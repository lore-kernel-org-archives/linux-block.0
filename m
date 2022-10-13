Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F33C433FE
	for <linux-block@archiver.kernel.org>; Thu, 13 Oct 2022 10:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiJMK2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMK2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Oct 2022 06:28:42 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2438FAA65
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 03:28:40 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id bk15so2066980wrb.13
        for <linux-block@vger.kernel.org>; Thu, 13 Oct 2022 03:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUcKJbXBOEpbBfA0pU0i0kCUvjBr6lSt0Uq5+NFkwQ8=;
        b=gf0ux+pGeM3oJndhhHX1n0j5vsLX1d/TeunYIv6PtqYUYLc/vOGD5KdSgPwaUWiUtq
         MEXoWnXd3XyY03M71GlTaWHSot+qYIQJN5fNJSIL6YQBO3LF5ZZx2khoC8rb0HFCGnLQ
         ypprCDScfuYNAo9kLZj9kw3SZg2g7zGPq12q7stcBzvS96U3pFYemX+gdqvPF+3k/HE/
         R1c9CX/D34ZVAm1CpvgL4PVQnZG3+qnig/ppDIO+W/8RoTrZx+Fg8nTdqRTKjqwglFd1
         uZqk278qB4ypCrdgxg1Gj8BuO7XhflUb1UeXhRJgnNGjdPOcpUfqz1gBogYn1u+TKTK0
         UAQA==
X-Gm-Message-State: ACrzQf0hF5hNHAmCHlgpwR3c/yd35aH3hIZJt69bzbxZiLdjAQhF1OOB
        G6EfS1OvJtWadZFKehwUTWo=
X-Google-Smtp-Source: AMsMyM7RflpqOJLx3tuHzisp4dlDMizKRV39aONKPGY5HRvNXGWT7Srx0srIFf2dg91sCJyXcjGBgA==
X-Received: by 2002:a05:6000:1689:b0:22e:2c03:36e7 with SMTP id y9-20020a056000168900b0022e2c0336e7mr21828088wrd.252.1665656919270;
        Thu, 13 Oct 2022 03:28:39 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m20-20020adfc594000000b0022abcc1e3cesm1699179wrg.116.2022.10.13.03.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 03:28:38 -0700 (PDT)
Message-ID: <99dac305-206c-4e1b-a1ec-50e107258b6b@grimberg.me>
Date:   Thu, 13 Oct 2022 13:28:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Content-Language: en-US
To:     Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com, axboe@kernel.dk
References: <20221013094450.5947-1-lengchao@huawei.com>
 <20221013094450.5947-2-lengchao@huawei.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221013094450.5947-2-lengchao@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 10/13/22 12:44, Chao Leng wrote:
> Drivers that have shared tagsets may need to quiesce potentially a lot
> of request queues that all share a single tagset (e.g. nvme). Add an interface
> to quiesce all the queues on a given tagset. This interface is useful because
> it can speedup the quiesce by doing it in parallel.
> 
> For tagsets that have BLK_MQ_F_BLOCKING set, we use call_srcu to all hctxs
> in parallel such that all of them wait for the same rcu elapsed period with
> a per-hctx heap allocated rcu_synchronize. for tagsets that don't have
> BLK_MQ_F_BLOCKING set, we simply call a single synchronize_rcu as this is
> sufficient.
> 
> Because some queues never need to be quiesced(e.g. nvme connect_q).
> So introduce QUEUE_FLAG_NOQUIESCED to tagset quiesce interface to
> skip the queue.

I wouldn't say it never nor will ever quiesce, we just don't happen to
quiesce it today...

> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Chao Leng <lengchao@huawei.com>
> ---
>   block/blk-mq.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/blk-mq.h |  2 ++
>   include/linux/blkdev.h |  2 ++
>   3 files changed, 79 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8070b6c10e8d..ebe25da08156 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -29,6 +29,7 @@
>   #include <linux/prefetch.h>
>   #include <linux/blk-crypto.h>
>   #include <linux/part_stat.h>
> +#include <linux/rcupdate_wait.h>
>   
>   #include <trace/events/block.h>
>   
> @@ -311,6 +312,80 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_unquiesce_queue);
>   
> +static void blk_mq_quiesce_blocking_tagset(struct blk_mq_tag_set *set)
> +{
> +	int i = 0;
> +	int count = 0;
> +	struct request_queue *q;
> +	struct rcu_synchronize *rcu;
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (blk_queue_noquiesced(q))
> +			continue;
> +
> +		blk_mq_quiesce_queue_nowait(q);
> +		count++;
> +	}
> +
> +	rcu = kvmalloc(count * sizeof(*rcu), GFP_KERNEL);
> +	if (rcu) {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +			if (blk_queue_noquiesced(q))
> +				continue;
> +
> +			init_rcu_head(&rcu[i].head);
> +			init_completion(&rcu[i].completion);
> +			call_srcu(q->srcu, &rcu[i].head, wakeme_after_rcu);
> +			i++;
> +		}
> +
> +		for (i = 0; i < count; i++) {
> +			wait_for_completion(&rcu[i].completion);
> +			destroy_rcu_head(&rcu[i].head);
> +		}
> +		kvfree(rcu);
> +	} else {
> +		list_for_each_entry(q, &set->tag_list, tag_set_list)
> +			synchronize_srcu(q->srcu);
> +	}
> +}
> +
> +static void blk_mq_quiesce_nonblocking_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	list_for_each_entry(q, &set->tag_list, tag_set_list) {
> +		if (blk_queue_noquiesced(q))
> +			continue;
> +
> +		blk_mq_quiesce_queue_nowait(q);
> +	}
> +	synchronize_rcu();
> +}
> +
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	mutex_lock(&set->tag_list_lock);
> +	if (set->flags & BLK_MQ_F_BLOCKING)
> +		blk_mq_quiesce_blocking_tagset(set);
> +	else
> +		blk_mq_quiesce_nonblocking_tagset(set);
> +
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_tagset);
> +
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set)
> +{
> +	struct request_queue *q;
> +
> +	mutex_lock(&set->tag_list_lock);
> +	list_for_each_entry(q, &set->tag_list, tag_set_list)
> +		blk_mq_unquiesce_queue(q);
> +	mutex_unlock(&set->tag_list_lock);
> +}
> +EXPORT_SYMBOL_GPL(blk_mq_unquiesce_tagset);
> +
>   void blk_mq_wake_waiters(struct request_queue *q)
>   {
>   	struct blk_mq_hw_ctx *hctx;
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index ba18e9bdb799..1df47606d0a7 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -877,6 +877,8 @@ void blk_mq_start_hw_queues(struct request_queue *q);
>   void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
>   void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
>   void blk_mq_quiesce_queue(struct request_queue *q);
> +void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);
> +void blk_mq_unquiesce_tagset(struct blk_mq_tag_set *set);
>   void blk_mq_wait_quiesce_done(struct request_queue *q);
>   void blk_mq_unquiesce_queue(struct request_queue *q);
>   void blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, unsigned long msecs);
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 50e358a19d98..f15544299a67 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -579,6 +579,7 @@ struct request_queue {
>   #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>   #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
>   #define QUEUE_FLAG_SQ_SCHED     30	/* single queue style io dispatch */
> +#define QUEUE_FLAG_NOQUIESCED	31	/* queue is never quiesced */

the comment is misleading. If this is truely queue that is never
quiescing then blk_mq_quiesce_queue() and friends need to skip it.

I'd call it self_quiesce or something that would reflect that it is
black-listed from tagset-wide quiesce.
