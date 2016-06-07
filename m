Return-Path: <mlin@kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAF1ivSYpbzPF+5_e+hEKZ_-t7=UhijULbkvF=SodSF7FD5YS-A@mail.gmail.com>
References: <1465248119-17875-1-git-send-email-hch@lst.de> <1465248119-17875-2-git-send-email-hch@lst.de>
 <20160607145736.GB28414@localhost.localdomain> <CAF1ivSYpbzPF+5_e+hEKZ_-t7=UhijULbkvF=SodSF7FD5YS-A@mail.gmail.com>
From: Ming Lin <mlin@kernel.org>
Date: Tue, 7 Jun 2016 16:21:53 -0700
Message-ID: <CAF1ivSYD88gsiAWQkcH-af07-HCVYzQrFcxpGhejLxcmr0WHrw@mail.gmail.com>
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_alloc_request_hctx
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Jun 7, 2016 at 8:27 AM, Ming Lin <mlin@kernel.org> wrote:
> On Tue, Jun 7, 2016 at 7:57 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On Mon, Jun 06, 2016 at 11:21:52PM +0200, Christoph Hellwig wrote:
>>> +struct request *blk_mq_alloc_request_hctx(struct request_queue *q, int rw,
>>> +             unsigned int flags, unsigned int hctx_idx)
>>> +{
>>> +     struct blk_mq_hw_ctx *hctx;
>>> +     struct blk_mq_ctx *ctx;
>>> +     struct request *rq;
>>> +     struct blk_mq_alloc_data alloc_data;
>>> +     int ret;
>>> +
>>> +     ret = blk_queue_enter(q, flags & BLK_MQ_REQ_NOWAIT);
>>> +     if (ret)
>>> +             return ERR_PTR(ret);
>>> +
>>> +     hctx = q->queue_hw_ctx[hctx_idx];
>>
>> We probably want to check 'if (hctx_idx < q->nr_hw_queues)' before
>> getting the hctx. Even if hctx_idx was origially valid, it's possible
>> (though unlikely) blk_queue_enter waits on reallocating h/w contexts,
>> which can make hctx_idx invalid.
>
> Yes, I'll update it.

How about this?

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7bb45ed..b59d2ef 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -279,6 +279,11 @@ struct request *blk_mq_alloc_request_hctx(struct
request_queue *q, int rw,
        if (ret)
                return ERR_PTR(ret);

+       if (hctx_idx >= q->nr_hw_queues) {
+               blk_queue_exit(q);
+               return ERR_PTR(-EINVAL);
+       }
+
        hctx = q->queue_hw_ctx[hctx_idx];
        ctx = __blk_mq_get_ctx(q, cpumask_first(hctx->cpumask));
