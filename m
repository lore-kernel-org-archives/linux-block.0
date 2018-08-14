Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [RFC PATCH V2 12/17] SCSI: create admin queue for each host
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20180811071220.357-1-ming.lei@redhat.com>
 <20180811071220.357-13-ming.lei@redhat.com>
 <09bd8add-cdc0-7a58-8972-5bc5036ba432@oracle.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d3022fca-7244-20db-5008-224eb895fb43@oracle.com>
Date: Tue, 14 Aug 2018 14:03:58 +0800
MIME-Version: 1.0
In-Reply-To: <09bd8add-cdc0-7a58-8972-5bc5036ba432@oracle.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>



On 08/14/2018 01:56 PM, jianchao.wang wrote:
> Hi Ming
> 
> On 08/11/2018 03:12 PM, Ming Lei wrote:
>> +static blk_status_t scsi_admin_queue_rq(struct blk_mq_hw_ctx *hctx,
>> +			 const struct blk_mq_queue_data *bd)
>> +{
>> +	struct scsi_device *sdev = scsi_req(bd->rq)->sdev;
>> +
>> +	WARN_ON_ONCE(hctx->queue == sdev->request_queue);
>> +
>> +	if (!__scsi_mq_get_budget(hctx, sdev))
>> +		return BLK_STS_RESOURCE;
>> +
>> +	return __scsi_queue_rq(hctx, bd, sdev);
>> +}
> 
> Why does it return BLK_STS_RESOURCE here ?
> 
> Do you want to use the following code branch in blk_mq_dispatch_rq_list to get the admin queue rerun ?
> 
> 		else if (needs_restart && (ret == BLK_STS_RESOURCE))
> 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
> 
> In theory, BLK_STS_DEV_RESOURCE should be returned here. However, I guess it will not work. Because
> the rr fashion loop restart has gone, the completion of normal queue will not restart the admin queue.
> If yes, please add some comment here to describe it. :)
> 

Looks like the patch 10 could avoid the admin queue hung.

Thanks
Jianchao
