Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296B9C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 02:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA482075A
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 02:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MhroK2m3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfKUCAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:00:46 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35841 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKUCAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 21:00:46 -0500
Received: by mail-pg1-f195.google.com with SMTP id k13so743587pgh.3
        for <linux-block@vger.kernel.org>; Wed, 20 Nov 2019 18:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9xapPHDVf3PXGdJNv/Of7REbSrhUR9JDR9JGay/Sbz0=;
        b=MhroK2m3cXwzUewkA6lyJHsjsIuZN7JmW6RfzTSbyx0cZfvoFkkibIuSjgfM4yu+aI
         ISVuIgtLFPBgJX7EK7kUekT7vxwfR9I16GSMzU9GBsaXF04kifcQo/bLPeZ2BSMVQ95k
         DfW/ApPqsSiC2WnRvG+7jXpOksDE8+STha3ko8LY8bPvAc6BKRLqOq4xnC90zR7vTjmx
         wgv2Gy3mR1AzxDtdtb3XcypnT/+6dZNUn0OX06Q8ZL7FWL7SZFGsfWZZjKX0+Czp1xCm
         fjFdT/HpqDCH+VKdL96h8RACb7wgO9t3YXiBxqbfYcebJS27mXGuwZRmuShh+/v2fjug
         isRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9xapPHDVf3PXGdJNv/Of7REbSrhUR9JDR9JGay/Sbz0=;
        b=iAx9wAa/7+4BdgWgcXIARbCpZ9vwiSwHCnbiEVlHnw0srX0kvI8gNiC2g5Ag1CtoRA
         HvgFAYgwnfIT+pw7cvR3xF1aSkmURII86r4MOc97sxSA0sSqlJSYhjg5cA85xAghdBoS
         yl1oeZ4RTg/NWMVqrgyRjR7pxx64YFmznHW+19h7J0mAmByON0fAaZkjz38Go+IOVgpe
         ZTjKnC4lrFt4rG+L7+IPmo5CI/X5Oyj5y5MWiKTCmNtgXCDIos9aJfKVh0T7g1qH8RTa
         mGeaC8AmyrROl4vU+UUkdVsUkRV3xoCq58YBoOP7yVCCfdJJFIXWZtB97Zt33Tg6gPU0
         411A==
X-Gm-Message-State: APjAAAV/8l0WUvCSjH5XBZzyb9QTHJcRcCS3KnFZvPTTgMx1z0QF7WaB
        EYCgLIbTcWM6KjnoY0PM73w48A==
X-Google-Smtp-Source: APXvYqzPCUUyrUhLNbEH09DScv2yuCoJodtIQUrm92K+ARqktL/H1Fjmtq72cnbqy5pOKRdhPJs2yA==
X-Received: by 2002:aa7:82d8:: with SMTP id f24mr7583923pfn.55.1574301644181;
        Wed, 20 Nov 2019 18:00:44 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 193sm767514pfv.18.2019.11.20.18.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 18:00:43 -0800 (PST)
Subject: Re: null_handle_cmd() doesn't initialize data when reading
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-block@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>
References: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d204a9d7-3722-5e55-d6cc-3018e366981e@kernel.dk>
Date:   Wed, 20 Nov 2019 16:12:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=VBHmBgqLi35tD27NRLH2tEZLH=Y+rTfZ3rKNz9ipG+jQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 3:16 AM, Alexander Potapenko wrote:
> Hi Jens,
> 
> I'm debugging an issue in nullb driver reported by KMSAN at QEMU startup.
> There are numerous reports like the one below when checking nullb for
> different partition types.
> Basically, read_dev_sector() allocates a cache page which is then
> wrapped into a bio and passed to the device driver, but never
> initialized.
> 
> I've tracked the problem down to a call to null_handle_cmd(cmd,
> /*sector*/0, /*nr_sectors*/8, /*op*/0).
> Turns out all the if-branches in this function are skipped, so neither
> of null_handle_throttled(), null_handle_flush(),
> null_handle_badblocks(), null_handle_memory_backed(),
> null_handle_zoned() is executed, and we proceed directly to
> nullb_complete_cmd().
> 
> As a result, the pages read from the nullb device are never
> initialized, at least at boot time.
> How can we fix this?
> 
> This bug may also have something to do with
> https://groups.google.com/d/topic/syzkaller-bugs/d0fmiL9Vi9k/discussion.

Probably just want to have the read path actually memset() them to
zero, or something like that.

-- 
Jens Axboe

