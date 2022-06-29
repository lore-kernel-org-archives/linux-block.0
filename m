Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA12C43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 19:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiF2TA5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiF2TA4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 15:00:56 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA001B781
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:00:55 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id h9-20020a17090a648900b001ecb8596e43so364474pjj.5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m3AG9RdQkKvq+okquL9cMs8wgYGcDdlD+r9O3qTKjIk=;
        b=Y0Do0lz99V4yd5Nz6loGNeMJcHJOHwnAfpADbQ07sp+Vog8oRwNc3y4b/SzcbjvRgR
         8r5qK5HsOvwFkg5X2+H1Gv/Y2QO6DKrnNA8e20WEvMdWx3HozBRx59tlcta46OXLRMAa
         ZX4rgGnWUHpsONLMxZezyxMn88g8TYpWP9MxBPvKohD8sW4SO5itsBkipZt1LqxyYYeL
         bUq1vkr8FzAgHtnoWEMVi6cSAAXVC+rBMSTpnqhzsaUrVGALJmmt9YgYqNFOBu93y1HU
         PlePt7BL0Ozw7v+aVVdRdfsNphsL1w+B5HS3br9PWKhgSCTZXCy99Pe7v6gDvNqHx2Kk
         KCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m3AG9RdQkKvq+okquL9cMs8wgYGcDdlD+r9O3qTKjIk=;
        b=ifjNE7aniLSBFkzUbXXBFeTcsgj0bp88lla2X9S8Xmzyt0HBWFU1h0mTRvtH2pSYo7
         6BwPBSqxpVjruiyhNcJmxBd+I3l7PXypYXlVq0OwPFWyNjrlyzCwfdvKBmh8i1Kr4aFQ
         MTmVH8P3vq2xaRyCOfGrY0CxFLPvhPSFUuP4OZIzF143Nxl4+/3nkq2bW//CFGecdb1F
         6+CbHNtiW3UQiTvNCpuQIM5bFEVc6JbkLbSVk8JUCjh7eqt58UblU49ytnPlhf07l1nq
         8LcmEDE75/7CZTDgjqIK09oZKjVfKLu87RTCxsSpiC+I0pCs6dnFvEcPJeEhw+H4Ob7q
         ssfw==
X-Gm-Message-State: AJIora/Q0eiWEnjEDWvtRvEQG31TRsRtVGG6N0EqGqwJaQNfNZG/jLEe
        E3LsLiABEq9JtYW5Dr30VZ55Pn+qYhe9cw==
X-Google-Smtp-Source: AGRyM1vuUg9v9LRXc8uTqf92k9LYfHqZPSVlOEAAitzYpiY+LZKy6uPkHW5NHxFB8qV8uBBcrBjMgw==
X-Received: by 2002:a17:90a:404a:b0:1ea:e936:b69 with SMTP id k10-20020a17090a404a00b001eae9360b69mr5299705pjg.133.1656529254467;
        Wed, 29 Jun 2022 12:00:54 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id pj4-20020a17090b4f4400b001ece6f492easm2602662pjb.44.2022.06.29.12.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:00:53 -0700 (PDT)
Message-ID: <3e15e116-ea64-501d-1292-7b2936b19681@kernel.dk>
Date:   Wed, 29 Jun 2022 13:00:52 -0600
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
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220629184001.b66bt4jnppjquzia@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 12:40 PM, Kent Overstreet wrote:
> On Wed, Jun 29, 2022 at 11:16:10AM -0600, Jens Axboe wrote:
>> Not sure what Christoph change you are referring to, but all the ones
>> that I did to improve the init side were all backed by numbers I ran at
>> that time (and most/all of the commit messages will have that data). So
>> yes, it is indeed still very noticeable. Maybe not at 100K IOPS, but at
>> 10M on a core it most certainly is.
> 
> I was referring to 609be1066731fea86436f5f91022f82e592ab456. You
> signed off on it, you must remember it...?

I'm sure we all remember each and every commit that gets applied,
particularly with such a precise description of the change.

>> I'm all for having solid and maintainable code, obviously, but frivolous
>> bloating of structures and more expensive setup cannot be hand waved
>> away with "it doesn't matter if we touch 3 or 6 cachelines" because we
>> obviously have a disagreement on that.
> 
> I wouldn't propose inflating struct _bio_ like that. But Jens, to be
> blunt - I know we have different priorities in the way we write code.
> Your writeback throttling code was buggy for _ages_ and I had users
> hitting deadlocks there that I pinged you about, and I could not make
> heads or tails of how that code was supposed to work and not for lack
> of time spent trying!

OK Kent, you just wasted your 2nd chance here. Plonk. There are many
rebuttals that could be made here, but I won't waste my time on it, nor
would it be appropriate.

Come back when you know how to act professionally. Or don't come back
at all.

-- 
Jens Axboe

