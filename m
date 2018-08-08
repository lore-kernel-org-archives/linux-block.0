Return-Path: <ming.lei@redhat.com>
Date: Wed, 8 Aug 2018 11:36:18 +0800
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
Subject: Re: [RFC PATCH 10/14] SCSI: use the dedicated admin queue to send
 admin commands
Message-ID: <20180808033612.GA9523@ming.t460p>
References: <20180807174433.8374-1-ming.lei@redhat.com>
 <20180807174433.8374-11-ming.lei@redhat.com>
 <eaa9a9ee6da927d1d65fe19de01114d5f38832bc.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <eaa9a9ee6da927d1d65fe19de01114d5f38832bc.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 07, 2018 at 11:33:15PM +0000, Bart Van Assche wrote:
> On Wed, 2018-08-08 at 01:44 +0800, Ming Lei wrote:
> > --- a/drivers/scsi/scsi_lib.c
> > +++ b/drivers/scsi/scsi_lib.c
> > @@ -278,16 +278,16 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
> >  	struct request *req;
> >  	struct scsi_request *rq;
> >  	int ret = DRIVER_ERROR << 24;
> > +	struct request_queue *q = sdev->host->admin_q;
> >  
> > -	req = blk_get_request(sdev->request_queue,
> > +	req = blk_get_request(q,
> >  			data_direction == DMA_TO_DEVICE ?
> >  			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
> 
> The above looks weird to me. Why are all RQF_PREEMPT requests sent to the admin
> queue instead of only RQF_PM requests?

The motivation is to use the dedicated admin queue for sending any admin
request, and that is why it isn't named as pm_queue, :-)

Also usually RQF_PREEMPT request is allowed when queue is quiesced, which
can be used in both system suspend and sending domain validation.

> 
> > @@ -299,6 +299,8 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
> >  	req->cmd_flags |= flags;
> >  	req->rq_flags |= rq_flags | RQF_QUIET;
> >  
> > +	atomic_inc(&sdev->nr_admin_pending);
> 
> Why has a new counter been introduced to keep track of admin requests instead of
> using q_usage_counter?

Just for making sure all admin requests sent to this scsi_device can be
completed before removing this scsi_device, given this patch switches to
use per-host admin queue to send admin requests to all scsi_devices in this host.

So we can't use the q_usage_counter of scsi_device's queue or the per-host
admin queue.

It won't be one big deal since scsi_execute() won't be run in fast path.

Thanks,
Ming
