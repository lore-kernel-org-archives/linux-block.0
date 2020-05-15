Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F22C433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 14:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E50CF207BB
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 14:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="c91SCmGt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgEOOm1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 May 2020 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgEOOm0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 May 2020 10:42:26 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A00C05BD09
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 07:42:24 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so3836647wra.7
        for <linux-block@vger.kernel.org>; Fri, 15 May 2020 07:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Scx8qbRNnSb6mhI2P/ywwy75Y7A4v6dRsK17pDDWhOg=;
        b=c91SCmGttOG3ObCpMk42ahE22FR47xfbS2luOS+DOg6a1Gmtzr4duy+mzrY+NEZgai
         S2GMvKDoH6nB+kBJa01W4vv/D59CT3K6h/RRdOICXorE10wKM25OU0dx+5IT0cd/8DLp
         NN0TPvzOgVPYYk5qZKgDoH3cd5fZy2CS4YJE16qa/VDT+TVIdhcWp6+M+S16GWaKDdFC
         ROcxFsT85sTMA7Nfl727feLMmNXuxMwXhS0jvqKkkn6cGPoXEQAwWA8d67oDeqc69/Cd
         +O1FoGUXWBZXHz2V4Rm7ir+yoxHA8RgNa36j6GkpNmvDbGWjgSqBHAVVVj+xZPN8P9rs
         91pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Scx8qbRNnSb6mhI2P/ywwy75Y7A4v6dRsK17pDDWhOg=;
        b=RqUDbET5YaI8Y0laqQKaPv+wo2ZNMlMszHgapOFaZ3zXFWLJ7eyC8386/Ebho5q2GK
         pm/FX1iQ5WwAJempY+sBxiWDvkgpeXg1WFwP6vOGoqgfpBV/YVQfuMJ05uE8HxoEqnGf
         DM9QBifA8ji5uvouN9UJxN0rIUv/ygo/tuTuGqLQampMieSv/MHlM3aL5zYpaUVa5yRp
         B1zEzvgY+jay5hLWohzYckSXkgB7Ze7BeGwxLESIS0mWJpUAYNsNSchR8Su6Hs+QRqIE
         MOdq+oBmTmQxhO6Viw458l0OhC5SH+kzJ+1Iqbx23BKBRtmFn3amwdBYpVQawTmH74SV
         PNBw==
X-Gm-Message-State: AOAM533DWiWmub9o4NlsU32Uti8/ZqDCZHoNlSCAy0nfQmiLDC1ztC3S
        lR5atGUlavUCXcvuzm2Yo8oBP50n8XYxlFWU1bBS
X-Google-Smtp-Source: ABdhPJyFvELd1j1z/UlmNGQZ8MKsuShu3Y1xEovb1pKCMtDZkj9bGkjryDuZB8CyYEIFl2HAOWoB3iqe5XzkSIR44rQ=
X-Received: by 2002:adf:9010:: with SMTP id h16mr2806662wrh.412.1589553743506;
 Fri, 15 May 2020 07:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200511135131.27580-1-danil.kipnis@cloud.ionos.com>
 <CAHg0HuyYO913MmHt7qi12T6mVXo9nabUs6GJyqRAGfWAdfPjCQ@mail.gmail.com> <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
In-Reply-To: <e04fc798-ee25-53a5-fae0-5985306b55fd@kernel.dk>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Fri, 15 May 2020 16:42:12 +0200
Message-ID: <CAHg0Hux7J3yieOiOxkqPOKNxj07T_hU-x2UF5Dt+uy9Kku4WsA@mail.gmail.com>
Subject: Re: [PATCH v15 00/25] RTRS (former IBTRS) RDMA Transport Library and
 RNBD (former IBNBD) RDMA Network Block Device
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 15, 2020 at 3:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/20 4:29 AM, Danil Kipnis wrote:
> > Hi Jens,
> >
> > we've fixed the kbuild cross-compile problem identified for our
> > patches for 5.7-rc4. The block part has been reviewed by Bart van
> > Assche (thanks a lot Bart), we also replaced idr by xarray there as
> > Jason suggested. You planned to queue us
> > for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
> > you please give Jason an OK to take this through the rdma tree, see
> > https://www.spinics.net/lists/linux-rdma/msg91400.html?
>
> My main worry isn't the current state of it, it's more how it's going
> to be handled going forward. If you're definitely going to maintain
> the upstream code in a suitable fashion, and not maintain an on-the-side
> version that you push to clients, then I'm fine with it going upstream
> and you can add my acked-by to the block part of the series.
>
> But maintaining the upstream version as the canonical version is key
> here.
Thanks a lot for your reply. We only do maintain the upstream code: we
have an extra compatibility layer which allows us to compile this code
for older kernels still in use in our production and we plan
to continue to do so in the future.
The only real difference of this code to the one running in our production
right now is the name of the driver: it is still "ibnbd" instead of current rnbd
but we will switch to it for the new kernels and also for the older kernels as
soon as our internal provisioning and monitoring infrastructure is prepared.

@Jason Should I resent you the patchset with Acked-By Jens added?


On Fri, May 15, 2020 at 3:53 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 5/15/20 4:29 AM, Danil Kipnis wrote:
> > Hi Jens,
> >
> > we've fixed the kbuild cross-compile problem identified for our
> > patches for 5.7-rc4. The block part has been reviewed by Bart van
> > Assche (thanks a lot Bart), we also replaced idr by xarray there as
> > Jason suggested. You planned to queue us
> > for 5.7: https://www.spinics.net/lists/linux-rdma/msg88472.html. Could
> > you please give Jason an OK to take this through the rdma tree, see
> > https://www.spinics.net/lists/linux-rdma/msg91400.html?
>
> My main worry isn't the current state of it, it's more how it's going
> to be handled going forward. If you're definitely going to maintain
> the upstream code in a suitable fashion, and not maintain an on-the-side
> version that you push to clients, then I'm fine with it going upstream
> and you can add my acked-by to the block part of the series.
>
> But maintaining the upstream version as the canonical version is key
> here.
>
> --
> Jens Axboe
>
