Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00DC2F441
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9142089F
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sqP4xwJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbfAUQXt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:23:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34631 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfAUQXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 11:23:48 -0500
Received: by mail-pg1-f195.google.com with SMTP id j10so9711626pga.1
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 08:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PXhFfF+bPtcy8TS1HaDGlOZYPI51QZdHLTw6WfQuKWQ=;
        b=sqP4xwJmWIgjbMlBKVrexlMgg1LEz8+P02Iu1uQ0SOqlsrNpFk3ONC3bgVaN1qjxMF
         f0PuNiZOMeUVIoFoEMWaCMP2AigoJlXb85mIWtuOyij83NgQcBfPLHRrn0rmJSg4SvbO
         lQX4RR4ETdzFmZP4Ow6aSwImGlmi8S9XMuoOqyReYXf+riO828suaQ261a9qtUV5IqVq
         wLRvgCLoLWg4/AXNUfAIL5PbzFxj0zcbXiY6XRkaDdCiEBL0bY/KRA61d0fID88vB36C
         2/B6NvgJWFGHciJN6hsXGic1YdHdrubhVa1qnFSiCwJD2st/NJrhkylb6zulJ9rgj8FB
         maxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PXhFfF+bPtcy8TS1HaDGlOZYPI51QZdHLTw6WfQuKWQ=;
        b=cB3xYjEVd/bc6jgQk/4AEf/Nk3g1DRVhOgtVMv0QP/djk9ASwipw24dX/6sFKVNSWA
         H8xuEb+mylLsHfm5q9V2CaiBAjyjmQwRS8N1+7Zfoe9I7dcH6fF/HLEI3We1TFzYyxuw
         rwe9KNARaU6sfw6vQNQtdcHKrULr2TSao+RUij3+WZfErHNVXP0RWEEpSAZNcUZBp4go
         EsJYsPHrqX3azEIaufGKCmQLlv0LOINT7pdkoMsEn/B0wkYlPrEy73GxJp0e8hrfEtBZ
         Z6Cs709I/MwGqEKyCSshupBA5MuH2Obvn+XT1hFitIG0kAElikShLFNY2jt9Wp5gLFLA
         Bzrw==
X-Gm-Message-State: AJcUukfDbMH4zvPbTHBx80bmzebmAR/xIl5JeNclsN9+/nEFWNB1GRyT
        M5EEAdaZA/G2Mg+IqqNUeUROaA==
X-Google-Smtp-Source: ALg8bN6AOy+8sm6wkQhJVBP3kPTWjj9tpz84w89An/vLTSniv+/dh9f0qSRgaVZay0rj0rjhenXjVA==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr27544410pgb.357.1548087827744;
        Mon, 21 Jan 2019 08:23:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g11sm15911244pfo.139.2019.01.21.08.23.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 08:23:46 -0800 (PST)
Subject: Re: [PATCH 05/17] Add io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, linux-block-owner@vger.kernel.org
References: <20190118161225.4545-1-axboe@kernel.dk>
 <20190118161225.4545-6-axboe@kernel.dk>
 <20204806b30147da55990e639586cce1@suse.de>
 <801e00ef-b21d-4420-9fa3-2b19fe2398b2@kernel.dk>
 <eb1e623843cd26ced5d06deb7fdb7851@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <df5b04ea-1c7c-03e5-087e-d9e3763d6670@kernel.dk>
Date:   Mon, 21 Jan 2019 09:23:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <eb1e623843cd26ced5d06deb7fdb7851@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/19 8:58 AM, Roman Penyaev wrote:
> On 2019-01-21 16:30, Jens Axboe wrote:
>> On 1/21/19 2:13 AM, Roman Penyaev wrote:
>>> On 2019-01-18 17:12, Jens Axboe wrote:
>>>
>>> [...]
>>>
>>>> +
>>>> +static int io_uring_create(unsigned entries, struct io_uring_params
>>>> *p,
>>>> +			   bool compat)
>>>> +{
>>>> +	struct user_struct *user = NULL;
>>>> +	struct io_ring_ctx *ctx;
>>>> +	int ret;
>>>> +
>>>> +	if (entries > IORING_MAX_ENTRIES)
>>>> +		return -EINVAL;
>>>> +
>>>> +	/*
>>>> +	 * Use twice as many entries for the CQ ring. It's possible for the
>>>> +	 * application to drive a higher depth than the size of the SQ 
>>>> ring,
>>>> +	 * since the sqes are only used at submission time. This allows for
>>>> +	 * some flexibility in overcommitting a bit.
>>>> +	 */
>>>> +	p->sq_entries = roundup_pow_of_two(entries);
>>>> +	p->cq_entries = 2 * p->sq_entries;
>>>> +
>>>> +	if (!capable(CAP_IPC_LOCK)) {
>>>> +		user = get_uid(current_user());
>>>> +		ret = __io_account_mem(user, ring_pages(p->sq_entries,
>>>> +							p->cq_entries));
>>>> +		if (ret) {
>>>> +			free_uid(user);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	ctx = io_ring_ctx_alloc(p);
>>>> +	if (!ctx)
>>>> +		return -ENOMEM;
>>>
>>> Hi Jens,
>>>
>>> It seems pages should be "unaccounted" back here and uid freed if path
>>> with "if (!capable(CAP_IPC_LOCK))" above was taken.
>>
>> Thanks, yes that is leaky. I'll fix that up.
>>
>>> But really, could please someone explain me what is wrong with
>>> allocating
>>> all urings in mmap() without touching RLIMIT_MEMLOCK at all?  Thus all
>>> memory will be accounted to the caller app and if app is greedy it 
>>> will
>>> be killed by oom.  What I'm missing?
>>
>> I don't really what that'd change, if we do it off the ->mmap() or when
>> we setup the io_uring instance with io_uring_setup(2). We need this 
>> memory
>> to be pinned, we can't fault on it.
> 
> Hm, I thought that for pinning there is a separate counter ->pinned_vm
> (introduced by bc3e53f682d9 ("mm: distinguish between mlocked and pinned
> pages")  Which seems not wired up with anything, just a counter, used by
> couple of drivers.

io_uring doesn't inc/dec either of those, but it probably should. As it
appears rather unused, probably not a big deal.

> Hmmm.. Frankly, now I am lost. You map these pages through
> remap_pfn_range(), so virtual user mapping won't fault, right?  And
> these pages you allocate with GFP_KERNEL, so they are already pinned.

Right, they will not fault. My point is that it sounded like you want
the application to allocate this memory in userspace, and then have the
kernel map it. I don't want to do that, that brings it's own host of
issues with it (we used to do that). The mmap(2) of kernel memory is
much cleaner.

> So now I do not understand why this accounting is needed at all :)
> The only reason I had in mind is some kind of accounting, to filter out
> greedy and nasty apps.  If this is not the case, then I am lost.
> Could you please explain?

We need some kind of limit, to prevent a user from creating millions of
io_uring instances and pining down everything. The old aio code realized
this after the fact, and added some silly sysctls to control this. I
want to avoid the same mess, and hence it makes more sense to tie into
some kind of limiting we already have, like RLIMIT_MEMLOCK. Since we're
using that rlimit, accounting the memory as locked is the right way to
go.

-- 
Jens Axboe

