Return-Path: <SRS0=9ghM=BF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EF2C433DF
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E68F20714
	for <linux-block@archiver.kernel.org>; Sun, 26 Jul 2020 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGZQ17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jul 2020 12:27:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45778 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGZQ17 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jul 2020 12:27:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id k4so6843318pld.12
        for <linux-block@vger.kernel.org>; Sun, 26 Jul 2020 09:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f9UHPTEDgofQBm9+ddcwo7E6t/wi8mG2HVW4ymePihg=;
        b=T1aR7LhYN9LJk/40GbKlGFtg2DmpzozxDtp3sq2hs6oEJFGrwtiLpbIhiWRh3Rpeeu
         +9gkws0gVVWpr+yKfjy35ZzTIouVlU7GrtTEmkW8zNSRszXoqB3mVfvoev7J4GhbuXcT
         BwG5xqeAahzqkw+iyRNU+fr0lbvR19Ya7FE83bT1IbhuXnt5F6ES2XU9V2vgoZvF8BnQ
         rqgedvT175/+IHRx6642r/0FFsf+5EYq8fOUx+jQahs5Bq/AQt5P8BnmEJWAC0tzZTGy
         0YW5jJ1RwkHWE4lwV54p83uJ75k8vnDAhBVoR5tcHoDh6pQ1jDDAvHAwdE5FilKr2kP8
         Y3RQ==
X-Gm-Message-State: AOAM530YFtIcVT08KbZ+MicpZBjwzkBjaog0BuwIR0vwWKkNnYAy8LLD
        PJ0Hghp0CB1SwZn6fjaXfqs=
X-Google-Smtp-Source: ABdhPJwEjvjDAiFfq6ZwfROrx1GzWMZV2Q8/Vu3XfAg2cyurbDNr5/NfNHmdIYdxxKj7hnMyFUw7lA==
X-Received: by 2002:a17:902:ff16:: with SMTP id f22mr2602902plj.269.1595780878301;
        Sun, 26 Jul 2020 09:27:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:c428:8d39:30dd:38a5? ([2601:647:4802:9070:c428:8d39:30dd:38a5])
        by smtp.gmail.com with ESMTPSA id hg11sm36668pjb.38.2020.07.26.09.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 09:27:57 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
Date:   Sun, 26 Jul 2020 09:27:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200726093132.GD1110104@T590>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	blk_mq_quiesce_queue_nowait(q);
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		init_completion(&hctx->rcu_sync.completion);
>> +		init_rcu_head(&hctx->rcu_sync.head);
>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>> +				wakeme_after_rcu);
>> +		else
>> +			call_rcu(&hctx->rcu_sync.head,
>> +				wakeme_after_rcu);
>> +	}
> 
> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
> synchronize_rcu() is OK for all hctx during waiting.

That's true, but I want a single interface for both. v2 had exactly
that, but I decided that this approach is better.

Also, having the driver call a single synchronize_rcu isn't great
layering (as quiesce can possibly use a different mechanism in the 
future). So drivers assumptions like:

         /*
          * SCSI never enables blk-mq's BLK_MQ_F_BLOCKING flag so
          * calling synchronize_rcu() once is enough.
          */
         WARN_ON_ONCE(shost->tag_set.flags & BLK_MQ_F_BLOCKING);

         if (!ret)
                 synchronize_rcu();

Are not great...

>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async);
>> +
>> +void blk_mq_quiesce_queue_async_wait(struct request_queue *q)
>> +{
>> +	struct blk_mq_hw_ctx *hctx;
>> +	unsigned int i;
>> +
>> +	queue_for_each_hw_ctx(q, hctx, i) {
>> +		wait_for_completion(&hctx->rcu_sync.completion);
>> +		destroy_rcu_head(&hctx->rcu_sync.head);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_async_wait);
>> +
>>   /**
>>    * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
>>    * @q: request queue.
>> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
>> index 23230c1d031e..5536e434311a 100644
>> --- a/include/linux/blk-mq.h
>> +++ b/include/linux/blk-mq.h
>> @@ -5,6 +5,7 @@
>>   #include <linux/blkdev.h>
>>   #include <linux/sbitmap.h>
>>   #include <linux/srcu.h>
>> +#include <linux/rcupdate_wait.h>
>>   
>>   struct blk_mq_tags;
>>   struct blk_flush_queue;
>> @@ -170,6 +171,7 @@ struct blk_mq_hw_ctx {
>>   	 */
>>   	struct list_head	hctx_list;
>>   
>> +	struct rcu_synchronize	rcu_sync;
>   
> The above struct takes at least 5 words, and I'd suggest to avoid it,
> and the hctx->srcu should be re-used for waiting BLK_MQ_F_BLOCKING.
> Meantime !BLK_MQ_F_BLOCKING doesn't need it.

It is at the end and contains exactly what is needed to synchronize. Not
sure what you mean by reuse hctx->srcu?
