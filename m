Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852FDC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4186B2082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HfgVuUo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4186B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLAIEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 03:04:49 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:38581 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbeLAIEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 03:04:49 -0500
Received: by mail-it1-f195.google.com with SMTP id h65so446909ith.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cRsPnPvObKw9srUN3sxcqUkd5caF5UaQ3qXVGgR5614=;
        b=HfgVuUo6haUbVSxYtcuxBaV9yBXF09T7uxUswmCJfZ0c/VUDbqfGf+wJdp+c5OEby6
         +nQQmRNlN1/hpgXicxDp8HIG5m1fU+WiWLmoxQVkBuPFCyQOFXEM6AFbL5YxeRRIUULb
         0OwM8+EklloC6t7fDXA9wc/+GM6t2+cY0DC89z5st8ICRsrJrLdsOywJtiz6X/l2Tju2
         1exc3LLkrb1vkIm4UK9xAYKUA/vgKGw9b8uMHK0HMJDCC1wF1RXDik5nhewrjXlsHE9k
         c8J/I/YAchF0+YVlUtCcByyS4iSgBUM3kAZ7C+F5CQK7sXhNP0dzEg0KOLyViHR6Y3W0
         4clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cRsPnPvObKw9srUN3sxcqUkd5caF5UaQ3qXVGgR5614=;
        b=GxO0ReXv9bOuG1Z80oak7TIH44nMLRcSAMLkt1WCIX9Cy6a6Gf5UCAJbD26IZBs3ny
         NcdEucyvOPTrbQ6WH9f0X3oqdRA9iHO/edVhWexZGWkSxGZUM+gJirNIknvXvneK1Pdy
         LRstOOhWmuTobRDEHXjhL7+icQScGSDYLcp2hW0AEsRLWkCHwL/onD8FJBLQB50aXgbf
         Pdu4Bt1lzeDfej7vtM7khAYCgxmDndkF4Motv1zt9/sd25k+Iem2GC9iQ09CoeYoLVat
         vyB+EGeSY6U2VyzjgTYW84k/dVYObPBVPolTkTlateMRPvkmbQfiNA1dMExpmVNlMoox
         CG6w==
X-Gm-Message-State: AA+aEWalyDyvB1kHtQqPF0ocvOaFgQG6BRiUchYsTkCYtLuzNqJZjGxp
        N96EaJxLXbFCm9A3HDPuSWBStwzYPK4=
X-Google-Smtp-Source: AFSGD/XVe99PFi67wvF/JljztpG5SLK1MYOTpTxMXpDYsLMQBuBxzeb/qGHRuggM3ssSISuuEKsD5A==
X-Received: by 2002:a24:7609:: with SMTP id z9mr347699itb.66.1543611255900;
        Fri, 30 Nov 2018 12:54:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w8-v6sm136436ita.18.2018.11.30.12.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:54:14 -0800 (PST)
Subject: Re: [PATCH] blk-mq: don't call ktime_get_ns() if we don't need it
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <51a1cb7b-6136-a220-6cac-9bccd2262ca3@kernel.dk>
 <20181130172704.GA16952@infradead.org>
 <2f4b6ca1-23e5-b7fd-286a-e3a76cfc411e@kernel.dk>
Message-ID: <29202974-a205-bd80-298e-52e24dfed48c@kernel.dk>
Date:   Fri, 30 Nov 2018 13:54:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2f4b6ca1-23e5-b7fd-286a-e3a76cfc411e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 10:29 AM, Jens Axboe wrote:
> On 11/30/18 10:27 AM, Christoph Hellwig wrote:
>> On Fri, Nov 30, 2018 at 08:56:25AM -0700, Jens Axboe wrote:
>>> We only need the request fields and the end_io time if we have stats
>>> enabled, or if we have a scheduler attached as those may use it for
>>> completion time stats.
>>>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  block/blk-mq.c | 13 ++++++++++---
>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 7dcef565dc0f..2b458e9da946 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -316,7 +316,8 @@ static struct request *blk_mq_rq_ctx_init(struct blk_mq_alloc_data *data,
>>>  	RB_CLEAR_NODE(&rq->rb_node);
>>>  	rq->rq_disk = NULL;
>>>  	rq->part = NULL;
>>> -	rq->start_time_ns = ktime_get_ns();
>>> +	if (data->q->elevator)
>>> +		rq->start_time_ns = ktime_get_ns();
>>
>> We also seem to use start_time_ns it in blk_account_io_done.
> 
> But only if RQF_STATS is set, in which case we are passing it in correctly.

Oh, needs a stats check for this one, for some reason I was thinking
of the end_io path. Will update.

-- 
Jens Axboe

