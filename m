Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCEBC04EB8
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2599020645
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 02:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uTb50F6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2599020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbeLECXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:23:44 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42241 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECXo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 21:23:44 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so4456598plp.9
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 18:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TGkEvw9hi4PIRlDKYwEtnqzAEGZvA3OcHi0FiybQXOM=;
        b=uTb50F6lKFCbkXubxxk4Llhj2H1V1tJqZc7CuZTwAadJtGLMmCfNCqmMu0r8Z5PTfL
         h/FD1AYflkKQv7sMlyhKbZpRnVpiZaHLwCnJDscyNUlGO9R5TOgxJJO9jeeLnV4q3kRq
         UIYyUCYA2tgeKhP96HmGw56NUQib4PU7eyJRaxNp2ml/avtkXoCK7ODGHfwfkBHyMIXG
         zfJ8Wz7UkpohSP59nRjcG7DUo9NYnifDI7swhMwOHY6+EGwnfv8phQst/VZt+MZ3NKo9
         e6jqMWCOvxLukPU8MUeWwpe239XCl5wy7RuyLRdxJmNrQCzC3BnzH0HOrzWb+Zs4OrCu
         6ftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TGkEvw9hi4PIRlDKYwEtnqzAEGZvA3OcHi0FiybQXOM=;
        b=BoFJ0wFKWjs4ajn5oeoNaTJlGlVsa+oonDQoYi3zuaQyWkrReOttEUiem6LgH5QF5F
         DDVHdPguTgHJjNti3w6g1o38CJjIM9WF+mXC7/2bnsg9A6Oa3/8HSTgcVXSjfQGlwUCJ
         dA1jbsWPoEsWLUngnFfFORVbNpeYVsAtQkscsA4TW+69Lw2qxlo7Lhey6Rq3sCIjhJwL
         br9HQfnZoejQs4UW3cSHSsJ5a3LBwwksPRPKJopauuFcZmy83n6ylgEaKA9G+zJr2LzY
         F/jmXPM/bTX7l2ukytkTsqa4HjtxOqIpbdzOx1FrB2My6v6oGOPyVZqpUAGxkaX6HdJn
         2AlQ==
X-Gm-Message-State: AA+aEWbuXo9kXEES9bOJ4pYe+AWvmCGzNo28KD/RHetTbJOgicuTiYPd
        m0/ap0v5DrBiTiSekHKvN/Cp6O6fmnc=
X-Google-Smtp-Source: AFSGD/WTOZZ+LLZoK0LTL+d9AR6w/eSUiFHKySsJtt8lxUxjq6+9PK7qE3OufuVPNSJ/fzC7f3+hKA==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr21834793pls.71.1543976622915;
        Tue, 04 Dec 2018 18:23:42 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id z127sm30016180pfb.80.2018.12.04.18.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 18:23:41 -0800 (PST)
Subject: Re: [PATCH] blk-mq: fix corruption with direct issue
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <1d359819-5410-7af2-d02b-f0ecca39d2c9@kernel.dk>
 <20181205013736.GD17845@ming.t460p>
 <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
