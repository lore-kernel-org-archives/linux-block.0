Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B11C10F03
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21832083D
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 16:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfCYQZR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 12:25:17 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35039 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCYQZR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 12:25:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id h39so11019773qte.2;
        Mon, 25 Mar 2019 09:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/3qcFiab5roarwBrwE0AfKKMTRw6Enlx5L9BcfDXngY=;
        b=MlpeDtg6ag/3OIs9s00epuGusc5tzfKYxXDlFczJiCyu/A0korFcWQqxAj2uq9s7Vj
         DdU243z7aql4457kaZi9cd2c6+HFF9ZTE5Pipx7+MQgD2C2FTc8evPk6WxiT3MXyL0tw
         PwOiLeQo9xf41UZC7fCVmqyTlaCiaCvIE/uTpcOYI0RKG3YLyVNk5ukw0lyu8C9itOsY
         Y+7U006xi5kPkTbkVgziOseIflmY3y5YL8ao9PN8t3Z4YBpj8dKUbqMMyVHelKqCnRJA
         gLTd9hPCTzqh8e/164R7ktSU5VaSdifcNL2NAMKU+2sN/TKYcQL5OVzGxbvqyxjNtcsP
         Mifw==
X-Gm-Message-State: APjAAAVjFIf9iQ9/KlBfUyFw6XK6K7m7Zr8nMNwu2co1YtDFto1O6RZ4
        1OQBlPWNb6aN68tCEnZAs+38a6RqVvj80CPM0oo=
X-Google-Smtp-Source: APXvYqy5O+Aq0j29hG+cWekpuSGn3MTLpaGPbrsWzdFEUenqiGUsGURqRRLSpfilya4J1c+1u8pu6oPwOIqpp5XslVg=
X-Received: by 2002:aed:3b09:: with SMTP id p9mr21351337qte.152.1553531116015;
 Mon, 25 Mar 2019 09:25:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de> <1553530766.2955.51.camel@HansenPartnership.com>
In-Reply-To: <1553530766.2955.51.camel@HansenPartnership.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Mar 2019 17:24:58 +0100
Message-ID: <CAK8P3a0u3SAehvBiRuE-a4=qiAsyDgv0yuuCWc-nQhiTENRCAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hannes Reinecke <hare@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 25, 2019 at 5:19 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> > --- a/fs/io_uring.c
> > +++ b/fs/io_uring.c
> > @@ -1968,7 +1968,15 @@ static int io_cqring_wait(struct io_ring_ctx
> > *ctx, int min_events,
> >               return 0;
> >
> >       if (sig) {
> > -             ret = set_user_sigmask(sig, &ksigmask, &sigsaved,
> > sigsz);
> > +#ifdef CONFIG_COMPAT
> > +             if (in_compat_syscall())
> > +                     ret = set_compat_user_sigmask((const
> > compat_sigset_t __user *)sig,
> > +                                                   &ksigmask,
> > &sigsaved, sigsz);
> > +             else
> > +#endif
>
> This looks a bit suboptimal: shouldn't in_compat_syscall() be hard
> coded to return 0 if CONFIG_COMPAT isn't defined?  That way the
> compiler can do the correct optimization and we don't have to litter
> #ifdefs and worry about undefined variables and other things.

The check can be outside of the #ifdef, but set_compat_user_sigmask
is not declared then.

I think for the future we can consider just moving the compat logic
into set_user_sigmask(), which would simplify most of the callers,
but that seemed to invasive as a bugfix for 5.1.

      Arnd
