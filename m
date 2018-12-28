Return-Path: <SRS0=yOtT=PF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C24C43387
	for <linux-block@archiver.kernel.org>; Fri, 28 Dec 2018 21:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B042186A
	for <linux-block@archiver.kernel.org>; Fri, 28 Dec 2018 21:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mr8LyNPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeL1V52 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 16:57:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43692 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeL1V52 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 16:57:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so19664837lji.10
        for <linux-block@vger.kernel.org>; Fri, 28 Dec 2018 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhKG5qssgRK1tdD/50G05rLcT6rEhcHJ9y6PNlWL0n8=;
        b=Mr8LyNPWGudAZLRPgffAdJ8vsw4hunhgs0UsB0OBsHltzbqB2mDDqMk2rJakw6ySMt
         rJJdDOUMsbEwiXbnhOCbgkPkDg3qbS8b1vZkzf6RXP4yOeRCSM7vRKQrSI1XSV4xNsFd
         V9xzL/UCn+6FaoeJJAGhp3JdVYC0jc4su1vHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhKG5qssgRK1tdD/50G05rLcT6rEhcHJ9y6PNlWL0n8=;
        b=pM1HoLAqurRWkJ2xgNhYenNAKoqSShLBIkOJnBBRl55G/BBqIZkoHC99FTCKF69gI7
         Mjfgx//vuIOgMUHhqP0L2Xd6lCkP0p/rc/flpUX8vneh/bZ6luTPj7DGAn/WqetAeTo3
         +2iHv5rlmltL+KKZ2M4YiLq4sz5spbubiT2y3solBL3oHa8zv97gnvFDmQcgYjcllhAL
         qCCimlSPjLOJ17LBmvcrZFqctjMvuMKgqOBWwfq29CyL0CBFBf5HhhoJNkyokateMESi
         aCPovebXEfrwTxc2fazZ/0HGi+gUE2aOW4yuWR4Hgs8Kfck2VLjuZCp4wpvNJn3j/1VI
         iMVA==
X-Gm-Message-State: AJcUukdVlE2WRhd/f9FECA82fSjNa4g8EUM0Ptl8LiLrsuIzSQgsFcc6
        4FTeZr5fZucctNRNkQMWVnBfogLwLgU=
X-Google-Smtp-Source: ALg8bN4qZHAn64gxb9JbhnJ2gmyFyZjjjsSXKIQ5Qyjrr3tqh6Y5nwU31kFPNP24KJNqqRAx3Qx+lA==
X-Received: by 2002:a2e:9603:: with SMTP id v3-v6mr2374393ljh.15.1546034245798;
        Fri, 28 Dec 2018 13:57:25 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 15-v6sm9703905lje.18.2018.12.28.13.57.24
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 13:57:25 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id n18so15309002lfh.6
        for <linux-block@vger.kernel.org>; Fri, 28 Dec 2018 13:57:24 -0800 (PST)
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr15493919lfg.117.1546034244471;
 Fri, 28 Dec 2018 13:57:24 -0800 (PST)
MIME-Version: 1.0
References: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk> <CAHk-=wjKZ-AmcVQEUFLuS1uSjyHLo2Z1tYq8asOCTziF8MbAuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjKZ-AmcVQEUFLuS1uSjyHLo2Z1tYq8asOCTziF8MbAuQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 13:57:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg4QEioEY=ps0ntD-CU_pDD4R3nkg-Z-sT_W=XWJ7-faQ@mail.gmail.com>
Message-ID: <CAHk-=wg4QEioEY=ps0ntD-CU_pDD4R3nkg-Z-sT_W=XWJ7-faQ@mail.gmail.com>
Subject: Re: [GIT PULL] Block changes for 4.21-rc
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 28, 2018 at 1:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Maybe I'm  missing something, but this really looks like a completely
> invalid "optimization" to me.  And it's entirely bogus too. If that
> memory barrier matters, you're almost certainly doing something wrong
> (most likely benchmarking something pointless).

Note: I have pulled the tree, but I expect this to be either reverted,
or explained why it really is correct.

Because right now it just looks to be like a race condition that
generates faster - but incorrect - code.

The race may be practically impossible to hit simply because the other
side is slow and heavy (and you need to hit the timing just right),
but I don't see what would keep it from fundamentally happening. The
"this happens in a blue moon on just very specific hardware" bugs are
the worst kind of bugs.

              Linus
