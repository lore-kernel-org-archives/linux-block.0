Return-Path: <ming.lei@redhat.com>
Date: Wed, 8 Aug 2018 11:37:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
	"jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"hch@lst.de" <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"hare@suse.de" <hare@suse.de>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
	"jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
	"jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 06/14] SCSI: pass scsi_device to scsi_mq_prep_fn
Message-ID: <20180808033700.GB9523@ming.t460p>
References: <20180807174433.8374-1-ming.lei@redhat.com>
 <20180807174433.8374-7-ming.lei@redhat.com>
 <9d8d49fcdd44152c9fda20c9a57dbb516a5bbbbd.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9d8d49fcdd44152c9fda20c9a57dbb516a5bbbbd.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 07, 2018 at 11:24:06PM +0000, Bart Van Assche wrote:
> On Wed, 2018-08-08 at 01:44 +0800, Ming Lei wrote:
> > diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> > index 435347f58328..52e498fb6280 100644
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -1971,10 +1971,9 @@ static unsigned int scsi_mq_sgl_size(struct Scsi_Host *shost)
> >  		sizeof(struct scatterlist);
> >  }
> >  
> > -static int scsi_mq_prep_fn(struct request *req)
> > +static int scsi_mq_prep_fn(struct scsi_device *sdev, struct request *req)
> >  {
> >  	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
> > -	struct scsi_device *sdev = req->q->queuedata;
> >  	struct Scsi_Host *shost = sdev->host;
> >  	struct scatterlist *sg;
> >  
> > @@ -2070,7 +2069,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
> >  		goto out_dec_target_busy;
> >  
> >  	if (!(req->rq_flags & RQF_DONTPREP)) {
> > -		ret = prep_to_mq(scsi_mq_prep_fn(req));
> > +		ret = prep_to_mq(scsi_mq_prep_fn(sdev, req));
> >  		if (ret != BLK_STS_OK)
> >  			goto out_dec_host_busy;
> >  		req->rq_flags |= RQF_DONTPREP;
> 
> This patch looks useful to me since it probably realizes a (small) performance
> improvement. I think this patch does not depend on any of the previous patches
> in this series. Is that correct?

Yes, it is.

Thanks,
Ming
