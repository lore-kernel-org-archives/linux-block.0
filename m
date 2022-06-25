Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BFDC43334
	for <linux-block@archiver.kernel.org>; Sat, 25 Jun 2022 00:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiFYA4N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 20:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiFYA4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 20:56:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928D55001A
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 17:56:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y32so7184572lfa.6
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 17:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9mu8UMNAJ24Uwc3zBvZmR8/GGKpqM/MqyFyhOPdnLaE=;
        b=ZRRCvvVzVikiA8t/f99Zo+E+sDTGejA7ynYxR9NWewy3J7dsULeod/U7Fp+07SXy4U
         3nVREaQEvYh3kKGBnPWhEAC4ugmbY0Gs/CZnOhd/eVtG2spJeu4x7kDFM0O3pPIld4iq
         lxbvVd7oB/wWBrrrh9X1wymqtfYg8z03emJbZ0k9GfdMf5bJlmdBNQR8GluPpn54dlSh
         7hepKj2bkWuvrz86NoCCeut7f5EsOMrLNpF8W7D6+47emiPpaCmve5Gs6hTaaI6d2RfZ
         8EXESB1CiC1Ue7MaznQm9Wz9XhLilagMR3qwbd0OhsdnsUT9PM3C1FTjnnOe+CdLRDtu
         eg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9mu8UMNAJ24Uwc3zBvZmR8/GGKpqM/MqyFyhOPdnLaE=;
        b=hpBVNS+N+T7m0tMVHh59CHFWmWe1J84QDuetDgV79wpeVT8/jr/O2dk3Ee/oNegO6/
         WKxU4Y34I8AHJxddqtaR4MC0K5QYE/xsewdpTOS4glVae1YSnf80UY76kvCQkl1whaFF
         YOQfLt8i1z74zdGiKGw+xnqfn1SrkQM1ADlSGXHIxiyFMy3LLZWPDYkhHx/CkWjnLeR5
         +8eu5DtCpqHGywHjeT6byR0F45sfqg6Lc4rEFMfGiDOANBDT1dzjyTs79BewHWPCJMBp
         HkoDuhXWb8f6LWOcN0re8QXfi4BqCl/qJ9NRFAxXY6tZ0cuiXKTU6GfNXVKNIQarusKK
         QqVQ==
X-Gm-Message-State: AJIora/9BOIOySLALyusAGJAp32P5G/wPj9/cmKhXPt0nb0uCc0yFQ0l
        k1XPtxgylSGiCOtlZiutp0kY3pjZMF2ffxgu9rM=
X-Google-Smtp-Source: AGRyM1uONEeI0x27khSEQYOSqP4JYMetn5qh6YQq725XOBIbUCVmYi9RTvjh83cStzMtDbD5mxpCLOYGYEbF0GE7eUM=
X-Received: by 2002:a05:6512:110f:b0:47f:985c:e010 with SMTP id
 l15-20020a056512110f00b0047f985ce010mr1070557lfg.390.1656118569754; Fri, 24
 Jun 2022 17:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220623180528.3595304-1-bvanassche@acm.org> <20220623180528.3595304-47-bvanassche@acm.org>
 <CAKFNMonCrSpx0RMdPfMXfAvfe3ZQeVae=QYbgi1iO3pTRUnD-w@mail.gmail.com> <d6ce8f96-18af-e5b2-6ce4-3ef24b084a81@acm.org>
In-Reply-To: <d6ce8f96-18af-e5b2-6ce4-3ef24b084a81@acm.org>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 25 Jun 2022 09:55:52 +0900
Message-ID: <CAKFNMonqq5j9285gKmhkyT-HrCG7WOqQSN2uw4WShNgT2Xmfrg@mail.gmail.com>
Subject: Re: [PATCH 46/51] fs/nilfs: Use the enum req_op and blk_opf_t types
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On Sat, Jun 25, 2022 at 9:02 AM Bart Van Assche wrote:
>
> On 6/23/22 20:43, Ryusuke Konishi wrote:
> > On Fri, Jun 24, 2022 at 3:06 AM Bart Van Assche wrote:
> >>
> >> Improve static type checking by using the enum req_op type for variables
> >> that represent a request operation and the new blk_opf_t type for
> >> variables that represent request flags.
> >>
> >> Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >> ---
> >>   fs/nilfs2/btnode.c            | 4 ++--
> >>   fs/nilfs2/btnode.h            | 5 +++--
> >>   fs/nilfs2/mdt.c               | 3 ++-
> >>   include/trace/events/nilfs2.h | 4 ++--
> >>   4 files changed, 9 insertions(+), 7 deletions(-)
> >
> > Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> >
> > I've checked this patch, picking up some of the block layer patches needed
> > to understand this conversion from the list of linux-block.
>
> Hi Ryusuke,
>
> Thank you for the quick review.
>
> Does "picking up" perhaps mean that you plan to send a subset of this
> patch series to Linus yourself? I prefer that the entire patch series is
> sent to Linus by a single kernel maintainer.

Sorry for the misleading wording.
That just means that I tracked and confirmed the related block layer patches
in the series to properly review this patch.  I recognize that the entire patch
series should be sent through the same maintainer.

Regards,
Ryusuke Konishi
