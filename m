Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:05:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/6] Split scsi passthrough fields out of struct
	request sequel
Message-ID: <20170601060544.GC16248@lst.de>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531214350.31157-1-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 02:43:44PM -0700, Bart Van Assche wrote:
> Hello Jens,
> 
> The patches in this series are a sequel of Christoph's "Split scsi passthrough
> fields out of struct request" patch series. The changes compared to v1 of this
> patch series are:
> - Renamed QUEUE_FLAG_SCSI_PDU into QUEUE_FLAG_SCSI_PASSTHROUGH and
>   blk_queue_scsi_pdu() into blk_queue_scsi_passthrough().
> - In the cdrom driver, moved the SCSI passthrough support test from
>   register_cdrom() to cdrom_read_cdda_bpc().
> 
> Please consider these patches for kernel v4.13.

I think these should probably go into 4.12.  At least the first one
should for sure.
