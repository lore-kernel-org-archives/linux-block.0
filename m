Return-Path: <SRS0=XolY=P5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0221C2F439
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909E72085A
	for <linux-block@archiver.kernel.org>; Mon, 21 Jan 2019 15:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="PlgdvSb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbfAUPaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:30:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35511 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbfAUPaX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 10:30:23 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so10298318pfi.2
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 07:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nRvUy+SI9xiZnr6nxruuT6UWSO+cMZ0IwN7BlWvylYU=;
        b=PlgdvSb27G2NIHacC3CVanXPw6ksDwktHJjQc2Rw0FiGRGSu0jcev3CxoAc300h0eA
         NgmGElne5aiE80V06p+80iqGhNawoi3VLs31X0iMIFn4spNMHioD3VoZwvX8HXk2lv6I
         Tlm8EcSI60dsXPWL/QUQmQ+Z/SXXoQDVJCxPAzOp8utRFcAv8THsfylPH+CXMWoxmvMb
         d8uVJTGD2OP77LMHOJHKUpbQHw+j33Fgm3z3+30nQ+/wuJGkFzbGkf+6VXso0AJAH2Kz
         P+X1EaRmG8Y3wKWf0HJNPoDRqFiPLX0eE9EixzxPni9xgFJhgsJQe0b8hcaBN/IU7ghm
         ZLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nRvUy+SI9xiZnr6nxruuT6UWSO+cMZ0IwN7BlWvylYU=;
        b=BxwR1Rohzrrk58dmELNtB15E/LbCV5RwQVyWhZv2/WiSZGSHo7BHNOYlIcOAfv5aC/
         FrnIr0x+j4DJ5D1O5xM7T+DX3pr17k8JF9g26DJErMVDb+FpkVp9bZKA8F2MpFb4bO7m
         wEMc3gFLMtQfqBMG6CzVp50m56ekSsPtOE6nN0j7QtvPV329aVGZEvpCi8aZP1D/DQuY
         mfo1kCCwaaAsOYLZvyy8adlQ872g/4ViuW2j/8dbmfOviR9QcfY58n75QAVmX/YBY1Pt
         ZOywBfrvcXy0FPb0jcqpIojsToMTno+6YvSGSPK6s7NPVCvvXtFRr0mTHQacFTWqmWsn
         iEfw==
X-Gm-Message-State: AJcUukfSxxgnTgzAhLxQuL5Vbfqb8/vJGvZuAdztuyHScIfPiQDYBf+m
        7YpS8wjhFw4XvBFjGVdZFOiKdg==
X-Google-Smtp-Source: ALg8bN4zlG5JwTKBIu0Uuf/QeuKULCx/e3tjcGVtr9360KXApa83luGfa2WDV3YaCcYfEp8QYz+LeQ==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr30520487pfn.125.1548084622190;
        Mon, 21 Jan 2019 07:30:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j9sm15522723pfi.86.2019.01.21.07.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 07:30:21 -0800 (PST)
Subject: Re: [PATCH 05/17] Add io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, hch@lst.de, jmoyer@redhat.com,
        avi@scylladb.com, linux-block-owner@vger.kernel.org
References: <20190118161225.4545-1-axboe@kernel.dk>
 <20190118161225.4545-6-axboe@kernel.dk>
 <20204806b30147da55990e639586cce1@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <801e00ef-b21d-4420-9fa3-2b19fe2398b2@kernel.dk>
Date:   Mon, 21 Jan 2019 08:30:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20204806b30147da55990e639586cce1@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/19 2:13 AM, Roman Penyaev wrote:
> On 2019-01-18 17:12, Jens Axboe wrote:
> 
> [...]
> 
>> +
>> +static int io_uring_create(unsigned entries, struct io_uring_params 
>> *p,
>> +			   bool compat)
>> +{
>> +	struct user_struct *user = NULL;
>> +	struct io_ring_ctx *ctx;
>> +	int ret;
>> +
>> +	if (entries > IORING_MAX_ENTRIES)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Use twice as many entries for the CQ ring. It's possible for the
>> +	 * application to drive a higher depth than the size of the SQ ring,
>> +	 * since the sqes are only used at submission time. This allows for
>> +	 * some flexibility in overcommitting a bit.
>> +	 */
>> +	p->sq_entries = roundup_pow_of_two(entries);
>> +	p->cq_entries = 2 * p->sq_entries;
>> +
>> +	if (!capable(CAP_IPC_LOCK)) {
>> +		user = get_uid(current_user());
>> +		ret = __io_account_mem(user, ring_pages(p->sq_entries,
>> +							p->cq_entries));
>> +		if (ret) {
>> +			free_uid(user);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	ctx = io_ring_ctx_alloc(p);
>> +	if (!ctx)
>> +		return -ENOMEM;
> 
> Hi Jens,
> 
> It seems pages should be "unaccounted" back here and uid freed if path
> with "if (!capable(CAP_IPC_LOCK))" above was taken.

Thanks, yes that is leaky. I'll fix that up.

> But really, could please someone explain me what is wrong with 
> allocating
> all urings in mmap() without touching RLIMIT_MEMLOCK at all?  Thus all
> memory will be accounted to the caller app and if app is greedy it will
> be killed by oom.  What I'm missing?

I don't really what that'd change, if we do it off the ->mmap() or when
we setup the io_uring instance with io_uring_setup(2). We need this memory
to be pinned, we can't fault on it.

-- 
Jens Axboe

