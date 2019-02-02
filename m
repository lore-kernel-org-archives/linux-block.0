Return-Path: <SRS0=HKPG=QJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E376C282D7
	for <linux-block@archiver.kernel.org>; Sat,  2 Feb 2019 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B6620870
	for <linux-block@archiver.kernel.org>; Sat,  2 Feb 2019 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BmhEvY6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfBBNwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:52:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46559 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfBBNwO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Feb 2019 08:52:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id cx1so601688plb.13
        for <linux-block@vger.kernel.org>; Sat, 02 Feb 2019 05:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5AlC4QyPW06AOvRKH00wDqsFC9lnxfI9v2oY0wpWUPk=;
        b=BmhEvY6sQi3L6+TarsP49S1wke6PtAldkGmnnjjMoSfDd5UTD0c4qSTOcRv/Gg+3Q1
         hgsPBgBhBXMjHE69h/HDpXS2optKFJVpCnH0Q1hoCoIpiMl487ilzbbyKoucTsC50ZB0
         eQMwL4oFGjKg6JSKq8/XypMR8ZMtW+8WzWdVW6nNCdxvzo30qjtYDWUobJ+6kVeF+jSV
         Us0imCnE3G6PC4J4dF2f+cr/RB2BYB01Zhb7GKEz64iE8dsVfOsMT9lAuvmycPIkc9EY
         NugZT9xW68m+jHLyp0VGWMFNwtdrH4m1KNi2GTtQwKDT5Bpyjz0k1tj8b8ohbMA57DQv
         FJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5AlC4QyPW06AOvRKH00wDqsFC9lnxfI9v2oY0wpWUPk=;
        b=TCNtXnoa0GEI8diVdKoTXhDEuIeQr3Z8LsZAa/AFQa7YohghPhIsLDeR8ZH+tcRo/L
         WZGSyCZ+HyJjSXNslw6b0ab4d3+qiOFiXJCuMXy4lh0s6CyL78kB0fMZ9lx4jf75yeV5
         38UGXE/Kg7m74yZeGDOYA9dYo2zdoYG0idd2I0Ggdu1zmSqmsOnFeArt20xO5aVtSRPn
         phdraoy+w5IIl8M+75UQ/mfBb+Gd+e0Cdo+605Vqt5fndr34x/da/Cl+s4u6dv9H3CNu
         EAcn/EvQJF9LLwJVnvvakUZSmOqulRp+Hew97Hh2ZkeOwl58eSTeMyyTeAJckzZ74sDA
         B5Tg==
X-Gm-Message-State: AHQUAubt80TneC08Z9oMsDceQyv/B9lxP+dnJ/G2GQ+LgB3wsNPVSClQ
        6z52IoTWKCTyUOwfkhjreDbGoQ==
X-Google-Smtp-Source: AHgI3Ibje411fbtlDjTq8xB0V7DYuTVCwZqgThpxHMxTnxengNVjNibPsvPswhBgcOvGfK6jUOiQKg==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr2306774pld.91.1549115533768;
        Sat, 02 Feb 2019 05:52:13 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d13sm26040183pfd.58.2019.02.02.05.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:52:12 -0800 (PST)
Subject: Re: [PATCHSET v11] io_uring IO interface
To:     Bart Van Assche <bvanassche@acm.org>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
References: <20190201152414.23296-1-axboe@kernel.dk>
 <1549061551.164323.17.camel@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1cb6406f-1408-c38c-e8ed-520bce965569@kernel.dk>
Date:   Sat, 2 Feb 2019 06:52:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549061551.164323.17.camel@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 3:52 PM, Bart Van Assche wrote:
> On Fri, 2019-02-01 at 08:23 -0700, Jens Axboe wrote:
>> Here's v11 of the io_uring project. Main fixes in this release is a
>> rework of how we grab the ctx->uring_lock, never using trylock for it in
>> a user visible way. Outside of that, fixes around locking for the polled
>> list when we hit -EAGAIN conditions on IO submit. This fixes list
>> corruption issues with polling that some users have reported.
>>
>> As far as I'm concerned, this project is ready to get staged for 5.1.
>> Please do review carefully so we can fix any minor nits that might still
>> exist.
>>
>> The liburing git repo has a full set of man pages for this, though they
>> could probably still use a bit of polish. I'd also like to see a
>> io_uring(7) man page to describe the overall design of the project,
>> expect that in the not-so-distant future. You can clone that here:
>>
>> git://git.kernel.dk/liburing
>>
>> Patches are against 5.0-rc4, and can also be found in my io_uring branch
>> here:
>>
>> git://git.kernel.dk/linux-block io_uring
>>
>> Changes since v10:
>> - Rework uring_lock locking
>> - Ensure that async contexts lock when fiddling with polled lists
>> - Minor tweak to io_iopoll_check() continue looping condition
>> - Fold __io_uring_enter() into io_uring_enter()
> 
> Hi Jens,
> 
> Which goal(s) do you want to realize with this new API? Is the goal
> perhaps to reduce the overhead of submitting I/O and receiving I/O
> completions?  If so, where can I find a comparison of the performance
> of this API with libaio and synchronous I/O?

Yes, it's to reduce the overhead of the interface, since aio isn't very
good. It's also to provide something that's more feature rich. It's
embarassing that we STILL don't have async buffered IO support, for
instance. With this infrastructure, we do.

In terms of benchmarks against aio, I included some in the v5 posting:

https://lore.kernel.org/linux-block/20190116175003.17880-1-axboe@kernel.dk/

I haven't done any against sync IO, but since you can use this interface
in a sync manner (just have min_complete == to_submit), there won't be
much of a difference, if any. If you use some of the more advanced
features, like pre-mapped buffers, it'll be faster than the current sync
IO.

-- 
Jens Axboe

