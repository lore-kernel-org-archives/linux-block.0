Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3642C433DB
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 14:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6DF23383
	for <linux-block@archiver.kernel.org>; Wed, 20 Jan 2021 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhATOOi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Jan 2021 09:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732626AbhATMxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Jan 2021 07:53:37 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BCC06179F
        for <linux-block@vger.kernel.org>; Wed, 20 Jan 2021 04:52:25 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so31036029ejc.1
        for <linux-block@vger.kernel.org>; Wed, 20 Jan 2021 04:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Br6UVy1fKZWQK9T/1MzkZkQs0zVn+GaHRpNTTy2H0w=;
        b=H6H+fu1CGqkj8wmSjfWKLRC7BiUGeypprNzWTcxgUWM4iIMfi4c8Q5P6MBPQ2Mu/f8
         54PKBL5Fxk15XMkHTxg2SVO+KbPcbltgwUMkqUmm7pCYjR+VeSf6rA4X63JRhbjbsctR
         fLmPLn9589W4HPoJHrxRTnz7y4TldZUe8ANYnFhQSnW7jB1pRawzZVBr8yPsOpl5SI5Z
         vinGaC1arl1+CwEH8pohPmaiRm8OH7OY7uEtH9zXSEeDFkNeGc5PbLlETu6eZ/WftLQo
         IRLL7Z89fnig+MO75HQ5czBSWbCY2YPAyTf2siAh36BYiDVPqcrCDh2Rrng9hZIT+wj1
         p7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Br6UVy1fKZWQK9T/1MzkZkQs0zVn+GaHRpNTTy2H0w=;
        b=kxHUUfQ5EiG0AetYefx3DYTd5kzUoO8cYqEGoEOLCu8ZuJGVVvugMsz78PsTXF6Zbl
         6t/rEFcObqfxZwvDynZ76fXXYSkRoZNKjy71RBYGuKthRL6OTPLR5xRlxGMBuRdem8Pz
         IcnaEdXjkCWk4WyKao0rchluOP4wx5HOz5L0Tf7oaancaKsrBV1TQBMxMLsGd2zsaXM5
         lk4I2xebLYW3FyipDA9g/OUJRTMkzq//1Lre6CMpbbGEYVZJumb0TrwCiLjOiYhsUrKh
         tADtiJyIbhAbxo9fvBsRVBHepTyiwG8rh2mRp4krDOCZtUvZiJqUjLf95XyXkom+mwQ+
         H1/g==
X-Gm-Message-State: AOAM530IjQpXvH+2hztYENq08g26HrwYhl+4QT0GXkP9jSOdkxR6cWu2
        5vuglB9WCetb2oewF+igfNfSQ50pgh4veTJvlQEhqQ==
X-Google-Smtp-Source: ABdhPJxbwaiXd9u8RPNyuuEyy8rlQ3s19h6lQgI7PtIbpz4NYtSFCpXJkQOWaRs4sUzKSIbyT7+M448CKqQcwJwCqcU=
X-Received: by 2002:a17:906:a669:: with SMTP id en9mr6270740ejb.353.1611147144655;
 Wed, 20 Jan 2021 04:52:24 -0800 (PST)
MIME-Version: 1.0
References: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
In-Reply-To: <20210110094457.6624-1-guoqing.jiang@cloud.ionos.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Wed, 20 Jan 2021 13:52:13 +0100
Message-ID: <CAMGffE=K7Q_Rho0WPfDo_HCLM=mLf6OTx1CYknBXEm0sT9-LCg@mail.gmail.com>
Subject: Re: [PATCH RFC V4 0/4] block: add two statistic tables
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jan 10, 2021 at 10:45 AM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi,
>
> No more comments since the last version, so this version is just rebase
> with latest tree.
>
> To make the tables work, it is necessary to enable BLK_ADDITIONAL_DISKSTAT
> option, and also enable the sysfs node.
> # echo 1 > /sys/block/md0/queue/io_extra_stats
>
> After that, the size and latency of io are recorded in each table.
>
> Thanks,
> Guoqing
>
> RFC V3: https://marc.info/?l=linux-block&m=159730633416534&w=2
> * Move the #ifdef CONFIG_BLK_ADDITIONAL_DISKSTAT into the function body
>   per Johannes's comment.
> * Tweak the output of two tables to make they are more intuitive
>
> RFC V2: https://marc.info/?l=linux-block&m=159467483514062&w=2
> * don't call ktime_get_ns and drop unnecessary patches.
> * add io_extra_stats to avoid potential overhead.
>
> RFC V1: https://marc.info/?l=linux-block&m=159419516730386&w=2
>
> Guoqing Jiang (4):
>   block: add a statistic table for io latency
>   block: add a statistic table for io sector
>   block: add io_extra_stats node
>   block: call blk_additional_{latency,sector} only when io_extra_stats
>     is true
>
>  Documentation/ABI/testing/sysfs-block | 26 +++++++++
>  Documentation/block/queue-sysfs.rst   |  6 +++
>  block/Kconfig                         |  9 ++++
>  block/blk-core.c                      | 51 ++++++++++++++++++
>  block/blk-sysfs.c                     | 10 ++++
>  block/genhd.c                         | 78 +++++++++++++++++++++++++++
>  include/linux/blkdev.h                |  6 +++
>  include/linux/part_stat.h             |  8 +++
>  8 files changed, 194 insertions(+)
>
> --
> 2.17.1
>
For the whole series,  look good to me, thx.
Reviewed-by: Jack Wang <jinpu.wang@cloud.ionos.com>
