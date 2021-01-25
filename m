Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E97C433DB
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 07:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2405222C9F
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 07:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbhAYHp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 02:45:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:46204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727337AbhAYHoj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 02:44:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3AD6DAD62;
        Mon, 25 Jan 2021 07:10:17 +0000 (UTC)
Subject: Re: [PATCH 2/3] blk-mq: Always complete remote completions requests
 in softirq
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <20210123201027.3262800-1-bigeasy@linutronix.de>
 <20210123201027.3262800-3-bigeasy@linutronix.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <30ce5ce2-8b9a-8873-4b37-c8720300942b@suse.de>
Date:   Mon, 25 Jan 2021 08:10:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210123201027.3262800-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/23/21 9:10 PM, Sebastian Andrzej Siewior wrote:
> Controllers with multiple queues have their IRQ-handelers pinned to a
> CPU. The core shouldn't need to complete the request on a remote CPU.
> 
> Remove this case and always raise the softirq to complete the request.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   block/blk-mq.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index f285a9123a8b0..90348ae518461 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -628,19 +628,7 @@ static void __blk_mq_complete_request_remote(void *data)
>   {
>   	struct request *rq = data;
>   
> -	/*
> -	 * For most of single queue controllers, there is only one irq vector
> -	 * for handling I/O completion, and the only irq's affinity is set
> -	 * to all possible CPUs.  On most of ARCHs, this affinity means the irq
> -	 * is handled on one specific CPU.
> -	 *
> -	 * So complete I/O requests in softirq context in case of single queue
> -	 * devices to avoid degrading I/O performance due to irqsoff latency.
> -	 */
> -	if (rq->q->nr_hw_queues == 1)
> -		blk_mq_trigger_softirq(rq);
> -	else
> -		rq->q->mq_ops->complete(rq);
> +	blk_mq_trigger_softirq(rq);
>   }
>   
>   static inline bool blk_mq_complete_need_ipi(struct request *rq)
> 
I don't get this.
This code is about _avoiding_ having to raise a softirq if the driver 
exports more than one hardware queue.
So where exactly does the remote CPU case come in here?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
