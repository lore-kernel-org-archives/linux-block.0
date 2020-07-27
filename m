Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767E5C433E4
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5995120729
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgG0SgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:36:12 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40127 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgG0SgM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 14:36:12 -0400
Received: by mail-pl1-f194.google.com with SMTP id l6so8562475plt.7
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 11:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5/iRfyPjaQoajA2PYsWzU8KDtKSbvhWEM8nxkAj9vrU=;
        b=tOfWRpzshRonyqlmr6pngsfhbQokCVKO4wAnQmkIKUzYER1bT4MBcIkVaH4mspJMCG
         mgOMbqxKzQ0Ftst7LJPkaMjAFnmIOQpb1v6kXzKefbmQ2UQ26ASYQCcqiNHB1MIk0xvR
         DkzXTvaTnUSO30fox8dgKCXauDq1G/4pQ8+lx3wc0weYzTEF43jJgcoUbMIbVqRXd954
         QhDtdTXFraPYirffvhRYQsdhxEwu3CdAj4uBAjq6ho3ZDnOJGU+62eNMr9d7yr9ChOTY
         VGGbNKCKChbly2WPu7UhoDW7dbu0FXFamnKmEEe4wpjfPng+55MrjBIiNZSSsUyywxpa
         6kwg==
X-Gm-Message-State: AOAM532dS+sSxHf1WElNx514R5Usb729gHmsv5Bio1VLbxbnweTAuWD/
        3bbKALg2JfXO3YLfkb08OhI=
X-Google-Smtp-Source: ABdhPJxBMbYhr78xpaCXN8tdvoA5GDb1qATLaqyTOrnGO8ZcyQmjQ2Epo+HjB5shx3APQ9K2rol5ow==
X-Received: by 2002:a17:902:b20a:: with SMTP id t10mr19269862plr.185.1595874971708;
        Mon, 27 Jul 2020 11:36:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b? ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id h131sm15860736pfe.138.2020.07.27.11.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 11:36:11 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
Date:   Mon, 27 Jul 2020 11:36:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727020803.GC1129253@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>> +{
>>>> +	struct blk_mq_hw_ctx *hctx;
>>>> +	unsigned int i;
>>>> +
>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>> +
>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>> +				wakeme_after_rcu);
>>>> +		else
>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>> +				wakeme_after_rcu);
>>>> +	}
>>>
>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>> synchronize_rcu() is OK for all hctx during waiting.
>>
>> That's true, but I want a single interface for both. v2 had exactly
>> that, but I decided that this approach is better.
> 
> Not sure one new interface is needed, and one simple way is to:
> 
> 1) call blk_mq_quiesce_queue_nowait() for each request queue
> 
> 2) wait in driver specific way
> 
> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
> then you may add per-tagset APIs for the waiting.

Because it puts assumptions on how quiesce works, which is something
I'd like to avoid because I think its cleaner, what do others think?
Jens? Christoph?

>> Also, having the driver call a single synchronize_rcu isn't great
> 
> Too many drivers are using synchronize_rcu():
> 
> 	$ git grep -n synchronize_rcu ./drivers/ | wc
> 	    186     524   11384

Wasn't talking about the usage of synchronize_rcu, was referring to
the hidden assumption that quiesce is an rcu driven operation.

>> layering (as quiesce can possibly use a different mechanism in the future).
> 
> What is the different mechanism?

Nothing specific, just said that having drivers assume that quiesce is
synchronizing rcu or srcu is not great.

>> So drivers assumptions like:
>>
>>          /*
>>           * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
>>           * calling synchronize_rcu() once is enough.
>>           */
>>          WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);
>>
>>          if (!ret)
>>                  synchronize_rcu();
>>
>> Are not great...
> 
> Both rcu read lock/unlock and synchronize_rcu is global interface, then
> it is reasonable to avoid unnecessary synchronize_rcu().

Again, the fact that quiesce translates to synchronize rcu/srcu based
on the underlying tagset is implicit.

>>>> +}
>>>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
>>>> +
>>>> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
>>>> +{
>>>> +	struct blk_mq_hw_ctx *hctx;
>>>> +	unsigned int i;
>>>> +
>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>> +		wait_for_completion(&hctx->rcu_sync.completion);
>>>> +		destroy_rcu_head(&hctx->rcu_sync.head);
>>>> +	}
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
>>>> +
>>>>    /**
>>>>     * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>>>>     * @q: request queue.
>>>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>>>> index 23230c1d031e..5536e434311a 100644
>>>> --- a/include/linux/blk-mq.h
>>>> +++ b/include/linux/blk-mq.h
>>>> @@ -5,6 +5,7 @@
>>>>    #include <linux/blkdev.h>
>>>>    #include <linux/sbitmap.h>
>>>>    #include <linux/srcu.h>
>>>> +#include <linux/rcupdate_wait.h>
>>>>    struct blk_mq_tags;
>>>>    struct blk_flush_queue;
>>>> @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
>>>>    	 */
>>>>    	struct list_head	hctx_list;
>>>> +	struct rcu_synchronize	rcu_sync;
>>> The above struct takes at least 5 words, and I'd suggest to avoid it,
>>> and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
>>> Meantime !BLK_MQ_F_BLOCKING doesn't need it.
>>
>> It is at the end and contains exactly what is needed to synchronize. Not
> 
> The sync is simply single global synchronize_rcu(), and why bother to add
> extra >=40bytes for each hctx.

We can use the heap for this, but it will slow down the operation. Not
sure if this is really meaningful given that it is in the end of the
struct...

We cannot use the stack, because we do the wait asynchronously.

>> sure what you mean by reuse hctx->srcu?
> 
> You already reuses hctx->srcu, but not see reason to add extra rcu_synchronize
> to each hctx for just simulating one single synchronize_rcu().

That is my preference, I don't want nvme or other drivers to take a
different route for blocking vs. non-bloking based on
