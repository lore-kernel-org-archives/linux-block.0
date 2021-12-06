Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72657C433EF
	for <linux-block@archiver.kernel.org>; Mon,  6 Dec 2021 20:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349847AbhLFUyv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Dec 2021 15:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349845AbhLFUyv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Dec 2021 15:54:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2BC061746
        for <linux-block@vger.kernel.org>; Mon,  6 Dec 2021 12:51:22 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b11so7852275pld.12
        for <linux-block@vger.kernel.org>; Mon, 06 Dec 2021 12:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mCJ4nBf6Lo40Ydhx+IIYyWq/GXNaQKH4uw6Hx68amJM=;
        b=QceAsGJixEdXIWVajZC5pj9oUyYkkA0rPKztynGXnWuxeFiY0GJd+OQq9CK2s1yJ3p
         EbXNWRJrSEFMK3AEUhNiBSDkAESrXDEQHGYA+aKlcYeMWdAx4UYED5QzvVP7v54+hMir
         2sE2cxDNiWuV1nJxEy0i7mZpkdfCeSVN0PM1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mCJ4nBf6Lo40Ydhx+IIYyWq/GXNaQKH4uw6Hx68amJM=;
        b=t740rlMF/f0q1FKWoaxzFDYTNyfI66kMrdeRrhY17nTudPAmTph835ksUIUtFHHl48
         isN7X03WavrIKvi1WJpDt3ZywSRXbW9S0iKNLpXAA0JsiLWzky3hr0+U95i+y9rKwfIC
         FAfHxbbJXygQsitqS65fRRbsubkLjaqHYK8rxPw1fawXgut+U2LtDdLlP9caaT3IbJdh
         5XpjVOFv/ANmvlQpYMkreqnHWTEQ84vJh45wq5Z/aoLcSh4VGnqWQGXMriwxHoAVb+tx
         kAdko3ikcl8K1w96n7Vdb79f/iP8c/fh0ApT3wvX6NKmgkM7JL1ru367Jxg9gcgMP9rf
         VY/Q==
X-Gm-Message-State: AOAM531R7+bMiGpvsYXg6rccS/5wX1GMGieGWFYZ/Fhrv8F895icQbpT
        10BmS3Uf6/wSAT/BXopnRqj6Qw==
X-Google-Smtp-Source: ABdhPJwd0z0OTzz0qvWpgQZFBgki7hiRllcp5VHVPHHFHjy1Xg4vtrktWWvpzaosTDvFAvoPlVV+Vw==
X-Received: by 2002:a17:90a:5883:: with SMTP id j3mr1117921pji.13.1638823881893;
        Mon, 06 Dec 2021 12:51:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm13750950pfi.46.2021.12.06.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:51:21 -0800 (PST)
Date:   Mon, 6 Dec 2021 12:51:21 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: switch to atomic_t for request references
Message-ID: <202112061247.C5CD07E3C@keescook>
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org>
 <Ya3KZiLg5lYjsGcQ@hirez.programming.kicks-ass.net>
 <CAHk-=wjXmGt9-JQp-wvup4y2tFNUCVjvx2W7MHzuAaxpryP4mg@mail.gmail.com>
 <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <282666e2-93d4-0302-b2d0-47d03395a6d4@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 06, 2021 at 11:13:20AM -0700, Jens Axboe wrote:
> On 12/6/21 10:35 AM, Linus Torvalds wrote:
> > On Mon, Dec 6, 2021 at 12:31 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> Quite; and for something that pretends to be about performance, it also
> >> lacks any actual numbers to back that claim.
> >>
> >> The proposed implementation also doesn't do nearly as much as the
> >> refcount_t one does.
> > 
> > Stop pretending refcoutn_t is that great.
> > 
> > It's horrid. The code it generators is disgusting. It should never
> > have been inlines in the first place, and the design decsisions were
> > questionable to begin with.
> > 
> > There's a reason core stuff (like the page counters) DO NOT USE REFCOUNT_T.
> > 
> > I seriously believe that refcount_t should be used for things like
> > device reference counting or similar issues, and not for _any_ truly
> > core code.

I'd like core code to be safe too, though. :)

> Maybe we just need to embrace it generically, took a quick stab at it
> which is attached. Totally untested...

As long as we have an API that can't end up in a pathological state, I'm
happy. The problem with prior atomic_t use was that it never noticed
when it was entering a condition that could be used to confuse system
state (use-after-free, etc). Depending on people to "use it correctly"
or never make mistakes is not sufficient: we need an API that protects
itself. We have to assume there are, and will continue to be, bugs with
refcounting.

-- 
Kees Cook
