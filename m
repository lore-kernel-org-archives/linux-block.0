Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34725 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750772AbcISPlZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Sep 2016 11:41:25 -0400
Received: by mail-pf0-f182.google.com with SMTP id p64so52144313pfb.1
        for <linux-block@vger.kernel.org>; Mon, 19 Sep 2016 08:41:24 -0700 (PDT)
Date: Mon, 19 Sep 2016 08:41:23 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>, Omar Sandoval <osandov@fb.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbitmap: avoid maybe-uninitialized warning
Message-ID: <20160919154123.GA5193@vader>
References: <20160919123359.1225305-1-arnd@arndb.de>
 <6efcc3e0-b85f-9612-2562-d37922a1dc92@kernel.dk>
 <2163656.5SLNssdXj1@wuerfel>
 <940657ab-4092-cebd-127e-6628adcf96b5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <940657ab-4092-cebd-127e-6628adcf96b5@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Sep 19, 2016 at 09:22:34AM -0600, Jens Axboe wrote:
> On 09/19/2016 09:14 AM, Arnd Bergmann wrote:
> > On Monday, September 19, 2016 8:43:12 AM CEST Jens Axboe wrote:
> > > On 09/19/2016 06:33 AM, Arnd Bergmann wrote:
> > > > The sbitmap code that has just been turned into a library module
> > > > returns uninitialized data for sbitmap_weight(), as pointed out by
> > > > gcc when building with -Wmaybe-uninitialized:
> > > > 
> > > > lib/sbitmap.c: In function 'sbitmap_weight':
> > > > lib/sbitmap.c:179:9: error: 'weight' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> > > > 
> > > > Note that the value is never initialized, we just add data on
> > > > top, so it is wrong regardless of sb->map_nr.
> > > > 
> > > > This adds the missing initialization.
> > > 
> > > Thanks Arnd, Colin sent the same patch and I applied it. Note that:
> > 
> > Ok, thanks!
> > 
> > > > Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
> > > 
> > > that isn't truly correct, that patch is just what moved the code. The
> > > bug predates that commit.
> > 
> > It's not important as long as the bug is fixed now, but I think it was
> > correct before that move, we just lost the 'used=0' initialization,
> > which also triggered the warning:
> > 
> > -static unsigned int bt_unused_tags(struct blk_mq_bitmap_tags *bt)
> > -{
> > -       unsigned int i, used;
> > -
> > -       for (i = 0, used = 0; i < bt->map_nr; i++) {
> > -               struct blk_align_bitmap *bm = &bt->map[i];
> > -
> > -               used += bitmap_weight(&bm->word, bm->depth);
> >         }
> > 
> > -       return bt->depth - used;
> >  }
> 
> I missed that, as I generally never use double inits in for loops, but I
> guess I did for this one. But you are right, the bug was introduced with
> the recent move, so your Fixes was completely correct.
> 
> Omar loses a cookie.

:(

Apparently we disable -Wmaybe-uninitialized by default since
6e8d666e9253 ("Disable "maybe-uninitialized" warning globally"), that's
probably why I didn't see this. My mistake, thanks Arnd and Colin.

-- 
Omar
