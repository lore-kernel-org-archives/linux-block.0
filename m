Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCA0C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 22:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D9664E5C
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 22:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhBWWut (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 17:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhBWWrG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 17:47:06 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CAEC06178A
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 14:46:26 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id g1so78783ljj.13
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 14:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w1loR0i9/IQnXQEFVUinQYQPT/pSvPKt4JZ95zXT3ww=;
        b=CoZ6zpVIQgeA5xgTs9DBjAfLnLxDYBcaUA5qu+4wMpweFUkZtrZDFvPY1bOdP8KCat
         Yw7SgjVJ0OIpTtJJGFpgBNLpBQjHp9hEuC4i0E6PrW6dnUMnQ7GTljuVzf2G1kZ/QGlw
         w+i5woCmmlqfEj4+T5/xQE5lpowxUC1v87bPOWGLmks/0LZS2hNYkBwwlC9AD25R2gQh
         OPtRwg5hYO7lCXcp93rlZmUTkex7vplr3TGgcQy9No/vEuOjLoF7U+KO7a59pZ6v2jTl
         wye7s5Ql15cO21DouXl7VLwy94XW1tBqcC+tHAlVxNIitn/CYM5ktP+Vz+j32MGMUwy4
         7P9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w1loR0i9/IQnXQEFVUinQYQPT/pSvPKt4JZ95zXT3ww=;
        b=OjpPry4WuAi855QokC1cMEUYmpp08p/1Z6pQQnp420An+ii227mStlDxkpIHK8eVyE
         0xeSoAFaplcoBQGtoKkUD/lFpa3CS8KISparcd0JPe85JqpcjOJ5uTPhh7uTNgtlB1z/
         eTZRQEF1Z8FR3Yq+2yOGFiZP+YDrlrNiue8hWH0KN2Reqtc7iUks5sk4+yWqGhBPAwiL
         1RBK47544bXOxGcETtZxr+8i7u3ClLihS0lAXng7VcUdckWQasHggJC4BJ5CRsXIavZq
         4hXwTiifJCryGFBxBS2sb3vuohNgzv7zr5B0ob2njAHLN3+HQPi2jJQF6ouJTwI+nHF2
         MVhw==
X-Gm-Message-State: AOAM531MVqFjG6RwpyhnSSb1neQAS0MxMjmLTm/yXudmnEcJBtW6ph+P
        WbNPZTeKT2GBbBL2fiRce6s8ScnNFFpMIOKLK7dBsg==
X-Google-Smtp-Source: ABdhPJxC9X92LlE0XE2ScJexcBEWrv3BiYeM/XqD2xAowgGVZYe5Lf/97bsSvv+mXzoDhIfbxn2RTRtVPemOMWSlxFg=
X-Received: by 2002:a2e:b0f9:: with SMTP id h25mr2979634ljl.232.1614120384650;
 Tue, 23 Feb 2021 14:46:24 -0800 (PST)
MIME-Version: 1.0
References: <CALAqxLUWjr2oR=5XxyGQ2HcC-TLARvboHRHHaAOUFq6_TsKXyw@mail.gmail.com>
 <20210223070408.GA16980@lst.de> <20210223072252.GA18035@lst.de>
In-Reply-To: <20210223072252.GA18035@lst.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 23 Feb 2021 14:46:13 -0800
Message-ID: <CALAqxLU5AU2jhEe=pa0=ye=8uYQeAw-4T86c36qCTipe9JE3OA@mail.gmail.com>
Subject: Re: [REGRESSION] "split bio_kmalloc from bio_alloc_bioset" causing
 crash shortly after bootup
To:     Christoph Hellwig <hch@lst.de>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        David Anderson <dvander@google.com>,
        Alistair Delva <adelva@google.com>,
        Todd Kjos <tkjos@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        YongQin Liu <yongqin.liu@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 22, 2021 at 11:22 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Feb 23, 2021 at 08:04:08AM +0100, Christoph Hellwig wrote:
> > The problem is that the blk-crypto fallback code calls bio_split
> > with a NULL bioset.  That was aready broken before, as the mempool
> > needed to guarantee forward progress was missing, but is not fatal.
> >
> > Satya, can you look into adding a mempool that can guarantees forward
> > progress here?
>
> Something like this would be the minimum viable fix:

This seems to work for me!

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
