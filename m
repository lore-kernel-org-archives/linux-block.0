Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7748C43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570E20856
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lA+V4GhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfCZLxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:53:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45359 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731449AbfCZLxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 07:53:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id s15so13952488wra.12
        for <linux-block@vger.kernel.org>; Tue, 26 Mar 2019 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qCwyZ7FbocWnc8CdV4hERB3qHdj5lW3pd0mmcHt1d/Y=;
        b=lA+V4GhQqi69wzJUwIoniQ/0VSWSXbbmXCwu7ST3kbTLqJhSOpVbWpjWjEgaYXkdzx
         V95TZLWtXNNCkcbSvCiLnFwxlLfBLAmP0gN2ItZtNKKxh5grMhoMI9Ksb/PmD60xd9C6
         VsDFkgnYGYS2c9HRJGrXfXMN/jcD5+Rm0/W3IeYWiUhO33CVOlJY5YJde+I0bDzrn26z
         vMBF43kFFjDyYzd8z4fnpXqANLp1nvUceiKGYhEsKDoM+vpB5EsLQjGs8BPwCXGoDRgC
         FMFzOYF+/3BNeKAjx0HInQsBLRjpHac9xyO5/Gh6Ti7gHqoy73BBTJsU9LoaPiJMkRaw
         neJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=qCwyZ7FbocWnc8CdV4hERB3qHdj5lW3pd0mmcHt1d/Y=;
        b=KlaCpp9J2lP0YyaUvULCghwH3bhtiNvS6UQdX3U6MmBHA5Q5vfvL0mcDSHCMjoP9pr
         EN8at7tYvN+CQ8U9R1KCNP73aQJCOFZSYV1zpCwbRT49yL50vkgk+9lNfVyP4Nnnba/g
         sfLKLDeJ/0Nr3axGAMx3Yjm13uurUpHFGtD0oMRAWw3D+c6S1rjx/W/YouwjF0rPyYTn
         mRfVtHgHOVtORV6+8cuvDq8HY9+A2GY4tIOHvsEXJ+fYamUYrmLivTGspDSyTDKF5u+c
         O7YAXiKRcFg+4Y4Siyzm1s1lZRhwmm7CcXNFMbQBr4bEqhR8RWPLLwJFF5tMAFtHpASl
         VV1Q==
X-Gm-Message-State: APjAAAVBgyedLa5QauUzNSPR8DPxYevU7MShoCMxcEGIkliulzD629hC
        XP5KqmSG3OGQscxAQUALGDrqXw==
X-Google-Smtp-Source: APXvYqyeX/I68b4lNXD4S2vv5OCknWxQCRkhiZuUBlDLna75MBMeW8bjeTFJ/L2Nh+AMb+cd8fWQTw==
X-Received: by 2002:a5d:4087:: with SMTP id o7mr7830063wrp.9.1553601187651;
        Tue, 26 Mar 2019 04:53:07 -0700 (PDT)
Received: from [192.168.0.102] ([88.147.50.223])
        by smtp.gmail.com with ESMTPSA id x192sm20297864wmf.48.2019.03.26.04.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 04:53:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH BUGFIX IMPROVEMENT V3 0/9] lock, bfq: fix bugs, reduce
 exec time and boost performance
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20190312085935.11340-1-paolo.valente@linaro.org>
Date:   Tue, 26 Mar 2019 12:53:04 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, broonie@kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        fra.fra.800@gmail.com, alessio.masola@gmail.com,
        holger@applied-asynchrony.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E7E093AD-07CC-4B76-9675-14F0A7C4D8E1@linaro.org>
References: <20190312085935.11340-1-paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 12 mar 2019, alle ore 09:59, Paolo Valente =
<paolo.valente@linaro.org> ha scritto:
>=20
> Hi,
> this is the v3 of the series
> https://lkml.org/lkml/2019/3/10/138
> that fixes some bug affecting performance, reduces execution time a
> little bit, and boosts throughput and responsiveness.
>=20
> The difference w.r.t. v2 are new fixes to the patch "block, bfq: print
> SHARED instead of pid for shared queues in logs", after patient checks
> and suggestions by Holger and Oleksandr.
>=20

Hi Jens,
have you had time to look into this?

Thanks,
Paolo

> Thanks,
> Paolo
>=20
> Francesco Pollicino (2):
>  block, bfq: print SHARED instead of pid for shared queues in logs
>  block, bfq: save & resume weight on a queue merge/split
>=20
> Paolo Valente (7):
>  block, bfq: increase idling for weight-raised queues
>  block, bfq: do not idle for lowest-weight queues
>  block, bfq: tune service injection basing on request service times
>  block, bfq: do not merge queues on flash storage with queueing
>  block, bfq: do not tag totally seeky queues as soft rt
>  block, bfq: always protect newly-created queues from existing active
>    queues
>  doc, block, bfq: add information on bfq execution time
>=20
> Documentation/block/bfq-iosched.txt |  29 +-
> block/bfq-cgroup.c                  |   3 +-
> block/bfq-iosched.c                 | 786 +++++++++++++++++++++++-----
> block/bfq-iosched.h                 |  92 ++--
> block/bfq-wf2q.c                    |   2 +-
> 5 files changed, 729 insertions(+), 183 deletions(-)
>=20
> --
> 2.20.1

