Return-Path: <ming.lei@redhat.com>
Date: Tue, 14 Aug 2018 19:34:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH V2 12/17] SCSI: create admin queue for each host
Message-ID: <20180814113402.GA12281@ming.t460p>
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-13-ming.lei@redhat.com>
 <09bd8add-cdc0-7a58-8972-5bc5036ba432@oracle.com>
 <d3022fca-7244-20db-5008-224eb895fb43@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d3022fca-7244-20db-5008-224eb895fb43@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 14, 2018 at 02:03:58PM +0800, jianchao.wang wrote:
> 
> 
> On 08/14/2018 01:56 PM, jianchao.wang wrote:
> > Hi Ming
> > 
> > On 08/11/2018 03:12 PM, Ming Lei wrote:
> >> +static blk_status_t scsi_admin_queue_rq(struct blk_mq_hw_ctx *hctx,
> >> +			 const struct blk_mq_queue_data *bd)
> >> +{
> >> +	struct scsi_device *sdev = scsi_req(bd->rq)->sdev;
> >> +
> >> +	WARN_ON_ONCE(hctx->queue == sdev->request_queue);
> >> +
> >> +	if (!__scsi_mq_get_budget(hctx, sdev))
> >> +		return BLK_STS_RESOURCE;
> >> +
> >> +	return __scsi_queue_rq(hctx, bd, sdev);
> >> +}
> > 
> > Why does it return BLK_STS_RESOURCE here ?
> > 
> > Do you want to use the following code branch in blk_mq_dispatch_rq_list to get the admin queue rerun ?
> > 
> > 		else if (needs_restart && (ret == BLK_STS_RESOURCE))
> > 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> > 
> > In theory, BLK_STS_DEV_RESOURCE should be returned here. However, I guess it will not work. Because
> > the rr fashion loop restart has gone, the completion of normal queue will not restart the admin queue.
> > If yes, please add some comment here to describe it. :)
> > 
> 
> Looks like the patch 10 could avoid the admin queue hung.

Yes, this one is patch 12, :-)

Also not necessary to add comment on returning BLK_STS_RESOURCE because
it is always the safe say, given blk-mq will handle the queue rerun.

However, if driver returns BLK_STS_DEV_RESOURCE, some comment have to
be added, please see comment on BLK_STS_DEV_RESOURCE.

Thanks,
Ming
