Return-Path: <ming.lei@redhat.com>
Date: Tue, 17 Jul 2018 23:38:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"rjw@rjwysocki.net" <rjw@rjwysocki.net>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH RFC V2 3/3] scsi_mq: enable runtime PM
Message-ID: <20180717153847.GB8973@ming.t460p>
References: <20180713080602.31602-1-ming.lei@redhat.com>
 <20180713080602.31602-4-ming.lei@redhat.com>
 <20180717132411.GI13582@lst.de>
 <20180717153031.GA8973@ming.t460p>
 <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <07874eaab2d93728afe3f220cd0efa8f41d4955a.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 17, 2018 at 03:34:35PM +0000, Bart Van Assche wrote:
> On Tue, 2018-07-17 at 23:30 +0800, Ming Lei wrote:
> > On Tue, Jul 17, 2018 at 03:24:11PM +0200, Christoph Hellwig wrote:
> > > On Fri, Jul 13, 2018 at 04:06:02PM +0800, Ming Lei wrote:
> > > > Usually SCSI supports runtime PM, so pass BLK_MQ_F_SUPPORT_RPM to blk-mq
> > > > core for enabling block runtime PM.
> > > 
> > > I still think enabling this unconditionally for any SCSI device was
> > > a mistake, and it is even more so for blk-mq.
> > > 
> > > Please only opt in for ufs, ATA first, adding others if wanted by
> > > maintainers.
> > 
> > No, this way will cause regression because runtime PM works for
> > all sd/sr device actually, and it isn't related with scsi host.
> 
> For which SCSI devices other than ufs and ATA do we need PM support?

As I said, it is any sd/sr device, which can be put down by runtime PM
via START_STOP command if it isn't used for a while.

Thanks,
Ming
