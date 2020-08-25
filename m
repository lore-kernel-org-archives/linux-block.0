Return-Path: <SRS0=AIgI=CD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58603C433DF
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 07:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A0C20578
	for <linux-block@archiver.kernel.org>; Tue, 25 Aug 2020 07:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="MInaNUgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgHYHUl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729209AbgHYHUl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Aug 2020 03:20:41 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF93DC061755
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 00:20:40 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c15so5855395lfi.3
        for <linux-block@vger.kernel.org>; Tue, 25 Aug 2020 00:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LWvQJmkrnmEIXZZ3m3NQCmqtplrJpyZpyg/o+bfnJmk=;
        b=MInaNUgnNlhGKEt7t59LrOLAkQfHi07yS38zUrGAb31g5p/yELmauj4uOqNWLb6upQ
         b2qdgKwN4nz31yW2hNDWVD1nIFK/ItIaHEkA2+9oScyT27YwivO+8RjC4nNikXGov4dp
         l/lB0aXorQ2lMUV6N2UzILuL1d9x1N0itJEIs0qZQzxL/aUF2jpKrgbHKFfSIJQ+jHd0
         BCLNefg3RRim+GdWCfwaT1rSo/QqHWs1QIBGRKuCWJZyR51YCsINfRpk8+msMXT5iOiA
         W7hUUwqghSUGOzWTJCgkKdwTx1rRh2A61TARMB5FTdSH0q+wE6BN+tudmqNy4b1FpFqM
         Oxww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LWvQJmkrnmEIXZZ3m3NQCmqtplrJpyZpyg/o+bfnJmk=;
        b=t/vTWR+gyX1Oh4Tpdkr4Or5JW7HUMHEnP8K3zqU9S/TBASsXmaAZ8U5erMjafHKMfJ
         y2LnmX8uuGkNG1QzY85SDYH4iAFT2iOeqcyEiyaF/qiKVxkCgHR3xsXnNuoMFyzyksCh
         1SzKtH2JMYDBjGpn2Vh0hazVDEIyOVTTAc6pU+gpJOZ8DSeXVL3CANuezbzxA1gn3G0b
         C4OP/lbA/dkPN4fG1DosVmczbFQKyEBQZbSjGN1bmq4h55QzKO+NdM/ard+XDXtJaEwj
         oqqyPaUucgE8HBx79VoYo0X7xlomdFxd1Thm2vz5SZ6heCRpl5VRDYR6rkaJwKWDD/ag
         AexA==
X-Gm-Message-State: AOAM530nRrW9yZBH3LbqkqYBlIYeqlxWNgIlxdfEiw9K3yylS1a+DayW
        1hOlTt7KpEdZDjOzXm5HxU8O6xf88ph9lVwo4EWsNA==
X-Google-Smtp-Source: ABdhPJwGMgG3bBokdb1Jbbca+NQTnmhr+DGZ3ftW+U8vN9vKTcQrR0ZB3M+G2qinwc3/MO2G36kF04shxwMgI0lZ9ao=
X-Received: by 2002:a19:cb45:: with SMTP id b66mr4279527lfg.179.1598340039088;
 Tue, 25 Aug 2020 00:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200824154436.GA255257@gardel-login> <CAB0TPYEPWALD1iOP_5Rq0NKusJEvc_eOVVkoXRxjPtPTZU2GgA@mail.gmail.com>
In-Reply-To: <CAB0TPYEPWALD1iOP_5Rq0NKusJEvc_eOVVkoXRxjPtPTZU2GgA@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 25 Aug 2020 09:20:28 +0200
Message-ID: <CAB0TPYHncOkecsmyypr2LACnbupfML7jn1kEdfR78rbA_w0EfQ@mail.gmail.com>
Subject: Re: LOOP_CONFIGURE ioctl doesn't work if lo_offset/lo_sizelimit are set
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I just sent a patch to fix the issue. The loop device would have
respected the configuration, but indeed the size of the underlying
block device was not set correctly, so reading back the size would
give the wrong result.

Thanks,
Martijn

On Mon, Aug 24, 2020 at 8:24 PM Martijn Coenen <maco@android.com> wrote:
>
> Hi Lennart,
>
> Thanks for the report, I'll look into it. FWIW, we've been using
> LOOP_CONFIGURE on Android with lo_offset/lo_sizelimit without issues,
> but it may be a particular configuration that's causing issues.
>
> Thanks,
> Martijn
>
> On Mon, Aug 24, 2020 at 5:44 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > Hi!
> >
> > Even with fe6a8fc5ed2f0081f17375ae2005718522c392c6 the LOOP_CONFIGURE
> > ioctl doesn't work correctly. It gets confused if the
> > lo_offset/lo_sizelimit fields are set to non-zero.
> >
> > In a quick test I ran (on Linux 5.8.3) I call LOOP_CONFIGURE with
> > .lo_offset=3221204992 and .lo_sizelimit=50331648 and immediately
> > verify the size of the block device with BLKGETSIZE64. It should of
> > course return 50331648, but actually returns 3271557120. (the precise
> > values have no particular relevance, it's just what I happened to use
> > in my test.) If I instead use LOOP_SET_STATUS64 with the exact same
> > parameters, everything works correctly. In either case, if I use
> > LOOP_GET_STATUS64 insted of BLKGETSIZE64 to verify things, everything
> > looks great.
> >
> > My guess is that the new ioctl simply doesn't properly propagate the
> > size limit into the underlying block device like it should. I didn't
> > have the time to investigate further though.
> >
> > Lennart
