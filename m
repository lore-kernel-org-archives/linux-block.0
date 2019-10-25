Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A70FCA9EBD
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3E921872
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 16:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aNd0D2BW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbfJYQSH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 12:18:07 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36540 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502249AbfJYQSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 12:18:07 -0400
Received: by mail-il1-f195.google.com with SMTP id s75so2350348ilc.3
        for <linux-block@vger.kernel.org>; Fri, 25 Oct 2019 09:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cE1b9N+JSmdmZWnadhYV9f3oWzb8Xfwnfyq0aav8ww0=;
        b=aNd0D2BWkQ7OpA6Jhxr7VLs1rJ//XD/TUSHQE3BOqNrX9ZHTcJgt3C/90uA13pVumv
         GYr9R1u8CBamW9tW2l47lF00Cqxx5j0LPimY5bp8+OECj4p4p1sM2gZXMFXb1V3/MvAQ
         GSwKVFlikMQilrFMXGSYPDbgfWJFhGilIV0viMTY9w5ACo6mQ5z9FCIx5EChrblrg9ES
         +FetKsiGJpD2EeYreSmjMcZT2npjICcCUcW6Fha0rsnAmIhlqFxPnxl//iYd/HbaD45K
         AfGFMnWq179Bc1ZtrsXpv74Q2adcBVbT7Ai7UCVxOKD5oGx+G58EmM5mLuUgj/xkiYls
         WnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cE1b9N+JSmdmZWnadhYV9f3oWzb8Xfwnfyq0aav8ww0=;
        b=XzLgBmnpzC9Hw+rP3k7Dqc3DXsp6RhhyMXlHv8dNMTtx2d0X08RYe5h1R3cVP/f8Me
         CFn5wGiS5e0+ZpHyt4DJrrUXagFfiPbgkIXVJM7+C6vBM3sM969amlcoGW0iDAC+bbFw
         sYFAoXoGamvUzxRrVm2VpLCGL7p24SuejR7GwvMiqPzarwD7xMeY4sx6WI0nPmm0EH40
         E5ix1S+1qWuswSdBJ4p6KL/STlmqn/ZxhYyWHqY15Q5WnFaL19xnb5NlGwO70ZP69kb3
         bVAyNVdHHOSZCpHmAdD5737sGyAZ5lMdSRVi7J9wFTrIwiW3qSKVsVM4a5LSIKQ1QgwX
         AfHg==
X-Gm-Message-State: APjAAAVw6HMsqvDnpDhFQosMkMaqKr47qQID27sMjjjMopLJwFuXIIyK
        4jUgTSDEgImFlFomrn4tgtR7+rfajfpFdg==
X-Google-Smtp-Source: APXvYqzBQDQbSyMQ4pev2z1Zte2MTuWWoP9fzY9GEEXgzeTXuL1BwoMQ8khRaF4oUkBn1B/Hfy5mpA==
X-Received: by 2002:a92:bb0f:: with SMTP id w15mr5517124ili.224.1572020284297;
        Fri, 25 Oct 2019 09:18:04 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i26sm320763ion.40.2019.10.25.09.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Oct 2019 09:18:03 -0700 (PDT)
Subject: Re: [BUG][RFC] Miscalculated inflight counter in io_uring
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bfecc5ba-274b-b2f7-52dc-8ac6e0fab352@gmail.com>
 <539958bc-7010-c6dc-7647-b6632b37569c@kernel.dk>
 <360f9685-084f-b174-ccee-5bfe92d0ad3a@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8cc2933-8392-ee64-6356-5c5a39bc973e@kernel.dk>
