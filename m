Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382F5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 15:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB3B61411
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 15:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbhI3P6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Sep 2021 11:58:18 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43712 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347264AbhI3P6P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Sep 2021 11:58:15 -0400
Received: by mail-pg1-f181.google.com with SMTP id r2so6692853pgl.10
        for <linux-block@vger.kernel.org>; Thu, 30 Sep 2021 08:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DJldzFwmSWHeQ300xoIRPMAhGIh9N799MhxD2bX20is=;
        b=VniQqISsyPwdESkKM8caSvoRujx4o/laiQXxDI3TQkKy4ymGHOvh0JTEkfN1gaYsuy
         w34FXiObvVaWRLOJnOc+ScqVRAsWDvtXcBKwvK68VgCRIMfK/RrgqPEG6SVt59dTt4Zu
         c0Au4PrW7MlDA4FlunzBulZnDB0HS8sXppzvRyVN89sIxxIJO8EzILPwy+tO/eggpzzz
         AN7kRYFeZ5jrUG0T8mGJTtRK6qQ0mUxlvgEDAqHypHdfbFt17EYOjUE02wlNr/852Un5
         qEaetUycWYh6pB4KeQe3y+p7d6x7QRwsIcwfLm8eoDIDxbv8HISPzT7IMejnVEoyt2hf
         9oLA==
X-Gm-Message-State: AOAM530dG6TKAoMpUk+XPtnniBqy6YotaksCBza6sikL1A71UHXx22BH
        mTEY3d9jJouM6itIhR2wOEo=
X-Google-Smtp-Source: ABdhPJwo66gJdxFEK7jtzxS04VZrY+6cdjQhPSuzJp3+SPBs4ALUnDKc4KlZ8SrCy5nNaSywNogDgw==
X-Received: by 2002:a63:4464:: with SMTP id t36mr5645283pgk.4.1633017392259;
        Thu, 30 Sep 2021 08:56:32 -0700 (PDT)
Received: from [10.254.204.66] (50-242-106-94-static.hfc.comcastbusiness.net. [50.242.106.94])
        by smtp.gmail.com with ESMTPSA id n12sm3428888pff.166.2021.09.30.08.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 08:56:31 -0700 (PDT)
Subject: Re: [PATCH V2 5/5] blk-mq: support concurrent queue quiesce/unquiesce
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-6-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e3d6c61c-f7cf-dcb0-df2e-a8e9acf5aaaa@acm.org>
Date:   Thu, 30 Sep 2021 08:56:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210930125621.1161726-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/21 5:56 AM, Ming Lei wrote:
> Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> blk_mq_quiesce_queue() because dispatch may still be in-progress after
> queue is frozen, and in several cases, such as switching io scheduler,
> updating nr_requests & wbt latency, we still need to quiesce queue as a
> supplement of freezing queue.

Is there agreement about this? If not, how about leaving out the above from the
patch description?

> As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> for us to need support nested quiesce, especially we can't let
> unquiesce happen when there is quiesce originated from other contexts.
> 
> This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
> and we only unquiesce queue when it is the last/outer-most one of all
> contexts.
> 
> One kernel panic issue has been reported[2] when running stress test on
> dm-mpath's updating nr_requests and suspending queue, and the similar
> issue should exist on almost all drivers which use quiesce/unquiesce.
> 
> [1] https://marc.info/?l=linux-block&m=150993988115872&w=2
> [2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html

Please share the call stack of the kernel oops fixed by [2] since that
call stack is not in the patch description.

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 21bf4c3f0825..10f8a3d4e3a1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -209,7 +209,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
>    */
>   void blk_mq_quiesce_queue_nowait(struct request_queue *q)
>   {
> -	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	if (!q->quiesce_depth++)
> +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> +	spin_unlock_irqrestore(&q->queue_lock, flags);
>   }
>   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);

Consider using == 0 instead of ! to check whether or not quiesce_depth is
zero to improve code readability.

> @@ -250,10 +255,19 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
>    */
>   void blk_mq_unquiesce_queue(struct request_queue *q)
>   {
> -	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> +	unsigned long flags;
> +	bool run_queue = false;
> +
> +	spin_lock_irqsave(&q->queue_lock, flags);
> +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
> +		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> +		run_queue = true;
> +	}
> +	spin_unlock_irqrestore(&q->queue_lock, flags);
>   
>   	/* dispatch requests which are inserted during quiescing */
> -	blk_mq_run_hw_queues(q, true);
> +	if (run_queue)
> +		blk_mq_run_hw_queues(q, true);
>   }

So calling with blk_mq_unquiesce_queue() q->quiesce_depth <= 0 is ignored
quietly? How about triggering a kernel warning for that condition?

Otherwise the code changes look good to me.

Thanks,

Bart.
