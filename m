Return-Path: <hch@lst.de>
Date: Thu, 12 Jul 2018 09:17:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] scsi_mq: enable runtime PM
Message-ID: <20180712071758.GB15624@lst.de>
References: <20180711162906.14271-1-ming.lei@redhat.com> <20180711162906.14271-5-ming.lei@redhat.com> <20180711171409.GC3500@lst.de> <20180712013642.GA15593@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180712013642.GA15593@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 12, 2018 at 09:36:49AM +0800, Ming Lei wrote:
> > As far as I can tell only ufs and libata support runtime PM, so
> > we should probably only enable it for those.
> 
> For legacy path, blk_pm_runtime_init() is always run for all SCSI devices,
> and this patch just follows the old way, so that we can keep runtime PM
> behaviour not changed from user view. That means if we want to only enable
> for ufs & libata, it should be in another standalone patch, instead of
> this one.

Please add this to the series as a separate patch then.
