Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A2AC433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 10:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbhLFKew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 05:34:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:25098 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238137AbhLFKew (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 05:34:52 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20211206103122euoutp02394e962b954276852f9ba361a90da96e~_I84PjEhL2466124661euoutp02x
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 10:31:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20211206103122euoutp02394e962b954276852f9ba361a90da96e~_I84PjEhL2466124661euoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1638786682;
        bh=qkE6L1gg4mx9zQtvA5M5yZEyRCJqiB5OCxuIxSq/nPY=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=PBGW6zagVRArxCQ+Cv7/B+TmoUcxeBbtKjrDrBRiVTEluQmN6kQV2CPMV4mWx0Hl4
         MrvbExp75qXMRD2l6g+ZSD42B1FO19NnHqJ3uBZnnxPvWWLABtcOAmXxTF4mlYg9fi
         APVd6+lUA4KGKKxLrb/+MbH3ZhxU0isnM4CqGGVU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20211206103122eucas1p246562ecadd6a235c8c2b438be3822d9d~_I83_9tqL0586805868eucas1p2M;
        Mon,  6 Dec 2021 10:31:22 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 50.E6.09887.976EDA16; Mon,  6
        Dec 2021 10:31:21 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447~_I83WghUF2064820648eucas1p2Y;
        Mon,  6 Dec 2021 10:31:21 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211206103121eusmtrp2c41df1e2f9d9e7e2a2c485ee0a68e2a5~_I83VqWKJ3024730247eusmtrp2S;
        Mon,  6 Dec 2021 10:31:21 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-db-61ade6797e6c
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D8.30.09522.976EDA16; Mon,  6
        Dec 2021 10:31:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211206103121eusmtip2b7a292b7705f830b27e7827154f812ca~_I83E8bdz0690206902eusmtip2C;
        Mon,  6 Dec 2021 10:31:21 +0000 (GMT)
Message-ID: <8b6e48b0-c55d-1583-1146-b18bf4eaf94a@samsung.com>
Date:   Mon, 6 Dec 2021 11:31:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH 1/4] blk-mq: remove hctx_lock and hctx_unlock
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20211203131534.3668411-2-ming.lei@redhat.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87qVz9YmGkxbYmmx+m4/m8XeW9oW
        hyY3Mzkwe1w+W+rxft9VNo/Pm+QCmKO4bFJSczLLUov07RK4Mj6cki647VxxY+c8tgbG2+Zd
        jJwcEgImEssaNrB2MXJxCAmsYJR4/Hk3I4TzhVHiwaEbzBDOZ0aJ5oZWRpiWpd9/QiWWM0ps
        OXqPBSQhJPCRUeL4g0oQm1fATmJW83wmEJtFQEVix76r7BBxQYmTM5+A1YsKJElMOLEbrEZY
        wFHi3K09rCA2s4C4xK0nEL0iAg4S6953MELE5SU293axgdhsAoYSXW9BbA4OTgFria+TmGFK
        mrfOBrtNQmAph8S+ryuZIY52kbj/8xIrhC0s8er4FnYIW0bi/06QXSANzYwSD8+tZYdwehgl
        LjfNgHrZWuLOuV9g25gFNCXW79IHMSWAjr63mAvC5JO48VYQ4gY+iUnbpjNDhHklOtqEIGao
        Scw6vg5u68ELl5gnMCrNQgqUWUien4Xkm1kIaxcwsqxiFE8tLc5NTy02ykst1ytOzC0uzUvX
        S87P3cQITB+n/x3/soNx+auPeocYmTgYDzFKcDArifCqPVybKMSbklhZlVqUH19UmpNafIhR
        moNFSZxX5E9DopBAemJJanZqakFqEUyWiYNTqoFpefu+mean2V1qO+5ePnqW68Cu3VJPJu/7
        fSBsT7dwjkqrr+3EEPPyiZ9dYy+qzkzJn/QkhWlphDTb6Uv5Jidvy7QdNGaOblz8PWdK0moR
        R4FSzxfP85OncSudPS9z98xJrjrX6Dh9AfFdb5Xytlb/3fLjQvqza/7VLVWqBoInXysvP37o
        9FX+T+46zTz9P3idTmyXNKlaftU257rz2tDnSY/PdrBKxCTGnfri6Ckh9Hv7OmfjxZNa1u1k
        dDt3xdDsf8OqZOfYZbpn+QIvnHtkXeFZbF4zR/vkk4btdbNypDZ6TqwXn5J1THua48MDcpGy
        ha6rXgWEvHmUlTxZ9fqk008/Cm/omrRrrrE+U7iEEktxRqKhFnNRcSIAXXQTWI4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42I5/e/4Pd3KZ2sTDXYdEbZYfbefzWLvLW2L
        Q5ObmRyYPS6fLfV4v+8qm8fnTXIBzFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuax
        VkamSvp2NimpOZllqUX6dgl6GR9OSRfcdq64sXMeWwPjbfMuRk4OCQETiaXffzJ3MXJxCAks
        ZZS49LeDCSIhI3FyWgMrhC0s8edaFxtE0XtGiVkz5jCDJHgF7CRmNc8Ha2ARUJHYse8qO0Rc
        UOLkzCcsILaoQJLE0wOdbCC2sICjxLlbe8CGMguIS9x6AtErIuAgse59ByNEXF5ic28XWL2Q
        QLZEf89fsHo2AUOJrrcgcQ4OTgFria+TmCHKzSS6tnbBtTZvnc08gVFoFpIrZiHZNgtJyywk
        LQsYWVYxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERsy2Yz8372Cc9+qj3iFGJg7GQ4wSHMxK
        IrxqD9cmCvGmJFZWpRblxxeV5qQWH2I0BQbFRGYp0eR8YMzmlcQbmhmYGpqYWRqYWpoZK4nz
        ehZ0JAoJpCeWpGanphakFsH0MXFwSjUwlTCuOcSQdabo8bfnS2as/p3A+qNqh0N44OmDPxYt
        2nrY7Picm6IH23u45r64VvjwgdQHy8kd4Xf+/7OZ6DGTM+X2Rc2tWzMrXdIz824v3dciKrZy
        bfL9deXPswzb69NN9iTMWXRldezrnVzfN9zgevbzQae4g0JMWMErb+nG3ptnaj/NnzGfZcVk
        pTKbHexB4uVzsz6whhzZ9PzAxfvs8Y0XvTw5Qzst/q10/lz5afIqXm5zYcbAKXKB0WL9Db3u
        M+uT92bkOWx/f0qTccYuj78buSeX7+lfc+zYcxmdvojvB7Pfb0zpPrGw63z72Rlev3/lJzXZ
        hWU5ta1mjt53TVN4yZeoANsHk0NuO65+e1GJpTgj0VCLuag4EQBZa1/sIQMAAA==
