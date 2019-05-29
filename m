Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D839C28CC2
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7811423FFE
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 17:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rqEGFjkU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfE2Rr1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 13:47:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41118 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Rr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 13:47:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id y10so2765672oia.8
        for <linux-block@vger.kernel.org>; Wed, 29 May 2019 10:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmI4EFzZ6VT9TOg1cFEHsMHt6YDKL3frdwtue1WA3MQ=;
        b=rqEGFjkUEFmWfe+Bt5MYFJ/f/Ul+aHmqapx7HwxPLddDX0XutuICprcxl2IRBB+2wZ
         FBRhjkQhq0l8FGGPbG9iYTwcvG1L0zqWGnLkyYD0QUHtOHVFLuFexbbvf8DTq2cAJwIc
         qGAeqR/R7WWTblsPDHtqemkbqR/RjKHsE/rp1eLjwVmSOkWL+HLfgGJwRyW90asobQJ4
         db628CyWRP0Gbo529Eq/uBkkm0ATyy/7jo4gyJbVRwGvSHZ4DHrUenMmRW4i+hfsltwh
         /NisW02kiqi8fqH+L1vXF6yr7Zpf/a9SpygycxZqARJe1E3v94fpOSgoJmPU9/JrJi49
         HCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmI4EFzZ6VT9TOg1cFEHsMHt6YDKL3frdwtue1WA3MQ=;
        b=WQ91VL/PW7ditJieim6CCxd/h6+JZWDHaqespfVtsTFPgNkQ4tWKJHffaF8DxipZFH
         FPRZtGWqudgMZZuAYv/HoHII6KNGylFS8XjPPKcKFBgl+aSggkh5KZMIkk9lxmxAOE8O
         eEPNOLQBICXSv6eDLVPwAQtzKqt/Lo0Bz6sFuJrfcyGmHv2Ki9sSjgqhG+dRJZDmu1Ju
         qMJ9BJX4mSHGoh+SX8jHXGiSzTmwvETGSQEhkJJRQ+sklXXr5M7gKtxHJLEHeaQ3GCzf
         UbT/+vzsMcRD7e+fZdGgyM41VogyslhVjCkcro3Z/DC5oZZ/Qndr0TmMjsTqm6cCaPb0
         1AEQ==
X-Gm-Message-State: APjAAAUndxyWgeFHDRwFpBq1o7VMvFoMI1ror4TQYVMNfr/dteO3scnR
        N0MQ68BhlEzOiqHS89kZtnqWBjLqrWXwsPEzeDtb1Q==
X-Google-Smtp-Source: APXvYqwAXrQMKCV8uFA/kbPzCqsEnH0/t77faf/fiPhDVfNPi7ZFtM6fgNmEGcbRFh238jXq6XZ6wItg04BAO70Npc4=
X-Received: by 2002:aca:5943:: with SMTP id n64mr58380oib.175.1559152041282;
 Wed, 29 May 2019 10:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190528162603.GA24097@kroah.com> <155905930702.7587.7100265859075976147.stgit@warthog.procyon.org.uk>
 <155905931502.7587.11705449537368497489.stgit@warthog.procyon.org.uk>
 <4031.1559064620@warthog.procyon.org.uk> <20190528231218.GA28384@kroah.com> <31936.1559146000@warthog.procyon.org.uk>
In-Reply-To: <31936.1559146000@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 19:46:54 +0200
Message-ID: <CAG48ez0R-R3Xs+3Xg9T9qcV3Xv6r4pnx1Z2y=Ltx7RGOayte_w@mail.gmail.com>
Subject: Re: [PATCH 1/7] General notification queue with user mmap()'able ring buffer
To:     David Howells <dhowells@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
> Greg KH <gregkh@linuxfoundation.org> wrote:
> > everyone should use
> > it.  It saves us having to audit the same pattern over and over again.
> > And, even nicer, it uses a refcount now, and as you are trying to
> > reference count an object, it is exactly what this was written for.
> >
> > So yes, I do think it should be used here, unless it is deemed to not
> > fit the pattern/usage model.
>
> kref_put() enforces a very specific destructor signature.  I know of places
> where that doesn't work because the destructor takes more than one argument
> (granted that this is not the case here).  So why does kref_put() exist at
> all?  Why not kref_dec_and_test()?
>
> Why doesn't refcount_t get merged into kref, or vice versa?  Having both would
> seem redundant.
>
> Mind you, I've been gradually reverting atomic_t-to-refcount_t conversions
> because it seems I'm not allowed refcount_inc/dec_return() and I want to get
> at the point refcount for tracing purposes.

Yeeech, that's horrible, please don't do that.

Does this mean that refcount_read() isn't sufficient for what you want
to do with tracing (because for some reason you actually need to know
the values atomically at the time of increment/decrement)?
