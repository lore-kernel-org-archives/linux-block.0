Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47339C433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 17:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiF2RQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiF2RQN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 13:16:13 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB43CA66
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 10:16:12 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id q18so14679267pld.13
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 10:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/+DA51ULPJFbE6Y+XCYKni6lHNUdKvUDD3ikKmPRkTc=;
        b=LvM4+4s72a5HL8dl73wjDhDkw4qwi4hworxeuGXzRsZM+z2nNUWMzDNMGYZHVFxMrW
         q9TsdwMUzro4cJ+vpQbm+N7e3hvGA5pzeCNSSns4dsO3/K3KttuBsE2qDGp9nvlyRwax
         6mfQey6M/TVtbfRKFud9Pk55GjZIm3g1/aiyTkwR8VOh+LBHwlM2lEODkRFEjBLEosyq
         S6F+RHGk1TKBn138gQXfv+SWQZaTooYwxzyAsywTEHoDxmBSdGaM5+hJIuhsZY1Iq3O5
         QdpVowZyC3tP90ealsFUSc1ZDI64UwXRBA1AfFYSTAyKs5YFpbIqf+MWnB5SioAMN9c1
         QF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/+DA51ULPJFbE6Y+XCYKni6lHNUdKvUDD3ikKmPRkTc=;
        b=0TClBzMYwryV3xTu6d3/j96tnSLafu+S06FlX5EzbR14XXSgi/bwSAgxsjKcjPjdl9
         EwBoV4UgVn1+ZA6E8kv9thI4ZRB7XqoG3WpDd8Ins9hcEJyVGobE8Zo6ldNGatAmAArU
         Bdgqc05XnrFifUZB8tYkCIyxBDM9dWWapkMd0fczacioDuzcEwe34iOt86SPu/sQEiqj
         SBPmL0JRnOMlxyHAz4Wc/rGVLYPQJvcpJVMiDgZAFDdvBgMIHwlj/kQ3TNoCfrAJ5+uw
         xufApGykeOTvUwtj1PECiztuZzA+oTwcsNKpXI+kK1K7eehUwm67WlC6xCZXZGeyXJgQ
         YoKg==
X-Gm-Message-State: AJIora/FRD6KXRV+zZoG2IfdE4swPsThgjZjdBWw9mQ2v5URu43ip5FQ
        dF8O+I5wrQAGw8a6VTw+TcnwMw==
X-Google-Smtp-Source: AGRyM1sYNbBYpPvY4Y2mmMGPN6ZIDBjC6tPIou6i47La2wx6f5mLpJ1OqrepCLDg5syxHJkuqTf4Sw==
X-Received: by 2002:a17:902:f813:b0:169:8f5d:c343 with SMTP id ix19-20020a170902f81300b001698f5dc343mr11359822plb.98.1656522972323;
        Wed, 29 Jun 2022 10:16:12 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t14-20020a17090340ce00b00163bddfb109sm11614197pld.10.2022.06.29.10.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 10:16:11 -0700 (PDT)
Message-ID: <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
Date:   Wed, 29 Jun 2022 11:16:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan> <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/22 12:32 PM, Kent Overstreet wrote:
> On Tue, Jun 28, 2022 at 12:13:06PM -0600, Jens Axboe wrote:
>> It's much less about using whatever amount of memory for inflight IO,
>> and much more about not bloating fast path structures (of which the
>> bio is certainly one). All of this gunk has to be initialized for
>> each IO, and that's the real issue.
>>
>> Just look at the recent work for iov_iter and why ITER_UBUF makes
>> sense to do.
>>
>> This is not a commentary on this patchset, just a general
>> observation. Sizes of hot data structures DO matter, and quite a bit
>> so.
> 
> Younger me would have definitely been in agreement; initializing these
> structs definitely tends to show up in profiles.

Older me still greatly cares :-)

> These days I'm somewhat less inclined towards that view - profiles
> naturally highlight where your cache misses are happening, and
> initializing a freshly allocated data structure is always going to be
> a cache miss. But the difference between touching 3 and 6 contiguous
> cachelines is practically nil...  assuming we aren't doing anything
> stupid like using memset (despite what Linus wants from the CPU
> vendors, rep stos _still_ sucks) and perhaps inserting prefetches
> where appropriate.
> 
> And I see work going by that makes me really wonder if it was
> justified - in particular I _really_ want to know if Christoph's bio
> initialization change was justified by actual benchmarks and what
> those numbers were, vs. looking at profiles. Wasn't anything in the
> commit log...

Not sure what Christoph change you are referring to, but all the ones
that I did to improve the init side were all backed by numbers I ran at
that time (and most/all of the commit messages will have that data). So
yes, it is indeed still very noticeable. Maybe not at 100K IOPS, but at
10M on a core it most certainly is.

I'm all for having solid and maintainable code, obviously, but frivolous
bloating of structures and more expensive setup cannot be hand waved
away with "it doesn't matter if we touch 3 or 6 cachelines" because we
obviously have a disagreement on that.

-- 
Jens Axboe

