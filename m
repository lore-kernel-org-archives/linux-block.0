Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97459C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 17:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C73A20637
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576085863;
	bh=iEYqtFO5ezi5pfJ5VyNemUIN2UU0gyoqqWd96YVfhgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=krYgRdLGod7WoYwspV3tSxGZlPV71dDzDQHMEuu0skdQnZNyE2Gp1fgHyR3sm16tX
	 BXtl44DLZKOBE5kmPKriFocu4+BrqXegzBe7OcLi+Jx0gp8oHzaD/WkbiIH+nPkAgn
	 1+Lo8KinsA+pc3tvhySifUE7tFhdLbqgdEWSzTp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfLKRhm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:37:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36242 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729996AbfLKRhm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 12:37:42 -0500
Received: by mail-lf1-f65.google.com with SMTP id n12so17368770lfe.3
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qPDI4CWJjC5/5bz94R850+eMWjiIMaPpEB5QatbHqs=;
        b=LtAWLNJIGgleEYyJY7SqUMGfF7zizqXB9fYINThzWBGo8tnYIl1k6mXoeKI7sQzQdq
         EPnru+FlO2NXMV0jrkNCbK7iiC4wwbei2gwxVjVLVdeaIlu64BeNLRHNskMdjZ4IKCGH
         RZm3Yapso6JOJSyQl9vuO5BT87Tpq60EJwBYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qPDI4CWJjC5/5bz94R850+eMWjiIMaPpEB5QatbHqs=;
        b=IBkyjBNoB9iprW+wSO91FqNsh7kR/O4pURAR0rh0HjrBJIyplAZ6ocQUYjBcvKnZeR
         m9BJcm3udnvMBZrPQWixEs+hrQRJooWoMXm4mkcy8xJvRaingzEoQwlLZOK571tfBGc+
         k+P9Qezk/rfJR54GqEqWKWyU1L89F2WNd1IXrZM1zQvfwDpd4Um1wWnpYwVVYMZ0koUV
         Oddla1Za6CT3H0i//x1764oj5N/twCX5WMcGgKbnRup3nT12XHIwdDExGcum3OqdHDH2
         7UxlZjgwx3TJhQrKpjzY9J3kCureYtWK9jAZpzkf6uIlJ1AdPyB6PaodadeVJ83n+1Ve
         6VFw==
X-Gm-Message-State: APjAAAUVSeNMJzSD1JAQGBq8cFHRupS25uEoAcdeygNHQE9bVhvT+eFn
        GHD4H4YyYFBy8SVH/iDMSKrMPpldhkc=
X-Google-Smtp-Source: APXvYqx/sW0H4a+GtHDaGPBChzY6brbZ6TGKwF99RTWvzTZISBdQ0OtBq7FfvhGdkIV/bGz28qI8Hw==
X-Received: by 2002:ac2:5605:: with SMTP id v5mr3088853lfd.136.1576085860017;
        Wed, 11 Dec 2019 09:37:40 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h19sm1532692ljl.57.2019.12.11.09.37.38
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 09:37:38 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id m6so25044189ljc.1
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 09:37:38 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr3004616ljg.133.1576085858434;
 Wed, 11 Dec 2019 09:37:38 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk>
In-Reply-To: <20191211152943.2933-1-axboe@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 09:37:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
Message-ID: <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Dave Chinner <david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 11, 2019 at 7:29 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Comments appreciated! This should work on any standard file system,
> using either the generic helpers or iomap. I have tested ext4 and xfs
> for the right read/write behavior, but no further validation has been
> done yet. Patches are against current git, and can also be found here:

I don't think this is conceptually wrong, but the implementation smells a bit.

I commented on the trivial part (the horrendous argument list to
iomap_actor), but I wonder how much of the explicit invalidation is
actually needed?

Because active invalidation really is a horrible horrible thing to do.
It immediately means that you can't use this interface for normal
everyday things that may actually cache perfectly fine.

What happens if you simply never _activate_ the page? Then they should
get invalidated on their own, without impacting any other load - but
only when there is _some_ memory pressure. They'll just stay on the
inactive lru list, and get re-used quickly.

Note that there are two ways to activate a page: the "accessed while
on the inactive list" will activate it, but these days we also have a
"pre-activate" path in the workingset code (see workingset_refault()).

Even if you might also want an explicit invalidate path, I would like
to hear what it looks like if you instead of - or in addition to -
invalidating, have a "don't activate" flag.

We don't have all _that_ many places where we activate pages, and they
should be easy to find (just grep for "SetPageActive()"), although the
call chain may make it a bit painful to add a "don't do it for this
access" kind of things.

But I think most of the regular IO call chains come through
"mark_page_accessed()". So _that_ is the part you want to avoid (and
maybe the workingset code). And that should be fairly straightforward,
I think.

In fact, that you say that just a pure random read case causes lots of
kswapd activity makes me think that maybe we've screwed up page
activation in general, and never noticed (because if you have enough
memory, you don't really see it that often)? So this might not be an
io_ring issue, but an issue in general.

                     Linus
