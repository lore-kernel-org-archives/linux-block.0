Return-Path: <ming.lei@redhat.com>
Date: Thu, 12 Jul 2018 09:36:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH RFC 4/4] scsi_mq: enable runtime PM
Message-ID: <20180712013642.GA15593@ming.t460p>
References: <20180711162906.14271-1-ming.lei@redhat.com>
 <20180711162906.14271-5-ming.lei@redhat.com>
 <20180711171409.GC3500@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180711171409.GC3500@lst.de>
List-ID: <linux-block@vger.kernel.org>

Hi Christoph,

On Wed, Jul 11, 2018 at 07:14:09PM +0200, Christoph Hellwig wrote:
> > @@ -3770,7 +3770,7 @@ EXPORT_SYMBOL(blk_finish_plug);
> >  void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
> >  {
> >  	/* not support for RQF_PM and ->rpm_status in blk-mq yet */
> > -	if (q->mq_ops)
> > +	if (q->mq_ops && !(q->tag_set->flags & BLK_MQ_F_SUPPORT_RPM))
> >  		return;
> >  
> >  	q->dev = dev;
> 
> This should go into a block layer patch, not a scsi one.

OK.

> 
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 41e9ac9fc138..fa4667aa4732 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -2306,7 +2306,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
> >  	shost->tag_set.queue_depth = shost->can_queue;
> >  	shost->tag_set.cmd_size = cmd_size;
> >  	shost->tag_set.numa_node = NUMA_NO_NODE;
> > -	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
> > +	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
> > +		BLK_MQ_F_SG_MERGE | BLK_MQ_F_SUPPORT_RPM;
> 
> As far as I can tell only ufs and libata support runtime PM, so
> we should probably only enable it for those.

For legacy path, blk_pm_runtime_init() is always run for all SCSI devices,
and this patch just follows the old way, so that we can keep runtime PM
behaviour not changed from user view. That means if we want to only enable
for ufs & libata, it should be in another standalone patch, instead of
this one.

I will address all your other comments and Alan's in V2.

Thanks,
Ming
