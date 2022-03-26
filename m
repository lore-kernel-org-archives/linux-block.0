Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59420C433F5
	for <linux-block@archiver.kernel.org>; Sat, 26 Mar 2022 19:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbiCZTQh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Mar 2022 15:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiCZTQg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Mar 2022 15:16:36 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4227F4617A
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 12:14:59 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id a30so6775805ljq.13
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 12:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZrSonZ9t4aFfjMExroET0FS1GvqweLwgmT83h6UhFjg=;
        b=CFpUnay9QTjj1Nrli7fPKHswFdNDhig3MHObC57lHOoS6JOsPYdds7q/R1piQ6zTHZ
         OJq++OpQln2Cf8AqVwsM6RPzJ2P8eVDT2cdnX2Rmb54n3I7nOiLGu0L4U4G6d92tfWEE
         gGFOCP2sV5uXxLvcvW6xUj+senNTbCdwVTR3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZrSonZ9t4aFfjMExroET0FS1GvqweLwgmT83h6UhFjg=;
        b=AHLVWRZvcwMhaKvSDolunJvJzHXB0Td3fziBMnq5kPoHQCi+zGqpHkOH8KSNjspw1T
         AbB+b1aNYS24Mi2R8Y6jAAWHc4Y4f2I7L3RRlPWLO0kbxFG7tUSXbm6XL7fVHjKHKvG0
         hdRYkLdgHr3f4IPKRt3/PxfEGAl2LPKULw4ag7Zpzc6CvFfHqklLqdyRM3SbHRXym+SR
         AitNOqsSKN7zwt0eISAS6OLSBL4ysla/0n8UQ9KPXhFho0/LT9S084AFXdpp1R/Ka4i4
         AGkNb/+yvXWCiu2oU40srDbltPiHrErqteElTIxQZqmD/ZLqSXRnqq9Vtt0i0nI+pGxb
         gpFQ==
X-Gm-Message-State: AOAM533lMuRHcje00HezSMsgRaciKGZyizkyk2RaE9mIIh3mwo6uj1z5
        qDrPKXGGgBar2cLSl/EUcUGPfhcsuD/PnJPkOhY=
X-Google-Smtp-Source: ABdhPJxqXKBy7AZuSCmqORzvI4HW3rEX8ZlTOjEICsYIqGfsYajuurB6dy5jfMOqRc/n/SXOzwUh3A==
X-Received: by 2002:a05:651c:1304:b0:249:7c9a:e5c8 with SMTP id u4-20020a05651c130400b002497c9ae5c8mr13176068lja.386.1648322097314;
        Sat, 26 Mar 2022 12:14:57 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id d24-20020a193858000000b0044a6c26e613sm841849lfj.65.2022.03.26.12.14.56
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Mar 2022 12:14:56 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id h7so18535962lfl.2
        for <linux-block@vger.kernel.org>; Sat, 26 Mar 2022 12:14:56 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr13244060lfu.542.1648322095684; Sat, 26
 Mar 2022 12:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk>
In-Reply-To: <37e3c459-0de0-3d23-11d2-7d7d39e5e941@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Mar 2022 12:14:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5AdZUOR8xYc6cxM2wZ_CtanV+e+B6b6pBsha9XXwxbA@mail.gmail.com>
Message-ID: <CAHk-=wh5AdZUOR8xYc6cxM2wZ_CtanV+e+B6b6pBsha9XXwxbA@mail.gmail.com>
Subject: Re: [GIT PULL] Support for 64-bit data integrity
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 25, 2022 at 8:18 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> This pull request adds support for 64-bit data integrity in the block
> layer and in NVMe.

I've pulled this, but people - please don't do silly things like this:

> Keith Busch (9):
>       linux/kernel: introduce lower_48_bits function

There is *NO* excuse for adding this completely trivial and pointless
function to a core kernel header file.

It isn't generic enough to make sense. "48" just isn't a common enough number.

Maybe

It isn't *complex* enough to make sense.

It isn't even clarifying the code.

Honestly, the advantage of writing

        seed = lower_48_bits(iter->seed);

over just writing it out the usual way, or using one of our existing
helpers like

        seed = iter->seed & GENMASK_ULL(47,0);

is just not there.

And it damn well shouldn't be in some <linux/kernel.h> header file. If
you ABSOLUTELY need to have it, put it in some NVMe-specific header
file where it (maybe) belongs.
