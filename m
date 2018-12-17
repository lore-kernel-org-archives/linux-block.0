Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506CDC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1738F2133F
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 15:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="goGJ/EYA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733059AbeLQPnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:43:50 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35836 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbeLQPnu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 10:43:50 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so20620355itp.0
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 07:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AvOJfp2s55a/cxH8YXHDyQPJDoAern9AYly5FBR4TU0=;
        b=goGJ/EYAVnBOl404uwd6GkNQnyqNl3je0RE8qQkC61kE4KhS8PV5O9uYJp0nNxtbiX
         C0hErdca68DNI9ZVzQpUGUX+t9JOlcglJclfMTKgh+sRfnEm/TFcF95/ZvchcY2UdVQb
         J5jDcT4K6ctKD4T4Zp61mpOCSB5GIuLmaUkYI1VwmkIlmLpNGnmiUfaCMoLd6nyXRAK6
         Qy8cr7sONgplaviu+yOCTRstqTG+ajRBqzR1CdZZGeDZozU63AlzFz8QWyAWPND+WTak
         Evz1/ZBR4CvNplHvacIaoBR1+184pNm1m54ofy3y13aI9wvbHR/woVfZSilKSe51xBve
         ET2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AvOJfp2s55a/cxH8YXHDyQPJDoAern9AYly5FBR4TU0=;
        b=rcj0dSA7DiswaNmSei/1Viq08IOLkP5tnTBcTjpjk9G7pbovTLE9q5Hs5xrTFBWWlG
         tExIsuh24e2ABAASER7CvP1hAFRH5SxYNfghsTGWhm432sL3RmxM07cSQu4qRwEMjayO
         4PSHByQSblIGqrVAUYCvmflrUTp7s7H/VE1avnAjyUNdLCPkxmAFAqxgVHxQfrFOAeTF
         jIfMaZGqQvLi19nMAxPLrnpveiNvrfiL0lVGUcKYe/0tIBE4GZbVOUUpZYgifNmsfPMP
         YcohgwdR45SyhJs0tVsucvbpSLViRNNcNYp04aw1FQKSRroHOM+6fyMYvlC+x/3qfokc
         ElKQ==
X-Gm-Message-State: AA+aEWYS+SdPcQhLdCfP2ryDEE6bMQFzDji0Q6wnGGW/v/c5kVXY/8Yl
        GOFUp6Nafv/vGMGaAZMoYdMbxw==
X-Google-Smtp-Source: AFSGD/XROs90ImHJsmvUaLooRvUu7qaKgmIijVibPEYkC8PnVzkdxMMjwLqcn1X4sawFFycTp/VChw==
X-Received: by 2002:a05:660c:12c7:: with SMTP id k7mr11910188itd.148.1545061429254;
        Mon, 17 Dec 2018 07:43:49 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r139sm6295927ior.53.2018.12.17.07.43.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 07:43:47 -0800 (PST)
Subject: Re: [PATCH V3 3/3] blk-mq: fix dispatch from sw queue
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20181217120844.8131-1-ming.lei@redhat.com>
 <20181217120844.8131-4-ming.lei@redhat.com>
 <fe4133ec-7dfa-255c-9c24-af448446bf23@kernel.dk>
 <65b5ae24-2c02-7f78-275e-3df5a860cad5@kernel.dk>
Message-ID: <9cfcc95b-883e-db62-1ae1-3c98b8f4048f@kernel.dk>
Date:   Mon, 17 Dec 2018 08:43:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <65b5ae24-2c02-7f78-275e-3df5a860cad5@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 6:29 AM, Jens Axboe wrote:
> On 12/17/18 5:55 AM, Jens Axboe wrote:
>> On 12/17/18 5:08 AM, Ming Lei wrote:
>>> When requst is added to rq list of sw queue(ctx), the rq may be from
>>> different type of hctx, especially after multi queue mapping is introduced.
>>>
>>> So when dispach request from sw queue via blk_mq_flush_busy_ctxs() or
>>> blk_mq_dequeue_from_ctx(), one request belonging to other queue type of
>>> hctx can be dispatch to current hctx in case that read queue or poll queue
>>> is enabled.
>>>
>>> This patch fixes this issue by introducing per-queue-type list.
>>
>> Looks good, just one comment:
>>
>>> diff --git a/block/blk-mq.h b/block/blk-mq.h
>>> index d1ed096723fb..0973a91eb1dd 100644
>>> --- a/block/blk-mq.h
>>> +++ b/block/blk-mq.h
>>> @@ -12,14 +12,16 @@ struct blk_mq_ctxs {
>>>  	struct blk_mq_ctx __percpu	*queue_ctx;
>>>  };
>>>  
>>> +struct blk_mq_ctx_list {
>>> +	spinlock_t		lock;
>>> +	struct list_head	rq_list;
>>> +}  ____cacheline_aligned_in_smp;
>>> +
>>>  /**
>>>   * struct blk_mq_ctx - State for a software queue facing the submitting CPUs
>>>   */
>>>  struct blk_mq_ctx {
>>> -	struct {
>>> -		spinlock_t		lock;
>>> -		struct list_head	rq_list;
>>> -	}  ____cacheline_aligned_in_smp;
>>> +	struct blk_mq_ctx_list  list[HCTX_MAX_TYPES];
>>
>> Let's not make that use 3 cachelines. There is no good reason to split
>> these across cachelines, if we have heavy traffic to multiple of these,
>> then we're not going very fast anyway. So just make it:
>>
>> 	struct {
>> 		spinlock_t		lock;
>> 		struct list_head	rq_list[HCTX_MAX_TYPES];
>> 	}  ____cacheline_aligned_in_smp;
> 
> Did it just to check, turns out fine and is of course less changes.
> Let me know.

Tests good for me, thanks for doing this work. Just a heads up that
I'm going to queue this up, attributed to you, but just with a note
that I changed the layout of that structure.

-- 
Jens Axboe

