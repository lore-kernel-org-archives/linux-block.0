Return-Path: <linus.walleij@linaro.org>
MIME-Version: 1.0
In-Reply-To: <a3216031-0801-45e2-320c-bfc88fa742b4@kernel.dk>
References: <20170209153403.9730-1-linus.walleij@linaro.org>
 <20170209153403.9730-7-linus.walleij@linaro.org> <00989e26-cdb9-48d7-2e46-ae6ef66e59a7@intel.com>
 <CACRpkdYOyEs8vxmPt1kGiKJrw8+16DyD8Nn=ke6mgxPaCQynCw@mail.gmail.com>
 <3fc89f9f-fbcf-113d-3644-b6c9dae003f0@intel.com> <8f1f3d4c-410c-2632-c776-4ced363bdb0d@kernel.dk>
 <e4b2c4bc-8627-2234-354d-c986f69b220f@intel.com> <97f2a4ea-0802-9f23-6ac7-b9d6c6afbfcc@kernel.dk>
 <a3571278-b30d-c3cb-bea6-d1776eb53025@intel.com> <a3216031-0801-45e2-320c-bfc88fa742b4@kernel.dk>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 Mar 2017 09:47:51 +0200
Message-ID: <CACRpkdYAY8CcWb5obz2Awh9_QoHeoN=aWjDsVKeftsQy0Y5MJg@mail.gmail.com>
Subject: Re: [PATCH 06/16] mmc: core: replace waitqueue with worker
To: Jens Axboe <axboe@kernel.dk>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
	Paolo Valente <paolo.valente@linaro.org>, Chunyan Zhang <zhang.chunyan@linaro.org>,
	Baolin Wang <baolin.wang@linaro.org>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 14, 2017 at 3:36 PM, Jens Axboe <axboe@kernel.dk> wrote:

> There's one case that doesn't look like it was converted properly, but
> that's a mistake. The general insert-and-run cases run inline if we can,
> but the direct-issue needs a fixup, see below.
>
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 159187a28d66..4196d6bee92d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1434,7 +1434,8 @@ static blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx, struct request *rq)
>         return blk_tag_to_qc_t(rq->internal_tag, hctx->queue_num, true);
>  }
>
> -static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
> +static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie,
> +                                     bool can_block)
>  {
>         struct request_queue *q = rq->q;
>         struct blk_mq_queue_data bd = {
> @@ -1475,7 +1476,7 @@ static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
>         }
>
>  insert:
> -       blk_mq_sched_insert_request(rq, false, true, true, false);
> +       blk_mq_sched_insert_request(rq, false, true, false, can_block);
>  }
>
>  /*
> @@ -1569,11 +1570,11 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>
>                 if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
>                         rcu_read_lock();
> -                       blk_mq_try_issue_directly(old_rq, &cookie);
> +                       blk_mq_try_issue_directly(old_rq, &cookie, false);
>                         rcu_read_unlock();
>                 } else {
>                         srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
> -                       blk_mq_try_issue_directly(old_rq, &cookie);
> +                       blk_mq_try_issue_directly(old_rq, &cookie, true);
>                         srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
>                 }
>                 goto done;

Jens do you have this in your patch queue or is it something you want
us to test and
submit back to you?

Yours,
Linus Walleij
