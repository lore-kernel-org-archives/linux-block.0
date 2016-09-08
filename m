Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35170 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753402AbcIHSQn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2016 14:16:43 -0400
Received: by mail-pf0-f174.google.com with SMTP id w87so20570297pfk.2
        for <linux-block@vger.kernel.org>; Thu, 08 Sep 2016 11:16:42 -0700 (PDT)
Date: Thu, 8 Sep 2016 11:16:40 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>
Cc: Alexei Starovoitov <ast@fb.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/5] blk-mq: abstract tag allocation out into
 scale_bitmap library
Message-ID: <20160908181640.GA30638@vader.DHCP.thefacebook.com>
References: <cover.1473291702.git.osandov@fb.com>
 <de3d08bb7b2a2f20bd456112b97a9ab2fe6f1573.1473291702.git.osandov@fb.com>
 <57D0AA74.5010000@fb.com>
 <20160908003859.GA31704@vader>
 <57D0BB13.30905@fb.com>
 <bee33eb9-9a92-c36c-ee0b-277a0263363c@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bee33eb9-9a92-c36c-ee0b-277a0263363c@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 08, 2016 at 10:11:58AM -0600, Jens Axboe wrote:
> On 09/07/2016 07:12 PM, Alexei Starovoitov wrote:
> > On 9/7/16 5:38 PM, Omar Sandoval wrote:
> > > On Wed, Sep 07, 2016 at 05:01:56PM -0700, Alexei Starovoitov wrote:
> > > > On 9/7/16 4:46 PM, Omar Sandoval wrote:
> > > > > From: Omar Sandoval <osandov@fb.com>
> > > > > 
> > > > > This is a generally useful data structure, so make it available to
> > > > > anyone else who might want to use it. It's also a nice cleanup
> > > > > separating the allocation logic from the rest of the tag handling
> > > > > logic.
> > > > > 
> > > > > The code is behind a new Kconfig option, CONFIG_SCALE_BITMAP, which is
> > > > > only selected by CONFIG_BLOCK for now.
> > > > > 
> > > > > This should be a complete noop functionality-wise.
> > > > > 
> > > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > > ---
> > > > >    MAINTAINERS                  |   1 +
> > > > >    block/Kconfig                |   1 +
> > > > >    block/blk-mq-tag.c           | 469
> > > > > ++++++++++---------------------------------
> > > > >    block/blk-mq-tag.h           |  37 +---
> > > > >    block/blk-mq.c               | 113 +++--------
> > > > >    block/blk-mq.h               |   9 -
> > > > >    include/linux/blk-mq.h       |   9 +-
> > > > >    include/linux/scale_bitmap.h | 340 +++++++++++++++++++++++++++++++
> > > > >    lib/Kconfig                  |   3 +
> > > > >    lib/Makefile                 |   2 +
> > > > >    lib/scale_bitmap.c           | 305 ++++++++++++++++++++++++++++
> > > > ...
> > > > > diff --git a/include/linux/scale_bitmap.h
> > > > > b/include/linux/scale_bitmap.h
> > > > > new file mode 100644
> > > > > index 0000000..63f712b
> > > > > --- /dev/null
> > > > > +++ b/include/linux/scale_bitmap.h
> > > > > @@ -0,0 +1,340 @@
> > > > > +/*
> > > > > + * Fast and scalable bitmaps.
> > > > ...
> > > > > +/**
> > > > > + * struct scale_bitmap_word - Word in a &struct scale_bitmap.
> > > > > + */
> > > > > +struct scale_bitmap_word {
> > > > > +/**
> > > > > + * struct scale_bitmap - Scalable bitmap.
> > > > > + *
> > > > > + * A &struct scale_bitmap is spread over multiple cachelines to
> > > > > avoid ping-pong.
> > > > > + * This trades off higher memory usage for better scalability.
> > > > > + */
> > > > > +struct scale_bitmap {
> > > > 
> > > > scale_bitmap sounds odd, since 'scale' is also a verb.
> > > > We also have lib/rhashtable.c:
> > > >   * Resizable, Scalable, Concurrent Hash Table
> > > > everything is 'scalable' nowadays.
> > > 
> > > Agreed, I'm not a huge fan of the name.
> > > 
> > > > May be resizable bitmap would be a better name?
> > > > 'struct rbitmap'... lib/rbitmap.c ?
> > > > 
> > > 
> > > Hm, the resizing operation isn't very well thought-out right now, it's
> > > there because it's okay for the way blk-mq uses it, but it's definitely
> > > not the point of the data structure. It's more of a cache-friendly
> > > bitmap, or a sparse bitmap. `struct sbitmap`? `struct cbitmap`?
> > 
> > yeah. naming is hard.
> > I think the name ideally should indicate how this bitmap
> > is different from array of bits that is already covered by
> > primitives in bitmap.h
> > Is it because the user can wait on the bit or because it's
> > smp aware? sort of percpu? I think that's the main trick how
> > it achieves good concurrent set/get access, right?
> > struct pcpu_bitmap ?
> > struct sbitmap is fine too.
> 
> It's not a true percpu bitmap. Rather it's a sparse bitmap, that
> provides some nice cache behavior through the nature of the sparseness.
> The percpu hinting helps with that. sbitmap might work, S for scale
> and/or sparse.
> 
> No name is going to convey what is special about it, but luckily Omar
> did a great job documenting it while pulling it out of blk-mq-tag. So
> I'm fine with just calling it sbitmap. I'll be pronouncing it like
> "spitmap".

"spitmap" it is :) I'll also do scale_bitmap_queue -> sbitmap_queue
unless anyone has a better idea.

-- 
Omar
