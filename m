Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E88FC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098F120848
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 00:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ikbnUsZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfCZANI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:13:08 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:43530 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726553AbfCZANI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 20:13:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6217E8EE0E0;
        Mon, 25 Mar 2019 17:13:07 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RDz2U9LDNnC6; Mon, 25 Mar 2019 17:13:06 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 648DE8EE0DF;
        Mon, 25 Mar 2019 17:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1553559186;
        bh=Lfp/oz/KzPDjG1nta07E58bI9NcSy7H9Dyu6V8CSx70=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ikbnUsZ1B1lkL+vzVvcVEImnvHc4J1lTEqettn2xHOd09KqS8acJuLXXLAEWUXKy4
         BxZx1B2lPD7RAvLfwJQNuLoDevkx30J8qfjhBZQSjRzGEn0pZMju2VjQ1+IXaK5aw4
         FlJGggUYGcewatXnsrOMViWRCdkb2vQPfI38191o=
Message-ID: <1553559185.2929.20.camel@HansenPartnership.com>
Subject: Re: [PATCH 1/2] io_uring: fix big-endian compat signal mask handling
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Arnd Bergmann <arnd@arndb.de>
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
Date:   Mon, 25 Mar 2019 17:13:05 -0700
In-Reply-To: <CAK8P3a0u3SAehvBiRuE-a4=qiAsyDgv0yuuCWc-nQhiTENRCAg@mail.gmail.com>
References: <20190325143521.34928-1-arnd@arndb.de>
         <1553530766.2955.51.camel@HansenPartnership.com>
         <CAK8P3a0u3SAehvBiRuE-a4=qiAsyDgv0yuuCWc-nQhiTENRCAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-03-25 at 17:24 +0100, Arnd Bergmann wrote:
> On Mon, Mar 25, 2019 at 5:19 PM James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> 
> > > --- a/fs/io_uring.c
> > > +++ b/fs/io_uring.c
> > > @@ -1968,7 +1968,15 @@ static int io_cqring_wait(struct
> > > io_ring_ctx
> > > *ctx, int min_events,
> > >               return 0;
> > > 
> > >       if (sig) {
> > > -             ret = set_user_sigmask(sig, &ksigmask, &sigsaved,
> > > sigsz);
> > > +#ifdef CONFIG_COMPAT
> > > +             if (in_compat_syscall())
> > > +                     ret = set_compat_user_sigmask((const
> > > compat_sigset_t __user *)sig,
> > > +                                                   &ksigmask,
> > > &sigsaved, sigsz);
> > > +             else
> > > +#endif
> > 
> > This looks a bit suboptimal: shouldn't in_compat_syscall() be hard
> > coded to return 0 if CONFIG_COMPAT isn't defined?  That way the
> > compiler can do the correct optimization and we don't have to
> > litter #ifdefs and worry about undefined variables and other
> > things.
> 
> The check can be outside of the #ifdef, but set_compat_user_sigmask
> is not declared then.

Right, but shouldn't it be declared?  I thought BUILD_BUG_ON had nice
magic that allowed it to work here (meaning if the compiler doesn't
eliminate the branch we get a build bug).

> I think for the future we can consider just moving the compat logic
> into set_user_sigmask(), which would simplify most of the callers,
> but that seemed to invasive as a bugfix for 5.1.

Well, that too.  I've just been on a recent bender to stop #ifdefs
after I saw what some people were doing with them.

James

