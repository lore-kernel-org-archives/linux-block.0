Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05546C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819CD20700
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 04:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tcQo4t+s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819CD20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGElz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 23:41:55 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38777 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGElz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 23:41:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so1305738pfi.5
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 20:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qs9R+kNxHiKBzgix7dwLXqSDH0DdtG2Tjb7XJxwoPK4=;
        b=tcQo4t+sgPzzQvkAme0aOU6WaonwEY4A1vnKZRq6mp9C5MomvcQF17VdtUUmbgk2qq
         lzbT4ZXJbyNvPpD1vWjwQOGR0G9LX/wsZh2Lrmwe3Osokd9Kv7or6zV4FmpX4rqVyMg+
         5zzZ9rlhyY1n1+jIndNCI9qklLofxW3+y+7XM8uuIcmXSC2/4LyNRT847xweB483NvJF
         n3ButercdXCQAqPrkQ3RVbwb7a4CiFbo5GDzc5COX81Lg4mjaD3f1NZE3RlkZf7cj5mz
         9aVbW1ETeNi/sTKUjAekhqP89fgBaLFAAMPCAhd8lgxQ5E18C+SS2caV37i/IL2Be9Cz
         A1Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qs9R+kNxHiKBzgix7dwLXqSDH0DdtG2Tjb7XJxwoPK4=;
        b=ZCiJHjvyW30DeVcIXLCKRkDViPptbY+5bY2im1sOeapj9Mz9izEdKdnD0Pm0lxSFZY
         ddSgIxlzYZ5PhESfssZ7B+zPzKEti+3lPCn4su8zRp1yEuLc28oRuksfjIV98e9iFrv8
         rH71fIf6SPfO3MZ9P1N8bde8RHStifPkio1MDZ3WR97tMIEE5W/o1kj+BrhTXfhH3n9c
         ED1yvhjiEYKQm/8EgLSutHKtMaYlmRJuIKZCMKeuCHNPNzHt/WLbIbTPubuDyAiSIn8Z
         6Lm6cTnRJ1HikuZL3nfxmq0M1Vu8DOzGxFHdRaBb/Z8YqrhqabPbq7WzA9FZ7lRaQFc3
         xvCA==
X-Gm-Message-State: AA+aEWaRhmpj4AnPIeKL7MBeh+K596YYlHu489r8oScT3cFBTNepgH30
        U1VG/N7ZWspPYMVvupjN0XeWHw==
X-Google-Smtp-Source: AFSGD/Wqeg3igKJsJPn+f4rUrwf3MSucN4uMjEr89tJOSizeRd1qwrPt3OCkMEECBgrQYmkiRwvzVw==
X-Received: by 2002:a63:c447:: with SMTP id m7mr690627pgg.27.1544157714192;
        Thu, 06 Dec 2018 20:41:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id l3sm2605892pga.92.2018.12.06.20.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 20:41:52 -0800 (PST)
Subject: Re: [PATCH v2] block/dm: fix handling of busy off direct dispatch
 path
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <e6024b99-579a-ce20-ca3a-a9983582ea36@kernel.dk>
 <20181207035449.GB17585@redhat.com>
 <5fa50933-2bd0-9ad5-ce60-4b4b130b2841@kernel.dk>
 <20181207041843.GA18124@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6fda4343-bce4-763b-1eb6-b3c4ad6418f5@kernel.dk>
