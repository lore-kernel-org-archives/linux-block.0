Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [PATCH 1/3] myrb: Add Mylex RAID controller (block interface)
Date: Wed, 17 Oct 2018 17:25:11 +0200
Message-Id: <20181017152513.136526-2-hare@suse.de>
In-Reply-To: <20181017152513.136526-1-hare@suse.de>
References: <20181017152513.136526-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds support for the Mylex DAC960 RAID controller,
supporting the older, block-based interface only.
The driver is a re-implementation of the original DAC960 driver.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 MAINTAINERS           |    6 +
 drivers/scsi/Kconfig  |   15 +
 drivers/scsi/Makefile |    1 +
 drivers/scsi/myrb.c   | 3656 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/myrb.h   |  958 +++++++++++++
 5 files changed, 4636 insertions(+)
 create mode 100644 drivers/scsi/myrb.c
 create mode 100644 drivers/scsi/myrb.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3594292ac295..99c7e6791519 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9892,6 +9892,12 @@ S:	Supported
 F:	drivers/gpu/drm/mxsfb/
 F:	Documentation/devicetree/bindings/display/mxsfb.txt
 
+MYLEX DAC960 PCI RAID Controller
+M:	Hannes Reinecke <hare@kernel.org>
+L:	linux-scsi@vger.kernel.org
+S:	Supported
+F:	drivers/scsi/myrb.*
+
 MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
 M:	Chris Lee <christopher.lee@cspi.com>
 L:	netdev@vger.kernel.org
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
index 000000000000..aeb282f617c5
--- /dev/null
+++ b/drivers/scsi/myrb.c
@@ -0,0 +1,3656 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
+ *
+ * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
+ *
+ * Based on the original DAC960 driver,
+ * Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
+ * Portions Copyright 2002 by Mylex (An IBM Business Unit)
+ *
+ */
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
+static inline void myrb_translate_devstate(void *DeviceState);
+
+static inline int myrb_logical_channel(struct Scsi_Host *shost)
+{
+	return shost->max_channel - 1;
+}
+
+static struct myrb_devstate_name_entry {
+	enum myrb_devstate state;
+	const char *name;
+} myrb_devstate_name_list[] = {
+	{ MYRB_DEVICE_DEAD, "Dead" },
+	{ MYRB_DEVICE_WO, "WriteOnly" },
+	{ MYRB_DEVICE_ONLINE, "Online" },
+	{ MYRB_DEVICE_CRITICAL, "Critical" },
+	{ MYRB_DEVICE_STANDBY, "Standby" },
+	{ MYRB_DEVICE_OFFLINE, "Offline" },
+};
+
+static const char *myrb_devstate_name(enum myrb_devstate state)
+{
+	struct myrb_devstate_name_entry *entry = myrb_devstate_name_list;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(myrb_devstate_name_list); i++) {
+		if (entry[i].state == state)
+			return entry[i].name;
+	}
+	return "Unknown";
+}
+
+static struct myrb_raidlevel_name_entry {
+	enum myrb_raidlevel level;
+	const char *name;
+} myrb_raidlevel_name_list[] = {
+	{ MYRB_RAID_LEVEL0, "RAID0" },
+	{ MYRB_RAID_LEVEL1, "RAID1" },
+	{ MYRB_RAID_LEVEL3, "RAID3" },
+	{ MYRB_RAID_LEVEL5, "RAID5" },
+	{ MYRB_RAID_LEVEL6, "RAID6" },
+	{ MYRB_RAID_JBOD, "JBOD" },
+};
+
+static const char *myrb_raidlevel_name(enum myrb_raidlevel level)
+{
+	struct myrb_raidlevel_name_entry *entry = myrb_raidlevel_name_list;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(myrb_raidlevel_name_list); i++) {
+		if (entry[i].level == level)
+			return entry[i].name;
+	}
+	return NULL;
+}
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
+	 * Initialize the Monitoring Timer.
+	 */
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
+	dma_pool_destroy(cb->sg_pool);
+	dma_pool_destroy(cb->dcdb_pool);
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
+	if (cb->prev_cmd_mbox1->words[0] == 0 ||
+	    cb->prev_cmd_mbox2->words[0] == 0)
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
+static unsigned short myrb_exec_cmd(struct myrb_hba *cb,
+		struct myrb_cmdblk *cmd_blk)
+{
+	DECLARE_COMPLETION_ONSTACK(cmpl);
+	unsigned long flags;
+
+	cmd_blk->completion = &cmpl;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	cb->qcmd(cb, cmd_blk);
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+
+	WARN_ON(in_interrupt());
+	wait_for_completion(&cmpl);
+	return cmd_blk->status;
+}
+
+/**
+ * myrb_exec_type3 - executes a type 3 command and waits for completion.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_exec_type3(struct myrb_hba *cb,
+		enum myrb_cmd_opcode op, dma_addr_t addr)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->dcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned short status;
+
+	mutex_lock(&cb->dcmd_mutex);
+	myrb_reset_cmd(cmd_blk);
+	mbox->type3.id = MYRB_DCMD_TAG;
+	mbox->type3.opcode = op;
+	mbox->type3.addr = addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	mutex_unlock(&cb->dcmd_mutex);
+	return status;
+}
+
+/**
+ * myrb_exec_type3D - executes a type 3D command and waits for completion.
+ *
+ * Return: command status
+ */
+static unsigned short myrb_exec_type3D(struct myrb_hba *cb,
+		enum myrb_cmd_opcode op, struct scsi_device *sdev,
+		struct myrb_pdev_state *pdev_info)
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
+		return MYRB_STATUS_SUBSYS_FAILED;
+
+	mutex_lock(&cb->dcmd_mutex);
+	myrb_reset_cmd(cmd_blk);
+	mbox->type3D.id = MYRB_DCMD_TAG;
+	mbox->type3D.opcode = op;
+	mbox->type3D.channel = sdev->channel;
+	mbox->type3D.target = sdev->id;
+	mbox->type3D.addr = pdev_info_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	mutex_unlock(&cb->dcmd_mutex);
+	dma_unmap_single(&cb->pdev->dev, pdev_info_addr,
+			 sizeof(struct myrb_pdev_state), DMA_FROM_DEVICE);
+	if (status == MYRB_STATUS_SUCCESS &&
+	    mbox->type3D.opcode == MYRB_CMD_GET_DEVICE_STATE_OLD)
+		myrb_translate_devstate(pdev_info);
+
+	return status;
+}
+
+static char *myrb_event_msg[] = {
+	"killed because write recovery failed",
+	"killed because of SCSI bus reset failure",
+	"killed because of double check condition",
+	"killed because it was removed",
+	"killed because of gross error on SCSI chip",
+	"killed because of bad tag returned from drive",
+	"killed because of timeout on SCSI command",
+	"killed because of reset SCSI command issued from system",
+	"killed because busy or parity error count exceeded limit",
+	"killed because of 'kill drive' command from system",
+	"killed because of selection timeout",
+	"killed due to SCSI phase sequence error",
+	"killed due to unknown status",
+};
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
+
+	ev_buf = dma_alloc_coherent(&cb->pdev->dev,
+				    sizeof(struct myrb_log_entry),
+				    &ev_addr, GFP_KERNEL);
+	if (!ev_buf)
+		return;
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->type3E.id = MYRB_MCMD_TAG;
+	mbox->type3E.opcode = MYRB_CMD_EVENT_LOG_OPERATION;
+	mbox->type3E.optype = DAC960_V1_GetEventLogEntry;
+	mbox->type3E.opqual = 1;
+	mbox->type3E.ev_seq = event;
+	mbox->type3E.addr = ev_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (status != MYRB_STATUS_SUCCESS)
+		shost_printk(KERN_INFO, cb->host,
+			     "Failed to get event log %d, status %04x\n",
+			     event, status);
+
+	else if (ev_buf->seq_num == event) {
+		struct scsi_sense_hdr sshdr;
+
+		memset(&sshdr, 0, sizeof(sshdr));
+		scsi_normalize_sense(ev_buf->sense, 32, &sshdr);
+
+		if (sshdr.sense_key == VENDOR_SPECIFIC &&
+		    sshdr.asc == 0x80 &&
+		    sshdr.ascq < ARRAY_SIZE(myrb_event_msg))
+			shost_printk(KERN_CRIT, cb->host,
+				     "Physical drive %d:%d: %s\n",
+				     ev_buf->channel, ev_buf->target,
+				     myrb_event_msg[sshdr.ascq]);
+		else
+			shost_printk(KERN_CRIT, cb->host,
+				     "Physical drive %d:%d: Sense: %X/%02X/%02X\n",
+				     ev_buf->channel, ev_buf->target,
+				     sshdr.sense_key, sshdr.asc, sshdr.ascq);
+	}
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
+	struct myrb_error_entry old_table[MYRB_MAX_CHANNELS * MYRB_MAX_TARGETS];
+
+	memcpy(&old_table, cb->err_table, sizeof(old_table));
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->type3.id = MYRB_MCMD_TAG;
+	mbox->type3.opcode = MYRB_CMD_GET_ERROR_TABLE;
+	mbox->type3.addr = cb->err_table_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (status == MYRB_STATUS_SUCCESS) {
+		struct myrb_error_entry *table = cb->err_table;
+		struct myrb_error_entry *new, *old;
+		size_t err_table_offset;
+		struct scsi_device *sdev;
+
+		shost_for_each_device(sdev, cb->host) {
+			if (sdev->channel >= myrb_logical_channel(cb->host))
+				continue;
+			err_table_offset = sdev->channel * MYRB_MAX_TARGETS
+				+ sdev->id;
+			new = table + err_table_offset;
+			old = &old_table[err_table_offset];
+			if (new->parity_err == old->parity_err &&
+			    new->soft_err == old->soft_err &&
+			    new->hard_err == old->hard_err &&
+			    new->misc_err == old->misc_err)
+				continue;
+			sdev_printk(KERN_CRIT, sdev,
+				    "Errors: Parity = %d, Soft = %d, Hard = %d, Misc = %d\n",
+				    new->parity_err, new->soft_err,
+				    new->hard_err, new->misc_err);
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
+	status = myrb_exec_type3(cb, MYRB_CMD_GET_LDEV_INFO,
+				 cb->ldev_info_addr);
+	if (status != MYRB_STATUS_SUCCESS)
+		return status;
+
+	for (ldev_num = 0; ldev_num < ldev_cnt; ldev_num++) {
+		struct myrb_ldev_info *old = NULL;
+		struct myrb_ldev_info *new = cb->ldev_info_buf + ldev_num;
+		struct scsi_device *sdev;
+
+		sdev = scsi_device_lookup(shost, myrb_logical_channel(shost),
+					  ldev_num, 0);
+		if (!sdev) {
+			if (new->state == MYRB_DEVICE_OFFLINE)
+				continue;
+			shost_printk(KERN_INFO, shost,
+				     "Adding Logical Drive %d in state %s\n",
+				     ldev_num, myrb_devstate_name(new->state));
+			scsi_add_device(shost, myrb_logical_channel(shost),
+					ldev_num, 0);
+			continue;
+		}
+		old = sdev->hostdata;
+		if (new->state != old->state)
+			shost_printk(KERN_INFO, shost,
+				     "Logical Drive %d is now %s\n",
+				     ldev_num, myrb_devstate_name(new->state));
+		if (new->wb_enabled != old->wb_enabled)
+			sdev_printk(KERN_INFO, sdev,
+				    "Logical Drive is now WRITE %s\n",
+				    (new->wb_enabled ? "BACK" : "THRU"));
+		memcpy(old, new, sizeof(*new));
+		scsi_device_put(sdev);
+	}
+	return status;
+}
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
+		struct myrb_rbld_progress *rbld)
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
+		return MYRB_STATUS_RBLD_NOT_CHECKED;
+
+	myrb_reset_cmd(cmd_blk);
+	mbox->type3.id = MYRB_MCMD_TAG;
+	mbox->type3.opcode = MYRB_CMD_GET_REBUILD_PROGRESS;
+	mbox->type3.addr = rbld_addr;
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
+	if (status == MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS &&
+	    cb->last_rbld_status == MYRB_STATUS_SUCCESS)
+		status = MYRB_STATUS_RBLD_SUCCESS;
+	if (status != MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS) {
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
+		case MYRB_STATUS_SUCCESS:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild in Progress, %d%% completed\n",
+				    (100 * (blocks_done >> 7))
+				    / (rbld_buf.ldev_size >> 7));
+			break;
+		case MYRB_STATUS_RBLD_FAILED_LDEV_FAILURE:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Failed due to Logical Drive Failure\n");
+			break;
+		case MYRB_STATUS_RBLD_FAILED_BADBLOCKS:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Failed due to Bad Blocks on Other Drives\n");
+			break;
+		case MYRB_STATUS_RBLD_FAILED_NEW_DRIVE_FAILED:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Failed due to Failure of Drive Being Rebuilt\n");
+			break;
+		case MYRB_STATUS_RBLD_SUCCESS:
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Completed Successfully\n");
+			break;
+		case MYRB_STATUS_RBLD_SUCCESS_TERMINATED:
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
+	mbox->type3.id = MYRB_MCMD_TAG;
+	mbox->type3.opcode = MYRB_CMD_REBUILD_STAT;
+	mbox->type3.addr = rbld_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	if (status == MYRB_STATUS_SUCCESS) {
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
+	mbox->type3B.id = MYRB_DCMD_TAG;
+	mbox->type3B.opcode = MYRB_CMD_BGI_CONTROL;
+	mbox->type3B.optype = 0x20;
+	mbox->type3B.addr = bgi_addr;
+	status = myrb_exec_cmd(cb, cmd_blk);
+	last_bgi = &cb->bgi_status;
+	sdev = scsi_device_lookup(cb->host,
+				  myrb_logical_channel(cb->host),
+				  bgi->ldev_num, 0);
+	switch (status) {
+	case MYRB_STATUS_SUCCESS:
+		switch (bgi->status) {
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
+				 "Background Initialization in Progress: %d%% completed\n",
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
+	case MYRB_STATUS_BGI_SUCCESS:
+		if (sdev && cb->bgi_status.status == MYRB_BGI_INPROGRESS)
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization Completed Successfully\n");
+		cb->bgi_status.status = MYRB_BGI_INVALID;
+		break;
+	case MYRB_STATUS_BGI_ABORTED:
+		if (sdev && cb->bgi_status.status == MYRB_BGI_INPROGRESS)
+			sdev_printk(KERN_INFO, sdev,
+				    "Background Initialization Aborted\n");
+		/* Fallthrough */
+	case MYRB_STATUS_NO_BGI_INPROGRESS:
+		cb->bgi_status.status = MYRB_BGI_INVALID;
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
+	struct myrb_enquiry old, *new;
+	unsigned short status;
+
+	memcpy(&old, cb->enquiry, sizeof(struct myrb_enquiry));
+
+	status = myrb_exec_type3(cb, MYRB_CMD_ENQUIRY, cb->enquiry_addr);
+	if (status != MYRB_STATUS_SUCCESS)
+		return status;
+
+	new = cb->enquiry;
+	if (new->ldev_count > old.ldev_count) {
+		int ldev_num = old.ldev_count - 1;
+
+		while (++ldev_num < new->ldev_count)
+			shost_printk(KERN_CRIT, cb->host,
+				     "Logical Drive %d Now Exists\n",
+				     ldev_num);
+	}
+	if (new->ldev_count < old.ldev_count) {
+		int ldev_num = new->ldev_count - 1;
+
+		while (++ldev_num < old.ldev_count)
+			shost_printk(KERN_CRIT, cb->host,
+				     "Logical Drive %d No Longer Exists\n",
+				     ldev_num);
+	}
+	if (new->status.deferred != old.status.deferred)
+		shost_printk(KERN_CRIT, cb->host,
+			     "Deferred Write Error Flag is now %s\n",
+			     (new->status.deferred ? "TRUE" : "FALSE"));
+	if (new->ev_seq != old.ev_seq) {
+		cb->new_ev_seq = new->ev_seq;
+		cb->need_err_info = true;
+		shost_printk(KERN_INFO, cb->host,
+			     "Event log %d/%d (%d/%d) available\n",
+			     cb->old_ev_seq, cb->new_ev_seq,
+			     old.ev_seq, new->ev_seq);
+	}
+	if ((new->ldev_critical > 0 &&
+	     new->ldev_critical != old.ldev_critical) ||
+	    (new->ldev_offline > 0 &&
+	     new->ldev_offline != old.ldev_offline) ||
+	    (new->ldev_count != old.ldev_count)) {
+		shost_printk(KERN_INFO, cb->host,
+			     "Logical drive count changed (%d/%d/%d)\n",
+			     new->ldev_critical,
+			     new->ldev_offline,
+			     new->ldev_count);
+		cb->need_ldev_info = true;
+	}
+	if (new->pdev_dead > 0 ||
+	    new->pdev_dead != old.pdev_dead ||
+	    time_after_eq(jiffies, cb->secondary_monitor_time
+			  + MYRB_SECONDARY_MONITOR_INTERVAL)) {
+		cb->need_bgi_status = cb->bgi_status_supported;
+		cb->secondary_monitor_time = jiffies;
+	}
+	if (new->rbld == MYRB_STDBY_RBLD_IN_PROGRESS ||
+	    new->rbld == MYRB_BG_RBLD_IN_PROGRESS ||
+	    old.rbld == MYRB_STDBY_RBLD_IN_PROGRESS ||
+	    old.rbld == MYRB_BG_RBLD_IN_PROGRESS) {
+		cb->need_rbld = true;
+		cb->rbld_first = (new->ldev_critical < old.ldev_critical);
+	}
+	if (old.rbld == MYRB_BG_CHECK_IN_PROGRESS)
+		switch (new->rbld) {
+		case MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS:
+			shost_printk(KERN_INFO, cb->host,
+				     "Consistency Check Completed Successfully\n");
+			break;
+		case MYRB_STDBY_RBLD_IN_PROGRESS:
+		case MYRB_BG_RBLD_IN_PROGRESS:
+			break;
+		case MYRB_BG_CHECK_IN_PROGRESS:
+			cb->need_cc_status = true;
+			break;
+		case MYRB_STDBY_RBLD_COMPLETED_WITH_ERROR:
+			shost_printk(KERN_INFO, cb->host,
+				     "Consistency Check Completed with Error\n");
+			break;
+		case MYRB_BG_RBLD_OR_CHECK_FAILED_DRIVE_FAILED:
+			shost_printk(KERN_INFO, cb->host,
+				     "Consistency Check Failed - Physical Device Failed\n");
+			break;
+		case MYRB_BG_RBLD_OR_CHECK_FAILED_LDEV_FAILED:
+			shost_printk(KERN_INFO, cb->host,
+				     "Consistency Check Failed - Logical Drive Failed\n");
+			break;
+		case MYRB_BG_RBLD_OR_CHECK_FAILED_OTHER:
+			shost_printk(KERN_INFO, cb->host,
+				     "Consistency Check Failed - Other Causes\n");
+			break;
+		case MYRB_BG_RBLD_OR_CHECK_SUCCESS_TERMINATED:
+			shost_printk(KERN_INFO, cb->host,
+				     "Consistency Check Successfully Terminated\n");
+			break;
+		}
+	else if (new->rbld == MYRB_BG_CHECK_IN_PROGRESS)
+		cb->need_cc_status = true;
+
+	return MYRB_STATUS_SUCCESS;
+}
+
+/**
+ * myrb_set_pdev_state - sets the device state for a physical device
+ *
+ * Return: command status
+ */
+static unsigned short myrb_set_pdev_state(struct myrb_hba *cb,
+		struct scsi_device *sdev, enum myrb_devstate state)
+{
+	struct myrb_cmdblk *cmd_blk = &cb->dcmd_blk;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned short status;
+
+	mutex_lock(&cb->dcmd_mutex);
+	mbox->type3D.opcode = MYRB_CMD_START_DEVICE;
+	mbox->type3D.id = MYRB_DCMD_TAG;
+	mbox->type3D.channel = sdev->channel;
+	mbox->type3D.target = sdev->id;
+	mbox->type3D.state = state & 0x1F;
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
+ */
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
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
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
+		MYRB_MAX_CHANNELS * MYRB_MAX_TARGETS;
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
+	cb->cmd_mbox_size =  MYRB_CMD_MBOX_COUNT * sizeof(union myrb_cmd_mbox);
+	cb->first_cmd_mbox = dma_alloc_coherent(&pdev->dev,
+						cb->cmd_mbox_size,
+						&cb->cmd_mbox_addr,
+						GFP_KERNEL);
+	if (!cb->first_cmd_mbox)
+		return false;
+
+	cmd_mbox_mem = cb->first_cmd_mbox;
+	cmd_mbox_mem += MYRB_CMD_MBOX_COUNT - 1;
+	cb->last_cmd_mbox = cmd_mbox_mem;
+	cb->next_cmd_mbox = cb->first_cmd_mbox;
+	cb->prev_cmd_mbox1 = cb->last_cmd_mbox;
+	cb->prev_cmd_mbox2 = cb->last_cmd_mbox - 1;
+
+	/* These are the base addresses for the status memory mailbox array */
+	cb->stat_mbox_size = MYRB_STAT_MBOX_COUNT *
+	    sizeof(struct myrb_stat_mbox);
+	cb->first_stat_mbox = dma_alloc_coherent(&pdev->dev,
+						 cb->stat_mbox_size,
+						 &cb->stat_mbox_addr,
+						 GFP_KERNEL);
+	if (!cb->first_stat_mbox)
+		return false;
+
+	stat_mbox_mem = cb->first_stat_mbox;
+	stat_mbox_mem += MYRB_STAT_MBOX_COUNT - 1;
+	cb->last_stat_mbox = stat_mbox_mem;
+	cb->next_stat_mbox = cb->first_stat_mbox;
+
+	/* Enable the Memory Mailbox Interface. */
+	cb->dual_mode_interface = true;
+	mbox.typeX.opcode = 0x2B;
+	mbox.typeX.id = 0;
+	mbox.typeX.opcode2 = 0x14;
+	mbox.typeX.cmd_mbox_addr = cb->cmd_mbox_addr;
+	mbox.typeX.stat_mbox_addr = cb->stat_mbox_addr;
+
+	status = mmio_init_fn(pdev, base, &mbox);
+	if (status != MYRB_STATUS_SUCCESS) {
+		cb->dual_mode_interface = false;
+		mbox.typeX.opcode2 = 0x10;
+		status = mmio_init_fn(pdev, base, &mbox);
+		if (status != MYRB_STATUS_SUCCESS) {
+			dev_err(&pdev->dev,
+				"Failed to enable mailbox, statux %02X\n",
+				status);
+			return false;
+		}
+	}
+	return true;
+}
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
+	if (status != MYRB_STATUS_SUCCESS) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed it issue V1 Enquiry\n");
+		goto out_free;
+	}
+
+	status = myrb_exec_type3(cb, MYRB_CMD_ENQUIRY2, enquiry2_addr);
+	if (status != MYRB_STATUS_SUCCESS) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed to issue V1 Enquiry2\n");
+		goto out_free;
+	}
+
+	status = myrb_exec_type3(cb, MYRB_CMD_READ_CONFIG2, config2_addr);
+	if (status != MYRB_STATUS_SUCCESS) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed to issue ReadConfig2\n");
+		goto out_free;
+	}
+
+	status = myrb_get_ldev_info(cb);
+	if (status != MYRB_STATUS_SUCCESS) {
+		shost_printk(KERN_WARNING, cb->host,
+			     "Failed to get logical drive information\n");
+		goto out_free;
+	}
+
+	/*
+	 * Initialize the Controller Model Name and Full Model Name fields.
+	 */
+	switch (enquiry2->hw.sub_model) {
+	case DAC960_V1_P_PD_PU:
+		if (enquiry2->scsi_cap.bus_speed == MYRB_SCSI_SPEED_ULTRA)
+			strcpy(cb->model_name, "DAC960PU");
+		else
+			strcpy(cb->model_name, "DAC960PD");
+		break;
+	case DAC960_V1_PL:
+		strcpy(cb->model_name, "DAC960PL");
+		break;
+	case DAC960_V1_PG:
+		strcpy(cb->model_name, "DAC960PG");
+		break;
+	case DAC960_V1_PJ:
+		strcpy(cb->model_name, "DAC960PJ");
+		break;
+	case DAC960_V1_PR:
+		strcpy(cb->model_name, "DAC960PR");
+		break;
+	case DAC960_V1_PT:
+		strcpy(cb->model_name, "DAC960PT");
+		break;
+	case DAC960_V1_PTL0:
+		strcpy(cb->model_name, "DAC960PTL0");
+		break;
+	case DAC960_V1_PRL:
+		strcpy(cb->model_name, "DAC960PRL");
+		break;
+	case DAC960_V1_PTL1:
+		strcpy(cb->model_name, "DAC960PTL1");
+		break;
+	case DAC960_V1_1164P:
+		strcpy(cb->model_name, "eXtremeRAID 1100");
+		break;
+	default:
+		shost_printk(KERN_WARNING, cb->host,
+			     "Unknown Model %X\n",
+			     enquiry2->hw.sub_model);
+		goto out;
+	}
+	/*
+	 * Initialize the Controller Firmware Version field and verify that it
+	 * is a supported firmware version.
+	 * The supported firmware versions are:
+	 *
+	 * DAC1164P		    5.06 and above
+	 * DAC960PTL/PRL/PJ/PG	    4.06 and above
+	 * DAC960PU/PD/PL	    3.51 and above
+	 * DAC960PU/PD/PL/P	    2.73 and above
+	 */
+#if defined(CONFIG_ALPHA)
+	/*
+	 * DEC Alpha machines were often equipped with DAC960 cards that were
+	 * OEMed from Mylex, and had their own custom firmware. Version 2.70,
+	 * the last custom FW revision to be released by DEC for these older
+	 * controllers, appears to work quite well with this driver.
+	 *
+	 * Cards tested successfully were several versions each of the PD and
+	 * PU, called by DEC the KZPSC and KZPAC, respectively, and having
+	 * the Manufacturer Numbers (from Mylex), usually on a sticker on the
+	 * back of the board, of:
+	 *
+	 * KZPSC:  D040347 (1-channel) or D040348 (2-channel)
+	 *         or D040349 (3-channel)
+	 * KZPAC:  D040395 (1-channel) or D040396 (2-channel)
+	 *         or D040397 (3-channel)
+	 */
+# define FIRMWARE_27X	"2.70"
+#else
+# define FIRMWARE_27X	"2.73"
+#endif
+
+	if (enquiry2->fw.major_version == 0) {
+		enquiry2->fw.major_version = cb->enquiry->fw_major_version;
+		enquiry2->fw.minor_version = cb->enquiry->fw_minor_version;
+		enquiry2->fw.firmware_type = '0';
+		enquiry2->fw.turn_id = 0;
+	}
+	sprintf(cb->fw_version, "%d.%02d-%c-%02d",
+		enquiry2->fw.major_version,
+		enquiry2->fw.minor_version,
+		enquiry2->fw.firmware_type,
+		enquiry2->fw.turn_id);
+	if (!((enquiry2->fw.major_version == 5 &&
+	       enquiry2->fw.minor_version >= 6) ||
+	      (enquiry2->fw.major_version == 4 &&
+	       enquiry2->fw.minor_version >= 6) ||
+	      (enquiry2->fw.major_version == 3 &&
+	       enquiry2->fw.minor_version >= 51) ||
+	      (enquiry2->fw.major_version == 2 &&
+	       strcmp(cb->fw_version, FIRMWARE_27X) >= 0))) {
+		shost_printk(KERN_WARNING, cb->host,
+			"Firmware Version '%s' unsupported\n",
+			cb->fw_version);
+		goto out;
+	}
+	/*
+	 * Initialize the Channels, Targets, Memory Size, and SAF-TE
+	 * Enclosure Management Enabled fields.
+	 */
+	switch (enquiry2->hw.model) {
+	case MYRB_5_CHANNEL_BOARD:
+		pchan_max = 5;
+		break;
+	case MYRB_3_CHANNEL_BOARD:
+	case MYRB_3_CHANNEL_ASIC_DAC:
+		pchan_max = 3;
+		break;
+	case MYRB_2_CHANNEL_BOARD:
+		pchan_max = 2;
+		break;
+	default:
+		pchan_max = enquiry2->cfg_chan;
+		break;
+	}
+	pchan_cur = enquiry2->cur_chan;
+	if (enquiry2->scsi_cap.bus_width == MYRB_WIDTH_WIDE_32BIT)
+		cb->bus_width = 32;
+	else if (enquiry2->scsi_cap.bus_width == MYRB_WIDTH_WIDE_16BIT)
+		cb->bus_width = 16;
+	else
+		cb->bus_width = 8;
+	cb->ldev_block_size = enquiry2->ldev_block_size;
+	shost->max_channel = pchan_cur;
+	shost->max_id = enquiry2->max_targets;
+	memsize = enquiry2->mem_size >> 20;
+	cb->safte_enabled = (enquiry2->fault_mgmt == MYRB_FAULT_SAFTE);
+	/*
+	 * Initialize the Controller Queue Depth, Driver Queue Depth,
+	 * Logical Drive Count, Maximum Blocks per Command, Controller
+	 * Scatter/Gather Limit, and Driver Scatter/Gather Limit.
+	 * The Driver Queue Depth must be at most one less than the
+	 * Controller Queue Depth to allow for an automatic drive
+	 * rebuild operation.
+	 */
+	shost->can_queue = cb->enquiry->max_tcq;
+	if (shost->can_queue < 3)
+		shost->can_queue = enquiry2->max_cmds;
+	if (shost->can_queue < 3)
+		/* Play safe and disable TCQ */
+		shost->can_queue = 1;
+
+	if (shost->can_queue > MYRB_CMD_MBOX_COUNT - 2)
+		shost->can_queue = MYRB_CMD_MBOX_COUNT - 2;
+	shost->max_sectors = enquiry2->max_sectors;
+	shost->sg_tablesize = enquiry2->max_sge;
+	if (shost->sg_tablesize > MYRB_SCATTER_GATHER_LIMIT)
+		shost->sg_tablesize = MYRB_SCATTER_GATHER_LIMIT;
+	/*
+	 * Initialize the Stripe Size, Segment Size, and Geometry Translation.
+	 */
+	cb->stripe_size = config2->blocks_per_stripe * config2->block_factor
+		>> (10 - MYRB_BLKSIZE_BITS);
+	cb->segment_size = config2->blocks_per_cacheline * config2->block_factor
+		>> (10 - MYRB_BLKSIZE_BITS);
+	/* Assume 255/63 translation */
+	cb->ldev_geom_heads = 255;
+	cb->ldev_geom_sectors = 63;
+	if (config2->drive_geometry) {
+		cb->ldev_geom_heads = 128;
+		cb->ldev_geom_sectors = 32;
+	}
+
+	/*
+	 * Initialize the Background Initialization Status.
+	 */
+	if ((cb->fw_version[0] == '4' &&
+	     strcmp(cb->fw_version, "4.08") >= 0) ||
+	    (cb->fw_version[0] == '5' &&
+	     strcmp(cb->fw_version, "5.08") >= 0)) {
+		cb->bgi_status_supported = true;
+		myrb_bgi_control(cb);
+	}
+	cb->last_rbld_status = MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS;
+	ret = 0;
+
+out:
+	shost_printk(KERN_INFO, cb->host,
+		"Configuring %s PCI RAID Controller\n", cb->model_name);
+	shost_printk(KERN_INFO, cb->host,
+		"  Firmware Version: %s, Memory Size: %dMB\n",
+		cb->fw_version, memsize);
+	if (cb->io_addr == 0)
+		shost_printk(KERN_INFO, cb->host,
+			"  I/O Address: n/a, PCI Address: 0x%lX, IRQ Channel: %d\n",
+			(unsigned long)cb->pci_addr, cb->irq);
+	else
+		shost_printk(KERN_INFO, cb->host,
+			"  I/O Address: 0x%lX, PCI Address: 0x%lX, IRQ Channel: %d\n",
+			(unsigned long)cb->io_addr, (unsigned long)cb->pci_addr,
+			cb->irq);
+	shost_printk(KERN_INFO, cb->host,
+		"  Controller Queue Depth: %d, Maximum Blocks per Command: %d\n",
+		cb->host->can_queue, cb->host->max_sectors);
+	shost_printk(KERN_INFO, cb->host,
+		     "  Driver Queue Depth: %d, Scatter/Gather Limit: %d of %d Segments\n",
+		     cb->host->can_queue, cb->host->sg_tablesize,
+		     MYRB_SCATTER_GATHER_LIMIT);
+	shost_printk(KERN_INFO, cb->host,
+		     "  Stripe Size: %dKB, Segment Size: %dKB, BIOS Geometry: %d/%d%s\n",
+		     cb->stripe_size, cb->segment_size,
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
+			MYRB_MAX_CHANNELS * MYRB_MAX_TARGETS;
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
+	struct myrb_hba *cb = shost_priv(shost);
+
+	cb->reset(cb->io_base);
+	return SUCCESS;
+}
+
+static int myrb_pthru_queuecommand(struct Scsi_Host *shost,
+		struct scsi_cmnd *scmd)
+{
+	struct myrb_hba *cb = shost_priv(shost);
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
+	mbox->type3.opcode = MYRB_CMD_DCDB;
+	mbox->type3.id = scmd->request->tag + 3;
+	mbox->type3.addr = dcdb_addr;
+	dcdb->channel = sdev->channel;
+	dcdb->target = sdev->id;
+	switch (scmd->sc_data_direction) {
+	case DMA_NONE:
+		dcdb->data_xfer = MYRB_DCDB_XFER_NONE;
+		break;
+	case DMA_TO_DEVICE:
+		dcdb->data_xfer = MYRB_DCDB_XFER_SYSTEM_TO_DEVICE;
+		break;
+	case DMA_FROM_DEVICE:
+		dcdb->data_xfer = MYRB_DCDB_XFER_DEVICE_TO_SYSTEM;
+		break;
+	default:
+		dcdb->data_xfer = MYRB_DCDB_XFER_ILLEGAL;
+		break;
+	}
+	dcdb->early_status = false;
+	if (scmd->request->timeout <= 10)
+		dcdb->timeout = MYRB_DCDB_TMO_10_SECS;
+	else if (scmd->request->timeout <= 60)
+		dcdb->timeout = MYRB_DCDB_TMO_60_SECS;
+	else if (scmd->request->timeout <= 600)
+		dcdb->timeout = MYRB_DCDB_TMO_10_MINS;
+	else
+		dcdb->timeout = MYRB_DCDB_TMO_24_HRS;
+	dcdb->no_autosense = false;
+	dcdb->allow_disconnect = true;
+	sgl = scsi_sglist(scmd);
+	dcdb->dma_addr = sg_dma_address(sgl);
+	if (sg_dma_len(sgl) > USHRT_MAX) {
+		dcdb->xfer_len_lo = sg_dma_len(sgl) & 0xffff;
+		dcdb->xfer_len_hi4 = sg_dma_len(sgl) >> 16;
+	} else {
+		dcdb->xfer_len_lo = sg_dma_len(sgl);
+		dcdb->xfer_len_hi4 = 0;
+	}
+	dcdb->cdb_len = scmd->cmd_len;
+	dcdb->sense_len = sizeof(dcdb->sense);
+	memcpy(&dcdb->cdb, scmd->cmnd, scmd->cmd_len);
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	cb->qcmd(cb, cmd_blk);
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return 0;
+}
+
+static void myrb_inquiry(struct myrb_hba *cb,
+		struct scsi_cmnd *scmd)
+{
+	unsigned char inq[36] = {
+		0x00, 0x00, 0x03, 0x02, 0x20, 0x00, 0x01, 0x00,
+		0x4d, 0x59, 0x4c, 0x45, 0x58, 0x20, 0x20, 0x20,
+		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+		0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20,
+		0x20, 0x20, 0x20, 0x20,
+	};
+
+	if (cb->bus_width > 16)
+		inq[7] |= 1 << 6;
+	if (cb->bus_width > 8)
+		inq[7] |= 1 << 5;
+	memcpy(&inq[16], cb->model_name, 16);
+	memcpy(&inq[32], cb->fw_version, 1);
+	memcpy(&inq[33], &cb->fw_version[2], 2);
+	memcpy(&inq[35], &cb->fw_version[7], 1);
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
+
+		modes[3] = 8;
+		put_unaligned_be32(ldev_info->size, &block_desc[0]);
+		put_unaligned_be32(cb->ldev_block_size, &block_desc[5]);
+	}
+	mode_pg[0] = 0x08;
+	mode_pg[1] = 0x12;
+	if (ldev_info->wb_enabled)
+		mode_pg[2] |= 0x04;
+	if (cb->segment_size) {
+		mode_pg[2] |= 0x08;
+		put_unaligned_be16(cb->segment_size, &mode_pg[14]);
+	}
+
+	scsi_sg_copy_from_buffer(scmd, modes, mode_len);
+}
+
+static void myrb_request_sense(struct myrb_hba *cb,
+		struct scsi_cmnd *scmd)
+{
+	scsi_build_sense_buffer(0, scmd->sense_buffer,
+				NO_SENSE, 0, 0);
+	scsi_sg_copy_from_buffer(scmd, scmd->sense_buffer,
+				 SCSI_SENSE_BUFFERSIZE);
+}
+
+static void myrb_read_capacity(struct myrb_hba *cb, struct scsi_cmnd *scmd,
+		struct myrb_ldev_info *ldev_info)
+{
+	unsigned char data[8];
+
+	dev_dbg(&scmd->device->sdev_gendev,
+		"Capacity %u, blocksize %u\n",
+		ldev_info->size, cb->ldev_block_size);
+	put_unaligned_be32(ldev_info->size - 1, &data[0]);
+	put_unaligned_be32(cb->ldev_block_size, &data[4]);
+	scsi_sg_copy_from_buffer(scmd, data, 8);
+}
+
+static int myrb_ldev_queuecommand(struct Scsi_Host *shost,
+		struct scsi_cmnd *scmd)
+{
+	struct myrb_hba *cb = shost_priv(shost);
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
+	if (ldev_info->state != MYRB_DEVICE_ONLINE &&
+	    ldev_info->state != MYRB_DEVICE_WO) {
+		dev_dbg(&shost->shost_gendev, "ldev %u in state %x, skip\n",
+			sdev->id, ldev_info ? ldev_info->state : 0xff);
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
+	case SYNCHRONIZE_CACHE:
+		scmd->result = (DID_OK << 16);
+		scmd->scsi_done(scmd);
+		return 0;
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
+	case READ_6:
+		if (ldev_info->state == MYRB_DEVICE_WO) {
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
+		if (ldev_info->state == MYRB_DEVICE_WO) {
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
+		if (ldev_info->state == MYRB_DEVICE_WO) {
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
+	mbox->type5.id = scmd->request->tag + 3;
+	if (scmd->sc_data_direction == DMA_NONE)
+		goto submit;
+	nsge = scsi_dma_map(scmd);
+	if (nsge == 1) {
+		sgl = scsi_sglist(scmd);
+		if (scmd->sc_data_direction == DMA_FROM_DEVICE)
+			mbox->type5.opcode = MYRB_CMD_READ;
+		else
+			mbox->type5.opcode = MYRB_CMD_WRITE;
+
+		mbox->type5.ld.xfer_len = block_cnt;
+		mbox->type5.ld.ldev_num = sdev->id;
+		mbox->type5.lba = lba;
+		mbox->type5.addr = (u32)sg_dma_address(sgl);
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
+			mbox->type5.opcode = MYRB_CMD_READ_SG;
+		else
+			mbox->type5.opcode = MYRB_CMD_WRITE_SG;
+
+		mbox->type5.ld.xfer_len = block_cnt;
+		mbox->type5.ld.ldev_num = sdev->id;
+		mbox->type5.lba = lba;
+		mbox->type5.addr = hw_sgl_addr;
+		mbox->type5.sg_count = nsge;
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
+		struct scsi_cmnd *scmd)
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
+static int myrb_ldev_slave_alloc(struct scsi_device *sdev)
+{
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_ldev_info *ldev_info;
+	unsigned short ldev_num = sdev->id;
+	enum raid_level level;
+
+	ldev_info = cb->ldev_info_buf + ldev_num;
+	if (!ldev_info)
+		return -ENXIO;
+
+	sdev->hostdata = kzalloc(sizeof(*ldev_info), GFP_KERNEL);
+	if (!sdev->hostdata)
+		return -ENOMEM;
+	dev_dbg(&sdev->sdev_gendev,
+		"slave alloc ldev %d state %x\n",
+		ldev_num, ldev_info->state);
+	memcpy(sdev->hostdata, ldev_info,
+	       sizeof(*ldev_info));
+	switch (ldev_info->raid_level) {
+	case MYRB_RAID_LEVEL0:
+		level = RAID_LEVEL_LINEAR;
+		break;
+	case MYRB_RAID_LEVEL1:
+		level = RAID_LEVEL_1;
+		break;
+	case MYRB_RAID_LEVEL3:
+		level = RAID_LEVEL_3;
+		break;
+	case MYRB_RAID_LEVEL5:
+		level = RAID_LEVEL_5;
+		break;
+	case MYRB_RAID_LEVEL6:
+		level = RAID_LEVEL_6;
+		break;
+	case MYRB_RAID_JBOD:
+		level = RAID_LEVEL_JBOD;
+		break;
+	default:
+		level = RAID_LEVEL_UNKNOWN;
+		break;
+	}
+	raid_set_level(myrb_raid_template, &sdev->sdev_gendev, level);
+	return 0;
+}
+
+static int myrb_pdev_slave_alloc(struct scsi_device *sdev)
+{
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_pdev_state *pdev_info;
+	unsigned short status;
+
+	if (sdev->id > MYRB_MAX_TARGETS)
+		return -ENXIO;
+
+	pdev_info = kzalloc(sizeof(*pdev_info), GFP_KERNEL|GFP_DMA);
+	if (!pdev_info)
+		return -ENOMEM;
+
+	status = myrb_exec_type3D(cb, MYRB_CMD_GET_DEVICE_STATE,
+				  sdev, pdev_info);
+	if (status != MYRB_STATUS_SUCCESS) {
+		dev_dbg(&sdev->sdev_gendev,
+			"Failed to get device state, status %x\n",
+			status);
+		kfree(pdev_info);
+		return -ENXIO;
+	}
+	if (!pdev_info->present) {
+		dev_dbg(&sdev->sdev_gendev,
+			"device not present, skip\n");
+		kfree(pdev_info);
+		return -ENXIO;
+	}
+	dev_dbg(&sdev->sdev_gendev,
+		"slave alloc pdev %d:%d state %x\n",
+		sdev->channel, sdev->id, pdev_info->state);
+	sdev->hostdata = pdev_info;
+
+	return 0;
+}
+
+static int myrb_slave_alloc(struct scsi_device *sdev)
+{
+	if (sdev->channel > myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	if (sdev->lun > 0)
+		return -ENXIO;
+
+	if (sdev->channel == myrb_logical_channel(sdev->host))
+		return myrb_ldev_slave_alloc(sdev);
+
+	return myrb_pdev_slave_alloc(sdev);
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
+	if (ldev_info->state != MYRB_DEVICE_ONLINE)
+		sdev_printk(KERN_INFO, sdev,
+			    "Logical drive is %s\n",
+			    myrb_devstate_name(ldev_info->state));
+
+	sdev->tagged_supported = 1;
+	return 0;
+}
+
+static void myrb_slave_destroy(struct scsi_device *sdev)
+{
+	kfree(sdev->hostdata);
+}
+
+static int myrb_biosparam(struct scsi_device *sdev, struct block_device *bdev,
+		sector_t capacity, int geom[])
+{
+	struct myrb_hba *cb = shost_priv(sdev->host);
+
+	geom[0] = cb->ldev_geom_heads;
+	geom[1] = cb->ldev_geom_sectors;
+	geom[2] = sector_div(capacity, geom[0] * geom[1]);
+
+	return 0;
+}
+
+static ssize_t raid_state_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	int ret;
+
+	if (!sdev->hostdata)
+		return snprintf(buf, 16, "Unknown\n");
+
+	if (sdev->channel == myrb_logical_channel(sdev->host)) {
+		struct myrb_ldev_info *ldev_info = sdev->hostdata;
+		const char *name;
+
+		name = myrb_devstate_name(ldev_info->state);
+		if (name)
+			ret = snprintf(buf, 32, "%s\n", name);
+		else
+			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+				       ldev_info->state);
+	} else {
+		struct myrb_pdev_state *pdev_info = sdev->hostdata;
+		unsigned short status;
+		const char *name;
+
+		status = myrb_exec_type3D(cb, MYRB_CMD_GET_DEVICE_STATE,
+					  sdev, pdev_info);
+		if (status != MYRB_STATUS_SUCCESS)
+			sdev_printk(KERN_INFO, sdev,
+				    "Failed to get device state, status %x\n",
+				    status);
+
+		if (!pdev_info->present)
+			name = "Removed";
+		else
+			name = myrb_devstate_name(pdev_info->state);
+		if (name)
+			ret = snprintf(buf, 32, "%s\n", name);
+		else
+			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+				       pdev_info->state);
+	}
+	return ret;
+}
+
+static ssize_t raid_state_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_pdev_state *pdev_info;
+	enum myrb_devstate new_state;
+	unsigned short status;
+
+	if (!strncmp(buf, "kill", 4) ||
+	    !strncmp(buf, "offline", 7))
+		new_state = MYRB_DEVICE_DEAD;
+	else if (!strncmp(buf, "online", 6))
+		new_state = MYRB_DEVICE_ONLINE;
+	else if (!strncmp(buf, "standby", 7))
+		new_state = MYRB_DEVICE_STANDBY;
+	else
+		return -EINVAL;
+
+	pdev_info = sdev->hostdata;
+	if (!pdev_info) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed - no physical device information\n");
+		return -ENXIO;
+	}
+	if (!pdev_info->present) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed - device not present\n");
+		return -ENXIO;
+	}
+
+	if (pdev_info->state == new_state)
+		return count;
+
+	status = myrb_set_pdev_state(cb, sdev, new_state);
+	switch (status) {
+	case MYRB_STATUS_SUCCESS:
+		break;
+	case MYRB_STATUS_START_DEVICE_FAILED:
+		sdev_printk(KERN_INFO, sdev,
+			     "Failed - Unable to Start Device\n");
+		count = -EAGAIN;
+		break;
+	case MYRB_STATUS_NO_DEVICE:
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed - No Device at Address\n");
+		count = -ENODEV;
+		break;
+	case MYRB_STATUS_INVALID_CHANNEL_OR_TARGET:
+		sdev_printk(KERN_INFO, sdev,
+			 "Failed - Invalid Channel or Target or Modifier\n");
+		count = -EINVAL;
+		break;
+	case MYRB_STATUS_CHANNEL_BUSY:
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
+static DEVICE_ATTR_RW(raid_state);
+
+static ssize_t raid_level_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
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
+		name = myrb_raidlevel_name(ldev_info->raid_level);
+		if (!name)
+			return snprintf(buf, 32, "Invalid (%02X)\n",
+					ldev_info->state);
+		return snprintf(buf, 32, "%s\n", name);
+	}
+	return snprintf(buf, 32, "Physical Drive\n");
+}
+static DEVICE_ATTR_RO(raid_level);
+
+static ssize_t rebuild_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_rbld_progress rbld_buf;
+	unsigned char status;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host))
+		return snprintf(buf, 32, "physical device - not rebuilding\n");
+
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+
+	if (rbld_buf.ldev_num != sdev->id ||
+	    status != MYRB_STATUS_SUCCESS)
+		return snprintf(buf, 32, "not rebuilding\n");
+
+	return snprintf(buf, 32, "rebuilding block %u of %u\n",
+			rbld_buf.ldev_size - rbld_buf.blocks_left,
+			rbld_buf.ldev_size);
+}
+
+static ssize_t rebuild_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_cmdblk *cmd_blk;
+	union myrb_cmd_mbox *mbox;
+	unsigned short status;
+	int rc, start;
+	const char *msg;
+
+	rc = kstrtoint(buf, 0, &start);
+	if (rc)
+		return rc;
+
+	if (sdev->channel >= myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	status = myrb_get_rbld_progress(cb, NULL);
+	if (start) {
+		if (status == MYRB_STATUS_SUCCESS) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Not Initiated; already in progress\n");
+			return -EALREADY;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->type3D.opcode = MYRB_CMD_REBUILD_ASYNC;
+		mbox->type3D.id = MYRB_DCMD_TAG;
+		mbox->type3D.channel = sdev->channel;
+		mbox->type3D.target = sdev->id;
+		status = myrb_exec_cmd(cb, cmd_blk);
+		mutex_unlock(&cb->dcmd_mutex);
+	} else {
+		struct pci_dev *pdev = cb->pdev;
+		unsigned char *rate;
+		dma_addr_t rate_addr;
+
+		if (status != MYRB_STATUS_SUCCESS) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Rebuild Not Cancelled; not in progress\n");
+			return 0;
+		}
+
+		rate = dma_alloc_coherent(&pdev->dev, sizeof(char),
+					  &rate_addr, GFP_KERNEL);
+		if (rate == NULL) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Cancellation of Rebuild Failed - Out of Memory\n");
+			return -ENOMEM;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->type3R.opcode = MYRB_CMD_REBUILD_CONTROL;
+		mbox->type3R.id = MYRB_DCMD_TAG;
+		mbox->type3R.rbld_rate = 0xFF;
+		mbox->type3R.addr = rate_addr;
+		status = myrb_exec_cmd(cb, cmd_blk);
+		dma_free_coherent(&pdev->dev, sizeof(char), rate, rate_addr);
+		mutex_unlock(&cb->dcmd_mutex);
+	}
+	if (status == MYRB_STATUS_SUCCESS) {
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
+	case MYRB_STATUS_ATTEMPT_TO_RBLD_ONLINE_DRIVE:
+		msg = "Attempt to Rebuild Online or Unresponsive Drive";
+		break;
+	case MYRB_STATUS_RBLD_NEW_DISK_FAILED:
+		msg = "New Disk Failed During Rebuild";
+		break;
+	case MYRB_STATUS_INVALID_ADDRESS:
+		msg = "Invalid Device Address";
+		break;
+	case MYRB_STATUS_RBLD_OR_CHECK_INPROGRESS:
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
+static DEVICE_ATTR_RW(rebuild);
+
+static ssize_t consistency_check_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_rbld_progress rbld_buf;
+	struct myrb_cmdblk *cmd_blk;
+	union myrb_cmd_mbox *mbox;
+	unsigned short ldev_num = 0xFFFF;
+	unsigned short status;
+	int rc, start;
+	const char *msg;
+
+	rc = kstrtoint(buf, 0, &start);
+	if (rc)
+		return rc;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host))
+		return -ENXIO;
+
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+	if (start) {
+		if (status == MYRB_STATUS_SUCCESS) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Check Consistency Not Initiated; already in progress\n");
+			return -EALREADY;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->type3C.opcode = MYRB_CMD_CHECK_CONSISTENCY_ASYNC;
+		mbox->type3C.id = MYRB_DCMD_TAG;
+		mbox->type3C.ldev_num = sdev->id;
+		mbox->type3C.auto_restore = true;
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
+				    "Check Consistency Not Cancelled; not in progress\n");
+			return 0;
+		}
+		rate = dma_alloc_coherent(&pdev->dev, sizeof(char),
+					  &rate_addr, GFP_KERNEL);
+		if (rate == NULL) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Cancellation of Check Consistency Failed - Out of Memory\n");
+			return -ENOMEM;
+		}
+		mutex_lock(&cb->dcmd_mutex);
+		cmd_blk = &cb->dcmd_blk;
+		myrb_reset_cmd(cmd_blk);
+		mbox = &cmd_blk->mbox;
+		mbox->type3R.opcode = MYRB_CMD_REBUILD_CONTROL;
+		mbox->type3R.id = MYRB_DCMD_TAG;
+		mbox->type3R.rbld_rate = 0xFF;
+		mbox->type3R.addr = rate_addr;
+		status = myrb_exec_cmd(cb, cmd_blk);
+		dma_free_coherent(&pdev->dev, sizeof(char), rate, rate_addr);
+		mutex_unlock(&cb->dcmd_mutex);
+	}
+	if (status == MYRB_STATUS_SUCCESS) {
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
+	case MYRB_STATUS_ATTEMPT_TO_RBLD_ONLINE_DRIVE:
+		msg = "Dependent Physical Device is DEAD";
+		break;
+	case MYRB_STATUS_RBLD_NEW_DISK_FAILED:
+		msg = "New Disk Failed During Rebuild";
+		break;
+	case MYRB_STATUS_INVALID_ADDRESS:
+		msg = "Invalid or Nonredundant Logical Drive";
+		break;
+	case MYRB_STATUS_RBLD_OR_CHECK_INPROGRESS:
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
+
+static ssize_t consistency_check_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return rebuild_show(dev, attr, buf);
+}
+static DEVICE_ATTR_RW(consistency_check);
+
+static ssize_t ctlr_num_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = shost_priv(shost);
+
+	return snprintf(buf, 20, "%d\n", cb->ctlr_num);
+}
+static DEVICE_ATTR_RO(ctlr_num);
+
+static ssize_t firmware_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = shost_priv(shost);
+
+	return snprintf(buf, 16, "%s\n", cb->fw_version);
+}
+static DEVICE_ATTR_RO(firmware);
+
+static ssize_t model_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = shost_priv(shost);
+
+	return snprintf(buf, 16, "%s\n", cb->model_name);
+}
+static DEVICE_ATTR_RO(model);
+
+static ssize_t flush_cache_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrb_hba *cb = shost_priv(shost);
+	unsigned short status;
+
+	status = myrb_exec_type3(cb, MYRB_CMD_FLUSH, 0);
+	if (status == MYRB_STATUS_SUCCESS) {
+		shost_printk(KERN_INFO, shost,
+			     "Cache Flush Completed\n");
+		return count;
+	}
+	shost_printk(KERN_INFO, shost,
+		     "Cache Flush Failed, status %x\n", status);
+	return -EIO;
+}
+static DEVICE_ATTR_WO(flush_cache);
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
+	.module			= THIS_MODULE,
+	.name			= "DAC960",
+	.proc_name		= "myrb",
+	.queuecommand		= myrb_queuecommand,
+	.eh_host_reset_handler	= myrb_host_reset,
+	.slave_alloc		= myrb_slave_alloc,
+	.slave_configure	= myrb_slave_configure,
+	.slave_destroy		= myrb_slave_destroy,
+	.bios_param		= myrb_biosparam,
+	.cmd_size		= sizeof(struct myrb_cmdblk),
+	.shost_attrs		= myrb_shost_attrs,
+	.sdev_attrs		= myrb_sdev_attrs,
+	.this_id		= -1,
+};
+
+/**
+ * myrb_is_raid - return boolean indicating device is raid volume
+ * @dev the device struct object
+ */
+static int myrb_is_raid(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+
+	return sdev->channel == myrb_logical_channel(sdev->host);
+}
+
+/**
+ * myrb_get_resync - get raid volume resync percent complete
+ * @dev the device struct object
+ */
+static void myrb_get_resync(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_rbld_progress rbld_buf;
+	unsigned int percent_complete = 0;
+	unsigned short status;
+	unsigned int ldev_size = 0, remaining = 0;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host))
+		return;
+	status = myrb_get_rbld_progress(cb, &rbld_buf);
+	if (status == MYRB_STATUS_SUCCESS) {
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
+static void myrb_get_state(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrb_hba *cb = shost_priv(sdev->host);
+	struct myrb_ldev_info *ldev_info = sdev->hostdata;
+	enum raid_state state = RAID_STATE_UNKNOWN;
+	unsigned short status;
+
+	if (sdev->channel < myrb_logical_channel(sdev->host) || !ldev_info)
+		state = RAID_STATE_UNKNOWN;
+	else {
+		status = myrb_get_rbld_progress(cb, NULL);
+		if (status == MYRB_STATUS_SUCCESS)
+			state = RAID_STATE_RESYNCING;
+		else {
+			switch (ldev_info->state) {
+			case MYRB_DEVICE_ONLINE:
+				state = RAID_STATE_ACTIVE;
+				break;
+			case MYRB_DEVICE_WO:
+			case MYRB_DEVICE_CRITICAL:
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
+		struct scsi_cmnd *scmd)
+{
+	unsigned short status;
+
+	if (!cmd_blk)
+		return;
+
+	scsi_dma_unmap(scmd);
+
+	if (cmd_blk->dcdb) {
+		memcpy(scmd->sense_buffer, &cmd_blk->dcdb->sense, 64);
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
+	case MYRB_STATUS_SUCCESS:
+	case MYRB_STATUS_DEVICE_BUSY:
+		scmd->result = (DID_OK << 16) | status;
+		break;
+	case MYRB_STATUS_BAD_DATA:
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
+	case MYRB_STATUS_IRRECOVERABLE_DATA_ERROR:
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
+	case MYRB_STATUS_LDRV_NONEXISTENT_OR_OFFLINE:
+		dev_dbg(&scmd->device->sdev_gendev,
+			    "Logical Drive Nonexistent or Offline");
+		scmd->result = (DID_BAD_TARGET << 16);
+		break;
+	case MYRB_STATUS_ACCESS_BEYOND_END_OF_LDRV:
+		dev_dbg(&scmd->device->sdev_gendev,
+			    "Attempt to Access Beyond End of Logical Drive");
+		/* Logical block address out of range */
+		scsi_build_sense_buffer(0, scmd->sense_buffer,
+					NOT_READY, 0x21, 0);
+		break;
+	case MYRB_STATUS_DEVICE_NONRESPONSIVE:
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
+	if (cmd_blk->completion) {
+		complete(cmd_blk->completion);
+		cmd_blk->completion = NULL;
+	}
+}
+
+static void myrb_monitor(struct work_struct *work)
+{
+	struct myrb_hba *cb = container_of(work,
+			struct myrb_hba, monitor_work.work);
+	struct Scsi_Host *shost = cb->host;
+	unsigned long interval = MYRB_PRIMARY_MONITOR_INTERVAL;
+
+	dev_dbg(&shost->shost_gendev, "monitor tick\n");
+
+	if (cb->new_ev_seq > cb->old_ev_seq) {
+		int event = cb->old_ev_seq;
+
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
+		unsigned char parm0, unsigned char parm1)
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
+static inline void DAC960_LA_hw_mbox_new_cmd(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_HWMBOX_NEW_CMD, base + DAC960_LA_IDB_OFFSET);
+}
+
+static inline void DAC960_LA_ack_hw_mbox_status(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_HWMBOX_ACK_STS, base + DAC960_LA_IDB_OFFSET);
+}
+
+static inline void DAC960_LA_gen_intr(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_GEN_IRQ, base + DAC960_LA_IDB_OFFSET);
+}
+
+static inline void DAC960_LA_reset_ctrl(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_CTRL_RESET, base + DAC960_LA_IDB_OFFSET);
+}
+
+static inline void DAC960_LA_mem_mbox_new_cmd(void __iomem *base)
+{
+	writeb(DAC960_LA_IDB_MMBOX_NEW_CMD, base + DAC960_LA_IDB_OFFSET);
+}
+
+static inline bool DAC960_LA_hw_mbox_is_full(void __iomem *base)
+{
+	unsigned char idb = readb(base + DAC960_LA_IDB_OFFSET);
+
+	return !(idb & DAC960_LA_IDB_HWMBOX_EMPTY);
+}
+
+static inline bool DAC960_LA_init_in_progress(void __iomem *base)
+{
+	unsigned char idb = readb(base + DAC960_LA_IDB_OFFSET);
+
+	return !(idb & DAC960_LA_IDB_INIT_DONE);
+}
+
+static inline void DAC960_LA_ack_hw_mbox_intr(void __iomem *base)
+{
+	writeb(DAC960_LA_ODB_HWMBOX_ACK_IRQ, base + DAC960_LA_ODB_OFFSET);
+}
+
+static inline void DAC960_LA_ack_mem_mbox_intr(void __iomem *base)
+{
+	writeb(DAC960_LA_ODB_MMBOX_ACK_IRQ, base + DAC960_LA_ODB_OFFSET);
+}
+
+static inline void DAC960_LA_ack_intr(void __iomem *base)
+{
+	writeb(DAC960_LA_ODB_HWMBOX_ACK_IRQ | DAC960_LA_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_LA_ODB_OFFSET);
+}
+
+static inline bool DAC960_LA_hw_mbox_status_available(void __iomem *base)
+{
+	unsigned char odb = readb(base + DAC960_LA_ODB_OFFSET);
+
+	return odb & DAC960_LA_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline bool DAC960_LA_mem_mbox_status_available(void __iomem *base)
+{
+	unsigned char odb = readb(base + DAC960_LA_ODB_OFFSET);
+
+	return odb & DAC960_LA_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline void DAC960_LA_enable_intr(void __iomem *base)
+{
+	unsigned char odb = 0xFF;
+
+	odb &= ~DAC960_LA_IRQMASK_DISABLE_IRQ;
+	writeb(odb, base + DAC960_LA_IRQMASK_OFFSET);
+}
+
+static inline void DAC960_LA_disable_intr(void __iomem *base)
+{
+	unsigned char odb = 0xFF;
+
+	odb |= DAC960_LA_IRQMASK_DISABLE_IRQ;
+	writeb(odb, base + DAC960_LA_IRQMASK_OFFSET);
+}
+
+static inline bool DAC960_LA_intr_enabled(void __iomem *base)
+{
+	unsigned char imask = readb(base + DAC960_LA_IRQMASK_OFFSET);
+
+	return !(imask & DAC960_LA_IRQMASK_DISABLE_IRQ);
+}
+
+static inline void DAC960_LA_write_cmd_mbox(union myrb_cmd_mbox *mem_mbox,
+		union myrb_cmd_mbox *mbox)
+{
+	mem_mbox->words[1] = mbox->words[1];
+	mem_mbox->words[2] = mbox->words[2];
+	mem_mbox->words[3] = mbox->words[3];
+	/* Memory barrier to prevent reordering */
+	wmb();
+	mem_mbox->words[0] = mbox->words[0];
+	/* Memory barrier to force PCI access */
+	mb();
+}
+
+static inline void DAC960_LA_write_hw_mbox(void __iomem *base,
+		union myrb_cmd_mbox *mbox)
+{
+	writel(mbox->words[0], base + DAC960_LA_CMDOP_OFFSET);
+	writel(mbox->words[1], base + DAC960_LA_MBOX4_OFFSET);
+	writel(mbox->words[2], base + DAC960_LA_MBOX8_OFFSET);
+	writeb(mbox->bytes[12], base + DAC960_LA_MBOX12_OFFSET);
+}
+
+static inline unsigned char DAC960_LA_read_status_cmd_ident(void __iomem *base)
+{
+	return readb(base + DAC960_LA_STSID_OFFSET);
+}
+
+static inline unsigned short DAC960_LA_read_status(void __iomem *base)
+{
+	return readw(base + DAC960_LA_STS_OFFSET);
+}
+
+static inline bool
+DAC960_LA_read_error_status(void __iomem *base, unsigned char *error,
+		unsigned char *param0, unsigned char *param1)
+{
+	unsigned char errsts = readb(base + DAC960_LA_ERRSTS_OFFSET);
+
+	if (!(errsts & DAC960_LA_ERRSTS_PENDING))
+		return false;
+	errsts &= ~DAC960_LA_ERRSTS_PENDING;
+
+	*error = errsts;
+	*param0 = readb(base + DAC960_LA_CMDOP_OFFSET);
+	*param1 = readb(base + DAC960_LA_CMDID_OFFSET);
+	writeb(0xFF, base + DAC960_LA_ERRSTS_OFFSET);
+	return true;
+}
+
+static inline unsigned short
+DAC960_LA_mbox_init(struct pci_dev *pdev, void __iomem *base,
+		union myrb_cmd_mbox *mbox)
+{
+	unsigned short status;
+	int timeout = 0;
+
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (!DAC960_LA_hw_mbox_is_full(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (DAC960_LA_hw_mbox_is_full(base)) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for empty mailbox\n");
+		return MYRB_STATUS_SUBSYS_TIMEOUT;
+	}
+	DAC960_LA_write_hw_mbox(base, mbox);
+	DAC960_LA_hw_mbox_new_cmd(base);
+	timeout = 0;
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_LA_hw_mbox_status_available(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (!DAC960_LA_hw_mbox_status_available(base)) {
+		dev_err(&pdev->dev, "Timeout waiting for mailbox status\n");
+		return MYRB_STATUS_SUBSYS_TIMEOUT;
+	}
+	status = DAC960_LA_read_status(base);
+	DAC960_LA_ack_hw_mbox_intr(base);
+	DAC960_LA_ack_hw_mbox_status(base);
+
+	return status;
+}
+
+static int DAC960_LA_hw_init(struct pci_dev *pdev,
+		struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	DAC960_LA_disable_intr(base);
+	DAC960_LA_ack_hw_mbox_status(base);
+	udelay(1000);
+	timeout = 0;
+	while (DAC960_LA_init_in_progress(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_LA_read_error_status(base, &error,
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
+	if (!myrb_enable_mmio(cb, DAC960_LA_mbox_init)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_LA_reset_ctrl(base);
+		return -ENODEV;
+	}
+	DAC960_LA_enable_intr(base);
+	cb->qcmd = myrb_qcmd;
+	cb->write_cmd_mbox = DAC960_LA_write_cmd_mbox;
+	if (cb->dual_mode_interface)
+		cb->get_cmd_mbox = DAC960_LA_mem_mbox_new_cmd;
+	else
+		cb->get_cmd_mbox = DAC960_LA_hw_mbox_new_cmd;
+	cb->disable_intr = DAC960_LA_disable_intr;
+	cb->reset = DAC960_LA_reset_ctrl;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_LA_intr_handler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	struct myrb_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	DAC960_LA_ack_intr(base);
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
+		if (cmd_blk) {
+			if (id < 3)
+				myrb_handle_cmdblk(cb, cmd_blk);
+			else
+				myrb_handle_scsi(cb, cmd_blk, scmd);
+		}
+	}
+	cb->next_stat_mbox = next_stat_mbox;
+	spin_unlock_irqrestore(&cb->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrb_privdata DAC960_LA_privdata = {
+	.hw_init =	DAC960_LA_hw_init,
+	.irq_handler =	DAC960_LA_intr_handler,
+	.mmio_size =	DAC960_LA_mmio_size,
+};
+
+/*
+ * DAC960 PG Series Controllers
+ */
+static inline void DAC960_PG_hw_mbox_new_cmd(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_HWMBOX_NEW_CMD, base + DAC960_PG_IDB_OFFSET);
+}
+
+static inline void DAC960_PG_ack_hw_mbox_status(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_HWMBOX_ACK_STS, base + DAC960_PG_IDB_OFFSET);
+}
+
+static inline void DAC960_PG_gen_intr(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_GEN_IRQ, base + DAC960_PG_IDB_OFFSET);
+}
+
+static inline void DAC960_PG_reset_ctrl(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_CTRL_RESET, base + DAC960_PG_IDB_OFFSET);
+}
+
+static inline void DAC960_PG_mem_mbox_new_cmd(void __iomem *base)
+{
+	writel(DAC960_PG_IDB_MMBOX_NEW_CMD, base + DAC960_PG_IDB_OFFSET);
+}
+
+static inline bool DAC960_PG_hw_mbox_is_full(void __iomem *base)
+{
+	unsigned char idb = readl(base + DAC960_PG_IDB_OFFSET);
+
+	return idb & DAC960_PG_IDB_HWMBOX_FULL;
+}
+
+static inline bool DAC960_PG_init_in_progress(void __iomem *base)
+{
+	unsigned char idb = readl(base + DAC960_PG_IDB_OFFSET);
+
+	return idb & DAC960_PG_IDB_INIT_IN_PROGRESS;
+}
+
+static inline void DAC960_PG_ack_hw_mbox_intr(void __iomem *base)
+{
+	writel(DAC960_PG_ODB_HWMBOX_ACK_IRQ, base + DAC960_PG_ODB_OFFSET);
+}
+
+static inline void DAC960_PG_ack_mem_mbox_intr(void __iomem *base)
+{
+	writel(DAC960_PG_ODB_MMBOX_ACK_IRQ, base + DAC960_PG_ODB_OFFSET);
+}
+
+static inline void DAC960_PG_ack_intr(void __iomem *base)
+{
+	writel(DAC960_PG_ODB_HWMBOX_ACK_IRQ | DAC960_PG_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_PG_ODB_OFFSET);
+}
+
+static inline bool DAC960_PG_hw_mbox_status_available(void __iomem *base)
+{
+	unsigned char odb = readl(base + DAC960_PG_ODB_OFFSET);
+
+	return odb & DAC960_PG_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline bool DAC960_PG_mem_mbox_status_available(void __iomem *base)
+{
+	unsigned char odb = readl(base + DAC960_PG_ODB_OFFSET);
+
+	return odb & DAC960_PG_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline void DAC960_PG_enable_intr(void __iomem *base)
+{
+	unsigned int imask = (unsigned int)-1;
+
+	imask &= ~DAC960_PG_IRQMASK_DISABLE_IRQ;
+	writel(imask, base + DAC960_PG_IRQMASK_OFFSET);
+}
+
+static inline void DAC960_PG_disable_intr(void __iomem *base)
+{
+	unsigned int imask = (unsigned int)-1;
+
+	writel(imask, base + DAC960_PG_IRQMASK_OFFSET);
+}
+
+static inline bool DAC960_PG_intr_enabled(void __iomem *base)
+{
+	unsigned int imask = readl(base + DAC960_PG_IRQMASK_OFFSET);
+
+	return !(imask & DAC960_PG_IRQMASK_DISABLE_IRQ);
+}
+
+static inline void DAC960_PG_write_cmd_mbox(union myrb_cmd_mbox *mem_mbox,
+		union myrb_cmd_mbox *mbox)
+{
+	mem_mbox->words[1] = mbox->words[1];
+	mem_mbox->words[2] = mbox->words[2];
+	mem_mbox->words[3] = mbox->words[3];
+	/* Memory barrier to prevent reordering */
+	wmb();
+	mem_mbox->words[0] = mbox->words[0];
+	/* Memory barrier to force PCI access */
+	mb();
+}
+
+static inline void DAC960_PG_write_hw_mbox(void __iomem *base,
+		union myrb_cmd_mbox *mbox)
+{
+	writel(mbox->words[0], base + DAC960_PG_CMDOP_OFFSET);
+	writel(mbox->words[1], base + DAC960_PG_MBOX4_OFFSET);
+	writel(mbox->words[2], base + DAC960_PG_MBOX8_OFFSET);
+	writeb(mbox->bytes[12], base + DAC960_PG_MBOX12_OFFSET);
+}
+
+static inline unsigned char
+DAC960_PG_read_status_cmd_ident(void __iomem *base)
+{
+	return readb(base + DAC960_PG_STSID_OFFSET);
+}
+
+static inline unsigned short
+DAC960_PG_read_status(void __iomem *base)
+{
+	return readw(base + DAC960_PG_STS_OFFSET);
+}
+
+static inline bool
+DAC960_PG_read_error_status(void __iomem *base, unsigned char *error,
+		unsigned char *param0, unsigned char *param1)
+{
+	unsigned char errsts = readb(base + DAC960_PG_ERRSTS_OFFSET);
+
+	if (!(errsts & DAC960_PG_ERRSTS_PENDING))
+		return false;
+	errsts &= ~DAC960_PG_ERRSTS_PENDING;
+	*error = errsts;
+	*param0 = readb(base + DAC960_PG_CMDOP_OFFSET);
+	*param1 = readb(base + DAC960_PG_CMDID_OFFSET);
+	writeb(0, base + DAC960_PG_ERRSTS_OFFSET);
+	return true;
+}
+
+static inline unsigned short
+DAC960_PG_mbox_init(struct pci_dev *pdev, void __iomem *base,
+		union myrb_cmd_mbox *mbox)
+{
+	unsigned short status;
+	int timeout = 0;
+
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (!DAC960_PG_hw_mbox_is_full(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (DAC960_PG_hw_mbox_is_full(base)) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for empty mailbox\n");
+		return MYRB_STATUS_SUBSYS_TIMEOUT;
+	}
+	DAC960_PG_write_hw_mbox(base, mbox);
+	DAC960_PG_hw_mbox_new_cmd(base);
+
+	timeout = 0;
+	while (timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PG_hw_mbox_status_available(base))
+			break;
+		udelay(10);
+		timeout++;
+	}
+	if (!DAC960_PG_hw_mbox_status_available(base)) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for mailbox status\n");
+		return MYRB_STATUS_SUBSYS_TIMEOUT;
+	}
+	status = DAC960_PG_read_status(base);
+	DAC960_PG_ack_hw_mbox_intr(base);
+	DAC960_PG_ack_hw_mbox_status(base);
+
+	return status;
+}
+
+static int DAC960_PG_hw_init(struct pci_dev *pdev,
+		struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	DAC960_PG_disable_intr(base);
+	DAC960_PG_ack_hw_mbox_status(base);
+	udelay(1000);
+	while (DAC960_PG_init_in_progress(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PG_read_error_status(base, &error,
+						&parm0, &parm1) &&
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
+	if (!myrb_enable_mmio(cb, DAC960_PG_mbox_init)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_PG_reset_ctrl(base);
+		return -ENODEV;
+	}
+	DAC960_PG_enable_intr(base);
+	cb->qcmd = myrb_qcmd;
+	cb->write_cmd_mbox = DAC960_PG_write_cmd_mbox;
+	if (cb->dual_mode_interface)
+		cb->get_cmd_mbox = DAC960_PG_mem_mbox_new_cmd;
+	else
+		cb->get_cmd_mbox = DAC960_PG_hw_mbox_new_cmd;
+	cb->disable_intr = DAC960_PG_disable_intr;
+	cb->reset = DAC960_PG_reset_ctrl;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_PG_intr_handler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	struct myrb_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	DAC960_PG_ack_intr(base);
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
+	.hw_init =	DAC960_PG_hw_init,
+	.irq_handler =	DAC960_PG_intr_handler,
+	.mmio_size =	DAC960_PG_mmio_size,
+};
+
+
+/*
+ * DAC960 PD Series Controllers
+ */
+
+static inline void DAC960_PD_hw_mbox_new_cmd(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_HWMBOX_NEW_CMD, base + DAC960_PD_IDB_OFFSET);
+}
+
+static inline void DAC960_PD_ack_hw_mbox_status(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_HWMBOX_ACK_STS, base + DAC960_PD_IDB_OFFSET);
+}
+
+static inline void DAC960_PD_gen_intr(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_GEN_IRQ, base + DAC960_PD_IDB_OFFSET);
+}
+
+static inline void DAC960_PD_reset_ctrl(void __iomem *base)
+{
+	writeb(DAC960_PD_IDB_CTRL_RESET, base + DAC960_PD_IDB_OFFSET);
+}
+
+static inline bool DAC960_PD_hw_mbox_is_full(void __iomem *base)
+{
+	unsigned char idb = readb(base + DAC960_PD_IDB_OFFSET);
+
+	return idb & DAC960_PD_IDB_HWMBOX_FULL;
+}
+
+static inline bool DAC960_PD_init_in_progress(void __iomem *base)
+{
+	unsigned char idb = readb(base + DAC960_PD_IDB_OFFSET);
+
+	return idb & DAC960_PD_IDB_INIT_IN_PROGRESS;
+}
+
+static inline void DAC960_PD_ack_intr(void __iomem *base)
+{
+	writeb(DAC960_PD_ODB_HWMBOX_ACK_IRQ, base + DAC960_PD_ODB_OFFSET);
+}
+
+static inline bool DAC960_PD_hw_mbox_status_available(void __iomem *base)
+{
+	unsigned char odb = readb(base + DAC960_PD_ODB_OFFSET);
+
+	return odb & DAC960_PD_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline void DAC960_PD_enable_intr(void __iomem *base)
+{
+	writeb(DAC960_PD_IRQMASK_ENABLE_IRQ, base + DAC960_PD_IRQEN_OFFSET);
+}
+
+static inline void DAC960_PD_disable_intr(void __iomem *base)
+{
+	writeb(0, base + DAC960_PD_IRQEN_OFFSET);
+}
+
+static inline bool DAC960_PD_intr_enabled(void __iomem *base)
+{
+	unsigned char imask = readb(base + DAC960_PD_IRQEN_OFFSET);
+
+	return imask & DAC960_PD_IRQMASK_ENABLE_IRQ;
+}
+
+static inline void DAC960_PD_write_cmd_mbox(void __iomem *base,
+		union myrb_cmd_mbox *mbox)
+{
+	writel(mbox->words[0], base + DAC960_PD_CMDOP_OFFSET);
+	writel(mbox->words[1], base + DAC960_PD_MBOX4_OFFSET);
+	writel(mbox->words[2], base + DAC960_PD_MBOX8_OFFSET);
+	writeb(mbox->bytes[12], base + DAC960_PD_MBOX12_OFFSET);
+}
+
+static inline unsigned char
+DAC960_PD_read_status_cmd_ident(void __iomem *base)
+{
+	return readb(base + DAC960_PD_STSID_OFFSET);
+}
+
+static inline unsigned short
+DAC960_PD_read_status(void __iomem *base)
+{
+	return readw(base + DAC960_PD_STS_OFFSET);
+}
+
+static inline bool
+DAC960_PD_read_error_status(void __iomem *base, unsigned char *error,
+		unsigned char *param0, unsigned char *param1)
+{
+	unsigned char errsts = readb(base + DAC960_PD_ERRSTS_OFFSET);
+
+	if (!(errsts & DAC960_PD_ERRSTS_PENDING))
+		return false;
+	errsts &= ~DAC960_PD_ERRSTS_PENDING;
+	*error = errsts;
+	*param0 = readb(base + DAC960_PD_CMDOP_OFFSET);
+	*param1 = readb(base + DAC960_PD_CMDID_OFFSET);
+	writeb(0, base + DAC960_PD_ERRSTS_OFFSET);
+	return true;
+}
+
+static void DAC960_PD_qcmd(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	void __iomem *base = cb->io_base;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+
+	while (DAC960_PD_hw_mbox_is_full(base))
+		udelay(1);
+	DAC960_PD_write_cmd_mbox(base, mbox);
+	DAC960_PD_hw_mbox_new_cmd(base);
+}
+
+static int DAC960_PD_hw_init(struct pci_dev *pdev,
+		struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	if (!request_region(cb->io_addr, 0x80, "myrb")) {
+		dev_err(&pdev->dev, "IO port 0x%lx busy\n",
+			(unsigned long)cb->io_addr);
+		return -EBUSY;
+	}
+	DAC960_PD_disable_intr(base);
+	DAC960_PD_ack_hw_mbox_status(base);
+	udelay(1000);
+	while (DAC960_PD_init_in_progress(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PD_read_error_status(base, &error,
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
+		DAC960_PD_reset_ctrl(base);
+		return -ENODEV;
+	}
+	DAC960_PD_enable_intr(base);
+	cb->qcmd = DAC960_PD_qcmd;
+	cb->disable_intr = DAC960_PD_disable_intr;
+	cb->reset = DAC960_PD_reset_ctrl;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_PD_intr_handler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	while (DAC960_PD_hw_mbox_status_available(base)) {
+		unsigned char id = DAC960_PD_read_status_cmd_ident(base);
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
+			cmd_blk->status = DAC960_PD_read_status(base);
+		else
+			dev_err(&cb->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		DAC960_PD_ack_intr(base);
+		DAC960_PD_ack_hw_mbox_status(base);
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
+	.hw_init =	DAC960_PD_hw_init,
+	.irq_handler =	DAC960_PD_intr_handler,
+	.mmio_size =	DAC960_PD_mmio_size,
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
+static inline void myrb_translate_enquiry(void *enq)
+{
+	memcpy(enq + 132, enq + 36, 64);
+	memset(enq + 36, 0, 96);
+}
+
+static inline void myrb_translate_devstate(void *state)
+{
+	memcpy(state + 2, state + 3, 1);
+	memmove(state + 4, state + 5, 2);
+	memmove(state + 6, state + 8, 4);
+}
+
+static inline void myrb_translate_to_rw_command(struct myrb_cmdblk *cmd_blk)
+{
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	int ldev_num = mbox->type5.ld.ldev_num;
+
+	mbox->bytes[3] &= 0x7;
+	mbox->bytes[3] |= mbox->bytes[7] << 6;
+	mbox->bytes[7] = ldev_num;
+}
+
+static inline void myrb_translate_from_rw_command(struct myrb_cmdblk *cmd_blk)
+{
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+	int ldev_num = mbox->bytes[7];
+
+	mbox->bytes[7] = mbox->bytes[3] >> 6;
+	mbox->bytes[3] &= 0x7;
+	mbox->bytes[3] |= ldev_num << 3;
+}
+
+static void DAC960_P_qcmd(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
+{
+	void __iomem *base = cb->io_base;
+	union myrb_cmd_mbox *mbox = &cmd_blk->mbox;
+
+	switch (mbox->common.opcode) {
+	case MYRB_CMD_ENQUIRY:
+		mbox->common.opcode = MYRB_CMD_ENQUIRY_OLD;
+		break;
+	case MYRB_CMD_GET_DEVICE_STATE:
+		mbox->common.opcode = MYRB_CMD_GET_DEVICE_STATE_OLD;
+		break;
+	case MYRB_CMD_READ:
+		mbox->common.opcode = MYRB_CMD_READ_OLD;
+		myrb_translate_to_rw_command(cmd_blk);
+		break;
+	case MYRB_CMD_WRITE:
+		mbox->common.opcode = MYRB_CMD_WRITE_OLD;
+		myrb_translate_to_rw_command(cmd_blk);
+		break;
+	case MYRB_CMD_READ_SG:
+		mbox->common.opcode = MYRB_CMD_READ_SG_OLD;
+		myrb_translate_to_rw_command(cmd_blk);
+		break;
+	case MYRB_CMD_WRITE_SG:
+		mbox->common.opcode = MYRB_CMD_WRITE_SG_OLD;
+		myrb_translate_to_rw_command(cmd_blk);
+		break;
+	default:
+		break;
+	}
+	while (DAC960_PD_hw_mbox_is_full(base))
+		udelay(1);
+	DAC960_PD_write_cmd_mbox(base, mbox);
+	DAC960_PD_hw_mbox_new_cmd(base);
+}
+
+
+static int DAC960_P_hw_init(struct pci_dev *pdev,
+		struct myrb_hba *cb, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char error, parm0, parm1;
+
+	if (!request_region(cb->io_addr, 0x80, "myrb")) {
+		dev_err(&pdev->dev, "IO port 0x%lx busy\n",
+			(unsigned long)cb->io_addr);
+		return -EBUSY;
+	}
+	DAC960_PD_disable_intr(base);
+	DAC960_PD_ack_hw_mbox_status(base);
+	udelay(1000);
+	while (DAC960_PD_init_in_progress(base) &&
+	       timeout < MYRB_MAILBOX_TIMEOUT) {
+		if (DAC960_PD_read_error_status(base, &error,
+						&parm0, &parm1) &&
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
+		DAC960_PD_reset_ctrl(base);
+		return -ETIMEDOUT;
+	}
+	DAC960_PD_enable_intr(base);
+	cb->qcmd = DAC960_P_qcmd;
+	cb->disable_intr = DAC960_PD_disable_intr;
+	cb->reset = DAC960_PD_reset_ctrl;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_P_intr_handler(int irq, void *arg)
+{
+	struct myrb_hba *cb = arg;
+	void __iomem *base = cb->io_base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cb->queue_lock, flags);
+	while (DAC960_PD_hw_mbox_status_available(base)) {
+		unsigned char id = DAC960_PD_read_status_cmd_ident(base);
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
+			cmd_blk->status = DAC960_PD_read_status(base);
+		else
+			dev_err(&cb->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		DAC960_PD_ack_intr(base);
+		DAC960_PD_ack_hw_mbox_status(base);
+
+		if (!cmd_blk)
+			continue;
+
+		mbox = &cmd_blk->mbox;
+		op = mbox->common.opcode;
+		switch (op) {
+		case MYRB_CMD_ENQUIRY_OLD:
+			mbox->common.opcode = MYRB_CMD_ENQUIRY;
+			myrb_translate_enquiry(cb->enquiry);
+			break;
+		case MYRB_CMD_READ_OLD:
+			mbox->common.opcode = MYRB_CMD_READ;
+			myrb_translate_from_rw_command(cmd_blk);
+			break;
+		case MYRB_CMD_WRITE_OLD:
+			mbox->common.opcode = MYRB_CMD_WRITE;
+			myrb_translate_from_rw_command(cmd_blk);
+			break;
+		case MYRB_CMD_READ_SG_OLD:
+			mbox->common.opcode = MYRB_CMD_READ_SG;
+			myrb_translate_from_rw_command(cmd_blk);
+			break;
+		case MYRB_CMD_WRITE_SG_OLD:
+			mbox->common.opcode = MYRB_CMD_WRITE_SG;
+			myrb_translate_from_rw_command(cmd_blk);
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
+	.hw_init =	DAC960_P_hw_init,
+	.irq_handler =	DAC960_P_intr_handler,
+	.mmio_size =	DAC960_PD_mmio_size,
+};
+
+static struct myrb_hba *myrb_detect(struct pci_dev *pdev,
+		const struct pci_device_id *entry)
+{
+	struct myrb_privdata *privdata =
+		(struct myrb_privdata *)entry->driver_data;
+	irq_handler_t irq_handler = privdata->irq_handler;
+	unsigned int mmio_size = privdata->mmio_size;
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
+		goto failure;
+
+	if (privdata->hw_init == DAC960_PD_hw_init ||
+	    privdata->hw_init == DAC960_P_hw_init) {
+		cb->io_addr = pci_resource_start(pdev, 0);
+		cb->pci_addr = pci_resource_start(pdev, 1);
+	} else
+		cb->pci_addr = pci_resource_start(pdev, 0);
+
+	pci_set_drvdata(pdev, cb);
+	spin_lock_init(&cb->queue_lock);
+	if (mmio_size < PAGE_SIZE)
+		mmio_size = PAGE_SIZE;
+	cb->mmio_base = ioremap_nocache(cb->pci_addr & PAGE_MASK, mmio_size);
+	if (cb->mmio_base == NULL) {
+		dev_err(&pdev->dev,
+			"Unable to map Controller Register Window\n");
+		goto failure;
+	}
+
+	cb->io_base = cb->mmio_base + (cb->pci_addr & ~PAGE_MASK);
+	if (privdata->hw_init(pdev, cb, cb->io_base))
+		goto failure;
+
+	if (request_irq(pdev->irq, irq_handler, IRQF_SHARED, "myrb", cb) < 0) {
+		dev_err(&pdev->dev,
+			"Unable to acquire IRQ Channel %d\n", pdev->irq);
+		goto failure;
+	}
+	cb->irq = pdev->irq;
+	return cb;
+
+failure:
+	dev_err(&pdev->dev,
+		"Failed to initialize Controller\n");
+	myrb_cleanup(cb);
+	return NULL;
+}
+
+static int myrb_probe(struct pci_dev *dev, const struct pci_device_id *entry)
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
+	myrb_exec_type3(cb, MYRB_CMD_FLUSH, 0);
+	myrb_cleanup(cb);
+	myrb_destroy_mempools(cb);
+}
+
+
+static const struct pci_device_id myrb_id_table[] = {
+	{
+		PCI_DEVICE_SUB(PCI_VENDOR_ID_DEC,
+			       PCI_DEVICE_ID_DEC_21285,
+			       PCI_VENDOR_ID_MYLEX,
+			       PCI_DEVICE_ID_MYLEX_DAC960_LA),
+		.driver_data	= (unsigned long) &DAC960_LA_privdata,
+	},
+	{
+		PCI_DEVICE_DATA(MYLEX, DAC960_PG, &DAC960_PG_privdata),
+	},
+	{
+		PCI_DEVICE_DATA(MYLEX, DAC960_PD, &DAC960_PD_privdata),
+	},
+	{
+		PCI_DEVICE_DATA(MYLEX, DAC960_P, &DAC960_P_privdata),
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
index 000000000000..9289c19fcb2f
--- /dev/null
+++ b/drivers/scsi/myrb.h
@@ -0,0 +1,958 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
+ *
+ * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
+ *
+ * Based on the original DAC960 driver,
+ * Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
+ * Portions Copyright 2002 by Mylex (An IBM Business Unit)
+ *
+ */
+
+#ifndef MYRB_H
+#define MYRB_H
+
+#define MYRB_MAX_LDEVS			32
+#define MYRB_MAX_CHANNELS		3
+#define MYRB_MAX_TARGETS		16
+#define MYRB_MAX_PHYSICAL_DEVICES	45
+#define MYRB_SCATTER_GATHER_LIMIT	32
+#define MYRB_CMD_MBOX_COUNT		256
+#define MYRB_STAT_MBOX_COUNT		1024
+
+#define MYRB_BLKSIZE_BITS		9
+#define MYRB_MAILBOX_TIMEOUT		1000000
+
+#define MYRB_DCMD_TAG			1
+#define MYRB_MCMD_TAG			2
+
+#define MYRB_PRIMARY_MONITOR_INTERVAL (10 * HZ)
+#define MYRB_SECONDARY_MONITOR_INTERVAL (60 * HZ)
+
+/*
+ * DAC960 V1 Firmware Command Opcodes.
+ */
+enum myrb_cmd_opcode {
+	/* I/O Commands */
+	MYRB_CMD_READ_EXTENDED =	0x33,
+	MYRB_CMD_WRITE_EXTENDED =	0x34,
+	MYRB_CMD_READAHEAD_EXTENDED =	0x35,
+	MYRB_CMD_READ_EXTENDED_SG =	0xB3,
+	MYRB_CMD_WRITE_EXTENDED_SG =	0xB4,
+	MYRB_CMD_READ =			0x36,
+	MYRB_CMD_READ_SG =		0xB6,
+	MYRB_CMD_WRITE =		0x37,
+	MYRB_CMD_WRITE_SG =		0xB7,
+	MYRB_CMD_DCDB =			0x04,
+	MYRB_CMD_DCDB_SG =		0x84,
+	MYRB_CMD_FLUSH =		0x0A,
+	/* Controller Status Related Commands */
+	MYRB_CMD_ENQUIRY =		0x53,
+	MYRB_CMD_ENQUIRY2 =		0x1C,
+	MYRB_CMD_GET_LDRV_ELEMENT =	0x55,
+	MYRB_CMD_GET_LDEV_INFO =	0x19,
+	MYRB_CMD_IOPORTREAD =		0x39,
+	MYRB_CMD_IOPORTWRITE =		0x3A,
+	MYRB_CMD_GET_SD_STATS =		0x3E,
+	MYRB_CMD_GET_PD_STATS =		0x3F,
+	MYRB_CMD_EVENT_LOG_OPERATION =	0x72,
+	/* Device Related Commands */
+	MYRB_CMD_START_DEVICE =		0x10,
+	MYRB_CMD_GET_DEVICE_STATE =	0x50,
+	MYRB_CMD_STOP_CHANNEL =		0x13,
+	MYRB_CMD_START_CHANNEL =	0x12,
+	MYRB_CMD_RESET_CHANNEL =	0x1A,
+	/* Commands Associated with Data Consistency and Errors */
+	MYRB_CMD_REBUILD =		0x09,
+	MYRB_CMD_REBUILD_ASYNC =	0x16,
+	MYRB_CMD_CHECK_CONSISTENCY =	0x0F,
+	MYRB_CMD_CHECK_CONSISTENCY_ASYNC = 0x1E,
+	MYRB_CMD_REBUILD_STAT =		0x0C,
+	MYRB_CMD_GET_REBUILD_PROGRESS =	0x27,
+	MYRB_CMD_REBUILD_CONTROL =	0x1F,
+	MYRB_CMD_READ_BADBLOCK_TABLE =	0x0B,
+	MYRB_CMD_READ_BADDATA_TABLE =	0x25,
+	MYRB_CMD_CLEAR_BADDATA_TABLE =	0x26,
+	MYRB_CMD_GET_ERROR_TABLE =	0x17,
+	MYRB_CMD_ADD_CAPACITY_ASYNC =	0x2A,
+	MYRB_CMD_BGI_CONTROL =		0x2B,
+	/* Configuration Related Commands */
+	MYRB_CMD_READ_CONFIG2 =		0x3D,
+	MYRB_CMD_WRITE_CONFIG2 =	0x3C,
+	MYRB_CMD_READ_CONFIG_ONDISK =	0x4A,
+	MYRB_CMD_WRITE_CONFIG_ONDISK =	0x4B,
+	MYRB_CMD_READ_CONFIG =		0x4E,
+	MYRB_CMD_READ_BACKUP_CONFIG =	0x4D,
+	MYRB_CMD_WRITE_CONFIG =		0x4F,
+	MYRB_CMD_ADD_CONFIG =		0x4C,
+	MYRB_CMD_READ_CONFIG_LABEL =	0x48,
+	MYRB_CMD_WRITE_CONFIG_LABEL =	0x49,
+	/* Firmware Upgrade Related Commands */
+	MYRB_CMD_LOAD_IMAGE =		0x20,
+	MYRB_CMD_STORE_IMAGE =		0x21,
+	MYRB_CMD_PROGRAM_IMAGE =	0x22,
+	/* Diagnostic Commands */
+	MYRB_CMD_SET_DIAGNOSTIC_MODE =	0x31,
+	MYRB_CMD_RUN_DIAGNOSTIC =	0x32,
+	/* Subsystem Service Commands */
+	MYRB_CMD_GET_SUBSYS_DATA =	0x70,
+	MYRB_CMD_SET_SUBSYS_PARAM =	0x71,
+	/* Version 2.xx Firmware Commands */
+	MYRB_CMD_ENQUIRY_OLD =		0x05,
+	MYRB_CMD_GET_DEVICE_STATE_OLD =	0x14,
+	MYRB_CMD_READ_OLD =		0x02,
+	MYRB_CMD_WRITE_OLD =		0x03,
+	MYRB_CMD_READ_SG_OLD =		0x82,
+	MYRB_CMD_WRITE_SG_OLD =		0x83
+} __packed;
+
+/*
+ * DAC960 V1 Firmware Command Status Codes.
+ */
+#define MYRB_STATUS_SUCCESS			0x0000	/* Common */
+#define MYRB_STATUS_CHECK_CONDITION		0x0002	/* Common */
+#define MYRB_STATUS_NO_DEVICE			0x0102	/* Common */
+#define MYRB_STATUS_INVALID_ADDRESS		0x0105	/* Common */
+#define MYRB_STATUS_INVALID_PARAM		0x0105	/* Common */
+#define MYRB_STATUS_IRRECOVERABLE_DATA_ERROR	0x0001	/* I/O */
+#define MYRB_STATUS_LDRV_NONEXISTENT_OR_OFFLINE 0x0002	/* I/O */
+#define MYRB_STATUS_ACCESS_BEYOND_END_OF_LDRV	0x0105	/* I/O */
+#define MYRB_STATUS_BAD_DATA			0x010C	/* I/O */
+#define MYRB_STATUS_DEVICE_BUSY			0x0008	/* DCDB */
+#define MYRB_STATUS_DEVICE_NONRESPONSIVE	0x000E	/* DCDB */
+#define MYRB_STATUS_COMMAND_TERMINATED		0x000F	/* DCDB */
+#define MYRB_STATUS_START_DEVICE_FAILED		0x0002	/* Device */
+#define MYRB_STATUS_INVALID_CHANNEL_OR_TARGET	0x0105	/* Device */
+#define MYRB_STATUS_CHANNEL_BUSY		0x0106	/* Device */
+#define MYRB_STATUS_OUT_OF_MEMORY		0x0107	/* Device */
+#define MYRB_STATUS_CHANNEL_NOT_STOPPED		0x0002	/* Device */
+#define MYRB_STATUS_ATTEMPT_TO_RBLD_ONLINE_DRIVE 0x0002	/* Consistency */
+#define MYRB_STATUS_RBLD_BADBLOCKS		0x0003	/* Consistency */
+#define MYRB_STATUS_RBLD_NEW_DISK_FAILED	0x0004	/* Consistency */
+#define MYRB_STATUS_RBLD_OR_CHECK_INPROGRESS	0x0106	/* Consistency */
+#define MYRB_STATUS_DEPENDENT_DISK_DEAD		0x0002	/* Consistency */
+#define MYRB_STATUS_INCONSISTENT_BLOCKS		0x0003	/* Consistency */
+#define MYRB_STATUS_INVALID_OR_NONREDUNDANT_LDRV 0x0105 /* Consistency */
+#define MYRB_STATUS_NO_RBLD_OR_CHECK_INPROGRESS	0x0105	/* Consistency */
+#define MYRB_STATUS_RBLD_IN_PROGRESS_DATA_VALID	0x0000	/* Consistency */
+#define MYRB_STATUS_RBLD_FAILED_LDEV_FAILURE	0x0002	/* Consistency */
+#define MYRB_STATUS_RBLD_FAILED_BADBLOCKS	0x0003	/* Consistency */
+#define MYRB_STATUS_RBLD_FAILED_NEW_DRIVE_FAILED 0x0004	/* Consistency */
+#define MYRB_STATUS_RBLD_SUCCESS		0x0100	/* Consistency */
+#define MYRB_STATUS_RBLD_SUCCESS_TERMINATED	0x0107	/* Consistency */
+#define MYRB_STATUS_RBLD_NOT_CHECKED		0x0108	/* Consistency */
+#define MYRB_STATUS_BGI_SUCCESS			0x0100	/* Consistency */
+#define MYRB_STATUS_BGI_ABORTED			0x0005	/* Consistency */
+#define MYRB_STATUS_NO_BGI_INPROGRESS		0x0105	/* Consistency */
+#define MYRB_STATUS_ADD_CAPACITY_INPROGRESS	0x0004	/* Consistency */
+#define MYRB_STATUS_ADD_CAPACITY_FAILED_OR_SUSPENDED 0x00F4 /* Consistency */
+#define MYRB_STATUS_CONFIG2_CSUM_ERROR		0x0002	/* Configuration */
+#define MYRB_STATUS_CONFIGURATION_SUSPENDED	0x0106	/* Configuration */
+#define MYRB_STATUS_FAILED_TO_CONFIGURE_NVRAM	0x0105	/* Configuration */
+#define MYRB_STATUS_CONFIGURATION_NOT_SAVED	0x0106	/* Configuration */
+#define MYRB_STATUS_SUBSYS_NOTINSTALLED		0x0001	/* Subsystem */
+#define MYRB_STATUS_SUBSYS_FAILED		0x0002	/* Subsystem */
+#define MYRB_STATUS_SUBSYS_BUSY			0x0106	/* Subsystem */
+#define MYRB_STATUS_SUBSYS_TIMEOUT		0x0108	/* Subsystem */
+
+/*
+ * DAC960 V1 Firmware Enquiry Command reply structure.
+ */
+struct myrb_enquiry {
+	unsigned char ldev_count;			/* Byte 0 */
+	unsigned int rsvd1:24;				/* Bytes 1-3 */
+	unsigned int ldev_sizes[32];			/* Bytes 4-131 */
+	unsigned short flash_age;			/* Bytes 132-133 */
+	struct {
+		unsigned char deferred:1;		/* Byte 134 Bit 0 */
+		unsigned char low_bat:1;		/* Byte 134 Bit 1 */
+		unsigned char rsvd2:6;			/* Byte 134 Bits 2-7 */
+	} status;
+	unsigned char rsvd3:8;				/* Byte 135 */
+	unsigned char fw_minor_version;			/* Byte 136 */
+	unsigned char fw_major_version;			/* Byte 137 */
+	enum {
+		MYRB_NO_STDBY_RBLD_OR_CHECK_IN_PROGRESS =	0x00,
+		MYRB_STDBY_RBLD_IN_PROGRESS =			0x01,
+		MYRB_BG_RBLD_IN_PROGRESS =			0x02,
+		MYRB_BG_CHECK_IN_PROGRESS =			0x03,
+		MYRB_STDBY_RBLD_COMPLETED_WITH_ERROR =		0xFF,
+		MYRB_BG_RBLD_OR_CHECK_FAILED_DRIVE_FAILED =	0xF0,
+		MYRB_BG_RBLD_OR_CHECK_FAILED_LDEV_FAILED =	0xF1,
+		MYRB_BG_RBLD_OR_CHECK_FAILED_OTHER =		0xF2,
+		MYRB_BG_RBLD_OR_CHECK_SUCCESS_TERMINATED =	0xF3
+	} __packed rbld;		/* Byte 138 */
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
+		unsigned char bbu_present:1;		/* Byte 151 Bit 3 */
+		unsigned char rsvd8:4;			/* Byte 151 Bits 4-7 */
+	} misc;
+	struct {
+		unsigned char target;
+		unsigned char channel;
+	} dead_drives[21];				/* Bytes 152-194 */
+	unsigned char rsvd9[62];			/* Bytes 195-255 */
+} __packed;
+
+/*
+ * DAC960 V1 Firmware Enquiry2 Command reply structure.
+ */
+struct myrb_enquiry2 {
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
+		} __packed sub_model;		/* Byte 0 */
+		unsigned char actual_channels;			/* Byte 1 */
+		enum {
+			MYRB_5_CHANNEL_BOARD =		0x01,
+			MYRB_3_CHANNEL_BOARD =		0x02,
+			MYRB_2_CHANNEL_BOARD =		0x03,
+			MYRB_3_CHANNEL_ASIC_DAC =	0x04
+		} __packed model;		/* Byte 2 */
+		enum {
+			MYRB_EISA_CONTROLLER =		0x01,
+			MYRB_MCA_CONTROLLER =		0x02,
+			MYRB_PCI_CONTROLLER =		0x03,
+			MYRB_SCSI_TO_SCSI =		0x08
+		} __packed controller;	/* Byte 3 */
+	} hw;						/* Bytes 0-3 */
+	/* MajorVersion.MinorVersion-FirmwareType-TurnID */
+	struct {
+		unsigned char major_version;		/* Byte 4 */
+		unsigned char minor_version;		/* Byte 5 */
+		unsigned char turn_id;			/* Byte 6 */
+		char firmware_type;			/* Byte 7 */
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
+			MYRB_RAM_TYPE_DRAM =		0x0,
+			MYRB_RAM_TYPE_EDO =			0x1,
+			MYRB_RAM_TYPE_SDRAM =		0x2,
+			MYRB_RAM_TYPE_Last =		0x7
+		} __packed ram:3;	/* Byte 40 Bits 0-2 */
+		enum {
+			MYRB_ERR_CORR_None =	0x0,
+			MYRB_ERR_CORR_Parity =	0x1,
+			MYRB_ERR_CORR_ECC =		0x2,
+			MYRB_ERR_CORR_Last =	0x7
+		} __packed ec:3;	/* Byte 40 Bits 3-5 */
+		unsigned char fast_page:1;		/* Byte 40 Bit 6 */
+		unsigned char low_power:1;		/* Byte 40 Bit 7 */
+		unsigned char rsvd4;			/* Bytes 41 */
+	} mem_type;
+	unsigned short clock_speed;			/* Bytes 42-43 */
+	unsigned short mem_speed;			/* Bytes 44-45 */
+	unsigned short hw_speed;			/* Bytes 46-47 */
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
+			MYRB_WIDTH_NARROW_8BIT =		0x0,
+			MYRB_WIDTH_WIDE_16BIT =			0x1,
+			MYRB_WIDTH_WIDE_32BIT =			0x2
+		} __packed bus_width:2;	/* Byte 106 Bits 0-1 */
+		enum {
+			MYRB_SCSI_SPEED_FAST =			0x0,
+			MYRB_SCSI_SPEED_ULTRA =			0x1,
+			MYRB_SCSI_SPEED_ULTRA2 =		0x2
+		} __packed bus_speed:2;	/* Byte 106 Bits 2-3 */
+		unsigned char differential:1;		/* Byte 106 Bit 4 */
+		unsigned char rsvd10:3;			/* Byte 106 Bits 5-7 */
+	} scsi_cap;
+	unsigned char rsvd11[5];			/* Byte 107-111 */
+	unsigned short fw_build;			/* Bytes 112-113 */
+	enum {
+		MYRB_FAULT_AEMI =				0x01,
+		MYRB_FAULT_OEM1 =				0x02,
+		MYRB_FAULT_OEM2 =				0x04,
+		MYRB_FAULT_OEM3 =				0x08,
+		MYRB_FAULT_CONNER =				0x10,
+		MYRB_FAULT_SAFTE =				0x20
+	} __packed fault_mgmt;		/* Byte 114 */
+	unsigned char rsvd12;				/* Byte 115 */
+	struct {
+		unsigned int clustering:1;		/* Byte 116 Bit 0 */
+		unsigned int online_RAID_expansion:1;	/* Byte 116 Bit 1 */
+		unsigned int readahead:1;		/* Byte 116 Bit 2 */
+		unsigned int bgi:1;			/* Byte 116 Bit 3 */
+		unsigned int rsvd13:28;			/* Bytes 116-119 */
+	} fw_features;
+	unsigned char rsvd14[8];			/* Bytes 120-127 */
+} __packed;
+
+/*
+ * DAC960 V1 Firmware Logical Drive State type.
+ */
+enum myrb_devstate {
+	MYRB_DEVICE_DEAD =		0x00,
+	MYRB_DEVICE_WO =		0x02,
+	MYRB_DEVICE_ONLINE =		0x03,
+	MYRB_DEVICE_CRITICAL =		0x04,
+	MYRB_DEVICE_STANDBY =		0x10,
+	MYRB_DEVICE_OFFLINE =		0xFF
+} __packed;
+
+/*
+ * DAC960 V1 RAID Levels
+ */
+enum myrb_raidlevel {
+	MYRB_RAID_LEVEL0 =		0x0,     /* RAID 0 */
+	MYRB_RAID_LEVEL1 =		0x1,     /* RAID 1 */
+	MYRB_RAID_LEVEL3 =		0x3,     /* RAID 3 */
+	MYRB_RAID_LEVEL5 =		0x5,     /* RAID 5 */
+	MYRB_RAID_LEVEL6 =		0x6,     /* RAID 6 */
+	MYRB_RAID_JBOD =		0x7,     /* RAID 7 (JBOD) */
+} __packed;
+
+/*
+ * DAC960 V1 Firmware Logical Drive Information structure.
+ */
+struct myrb_ldev_info {
+	unsigned int size;				/* Bytes 0-3 */
+	enum myrb_devstate state;			/* Byte 4 */
+	unsigned int raid_level:7;			/* Byte 5 Bits 0-6 */
+	unsigned int wb_enabled:1;			/* Byte 5 Bit 7 */
+	unsigned int rsvd:16;				/* Bytes 6-7 */
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
+	unsigned char msg_type;			/* Byte 0 */
+	unsigned char msg_len;			/* Byte 1 */
+	unsigned char target:5;			/* Byte 2 Bits 0-4 */
+	unsigned char channel:3;		/* Byte 2 Bits 5-7 */
+	unsigned char lun:6;			/* Byte 3 Bits 0-5 */
+	unsigned char rsvd1:2;			/* Byte 3 Bits 6-7 */
+	unsigned short seq_num;			/* Bytes 4-5 */
+	unsigned char sense[26];		/* Bytes 6-31 */
+};
+
+/*
+ * DAC960 V1 Firmware Get Device State Command reply structure.
+ * The structure is padded by 2 bytes for compatibility with Version 2.xx
+ * Firmware.
+ */
+struct myrb_pdev_state {
+	unsigned int present:1;			/* Byte 0 Bit 0 */
+	unsigned int :7;				/* Byte 0 Bits 1-7 */
+	enum {
+		MYRB_TYPE_OTHER =			0x0,
+		MYRB_TYPE_DISK =			0x1,
+		MYRB_TYPE_TAPE =			0x2,
+		MYRB_TYPE_CDROM_OR_WORM =		0x3
+	} __packed devtype:2;		/* Byte 1 Bits 0-1 */
+	unsigned int rsvd1:1;				/* Byte 1 Bit 2 */
+	unsigned int fast20:1;				/* Byte 1 Bit 3 */
+	unsigned int sync:1;				/* Byte 1 Bit 4 */
+	unsigned int fast:1;				/* Byte 1 Bit 5 */
+	unsigned int wide:1;				/* Byte 1 Bit 6 */
+	unsigned int tcq_supported:1;			/* Byte 1 Bit 7 */
+	enum myrb_devstate state;			/* Byte 2 */
+	unsigned int rsvd2:8;				/* Byte 3 */
+	unsigned int sync_multiplier;			/* Byte 4 */
+	unsigned int sync_offset:5;			/* Byte 5 Bits 0-4 */
+	unsigned int rsvd3:3;				/* Byte 5 Bits 5-7 */
+	unsigned int size;				/* Bytes 6-9 */
+	unsigned int rsvd4:16;			/* Bytes 10-11 */
+} __packed;
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
+struct myrb_bgi_status {
+	unsigned int ldev_size;				/* Bytes 0-3 */
+	unsigned int blocks_done;			/* Bytes 4-7 */
+	unsigned char rsvd1[12];			/* Bytes 8-19 */
+	unsigned int ldev_num;				/* Bytes 20-23 */
+	unsigned char raid_level;			/* Byte 24 */
+	enum {
+		MYRB_BGI_INVALID =	0x00,
+		MYRB_BGI_STARTED =	0x02,
+		MYRB_BGI_INPROGRESS =	0x04,
+		MYRB_BGI_SUSPENDED =	0x05,
+		MYRB_BGI_CANCELLED =	0x06
+	} __packed status;		/* Byte 25 */
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
+	unsigned rsvd1:1;				/* Byte 0 Bit 0 */
+	unsigned active_negation:1;			/* Byte 0 Bit 1 */
+	unsigned rsvd2:5;				/* Byte 0 Bits 2-6 */
+	unsigned no_rescan_on_reset_during_scan:1;	/* Byte 0 Bit 7 */
+	unsigned StorageWorks_support:1;		/* Byte 1 Bit 0 */
+	unsigned HewlettPackard_support:1;		/* Byte 1 Bit 1 */
+	unsigned no_disconnect_on_first_command:1;	/* Byte 1 Bit 2 */
+	unsigned rsvd3:2;				/* Byte 1 Bits 3-4 */
+	unsigned AEMI_ARM:1;				/* Byte 1 Bit 5 */
+	unsigned AEMI_OFM:1;				/* Byte 1 Bit 6 */
+	unsigned rsvd4:1;				/* Byte 1 Bit 7 */
+	enum {
+		MYRB_OEMID_MYLEX =		0x00,
+		MYRB_OEMID_IBM =		0x08,
+		MYRB_OEMID_HP =			0x0A,
+		MYRB_OEMID_DEC =		0x0C,
+		MYRB_OEMID_SIEMENS =		0x10,
+		MYRB_OEMID_INTEL =		0x12
+	} __packed OEMID;		/* Byte 2 */
+	unsigned char oem_model_number;			/* Byte 3 */
+	unsigned char physical_sector;			/* Byte 4 */
+	unsigned char logical_sector;			/* Byte 5 */
+	unsigned char block_factor;			/* Byte 6 */
+	unsigned readahead_enabled:1;			/* Byte 7 Bit 0 */
+	unsigned low_BIOS_delay:1;			/* Byte 7 Bit 1 */
+	unsigned rsvd5:2;				/* Byte 7 Bits 2-3 */
+	unsigned restrict_reassign_to_one_sector:1;	/* Byte 7 Bit 4 */
+	unsigned rsvd6:1;				/* Byte 7 Bit 5 */
+	unsigned FUA_during_write_recovery:1;		/* Byte 7 Bit 6 */
+	unsigned enable_LeftSymmetricRAID5Algorithm:1;	/* Byte 7 Bit 7 */
+	unsigned char default_rebuild_rate;		/* Byte 8 */
+	unsigned char rsvd7;				/* Byte 9 */
+	unsigned char blocks_per_cacheline;		/* Byte 10 */
+	unsigned char blocks_per_stripe;		/* Byte 11 */
+	struct {
+		enum {
+			MYRB_SPEED_ASYNC =		0x0,
+			MYRB_SPEED_SYNC_8MHz =		0x1,
+			MYRB_SPEED_SYNC_5MHz =		0x2,
+			MYRB_SPEED_SYNC_10_OR_20MHz =	0x3
+		} __packed speed:2;	/* Byte 11 Bits 0-1 */
+		unsigned force_8bit:1;			/* Byte 11 Bit 2 */
+		unsigned disable_fast20:1;		/* Byte 11 Bit 3 */
+		unsigned rsvd8:3;			/* Byte 11 Bits 4-6 */
+		unsigned enable_tcq:1;			/* Byte 11 Bit 7 */
+	} __packed channelparam[6];	/* Bytes 12-17 */
+	unsigned char SCSIInitiatorID;			/* Byte 18 */
+	unsigned char rsvd9;				/* Byte 19 */
+	enum {
+		MYRB_STARTUP_CONTROLLER_SPINUP =	0x00,
+		MYRB_STARTUP_POWERON_SPINUP =		0x01
+	} __packed startup;		/* Byte 20 */
+	unsigned char simultaneous_device_spinup_count;	/* Byte 21 */
+	unsigned char seconds_delay_between_spinups;	/* Byte 22 */
+	unsigned char rsvd10[29];			/* Bytes 23-51 */
+	unsigned BIOS_disabled:1;			/* Byte 52 Bit 0 */
+	unsigned CDROM_boot_enabled:1;			/* Byte 52 Bit 1 */
+	unsigned rsvd11:3;				/* Byte 52 Bits 2-4 */
+	enum {
+		MYRB_GEOM_128_32 =		0x0,
+		MYRB_GEOM_255_63 =		0x1,
+		MYRB_GEOM_RESERVED1 =		0x2,
+		MYRB_GEOM_RESERVED2 =		0x3
+	} __packed drive_geometry:2;	/* Byte 52 Bits 5-6 */
+	unsigned rsvd12:1;				/* Byte 52 Bit 7 */
+	unsigned char rsvd13[9];			/* Bytes 53-61 */
+	unsigned short csum;				/* Bytes 62-63 */
+};
+
+/*
+ * DAC960 V1 Firmware DCDB request structure.
+ */
+struct myrb_dcdb {
+	unsigned target:4;				 /* Byte 0 Bits 0-3 */
+	unsigned channel:4;				 /* Byte 0 Bits 4-7 */
+	enum {
+		MYRB_DCDB_XFER_NONE =		0,
+		MYRB_DCDB_XFER_DEVICE_TO_SYSTEM = 1,
+		MYRB_DCDB_XFER_SYSTEM_TO_DEVICE = 2,
+		MYRB_DCDB_XFER_ILLEGAL =	3
+	} __packed data_xfer:2;				/* Byte 1 Bits 0-1 */
+	unsigned early_status:1;			/* Byte 1 Bit 2 */
+	unsigned rsvd1:1;				/* Byte 1 Bit 3 */
+	enum {
+		MYRB_DCDB_TMO_24_HRS =	0,
+		MYRB_DCDB_TMO_10_SECS =	1,
+		MYRB_DCDB_TMO_60_SECS =	2,
+		MYRB_DCDB_TMO_10_MINS =	3
+	} __packed timeout:2;				/* Byte 1 Bits 4-5 */
+	unsigned no_autosense:1;			/* Byte 1 Bit 6 */
+	unsigned allow_disconnect:1;			/* Byte 1 Bit 7 */
+	unsigned short xfer_len_lo;			/* Bytes 2-3 */
+	u32 dma_addr;					/* Bytes 4-7 */
+	unsigned char cdb_len:4;			/* Byte 8 Bits 0-3 */
+	unsigned char xfer_len_hi4:4;			/* Byte 8 Bits 4-7 */
+	unsigned char sense_len;			/* Byte 9 */
+	unsigned char cdb[12];				/* Bytes 10-21 */
+	unsigned char sense[64];			/* Bytes 22-85 */
+	unsigned char status;				/* Byte 86 */
+	unsigned char rsvd2;				/* Byte 87 */
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
+	unsigned int words[4];				/* Words 0-3 */
+	unsigned char bytes[16];			/* Bytes 0-15 */
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd[14];			/* Bytes 2-15 */
+	} __packed common;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd1[6];			/* Bytes 2-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __packed type3;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char optype;			/* Byte 2 */
+		unsigned char rsvd1[5];			/* Bytes 3-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __packed type3B;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd1[5];			/* Bytes 2-6 */
+		unsigned char ldev_num:6;		/* Byte 7 Bits 0-6 */
+		unsigned char auto_restore:1;		/* Byte 7 Bit 7 */
+		unsigned char rsvd2[8];			/* Bytes 8-15 */
+	} __packed type3C;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char channel;			/* Byte 2 */
+		unsigned char target;			/* Byte 3 */
+		enum myrb_devstate state;		/* Byte 4 */
+		unsigned char rsvd1[3];			/* Bytes 5-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __packed type3D;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char optype;			/* Byte 2 */
+		unsigned char opqual;			/* Byte 3 */
+		unsigned short ev_seq;			/* Bytes 4-5 */
+		unsigned char rsvd1[2];			/* Bytes 6-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __packed type3E;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char rsvd1[2];			/* Bytes 2-3 */
+		unsigned char rbld_rate;		/* Byte 4 */
+		unsigned char rsvd2[3];			/* Bytes 5-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char rsvd3[4];			/* Bytes 12-15 */
+	} __packed type3R;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned short xfer_len;		/* Bytes 2-3 */
+		unsigned int lba;			/* Bytes 4-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char ldev_num;			/* Byte 12 */
+		unsigned char rsvd[3];			/* Bytes 13-15 */
+	} __packed type4;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		struct {
+			unsigned short xfer_len:11;	/* Bytes 2-3 */
+			unsigned char ldev_num:5;	/* Byte 3 Bits 3-7 */
+		} __packed ld;
+		unsigned int lba;			/* Bytes 4-7 */
+		u32 addr;				/* Bytes 8-11 */
+		unsigned char sg_count:6;		/* Byte 12 Bits 0-5 */
+		enum {
+			MYRB_SGL_ADDR32_COUNT32 = 0x0,
+			MYRB_SGL_ADDR32_COUNT16 = 0x1,
+			MYRB_SGL_COUNT32_ADDR32 = 0x2,
+			MYRB_SGL_COUNT16_ADDR32 = 0x3
+		} __packed sg_type:2;	/* Byte 12 Bits 6-7 */
+		unsigned char rsvd[3];			/* Bytes 13-15 */
+	} __packed type5;
+	struct {
+		enum myrb_cmd_opcode opcode;		/* Byte 0 */
+		unsigned char id;			/* Byte 1 */
+		unsigned char opcode2;			/* Byte 2 */
+		unsigned char rsvd1:8;			/* Byte 3 */
+		u32 cmd_mbox_addr;			/* Bytes 4-7 */
+		u32 stat_mbox_addr;			/* Bytes 8-11 */
+		unsigned char rsvd2[4];			/* Bytes 12-15 */
+	} __packed typeX;
+};
+
+/*
+ * DAC960 V1 Firmware Controller Status Mailbox structure.
+ */
+struct myrb_stat_mbox {
+	unsigned char id;		/* Byte 0 */
+	unsigned char rsvd:7;		/* Byte 1 Bits 0-6 */
+	unsigned char valid:1;			/* Byte 1 Bit 7 */
+	unsigned short status;		/* Bytes 2-3 */
+};
+
+struct myrb_cmdblk {
+	union myrb_cmd_mbox mbox;
+	unsigned short status;
+	struct completion *completion;
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
+	unsigned char bus_width;
+	unsigned short stripe_size;
+	unsigned short segment_size;
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
+	void (*qcmd)(struct myrb_hba *cs, struct myrb_cmdblk *cmd_blk);
+	void (*write_cmd_mbox)(union myrb_cmd_mbox *next_mbox,
+			       union myrb_cmd_mbox *cmd_mbox);
+	void (*get_cmd_mbox)(void __iomem *base);
+	void (*disable_intr)(void __iomem *base);
+	void (*reset)(void __iomem *base);
+
+	unsigned int ctlr_num;
+	unsigned char model_name[20];
+	unsigned char fw_version[12];
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
+#define DAC960_LA_mmio_size		0x80
+
+enum DAC960_LA_reg_offset {
+	DAC960_LA_IRQMASK_OFFSET	= 0x34,
+	DAC960_LA_CMDOP_OFFSET		= 0x50,
+	DAC960_LA_CMDID_OFFSET		= 0x51,
+	DAC960_LA_MBOX2_OFFSET		= 0x52,
+	DAC960_LA_MBOX3_OFFSET		= 0x53,
+	DAC960_LA_MBOX4_OFFSET		= 0x54,
+	DAC960_LA_MBOX5_OFFSET		= 0x55,
+	DAC960_LA_MBOX6_OFFSET		= 0x56,
+	DAC960_LA_MBOX7_OFFSET		= 0x57,
+	DAC960_LA_MBOX8_OFFSET		= 0x58,
+	DAC960_LA_MBOX9_OFFSET		= 0x59,
+	DAC960_LA_MBOX10_OFFSET		= 0x5A,
+	DAC960_LA_MBOX11_OFFSET		= 0x5B,
+	DAC960_LA_MBOX12_OFFSET		= 0x5C,
+	DAC960_LA_STSID_OFFSET		= 0x5D,
+	DAC960_LA_STS_OFFSET		= 0x5E,
+	DAC960_LA_IDB_OFFSET		= 0x60,
+	DAC960_LA_ODB_OFFSET		= 0x61,
+	DAC960_LA_ERRSTS_OFFSET		= 0x63,
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
+#define DAC960_PG_mmio_size		0x2000
+
+enum DAC960_PG_reg_offset {
+	DAC960_PG_IDB_OFFSET		= 0x0020,
+	DAC960_PG_ODB_OFFSET		= 0x002C,
+	DAC960_PG_IRQMASK_OFFSET	= 0x0034,
+	DAC960_PG_CMDOP_OFFSET		= 0x1000,
+	DAC960_PG_CMDID_OFFSET		= 0x1001,
+	DAC960_PG_MBOX2_OFFSET		= 0x1002,
+	DAC960_PG_MBOX3_OFFSET		= 0x1003,
+	DAC960_PG_MBOX4_OFFSET		= 0x1004,
+	DAC960_PG_MBOX5_OFFSET		= 0x1005,
+	DAC960_PG_MBOX6_OFFSET		= 0x1006,
+	DAC960_PG_MBOX7_OFFSET		= 0x1007,
+	DAC960_PG_MBOX8_OFFSET		= 0x1008,
+	DAC960_PG_MBOX9_OFFSET		= 0x1009,
+	DAC960_PG_MBOX10_OFFSET		= 0x100A,
+	DAC960_PG_MBOX11_OFFSET		= 0x100B,
+	DAC960_PG_MBOX12_OFFSET		= 0x100C,
+	DAC960_PG_STSID_OFFSET		= 0x1018,
+	DAC960_PG_STS_OFFSET		= 0x101A,
+	DAC960_PG_ERRSTS_OFFSET		= 0x103F,
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
+#define DAC960_PD_mmio_size		0x80
+
+enum DAC960_PD_reg_offset {
+	DAC960_PD_CMDOP_OFFSET		= 0x00,
+	DAC960_PD_CMDID_OFFSET		= 0x01,
+	DAC960_PD_MBOX2_OFFSET		= 0x02,
+	DAC960_PD_MBOX3_OFFSET		= 0x03,
+	DAC960_PD_MBOX4_OFFSET		= 0x04,
+	DAC960_PD_MBOX5_OFFSET		= 0x05,
+	DAC960_PD_MBOX6_OFFSET		= 0x06,
+	DAC960_PD_MBOX7_OFFSET		= 0x07,
+	DAC960_PD_MBOX8_OFFSET		= 0x08,
+	DAC960_PD_MBOX9_OFFSET		= 0x09,
+	DAC960_PD_MBOX10_OFFSET		= 0x0A,
+	DAC960_PD_MBOX11_OFFSET		= 0x0B,
+	DAC960_PD_MBOX12_OFFSET		= 0x0C,
+	DAC960_PD_STSID_OFFSET		= 0x0D,
+	DAC960_PD_STS_OFFSET		= 0x0E,
+	DAC960_PD_ERRSTS_OFFSET		= 0x3F,
+	DAC960_PD_IDB_OFFSET		= 0x40,
+	DAC960_PD_ODB_OFFSET		= 0x41,
+	DAC960_PD_IRQEN_OFFSET		= 0x43,
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
+	myrb_hw_init_t		hw_init;
+	irq_handler_t		irq_handler;
+	unsigned int		mmio_size;
+};
+
+#endif /* MYRB_H */
-- 
2.16.4
