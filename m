Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB08C433ED
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 21:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573AF6139B
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 21:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbhDEVey (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 17:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbhDEVeu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 17:34:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3888BC061756
        for <linux-block@vger.kernel.org>; Mon,  5 Apr 2021 14:34:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id a6so2990601pls.1
        for <linux-block@vger.kernel.org>; Mon, 05 Apr 2021 14:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZmFgi3PmmRe1wsH3utNoiIpOcro2FjzoeYSs8qnjOA=;
        b=iWurfUBb+Iq8jKaOqMzybmGEwJto6As0LQjV2qKUFMNkKjltiJdmwA5M62d+8xgJbm
         ZTPQN8zViw6O1oOUlojXuYB4A4++3ZYz9DJ7YqzsXRFzeesHo8StRKUzCDxV7d8MT9rR
         wQ5TXqS2Swi/g/a/lPYe9mJ1cVbkBbHdFURohuJdXCAWAxeJ1C3ysW0znHoN1S6/5ohB
         5p9UxCMfUIRpR1o0wuvNyNBFUHzqP8GldrGWOeshTpvMXeOh/Uvun+LIj/rs6KaEQM2L
         OMrILHDr/sYmt8vneJc/ch2nvJ2JsgoKWbI6zu16MMyOHzDfEp0NRJImBuE/x3l7dZ9E
         cq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZmFgi3PmmRe1wsH3utNoiIpOcro2FjzoeYSs8qnjOA=;
        b=Enky8+errnkrr/2tMTSTJqPhJh4oVlkHAk55W6SVmHLFh4LXs6oVJwejFDbykaWTeA
         5Q6gdWlvdqMJZC9cjDFn1WIHJCASaj1RahetZM7gWvSPHDGkjVTAeAniXKxyxaHZF1RA
         D+DdtBJuzUpulnctMmMBsv+yMGcJNBiDbJi/ajaIgfQSKKhwxxAQS8FyUlNk1oVfbyi0
         ORQUSec7mjf3L+iXtOMGryZfaZoaaloJxL8laAmu6B5GRtk6m8tWWF2DPkezODZf2fYQ
         EybB63cA7gooE6/rEru0ycgB0ibdqEAUXMn6OXdqXvys17N9qVm9d0swu2j+5TkLFvwd
         G5EA==
X-Gm-Message-State: AOAM532kaVqjXZow+0gHBMNheKPZ/EV54GvY7E5hF2My2x1MonrHqvdc
        fXpfaDS27FdcZXRYhc4C14iWFA==
X-Google-Smtp-Source: ABdhPJwao9ArrDtO6bkFV+KgBKljGTh751JJS5duSO6lKTn8ewtD6hGNKf6mD5iV01OG1FXEWoMAug==
X-Received: by 2002:a17:902:e98c:b029:e5:defc:ccf8 with SMTP id f12-20020a170902e98cb02900e5defcccf8mr25475226plb.20.1617658482675;
        Mon, 05 Apr 2021 14:34:42 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id v19sm16735238pfc.183.2021.04.05.14.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 14:34:41 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] blk-mq: Fix a race between iterating over requests
 and freeing requests
To:     Khazhy Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20210405002834.32339-1-bvanassche@acm.org>
 <20210405002834.32339-4-bvanassche@acm.org>
 <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54474b65-ffa4-9335-f7a2-5b49ccf169d4@kernel.dk>
