Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0FC65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F9F820672
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 16:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wPFXhZUs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F9F820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbeLLQgj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:36:39 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39960 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeLLQgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 11:36:39 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so10759785ita.5
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 08:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zgeCD1betO4EgGCCIKSPxE0ySS5/CEKXvjEzDNIBKWc=;
        b=wPFXhZUsTnf6HXGQfTSF/MN2sn1sTazJcfI4Et6hVSbsurqwXHagAdIXJrIMIqspYk
         JJpfs8yQt2oFgq0R2B1HiNTx/GCm7Qq6Ks/ui6VMoQxOvp/Ji/lMGnGiZq/5RTNI9YNI
         y0ury0VELRFTz03XSj9drxXbzbiTLmLwxfNSOIO0PX05adyKsYp73Th7DBBcxK45YEax
         zrat+kvdE0sgYnpbLElnn9K94duuBXoL7oDpu2hLbVfD8XMVDGnEaD5RVyM7exrKRGf9
         qoW2TIIc1jPwauqGCz/dlujqqJcAxedPxkUEOJ9+Ke36sOgHSqpEhRuQ2ClOGVoaymED
         7cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zgeCD1betO4EgGCCIKSPxE0ySS5/CEKXvjEzDNIBKWc=;
        b=LMf2lq1pxAeeOy3U5qhKUHc2tDkv8EVPmIIYRbNG5keWxdYUEtCgkn9O585Ls6StOI
         HpGHVqhsDBFOpJPv6KTwnVojLYKZIopRSFdZBZOMvZqojcQZsX76o0WshEDWeN85qSBr
         e84Hp88vVNJy4B9oo1soO4Hr4zg+pRnJGwf3vP5P/rgFD3bHAotuCPUiQXbqBNECBx3x
         DZRbA3PEYJzJ40cCDpBNXVgdP+p569cbfK53PZ60KdNeEi9EWsC1CTPU1NiKVVzdU6Yj
         +R2Ud4TmZ32X2M7DhQZTSgTBCxFBjrh8yp05r+TXzkWBWjbg2lrbCcUCSuMsFNJWy1Ux
         oAwQ==
X-Gm-Message-State: AA+aEWZTHp6EhAqk+rkpdN8TiQwZCsiz/nVJKXbHfSxn30qIiPotZanu
        vTDe19aHWz5yUZSWccr88jROuw==
X-Google-Smtp-Source: AFSGD/XgJJdtQ3zhMEXZw2FdWHFwR2S8Zd4Afjf5ycu0ehUKS5MmpNgTa69DJ/0pLlD3Cg3m0lwhoA==
X-Received: by 2002:a02:ba01:: with SMTP id z1mr3385837jan.100.1544632598748;
        Wed, 12 Dec 2018 08:36:38 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m45sm2842983iti.10.2018.12.12.08.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 08:36:37 -0800 (PST)
Subject: Re: [PATCH v2] nvme: provide fallback for discard alloc failure
To:     Keith Busch <keith.busch@intel.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>
References: <87d6d992-6d9f-c863-c14c-e4f3555cb3d6@kernel.dk>
 <20181212162855.GA10895@localhost.localdomain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f53d0bc1-6fe0-12e5-c210-e583d71bc739@kernel.dk>
Date:   Wed, 12 Dec 2018 09:36:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181212162855.GA10895@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/12/18 9:28 AM, Keith Busch wrote:
> On Wed, Dec 12, 2018 at 09:18:11AM -0700, Jens Axboe wrote:
>> When boxes are run near (or to) OOM, we have a problem with the discard
>> page allocation in nvme. If we fail allocating the special page, we
>> return busy, and it'll get retried. But since ordering is honored for
>> dispatch requests, we can keep retrying this same IO and failing. Behind
>> that IO could be requests that want to free memory, but they never get
>> the chance.
>>
>> Allocate a fixed discard page per controller for a safe fallback, and use
>> that if the initial allocation fails.
> 
> Do we need to allocate this per controller? One page for the whole driver
> may be sufficient to make forward progress, right?

It should be, but that might create a shit storm if we're OOM and have
tons of drives. I think one per controller is saner, and it's dwarfed
by memory we consume anyway in static allocations.

-- 
Jens Axboe

