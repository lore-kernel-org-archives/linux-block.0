Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>,
        Damien Le Moal <damien.lemoal@hgst.com>
Subject: Re: [PATCH v8 6/7] sd: Implement support for ZBC devices
References: <1476772835-18541-1-git-send-email-damien.lemoal@wdc.com>
	<1476772835-18541-7-git-send-email-damien.lemoal@wdc.com>
Date: Tue, 18 Oct 2016 12:58:11 -0400
In-Reply-To: <1476772835-18541-7-git-send-email-damien.lemoal@wdc.com> (Damien
	Le Moal's message of "Tue, 18 Oct 2016 15:40:34 +0900")
Message-ID: <x498ttlvbks.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Damien Le Moal <damien.lemoal@wdc.com> writes:

> +	if (!is_power_of_2(zone_blocks)) {
> +		if (sdkp->first_scan)
> +			sd_printk(KERN_NOTICE, sdkp,
> +				  "Devices with non power of 2 zone "
> +				  "size are not supported\n");
> +		return -ENODEV;
> +	}

Are power of 2 zone sizes required by the standard?  I see why you've
done this, but I wonder if we're artificially limiting the
implementation, and whether there will be valid devices on the market
that simply won't work with Linux because of this.

-Jeff