Date:   Fri, 25 Oct 2019 10:18:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <360f9685-084f-b174-ccee-5bfe92d0ad3a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/25/19 10:08 AM, Pavel Begunkov wrote:
> On 25/10/2019 18:32, Jens Axboe wrote:
>> On 10/25/19 3:48 AM, Pavel Begunkov wrote:
>>> In case of IORING_SETUP_SQPOLL | IORING_SETUP_IOPOLL:
>>>
>>> @inflight count returned by io_submit_sqes() is the number of entries
>>> picked up from a sqring including already completed/failed. And
>>> completed but not failed requests will be placed into @poll_list.
>>>
>>> Then io_sq_thread() tries to poll @inflight events, even though failed
>>> won't appear in @poll_list. Thus, it will think that there are always
>>> something to poll (i.e. @inflight > 0)
>>>
>>> There are several issues with this:
>>> 1. io_sq_thread won't ever sleep
>>> 2. io_sq_thread() may be left running and actively polling even after
>>> user process is destroyed
>>> 3. the same goes for mm_struct with all vmas of the user process
>>> TL;DR;
>>> awhile @inflight > 0, io_sq_thread won't put @cur_mm, so locking
>>> recycling of vmas used for rings' mapping, which hold refcount of
>>> io_uring's struct file. Thus, io_uring_release() won't be called, as
>>> well as kthread_{park,stop}(). That's all in case when the user process
>>> haven't unmapped rings.
>>>
>>>
>>> I'm not sure how to fix it better:
>>> 1. try to put failed into poll_list (grabbing mutex).
>>>
>>> 2. test for zero-inflight case with comparing sq and cq. something like
>>> ```
>>> if (nr_polled == 0) {
>>> 	lock(comp_lock);
>>> 	if (cached_cq_head == cached_sq_tail)
>>> 		inflight = 0;
>>> 	unlock(comp_lock);
>>> }
>>> ```
>>> But that's adds extra spinlock locking in fast-path. And that's unsafe
>>> to use non-cached heads/tails, as it could be maliciously changed by
>>> userspace.
>>>
>>> 3. Do some counting of failed (probably needs atomic or synchronisation)
>>>
>>> 4. something else?
>>
>> Can we just look at the completion count? Ala:
>>
>> prev_tail = ctx->cached_cq_tail;
>> inflight += io_submit_sqes(ctx, to_submit, cur_mm != NULL,
>>                                               mm_fault);
>> if (prev_tail != ctx->cached_cq_tail)
>> 	inflight -= (ctx->cached_cq_tail - prev_tail);
>>
>> or something like that.
>>
> 
> Don't think so:
> 1. @cached_cq_tail is protected be @completion_lock. (right?)
> Never know what happens, when you violate a memory model.
> 2. if something is successfully completed by that time, we again get
> the wrong number.
> 
> Basically, it's
> inflight = (cached_sq_head - cached_cq_tail) + len(poll_list)
> maybe you can figure out something from this.
> 
> idea 1:
> How about to count failed events and subtract it?
> But as they may fail asynchronously need synchronisation
> e.g. atomic_add() for fails (fail, slow-path)
> and atomic_load() in kthread (fast-path)

How about we just go way simpler? We only really care about if we have
any inflight requests for polling, or none at all. We don't care about
the count of them. So if we check the poll_list, and if it's empty, then
we just reset inflight. That should handle it without any extra weird
accounting, or racy logic.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 9c128df3d675..afc463a06fdc 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -874,19 +874,12 @@ static void io_iopoll_reap_events(struct io_ring_ctx *ctx)
 	mutex_unlock(&ctx->uring_lock);
 }
 
-static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
-			   long min)
+static int __io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
+			    long min)
 {
-	int iters, ret = 0;
-
-	/*
-	 * We disallow the app entering submit/complete with polling, but we
-	 * still need to lock the ring to prevent racing with polled issue
-	 * that got punted to a workqueue.
-	 */
-	mutex_lock(&ctx->uring_lock);
+	int iters, ret;
 
-	iters = 0;
+	ret = iters = 0;
 	do {
 		int tmin = 0;
 
@@ -922,6 +915,21 @@ static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		ret = 0;
 	} while (min && !*nr_events && !need_resched());
 
+	return ret;
+}
+
+static int io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
+			   long min)
+{
+	int ret;
+
+	/*
+	 * We disallow the app entering submit/complete with polling, but we
+	 * still need to lock the ring to prevent racing with polled issue
+	 * that got punted to a workqueue.
+	 */
+	mutex_lock(&ctx->uring_lock);
+	ret = __io_iopoll_check(ctx, nr_events, min);
 	mutex_unlock(&ctx->uring_lock);
 	return ret;
 }
@@ -2658,7 +2666,12 @@ static int io_sq_thread(void *data)
 			unsigned nr_events = 0;
 
 			if (ctx->flags & IORING_SETUP_IOPOLL) {
-				io_iopoll_check(ctx, &nr_events, 0);
+				mutex_lock(&ctx->uring_lock);
+				if (!list_empty(&ctx->poll_list))
+					__io_iopoll_check(ctx, &nr_events, 0);
+				else
+					inflight = 0;
+				mutex_unlock(&ctx->uring_lock);
 			} else {
 				/*
 				 * Normal IO, just pretend everything completed.

-- 
Jens Axboe

