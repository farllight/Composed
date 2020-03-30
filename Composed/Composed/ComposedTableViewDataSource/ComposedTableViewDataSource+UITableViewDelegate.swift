//
//  ComposedTableViewDataSource+UITableViewDelegate.swift
//  Composed
//
//  Created by Vladislav Markov on 12.04.2020.
//  Copyright © 2020 farllight. All rights reserved.
//

import UIKit

extension ComposedTableViewDataSource: UITableViewDelegate {
    // MARK: - Configuring Rows for the Table View
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, indentationLevelForRowAt: indexPath) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, shouldSpringLoadRowAt: indexPath, with: context) ?? false
    }
    
    // MARK: - Responding to Row Selections
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, willSelectRowAt: indexPath) ?? nil
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didDeselectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, shouldBeginMultipleSelectionInteractionAt indexPath: IndexPath) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, shouldBeginMultipleSelectionInteractionAt: indexPath) ?? false
    }
    
    public func tableView(_ tableView: UITableView, didBeginMultipleSelectionInteractionAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didBeginMultipleSelectionInteractionAt: indexPath)
    }
    
    public func tableViewDidEndMultipleSelectionInteraction(_ tableView: UITableView) {
        self.dataSources.forEach { $0.tableViewDidEndMultipleSelectionInteraction?(tableView) }
    }
    
    // MARK: - Providing Custom Header and Footer Views
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, viewForFooterInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let dataSource = self.decompose(section: section)
        dataSource.tableView?(tableView, willDisplayHeaderView: view, forSection: section)
    }
    
    public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let dataSource = self.decompose(section: section)
        dataSource.tableView?(tableView, willDisplayFooterView: view, forSection: section)
    }
    
    // MARK: - Providing Header, Footer, and Row Heights
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, heightForRowAt: indexPath) ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, heightForHeaderInSection: section) ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, heightForFooterInSection: section) ?? UITableView.automaticDimension
    }
    
    // MARK: - Estimating Heights for the Table's Content
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, estimatedHeightForHeaderInSection: section) ?? UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        let dataSource = self.decompose(section: section)
        return dataSource.tableView?(tableView, estimatedHeightForFooterInSection: section) ?? UITableView.automaticDimension
    }
    
    // MARK: - Managing Accessory Views
    public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, accessoryButtonTappedForRowWith: indexPath)
    }
    
    // MARK: - Responding to Row Actions
    public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, leadingSwipeActionsConfigurationForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, trailingSwipeActionsConfigurationForRowAt: indexPath)
    }
    
    // MARK: - Managing Table View Highlights
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, shouldHighlightRowAt: indexPath) ?? false
    }
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didHighlightRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didUnhighlightRowAt: indexPath)
    }
    
    // MARK: - Editing Table Rows
    public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, willBeginEditingRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didEndEditingRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, editingStyleForRowAt: indexPath) ?? .none
    }
    
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, shouldIndentWhileEditingRowAt: indexPath) ?? false
    }
    
    // MARK: - Reordering Table Rows
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        let dataSource = self.decompose(indexPath: sourceIndexPath)
        return dataSource.tableView?(tableView, targetIndexPathForMoveFromRowAt: sourceIndexPath, toProposedIndexPath: proposedDestinationIndexPath) ?? proposedDestinationIndexPath
    }
    
    // MARK: - Tracking the Removal of Views
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let dataSource = self.decompose(indexPath: indexPath)
        dataSource.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        let dataSource = self.decompose(section: section)
        dataSource.tableView?(tableView, didEndDisplayingHeaderView: view, forSection: section)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        let dataSource = self.decompose(section: section)
        dataSource.tableView?(tableView, didEndDisplayingFooterView: view, forSection: section)
    }
    
    // MARK: - Managing Table View Focus
    public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, canFocusRowAt: indexPath) ?? false
    }
    
    // TODO: - What do with this? May be create delegate for ComposedTableViewDataSource?
    // public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
    
    public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        self.dataSources.forEach { $0.tableView?(tableView, didUpdateFocusIn: context, with: coordinator) }
    }
    
    // TODO: - What do with this? May be create delegate for ComposedTableViewDataSource?
    // public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
    
    // MARK: - Instance Methods
    public func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let dataSource = self.decompose(indexPath: indexPath)
        return dataSource.tableView?(tableView, contextMenuConfigurationForRowAt: indexPath, point: point)
    }
    
    // TODO: - What do with this? May be create delegate for ComposedTableViewDataSource?
    // public func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
    
    // TODO: - What do with this? May be create delegate for ComposedTableViewDataSource?
    // public func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview?
    
    // TODO: - What do with this? May be create delegate for ComposedTableViewDataSource?
    // public func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating)
}
