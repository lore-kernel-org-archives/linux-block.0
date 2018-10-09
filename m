Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/3] myrb: Add Mylex RAID controller (block interface)
Date: Tue,  9 Oct 2018 17:26:59 +0200
Message-Id: <20181009152701.5542-2-hare@suse.de>
In-Reply-To: <20181009152701.5542-1-hare@suse.de>
References: <20181009152701.5542-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds support for the Mylex DAC960 RAID controller,
supporting the older, block-based interface only.
The driver is a re-implementation of the original DAC960 driver.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/Kconfig    |   15 +
 drivers/scsi/Makefile   |    1 +
 drivers/scsi/myrb.c     | 3829 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/myrb.h     |  970 ++++++++++++
 include/linux/pci_ids.h |    2 +
 5 files changed, 4817 insertions(+)
 create mode 100644 drivers/scsi/myrb.c
 create mode 100644 drivers/scsi/myrb.h

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 8fc851a9e116..f2a71bb74f48 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -557,6 +557,21 @@ config SCSI_FLASHPOINT
 	  substantial, so users of MultiMaster Host Adapters may not
 	  wish to include it.
 
+config SCSI_MYRB
+	tristate "Mylex DAC960/DAC1100 PCI RAID Controller (Block Interface)"
+	depends on PCI
+	select RAID_ATTRS
+	help
+	  This driver adds support for the Mylex DAC960, AcceleRAID, and
+	  eXtremeRAID PCI RAID controllers. This driver supports the
+	  older, block based interface.
+	  This driver is a reimplementation of the original DAC960
+	  driver. If you have used the DAC960 driver you should enable
+	  this module.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called myrb.
+
 config VMWARE_PVSCSI
 	tristate "VMware PVSCSI driver support"
 	depends on PCI && SCSI && X86
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index 6d71b2a9592b..cfd58ffc0b61 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -106,6 +106,7 @@ obj-$(CONFIG_SCSI_INIA100)	+= a100u2w.o
 obj-$(CONFIG_SCSI_QLOGICPTI)	+= qlogicpti.o
 obj-$(CONFIG_SCSI_MESH)		+= mesh.o
 obj-$(CONFIG_SCSI_MAC53C94)	+= mac53c94.o
+obj-$(CONFIG_SCSI_MYRB)		+= myrb.o
 obj-$(CONFIG_BLK_DEV_3W_XXXX_RAID) += 3w-xxxx.o
 obj-$(CONFIG_SCSI_3W_9XXX)	+= 3w-9xxx.o
 obj-$(CONFIG_SCSI_3W_SAS)	+= 3w-sas.o
