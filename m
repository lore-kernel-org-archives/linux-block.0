Return-Path: <hch@lst.de>
Date: Wed, 17 Oct 2018 09:28:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/3] myrs: Add Mylex RAID controller (SCSI interface)
Message-ID: <20181017072841.GG23407@lst.de>
References: <20181012071548.129113-1-hare@suse.de> <20181012071548.129113-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181012071548.129113-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Oct 12, 2018 at 09:15:47AM +0200, Hannes Reinecke wrote:
> This patch adds support for the Mylex DAC960 RAID controller,
> supporting the newer, SCSI-based interface.
> The driver is a re-implementation of the original DAC960 driver.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> ---
>  MAINTAINERS           |    1 +
>  drivers/scsi/Kconfig  |   15 +
>  drivers/scsi/Makefile |    1 +
>  drivers/scsi/myrs.c   | 3267 +++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/scsi/myrs.h   | 1134 +++++++++++++++++
>  5 files changed, 4418 insertions(+)
>  create mode 100644 drivers/scsi/myrs.c
>  create mode 100644 drivers/scsi/myrs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6dde2ff49b3..adc23290c28d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9897,6 +9897,7 @@ M:	Hannes Reinecke <hare@kernel.org>
>  L:	linux-scsi@vger.kernel.org
>  S:	Supported
>  F:	drivers/scsi/myrb.*
> +F:	drivers/scsi/myrs.*
>  
>  MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
>  M:	Chris Lee <christopher.lee@cspi.com>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index f2a71bb74f48..c1d3d0d45ced 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -572,6 +572,21 @@ config SCSI_MYRB
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called myrb.
>  
> +config SCSI_MYRS
> +	tristate "Mylex DAC960/DAC1100 PCI RAID Controller (SCSI Interface)"
> +	depends on PCI
> +	select RAID_ATTRS
> +	help
> +	  This driver adds support for the Mylex DAC960, AcceleRAID, and
> +	  eXtremeRAID PCI RAID controllers.  This driver supports the
> +	  newer, SCSI-based interface only.
> +	  This driver is a reimplementation of the original DAC960
> +	  driver. If you have used the DAC960 driver you should enable
> +	  this module.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called myrs.
> +
>  config VMWARE_PVSCSI
>  	tristate "VMware PVSCSI driver support"
>  	depends on PCI && SCSI && X86
> diff --git a/drivers/scsi/Makefile b/drivers/scsi/Makefile
> index cfd58ffc0b61..fcb41ae329c4 100644
> --- a/drivers/scsi/Makefile
> +++ b/drivers/scsi/Makefile
> @@ -107,6 +107,7 @@ obj-$(CONFIG_SCSI_QLOGICPTI)	+= qlogicpti.o
>  obj-$(CONFIG_SCSI_MESH)		+= mesh.o
>  obj-$(CONFIG_SCSI_MAC53C94)	+= mac53c94.o
>  obj-$(CONFIG_SCSI_MYRB)		+= myrb.o
> +obj-$(CONFIG_SCSI_MYRS)		+= myrs.o
>  obj-$(CONFIG_BLK_DEV_3W_XXXX_RAID) += 3w-xxxx.o
>  obj-$(CONFIG_SCSI_3W_9XXX)	+= 3w-9xxx.o
>  obj-$(CONFIG_SCSI_3W_SAS)	+= 3w-sas.o
> diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
> new file mode 100644
> index 000000000000..8cf0a5924290
> --- /dev/null
> +++ b/drivers/scsi/myrs.c
> @@ -0,0 +1,3267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Driver for Mylex DAC960/AcceleRAID/eXtremeRAID PCI RAID Controllers
> + *
> + * This driver supports the newer, SCSI-based firmware interface only.
> + *
> + * Copyright 2017 Hannes Reinecke, SUSE Linux GmbH <hare@suse.com>
> + *
> + * Based on the original DAC960 driver, which has
> + * Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
> + * Portions Copyright 2002 by Mylex (An IBM Business Unit)
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/pci.h>
> +#include <linux/raid_class.h>
> +#include <asm/unaligned.h>
> +#include <scsi/scsi.h>
> +#include <scsi/scsi_host.h>
> +#include <scsi/scsi_device.h>
> +#include <scsi/scsi_cmnd.h>
> +#include <scsi/scsi_tcq.h>
> +#include "myrs.h"
> +
> +static struct raid_template *myrs_raid_template;
> +
> +static struct myrs_devstate_name_entry {
> +	enum myrs_devstate state;
> +	char *name;
> +} myrs_devstate_name_list[] = {
> +	{ MYRS_DEVICE_UNCONFIGURED, "Unconfigured" },
> +	{ MYRS_DEVICE_ONLINE, "Online" },
> +	{ MYRS_DEVICE_REBUILD, "Rebuild" },
> +	{ MYRS_DEVICE_MISSING, "Missing" },
> +	{ MYRS_DEVICE_SUSPECTED_CRITICAL, "SuspectedCritical" },
> +	{ MYRS_DEVICE_OFFLINE, "Offline" },
> +	{ MYRS_DEVICE_CRITICAL, "Critical" },
> +	{ MYRS_DEVICE_SUSPECTED_DEAD, "SuspectedDead" },
> +	{ MYRS_DEVICE_COMMANDED_OFFLINE, "CommandedOffline" },
> +	{ MYRS_DEVICE_STANDBY, "Standby" },
> +	{ MYRS_DEVICE_INVALID_STATE, "Invalid" },
> +};
> +
> +static char *myrs_devstate_name(enum myrs_devstate state)
> +{
> +	struct myrs_devstate_name_entry *entry = myrs_devstate_name_list;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(myrs_devstate_name_list); i++) {
> +		if (entry[i].state == state)
> +			return entry[i].name;
> +	}
> +	return NULL;
> +}
> +
> +static struct myrs_raid_level_name_entry {
> +	enum myrs_raid_level level;
> +	char *name;
> +} myrs_raid_level_name_list[] = {
> +	{ MYRS_RAID_LEVEL0, "RAID0" },
> +	{ MYRS_RAID_LEVEL1, "RAID1" },
> +	{ MYRS_RAID_LEVEL3, "RAID3 right asymmetric parity" },
> +	{ MYRS_RAID_LEVEL5, "RAID5 right asymmetric parity" },
> +	{ MYRS_RAID_LEVEL6, "RAID6" },
> +	{ MYRS_RAID_JBOD, "JBOD" },
> +	{ MYRS_RAID_NEWSPAN, "New Mylex SPAN" },
> +	{ MYRS_RAID_LEVEL3F, "RAID3 fixed parity" },
> +	{ MYRS_RAID_LEVEL3L, "RAID3 left symmetric parity" },
> +	{ MYRS_RAID_SPAN, "Mylex SPAN" },
> +	{ MYRS_RAID_LEVEL5L, "RAID5 left symmetric parity" },
> +	{ MYRS_RAID_LEVELE, "RAIDE (concatenation)" },
> +	{ MYRS_RAID_PHYSICAL, "Physical device" },
> +};
> +
> +static char *myrs_raid_level_name(enum myrs_raid_level level)
> +{
> +	struct myrs_raid_level_name_entry *entry = myrs_raid_level_name_list;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(myrs_raid_level_name_list); i++) {
> +		if (entry[i].level == level)
> +			return entry[i].name;
> +	}
> +	return NULL;
> +}
> +
> +/**
> + * myrs_reset_cmd - clears critical fields in struct myrs_cmdblk
> + */
> +static inline void myrs_reset_cmd(struct myrs_cmdblk *cmd_blk)
> +{
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +
> +	memset(mbox, 0, sizeof(union myrs_cmd_mbox));
> +	cmd_blk->status = 0;
> +}
> +
> +/**
> + * myrs_qcmd - queues Command for DAC960 V2 Series Controllers.
> + */
> +static void myrs_qcmd(struct myrs_hba *cs, struct myrs_cmdblk *cmd_blk)
> +{
> +	void __iomem *base = cs->io_base;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	union myrs_cmd_mbox *next_mbox = cs->next_cmd_mbox;
> +
> +	cs->write_cmd_mbox(next_mbox, mbox);
> +
> +	if (cs->prev_cmd_mbox1->words[0] == 0 ||
> +	    cs->prev_cmd_mbox2->words[0] == 0)
> +		cs->get_cmd_mbox(base);
> +
> +	cs->prev_cmd_mbox2 = cs->prev_cmd_mbox1;
> +	cs->prev_cmd_mbox1 = next_mbox;
> +
> +	if (++next_mbox > cs->last_cmd_mbox)
> +		next_mbox = cs->first_cmd_mbox;
> +
> +	cs->next_cmd_mbox = next_mbox;
> +}
> +
> +/**
> + * myrs_exec_cmd - executes V2 Command and waits for completion.
> + */
> +static void myrs_exec_cmd(struct myrs_hba *cs,
> +		struct myrs_cmdblk *cmd_blk)
> +{
> +	DECLARE_COMPLETION_ONSTACK(complete);
> +	unsigned long flags;
> +
> +	cmd_blk->complete = &complete;
> +	spin_lock_irqsave(&cs->queue_lock, flags);
> +	myrs_qcmd(cs, cmd_blk);
> +	spin_unlock_irqrestore(&cs->queue_lock, flags);
> +
> +	WARN_ON(in_interrupt());
> +	wait_for_completion(&complete);
> +}
> +
> +/**
> + * myrs_report_progress - prints progress message
> + */
> +static void myrs_report_progress(struct myrs_hba *cs, unsigned short ldev_num,
> +		unsigned char *msg, unsigned long blocks,
> +		unsigned long size)
> +{
> +	shost_printk(KERN_INFO, cs->host,
> +		     "Logical Drive %d: %s in Progress: %d%% completed\n",
> +		     ldev_num, msg,
> +		     (100 * (int)(blocks >> 7)) / (int)(size >> 7));
> +}
> +
> +/**
> + * myrs_get_ctlr_info - executes a Controller Information IOCTL Command
> + */
> +static unsigned char myrs_get_ctlr_info(struct myrs_hba *cs)
> +{
> +	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	dma_addr_t ctlr_info_addr;
> +	union myrs_sgl *sgl;
> +	unsigned char status;
> +	struct myrs_ctlr_info old;
> +
> +	memcpy(&old, cs->ctlr_info, sizeof(struct myrs_ctlr_info));
> +	ctlr_info_addr = dma_map_single(&cs->pdev->dev, cs->ctlr_info,
> +					sizeof(struct myrs_ctlr_info),
> +					DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&cs->pdev->dev, ctlr_info_addr))
> +		return MYRS_STATUS_FAILED;
> +
> +	mutex_lock(&cs->dcmd_mutex);
> +	myrs_reset_cmd(cmd_blk);
> +	mbox->ctlr_info.id = MYRS_DCMD_TAG;
> +	mbox->ctlr_info.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->ctlr_info.control.dma_ctrl_to_host = true;
> +	mbox->ctlr_info.control.no_autosense = true;
> +	mbox->ctlr_info.dma_size = sizeof(struct myrs_ctlr_info);
> +	mbox->ctlr_info.ctlr_num = 0;
> +	mbox->ctlr_info.ioctl_opcode = MYRS_IOCTL_GET_CTLR_INFO;
> +	sgl = &mbox->ctlr_info.dma_addr;
> +	sgl->sge[0].sge_addr = ctlr_info_addr;
> +	sgl->sge[0].sge_count = mbox->ctlr_info.dma_size;
> +	dev_dbg(&cs->host->shost_gendev, "Sending GetControllerInfo\n");
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +	mutex_unlock(&cs->dcmd_mutex);
> +	dma_unmap_single(&cs->pdev->dev, ctlr_info_addr,
> +			 sizeof(struct myrs_ctlr_info), DMA_FROM_DEVICE);
> +	if (status == MYRS_STATUS_SUCCESS) {
> +		if (cs->ctlr_info->bg_init_active +
> +		    cs->ctlr_info->ldev_init_active +
> +		    cs->ctlr_info->pdev_init_active +
> +		    cs->ctlr_info->cc_active +
> +		    cs->ctlr_info->rbld_active +
> +		    cs->ctlr_info->exp_active != 0)
> +			cs->needs_update = true;
> +		if (cs->ctlr_info->ldev_present != old.ldev_present ||
> +		    cs->ctlr_info->ldev_critical != old.ldev_critical ||
> +		    cs->ctlr_info->ldev_offline != old.ldev_offline)
> +			shost_printk(KERN_INFO, cs->host,
> +				     "Logical drive count changes (%d/%d/%d)\n",
> +				     cs->ctlr_info->ldev_critical,
> +				     cs->ctlr_info->ldev_offline,
> +				     cs->ctlr_info->ldev_present);
> +	}
> +
> +	return status;
> +}
> +
> +/**
> + * myrs_get_ldev_info - executes a Logical Device Information IOCTL Command
> + */
> +static unsigned char myrs_get_ldev_info(struct myrs_hba *cs,
> +		unsigned short ldev_num, struct myrs_ldev_info *ldev_info)
> +{
> +	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	dma_addr_t ldev_info_addr;
> +	struct myrs_ldev_info ldev_info_orig;
> +	union myrs_sgl *sgl;
> +	unsigned char status;
> +
> +	memcpy(&ldev_info_orig, ldev_info, sizeof(struct myrs_ldev_info));
> +	ldev_info_addr = dma_map_single(&cs->pdev->dev, ldev_info,
> +					sizeof(struct myrs_ldev_info),
> +					DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&cs->pdev->dev, ldev_info_addr))
> +		return MYRS_STATUS_FAILED;
> +
> +	mutex_lock(&cs->dcmd_mutex);
> +	myrs_reset_cmd(cmd_blk);
> +	mbox->ldev_info.id = MYRS_DCMD_TAG;
> +	mbox->ldev_info.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->ldev_info.control.dma_ctrl_to_host = true;
> +	mbox->ldev_info.control.no_autosense = true;
> +	mbox->ldev_info.dma_size = sizeof(struct myrs_ldev_info);
> +	mbox->ldev_info.ldev.ldev_num = ldev_num;
> +	mbox->ldev_info.ioctl_opcode = MYRS_IOCTL_GET_LDEV_INFO_VALID;
> +	sgl = &mbox->ldev_info.dma_addr;
> +	sgl->sge[0].sge_addr = ldev_info_addr;
> +	sgl->sge[0].sge_count = mbox->ldev_info.dma_size;
> +	dev_dbg(&cs->host->shost_gendev,
> +		"Sending GetLogicalDeviceInfoValid for ldev %d\n", ldev_num);
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +	mutex_unlock(&cs->dcmd_mutex);
> +	dma_unmap_single(&cs->pdev->dev, ldev_info_addr,
> +			 sizeof(struct myrs_ldev_info), DMA_FROM_DEVICE);
> +	if (status == MYRS_STATUS_SUCCESS) {
> +		unsigned short ldev_num = ldev_info->ldev_num;
> +		struct myrs_ldev_info *new = ldev_info;
> +		struct myrs_ldev_info *old = &ldev_info_orig;
> +		unsigned long ldev_size = new->cfg_devsize;
> +
> +		if (new->dev_state != old->dev_state) {
> +			const char *name;
> +
> +			name = myrs_devstate_name(new->dev_state);
> +			shost_printk(KERN_INFO, cs->host,
> +				     "Logical Drive %d is now %s\n",
> +				     ldev_num, name ? name : "Invalid");
> +		}
> +		if ((new->soft_errs != old->soft_errs) ||
> +		    (new->cmds_failed != old->cmds_failed) ||
> +		    (new->deferred_write_errs != old->deferred_write_errs))
> +			shost_printk(KERN_INFO, cs->host,
> +				     "Logical Drive %d Errors: Soft = %d, Failed = %d, Deferred Write = %d\n",
> +				     ldev_num, new->soft_errs,
> +				     new->cmds_failed,
> +				     new->deferred_write_errs);
> +		if (new->bg_init_active)
> +			myrs_report_progress(cs, ldev_num,
> +					     "Background Initialization",
> +					     new->bg_init_lba, ldev_size);
> +		else if (new->fg_init_active)
> +			myrs_report_progress(cs, ldev_num,
> +					     "Foreground Initialization",
> +					     new->fg_init_lba, ldev_size);
> +		else if (new->migration_active)
> +			myrs_report_progress(cs, ldev_num,
> +					     "Data Migration",
> +					     new->migration_lba, ldev_size);
> +		else if (new->patrol_active)
> +			myrs_report_progress(cs, ldev_num,
> +					     "Patrol Operation",
> +					     new->patrol_lba, ldev_size);
> +		if (old->bg_init_active && !new->bg_init_active)
> +			shost_printk(KERN_INFO, cs->host,
> +				     "Logical Drive %d: Background Initialization %s\n",
> +				     ldev_num,
> +				     (new->ldev_control.ldev_init_done ?
> +				      "Completed" : "Failed"));
> +	}
> +	return status;
> +}
> +
> +/**
> + * myrs_get_pdev_info - executes a "Read Physical Device Information" Command
> + */
> +static unsigned char myrs_get_pdev_info(struct myrs_hba *cs,
> +		unsigned char channel, unsigned char target, unsigned char lun,
> +		struct myrs_pdev_info *pdev_info)
> +{
> +	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	dma_addr_t pdev_info_addr;
> +	union myrs_sgl *sgl;
> +	unsigned char status;
> +
> +	pdev_info_addr = dma_map_single(&cs->pdev->dev, pdev_info,
> +					sizeof(struct myrs_pdev_info),
> +					DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&cs->pdev->dev, pdev_info_addr))
> +		return MYRS_STATUS_FAILED;
> +
> +	mutex_lock(&cs->dcmd_mutex);
> +	myrs_reset_cmd(cmd_blk);
> +	mbox->pdev_info.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->pdev_info.id = MYRS_DCMD_TAG;
> +	mbox->pdev_info.control.dma_ctrl_to_host = true;
> +	mbox->pdev_info.control.no_autosense = true;
> +	mbox->pdev_info.dma_size = sizeof(struct myrs_pdev_info);
> +	mbox->pdev_info.pdev.lun = lun;
> +	mbox->pdev_info.pdev.target = target;
> +	mbox->pdev_info.pdev.channel = channel;
> +	mbox->pdev_info.ioctl_opcode = MYRS_IOCTL_GET_PDEV_INFO_VALID;
> +	sgl = &mbox->pdev_info.dma_addr;
> +	sgl->sge[0].sge_addr = pdev_info_addr;
> +	sgl->sge[0].sge_count = mbox->pdev_info.dma_size;
> +	dev_dbg(&cs->host->shost_gendev,
> +		"Sending GetPhysicalDeviceInfoValid for pdev %d:%d:%d\n",
> +		channel, target, lun);
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +	mutex_unlock(&cs->dcmd_mutex);
> +	dma_unmap_single(&cs->pdev->dev, pdev_info_addr,
> +			 sizeof(struct myrs_pdev_info), DMA_FROM_DEVICE);
> +	return status;
> +}
> +
> +/**
> + * myrs_dev_op - executes a "Device Operation" Command
> + */
> +static unsigned char myrs_dev_op(struct myrs_hba *cs,
> +		enum myrs_ioctl_opcode opcode, enum myrs_opdev opdev)
> +{
> +	struct myrs_cmdblk *cmd_blk = &cs->dcmd_blk;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	unsigned char status;
> +
> +	mutex_lock(&cs->dcmd_mutex);
> +	myrs_reset_cmd(cmd_blk);
> +	mbox->dev_op.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->dev_op.id = MYRS_DCMD_TAG;
> +	mbox->dev_op.control.dma_ctrl_to_host = true;
> +	mbox->dev_op.control.no_autosense = true;
> +	mbox->dev_op.ioctl_opcode = opcode;
> +	mbox->dev_op.opdev = opdev;
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +	mutex_unlock(&cs->dcmd_mutex);
> +	return status;
> +}
> +
> +/**
> + * myrs_translate_pdev - translates a Physical Device Channel and
> + * TargetID into a Logical Device.
> + */
> +static unsigned char myrs_translate_pdev(struct myrs_hba *cs,
> +		unsigned char channel, unsigned char target, unsigned char lun,
> +		struct myrs_devmap *devmap)
> +{
> +	struct pci_dev *pdev = cs->pdev;
> +	dma_addr_t devmap_addr;
> +	struct myrs_cmdblk *cmd_blk;
> +	union myrs_cmd_mbox *mbox;
> +	union myrs_sgl *sgl;
> +	unsigned char status;
> +
> +	memset(devmap, 0x0, sizeof(struct myrs_devmap));
> +	devmap_addr = dma_map_single(&pdev->dev, devmap,
> +				     sizeof(struct myrs_devmap),
> +				     DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&pdev->dev, devmap_addr))
> +		return MYRS_STATUS_FAILED;
> +
> +	mutex_lock(&cs->dcmd_mutex);
> +	cmd_blk = &cs->dcmd_blk;
> +	mbox = &cmd_blk->mbox;
> +	mbox->pdev_info.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->pdev_info.control.dma_ctrl_to_host = true;
> +	mbox->pdev_info.control.no_autosense = true;
> +	mbox->pdev_info.dma_size = sizeof(struct myrs_devmap);
> +	mbox->pdev_info.pdev.target = target;
> +	mbox->pdev_info.pdev.channel = channel;
> +	mbox->pdev_info.pdev.lun = lun;
> +	mbox->pdev_info.ioctl_opcode = MYRS_IOCTL_XLATE_PDEV_TO_LDEV;
> +	sgl = &mbox->pdev_info.dma_addr;
> +	sgl->sge[0].sge_addr = devmap_addr;
> +	sgl->sge[0].sge_count = mbox->pdev_info.dma_size;
> +
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +	mutex_unlock(&cs->dcmd_mutex);
> +	dma_unmap_single(&pdev->dev, devmap_addr,
> +			 sizeof(struct myrs_devmap), DMA_FROM_DEVICE);
> +	return status;
> +}
> +
> +/**
> + * myrs_get_event - executes a Get Event Command
> + */
> +static unsigned char myrs_get_event(struct myrs_hba *cs,
> +		unsigned int event_num, struct myrs_event *event_buf)
> +{
> +	struct pci_dev *pdev = cs->pdev;
> +	dma_addr_t event_addr;
> +	struct myrs_cmdblk *cmd_blk = &cs->mcmd_blk;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	union myrs_sgl *sgl;
> +	unsigned char status;
> +
> +	event_addr = dma_map_single(&pdev->dev, event_buf,
> +				    sizeof(struct myrs_event), DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&pdev->dev, event_addr))
> +		return MYRS_STATUS_FAILED;
> +
> +	mbox->get_event.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->get_event.dma_size = sizeof(struct myrs_event);
> +	mbox->get_event.evnum_upper = event_num >> 16;
> +	mbox->get_event.ctlr_num = 0;
> +	mbox->get_event.ioctl_opcode = MYRS_IOCTL_GET_EVENT;
> +	mbox->get_event.evnum_lower = event_num & 0xFFFF;
> +	sgl = &mbox->get_event.dma_addr;
> +	sgl->sge[0].sge_addr = event_addr;
> +	sgl->sge[0].sge_count = mbox->get_event.dma_size;
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +	dma_unmap_single(&pdev->dev, event_addr,
> +			 sizeof(struct myrs_event), DMA_FROM_DEVICE);
> +
> +	return status;
> +}
> +
> +/*
> + * myrs_get_fwstatus - executes a Get Health Status Command
> + */
> +static unsigned char myrs_get_fwstatus(struct myrs_hba *cs)
> +{
> +	struct myrs_cmdblk *cmd_blk = &cs->mcmd_blk;
> +	union myrs_cmd_mbox *mbox = &cmd_blk->mbox;
> +	union myrs_sgl *sgl;
> +	unsigned char status = cmd_blk->status;
> +
> +	myrs_reset_cmd(cmd_blk);
> +	mbox->common.opcode = MYRS_CMD_OP_IOCTL;
> +	mbox->common.id = MYRS_MCMD_TAG;
> +	mbox->common.control.dma_ctrl_to_host = true;
> +	mbox->common.control.no_autosense = true;
> +	mbox->common.dma_size = sizeof(struct myrs_fwstat);
> +	mbox->common.ioctl_opcode = MYRS_IOCTL_GET_HEALTH_STATUS;
> +	sgl = &mbox->common.dma_addr;
> +	sgl->sge[0].sge_addr = cs->fwstat_addr;
> +	sgl->sge[0].sge_count = mbox->ctlr_info.dma_size;
> +	dev_dbg(&cs->host->shost_gendev, "Sending GetHealthStatus\n");
> +	myrs_exec_cmd(cs, cmd_blk);
> +	status = cmd_blk->status;
> +
> +	return status;
> +}
> +
> +/**
> + * myrs_enable_mmio_mbox - enables the Memory Mailbox Interface
> + */
> +static bool myrs_enable_mmio_mbox(struct myrs_hba *cs,
> +		enable_mbox_t enable_mbox_fn)
> +{
> +	void __iomem *base = cs->io_base;
> +	struct pci_dev *pdev = cs->pdev;
> +	union myrs_cmd_mbox *cmd_mbox;
> +	struct myrs_stat_mbox *stat_mbox;
> +	union myrs_cmd_mbox *mbox;
> +	dma_addr_t mbox_addr;
> +	unsigned char status = MYRS_STATUS_FAILED;
> +
> +	if (pci_set_dma_mask(pdev, DMA_BIT_MASK(64)))
> +		if (pci_set_dma_mask(pdev, DMA_BIT_MASK(32))) {

Please use dma_set_mask.

Except for that, the pci_ids.h issue mentioned in the previous patch
this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
