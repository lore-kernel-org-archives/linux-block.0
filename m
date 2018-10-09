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
Subject: [PATCH 2/3] myrs: Add Mylex RAID controller (SCSI interface)
Date: Tue,  9 Oct 2018 17:27:00 +0200
Message-Id: <20181009152701.5542-3-hare@suse.de>
In-Reply-To: <20181009152701.5542-1-hare@suse.de>
References: <20181009152701.5542-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch adds support for the Mylex DAC960 RAID controller,
supporting the newer, SCSI-based interface.
The driver is a re-implementation of the original DAC960 driver.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/Kconfig  |   15 +
 drivers/scsi/Makefile |    1 +
 drivers/scsi/myrs.c   | 3423 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/myrs.h   | 1141 +++++++++++++++++
 4 files changed, 4580 insertions(+)
 create mode 100644 drivers/scsi/myrs.c
 create mode 100644 drivers/scsi/myrs.h

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index f2a71bb74f48..c1d3d0d45ced 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -572,6 +572,21 @@ config SCSI_MYRB
 	  To compile this driver as a module, choose M here: the
 	  module will be called myrb.
 
+config SCSI_MYRS
+	tristate "Mylex DAC960/DAC1100 PCI RAID Controller (SCSI Interface)"
+	depends on PCI
+	select RAID_ATTRS
+	help
+	  This driver adds support for the Mylex DAC960, AcceleRAID, and
+	  eXtremeRAID PCI RAID controllers.  This driver supports the
+	  newer, SCSI-based interface only.
+	  This driver is a reimplementation of the original DAC960
+	  driver. If you have used the DAC960 driver you should enable
+	  this module.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called myrs.
+
 config VMWARE_PVSCSI
 	tristate "VMware PVSCSI driver support"
 	depends on PCI && SCSI && X86
diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
index cfd58ffc0b61..fcb41ae329c4 100644
--- a/drivers/scsi/Makefile
+++ b/drivers/scsi/Makefile
@@ -107,6 +107,7 @@ obj-$(CONFIG_SCSI_QLOGICPTI)	+= qlogicpti.o
 obj-$(CONFIG_SCSI_MESH)		+= mesh.o
 obj-$(CONFIG_SCSI_MAC53C94)	+= mac53c94.o
 obj-$(CONFIG_SCSI_MYRB)		+= myrb.o
+obj-$(CONFIG_SCSI_MYRS)		+= myrs.o
 obj-$(CONFIG_BLK_DEV_3W_XXXX_RAID) += 3w-xxxx.o
 obj-$(CONFIG_SCSI_3W_9XXX)	+= 3w-9xxx.o
 obj-$(CONFIG_SCSI_3W_SAS)	+= 3w-sas.o
diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
new file mode 100644
index 000000000000..bf8beccddfb8
--- /dev/null
+++ b/drivers/scsi/myrs.c
@@ -0,0 +1,3423 @@
+/*
+ * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
+ *
+ * This driver supports the newer, SCSI-based firmware interface only.
+ *
+ * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
+ *
+ * Based on the original DAC960 driver, which has
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
+#include "myrs.h"
+
+static struct raid_template *myrs_raid_template;
+
+static struct myrs_devstate_name_entry {
+	enum myrs_devstate state;
+	char *name;
+} myrs_devstate_name_list[] = {
+	{ DAC960_V2_Device_Unconfigured, "Unconfigured" },
+	{ DAC960_V2_Device_Online, "Online" },
+	{ DAC960_V2_Device_Rebuild, "Rebuild" },
+	{ DAC960_V2_Device_Missing, "Missing" },
+	{ DAC960_V2_Device_SuspectedCritical, "SuspectedCritical" },
+	{ DAC960_V2_Device_Offline, "Offline" },
+	{ DAC960_V2_Device_Critical, "Critical" },
+	{ DAC960_V2_Device_SuspectedDead, "SuspectedDead" },
+	{ DAC960_V2_Device_CommandedOffline, "CommandedOffline" },
+	{ DAC960_V2_Device_Standby, "Standby" },
+	{ DAC960_V2_Device_InvalidState, NULL },
+};
+
+static char *myrs_devstate_name(enum myrs_devstate state)
+{
+	struct myrs_devstate_name_entry *entry = myrs_devstate_name_list;
+
+	while (entry && entry->name) {
+		if (entry->state == state)
+			return entry->name;
+		entry++;
+	}
+	return NULL;
+}
+
+static struct myrs_raid_level_name_entry {
+	enum myrs_raid_level level;
+	char *name;
+} myrs_raid_level_name_list[] = {
+	{ DAC960_V2_RAID_Level0, "RAID0" },
+	{ DAC960_V2_RAID_Level1, "RAID1" },
+	{ DAC960_V2_RAID_Level3, "RAID3 right asymmetric parity" },
+	{ DAC960_V2_RAID_Level5, "RAID5 right asymmetric parity" },
+	{ DAC960_V2_RAID_Level6, "RAID6" },
+	{ DAC960_V2_RAID_JBOD, "JBOD" },
+	{ DAC960_V2_RAID_NewSpan, "New Mylex SPAN" },
+	{ DAC960_V2_RAID_Level3F, "RAID3 fixed parity" },
+	{ DAC960_V2_RAID_Level3L, "RAID3 left symmetric parity" },
+	{ DAC960_V2_RAID_Span, "Mylex SPAN" },
+	{ DAC960_V2_RAID_Level5L, "RAID5 left symmetric parity" },
+	{ DAC960_V2_RAID_LevelE, "RAIDE (concatenation)" },
+	{ DAC960_V2_RAID_Physical, "Physical device" },
+	{ 0xff, NULL }
+};
+
+static char *myrs_raid_level_name(enum myrs_raid_level level)
+{
+	struct myrs_raid_level_name_entry *entry = myrs_raid_level_name_list;
+
+	while (entry && entry->name) {
+		if (entry->level == level)
+			return entry->name;
+		entry++;
+	}
+	return NULL;
+}
+
+/**
+ * myrs_reset_cmd - clears critical fields in struct myrs_cmdblk
+ */
+static inline void myrs_reset_cmd(struct myrs_cmdblk *cmd_blk)
+{
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+
+	memset(mbox, 0, sizeof(union myrs_cmd_mbox));
+	cmd_blk->status = 0;
+}
+
+/**
+ * myrs_qcmd - queues Command for DAC960 V2 Series Controllers.
+ */
+static void myrs_qcmd(struct myrs_hba *cs, struct myrs_cmdblk *cmd_blk)
+{
+	void __iomem *base = cs->io_base;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	union myrs_cmd_mbox *next_mbox = cs->next_cmd_mbox;
+
+	cs->write_cmd_mbox(next_mbox, mbox);
+
+	if (cs->prev_cmd_mbox1->Words[0] == 0 ||
+	    cs->prev_cmd_mbox2->Words[0] == 0)
+		cs->get_cmd_mbox(base);
+
+	cs->prev_cmd_mbox2 = cs->prev_cmd_mbox1;
+	cs->prev_cmd_mbox1 = next_mbox;
+
+	if (++next_mbox > cs->last_cmd_mbox)
+		next_mbox = cs->first_cmd_mbox;
+
+	cs->next_cmd_mbox = next_mbox;
+}
+
+/**
+ * myrs_exec_cmd - executes V2 Command and waits for completion.
+ */
+static void myrs_exec_cmd(struct myrs_hba *cs,
+			  struct myrs_cmdblk *cmd_blk)
+{
+	DECLARE_COMPLETION_ONSTACK(complete);
+	unsigned long flags;
+
+	cmd_blk->complete = &complete;
+	spin_lock_irqsave(&cs->queue_lock, flags);
+	myrs_qcmd(cs, cmd_blk);
+	spin_unlock_irqrestore(&cs->queue_lock, flags);
+
+	if (in_interrupt())
+		return;
+	wait_for_completion(&complete);
+}
+
+/**
+ * myrs_report_progress - prints progress message
+ */
+static void
+myrs_report_progress(struct myrs_hba *cs, unsigned short ldev_num,
+		     unsigned char *msg, unsigned long blocks,
+		     unsigned long size)
+{
+	shost_printk(KERN_INFO, cs->host,
+		     "Logical Drive %d: %s in Progress: %d%% completed\n",
+		     ldev_num, msg,
+		     (100 * (int)(blocks >> 7)) / (int)(size >> 7));
+}
+
+/**
+ * myrs_get_ctlr_info - executes a Controller Information IOCTL Command
+ */
+static unsigned char
+myrs_get_ctlr_info(struct myrs_hba *cs)
+{
+	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	dma_addr_t ctlr_info_addr;
+	union myrs_sgl *sgl;
+	unsigned char status;
+	struct myrs_ctlr_info old;
+
+	memcpy(&old, cs->ctlr_info, sizeof(struct myrs_ctlr_info));
+	ctlr_info_addr = dma_map_single(&cs->pdev->dev, cs->ctlr_info,
+					sizeof(struct myrs_ctlr_info),
+					DMA_FROM_DEVICE);
+	if (dma_mapping_error(&cs->pdev->dev, ctlr_info_addr))
+		return DAC960_V2_AbnormalCompletion;
+
+	mutex_lock(&cs->dcmd_mutex);
+	myrs_reset_cmd(cmd_blk);
+	mbox->ControllerInfo.id = MYRS_DCMD_TAG;
+	mbox->ControllerInfo.opcode = DAC960_V2_IOCTL;
+	mbox->ControllerInfo.control.dma_ctrl_to_host = true;
+	mbox->ControllerInfo.control.no_autosense = true;
+	mbox->ControllerInfo.dma_size = sizeof(struct myrs_ctlr_info);
+	mbox->ControllerInfo.ctlr_num = 0;
+	mbox->ControllerInfo.ioctl_opcode = DAC960_V2_GetControllerInfo;
+	sgl = &mbox->ControllerInfo.dma_addr;
+	sgl->sge[0].sge_addr = ctlr_info_addr;
+	sgl->sge[0].sge_count = mbox->ControllerInfo.dma_size;
+	dev_dbg(&cs->host->shost_gendev, "Sending GetControllerInfo\n");
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	dma_unmap_single(&cs->pdev->dev, ctlr_info_addr,
+			 sizeof(struct myrs_ctlr_info), DMA_FROM_DEVICE);
+	if (status == DAC960_V2_NormalCompletion) {
+		if (cs->ctlr_info->bg_init_active +
+		    cs->ctlr_info->ldev_init_active +
+		    cs->ctlr_info->pdev_init_active +
+		    cs->ctlr_info->cc_active +
+		    cs->ctlr_info->rbld_active +
+		    cs->ctlr_info->exp_active != 0)
+			cs->needs_update = true;
+		if (cs->ctlr_info->ldev_present != old.ldev_present ||
+		    cs->ctlr_info->ldev_critical != old.ldev_critical ||
+		    cs->ctlr_info->ldev_offline != old.ldev_offline)
+			shost_printk(KERN_INFO, cs->host,
+				     "Logical drive count changes (%d/%d/%d)\n",
+				     cs->ctlr_info->ldev_critical,
+				     cs->ctlr_info->ldev_offline,
+				     cs->ctlr_info->ldev_present);
+	}
+
+	return status;
+}
+
+/**
+ * myrs_get_ldev_info - executes a Logical Device Information IOCTL Command
+ */
+static unsigned char
+myrs_get_ldev_info(struct myrs_hba *cs, unsigned short ldev_num,
+		   struct myrs_ldev_info *ldev_info)
+{
+	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	dma_addr_t ldev_info_addr;
+	struct myrs_ldev_info ldev_info_orig;
+	union myrs_sgl *sgl;
+	unsigned char status;
+
+	memcpy(&ldev_info_orig, ldev_info, sizeof(struct myrs_ldev_info));
+	ldev_info_addr = dma_map_single(&cs->pdev->dev, ldev_info,
+					sizeof(struct myrs_ldev_info),
+					DMA_FROM_DEVICE);
+	if (dma_mapping_error(&cs->pdev->dev, ldev_info_addr))
+		return DAC960_V2_AbnormalCompletion;
+
+	mutex_lock(&cs->dcmd_mutex);
+	myrs_reset_cmd(cmd_blk);
+	mbox->LogicalDeviceInfo.id = MYRS_DCMD_TAG;
+	mbox->LogicalDeviceInfo.opcode = DAC960_V2_IOCTL;
+	mbox->LogicalDeviceInfo.control.dma_ctrl_to_host = true;
+	mbox->LogicalDeviceInfo.control.no_autosense = true;
+	mbox->LogicalDeviceInfo.dma_size = sizeof(struct myrs_ldev_info);
+	mbox->LogicalDeviceInfo.ldev.ldev_num = ldev_num;
+	mbox->LogicalDeviceInfo.ioctl_opcode =
+		DAC960_V2_GetLogicalDeviceInfoValid;
+	sgl = &mbox->LogicalDeviceInfo.dma_addr;
+	sgl->sge[0].sge_addr = ldev_info_addr;
+	sgl->sge[0].sge_count = mbox->LogicalDeviceInfo.dma_size;
+	dev_dbg(&cs->host->shost_gendev,
+		"Sending GetLogicalDeviceInfoValid for ldev %d\n", ldev_num);
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	dma_unmap_single(&cs->pdev->dev, ldev_info_addr,
+			 sizeof(struct myrs_ldev_info), DMA_FROM_DEVICE);
+	if (status == DAC960_V2_NormalCompletion) {
+		unsigned short ldev_num = ldev_info->ldev_num;
+		struct myrs_ldev_info *new = ldev_info;
+		struct myrs_ldev_info *old = &ldev_info_orig;
+		unsigned long ldev_size = new->cfg_devsize;
+
+		if (new->dev_state != old->dev_state) {
+			const char *name;
+
+			name = myrs_devstate_name(new->dev_state);
+			shost_printk(KERN_INFO, cs->host,
+				     "Logical Drive %d is now %s\n",
+				     ldev_num, name ? name : "Invalid");
+		}
+		if ((new->soft_errs != old->soft_errs) ||
+		    (new->cmds_failed != old->cmds_failed) ||
+		    (new->deferred_write_errs != old->deferred_write_errs))
+			shost_printk(KERN_INFO, cs->host,
+				     "Logical Drive %d Errors: "
+				     "Soft = %d, Failed = %d, Deferred Write = %d\n",
+				     ldev_num, new->soft_errs,
+				     new->cmds_failed,
+				     new->deferred_write_errs);
+		if (new->bg_init_active)
+			myrs_report_progress(cs, ldev_num,
+					     "Background Initialization",
+					     new->bg_init_lba, ldev_size);
+		else if (new->fg_init_active)
+			myrs_report_progress(cs, ldev_num,
+					     "Foreground Initialization",
+					     new->fg_init_lba, ldev_size);
+		else if (new->migration_active)
+			myrs_report_progress(cs, ldev_num,
+					     "Data Migration",
+					     new->migration_lba, ldev_size);
+		else if (new->patrol_active)
+			myrs_report_progress(cs, ldev_num,
+					     "Patrol Operation",
+					     new->patrol_lba, ldev_size);
+		if (old->bg_init_active && !new->bg_init_active)
+			shost_printk(KERN_INFO, cs->host,
+				     "Logical Drive %d: "
+				     "Background Initialization %s\n",
+				     ldev_num,
+				     (new->ldev_control.ldev_init_done ?
+				      "Completed" : "Failed"));
+	}
+	return status;
+}
+
+/**
+ * myrs_get_pdev_info - executes a "Read Physical Device Information" Command
+ */
+static unsigned char
+myrs_get_pdev_info(struct myrs_hba *cs, unsigned char channel,
+		   unsigned char target, unsigned char lun,
+		   struct myrs_pdev_info *pdev_info)
+{
+	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	dma_addr_t pdev_info_addr;
+	union myrs_sgl *sgl;
+	unsigned char status;
+
+	pdev_info_addr = dma_map_single(&cs->pdev->dev, pdev_info,
+					sizeof(struct myrs_pdev_info),
+					DMA_FROM_DEVICE);
+	if (dma_mapping_error(&cs->pdev->dev, pdev_info_addr))
+		return DAC960_V2_AbnormalCompletion;
+
+	mutex_lock(&cs->dcmd_mutex);
+	myrs_reset_cmd(cmd_blk);
+	mbox->PhysicalDeviceInfo.opcode = DAC960_V2_IOCTL;
+	mbox->PhysicalDeviceInfo.id = MYRS_DCMD_TAG;
+	mbox->PhysicalDeviceInfo.control.dma_ctrl_to_host = true;
+	mbox->PhysicalDeviceInfo.control.no_autosense = true;
+	mbox->PhysicalDeviceInfo.dma_size = sizeof(struct myrs_pdev_info);
+	mbox->PhysicalDeviceInfo.pdev.lun = lun;
+	mbox->PhysicalDeviceInfo.pdev.target = target;
+	mbox->PhysicalDeviceInfo.pdev.channel = channel;
+	mbox->PhysicalDeviceInfo.ioctl_opcode =
+		DAC960_V2_GetPhysicalDeviceInfoValid;
+	sgl = &mbox->PhysicalDeviceInfo.dma_addr;
+	sgl->sge[0].sge_addr = pdev_info_addr;
+	sgl->sge[0].sge_count = mbox->PhysicalDeviceInfo.dma_size;
+	dev_dbg(&cs->host->shost_gendev,
+		"Sending GetPhysicalDeviceInfoValid for pdev %d:%d:%d\n",
+		channel, target, lun);
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	dma_unmap_single(&cs->pdev->dev, pdev_info_addr,
+			 sizeof(struct myrs_pdev_info), DMA_FROM_DEVICE);
+	return status;
+}
+
+/**
+ * myrs_dev_op - executes a "Device Operation" Command
+ */
+static unsigned char
+myrs_dev_op(struct myrs_hba *cs, enum myrs_ioctl_opcode opcode,
+	    enum myrs_opdev opdev)
+{
+	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	unsigned char status;
+
+	mutex_lock(&cs->dcmd_mutex);
+	myrs_reset_cmd(cmd_blk);
+	mbox->DeviceOperation.opcode = DAC960_V2_IOCTL;
+	mbox->DeviceOperation.id = MYRS_DCMD_TAG;
+	mbox->DeviceOperation.control.dma_ctrl_to_host = true;
+	mbox->DeviceOperation.control.no_autosense = true;
+	mbox->DeviceOperation.ioctl_opcode = opcode;
+	mbox->DeviceOperation.opdev = opdev;
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	return status;
+}
+
+/**
+ * myrs_translate_pdev - translates a Physical Device Channel and
+ * TargetID into a Logical Device.
+ */
+static unsigned char
+myrs_translate_pdev(struct myrs_hba *cs, unsigned char channel,
+		    unsigned char target, unsigned char lun,
+		    struct myrs_devmap *devmap)
+{
+	struct pci_dev *pdev = cs->pdev;
+	dma_addr_t devmap_addr;
+	struct myrs_cmdblk *cmd_blk;
+	union myrs_cmd_mbox *mbox;
+	union myrs_sgl *sgl;
+	unsigned char status;
+
+	memset(devmap, 0x0, sizeof(struct myrs_devmap));
+	devmap_addr = dma_map_single(&pdev->dev, devmap,
+				     sizeof(struct myrs_devmap),
+				     DMA_FROM_DEVICE);
+	if (dma_mapping_error(&pdev->dev, devmap_addr))
+		return DAC960_V2_AbnormalCompletion;
+
+	mutex_lock(&cs->dcmd_mutex);
+	cmd_blk = &cs->dcmd_blk;
+	mbox = &cmd_blk->mbox;
+	mbox->PhysicalDeviceInfo.opcode = DAC960_V2_IOCTL;
+	mbox->PhysicalDeviceInfo.control.dma_ctrl_to_host = true;
+	mbox->PhysicalDeviceInfo.control.no_autosense = true;
+	mbox->PhysicalDeviceInfo.dma_size = sizeof(struct myrs_devmap);
+	mbox->PhysicalDeviceInfo.pdev.target = target;
+	mbox->PhysicalDeviceInfo.pdev.channel = channel;
+	mbox->PhysicalDeviceInfo.pdev.lun = lun;
+	mbox->PhysicalDeviceInfo.ioctl_opcode =
+		DAC960_V2_TranslatePhysicalToLogicalDevice;
+	sgl = &mbox->PhysicalDeviceInfo.dma_addr;
+	sgl->sge[0].sge_addr = devmap_addr;
+	sgl->sge[0].sge_count = mbox->PhysicalDeviceInfo.dma_size;
+
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	dma_unmap_single(&pdev->dev, devmap_addr,
+			 sizeof(struct myrs_devmap), DMA_FROM_DEVICE);
+	return status;
+}
+
+/**
+ * myrs_get_event - executes a Get Event Command
+ */
+static unsigned char
+myrs_get_event(struct myrs_hba *cs, unsigned int event_num,
+	       struct myrs_event *event_buf)
+{
+	struct pci_dev *pdev = cs->pdev;
+	dma_addr_t event_addr;
+	struct myrs_cmdblk *cmd_blk = &cs->mcmd_blk;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	union myrs_sgl *sgl;
+	unsigned char status;
+
+	event_addr = dma_map_single(&pdev->dev, event_buf,
+				    sizeof(struct myrs_event), DMA_FROM_DEVICE);
+	if (dma_mapping_error(&pdev->dev, event_addr))
+		return DAC960_V2_AbnormalCompletion;
+
+	mbox->GetEvent.opcode = DAC960_V2_IOCTL;
+	mbox->GetEvent.dma_size = sizeof(struct myrs_event);
+	mbox->GetEvent.evnum_upper = event_num >> 16;
+	mbox->GetEvent.ctlr_num = 0;
+	mbox->GetEvent.ioctl_opcode = DAC960_V2_GetEvent;
+	mbox->GetEvent.evnum_lower = event_num & 0xFFFF;
+	sgl = &mbox->GetEvent.dma_addr;
+	sgl->sge[0].sge_addr = event_addr;
+	sgl->sge[0].sge_count = mbox->GetEvent.dma_size;
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	dma_unmap_single(&pdev->dev, event_addr,
+			 sizeof(struct myrs_event), DMA_FROM_DEVICE);
+
+	return status;
+}
+
+/*
+ * myrs_get_fwstatus - executes a Get Health Status Command
+ */
+static unsigned char myrs_get_fwstatus(struct myrs_hba *cs)
+{
+	struct myrs_cmdblk *cmd_blk = &cs->mcmd_blk;
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	union myrs_sgl *sgl;
+	unsigned char status = cmd_blk->status;
+
+	myrs_reset_cmd(cmd_blk);
+	mbox->Common.opcode = DAC960_V2_IOCTL;
+	mbox->Common.id = MYRS_MCMD_TAG;
+	mbox->Common.control.dma_ctrl_to_host = true;
+	mbox->Common.control.no_autosense = true;
+	mbox->Common.dma_size = sizeof(struct myrs_fwstat);
+	mbox->Common.ioctl_opcode = DAC960_V2_GetHealthStatus;
+	sgl = &mbox->Common.dma_addr;
+	sgl->sge[0].sge_addr = cs->fwstat_addr;
+	sgl->sge[0].sge_count = mbox->ControllerInfo.dma_size;
+	dev_dbg(&cs->host->shost_gendev, "Sending GetHealthStatus\n");
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+
+	return status;
+}
+
+/**
+ * myrs_enable_mmio_mbox - enables the Memory Mailbox Interface
+ */
+static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
+				  enable_mbox_t enable_mbox_fn)
+{
+	void __iomem *base = cs->io_base;
+	struct pci_dev *pdev = cs->pdev;
+	union myrs_cmd_mbox *cmd_mbox;
+	struct myrs_stat_mbox *stat_mbox;
+	union myrs_cmd_mbox *mbox;
+	dma_addr_t mbox_addr;
+	unsigned char status = DAC960_V2_AbnormalCompletion;
+
+	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)))
+		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {
+			dev_err(&pdev->dev, "DMA mask out of range\n");
+			return false;
+		}
+
+	/* Temporary dma mapping, used only in the scope of this function */
+	mbox = dma_alloc_coherent(&pdev->dev, sizeof(union myrs_cmd_mbox),
+				  &mbox_addr, GFP_KERNEL);
+	if (dma_mapping_error(&pdev->dev, mbox_addr))
+		return false;
+
+	/* These are the base addresses for the command memory mailbox array */
+	cs->cmd_mbox_size = MYRS_MAX_CMD_MBOX * sizeof(union myrs_cmd_mbox);
+	cmd_mbox = dma_alloc_coherent(&pdev->dev, cs->cmd_mbox_size,
+				      &cs->cmd_mbox_addr, GFP_KERNEL);
+	if (dma_mapping_error(&pdev->dev, cs->cmd_mbox_addr)) {
+		dev_err(&pdev->dev, "Failed to map command mailbox\n");
+		goto out_free;
+	}
+	cs->first_cmd_mbox = cmd_mbox;
+	cmd_mbox += MYRS_MAX_CMD_MBOX - 1;
+	cs->last_cmd_mbox = cmd_mbox;
+	cs->next_cmd_mbox = cs->first_cmd_mbox;
+	cs->prev_cmd_mbox1 = cs->last_cmd_mbox;
+	cs->prev_cmd_mbox2 = cs->last_cmd_mbox - 1;
+
+	/* These are the base addresses for the status memory mailbox array */
+	cs->stat_mbox_size = MYRS_MAX_STAT_MBOX * sizeof(struct myrs_stat_mbox);
+	stat_mbox = dma_alloc_coherent(&pdev->dev, cs->stat_mbox_size,
+				       &cs->stat_mbox_addr, GFP_KERNEL);
+	if (dma_mapping_error(&pdev->dev, cs->stat_mbox_addr)) {
+		dev_err(&pdev->dev, "Failed to map status mailbox\n");
+		goto out_free;
+	}
+
+	cs->first_stat_mbox = stat_mbox;
+	stat_mbox += MYRS_MAX_STAT_MBOX - 1;
+	cs->last_stat_mbox = stat_mbox;
+	cs->next_stat_mbox = cs->first_stat_mbox;
+
+	cs->fwstat_buf = dma_alloc_coherent(&pdev->dev,
+					    sizeof(struct myrs_fwstat),
+					    &cs->fwstat_addr, GFP_KERNEL);
+	if (dma_mapping_error(&pdev->dev, cs->fwstat_addr)) {
+		dev_err(&pdev->dev, "Failed to map firmware health buffer\n");
+		cs->fwstat_buf = NULL;
+		goto out_free;
+	}
+	cs->ctlr_info = kzalloc(sizeof(struct myrs_ctlr_info),
+				GFP_KERNEL | GFP_DMA);
+	if (!cs->ctlr_info) {
+		dev_err(&pdev->dev, "Failed to allocate controller info\n");
+		goto out_free;
+	}
+
+	cs->event_buf = kzalloc(sizeof(struct myrs_event),
+				GFP_KERNEL | GFP_DMA);
+	if (!cs->event_buf) {
+		dev_err(&pdev->dev, "Failed to allocate event buffer\n");
+		goto out_free;
+	}
+
+	/* Enable the Memory Mailbox Interface. */
+	memset(mbox, 0, sizeof(union myrs_cmd_mbox));
+	mbox->SetMemoryMailbox.id = 1;
+	mbox->SetMemoryMailbox.opcode = DAC960_V2_IOCTL;
+	mbox->SetMemoryMailbox.control.no_autosense = true;
+	mbox->SetMemoryMailbox.first_cmd_mbox_size_kb =
+		(MYRS_MAX_CMD_MBOX * sizeof(union myrs_cmd_mbox)) >> 10;
+	mbox->SetMemoryMailbox.first_stat_mbox_size_kb =
+		(MYRS_MAX_STAT_MBOX * sizeof(struct myrs_stat_mbox)) >> 10;
+	mbox->SetMemoryMailbox.second_cmd_mbox_size_kb = 0;
+	mbox->SetMemoryMailbox.second_stat_mbox_size_kb = 0;
+	mbox->SetMemoryMailbox.sense_len = 0;
+	mbox->SetMemoryMailbox.ioctl_opcode = DAC960_V2_SetMemoryMailbox;
+	mbox->SetMemoryMailbox.fwstat_buf_size_kb = 1;
+	mbox->SetMemoryMailbox.fwstat_buf_addr = cs->fwstat_addr;
+	mbox->SetMemoryMailbox.first_cmd_mbox_addr = cs->cmd_mbox_addr;
+	mbox->SetMemoryMailbox.first_stat_mbox_addr = cs->stat_mbox_addr;
+	status = enable_mbox_fn(base, mbox_addr);
+
+out_free:
+	dma_free_coherent(&pdev->dev, sizeof(union myrs_cmd_mbox),
+			  mbox, mbox_addr);
+	if (status != DAC960_V2_NormalCompletion)
+		dev_err(&pdev->dev, "Failed to enable mailbox, status %X\n",
+			status);
+	return (status == DAC960_V2_NormalCompletion);
+}
+
+/**
+ * myrs_get_config - reads the Configuration Information
+ */
+static int myrs_get_config(struct myrs_hba *cs)
+{
+	struct myrs_ctlr_info *info = cs->ctlr_info;
+	struct Scsi_Host *shost = cs->host;
+	unsigned char status;
+	unsigned char model[20];
+	unsigned char fw_version[12];
+	int i, model_len;
+
+	/* Get data into dma-able area, then copy into permanent location */
+	mutex_lock(&cs->cinfo_mutex);
+	status = myrs_get_ctlr_info(cs);
+	mutex_unlock(&cs->cinfo_mutex);
+	if (status != DAC960_V2_NormalCompletion) {
+		shost_printk(KERN_ERR, shost,
+			     "Failed to get controller information\n");
+		return -ENODEV;
+	}
+
+	/* Initialize the Controller Model Name and Full Model Name fields. */
+	model_len = sizeof(info->ctlr_name);
+	if (model_len > sizeof(model)-1)
+		model_len = sizeof(model)-1;
+	memcpy(model, info->ctlr_name, model_len);
+	model_len--;
+	while (model[model_len] == ' ' || model[model_len] == '\0')
+		model_len--;
+	model[++model_len] = '\0';
+	strcpy(cs->model_name, "DAC960 ");
+	strcat(cs->model_name, model);
+	/* Initialize the Controller Firmware Version field. */
+	sprintf(fw_version, "%d.%02d-%02d",
+		info->fw_major_version, info->fw_minor_version,
+		info->fw_turn_number);
+	if (info->fw_major_version == 6 &&
+	    info->fw_minor_version == 0 &&
+	    info->fw_turn_number < 1) {
+		shost_printk(KERN_WARNING, shost,
+			"FIRMWARE VERSION %s DOES NOT PROVIDE THE CONTROLLER\n"
+			"STATUS MONITORING FUNCTIONALITY NEEDED BY THIS DRIVER.\n"
+			"PLEASE UPGRADE TO VERSION 6.00-01 OR ABOVE.\n",
+			fw_version);
+		return -ENODEV;
+	}
+	/* Initialize the Controller Channels and Targets. */
+	shost->max_channel = info->physchan_present + info->virtchan_present;
+	shost->max_id = info->max_targets[0];
+	for (i = 1; i < 16; i++) {
+		if (!info->max_targets[i])
+			continue;
+		if (shost->max_id < info->max_targets[i])
+			shost->max_id = info->max_targets[i];
+	}
+
+	/*
+	 * Initialize the Controller Queue Depth, Driver Queue Depth,
+	 * Logical Drive Count, Maximum Blocks per Command, Controller
+	 * Scatter/Gather Limit, and Driver Scatter/Gather Limit.
+	 * The Driver Queue Depth must be at most three less than
+	 * the Controller Queue Depth; tag '1' is reserved for
+	 * direct commands, and tag '2' for monitoring commands.
+	 */
+	shost->can_queue = info->max_tcq - 3;
+	if (shost->can_queue > MYRS_MAX_CMD_MBOX - 3)
+		shost->can_queue = MYRS_MAX_CMD_MBOX - 3;
+	shost->max_sectors = info->max_transfer_size;
+	shost->sg_tablesize = info->max_sge;
+	if (shost->sg_tablesize > MYRS_SG_LIMIT)
+		shost->sg_tablesize = MYRS_SG_LIMIT;
+
+	shost_printk(KERN_INFO, shost,
+		"Configuring %s PCI RAID Controller\n", model);
+	shost_printk(KERN_INFO, shost,
+		"  Firmware Version: %s, Channels: %d, Memory Size: %dMB\n",
+		fw_version, info->physchan_present, info->mem_size_mb);
+
+	shost_printk(KERN_INFO, shost,
+		     "  Controller Queue Depth: %d,"
+		     " Maximum Blocks per Command: %d\n",
+		     shost->can_queue, shost->max_sectors);
+
+	shost_printk(KERN_INFO, shost,
+		     "  Driver Queue Depth: %d,"
+		     " Scatter/Gather Limit: %d of %d Segments\n",
+		     shost->can_queue, shost->sg_tablesize, MYRS_SG_LIMIT);
+	for (i = 0; i < info->physchan_max; i++) {
+		if (!info->max_targets[i])
+			continue;
+		shost_printk(KERN_INFO, shost,
+			     "  Device Channel %d: max %d devices\n",
+			     i, info->max_targets[i]);
+	}
+	shost_printk(KERN_INFO, shost,
+		     "  Physical: %d/%d channels, %d disks, %d devices\n",
+		     info->physchan_present, info->physchan_max,
+		     info->pdisk_present, info->pdev_present);
+
+	shost_printk(KERN_INFO, shost,
+		     "  Logical: %d/%d channels, %d disks\n",
+		     info->virtchan_present, info->virtchan_max,
+		     info->ldev_present);
+	return 0;
+}
+
+/**
+ * myrs_log_event - prints a Controller Event message
+ */
+static struct {
+	int ev_code;
+	unsigned char *ev_msg;
+} myrs_ev_list[] =
+{ /* Physical Device Events (0x0000 - 0x007F) */
+	{ 0x0001, "P Online" },
+	{ 0x0002, "P Standby" },
+	{ 0x0005, "P Automatic Rebuild Started" },
+	{ 0x0006, "P Manual Rebuild Started" },
+	{ 0x0007, "P Rebuild Completed" },
+	{ 0x0008, "P Rebuild Cancelled" },
+	{ 0x0009, "P Rebuild Failed for Unknown Reasons" },
+	{ 0x000A, "P Rebuild Failed due to New Physical Device" },
+	{ 0x000B, "P Rebuild Failed due to Logical Drive Failure" },
+	{ 0x000C, "S Offline" },
+	{ 0x000D, "P Found" },
+	{ 0x000E, "P Removed" },
+	{ 0x000F, "P Unconfigured" },
+	{ 0x0010, "P Expand Capacity Started" },
+	{ 0x0011, "P Expand Capacity Completed" },
+	{ 0x0012, "P Expand Capacity Failed" },
+	{ 0x0013, "P Command Timed Out" },
+	{ 0x0014, "P Command Aborted" },
+	{ 0x0015, "P Command Retried" },
+	{ 0x0016, "P Parity Error" },
+	{ 0x0017, "P Soft Error" },
+	{ 0x0018, "P Miscellaneous Error" },
+	{ 0x0019, "P Reset" },
+	{ 0x001A, "P Active Spare Found" },
+	{ 0x001B, "P Warm Spare Found" },
+	{ 0x001C, "S Sense Data Received" },
+	{ 0x001D, "P Initialization Started" },
+	{ 0x001E, "P Initialization Completed" },
+	{ 0x001F, "P Initialization Failed" },
+	{ 0x0020, "P Initialization Cancelled" },
+	{ 0x0021, "P Failed because Write Recovery Failed" },
+	{ 0x0022, "P Failed because SCSI Bus Reset Failed" },
+	{ 0x0023, "P Failed because of Double Check Condition" },
+	{ 0x0024, "P Failed because Device Cannot Be Accessed" },
+	{ 0x0025, "P Failed because of Gross Error on SCSI Processor" },
+	{ 0x0026, "P Failed because of Bad Tag from Device" },
+	{ 0x0027, "P Failed because of Command Timeout" },
+	{ 0x0028, "P Failed because of System Reset" },
+	{ 0x0029, "P Failed because of Busy Status or Parity Error" },
+	{ 0x002A, "P Failed because Host Set Device to Failed State" },
+	{ 0x002B, "P Failed because of Selection Timeout" },
+	{ 0x002C, "P Failed because of SCSI Bus Phase Error" },
+	{ 0x002D, "P Failed because Device Returned Unknown Status" },
+	{ 0x002E, "P Failed because Device Not Ready" },
+	{ 0x002F, "P Failed because Device Not Found at Startup" },
+	{ 0x0030, "P Failed because COD Write Operation Failed" },
+	{ 0x0031, "P Failed because BDT Write Operation Failed" },
+	{ 0x0039, "P Missing at Startup" },
+	{ 0x003A, "P Start Rebuild Failed due to Physical Drive Too Small" },
+	{ 0x003C, "P Temporarily Offline Device Automatically Made Online" },
+	{ 0x003D, "P Standby Rebuild Started" },
+	/* Logical Device Events (0x0080 - 0x00FF) */
+	{ 0x0080, "M Consistency Check Started" },
+	{ 0x0081, "M Consistency Check Completed" },
+	{ 0x0082, "M Consistency Check Cancelled" },
+	{ 0x0083, "M Consistency Check Completed With Errors" },
+	{ 0x0084, "M Consistency Check Failed due to Logical Drive Failure" },
+	{ 0x0085, "M Consistency Check Failed due to Physical Device Failure" },
+	{ 0x0086, "L Offline" },
+	{ 0x0087, "L Critical" },
+	{ 0x0088, "L Online" },
+	{ 0x0089, "M Automatic Rebuild Started" },
+	{ 0x008A, "M Manual Rebuild Started" },
+	{ 0x008B, "M Rebuild Completed" },
+	{ 0x008C, "M Rebuild Cancelled" },
+	{ 0x008D, "M Rebuild Failed for Unknown Reasons" },
+	{ 0x008E, "M Rebuild Failed due to New Physical Device" },
+	{ 0x008F, "M Rebuild Failed due to Logical Drive Failure" },
+	{ 0x0090, "M Initialization Started" },
+	{ 0x0091, "M Initialization Completed" },
+	{ 0x0092, "M Initialization Cancelled" },
+	{ 0x0093, "M Initialization Failed" },
+	{ 0x0094, "L Found" },
+	{ 0x0095, "L Deleted" },
+	{ 0x0096, "M Expand Capacity Started" },
+	{ 0x0097, "M Expand Capacity Completed" },
+	{ 0x0098, "M Expand Capacity Failed" },
+	{ 0x0099, "L Bad Block Found" },
+	{ 0x009A, "L Size Changed" },
+	{ 0x009B, "L Type Changed" },
+	{ 0x009C, "L Bad Data Block Found" },
+	{ 0x009E, "L Read of Data Block in BDT" },
+	{ 0x009F, "L Write Back Data for Disk Block Lost" },
+	{ 0x00A0, "L Temporarily Offline RAID-5/3 Drive Made Online" },
+	{ 0x00A1, "L Temporarily Offline RAID-6/1/0/7 Drive Made Online" },
+	{ 0x00A2, "L Standby Rebuild Started" },
+	/* Fault Management Events (0x0100 - 0x017F) */
+	{ 0x0140, "E Fan %d Failed" },
+	{ 0x0141, "E Fan %d OK" },
+	{ 0x0142, "E Fan %d Not Present" },
+	{ 0x0143, "E Power Supply %d Failed" },
+	{ 0x0144, "E Power Supply %d OK" },
+	{ 0x0145, "E Power Supply %d Not Present" },
+	{ 0x0146, "E Temperature Sensor %d Temperature Exceeds Safe Limit" },
+	{ 0x0147, "E Temperature Sensor %d Temperature Exceeds Working Limit" },
+	{ 0x0148, "E Temperature Sensor %d Temperature Normal" },
+	{ 0x0149, "E Temperature Sensor %d Not Present" },
+	{ 0x014A, "E Enclosure Management Unit %d Access Critical" },
+	{ 0x014B, "E Enclosure Management Unit %d Access OK" },
+	{ 0x014C, "E Enclosure Management Unit %d Access Offline" },
+	/* Controller Events (0x0180 - 0x01FF) */
+	{ 0x0181, "C Cache Write Back Error" },
+	{ 0x0188, "C Battery Backup Unit Found" },
+	{ 0x0189, "C Battery Backup Unit Charge Level Low" },
+	{ 0x018A, "C Battery Backup Unit Charge Level OK" },
+	{ 0x0193, "C Installation Aborted" },
+	{ 0x0195, "C Battery Backup Unit Physically Removed" },
+	{ 0x0196, "C Memory Error During Warm Boot" },
+	{ 0x019E, "C Memory Soft ECC Error Corrected" },
+	{ 0x019F, "C Memory Hard ECC Error Corrected" },
+	{ 0x01A2, "C Battery Backup Unit Failed" },
+	{ 0x01AB, "C Mirror Race Recovery Failed" },
+	{ 0x01AC, "C Mirror Race on Critical Drive" },
+	/* Controller Internal Processor Events */
+	{ 0x0380, "C Internal Controller Hung" },
+	{ 0x0381, "C Internal Controller Firmware Breakpoint" },
+	{ 0x0390, "C Internal Controller i960 Processor Specific Error" },
+	{ 0x03A0, "C Internal Controller StrongARM Processor Specific Error" },
+	{ 0, "" }
+};
+
+static void myrs_log_event(struct myrs_hba *cs, struct myrs_event *ev)
+{
+	unsigned char msg_buf[MYRS_LINE_BUFFER_SIZE];
+	int ev_idx = 0, ev_code;
+	unsigned char ev_type, *ev_msg;
+	struct Scsi_Host *shost = cs->host;
+	struct scsi_device *sdev;
+	struct scsi_sense_hdr sshdr;
+	unsigned char sense_info[4];
+	unsigned char cmd_specific[4];
+
+	if (ev->ev_code == 0x1C) {
+		if (!scsi_normalize_sense(ev->sense_data, 40, &sshdr)) {
+			memset(&sshdr, 0x0, sizeof(sshdr));
+			memset(sense_info, 0x0, sizeof(sense_info));
+			memset(cmd_specific, 0x0, sizeof(cmd_specific));
+		} else {
+			memcpy(sense_info, &ev->sense_data[3], 4);
+			memcpy(cmd_specific, &ev->sense_data[7], 4);
+		}
+	}
+	if (sshdr.sense_key == VENDOR_SPECIFIC &&
+	    (sshdr.asc == 0x80 || sshdr.asc == 0x81))
+		ev->ev_code = ((sshdr.asc - 0x80) << 8 | sshdr.ascq);
+	while (true) {
+		ev_code = myrs_ev_list[ev_idx].ev_code;
+		if (ev_code == ev->ev_code || ev_code == 0)
+			break;
+		ev_idx++;
+	}
+	ev_type = myrs_ev_list[ev_idx].ev_msg[0];
+	ev_msg = &myrs_ev_list[ev_idx].ev_msg[2];
+	if (ev_code == 0) {
+		shost_printk(KERN_WARNING, shost,
+			     "Unknown Controller Event Code %04X\n",
+			     ev->ev_code);
+		return;
+	}
+	switch (ev_type) {
+	case 'P':
+		sdev = scsi_device_lookup(shost, ev->channel,
+					  ev->target, 0);
+		sdev_printk(KERN_INFO, sdev, "event %d: Physical Device %s\n",
+			    ev->ev_seq, ev_msg);
+		if (sdev && sdev->hostdata &&
+		    sdev->channel < cs->ctlr_info->physchan_present) {
+			struct myrs_pdev_info *pdev_info = sdev->hostdata;
+			switch (ev->ev_code) {
+			case 0x0001:
+			case 0x0007:
+				pdev_info->dev_state = DAC960_V2_Device_Online;
+				break;
+			case 0x0002:
+				pdev_info->dev_state = DAC960_V2_Device_Standby;
+				break;
+			case 0x000C:
+				pdev_info->dev_state = DAC960_V2_Device_Offline;
+				break;
+			case 0x000E:
+				pdev_info->dev_state = DAC960_V2_Device_Missing;
+				break;
+			case 0x000F:
+				pdev_info->dev_state =
+					DAC960_V2_Device_Unconfigured;
+				break;
+			}
+		}
+		break;
+	case 'L':
+		shost_printk(KERN_INFO, shost,
+			     "event %d: Logical Drive %d %s\n",
+			     ev->ev_seq, ev->lun, ev_msg);
+		cs->needs_update = true;
+		break;
+	case 'M':
+		shost_printk(KERN_INFO, shost,
+			     "event %d: Logical Drive %d %s\n",
+			     ev->ev_seq, ev->lun, ev_msg);
+		cs->needs_update = true;
+		break;
+	case 'S':
+		if (sshdr.sense_key == NO_SENSE ||
+		    (sshdr.sense_key == NOT_READY &&
+		     sshdr.asc == 0x04 && (sshdr.ascq == 0x01 ||
+					    sshdr.ascq == 0x02)))
+			break;
+		shost_printk(KERN_INFO, shost,
+			     "event %d: Physical Device %d:%d %s\n",
+			     ev->ev_seq, ev->channel, ev->target, ev_msg);
+		shost_printk(KERN_INFO, shost,
+			     "Physical Device %d:%d Request Sense: "
+			     "Sense Key = %X, ASC = %02X, ASCQ = %02X\n",
+			     ev->channel, ev->target,
+			     sshdr.sense_key, sshdr.asc, sshdr.ascq);
+		shost_printk(KERN_INFO, shost,
+			     "Physical Device %d:%d Request Sense: "
+			     "Information = %02X%02X%02X%02X "
+			     "%02X%02X%02X%02X\n",
+			     ev->channel, ev->target,
+			     sense_info[0], sense_info[1],
+			     sense_info[2], sense_info[3],
+			     cmd_specific[0], cmd_specific[1],
+			     cmd_specific[2], cmd_specific[3]);
+		break;
+	case 'E':
+		if (cs->disable_enc_msg)
+			break;
+		sprintf(msg_buf, ev_msg, ev->lun);
+		shost_printk(KERN_INFO, shost, "event %d: Enclosure %d %s\n",
+			     ev->ev_seq, ev->target, msg_buf);
+		break;
+	case 'C':
+		shost_printk(KERN_INFO, shost, "event %d: Controller %s\n",
+			     ev->ev_seq, ev_msg);
+		break;
+	default:
+		shost_printk(KERN_INFO, shost,
+			     "event %d: Unknown Event Code %04X\n",
+			     ev->ev_seq, ev->ev_code);
+		break;
+	}
+}
+
+/*
+ * SCSI sysfs interface functions
+ */
+static ssize_t myrs_show_dev_state(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	int ret;
+
+	if (!sdev->hostdata)
+		return snprintf(buf, 16, "Unknown\n");
+
+	if (sdev->channel >= cs->ctlr_info->physchan_present) {
+		struct myrs_ldev_info *ldev_info = sdev->hostdata;
+		const char *name;
+
+		name = myrs_devstate_name(ldev_info->dev_state);
+		if (name)
+			ret = snprintf(buf, 32, "%s\n", name);
+		else
+			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+				       ldev_info->dev_state);
+	} else {
+		struct myrs_pdev_info *pdev_info;
+		const char *name;
+
+		pdev_info = sdev->hostdata;
+		name = myrs_devstate_name(pdev_info->dev_state);
+		if (name)
+			ret = snprintf(buf, 32, "%s\n", name);
+		else
+			ret = snprintf(buf, 32, "Invalid (%02X)\n",
+				       pdev_info->dev_state);
+	}
+	return ret;
+}
+
+static ssize_t myrs_store_dev_state(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_cmdblk *cmd_blk;
+	union myrs_cmd_mbox *mbox;
+	enum myrs_devstate new_state;
+	unsigned short ldev_num;
+	unsigned char status;
+
+	if (!strncmp(buf, "offline", 7) ||
+	    !strncmp(buf, "kill", 4))
+		new_state = DAC960_V2_Device_Offline;
+	else if (!strncmp(buf, "online", 6))
+		new_state = DAC960_V2_Device_Online;
+	else if (!strncmp(buf, "standby", 7))
+		new_state = DAC960_V2_Device_Standby;
+	else
+		return -EINVAL;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present) {
+		struct myrs_pdev_info *pdev_info = sdev->hostdata;
+		struct myrs_devmap *pdev_devmap =
+			(struct myrs_devmap *)&pdev_info->rsvd13;
+
+		if (pdev_info->dev_state == new_state) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Device already in %s\n",
+				    myrs_devstate_name(new_state));
+			return count;
+		}
+		status = myrs_translate_pdev(cs, sdev->channel, sdev->id,
+					     sdev->lun, pdev_devmap);
+		if (status != DAC960_V2_NormalCompletion)
+			return -ENXIO;
+		ldev_num = pdev_devmap->ldev_num;
+	} else {
+		struct myrs_ldev_info *ldev_info = sdev->hostdata;
+
+		if (ldev_info->dev_state == new_state) {
+			sdev_printk(KERN_INFO, sdev,
+				    "Device already in %s\n",
+				    myrs_devstate_name(new_state));
+			return count;
+		}
+		ldev_num = ldev_info->ldev_num;
+	}
+	mutex_lock(&cs->dcmd_mutex);
+	cmd_blk = &cs->dcmd_blk;
+	myrs_reset_cmd(cmd_blk);
+	mbox = &cmd_blk->mbox;
+	mbox->Common.opcode = DAC960_V2_IOCTL;
+	mbox->Common.id = MYRS_DCMD_TAG;
+	mbox->Common.control.dma_ctrl_to_host = true;
+	mbox->Common.control.no_autosense = true;
+	mbox->SetDeviceState.ioctl_opcode = DAC960_V2_SetDeviceState;
+	mbox->SetDeviceState.state = new_state;
+	mbox->SetDeviceState.ldev.ldev_num = ldev_num;
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	if (status == DAC960_V2_NormalCompletion) {
+		if (sdev->channel < cs->ctlr_info->physchan_present) {
+			struct myrs_pdev_info *pdev_info = sdev->hostdata;
+
+			pdev_info->dev_state = new_state;
+		} else {
+			struct myrs_ldev_info *ldev_info = sdev->hostdata;
+
+			ldev_info->dev_state = new_state;
+		}
+		sdev_printk(KERN_INFO, sdev,
+			    "Set device state to %s\n",
+			    myrs_devstate_name(new_state));
+		return count;
+	}
+	sdev_printk(KERN_INFO, sdev,
+		    "Failed to set device state to %s, status 0x%02x\n",
+		    myrs_devstate_name(new_state), status);
+	return -EINVAL;
+}
+
+static DEVICE_ATTR(raid_state, S_IRUGO | S_IWUSR, myrs_show_dev_state,
+		   myrs_store_dev_state);
+
+static ssize_t myrs_show_dev_level(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	const char *name = NULL;
+
+	if (!sdev->hostdata)
+		return snprintf(buf, 16, "Unknown\n");
+
+	if (sdev->channel >= cs->ctlr_info->physchan_present) {
+		struct myrs_ldev_info *ldev_info;
+
+		ldev_info = sdev->hostdata;
+		name = myrs_raid_level_name(ldev_info->raid_level);
+		if (!name)
+			return snprintf(buf, 32, "Invalid (%02X)\n",
+					ldev_info->dev_state);
+
+	} else
+		name = myrs_raid_level_name(DAC960_V2_RAID_Physical);
+
+	return snprintf(buf, 32, "%s\n", name);
+}
+static DEVICE_ATTR(raid_level, S_IRUGO, myrs_show_dev_level, NULL);
+
+static ssize_t myrs_show_dev_rebuild(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info;
+	unsigned short ldev_num;
+	unsigned char status;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present)
+		return snprintf(buf, 32, "physical device - not rebuilding\n");
+
+	ldev_info = sdev->hostdata;
+	ldev_num = ldev_info->ldev_num;
+	status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+	if (status != DAC960_V2_NormalCompletion) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed to get device information, status 0x%02x\n",
+			    status);
+		return -EIO;
+	}
+	if (ldev_info->rbld_active) {
+		return snprintf(buf, 32, "rebuilding block %zu of %zu\n",
+				(size_t)ldev_info->rbld_lba,
+				(size_t)ldev_info->cfg_devsize);
+	} else
+		return snprintf(buf, 32, "not rebuilding\n");
+}
+
+static ssize_t myrs_store_dev_rebuild(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info;
+	struct myrs_cmdblk *cmd_blk;
+	union myrs_cmd_mbox *mbox;
+	char tmpbuf[8];
+	ssize_t len;
+	unsigned short ldev_num;
+	unsigned char status;
+	int rebuild;
+	int ret = count;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present)
+		return -EINVAL;
+
+	ldev_info = sdev->hostdata;
+	if (!ldev_info)
+		return -ENXIO;
+	ldev_num = ldev_info->ldev_num;
+
+	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	strncpy(tmpbuf, buf, len);
+	tmpbuf[len] = '\0';
+	if (sscanf(tmpbuf, "%d", &rebuild) != 1)
+		return -EINVAL;
+
+	status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+	if (status != DAC960_V2_NormalCompletion) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed to get device information, status 0x%02x\n",
+			    status);
+		return -EIO;
+	}
+
+	if (rebuild && ldev_info->rbld_active) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Rebuild Not Initiated; already in progress\n");
+		return -EALREADY;
+	}
+	if (!rebuild && !ldev_info->rbld_active) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Rebuild Not Cancelled; no rebuild in progress\n");
+		return ret;
+	}
+
+	mutex_lock(&cs->dcmd_mutex);
+	cmd_blk = &cs->dcmd_blk;
+	myrs_reset_cmd(cmd_blk);
+	mbox = &cmd_blk->mbox;
+	mbox->Common.opcode = DAC960_V2_IOCTL;
+	mbox->Common.id = MYRS_DCMD_TAG;
+	mbox->Common.control.dma_ctrl_to_host = true;
+	mbox->Common.control.no_autosense = true;
+	if (rebuild) {
+		mbox->LogicalDeviceInfo.ldev.ldev_num = ldev_num;
+		mbox->LogicalDeviceInfo.ioctl_opcode =
+			DAC960_V2_RebuildDeviceStart;
+	} else {
+		mbox->LogicalDeviceInfo.ldev.ldev_num = ldev_num;
+		mbox->LogicalDeviceInfo.ioctl_opcode =
+			DAC960_V2_RebuildDeviceStop;
+	}
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	if (status) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Rebuild Not %s, status 0x%02x\n",
+			    rebuild ? "Initiated" : "Cancelled", status);
+		ret = -EIO;
+	} else
+		sdev_printk(KERN_INFO, sdev, "Rebuild %s\n",
+			    rebuild ? "Initiated" : "Cancelled");
+
+	return ret;
+}
+static DEVICE_ATTR(rebuild, S_IRUGO | S_IWUSR, myrs_show_dev_rebuild,
+		   myrs_store_dev_rebuild);
+
+static ssize_t myrs_show_consistency_check(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info;
+	unsigned short ldev_num;
+	unsigned char status;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present)
+		return snprintf(buf, 32, "physical device - not checking\n");
+
+	ldev_info = sdev->hostdata;
+	if (!ldev_info)
+		return -ENXIO;
+	ldev_num = ldev_info->ldev_num;
+	status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+	if (ldev_info->cc_active)
+		return snprintf(buf, 32, "checking block %zu of %zu\n",
+				(size_t)ldev_info->cc_lba,
+				(size_t)ldev_info->cfg_devsize);
+	else
+		return snprintf(buf, 32, "not checking\n");
+}
+
+static ssize_t myrs_store_consistency_check(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info;
+	struct myrs_cmdblk *cmd_blk;
+	union myrs_cmd_mbox *mbox;
+	char tmpbuf[8];
+	ssize_t len;
+	unsigned short ldev_num;
+	unsigned char status;
+	int check;
+	int ret = count;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present)
+		return -EINVAL;
+
+	ldev_info = sdev->hostdata;
+	if (!ldev_info)
+		return -ENXIO;
+	ldev_num = ldev_info->ldev_num;
+
+	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	strncpy(tmpbuf, buf, len);
+	tmpbuf[len] = '\0';
+	if (sscanf(tmpbuf, "%d", &check) != 1)
+		return -EINVAL;
+
+	status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+	if (status != DAC960_V2_NormalCompletion) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Failed to get device information, status 0x%02x\n",
+			    status);
+		return -EIO;
+	}
+	if (check && ldev_info->cc_active) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Consistency Check Not Initiated; "
+			    "already in progress\n");
+		return -EALREADY;
+	}
+	if (!check && !ldev_info->cc_active) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Consistency Check Not Cancelled; "
+			    "check not in progress\n");
+		return ret;
+	}
+
+	mutex_lock(&cs->dcmd_mutex);
+	cmd_blk = &cs->dcmd_blk;
+	myrs_reset_cmd(cmd_blk);
+	mbox = &cmd_blk->mbox;
+	mbox->Common.opcode = DAC960_V2_IOCTL;
+	mbox->Common.id = MYRS_DCMD_TAG;
+	mbox->Common.control.dma_ctrl_to_host = true;
+	mbox->Common.control.no_autosense = true;
+	if (check) {
+		mbox->ConsistencyCheck.ldev.ldev_num = ldev_num;
+		mbox->ConsistencyCheck.ioctl_opcode =
+			DAC960_V2_ConsistencyCheckStart;
+		mbox->ConsistencyCheck.RestoreConsistency = true;
+		mbox->ConsistencyCheck.InitializedAreaOnly = false;
+	} else {
+		mbox->ConsistencyCheck.ldev.ldev_num = ldev_num;
+		mbox->ConsistencyCheck.ioctl_opcode =
+			DAC960_V2_ConsistencyCheckStop;
+	}
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	if (status != DAC960_V2_NormalCompletion) {
+		sdev_printk(KERN_INFO, sdev,
+			    "Consistency Check Not %s, status 0x%02x\n",
+			    check ? "Initiated" : "Cancelled", status);
+		ret = -EIO;
+	} else
+		sdev_printk(KERN_INFO, sdev, "Consistency Check %s\n",
+			    check ? "Initiated" : "Cancelled");
+
+	return ret;
+}
+static DEVICE_ATTR(consistency_check, S_IRUGO | S_IWUSR,
+		   myrs_show_consistency_check,
+		   myrs_store_consistency_check);
+
+static struct device_attribute *myrs_sdev_attrs[] = {
+	&dev_attr_consistency_check,
+	&dev_attr_rebuild,
+	&dev_attr_raid_state,
+	&dev_attr_raid_level,
+	NULL,
+};
+
+static ssize_t myrs_show_ctlr_serial(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+	char serial[17];
+
+	memcpy(serial, cs->ctlr_info->serial_number, 16);
+	serial[16] = '\0';
+	return snprintf(buf, 16, "%s\n", serial);
+}
+static DEVICE_ATTR(serial, S_IRUGO, myrs_show_ctlr_serial, NULL);
+
+static ssize_t myrs_show_ctlr_num(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	return snprintf(buf, 20, "%d\n", cs->host->host_no);
+}
+static DEVICE_ATTR(ctlr_num, S_IRUGO, myrs_show_ctlr_num, NULL);
+
+static struct myrs_cpu_type_tbl {
+	enum myrs_cpu_type type;
+	char *name;
+} myrs_cpu_type_names[] = {
+	{ DAC960_V2_ProcessorType_i960CA, "i960CA" },
+	{ DAC960_V2_ProcessorType_i960RD, "i960RD" },
+	{ DAC960_V2_ProcessorType_i960RN, "i960RN" },
+	{ DAC960_V2_ProcessorType_i960RP, "i960RP" },
+	{ DAC960_V2_ProcessorType_NorthBay, "NorthBay" },
+	{ DAC960_V2_ProcessorType_StrongArm, "StrongARM" },
+	{ DAC960_V2_ProcessorType_i960RM, "i960RM" },
+	{ 0xff, NULL },
+};
+
+static ssize_t myrs_show_processor(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+	struct myrs_cpu_type_tbl *tbl = myrs_cpu_type_names;
+	const char *first_processor = NULL;
+	const char *second_processor = NULL;
+	struct myrs_ctlr_info *info = cs->ctlr_info;
+	ssize_t ret;
+
+	if (info->cpu[0].cpu_count) {
+		while (tbl && tbl->name) {
+			if (tbl->type == info->cpu[0].cpu_type) {
+				first_processor = tbl->name;
+				break;
+			}
+			tbl++;
+		}
+	}
+	if (info->cpu[1].cpu_count) {
+		tbl = myrs_cpu_type_names;
+		while (tbl && tbl->name) {
+			if (tbl->type == info->cpu[1].cpu_type) {
+				second_processor = tbl->name;
+				break;
+			}
+			tbl++;
+		}
+	}
+	if (first_processor && second_processor)
+		ret = snprintf(buf, 64, "1: %s (%s, %d cpus)\n"
+			       "2: %s (%s, %d cpus)\n",
+			       info->cpu[0].cpu_name,
+			       first_processor, info->cpu[0].cpu_count,
+			       info->cpu[1].cpu_name,
+			       second_processor, info->cpu[1].cpu_count);
+	else if (!second_processor)
+		ret = snprintf(buf, 64, "1: %s (%s, %d cpus)\n2: absent\n",
+			       info->cpu[0].cpu_name,
+			       first_processor, info->cpu[0].cpu_count);
+	else if (!first_processor)
+		ret = snprintf(buf, 64, "1: absent\n2: %s (%s, %d cpus)\n",
+			       info->cpu[1].cpu_name,
+			       second_processor, info->cpu[1].cpu_count);
+	else
+		ret = snprintf(buf, 64, "1: absent\n2: absent\n");
+
+	return ret;
+}
+static DEVICE_ATTR(processor, S_IRUGO, myrs_show_processor, NULL);
+
+static ssize_t myrs_show_model_name(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	return snprintf(buf, 28, "%s\n", cs->model_name);
+}
+static DEVICE_ATTR(model, S_IRUGO, myrs_show_model_name, NULL);
+
+static ssize_t myrs_show_ctlr_type(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	return snprintf(buf, 4, "%d\n", cs->ctlr_info->ctlr_type);
+}
+static DEVICE_ATTR(ctlr_type, S_IRUGO, myrs_show_ctlr_type, NULL);
+
+static ssize_t myrs_show_cache_size(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	return snprintf(buf, 8, "%d MB\n", cs->ctlr_info->cache_size_mb);
+}
+static DEVICE_ATTR(cache_size, S_IRUGO, myrs_show_cache_size, NULL);
+
+static ssize_t myrs_show_firmware_version(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	return snprintf(buf, 16, "%d.%02d-%02d\n",
+			cs->ctlr_info->fw_major_version,
+			cs->ctlr_info->fw_minor_version,
+			cs->ctlr_info->fw_turn_number);
+}
+static DEVICE_ATTR(firmware, S_IRUGO, myrs_show_firmware_version, NULL);
+
+static ssize_t myrs_store_discovery_command(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+	struct myrs_cmdblk *cmd_blk;
+	union myrs_cmd_mbox *mbox;
+	unsigned char status;
+
+	mutex_lock(&cs->dcmd_mutex);
+	cmd_blk = &cs->dcmd_blk;
+	myrs_reset_cmd(cmd_blk);
+	mbox = &cmd_blk->mbox;
+	mbox->Common.opcode = DAC960_V2_IOCTL;
+	mbox->Common.id = MYRS_DCMD_TAG;
+	mbox->Common.control.dma_ctrl_to_host = true;
+	mbox->Common.control.no_autosense = true;
+	mbox->Common.ioctl_opcode = DAC960_V2_StartDiscovery;
+	myrs_exec_cmd(cs, cmd_blk);
+	status = cmd_blk->status;
+	mutex_unlock(&cs->dcmd_mutex);
+	if (status != DAC960_V2_NormalCompletion) {
+		shost_printk(KERN_INFO, shost,
+			     "Discovery Not Initiated, status %02X\n",
+			     status);
+		return -EINVAL;
+	}
+	shost_printk(KERN_INFO, shost, "Discovery Initiated\n");
+	cs->next_evseq = 0;
+	cs->needs_update = true;
+	queue_delayed_work(cs->work_q, &cs->monitor_work, 1);
+	flush_delayed_work(&cs->monitor_work);
+	shost_printk(KERN_INFO, shost, "Discovery Completed\n");
+
+	return count;
+}
+static DEVICE_ATTR(discovery, S_IWUSR, NULL, myrs_store_discovery_command);
+
+static ssize_t myrs_store_flush_cache(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+	unsigned char status;
+
+	status = myrs_dev_op(cs, DAC960_V2_FlushDeviceData,
+			     DAC960_V2_RAID_Controller);
+	if (status == DAC960_V2_NormalCompletion) {
+		shost_printk(KERN_INFO, shost, "Cache Flush Completed\n");
+		return count;
+	}
+	shost_printk(KERN_INFO, shost,
+		     "Cache Flush failed, status 0x%02x\n", status);
+	return -EIO;
+}
+static DEVICE_ATTR(flush_cache, S_IWUSR, NULL, myrs_store_flush_cache);
+
+static ssize_t myrs_show_suppress_enclosure_messages(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	return snprintf(buf, 3, "%d\n", cs->disable_enc_msg);
+}
+
+static ssize_t myrs_store_suppress_enclosure_messages(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	char tmpbuf[8];
+	ssize_t len;
+	int value;
+
+	len = count > sizeof(tmpbuf) - 1 ? sizeof(tmpbuf) - 1 : count;
+	strncpy(tmpbuf, buf, len);
+	tmpbuf[len] = '\0';
+	if (sscanf(tmpbuf, "%d", &value) != 1 || value > 2)
+		return -EINVAL;
+
+	cs->disable_enc_msg = value;
+	return count;
+}
+static DEVICE_ATTR(disable_enclosure_messages, S_IRUGO | S_IWUSR,
+		   myrs_show_suppress_enclosure_messages,
+		   myrs_store_suppress_enclosure_messages);
+
+static struct device_attribute *myrs_shost_attrs[] = {
+	&dev_attr_serial,
+	&dev_attr_ctlr_num,
+	&dev_attr_processor,
+	&dev_attr_model,
+	&dev_attr_ctlr_type,
+	&dev_attr_cache_size,
+	&dev_attr_firmware,
+	&dev_attr_discovery,
+	&dev_attr_flush_cache,
+	&dev_attr_disable_enclosure_messages,
+	NULL,
+};
+
+/*
+ * SCSI midlayer interface
+ */
+int myrs_host_reset(struct scsi_cmnd *scmd)
+{
+	struct Scsi_Host *shost = scmd->device->host;
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+
+	cs->reset(cs->io_base);
+	return SUCCESS;
+}
+
+static void
+myrs_mode_sense(struct myrs_hba *cs, struct scsi_cmnd *scmd,
+		struct myrs_ldev_info *ldev_info)
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
+	modes[2] = 0x10; /* Enable FUA */
+	if (ldev_info->ldev_control.wce == DAC960_V2_LogicalDeviceReadOnly)
+		modes[2] |= 0x80;
+	if (!dbd) {
+		unsigned char *block_desc = &modes[4];
+		modes[3] = 8;
+		put_unaligned_be32(ldev_info->cfg_devsize, &block_desc[0]);
+		put_unaligned_be32(ldev_info->devsize_bytes, &block_desc[5]);
+	}
+	mode_pg[0] = 0x08;
+	mode_pg[1] = 0x12;
+	if (ldev_info->ldev_control.rce == DAC960_V2_ReadCacheDisabled)
+		mode_pg[2] |= 0x01;
+	if (ldev_info->ldev_control.wce == DAC960_V2_WriteCacheEnabled ||
+	    ldev_info->ldev_control.wce ==
+	    DAC960_V2_IntelligentWriteCacheEnabled)
+		mode_pg[2] |= 0x04;
+	if (ldev_info->cacheline_size) {
+		mode_pg[2] |= 0x08;
+		put_unaligned_be16(1 << ldev_info->cacheline_size,
+				   &mode_pg[14]);
+	}
+
+	scsi_sg_copy_from_buffer(scmd, modes, mode_len);
+}
+
+static int myrs_queuecommand(struct Scsi_Host *shost,
+			     struct scsi_cmnd *scmd)
+{
+	struct myrs_hba *cs = (struct myrs_hba *)shost->hostdata;
+	struct myrs_cmdblk *cmd_blk = scsi_cmd_priv(scmd);
+	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
+	struct scsi_device *sdev = scmd->device;
+	union myrs_sgl *hw_sge;
+	dma_addr_t sense_addr;
+	struct scatterlist *sgl;
+	unsigned long flags, timeout;
+	int nsge;
+
+	if (!scmd->device->hostdata) {
+		scmd->result = (DID_NO_CONNECT << 16);
+		scmd->scsi_done(scmd);
+		return 0;
+	}
+
+	switch (scmd->cmnd[0]) {
+	case REPORT_LUNS:
+		scsi_build_sense_buffer(0, scmd->sense_buffer, ILLEGAL_REQUEST,
+					0x20, 0x0);
+		scmd->result = (DRIVER_SENSE << 24) | SAM_STAT_CHECK_CONDITION;
+		scmd->scsi_done(scmd);
+		return 0;
+	case MODE_SENSE:
+		if (scmd->device->channel >= cs->ctlr_info->physchan_present) {
+			struct myrs_ldev_info *ldev_info = sdev->hostdata;
+			if ((scmd->cmnd[2] & 0x3F) != 0x3F &&
+			    (scmd->cmnd[2] & 0x3F) != 0x08) {
+				/* Illegal request, invalid field in CDB */
+				scsi_build_sense_buffer(0, scmd->sense_buffer,
+							ILLEGAL_REQUEST, 0x24, 0);
+				scmd->result = (DRIVER_SENSE << 24) |
+					SAM_STAT_CHECK_CONDITION;
+			} else {
+				myrs_mode_sense(cs, scmd, ldev_info);
+				scmd->result = (DID_OK << 16);
+			}
+			scmd->scsi_done(scmd);
+			return 0;
+		}
+		break;
+	}
+
+	myrs_reset_cmd(cmd_blk);
+	cmd_blk->sense = dma_pool_alloc(cs->sense_pool, GFP_ATOMIC,
+					&sense_addr);
+	if (!cmd_blk->sense)
+		return SCSI_MLQUEUE_HOST_BUSY;
+	cmd_blk->sense_addr = sense_addr;
+
+	timeout = scmd->request->timeout;
+	if (scmd->cmd_len <= 10) {
+		if (scmd->device->channel >= cs->ctlr_info->physchan_present) {
+			struct myrs_ldev_info *ldev_info = sdev->hostdata;
+
+			mbox->SCSI_10.opcode = DAC960_V2_SCSI_10;
+			mbox->SCSI_10.pdev.lun = ldev_info->lun;
+			mbox->SCSI_10.pdev.target = ldev_info->target;
+			mbox->SCSI_10.pdev.channel = ldev_info->channel;
+			mbox->SCSI_10.pdev.ctlr = 0;
+		} else {
+			mbox->SCSI_10.opcode = DAC960_V2_SCSI_10_Passthru;
+			mbox->SCSI_10.pdev.lun = sdev->lun;
+			mbox->SCSI_10.pdev.target = sdev->id;
+			mbox->SCSI_10.pdev.channel = sdev->channel;
+		}
+		mbox->SCSI_10.id = scmd->request->tag + 3;
+		mbox->SCSI_10.control.dma_ctrl_to_host =
+			(scmd->sc_data_direction == DMA_FROM_DEVICE);
+		if (scmd->request->cmd_flags & REQ_FUA)
+			mbox->SCSI_10.control.fua = true;
+		mbox->SCSI_10.dma_size = scsi_bufflen(scmd);
+		mbox->SCSI_10.sense_addr = cmd_blk->sense_addr;
+		mbox->SCSI_10.sense_len = MYRS_SENSE_SIZE;
+		mbox->SCSI_10.cdb_len = scmd->cmd_len;
+		if (timeout > 60) {
+			mbox->SCSI_10.tmo.tmo_scale =
+				DAC960_V2_TimeoutScale_Minutes;
+			mbox->SCSI_10.tmo.tmo_val = timeout / 60;
+		} else {
+			mbox->SCSI_10.tmo.tmo_scale =
+				DAC960_V2_TimeoutScale_Seconds;
+			mbox->SCSI_10.tmo.tmo_val = timeout;
+		}
+		memcpy(&mbox->SCSI_10.cdb, scmd->cmnd, scmd->cmd_len);
+		hw_sge = &mbox->SCSI_10.dma_addr;
+		cmd_blk->DCDB = NULL;
+	} else {
+		dma_addr_t DCDB_dma;
+
+		cmd_blk->DCDB = dma_pool_alloc(cs->dcdb_pool, GFP_ATOMIC,
+					       &DCDB_dma);
+		if (!cmd_blk->DCDB) {
+			dma_pool_free(cs->sense_pool, cmd_blk->sense,
+				      cmd_blk->sense_addr);
+			cmd_blk->sense = NULL;
+			cmd_blk->sense_addr = 0;
+			return SCSI_MLQUEUE_HOST_BUSY;
+		}
+		cmd_blk->DCDB_dma = DCDB_dma;
+		if (scmd->device->channel >= cs->ctlr_info->physchan_present) {
+			struct myrs_ldev_info *ldev_info = sdev->hostdata;
+
+			mbox->SCSI_255.opcode = DAC960_V2_SCSI_256;
+			mbox->SCSI_255.pdev.lun = ldev_info->lun;
+			mbox->SCSI_255.pdev.target = ldev_info->target;
+			mbox->SCSI_255.pdev.channel = ldev_info->channel;
+			mbox->SCSI_255.pdev.ctlr = 0;
+		} else {
+			mbox->SCSI_255.opcode = DAC960_V2_SCSI_255_Passthru;
+			mbox->SCSI_255.pdev.lun = sdev->lun;
+			mbox->SCSI_255.pdev.target = sdev->id;
+			mbox->SCSI_255.pdev.channel = sdev->channel;
+		}
+		mbox->SCSI_255.id = scmd->request->tag + 3;
+		mbox->SCSI_255.control.dma_ctrl_to_host =
+			(scmd->sc_data_direction == DMA_FROM_DEVICE);
+		if (scmd->request->cmd_flags & REQ_FUA)
+			mbox->SCSI_255.control.fua = true;
+		mbox->SCSI_255.dma_size = scsi_bufflen(scmd);
+		mbox->SCSI_255.sense_addr = cmd_blk->sense_addr;
+		mbox->SCSI_255.sense_len = MYRS_SENSE_SIZE;
+		mbox->SCSI_255.cdb_len = scmd->cmd_len;
+		mbox->SCSI_255.cdb_addr = cmd_blk->DCDB_dma;
+		if (timeout > 60) {
+			mbox->SCSI_255.tmo.tmo_scale =
+				DAC960_V2_TimeoutScale_Minutes;
+			mbox->SCSI_255.tmo.tmo_val = timeout / 60;
+		} else {
+			mbox->SCSI_255.tmo.tmo_scale =
+				DAC960_V2_TimeoutScale_Seconds;
+			mbox->SCSI_255.tmo.tmo_val = timeout;
+		}
+		memcpy(cmd_blk->DCDB, scmd->cmnd, scmd->cmd_len);
+		hw_sge = &mbox->SCSI_255.dma_addr;
+	}
+	if (scmd->sc_data_direction == DMA_NONE)
+		goto submit;
+	nsge = scsi_dma_map(scmd);
+	if (nsge == 1) {
+		sgl = scsi_sglist(scmd);
+		hw_sge->sge[0].sge_addr = (u64)sg_dma_address(sgl);
+		hw_sge->sge[0].sge_count = (u64)sg_dma_len(sgl);
+	} else {
+		struct myrs_sge *hw_sgl;
+		dma_addr_t hw_sgl_addr;
+		int i;
+
+		if (nsge > 2) {
+			hw_sgl = dma_pool_alloc(cs->sg_pool, GFP_ATOMIC,
+						&hw_sgl_addr);
+			if (WARN_ON(!hw_sgl)) {
+				if (cmd_blk->DCDB) {
+					dma_pool_free(cs->dcdb_pool,
+						      cmd_blk->DCDB,
+						      cmd_blk->DCDB_dma);
+					cmd_blk->DCDB = NULL;
+					cmd_blk->DCDB_dma = 0;
+				}
+				dma_pool_free(cs->sense_pool,
+					      cmd_blk->sense,
+					      cmd_blk->sense_addr);
+				cmd_blk->sense = NULL;
+				cmd_blk->sense_addr = 0;
+				return SCSI_MLQUEUE_HOST_BUSY;
+			}
+			cmd_blk->sgl = hw_sgl;
+			cmd_blk->sgl_addr = hw_sgl_addr;
+			if (scmd->cmd_len <= 10)
+				mbox->SCSI_10.control.add_sge_mem = true;
+			else
+				mbox->SCSI_255.control.add_sge_mem = true;
+			hw_sge->ext.sge0_len = nsge;
+			hw_sge->ext.sge0_addr = cmd_blk->sgl_addr;
+		} else
+			hw_sgl = hw_sge->sge;
+
+		scsi_for_each_sg(scmd, sgl, nsge, i) {
+			if (WARN_ON(!hw_sgl)) {
+				scsi_dma_unmap(scmd);
+				scmd->result = (DID_ERROR << 16);
+				scmd->scsi_done(scmd);
+				return 0;
+			}
+			hw_sgl->sge_addr = (u64)sg_dma_address(sgl);
+			hw_sgl->sge_count = (u64)sg_dma_len(sgl);
+			hw_sgl++;
+		}
+	}
+submit:
+	spin_lock_irqsave(&cs->queue_lock, flags);
+	myrs_qcmd(cs, cmd_blk);
+	spin_unlock_irqrestore(&cs->queue_lock, flags);
+
+	return 0;
+}
+
+static unsigned short myrs_translate_ldev(struct myrs_hba *cs,
+					  struct scsi_device *sdev)
+{
+	unsigned short ldev_num;
+	unsigned int chan_offset =
+		sdev->channel - cs->ctlr_info->physchan_present;
+
+	ldev_num = sdev->id + chan_offset * sdev->host->max_id;
+
+	return ldev_num;
+}
+
+static int myrs_slave_alloc(struct scsi_device *sdev)
+{
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	unsigned char status;
+
+	if (sdev->channel > sdev->host->max_channel)
+		return 0;
+
+	if (sdev->channel >= cs->ctlr_info->physchan_present) {
+		struct myrs_ldev_info *ldev_info;
+		unsigned short ldev_num;
+
+		if (sdev->lun > 0)
+			return -ENXIO;
+
+		ldev_num = myrs_translate_ldev(cs, sdev);
+
+		ldev_info = kzalloc(sizeof(*ldev_info), GFP_KERNEL|GFP_DMA);
+		if (!ldev_info)
+			return -ENOMEM;
+
+		status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+		if (status != DAC960_V2_NormalCompletion) {
+			sdev->hostdata = NULL;
+			kfree(ldev_info);
+		} else {
+			enum raid_level level;
+
+			dev_dbg(&sdev->sdev_gendev,
+				"Logical device mapping %d:%d:%d -> %d\n",
+				ldev_info->channel, ldev_info->target,
+				ldev_info->lun, ldev_info->ldev_num);
+
+			sdev->hostdata = ldev_info;
+			switch (ldev_info->raid_level) {
+			case DAC960_V2_RAID_Level0:
+				level = RAID_LEVEL_LINEAR;
+				break;
+			case DAC960_V2_RAID_Level1:
+				level = RAID_LEVEL_1;
+				break;
+			case DAC960_V2_RAID_Level3:
+			case DAC960_V2_RAID_Level3F:
+			case DAC960_V2_RAID_Level3L:
+				level = RAID_LEVEL_3;
+				break;
+			case DAC960_V2_RAID_Level5:
+			case DAC960_V2_RAID_Level5L:
+				level = RAID_LEVEL_5;
+				break;
+			case DAC960_V2_RAID_Level6:
+				level = RAID_LEVEL_6;
+				break;
+			case DAC960_V2_RAID_LevelE:
+			case DAC960_V2_RAID_NewSpan:
+			case DAC960_V2_RAID_Span:
+				level = RAID_LEVEL_LINEAR;
+				break;
+			case DAC960_V2_RAID_JBOD:
+				level = RAID_LEVEL_JBOD;
+				break;
+			default:
+				level = RAID_LEVEL_UNKNOWN;
+				break;
+			}
+			raid_set_level(myrs_raid_template,
+				       &sdev->sdev_gendev, level);
+			if (ldev_info->dev_state != DAC960_V2_Device_Online) {
+				const char *name;
+
+				name = myrs_devstate_name(ldev_info->dev_state);
+				sdev_printk(KERN_DEBUG, sdev,
+					    "logical device in state %s\n",
+					    name ? name : "Invalid");
+			}
+		}
+	} else {
+		struct myrs_pdev_info *pdev_info;
+
+		pdev_info = kzalloc(sizeof(*pdev_info), GFP_KERNEL|GFP_DMA);
+		if (!pdev_info)
+			return -ENOMEM;
+
+		status = myrs_get_pdev_info(cs, sdev->channel,
+					    sdev->id, sdev->lun,
+					    pdev_info);
+		if (status != DAC960_V2_NormalCompletion) {
+			sdev->hostdata = NULL;
+			kfree(pdev_info);
+			return -ENXIO;
+		}
+		sdev->hostdata = pdev_info;
+	}
+	return 0;
+}
+
+static int myrs_slave_configure(struct scsi_device *sdev)
+{
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info;
+
+	if (sdev->channel > sdev->host->max_channel)
+		return -ENXIO;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present) {
+		/* Skip HBA device */
+		if (sdev->type == TYPE_RAID)
+			return -ENXIO;
+		sdev->no_uld_attach = 1;
+		return 0;
+	}
+	if (sdev->lun != 0)
+		return -ENXIO;
+
+	ldev_info = sdev->hostdata;
+	if (!ldev_info)
+		return -ENXIO;
+	if (ldev_info->ldev_control.wce == DAC960_V2_WriteCacheEnabled ||
+	    ldev_info->ldev_control.wce ==
+	    DAC960_V2_IntelligentWriteCacheEnabled)
+		sdev->wce_default_on = 1;
+	sdev->tagged_supported = 1;
+	return 0;
+}
+
+static void myrs_slave_destroy(struct scsi_device *sdev)
+{
+	void *hostdata = sdev->hostdata;
+
+	if (hostdata) {
+		kfree(hostdata);
+		sdev->hostdata = NULL;
+	}
+}
+
+struct scsi_host_template myrs_template = {
+	.module = THIS_MODULE,
+	.name = "DAC960",
+	.proc_name = "myrs",
+	.queuecommand = myrs_queuecommand,
+	.eh_host_reset_handler = myrs_host_reset,
+	.slave_alloc = myrs_slave_alloc,
+	.slave_configure = myrs_slave_configure,
+	.slave_destroy = myrs_slave_destroy,
+	.cmd_size = sizeof(struct myrs_cmdblk),
+	.shost_attrs = myrs_shost_attrs,
+	.sdev_attrs = myrs_sdev_attrs,
+	.this_id = -1,
+};
+
+static struct myrs_hba *myrs_alloc_host(struct pci_dev *pdev,
+					const struct pci_device_id *entry)
+{
+	struct Scsi_Host *shost;
+	struct myrs_hba *cs;
+
+	shost = scsi_host_alloc(&myrs_template, sizeof(struct myrs_hba));
+	if (!shost)
+		return NULL;
+
+	shost->max_cmd_len = 16;
+	shost->max_lun = 256;
+	cs = (struct myrs_hba *)shost->hostdata;
+	mutex_init(&cs->dcmd_mutex);
+	mutex_init(&cs->cinfo_mutex);
+	cs->host = shost;
+
+	return cs;
+}
+
+/*
+ * RAID template functions
+ */
+
+/**
+ * myrs_is_raid - return boolean indicating device is raid volume
+ * @dev the device struct object
+ */
+static int
+myrs_is_raid(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+
+	return (sdev->channel >= cs->ctlr_info->physchan_present) ? 1 : 0;
+}
+
+/**
+ * myrs_get_resync - get raid volume resync percent complete
+ * @dev the device struct object
+ */
+static void
+myrs_get_resync(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info = sdev->hostdata;
+	u8 percent_complete = 0, status;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present || !ldev_info)
+		return;
+	if (ldev_info->rbld_active) {
+		unsigned short ldev_num = ldev_info->ldev_num;
+
+		status = myrs_get_ldev_info(cs, ldev_num, ldev_info);
+		percent_complete = ldev_info->rbld_lba * 100 /
+			ldev_info->cfg_devsize;
+	}
+	raid_set_resync(myrs_raid_template, dev, percent_complete);
+}
+
+/**
+ * myrs_get_state - get raid volume status
+ * @dev the device struct object
+ */
+static void
+myrs_get_state(struct device *dev)
+{
+	struct scsi_device *sdev = to_scsi_device(dev);
+	struct myrs_hba *cs = (struct myrs_hba *)sdev->host->hostdata;
+	struct myrs_ldev_info *ldev_info = sdev->hostdata;
+	enum raid_state state = RAID_STATE_UNKNOWN;
+
+	if (sdev->channel < cs->ctlr_info->physchan_present || !ldev_info)
+		state = RAID_STATE_UNKNOWN;
+	else {
+		switch (ldev_info->dev_state) {
+		case DAC960_V2_Device_Online:
+			state = RAID_STATE_ACTIVE;
+			break;
+		case DAC960_V2_Device_SuspectedCritical:
+		case DAC960_V2_Device_Critical:
+			state = RAID_STATE_DEGRADED;
+			break;
+		case DAC960_V2_Device_Rebuild:
+			state = RAID_STATE_RESYNCING;
+			break;
+		case DAC960_V2_Device_Unconfigured:
+		case DAC960_V2_Device_InvalidState:
+			state = RAID_STATE_UNKNOWN;
+			break;
+		default:
+			state = RAID_STATE_OFFLINE;
+		}
+	}
+	raid_set_state(myrs_raid_template, dev, state);
+}
+
+struct raid_function_template myrs_raid_functions = {
+	.cookie		= &myrs_template,
+	.is_raid	= myrs_is_raid,
+	.get_resync	= myrs_get_resync,
+	.get_state	= myrs_get_state,
+};
+
+/*
+ * PCI interface functions
+ */
+void myrs_flush_cache(struct myrs_hba *cs)
+{
+	myrs_dev_op(cs, DAC960_V2_FlushDeviceData, DAC960_V2_RAID_Controller);
+}
+
+static void myrs_handle_scsi(struct myrs_hba *cs, struct myrs_cmdblk *cmd_blk,
+			     struct scsi_cmnd *scmd)
+{
+	unsigned char status;
+
+	if (!cmd_blk)
+		return;
+
+	BUG_ON(!scmd);
+	scsi_dma_unmap(scmd);
+	status = cmd_blk->status;
+	if (cmd_blk->sense) {
+		if (status == DAC960_V2_AbnormalCompletion &&
+		    cmd_blk->sense_len) {
+			unsigned int sense_len = SCSI_SENSE_BUFFERSIZE;
+
+			if (sense_len > cmd_blk->sense_len)
+				sense_len = cmd_blk->sense_len;
+			memcpy(scmd->sense_buffer, cmd_blk->sense, sense_len);
+		}
+		dma_pool_free(cs->sense_pool, cmd_blk->sense,
+			      cmd_blk->sense_addr);
+		cmd_blk->sense = NULL;
+		cmd_blk->sense_addr = 0;
+	}
+	if (cmd_blk->DCDB) {
+		dma_pool_free(cs->dcdb_pool, cmd_blk->DCDB,
+			      cmd_blk->DCDB_dma);
+		cmd_blk->DCDB = NULL;
+		cmd_blk->DCDB_dma = 0;
+	}
+	if (cmd_blk->sgl) {
+		dma_pool_free(cs->sg_pool, cmd_blk->sgl,
+			      cmd_blk->sgl_addr);
+		cmd_blk->sgl = NULL;
+		cmd_blk->sgl_addr = 0;
+	}
+	if (cmd_blk->residual)
+		scsi_set_resid(scmd, cmd_blk->residual);
+	if (status == DAC960_V2_DeviceNonresponsive ||
+	    status == DAC960_V2_DeviceNonresponsive2)
+		scmd->result = (DID_BAD_TARGET << 16);
+	else
+		scmd->result = (DID_OK << 16) || status;
+	scmd->scsi_done(scmd);
+}
+
+static void myrs_handle_cmdblk(struct myrs_hba *cs, struct myrs_cmdblk *cmd_blk)
+{
+	if (!cmd_blk)
+		return;
+
+	if (cmd_blk->complete) {
+		complete(cmd_blk->complete);
+		cmd_blk->complete = NULL;
+	}
+}
+
+static void myrs_monitor(struct work_struct *work)
+{
+	struct myrs_hba *cs = container_of(work, struct myrs_hba,
+					   monitor_work.work);
+	struct Scsi_Host *shost = cs->host;
+	struct myrs_ctlr_info *info = cs->ctlr_info;
+	unsigned int epoch = cs->fwstat_buf->epoch;
+	unsigned long interval = MYRS_PRIMARY_MONITOR_INTERVAL;
+	unsigned char status;
+
+	dev_dbg(&shost->shost_gendev, "monitor tick\n");
+
+	status = myrs_get_fwstatus(cs);
+
+	if (cs->needs_update) {
+		cs->needs_update = false;
+		mutex_lock(&cs->cinfo_mutex);
+		status = myrs_get_ctlr_info(cs);
+		mutex_unlock(&cs->cinfo_mutex);
+	}
+	if (cs->fwstat_buf->next_evseq - cs->next_evseq > 0) {
+		status = myrs_get_event(cs, cs->next_evseq,
+					cs->event_buf);
+		if (status == DAC960_V2_NormalCompletion) {
+			myrs_log_event(cs, cs->event_buf);
+			cs->next_evseq++;
+			interval = 1;
+		}
+	}
+
+	if (time_after(jiffies, cs->secondary_monitor_time
+		       + MYRS_SECONDARY_MONITOR_INTERVAL))
+		cs->secondary_monitor_time = jiffies;
+
+	if (info->bg_init_active +
+	    info->ldev_init_active +
+	    info->pdev_init_active +
+	    info->cc_active +
+	    info->rbld_active +
+	    info->exp_active != 0) {
+		struct scsi_device *sdev;
+		shost_for_each_device(sdev, shost) {
+			struct myrs_ldev_info *ldev_info;
+			int ldev_num;
+
+			if (sdev->channel < info->physchan_present)
+				continue;
+			ldev_info = sdev->hostdata;
+			if (!ldev_info)
+				continue;
+			ldev_num = ldev_info->ldev_num;
+			myrs_get_ldev_info(cs, ldev_num, ldev_info);
+		}
+		cs->needs_update = true;
+	}
+	if (epoch == cs->epoch &&
+	    cs->fwstat_buf->next_evseq == cs->next_evseq &&
+	    (cs->needs_update == false ||
+	     time_before(jiffies, cs->primary_monitor_time
+			 + MYRS_PRIMARY_MONITOR_INTERVAL))) {
+		interval = MYRS_SECONDARY_MONITOR_INTERVAL;
+	}
+
+	if (interval > 1)
+		cs->primary_monitor_time = jiffies;
+	queue_delayed_work(cs->work_q, &cs->monitor_work, interval);
+}
+
+static bool myrs_create_mempools(struct pci_dev *pdev, struct myrs_hba *cs)
+{
+	struct Scsi_Host *shost = cs->host;
+	size_t elem_size, elem_align;
+
+	elem_align = sizeof(struct myrs_sge);
+	elem_size = shost->sg_tablesize * elem_align;
+	cs->sg_pool = dma_pool_create("myrs_sg", &pdev->dev,
+				      elem_size, elem_align, 0);
+	if (cs->sg_pool == NULL) {
+		shost_printk(KERN_ERR, shost,
+			     "Failed to allocate SG pool\n");
+		return false;
+	}
+
+	cs->sense_pool = dma_pool_create("myrs_sense", &pdev->dev,
+					 MYRS_SENSE_SIZE, sizeof(int), 0);
+	if (cs->sense_pool == NULL) {
+		dma_pool_destroy(cs->sg_pool);
+		cs->sg_pool = NULL;
+		shost_printk(KERN_ERR, shost,
+			     "Failed to allocate sense data pool\n");
+		return false;
+	}
+
+	cs->dcdb_pool = dma_pool_create("myrs_dcdb", &pdev->dev,
+					MYRS_DCDB_SIZE,
+					sizeof(unsigned char), 0);
+	if (!cs->dcdb_pool) {
+		dma_pool_destroy(cs->sg_pool);
+		cs->sg_pool = NULL;
+		dma_pool_destroy(cs->sense_pool);
+		cs->sense_pool = NULL;
+		shost_printk(KERN_ERR, shost,
+			     "Failed to allocate DCDB pool\n");
+		return false;
+	}
+
+	snprintf(cs->work_q_name, sizeof(cs->work_q_name),
+		 "myrs_wq_%d", shost->host_no);
+	cs->work_q = create_singlethread_workqueue(cs->work_q_name);
+	if (!cs->work_q) {
+		dma_pool_destroy(cs->dcdb_pool);
+		cs->dcdb_pool = NULL;
+		dma_pool_destroy(cs->sg_pool);
+		cs->sg_pool = NULL;
+		dma_pool_destroy(cs->sense_pool);
+		cs->sense_pool = NULL;
+		shost_printk(KERN_ERR, shost,
+			     "Failed to create workqueue\n");
+		return false;
+	}
+
+	/* Initialize the Monitoring Timer. */
+	INIT_DELAYED_WORK(&cs->monitor_work, myrs_monitor);
+	queue_delayed_work(cs->work_q, &cs->monitor_work, 1);
+
+	return true;
+}
+
+static void myrs_destroy_mempools(struct myrs_hba *cs)
+{
+	cancel_delayed_work_sync(&cs->monitor_work);
+	destroy_workqueue(cs->work_q);
+
+	if (cs->sg_pool) {
+		dma_pool_destroy(cs->sg_pool);
+		cs->sg_pool = NULL;
+	}
+
+	if (cs->dcdb_pool) {
+		dma_pool_destroy(cs->dcdb_pool);
+		cs->dcdb_pool = NULL;
+	}
+	if (cs->sense_pool) {
+		dma_pool_destroy(cs->sense_pool);
+		cs->sense_pool = NULL;
+	}
+}
+
+static void myrs_unmap(struct myrs_hba *cs)
+{
+	if (cs->event_buf) {
+		kfree(cs->event_buf);
+		cs->event_buf = NULL;
+	}
+	if (cs->ctlr_info) {
+		kfree(cs->ctlr_info);
+		cs->ctlr_info = NULL;
+	}
+	if (cs->fwstat_buf) {
+		dma_free_coherent(&cs->pdev->dev, sizeof(struct myrs_fwstat),
+				  cs->fwstat_buf, cs->fwstat_addr);
+		cs->fwstat_buf = NULL;
+	}
+	if (cs->first_stat_mbox) {
+		dma_free_coherent(&cs->pdev->dev, cs->stat_mbox_size,
+				  cs->first_stat_mbox, cs->stat_mbox_addr);
+		cs->first_stat_mbox = NULL;
+	}
+	if (cs->first_cmd_mbox) {
+		dma_free_coherent(&cs->pdev->dev, cs->cmd_mbox_size,
+				  cs->first_cmd_mbox, cs->cmd_mbox_addr);
+		cs->first_cmd_mbox = NULL;
+	}
+}
+
+static void myrs_cleanup(struct myrs_hba *cs)
+{
+	struct pci_dev *pdev = cs->pdev;
+
+	/* Free the memory mailbox, status, and related structures */
+	myrs_unmap(cs);
+
+	if (cs->mmio_base) {
+		cs->disable_intr(cs);
+		iounmap(cs->mmio_base);
+	}
+	if (cs->irq)
+		free_irq(cs->irq, cs);
+	if (cs->io_addr)
+		release_region(cs->io_addr, 0x80);
+	iounmap(cs->mmio_base);
+	pci_set_drvdata(pdev, NULL);
+	pci_disable_device(pdev);
+	scsi_host_put(cs->host);
+}
+
+static struct myrs_hba *myrs_detect(struct pci_dev *pdev,
+				    const struct pci_device_id *entry)
+{
+	struct myrs_privdata *privdata =
+		(struct myrs_privdata *)entry->driver_data;
+	irq_handler_t irq_handler = privdata->irq_handler;
+	unsigned int mmio_size = privdata->io_mem_size;
+	struct myrs_hba *cs = NULL;
+
+	cs = myrs_alloc_host(pdev, entry);
+	if (!cs) {
+		dev_err(&pdev->dev, "Unable to allocate Controller\n");
+		return NULL;
+	}
+	cs->pdev = pdev;
+
+	if (pci_enable_device(pdev))
+		goto Failure;
+
+	cs->pci_addr = pci_resource_start(pdev, 0);
+
+	pci_set_drvdata(pdev, cs);
+	spin_lock_init(&cs->queue_lock);
+	/* Map the Controller Register Window. */
+	if (mmio_size < PAGE_SIZE)
+		mmio_size = PAGE_SIZE;
+	cs->mmio_base = ioremap_nocache(cs->pci_addr & PAGE_MASK, mmio_size);
+	if (cs->mmio_base == NULL) {
+		dev_err(&pdev->dev,
+			"Unable to map Controller Register Window\n");
+		goto Failure;
+	}
+
+	cs->io_base = cs->mmio_base + (cs->pci_addr & ~PAGE_MASK);
+	if (privdata->hw_init(pdev, cs, cs->io_base))
+		goto Failure;
+
+	/* Acquire shared access to the IRQ Channel. */
+	if (request_irq(pdev->irq, irq_handler, IRQF_SHARED, "myrs", cs) < 0) {
+		dev_err(&pdev->dev,
+			"Unable to acquire IRQ Channel %d\n", pdev->irq);
+		goto Failure;
+	}
+	cs->irq = pdev->irq;
+	return cs;
+
+Failure:
+	dev_err(&pdev->dev,
+		"Failed to initialize Controller\n");
+	myrs_cleanup(cs);
+	return NULL;
+}
+
+/**
+ * myrs_err_status reports Controller BIOS Messages passed through
+  the Error Status Register when the driver performs the BIOS handshaking.
+  It returns true for fatal errors and false otherwise.
+*/
+
+static bool myrs_err_status(struct myrs_hba *cs, unsigned char status,
+			    unsigned char parm0, unsigned char parm1)
+{
+	struct pci_dev *pdev = cs->pdev;
+
+	switch (status) {
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
+			status);
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
+ * DAC960 GEM Series Controllers.
+ */
+
+static inline
+void DAC960_GEM_HardwareMailboxNewCommand(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_NEW_CMD << 24);
+	writel(val, base + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+void DAC960_GEM_AcknowledgeHardwareMailboxStatus(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_ACK_STS << 24);
+	writel(val, base + DAC960_GEM_InboundDoorBellRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_GenerateInterrupt(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_IDB_GEN_IRQ << 24);
+	writel(val, base + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+void DAC960_GEM_ControllerReset(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_IDB_CTRL_RESET << 24);
+	writel(val, base + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+void DAC960_GEM_MemoryMailboxNewCommand(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_IDB_HWMBOX_NEW_CMD << 24);
+	writel(val, base + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+}
+
+static inline
+bool DAC960_GEM_HardwareMailboxFullP(void __iomem *base)
+{
+	__le32 val;
+
+        val = readl(base + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_HWMBOX_FULL;
+}
+
+static inline
+bool DAC960_GEM_InitializationInProgressP(void __iomem *base)
+{
+	__le32 val;
+
+	val = readl(base + DAC960_GEM_InboundDoorBellRegisterReadSetOffset);
+	return (le32_to_cpu(val) >> 24) & DAC960_GEM_IDB_INIT_IN_PROGRESS;
+}
+
+static inline
+void DAC960_GEM_AcknowledgeHardwareMailboxInterrupt(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_ODB_HWMBOX_ACK_IRQ << 24);
+	writel(val, base + DAC960_GEM_OutboundDoorBellRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_AcknowledgeMemoryMailboxInterrupt(void __iomem *base)
+{
+	__le32 val = cpu_to_le32(DAC960_GEM_ODB_MMBOX_ACK_IRQ << 24);
+	writel(val, base + DAC960_GEM_OutboundDoorBellRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_AcknowledgeInterrupt(void __iomem *base)
+{
+	__le32 val = cpu_to_le32((DAC960_GEM_ODB_HWMBOX_ACK_IRQ |
+				  DAC960_GEM_ODB_MMBOX_ACK_IRQ) << 24);
+	writel(val, base + DAC960_GEM_OutboundDoorBellRegisterClearOffset);
+}
+
+static inline
+bool DAC960_GEM_HardwareMailboxStatusAvailableP(void __iomem *base)
+{
+	__le32 val;
+
+	val = readl(base + DAC960_GEM_OutboundDoorBellRegisterReadSetOffset);
+	return (le32_to_cpu(val) >> 24) & DAC960_GEM_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline
+bool DAC960_GEM_MemoryMailboxStatusAvailableP(void __iomem *base)
+{
+	__le32 val;
+
+	val = readl(base + DAC960_GEM_OutboundDoorBellRegisterReadSetOffset);
+	return (le32_to_cpu(val) >> 24) & DAC960_GEM_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline
+void DAC960_GEM_EnableInterrupts(void __iomem *base)
+{
+	__le32 val = cpu_to_le32((DAC960_GEM_IRQMASK_HWMBOX_IRQ |
+				  DAC960_GEM_IRQMASK_MMBOX_IRQ) << 24);
+	writel(val, base + DAC960_GEM_InterruptMaskRegisterClearOffset);
+}
+
+static inline
+void DAC960_GEM_DisableInterrupts(void __iomem *base)
+{
+	__le32 val = 0;
+	writel(val, base + DAC960_GEM_InterruptMaskRegisterReadSetOffset);
+}
+
+static inline
+bool DAC960_GEM_InterruptsEnabledP(void __iomem *base)
+{
+	__le32 val;
+
+	val = readl(base + DAC960_GEM_InterruptMaskRegisterReadSetOffset);
+	return !((le32_to_cpu(val) >> 24) &
+		 (DAC960_GEM_IRQMASK_HWMBOX_IRQ |
+		  DAC960_GEM_IRQMASK_MMBOX_IRQ));
+}
+
+static inline
+void DAC960_GEM_WriteCommandMailbox(union myrs_cmd_mbox *mem_mbox,
+				    union myrs_cmd_mbox *mbox)
+{
+	memcpy(&mem_mbox->Words[1], &mbox->Words[1],
+	       sizeof(union myrs_cmd_mbox) - sizeof(unsigned int));
+	wmb();
+	mem_mbox->Words[0] = mbox->Words[0];
+	mb();
+}
+
+static inline
+void DAC960_GEM_WriteHardwareMailbox(void __iomem *base,
+				     dma_addr_t CommandMailboxDMA)
+{
+	dma_addr_writeql(CommandMailboxDMA,
+			 base + DAC960_GEM_CommandMailboxBusAddressOffset);
+}
+
+static inline unsigned short
+DAC960_GEM_ReadCommandIdentifier(void __iomem *base)
+{
+	return readw(base + DAC960_GEM_CommandStatusOffset);
+}
+
+static inline unsigned char
+DAC960_GEM_ReadCommandStatus(void __iomem *base)
+{
+	return readw(base + DAC960_GEM_CommandStatusOffset + 2);
+}
+
+static inline bool
+DAC960_GEM_ReadErrorStatus(void __iomem *base,
+			   unsigned char *ErrorStatus,
+			   unsigned char *Parameter0,
+			   unsigned char *Parameter1)
+{
+	__le32 val;
+
+	val = readl(base + DAC960_GEM_ErrorStatusRegisterReadSetOffset);
+	if (!((le32_to_cpu(val) >> 24) & DAC960_GEM_ERRSTS_PENDING))
+		return false;
+	*ErrorStatus = val & ~(DAC960_GEM_ERRSTS_PENDING << 24);
+	*Parameter0 =
+		readb(base + DAC960_GEM_CommandMailboxBusAddressOffset + 0);
+	*Parameter1 =
+		readb(base + DAC960_GEM_CommandMailboxBusAddressOffset + 1);
+	writel(0x03000000, base +
+	       DAC960_GEM_ErrorStatusRegisterClearOffset);
+	return true;
+}
+
+static inline unsigned char
+DAC960_GEM_MailboxInit(void __iomem *base, dma_addr_t mbox_addr)
+{
+	unsigned char status;
+
+	while (DAC960_GEM_HardwareMailboxFullP(base))
+		udelay(1);
+	DAC960_GEM_WriteHardwareMailbox(base, mbox_addr);
+	DAC960_GEM_HardwareMailboxNewCommand(base);
+	while (!DAC960_GEM_HardwareMailboxStatusAvailableP(base))
+		udelay(1);
+	status = DAC960_GEM_ReadCommandStatus(base);
+	DAC960_GEM_AcknowledgeHardwareMailboxInterrupt(base);
+	DAC960_GEM_AcknowledgeHardwareMailboxStatus(base);
+
+	return status;
+}
+
+static int DAC960_GEM_HardwareInit(struct pci_dev *pdev,
+				   struct myrs_hba *cs, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char status, parm0, parm1;
+
+	DAC960_GEM_DisableInterrupts(base);
+	DAC960_GEM_AcknowledgeHardwareMailboxStatus(base);
+	udelay(1000);
+	while (DAC960_GEM_InitializationInProgressP(base) &&
+	       timeout < MYRS_MAILBOX_TIMEOUT) {
+		if (DAC960_GEM_ReadErrorStatus(base, &status,
+					       &parm0, &parm1) &&
+		    myrs_err_status(cs, status, parm0, parm1))
+			return -EIO;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRS_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrs_enable_mmio_mbox(cs, DAC960_GEM_MailboxInit)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_GEM_ControllerReset(base);
+		return -EAGAIN;
+	}
+	DAC960_GEM_EnableInterrupts(base);
+	cs->write_cmd_mbox = DAC960_GEM_WriteCommandMailbox;
+	cs->get_cmd_mbox = DAC960_GEM_MemoryMailboxNewCommand;
+	cs->disable_intr = DAC960_GEM_DisableInterrupts;
+	cs->reset = DAC960_GEM_ControllerReset;
+	return 0;
+}
+
+static irqreturn_t DAC960_GEM_InterruptHandler(int irq,
+					       void *DeviceIdentifier)
+{
+	struct myrs_hba *cs = DeviceIdentifier;
+	void __iomem *base = cs->io_base;
+	struct myrs_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cs->queue_lock, flags);
+	DAC960_GEM_AcknowledgeInterrupt(base);
+	next_stat_mbox = cs->next_stat_mbox;
+	while (next_stat_mbox->id > 0) {
+		unsigned short id = next_stat_mbox->id;
+		struct scsi_cmnd *scmd = NULL;
+		struct myrs_cmdblk *cmd_blk = NULL;
+
+		if (id == MYRS_DCMD_TAG)
+			cmd_blk = &cs->dcmd_blk;
+		else if (id == MYRS_MCMD_TAG)
+			cmd_blk = &cs->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cs->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk) {
+			cmd_blk->status = next_stat_mbox->status;
+			cmd_blk->sense_len = next_stat_mbox->sense_len;
+			cmd_blk->residual = next_stat_mbox->residual;
+		} else
+			dev_err(&cs->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		memset(next_stat_mbox, 0, sizeof(struct myrs_stat_mbox));
+		if (++next_stat_mbox > cs->last_stat_mbox)
+			next_stat_mbox = cs->first_stat_mbox;
+
+		if (id < 3)
+			myrs_handle_cmdblk(cs, cmd_blk);
+		else
+			myrs_handle_scsi(cs, cmd_blk, scmd);
+	}
+	cs->next_stat_mbox = next_stat_mbox;
+	spin_unlock_irqrestore(&cs->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrs_privdata DAC960_GEM_privdata = {
+	.hw_init =		DAC960_GEM_HardwareInit,
+	.irq_handler =		DAC960_GEM_InterruptHandler,
+	.io_mem_size =		DAC960_GEM_RegisterWindowSize,
+};
+
+/*
+ * DAC960 BA Series Controllers.
+ */
+
+static inline
+void DAC960_BA_HardwareMailboxNewCommand(void __iomem *base)
+{
+	writeb(DAC960_BA_IDB_HWMBOX_NEW_CMD,
+	       base + DAC960_BA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_BA_AcknowledgeHardwareMailboxStatus(void __iomem *base)
+{
+	writeb(DAC960_BA_IDB_HWMBOX_ACK_STS,
+	       base + DAC960_BA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_BA_GenerateInterrupt(void __iomem *base)
+{
+	writeb(DAC960_BA_IDB_GEN_IRQ,
+	       base + DAC960_BA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_BA_ControllerReset(void __iomem *base)
+{
+	writeb(DAC960_BA_IDB_CTRL_RESET,
+	       base + DAC960_BA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_BA_MemoryMailboxNewCommand(void __iomem *base)
+{
+	writeb(DAC960_BA_IDB_MMBOX_NEW_CMD,
+	       base + DAC960_BA_InboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_BA_HardwareMailboxFullP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_BA_InboundDoorBellRegisterOffset);
+	return !(val & DAC960_BA_IDB_HWMBOX_EMPTY);
+}
+
+static inline
+bool DAC960_BA_InitializationInProgressP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_BA_InboundDoorBellRegisterOffset);
+	return !(val & DAC960_BA_IDB_INIT_DONE);
+}
+
+static inline
+void DAC960_BA_AcknowledgeHardwareMailboxInterrupt(void __iomem *base)
+{
+	writeb(DAC960_BA_ODB_HWMBOX_ACK_IRQ,
+	       base + DAC960_BA_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_BA_AcknowledgeMemoryMailboxInterrupt(void __iomem *base)
+{
+	writeb(DAC960_BA_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_BA_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_BA_AcknowledgeInterrupt(void __iomem *base)
+{
+	writeb(DAC960_BA_ODB_HWMBOX_ACK_IRQ | DAC960_BA_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_BA_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_BA_HardwareMailboxStatusAvailableP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_BA_OutboundDoorBellRegisterOffset);
+	return val & DAC960_BA_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline
+bool DAC960_BA_MemoryMailboxStatusAvailableP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_BA_OutboundDoorBellRegisterOffset);
+	return val & DAC960_BA_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline
+void DAC960_BA_EnableInterrupts(void __iomem *base)
+{
+	writeb(~DAC960_BA_IRQMASK_DISABLE_IRQ,
+	       base + DAC960_BA_InterruptMaskRegisterOffset);
+}
+
+static inline
+void DAC960_BA_DisableInterrupts(void __iomem *base)
+{
+	writeb(0xFF, base + DAC960_BA_InterruptMaskRegisterOffset);
+}
+
+static inline
+bool DAC960_BA_InterruptsEnabledP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_BA_InterruptMaskRegisterOffset);
+	return !(val & DAC960_BA_IRQMASK_DISABLE_IRQ);
+}
+
+static inline
+void DAC960_BA_WriteCommandMailbox(union myrs_cmd_mbox *mem_mbox,
+				   union myrs_cmd_mbox *mbox)
+{
+	memcpy(&mem_mbox->Words[1], &mbox->Words[1],
+	       sizeof(union myrs_cmd_mbox) - sizeof(unsigned int));
+	wmb();
+	mem_mbox->Words[0] = mbox->Words[0];
+	mb();
+}
+
+
+static inline
+void DAC960_BA_WriteHardwareMailbox(void __iomem *base,
+				    dma_addr_t CommandMailboxDMA)
+{
+	dma_addr_writeql(CommandMailboxDMA,
+			 base + DAC960_BA_CommandMailboxBusAddressOffset);
+}
+
+static inline unsigned short
+DAC960_BA_ReadCommandIdentifier(void __iomem *base)
+{
+	return readw(base + DAC960_BA_CommandStatusOffset);
+}
+
+static inline unsigned char
+DAC960_BA_ReadCommandStatus(void __iomem *base)
+{
+	return readw(base + DAC960_BA_CommandStatusOffset + 2);
+}
+
+static inline bool
+DAC960_BA_ReadErrorStatus(void __iomem *base,
+			  unsigned char *ErrorStatus,
+			  unsigned char *Parameter0,
+			  unsigned char *Parameter1)
+{
+	u8 val;
+
+	val = readb(base + DAC960_BA_ErrorStatusRegisterOffset);
+	if (!(val & DAC960_BA_ERRSTS_PENDING))
+		return false;
+	val &= ~DAC960_BA_ERRSTS_PENDING;
+	*ErrorStatus = val;
+	*Parameter0 = readb(base + DAC960_BA_CommandMailboxBusAddressOffset + 0);
+	*Parameter1 = readb(base + DAC960_BA_CommandMailboxBusAddressOffset + 1);
+	writeb(0xFF, base + DAC960_BA_ErrorStatusRegisterOffset);
+	return true;
+}
+
+static inline unsigned char
+DAC960_BA_MailboxInit(void __iomem *base, dma_addr_t mbox_addr)
+{
+	unsigned char status;
+
+	while (DAC960_BA_HardwareMailboxFullP(base))
+		udelay(1);
+	DAC960_BA_WriteHardwareMailbox(base, mbox_addr);
+	DAC960_BA_HardwareMailboxNewCommand(base);
+	while (!DAC960_BA_HardwareMailboxStatusAvailableP(base))
+		udelay(1);
+	status = DAC960_BA_ReadCommandStatus(base);
+	DAC960_BA_AcknowledgeHardwareMailboxInterrupt(base);
+	DAC960_BA_AcknowledgeHardwareMailboxStatus(base);
+
+	return status;
+}
+
+static int DAC960_BA_HardwareInit(struct pci_dev *pdev,
+				  struct myrs_hba *cs, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char status, parm0, parm1;
+
+	DAC960_BA_DisableInterrupts(base);
+	DAC960_BA_AcknowledgeHardwareMailboxStatus(base);
+	udelay(1000);
+	while (DAC960_BA_InitializationInProgressP(base) &&
+	       timeout < MYRS_MAILBOX_TIMEOUT) {
+		if (DAC960_BA_ReadErrorStatus(base, &status,
+					      &parm0, &parm1) &&
+		    myrs_err_status(cs, status, parm0, parm1))
+			return -EIO;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRS_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrs_enable_mmio_mbox(cs, DAC960_BA_MailboxInit)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_BA_ControllerReset(base);
+		return -EAGAIN;
+	}
+	DAC960_BA_EnableInterrupts(base);
+	cs->write_cmd_mbox = DAC960_BA_WriteCommandMailbox;
+	cs->get_cmd_mbox = DAC960_BA_MemoryMailboxNewCommand;
+	cs->disable_intr = DAC960_BA_DisableInterrupts;
+	cs->reset = DAC960_BA_ControllerReset;
+	return 0;
+}
+
+static irqreturn_t DAC960_BA_InterruptHandler(int irq,
+					      void *DeviceIdentifier)
+{
+	struct myrs_hba *cs = DeviceIdentifier;
+	void __iomem *base = cs->io_base;
+	struct myrs_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cs->queue_lock, flags);
+	DAC960_BA_AcknowledgeInterrupt(base);
+	next_stat_mbox = cs->next_stat_mbox;
+	while (next_stat_mbox->id > 0) {
+		unsigned short id = next_stat_mbox->id;
+		struct scsi_cmnd *scmd = NULL;
+		struct myrs_cmdblk *cmd_blk = NULL;
+
+		if (id == MYRS_DCMD_TAG)
+			cmd_blk = &cs->dcmd_blk;
+		else if (id == MYRS_MCMD_TAG)
+			cmd_blk = &cs->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cs->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk) {
+			cmd_blk->status = next_stat_mbox->status;
+			cmd_blk->sense_len = next_stat_mbox->sense_len;
+			cmd_blk->residual = next_stat_mbox->residual;
+		} else
+			dev_err(&cs->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		memset(next_stat_mbox, 0, sizeof(struct myrs_stat_mbox));
+		if (++next_stat_mbox > cs->last_stat_mbox)
+			next_stat_mbox = cs->first_stat_mbox;
+
+		if (id < 3)
+			myrs_handle_cmdblk(cs, cmd_blk);
+		else
+			myrs_handle_scsi(cs, cmd_blk, scmd);
+	}
+	cs->next_stat_mbox = next_stat_mbox;
+	spin_unlock_irqrestore(&cs->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrs_privdata DAC960_BA_privdata = {
+	.hw_init =		DAC960_BA_HardwareInit,
+	.irq_handler =		DAC960_BA_InterruptHandler,
+	.io_mem_size =		DAC960_BA_RegisterWindowSize,
+};
+
+/*
+ * DAC960 LP Series Controllers.
+ */
+
+static inline
+void DAC960_LP_HardwareMailboxNewCommand(void __iomem *base)
+{
+	writeb(DAC960_LP_IDB_HWMBOX_NEW_CMD,
+	       base + DAC960_LP_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LP_AcknowledgeHardwareMailboxStatus(void __iomem *base)
+{
+	writeb(DAC960_LP_IDB_HWMBOX_ACK_STS,
+	       base + DAC960_LP_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LP_GenerateInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LP_IDB_GEN_IRQ,
+	       base + DAC960_LP_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LP_ControllerReset(void __iomem *base)
+{
+	writeb(DAC960_LP_IDB_CTRL_RESET,
+	       base + DAC960_LP_InboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LP_MemoryMailboxNewCommand(void __iomem *base)
+{
+	writeb(DAC960_LP_IDB_MMBOX_NEW_CMD,
+	       base + DAC960_LP_InboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_LP_HardwareMailboxFullP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_LP_InboundDoorBellRegisterOffset);
+	return val & DAC960_LP_IDB_HWMBOX_FULL;
+}
+
+static inline
+bool DAC960_LP_InitializationInProgressP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_LP_InboundDoorBellRegisterOffset);
+	return val & DAC960_LP_IDB_INIT_IN_PROGRESS;
+}
+
+static inline
+void DAC960_LP_AcknowledgeHardwareMailboxInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LP_ODB_HWMBOX_ACK_IRQ,
+	       base + DAC960_LP_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LP_AcknowledgeMemoryMailboxInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LP_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_LP_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+void DAC960_LP_AcknowledgeInterrupt(void __iomem *base)
+{
+	writeb(DAC960_LP_ODB_HWMBOX_ACK_IRQ | DAC960_LP_ODB_MMBOX_ACK_IRQ,
+	       base + DAC960_LP_OutboundDoorBellRegisterOffset);
+}
+
+static inline
+bool DAC960_LP_HardwareMailboxStatusAvailableP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_LP_OutboundDoorBellRegisterOffset);
+	return val & DAC960_LP_ODB_HWMBOX_STS_AVAIL;
+}
+
+static inline
+bool DAC960_LP_MemoryMailboxStatusAvailableP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_LP_OutboundDoorBellRegisterOffset);
+	return val & DAC960_LP_ODB_MMBOX_STS_AVAIL;
+}
+
+static inline
+void DAC960_LP_EnableInterrupts(void __iomem *base)
+{
+	writeb(~DAC960_LP_IRQMASK_DISABLE_IRQ,
+	       base + DAC960_LP_InterruptMaskRegisterOffset);
+}
+
+static inline
+void DAC960_LP_DisableInterrupts(void __iomem *base)
+{
+	writeb(0xFF,
+	       base + DAC960_LP_InterruptMaskRegisterOffset);
+}
+
+static inline
+bool DAC960_LP_InterruptsEnabledP(void __iomem *base)
+{
+	u8 val;
+
+	val = readb(base + DAC960_LP_InterruptMaskRegisterOffset);
+	return !(val & DAC960_LP_IRQMASK_DISABLE_IRQ);
+}
+
+static inline
+void DAC960_LP_WriteCommandMailbox(union myrs_cmd_mbox *mem_mbox,
+				   union myrs_cmd_mbox *mbox)
+{
+	memcpy(&mem_mbox->Words[1], &mbox->Words[1],
+	       sizeof(union myrs_cmd_mbox) - sizeof(unsigned int));
+	wmb();
+	mem_mbox->Words[0] = mbox->Words[0];
+	mb();
+}
+
+static inline
+void DAC960_LP_WriteHardwareMailbox(void __iomem *base,
+				    dma_addr_t CommandMailboxDMA)
+{
+	dma_addr_writeql(CommandMailboxDMA,
+			 base + DAC960_LP_CommandMailboxBusAddressOffset);
+}
+
+static inline unsigned short
+DAC960_LP_ReadCommandIdentifier(void __iomem *base)
+{
+	return readw(base + DAC960_LP_CommandStatusOffset);
+}
+
+static inline unsigned char
+DAC960_LP_ReadCommandStatus(void __iomem *base)
+{
+	return readw(base + DAC960_LP_CommandStatusOffset + 2);
+}
+
+static inline bool
+DAC960_LP_ReadErrorStatus(void __iomem *base,
+			  unsigned char *ErrorStatus,
+			  unsigned char *Parameter0,
+			  unsigned char *Parameter1)
+{
+	u8 val;
+
+	val = readb(base + DAC960_LP_ErrorStatusRegisterOffset);
+	if (!(val & DAC960_LP_ERRSTS_PENDING))
+		return false;
+	val &= ~DAC960_LP_ERRSTS_PENDING;
+	*ErrorStatus = val;
+	*Parameter0 =
+		readb(base + DAC960_LP_CommandMailboxBusAddressOffset + 0);
+	*Parameter1 =
+		readb(base + DAC960_LP_CommandMailboxBusAddressOffset + 1);
+	writeb(0xFF, base + DAC960_LP_ErrorStatusRegisterOffset);
+	return true;
+}
+
+static inline unsigned char
+DAC960_LP_MailboxInit(void __iomem *base, dma_addr_t mbox_addr)
+{
+	unsigned char status;
+
+	while (DAC960_LP_HardwareMailboxFullP(base))
+		udelay(1);
+	DAC960_LP_WriteHardwareMailbox(base, mbox_addr);
+	DAC960_LP_HardwareMailboxNewCommand(base);
+	while (!DAC960_LP_HardwareMailboxStatusAvailableP(base))
+		udelay(1);
+	status = DAC960_LP_ReadCommandStatus(base);
+	DAC960_LP_AcknowledgeHardwareMailboxInterrupt(base);
+	DAC960_LP_AcknowledgeHardwareMailboxStatus(base);
+
+	return status;
+}
+
+static int DAC960_LP_HardwareInit(struct pci_dev *pdev,
+				  struct myrs_hba *cs, void __iomem *base)
+{
+	int timeout = 0;
+	unsigned char status, parm0, parm1;
+
+	DAC960_LP_DisableInterrupts(base);
+	DAC960_LP_AcknowledgeHardwareMailboxStatus(base);
+	udelay(1000);
+	while (DAC960_LP_InitializationInProgressP(base) &&
+	       timeout < MYRS_MAILBOX_TIMEOUT) {
+		if (DAC960_LP_ReadErrorStatus(base, &status,
+					      &parm0, &parm1) &&
+		    myrs_err_status(cs, status,parm0, parm1))
+			return -EIO;
+		udelay(10);
+		timeout++;
+	}
+	if (timeout == MYRS_MAILBOX_TIMEOUT) {
+		dev_err(&pdev->dev,
+			"Timeout waiting for Controller Initialisation\n");
+		return -ETIMEDOUT;
+	}
+	if (!myrs_enable_mmio_mbox(cs, DAC960_LP_MailboxInit)) {
+		dev_err(&pdev->dev,
+			"Unable to Enable Memory Mailbox Interface\n");
+		DAC960_LP_ControllerReset(base);
+		return -ENODEV;
+	}
+	DAC960_LP_EnableInterrupts(base);
+	cs->write_cmd_mbox = DAC960_LP_WriteCommandMailbox;
+	cs->get_cmd_mbox = DAC960_LP_MemoryMailboxNewCommand;
+	cs->disable_intr = DAC960_LP_DisableInterrupts;
+	cs->reset = DAC960_LP_ControllerReset;
+
+	return 0;
+}
+
+static irqreturn_t DAC960_LP_InterruptHandler(int irq,
+					      void *DeviceIdentifier)
+{
+	struct myrs_hba *cs = DeviceIdentifier;
+	void __iomem *base = cs->io_base;
+	struct myrs_stat_mbox *next_stat_mbox;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cs->queue_lock, flags);
+	DAC960_LP_AcknowledgeInterrupt(base);
+	next_stat_mbox = cs->next_stat_mbox;
+	while (next_stat_mbox->id > 0) {
+		unsigned short id = next_stat_mbox->id;
+		struct scsi_cmnd *scmd = NULL;
+		struct myrs_cmdblk *cmd_blk = NULL;
+
+		if (id == MYRS_DCMD_TAG)
+			cmd_blk = &cs->dcmd_blk;
+		else if (id == MYRS_MCMD_TAG)
+			cmd_blk = &cs->mcmd_blk;
+		else {
+			scmd = scsi_host_find_tag(cs->host, id - 3);
+			if (scmd)
+				cmd_blk = scsi_cmd_priv(scmd);
+		}
+		if (cmd_blk) {
+			cmd_blk->status = next_stat_mbox->status;
+			cmd_blk->sense_len = next_stat_mbox->sense_len;
+			cmd_blk->residual = next_stat_mbox->residual;
+		} else
+			dev_err(&cs->pdev->dev,
+				"Unhandled command completion %d\n", id);
+
+		memset(next_stat_mbox, 0, sizeof(struct myrs_stat_mbox));
+		if (++next_stat_mbox > cs->last_stat_mbox)
+			next_stat_mbox = cs->first_stat_mbox;
+
+		if (id < 3)
+			myrs_handle_cmdblk(cs, cmd_blk);
+		else
+			myrs_handle_scsi(cs, cmd_blk, scmd);
+	}
+	cs->next_stat_mbox = next_stat_mbox;
+	spin_unlock_irqrestore(&cs->queue_lock, flags);
+	return IRQ_HANDLED;
+}
+
+struct myrs_privdata DAC960_LP_privdata = {
+	.hw_init =		DAC960_LP_HardwareInit,
+	.irq_handler =		DAC960_LP_InterruptHandler,
+	.io_mem_size =		DAC960_LP_RegisterWindowSize,
+};
+
+/*
+ * Module functions
+ */
+static int
+myrs_probe(struct pci_dev *dev, const struct pci_device_id *entry)
+{
+	struct myrs_hba *cs;
+	int ret;
+
+	cs = myrs_detect(dev, entry);
+	if (!cs)
+		return -ENODEV;
+
+	ret = myrs_get_config(cs);
+	if (ret < 0) {
+		myrs_cleanup(cs);
+		return ret;
+	}
+
+	if (!myrs_create_mempools(dev, cs)) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	ret = scsi_add_host(cs->host, &dev->dev);
+	if (ret) {
+		dev_err(&dev->dev, "scsi_add_host failed with %d\n", ret);
+		myrs_destroy_mempools(cs);
+		goto failed;
+	}
+	scsi_scan_host(cs->host);
+	return 0;
+failed:
+	myrs_cleanup(cs);
+	return ret;
+}
+
+
+static void myrs_remove(struct pci_dev *pdev)
+{
+	struct myrs_hba *cs = pci_get_drvdata(pdev);
+
+	if (cs == NULL)
+		return;
+
+	shost_printk(KERN_NOTICE, cs->host, "Flushing Cache...");
+	myrs_flush_cache(cs);
+	myrs_destroy_mempools(cs);
+	myrs_cleanup(cs);
+}
+
+
+static const struct pci_device_id myrs_id_table[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_GEM,
+		.subvendor	= PCI_SUBVENDOR_ID_MYLEX,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_GEM_privdata,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_BA,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_BA_privdata,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_MYLEX,
+		.device		= PCI_DEVICE_ID_MYLEX_DAC960_LP,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+		.driver_data	= (unsigned long) &DAC960_LP_privdata,
+	},
+	{0, },
+};
+
+MODULE_DEVICE_TABLE(pci, myrs_id_table);
+
+static struct pci_driver myrs_pci_driver = {
+	.name		= "myrs",
+	.id_table	= myrs_id_table,
+	.probe		= myrs_probe,
+	.remove		= myrs_remove,
+};
+
+static int __init myrs_init_module(void)
+{
+	int ret;
+
+	myrs_raid_template = raid_class_attach(&myrs_raid_functions);
+	if (!myrs_raid_template)
+		return -ENODEV;
+
+	ret = pci_register_driver(&myrs_pci_driver);
+	if (ret)
+		raid_class_release(myrs_raid_template);
+
+	return ret;
+}
+
+static void __exit myrs_cleanup_module(void)
+{
+	pci_unregister_driver(&myrs_pci_driver);
+	raid_class_release(myrs_raid_template);
+}
+
+module_init(myrs_init_module);
+module_exit(myrs_cleanup_module);
+
+MODULE_DESCRIPTION("Mylex DAC960/AcceleRAID/eXtremeRAID driver (SCSI Interface)");
+MODULE_AUTHOR("Hannes Reinecke <hare@suse.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/scsi/myrs.h b/drivers/scsi/myrs.h
new file mode 100644
index 000000000000..a2c0515bd8de
--- /dev/null
+++ b/drivers/scsi/myrs.h
@@ -0,0 +1,1141 @@
+/*
+ * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
+ *
+ * This driver supports the newer, SCSI-based firmware interface only.
+ *
+ * Copyright 2018 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
+ *
+ * Based on the original DAC960 driver, which has
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
+#ifndef _MYRS_H
+#define _MYRS_H
+
+#define MYRS_MAILBOX_TIMEOUT 1000000
+
+#define MYRS_DCMD_TAG 1
+#define MYRS_MCMD_TAG 2
+
+#define MYRS_LINE_BUFFER_SIZE 128
+
+#define MYRS_PRIMARY_MONITOR_INTERVAL (10 * HZ)
+#define MYRS_SECONDARY_MONITOR_INTERVAL (60 * HZ)
+
+/* Maximum number of Scatter/Gather Segments supported */
+#define MYRS_SG_LIMIT		128
+
+/*
+ * Number of Command and Status Mailboxes used by the
+ * DAC960 V2 Firmware Memory Mailbox Interface.
+ */
+#define MYRS_MAX_CMD_MBOX		512
+#define MYRS_MAX_STAT_MBOX		512
+
+#define MYRS_DCDB_SIZE			16
+#define MYRS_SENSE_SIZE			14
+
+/*
+ * DAC960 V2 Firmware Command Opcodes.
+ */
+enum myrs_cmd_opcode {
+	DAC960_V2_MemCopy =				0x01,
+	DAC960_V2_SCSI_10_Passthru =			0x02,
+	DAC960_V2_SCSI_255_Passthru =			0x03,
+	DAC960_V2_SCSI_10 =				0x04,
+	DAC960_V2_SCSI_256 =				0x05,
+	DAC960_V2_IOCTL =				0x20
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 Firmware IOCTL Opcodes.
+ */
+enum myrs_ioctl_opcode {
+	DAC960_V2_GetControllerInfo =			0x01,
+	DAC960_V2_GetLogicalDeviceInfoValid =		0x03,
+	DAC960_V2_GetPhysicalDeviceInfoValid =		0x05,
+	DAC960_V2_GetHealthStatus =			0x11,
+	DAC960_V2_GetEvent =				0x15,
+	DAC960_V2_StartDiscovery =			0x81,
+	DAC960_V2_SetDeviceState =			0x82,
+	DAC960_V2_InitPhysicalDeviceStart =		0x84,
+	DAC960_V2_InitPhysicalDeviceStop =		0x85,
+	DAC960_V2_InitLogicalDeviceStart =		0x86,
+	DAC960_V2_InitLogicalDeviceStop =		0x87,
+	DAC960_V2_RebuildDeviceStart =			0x88,
+	DAC960_V2_RebuildDeviceStop =			0x89,
+	DAC960_V2_MakeConsistencDataStart =		0x8A,
+	DAC960_V2_MakeConsistencDataStop =		0x8B,
+	DAC960_V2_ConsistencyCheckStart =		0x8C,
+	DAC960_V2_ConsistencyCheckStop =		0x8D,
+	DAC960_V2_SetMemoryMailbox =			0x8E,
+	DAC960_V2_ResetDevice =				0x90,
+	DAC960_V2_FlushDeviceData =			0x91,
+	DAC960_V2_PauseDevice =				0x92,
+	DAC960_V2_UnPauseDevice =			0x93,
+	DAC960_V2_LocateDevice =			0x94,
+	DAC960_V2_CreateNewConfiguration =		0xC0,
+	DAC960_V2_DeleteLogicalDevice =			0xC1,
+	DAC960_V2_ReplaceInternalDevice =		0xC2,
+	DAC960_V2_RenameLogicalDevice =			0xC3,
+	DAC960_V2_AddNewConfiguration =			0xC4,
+	DAC960_V2_TranslatePhysicalToLogicalDevice =	0xC5,
+	DAC960_V2_ClearConfiguration =			0xCA,
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 Firmware Command Status Codes.
+*/
+#define DAC960_V2_NormalCompletion		0x00
+#define DAC960_V2_AbnormalCompletion		0x02
+#define DAC960_V2_DeviceBusy			0x08
+#define DAC960_V2_DeviceNonresponsive		0x0E
+#define DAC960_V2_DeviceNonresponsive2		0x0F
+#define DAC960_V2_DeviceRevervationConflict	0x18
+
+/*
+ * DAC960 V2 Firmware Memory Type structure.
+ */
+struct myrs_mem_type {
+	enum {
+		DAC960_V2_MemoryType_Reserved =		0x00,
+		DAC960_V2_MemoryType_DRAM =		0x01,
+		DAC960_V2_MemoryType_EDRAM =		0x02,
+		DAC960_V2_MemoryType_EDO =		0x03,
+		DAC960_V2_MemoryType_SDRAM =		0x04,
+		DAC960_V2_MemoryType_Last =		0x1F
+	} __attribute__ ((packed)) mem_type:5;	/* Byte 0 Bits 0-4 */
+	bool rsvd:1;				/* Byte 0 Bit 5 */
+	bool mem_parity:1;			/* Byte 0 Bit 6 */
+	bool mem_ecc:1;				/* Byte 0 Bit 7 */
+};
+
+/*
+ * DAC960 V2 Firmware Processor Type structure.
+ */
+enum myrs_cpu_type {
+	DAC960_V2_ProcessorType_i960CA =		0x01,
+	DAC960_V2_ProcessorType_i960RD =		0x02,
+	DAC960_V2_ProcessorType_i960RN =		0x03,
+	DAC960_V2_ProcessorType_i960RP =		0x04,
+	DAC960_V2_ProcessorType_NorthBay =		0x05,
+	DAC960_V2_ProcessorType_StrongArm =		0x06,
+	DAC960_V2_ProcessorType_i960RM =		0x07
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 Firmware Get Controller Info reply structure.
+ */
+struct myrs_ctlr_info {
+	unsigned char rsvd1;				/* Byte 0 */
+	enum {
+		DAC960_V2_SCSI_Bus =			0x00,
+		DAC960_V2_Fibre_Bus =			0x01,
+		DAC960_V2_PCI_Bus =			0x03
+	} __attribute__ ((packed)) bus;	/* Byte 1 */
+	enum {
+		DAC960_V2_DAC960E =			0x01,
+		DAC960_V2_DAC960M =			0x08,
+		DAC960_V2_DAC960PD =			0x10,
+		DAC960_V2_DAC960PL =			0x11,
+		DAC960_V2_DAC960PU =			0x12,
+		DAC960_V2_DAC960PE =			0x13,
+		DAC960_V2_DAC960PG =			0x14,
+		DAC960_V2_DAC960PJ =			0x15,
+		DAC960_V2_DAC960PTL0 =			0x16,
+		DAC960_V2_DAC960PR =			0x17,
+		DAC960_V2_DAC960PRL =			0x18,
+		DAC960_V2_DAC960PT =			0x19,
+		DAC960_V2_DAC1164P =			0x1A,
+		DAC960_V2_DAC960PTL1 =			0x1B,
+		DAC960_V2_EXR2000P =			0x1C,
+		DAC960_V2_EXR3000P =			0x1D,
+		DAC960_V2_AcceleRAID352 =		0x1E,
+		DAC960_V2_AcceleRAID170 =		0x1F,
+		DAC960_V2_AcceleRAID160 =		0x20,
+		DAC960_V2_DAC960S =			0x60,
+		DAC960_V2_DAC960SU =			0x61,
+		DAC960_V2_DAC960SX =			0x62,
+		DAC960_V2_DAC960SF =			0x63,
+		DAC960_V2_DAC960SS =			0x64,
+		DAC960_V2_DAC960FL =			0x65,
+		DAC960_V2_DAC960LL =			0x66,
+		DAC960_V2_DAC960FF =			0x67,
+		DAC960_V2_DAC960HP =			0x68,
+		DAC960_V2_RAIDBRICK =			0x69,
+		DAC960_V2_METEOR_FL =			0x6A,
+		DAC960_V2_METEOR_FF =			0x6B
+	} __attribute__ ((packed)) ctlr_type;	/* Byte 2 */
+	unsigned char rsvd2;			/* Byte 3 */
+	unsigned short bus_speed_mhz;		/* Bytes 4-5 */
+	unsigned char bus_width;		/* Byte 6 */
+	unsigned char flash_code;		/* Byte 7 */
+	unsigned char ports_present;		/* Byte 8 */
+	unsigned char rsvd3[7];			/* Bytes 9-15 */
+	unsigned char bus_name[16];		/* Bytes 16-31 */
+	unsigned char ctlr_name[16];		/* Bytes 32-47 */
+	unsigned char rsvd4[16];		/* Bytes 48-63 */
+	/* Firmware Release Information */
+	unsigned char fw_major_version;		/* Byte 64 */
+	unsigned char fw_minor_version;		/* Byte 65 */
+	unsigned char fw_turn_number;		/* Byte 66 */
+	unsigned char fw_build_number;		/* Byte 67 */
+	unsigned char fw_release_day;		/* Byte 68 */
+	unsigned char fw_release_month;		/* Byte 69 */
+	unsigned char fw_release_year_hi;	/* Byte 70 */
+	unsigned char fw_release_year_lo;	/* Byte 71 */
+	/* Hardware Release Information */
+	unsigned char hw_rev;			/* Byte 72 */
+	unsigned char rsvd5[3];			/* Bytes 73-75 */
+	unsigned char hw_release_day;		/* Byte 76 */
+	unsigned char hw_release_month;		/* Byte 77 */
+	unsigned char hw_release_year_hi;	/* Byte 78 */
+	unsigned char hw_release_year_lo;	/* Byte 79 */
+	/* Hardware Manufacturing Information */
+	unsigned char manuf_batch_num;		/* Byte 80 */
+	unsigned char rsvd6;			/* Byte 81 */
+	unsigned char manuf_plant_num;		/* Byte 82 */
+	unsigned char rsvd7;			/* Byte 83 */
+	unsigned char hw_manuf_day;		/* Byte 84 */
+	unsigned char hw_manuf_month;		/* Byte 85 */
+	unsigned char hw_manuf_year_hi;		/* Byte 86 */
+	unsigned char hw_manuf_year_lo;		/* Byte 87 */
+	unsigned char max_pd_per_xld;		/* Byte 88 */
+	unsigned char max_ild_per_xld;		/* Byte 89 */
+	unsigned short nvram_size_kb;		/* Bytes 90-91 */
+	unsigned char max_xld;			/* Byte 92 */
+	unsigned char rsvd8[3];			/* Bytes 93-95 */
+	/* Unique Information per Controller */
+	unsigned char serial_number[16];	/* Bytes 96-111 */
+	unsigned char rsvd9[16];		/* Bytes 112-127 */
+	/* Vendor Information */
+	unsigned char rsvd10[3];		/* Bytes 128-130 */
+	unsigned char oem_code;			/* Byte 131 */
+	unsigned char vendor[16];		/* Bytes 132-147 */
+	/* Other Physical/Controller/Operation Information */
+	bool bbu_present:1;			/* Byte 148 Bit 0 */
+	bool cluster_mode:1;			/* Byte 148 Bit 1 */
+	unsigned char rsvd11:6;			/* Byte 148 Bits 2-7 */
+	unsigned char rsvd12[3];		/* Bytes 149-151 */
+	/* Physical Device Scan Information */
+	bool pscan_active:1;			/* Byte 152 Bit 0 */
+	unsigned char rsvd13:7;			/* Byte 152 Bits 1-7 */
+	unsigned char pscan_chan;		/* Byte 153 */
+	unsigned char pscan_target;		/* Byte 154 */
+	unsigned char pscan_lun;		/* Byte 155 */
+	/* Maximum Command Data Transfer Sizes */
+	unsigned short max_transfer_size;	/* Bytes 156-157 */
+	unsigned short max_sge;			/* Bytes 158-159 */
+	/* Logical/Physical Device Counts */
+	unsigned short ldev_present;		/* Bytes 160-161 */
+	unsigned short ldev_critical;		/* Bytes 162-163 */
+	unsigned short ldev_offline;		/* Bytes 164-165 */
+	unsigned short pdev_present;		/* Bytes 166-167 */
+	unsigned short pdisk_present;		/* Bytes 168-169 */
+	unsigned short pdisk_critical;		/* Bytes 170-171 */
+	unsigned short pdisk_offline;		/* Bytes 172-173 */
+	unsigned short max_tcq;			/* Bytes 174-175 */
+	/* Channel and Target ID Information */
+	unsigned char physchan_present;		/* Byte 176 */
+	unsigned char virtchan_present;		/* Byte 177 */
+	unsigned char physchan_max;		/* Byte 178 */
+	unsigned char virtchan_max;		/* Byte 179 */
+	unsigned char max_targets[16];		/* Bytes 180-195 */
+	unsigned char rsvd14[12];		/* Bytes 196-207 */
+	/* Memory/Cache Information */
+	unsigned short mem_size_mb;		/* Bytes 208-209 */
+	unsigned short cache_size_mb;		/* Bytes 210-211 */
+	unsigned int valid_cache_bytes;		/* Bytes 212-215 */
+	unsigned int dirty_cache_bytes;		/* Bytes 216-219 */
+	unsigned short mem_speed_mhz;		/* Bytes 220-221 */
+	unsigned char mem_data_width;		/* Byte 222 */
+	struct myrs_mem_type mem_type;		/* Byte 223 */
+	unsigned char cache_mem_type_name[16];	/* Bytes 224-239 */
+	/* Execution Memory Information */
+	unsigned short exec_mem_size_mb;	/* Bytes 240-241 */
+	unsigned short exec_l2_cache_size_mb;	/* Bytes 242-243 */
+	unsigned char rsvd15[8];		/* Bytes 244-251 */
+	unsigned short exec_mem_speed_mhz;	/* Bytes 252-253 */
+	unsigned char exec_mem_data_width;	/* Byte 254 */
+	struct myrs_mem_type exec_mem_type;	/* Byte 255 */
+	unsigned char exec_mem_type_name[16];	/* Bytes 256-271 */
+	/* CPU Type Information */
+	struct {				/* Bytes 272-335 */
+		unsigned short cpu_speed_mhz;
+		enum myrs_cpu_type cpu_type;
+		unsigned char cpu_count;
+		unsigned char rsvd16[12];
+		unsigned char cpu_name[16];
+	} __attribute(( packed )) cpu[2];
+	/* Debugging/Profiling/Command Time Tracing Information */
+	unsigned short cur_prof_page_num;	/* Bytes 336-337 */
+	unsigned short num_prof_waiters;	/* Bytes 338-339 */
+	unsigned short cur_trace_page_num;	/* Bytes 340-341 */
+	unsigned short num_trace_waiters;	/* Bytes 342-343 */
+	unsigned char rsvd18[8];		/* Bytes 344-351 */
+	/* Error Counters on Physical Devices */
+	unsigned short pdev_bus_resets;		/* Bytes 352-353 */
+	unsigned short pdev_parity_errors;	/* Bytes 355-355 */
+	unsigned short pdev_soft_errors;	/* Bytes 356-357 */
+	unsigned short pdev_cmds_failed;	/* Bytes 358-359 */
+	unsigned short pdev_misc_errors;	/* Bytes 360-361 */
+	unsigned short pdev_cmd_timeouts;	/* Bytes 362-363 */
+	unsigned short pdev_sel_timeouts;	/* Bytes 364-365 */
+	unsigned short pdev_retries_done;	/* Bytes 366-367 */
+	unsigned short pdev_aborts_done;	/* Bytes 368-369 */
+	unsigned short pdev_host_aborts_done;	/* Bytes 370-371 */
+	unsigned short pdev_predicted_failures;	/* Bytes 372-373 */
+	unsigned short pdev_host_cmds_failed;	/* Bytes 374-375 */
+	unsigned short pdev_hard_errors;	/* Bytes 376-377 */
+	unsigned char rsvd19[6];		/* Bytes 378-383 */
+	/* Error Counters on Logical Devices */
+	unsigned short ldev_soft_errors;	/* Bytes 384-385 */
+	unsigned short ldev_cmds_failed;	/* Bytes 386-387 */
+	unsigned short ldev_host_aborts_done;	/* Bytes 388-389 */
+	unsigned char rsvd20[2];		/* Bytes 390-391 */
+	/* Error Counters on Controller */
+	unsigned short ctlr_mem_errors;		/* Bytes 392-393 */
+	unsigned short ctlr_host_aborts_done;	/* Bytes 394-395 */
+	unsigned char rsvd21[4];		/* Bytes 396-399 */
+	/* Long Duration Activity Information */
+	unsigned short bg_init_active;		/* Bytes 400-401 */
+	unsigned short ldev_init_active;	/* Bytes 402-403 */
+	unsigned short pdev_init_active;	/* Bytes 404-405 */
+	unsigned short cc_active;		/* Bytes 406-407 */
+	unsigned short rbld_active;		/* Bytes 408-409 */
+	unsigned short exp_active;		/* Bytes 410-411 */
+	unsigned short patrol_active;		/* Bytes 412-413 */
+	unsigned char rsvd22[2];		/* Bytes 414-415 */
+	/* Flash ROM Information */
+	unsigned char flash_type;		/* Byte 416 */
+	unsigned char rsvd23;			/* Byte 417 */
+	unsigned short flash_size_MB;		/* Bytes 418-419 */
+	unsigned int flash_limit;		/* Bytes 420-423 */
+	unsigned int flash_count;		/* Bytes 424-427 */
+	unsigned char rsvd24[4];		/* Bytes 428-431 */
+	unsigned char flash_type_name[16];	/* Bytes 432-447 */
+	/* Firmware Run Time Information */
+	unsigned char rbld_rate;		/* Byte 448 */
+	unsigned char bg_init_rate;		/* Byte 449 */
+	unsigned char fg_init_rate;		/* Byte 450 */
+	unsigned char cc_rate;			/* Byte 451 */
+	unsigned char rsvd25[4];		/* Bytes 452-455 */
+	unsigned int max_dp;			/* Bytes 456-459 */
+	unsigned int free_dp;			/* Bytes 460-463 */
+	unsigned int max_iop;			/* Bytes 464-467 */
+	unsigned int free_iop;			/* Bytes 468-471 */
+	unsigned short max_combined_len;	/* Bytes 472-473 */
+	unsigned short num_cfg_groups;		/* Bytes 474-475 */
+	bool installation_abort_status:1;	/* Byte 476 Bit 0 */
+	bool maint_mode_status:1;		/* Byte 476 Bit 1 */
+	unsigned char rsvd26[7];		/* Bytes 476-511 */
+	unsigned char rsvd27[512];		/* Bytes 512-1023 */
+};
+
+/*
+ * DAC960 V2 Firmware Device State type.
+ */
+enum myrs_devstate {
+	DAC960_V2_Device_Unconfigured =		0x00,
+	DAC960_V2_Device_Online =		0x01,
+	DAC960_V2_Device_Rebuild =		0x03,
+	DAC960_V2_Device_Missing =		0x04,
+	DAC960_V2_Device_SuspectedCritical =	0x05,
+	DAC960_V2_Device_Offline =		0x08,
+	DAC960_V2_Device_Critical =		0x09,
+	DAC960_V2_Device_SuspectedDead =	0x0C,
+	DAC960_V2_Device_CommandedOffline =	0x10,
+	DAC960_V2_Device_Standby =		0x21,
+	DAC960_V2_Device_InvalidState =		0xFF
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 RAID Levels
+ */
+enum myrs_raid_level {
+	DAC960_V2_RAID_Level0 =		0x0,     /* RAID 0 */
+	DAC960_V2_RAID_Level1 =		0x1,     /* RAID 1 */
+	DAC960_V2_RAID_Level3 =		0x3,     /* RAID 3 right asymmetric parity */
+	DAC960_V2_RAID_Level5 =		0x5,     /* RAID 5 right asymmetric parity */
+	DAC960_V2_RAID_Level6 =		0x6,     /* RAID 6 (Mylex RAID 6) */
+	DAC960_V2_RAID_JBOD =		0x7,     /* RAID 7 (JBOD) */
+	DAC960_V2_RAID_NewSpan =	0x8,     /* New Mylex SPAN */
+	DAC960_V2_RAID_Level3F =	0x9,     /* RAID 3 fixed parity */
+	DAC960_V2_RAID_Level3L =	0xb,     /* RAID 3 left symmetric parity */
+	DAC960_V2_RAID_Span =		0xc,     /* current spanning implementation */
+	DAC960_V2_RAID_Level5L =	0xd,     /* RAID 5 left symmetric parity */
+	DAC960_V2_RAID_LevelE =		0xe,     /* RAID E (concatenation) */
+	DAC960_V2_RAID_Physical =	0xf,     /* physical device */
+} __attribute__ ((packed));
+
+enum myrs_stripe_size {
+	DAC960_V2_StripeSize_0 =	0x0,	/* no stripe (RAID 1, RAID 7, etc) */
+	DAC960_V2_StripeSize_512b =	0x1,
+	DAC960_V2_StripeSize_1k =	0x2,
+	DAC960_V2_StripeSize_2k =	0x3,
+	DAC960_V2_StripeSize_4k =	0x4,
+	DAC960_V2_StripeSize_8k =	0x5,
+	DAC960_V2_StripeSize_16k =	0x6,
+	DAC960_V2_StripeSize_32k =	0x7,
+	DAC960_V2_StripeSize_64k =	0x8,
+	DAC960_V2_StripeSize_128k =	0x9,
+	DAC960_V2_StripeSize_256k =	0xa,
+	DAC960_V2_StripeSize_512k =	0xb,
+	DAC960_V2_StripeSize_1m =	0xc,
+} __attribute__ ((packed));
+
+enum myrs_cacheline_size {
+	DAC960_V2_Cacheline_ZERO =	0x0,	/* caching cannot be enabled */
+	DAC960_V2_Cacheline_512b =	0x1,
+	DAC960_V2_Cacheline_1k =	0x2,
+	DAC960_V2_Cacheline_2k =	0x3,
+	DAC960_V2_Cacheline_4k =	0x4,
+	DAC960_V2_Cacheline_8k =	0x5,
+	DAC960_V2_Cacheline_16k =	0x6,
+	DAC960_V2_Cacheline_32k =	0x7,
+	DAC960_V2_Cacheline_64k =	0x8,
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 Firmware Get Logical Device Info reply structure.
+ */
+struct myrs_ldev_info {
+	unsigned char ctlr;			/* Byte 0 */
+	unsigned char channel;			/* Byte 1 */
+	unsigned char target;			/* Byte 2 */
+	unsigned char lun;			/* Byte 3 */
+	enum myrs_devstate dev_state;		/* Byte 4 */
+	unsigned char raid_level;		/* Byte 5 */
+	enum myrs_stripe_size stripe_size;	/* Byte 6 */
+	enum myrs_cacheline_size cacheline_size; /* Byte 7 */
+	struct {
+		enum {
+			DAC960_V2_ReadCacheDisabled =		0x0,
+			DAC960_V2_ReadCacheEnabled =		0x1,
+			DAC960_V2_ReadAheadEnabled =		0x2,
+			DAC960_V2_IntelligentReadAheadEnabled =	0x3,
+			DAC960_V2_ReadCache_Last =		0x7
+		} __attribute__ ((packed)) rce:3; /* Byte 8 Bits 0-2 */
+		enum {
+			DAC960_V2_WriteCacheDisabled =		0x0,
+			DAC960_V2_LogicalDeviceReadOnly =	0x1,
+			DAC960_V2_WriteCacheEnabled =		0x2,
+			DAC960_V2_IntelligentWriteCacheEnabled = 0x3,
+			DAC960_V2_WriteCache_Last =		0x7
+		} __attribute__ ((packed)) wce:3; /* Byte 8 Bits 3-5 */
+		bool rsvd1:1;			/* Byte 8 Bit 6 */
+		bool ldev_init_done:1;		/* Byte 8 Bit 7 */
+	} ldev_control;				/* Byte 8 */
+	/* Logical Device Operations Status */
+	bool cc_active:1;			/* Byte 9 Bit 0 */
+	bool rbld_active:1;			/* Byte 9 Bit 1 */
+	bool bg_init_active:1;			/* Byte 9 Bit 2 */
+	bool fg_init_active:1;			/* Byte 9 Bit 3 */
+	bool migration_active:1;		/* Byte 9 Bit 4 */
+	bool patrol_active:1;			/* Byte 9 Bit 5 */
+	unsigned char rsvd2:2;			/* Byte 9 Bits 6-7 */
+	unsigned char raid5_writeupdate;	/* Byte 10 */
+	unsigned char raid5_algo;		/* Byte 11 */
+	unsigned short ldev_num;		/* Bytes 12-13 */
+	/* BIOS Info */
+	bool bios_disabled:1;			/* Byte 14 Bit 0 */
+	bool cdrom_boot:1;			/* Byte 14 Bit 1 */
+	bool drv_coercion:1;			/* Byte 14 Bit 2 */
+	bool write_same_disabled:1;		/* Byte 14 Bit 3 */
+	bool hba_mode:1;			/* Byte 14 Bit 4 */
+	enum {
+		DAC960_V2_Geometry_128_32 =		0x0,
+		DAC960_V2_Geometry_255_63 =		0x1,
+		DAC960_V2_Geometry_Reserved1 =		0x2,
+		DAC960_V2_Geometry_Reserved2 =		0x3
+	} __attribute__ ((packed)) drv_geom:2;	/* Byte 14 Bits 5-6 */
+	bool super_ra_enabled:1;		/* Byte 14 Bit 7 */
+	unsigned char rsvd3:8;			/* Byte 15 */
+	/* Error Counters */
+	unsigned short soft_errs;		/* Bytes 16-17 */
+	unsigned short cmds_failed;		/* Bytes 18-19 */
+	unsigned short cmds_aborted;		/* Bytes 20-21 */
+	unsigned short deferred_write_errs;	/* Bytes 22-23 */
+	unsigned int rsvd4:32;			/* Bytes 24-27 */
+	unsigned int rsvd5:32;			/* Bytes 28-31 */
+	/* Device Size Information */
+	unsigned short rsvd6:16;		/* Bytes 32-33 */
+	unsigned short devsize_bytes;		/* Bytes 34-35 */
+	unsigned int orig_devsize;		/* Bytes 36-39 */
+	unsigned int cfg_devsize;		/* Bytes 40-43 */
+	unsigned int rsvd7:32;			/* Bytes 44-47 */
+	unsigned char ldev_name[32];		/* Bytes 48-79 */
+	unsigned char inquiry[36];		/* Bytes 80-115 */
+	unsigned char rsvd8[12];		/* Bytes 116-127 */
+	u64 last_read_lba;			/* Bytes 128-135 */
+	u64 last_write_lba;			/* Bytes 136-143 */
+	u64 cc_lba;				/* Bytes 144-151 */
+	u64 rbld_lba;				/* Bytes 152-159 */
+	u64 bg_init_lba;			/* Bytes 160-167 */
+	u64 fg_init_lba;			/* Bytes 168-175 */
+	u64 migration_lba;			/* Bytes 176-183 */
+	u64 patrol_lba;				/* Bytes 184-191 */
+	unsigned char rsvd9[64];		/* Bytes 192-255 */
+};
+
+/*
+ * DAC960 V2 Firmware Get Physical Device Info reply structure.
+ */
+struct myrs_pdev_info {
+	unsigned char rsvd1:8;			/* Byte 0 */
+	unsigned char channel;			/* Byte 1 */
+	unsigned char target;			/* Byte 2 */
+	unsigned char lun;			/* Byte 3 */
+	/* Configuration Status Bits */
+	bool pdev_fault_tolerant:1;		/* Byte 4 Bit 0 */
+	bool pdev_connected:1;			/* Byte 4 Bit 1 */
+	bool pdev_local_to_ctlr:1;		/* Byte 4 Bit 2 */
+	unsigned char rsvd2:5;			/* Byte 4 Bits 3-7 */
+	/* Multiple Host/Controller Status Bits */
+	bool remote_host_dead:1;		/* Byte 5 Bit 0 */
+	bool remove_ctlr_dead:1;		/* Byte 5 Bit 1 */
+	unsigned char rsvd3:6;			/* Byte 5 Bits 2-7 */
+	enum myrs_devstate dev_state;		/* Byte 6 */
+	unsigned char nego_data_width;		/* Byte 7 */
+	unsigned short nego_sync_rate; 		/* Bytes 8-9 */
+	/* Multiported Physical Device Information */
+	unsigned char num_ports;		/* Byte 10 */
+	unsigned char drv_access_bitmap;	/* Byte 11 */
+	unsigned int rsvd4:32;			/* Bytes 12-15 */
+	unsigned char ip_address[16];		/* Bytes 16-31 */
+	unsigned short MaximumTags;		/* Bytes 32-33 */
+	/* Physical Device Operations Status */
+	bool cc_in_progress:1;			/* Byte 34 Bit 0 */
+	bool rbld_in_progress:1;		/* Byte 34 Bit 1 */
+	bool makecc_in_progress:1;		/* Byte 34 Bit 2 */
+	bool pdevinit_in_progress:1;		/* Byte 34 Bit 3 */
+	bool migration_in_progress:1;		/* Byte 34 Bit 4 */
+	bool patrol_in_progress:1;		/* Byte 34 Bit 5 */
+	unsigned char rsvd5:2;			/* Byte 34 Bits 6-7 */
+	unsigned char long_op_status;		/* Byte 35 */
+	unsigned char parity_errs;		/* Byte 36 */
+	unsigned char soft_errs;		/* Byte 37 */
+	unsigned char hard_errs;		/* Byte 38 */
+	unsigned char misc_errs;		/* Byte 39 */
+	unsigned char cmd_timeouts;		/* Byte 40 */
+	unsigned char retries;			/* Byte 41 */
+	unsigned char aborts;			/* Byte 42 */
+	unsigned char pred_failures;		/* Byte 43 */
+	unsigned int rsvd6:32;			/* Bytes 44-47 */
+	unsigned short rsvd7:16;		/* Bytes 48-49 */
+	unsigned short devsize_bytes;		/* Bytes 50-51 */
+	unsigned int orig_devsize;		/* Bytes 52-55 */
+	unsigned int cfg_devsize;		/* Bytes 56-59 */
+	unsigned int rsvd8:32;			/* Bytes 60-63 */
+	unsigned char pdev_name[16];		/* Bytes 64-79 */
+	unsigned char rsvd9[16];		/* Bytes 80-95 */
+	unsigned char rsvd10[32];		/* Bytes 96-127 */
+	unsigned char inquiry[36];		/* Bytes 128-163 */
+	unsigned char rsvd11[20];		/* Bytes 164-183 */
+	unsigned char rsvd12[8];		/* Bytes 184-191 */
+	u64 last_read_lba;			/* Bytes 192-199 */
+	u64 last_write_lba;			/* Bytes 200-207 */
+	u64 cc_lba;				/* Bytes 208-215 */
+	u64 rbld_lba;				/* Bytes 216-223 */
+	u64 makecc_lba;				/* Bytes 224-231 */
+	u64 devinit_lba;			/* Bytes 232-239 */
+	u64 migration_lba;			/* Bytes 240-247 */
+	u64 patrol_lba;				/* Bytes 248-255 */
+	unsigned char rsvd13[256];		/* Bytes 256-511 */
+};
+
+/*
+ * DAC960 V2 Firmware Health Status Buffer structure.
+ */
+struct myrs_fwstat {
+	unsigned int uptime_usecs;		/* Bytes 0-3 */
+	unsigned int uptime_msecs;		/* Bytes 4-7 */
+	unsigned int seconds;			/* Bytes 8-11 */
+	unsigned char rsvd1[4];			/* Bytes 12-15 */
+	unsigned int epoch;			/* Bytes 16-19 */
+	unsigned char rsvd2[4];			/* Bytes 20-23 */
+	unsigned int dbg_msgbuf_idx;		/* Bytes 24-27 */
+	unsigned int coded_msgbuf_idx;		/* Bytes 28-31 */
+	unsigned int cur_timetrace_page;	/* Bytes 32-35 */
+	unsigned int cur_prof_page;		/* Bytes 36-39 */
+	unsigned int next_evseq;		/* Bytes 40-43 */
+	unsigned char rsvd3[4];			/* Bytes 44-47 */
+	unsigned char rsvd4[16];		/* Bytes 48-63 */
+	unsigned char rsvd5[64];		/* Bytes 64-127 */
+};
+
+/*
+ * DAC960 V2 Firmware Get Event reply structure.
+ */
+struct myrs_event {
+	unsigned int ev_seq;			/* Bytes 0-3 */
+	unsigned int ev_time;			/* Bytes 4-7 */
+	unsigned int ev_code;			/* Bytes 8-11 */
+	unsigned char rsvd1:8;			/* Byte 12 */
+	unsigned char channel;			/* Byte 13 */
+	unsigned char target;			/* Byte 14 */
+	unsigned char lun;			/* Byte 15 */
+	unsigned int rsvd2:32;			/* Bytes 16-19 */
+	unsigned int ev_parm;			/* Bytes 20-23 */
+	unsigned char sense_data[40];		/* Bytes 24-63 */
+};
+
+/*
+ * DAC960 V2 Firmware Command Control Bits structure.
+ */
+struct myrs_cmd_ctrl {
+	bool fua:1;			/* Byte 0 Bit 0 */
+	bool disable_pgout:1;		/* Byte 0 Bit 1 */
+	bool rsvd1:1;			/* Byte 0 Bit 2 */
+	bool add_sge_mem:1;		/* Byte 0 Bit 3 */
+	bool dma_ctrl_to_host:1;	/* Byte 0 Bit 4 */
+	bool rsvd2:1;			/* Byte 0 Bit 5 */
+	bool no_autosense:1;		/* Byte 0 Bit 6 */
+	bool disc_prohibited:1;		/* Byte 0 Bit 7 */
+};
+
+/*
+ * DAC960 V2 Firmware Command Timeout structure.
+ */
+struct myrs_cmd_tmo {
+	unsigned char tmo_val:6;			/* Byte 0 Bits 0-5 */
+	enum {
+		DAC960_V2_TimeoutScale_Seconds =	0,
+		DAC960_V2_TimeoutScale_Minutes =	1,
+		DAC960_V2_TimeoutScale_Hours =		2,
+		DAC960_V2_TimeoutScale_Reserved =	3
+	} __attribute__ ((packed)) tmo_scale:2;		/* Byte 0 Bits 6-7 */
+};
+
+/*
+ * DAC960 V2 Firmware Physical Device structure.
+ */
+struct myrs_pdev {
+	unsigned char lun;			/* Byte 0 */
+	unsigned char target;			/* Byte 1 */
+	unsigned char channel:3;		/* Byte 2 Bits 0-2 */
+	unsigned char ctlr:5;			/* Byte 2 Bits 3-7 */
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 Firmware Logical Device structure.
+ */
+struct myrs_ldev {
+	unsigned short ldev_num;		/* Bytes 0-1 */
+	unsigned char rsvd:3;			/* Byte 2 Bits 0-2 */
+	unsigned char ctlr:5;			/* Byte 2 Bits 3-7 */
+} __attribute__ ((packed));
+
+/*
+ * DAC960 V2 Firmware Operation Device type.
+ */
+enum myrs_opdev {
+	DAC960_V2_Physical_Device =		0x00,
+	DAC960_V2_RAID_Device =			0x01,
+	DAC960_V2_Physical_Channel =		0x02,
+	DAC960_V2_RAID_Channel =		0x03,
+	DAC960_V2_Physical_Controller =		0x04,
+	DAC960_V2_RAID_Controller =		0x05,
+	DAC960_V2_Configuration_Group =		0x10,
+	DAC960_V2_Enclosure =			0x11
+} __attribute__ ((packed)) ;
+
+/*
+ * DAC960 V2 Firmware Translate Physical To Logical Device structure.
+ */
+struct myrs_devmap {
+	unsigned short ldev_num;		/* Bytes 0-1 */
+	unsigned short rsvd:16;			/* Bytes 2-3 */
+	unsigned char prev_boot_ctlr;		/* Byte 4 */
+	unsigned char prev_boot_channel;	/* Byte 5 */
+	unsigned char prev_boot_target;		/* Byte 6 */
+	unsigned char prev_boot_lun;		/* Byte 7 */
+};
+
+/*
+ * DAC960 V2 Firmware Scatter/Gather List Entry structure.
+ */
+struct myrs_sge {
+	u64 sge_addr;			/* Bytes 0-7 */
+	u64 sge_count;			/* Bytes 8-15 */
+};
+
+/*
+ * DAC960 V2 Firmware Data Transfer Memory Address structure.
+ */
+union myrs_sgl {
+	struct myrs_sge sge[2]; /* Bytes 0-31 */
+	struct {
+		unsigned short sge0_len;	/* Bytes 0-1 */
+		unsigned short sge1_len;	/* Bytes 2-3 */
+		unsigned short sge2_len;	/* Bytes 4-5 */
+		unsigned short rsvd:16;		/* Bytes 6-7 */
+		u64 sge0_addr;			/* Bytes 8-15 */
+		u64 sge1_addr;			/* Bytes 16-23 */
+		u64 sge2_addr;			/* Bytes 24-31 */
+	} ext;
+};
+
+/*
+ * 64 Byte DAC960 V2 Firmware Command Mailbox structure.
+ */
+union myrs_cmd_mbox {
+	unsigned int Words[16];				/* Words 0-15 */
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		unsigned int rsvd1:24;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		unsigned char rsvd2[10];		/* Bytes 22-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} Common;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size;				/* Bytes 4-7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		struct myrs_pdev pdev;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		unsigned char cdb_len;			/* Byte 21 */
+		unsigned char cdb[10];			/* Bytes 22-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} SCSI_10;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size;				/* Bytes 4-7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		struct myrs_pdev pdev;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		unsigned char cdb_len;			/* Byte 21 */
+		unsigned short rsvd:16;			/* Bytes 22-23 */
+		u64 cdb_addr;				/* Bytes 24-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} SCSI_255;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		unsigned short rsvd1:16;		/* Bytes 16-17 */
+		unsigned char ctlr_num;			/* Byte 18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		unsigned char rsvd2[10];		/* Bytes 22-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} ControllerInfo;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		struct myrs_ldev ldev;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		unsigned char rsvd[10];			/* Bytes 22-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} LogicalDeviceInfo;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		struct myrs_pdev pdev;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		unsigned char rsvd[10];			/* Bytes 22-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} PhysicalDeviceInfo;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		unsigned short evnum_upper;		/* Bytes 16-17 */
+		unsigned char ctlr_num;			/* Byte 18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		unsigned short evnum_lower;		/* Bytes 22-23 */
+		unsigned char rsvd[8];			/* Bytes 24-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} GetEvent;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		union {
+			struct myrs_ldev ldev;		/* Bytes 16-18 */
+			struct myrs_pdev pdev;		/* Bytes 16-18 */
+		};
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		enum myrs_devstate state;		/* Byte 22 */
+		unsigned char rsvd[9];			/* Bytes 23-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} SetDeviceState;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		struct myrs_ldev ldev;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		bool RestoreConsistency:1;		/* Byte 22 Bit 0 */
+		bool InitializedAreaOnly:1;		/* Byte 22 Bit 1 */
+		unsigned char rsvd1:6;			/* Byte 22 Bits 2-7 */
+		unsigned char rsvd2[9];			/* Bytes 23-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} ConsistencyCheck;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		unsigned char first_cmd_mbox_size_kb;	/* Byte 4 */
+		unsigned char first_stat_mbox_size_kb;		/* Byte 5 */
+		unsigned char second_cmd_mbox_size_kb;	/* Byte 6 */
+		unsigned char second_stat_mbox_size_kb;	/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		unsigned int rsvd1:24;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		unsigned char fwstat_buf_size_kb;	/* Byte 22 */
+		unsigned char rsvd2:8;			/* Byte 23 */
+		u64 fwstat_buf_addr;	/* Bytes 24-31 */
+		u64 first_cmd_mbox_addr;	/* Bytes 32-39 */
+		u64 first_stat_mbox_addr;	/* Bytes 40-47 */
+		u64 second_cmd_mbox_addr;	/* Bytes 48-55 */
+		u64 second_stat_mbox_addr;	/* Bytes 56-63 */
+	} SetMemoryMailbox;
+	struct {
+		unsigned short id;			/* Bytes 0-1 */
+		enum myrs_cmd_opcode opcode;		/* Byte 2 */
+		struct myrs_cmd_ctrl control;		/* Byte 3 */
+		u32 dma_size:24;			/* Bytes 4-6 */
+		unsigned char dma_num;			/* Byte 7 */
+		u64 sense_addr;				/* Bytes 8-15 */
+		struct myrs_pdev pdev;			/* Bytes 16-18 */
+		struct myrs_cmd_tmo tmo;		/* Byte 19 */
+		unsigned char sense_len;		/* Byte 20 */
+		enum myrs_ioctl_opcode ioctl_opcode;	/* Byte 21 */
+		enum myrs_opdev opdev;			/* Byte 22 */
+		unsigned char rsvd[9];			/* Bytes 23-31 */
+		union myrs_sgl dma_addr;		/* Bytes 32-63 */
+	} DeviceOperation;
+};
+
+/*
+ * DAC960 V2 Firmware Controller Status Mailbox structure.
+ */
+struct myrs_stat_mbox {
+	unsigned short id;		/* Bytes 0-1 */
+	unsigned char status;		/* Byte 2 */
+	unsigned char sense_len;	/* Byte 3 */
+	int residual;			/* Bytes 4-7 */
+};
+
+struct myrs_cmdblk { 
+	union myrs_cmd_mbox mbox;
+	unsigned char status;
+	unsigned char sense_len;
+	int residual;
+	struct completion *complete;
+	struct myrs_sge *sgl;
+	dma_addr_t sgl_addr;
+	unsigned char *DCDB;
+	dma_addr_t DCDB_dma;
+	unsigned char *sense;
+	dma_addr_t sense_addr;
+};
+
+/*
+ * DAC960 Driver Controller structure.
+ */
+struct myrs_hba {
+	void __iomem *io_base;
+	void __iomem *mmio_base;
+	phys_addr_t io_addr;
+	phys_addr_t pci_addr;
+	unsigned int irq;
+
+	unsigned char model_name[28];
+	unsigned char fw_version[12];
+
+	struct Scsi_Host *host;
+	struct pci_dev *pdev;
+
+	unsigned int epoch;
+	unsigned int next_evseq;
+	/* Monitor flags */
+	bool needs_update;
+	bool disable_enc_msg;
+
+	struct workqueue_struct *work_q;
+	char work_q_name[20];
+	struct delayed_work monitor_work;
+	unsigned long primary_monitor_time;
+	unsigned long secondary_monitor_time;
+
+	spinlock_t queue_lock;
+
+	struct dma_pool *sg_pool;
+	struct dma_pool *sense_pool;
+	struct dma_pool *dcdb_pool;
+
+	void (*write_cmd_mbox)(union myrs_cmd_mbox *, union myrs_cmd_mbox *);
+	void (*get_cmd_mbox)(void __iomem *);
+	void (*disable_intr)(void __iomem *);
+	void (*reset)(void __iomem *);
+
+	dma_addr_t cmd_mbox_addr;
+	size_t cmd_mbox_size;
+	union myrs_cmd_mbox *first_cmd_mbox;
+	union myrs_cmd_mbox *last_cmd_mbox;
+	union myrs_cmd_mbox *next_cmd_mbox;
+	union myrs_cmd_mbox *prev_cmd_mbox1;
+	union myrs_cmd_mbox *prev_cmd_mbox2;
+
+	dma_addr_t stat_mbox_addr;
+	size_t stat_mbox_size;
+	struct myrs_stat_mbox *first_stat_mbox;
+	struct myrs_stat_mbox *last_stat_mbox;
+	struct myrs_stat_mbox *next_stat_mbox;
+
+	struct myrs_cmdblk dcmd_blk;
+	struct myrs_cmdblk mcmd_blk;
+	struct mutex dcmd_mutex;
+
+	struct myrs_fwstat *fwstat_buf;
+	dma_addr_t fwstat_addr;
+
+	struct myrs_ctlr_info *ctlr_info;
+	struct mutex cinfo_mutex;
+
+	struct myrs_event *event_buf;
+};
+
+typedef unsigned char (*enable_mbox_t)(void __iomem *base, dma_addr_t addr);
+typedef int (*myrs_hwinit_t)(struct pci_dev *pdev,
+			     struct myrs_hba *c, void __iomem *base);
+
+struct myrs_privdata {
+	myrs_hwinit_t		hw_init;
+	irq_handler_t		irq_handler;
+	unsigned int		io_mem_size;
+};
+
+/*
+ * DAC960 GEM Series Controller Interface Register Offsets.
+ */
+
+#define DAC960_GEM_RegisterWindowSize	0x600
+
+enum DAC960_GEM_RegisterOffsets {
+	DAC960_GEM_InboundDoorBellRegisterReadSetOffset = 0x214,
+	DAC960_GEM_InboundDoorBellRegisterClearOffset =	0x218,
+	DAC960_GEM_OutboundDoorBellRegisterReadSetOffset = 0x224,
+	DAC960_GEM_OutboundDoorBellRegisterClearOffset = 0x228,
+	DAC960_GEM_InterruptStatusRegisterOffset =	0x208,
+	DAC960_GEM_InterruptMaskRegisterReadSetOffset =	0x22C,
+	DAC960_GEM_InterruptMaskRegisterClearOffset =	0x230,
+	DAC960_GEM_CommandMailboxBusAddressOffset =	0x510,
+	DAC960_GEM_CommandStatusOffset =		0x518,
+	DAC960_GEM_ErrorStatusRegisterReadSetOffset =	0x224,
+	DAC960_GEM_ErrorStatusRegisterClearOffset =	0x228,
+};
+
+/*
+ * DAC960 GEM Series Inbound Door Bell Register.
+ */
+#define DAC960_GEM_IDB_HWMBOX_NEW_CMD	0x01
+#define DAC960_GEM_IDB_HWMBOX_ACK_STS	0x02
+#define DAC960_GEM_IDB_GEN_IRQ		0x04
+#define DAC960_GEM_IDB_CTRL_RESET	0x08
+#define DAC960_GEM_IDB_MMBOX_NEW_CMD	0x10
+
+#define DAC960_GEM_IDB_HWMBOX_FULL	0x01
+#define DAC960_GEM_IDB_INIT_IN_PROGRESS	0x02
+
+/*
+ * DAC960 GEM Series Outbound Door Bell Register.
+ */
+#define DAC960_GEM_ODB_HWMBOX_ACK_IRQ 0x01
+#define DAC960_GEM_ODB_MMBOX_ACK_IRQ 0x02
+#define DAC960_GEM_ODB_HWMBOX_STS_AVAIL 0x01
+#define DAC960_GEM_ODB_MMBOX_STS_AVAIL 0x02
+
+/*
+ * DAC960 GEM Series Interrupt Mask Register.
+ */
+#define DAC960_GEM_IRQMASK_HWMBOX_IRQ 0x01
+#define DAC960_GEM_IRQMASK_MMBOX_IRQ 0x02
+
+/*
+ * DAC960 GEM Series Error Status Register.
+ */
+#define DAC960_GEM_ERRSTS_PENDING 0x20
+
+/*
+ * dma_addr_writeql is provided to write dma_addr_t types
+ * to a 64-bit pci address space register.  The controller
+ * will accept having the register written as two 32-bit
+ * values.
+ *
+ * In HIGHMEM kernels, dma_addr_t is a 64-bit value.
+ * without HIGHMEM,  dma_addr_t is a 32-bit value.
+ *
+ * The compiler should always fix up the assignment
+ * to u.wq appropriately, depending upon the size of
+ * dma_addr_t.
+ */
+static inline
+void dma_addr_writeql(dma_addr_t addr, void __iomem *write_address)
+{
+	union {
+		u64 wq;
+		uint wl[2];
+	} u;
+
+	u.wq = addr;
+
+	writel(u.wl[0], write_address);
+	writel(u.wl[1], write_address + 4);
+}
+
+/*
+ * DAC960 BA Series Controller Interface Register Offsets.
+ */
+
+#define DAC960_BA_RegisterWindowSize		0x80
+
+enum DAC960_BA_RegisterOffsets
+{
+	DAC960_BA_InterruptStatusRegisterOffset =	0x30,
+	DAC960_BA_InterruptMaskRegisterOffset =		0x34,
+	DAC960_BA_CommandMailboxBusAddressOffset =	0x50,
+	DAC960_BA_CommandStatusOffset =			0x58,
+	DAC960_BA_InboundDoorBellRegisterOffset =	0x60,
+	DAC960_BA_OutboundDoorBellRegisterOffset =	0x61,
+	DAC960_BA_ErrorStatusRegisterOffset =		0x63
+};
+
+/*
+ * DAC960 BA Series Inbound Door Bell Register.
+ */
+#define DAC960_BA_IDB_HWMBOX_NEW_CMD 0x01
+#define DAC960_BA_IDB_HWMBOX_ACK_STS 0x02
+#define DAC960_BA_IDB_GEN_IRQ 0x04
+#define DAC960_BA_IDB_CTRL_RESET 0x08
+#define DAC960_BA_IDB_MMBOX_NEW_CMD 0x10
+
+#define DAC960_BA_IDB_HWMBOX_EMPTY 0x01
+#define DAC960_BA_IDB_INIT_DONE 0x02
+
+/*
+ * DAC960 BA Series Outbound Door Bell Register.
+ */
+#define DAC960_BA_ODB_HWMBOX_ACK_IRQ 0x01
+#define DAC960_BA_ODB_MMBOX_ACK_IRQ 0x02
+
+#define DAC960_BA_ODB_HWMBOX_STS_AVAIL 0x01
+#define DAC960_BA_ODB_MMBOX_STS_AVAIL 0x02
+
+/*
+ * DAC960 BA Series Interrupt Mask Register.
+ */
+#define DAC960_BA_IRQMASK_DISABLE_IRQ 0x04
+#define DAC960_BA_IRQMASK_DISABLEW_I2O 0x08
+
+/*
+ * DAC960 BA Series Error Status Register.
+ */
+#define DAC960_BA_ERRSTS_PENDING 0x04
+
+/*
+ * DAC960 LP Series Controller Interface Register Offsets.
+ */
+
+#define DAC960_LP_RegisterWindowSize		0x80
+
+enum DAC960_LP_RegisterOffsets {
+	DAC960_LP_CommandMailboxBusAddressOffset =	0x10,
+	DAC960_LP_CommandStatusOffset =			0x18,
+	DAC960_LP_InboundDoorBellRegisterOffset =	0x20,
+	DAC960_LP_OutboundDoorBellRegisterOffset =	0x2C,
+	DAC960_LP_ErrorStatusRegisterOffset =		0x2E,
+	DAC960_LP_InterruptStatusRegisterOffset =	0x30,
+	DAC960_LP_InterruptMaskRegisterOffset =		0x34,
+};
+
+/*
+ * DAC960 LP Series Inbound Door Bell Register.
+ */
+#define DAC960_LP_IDB_HWMBOX_NEW_CMD 0x01
+#define DAC960_LP_IDB_HWMBOX_ACK_STS 0x02
+#define DAC960_LP_IDB_GEN_IRQ 0x04
+#define DAC960_LP_IDB_CTRL_RESET 0x08
+#define DAC960_LP_IDB_MMBOX_NEW_CMD 0x10
+
+#define DAC960_LP_IDB_HWMBOX_FULL 0x01
+#define DAC960_LP_IDB_INIT_IN_PROGRESS 0x02
+
+/*
+ * DAC960 LP Series Outbound Door Bell Register.
+ */
+#define DAC960_LP_ODB_HWMBOX_ACK_IRQ 0x01
+#define DAC960_LP_ODB_MMBOX_ACK_IRQ 0x02
+
+#define DAC960_LP_ODB_HWMBOX_STS_AVAIL 0x01
+#define DAC960_LP_ODB_MMBOX_STS_AVAIL 0x02
+
+/*
+ * DAC960 LP Series Interrupt Mask Register.
+ */
+#define DAC960_LP_IRQMASK_DISABLE_IRQ 0x04
+
+/*
+ * DAC960 LP Series Error Status Register.
+ */
+#define DAC960_LP_ERRSTS_PENDING 0x04
+
+#endif /* _MYRS_H */
-- 
2.16.4
