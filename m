Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19EC2D0C6
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 19:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F65206C3
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 19:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576091718;
	bh=YO4QNve8tgPgMQhk2yTyorPpFpqk5lih6eM7fZNhjPM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Is1wQ6BnXhG9I5oyA8FAVSlzPJC/Byhf4blS1sqeKGiDt1lGaMXcJpLXwgp/RSqns
	 BzQLaJEdCwFQS7duzqkrNeZj/W3f3QGh6bb7l9MdQpREYF+V/E9JWO1GvBytiFIs5q
	 jVVB2uohCNWrINWo+L2kHS6sJPjwaXBWMzU1/R4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfLKTPS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:15:18 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43610 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfLKTPR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 14:15:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so25336005ljm.10
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 11:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOD7R27AsduJWVvdOr2UIanUZawLN4t/gENPDoXyCKs=;
        b=VdTfqGW9GvpFK5GEtZfMWoXvDM0CVFcRYBxvTgJD7+rU2yW/orFNa/DB6iVh91TX0t
         aDxZ9K5e9xBP74CjsXLZ6j+btdY5WwxvIgcQ3P7lR8WRNwUHrI70uAyCgm82AEi4TdHY
         GbH2oENsGX414IFAn8/pU1MmiER9PTwnReX7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOD7R27AsduJWVvdOr2UIanUZawLN4t/gENPDoXyCKs=;
        b=PM1eZThl5LG0XmdRNGMGHMX4Fv6wMIOmAyBoGiZdeSWSzx3mmcwkGWQ/xvrclaHBre
         eKdgD7J5OgqVjEp6ymnBJEYv9kPR6O4h2hPaiiaNZX8hMD+ZIzqj0cwfllMGYpVAM6LV
         24lUyjWqvsTUCu6lvDDtOXpxZmzwBujuiMOwMLwZh9yj0lF8s38hc/9un/ZjCwF0QTBn
         gZg8tUelnJ/wf9IzhIDUGtrm4jbnyZWhD9N9inROUJJP0p6fuEJPTEGm6tkZxjpRFJCs
         9QuBhkU3/3LDny61262L7hNzkDhftCs8Br4Ra5cMbv6FCW13tA3weBHtmJto2nyZv+Ex
         XFOw==
X-Gm-Message-State: APjAAAWaWMzEibEWneUW5gGc2izG4Z8uDPaZPS+u1qxCt48yHrUfpuA5
        vCy9JdId2ojwWm/Wl4kmYgcFRS//xHA=
X-Google-Smtp-Source: APXvYqzOHN7CCEOSTefnQkL0oyhCeqlrnq4tv72qqHI4hcdU0Quls0BtjsQFX1b2Yd1CxPA9IQ/VEw==
X-Received: by 2002:a2e:144b:: with SMTP id 11mr3337876lju.216.1576091714541;
        Wed, 11 Dec 2019 11:15:14 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id g6sm1697494lja.10.2019.12.11.11.15.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 11:15:13 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id e10so25329434ljj.6
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 11:15:13 -0800 (PST)
X-Received: by 2002:a2e:9041:: with SMTP id n1mr3339710ljg.133.1576091712754;
 Wed, 11 Dec 2019 11:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20191211152943.2933-1-axboe@kernel.dk> <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
In-Reply-To: <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Dec 2019 11:14:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh_YwvNNikQ9yh7oqG5hyJE9tw+bXFft-mOQJ0n_v+a7g@mail.gmail.com>
Message-ID: <CAHk-=wh_YwvNNikQ9yh7oqG5hyJE9tw+bXFft-mOQJ0n_v+a7g@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>
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

[ Adding Johannes Weiner to the cc, I think he's looked at the working
set and the inactive/active LRU lists the most ]

On Wed, Dec 11, 2019 at 9:56 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> > In fact, that you say that just a pure random read case causes lots of
> > kswapd activity makes me think that maybe we've screwed up page
> > activation in general, and never noticed (because if you have enough
> > memory, you don't really see it that often)? So this might not be an
> > io_ring issue, but an issue in general.
>
> This is very much not an io_uring issue, you can see exactly the same
> kind of behavior with normal buffered reads or mmap'ed IO. I do wonder
> if streamed reads are as bad in terms of making kswapd go crazy, I
> forget if I tested that explicitly as well.

We definitely used to have people test things like "read the same
much-bigger-than-memory file over and over", and it wasn't supposed to
be all _that_ painful, because the pages never activated, and they got
moved out of the cache quickly and didn't disturb other activities
(other than the constant IO, of course, which can be a big deal in
itself).

But maybe that was just the streaming case. With read-around and
random accesses, maybe we end up activating too much (and maybe we
always did).

But I wouldn't be surprised if we've lost that as people went from
having 16-32MB to having that many GB instead - simply because a lot
of loads are basically entirely cached, and the few things that are
not tend to be explicitly uncached (ie O_DIRECT etc).

I think the workingset changes actually were maybe kind of related to
this - the inactive list can become too small to ever give people time
to do a good job of picking the _right_ thing to activate.

So this might either be the reverse situation - maybe we let the
inactive list grow too large, and then even a big random load will
activate pages that really shouldn't be activated? Or it might be
related to the workingset issue in that we've activated pages too
eagerly and not ever moved things back to the inactive list (which
then in some situations causes the inactive list to be very small).

Who knows. But this is definitely an area that I suspect hasn't gotten
all that much attention simply because memory has become much more
plentiful, and a lot of regular loads basically have enough memory
that almost all IO is cached anyway, and the old "you needed to be
more clever about balancing swap/inactive/active even under normal
loads" thing may have gone away a bit.

These days, even if you do somewhat badly in that balancing act, a lot
of loads probably won't notice that much. Either there is still so
much memory for caching that the added IO isn't really ever dominant,
or you had such a big load to begin with that it was long since
rewritten to use O_DIRECT.

            Linus
