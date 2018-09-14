Return-Path: <stern+5b8652cc@rowland.harvard.edu>
Date: Fri, 14 Sep 2018 10:10:27 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Christoph Hellwig <hch@lst.de>
cc: Bart Van Assche <bart.vanassche@wdc.com>, Jens Axboe <axboe@kernel.dk>,
     <linux-block@vger.kernel.org>, Jianchao Wang <jianchao.w.wang@oracle.com>,
    Ming Lei <ming.lei@redhat.com>, Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v4 04/10] block: Move power management code into a new
 source file
In-Reply-To: <20180914130100.GC26651@lst.de>
Message-ID: <Pine.LNX.4.44L0.1809141008170.1482-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

On Fri, 14 Sep 2018, Christoph Hellwig wrote:

> >  11 files changed, 266 insertions(+), 239 deletions(-)
> >  create mode 100644 block/blk-pm.c
> >  create mode 100644 block/blk-pm.h
> >  create mode 100644 include/linux/blk-pm.h
> > 
> > diff --git a/block/Kconfig b/block/Kconfig
> > index 1f2469a0123c..e213d90a5e64 100644
> > --- a/block/Kconfig
> > +++ b/block/Kconfig
> > @@ -228,4 +228,9 @@ config BLK_MQ_RDMA
> >  	depends on BLOCK && INFINIBAND
> >  	default y
> >  
> > +config BLK_PM
> > +	bool
> > +	depends on BLOCK && PM
> > +	default y
> 
> This could be shortened to
> 
> config BLK_PM
> 	def_bool BLOCK && PM
> 
> Also a lot of this code is only used by scsi.  I really wonder if
> we should move it into scsi instead, and if not at least make it
> a selectable option that only scsi selects.

Although SCSI is currently the only user of block-layer runtime PM, 
there's no reason other subsystems or drivers couldn't decide to use it 
too.  In theory, anything whose activity is controlled by block 
requests could benefit from it.

Making it selectable sounds like a reasonable approach.

Alan Stern