X-CMS-MailID: 20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447
References: <20211203131534.3668411-1-ming.lei@redhat.com>
        <20211203131534.3668411-2-ming.lei@redhat.com>
        <CGME20211206103121eucas1p2ac12934f15129fe77d7f8d95c02fe447@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 03.12.2021 14:15, Ming Lei wrote:
> Remove hctx_lock and hctx_unlock, and add one helper of
> blk_mq_run_dispatch_ops() to run code block defined in dispatch_ops
> with rcu/srcu read held.
>
> Compared with hctx_lock()/hctx_unlock():
>
> 1) remove 2 branch to 1, so we just need to check
> (hctx->flags & BLK_MQ_F_BLOCKING) once when running one dispatch_ops
>
> 2) srcu_idx needn't to be touched in case of non-blocking
>
> 3) might_sleep_if() can be moved to the blocking branch
>
> Also put the added blk_mq_run_dispatch_ops() in private header, so that
> the following patch can use it out of blk-mq.c.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

This patch landed in linux next-20211206 as commit 2a904d00855f 
("blk-mq: remove hctx_lock and hctx_unlock"). It introduces a following 
'BUG' warning on my test systems (ARM/ARM64-based boards with rootfs on 
SD card or eMMC):

BUG: sleeping function called from invalid context at block/blk-mq.c:2060
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 249, name: 
kworker/0:3H
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by kworker/0:3H/249:
  #0: c1d782a8 ((wq_completion)mmc_complete){+.+.}-{0:0}, at: 
process_one_work+0x21c/0x7ec
  #1: c3b59f18 ((work_completion)(&mq->complete_work)){+.+.}-{0:0}, at: 
process_one_work+0x21c/0x7ec
  #2: c1d7858c (&mq->complete_lock){+.+.}-{3:3}, at: 
