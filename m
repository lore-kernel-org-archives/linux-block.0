Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F8C433DF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F2CB2070B
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pTZzDoy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgG0VFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgG0VFo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 17:05:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F902C061794
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 14:05:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a9so10363586pjd.3
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M6OD+yOQvORkRlTgQV/1JnSgKOlwQw4SxTkeowcTbZk=;
        b=pTZzDoy6oV2JfpdHLLKNS86nO/DyqjZGFIm6nl5rynxv/GajERZlAFawqO0LUAKZ4G
         hvLr3hqPF1Z/gGmfa1lpEFJlV6CacW3Xxx/yq/1h+bMryPKL+jL8BPEuG4yFwTFZiyzM
         L17i8uKXvuJX7OKxwEFmABLlar1nMCSMvUZvZ/knzliZrgwmXsQ8YbekXkS0bHnambLs
         sqtGHwuDgCNfiIn7OWdx0Qh4wGtTcqMJo4COPgB54ptd8QK777hhGB1Pmnr0WOSYKTPV
         QzmEuDceUeSZzQOaJrApBISFpfJUsEhDenrrPJxolp/e/9s4q2EPQfZ1ChWiVmyqqhV1
         HGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M6OD+yOQvORkRlTgQV/1JnSgKOlwQw4SxTkeowcTbZk=;
        b=S6fwgV//9dt2Ou/sUHhY80EQcKTNr5yySz/p8PgB+I21b44QPUjO8qnbViLwgE6sNv
         5gVpKyBf+aotCc5aWgArO/tBHufciQ4h9606cz58XmABhtCD8mK7bsnPbbH2nk5W07tI
         pQl3sBgplNazRwklCSiBCMxyl6bswQt2nigkTDrpGaJ7esDxZHw70fGfRXJFLHhRSycr
         yDwYLL+fLFzFei48U5u9pEchpECtIlOCVsNS0MEU/HT/qY0ETky0dqXLg1e5jySiSDio
         sim5KoyjHG9Lhjx3/p0BvoPtex+CoJ0z+AY8osvCazh0IloaX+D01VNDShjXvyQ9H/qi
         WjNQ==
X-Gm-Message-State: AOAM531N7NE9j49vx8AL6Y3TP7N1AGR/2d9X9ql59WoC6zEp9N7Vbb8c
        fuWt1FayEkwSYR/lVHoFaGxCHA==
X-Google-Smtp-Source: ABdhPJz+2MYf/0T4cwbYqtNje9/MZTK8Od4RSqrvEt6gRT4CRRVSZRurwTgj0OCnY1svQR2WEL3Xmg==
X-Received: by 2002:a17:90a:6e47:: with SMTP id s7mr1057440pjm.217.1595883942702;
        Mon, 27 Jul 2020 14:05:42 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a67sm16823682pfa.81.2020.07.27.14.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 14:05:42 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] blk-mq: add async quiesce interface
To:     Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Chao Leng <lengchao@huawei.com>
References: <20200726002301.145627-1-sagi@grimberg.me>
 <20200726002301.145627-2-sagi@grimberg.me> <20200726093132.GD1110104@T590>
 <9ac5f658-31b3-bb19-e5fe-385a629a7d67@grimberg.me>
 <20200727020803.GC1129253@T590>
 <2c2ae567-6953-5b7f-2fa1-a65e287b5a9d@grimberg.me>
 <f2fc0ecf-b599-678f-7241-fcd44cde6fab@kernel.dk>
 <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23ad666a-af6a-b110-441e-43ec0f833af4@kernel.dk>