Message-ID: <0af0fd70-acc3-9b9e-8027-fb75f92bea90@kernel.dk>
Date:   Tue, 4 Dec 2018 19:23:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <37bf8821-c205-717a-df0d-96ecfb0f75aa@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 7:16 PM, Jens Axboe wrote:
> On 12/4/18 6:37 PM, Ming Lei wrote:
>> On Tue, Dec 04, 2018 at 03:47:46PM -0700, Jens Axboe wrote:
>>> If we attempt a direct issue to a SCSI device, and it returns BUSY, then
>>> we queue the request up normally. However, the SCSI layer may have
>>> already setup SG tables etc for this particular command. If we later
>>> merge with this request, then the old tables are no longer valid. Once
>>> we issue the IO, we only read/write the original part of the request,
>>> not the new state of it.
>>>
>>> This causes data corruption, and is most often noticed with the file
>>> system complaining about the just read data being invalid:
>>>
>>> [  235.934465] EXT4-fs error (device sda1): ext4_iget:4831: inode #7142: comm dpkg-query: bad extra_isize 24937 (inode size 256)
>>>
>>> because most of it is garbage...
>>>
>>> This doesn't happen from the normal issue path, as we will simply defer
>>> the request to the hardware queue dispatch list if we fail. Once it's on
>>> the dispatch list, we never merge with it.
>>>
>>> Fix this from the direct issue path by flagging the request as
>>> REQ_NOMERGE so we don't change the size of it before issue.
>>>
>>> See also:
>>>   https://bugzilla.kernel.org/show_bug.cgi?id=201685
>>>
>>> Fixes: 6ce3dd6eec1 ("blk-mq: issue directly if hw queue isn't busy in case of 'none'")
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 3f91c6e5b17a..d8f518c6ea38 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1715,6 +1715,15 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>>>  		break;
>>>  	case BLK_STS_RESOURCE:
>>>  	case BLK_STS_DEV_RESOURCE:
>>> +		/*
>>> +		 * If direct dispatch fails, we cannot allow any merging on
>>> +		 * this IO. Drivers (like SCSI) may have set up permanent state
>>> +		 * for this request, like SG tables and mappings, and if we
>>> +		 * merge to it later on then we'll still only do IO to the
>>> +		 * original part.
>>> +		 */
>>> +		rq->cmd_flags |= REQ_NOMERGE;
>>> +
>>>  		blk_mq_update_dispatch_busy(hctx, true);
>>>  		__blk_mq_requeue_request(rq);
>>>  		break;
>>>
>>
>> Not sure it is enough to just mark it as NOMERGE, for example, driver
>> may have setup the .special_vec for discard, and NOMERGE may not prevent
>> request from entering elevator queue completely. Cause 'rq.rb_node' and
>> 'rq.special_vec' share same space.
> 
> We should rather limit the scope of the direct dispatch instead. It
> doesn't make sense to do for anything but read/write anyway.
> 
>> So how about inserting this request via blk_mq_request_bypass_insert()
>> in case that direct issue returns BUSY? Then it is invariant that
>> any request queued via .queue_rq() won't enter scheduler queue.
> 
> I did consider this, but I didn't want to experiment with exercising
> a new path for an important bug fix. You do realize that your original
> patch has been corrupting data for months? I think a little caution
> is in order here.

Here's a further limiting version. And we seriously need to clean up the
direct issue paths, it's ridiculous.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3f91c6e5b17a..3262d83b9e07 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1715,6 +1715,15 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 		break;
 	case BLK_STS_RESOURCE:
 	case BLK_STS_DEV_RESOURCE:
+		/*
+		 * If direct dispatch fails, we cannot allow any merging on
+		 * this IO. Drivers (like SCSI) may have set up permanent state
+		 * for this request, like SG tables and mappings, and if we
+		 * merge to it later on then we'll still only do IO to the
+		 * original part.
+		 */
+		rq->cmd_flags |= REQ_NOMERGE;
+
 		blk_mq_update_dispatch_busy(hctx, true);
 		__blk_mq_requeue_request(rq);
 		break;
@@ -1727,6 +1736,18 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+/*
+ * Don't allow direct dispatch of anything but regular reads/writes,
+ * as some of the other commands can potentially share request space
+ * with data we need for the IO scheduler. If we attempt a direct dispatch
+ * on those and fail, we can't safely add it to the scheduler afterwards
+ * without potentially overwriting data that the driver has already written.
+ */
+static bool blk_rq_can_direct_dispatch(struct request *rq)
+{
+	return req_op(rq) == REQ_OP_READ || req_op(rq) == REQ_OP_WRITE;
+}
+
 static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 						struct request *rq,
 						blk_qc_t *cookie,
@@ -1748,7 +1769,7 @@ static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
 		goto insert;
 	}
 
-	if (q->elevator && !bypass_insert)
+	if (!blk_rq_can_direct_dispatch(rq) || (q->elevator && !bypass_insert))
 		goto insert;
 
 	if (!blk_mq_get_dispatch_budget(hctx))
@@ -1810,6 +1831,9 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 		struct request *rq = list_first_entry(list, struct request,
 				queuelist);
 
+		if (!blk_rq_can_direct_dispatch(rq))
+			break;
+
 		list_del_init(&rq->queuelist);
 		ret = blk_mq_request_issue_directly(rq);
 		if (ret != BLK_STS_OK) {

-- 
Jens Axboe