mmc_blk_mq_complete_prev_req.part.3+0x2c/0x234
  #3: c1f7a1b4 (&fq->mq_flush_lock){....}-{2:2}, at: 
mq_flush_data_end_io+0x68/0x124
irq event stamp: 16306
hardirqs last  enabled at (16305): [<c01da058>] ktime_get+0x178/0x19c
hardirqs last disabled at (16306): [<c0b7a090>] 
_raw_spin_lock_irqsave+0x24/0x60
softirqs last  enabled at (16300): [<c01016fc>] __do_softirq+0x4cc/0x5ec
softirqs last disabled at (16289): [<c012f95c>] do_softirq+0xb8/0xc4
Preemption disabled at:
[<00000000>] 0x0
CPU: 0 PID: 249 Comm: kworker/0:3H Not tainted 
5.16.0-rc3-00080-g2a904d00855f #4254
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: mmc_complete mmc_blk_mq_complete_work
[<c01110d0>] (unwind_backtrace) from [<c010cab8>] (show_stack+0x10/0x14)
[<c010cab8>] (show_stack) from [<c0b6c728>] (dump_stack_lvl+0x58/0x70)
[<c0b6c728>] (dump_stack_lvl) from [<c01594d0>] 
(__might_resched+0x248/0x298)
[<c01594d0>] (__might_resched) from [<c0512cec>] 
(blk_mq_run_hw_queue+0xac/0x230)
[<c0512cec>] (blk_mq_run_hw_queue) from [<c050f660>] 
(__blk_mq_free_request+0x84/0x90)
[<c050f660>] (__blk_mq_free_request) from [<c05086b8>] 
(blk_flush_complete_seq+0x250/0x260)
[<c05086b8>] (blk_flush_complete_seq) from [<c0508b34>] 
(mq_flush_data_end_io+0x80/0x124)
[<c0508b34>] (mq_flush_data_end_io) from [<c08a0c28>] 
(mmc_blk_mq_post_req+0xc4/0xd8)
[<c08a0c28>] (mmc_blk_mq_post_req) from [<c08a0e68>] 
(mmc_blk_mq_complete_prev_req.part.3+0x22c/0x234)
[<c08a0e68>] (mmc_blk_mq_complete_prev_req.part.3) from [<c0148980>] 
(process_one_work+0x2c8/0x7ec)
[<c0148980>] (process_one_work) from [<c0148ef4>] (worker_thread+0x50/0x584)
[<c0148ef4>] (worker_thread) from [<c015118c>] (kthread+0x13c/0x19c)
[<c015118c>] (kthread) from [<c0100108>] (ret_from_fork+0x14/0x2c)
Exception stack(0xc3b59fb0 to 0xc3b59ff8)
9fa0:                                     00000000 00000000 00000000 
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000

Please let me know if I can do something to help debugging this issue.

