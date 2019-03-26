Return-Path: <SRS0=zyEp=R5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CEBC43381
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 08:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1E620857
	for <linux-block@archiver.kernel.org>; Tue, 26 Mar 2019 08:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfCZIfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:35:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37010 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbfCZIfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Mar 2019 04:35:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id z16so13583787qtn.4;
        Tue, 26 Mar 2019 01:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8CWQ0vlfEM02bfYSXusQ3OXqqxb3sLKb5Y+G7wWTrg=;
        b=BULgRyAcnpnyg3CWtI3nmTweD6Gj2/r+ImMIKdzkqwuJ0ClcpteXLQqPFaTWuxl2Up
         DAanMgRnEoPs9AogAt3IdBBv/WdB2nCxyWpTGJiKR//TTxeau/I8ori5vw2xamm483sC
         Y8yJptsyME0wLrtfiNmB9/rJoYV7N92ZddOSDPFsIB97yO0p4JHdfvGVS4VCo2My5RJ1
         og7zZvHXLGWxTU1Xtcaggc/IMhCC/wgqzhpbYJNrtqTOH+/2Spm6ZXQ4sGLdgzH8PRI9
         IU3Bt74DJCQzGJQ9NBE0ACqPtFpMLhNuc33dVEPePg3bBNCbmkYtl3x0ZUegUipLbe8C
         oNxA==
X-Gm-Message-State: APjAAAXxrqpL9QRRt3dwN8wIBvdCM9uIf8wywZ+VoLn/45vQOjzD9oq6
        DLx79xKShzzIqPyhcCz1gmOxAOq1b0oJAqFZ/+I=
X-Google-Smtp-Source: APXvYqyg4+9rtk0JX8+Cjo+URmihQxVIBPcSeFpZD1ZyXzneXzE/LdslzI+/IPABGlieTqXdkmAhtAU2+raJmd/OmnM=
X-Received: by 2002:ac8:276b:: with SMTP id h40mr24477221qth.319.1553589350138;
 Tue, 26 Mar 2019 01:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190325143521.34928-1-arnd@arndb.de> <1553530766.2955.51.camel@HansenPartnership.com>
 <CAK8P3a0u3SAehvBiRuE-a4=qiAsyDgv0yuuCWc-nQhiTENRCAg@mail.gmail.com> <1553559185.2929.20.camel@HansenPartnership.com>
In-Reply-To: <1553559185.2929.20.camel@HansenPartnership.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 26 Mar 2019 09:35:33 +0100
Message-ID: <CAK8P3a3TbXZdo2Gom=GbvOeFkiJmGHXDfCq4unJn3-P_K5peJA@mail.gmail.com>
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

On Tue, Mar 26, 2019 at 1:13 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Mon, 2019-03-25 at 17:24 +0100, Arnd Bergmann wrote:
> > On Mon, Mar 25, 2019 at 5:19 PM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > > This looks a bit suboptimal: shouldn't in_compat_syscall() be hard
> > > coded to return 0 if CONFIG_COMPAT isn't defined?  That way the
> > > compiler can do the correct optimization and we don't have to
> > > litter #ifdefs and worry about undefined variables and other
> > > things.
> >
> > The check can be outside of the #ifdef, but set_compat_user_sigmask
> > is not declared then.
>
> Right, but shouldn't it be declared?  I thought BUILD_BUG_ON had nice
> magic that allowed it to work here (meaning if the compiler doesn't
> eliminate the branch we get a build bug).

My y2038 series originally went in that direction by allowing much more
of the compat code to be compiled and then discarded without the
#ifdefs (and combine it with the 32-bit time_t handling on 32-bit
architectures). I went away from that after Christoph and others found
the reuse of the compat interfaces too confusing.

The current state now is that most compat_* interfaces cannot be
compiled unless CONFIG_COMPAT is set, and making that work
in general is a lot of work, so I followed the usual precedent here
and used that #ifdef. This also matches what is done elsewhere
in the same file (see io_import_iovec).

> > I think for the future we can consider just moving the compat logic
> > into set_user_sigmask(), which would simplify most of the callers,
> > but that seemed to invasive as a bugfix for 5.1.
>
> Well, that too.  I've just been on a recent bender to stop #ifdefs
> after I saw what some people were doing with them.

I absolutely agree in general, and have sent many patches to
remove #ifdefs in other code when there was a good alternative
and the #ifdefs are wrong (which they are at least 30% of the time
in my experience).

The problems for doing this in general for compat code are

- some structures have a conditional compat_ioctl() callback
  pointer, and need an #ifdef around the assignment until
  we change the struct as well.
- Most compat handlers require the use of the compat_ptr()
  wrapper, I have a patch to move this to common code, but
  that was rejected previously
- many compat handlers rely on types from asm/compat.h
  that does not exist on architectures without compat support.

In this specific case, compat_sigset_t is required for declaring
set_compat_user_sigmask(), and the former is not easy to
define on non-compat architectures. I still think that the best
way forward here is to move it into set_user_sigmask()
next merge window, rather than doing a larger scale rewrite
of linux/compat.h to get this bug fixed now.

      Arnd