Date:   Mon, 27 Jul 2020 15:05:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bcb8f89b-8477-c48b-1e0f-947cbe741818@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/20 3:00 PM, Sagi Grimberg wrote:
> 
>>>>>>> +void blk_mq_quiesce_queue_async(struct request_queue *q)
>>>>>>> +{
>>>>>>> +	struct blk_mq_hw_ctx *hctx;
>>>>>>> +	unsigned int i;
>>>>>>> +
>>>>>>> +	blk_mq_quiesce_queue_nowait(q);
>>>>>>> +
>>>>>>> +	queue_for_each_hw_ctx(q, hctx, i) {
>>>>>>> +		init_completion(&hctx->rcu_sync.completion);
>>>>>>> +		init_rcu_head(&hctx->rcu_sync.head);
>>>>>>> +		if (hctx->flags & BLK_MQ_F_BLOCKING)
>>>>>>> +			call_srcu(hctx->srcu, &hctx->rcu_sync.head,
>>>>>>> +				wakeme_after_rcu);
>>>>>>> +		else
>>>>>>> +			call_rcu(&hctx->rcu_sync.head,
>>>>>>> +				wakeme_after_rcu);
>>>>>>> +	}
>>>>>>
>>>>>> Looks not necessary to do anything in case of !BLK_MQ_F_BLOCKING, and single
>>>>>> synchronize_rcu() is OK for all hctx during waiting.
>>>>>
>>>>> That's true, but I want a single interface for both. v2 had exactly
>>>>> that, but I decided that this approach is better.
>>>>
>>>> Not sure one new interface is needed, and one simple way is to:
>>>>
>>>> 1) call blk_mq_quiesce_queue_nowait() for each request queue
>>>>
>>>> 2) wait in driver specific way
>>>>
>>>> Or just wondering why nvme doesn't use set->tag_list to retrieve NS,
>>>> then you may add per-tagset APIs for the waiting.
>>>
>>> Because it puts assumptions on how quiesce works, which is something
>>> I'd like to avoid because I think its cleaner, what do others think?
>>> Jens? Christoph?
>>
>> I'd prefer to have it in a helper, and just have blk_mq_quiesce_queue()
>> call that.
> 
> I agree with this approach as well.
> 
> Jens, this mean that we use the call_rcu mechanism also for non-blocking
> hctxs, because the caller  will call it for multiple request queues (see
> patch 2) and we don't want to call synchronize_rcu for every request
> queue serially, we want it to happen in parallel.
> 
> Which leaves us with the patchset as it is, just to convert the
> rcu_synchronize structure to be dynamically allocated on the heap
> rather than keeping it statically allocated in the hctx.
> 
> This is how it looks:

OK, so maybe I'm not fully up-to-date on the thread, but why aren't we
just having a blk_mq_quiesce_queue_wait() that does something ala:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 667155f752f7..b4ceaaed2f9c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -209,32 +209,37 @@ void blk_mq_quiesce_queue_nowait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
 
-/**
- * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
- * @q: request queue.
- *
- * Note: this function does not prevent that the struct request end_io()
- * callback function is invoked. Once this function is returned, we make
- * sure no dispatch can happen until the queue is unquiesced via
- * blk_mq_unquiesce_queue().
- */
-void blk_mq_quiesce_queue(struct request_queue *q)
+void blk_mq_quiesce_queue_wait(struct request_queue *q)
 {
 	struct blk_mq_hw_ctx *hctx;
 	unsigned int i;
 	bool rcu = false;
 
-	blk_mq_quiesce_queue_nowait(q);
-
 	queue_for_each_hw_ctx(q, hctx, i) {
 		if (hctx->flags & BLK_MQ_F_BLOCKING)
 			synchronize_srcu(hctx->srcu);
 		else
 			rcu = true;
 	}
+
 	if (rcu)
 		synchronize_rcu();
 }
+
+/**
+ * blk_mq_quiesce_queue() - wait until all ongoing dispatches have finished
+ * @q: request queue.
+ *
+ * Note: this function does not prevent that the struct request end_io()
+ * callback function is invoked. Once this function is returned, we make
+ * sure no dispatch can happen until the queue is unquiesced via
+ * blk_mq_unquiesce_queue().
+ */
+void blk_mq_quiesce_queue(struct request_queue *q)
+{
+	blk_mq_quiesce_queue_nowait(q);
+	blk_mq_quiesce_queue_wait(q);
+}
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
 
 /*

Do we care about BLK_MQ_F_BLOCKING runtime at all?

-- 
Jens Axboe

