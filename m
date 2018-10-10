Return-Path: <hch@lst.de>
Date: Wed, 10 Oct 2018 14:56:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	James Bottomley <james.bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 1/3] myrb: Add Mylex RAID controller (block interface)
Message-ID: <20181010125630.GA21110@lst.de>
References: <20181009152701.5542-1-hare@suse.de> <20181009152701.5542-2-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181009152701.5542-2-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

> +static void myrb_monitor(struct work_struct *work);
> +static inline void DAC960_P_To_PD_TranslateDeviceState(void *DeviceState);

Can you please use normal kernel function names and a normal prefix?

Also there seems to be no good reason to need a forward declaration for
this function.

> +static struct myrb_devstate_name_entry {
> +	enum myrb_devstate state;
> +	char *name;
> +} myrb_devstate_name_list[] = {
> +	{ DAC960_V1_Device_Dead, "Dead" },
> +	{ DAC960_V1_Device_WriteOnly, "WriteOnly" },
> +	{ DAC960_V1_Device_Online, "Online" },
> +	{ DAC960_V1_Device_Critical, "Critical" },
> +	{ DAC960_V1_Device_Standby, "Standby" },
> +	{ DAC960_V1_Device_Offline, NULL },
> +};

Please use MYRB_ as prefix.

> +static char *myrb_devstate_name(enum myrb_devstate state)
> +{
> +	struct myrb_devstate_name_entry *entry = myrb_devstate_name_list;
> +
> +	while (entry && entry->name) {
> +		if (entry->state == state)
> +			return entry->name;
> +		entry++;
> +	}
> +	return (state == DAC960_V1_Device_Offline) ? "Offline" : "Unknown";

Why not use ARRAY_SIZE and use a proper list entry for Offline?

> +static char *myrb_raidlevel_name(enum myrb_raidlevel level)
> +{
> +	struct myrb_raidlevel_name_entry *entry = myrb_raidlevel_name_list;
> +
> +	while (entry && entry->name) {
> +		if (entry->level == level)
> +			return entry->name;
> +		entry++;
> +	}
> +	return NULL;

Same here - please use ARRAY_SIZE.

> +/**
> + * myrb_exec_cmd - executes command block and waits for completion.
> + *
> + * Return: command status
> + */
> +static unsigned short myrb_exec_cmd(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)
> +{
> +	DECLARE_COMPLETION_ONSTACK(Completion);
> +	unsigned long flags;
> +
> +	cmd_blk->Completion = &Completion;
> +
> +	spin_lock_irqsave(&cb->queue_lock, flags);
> +	cb->qcmd(cb, cmd_blk);
> +	spin_unlock_irqrestore(&cb->queue_lock, flags);
> +
> +	wait_for_completion(&Completion);
> +	return cmd_blk->status;
> +}

My comment from ast time here is not addressed:

https://patchwork.kernel.org/comment/21613427/

> +	static char *DAC960_EventMessages[] =
> +		{ "killed because write recovery failed",
> +		  "killed because of SCSI bus reset failure",
> +		  "killed because of double check condition",
> +		  "killed because it was removed",
> +		  "killed because of gross error on SCSI chip",
> +		  "killed because of bad tag returned from drive",
> +		  "killed because of timeout on SCSI command",
> +		  "killed because of reset SCSI command issued from system",
> +		  "killed because busy or parity error count exceeded limit",
> +		  "killed because of 'kill drive' command from system",
> +		  "killed because of selection timeout",
> +		  "killed due to SCSI phase sequence error",
> +		  "killed due to unknown status" };

Rather odd indentation.  It might also look a lot nicer if moved outside
the function.

> +	mbox->Type3E.addr = ev_addr;
> +	status = myrb_exec_cmd(cb, cmd_blk);
> +	if (status == DAC960_V1_NormalCompletion) {
> +		if (ev_buf->SequenceNumber == event) {

...

> +			}
> +		}
> +	} else
> +		shost_printk(KERN_INFO, cb->host,
> +			     "Failed to get event log %d, status %04x\n",
> +			     event, status);
> +

Why not:

	if (status != DAC960_V1_NormalCompletion) {
		shost_printk(KERN_INFO, cb->host,
			     "Failed to get event log %d, status %04x\n",
			     event, status);
	} else if (ev_buf->SequenceNumber == event) {
		...
	}

to reduce the indentation a bit?

> +	for (ldev_num = 0; ldev_num < ldev_cnt; ldev_num++) {
> +		struct myrb_ldev_info *old = NULL;
> +		struct myrb_ldev_info *new = cb->ldev_info_buf + ldev_num;
> +		struct scsi_device *sdev;
> +		enum myrb_devstate old_state = DAC960_V1_Device_Offline;
> +
> +		sdev = scsi_device_lookup(shost, myrb_logical_channel(shost),
> +					  ldev_num, 0);
> +		if (sdev && sdev->hostdata)
> +			old = sdev->hostdata;
> +		else if (new->State != DAC960_V1_Device_Offline) {
> +			if (sdev)
> +				scsi_device_put(sdev);
> +			shost_printk(KERN_INFO, shost,
> +				     "Adding Logical Drive %d in state %s\n",
> +				     ldev_num, myrb_devstate_name(new->State));
> +			scsi_add_device(shost, myrb_logical_channel(shost),
> +					ldev_num, 0);
> +			break;
> +		}

I don't think finding a device but not having a hostdata can happen
here, as we always set it up in slave_alloc.

So this could become something like:

		sdev = scsi_device_lookup(shost, myrb_logical_channel(shost),
					  ldev_num, 0);
		if (!sdev) {
			if (new->State == DAC960_V1_Device_Offline)
				continue;
			shost_printk(KERN_INFO, shost,
				     "Adding Logical Drive %d in state %s\n",
				     ldev_num, myrb_devstate_name(new->State));
			scsi_add_device(shost, myrb_logical_channel(shost),
					ldev_num, 0);
			break;
		}

		old = sdev->hostdata;
		if (new->State != old->State)
			shost_printk(KERN_INFO, shost,
				     "Logical Drive %d is now %s\n",
				     ldev_num, myrb_devstate_name(new->State));
		if (new->WriteBack != old->WriteBack)
			sdev_printk(KERN_INFO, sdev,
				    "Logical Drive is now WRITE %s\n",
				    new->WriteBack ? "BACK" : "THRU");
		memcpy(old, new, sizeof(*new));
		scsi_device_put(sdev);
	}

But the break when adding the new device also looks odd to me.  Is
it gurantee we only see a single new device per call?

> +	/*
> +	  Initialize the Controller Firmware Version field and verify that it
> +	  is a supported firmware version.  The supported firmware versions are:
> +
> +	  DAC1164P		    5.06 and above
> +	  DAC960PTL/PRL/PJ/PG	    4.06 and above
> +	  DAC960PU/PD/PL	    3.51 and above
> +	  DAC960PU/PD/PL/P	    2.73 and above
> +	*/

Please switch to normal kernel comment style.

> +#if defined(CONFIG_ALPHA)

#ifdef CONFIG_ALPHA

> +static int myrb_host_reset(struct scsi_cmnd *scmd)
> +{
> +	struct Scsi_Host *shost = scmd->device->host;
> +	struct myrb_hba *cb = (struct myrb_hba *)shost->hostdata;

cb is an odd variable name for this type.  Also please use shost_priv()

> +	ldev_info = sdev->hostdata;
> +	if (!ldev_info ||

again, there should be no way for this to be NULL

> +	if (sdev->channel == myrb_logical_channel(sdev->host)) {

Maybe split some ldev/pdev alloc_slave helpers out here?

> +static void myrb_slave_destroy(struct scsi_device *sdev)
> +{
> +	void *hostdata = sdev->hostdata;
> +
> +	if (hostdata) {
> +		kfree(hostdata);
> +		sdev->hostdata = NULL;
> +	}

No need to check for NULL before kfree, and no need to zero a pointer
about to get freed itself.  This could just be:

static void myrb_slave_destroy(struct scsi_device *sdev)
{
	kfree(sdev->hostdata);
}

> +struct scsi_host_template myrb_template = {
> +	.module = THIS_MODULE,
> +	.name = "DAC960",
> +	.proc_name = "myrb",
> +	.queuecommand = myrb_queuecommand,
> +	.eh_host_reset_handler = myrb_host_reset,
> +	.slave_alloc = myrb_slave_alloc,
> +	.slave_configure = myrb_slave_configure,
> +	.slave_destroy = myrb_slave_destroy,
> +	.bios_param = myrb_biosparam,
> +	.cmd_size = sizeof(struct myrb_cmdblk),
> +	.shost_attrs = myrb_shost_attrs,
> +	.sdev_attrs = myrb_sdev_attrs,
> +	.this_id = -1,
> +};

Would be nice to aligned the = with tabs.

> +static int
> +myrb_is_raid(struct device *dev)
> +{
> +	struct scsi_device *sdev = to_scsi_device(dev);
> +
> +	return (sdev->channel == myrb_logical_channel(sdev->host)) ? 1 : 0;

No need for the ? 1 : 0:

	return sdev->channel == myrb_logical_channel(sdev->host);

> +static inline
> +void DAC960_LA_HardwareMailboxNewCommand(void __iomem *base)
> +{
> +	writeb(DAC960_LA_IDB_HWMBOX_NEW_CMD,
> +	       base + DAC960_LA_InboundDoorBellRegisterOffset);
> +}

Please user proper linux style naming (also for constants and struct
members).

> +static inline
> +void DAC960_P_To_PD_TranslateReadWriteCommand(struct myrb_cmdblk *cmd_blk)

static inline void function();

or

static inline void
function()

please, but not the above.

> +static void DAC960_P_QueueCommand(struct myrb_hba *cb, struct myrb_cmdblk *cmd_blk)

Overly long line.

> +static const struct pci_device_id myrb_id_table[] = {
> +	{
> +		.vendor		= PCI_VENDOR_ID_DEC,
> +		.device		= PCI_DEVICE_ID_DEC_21285,
> +		.subvendor	= PCI_SUBVENDOR_ID_MYLEX,
> +		.subdevice	= PCI_SUBDEVICE_ID_MYLEX_DAC960_LA,
> +		.driver_data	= (unsigned long) &DAC960_LA_privdata,
> +	},
> +	{
> +		.vendor		= PCI_VENDOR_ID_MYLEX,
> +		.device		= PCI_DEVICE_ID_MYLEX_DAC960_PG,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.driver_data	= (unsigned long) &DAC960_PG_privdata,
> +	},

Please use the PCI_DEVICE_SUB and PCI_VDEVICE macros.
