Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C882EC31E5B
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 20:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D432080A
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 20:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFQU7R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:59:17 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41820 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFQU7Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 16:59:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so7623989qtj.8;
        Mon, 17 Jun 2019 13:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIPHa48eC477VDjHx1ZCYDwdsGRn2h4fpH2GcgXY5WE=;
        b=PVJS3rQlo7EgpZ0Osav7kLrFVPZxQecQ4M+54gFZNIzropfO06Aq8VDFc9/cpUKB5y
         8/eyxwxU95+kZ0vHbzVmJwA9wSAk8mB9dPmaVCZ1SxR/Go97yddOw0ZYlw4CpbD7rB3n
         KIiySWXJoLslXNIgX6MSMhlR3QRrWGnUXjoGja6Tmq4+7rW5vTi4RYTl9p3Cvf6InaPH
         yEm7IEo3DY8SrmkgCMfqROkFQlg+hokKjhReuHngNBPBIouoVfWn3KQOWVL5BqrRGQ+o
         OLCvoGxHigCVtZIi0nwi/m7gXlGc2FVvCo146yuFjfN7Ii3qsRnQGfr130rVI0e77NkQ
         5uhA==
X-Gm-Message-State: APjAAAUjfunF3nYpqu6MkAWAZeDDL47PaR8mPNDUyudyh0IAlwt4CxG1
        Wie4p2jXgk0o0lgWkjCHvBokjibpVdY8UO7/2PI=
X-Google-Smtp-Source: APXvYqwdO9AXswCnqssJhbkYuHKAqCG+M7GEDGIS0W5qNxg/G4WXNXsrWuIOG9pTVB9wQ5YtWiHQyphDJ77tPGzwraA=
X-Received: by 2002:a0c:b758:: with SMTP id q24mr23622267qve.45.1560805155468;
 Mon, 17 Jun 2019 13:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190617132440.2721536-1-arnd@arndb.de> <20190617144335.q243r7l7ox7galhl@gondor.apana.org.au>
In-Reply-To: <20190617144335.q243r7l7ox7galhl@gondor.apana.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 22:58:58 +0200
Message-ID: <CAK8P3a2g4ZDcyxuSOkYzOmqV3Hc3YF3Anc3GQysvGo9bijYufQ@mail.gmail.com>
Subject: Re: [PATCH] drbd: dynamically allocate shash descriptor
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 17, 2019 at 4:43 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Jun 17, 2019 at 03:24:13PM +0200, Arnd Bergmann wrote:
> > Building with clang and KASAN, we get a warning about an overly large
> > stack frame on 32-bit architectures:
> >
> > drivers/block/drbd/drbd_receiver.c:921:31: error: stack frame size of 1280 bytes in function 'conn_connect'
> >       [-Werror,-Wframe-larger-than=]
> >
> > We already allocate other data dynamically in this function, so
> > just do the same for the shash descriptor, which makes up most of
> > this memory.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/block/drbd/drbd_receiver.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
>
> Does this patch fix the warning as well?

The warning is gone with this patch. Instead of 1280 bytes for drbd_receiver,
I now see 512 bytes, and 768 bytes for drbd_get_response, everything else is
under 160 bytes in this file.

However, with the call chain of

drbd_receiver
   conn_connect
       drbd_do_auth
             drbd_get_response

This still adds up to as much as before, so it only shuts up the
warning but does not reduce the maximum stack usage.

If we are sure that is ok, then your patch would be nicer,
possibly with a 'noinline_for_stack' tag on drbd_get_response.

       Arnd
