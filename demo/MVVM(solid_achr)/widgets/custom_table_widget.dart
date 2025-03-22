import 'dart:developer';
import 'dart:html' as html;
import 'package:excel/excel.dart' as xl;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zero_admin/res/res.dart';
import 'package:zero_admin/utils/utils.dart';
import 'package:zero_admin/widgets/widgets.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart' as path_provider;

class CustomTableWidget<T> extends StatelessWidget {
  final String title;
  final List<TableColumn> columns;
  final List<T> data;
  final Widget Function(T item, int index) rowBuilder;
  final List<String> Function(T item)? dataExtractor;
  final Widget? searchWidget;
  final Widget? actionWidget;
  final bool showPagination;
  final int totalItems;
  final int currentPage;
  final int itemsPerPage;
  final Function(int)? onPageChanged;
  final bool isLoading;
  final String emptyMessage;
  final Widget? icon;
  final TextEditingController searchController;
  final Function(String) onSearch;

  const CustomTableWidget({
    super.key,
    required this.title,
    required this.columns,
    required this.data,
    required this.rowBuilder,
    this.dataExtractor,
    this.searchWidget,
    this.actionWidget,
    this.showPagination = true,
    this.totalItems = 0,
    this.currentPage = 1,
    this.itemsPerPage = 10,
    this.onPageChanged,
    this.isLoading = false,
    this.icon,
    this.emptyMessage = 'No data available',
    required this.searchController,
    required this.onSearch,
  });
  Future<void> _exportToExcel() async {
    // Add better validation and user feedback
    if (data.isEmpty) {
      Utility.showMessage(
        message: 'No data available to export',
        type: MessageType.error,
      );
      return;
    }

    if (dataExtractor == null) {
      Utility.showMessage(
        message: 'Data extraction function not provided',
        type: MessageType.error,
      );
      return;
    }

    try {
      // Create a new Excel document
      final excel = xl.Excel.createExcel();
      final sheetName = excel.getDefaultSheet() ?? 'Sheet1';
      final sheet = excel.sheets[sheetName];

      if (sheet == null) {
        Utility.showMessage(
          message: 'Failed to create Excel sheet',
          type: MessageType.error,
        );
        return;
      }

      // Add headers
      for (var i = 0; i < columns.length; i++) {
        sheet.cell(xl.CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          ..value = xl.TextCellValue(columns[i].title)
          ..cellStyle = xl.CellStyle(
            bold: true,
            horizontalAlign: xl.HorizontalAlign.Center,
          );
      }

      // Add data rows
      for (var rowIndex = 0; rowIndex < data.length; rowIndex++) {
        final rowData = dataExtractor!(data[rowIndex]);
        for (var colIndex = 0;
            colIndex < rowData.length && colIndex < columns.length;
            colIndex++) {
          sheet
              .cell(xl.CellIndex.indexByColumnRow(
                  columnIndex: colIndex, rowIndex: rowIndex + 1))
              .value = xl.TextCellValue(rowData[colIndex]);
        }
      }

      // Encode the Excel file
      final bytes = excel.encode();
      if (bytes == null) {
        Utility.showMessage(
          message: 'Failed to encode Excel file',
          type: MessageType.error,
        );
        return;
      }

      final fileName =
          '${title.toLowerCase().replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.xlsx';

      if (kIsWeb) {
        log('Attempting to export on web platform');
        // Web export logic
        final blob = html.Blob(
          [Uint8List.fromList(bytes)],
          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        );

        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..setAttribute('download', fileName)
          ..style.display = 'none';

        html.document.body?.append(anchor);
        anchor.click();

        // Wait a moment before cleanup to ensure download starts
        await Future.delayed(const Duration(seconds: 1));

        html.document.body?.children.remove(anchor);
        html.Url.revokeObjectUrl(url);

        Utility.showMessage(
          message: 'File download started',
          type: MessageType.success,
        );
      } else {
        log('Attempting to export on mobile/desktop platform');
        // Desktop/Mobile implementation
        final directory =
            await path_provider.getApplicationDocumentsDirectory();
        final path = '${directory.path}/$fileName';
        final file = io.File(path);

        await file.writeAsBytes(bytes);

        Utility.showMessage(
          message: 'File saved to: $path',
          type: MessageType.success,
        );
      }
    } catch (e, stackTrace) {
      log('Error during Excel export: $e');
      log('Stack trace: $stackTrace');

      Utility.showMessage(
        message: 'Error exporting data: $e',
        type: MessageType.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      margin: Dimens.edgeInsets8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Padding(
        padding: Dimens.edgeInsets8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (icon != null) icon!,
                    Dimens.boxWidth8,
                    if (title.isNotEmpty)
                      Text(
                        title,
                        style: Styles.black16w600.copyWith(
                          fontSize: 20,
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Dimens.boxWidth8,
                      // Export button
                      CustomButton(
                        width: 170,
                        height: 40,
                        onTap: () => _exportToExcel(),
                        buttonType: ButtonType.secondary,
                        title: 'Export',
                        borderRadius: 8,
                        style: Styles.black14w500.copyWith(
                          fontSize: 14,
                          color: ColorsValue.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Dimens.boxHeight8,

            // Table content
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorsValue.primaryColor,
                      ),
                    )
                  : data.isEmpty
                      ? Center(
                          child: Text(
                            emptyMessage,
                            style: Styles.grey11.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            // Table header
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  for (var column in columns)
                                    if (!isMobile || !column.hideOnMobile)
                                      Expanded(
                                        flex: column.flex,
                                        child: Text(
                                          column.title,
                                          style: Styles.black14w500.copyWith(
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                ],
                              ),
                            ),

                            // Table rows
                            Expanded(
                              child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.grey[200]!,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: rowBuilder(data[index], index),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            ),

            // Pagination
            if (showPagination && totalItems > 0)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Showing ${((currentPage - 1) * itemsPerPage) + 1}-${currentPage * itemsPerPage > totalItems ? totalItems : currentPage * itemsPerPage} of $totalItems',
                      style: Styles.grey11.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Dimens.boxWidth8,
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: currentPage > 1
                          ? () => onPageChanged?.call(currentPage - 1)
                          : null,
                      constraints: const BoxConstraints(),
                      padding: Dimens.edgeInsets8,
                      iconSize: 20,
                      color: Colors.grey[700],
                    ),
                    Container(
                      padding: Dimens.edgeInsets8_4,
                      decoration: BoxDecoration(
                        color: ColorsValue.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '$currentPage',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: currentPage * itemsPerPage < totalItems
                          ? () => onPageChanged?.call(currentPage + 1)
                          : null,
                      constraints: const BoxConstraints(),
                      padding: Dimens.edgeInsets8,
                      iconSize: 20,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TableColumn {
  final String title;
  final int flex;
  final bool hideOnMobile;
  final TextAlign textAlign;

  const TableColumn({
    required this.title,
    this.flex = 1,
    this.hideOnMobile = false,
    this.textAlign = TextAlign.left,
  });
}

class TableAction {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const TableAction({
    required this.icon,
    required this.color,
    required this.onPressed,
  });
}

// Helper widget for common table actions
class TableActionWidget extends StatelessWidget {
  final List<TableAction> actions;

  const TableActionWidget({
    super.key,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: actions.map((action) {
        return IconButton(
          icon: Icon(
            action.icon,
            color: action.color,
            size: 20,
          ),
          onPressed: action.onPressed,
          constraints: const BoxConstraints(),
          padding: Dimens.edgeInsets8,
        );
      }).toList(),
    );
  }
}

// Helper widget for status badges
class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Dimens.edgeInsets4,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Styles.grey11.copyWith(
          fontSize: 12,
          color: textColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
