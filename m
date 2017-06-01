Return-Path: <hch@lst.de>
Date: Thu, 1 Jun 2017 08:05:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.com>,
	Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2 5/6] cdrom: Check SCSI passthrough support before
	reading audio
Message-ID: <20170601060519.GB16248@lst.de>
References: <20170531214350.31157-1-bart.vanassche@sandisk.com> <20170531214350.31157-6-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170531214350.31157-6-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 31, 2017 at 02:43:49PM -0700, Bart Van Assche wrote:
> The CDROMREADAUDIO ioctl uses SCSI passthrough when the .disk
> pointer has been set in struct cdrom_device_info. Hence check
> whether SCSI passthrough is supported before submitting a SCSI
> command. Note: both the ide-cd and sr drivers set the disk
> pointer in struct cdrom_device_info but neither the pcd nor
> the gdrom driver sets that pointer.

And I think that's exactly the point.  There probably can be some
further cleanup in this area, but for now this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
