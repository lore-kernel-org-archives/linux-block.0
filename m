Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC3BC433EF
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879EF6120F
	for <linux-block@archiver.kernel.org>; Mon,  1 Nov 2021 17:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhKARFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Nov 2021 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbhKARFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Nov 2021 13:05:49 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C9C061714
        for <linux-block@vger.kernel.org>; Mon,  1 Nov 2021 10:03:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id p16so37639177lfa.2
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XOfdyTNR9F59w5/7qXiN/n8sc+FHIqIqjqFQUvlR+hY=;
        b=fC0cFc8IyCL1Waml7qHKjiBvWF8lUkHc4l0aUEviMCg7+ysBIi2bZThPj+vJ1iOaxc
         t0++lmJhkhgQRYWZnElkAo9ZdJfb7UEUNicNQDPu+YRcuStF0NegiCXDynPuMQV92ojq
         Xl9ra5yNc8CXA8CSLKFm4J+mLwmiJFSLQZNxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XOfdyTNR9F59w5/7qXiN/n8sc+FHIqIqjqFQUvlR+hY=;
        b=RRVE0ze9AcMDcUaBcGoNA0f1AX0CMSVXL1R94z3qIgOt1UByUBez9MVcbPA7Wll2n/
         oDYdeR9dEnxo6d9KQ+YWoXHFAOJfs5I3/Mu36c5xx7NfPypYUKJ82S4Ls7/+LDdTgPOU
         JTqo0dfqcqlafint2grULmW9Zb6tMsTBexkv4NflvFlgHXmhWErPVPxPhLseDxxRvQPl
         k9ItWmSVbf2kR9CrYIjOvcxqJbmQvrD208HNIWUrkHKOU8wOdigHiQmGsAeTBlKn6VQ5
         q93Z4hxk5uvRN1t+7LFT77t82OtzeTh6IdfFldhaz4yKnqx1tU6Dbk50eYhsZ+KhF6GB
         18aw==
X-Gm-Message-State: AOAM5334MUP81SRD74Zz0S3WpdfncJoS5xnLFKbLhbZgzGKFUF/QSPqq
        k0CbrMxokLDhIjQ8Pif4jvffJ4zFvJ94F3tE
X-Google-Smtp-Source: ABdhPJzqCuwrPxq101Qk0Szysl22L4BlwPtejfBwvc4LgYxq6YI0669iDSzLn8bjNHBaa9OUrVa1lQ==
X-Received: by 2002:a05:6512:251:: with SMTP id b17mr11231554lfo.57.1635786193894;
        Mon, 01 Nov 2021 10:03:13 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id f9sm1568536ljq.58.2021.11.01.10.03.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Nov 2021 10:03:13 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id x19so6296592ljm.11
        for <linux-block@vger.kernel.org>; Mon, 01 Nov 2021 10:03:12 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr4253756ljp.68.1635786192720;
 Mon, 01 Nov 2021 10:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
In-Reply-To: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Nov 2021 10:02:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com>
Message-ID: <CAHk-=wii3c_VebHJxEyqU5P6FKjOLirYHQm+0=oaL59DNi-t1A@mail.gmail.com>
Subject: Re: [GIT PULL] bdev size cleanups
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 31, 2021 at 12:41 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On top of the core block branch, this topic branch cleans up the bdev
> size handling.

So on the whole this seems to be a good cleanup, but some of it worries me.

For example, it seems to have lost the cast to "loff_t" when
generating the byte size from a "sector_t".

Ok, so these days those are both 64-bit, and it doesn't actually
matter (the time when we had a 32-bit sector_t as an option are long
gone), but I think that bdev_nr_bytes() helper really ends up being
subtler than it looks. It very much depends on 'sector_t' and 'loff_t'
being the same size (although sector_t is an u64, loff_t ends up being
the signed version).

I've pulled this, but I do think it might have been better with the
type conversion being explicit. One of the reasons we had "sector_t"
originally was that it ended up being configuration-dependent, and
could be 32-bit. Those times may be gone, but it's still conceptually
a very different type from "loff_t".

                 Linus
