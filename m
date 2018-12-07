Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F7C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248E220837
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JfJFV2n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248E220837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLGQfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:35:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35921 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbeLGQfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 11:35:09 -0500
Received: by mail-io1-f66.google.com with SMTP id m19so3756424ioh.3
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 08:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Rf7fqHu64tMHbdQyr+dFH7v+pJzc1qBb5rk0lTgu8k=;
        b=JfJFV2n9LzfBUJd7NyZ4RvuiEzltOYb5KrFcRiwH4CAq1/a1PlpvOx/Ryvhs22/YRL
         2p1fqEpw+YxVDqY6RvmhoeoLGiw/f9gvPMBv335Puo64OBLDmqy3vwCHua3DrVxD7+eq
         gCAWtoudZMCQpE1tlBn+OSFdncxkbQwprBFDAvEp3fiAUmZxUKAjOgGdk89D4LGEM1as
         oCTamf0LxekLPZ4vDToSHIzVJVTIg0oeEu28aNedBKIYtI84msSsQXbTbedNunAloIW5
         pHwxNgdA0gxJSNGoUdQs6FrDtWYKfDexH1+gA+ygZUZnKdYgvfB4zqwEYfMv2F8aIhGw
         rSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Rf7fqHu64tMHbdQyr+dFH7v+pJzc1qBb5rk0lTgu8k=;
        b=AB4tDpZweI4l9PzxHh2mJSejcV4BNoaEJy0iuc8Mv3pnOwq1g+zS/NVWhbF6sBKBzh
         tG4pMFpkz+xkoj3flBqhYzfk27riTRioxOdcChWSLVXEMd9kv58JYK9GohGQO8/k2uva
         TcIUl4eldmyk+14NCYlyHIxGlupQh9g1Dyi/jnIvQqOlLaKh6FVq33Td7ME+TiNV3UYq
         MIrsL5/1XyNaDT8R5VZaRx2m0fOz/WrELwYku2xVjRtk9xIMTp/G6xNivVEpVQs+2+t4
         4t0/5cFn877yrfxh7vgzTc4lq86o6SrPL7PeGnETZVTZLsbxhNCGB+aq3f8uCN7ssSDU
         s+DA==
X-Gm-Message-State: AA+aEWZ1y/vsDq8OXv08c6RIVjnoApSnsGnKUHDRAo2pm8ELVrFup7CW
        hA53I1IvWOkJ4US7eLtnI2tmSw==
X-Google-Smtp-Source: AFSGD/WBzTFoyqGSv0xAmU+g3K9DWmAPdsbSmt78DqPVTNSW1pcBDN9k+gWO1P5EHQLprMhEVJfO+g==
X-Received: by 2002:a5d:88ce:: with SMTP id i14mr2432827iol.66.1544200508022;
        Fri, 07 Dec 2018 08:35:08 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o18sm1370825ioh.31.2018.12.07.08.35.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 08:35:07 -0800 (PST)
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
 <1544199585.185366.303.camel@acm.org>
 <693ac87a-ebb5-2e4e-25e5-92a1d3865c8f@kernel.dk>
Message-ID: <7eaf8a39-3628-e153-79c9-0f115a4392d4@kernel.dk>
Date:   Fri, 7 Dec 2018 09:35:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <693ac87a-ebb5-2e4e-25e5-92a1d3865c8f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/7/18 9:24 AM, Jens Axboe wrote:
> On 12/7/18 9:19 AM, Bart Van Assche wrote:
>> On Thu, 2018-12-06 at 22:17 -0700, Jens Axboe wrote:
>>> Instead of making special cases for what we can direct issue, and now
>>> having to deal with DM solving the livelock while still retaining a BUSY
>>> condition feedback loop, always just add a request that has been through
>>> ->queue_rq() to the hardware queue dispatch list. These are safe to use
>>> as no merging can take place there. Additionally, if requests do have
>>> prepped data from drivers, we aren't dependent on them not sharing space
>>> in the request structure to safely add them to the IO scheduler lists.
>>
>> How about making blk_mq_sched_insert_request() complain if a request is passed
>> to it in which the RQF_DONTPREP flag has been set to avoid that this problem is
>> reintroduced in the future? Otherwise this patch looks fine to me.
> 
> I agree, but I think we should do that as a follow up patch. I don't want to
> touch this one if we can avoid it. The thought did cross my mind, too. It
> should be impossible now that everything goes to the dispatch list.

Something like the below.


diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 29bfe8017a2d..9e5bda8800f8 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -377,6 +377,16 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 
 	WARN_ON(e && (rq->tag != -1));
 
+	/*
+	 * It's illegal to insert a request into the scheduler that has
+	 * been through ->queue_rq(). Warn for that case, and use a bypass
+	 * insert to be safe.
+	 */
+	if (WARN_ON_ONCE(rq->rq_flags & RQF_DONTPREP)) {
+		blk_mq_request_bypass_insert(rq, false);
+		goto run;
+	}
+
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq))
 		goto run;
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6a7566244de3..d5f890d5c814 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1595,15 +1595,25 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *hctx, struct blk_mq_ctx *ctx,
 			    struct list_head *list)
 
 {
-	struct request *rq;
+	struct request *rq, *tmp;
 
 	/*
 	 * preemption doesn't flush plug list, so it's possible ctx->cpu is
 	 * offline now
 	 */
-	list_for_each_entry(rq, list, queuelist) {
+	list_for_each_entry_safe(rq, tmp, list, queuelist) {
 		BUG_ON(rq->mq_ctx != ctx);
 		trace_block_rq_insert(hctx->queue, rq);
+
+		/*
+		 * It's illegal to insert a request into the scheduler that has
+		 * been through ->queue_rq(). Warn for that case, and use a
+		 * bypass insert to be safe.
+		 */
+		if (WARN_ON_ONCE(rq->rq_flags & RQF_DONTPREP)) {
+			list_del_init(&rq->queuelist);
+			blk_mq_request_bypass_insert(rq, false);
+		}
 	}
 
 	spin_lock(&ctx->lock);

-- 
Jens Axboe

