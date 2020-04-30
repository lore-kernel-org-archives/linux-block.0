Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E3DC83001
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 07:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0119821973
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 07:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Pm0gae2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgD3Hm7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgD3Hm7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 03:42:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D9C035495
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 00:42:58 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z6so721994wml.2
        for <linux-block@vger.kernel.org>; Thu, 30 Apr 2020 00:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yj3aOOAITkSoQ9HT/kLSsxXrmoC54MHhQnwfKg+EFsA=;
        b=Pm0gae2WWQGHGGGGOdaSVHtCmsA3TKcvgr8Nj2+qIsy2aELVcARV7qCd1ZjvJEtCOm
         IbAmWIeKIhTLUxDSeh8VESrrbt3Ygn2crA0bwve3VtBx633ubS3cEfqPlO2wWQOY5Nyz
         Tno8w9QwO+9xz9CppDJqIb4qnllco8yeygNgsc8FRmjR71xzM/6ubeb551WtgtYcTm+h
         owYpjqttcka/D0/FP7xQIfATN3FEValTX9qyiPQNUpbr3A9MhvN0yejJ0SHcBcaxiOCt
         okM0y78WXX4bpPirKvDRd6VJjGX935ZDzSQ7qMnfAFh15LDEfDtdum4d5oQTMSROTdIY
         YCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yj3aOOAITkSoQ9HT/kLSsxXrmoC54MHhQnwfKg+EFsA=;
        b=DCNS6emBXwEMvSPoXopcgUo4fEMOJ2UGHJHXtxCyeOH0zQC9kK0h05JiFGM+z8aRG4
         BDYJWXk6vxhkvo3WHW7cLihtjp+tXsBeSrmqErNJg+zZoSj2dLqH94UniOUSBWMy04NU
         XmzPYLVpcDraYzGD/kW/OMHduVJyirez9G39LOhbL4flkzYxXjHFPijkHFOXa+5wNOjt
         21IbqoVjdDWNqHoOcBUNRbq8N+vHsvUnb5Mqn6nui0TzHS3BVsXfIdkezahF6Izipy7F
         Jc7sz/Qku39JV+ljqFJ2sDrQtu5tIJHhDUz3f2s2zO80hQu+0+k7INRVBfPIKFyEGyZR
         DFjQ==
X-Gm-Message-State: AGi0PuZrJdpp+A4o3G7UioqEmcwK77d1BsvZ7zdVI2AE1CVtBbzpAXk4
        XNVA8UcSGR0AVscMr/4vChnospagGH9pw9CXSvYH
X-Google-Smtp-Source: APiQypLeP/hDfEhBONVBBPo4+ko5WjkMd4EvCY7nuPRLYRkKNJYDO0r9o+eolLYaXHwTLn8a3SMcctnUtcNSRYJt06E=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr1403256wml.166.1588232577086;
 Thu, 30 Apr 2020 00:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-24-danil.kipnis@cloud.ionos.com> <20200429171804.GE26002@ziepe.ca>
In-Reply-To: <20200429171804.GE26002@ziepe.ca>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Thu, 30 Apr 2020 09:42:46 +0200
Message-ID: <CAHg0Huyvt1P1To+fxn3RZdGXJfnQXpNxJbpNxquqLw_KVtcDKA@mail.gmail.com>
Subject: Re: [PATCH v13 23/25] block/rnbd: include client and server modules
 into kernel compilation
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jinpu Wang <jinpu.wang@cloud.ionos.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 29, 2020 at 7:18 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Mon, Apr 27, 2020 at 04:10:18PM +0200, Danil Kipnis wrote:
> > +rnbd-client-y := rnbd-clt.o \
> > +               rnbd-common.o \
> > +               rnbd-clt-sysfs.o
> > +
> > +rnbd-server-y := rnbd-srv.o \
> > +               rnbd-common.o \
> > +               rnbd-srv-dev.o \
> > +               rnbd-srv-sysfs.o
>
> keep lists of things sorted

Hi Jason, I understand you mean to sort the order of object files
here, right? Is that the reason the kbuild robot couldn't find the
rtrs.h include file?