> ---
>   block/blk-mq.c | 57 +++++++++-----------------------------------------
>   block/blk-mq.h | 16 ++++++++++++++
>   2 files changed, 26 insertions(+), 47 deletions(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index fc4520e992b1..a9d69e1dea8b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1071,26 +1071,6 @@ void blk_mq_complete_request(struct request *rq)
>   }
>   EXPORT_SYMBOL(blk_mq_complete_request);
>   
> -static void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> -	__releases(hctx->srcu)
> -{
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> -		rcu_read_unlock();
> -	else
> -		srcu_read_unlock(hctx->srcu, srcu_idx);
> -}
> -
> -static void hctx_lock(struct blk_mq_hw_ctx *hctx, int *srcu_idx)
> -	__acquires(hctx->srcu)
> -{
> -	if (!(hctx->flags & BLK_MQ_F_BLOCKING)) {
> -		/* shut up gcc false positive */
> -		*srcu_idx = 0;
> -		rcu_read_lock();
> -	} else
> -		*srcu_idx = srcu_read_lock(hctx->srcu);
> -}
> -
>   /**
>    * blk_mq_start_request - Start processing a request
>    * @rq: Pointer to request to be started
> @@ -1947,19 +1927,13 @@ bool blk_mq_dispatch_rq_list(struct blk_mq_hw_ctx *hctx, struct list_head *list,
>    */
>   static void __blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx)
>   {
> -	int srcu_idx;
> -
>   	/*
>   	 * We can't run the queue inline with ints disabled. Ensure that
>   	 * we catch bad users of this early.
>   	 */
>   	WARN_ON_ONCE(in_interrupt());
>   
> -	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
> -
> -	hctx_lock(hctx, &srcu_idx);
> -	blk_mq_sched_dispatch_requests(hctx);
> -	hctx_unlock(hctx, srcu_idx);
> +	blk_mq_run_dispatch_ops(hctx, blk_mq_sched_dispatch_requests(hctx));
>   }
>   
>   static inline int blk_mq_first_mapped_cpu(struct blk_mq_hw_ctx *hctx)
> @@ -2071,7 +2045,6 @@ EXPORT_SYMBOL(blk_mq_delay_run_hw_queue);
>    */
>   void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   {
> -	int srcu_idx;
>   	bool need_run;
>   
>   	/*
> @@ -2082,10 +2055,9 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async)
>   	 * And queue will be rerun in blk_mq_unquiesce_queue() if it is
>   	 * quiesced.
>   	 */
> -	hctx_lock(hctx, &srcu_idx);
> -	need_run = !blk_queue_quiesced(hctx->queue) &&
> -		blk_mq_hctx_has_pending(hctx);
> -	hctx_unlock(hctx, srcu_idx);
> +	blk_mq_run_dispatch_ops(hctx,
> +		need_run = !blk_queue_quiesced(hctx->queue) &&
> +		blk_mq_hctx_has_pending(hctx));
>   
>   	if (need_run)
>   		__blk_mq_delay_run_hw_queue(hctx, async, 0);
> @@ -2488,32 +2460,22 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
>   		struct request *rq)
>   {
> -	blk_status_t ret;
> -	int srcu_idx;
> -
> -	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
> +	blk_status_t ret =
> +		__blk_mq_try_issue_directly(hctx, rq, false, true);
>   
> -	hctx_lock(hctx, &srcu_idx);
> -
> -	ret = __blk_mq_try_issue_directly(hctx, rq, false, true);
>   	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
>   		blk_mq_request_bypass_insert(rq, false, true);
>   	else if (ret != BLK_STS_OK)
>   		blk_mq_end_request(rq, ret);
> -
> -	hctx_unlock(hctx, srcu_idx);
>   }
>   
>   static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
>   {
>   	blk_status_t ret;
> -	int srcu_idx;
>   	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>   
> -	hctx_lock(hctx, &srcu_idx);
> -	ret = __blk_mq_try_issue_directly(hctx, rq, true, last);
> -	hctx_unlock(hctx, srcu_idx);
> -
> +	blk_mq_run_dispatch_ops(hctx,
> +		ret = __blk_mq_try_issue_directly(hctx, rq, true, last));
>   	return ret;
>   }
>   
> @@ -2826,7 +2788,8 @@ void blk_mq_submit_bio(struct bio *bio)
>   		  (q->nr_hw_queues == 1 || !is_sync)))
>   		blk_mq_sched_insert_request(rq, false, true, true);
>   	else
> -		blk_mq_try_issue_directly(rq->mq_hctx, rq);
> +		blk_mq_run_dispatch_ops(rq->mq_hctx,
> +				blk_mq_try_issue_directly(rq->mq_hctx, rq));
>   }
>   
>   /**
> diff --git a/block/blk-mq.h b/block/blk-mq.h
> index d516c7a46f57..e4c396204928 100644
> --- a/block/blk-mq.h
> +++ b/block/blk-mq.h
> @@ -374,5 +374,21 @@ static inline bool hctx_may_queue(struct blk_mq_hw_ctx *hctx,
>   	return __blk_mq_active_requests(hctx) < depth;
>   }
>   
> +/* run the code block in @dispatch_ops with rcu/srcu read lock held */
> +#define blk_mq_run_dispatch_ops(hctx, dispatch_ops)		\
> +do {								\
> +	if (!((hctx)->flags & BLK_MQ_F_BLOCKING)) {		\
> +		rcu_read_lock();				\
> +		(dispatch_ops);					\
> +		rcu_read_unlock();				\
> +	} else {						\
> +		int srcu_idx;					\
> +								\
> +		might_sleep();					\
> +		srcu_idx = srcu_read_lock((hctx)->srcu);	\
> +		(dispatch_ops);					\
> +		srcu_read_unlock((hctx)->srcu, srcu_idx);	\
> +	}							\
> +} while (0)
>   
>   #endif

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

