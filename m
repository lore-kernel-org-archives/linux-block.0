Return-Path: <ming.lei@redhat.com>
Date: Tue, 17 Jul 2018 23:30:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
Message-ID: <20180717153031.GA8973@ming.t460p>
References: <20180713080602.31602-1-ming.lei@redhat.com>
 <20180713080602.31602-4-ming.lei@redhat.com>
 <20180717132411.GI13582@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180717132411.GI13582@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 17, 2018 at 03:24:11PM +0200, Christoph Hellwig wrote:
> On Fri, Jul 13, 2018 at 04:06:02PM +0800, Ming Lei wrote:
> > Usually SCSI supports runtime PM, so pass BLK_MQ_F_SUPPORT_RPM to blk-mq
> > core for enabling block runtime PM.
> 
> I still think enabling this unconditionally for any SCSI device was
> a mistake, and it is even more so for blk-mq.
> 
> Please only opt in for ufs, ATA first, adding others if wanted by
> maintainers.

No, this way will cause regression because runtime PM works for
all sd/sr device actually, and it isn't related with scsi host.


Thanks,
Ming
