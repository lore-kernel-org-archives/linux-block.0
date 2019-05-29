Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBBBC28CC2
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 14:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3256B239B7
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 14:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PRVorFm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfE2OQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 10:16:38 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44795 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfE2OQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 10:16:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id g18so2147416otj.11
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 07:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LPIxbFckpmqavIl60mnhGb6C8rcrkiaOP2OfEidBo5E=;
        b=PRVorFm2Okq9hP5kqFH4ZiGr/E/Zu5eJY3MGXXFHxfdpmEdO3GutJJMHvfi09HYlYk
         SnDTz9Jq0D6SvbjJsXUxw5SPAGf64dGBdkqzG7gBAtOGooyMlAvl8mmczoLi90evYR0A
         PoHHqSU1LxoqR2wdSfJkTL18f/IZSr+Mc0D+armTgiJNv2KbxIbIGzPnKannBmXr5ZoL
         onXscwCND5pzd7qsQ+4DRiaG4VALoZaDIZlGVD+Au9+DrLehAtdeFUdLTVj+n3sjvpTd
         19cYxGogHm6iK4AXItVQ8hkyokyg4Cjwng+d2g0cb8MTYxZRlHB62qmC+BHhUJPQbJyg
         MxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LPIxbFckpmqavIl60mnhGb6C8rcrkiaOP2OfEidBo5E=;
        b=NF0RWxXZzQvZDaRR3MCkDBsZnPp4u/c7T5nL+6M6tewPeUEh0IZcIYRVNjSccBavlI
         vmxQl/kCJOnxsUe4yWjUZHi/OuewrjdvKJpBCbvWDCgEQyPopUsM4BVh+4Deqei+cAIL
         Zaqm5oxFAYJixMHgkYvnrc3+o8Tc37rSEesP1wtrnqZbB+Y0s17VDKdTq5UHunLqz55+
         DOR8lh26/kqLNdzEJP+KBKD/Bwk7qhj0yt9JEjYSOZYlHJu3+/fM8+JK6rgwxDyUZ/r5
         a4ZaRjPONsOsnSWNEz5neTvRfUxMvG596155gMAbo+2VoVIcUjacRLQwB5/wPGsHLAbB
         y7FQ==
X-Gm-Message-State: APjAAAX9UQbQhPd33UFBXQ8jWtLvil4Pxm5Rh35XoFnW1Y0+EnhUu9aC
        bhDDgL0v32Wnuj7a+jfCLXsuuQi9907ig57boofBvQ==
X-Google-Smtp-Source: APXvYqwFTJrhrhEsjfOGtxnb29he2Fqyf9z7Tcu+GzobGgP0NfT3JF16fdsQq+/5jwCnLYlKlqDC3v5fUc8xIPyeFeo=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr37188otp.110.1559139396903;
 Wed, 29 May 2019 07:16:36 -0700 (PDT)
MIME-Version: 1.0
References: <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905934373.7587.10824503964531598726.stgit@warthog.procyon.org.uk>
 <CAG48ez2o1egR13FDd3=CgdXP_MbBsZM4SX=+aqvR6eheWddhFg@mail.gmail.com> <24577.1559134719@warthog.procyon.org.uk>
In-Reply-To: <24577.1559134719@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 16:16:10 +0200
Message-ID: <CAG48ez0Ugv=cfj-v6DaYma0HgyiBjpykSkCr7mCAcMx13LEncg@mail.gmail.com>
Subject: Re: [PATCH 4/7] vfs: Add superblock notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 2:58 PM David Howells <dhowells@redhat.com> wrote:
> Jann Horn <jannh@google.com> wrote:
> > It might make sense to require that the path points to the root inode
> > of the superblock? That way you wouldn't be able to do this on a bind
> > mount that exposes part of a shared filesystem to a container.
>
> Why prevent that?  It doesn't prevent the container denizen from watching a
> bind mount that exposes the root of a shared filesystem into a container.

Well, yes, but if you expose the root of the shared filesystem to the
container, the container is probably meant to have a higher level of
access than if only a bind mount is exposed? But I don't know.

> It probably makes sense to permit the LSM to rule on whether a watch may be
> emplaced, however.

We should have some sort of reasonable policy outside of LSM code
though - the kernel should still be secure even if no LSMs are built
into it.

> > > +                       }
> > > +               }
> > > +               up_write(&s->s_umount);
> > > +               if (ret < 0)
> > > +                       kfree(watch);
> > > +       } else if (s->s_watchers) {
> >
> > This should probably have something like a READ_ONCE() for clarity?
>
> Note that I think I'll rearrange this to:
>
>         } else {
>                 ret = -EBADSLT;
>                 if (s->s_watchers) {
>                         down_write(&s->s_umount);
>                         ret = remove_watch_from_object(s->s_watchers, wqueue,
>                                                        s->s_unique_id, false);
>                         up_write(&s->s_umount);
>                 }
>         }
>
> I'm not sure READ_ONCE() is necessary, since s_watchers can only be
> instantiated once and the watch list then persists until the superblock is
> deactivated.  Furthermore, by the time deactivate_locked_super() is called, we
> can't be calling sb_notify() on it as it's become inaccessible.
>
> So if we see s->s_watchers as non-NULL, we should not see anything different
> inside the lock.  In fact, I should be able to rewrite the above to:
>
>         } else {
>                 ret = -EBADSLT;
>                 wlist = s->s_watchers;
>                 if (wlist) {
>                         down_write(&s->s_umount);
>                         ret = remove_watch_from_object(wlist, wqueue,
>                                                        s->s_unique_id, false);
>                         up_write(&s->s_umount);
>                 }
>         }

I'm extremely twitchy when it comes to code like this because AFAIK
gcc at least used to sometimes turn code that read a value from memory
and then used it multiple times into something with multiple memory
reads, leading to critical security vulnerabilities; see e.g. slide 36
of <https://www.blackhat.com/docs/us-16/materials/us-16-Wilhelm-Xenpwn-Breaking-Paravirtualized-Devices.pdf>.
I am not aware of any spec that requires the compiler to only perform
one read from the memory location in code like this.