Date:   Thu, 6 Dec 2018 21:41:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207041843.GA18124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 9:18 PM, Mike Snitzer wrote:
> On Thu, Dec 06 2018 at 11:06pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> On 12/6/18 8:54 PM, Mike Snitzer wrote:
>>> On Thu, Dec 06 2018 at  9:49pm -0500,
>>> Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>>> After the direct dispatch corruption fix, we permanently disallow direct
>>>> dispatch of non read/write requests. This works fine off the normal IO
>>>> path, as they will be retried like any other failed direct dispatch
>>>> request. But for the blk_insert_cloned_request() that only DM uses to
>>>> bypass the bottom level scheduler, we always first attempt direct
>>>> dispatch. For some types of requests, that's now a permanent failure,
>>>> and no amount of retrying will make that succeed.
>>>>
>>>> Use the driver private RQF_DONTPREP to track this condition in DM. If
>>>> we encounter a BUSY condition from blk_insert_cloned_request(), then
>>>> flag the request with RQF_DONTPREP. When we next time see this request,
>>>> ask blk_insert_cloned_request() to bypass insert the request directly.
>>>> This avoids the livelock of repeatedly trying to direct dispatch a
>>>> request, while still retaining the BUSY feedback loop for blk-mq so
>>>> that we don't over-dispatch to the lower level queue and mess up
>>>> opportunities for merging on the DM queue.
>>>>
>>>> Fixes: ffe81d45322c ("blk-mq: fix corruption with direct issue")
>>>> Reported-by: Bart Van Assche <bvanassche@acm.org>
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> This passes my testing as well, like the previous patch. But unlike the
>>>> previous patch, we retain the BUSY feedback loop information for better
>>>> merging.
>>>
>>> But it is kind of gross to workaround the new behaviour to "permanently
>>> disallow direct dispatch of non read/write requests" by always failing
>>> such requests back to DM for later immediate direct dispatch.  That
>>> bouncing of the request was acceptable when there was load-based
>>> justification for having to retry (and in doing so: taking the cost of
>>> freeing the clone request gotten via get_request() from the underlying
>>> request_queues).
>>>
>>> Having to retry like this purely because the request isn't a read or
>>> write seems costly.. every non-read-write will have implied
>>> request_queue bouncing.  In multipath's case: it could select an
>>> entirely different underlying path the next time it is destaged (with
>>> RQF_DONTPREP set).  Which you'd think would negate all hope of IO
>>> merging based performance improvements -- but that is a tangent I'll
>>> need to ask Ming about (again).
>>>
>>> I really don't like this business of bouncing requests as a workaround
>>> for the recent implementation of the corruption fix.
>>>
>>> Why not just add an override flag to _really_ allow direct dispatch for
>>> _all_ types of requests?
>>>
>>> (just peeked at linux-block and it is looking like you took 
>>> jianchao.wang's series to avoid this hack... ;)
>>>
>>> Awesome.. my work is done for tonight!
>>
>> The whole point is doing something that is palatable to 4.20 and leaving
>> the more experimental stuff to 4.21, where we have some weeks to verify
>> that there are no conditions that cause IO stalls. I don't envision there
>> will be, but I'm not willing to risk it this late in the 4.20 cycle.
>>
>> That said, this isn't a quick and dirty and I don't think it's fair
>> calling this a hack. Using RQF_DONTPREP is quite common in drivers to
>> retain state over multiple ->queue_rq invocations. Using it to avoid
>> multiple direct dispatch failures (and obviously this new livelock)
>> seems fine to me.
> 
> But it bounces IO purely because non-read-write.  That results in
> guaranteed multiple blk_get_request() -- from underlying request_queues
> request-based DM is stacked on -- for every non-read-write IO that is
> cloned.  That seems pathological.  I must still be missing something.
> 
>> I really don't want to go around and audit every driver for potential
>> retained state over special commands, that's why the read+write thing is
>> in place. It's the safe option, which is what we need right now.
> 
> Maybe leave blk_mq_request_issue_directly() interface how it is,
> non-read-write restriction and all, but export a new
> __blk_mq_request_issue_directly() that _only_
> blk_insert_cloned_request() -- and future comparable users -- makes use
> of?
> 
> To me that is the best of both worlds: Fix corruption issue but don't
> impose needless blk_get_request() dances for non-read-write IO issued to
> dm-multipath.

Alright, I hear your point. Maybe we are going to be better off with
just dispatch insert. Here's a version of that on top of -git, basically
reverting the previous one, and applying the two hunks from Ming, but
also adding a missed one in blk_mq_try_issue_list_directly() where we
don't want to be adding the current request back to the list. That should
go to dispatch, too.

Note note note - not tested yet. Will do so now.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3262d83b9e07..89270a924ba8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1736,18 +1736,6 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-/*
- * Don't allow direct dispatch of anything but regular reads/writes,
- * as some of the other commands can potentially share request space
- * with data we need for the IO scheduler. If we attempt a direct dispatch
- * on those and fail, we can't safely add it to the scheduler afterwards
- * without potentially overwriting data that the driver has already written.
- */
-static bool blk_rq_can_direct_dispatch(struct request *rq)
-{
-	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
-}
-
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
@@ -1769,7 +1757,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
+	if (q->elevator && !bypass_insert)
 		goto insert;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
@@ -1785,7 +1773,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 	if (bypass_insert)
 		return BLK_STS_RESOURCE;
 
-	blk_mq_sched_insert_request(rq, false, run_queue, false);
+	blk_mq_request_bypass_insert(rq, run_queue);
 	return BLK_STS_OK;
 }
 
@@ -1801,7 +1789,7 @@ static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 
 	ret = __blk_mq_try_issue_directly(hctx, rq, cookie, false);
 	if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE)
-		blk_mq_sched_insert_request(rq, false, true, false);
+		blk_mq_request_bypass_insert(rq, true);
 	else if (ret != BLK_STS_OK)
 		blk_mq_end_request(rq, ret);
 
@@ -1831,15 +1819,12 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
-		if (!blk_rq_can_direct_dispatch(rq))
-			break;
-
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq);
 		if (ret != BLK_STS_OK) {
 			if (ret == BLK_STS_RESOURCE ||
 					ret == BLK_STS_DEV_RESOURCE) {
-				list_add(&rq->queuelist, list);
+				blk_mq_request_bypass_insert(rq, true);
 				break;
 			}
 			blk_mq_end_request(rq, ret);

-- 
Jens Axboe

