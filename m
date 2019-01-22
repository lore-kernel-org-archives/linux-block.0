Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C5EC282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D87B20823
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 16:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uKEvhssM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfAVQLe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:11:34 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43340 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728745AbfAVQLd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 11:11:33 -0500
Received: by mail-io1-f68.google.com with SMTP id b23so19528544ios.10
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 08:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UWHwhcCkFEEvMEKdL/+wKuBCT2IRG92ONIAGiyguZ5s=;
        b=uKEvhssM3pp+nFe6R4lnxSOGavvjSqosNY3NIZqetB9UxKd3OwEqb2IfGx9PxCQ0f7
         dceaGL4p2dFvJSMeNBgMqdvQzDHeJZ7JN46CSk1qbJQmGXgfioE9LqB8sS2/lGZwkhpF
         hRgievdHeP0ruloMgz7nHfmCwmRaT/QUUJ7EyMwACdDSDT8yq2b2Yuof2bkJuSFITxEz
         8cMc0kyPXIIpRd39qMHPn0swqc6kx5jEyfqd5lj3cDUeUMd8wJYo/RpVTp8NWIM539pb
         7CVYQLTptrDhmjVzzNctLTXAiJrGyIwoaI83MevV1/zda9B16ttO04c19rUd9d3d1URp
         l6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UWHwhcCkFEEvMEKdL/+wKuBCT2IRG92ONIAGiyguZ5s=;
        b=uauxw8nowPXU0FFqkdFcnX9voJHhIY3e2vHSgfTu8rbLj9e+bb23Pu8Pv9I+uLkeEn
         m6zSrz/YjlQcuwLw/lo1fG6tD1pl0DUwaTpN2nWzny0tVZAqdBR1y9sOKhgMOBhNnhSP
         OAD8g0tQweGK34mB0AVm8K758qj7h2nGpILEeXP9tK+XUkQAaQ3PGYeZZvWGr+fTrCsk
         lbp7fnOjgcWfkgTT5SFAZ3JYEyQoetESf/ftDLmKXhDSrQ5T1ah/p+TkQC68PX57V1Sz
         ZgcpgDPTEssG+PJZLG4YCPWeuGAzDZn2wCRHh2XPB+SF1QveuzL6o3CSe2mbMNqVXcjm
         idQA==
X-Gm-Message-State: AJcUukeO4u0x4D2l2q5+CRx5EpS6HrmE7/pKcBG4U01glZSfTojOy21d
        C6XqOrxuMbiu6kLnwVvpYJD9Bw==
X-Google-Smtp-Source: ALg8bN57VOnWExovC9L4z9ovZwWlOhp5X+QZkDeTTmLFm8DZyDPuZnu1MDqgkfSFMHQpkzVHR7luDg==
X-Received: by 2002:a6b:e316:: with SMTP id u22mr4172220ioc.33.1548173492756;
        Tue, 22 Jan 2019 08:11:32 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y13sm6056439ioa.56.2019.01.22.08.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 08:11:31 -0800 (PST)
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
 <df5b04ea-1c7c-03e5-087e-d9e3763d6670@kernel.dk>
 <4e7ef6f79c1fcd3aafa992ea9652e4ea@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b7f1ef3d-2aeb-14aa-8070-b963bf685f0f@kernel.dk>
