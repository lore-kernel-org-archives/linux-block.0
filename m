Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB90EC433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 23:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D25A613C3
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 23:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhDWXSu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhDWXSs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 19:18:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25244C061574
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 16:18:09 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h15so17338518pfv.2
        for <linux-block@vger.kernel.org>; Fri, 23 Apr 2021 16:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d0/N2jEwDHpJn6k6ipoibjeRwgq1L+BzE5aybLBpoy4=;
        b=wBfLojy8KnfzXRNIAqHhyTVC75XJU2LsOgM+LTowyl3g5Vp0up70eN2inMG1Ix92iE
         3UyLjNCtliUtmWjOT9turaQq3ZiDkwy/CZCcMiSJuPohACvvg8PXpQXAymoJvKFTcokD
         /1odwz+SNobRjFm+CN891lZeJ6hhwXDUDF4WfnodBOxRmvpRhW7Zx5WQzpEsXGzqAKVP
         dD0NEspM0sSruJEO+ozdiNl6YIW5Lom10wsjKZRcyguHGY2U0lXJIhbwEypIMy7yaMAq
         bf1oHgHX+0mc4VcsbudF4P6VIavtnSmcTCoKl6Wy8LbxJni+oHtK+A6os9c9Mq3nXQ3Y
         FjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d0/N2jEwDHpJn6k6ipoibjeRwgq1L+BzE5aybLBpoy4=;
        b=QCioWZpgHS7SvoscfO60U9IhnDi8584aMhxAsus1jce35DcAilJ12tVAgCBudmPI/S
         +vr4bKgrPKf05UkTydFSNj7Tr4teSVZhBNO8BjjZA75L6/3UgdHrrJKFI6/ftlgGKel8
         Ld3HcUkdq7o5WIE1t8UFXIZru3C2uSPumUdxuJ63JAmcgTncfTNRFpzt0h7l5SKeF7sv
         peK+1a+XjlfXp1tA0198BZjeUPagvPckWxEdu7qY5CnFXYEqhV6JBEGivuUk961v8Vf+
         Kvw0MX31epkgafzdtFr48F+y6r+QvNOr6Nw90gdVN0Z2eW7zUFywH+22Tygsyta6kkyC
         /21g==
X-Gm-Message-State: AOAM5302iVEU/ZZ/sBlqjWabognnLUqS0oUjdEzHsqgqmHxdtzZsw9xA
        SUKGf5x6d/YvBZ9VxDQGfzNazJtaW73REg==
X-Google-Smtp-Source: ABdhPJzLjmNI5nWzp6S6z6TgDpQtZj2Wjpzujd5r1JJXiGXAy+kHyGUZY10tf7EeSU29R0ZJbtqmYQ==
X-Received: by 2002:a63:ee0f:: with SMTP id e15mr6059749pgi.310.1619219888403;
        Fri, 23 Apr 2021 16:18:08 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n11sm6093989pff.96.2021.04.23.16.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 16:18:07 -0700 (PDT)
Subject: Re: [GIT PULL] Block fix for 5.12 final
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk>
 <CAHk-=wi5otGvBvWGx-XC=es88Xghe1TNFEYg_ZwoiZBzRvGeRA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea03f25e-90b7-f099-cba9-c2ae13b8e616@kernel.dk>
Date:   Fri, 23 Apr 2021 17:18:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wi5otGvBvWGx-XC=es88Xghe1TNFEYg_ZwoiZBzRvGeRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/23/21 3:54 PM, Linus Torvalds wrote:
> On Fri, Apr 23, 2021 at 2:06 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> A single fix for a behavioral regression in this series, when re-reading
>> the partition table with partitions open.
> 
> Hmm. The fact that it's no longer calling blk_drop_partitions() didn't
> just mean that the check for "bdev->bd_part_count" was lost (now
> re-instated).
> 
> It also seems to mean that blkdev_reread_part() no longer does the
> 
>         sync_blockdev(bdev);
>         invalidate_bdev(bdev);
> 
> to write back and invalidate any caches.
> 
> Are we sure cache writeback/invalidate isn't needed? Or does it get
> done some other place?

Hmm yes, that's a good point, we dropped both of those in the call trace
as part of 4601b4b130de2329fe06df80ed5d77265f2058e5 - Christoph, what
was the reasoning here?

-- 
Jens Axboe