Date:   Mon, 5 Apr 2021 15:34:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACGdZYJh6ZvVekC8eBvz3SmN-TH8hTAmMQrvHtLJsKyL3R_fLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/21 12:08 PM, Khazhy Kumykov wrote:
> On Sun, Apr 4, 2021 at 5:28 PM Bart Van Assche <bvanassche@acm.org> wrote:
>> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
>> index 116c3691b104..e7a6a114d216 100644
>> --- a/block/blk-mq-tag.c
>> +++ b/block/blk-mq-tag.c
>> @@ -209,7 +209,11 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>>
>>         if (!reserved)
>>                 bitnr += tags->nr_reserved_tags;
>> -       rq = tags->rqs[bitnr];
>> +       /*
>> +        * Protected by rq->q->q_usage_counter. See also
>> +        * blk_mq_queue_tag_busy_iter().
>> +        */
>> +       rq = rcu_dereference_check(tags->rqs[bitnr], true);
> 
> maybe I'm missing something, but if this tags struct has a shared
> sbitmap, what guarantees do we have that while iterating we won't
> touch requests from a queue that's tearing down? The check a few lines
> below suggests that at the least we may touch requests from a
> different queue.
> 
> say we enter blk_mq_queue_tag_busy_iter, we're iterating with raised
> hctx->q->q_usage_counter, and get to bt_iter
> 
> say tagset has 2 shared queues, hctx->q is q1, rq->q is q2
> (thread 1)
> rq = rcu_deref_check
> (rq->q != hctx->q, but we don't know yet)
> 
> (thread 2)
> elsewhere, blk_cleanup_queue(q2) runs (or elevator_exit), since we
> only have raised q_usage_counter on q1, this goes to completion and
> frees rq. if we have preempt kernel, thread 1 may be paused before we
> read rq->q, so synchonrize_rcu passes happily by
> 
> (thread 1)
> we check rq && rq->q == hctx->q, use-after-free since rq was freed above
> 
> I think John Garry mentioned observing a similar race in patch 2 of
> his series, perhaps his test case can verify this?
> 
> "Indeed, blk_mq_queue_tag_busy_iter() already does take a reference to its
> queue usage counter when called, and the queue cannot be frozen to switch
> IO scheduler until all refs are dropped. This ensures no stale references
> to IO scheduler requests will be seen by blk_mq_queue_tag_busy_iter().
> 
> However, there is nothing to stop blk_mq_queue_tag_busy_iter() being
> run for another queue associated with the same tagset, and it seeing
> a stale IO scheduler request from the other queue after they are freed."
> 
> so, to my understanding, we have a race between reading
> tags->rq[bitnr], and verifying that rq->q == hctx->q, where if we
> schedule off we might have use-after-free? If that's the case, perhaps
> we should rcu_read_lock until we verify the queues match, then we can
> release and run fn(), as we verified we no longer need it?

For something out of left field, we can check if the page that the rq
belongs to is still part of the tag set. If it isn't, then don't
deref it.

Totally untested.

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e5bfecf2940d..6209c465e884 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -196,9 +196,35 @@ struct bt_iter_data {
 	struct blk_mq_hw_ctx *hctx;
 	busy_iter_fn *fn;
 	void *data;
+	struct page *last_lookup;
 	bool reserved;
 };
 
+static bool rq_from_queue(struct bt_iter_data *iter_data, struct request *rq)
+{
+	struct blk_mq_hw_ctx *hctx = iter_data->hctx;
+	struct page *rq_page, *page;
+
+	/*
+	 * We can hit rq == NULL here, because the tagging functions
+	 * test and set the bit before assigning ->rqs[].
+	 */
+	if (!rq)
+		return false;
+	rq_page = virt_to_page(rq);
+	if (rq_page == iter_data->last_lookup)
+		goto check_queue;
+	list_for_each_entry(page, &hctx->tags->page_list, lru) {
+		if (page == rq_page) {
+			iter_data->last_lookup = page;
+			goto check_queue;
+		}
+	}
+	return false;
+check_queue:
+	return rq->q == hctx->queue && rq->mq_hctx == hctx;
+}
+
 static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 {
 	struct bt_iter_data *iter_data = data;
@@ -211,11 +237,7 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
 		bitnr += tags->nr_reserved_tags;
 	rq = tags->rqs[bitnr];
 
-	/*
-	 * We can hit rq == NULL here, because the tagging functions
-	 * test and set the bit before assigning ->rqs[].
-	 */
-	if (rq && rq->q == hctx->queue && rq->mq_hctx == hctx)
+	if (rq_from_queue(iter_data, rq))
 		return iter_data->fn(hctx, rq, iter_data->data, reserved);
 	return true;
 }

-- 
Jens Axboe

