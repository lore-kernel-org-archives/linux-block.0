Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbitmap: avoid maybe-uninitialized warning
Date: Mon, 19 Sep 2016 17:14:48 +0200
Message-ID: <2163656.5SLNssdXj1@wuerfel>
In-Reply-To: <6efcc3e0-b85f-9612-2562-d37922a1dc92@kernel.dk>
References: <20160919123359.1225305-1-arnd@arndb.de> <6efcc3e0-b85f-9612-2562-d37922a1dc92@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

On Monday, September 19, 2016 8:43:12 AM CEST Jens Axboe wrote:
> On 09/19/2016 06:33 AM, Arnd Bergmann wrote:
> > The sbitmap code that has just been turned into a library module
> > returns uninitialized data for sbitmap_weight(), as pointed out by
> > gcc when building with -Wmaybe-uninitialized:
> >
> > lib/sbitmap.c: In function 'sbitmap_weight':
> > lib/sbitmap.c:179:9: error: 'weight' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >
> > Note that the value is never initialized, we just add data on
> > top, so it is wrong regardless of sb->map_nr.
> >
> > This adds the missing initialization.
> 
> Thanks Arnd, Colin sent the same patch and I applied it. Note that:

Ok, thanks!

> > Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
> 
> that isn't truly correct, that patch is just what moved the code. The 
> bug predates that commit.

It's not important as long as the bug is fixed now, but I think it was
correct before that move, we just lost the 'used=0' initialization,
which also triggered the warning:

-static unsigned int bt_unused_tags(struct blk_mq_bitmap_tags *bt)
-{
-       unsigned int i, used;
-
-       for (i = 0, used = 0; i < bt->map_nr; i++) {
-               struct blk_align_bitmap *bm = &bt->map[i];
-
-               used += bitmap_weight(&bm->word, bm->depth);
        }
 
-       return bt->depth - used;
 }

	Arnd
