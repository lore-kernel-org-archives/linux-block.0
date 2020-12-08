Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65C7C4361B
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70A9623A1D
	for <linux-block@archiver.kernel.org>; Tue,  8 Dec 2020 00:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgLHAh0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 19:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgLHAhZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 19:37:25 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1163C061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 16:36:39 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id d2so8256062pfq.5
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 16:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=IvcPJHZoFunkHsXGJz6TCzw66X+X7Y8MJpDqWrC0LTY=;
        b=vIruKcKRfHol7GzqTvEmVBeeCB85QZXBQz5mFqZQZ9S+xYurgJKGqtX4CsD/06AmNh
         hVGsHt54495brcLTwrUo0Wfeqa/vuIfFxX9+KfNJEIAMS0Tl6Dz30Tcxz/Hca/EouPgb
         eJT/5NQhFgVGAKNGj7Nf0+Y2m4+OEExCq5ZP2NwQzcfjNeNMmtSuPFJCGlgNUq+Sskuu
         El2duvtTNB7/AIekSND1NQpOQn4RddJXWge/dlu6ny7RiGCBOL2fEIMkI980CV57xliv
         Hk5C6OCywNrlaSjlcCgeN2YboC5MtMQ2oMdAWFHh/Jg1hPMv6dDnCaAwD3dDr1AvHJ2K
         2r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IvcPJHZoFunkHsXGJz6TCzw66X+X7Y8MJpDqWrC0LTY=;
        b=k9c0IHbfi4GfBQBRTt1FvaK46F/neFRuYfY9nAhE8QXQmZ4DP8yxt8HE053Hwx9Kaw
         WNaTGNemwZTD8P8SA36BIFwZ+HlboZ1MUSo9BDZ1P9GIzCTtO713khcXQSfXFnr6Ytm0
         iVCVFhYQnC4q1/RxMGSyjFu9fICuuaxkja5KjTGTcKMyPeJGwUwcOLDMH8uICUscZSk3
         XzV2lU5mGO9a5sCVLvMlVuwu/Tm1xw5oiaVwD1Jiw4Tjx6ycsx6Ami1nZsvIdbigaJ0q
         lQANVgbaj0IcEqbOM1gWfB5Rd2duyT+ICGiR6KUOWuWVMOcDjwOSQV3ZIKWrLwD31X5D
         a3Qw==
X-Gm-Message-State: AOAM531w1MUPzXkg9YUdYsW2FeR/FqoeJGWfE7HtiA5qlOnthW9EazUL
        KJ7mSQItermMhfACOFqAwrDgK2iodBGiJA==
X-Google-Smtp-Source: ABdhPJxhWpI/53NsU4PHZgmVGNpxfEb0/xPFthqRekH0tS0LpuIbnrudQZHXimvdclMOV74nGEr/Ww==
X-Received: by 2002:a63:6f42:: with SMTP id k63mr20470904pgc.140.1607387799213;
        Mon, 07 Dec 2020 16:36:39 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v126sm15675011pfb.137.2020.12.07.16.36.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 16:36:38 -0800 (PST)
Subject: Re: [PATCH v4 0/9] null_blk fixes, improvements and cleanup
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20201120015519.276820-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb9a82fd-b89a-d2a4-5b3c-c0d2e9373bb4@kernel.dk>
Date:   Mon, 7 Dec 2020 17:36:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120015519.276820-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/20 6:55 PM, Damien Le Moal wrote:
> Jens,
> 
> This series provides fixes and improvements for null_blk.
> 
> The first two patches are bug fixes which likely should go into 5.10.
> The first patch fixes a problem with zone initialization when the
> device capacity is not a multiple of the zone size and the second
> patch fixes zone append handling.
> 
> The following patches are improvements and cleanups:
> * Patch 3 makes sure that the device max_sectors limit is aligned to the
>   block size.
> * Patch 4 improves zone locking overall, and especially the memory
>   backing disabled case by introducing a spinlock array to implement a
>   per zone lock in place of a global lock. With this patch, write
>   performance remains mostly unchanged, but read performance with a
>   multi-queue setup more than double from 1.3 MIOPS to 3.3 MIOPS (4K
>   random reads to zones with fio zonemode=zbd).
> * Patch 5 improves implicit zone close
> * Patch 6 and 7 cleanup discard handling code and use that code to free
>   the memory backing a zone that is being reset.
> * Patch 8 adds the max_sectors configuration option to allow changing
>   the max_sectors/max_hw_sectors of the device.
> * Finally, patch 9 moves nullblk into its own directory under
>   drivers/block/null_blk/

Applied, thanks.

-- 
Jens Axboe

