Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D60C31E5B
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1828820644
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 20:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfFQUjI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 16:39:08 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46126 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfFQUjI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 16:39:08 -0400
Received: by mail-qk1-f193.google.com with SMTP id x18so7072161qkn.13;
        Mon, 17 Jun 2019 13:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LpZTAf50o7/PLh9CIzhk7vHJ2cGCWuaTKNqQ1cWqNqU=;
        b=oOkYTJhy9twBIPx4+t93Kg0Kl/qS/3jcbrKRUQHXUOi2pl22YsJ3dZ79A7f9pXmwe2
         kg8NtJ0eUG96LCT0UzEu8TmrSXzReFajx0er9Fazg6Phe2CdMzGWFQDMPCO9J66HSMDv
         N/tFCl/FMkJjCFXSOVPDeu3HY/rpYZlGFEmjxaMqsSshjBGwqs2HiX3C1eIekrCUjAFk
         Hs8/w9CGOwcNnNxpfe+ZjQeKD+Mx27CF7u4ydGG4zZoB8G7r7KVBsawBwuVHN7Qz4gS0
         yIgi7VYLBSFJwnEC6iI8g0CL+nGP7DkZKb/iiZygzCtbXrw+UQbvKJO8sZfTi8HW5tH3
         Evrg==
X-Gm-Message-State: APjAAAXtpyASEEdj7YWOqpbEpd7tKPuKzVIaGQdfHDZFucD72x95e66W
        caK4WkMkw1dKyfTek+vYF0z3VdEH3y6vDzQNtQkZiMmX
X-Google-Smtp-Source: APXvYqxvkiU7uT50Vvb6ohuGYInfRfCjQ5Yqch5RcVO9LxFG+MQCn35pmZdu8YSFm96BJGPKBdyUGG9NgPKKxkQBSKU=
X-Received: by 2002:a37:a4d3:: with SMTP id n202mr2958065qke.84.1560803946661;
 Mon, 17 Jun 2019 13:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617132440.2721536-1-arnd@arndb.de> <20190617143635.xkbmoug5swqoi5em@rck.sh>
In-Reply-To: <20190617143635.xkbmoug5swqoi5em@rck.sh>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 22:38:49 +0200
Message-ID: <CAK8P3a3PDznLXbaQNtFpgtJyP29mh2gGSm8DeSk0NfZCgZQ_kA@mail.gmail.com>
Subject: Re: [PATCH] drbd: dynamically allocate shash descriptor
To:     Roland Kammerer <roland.kammerer@linbit.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Eric Biggers <ebiggers@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 17, 2019 at 4:36 PM Roland Kammerer
<roland.kammerer@linbit.com> wrote:
> > @@ -5572,6 +5579,7 @@ static int drbd_do_auth(struct drbd_connection *connection)
> >       kfree(response);
> >       kfree(right_response);
> >       shash_desc_zero(desc);
> > +     kfree(desc);
> >
> >       return rv;
> >  }
>
> Hi Arnd,
>
> are you sure your cleanup is okay?
>
> >       shash_desc_zero(desc);
> > +     kfree(desc);
>
> You shash_desc_zero() a potential NULL pointer. memzero_expicit() in the
> function then dereferences it:
>
> memzero_explicit(desc,
>         sizeof(*desc) + crypto_shash_descsize(desc->tfm));
>
> Maybe some if (desc) guard?

Good catch. I guess kzfree() would have been the right thing to call.

        Arnd
