Return-Path: <SRS0=sC6v=PZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E25C43387
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ECC20652
	for <linux-block@archiver.kernel.org>; Thu, 17 Jan 2019 14:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="j4w18EuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfAQOys (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:54:48 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46296 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbfAQOys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jan 2019 09:54:48 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so4532269pgp.13
        for <linux-block@vger.kernel.org>; Thu, 17 Jan 2019 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m5CBrqp0iqhc29uw0yzsJhIdgNv77XqVURvfcftCQUY=;
        b=j4w18EuIxfUogVn9SygqNAg0mC3ziEwtkggZAQiHYtoJteqFufaPOk1PlOuvpcH5sj
         QrGWn3pJqTOUQ3WcIAHptyFKkvqEbbWy5FFNbLJd/7NNt9/i8gEocJRBDDrOWC9nuAtb
         PeQbdvZ74nryGtSHkeAi22/lxpti8Usr8u62oMakNAmsG7WAY1l//2uOOa8sa89olHpJ
         Kbswc+ksXmQt5HLw9ViD9y6/oxz2OBy5g+U0fVfmh6Pd+b+KcFON0PWnYcFuIoYsAvNJ
         cSL4sKfP/AC1+1eexqgrAaa0oECO3PLpMeykM4qgh9GQq6fxvW8PmU5qaHZOMMV31PTs
         Xp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m5CBrqp0iqhc29uw0yzsJhIdgNv77XqVURvfcftCQUY=;
        b=nlVgBPwXtBluApAA4/uUzKdJd5mdsi4Wb4i6PU0m4ZoqxzZ9FIhfUtT72nwlvulUpi
         143S4rgZ/yAxqnOKghpNQdsDef9oFnIXseI58YnyhfxMbhJfMZ6/Op3BQxUWhcHXtljD
         xV0w9Z7XTRJhjW1gsAHvIYsXdoOBQA9fQ2Nj3aTe82iW3RlzZqehCyOAviyWteVK94MA
         Y02dhRSireI9TB/5gETQtDVRuc9wye+Sgf1sVXNj6z4yfeZplfLdF1A6VG4+j7zL48rU
         FxM5LNgBCdiQ+lrMgwkSuuh7+GnMtFNcK6msCyCcj0cucAmryycL1DA7X7u+JkXXzH1u
         /9nw==
X-Gm-Message-State: AJcUukf8hzBuvbb4fUxvOcNgEgrkoQrIYJwkW9AYtsD7fKid2JOMVdul
        A3MLdmA/aq+5RHm/BCgQ1zYtKg==
X-Google-Smtp-Source: ALg8bN72WkkJyYEOw6XIXNdT1IYLzpCsDy2xCesmVDLjMHToGNmxSqllDTaDFposQ3n8URX3fybuYA==
X-Received: by 2002:a62:42d4:: with SMTP id h81mr15186881pfd.259.1547736887235;
        Thu, 17 Jan 2019 06:54:47 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b9sm2608171pfi.118.2019.01.17.06.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 06:54:45 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-block-owner@vger.kernel.org
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <362738449bd3f83d18cb1056acc9b875@suse.de>
 <cf948a5c-a05f-82c8-2ce9-937dec069567@kernel.dk>
 <24a609aa05936eb2380f93487be8736c@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3d902f9-06f8-9e9e-4dcf-ad09e4e291ae@kernel.dk>
Date:   Thu, 17 Jan 2019 07:54:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <24a609aa05936eb2380f93487be8736c@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/19 7:34 AM, Roman Penyaev wrote:
> On 2019-01-17 14:54, Jens Axboe wrote:
>> On 1/17/19 5:02 AM, Roman Penyaev wrote:
>>> Hi Jens,
>>>
>>> On 2019-01-16 18:49, Jens Axboe wrote:
>>>
>>> [...]
>>>
>>>> +static void *io_mem_alloc(size_t size)
>>>> +{
>>>> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | 
>>>> __GFP_COMP
>>>> |
>>>> +				__GFP_NORETRY;
>>>> +
>>>> +	return (void *) __get_free_pages(gfp_flags, get_order(size));
>>>
>>> Since these pages are shared between kernel and userspace, do we need
>>> to care about d-cache aliasing on armv6 (or other "strange" archs
>>> which I've never seen) with vivt or vipt cpu caches?
>>>
>>> E.g. vmalloc_user() targets this problem by aligning kernel address
>>> on SHMLBA, so no flush_dcache_page() is required.
>>
>> I'm honestly not sure, it'd be trivial enough to stick a
>> flush_dcache_page() into the few areas we'd need it. The rings are
>> already page (SHMLBA) aligned.
> 
> For arm SHMLBA is not a page, it is 4x page.  So for userspace vaddr
> which mmap() returns is aligned, but for kernel not.  So indeed
> flush_dcache_page() should be used.

Oh indeed, my bad.

> The other question which I can't answer myself is the order of
> flush_dcache_page() and smp_wmb().  Does flush_scache_page() implies
> flush of the cpu write buffer?   Or firstly smp_wmb() should be done
> in order to flush everything to cache.  Here is what arm spec says
> about write-back cache:
> 
> "Writes that miss in the cache are placed in the write buffer and
> appear on the AMBA ASB interface. The CPU continues execution as
> soon as the write is placed in the write buffer."
> 
> So if you firstly do flush_dcache_page() will it flush write buffer?
> Because it seems that firstly smp_wmb() and then flush_dcache_page(),
> or I am going mad?

I don't think you're going mad! We'd first need smp_wmb() to order the
writes, then the flush_dcache_page(). For filling the CQ ring, we'd also
need to flush the page the cqe belongs to.

Question is if we care enough about performance on vivt to do something
about that. I know what my answer will be... If others care, they can
incrementally improve upon that.

-- 
Jens Axboe