Date:   Tue, 22 Jan 2019 09:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <4e7ef6f79c1fcd3aafa992ea9652e4ea@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/19 9:49 AM, Roman Penyaev wrote:
> On 2019-01-21 17:23, Jens Axboe wrote:
>> On 1/21/19 8:58 AM, Roman Penyaev wrote:
>>> On 2019-01-21 16:30, Jens Axboe wrote:
>>>> On 1/21/19 2:13 AM, Roman Penyaev wrote:
>>>>> On 2019-01-18 17:12, Jens Axboe wrote:
>>>>>
>>>>> [...]
>>>>>
>>>>>> +
>>>>>> +static int io_uring_create(unsigned entries, struct 
>>>>>> io_uring_params
>>>>>> *p,
>>>>>> +			   bool compat)
>>>>>> +{
>>>>>> +	struct user_struct *user = NULL;
>>>>>> +	struct io_ring_ctx *ctx;
>>>>>> +	int ret;
>>>>>> +
>>>>>> +	if (entries > IORING_MAX_ENTRIES)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	/*
>>>>>> +	 * Use twice as many entries for the CQ ring. It's possible for 
>>>>>> the
>>>>>> +	 * application to drive a higher depth than the size of the SQ
>>>>>> ring,
>>>>>> +	 * since the sqes are only used at submission time. This allows 
>>>>>> for
>>>>>> +	 * some flexibility in overcommitting a bit.
>>>>>> +	 */
>>>>>> +	p->sq_entries = roundup_pow_of_two(entries);
>>>>>> +	p->cq_entries = 2 * p->sq_entries;
>>>>>> +
>>>>>> +	if (!capable(CAP_IPC_LOCK)) {
>>>>>> +		user = get_uid(current_user());
>>>>>> +		ret = __io_account_mem(user, ring_pages(p->sq_entries,
>>>>>> +							p->cq_entries));
>>>>>> +		if (ret) {
>>>>>> +			free_uid(user);
>>>>>> +			return ret;
>>>>>> +		}
>>>>>> +	}
>>>>>> +
>>>>>> +	ctx = io_ring_ctx_alloc(p);
>>>>>> +	if (!ctx)
>>>>>> +		return -ENOMEM;
>>>>>
>>>>> Hi Jens,
>>>>>
>>>>> It seems pages should be "unaccounted" back here and uid freed if 
>>>>> path
>>>>> with "if (!capable(CAP_IPC_LOCK))" above was taken.
>>>>
>>>> Thanks, yes that is leaky. I'll fix that up.
>>>>
>>>>> But really, could please someone explain me what is wrong with
>>>>> allocating
>>>>> all urings in mmap() without touching RLIMIT_MEMLOCK at all?  Thus 
>>>>> all
>>>>> memory will be accounted to the caller app and if app is greedy it
>>>>> will
>>>>> be killed by oom.  What I'm missing?
>>>>
>>>> I don't really what that'd change, if we do it off the ->mmap() or 
>>>> when
>>>> we setup the io_uring instance with io_uring_setup(2). We need this
>>>> memory
>>>> to be pinned, we can't fault on it.
>>>
>>> Hm, I thought that for pinning there is a separate counter ->pinned_vm
>>> (introduced by bc3e53f682d9 ("mm: distinguish between mlocked and 
>>> pinned
>>> pages")  Which seems not wired up with anything, just a counter, used 
>>> by
>>> couple of drivers.
>>
>> io_uring doesn't inc/dec either of those, but it probably should. As it
>> appears rather unused, probably not a big deal.
>>
>>> Hmmm.. Frankly, now I am lost. You map these pages through
>>> remap_pfn_range(), so virtual user mapping won't fault, right?  And
>>> these pages you allocate with GFP_KERNEL, so they are already pinned.
>>
>> Right, they will not fault. My point is that it sounded like you want
>> the application to allocate this memory in userspace, and then have the
>> kernel map it. I don't want to do that, that brings it's own host of
>> issues with it (we used to do that). The mmap(2) of kernel memory is
>> much cleaner.
> 
> No, no.  I've explained below.
> 
>>
>>> So now I do not understand why this accounting is needed at all :)
>>> The only reason I had in mind is some kind of accounting, to filter 
>>> out
>>> greedy and nasty apps.  If this is not the case, then I am lost.
>>> Could you please explain?
>>
>> We need some kind of limit, to prevent a user from creating millions of
>> io_uring instances and pining down everything. The old aio code 
>> realized
>> this after the fact, and added some silly sysctls to control this. I
>> want to avoid the same mess, and hence it makes more sense to tie into
>> some kind of limiting we already have, like RLIMIT_MEMLOCK. Since we're
>> using that rlimit, accounting the memory as locked is the right way to
>> go.
> 
> Yes, that what I thought from the very beginning: RLIMIT_MEMLOCK is used
> to limit somehow the allocation.  Thanks for clarifying that.

Yes, sorry if that wasn't clear!

> But again returning to mmap(): why not to do the same alloc of pages
> with GFP_KERNEL and remap_pfn_range() (exactly like you do now), but
> inside ->mmap callback?  (so simply postpone allocation to the mmap(2)
> step).  Then allocated memory will be "atomically" accounted for user
> vma, and greedy app will be safely killed by oom even without usage of
> RLIMIT_MEMLOCK limit (which is a pain if it is low, right?).

I honestly don't see how that helps us at all. Accounting wise, we can
do it anywhere. And I do prefer having the setup in the
io_uring_setup(2) path, so the mmap() becomes straightforward and won't
ever error unless the app passes in the wrong sizes/offsets.

I've since checked up on the rlimit memlock limits. On my laptop, it's
16k pages, so 64MB. Which seems plentiful for our purposes. On my test
vm, running a different distro, it's also 64MB. On my test box, it's 64
pages, which is a lot lower, but still 256k which will suffice for the
majority. So I'm not as worried about that as I initially was, if folks
were running with 64kb limits.

> So basically you do not have this unsafe gap: memory is allocated in
> io_uring_setup(2) and then sometime in the future accounted for vma
> inside mmap(2). No. Allocation and mmaping happens directly inside
> mmap(2) callback, so no rlimit is needed.

I account upfront in io_uring_setup(2), so there should be no gap where
we've overcommitted.

I still don't follow why you don't think rlimit is needed for this case,
maybe I'm missing something.

-- 
Jens Axboe

