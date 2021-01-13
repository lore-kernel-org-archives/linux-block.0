Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF669C433E6
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC22233A2
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 09:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbhAMJUI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbhAMJUI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 04:20:08 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09B9C061575;
        Wed, 13 Jan 2021 01:19:27 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y4so1533863ybn.3;
        Wed, 13 Jan 2021 01:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xHV72iPm1ITS/y3yBUV429ONkrf7HXSCrv4hwpk0AA=;
        b=b9d4g4uoJ8wpveFIO1Ih3SbWNvmJGA9TTTyEAP3a+wAChA1XkfiKg0+Kxgcuc8os58
         tMYiCXn3ZJ5ru8gDwzxMW3aNWzP94SWlchJ0uVGsXWPMfc+Yqk0V55Hln9jcqbVod1ek
         A7baTm1Ni+RaYL7etar8ReSLoHwHjswsZgd6KAhe1eT+mmLm+PVD4g40oPJe7t7CCLVt
         44M2xhbFcVSHGYYzVULH/yNtxZCqikDrz5U1zkh2hH6JIKXntkIxYazA9FR41eNzuIlf
         v/ZeLv2MIGk5KTtpIZ8VBqXYwSjRz4/WhF/e2kIfZY/KlhgawkYyL5l9YNixLduDkxQP
         Gvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xHV72iPm1ITS/y3yBUV429ONkrf7HXSCrv4hwpk0AA=;
        b=phmLGOlubQHQwDVCLFkuXcgrMIyW3Ft9Z2rnTIew20f22SY3HEdCheKKgcMpDFBvkw
         pW4R8M8INfoanQ4M6Fx7lHBiC9i/Ktt4ZJhH3Nneu49nUHa80oRQBGuJoiwWUpS/l8Zx
         I2MPoHWPnOdoiTVA4MLX1SON0QGhC+t29v6GsLGFhTmzhtyK3DgUxfDLFGDh/1b4RWx9
         i+kbe5e6T9c2+kSPcC1cePWUYezUGP6lrr1Xi3JAQ7wof56ChbI+c/1DnA6oBitV5G9u
         kbHxh2kNj7oDPf0eaCsOztj5bWOICuLBRVGQ1s61VWfUm4TCQ3pbF7v+8B7tBX7eGUPb
         wKxA==
X-Gm-Message-State: AOAM5314f2FitZHs8Hf26DXxgdMR/SoddH5jTD0eSwI7x0f3CUwTYM5k
        3kdtK2C8qkxZoatBSdVRbBFqLFR/ZGipAW3JmQk=
X-Google-Smtp-Source: ABdhPJz6P0/yVNcimAVgk8zvEu7lAVc7RhHvApUF4bzr0QG4rKm7eEVCeNQa/mBOHjGBydpO49xzf1+aHtVN4v9JRLA=
X-Received: by 2002:a25:9885:: with SMTP id l5mr1877548ybo.501.1610529567021;
 Wed, 13 Jan 2021 01:19:27 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210113040146epcas1p230596c7c3760471dca442d1f7ce4dc55@epcas1p2.samsung.com>
 <CH2PR04MB65225EDDA7069CCD47A459A5E7A90@CH2PR04MB6522.namprd04.prod.outlook.com>
 <20210113034637.1382-1-nanich.lee@samsung.com>
In-Reply-To: <20210113034637.1382-1-nanich.lee@samsung.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 13 Jan 2021 17:19:15 +0800
Message-ID: <CACVXFVMb0eE5-yo2k3KvnJjKN+aDLzOuT9rKQ7LY5-4WTgM3jw@mail.gmail.com>
Subject: Re: Re: [PATCH] bio: limit bio max size.
To:     Changheun Lee <nanich.lee@samsung.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, jisoo2146.oh@samsung.com,
        junho89.kim@samsung.com, linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mj0123.lee@samsung.com, seunghwan.hyun@samsung.com,
        sookwan7.kim@samsung.com, Tejun Heo <tj@kernel.org>,
        yt0928.kim@samsung.com, woosung2.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 13, 2021 at 12:09 PM Changheun Lee <nanich.lee@samsung.com> wrote:
>
> >On 2021/01/12 21:14, Changheun Lee wrote:
> >>> On 2021/01/12 17:52, Changheun Lee wrote:
> >>>> From: "Changheun Lee" <nanich.lee@samsung.com>
> >>>>
> >>>> bio size can grow up to 4GB when muli-page bvec is enabled.
> >>>> but sometimes it would lead to inefficient behaviors.
> >>>> in case of large chunk direct I/O, - 64MB chunk read in user space -
> >>>> all pages for 64MB would be merged to a bio structure if memory address is
> >>>> continued phsycally. it makes some delay to submit until merge complete.
> >>>> bio max size should be limited as a proper size.
> >>>
> >>> But merging physically contiguous pages into the same bvec + later automatic bio
> >>> split on submit should give you better throughput for large IOs compared to
> >>> having to issue a bio chain of smaller BIOs that are arbitrarily sized and will
> >>> likely need splitting anyway (because of DMA boundaries etc).
> >>>
> >>> Do you have a specific case where you see higher performance with this patch
> >>> applied ? On Intel, BIO_MAX_SIZE would be 1MB... That is arbitrary and too small
> >>> considering that many hardware can execute larger IOs than that.
> >>>
> >>
> >> When I tested 32MB chunk read with O_DIRECT in android, all pages of 32MB
> >> is merged into a bio structure.
> >> And elapsed time to merge complete was about 2ms.
> >> It means first bio-submit is after 2ms.
> >> If bio size is limited with 1MB with this patch, first bio-submit is about
> >> 100us by bio_full operation.
> >
> >bio_submit() will split the large BIO case into multiple requests while the
> >small BIO case will likely result one or two requests only. That likely explain
> >the time difference here. However, for the large case, the 2ms will issue ALL
> >requests needed for processing the entire 32MB user IO while the 1MB bio case
> >will need 32 different bio_submit() calls. So what is the actual total latency
> >difference for the entire 32MB user IO ? That is I think what needs to be
> >compared here.
> >
> >Also, what is your device max_sectors_kb and max queue depth ?
> >
>
> 32MB total latency is about 19ms including merge time without this patch.
> But with this patch, total latency is about 17ms including merge time too.

19ms looks too big just for preparing one 32MB sized bio, which isn't
supposed to
take so long.  Can you investigate where the 19ms is taken just for
preparing one
32MB sized bio?

It might be iov_iter_get_pages() for handling page fault. If yes, one suggestion
is to enable THP(Transparent HugePage Support) in your application.


-- 
Ming Lei
