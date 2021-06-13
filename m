Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41621C48BDF
	for <linux-block@archiver.kernel.org>; Sun, 13 Jun 2021 17:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E121F6128B
	for <linux-block@archiver.kernel.org>; Sun, 13 Jun 2021 17:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhFMRGv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 13 Jun 2021 13:06:51 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35414 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhFMRGv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 13 Jun 2021 13:06:51 -0400
Received: by mail-oi1-f170.google.com with SMTP id l12so4172839oig.2
        for <linux-block@vger.kernel.org>; Sun, 13 Jun 2021 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mbsW3tqwlgDfYgVGWT0IOLXl2n0jsZP2I3ShQKe2U50=;
        b=Xvk9ZtTuR1jditfRRd4OHlcsvQcbyX2MDi67lyFavOnWVWtFVSqDnetF3VM8FCikVI
         m9a8iwfqw+7QsOlnivjmlxMLD00oDhiAd2SvKUg2acGwgexyT6/gzAwv5wJ2ZzG5ZbzO
         0aInmgGUeFznG+M2cWe4BASmdjFyy9k9JQW/3T88W1CJDMm9SiTHD6Ne5zMQwRPHmyIM
         +7+d3fkBogIqpwN0uUWekoj7jPaU8D54QRUPa4hmjxB+bZM2l6UDqwTtEenbQWK0HZhM
         XTF9cYmECiK0ULWZC2C2gCw2P2z0chz7vtZv+vLGLRKOKwLhuHLV61UnG2cO4x2fLhiO
         C7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mbsW3tqwlgDfYgVGWT0IOLXl2n0jsZP2I3ShQKe2U50=;
        b=DxGBtfBNNMTN9hQ/ErQVa4X1Cv0LmjSK4F8FaGQ99xrWcI1XkzH/mYl3x0tS+R+a1/
         KyF8golgO4ZA2XrZPkT7pZOrRwuYPV/r5tRrfsgtjzeIPb+jf+wVwQG2kIzdLtO0vVw1
         9DZUnj0Mrxb5Zbdmmf6gjOEB83Ojr59Ko41mndISRuNwsjaQTN+9AjfxASd2rHBq2Qfa
         swfhPB8znqBk2rEE8GwaFWBxXXF2NGn6tN2p0FK2Ry7LbbpjbiCLFsdNKl4ThAvfvpGR
         DuhTqPoAoSZJrXFIL0zIZqlOqe7MX7Si9xHMAtu1Vxwyxk33lpD0gNP7CdrU6q1QOXMr
         cjIw==
X-Gm-Message-State: AOAM531oJI2EAVlsFO6yp79+YRL2wtaMIZ4a3M1s8p2K+eoeDEgVdBTg
        VeJjZUSiNAFxJ/ka+VNJxjHGfamZzqFtM+wgrUXXtvAlR08=
X-Google-Smtp-Source: ABdhPJw68MFSa/ggwnqD0RY/BgCKCVuU2HwilJS5UIpIxCR0LzSt4TPLedDH7QnB+XwwX6+OvV08aLLWiJzaFXNUwK8=
X-Received: by 2002:a05:6808:11a:: with SMTP id b26mr8404149oie.77.1623603829475;
 Sun, 13 Jun 2021 10:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
In-Reply-To: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
From:   Omar Kilani <omar.kilani@gmail.com>
Date:   Sun, 13 Jun 2021 10:03:38 -0700
Message-ID: <CA+8F9hjJF8e4U7W9tUgGu7dUR_hz-y_EDuq-McHS-GBiZm0-rQ@mail.gmail.com>
Subject: Re: Deadlock in wbt / rq-qos
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just looking at blk-wbt.c...

Should...

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/block/blk-wbt.c?h=v5.13-rc5&id=482e302a61f1fc62b0e13be20bc7a11a91b5832d#n164

if (!inflight || diff >= rwb->wb_background / 2)

Be:

if (!inflight || diff >= limit / 2)

?

On Sun, Jun 13, 2021 at 8:49 AM Omar Kilani <omar.kilani@gmail.com> wrote:
>
> Hi there,
>
> I appear to have stumbled upon a deadlock in wbt or rq-qos.
>
> My journal of a lot of data points is over here:
>
> https://github.com/openzfs/zfs/issues/12204
>
> I initially deadlocked on RHEL 8.4's 4.18.0-305.3.1.el8_4.x86_64
> kernel, but the code in blk-wbt.c / blk-rq-qos.c is functionally
> identical to 5.13.0-rc5, so I tried that and I'm able to deadlock that
> as well. I believe the same code exists all the way back to 5.0.1.
>
> The Something Weird (tm) about this is that it possibly only happens
> on AMD EPYC CPUs. I just don't have the necessary setup to confirm
> that either way, but it's a hunch because I can't reproduce it on an
> Ice Lake VM (but the Ice Lake VM also has more storage bandwidth so
> that could be the thing, and I can't decrease that storage bandwidth,
> so I can't do a like-for-like test.)
>
> I "instrumented" wbt / rq-qos with a bunch of printk's which you can
> see with this patch:
>
> https://gist.github.com/omarkilani/2ad526c3546b40537b546450c8f685dc
>
> I then ran my repro workload to cause the deadlock, here's the dmesg
> output just before the deadlock and then the backtraces with my printk
> patch applied:
>
> https://gist.githubusercontent.com/omarkilani/ff0a96d872e09b4fb648272d104e0053/raw/d3da3974162f8aa87b7309317af80929fadf250f/dmesg.wbt.deadlock.log
>
> Happy to apply whatever / run whatever to get more data.
>
> Thanks!
>
> Regards,
> Omar