diff --git a/drivers/scsi/myrb.c b/drivers/scsi/myrb.c
new file mode 100644
index 000000000000..e690ab811f97
--- /dev/null
+++ b/drivers/scsi/myrb.c
@@ -0,0 +1,3829 @@
+/*
+ * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
+ *
+ * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
+ *
+ * Based on the original DAC960 driver,
+ * Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
+ * Portions Copyright 2002 by Mylex (An IBM Business Unit)
+ *
+ * This program is free software; you may redistribute and/or modify it under
+ * the terms of the GNU General Public License Version 2 as published by the
+ *  Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for complete details.
+ */
+
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/pci.h>
+#include <linux/raid_class.h>
+#include <asm/unaligned.h>
+#include <scsi/scsi.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_tcq.h>
+#include "myrb.h"
+
+static struct raid_template *myrb_raid_template;
+
+static void myrb_monitor(struct work_struct *work);
+static inline void DAC960_P_To_PD_TranslateDeviceState(void *DeviceState);
+
+static inline int myrb_logical_channel(struct Scsi_Host *shost)
+{
+	return shost->max_channel - 1;
+}
+
+static struct myrb_devstate_name_entry {
+	enum myrb_devstate state;
+	char *name;
+} myrb_devstate_name_list[] = {
+	{ DAC960_V1_Device_Dead, "Dead" },
+	{ DAC960_V1_Device_WriteOnly, "WriteOnly" },
+	{ DAC960_V1_Device_Online, "Online" },
+	{ DAC960_V1_Device_Critical, "Critical" },
+	{ DAC960_V1_Device_Standby, "Standby" },
+	{ DAC960_V1_Device_Offline, NULL },
+};
+
+static char *myrb_devstate_name(enum myrb_devstate state)
+{
+	struct myrb_devstate_name_entry *entry = myrb_devstate_name_list;
+
+	while (entry && entry->name) {
+		if (entry->state == state)
+			return entry->name;
+		entry++;
+	}
+	return (state == DAC960_V1_Device_Offline) ? "Offline" : "Unknown";
+}
+
+static struct myrb_raidlevel_name_entry {
+	enum myrb_raidlevel level;
+	char *name;
+} myrb_raidlevel_name_list[] = {
+	{ DAC960_V1_RAID_Level0, "RAID0" },
+	{ DAC960_V1_RAID_Level1, "RAID1" },
+	{ DAC960_V1_RAID_Level3, "RAID3" },
+	{ DAC960_V1_RAID_Level5, "RAID5" },
+	{ DAC960_V1_RAID_Level6, "RAID6" },
+	{ DAC960_V1_RAID_JBOD, "JBOD" },
+	{ 0xff, NULL }
+};
+
+static char *myrb_raidlevel_name(enum myrb_raidlevel level)
+{
+	struct myrb_raidlevel_name_entry *entry = myrb_raidlevel_name_list;
+
+	while (entry && entry->name) {
+		if (entry->level == level)
+			return entry->name;
+		entry++;
+	}
+	return NULL;
+}
+
+
+/**
+ * myrb_create_mempools - allocates auxiliary data structures
+ *
+ * Return: true on success, false otherwise.
+ */
+static bool myrb_create_mempools(struct pci_dev *pdev, struct myrb_hba *cb)
+{
+	size_t elem_size, elem_align;
+
+	elem_align = sizeof(struct myrb_sge);
+	elem_size = cb->host->sg_tablesize * elem_align;
+	cb->sg_pool = dma_pool_create("myrb_sg", &pdev->dev,
+				      elem_size, elem_align, 0);
+	if (cb->sg_pool == NULL) {
+		shost_printk(KERN_ERR, cb->host,
+			     "Failed to allocate SG pool\n");
+		return false;
+	}
+
+	cb->dcdb_pool = dma_pool_create("myrb_dcdb", &pdev->dev,
+				       sizeof(struct myrb_dcdb),
+				       sizeof(unsigned int), 0);
+	if (!cb->dcdb_pool) {
+		dma_pool_destroy(cb->sg_pool);
+		cb->sg_pool = NULL;
+		shost_printk(KERN_ERR, cb->host,
+			     "Failed to allocate DCDB pool\n");
+		return false;
+	}
+
+	snprintf(cb->work_q_name, sizeof(cb->work_q_name),
+		 "myrb_wq_%d", cb->host->host_no);
+	cb->work_q = create_singlethread_workqueue(cb->work_q_name);
+	if (!cb->work_q) {
+		dma_pool_destroy(cb->dcdb_pool);
+		cb->dcdb_pool = NULL;
+		dma_pool_destroy(cb->sg_pool);
+		cb->sg_pool = NULL;
+		shost_printk(KERN_ERR, cb->host,
+			     "Failed to create workqueue\n");
+		return false;
+	}
+
+	/*
+	  Initialize the Monitoring Timer.
+	*/
+	INIT_DELAYED_WORK(&cb->monitor_work, myrb_monitor);
+	queue_delayed_work(cb->work_q, &cb->monitor_work, 1);
+
+	return true;
+}
+
+/**
+ * myrb_destroy_mempools - tears down the memory pools for the controller
+ */
+static void myrb_destroy_mempools(struct myrb_hba *cb)
+{
+	cancel_delayed_work_sync(&cb->monitor_work);
+	destroy_workqueue(cb->work_q);
+
+	if (cb->sg_pool != NULL)
+		dma_pool_destroy(cb->sg_pool);
+
+	if (cb->dcdb_pool) {
+		dma_pool_destroy(cb->dcdb_pool);
+		cb->dcdb_pool = NULL;
+	}
+}
+
+/**
+ * myrb_reset_cmd - reset command block
+ */
+static inline void myrb_reset_cmd(struct myrb_cmdblk *cmd_blk)
+{
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+
+	memset(mbox, 0, sizeof(union myrb_cmd_mbox));
+	cmd_blk->status = 0;
+}
+
+
+/**
+ * myrb_qcmd - queues command block for execution
+ */
+static void myrb_qcmd(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	void __iomem *base = cb->io_base;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	union myrb_cmd_mbox *next_mbox = cb->next_cmd_mbox;
+
+	cb->write_cmd_mbox(next_mbox, mbox);
+	if (cb->prev_cmd_mbox1->Words[0] == 0 ||
+	    cb->prev_cmd_mbox2->Words[0] == 0)
+		cb->get_cmd_mbox(base);
+	cb->prev_cmd_mbox2 = cb->prev_cmd_mbox1;
+	cb->prev_cmd_mbox1 = next_mbox;
+	if (++next_mbox > cb->last_cmd_mbox)
+		next_mbox = cb->first_cmd_mbox;
+	cb->next_cmd_mbox = next_mbox;
+}
+
+/**
+ * myrb_exec_cmd - executes command block and waits for completion.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_exec_cmd(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	DECLARE_COMPLETION_ONSTACK(Completion);
+	unsigned long flags;
+
+	cmd_blk->Completion = &Completion;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	cb->qcmd(cb, cmd_blk);
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+
+	wait_for_completion(&Completion);
+	return cmd_blk->status;
+}
+
+/**
+ * myrb_exec_type3 - executes a type 3 command and waits for completion.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_exec_type3(struct myrb_hba *cb,
+				      enum myrb_cmd_opcode op,
+				      dma_addr_t addr)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->dcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned short status;
+
+	mutex_lock(&cb->dcmd_mutex);
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3.id = MYRB_DCMD_TAG;
+	mbox->Type3.opcode = op;
+	mbox->Type3.addr = addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	mutex_unlock(&cb->dcmd_mutex);
+	return status;
+}
+
+
+/**
+ * myrb_exec_type3D - executes a type 3D command and waits for completion.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_exec_type3D(struct myrb_hba *cb,
+				       enum myrb_cmd_opcode op,
+				       struct scsi_device *sdev,
+				       struct myrb_pdev_state *pdev_info)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->dcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned short status;
+	dma_addr_t pdev_info_addr;
+
+	pdev_info_addr = dma_map_single(&cb->pdev->dev, pdev_info,
+					sizeof(struct myrb_pdev_state),
+					DMA_FROM_DEVICE);
+	if (dma_mapping_error(&cb->pdev->dev, pdev_info_addr))
+		return DAC960_V1_SubsystemFailed;
+
+	mutex_lock(&cb->dcmd_mutex);
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3D.id = MYRB_DCMD_TAG;
+	mbox->Type3D.opcode = op;
+	mbox->Type3D.Channel = sdev->channel;
+	mbox->Type3D.TargetID = sdev->id;
+	mbox->Type3D.addr = pdev_info_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	mutex_unlock(&cb->dcmd_mutex);
+	dma_unmap_single(&cb->pdev->dev, pdev_info_addr,
+			 sizeof(struct myrb_pdev_state), DMA_FROM_DEVICE);
+	if (status == DAC960_V1_NormalCompletion &&
+	    mbox->Type3D.opcode == DAC960_V1_GetDeviceState_Old)
+		DAC960_P_To_PD_TranslateDeviceState(pdev_info);
+
+	return status;
+}
+
+
+/**
+ * myrb_get_event - get event log from HBA
+ * @cb: pointer to the hba structure
+ * @event: number of the event
+ *
+ * Execute a type 3E command and logs the event message
+ */
+static void myrb_get_event(struct myrb_hba *cb, unsigned int event)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->mcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct myrb_log_entry *ev_buf;
+	dma_addr_t ev_addr;
+	unsigned short status;
+	static char *DAC960_EventMessages[] =
+		{ "killed because write recovery failed",
+		  "killed because of SCSI bus reset failure",
+		  "killed because of double check condition",
+		  "killed because it was removed",
+		  "killed because of gross error on SCSI chip",
+		  "killed because of bad tag returned from drive",
+		  "killed because of timeout on SCSI command",
+		  "killed because of reset SCSI command issued from system",
+		  "killed because busy or parity error count exceeded limit",
+		  "killed because of 'kill drive' command from system",
+		  "killed because of selection timeout",
+		  "killed due to SCSI phase sequence error",
+		  "killed due to unknown status" };
+
+	ev_buf = dma_alloc_coherent(&cb->pdev->dev,
+				    sizeof(struct myrb_log_entry),
+				    &ev_addr, GFP_KERNEL);
+	if (!ev_buf)
+		return;
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3E.id = MYRB_MCMD_TAG;
+	mbox->Type3E.opcode = DAC960_V1_PerformEventLogOperation;
+	mbox->Type3E.optype = DAC960_V1_GetEventLogEntry;
+	mbox->Type3E.opqual = 1;
+	mbox->Type3E.ev_seq = event;
+	mbox->Type3E.addr = ev_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (status == DAC960_V1_NormalCompletion) {
+		if (ev_buf->SequenceNumber == event) {
+			struct scsi_sense_hdr sshdr;
+
+			memset(&sshdr, 0, sizeof(sshdr));
+			scsi_normalize_sense(ev_buf->SenseData, 32, &sshdr);
+
+			if (sshdr.sense_key == VENDOR_SPECIFIC &&
+			    sshdr.asc == 0x80 &&
+			    sshdr.ascq < ARRAY_SIZE(DAC960_EventMessages)) {
+				shost_printk(KERN_CRIT, cb->host,
+					     "Physical drive %d:%d: %s\n",
+					     ev_buf->Channel,
+					     ev_buf->TargetID,
+					     DAC960_EventMessages[sshdr.ascq]);
+			} else {
+				shost_printk(KERN_CRIT, cb->host,
+					     "Physical drive %d:%d: "
+					     "Sense: %X/%02X/%02X\n",
+					     ev_buf->Channel,
+					     ev_buf->TargetID,
+					     sshdr.sense_key,
+					     sshdr.asc, sshdr.ascq);
+			}
+		}
+	} else
+		shost_printk(KERN_INFO, cb->host,
+			     "Failed to get event log %d, status %04x\n",
+			     event, status);
+
+	dma_free_coherent(&cb->pdev->dev, sizeof(struct myrb_log_entry),
+			  ev_buf, ev_addr);
+}
+
+/**
+ * myrb_get_errtable - retrieves the error table from the controller
+ *
+ * Executes a type 3 command and logs the error table from the controller.
+ */
+static void myrb_get_errtable(struct myrb_hba *cb)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->mcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned short status;
+	struct myrb_error_entry
+		old_table[DAC960_V1_MaxChannels * DAC960_V1_MaxTargets];
+
+	memcpy(&old_table, cb->err_table, sizeof(old_table));
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3.id = MYRB_MCMD_TAG;
+	mbox->Type3.opcode = DAC960_V1_GetErrorTable;
+	mbox->Type3.addr = cb->err_table_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (status == DAC960_V1_NormalCompletion) {
+		struct myrb_error_entry *table = cb->err_table;
+		struct myrb_error_entry *new_entry, *old_entry;
+		size_t err_table_offset;
+		struct scsi_device *sdev;
+
+		shost_for_each_device(sdev, cb->host) {
+			if (sdev->channel >= myrb_logical_channel(cb->host))
+				continue;
+			err_table_offset = sdev->channel * DAC960_V1_MaxTargets
+				+ sdev->id;
+			new_entry = table + err_table_offset;
+			old_entry = &old_table[err_table_offset];
+			if (new_entry->parity_err != old_entry->parity_err ||
+			    new_entry->soft_err != old_entry->soft_err ||
+			    new_entry->hard_err != old_entry->hard_err ||
+			    new_entry->misc_err != old_entry->misc_err)
+				sdev_printk(KERN_CRIT, sdev,
+					    "Errors: "
+					    "Parity = %d, Soft = %d, "
+					    "Hard = %d, Misc = %d\n",
+					    new_entry->parity_err,
+					    new_entry->soft_err,
+					    new_entry->hard_err,
+					    new_entry->misc_err);
+		}
+	}
+}
+
+/**
+ * myrb_get_ldev_info - retrieves the logical device table from the controller
+ *
+ * Executes a type 3 command and updates the logical device table.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_get_ldev_info(struct myrb_hba *cb)
+{
+	unsigned short status;
+	int ldev_num, ldev_cnt = cb->enquiry->ldev_count;
+	struct Scsi_Host *shost = cb->host;
+
+	status = myrb_exec_type3(cb, DAC960_V1_GetLogicalDeviceInfo,
+				 cb->ldev_info_addr);
+	if (status != DAC960_V1_NormalCompletion)
+		return status;
+
+	for (ldev_num = 0; ldev_num < ldev_cnt; ldev_num++) {
+		struct myrb_ldev_info *old = NULL;
+		struct myrb_ldev_info *new = cb->ldev_info_buf + ldev_num;
+		struct scsi_device *sdev;
+		enum myrb_devstate old_state = DAC960_V1_Device_Offline;
+
+		sdev = scsi_device_lookup(shost, myrb_logical_channel(shost),
+					  ldev_num, 0);
+		if (sdev && sdev->hostdata)
+			old = sdev->hostdata;
+		else if (new->State != DAC960_V1_Device_Offline) {
+			if (sdev)
+				scsi_device_put(sdev);
+			shost_printk(KERN_INFO, shost,
+				     "Adding Logical Drive %d in state %s\n",
+				     ldev_num, myrb_devstate_name(new->State));
+			scsi_add_device(shost, myrb_logical_channel(shost),
+					ldev_num, 0);
+			break;
+		}
+		if (old)
+			old_state = old->State;
+		if (new->State != old_state)
+			shost_printk(KERN_INFO, shost,
+				     "Logical Drive %d is now %s\n",
+				     ldev_num, myrb_devstate_name(new->State));
+		if (old && new->WriteBack != old->WriteBack)
+			sdev_printk(KERN_INFO, sdev,
+				    "Logical Drive is now WRITE %s\n",
+				    (new->WriteBack ? "BACK" : "THRU"));
+		if (old)
+			memcpy(old, new, sizeof(*new));
+		if (sdev)
+			scsi_device_put(sdev);
+	}
+	return status;
+}
+
+
+/**
+ * myrb_get_rbld_progress - get rebuild progress information
+ *
+ * Executes a type 3 command and returns the rebuild progress
+ * information.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_get_rbld_progress(struct myrb_hba *cb,
+					     struct myrb_rbld_progress *rbld)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->mcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct myrb_rbld_progress *rbld_buf;
+	dma_addr_t rbld_addr;
+	unsigned short status;
+
+	rbld_buf = dma_alloc_coherent(&cb->pdev->dev,
+				      sizeof(struct myrb_rbld_progress),
+				      &rbld_addr, GFP_KERNEL);
+	if (!rbld_buf)
+		return DAC960_V1_RebuildNotChecked;
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3.id = MYRB_MCMD_TAG;
+	mbox->Type3.opcode = DAC960_V1_GetRebuildProgress;
+	mbox->Type3.addr = rbld_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (rbld)
+		memcpy(rbld, rbld_buf, sizeof(struct myrb_rbld_progress));
+	dma_free_coherent(&cb->pdev->dev, sizeof(struct myrb_rbld_progress),
+			  rbld_buf, rbld_addr);
+	return status;
+}
+
+/**
+ * myrb_update_rbld_progress - updates the rebuild status
+ *
+ * Updates the rebuild status for the attached logical devices.
+ *
+ */
+static void myrb_update_rbld_progress(struct myrb_hba *cb)
+{
+	struct myrb_rbld_progress rbld_buf;
+	unsigned short status;
+
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+	if (status == DAC960_V1_NoRebuildOrCheckInProgress &&
+	    cb->last_rbld_status == DAC960_V1_NormalCompletion)
+		status = DAC960_V1_RebuildSuccessful;
+	if (status != DAC960_V1_NoRebuildOrCheckInProgress) {
+		unsigned int blocks_done =
+			rbld_buf.ldev_size - rbld_buf.blocks_left;
+		struct scsi_device *sdev;
+
+		sdev = scsi_device_lookup(cb->host,
+					  myrb_logical_channel(cb->host),
+					  rbld_buf.ldev_num, 0);
+		if (!sdev)
+			return;
+
+		switch (status) {
+		case DAC960_V1_NormalCompletion:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild in Progress, "
+				    "%d%% completed\n",
+				    (100 * (blocks_done >> 7))
+				    / (rbld_buf.ldev_size >> 7));
+			break;
+		case DAC960_V1_RebuildFailed_LogicalDriveFailure:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Failed due to "
+				    "Logical Drive Failure\n");
+			break;
+		case DAC960_V1_RebuildFailed_BadBlocksOnOther:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Failed due to "
+				    "Bad Blocks on Other Drives\n");
+			break;
+		case DAC960_V1_RebuildFailed_NewDriveFailed:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Failed due to "
+				    "Failure of Drive Being Rebuilt\n");
+			break;
+		case DAC960_V1_RebuildSuccessful:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Completed Successfully\n");
+			break;
+		case DAC960_V1_RebuildSuccessfullyTerminated:
+			sdev_printk(KERN_INFO, sdev,
+				     "Rebuild Successfully Terminated\n");
+			break;
+		default:
+			break;
+		}
+		scsi_device_put(sdev);
+	}
+	cb->last_rbld_status = status;
+}
+
+
+/**
+ * myrb_get_cc_progress - retrieve the rebuild status
+ *
+ * Execute a type 3 Command and fetch the rebuild / consistency check
+ * status.
+ */
+static void myrb_get_cc_progress(struct myrb_hba *cb)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->mcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct myrb_rbld_progress *rbld_buf;
+	dma_addr_t rbld_addr;
+	unsigned short status;
+
+	rbld_buf = dma_alloc_coherent(&cb->pdev->dev,
+				      sizeof(struct myrb_rbld_progress),
+				      &rbld_addr, GFP_KERNEL);
+	if (!rbld_buf) {
+		cb->need_cc_status = true;
+		return;
+	}
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3.id = MYRB_MCMD_TAG;
+	mbox->Type3.opcode = DAC960_V1_RebuildStat;
+	mbox->Type3.addr = rbld_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (status == DAC960_V1_NormalCompletion) {
+		unsigned int ldev_num = rbld_buf->ldev_num;
+		unsigned int ldev_size = rbld_buf->ldev_size;
+		unsigned int blocks_done =
+			ldev_size - rbld_buf->blocks_left;
+		struct scsi_device *sdev;
+
+		sdev = scsi_device_lookup(cb->host,
+					  myrb_logical_channel(cb->host),
+					  ldev_num, 0);
+		if (sdev) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Consistency Check in Progress: %d%% completed\n",
+				    (100 * (blocks_done >> 7))
+				    / (ldev_size >> 7));
+			scsi_device_put(sdev);
+		}
+	}
+	dma_free_coherent(&cb->pdev->dev, sizeof(struct myrb_rbld_progress),
+			  rbld_buf, rbld_addr);
+}
+
+
+/**
+ * myrb_bgi_control - updates background initialisation status
+ *
+ * Executes a type 3B command and updates the background initialisation status
+ */
+static void myrb_bgi_control(struct myrb_hba *cb)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->mcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct myrb_bgi_status *bgi, *last_bgi;
+	dma_addr_t bgi_addr;
+	struct scsi_device *sdev = NULL;
+	unsigned short status;
+
+	bgi = dma_alloc_coherent(&cb->pdev->dev, sizeof(struct myrb_bgi_status),
+				 &bgi_addr, GFP_KERNEL);
+	if (!bgi) {
+		shost_printk(KERN_ERR, cb->host,
+			     "Failed to allocate bgi memory\n");
+		return;
+	}
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type3B.id = MYRB_DCMD_TAG;
+	mbox->Type3B.opcode = DAC960_V1_BackgroundInitializationControl;
+	mbox->Type3B.optype = 0x20;
+	mbox->Type3B.addr = bgi_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	last_bgi = &cb->bgi_status;
+	sdev = scsi_device_lookup(cb->host,
+				  myrb_logical_channel(cb->host),
+				  bgi->ldev_num, 0);
+	switch (status) {
+	case DAC960_V1_NormalCompletion:
+		switch (bgi->Status) {
+		case MYRB_BGI_INVALID:
+			break;
+		case MYRB_BGI_STARTED:
+			if (!sdev)
+				break;
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization Started\n");
+			break;
+		case MYRB_BGI_INPROGRESS:
+			if (!sdev)
+				break;
+			if (bgi->blocks_done == last_bgi->blocks_done &&
+			    bgi->ldev_num == last_bgi->ldev_num)
+				break;
+			sdev_printk(KERN_INFO, sdev,
+				 "Background Initialization in Progress: "
+				 "%d%% completed\n",
+				 (100 * (bgi->blocks_done >> 7))
+				 / (bgi->ldev_size >> 7));
+			break;
+		case MYRB_BGI_SUSPENDED:
+			if (!sdev)
+				break;
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization Suspended\n");
+			break;
+		case MYRB_BGI_CANCELLED:
+			if (!sdev)
+				break;
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization Cancelled\n");
+			break;
+		}
+		memcpy(&cb->bgi_status, bgi, sizeof(struct myrb_bgi_status));
+		break;
+	case DAC960_V1_BackgroundInitSuccessful:
+		if (sdev && cb->bgi_status.Status == MYRB_BGI_INPROGRESS)
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization "
+				    "Completed Successfully\n");
+		cb->bgi_status.Status = MYRB_BGI_INVALID;
+		break;
+	case DAC960_V1_BackgroundInitAborted:
+		if (sdev && cb->bgi_status.Status == MYRB_BGI_INPROGRESS)
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization Aborted\n");
+		/* Fallthrough */
+	case DAC960_V1_NoBackgroundInitInProgress:
+		cb->bgi_status.Status = MYRB_BGI_INVALID;
+		break;
+	}
+	if (sdev)
+		scsi_device_put(sdev);
+	dma_free_coherent(&cb->pdev->dev, sizeof(struct myrb_bgi_status),
+			  bgi, bgi_addr);
+}
+
+/**
+ * myrb_hba_enquiry - updates the controller status
+ *
+ * Executes a DAC_V1_Enquiry command and updates the controller status.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_hba_enquiry(struct myrb_hba *cb)
+{
+	struct myrb_enquiry old;
+	unsigned short status;
+
+	memcpy(&old, cb->enquiry, sizeof(struct myrb_enquiry));
+
+	status = myrb_exec_type3(cb, DAC960_V1_Enquiry, cb->enquiry_addr);
+	if (status == DAC960_V1_NormalCompletion) {
+		struct myrb_enquiry *new = cb->enquiry;
+		if (new->ldev_count > old.ldev_count) {
+			int ldev_num = old.ldev_count - 1;
+			while (++ldev_num < new->ldev_count)
+				shost_printk(KERN_CRIT, cb->host,
+					"Logical Drive %d Now Exists\n",
+					 ldev_num);
+		}
+		if (new->ldev_count < old.ldev_count) {
+			int ldev_num = new->ldev_count - 1;
+			while (++ldev_num < old.ldev_count)
+				shost_printk(KERN_CRIT, cb->host,
+					 "Logical Drive %d No Longer Exists\n",
+					 ldev_num);
+		}
+		if (new->status.deferred != old.status.deferred)
+			shost_printk(KERN_CRIT, cb->host,
+				 "Deferred Write Error Flag is now %s\n",
+				 (new->status.deferred ? "TRUE" : "FALSE"));
+		if (new->ev_seq != old.ev_seq) {
+			cb->new_ev_seq = new->ev_seq;
+			cb->need_err_info = true;
+			shost_printk(KERN_INFO, cb->host,
+				     "Event log %d/%d (%d/%d) available\n",
+				     cb->old_ev_seq, cb->new_ev_seq,
+				     old.ev_seq, new->ev_seq);
+		}
+		if ((new->ldev_critical > 0 &&
+		     new->ldev_critical != old.ldev_critical) ||
+		    (new->ldev_offline > 0 &&
+		     new->ldev_offline != old.ldev_offline) ||
+		    (new->ldev_count != old.ldev_count)) {
+			shost_printk(KERN_INFO, cb->host,
+				     "Logical drive count changed (%d/%d/%d)\n",
+				     new->ldev_critical,
+				     new->ldev_offline,
+				     new->ldev_count);
+			cb->need_ldev_info = true;
+		}
+		if (new->pdev_dead > 0 ||
+		    new->pdev_dead != old.pdev_dead ||
+		    time_after_eq(jiffies, cb->secondary_monitor_time
+				  + MYRB_SECONDARY_MONITOR_INTERVAL)) {
+			cb->need_bgi_status = cb->bgi_status_supported;
+			cb->secondary_monitor_time = jiffies;
+		}
+		if (new->rbld == DAC960_V1_StandbyRebuildInProgress ||
+		    new->rbld == DAC960_V1_BackgroundRebuildInProgress ||
+		    old.rbld == DAC960_V1_StandbyRebuildInProgress ||
+		    old.rbld == DAC960_V1_BackgroundRebuildInProgress) {
+			cb->need_rbld = true;
+			cb->rbld_first = (new->ldev_critical < old.ldev_critical);
+		}
+		if (old.rbld == DAC960_V1_BackgroundCheckInProgress)
+			switch (new->rbld) {
+			case DAC960_V1_NoStandbyRebuildOrCheckInProgress:
+				shost_printk(KERN_INFO, cb->host,
+					 "Consistency Check Completed Successfully\n");
+				break;
+			case DAC960_V1_StandbyRebuildInProgress:
+			case DAC960_V1_BackgroundRebuildInProgress:
+				break;
+			case DAC960_V1_BackgroundCheckInProgress:
+				cb->need_cc_status = true;
+				break;
+			case DAC960_V1_StandbyRebuildCompletedWithError:
+				shost_printk(KERN_INFO, cb->host,
+					 "Consistency Check Completed with Error\n");
+				break;
+			case DAC960_V1_BackgroundRebuildOrCheckFailed_DriveFailed:
+				shost_printk(KERN_INFO, cb->host,
+					 "Consistency Check Failed - "
+					 "Physical Device Failed\n");
+				break;
+			case DAC960_V1_BackgroundRebuildOrCheckFailed_LogicalDriveFailed:
+				shost_printk(KERN_INFO, cb->host,
+					 "Consistency Check Failed - "
+					 "Logical Drive Failed\n");
+				break;
+			case DAC960_V1_BackgroundRebuildOrCheckFailed_OtherCauses:
+				shost_printk(KERN_INFO, cb->host,
+					 "Consistency Check Failed - Other Causes\n");
+				break;
+			case DAC960_V1_BackgroundRebuildOrCheckSuccessfullyTerminated:
+				shost_printk(KERN_INFO, cb->host,
+					 "Consistency Check Successfully Terminated\n");
+				break;
+			}
+		else if (new->rbld == DAC960_V1_BackgroundCheckInProgress)
+			cb->need_cc_status = true;
+
+	}
+	return status;
+}
+
+/**
+ * myrb_set_pdev_state - sets the device state for a physical device
+ *
+ * Return: command status
+ */
+static unsigned short myrb_set_pdev_state(struct myrb_hba *cb,
+					  struct scsi_device *sdev,
+					  enum myrb_devstate State)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->dcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned short status;
+
+	mutex_lock(&cb->dcmd_mutex);
+	mbox->Type3D.opcode = DAC960_V1_StartDevice;
+	mbox->Type3D.id = MYRB_DCMD_TAG;
+	mbox->Type3D.Channel = sdev->channel;
+	mbox->Type3D.TargetID = sdev->id;
+	mbox->Type3D.State = State & 0x1F;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	mutex_unlock(&cb->dcmd_mutex);
+
+	return status;
+}
+
+/**
+ * myrb_enable_mmio - enables the Memory Mailbox Interface
+ *
+ * PD and P controller types have no memory mailbox, but still need the
+ * other dma mapped memory.
+ *
+ * Return: true on success, false otherwise.
+*/
+static bool myrb_enable_mmio(struct myrb_hba *cb, mbox_mmio_init_t mmio_init_fn)
+{
+	void __iomem *base = cb->io_base;
+	struct pci_dev *pdev = cb->pdev;
+	size_t err_table_size;
+	size_t ldev_info_size;
+	union myrb_cmd_mbox *cmd_mbox_mem;
+	struct myrb_stat_mbox *stat_mbox_mem;
+	union myrb_cmd_mbox mbox;
+	unsigned short status;
+
+	memset(&mbox, 0, sizeof(union myrb_cmd_mbox));
+
+	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
+		dev_err(&pdev->dev, "DMA mask out of range\n");
+		return false;
+	}
+
+	cb->enquiry = dma_alloc_coherent(&pdev->dev,
+					 sizeof(struct myrb_enquiry),
+					 &cb->enquiry_addr, GFP_KERNEL);
+	if (!cb->enquiry)
+		return false;
+
+	err_table_size = sizeof(struct myrb_error_entry) *
+		DAC960_V1_MaxChannels * DAC960_V1_MaxTargets;
+	cb->err_table = dma_alloc_coherent(&pdev->dev, err_table_size,
+					   &cb->err_table_addr, GFP_KERNEL);
+	if (!cb->err_table)
+		return false;
+
+	ldev_info_size = sizeof(struct myrb_ldev_info) * MYRB_MAX_LDEVS;
+	cb->ldev_info_buf = dma_alloc_coherent(&pdev->dev, ldev_info_size,
+					       &cb->ldev_info_addr, GFP_KERNEL);
+	if (!cb->ldev_info_buf)
+		return false;
+
+	/*
+	 * Skip mailbox initialisation for PD and P Controllers
+	 */
+	if (!mmio_init_fn)
+		return true;
+
+	/* These are the base addresses for the command memory mailbox array */
+	cb->cmd_mbox_size =  DAC960_V1_CommandMailboxCount *
+		sizeof(union myrb_cmd_mbox);
+	cb->first_cmd_mbox = dma_alloc_coherent(&pdev->dev,
+						cb->cmd_mbox_size,
+						&cb->cmd_mbox_addr,
+						GFP_KERNEL);
+	if (!cb->first_cmd_mbox)
+		return false;
+
+	cmd_mbox_mem = cb->first_cmd_mbox;
+	cmd_mbox_mem += DAC960_V1_CommandMailboxCount - 1;
+	cb->last_cmd_mbox = cmd_mbox_mem;
+	cb->next_cmd_mbox = cb->first_cmd_mbox;
+	cb->prev_cmd_mbox1 = cb->last_cmd_mbox;
+	cb->prev_cmd_mbox2 = cb->last_cmd_mbox - 1;
+
+	/* These are the base addresses for the status memory mailbox array */
+	cb->stat_mbox_size = DAC960_V1_StatusMailboxCount *
+		sizeof(struct myrb_stat_mbox);
+	cb->first_stat_mbox = dma_alloc_coherent(&pdev->dev,
+						 cb->stat_mbox_size,
+						 &cb->stat_mbox_addr,
+						 GFP_KERNEL);
+	if (!cb->first_stat_mbox)
+		return false;
+
+	stat_mbox_mem = cb->first_stat_mbox;
+	stat_mbox_mem += DAC960_V1_StatusMailboxCount - 1;
+	cb->last_stat_mbox = stat_mbox_mem;
+	cb->next_stat_mbox = cb->first_stat_mbox;
+
+	/* Enable the Memory Mailbox Interface. */
+	cb->dual_mode_interface = true;
+	mbox.TypeX.opcode = 0x2B;
+	mbox.TypeX.id = 0;
+	mbox.TypeX.CommandOpcode2 = 0x14;
+	mbox.TypeX.CommandMailboxesBusAddress = cb->cmd_mbox_addr;
+	mbox.TypeX.StatusMailboxesBusAddress = cb->stat_mbox_addr;
+
+	status = mmio_init_fn(pdev, base, &mbox);
+	if (status != DAC960_V1_NormalCompletion) {
+		cb->dual_mode_interface = false;
+		mbox.TypeX.CommandOpcode2 = 0x10;
+		status = mmio_init_fn(pdev, base, &mbox);
+		if (status != DAC960_V1_NormalCompletion) {
+			dev_err(&pdev->dev,
+				"Failed to enable mailbox, statux %02X\n",
+				status);
+			return false;
+		}
+	}
+	return true;
+}
+
+
+/**
+ * myrb_get_hba_config - reads the configuration information
+ *
+ * Reads the configuration information from the controller and
+ * initializes the controller structure.
+ *
+ * Return: 0 on success, errno otherwise
+ */
+static int myrb_get_hba_config(struct myrb_hba *cb)
+{
+	struct myrb_enquiry2 *enquiry2;
+	dma_addr_t enquiry2_addr;
+	struct myrb_config2 *config2;
+	dma_addr_t config2_addr;
+	struct Scsi_Host *shost = cb->host;
+	struct pci_dev *pdev = cb->pdev;
+	int pchan_max = 0, pchan_cur = 0;
+	unsigned short status;
+	int ret = -ENODEV, memsize = 0;
+
+	enquiry2 = dma_alloc_coherent(&pdev->dev, sizeof(struct myrb_enquiry2),
+				      &enquiry2_addr, GFP_KERNEL);
+	if (!enquiry2) {
+		shost_printk(KERN_ERR, cb->host,
+			     "Failed to allocate V1 enquiry2 memory\n");
+		return -ENOMEM;
+	}
+	config2 = dma_alloc_coherent(&pdev->dev, sizeof(struct myrb_config2),
+				     &config2_addr, GFP_KERNEL);
+	if (!config2) {
+		shost_printk(KERN_ERR, cb->host,
+			     "Failed to allocate V1 config2 memory\n");
+		dma_free_coherent(&pdev->dev, sizeof(struct myrb_enquiry2),
+				  enquiry2, enquiry2_addr);
+		return -ENOMEM;
+	}
+	mutex_lock(&cb->dma_mutex);
+	status = myrb_hba_enquiry(cb);
+	mutex_unlock(&cb->dma_mutex);
+	if (status != DAC960_V1_NormalCompletion) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed it issue V1 Enquiry\n");
+		goto out_free;
+	}
+
+	status = myrb_exec_type3(cb, DAC960_V1_Enquiry2, enquiry2_addr);
+	if (status != DAC960_V1_NormalCompletion) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed to issue V1 Enquiry2\n");
+		goto out_free;
+	}
+
+	status = myrb_exec_type3(cb, DAC960_V1_ReadConfig2, config2_addr);
+	if (status != DAC960_V1_NormalCompletion) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed to issue ReadConfig2\n");
+		goto out_free;
+	}
+
+	status = myrb_get_ldev_info(cb);
+	if (status != DAC960_V1_NormalCompletion) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed to get logical drive information\n");
+		goto out_free;
+	}
+
+	/*
+	  Initialize the Controller Model Name and Full Model Name fields.
+	*/
+	switch (enquiry2->hw.SubModel) {
+	case DAC960_V1_P_PD_PU:
+		if (enquiry2->scsi_cap.bus_speed == DAC960_V1_Ultra)
+			strcpy(cb->ModelName, "DAC960PU");
+		else
+			strcpy(cb->ModelName, "DAC960PD");
+		break;
+	case DAC960_V1_PL:
+		strcpy(cb->ModelName, "DAC960PL");
+		break;
+	case DAC960_V1_PG:
+		strcpy(cb->ModelName, "DAC960PG");
+		break;
+	case DAC960_V1_PJ:
+		strcpy(cb->ModelName, "DAC960PJ");
+		break;
+	case DAC960_V1_PR:
+		strcpy(cb->ModelName, "DAC960PR");
+		break;
+	case DAC960_V1_PT:
+		strcpy(cb->ModelName, "DAC960PT");
+		break;
+	case DAC960_V1_PTL0:
+		strcpy(cb->ModelName, "DAC960PTL0");
+		break;
+	case DAC960_V1_PRL:
+		strcpy(cb->ModelName, "DAC960PRL");
+		break;
+	case DAC960_V1_PTL1:
+		strcpy(cb->ModelName, "DAC960PTL1");
+		break;
+	case DAC960_V1_1164P:
+		strcpy(cb->ModelName, "eXtremeRAID 1100");
+		break;
+	default:
+		shost_printk(KERN_WARNING, cb->host,
+			     "Unknown Model %X\n",
+			     enquiry2->hw.SubModel);
+		goto out;
+	}
+	/*
+	  Initialize the Controller Firmware Version field and verify that it
+	  is a supported firmware version.  The supported firmware versions are:
+
+	  DAC1164P		    5.06 and above
+	  DAC960PTL/PRL/PJ/PG	    4.06 and above
+	  DAC960PU/PD/PL	    3.51 and above
+	  DAC960PU/PD/PL/P	    2.73 and above
+	*/
+#if defined(CONFIG_ALPHA)
+	/*
+	  DEC Alpha machines were often equipped with DAC960 cards that were
+	  OEMed from Mylex, and had their own custom firmware. Version 2.70,
+	  the last custom FW revision to be released by DEC for these older
+	  controllers, appears to work quite well with this driver.
+
+	  Cards tested successfully were several versions each of the PD and
+	  PU, called by DEC the KZPSC and KZPAC, respectively, and having
+	  the Manufacturer Numbers (from Mylex), usually on a sticker on the
+	  back of the board, of:
+
+	  KZPSC:  D040347 (1-channel) or D040348 (2-channel) or D040349 (3-channel)
+	  KZPAC:  D040395 (1-channel) or D040396 (2-channel) or D040397 (3-channel)
+	*/
+# define FIRMWARE_27X	"2.70"
+#else
+# define FIRMWARE_27X	"2.73"
+#endif
+
+	if (enquiry2->fw.MajorVersion == 0) {
+		enquiry2->fw.MajorVersion = cb->enquiry->fw_major_version;
+		enquiry2->fw.MinorVersion = cb->enquiry->fw_minor_version;
+		enquiry2->fw.FirmwareType = '0';
+		enquiry2->fw.TurnID = 0;
+	}
+	sprintf(cb->FirmwareVersion, "%d.%02d-%c-%02d",
+		enquiry2->fw.MajorVersion,
+		enquiry2->fw.MinorVersion,
+		enquiry2->fw.FirmwareType,
+		enquiry2->fw.TurnID);
+	if (!((enquiry2->fw.MajorVersion == 5 &&
+	       enquiry2->fw.MinorVersion >= 6) ||
+	      (enquiry2->fw.MajorVersion == 4 &&
+	       enquiry2->fw.MinorVersion >= 6) ||
+	      (enquiry2->fw.MajorVersion == 3 &&
+	       enquiry2->fw.MinorVersion >= 51) ||
+	      (enquiry2->fw.MajorVersion == 2 &&
+	       strcmp(cb->FirmwareVersion, FIRMWARE_27X) >= 0))) {
+		shost_printk(KERN_WARNING, cb->host,
+			"Firmware Version '%s' unsupported\n",
+			cb->FirmwareVersion);
+		goto out;
+	}
+	/*
+	  Initialize the c Channels, Targets, Memory Size, and SAF-TE
+	  Enclosure Management Enabled fields.
+	*/
+	switch (enquiry2->hw.Model) {
+	case DAC960_V1_FiveChannelBoard:
+		pchan_max = 5;
+		break;
+	case DAC960_V1_ThreeChannelBoard:
+	case DAC960_V1_ThreeChannelASIC_DAC:
+		pchan_max = 3;
+		break;
+	case DAC960_V1_TwoChannelBoard:
+		pchan_max = 2;
+		break;
+	default:
+		pchan_max = enquiry2->cfg_chan;
+		break;
+	}
+	pchan_cur = enquiry2->cur_chan;
+	if (enquiry2->scsi_cap.bus_width == DAC960_V1_Wide_32bit)
+		cb->BusWidth = 32;
+	else if (enquiry2->scsi_cap.bus_width == DAC960_V1_Wide_16bit)
+		cb->BusWidth = 16;
+	else
+		cb->BusWidth = 8;
+	cb->ldev_block_size = enquiry2->ldev_block_size;
+	shost->max_channel = pchan_cur;
+	shost->max_id = enquiry2->max_targets;
+	memsize = enquiry2->mem_size >> 20;
+	cb->safte_enabled = (enquiry2->fault_mgmt == DAC960_V1_SAFTE);
+	/*
+	  Initialize the Controller Queue Depth, Driver Queue Depth, Logical Drive
+	  Count, Maximum Blocks per Command, Controller Scatter/Gather Limit, and
+	  Driver Scatter/Gather Limit.  The Driver Queue Depth must be at most one
+	  less than the Controller Queue Depth to allow for an automatic drive
+	  rebuild operation.
+	*/
+	shost->can_queue = cb->enquiry->max_tcq;
+	if (shost->can_queue < 3)
+		shost->can_queue = enquiry2->max_cmds;
+	if (shost->can_queue < 3)
+		/* Play safe and disable TCQ */
+		shost->can_queue = 1;
+
+	if (shost->can_queue > DAC960_V1_CommandMailboxCount - 2)
+		shost->can_queue = DAC960_V1_CommandMailboxCount - 2;
+	shost->max_sectors = enquiry2->max_sectors;
+	shost->sg_tablesize = enquiry2->max_sge;
+	if (shost->sg_tablesize > DAC960_V1_ScatterGatherLimit)
+		shost->sg_tablesize = DAC960_V1_ScatterGatherLimit;
+	/*
+	  Initialize the Stripe Size, Segment Size, and Geometry Translation.
+	*/
+	cb->StripeSize = config2->BlocksPerStripe * config2->BlockFactor
+		>> (10 - MYRB_BLKSIZE_BITS);
+	cb->SegmentSize = config2->BlocksPerCacheLine * config2->BlockFactor
+		>> (10 - MYRB_BLKSIZE_BITS);
+	/* Assume 255/63 translation */
+	cb->ldev_geom_heads = 255;
+	cb->ldev_geom_sectors = 63;
+	if (config2->DriveGeometry) {
+		cb->ldev_geom_heads = 128;
+		cb->ldev_geom_sectors = 32;
+	}
+
+	/*
+	  Initialize the Background Initialization Status.
+	*/
+	if ((cb->FirmwareVersion[0] == '4' &&
+	     strcmp(cb->FirmwareVersion, "4.08") >= 0) ||
+	    (cb->FirmwareVersion[0] == '5' &&
+	     strcmp(cb->FirmwareVersion, "5.08") >= 0)) {
+		cb->bgi_status_supported = true;
+		myrb_bgi_control(cb);
+	}
+	cb->last_rbld_status = DAC960_V1_NoRebuildOrCheckInProgress;
+	ret = 0;
+
+out:
+	shost_printk(KERN_INFO, cb->host,
+		"Configuring %s PCI RAID Controller\n", cb->ModelName);
+	shost_printk(KERN_INFO, cb->host,
+		     "  Firmware Version: %s, Memory Size: %dMB\n",
+		     cb->FirmwareVersion, memsize);
+	if (cb->io_addr == 0)
+		shost_printk(KERN_INFO, cb->host,
+			"  I/O Address: n/a, PCI Address: 0x%lX, IRQ Channel: %d\n",
+			(unsigned long)cb->pci_addr, cb->irq);
+	else
+		shost_printk(KERN_INFO, cb->host,
+			"  I/O Address: 0x%lX, PCI Address: 0x%lX, IRQ Channel: %d\n",
+			(unsigned long)cb->io_addr,
+			(unsigned long)cb->pci_addr,
+			cb->irq);
+	shost_printk(KERN_INFO, cb->host,
+		"  Controller Queue Depth: %d, Maximum Blocks per Command: %d\n",
+		cb->host->can_queue, cb->host->max_sectors);
+	shost_printk(KERN_INFO, cb->host,
+		     "  Driver Queue Depth: %d,"
+		     " Scatter/Gather Limit: %d of %d Segments\n",
+		     cb->host->can_queue, cb->host->sg_tablesize,
+		     DAC960_V1_ScatterGatherLimit);
+	shost_printk(KERN_INFO, cb->host,
+		     "  Stripe Size: %dKB, Segment Size: %dKB, "
+		     "BIOS Geometry: %d/%d%s\n",
+		     cb->StripeSize, cb->SegmentSize,
+		     cb->ldev_geom_heads, cb->ldev_geom_sectors,
+		     cb->safte_enabled ?
+		     "  SAF-TE Enclosure Management Enabled" : "");
+	shost_printk(KERN_INFO, cb->host,
+		     "  Physical: %d/%d channels %d/%d/%d devices\n",
+		     pchan_cur, pchan_max, 0, cb->enquiry->pdev_dead,
+		     cb->host->max_id);
+
+	shost_printk(KERN_INFO, cb->host,
+		     "  Logical: 1/1 channels, %d/%d disks\n",
+		     cb->enquiry->ldev_count, MYRB_MAX_LDEVS);
+
+out_free:
+	dma_free_coherent(&pdev->dev, sizeof(struct myrb_enquiry2),
+			  enquiry2, enquiry2_addr);
+	dma_free_coherent(&pdev->dev, sizeof(struct myrb_config2),
+			  config2, config2_addr);
+
+	return ret;
+}
+
+/**
+ * myrb_unmap - unmaps controller structures
+ */
+static void myrb_unmap(struct myrb_hba *cb)
+{
+	if (cb->ldev_info_buf) {
+		size_t ldev_info_size = sizeof(struct myrb_ldev_info) *
+			MYRB_MAX_LDEVS;
+		dma_free_coherent(&cb->pdev->dev, ldev_info_size,
+				  cb->ldev_info_buf, cb->ldev_info_addr);
+		cb->ldev_info_buf = NULL;
+	}
+	if (cb->err_table) {
+		size_t err_table_size = sizeof(struct myrb_error_entry) *
+			DAC960_V1_MaxChannels * DAC960_V1_MaxTargets;
+		dma_free_coherent(&cb->pdev->dev, err_table_size,
+				  cb->err_table, cb->err_table_addr);
+		cb->err_table = NULL;
+	}
+	if (cb->enquiry) {
+		dma_free_coherent(&cb->pdev->dev, sizeof(struct myrb_enquiry),
+				  cb->enquiry, cb->enquiry_addr);
+		cb->enquiry = NULL;
+	}
+	if (cb->first_stat_mbox) {
+		dma_free_coherent(&cb->pdev->dev, cb->stat_mbox_size,
+				  cb->first_stat_mbox, cb->stat_mbox_addr);
+		cb->first_stat_mbox = NULL;
+	}
+	if (cb->first_cmd_mbox) {
+		dma_free_coherent(&cb->pdev->dev, cb->cmd_mbox_size,
+				  cb->first_cmd_mbox, cb->cmd_mbox_addr);
+		cb->first_cmd_mbox = NULL;
+	}
+}
+
+/**
+ * myrb_cleanup - cleanup controller structures
+ */
+static void myrb_cleanup(struct myrb_hba *cb)
+{
+	struct pci_dev *pdev = cb->pdev;
+
+	/* Free the memory mailbox, status, and related structures */
+	myrb_unmap(cb);
+
+	if (cb->mmio_base) {
+		cb->disable_intr(cb->io_base);
+		iounmap(cb->mmio_base);
+	}
+	if (cb->irq)
+		free_irq(cb->irq, cb);
+	if (cb->io_addr)
+		release_region(cb->io_addr, 0x80);
+	pci_set_drvdata(pdev, NULL);
+	pci_disable_device(pdev);
+	scsi_host_put(cb->host);
+}
+
+static int myrb_host_reset(struct scsi_cmnd *scmd)
+{
+	struct Scsi_Host *shost = scmd->device->host;
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+
+	cb->reset(cb->io_base);
+	return SUCCESS;
+}
+
+static int myrb_pthru_queuecommand(struct Scsi_Host *shost,
+				   struct scsi_cmnd *scmd)
+{
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+	struct myrb_cmdblk *cmd_blk = scsi_cmd_priv(scmd);
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct myrb_dcdb *dcdb;
+	dma_addr_t dcdb_addr;
+	struct scsi_device *sdev = scmd->device;
+	struct scatterlist *sgl;
+	unsigned long flags;
+	int nsge;
+
+	myrb_reset_cmd(cmd_blk);
+	dcdb = dma_pool_alloc(cb->dcdb_pool, GFP_ATOMIC, &dcdb_addr);
+	if (!dcdb)
+		return SCSI_MLQUEUE_HOST_BUSY;
+	nsge = scsi_dma_map(scmd);
+	if (nsge > 1) {
+		dma_pool_free(cb->dcdb_pool, dcdb, dcdb_addr);
+		scmd->result = (DID_ERROR << 16);
+		scmd->scsi_done(scmd);
+		return 0;
+	}
+
+	mbox->Type3.opcode = DAC960_V1_DCDB;
+	mbox->Type3.id = scmd->request->tag + 3;
+	mbox->Type3.addr = dcdb_addr;
+	dcdb->Channel = sdev->channel;
+	dcdb->TargetID = sdev->id;
+	switch (scmd->sc_data_direction) {
+	case DMA_NONE:
+		dcdb->Direction = DAC960_V1_DCDB_NoDataTransfer;
+		break;
+	case DMA_TO_DEVICE:
+		dcdb->Direction = DAC960_V1_DCDB_DataTransferSystemToDevice;
+		break;
+	case DMA_FROM_DEVICE:
+		dcdb->Direction = DAC960_V1_DCDB_DataTransferDeviceToSystem;
+		break;
+	default:
+		dcdb->Direction = DAC960_V1_DCDB_IllegalDataTransfer;
+		break;
+	}
+	dcdb->EarlyStatus = false;
+	if (scmd->request->timeout <= 10)
+		dcdb->Timeout = DAC960_V1_DCDB_Timeout_10_seconds;
+	else if (scmd->request->timeout <= 60)
+		dcdb->Timeout = DAC960_V1_DCDB_Timeout_60_seconds;
+	else if (scmd->request->timeout <= 600)
+		dcdb->Timeout = DAC960_V1_DCDB_Timeout_10_minutes;
+	else
+		dcdb->Timeout = DAC960_V1_DCDB_Timeout_24_hours;
+	dcdb->NoAutomaticRequestSense = false;
+	dcdb->DisconnectPermitted = true;
+	sgl = scsi_sglist(scmd);
+	dcdb->BusAddress = sg_dma_address(sgl);
+	if (sg_dma_len(sgl) > USHRT_MAX) {
+		dcdb->xfer_len_lo = sg_dma_len(sgl) & 0xffff;
+		dcdb->xfer_len_hi4 = sg_dma_len(sgl) >> 16;
+	} else {
+		dcdb->xfer_len_lo = sg_dma_len(sgl);
+		dcdb->xfer_len_hi4 = 0;
+	}
+	dcdb->CDBLength = scmd->cmd_len;
+	dcdb->SenseLength = sizeof(dcdb->SenseData);
+	memcpy(&dcdb->CDB, scmd->cmnd, scmd->cmd_len);
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	cb->qcmd(cb, cmd_blk);
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return 0;
+}
+
+static void myrb_inquiry(struct myrb_hba *cb,
+			 struct scsi_cmnd *scmd)
+{
+	unsigned char inq[36] = {
+		0x00, 0x00, 0x03, 0x02, 0x20, 0x00, 0x01, 0x00,
+		0x4d, 0x59, 0x4c, 0x45, 0x58, 0x20, 0x20, 0x20,
+		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+		0x20, 0x20, 0x20, 0x20,
+	};
+
+	if (cb->BusWidth > 16)
+		inq[7] |= 1 << 6;
+	if (cb->BusWidth > 8)
+		inq[7] |= 1 << 5;
+	memcpy(&inq[16], cb->ModelName, 16);
+	memcpy(&inq[32], cb->FirmwareVersion, 1);
+	memcpy(&inq[33], &cb->FirmwareVersion[2], 2);
+	memcpy(&inq[35], &cb->FirmwareVersion[7], 1);
+
+	scsi_sg_copy_from_buffer(scmd, (void *)inq, 36);
+}
+
+static void
+myrb_mode_sense(struct myrb_hba *cb, struct scsi_cmnd *scmd,
+		struct myrb_ldev_info *ldev_info)
+{
+	unsigned char modes[32], *mode_pg;
+	bool dbd;
+	size_t mode_len;
+
+	dbd = (scmd->cmnd[1] & 0x08) == 0x08;
+	if (dbd) {
+		mode_len = 24;
+		mode_pg = &modes[4];
+	} else {
+		mode_len = 32;
+		mode_pg = &modes[12];
+	}
+	memset(modes, 0, sizeof(modes));
+	modes[0] = mode_len - 1;
+	if (!dbd) {
+		unsigned char *block_desc = &modes[4];
+		modes[3] = 8;
+		put_unaligned_be32(ldev_info->Size, &block_desc[0]);
+		put_unaligned_be32(cb->ldev_block_size, &block_desc[5]);
+	}
+	mode_pg[0] = 0x08;
+	mode_pg[1] = 0x12;
+	if (ldev_info->WriteBack)
+		mode_pg[2] |= 0x04;
+	if (cb->SegmentSize) {
+		mode_pg[2] |= 0x08;
+		put_unaligned_be16(cb->SegmentSize, &mode_pg[14]);
+	}
+
+	scsi_sg_copy_from_buffer(scmd, modes, mode_len);
+}
+
+static void myrb_request_sense(struct myrb_hba *cb,
+			       struct scsi_cmnd *scmd)
+{
+	scsi_build_sense_buffer(0, scmd->sense_buffer,
+				NO_SENSE, 0, 0);
+	scsi_sg_copy_from_buffer(scmd, scmd->sense_buffer,
+				 SCSI_SENSE_BUFFERSIZE);
+}
+
+static void myrb_read_capacity(struct myrb_hba *cb, struct scsi_cmnd *scmd,
+			       struct myrb_ldev_info *ldev_info)
+{
+	unsigned char data[8];
+
+	dev_dbg(&scmd->device->sdev_gendev,
+		"Capacity %u, blocksize %u\n",
+		ldev_info->Size, cb->ldev_block_size);
+	put_unaligned_be32(ldev_info->Size - 1, &data[0]);
+	put_unaligned_be32(cb->ldev_block_size, &data[4]);
+	scsi_sg_copy_from_buffer(scmd, data, 8);
+}
+
+static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
+				  struct scsi_cmnd *scmd)
+{
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+	struct myrb_cmdblk *cmd_blk = scsi_cmd_priv(scmd);
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct myrb_ldev_info *ldev_info;
+	struct scsi_device *sdev = scmd->device;
+	struct scatterlist *sgl;
+	unsigned long flags;
+	u64 lba;
+	u32 block_cnt;
+	int nsge;
+
+	ldev_info = sdev->hostdata;
+	if (!ldev_info ||
+	    (ldev_info->State != DAC960_V1_Device_Online &&
+	     ldev_info->State != DAC960_V1_Device_WriteOnly)) {
+		dev_dbg(&shost->shost_gendev, "ldev %u in state %x, skip\n",
+			sdev->id, ldev_info ? ldev_info->State : 0xff);
+		scmd->result = (DID_BAD_TARGET << 16);
+		scmd->scsi_done(scmd);
+		return 0;
+	}
+	switch (scmd->cmnd[0]) {
+	case TEST_UNIT_READY:
+		scmd->result = (DID_OK << 16);
+		scmd->scsi_done(scmd);
+		return 0;
+	case INQUIRY:
+		if (scmd->cmnd[1] & 1) {
+			/* Illegal request, invalid field in CDB */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						ILLEGAL_REQUEST, 0x24, 0);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+		} else {
+			myrb_inquiry(cb, scmd);
+			scmd->result = (DID_OK << 16);
+		}
+		scmd->scsi_done(scmd);
+		return 0;
+		break;
+	case SYNCHRONIZE_CACHE:
+		scmd->result = (DID_OK << 16);
+		scmd->scsi_done(scmd);
+		return 0;
+		break;
+	case MODE_SENSE:
+		if ((scmd->cmnd[2] & 0x3F) != 0x3F &&
+		    (scmd->cmnd[2] & 0x3F) != 0x08) {
+			/* Illegal request, invalid field in CDB */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						ILLEGAL_REQUEST, 0x24, 0);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+		} else {
+			myrb_mode_sense(cb, scmd, ldev_info);
+			scmd->result = (DID_OK << 16);
+		}
+		scmd->scsi_done(scmd);
+		return 0;
+		break;
+	case READ_CAPACITY:
+		if ((scmd->cmnd[1] & 1) ||
+		    (scmd->cmnd[8] & 1)) {
+			/* Illegal request, invalid field in CDB */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						ILLEGAL_REQUEST, 0x24, 0);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+		lba = get_unaligned_be32(&scmd->cmnd[2]);
+		if (lba) {
+			/* Illegal request, invalid field in CDB */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						ILLEGAL_REQUEST, 0x24, 0);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+		myrb_read_capacity(cb, scmd, ldev_info);
+		scmd->scsi_done(scmd);
+		return 0;
+	case REQUEST_SENSE:
+		myrb_request_sense(cb, scmd);
+		scmd->result = (DID_OK << 16);
+		return 0;
+		break;
+	case SEND_DIAGNOSTIC:
+		if (scmd->cmnd[1] != 0x04) {
+			/* Illegal request, invalid field in CDB */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						ILLEGAL_REQUEST, 0x24, 0);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+		} else {
+			/* Assume good status */
+			scmd->result = (DID_OK << 16);
+		}
+		scmd->scsi_done(scmd);
+		return 0;
+		break;
+	case READ_6:
+		if (ldev_info->State == DAC960_V1_Device_WriteOnly) {
+			/* Data protect, attempt to read invalid data */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						DATA_PROTECT, 0x21, 0x06);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+	case WRITE_6:
+		lba = (((scmd->cmnd[1] & 0x1F) << 16) |
+		       (scmd->cmnd[2] << 8) |
+		       scmd->cmnd[3]);
+		block_cnt = scmd->cmnd[4];
+		break;
+	case READ_10:
+		if (ldev_info->State == DAC960_V1_Device_WriteOnly) {
+			/* Data protect, attempt to read invalid data */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						DATA_PROTECT, 0x21, 0x06);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+	case WRITE_10:
+	case VERIFY:		/* 0x2F */
+	case WRITE_VERIFY:	/* 0x2E */
+		lba = get_unaligned_be32(&scmd->cmnd[2]);
+		block_cnt = get_unaligned_be16(&scmd->cmnd[7]);
+		break;
+	case READ_12:
+		if (ldev_info->State == DAC960_V1_Device_WriteOnly) {
+			/* Data protect, attempt to read invalid data */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						DATA_PROTECT, 0x21, 0x06);
+			scmd->result = (DRIVER_SENSE << 24) |
+				SAM_STAT_CHECK_CONDITION;
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+	case WRITE_12:
+	case VERIFY_12: /* 0xAF */
+	case WRITE_VERIFY_12:	/* 0xAE */
+		lba = get_unaligned_be32(&scmd->cmnd[2]);
+		block_cnt = get_unaligned_be32(&scmd->cmnd[6]);
+		break;
+	default:
+		/* Illegal request, invalid opcode */
+		scsi_build_sense_buffer(0, scmd->sense_buffer,
+					ILLEGAL_REQUEST, 0x20, 0);
+		scmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+		scmd->scsi_done(scmd);
+		return 0;
+	}
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->Type5.id = scmd->request->tag + 3;
+	if (scmd->sc_data_direction == DMA_NONE)
+		goto submit;
+	nsge = scsi_dma_map(scmd);
+	if (nsge == 1) {
+		sgl = scsi_sglist(scmd);
+		if (scmd->sc_data_direction == DMA_FROM_DEVICE)
+			mbox->Type5.opcode = DAC960_V1_Read;
+		else
+			mbox->Type5.opcode = DAC960_V1_Write;
+
+		mbox->Type5.LD.xfer_len = block_cnt;
+		mbox->Type5.LD.ldev_num = sdev->id;
+		mbox->Type5.lba = lba;
+		mbox->Type5.addr = (u32)sg_dma_address(sgl);
+	} else {
+		struct myrb_sge *hw_sgl;
+		dma_addr_t hw_sgl_addr;
+		int i;
+
+		hw_sgl = dma_pool_alloc(cb->sg_pool, GFP_ATOMIC, &hw_sgl_addr);
+		if (!hw_sgl)
+			return SCSI_MLQUEUE_HOST_BUSY;
+
+		cmd_blk->sgl = hw_sgl;
+		cmd_blk->sgl_addr = hw_sgl_addr;
+
+		if (scmd->sc_data_direction == DMA_FROM_DEVICE)
+			mbox->Type5.opcode = DAC960_V1_ReadWithScatterGather;
+		else
+			mbox->Type5.opcode = DAC960_V1_WriteWithScatterGather;
+
+		mbox->Type5.LD.xfer_len = block_cnt;
+		mbox->Type5.LD.ldev_num = sdev->id;
+		mbox->Type5.lba = lba;
+		mbox->Type5.addr = hw_sgl_addr;
+		mbox->Type5.sg_count = nsge;
+
+		scsi_for_each_sg(scmd, sgl, nsge, i) {
+			hw_sgl->sge_addr = (u32)sg_dma_address(sgl);
+			hw_sgl->sge_count = (u32)sg_dma_len(sgl);
+			hw_sgl++;
+		}
+	}
+submit:
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	cb->qcmd(cb, cmd_blk);
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+
+	return 0;
+}
+
+static int myrb_queuecommand(struct Scsi_Host *shost,
+			     struct scsi_cmnd *scmd)
+{
+	struct scsi_device *sdev = scmd->device;
+
+	if (sdev->channel > myrb_logical_channel(shost)) {
+		scmd->result = (DID_BAD_TARGET << 16);
+		scmd->scsi_done(scmd);
+		return 0;
+	}
+	if (sdev->channel == myrb_logical_channel(shost))
+		return myrb_ldev_queuecommand(shost, scmd);
+
+	return myrb_pthru_queuecommand(shost, scmd);
+}
+
+static int myrb_slave_alloc(struct scsi_device *sdev)
+{
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	unsigned short status;
+
+	if (sdev->channel > myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	if (sdev->lun > 0)
+		return -ENXIO;
+
+	if (sdev->channel == myrb_logical_channel(sdev->host)) {
+		struct myrb_ldev_info *ldev_info;
+		unsigned short ldev_num = sdev->id;
+		enum raid_level level;
+
+		ldev_info = cb->ldev_info_buf + ldev_num;
+		if (!ldev_info)
+			return -ENXIO;
+
+		sdev->hostdata = kzalloc(sizeof(*ldev_info),
+					 GFP_KERNEL);
+		if (!sdev->hostdata)
+			return -ENOMEM;
+		dev_dbg(&sdev->sdev_gendev,
+			"slave alloc ldev %d state %x\n",
+			ldev_num, ldev_info->State);
+		memcpy(sdev->hostdata, ldev_info,
+		       sizeof(*ldev_info));
+		switch (ldev_info->RAIDLevel) {
+		case DAC960_V1_RAID_Level0:
+			level = RAID_LEVEL_LINEAR;
+			break;
+		case DAC960_V1_RAID_Level1:
+			level = RAID_LEVEL_1;
+			break;
+		case DAC960_V1_RAID_Level3:
+			level = RAID_LEVEL_3;
+			break;
+		case DAC960_V1_RAID_Level5:
+			level = RAID_LEVEL_5;
+			break;
+		case DAC960_V1_RAID_Level6:
+			level = RAID_LEVEL_6;
+			break;
+		case DAC960_V1_RAID_JBOD:
+			level = RAID_LEVEL_JBOD;
+			break;
+		default:
+			level = RAID_LEVEL_UNKNOWN;
+			break;
+		}
+		raid_set_level(myrb_raid_template,
+			       &sdev->sdev_gendev, level);
+		return 0;
+	} else {
+		struct myrb_pdev_state *pdev_info;
+
+		if (sdev->id > DAC960_V1_MaxTargets)
+			return -ENXIO;
+
+		pdev_info = kzalloc(sizeof(*pdev_info), GFP_KERNEL|GFP_DMA);
+		if (!pdev_info)
+			return -ENOMEM;
+
+		status = myrb_exec_type3D(cb, DAC960_V1_GetDeviceState,
+					  sdev, pdev_info);
+		if (status != DAC960_V1_NormalCompletion) {
+			dev_dbg(&sdev->sdev_gendev,
+				"Failed to get device state, status %x\n",
+				status);
+			kfree(pdev_info);
+			return -ENXIO;
+		}
+		if (!pdev_info->Present) {
+			dev_dbg(&sdev->sdev_gendev,
+				"device not present, skip\n");
+			kfree(pdev_info);
+			return -ENXIO;
+		}
+		dev_dbg(&sdev->sdev_gendev,
+			 "slave alloc pdev %d:%d state %x\n",
+			 sdev->channel, sdev->id, pdev_info->State);
+		sdev->hostdata = pdev_info;
+	}
+	return 0;
+}
+
+static int myrb_slave_configure(struct scsi_device *sdev)
+{
+	struct myrb_ldev_info *ldev_info;
+
+	if (sdev->channel > myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host)) {
+		sdev->no_uld_attach = 1;
+		return 0;
+	}
+	if (sdev->lun != 0)
+		return -ENXIO;
+
+	ldev_info = sdev->hostdata;
+	if (!ldev_info)
+		return -ENXIO;
+	if (ldev_info->State != DAC960_V1_Device_Online)
+		sdev_printk(KERN_INFO, sdev,
+			    "Logical drive is %s\n",
+			    myrb_devstate_name(ldev_info->State));
+
+	sdev->tagged_supported = 1;
+	return 0;
+}
+
+static void myrb_slave_destroy(struct scsi_device *sdev)
+{
+	void *hostdata = sdev->hostdata;
+
+	if (hostdata) {
+		kfree(hostdata);
+		sdev->hostdata = NULL;
+	}
+}
+
+static int myrb_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+			  sector_t capacity, int geom[])
+{
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+
+	geom[0] = cb->ldev_geom_heads;
+	geom[1] = cb->ldev_geom_sectors;
+	geom[2] = sector_div(capacity, geom[0] * geom[1]);
+
+	return 0;
+}
+
+static ssize_t
+myrb_show_dev_state(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	int ret;
+
+	if (!sdev->hostdata)
+		return snprintf(buf, 16, "Unknown\n");
+
+	if (sdev->channel == myrb_logical_channel(sdev->host)) {
+		struct myrb_ldev_info *ldev_info = sdev->hostdata;
+		const char *name;
+
+		name = myrb_devstate_name(ldev_info->State);
+		if (name)
+			ret = snprintf(buf, 32, "%s\n", name);
+		else
+			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+				       ldev_info->State);
+	} else {
+		struct myrb_pdev_state *pdev_info = sdev->hostdata;
+		unsigned short status;
+		const char *name;
+
+		status = myrb_exec_type3D(cb, DAC960_V1_GetDeviceState,
+					  sdev, pdev_info);
+		if (status != DAC960_V1_NormalCompletion)
+			sdev_printk(KERN_INFO, sdev,
+				    "Failed to get device state, status %x\n",
+				    status);
+
+		if (!pdev_info->Present)
+			name = "Removed";
+		else
+			name = myrb_devstate_name(pdev_info->State);
+		if (name)
+			ret = snprintf(buf, 32, "%s\n", name);
+		else
+			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+				       pdev_info->State);
+	}
+	return ret;
+}
+
+static ssize_t
+myrb_store_dev_state(struct device *dev, struct device_attribute *attr,
+		     const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	struct myrb_pdev_state *pdev_info;
+	enum myrb_devstate new_state;
+	unsigned short status;
+
+	if (!strncmp(buf, "kill", 4) ||
+	    !strncmp(buf, "offline", 7))
+		new_state = DAC960_V1_Device_Dead;
+	else if (!strncmp(buf, "online", 6))
+		new_state = DAC960_V1_Device_Online;
+	else if (!strncmp(buf, "standby", 7))
+		new_state = DAC960_V1_Device_Standby;
+	else
+		return -EINVAL;
+
+	pdev_info = sdev->hostdata;
+	if (!pdev_info) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed - no physical device information\n");
+		return -ENXIO;
+	}
+	if (!pdev_info->Present) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed - device not present\n");
+		return -ENXIO;
+	}
+
+	if (pdev_info->State == new_state)
+		return count;
+
+	status = myrb_set_pdev_state(cb, sdev, new_state);
+	switch (status) {
+	case DAC960_V1_NormalCompletion:
+		break;
+	case DAC960_V1_UnableToStartDevice:
+		sdev_printk(KERN_INFO, sdev,
+			     "Failed - Unable to Start Device\n");
+		count = -EAGAIN;
+		break;
+	case DAC960_V1_NoDeviceAtAddress:
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed - No Device at Address\n");
+		count = -ENODEV;
+		break;
+	case DAC960_V1_InvalidChannelOrTargetOrModifier:
+		sdev_printk(KERN_INFO, sdev,
+			 "Failed - Invalid Channel or Target or Modifier\n");
+		count = -EINVAL;
+		break;
+	case DAC960_V1_ChannelBusy:
+		sdev_printk(KERN_INFO, sdev,
+			 "Failed - Channel Busy\n");
+		count = -EBUSY;
+		break;
+	default:
+		sdev_printk(KERN_INFO, sdev,
+			 "Failed - Unexpected Status %04X\n", status);
+		count = -EIO;
+		break;
+	}
+	return count;
+}
+static DEVICE_ATTR(raid_state, S_IRUGO | S_IWUSR, myrb_show_dev_state,
+		   myrb_store_dev_state);
+
+static ssize_t
+myrb_show_dev_level(struct device *dev, struct device_attribute *attr,
+		    char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	if (sdev->channel == myrb_logical_channel(sdev->host)) {
+		struct myrb_ldev_info *ldev_info = sdev->hostdata;
+		const char *name;
+
+		if (!ldev_info)
+			return -ENXIO;
+
+		name = myrb_raidlevel_name(ldev_info->RAIDLevel);
+		if (!name)
+			return snprintf(buf, 32, "Invalid (%02X)\n",
+					ldev_info->State);
+		return snprintf(buf,32, "%s\n", name);
+	}
+	return snprintf(buf, 32, "Physical Drive\n");
+}
+static DEVICE_ATTR(raid_level, S_IRUGO, myrb_show_dev_level, NULL);
+
+static ssize_t
+myrb_show_dev_rebuild(struct device *dev, struct device_attribute *attr,
+		      char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	struct myrb_rbld_progress rbld_buf;
+	unsigned char status;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host))
+		return snprintf(buf, 32, "physical device - not rebuilding\n");
+
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+
+	if (rbld_buf.ldev_num != sdev->id ||
+	    status != DAC960_V1_NormalCompletion)
+		return snprintf(buf, 32, "not rebuilding\n");
+
+	return snprintf(buf, 32, "rebuilding block %u of %u\n",
+			rbld_buf.ldev_size - rbld_buf.blocks_left,
+			rbld_buf.ldev_size);
+}
+
+static ssize_t
+myrb_store_dev_rebuild(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	struct myrb_cmdblk *cmd_blk;
+	union myrb_cmd_mbox *mbox;
+	char tmpbuf[8];
+	ssize_t len;
+	unsigned short status;
+	int start;
+	const char *msg;
+
+	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	strncpy(tmpbuf, buf, len);
+	tmpbuf[len] = '\0';
+	if (sscanf(tmpbuf, "%d", &start) != 1)
+		return -EINVAL;
+
+	if (sdev->channel >= myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	status = myrb_get_rbld_progress(cb, NULL);
+	if (start) {
+		if (status == DAC960_V1_NormalCompletion) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Not Initiated; already in progress\n");
+			return -EALREADY;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->Type3D.opcode = DAC960_V1_RebuildAsync;
+		mbox->Type3D.id = MYRB_DCMD_TAG;
+		mbox->Type3D.Channel = sdev->channel;
+		mbox->Type3D.TargetID = sdev->id;
+		status = myrb_exec_cmd(cb, cmd_blk);
+		mutex_unlock(&cb->dcmd_mutex);
+	} else {
+		struct pci_dev *pdev = cb->pdev;
+		unsigned char *rate;
+		dma_addr_t rate_addr;
+
+		if (status != DAC960_V1_NormalCompletion) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Not Cancelled; not in progress\n");
+			return 0;
+		}
+
+		rate = dma_alloc_coherent(&pdev->dev, sizeof(char),
+					  &rate_addr, GFP_KERNEL);
+		if (rate == NULL) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Cancellation of Rebuild Failed - "
+				    "Out of Memory\n");
+			return -ENOMEM;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->Type3R.opcode = DAC960_V1_RebuildControl;
+		mbox->Type3R.id = MYRB_DCMD_TAG;
+		mbox->Type3R.rbld_rate = 0xFF;
+		mbox->Type3R.addr = rate_addr;
+		status = myrb_exec_cmd(cb, cmd_blk);
+		dma_free_coherent(&pdev->dev, sizeof(char), rate, rate_addr);
+		mutex_unlock(&cb->dcmd_mutex);
+	}
+	if (status == DAC960_V1_NormalCompletion) {
+		sdev_printk(KERN_INFO, sdev, "Rebuild %s\n",
+			    start ? "Initiated" : "Cancelled");
+		return count;
+	}
+	if (!start) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Rebuild Not Cancelled, status 0x%x\n",
+			    status);
+		return -EIO;
+	}
+
+	switch (status) {
+	case DAC960_V1_AttemptToRebuildOnlineDrive:
+		msg = "Attempt to Rebuild Online or Unresponsive Drive";
+		break;
+	case DAC960_V1_NewDiskFailedDuringRebuild:
+		msg = "New Disk Failed During Rebuild";
+		break;
+	case DAC960_V1_InvalidDeviceAddress:
+		msg = "Invalid Device Address";
+		break;
+	case DAC960_V1_RebuildOrCheckAlreadyInProgress:
+		msg = "Already in Progress";
+		break;
+	default:
+		msg = NULL;
+		break;
+	}
+	if (msg)
+		sdev_printk(KERN_INFO, sdev,
+			    "Rebuild Failed - %s\n", msg);
+	else
+		sdev_printk(KERN_INFO, sdev,
+			    "Rebuild Failed, status 0x%x\n", status);
+
+	return -EIO;
+}
+static DEVICE_ATTR(rebuild, S_IRUGO | S_IWUSR, myrb_show_dev_rebuild,
+		   myrb_store_dev_rebuild);
+
+static ssize_t
+myrb_store_dev_consistency_check(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	struct myrb_rbld_progress rbld_buf;
+	struct myrb_cmdblk *cmd_blk;
+	union myrb_cmd_mbox *mbox;
+	char tmpbuf[8];
+	ssize_t len;
+	unsigned short ldev_num = 0xFFFF;
+	unsigned short status;
+	int start;
+	const char *msg;
+
+	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	strncpy(tmpbuf, buf, len);
+	tmpbuf[len] = '\0';
+	if (sscanf(tmpbuf, "%d", &start) != 1)
+		return -EINVAL;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+	if (start) {
+		if (status == DAC960_V1_NormalCompletion) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Check Consistency Not Initiated; "
+				    "already in progress\n");
+			return -EALREADY;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->Type3C.opcode = DAC960_V1_CheckConsistencyAsync;
+		mbox->Type3C.id = MYRB_DCMD_TAG;
+		mbox->Type3C.ldev_num = sdev->id;
+		mbox->Type3C.AutoRestore = true;
+
+		status = myrb_exec_cmd(cb, cmd_blk);
+		mutex_unlock(&cb->dcmd_mutex);
+	} else {
+		struct pci_dev *pdev = cb->pdev;
+		unsigned char *rate;
+		dma_addr_t rate_addr;
+
+		if (ldev_num != sdev->id) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Check Consistency Not Cancelled; "
+				    "not in progress\n");
+			return 0;
+		}
+		rate = dma_alloc_coherent(&pdev->dev, sizeof(char),
+					  &rate_addr, GFP_KERNEL);
+		if (rate == NULL) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Cancellation of Check Consistency Failed - "
+				    "Out of Memory\n");
+			return -ENOMEM;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->Type3R.opcode = DAC960_V1_RebuildControl;
+		mbox->Type3R.id = MYRB_DCMD_TAG;
+		mbox->Type3R.rbld_rate = 0xFF;
+		mbox->Type3R.addr = rate_addr;
+		status = myrb_exec_cmd(cb, cmd_blk);
+		dma_free_coherent(&pdev->dev, sizeof(char), rate, rate_addr);
+		mutex_unlock(&cb->dcmd_mutex);
+	}
+	if (status == DAC960_V1_NormalCompletion) {
+		sdev_printk(KERN_INFO, sdev, "Check Consistency %s\n",
+			    start ? "Initiated" : "Cancelled");
+		return count;
+	}
+	if (!start) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Check Consistency Not Cancelled, status 0x%x\n",
+			    status);
+		return -EIO;
+	}
+
+	switch (status) {
+	case DAC960_V1_AttemptToRebuildOnlineDrive:
+		msg = "Dependent Physical Device is DEAD";
+		break;
+	case DAC960_V1_NewDiskFailedDuringRebuild:
+		msg = "New Disk Failed During Rebuild";
+		break;
+	case DAC960_V1_InvalidDeviceAddress:
+		msg = "Invalid or Nonredundant Logical Drive";
+		break;
+	case DAC960_V1_RebuildOrCheckAlreadyInProgress:
+		msg = "Already in Progress";
+		break;
+	default:
+		msg = NULL;
+		break;
+	}
+	if (msg)
+		sdev_printk(KERN_INFO, sdev,
+			    "Check Consistency Failed - %s\n", msg);
+	else
+		sdev_printk(KERN_INFO, sdev,
+			    "Check Consistency Failed, status 0x%x\n", status);
+
+	return -EIO;
+}
+static DEVICE_ATTR(consistency_check, S_IRUGO | S_IWUSR,
+		   myrb_show_dev_rebuild,
+		   myrb_store_dev_consistency_check);
+
+static ssize_t
+myrb_show_ctlr_num(struct device *dev, struct device_attribute *attr,
+		   char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+
+	return snprintf(buf, 20, "%d\n", cb->ctlr_num);
+}
+static DEVICE_ATTR(ctlr_num, S_IRUGO, myrb_show_ctlr_num, NULL);
+
+static ssize_t
+myrb_show_firmware_version(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+
+	return snprintf(buf, 16, "%s\n", cb->FirmwareVersion);
+}
+static DEVICE_ATTR(firmware, S_IRUGO, myrb_show_firmware_version, NULL);
+
+static ssize_t
+myrb_show_model_name(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+
+	return snprintf(buf, 16, "%s\n", cb->ModelName);
+}
+static DEVICE_ATTR(model, S_IRUGO, myrb_show_model_name, NULL);
+
+static ssize_t
+myrb_store_flush_cache(struct device *dev, struct device_attribute *attr,
+		       const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;
+	unsigned short status;
+
+	status = myrb_exec_type3(cb, DAC960_V1_Flush, 0);
+	if (status == DAC960_V1_NormalCompletion) {
+		shost_printk(KERN_INFO, shost,
+			     "Cache Flush Completed\n");
+		return count;
+	}
+	shost_printk(KERN_INFO, shost,
+		     "Cache Flush Failed, status %x\n", status);
+	return -EIO;
+}
+static DEVICE_ATTR(flush_cache, S_IWUSR, NULL, myrb_store_flush_cache);
+
+static struct device_attribute *myrb_sdev_attrs[] = {
+	&dev_attr_rebuild,
+	&dev_attr_consistency_check,
+	&dev_attr_raid_state,
+	&dev_attr_raid_level,
+	NULL,
+};
+
+static struct device_attribute *myrb_shost_attrs[] = {
+	&dev_attr_ctlr_num,
+	&dev_attr_model,
+	&dev_attr_firmware,
+	&dev_attr_flush_cache,
+	NULL,
+};
+
+struct scsi_host_template myrb_template = {
+	.module = THIS_MODULE,
+	.name = "DAC960",
+	.proc_name = "myrb",
+	.queuecommand = myrb_queuecommand,
+	.eh_host_reset_handler = myrb_host_reset,
+	.slave_alloc = myrb_slave_alloc,
+	.slave_configure = myrb_slave_configure,
+	.slave_destroy = myrb_slave_destroy,
+	.bios_param = myrb_biosparam,
+	.cmd_size = sizeof(struct myrb_cmdblk),
+	.shost_attrs = myrb_shost_attrs,
+	.sdev_attrs = myrb_sdev_attrs,
+	.this_id = -1,
+};
+
+/**
+ * myrb_is_raid - return boolean indicating device is raid volume
+ * @dev the device struct object
+ */
+static int
+myrb_is_raid(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	return (sdev->channel == myrb_logical_channel(sdev->host)) ? 1 : 0;
+}
+
+/**
+ * myrb_get_resync - get raid volume resync percent complete
+ * @dev the device struct object
+ */
+static void
+myrb_get_resync(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	struct myrb_rbld_progress rbld_buf;
+	unsigned int percent_complete = 0;
+	unsigned short status;
+	unsigned int ldev_size = 0, remaining = 0;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host))
+		return;
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+	if (status == DAC960_V1_NormalCompletion) {
+		if (rbld_buf.ldev_num == sdev->id) {
+			ldev_size = rbld_buf.ldev_size;
+			remaining = rbld_buf.blocks_left;
+		}
+	}
+	if (remaining && ldev_size)
+		percent_complete = (ldev_size - remaining) * 100 / ldev_size;
+	raid_set_resync(myrb_raid_template, dev, percent_complete);
+}
+
+/**
+ * myrb_get_state - get raid volume status
+ * @dev the device struct object
+ */
+static void
+myrb_get_state(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = (struct myrb_hba *)sdev->host->hostdata;
+	struct myrb_ldev_info *ldev_info = sdev->hostdata;
+	enum raid_state state = RAID_STATE_UNKNOWN;
+	unsigned short status;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host) || !ldev_info)
+		state = RAID_STATE_UNKNOWN;
+	else {
+		status = myrb_get_rbld_progress(cb, NULL);
+		if (status == DAC960_V1_NormalCompletion)
+			state = RAID_STATE_RESYNCING;
+		else {
+			switch (ldev_info->State) {
+			case DAC960_V1_Device_Online:
+				state = RAID_STATE_ACTIVE;
+				break;
+			case DAC960_V1_Device_WriteOnly:
+			case DAC960_V1_Device_Critical:
+				state = RAID_STATE_DEGRADED;
+				break;
+			default:
+				state = RAID_STATE_OFFLINE;
+			}
+		}
+	}
+	raid_set_state(myrb_raid_template, dev, state);
+}
+
+struct raid_function_template myrb_raid_functions = {
+	.cookie		= &myrb_template,
+	.is_raid	= myrb_is_raid,
+	.get_resync	= myrb_get_resync,
+	.get_state	= myrb_get_state,
+};
+
+static void myrb_handle_scsi(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk,
+			     struct scsi_cmnd *scmd)
+{
+	unsigned short status;
+
+	if (!cmd_blk)
+		return;
+
+	BUG_ON(!scmd);
+	scsi_dma_unmap(scmd);
+
+	if (cmd_blk->dcdb) {
+		memcpy(scmd->sense_buffer, &cmd_blk->dcdb->SenseData, 64);
+		dma_pool_free(cb->dcdb_pool, cmd_blk->dcdb,
+			      cmd_blk->dcdb_addr);
+		cmd_blk->dcdb = NULL;
+	}
+	if (cmd_blk->sgl) {
+		dma_pool_free(cb->sg_pool, cmd_blk->sgl, cmd_blk->sgl_addr);
+		cmd_blk->sgl = NULL;
+		cmd_blk->sgl_addr = 0;
+	}
+	status = cmd_blk->status;
+	switch (status) {
+	case DAC960_V1_NormalCompletion:
+	case DAC960_V1_DeviceBusy:
+		scmd->result = (DID_OK << 16) | status;
+		break;
+	case DAC960_V1_BadDataEncountered:
+		dev_dbg(&scmd->device->sdev_gendev,
+			"Bad Data Encountered\n");
+		if (scmd->sc_data_direction == DMA_FROM_DEVICE)
+			/* Unrecovered read error */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						MEDIUM_ERROR, 0x11, 0);
+		else
+			/* Write error */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						MEDIUM_ERROR, 0x0C, 0);
+		scmd->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
+		break;
+	case DAC960_V1_IrrecoverableDataError:
+		scmd_printk(KERN_ERR, scmd, "Irrecoverable Data Error\n");
+		if (scmd->sc_data_direction == DMA_FROM_DEVICE)
+			/* Unrecovered read error, auto-reallocation failed */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						MEDIUM_ERROR, 0x11, 0x04);
+		else
+			/* Write error, auto-reallocation failed */
+			scsi_build_sense_buffer(0, scmd->sense_buffer,
+						MEDIUM_ERROR, 0x0C, 0x02);
+		scmd->result = (DID_OK << 16) | SAM_STAT_CHECK_CONDITION;
+		break;
+	case DAC960_V1_LogicalDriveNonexistentOrOffline:
+		dev_dbg(&scmd->device->sdev_gendev,
+			    "Logical Drive Nonexistent or Offline");
+		scmd->result = (DID_BAD_TARGET << 16);
+		break;
+	case DAC960_V1_AccessBeyondEndOfLogicalDrive:
+		dev_dbg(&scmd->device->sdev_gendev,
+			    "Attempt to Access Beyond End of Logical Drive");
+		/* Logical block address out of range */
+		scsi_build_sense_buffer(0, scmd->sense_buffer,
+					NOT_READY, 0x21, 0);
+		break;
+	case DAC960_V1_DeviceNonresponsive:
+		dev_dbg(&scmd->device->sdev_gendev, "Device nonresponsive\n");
+		scmd->result = (DID_BAD_TARGET << 16);
+		break;
+	default:
+		scmd_printk(KERN_ERR, scmd,
+			    "Unexpected Error Status %04X", status);
+		scmd->result = (DID_ERROR << 16);
+		break;
+	}
+	scmd->scsi_done(scmd);
+}
+
+static void myrb_handle_cmdblk(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	if (!cmd_blk)
+		return;
+
+	if (cmd_blk->Completion) {
+		complete(cmd_blk->Completion);
+		cmd_blk->Completion = NULL;
+	}
+}
+
+static void myrb_monitor(struct work_struct *work)
+{
+	struct myrb_hba *cb = container_of(work, struct myrb_hba, monitor_work.work);
+	struct Scsi_Host *shost = cb->host;
+	unsigned long interval = MYRB_PRIMARY_MONITOR_INTERVAL;
+
+	dev_dbg(&shost->shost_gendev, "monitor tick\n");
+
+	if (cb->new_ev_seq > cb->old_ev_seq) {
+		int event = cb->old_ev_seq;
+		dev_dbg(&shost->shost_gendev,
+			"get event log no %d/%d\n",
+			cb->new_ev_seq, event);
+		myrb_get_event(cb, event);
+		cb->old_ev_seq = event + 1;
+		interval = 10;
+	} else if (cb->need_err_info) {
+		cb->need_err_info = false;
+		dev_dbg(&shost->shost_gendev, "get error table\n");
+		myrb_get_errtable(cb);
+		interval = 10;
+	} else if (cb->need_rbld && cb->rbld_first) {
+		cb->need_rbld = false;
+		dev_dbg(&shost->shost_gendev,
+			"get rebuild progress\n");
+		myrb_update_rbld_progress(cb);
+		interval = 10;
+	} else if (cb->need_ldev_info) {
+		cb->need_ldev_info = false;
+		dev_dbg(&shost->shost_gendev,
+			"get logical drive info\n");
+		myrb_get_ldev_info(cb);
+		interval = 10;
+	} else if (cb->need_rbld) {
+		cb->need_rbld = false;
+		dev_dbg(&shost->shost_gendev,
+			"get rebuild progress\n");
+		myrb_update_rbld_progress(cb);
+		interval = 10;
+	} else if (cb->need_cc_status) {
+		cb->need_cc_status = false;
+		dev_dbg(&shost->shost_gendev,
+			"get consistency check progress\n");
+		myrb_get_cc_progress(cb);
+		interval = 10;
+	} else if (cb->need_bgi_status) {
+		cb->need_bgi_status = false;
+		dev_dbg(&shost->shost_gendev, "get background init status\n");
+		myrb_bgi_control(cb);
+		interval = 10;
+	} else {
+		dev_dbg(&shost->shost_gendev, "new enquiry\n");
+		mutex_lock(&cb->dma_mutex);
+		myrb_hba_enquiry(cb);
+		mutex_unlock(&cb->dma_mutex);
+		if ((cb->new_ev_seq - cb->old_ev_seq > 0) ||
+		    cb->need_err_info || cb->need_rbld ||
+		    cb->need_ldev_info || cb->need_cc_status ||
+		    cb->need_bgi_status) {
+			dev_dbg(&shost->shost_gendev,
+				"reschedule monitor\n");
+			interval = 0;
+		}
+	}
+	if (interval > 1)
+		cb->primary_monitor_time = jiffies;
+	queue_delayed_work(cb->work_q, &cb->monitor_work, interval);
+}
+
+/**
+ * myrb_err_status - reports controller BIOS messages
+ *
+ * Controller BIOS messages are passed through the Error Status Register
+ * when the driver performs the BIOS handshaking.
+ *
+ * Return: true for fatal errors and false otherwise.
+ */
+bool myrb_err_status(struct myrb_hba *cb, unsigned char error,
+		     unsigned char parm0, unsigned char parm1)
+{
+	struct pci_dev *pdev = cb->pdev;
+
+	switch (error) {
+	case 0x00:
+		dev_info(&pdev->dev,
+			 "Physical Device %d:%d Not Responding\n",
+			 parm1, parm0);
+		break;
+	case 0x08:
+		dev_notice(&pdev->dev, "Spinning Up Drives\n");
+		break;
+	case 0x30:
+		dev_notice(&pdev->dev, "Configuration Checksum Error\n");
+		break;
+	case 0x60:
+		dev_notice(&pdev->dev, "Mirror Race Recovery Failed\n");
+		break;
+	case 0x70:
+		dev_notice(&pdev->dev, "Mirror Race Recovery In Progress\n");
+		break;
+	case 0x90:
+		dev_notice(&pdev->dev, "Physical Device %d:%d COD Mismatch\n",
+			   parm1, parm0);
+		break;
+	case 0xA0:
+		dev_notice(&pdev->dev, "Logical Drive Installation Aborted\n");
+		break;
+	case 0xB0:
+		dev_notice(&pdev->dev, "Mirror Race On A Critical Logical Drive\n");
+		break;
+	case 0xD0:
+		dev_notice(&pdev->dev, "New Controller Configuration Found\n");
+		break;
+	case 0xF0:
+		dev_err(&pdev->dev, "Fatal Memory Parity Error\n");
+		return true;
+	default:
+		dev_err(&pdev->dev, "Unknown Initialization Error %02X\n",
+			error);
+		return true;
+	}
+	return false;
+}
+
+/*
+ * Hardware-specific functions
+ */
+
+/*
+ * DAC960 LA Series Controllers
+ */
+
+static inline
+void DAC960_LA_HardwareMailboxNewCommand(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_HWMBOX_NEW_CMD,
+	       base + DAC960_LA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LA_AcknowledgeHardwareMailboxStatus(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_HWMBOX_ACK_STS,
+	       base + DAC960_LA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LA_GenerateInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_GEN_IRQ,
+	       base + DAC960_LA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LA_ControllerReset(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_CTRL_RESET,
+	       base + DAC960_LA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LA_MemoryMailboxNewCommand(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_MMBOX_NEW_CMD,
+	       base + DAC960_LA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_LA_HardwareMailboxFullP(void __iomem *base)
+{
+	unsigned char idb =
+		readb(base + DAC960_LA_InboundDoorBellRegisterOffset);
+	return !(idb & DAC960_LA_IDB_HWMBOX_EMPTY);
+}
+
+static inline
+bool DAC960_LA_InitializationInProgressP(void __iomem *base)
+{
+	unsigned char idb =
+		readb(base + DAC960_LA_InboundDoorBellRegisterOffset);
+	return !(idb & DAC960_LA_IDB_INIT_DONE);
+}
+
+static inline
+void DAC960_LA_AcknowledgeHardwareMailboxInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LA_ODB_HWMBOX_ACK_IRQ,
+	       base + DAC960_LA_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LA_AcknowledgeMemoryMailboxInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LA_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_LA_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LA_AcknowledgeInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LA_ODB_HWMBOX_ACK_IRQ | DAC960_LA_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_LA_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_LA_HardwareMailboxStatusAvailableP(void __iomem *base)
+{
+	unsigned char odb =
+		readb(base + DAC960_LA_OutboundDoorBellRegisterOffset);
+	return odb & DAC960_LA_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline
+bool DAC960_LA_MemoryMailboxStatusAvailableP(void __iomem *base)
+{
+	unsigned char odb =
+		readb(base + DAC960_LA_OutboundDoorBellRegisterOffset);
+	return odb & DAC960_LA_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline
+void DAC960_LA_EnableInterrupts(void __iomem *base)
+{
+	unsigned char odb = 0xFF;
+
+	odb &= ~DAC960_LA_IRQMASK_DISABLE_IRQ;
+	writeb(odb, base + DAC960_LA_InterruptMaskRegisterOffset);
+}
+
+static inline
+void DAC960_LA_DisableInterrupts(void __iomem *base)
+{
+	unsigned char odb = 0xFF;
+
+	odb |= DAC960_LA_IRQMASK_DISABLE_IRQ;
+	writeb(odb, base + DAC960_LA_InterruptMaskRegisterOffset);
+}
+
+static inline
+bool DAC960_LA_InterruptsEnabledP(void __iomem *base)
+{
+	unsigned char imask =
+		readb(base + DAC960_LA_InterruptMaskRegisterOffset);
+	return !(imask & DAC960_LA_IRQMASK_DISABLE_IRQ);
+}
+
+static inline
+void DAC960_LA_WriteCommandMailbox(union myrb_cmd_mbox *mem_mbox,
+				   union myrb_cmd_mbox *mbox)
+{
+	mem_mbox->Words[1] = mbox->Words[1];
+	mem_mbox->Words[2] = mbox->Words[2];
+	mem_mbox->Words[3] = mbox->Words[3];
+	wmb();
+	mem_mbox->Words[0] = mbox->Words[0];
+	mb();
+}
+
+static inline
+void DAC960_LA_WriteHardwareMailbox(void __iomem *base,
+				    union myrb_cmd_mbox *mbox)
+{
+	writel(mbox->Words[0],
+	       base + DAC960_LA_CommandOpcodeRegisterOffset);
+	writel(mbox->Words[1],
+	       base + DAC960_LA_MailboxRegister4Offset);
+	writel(mbox->Words[2],
+	       base + DAC960_LA_MailboxRegister8Offset);
+	writeb(mbox->Bytes[12],
+	       base + DAC960_LA_MailboxRegister12Offset);
+}
+
+static inline unsigned char
+DAC960_LA_ReadStatusCommandIdentifier(void __iomem *base)
+{
+	return readb(base + DAC960_LA_StatusCommandIdentifierRegOffset);
+}
+
+static inline unsigned short
+DAC960_LA_ReadStatusRegister(void __iomem *base)
+{
+	return readw(base + DAC960_LA_StatusRegisterOffset);
+}
+
+static inline bool
+DAC960_LA_ReadErrorStatus(void __iomem *base,
+			  unsigned char *ErrorStatus,
+			  unsigned char *Parameter0,
+			  unsigned char *Parameter1)
+{
+	unsigned char errsts =
+		readb(base + DAC960_LA_ErrorStatusRegisterOffset);
+	if (!(errsts & DAC960_LA_ERRSTS_PENDING))
+		return false;
+	errsts &= ~DAC960_LA_ERRSTS_PENDING;
+
+	*ErrorStatus = errsts;
+	*Parameter0 =
+		readb(base + DAC960_LA_CommandOpcodeRegisterOffset);
+	*Parameter1 =
+		readb(base + DAC960_LA_CommandIdentifierRegisterOffset);
+	writeb(0xFF, base + DAC960_LA_ErrorStatusRegisterOffset);
+	return true;
+}
+
+static inline unsigned short
+DAC960_LA_MailboxInit(struct pci_dev *pdev, void __iomem *base,
+		      union myrb_cmd_mbox *mbox)
+{
+	unsigned short status;
+	int timeout = 0;
+
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (!DAC960_LA_HardwareMailboxFullP(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (DAC960_LA_HardwareMailboxFullP(base)) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for empty mailbox\n");
+		return DAC960_V1_SubsystemTimeout;
+	}
+	DAC960_LA_WriteHardwareMailbox(base, mbox);
+	DAC960_LA_HardwareMailboxNewCommand(base);
+	timeout = 0;
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_LA_HardwareMailboxStatusAvailableP(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (!DAC960_LA_HardwareMailboxStatusAvailableP(base)) {
+		dev_err(&pdev->dev, "Timeout waiting for mailbox status\n");
+		return DAC960_V1_SubsystemTimeout;
+	}
+	status = DAC960_LA_ReadStatusRegister(base);
+	DAC960_LA_AcknowledgeHardwareMailboxInterrupt(base);
+	DAC960_LA_AcknowledgeHardwareMailboxStatus(base);
+
+	return status;
+}
+
+static int DAC960_LA_HardwareInit(struct pci_dev *pdev,
+				  struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	DAC960_LA_DisableInterrupts(base);
+	DAC960_LA_AcknowledgeHardwareMailboxStatus(base);
+	udelay(1000);
+	timeout = 0;
+	while (DAC960_LA_InitializationInProgressP(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_LA_ReadErrorStatus(base, &error,
+					      &parm0, &parm1) &&
+		    myrb_err_status(cb, error, parm0, parm1))
+			return -ENODEV;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRB_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrb_enable_mmio(cb, DAC960_LA_MailboxInit)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_LA_ControllerReset(base);
+		return -ENODEV;
+	}
+	DAC960_LA_EnableInterrupts(base);
+	cb->qcmd = myrb_qcmd;
+	cb->write_cmd_mbox = DAC960_LA_WriteCommandMailbox;
+	if (cb->dual_mode_interface)
+		cb->get_cmd_mbox = DAC960_LA_MemoryMailboxNewCommand;
+	else
+		cb->get_cmd_mbox = DAC960_LA_HardwareMailboxNewCommand;
+	cb->disable_intr = DAC960_LA_DisableInterrupts;
+	cb->reset = DAC960_LA_ControllerReset;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_LA_InterruptHandler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	struct myrb_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	DAC960_LA_AcknowledgeInterrupt(base);
+	next_stat_mbox = cb->next_stat_mbox;
+	while (next_stat_mbox->valid) {
+		unsigned char id = next_stat_mbox->id;
+		struct scsi_cmnd *scmd = NULL;
+		struct myrb_cmdblk *cmd_blk = NULL;
+
+		if (id == MYRB_DCMD_TAG)
+			cmd_blk = &cb->dcmd_blk;
+		else if (id == MYRB_MCMD_TAG)
+			cmd_blk = &cb->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cb->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk)
+			cmd_blk->status = next_stat_mbox->status;
+		else
+			dev_err(&cb->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		memset(next_stat_mbox, 0, sizeof(struct myrb_stat_mbox));
+		if (++next_stat_mbox > cb->last_stat_mbox)
+			next_stat_mbox = cb->first_stat_mbox;
+
+		if (id < 3)
+			myrb_handle_cmdblk(cb, cmd_blk);
+		else
+			myrb_handle_scsi(cb, cmd_blk, scmd);
+	}
+	cb->next_stat_mbox = next_stat_mbox;
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrb_privdata DAC960_LA_privdata = {
+	.HardwareInit =		DAC960_LA_HardwareInit,
+	.InterruptHandler =	DAC960_LA_InterruptHandler,
+	.MemoryWindowSize =	DAC960_LA_RegisterWindowSize,
+};
+
+/*
+ * DAC960 PG Series Controllers
+ */
+static inline
+void DAC960_PG_HardwareMailboxNewCommand(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_HWMBOX_NEW_CMD,
+	       base + DAC960_PG_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PG_AcknowledgeHardwareMailboxStatus(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_HWMBOX_ACK_STS,
+	       base + DAC960_PG_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PG_GenerateInterrupt(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_GEN_IRQ,
+	       base + DAC960_PG_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PG_ControllerReset(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_CTRL_RESET,
+	       base + DAC960_PG_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PG_MemoryMailboxNewCommand(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_MMBOX_NEW_CMD,
+	       base + DAC960_PG_InboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_PG_HardwareMailboxFullP(void __iomem *base)
+{
+	unsigned char idb =
+		readl(base + DAC960_PG_InboundDoorBellRegisterOffset);
+	return idb & DAC960_PG_IDB_HWMBOX_FULL;
+}
+
+static inline
+bool DAC960_PG_InitializationInProgressP(void __iomem *base)
+{
+	unsigned char idb =
+		readl(base + DAC960_PG_InboundDoorBellRegisterOffset);
+	return idb & DAC960_PG_IDB_INIT_IN_PROGRESS;
+}
+
+static inline
+void DAC960_PG_AcknowledgeHardwareMailboxInterrupt(void __iomem *base)
+{
+	writel(DAC960_PG_ODB_HWMBOX_ACK_IRQ,
+	       base + DAC960_PG_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PG_AcknowledgeMemoryMailboxInterrupt(void __iomem *base)
+{
+	writel(DAC960_PG_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_PG_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PG_AcknowledgeInterrupt(void __iomem *base)
+{
+	writel(DAC960_PG_ODB_HWMBOX_ACK_IRQ | DAC960_PG_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_PG_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_PG_HardwareMailboxStatusAvailableP(void __iomem *base)
+{
+	unsigned char odb =
+		readl(base + DAC960_PG_OutboundDoorBellRegisterOffset);
+	return odb & DAC960_PG_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline
+bool DAC960_PG_MemoryMailboxStatusAvailableP(void __iomem *base)
+{
+	unsigned char odb =
+		readl(base + DAC960_PG_OutboundDoorBellRegisterOffset);
+	return odb & DAC960_PG_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline
+void DAC960_PG_EnableInterrupts(void __iomem *base)
+{
+	unsigned int imask = (unsigned int)-1;
+
+	imask &= ~DAC960_PG_IRQMASK_DISABLE_IRQ;
+	writel(imask, base + DAC960_PG_InterruptMaskRegisterOffset);
+}
+
+static inline
+void DAC960_PG_DisableInterrupts(void __iomem *base)
+{
+	unsigned int imask = (unsigned int)-1;
+
+	writel(imask, base + DAC960_PG_InterruptMaskRegisterOffset);
+}
+
+static inline
+bool DAC960_PG_InterruptsEnabledP(void __iomem *base)
+{
+	unsigned int imask =
+		readl(base + DAC960_PG_InterruptMaskRegisterOffset);
+	return !(imask & DAC960_PG_IRQMASK_DISABLE_IRQ);
+}
+
+static inline
+void DAC960_PG_WriteCommandMailbox(union myrb_cmd_mbox *mem_mbox,
+				   union myrb_cmd_mbox *mbox)
+{
+	mem_mbox->Words[1] = mbox->Words[1];
+	mem_mbox->Words[2] = mbox->Words[2];
+	mem_mbox->Words[3] = mbox->Words[3];
+	wmb();
+	mem_mbox->Words[0] = mbox->Words[0];
+	mb();
+}
+
+static inline
+void DAC960_PG_WriteHardwareMailbox(void __iomem *base,
+				    union myrb_cmd_mbox *mbox)
+{
+	writel(mbox->Words[0],
+	       base + DAC960_PG_CommandOpcodeRegisterOffset);
+	writel(mbox->Words[1],
+	       base + DAC960_PG_MailboxRegister4Offset);
+	writel(mbox->Words[2],
+	       base + DAC960_PG_MailboxRegister8Offset);
+	writeb(mbox->Bytes[12],
+	       base + DAC960_PG_MailboxRegister12Offset);
+}
+
+static inline unsigned char
+DAC960_PG_ReadStatusCommandIdentifier(void __iomem *base)
+{
+	return readb(base + DAC960_PG_StatusCommandIdentifierRegOffset);
+}
+
+static inline unsigned short
+DAC960_PG_ReadStatusRegister(void __iomem *base)
+{
+	return readw(base + DAC960_PG_StatusRegisterOffset);
+}
+
+static inline bool
+DAC960_PG_ReadErrorStatus(void __iomem *base,
+			  unsigned char *ErrorStatus,
+			  unsigned char *Parameter0,
+			  unsigned char *Parameter1)
+{
+	unsigned char errsts =
+		readb(base + DAC960_PG_ErrorStatusRegisterOffset);
+	if (!(errsts & DAC960_PG_ERRSTS_PENDING))
+		return false;
+	errsts &= ~DAC960_PG_ERRSTS_PENDING;
+	*ErrorStatus = errsts;
+	*Parameter0 = readb(base + DAC960_PG_CommandOpcodeRegisterOffset);
+	*Parameter1 = readb(base + DAC960_PG_CommandIdentifierRegisterOffset);
+	writeb(0, base + DAC960_PG_ErrorStatusRegisterOffset);
+	return true;
+}
+
+static inline unsigned short
+DAC960_PG_MailboxInit(struct pci_dev *pdev, void __iomem *base,
+		      union myrb_cmd_mbox *mbox)
+{
+	unsigned short status;
+	int timeout = 0;
+
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (!DAC960_PG_HardwareMailboxFullP(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (DAC960_PG_HardwareMailboxFullP(base)) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for empty mailbox\n");
+		return DAC960_V1_SubsystemTimeout;
+	}
+	DAC960_PG_WriteHardwareMailbox(base, mbox);
+	DAC960_PG_HardwareMailboxNewCommand(base);
+
+	timeout = 0;
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PG_HardwareMailboxStatusAvailableP(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (!DAC960_PG_HardwareMailboxStatusAvailableP(base)) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for mailbox status\n");
+		return DAC960_V1_SubsystemTimeout;
+	}
+	status = DAC960_PG_ReadStatusRegister(base);
+	DAC960_PG_AcknowledgeHardwareMailboxInterrupt(base);
+	DAC960_PG_AcknowledgeHardwareMailboxStatus(base);
+
+	return status;
+}
+
+static int DAC960_PG_HardwareInit(struct pci_dev *pdev,
+				  struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	DAC960_PG_DisableInterrupts(base);
+	DAC960_PG_AcknowledgeHardwareMailboxStatus(base);
+	udelay(1000);
+	while (DAC960_PG_InitializationInProgressP(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PG_ReadErrorStatus(base, &error,
+					      &parm0, &parm1) &&
+		    myrb_err_status(cb, error, parm0, parm1))
+			return -EIO;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRB_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrb_enable_mmio(cb, DAC960_PG_MailboxInit)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_PG_ControllerReset(base);
+		return -ENODEV;
+	}
+	DAC960_PG_EnableInterrupts(base);
+	cb->qcmd = myrb_qcmd;
+	cb->write_cmd_mbox = DAC960_PG_WriteCommandMailbox;
+	if (cb->dual_mode_interface)
+		cb->get_cmd_mbox = DAC960_PG_MemoryMailboxNewCommand;
+	else
+		cb->get_cmd_mbox = DAC960_PG_HardwareMailboxNewCommand;
+	cb->disable_intr = DAC960_PG_DisableInterrupts;
+	cb->reset = DAC960_PG_ControllerReset;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_PG_InterruptHandler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	struct myrb_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	DAC960_PG_AcknowledgeInterrupt(base);
+	next_stat_mbox = cb->next_stat_mbox;
+	while (next_stat_mbox->valid) {
+		unsigned char id = next_stat_mbox->id;
+		struct scsi_cmnd *scmd = NULL;
+		struct myrb_cmdblk *cmd_blk = NULL;
+
+		if (id == MYRB_DCMD_TAG)
+			cmd_blk = &cb->dcmd_blk;
+		else if (id == MYRB_MCMD_TAG)
+			cmd_blk = &cb->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cb->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk)
+			cmd_blk->status = next_stat_mbox->status;
+		else
+			dev_err(&cb->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		memset(next_stat_mbox, 0, sizeof(struct myrb_stat_mbox));
+		if (++next_stat_mbox > cb->last_stat_mbox)
+			next_stat_mbox = cb->first_stat_mbox;
+
+		if (id < 3)
+			myrb_handle_cmdblk(cb, cmd_blk);
+		else
+			myrb_handle_scsi(cb, cmd_blk, scmd);
+	}
+	cb->next_stat_mbox = next_stat_mbox;
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrb_privdata DAC960_PG_privdata = {
+	.HardwareInit =		DAC960_PG_HardwareInit,
+	.InterruptHandler =	DAC960_PG_InterruptHandler,
+	.MemoryWindowSize =	DAC960_PG_RegisterWindowSize,
+};
+
+
+/*
+ * DAC960 PD Series Controllers
+ */
+
+static inline
+void DAC960_PD_NewCommand(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_HWMBOX_NEW_CMD,
+	       base + DAC960_PD_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PD_AcknowledgeStatus(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_HWMBOX_ACK_STS,
+	       base + DAC960_PD_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PD_GenerateInterrupt(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_GEN_IRQ,
+	       base + DAC960_PD_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_PD_ControllerReset(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_CTRL_RESET,
+	       base + DAC960_PD_InboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_PD_MailboxFullP(void __iomem *base)
+{
+	unsigned char idb =
+		readb(base + DAC960_PD_InboundDoorBellRegisterOffset);
+	return idb & DAC960_PD_IDB_HWMBOX_FULL;
+}
+
+static inline
+bool DAC960_PD_InitializationInProgressP(void __iomem *base)
+{
+	unsigned char idb =
+		readb(base + DAC960_PD_InboundDoorBellRegisterOffset);
+	return idb & DAC960_PD_IDB_INIT_IN_PROGRESS;
+}
+
+static inline
+void DAC960_PD_AcknowledgeInterrupt(void __iomem *base)
+{
+	writeb(DAC960_PD_ODB_HWMBOX_ACK_IRQ,
+	       base + DAC960_PD_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_PD_StatusAvailableP(void __iomem *base)
+{
+	unsigned char odb =
+		readb(base + DAC960_PD_OutboundDoorBellRegisterOffset);
+	return odb & DAC960_PD_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline
+void DAC960_PD_EnableInterrupts(void __iomem *base)
+{
+	writeb(DAC960_PD_IRQMASK_ENABLE_IRQ,
+	       base + DAC960_PD_InterruptEnableRegisterOffset);
+}
+
+static inline
+void DAC960_PD_DisableInterrupts(void __iomem *base)
+{
+	writeb(0, base + DAC960_PD_InterruptEnableRegisterOffset);
+}
+
+static inline
+bool DAC960_PD_InterruptsEnabledP(void __iomem *base)
+{
+	unsigned char imask =
+		readb(base + DAC960_PD_InterruptEnableRegisterOffset);
+	return imask & DAC960_PD_IRQMASK_ENABLE_IRQ;
+}
+
+static inline
+void DAC960_PD_WriteCommandMailbox(void __iomem *base,
+				   union myrb_cmd_mbox *mbox)
+{
+	writel(mbox->Words[0],
+	       base + DAC960_PD_CommandOpcodeRegisterOffset);
+	writel(mbox->Words[1],
+	       base + DAC960_PD_MailboxRegister4Offset);
+	writel(mbox->Words[2],
+	       base + DAC960_PD_MailboxRegister8Offset);
+	writeb(mbox->Bytes[12],
+	       base + DAC960_PD_MailboxRegister12Offset);
+}
+
+static inline unsigned char
+DAC960_PD_ReadStatusCommandIdentifier(void __iomem *base)
+{
+	return readb(base + DAC960_PD_StatusCommandIdentifierRegOffset);
+}
+
+static inline unsigned short
+DAC960_PD_ReadStatusRegister(void __iomem *base)
+{
+	return readw(base + DAC960_PD_StatusRegisterOffset);
+}
+
+static inline bool
+DAC960_PD_ReadErrorStatus(void __iomem *base,
+			  unsigned char *ErrorStatus,
+			  unsigned char *Parameter0,
+			  unsigned char *Parameter1)
+{
+	unsigned char errsts =
+		readb(base + DAC960_PD_ErrorStatusRegisterOffset);
+	if (!(errsts & DAC960_PD_ERRSTS_PENDING))
+		return false;
+	errsts &= ~DAC960_PD_ERRSTS_PENDING;
+	*ErrorStatus = errsts;
+	*Parameter0 = readb(base + DAC960_PD_CommandOpcodeRegisterOffset);
+	*Parameter1 = readb(base + DAC960_PD_CommandIdentifierRegisterOffset);
+	writeb(0, base + DAC960_PD_ErrorStatusRegisterOffset);
+	return true;
+}
+
+static void DAC960_PD_QueueCommand(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	void __iomem *base = cb->io_base;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+
+	while (DAC960_PD_MailboxFullP(base))
+		udelay(1);
+	DAC960_PD_WriteCommandMailbox(base, mbox);
+	DAC960_PD_NewCommand(base);
+}
+
+
+static int DAC960_PD_HardwareInit(struct pci_dev *pdev,
+				  struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	if (!request_region(cb->io_addr, 0x80, "myrb")) {
+		dev_err(&pdev->dev, "IO port 0x%lx busy\n",
+			(unsigned long)cb->io_addr);
+		return -EBUSY;
+	}
+	DAC960_PD_DisableInterrupts(base);
+	DAC960_PD_AcknowledgeStatus(base);
+	udelay(1000);
+	while (DAC960_PD_InitializationInProgressP(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PD_ReadErrorStatus(base, &error,
+					      &parm0, &parm1) &&
+		    myrb_err_status(cb, error, parm0, parm1))
+			return -EIO;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRB_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrb_enable_mmio(cb, NULL)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_PD_ControllerReset(base);
+		return -ENODEV;
+	}
+	DAC960_PD_EnableInterrupts(base);
+	cb->qcmd = DAC960_PD_QueueCommand;
+	cb->disable_intr = DAC960_PD_DisableInterrupts;
+	cb->reset = DAC960_PD_ControllerReset;
+
+	return 0;
+}
+
+
+static irqreturn_t DAC960_PD_InterruptHandler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	while (DAC960_PD_StatusAvailableP(base)) {
+		unsigned char id = DAC960_PD_ReadStatusCommandIdentifier(base);
+		struct scsi_cmnd *scmd = NULL;
+		struct myrb_cmdblk *cmd_blk = NULL;
+
+		if (id == MYRB_DCMD_TAG)
+			cmd_blk = &cb->dcmd_blk;
+		else if (id == MYRB_MCMD_TAG)
+			cmd_blk = &cb->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cb->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk)
+			cmd_blk->status = DAC960_PD_ReadStatusRegister(base);
+		else
+			dev_err(&cb->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		DAC960_PD_AcknowledgeInterrupt(base);
+		DAC960_PD_AcknowledgeStatus(base);
+
+		if (id < 3)
+			myrb_handle_cmdblk(cb, cmd_blk);
+		else
+			myrb_handle_scsi(cb, cmd_blk, scmd);
+	}
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrb_privdata DAC960_PD_privdata = {
+	.HardwareInit =		DAC960_PD_HardwareInit,
+	.InterruptHandler =	DAC960_PD_InterruptHandler,
+	.MemoryWindowSize =	DAC960_PD_RegisterWindowSize,
+};
+
+
+/*
+ * DAC960 P Series Controllers
+ *
+ * Similar to the DAC960 PD Series Controllers, but some commands have
+ * to be translated.
+ */
+
+static inline void DAC960_P_To_PD_TranslateEnquiry(void *Enquiry)
+{
+	memcpy(Enquiry + 132, Enquiry + 36, 64);
+	memset(Enquiry + 36, 0, 96);
+}
+
+static inline void DAC960_P_To_PD_TranslateDeviceState(void *DeviceState)
+{
+	memcpy(DeviceState + 2, DeviceState + 3, 1);
+	memmove(DeviceState + 4, DeviceState + 5, 2);
+	memmove(DeviceState + 6, DeviceState + 8, 4);
+}
+
+static inline
+void DAC960_PD_To_P_TranslateReadWriteCommand(struct myrb_cmdblk *cmd_blk)
+{
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	int ldev_num = mbox->Type5.LD.ldev_num;
+
+	mbox->Bytes[3] &= 0x7;
+	mbox->Bytes[3] |= mbox->Bytes[7] << 6;
+	mbox->Bytes[7] = ldev_num;
+}
+
+static inline
+void DAC960_P_To_PD_TranslateReadWriteCommand(struct myrb_cmdblk *cmd_blk)
+{
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	int ldev_num = mbox->Bytes[7];
+
+	mbox->Bytes[7] = mbox->Bytes[3] >> 6;
+	mbox->Bytes[3] &= 0x7;
+	mbox->Bytes[3] |= ldev_num << 3;
+}
+
+static void DAC960_P_QueueCommand(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	void __iomem *base = cb->io_base;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+
+	switch (mbox->Common.opcode) {
+	case DAC960_V1_Enquiry:
+		mbox->Common.opcode = DAC960_V1_Enquiry_Old;
+		break;
+	case DAC960_V1_GetDeviceState:
+		mbox->Common.opcode = DAC960_V1_GetDeviceState_Old;
+		break;
+	case DAC960_V1_Read:
+		mbox->Common.opcode = DAC960_V1_Read_Old;
+		DAC960_PD_To_P_TranslateReadWriteCommand(cmd_blk);
+		break;
+	case DAC960_V1_Write:
+		mbox->Common.opcode = DAC960_V1_Write_Old;
+		DAC960_PD_To_P_TranslateReadWriteCommand(cmd_blk);
+		break;
+	case DAC960_V1_ReadWithScatterGather:
+		mbox->Common.opcode = DAC960_V1_ReadWithScatterGather_Old;
+		DAC960_PD_To_P_TranslateReadWriteCommand(cmd_blk);
+		break;
+	case DAC960_V1_WriteWithScatterGather:
+		mbox->Common.opcode = DAC960_V1_WriteWithScatterGather_Old;
+		DAC960_PD_To_P_TranslateReadWriteCommand(cmd_blk);
+		break;
+	default:
+		break;
+	}
+	while (DAC960_PD_MailboxFullP(base))
+		udelay(1);
+	DAC960_PD_WriteCommandMailbox(base, mbox);
+	DAC960_PD_NewCommand(base);
+}
+
+
+static int DAC960_P_HardwareInit(struct pci_dev *pdev,
+				 struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	if (!request_region(cb->io_addr, 0x80, "myrb")){
+		dev_err(&pdev->dev, "IO port 0x%lx busy\n",
+			(unsigned long)cb->io_addr);
+		return -EBUSY;
+	}
+	DAC960_PD_DisableInterrupts(base);
+	DAC960_PD_AcknowledgeStatus(base);
+	udelay(1000);
+	while (DAC960_PD_InitializationInProgressP(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PD_ReadErrorStatus(base, &error,
+					      &parm0, &parm1) &&
+		    myrb_err_status(cb, error, parm0, parm1))
+			return -EAGAIN;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRB_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrb_enable_mmio(cb, NULL)) {
+		dev_err(&pdev->dev,
+			"Unable to allocate DMA mapped memory\n");
+		DAC960_PD_ControllerReset(base);
+		return -ETIMEDOUT;
+	}
+	DAC960_PD_EnableInterrupts(base);
+	cb->qcmd = DAC960_P_QueueCommand;
+	cb->disable_intr = DAC960_PD_DisableInterrupts;
+	cb->reset = DAC960_PD_ControllerReset;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_P_InterruptHandler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	while (DAC960_PD_StatusAvailableP(base)) {
+		unsigned char id = DAC960_PD_ReadStatusCommandIdentifier(base);
+		struct scsi_cmnd *scmd = NULL;
+		struct myrb_cmdblk *cmd_blk = NULL;
+		union myrb_cmd_mbox *mbox;
+		enum myrb_cmd_opcode op;
+
+
+		if (id == MYRB_DCMD_TAG)
+			cmd_blk = &cb->dcmd_blk;
+		else if (id == MYRB_MCMD_TAG)
+			cmd_blk = &cb->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cb->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk)
+			cmd_blk->status
+				= DAC960_PD_ReadStatusRegister(base);
+		else
+			dev_err(&cb->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		DAC960_PD_AcknowledgeInterrupt(base);
+		DAC960_PD_AcknowledgeStatus(base);
+
+		if (!cmd_blk)
+			continue;
+
+		mbox = &cmd_blk->mbox;
+		op = mbox->Common.opcode;
+		switch (op) {
+		case DAC960_V1_Enquiry_Old:
+			mbox->Common.opcode = DAC960_V1_Enquiry;
+			DAC960_P_To_PD_TranslateEnquiry(cb->enquiry);
+			break;
+		case DAC960_V1_Read_Old:
+			mbox->Common.opcode = DAC960_V1_Read;
+			DAC960_P_To_PD_TranslateReadWriteCommand(cmd_blk);
+			break;
+		case DAC960_V1_Write_Old:
+			mbox->Common.opcode = DAC960_V1_Write;
+			DAC960_P_To_PD_TranslateReadWriteCommand(cmd_blk);
+			break;
+		case DAC960_V1_ReadWithScatterGather_Old:
+			mbox->Common.opcode = DAC960_V1_ReadWithScatterGather;
+			DAC960_P_To_PD_TranslateReadWriteCommand(cmd_blk);
+			break;
+		case DAC960_V1_WriteWithScatterGather_Old:
+			mbox->Common.opcode = DAC960_V1_WriteWithScatterGather;
+			DAC960_P_To_PD_TranslateReadWriteCommand(cmd_blk);
+			break;
+		default:
+			break;
+		}
+		if (id < 3)
+			myrb_handle_cmdblk(cb, cmd_blk);
+		else
+			myrb_handle_scsi(cb, cmd_blk, scmd);
+	}
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrb_privdata DAC960_P_privdata = {
+	.HardwareInit =		DAC960_P_HardwareInit,
+	.InterruptHandler =	DAC960_P_InterruptHandler,
+	.MemoryWindowSize =	DAC960_PD_RegisterWindowSize,
+};
+
+static struct myrb_hba *
+myrb_detect(struct pci_dev *pdev, const struct pci_device_id *entry)
+{
+	struct myrb_privdata *privdata =
+		(struct myrb_privdata *)entry->driver_data;
+	irq_handler_t InterruptHandler = privdata->InterruptHandler;
+	unsigned int mmio_size = privdata->MemoryWindowSize;
+	struct Scsi_Host *shost;
+	struct myrb_hba *cb = NULL;
+
+	shost = scsi_host_alloc(&myrb_template, sizeof(struct myrb_hba));
+	if (!shost) {
+		dev_err(&pdev->dev, "Unable to allocate Controller\n");
+		return NULL;
+	}
+	shost->max_cmd_len = 12;
+	shost->max_lun = 256;
+	cb = shost_priv(shost);
+	mutex_init(&cb->dcmd_mutex);
+	mutex_init(&cb->dma_mutex);
+	cb->pdev = pdev;
+
+	if (pci_enable_device(pdev))
+		goto Failure;
+
+	if (privdata->HardwareInit == DAC960_PD_HardwareInit ||
+	    privdata->HardwareInit == DAC960_P_HardwareInit) {
+		cb->io_addr = pci_resource_start(pdev, 0);
+		cb->pci_addr = pci_resource_start(pdev, 1);
+	} else
+		cb->pci_addr = pci_resource_start(pdev, 0);
+
+	pci_set_drvdata(pdev, cb);
+	spin_lock_init(&cb->queue_lock);
+	/*
+	  Map the Controller Register Window.
+	*/
+	if (mmio_size < PAGE_SIZE)
+		mmio_size = PAGE_SIZE;
+	cb->mmio_base = ioremap_nocache(cb->pci_addr & PAGE_MASK, mmio_size);
+	if (cb->mmio_base == NULL) {
+		dev_err(&pdev->dev,
+			"Unable to map Controller Register Window\n");
+		goto Failure;
+	}
+
+	cb->io_base = cb->mmio_base + (cb->pci_addr & ~PAGE_MASK);
+	if (privdata->HardwareInit(pdev, cb, cb->io_base))
+		goto Failure;
+
+	/*
+	  Acquire shared access to the IRQ Channel.
+	*/
+	if (request_irq(pdev->irq, InterruptHandler, IRQF_SHARED,
+			"myrb", cb) < 0) {
+		dev_err(&pdev->dev,
+			"Unable to acquire IRQ Channel %d\n", pdev->irq);
+		goto Failure;
+	}
+	cb->irq = pdev->irq;
+	return cb;
+
+Failure:
+	dev_err(&pdev->dev,
+		"Failed to initialize Controller\n");
+	myrb_cleanup(cb);
+	return NULL;
+}
+
+static int
+myrb_probe(struct pci_dev *dev, const struct pci_device_id *entry)
+{
+	struct myrb_hba *cb;
+	int ret;
+
+	cb = myrb_detect(dev, entry);
+	if (!cb)
+		return -ENODEV;
+
+	ret = myrb_get_hba_config(cb);
+	if (ret < 0) {
+		myrb_cleanup(cb);
+		return ret;
+	}
+
+	if (!myrb_create_mempools(dev, cb)) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	ret = scsi_add_host(cb->host, &dev->dev);
+	if (ret) {
+		dev_err(&dev->dev, "scsi_add_host failed with %d\n", ret);
+		myrb_destroy_mempools(cb);
+		goto failed;
+	}
+	scsi_scan_host(cb->host);
+	return 0;
+failed:
+	myrb_cleanup(cb);
+	return ret;
+}
+
+
+static void myrb_remove(struct pci_dev *pdev)
+{
+	struct myrb_hba *cb = pci_get_drvdata(pdev);
+
+	shost_printk(KERN_NOTICE, cb->host, "Flushing Cache...");
+	myrb_exec_type3(cb, DAC960_V1_Flush, 0);
+	myrb_cleanup(cb);
+	myrb_destroy_mempools(cb);
+}
+
+
+static const struct pci_device_id myrb_id_table[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_DEC,
+		.device		= PCI_DEVICE_ID_DEC_21285,
+		.subvendor	= PCI_SUBVENDOR_ID_MYLEX,
+		.subdevice	= PCI_SUBDEVICE_ID_MYLEX_DAC960_LA,
+		.driver_data	= (unsigned long) &DAC960_LA_privdata,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_PG,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_PG_privdata,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_PD,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_PD_privdata,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_P,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_P_privdata,
+	},
+	{0, },
+};
+
+MODULE_DEVICE_TABLE(pci, myrb_id_table);
+
+static struct pci_driver myrb_pci_driver = {
+	.name		= "myrb",
+	.id_table	= myrb_id_table,
+	.probe		= myrb_probe,
+	.remove		= myrb_remove,
+};
+
+static int __init myrb_init_module(void)
+{
+	int ret;
+
+	myrb_raid_template = raid_class_attach(&myrb_raid_functions);
+	if (!myrb_raid_template)
+		return -ENODEV;
+
+	ret = pci_register_driver(&myrb_pci_driver);
+	if (ret)
+		raid_class_release(myrb_raid_template);
+
+	return ret;
+}
+
+static void __exit myrb_cleanup_module(void)
+{
+	pci_unregister_driver(&myrb_pci_driver);
+	raid_class_release(myrb_raid_template);
+}
+
+module_init(myrb_init_module);
+module_exit(myrb_cleanup_module);
+
+MODULE_DESCRIPTION("Mylex DAC960/AcceleRAID/eXtremeRAID driver (Block interface)");
+MODULE_AUTHOR("Hannes Reinecke <hare@suse.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/myrb.h b/drivers/scsi/myrb.h
new file mode 100644
index 000000000000..a71a981df283
--- /dev/null
+++ b/drivers/scsi/myrb.h
@@ -0,0 +1,970 @@
+/*
+ * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
+ *
+ * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
+ *
+ * Based on the original DAC960 driver,
+ * Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
+ * Portions Copyright 2002 by Mylex (An IBM Business Unit)
+ *
+ * This program is free software; you may redistribute and/or modify it under
+ * the terms of the GNU General Public License Version 2 as published by the
+ *  Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY, without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for complete details.
+ *
+ */
+
+#ifndef MYRB_H
+#define MYRB_H
+
+#define MYRB_MAX_LDEVS				32
+#define DAC960_V1_MaxChannels			3
+#define DAC960_V1_MaxTargets			16
+#define DAC960_V1_MaxPhysicalDevices		45
+#define DAC960_V1_ScatterGatherLimit		32
+#define DAC960_V1_CommandMailboxCount		256
+#define DAC960_V1_StatusMailboxCount		1024
+
+#define MYRB_BLKSIZE_BITS			9
+#define MYRB_MAILBOX_TIMEOUT 1000000
+
+#define MYRB_DCMD_TAG 1
+#define MYRB_MCMD_TAG 2
+
+#define MYRB_PRIMARY_MONITOR_INTERVAL (10 * HZ)
+#define MYRB_SECONDARY_MONITOR_INTERVAL (60 * HZ)
+
+/*
+ * DAC960 V1 Firmware Command Opcodes.
+ */
+enum myrb_cmd_opcode {
+	/* I/O Commands */
+	DAC960_V1_ReadExtended =			0x33,
+	DAC960_V1_WriteExtended =			0x34,
+	DAC960_V1_ReadAheadExtended =			0x35,
+	DAC960_V1_ReadExtendedWithScatterGather =	0xB3,
+	DAC960_V1_WriteExtendedWithScatterGather =	0xB4,
+	DAC960_V1_Read =				0x36,
+	DAC960_V1_ReadWithScatterGather =		0xB6,
+	DAC960_V1_Write =				0x37,
+	DAC960_V1_WriteWithScatterGather =		0xB7,
+	DAC960_V1_DCDB =				0x04,
+	DAC960_V1_DCDBWithScatterGather =		0x84,
+	DAC960_V1_Flush =				0x0A,
+	/* Controller Status Related Commands */
+	DAC960_V1_Enquiry =				0x53,
+	DAC960_V1_Enquiry2 =				0x1C,
+	DAC960_V1_GetLogicalDriveElement =		0x55,
+	DAC960_V1_GetLogicalDeviceInfo =		0x19,
+	DAC960_V1_IOPortRead =				0x39,
+	DAC960_V1_IOPortWrite =				0x3A,
+	DAC960_V1_GetSDStats =				0x3E,
+	DAC960_V1_GetPDStats =				0x3F,
+	DAC960_V1_PerformEventLogOperation =		0x72,
+	/* Device Related Commands */
+	DAC960_V1_StartDevice =				0x10,
+	DAC960_V1_GetDeviceState =			0x50,
+	DAC960_V1_StopChannel =				0x13,
+	DAC960_V1_StartChannel =			0x12,
+	DAC960_V1_ResetChannel =			0x1A,
+	/* Commands Associated with Data Consistency and Errors */
+	DAC960_V1_Rebuild =				0x09,
+	DAC960_V1_RebuildAsync =			0x16,
+	DAC960_V1_CheckConsistency =			0x0F,
+	DAC960_V1_CheckConsistencyAsync =		0x1E,
+	DAC960_V1_RebuildStat =				0x0C,
+	DAC960_V1_GetRebuildProgress =			0x27,
+	DAC960_V1_RebuildControl =			0x1F,
+	DAC960_V1_ReadBadBlockTable =			0x0B,
+	DAC960_V1_ReadBadDataTable =			0x25,
+	DAC960_V1_ClearBadDataTable =			0x26,
+	DAC960_V1_GetErrorTable =			0x17,
+	DAC960_V1_AddCapacityAsync =			0x2A,
+	DAC960_V1_BackgroundInitializationControl =	0x2B,
+	/* Configuration Related Commands */
+	DAC960_V1_ReadConfig2 =				0x3D,
+	DAC960_V1_WriteConfig2 =			0x3C,
+	DAC960_V1_ReadConfigurationOnDisk =		0x4A,
+	DAC960_V1_WriteConfigurationOnDisk =		0x4B,
+	DAC960_V1_ReadConfiguration =			0x4E,
+	DAC960_V1_ReadBackupConfiguration =		0x4D,
+	DAC960_V1_WriteConfiguration =			0x4F,
+	DAC960_V1_AddConfiguration =			0x4C,
+	DAC960_V1_ReadConfigurationLabel =		0x48,
+	DAC960_V1_WriteConfigurationLabel =		0x49,
+	/* Firmware Upgrade Related Commands */
+	DAC960_V1_LoadImage =				0x20,
+	DAC960_V1_StoreImage =				0x21,
+	DAC960_V1_ProgramImage =			0x22,
+	/* Diagnostic Commands */
+	DAC960_V1_SetDiagnosticMode =			0x31,
+	DAC960_V1_RunDiagnostic =			0x32,
+	/* Subsystem Service Commands */
+	DAC960_V1_GetSubsystemData =			0x70,
+	DAC960_V1_SetSubsystemParameters =		0x71,
+	/* Version 2.xx Firmware Commands */
+	DAC960_V1_Enquiry_Old =				0x05,
+	DAC960_V1_GetDeviceState_Old =			0x14,
+	DAC960_V1_Read_Old =				0x02,
+	DAC960_V1_Write_Old =				0x03,
+	DAC960_V1_ReadWithScatterGather_Old =		0x82,
+	DAC960_V1_WriteWithScatterGather_Old =		0x83
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V1 Firmware Command Status Codes.
+ */
+#define DAC960_V1_NormalCompletion		0x0000	/* Common */
+#define DAC960_V1_CheckConditionReceived	0x0002	/* Common */
+#define DAC960_V1_NoDeviceAtAddress		0x0102	/* Common */
+#define DAC960_V1_InvalidDeviceAddress		0x0105	/* Common */
+#define DAC960_V1_InvalidParameter		0x0105	/* Common */
+#define DAC960_V1_IrrecoverableDataError	0x0001	/* I/O */
+#define DAC960_V1_LogicalDriveNonexistentOrOffline 0x0002 /* I/O */
+#define DAC960_V1_AccessBeyondEndOfLogicalDrive	0x0105	/* I/O */
+#define DAC960_V1_BadDataEncountered		0x010C	/* I/O */
+#define DAC960_V1_DeviceBusy			0x0008	/* DCDB */
+#define DAC960_V1_DeviceNonresponsive		0x000E	/* DCDB */
+#define DAC960_V1_CommandTerminatedAbnormally	0x000F	/* DCDB */
+#define DAC960_V1_UnableToStartDevice		0x0002	/* Device */
+#define DAC960_V1_InvalidChannelOrTargetOrModifier 0x0105 /* Device */
+#define DAC960_V1_ChannelBusy			0x0106	/* Device */
+#define DAC960_V1_OutOfMemory			0x0107	/* Device */
+#define DAC960_V1_ChannelNotStopped		0x0002	/* Device */
+#define DAC960_V1_AttemptToRebuildOnlineDrive	0x0002	/* Consistency */
+#define DAC960_V1_RebuildBadBlocksEncountered	0x0003	/* Consistency */
+#define DAC960_V1_NewDiskFailedDuringRebuild	0x0004	/* Consistency */
+#define DAC960_V1_RebuildOrCheckAlreadyInProgress 0x0106 /* Consistency */
+#define DAC960_V1_DependentDiskIsDead		0x0002	/* Consistency */
+#define DAC960_V1_InconsistentBlocksFound	0x0003	/* Consistency */
+#define DAC960_V1_InvalidOrNonredundantLogicalDrive 0x0105 /* Consistency */
+#define DAC960_V1_NoRebuildOrCheckInProgress	0x0105	/* Consistency */
+#define DAC960_V1_RebuildInProgress_DataValid	0x0000	/* Consistency */
+#define DAC960_V1_RebuildFailed_LogicalDriveFailure 0x0002 /* Consistency */
+#define DAC960_V1_RebuildFailed_BadBlocksOnOther 0x0003	/* Consistency */
+#define DAC960_V1_RebuildFailed_NewDriveFailed	0x0004	/* Consistency */
+#define DAC960_V1_RebuildSuccessful		0x0100	/* Consistency */
+#define DAC960_V1_RebuildSuccessfullyTerminated	0x0107	/* Consistency */
+#define DAC960_V1_RebuildNotChecked		0x0108	/* Consistency */
+#define DAC960_V1_BackgroundInitSuccessful	0x0100	/* Consistency */
+#define DAC960_V1_BackgroundInitAborted		0x0005	/* Consistency */
+#define DAC960_V1_NoBackgroundInitInProgress	0x0105	/* Consistency */
+#define DAC960_V1_AddCapacityInProgress		0x0004	/* Consistency */
+#define DAC960_V1_AddCapacityFailedOrSuspended	0x00F4	/* Consistency */
+#define DAC960_V1_Config2ChecksumError		0x0002	/* Configuration */
+#define DAC960_V1_ConfigurationSuspended	0x0106	/* Configuration */
+#define DAC960_V1_FailedToConfigureNVRAM	0x0105	/* Configuration */
+#define DAC960_V1_ConfigurationNotSavedStateChange 0x0106 /* Configuration */
+#define DAC960_V1_SubsystemNotInstalled		0x0001	/* Subsystem */
+#define DAC960_V1_SubsystemFailed		0x0002	/* Subsystem */
+#define DAC960_V1_SubsystemBusy			0x0106	/* Subsystem */
+#define DAC960_V1_SubsystemTimeout		0x0108  /* Subsystem */
+
+/*
+ * DAC960 V1 Firmware Enquiry Command reply structure.
+ */
+struct myrb_enquiry
+{
+	unsigned char ldev_count;			/* Byte 0 */
+	unsigned int rsvd1:24;				/* Bytes 1-3 */
+	unsigned int ldev_sizes[32];			/* Bytes 4-131 */
+	unsigned short flash_age;			/* Bytes 132-133 */
+	struct {
+		bool deferred:1;			/* Byte 134 Bit 0 */
+		bool low_bat:1;				/* Byte 134 Bit 1 */
+		unsigned char rsvd2:6;			/* Byte 134 Bits 2-7 */
+	} status;
+	unsigned char rsvd3:8;				/* Byte 135 */
+	unsigned char fw_minor_version;			/* Byte 136 */
+	unsigned char fw_major_version;			/* Byte 137 */
+	enum {
+		DAC960_V1_NoStandbyRebuildOrCheckInProgress =		    0x00,
+		DAC960_V1_StandbyRebuildInProgress =			    0x01,
+		DAC960_V1_BackgroundRebuildInProgress =			    0x02,
+		DAC960_V1_BackgroundCheckInProgress =			    0x03,
+		DAC960_V1_StandbyRebuildCompletedWithError =		    0xFF,
+		DAC960_V1_BackgroundRebuildOrCheckFailed_DriveFailed =	    0xF0,
+		DAC960_V1_BackgroundRebuildOrCheckFailed_LogicalDriveFailed =   0xF1,
+		DAC960_V1_BackgroundRebuildOrCheckFailed_OtherCauses =	    0xF2,
+		DAC960_V1_BackgroundRebuildOrCheckSuccessfullyTerminated =	    0xF3
+	} __attribute__ ((packed)) rbld;		/* Byte 138 */
+	unsigned char max_tcq;				/* Byte 139 */
+	unsigned char ldev_offline;			/* Byte 140 */
+	unsigned char rsvd4:8;				/* Byte 141 */
+	unsigned short ev_seq;				/* Bytes 142-143 */
+	unsigned char ldev_critical;			/* Byte 144 */
+	unsigned int rsvd5:24;				/* Bytes 145-147 */
+	unsigned char pdev_dead;			/* Byte 148 */
+	unsigned char rsvd6:8;				/* Byte 149 */
+	unsigned char rbld_count;			/* Byte 150 */
+	struct {
+		unsigned char rsvd7:3;			/* Byte 151 Bits 0-2 */
+		bool bbu_present:1;			/* Byte 151 Bit 3 */
+		unsigned char rsvd8:4;			/* Byte 151 Bits 4-7 */
+	} misc;
+	struct {
+		unsigned char target;
+		unsigned char channel;
+	} dead_drives[21];				/* Bytes 152-194 */
+	unsigned char rsvd9[62];			/* Bytes 195-255 */
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V1 Firmware Enquiry2 Command reply structure.
+ */
+struct myrb_enquiry2
+{
+	struct {
+		enum {
+			DAC960_V1_P_PD_PU =			0x01,
+			DAC960_V1_PL =				0x02,
+			DAC960_V1_PG =				0x10,
+			DAC960_V1_PJ =				0x11,
+			DAC960_V1_PR =				0x12,
+			DAC960_V1_PT =				0x13,
+			DAC960_V1_PTL0 =			0x14,
+			DAC960_V1_PRL =				0x15,
+			DAC960_V1_PTL1 =			0x16,
+			DAC960_V1_1164P =			0x20
+		} __attribute__ ((packed)) SubModel;		/* Byte 0 */
+		unsigned char ActualChannels;			/* Byte 1 */
+		enum {
+			DAC960_V1_FiveChannelBoard =		0x01,
+			DAC960_V1_ThreeChannelBoard =		0x02,
+			DAC960_V1_TwoChannelBoard =		0x03,
+			DAC960_V1_ThreeChannelASIC_DAC =	0x04
+		} __attribute__ ((packed)) Model;		/* Byte 2 */
+		enum {
+			DAC960_V1_EISA_Controller =		0x01,
+			DAC960_V1_MicroChannel_Controller =	0x02,
+			DAC960_V1_PCI_Controller =		0x03,
+			DAC960_V1_SCSItoSCSI_Controller =	0x08
+		} __attribute__ ((packed)) ProductFamily;	/* Byte 3 */
+	} hw;						/* Bytes 0-3 */
+	/* MajorVersion.MinorVersion-FirmwareType-TurnID */
+	struct {
+		unsigned char MajorVersion;		/* Byte 4 */
+		unsigned char MinorVersion;		/* Byte 5 */
+		unsigned char TurnID;			/* Byte 6 */
+		char FirmwareType;			/* Byte 7 */
+	} fw;						/* Bytes 4-7 */
+	unsigned int rsvd1;				/* Byte 8-11 */
+	unsigned char cfg_chan;				/* Byte 12 */
+	unsigned char cur_chan;				/* Byte 13 */
+	unsigned char max_targets;			/* Byte 14 */
+	unsigned char max_tcq;				/* Byte 15 */
+	unsigned char max_ldev;				/* Byte 16 */
+	unsigned char max_arms;				/* Byte 17 */
+	unsigned char max_spans;			/* Byte 18 */
+	unsigned char rsvd2;				/* Byte 19 */
+	unsigned int rsvd3;				/* Bytes 20-23 */
+	unsigned int mem_size;				/* Bytes 24-27 */
+	unsigned int cache_size;			/* Bytes 28-31 */
+	unsigned int flash_size;			/* Bytes 32-35 */
+	unsigned int nvram_size;			/* Bytes 36-39 */
+	struct {
+		enum {
+			DAC960_V1_RamType_DRAM =		0x0,
+			DAC960_V1_RamType_EDO =			0x1,
+			DAC960_V1_RamType_SDRAM =		0x2,
+			DAC960_V1_RamType_Last =		0x7
+		} __attribute__ ((packed)) ram:3;	/* Byte 40 Bits 0-2 */
+		enum {
+			DAC960_V1_ErrorCorrection_None =	0x0,
+			DAC960_V1_ErrorCorrection_Parity =	0x1,
+			DAC960_V1_ErrorCorrection_ECC =		0x2,
+			DAC960_V1_ErrorCorrection_Last =	0x7
+		} __attribute__ ((packed)) ec:3;	/* Byte 40 Bits 3-5 */
+		bool fast_page:1;			/* Byte 40 Bit 6 */
+		bool low_power:1;			/* Byte 40 Bit 7 */
+		unsigned char rsvd4;			/* Bytes 41 */
+	} mem_type;
+	unsigned short ClockSpeed;			/* Bytes 42-43 */
+	unsigned short MemorySpeed;			/* Bytes 44-45 */
+	unsigned short HardwareSpeed;			/* Bytes 46-47 */
+	unsigned char rsvd5[12];			/* Bytes 48-59 */
+	unsigned short max_cmds;			/* Bytes 60-61 */
+	unsigned short max_sge;				/* Bytes 62-63 */
+	unsigned short max_drv_cmds;			/* Bytes 64-65 */
+	unsigned short max_io_desc;			/* Bytes 66-67 */
+	unsigned short max_sectors;			/* Bytes 68-69 */
+	unsigned char latency;				/* Byte 70 */
+	unsigned char rsvd6;				/* Byte 71 */
+	unsigned char scsi_tmo;				/* Byte 72 */
+	unsigned char rsvd7;				/* Byte 73 */
+	unsigned short min_freelines;			/* Bytes 74-75 */
+	unsigned char rsvd8[8];				/* Bytes 76-83 */
+	unsigned char rbld_rate_const;			/* Byte 84 */
+	unsigned char rsvd9[11];			/* Byte 85-95 */
+	unsigned short pdrv_block_size;			/* Bytes 96-97 */
+	unsigned short ldev_block_size;			/* Bytes 98-99 */
+	unsigned short max_blocks_per_cmd;		/* Bytes 100-101 */
+	unsigned short block_factor;			/* Bytes 102-103 */
+	unsigned short cacheline_size;			/* Bytes 104-105 */
+	struct {
+		enum {
+			DAC960_V1_Narrow_8bit =			0x0,
+			DAC960_V1_Wide_16bit =			0x1,
+			DAC960_V1_Wide_32bit =			0x2
+		} __attribute__ ((packed)) bus_width:2;	/* Byte 106 Bits 0-1 */
+		enum {
+			DAC960_V1_Fast =			0x0,
+			DAC960_V1_Ultra =			0x1,
+			DAC960_V1_Ultra2 =			0x2
+		} __attribute__ ((packed)) bus_speed:2;	/* Byte 106 Bits 2-3 */
+		bool Differential:1;			/* Byte 106 Bit 4 */
+		unsigned char rsvd10:3;			/* Byte 106 Bits 5-7 */
+	} scsi_cap;
+	unsigned char rsvd11[5];			/* Byte 107-111 */
+	unsigned short fw_build;			/* Bytes 112-113 */
+	enum {
+		DAC960_V1_AEMI =				0x01,
+		DAC960_V1_OEM1 =				0x02,
+		DAC960_V1_OEM2 =				0x04,
+		DAC960_V1_OEM3 =				0x08,
+		DAC960_V1_Conner =				0x10,
+		DAC960_V1_SAFTE =				0x20
+	} __attribute__ ((packed)) fault_mgmt;		/* Byte 114 */
+	unsigned char rsvd12;				/* Byte 115 */
+	struct {
+		bool Clustering:1;			/* Byte 116 Bit 0 */
+		bool MylexOnlineRAIDExpansion:1;	/* Byte 116 Bit 1 */
+		bool ReadAhead:1;			/* Byte 116 Bit 2 */
+		bool BackgroundInitialization:1;	/* Byte 116 Bit 3 */
+		unsigned int rsvd13:28;			/* Bytes 116-119 */
+	} fw_features;
+	unsigned char rsvd14[8];			/* Bytes 120-127 */
+} __attribute__((packed));
+
+/*
+ * DAC960 V1 Firmware Logical Drive State type.
+ */
+enum myrb_devstate {
+	DAC960_V1_Device_Dead =			0x00,
+	DAC960_V1_Device_WriteOnly =		0x02,
+	DAC960_V1_Device_Online =		0x03,
+	DAC960_V1_Device_Critical =		0x04,
+	DAC960_V1_Device_Standby =		0x10,
+	DAC960_V1_Device_Offline =		0xFF
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V1 RAID Levels
+ */
+enum myrb_raidlevel {
+	DAC960_V1_RAID_Level0 =		0x0,     /* RAID 0 */
+	DAC960_V1_RAID_Level1 =		0x1,     /* RAID 1 */
+	DAC960_V1_RAID_Level3 =		0x3,     /* RAID 3 */
+	DAC960_V1_RAID_Level5 =		0x5,     /* RAID 5 */
+	DAC960_V1_RAID_Level6 =		0x6,     /* RAID 6 */
+	DAC960_V1_RAID_JBOD =		0x7,     /* RAID 7 (JBOD) */
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V1 Firmware Logical Drive Information structure.
+ */
+struct myrb_ldev_info {
+	unsigned int Size;				/* Bytes 0-3 */
+	enum myrb_devstate State;			/* Byte 4 */
+	unsigned char RAIDLevel:7;			/* Byte 5 Bits 0-6 */
+	bool WriteBack:1;				/* Byte 5 Bit 7 */
+	unsigned short :16;				/* Bytes 6-7 */
+};
+
+/*
+ * DAC960 V1 Firmware Perform Event Log Operation Types.
+ */
+#define DAC960_V1_GetEventLogEntry		0x00
+
+/*
+ * DAC960 V1 Firmware Get Event Log Entry Command reply structure.
+ */
+struct myrb_log_entry {
+	unsigned char MessageType;			/* Byte 0 */
+	unsigned char MessageLength;			/* Byte 1 */
+	unsigned char TargetID:5;			/* Byte 2 Bits 0-4 */
+	unsigned char Channel:3;			/* Byte 2 Bits 5-7 */
+	unsigned char LogicalUnit:6;			/* Byte 3 Bits 0-5 */
+	unsigned char rsvd1:2;				/* Byte 3 Bits 6-7 */
+	unsigned short SequenceNumber;			/* Bytes 4-5 */
+	unsigned char SenseData[26];			/* Bytes 6-31 */
+};
+
+/*
+ * DAC960 V1 Firmware Get Device State Command reply structure.
+ * The structure is padded by 2 bytes for compatibility with Version 2.xx
+ * Firmware.
+ */
+struct myrb_pdev_state {
+	bool Present:1;					/* Byte 0 Bit 0 */
+	unsigned char :7;				/* Byte 0 Bits 1-7 */
+	enum {
+		DAC960_V1_OtherType =			0x0,
+		DAC960_V1_DiskType =			0x1,
+		DAC960_V1_SequentialType =		0x2,
+		DAC960_V1_CDROM_or_WORM_Type =		0x3
+	} __attribute__ ((packed)) DeviceType:2;	/* Byte 1 Bits 0-1 */
+	bool rsvd1:1;					/* Byte 1 Bit 2 */
+	bool Fast20:1;					/* Byte 1 Bit 3 */
+	bool Sync:1;					/* Byte 1 Bit 4 */
+	bool Fast:1;					/* Byte 1 Bit 5 */
+	bool Wide:1;					/* Byte 1 Bit 6 */
+	bool TaggedQueuingSupported:1;			/* Byte 1 Bit 7 */
+	enum myrb_devstate State;			/* Byte 2 */
+	unsigned char rsvd2:8;				/* Byte 3 */
+	unsigned char SynchronousMultiplier;		/* Byte 4 */
+	unsigned char SynchronousOffset:5;		/* Byte 5 Bits 0-4 */
+	unsigned char rsvd3:3;				/* Byte 5 Bits 5-7 */
+	unsigned int Size __attribute__ ((packed));	/* Bytes 6-9 */
+	unsigned short rsvd4:16;			/* Bytes 10-11 */
+};
+
+/*
+ * DAC960 V1 Firmware Get Rebuild Progress Command reply structure.
+ */
+struct myrb_rbld_progress {
+	unsigned int ldev_num;				/* Bytes 0-3 */
+	unsigned int ldev_size;				/* Bytes 4-7 */
+	unsigned int blocks_left;			/* Bytes 8-11 */
+};
+
+/*
+ * DAC960 V1 Firmware Background Initialization Status Command reply structure.
+ */
+struct myrb_bgi_status
+{
+	unsigned int ldev_size;				/* Bytes 0-3 */
+	unsigned int blocks_done;			/* Bytes 4-7 */
+	unsigned char rsvd1[12];			/* Bytes 8-19 */
+	unsigned int ldev_num;				/* Bytes 20-23 */
+	unsigned char RAIDLevel;			/* Byte 24 */
+	enum {
+		MYRB_BGI_INVALID =	0x00,
+		MYRB_BGI_STARTED =	0x02,
+		MYRB_BGI_INPROGRESS =	0x04,
+		MYRB_BGI_SUSPENDED =	0x05,
+		MYRB_BGI_CANCELLED =	0x06
+	} __attribute__ ((packed)) Status;		/* Byte 25 */
+	unsigned char rsvd2[6];				/* Bytes 26-31 */
+};
+
+/*
+ * DAC960 V1 Firmware Error Table Entry structure.
+ */
+struct myrb_error_entry {
+	unsigned char parity_err;			/* Byte 0 */
+	unsigned char soft_err;				/* Byte 1 */
+	unsigned char hard_err;				/* Byte 2 */
+	unsigned char misc_err;				/* Byte 3 */
+};
+
+/*
+ * DAC960 V1 Firmware Read Config2 Command reply structure.
+ */
+struct myrb_config2 {
+	unsigned char :1;				/* Byte 0 Bit 0 */
+	bool ActiveNegationEnabled:1;			/* Byte 0 Bit 1 */
+	unsigned char :5;				/* Byte 0 Bits 2-6 */
+	bool NoRescanIfResetReceivedDuringScan:1;	/* Byte 0 Bit 7 */
+	bool StorageWorksSupportEnabled:1;		/* Byte 1 Bit 0 */
+	bool HewlettPackardSupportEnabled:1;		/* Byte 1 Bit 1 */
+	bool NoDisconnectOnFirstCommand:1;		/* Byte 1 Bit 2 */
+	unsigned char :2;				/* Byte 1 Bits 3-4 */
+	bool AEMI_ARM:1;				/* Byte 1 Bit 5 */
+	bool AEMI_OFM:1;				/* Byte 1 Bit 6 */
+	unsigned char :1;				/* Byte 1 Bit 7 */
+	enum {
+		DAC960_V1_OEMID_Mylex =			0x00,
+		DAC960_V1_OEMID_IBM =			0x08,
+		DAC960_V1_OEMID_HP =			0x0A,
+		DAC960_V1_OEMID_DEC =			0x0C,
+		DAC960_V1_OEMID_Siemens =		0x10,
+		DAC960_V1_OEMID_Intel =			0x12
+	} __attribute__ ((packed)) OEMID;		/* Byte 2 */
+	unsigned char OEMModelNumber;			/* Byte 3 */
+	unsigned char PhysicalSector;			/* Byte 4 */
+	unsigned char LogicalSector;			/* Byte 5 */
+	unsigned char BlockFactor;			/* Byte 6 */
+	bool ReadAheadEnabled:1;			/* Byte 7 Bit 0 */
+	bool LowBIOSDelay:1;				/* Byte 7 Bit 1 */
+	unsigned char :2;				/* Byte 7 Bits 2-3 */
+	bool ReassignRestrictedToOneSector:1;		/* Byte 7 Bit 4 */
+	unsigned char :1;				/* Byte 7 Bit 5 */
+	bool ForceUnitAccessDuringWriteRecovery:1;	/* Byte 7 Bit 6 */
+	bool EnableLeftSymmetricRAID5Algorithm:1;	/* Byte 7 Bit 7 */
+	unsigned char DefaultRebuildRate;		/* Byte 8 */
+	unsigned char :8;				/* Byte 9 */
+	unsigned char BlocksPerCacheLine;		/* Byte 10 */
+	unsigned char BlocksPerStripe;			/* Byte 11 */
+	struct {
+		enum {
+			DAC960_V1_Async =		0x0,
+			DAC960_V1_Sync_8MHz =		0x1,
+			DAC960_V1_Sync_5MHz =		0x2,
+			DAC960_V1_Sync_10or20MHz =	0x3
+		} __attribute__ ((packed)) Speed:2;	/* Byte 11 Bits 0-1 */
+		bool Force8Bit:1;			/* Byte 11 Bit 2 */
+		bool DisableFast20:1;			/* Byte 11 Bit 3 */
+		unsigned char :3;			/* Byte 11 Bits 4-6 */
+		bool EnableTaggedQueuing:1;		/* Byte 11 Bit 7 */
+	} __attribute__ ((packed)) ChannelParameters[6]; /* Bytes 12-17 */
+	unsigned char SCSIInitiatorID;			/* Byte 18 */
+	unsigned char :8;				/* Byte 19 */
+	enum {
+		DAC960_V1_StartupMode_ControllerSpinUp =	0x00,
+		DAC960_V1_StartupMode_PowerOnSpinUp =	0x01
+	} __attribute__ ((packed)) StartupMode;		/* Byte 20 */
+	unsigned char SimultaneousDeviceSpinUpCount;	/* Byte 21 */
+	unsigned char SecondsDelayBetweenSpinUps;	/* Byte 22 */
+	unsigned char Reserved1[29];			/* Bytes 23-51 */
+	bool BIOSDisabled:1;				/* Byte 52 Bit 0 */
+	bool CDROMBootEnabled:1;			/* Byte 52 Bit 1 */
+	unsigned char :3;				/* Byte 52 Bits 2-4 */
+	enum {
+		DAC960_V1_Geometry_128_32 =		0x0,
+		DAC960_V1_Geometry_255_63 =		0x1,
+		DAC960_V1_Geometry_Reserved1 =		0x2,
+		DAC960_V1_Geometry_Reserved2 =		0x3
+	} __attribute__ ((packed)) DriveGeometry:2;	/* Byte 52 Bits 5-6 */
+	unsigned char :1;				/* Byte 52 Bit 7 */
+	unsigned char Reserved2[9];			/* Bytes 53-61 */
+	unsigned short Checksum;			/* Bytes 62-63 */
+};
+
+/*
+ * DAC960 V1 Firmware DCDB request structure.
+ */
+struct myrb_dcdb {
+	unsigned char TargetID:4;			 /* Byte 0 Bits 0-3 */
+	unsigned char Channel:4;			 /* Byte 0 Bits 4-7 */
+	enum {
+		DAC960_V1_DCDB_NoDataTransfer =		0,
+		DAC960_V1_DCDB_DataTransferDeviceToSystem = 1,
+		DAC960_V1_DCDB_DataTransferSystemToDevice = 2,
+		DAC960_V1_DCDB_IllegalDataTransfer =	3
+	} __attribute__ ((packed)) Direction:2;		/* Byte 1 Bits 0-1 */
+	bool EarlyStatus:1;				/* Byte 1 Bit 2 */
+	unsigned char :1;				/* Byte 1 Bit 3 */
+	enum {
+		DAC960_V1_DCDB_Timeout_24_hours =	0,
+		DAC960_V1_DCDB_Timeout_10_seconds =	1,
+		DAC960_V1_DCDB_Timeout_60_seconds =	2,
+		DAC960_V1_DCDB_Timeout_10_minutes =	3
+	} __attribute__ ((packed)) Timeout:2;		/* Byte 1 Bits 4-5 */
+	bool NoAutomaticRequestSense:1;			/* Byte 1 Bit 6 */
+	bool DisconnectPermitted:1;			/* Byte 1 Bit 7 */
+	unsigned short xfer_len_lo;			/* Bytes 2-3 */
+	u32 BusAddress;					/* Bytes 4-7 */
+	unsigned char CDBLength:4;			/* Byte 8 Bits 0-3 */
+	unsigned char xfer_len_hi4:4;			/* Byte 8 Bits 4-7 */
+	unsigned char SenseLength;			/* Byte 9 */
+	unsigned char CDB[12];				/* Bytes 10-21 */
+	unsigned char SenseData[64];			/* Bytes 22-85 */
+	unsigned char Status;				/* Byte 86 */
+	unsigned char :8;				/* Byte 87 */
+};
+
+/*
+ * DAC960 V1 Firmware Scatter/Gather List Type 1 32 Bit Address
+ *32 Bit Byte Count structure.
+ */
+struct myrb_sge {
+	u32 sge_addr;		/* Bytes 0-3 */
+	u32 sge_count;		/* Bytes 4-7 */
+};
+
+/*
+ * 13 Byte DAC960 V1 Firmware Command Mailbox structure.
+ * Bytes 13-15 are not used.  The structure is padded to 16 bytes for
+ * efficient access.
+ */
+union myrb_cmd_mbox {
+	unsigned int Words[4];				/* Words 0-3 */
+	unsigned char Bytes[16];			/* Bytes 0-15 */
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd[14];			/* Bytes 2-15 */
+	} __attribute__ ((packed)) Common;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd1[6];			/* Bytes 2-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __attribute__ ((packed)) Type3;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char optype;			/* Byte 2 */
+		unsigned char rsvd1[5];			/* Bytes 3-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __attribute__ ((packed)) Type3B;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd1[5];			/* Bytes 2-6 */
+		unsigned char ldev_num:6;		/* Byte 7 Bits 0-6 */
+		bool AutoRestore:1;			/* Byte 7 Bit 7 */
+		unsigned char rsvd2[8];			/* Bytes 8-15 */
+	} __attribute__ ((packed)) Type3C;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char Channel;			/* Byte 2 */
+		unsigned char TargetID;			/* Byte 3 */
+		enum myrb_devstate State;		/* Byte 4 */
+		unsigned char rsvd1[3];			/* Bytes 5-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __attribute__ ((packed)) Type3D;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char optype;			/* Byte 2 */
+		unsigned char opqual;			/* Byte 3 */
+		unsigned short ev_seq;			/* Bytes 4-5 */
+		unsigned char rsvd1[2];			/* Bytes 6-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __attribute__ ((packed)) Type3E;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd1[2];			/* Bytes 2-3 */
+		unsigned char rbld_rate;		/* Byte 4 */
+		unsigned char rsvd2[3];			/* Bytes 5-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd3[4];			/* Bytes 12-15 */
+	} __attribute__ ((packed)) Type3R;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned short xfer_len;		/* Bytes 2-3 */
+		unsigned int lba;			/* Bytes 4-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char ldev_num;			/* Byte 12 */
+		unsigned char rsvd[3];			/* Bytes 13-15 */
+	} __attribute__ ((packed)) Type4;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		struct {
+			unsigned short xfer_len:11;	/* Bytes 2-3 */
+			unsigned char ldev_num:5;	/* Byte 3 Bits 3-7 */
+		} __attribute__ ((packed)) LD;
+		unsigned int lba;			/* Bytes 4-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char sg_count:6;		/* Byte 12 Bits 0-5 */
+		enum {
+			DAC960_V1_ScatterGather_32BitAddress_32BitByteCount = 0x0,
+			DAC960_V1_ScatterGather_32BitAddress_16BitByteCount = 0x1,
+			DAC960_V1_ScatterGather_32BitByteCount_32BitAddress = 0x2,
+			DAC960_V1_ScatterGather_16BitByteCount_32BitAddress = 0x3
+		} __attribute__ ((packed)) sg_type:2;	/* Byte 12 Bits 6-7 */
+		unsigned char rsvd[3];			/* Bytes 13-15 */
+	} __attribute__ ((packed)) Type5;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char CommandOpcode2;		/* Byte 2 */
+		unsigned char rsvd1:8;			/* Byte 3 */
+		u32 CommandMailboxesBusAddress;		/* Bytes 4-7 */
+		u32 StatusMailboxesBusAddress;		/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __attribute__ ((packed)) TypeX;
+};
+
+/*
+ * DAC960 V1 Firmware Controller Status Mailbox structure.
+ */
+struct myrb_stat_mbox {
+	unsigned char id;		/* Byte 0 */
+	unsigned char rsvd:7;		/* Byte 1 Bits 0-6 */
+	bool valid:1;			/* Byte 1 Bit 7 */
+	unsigned short status;		/* Bytes 2-3 */
+};
+
+struct myrb_cmdblk {
+	union myrb_cmd_mbox mbox;
+	unsigned short status;
+	struct completion *Completion;
+	struct myrb_dcdb *dcdb;
+	dma_addr_t dcdb_addr;
+	struct myrb_sge *sgl;
+	dma_addr_t sgl_addr;
+};
+
+struct myrb_hba {
+	unsigned int ldev_block_size;
+	unsigned char ldev_geom_heads;
+	unsigned char ldev_geom_sectors;
+	unsigned char BusWidth;
+	unsigned short StripeSize;
+	unsigned short SegmentSize;
+	unsigned short new_ev_seq;
+	unsigned short old_ev_seq;
+	bool dual_mode_interface;
+	bool bgi_status_supported;
+	bool safte_enabled;
+	bool need_ldev_info;
+	bool need_err_info;
+	bool need_rbld;
+	bool need_cc_status;
+	bool need_bgi_status;
+	bool rbld_first;
+
+	struct pci_dev *pdev;
+	struct Scsi_Host *host;
+
+	struct workqueue_struct *work_q;
+	char work_q_name[20];
+	struct delayed_work monitor_work;
+	unsigned long primary_monitor_time;
+	unsigned long secondary_monitor_time;
+
+	struct dma_pool *sg_pool;
+	struct dma_pool *dcdb_pool;
+
+	spinlock_t queue_lock;
+
+	void (*qcmd)(struct myrb_hba *, struct myrb_cmdblk *);
+	void (*write_cmd_mbox)(union myrb_cmd_mbox *, union myrb_cmd_mbox *);
+	void (*get_cmd_mbox)(void __iomem *);
+	void (*disable_intr)(void __iomem *);
+	void (*reset)(void __iomem *);
+
+	unsigned int ctlr_num;
+	unsigned char ModelName[20];
+	unsigned char FirmwareVersion[12];
+
+	unsigned int irq;
+	phys_addr_t io_addr;
+	phys_addr_t pci_addr;
+	void __iomem *io_base;
+	void __iomem *mmio_base;
+
+	size_t cmd_mbox_size;
+	dma_addr_t cmd_mbox_addr;
+	union myrb_cmd_mbox *first_cmd_mbox;
+	union myrb_cmd_mbox *last_cmd_mbox;
+	union myrb_cmd_mbox *next_cmd_mbox;
+	union myrb_cmd_mbox *prev_cmd_mbox1;
+	union myrb_cmd_mbox *prev_cmd_mbox2;
+
+	size_t stat_mbox_size;
+	dma_addr_t stat_mbox_addr;
+	struct myrb_stat_mbox *first_stat_mbox;
+	struct myrb_stat_mbox *last_stat_mbox;
+	struct myrb_stat_mbox *next_stat_mbox;
+
+	struct myrb_cmdblk dcmd_blk;
+	struct myrb_cmdblk mcmd_blk;
+	struct mutex dcmd_mutex;
+
+	struct myrb_enquiry *enquiry;
+	dma_addr_t enquiry_addr;
+
+	struct myrb_error_entry *err_table;
+	dma_addr_t err_table_addr;
+
+	unsigned short last_rbld_status;
+
+	struct myrb_ldev_info *ldev_info_buf;
+	dma_addr_t ldev_info_addr;
+
+	struct myrb_bgi_status bgi_status;
+
+	struct mutex dma_mutex;
+};
+
+/*
+ * DAC960 LA Series Controller Interface Register Offsets.
+ */
+#define DAC960_LA_RegisterWindowSize		0x80
+
+enum DAC960_LA_RegisterOffsets {
+	DAC960_LA_InterruptMaskRegisterOffset =		0x34,
+	DAC960_LA_CommandOpcodeRegisterOffset =		0x50,
+	DAC960_LA_CommandIdentifierRegisterOffset =	0x51,
+	DAC960_LA_MailboxRegister2Offset =		0x52,
+	DAC960_LA_MailboxRegister3Offset =		0x53,
+	DAC960_LA_MailboxRegister4Offset =		0x54,
+	DAC960_LA_MailboxRegister5Offset =		0x55,
+	DAC960_LA_MailboxRegister6Offset =		0x56,
+	DAC960_LA_MailboxRegister7Offset =		0x57,
+	DAC960_LA_MailboxRegister8Offset =		0x58,
+	DAC960_LA_MailboxRegister9Offset =		0x59,
+	DAC960_LA_MailboxRegister10Offset =		0x5A,
+	DAC960_LA_MailboxRegister11Offset =		0x5B,
+	DAC960_LA_MailboxRegister12Offset =		0x5C,
+	DAC960_LA_StatusCommandIdentifierRegOffset =	0x5D,
+	DAC960_LA_StatusRegisterOffset =		0x5E,
+	DAC960_LA_InboundDoorBellRegisterOffset =	0x60,
+	DAC960_LA_OutboundDoorBellRegisterOffset =	0x61,
+	DAC960_LA_ErrorStatusRegisterOffset =		0x63
+};
+
+/*
+ * DAC960 LA Series Inbound Door Bell Register.
+ */
+#define DAC960_LA_IDB_HWMBOX_NEW_CMD 0x01
+#define DAC960_LA_IDB_HWMBOX_ACK_STS 0x02
+#define DAC960_LA_IDB_GEN_IRQ 0x04
+#define DAC960_LA_IDB_CTRL_RESET 0x08
+#define DAC960_LA_IDB_MMBOX_NEW_CMD 0x10
+
+#define DAC960_LA_IDB_HWMBOX_EMPTY 0x01
+#define DAC960_LA_IDB_INIT_DONE 0x02
+
+/*
+ * DAC960 LA Series Outbound Door Bell Register.
+ */
+#define DAC960_LA_ODB_HWMBOX_ACK_IRQ 0x01
+#define DAC960_LA_ODB_MMBOX_ACK_IRQ 0x02
+#define DAC960_LA_ODB_HWMBOX_STS_AVAIL 0x01
+#define DAC960_LA_ODB_MMBOX_STS_AVAIL 0x02
+
+/*
+ * DAC960 LA Series Interrupt Mask Register.
+ */
+#define DAC960_LA_IRQMASK_DISABLE_IRQ 0x04
+
+/*
+ * DAC960 LA Series Error Status Register.
+ */
+#define DAC960_LA_ERRSTS_PENDING 0x02
+
+/*
+ * DAC960 PG Series Controller Interface Register Offsets.
+ */
+#define DAC960_PG_RegisterWindowSize		0x2000
+
+enum DAC960_PG_RegisterOffsets
+{
+	DAC960_PG_InboundDoorBellRegisterOffset =	0x0020,
+	DAC960_PG_OutboundDoorBellRegisterOffset =	0x002C,
+	DAC960_PG_InterruptMaskRegisterOffset =		0x0034,
+	DAC960_PG_CommandOpcodeRegisterOffset =		0x1000,
+	DAC960_PG_CommandIdentifierRegisterOffset =	0x1001,
+	DAC960_PG_MailboxRegister2Offset =		0x1002,
+	DAC960_PG_MailboxRegister3Offset =		0x1003,
+	DAC960_PG_MailboxRegister4Offset =		0x1004,
+	DAC960_PG_MailboxRegister5Offset =		0x1005,
+	DAC960_PG_MailboxRegister6Offset =		0x1006,
+	DAC960_PG_MailboxRegister7Offset =		0x1007,
+	DAC960_PG_MailboxRegister8Offset =		0x1008,
+	DAC960_PG_MailboxRegister9Offset =		0x1009,
+	DAC960_PG_MailboxRegister10Offset =		0x100A,
+	DAC960_PG_MailboxRegister11Offset =		0x100B,
+	DAC960_PG_MailboxRegister12Offset =		0x100C,
+	DAC960_PG_StatusCommandIdentifierRegOffset =	0x1018,
+	DAC960_PG_StatusRegisterOffset =		0x101A,
+	DAC960_PG_ErrorStatusRegisterOffset =		0x103F
+};
+
+/*
+ * DAC960 PG Series Inbound Door Bell Register.
+ */
+#define DAC960_PG_IDB_HWMBOX_NEW_CMD 0x01
+#define DAC960_PG_IDB_HWMBOX_ACK_STS 0x02
+#define DAC960_PG_IDB_GEN_IRQ 0x04
+#define DAC960_PG_IDB_CTRL_RESET 0x08
+#define DAC960_PG_IDB_MMBOX_NEW_CMD 0x10
+
+#define DAC960_PG_IDB_HWMBOX_FULL 0x01
+#define DAC960_PG_IDB_INIT_IN_PROGRESS 0x02
+
+/*
+ * DAC960 PG Series Outbound Door Bell Register.
+ */
+#define DAC960_PG_ODB_HWMBOX_ACK_IRQ 0x01
+#define DAC960_PG_ODB_MMBOX_ACK_IRQ 0x02
+#define DAC960_PG_ODB_HWMBOX_STS_AVAIL 0x01
+#define DAC960_PG_ODB_MMBOX_STS_AVAIL 0x02
+
+/*
+ * DAC960 PG Series Interrupt Mask Register.
+ */
+#define DAC960_PG_IRQMASK_MSI_MASK1 0x03
+#define DAC960_PG_IRQMASK_DISABLE_IRQ 0x04
+#define DAC960_PG_IRQMASK_MSI_MASK2 0xF8
+
+/*
+ * DAC960 PG Series Error Status Register.
+ */
+#define DAC960_PG_ERRSTS_PENDING 0x04
+
+/*
+ * DAC960 PD Series Controller Interface Register Offsets.
+ */
+#define DAC960_PD_RegisterWindowSize		0x80
+
+enum DAC960_PD_RegisterOffsets
+{
+	DAC960_PD_CommandOpcodeRegisterOffset =		0x00,
+	DAC960_PD_CommandIdentifierRegisterOffset =	0x01,
+	DAC960_PD_MailboxRegister2Offset =		0x02,
+	DAC960_PD_MailboxRegister3Offset =		0x03,
+	DAC960_PD_MailboxRegister4Offset =		0x04,
+	DAC960_PD_MailboxRegister5Offset =		0x05,
+	DAC960_PD_MailboxRegister6Offset =		0x06,
+	DAC960_PD_MailboxRegister7Offset =		0x07,
+	DAC960_PD_MailboxRegister8Offset =		0x08,
+	DAC960_PD_MailboxRegister9Offset =		0x09,
+	DAC960_PD_MailboxRegister10Offset =		0x0A,
+	DAC960_PD_MailboxRegister11Offset =		0x0B,
+	DAC960_PD_MailboxRegister12Offset =		0x0C,
+	DAC960_PD_StatusCommandIdentifierRegOffset =	0x0D,
+	DAC960_PD_StatusRegisterOffset =		0x0E,
+	DAC960_PD_ErrorStatusRegisterOffset =		0x3F,
+	DAC960_PD_InboundDoorBellRegisterOffset =	0x40,
+	DAC960_PD_OutboundDoorBellRegisterOffset =	0x41,
+	DAC960_PD_InterruptEnableRegisterOffset =	0x43
+};
+
+/*
+ * DAC960 PD Series Inbound Door Bell Register.
+ */
+#define DAC960_PD_IDB_HWMBOX_NEW_CMD 0x01
+#define DAC960_PD_IDB_HWMBOX_ACK_STS 0x02
+#define DAC960_PD_IDB_GEN_IRQ 0x04
+#define DAC960_PD_IDB_CTRL_RESET 0x08
+
+#define DAC960_PD_IDB_HWMBOX_FULL 0x01
+#define DAC960_PD_IDB_INIT_IN_PROGRESS 0x02
+
+/*
+ * DAC960 PD Series Outbound Door Bell Register.
+ */
+#define DAC960_PD_ODB_HWMBOX_ACK_IRQ 0x01
+#define DAC960_PD_ODB_HWMBOX_STS_AVAIL 0x01
+
+/*
+ * DAC960 PD Series Interrupt Enable Register.
+ */
+#define DAC960_PD_IRQMASK_ENABLE_IRQ 0x01
+
+/*
+ * DAC960 PD Series Error Status Register.
+ */
+#define DAC960_PD_ERRSTS_PENDING 0x04
+
+typedef int (*myrb_hw_init_t)(struct pci_dev *pdev,
+			      struct myrb_hba *cb, void __iomem *base);
+typedef unsigned short (*mbox_mmio_init_t)(struct pci_dev *pdev,
+					   void __iomem *base,
+					   union myrb_cmd_mbox *mbox);
+
+struct myrb_privdata {
+	myrb_hw_init_t		HardwareInit;
+	irq_handler_t		InterruptHandler;
+	unsigned int		MemoryWindowSize;
+};
+
+#endif /* MYRB_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 99d366cb0e9f..1efbd175411a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -922,10 +922,12 @@
 #define PCI_DEVICE_ID_PICOPOWER_PT86C523BBP	0x8002
 
 #define PCI_VENDOR_ID_MYLEX		0x1069
+#define PCI_SUBVENDOR_ID_MYLEX		0x1069
 #define PCI_DEVICE_ID_MYLEX_DAC960_P	0x0001
 #define PCI_DEVICE_ID_MYLEX_DAC960_PD	0x0002
 #define PCI_DEVICE_ID_MYLEX_DAC960_PG	0x0010
 #define PCI_DEVICE_ID_MYLEX_DAC960_LA	0x0020
+#define PCI_SUBDEVICE_ID_MYLEX_DAC960_LA 0x0020
 #define PCI_DEVICE_ID_MYLEX_DAC960_LP	0x0050
 #define PCI_DEVICE_ID_MYLEX_DAC960_BA	0xBA56
 #define PCI_DEVICE_ID_MYLEX_DAC960_GEM	0xB166
-- 
2.16.4
