Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHXD6A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Aug 2017 23:58:00 -0400
Date: Thu, 24 Aug 2017 11:57:44 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V2 02/20] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170824035743.GA12966@ming.t460p>
References: <20170805065705.12989-1-ming.lei@redhat.com>
 <20170805065705.12989-3-ming.lei@redhat.com>
 <1503426533.2508.6.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503426533.2508.6.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Aug 22, 2017 at 06:28:54PM +0000, Bart Van Assche wrote:
> On Sat, 2017-08-05 at 14:56 +0800, Ming Lei wrote:
> > /**
> >   * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
> > + * @off: Offset to iterate from
> >   * @sb: Bitmap to iterate over.
> >   * @fn: Callback. Should return true to continue or false to break early.
> >   * @data: Pointer to pass to callback.
> 
> Using 'off' as the name for the new argument seems confusing to me since that
> argument starts from zero and is not an offset relative to anything. Please
> consider to use 'start' as the name for this argument.

OK

> 
> > -static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
> > -					void *data)
> > +static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> > +					  unsigned int off,
> > +					  sb_for_each_fn fn, void *data)
> >  {
> > -	unsigned int i;
> > +	unsigned int index = SB_NR_TO_INDEX(sb, off);
> 
> Is it really useful to rename 'i' into 'index'? I think that change makes this
> patch harder to read than necessary.

All local variable is named as 'index' in lib/sbitmap.c
if it is initialized as SB_NR_TO_INDEX().

> 
> > +	unsigned int nr = SB_NR_TO_BIT(sb, off);
> > +	unsigned int scanned = 0;
> >  
> > -	for (i = 0; i < sb->map_nr; i++) {
> > -		struct sbitmap_word *word = &sb->map[i];
> > -		unsigned int off, nr;
> > +	while (1) {
> 
> Sorry but this change looks incorrect to me. I think the following two tests
> have to be performed before the while loop starts to avoid triggering an
> out-of-bounds reference of sb->map[]:
> * Whether or not sb->map_nr is zero.

That won't happen, please see sbitmap_init_node().

> * Whether or not index >= sb->map_nr. I propose to start iterating from the
>   start of @sb in this case.

It has been checked at the end of the loop.

> 
> Additionally, the new loop in __sbitmap_for_each_set() looks more complicated
> and more fragile to me than necessary. How about using the code below? That

Why is it fragile? With the 'scanned' variable, it is guaranteed
that all bit can be iterated just once.

> code needs one local variable less than your implementation.

The local variable of 'start' can be removed too in the orignal
patch, will do that in V3.

> 
> static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> 					  const unsigned int start,
> 					  sb_for_each_fn fn, void *data)
> {
> 	unsigned int i = start >> sb->shift;
> 	unsigned int nr = start & ((1 << sb->shift) - 1);
> 	bool cycled = false;
> 
> 	if (!sb->map_nr)
> 		return;

We don't have zero depth yet, so no zero sb->map_nr.

> 
> 	if (unlikely(i >= sb->map_nr)) {
> 		i = 0;
> 		nr = 0;

This check isn't necessary at least now.

> 	}
> 
> 	while (true) {
> 		struct sbitmap_word *word = &sb->map[i];
> 		unsigned int off;

Looks you removed the check on 'word->word'.

> 
> 		off = i << sb->shift;
> 		while (1) {
> 			nr = find_next_bit(&word->word, word->depth, nr);

If we start from middle of one word, the last search shouldn't touch
the part which is scanned already. This way can't guarantee that point.

> 			if (cycled && off + nr >= start)
> 				return;

If 'map_nr' is 1 and start is zero, cycled is still false, so we should
return here but not, then every time we have to search one extra time
for this case.

> 
> 			if (nr >= word->depth)
> 				break;
> 
> 			if (!fn(sb, off + nr, data))
> 				return;
> 
> 			nr++;
> 		}
> 		if (++i >= sb->map_nr) {
> 			cycled = true;
> 			i = 0;
> 		}
> 		nr = 0;
> 	}
> }
> 
> Thanks,
> 
> Bart.

Given sbitmap is a global map, and the original patch can guarantee
to iterate each bit just once strictly, I suggest to take the
original way first.

-- 
Ming
