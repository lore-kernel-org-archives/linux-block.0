Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH V2 5/5] nvme: pci: simplify timeout handling
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180429154152.16656-1-ming.lei@redhat.com>
 <20180429154152.16656-6-ming.lei@redhat.com>
 <655b9d93-b4fc-b78b-1ea1-1c34d5c0535e@oracle.com>
 <20180502045423.GE22363@ming.t460p>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <eee63159-aae9-1936-008d-024dce13a69b@oracle.com>
Date: Wed, 2 May 2018 13:12:57 +0800
MIME-Version: 1.0
In-Reply-To: <20180502045423.GE22363@ming.t460p>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Ming

On 05/02/2018 12:54 PM, Ming Lei wrote:
>> We need to return BLK_EH_RESET_TIMER in nvme_timeout then:
>> 1. defer the completion. we can't unmap the io request before close the controller totally, so not BLK_EH_HANDLED.
>> 2. nvme_cancel_request could complete it. blk_mq_complete_request is invoked by nvme_cancel_request, so not BLK_EH_NOT_HANDLED.
> We don't need to change return value of .timeout() any more after
> calling nvme_quiesce_timeout():
> 
> Thanks the single EH kthread, once nvme_quiesce_timeout() returns, all
> timed-out requests have been handled already. Some of them may be completed,
> and others may be handled as RESET_TIMER, but none of them are handled as
> NOT_HANDLED because nvme_timeout() won't return that value.
> 
> So the following blk_mq_tagset_busy_iter(nvme_cancel_request) can handle
> all in-flight requests because timeout is drained and quiesced.

The key point here is we cannot unmap the io requests before we close the controller directly.
The nvme controller may still hold the command after we complete and unmap the io request in nvme_timeout.
This will cause memory corruption.

So we cannot just schedule the eh recovery kthread then return BLK_EH_HANDLED.
We need to deffer the completion of timeout requests until the controller has been closed totally in nvme_dev_disable.

Thanks
Jianchao
