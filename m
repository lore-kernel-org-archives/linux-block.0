Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6907C433EF
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 11:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8933F61205
	for <linux-block@archiver.kernel.org>; Sat, 11 Sep 2021 11:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235670AbhIKLBv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Sep 2021 07:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhIKLBu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Sep 2021 07:01:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64243C061756
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 04:00:38 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d17so2766300plr.12
        for <linux-block@vger.kernel.org>; Sat, 11 Sep 2021 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMOWBn/u3aVqbnWmF8p6o8arazc7UvhFXaE3d67u6n4=;
        b=QN7SJrTyCSMIyBHAc17ieT6dplKOZbkE5rooPK1SQ14X4xBKVqgd3AWSEfSLXX0lIJ
         hz8ASHsktLblp54wrq+oizyk4nxhAd6Syku/hay86bw7DywlNeZ1gbjfZtVvuIf30Cn4
         Ez3PXcTQNbYW8k7YDERRrLNGyberXh8uZatjwIwNGUw6yPc/iWZJyLdcYt82Y7/p2aO7
         K8Np2VFafUo8P01L5Gtq8jVR587gQ33yVvkGAPU/9ba78gTYgBdhg1dyHNxc5lplsWN0
         4hSaLhfiCqpT8kECOa3ix5k2WOrBeEb+/AotOtTsJZwjFKBsLCxzCa0vID2ZSiZaCbbi
         nwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMOWBn/u3aVqbnWmF8p6o8arazc7UvhFXaE3d67u6n4=;
        b=hA55Qckv8ffqC//c/pLP/gcHNSGSVKy2LRtHCjaZFjIrsdxo/PgMSSMHiQMBPEeqAU
         aIdxRGbQB/cbtD0hrGEqjm4y4oIc2fEvFqBnSopjzsDfq1SphFENjWhfqct94Ukd9Ai3
         /7LLZfmBtTMXkZ3+XlaHtM5P0kpOqjmmPz60pPjREooEPNllSW3JWBGe8vuMPaP25HO6
         e9o4P9Z6cIVEaKvOrlfoUyIjR9Kb4fLIuaR1vgysIm+yq6b7oL++K0T+pxIfQqsQQ/hF
         hKxIyZp7hRvQhUzk65BnX6XjGN6UQJBJ+F8WrR31QuMvE9u2BXj5LEKamBv8IfEXJz+L
         pxMA==
X-Gm-Message-State: AOAM5331vmiSLdHmCKNSAxVZ4hvMHsOYXElQ49+TKhrQW+FZ3BWY1jn4
        rln0sel5jgIi5CTJFeNSZQlqtdjpSmYKo+Ofy5m1nA==
X-Google-Smtp-Source: ABdhPJy5cGNaclwU+Wu7lP6BWkQDF5adMjybClEbKDSLZmxMjfP4ZCWLYauxivTUNLyUwHfncbGeD7NsKBTRJr1L2ns=
X-Received: by 2002:a17:902:e846:b0:13a:479:33e5 with SMTP id
 t6-20020a170902e84600b0013a047933e5mr1986123plg.25.1631358037720; Sat, 11 Sep
 2021 04:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210910211600.5663-1-lumip@lumip.de> <e3efb5ea-0884-c02a-cb81-408ec421463d@infradead.org>
In-Reply-To: <e3efb5ea-0884-c02a-cb81-408ec421463d@infradead.org>
From:   Phillip Potter <phil@philpotter.co.uk>
Date:   Sat, 11 Sep 2021 12:00:27 +0100
Message-ID: <CAA=Fs0mEprM0hErRY-kw7bOVqEw3o6X=--OixQ=_fNXdV_-QGQ@mail.gmail.com>
Subject: Re: [PATCH v3] drivers/cdrom: improved ioctl for media change detection
To:     Lukas Prediger <lumip@lumip.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 10 Sept 2021 at 22:41, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi Lukas,
>
> Just a minor nit:
>
> On 9/10/21 2:16 PM, Lukas Prediger wrote:
> > +#define MEDIA_CHANGED_FLAG   0x1     /* Last detected media change was more \
> > +                                      * recent than last_media_change set by\
> > +                                      * caller.                             \
> > +                                      */
>
> Drop the "continuation" backslashes.
> They are not needed.
>
> thanks.
> --
> ~Randy
>

Dear Lukas,

Happy to take these out for you and save you resubmitting.
I'm very happy with patch anyway. Once I hear back from
you I'll send onto Jens with my approval after one final test :-)

Thanks again for the code.

Regards,
Phil
