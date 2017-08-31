Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750814AbdHaDdz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 23:33:55 -0400
Date: Thu, 31 Aug 2017 11:33:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "osandov@fb.com" <osandov@fb.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "loberman@redhat.com" <loberman@redhat.com>
Subject: Re: [PATCH V3 02/14] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170831033339.GC12246@ming.t460p>
References: <20170826163332.28971-1-ming.lei@redhat.com>
 <20170826163332.28971-3-ming.lei@redhat.com>
 <1504108512.2526.23.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504108512.2526.23.camel@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Aug 30, 2017 at 03:55:13PM +0000, Bart Van Assche wrote:
> On Sun, 2017-08-27 at 00:33 +0800, Ming Lei wrote:
> >  /**
> >   * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
> > + * @start: Where to start the iteration
> 
> Thanks for having changed the name of this argument ...
> 
> > -static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
> > -					void *data)
> > +static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> > +					  unsigned int start,
> > +					  sb_for_each_fn fn, void *data)
> >  {
> > -	unsigned int i;
> > +	unsigned int index = SB_NR_TO_INDEX(sb, start);
> > +	unsigned int nr = SB_NR_TO_BIT(sb, start);
> > +	unsigned int scanned = 0;
> 
> ... but I'm still missing a check here whether or not index >= sb->map_nr.

The reason I didn't do that is because the only one user is always to
pass correct 'start'.

OK, will add it.

>  
> > -	for (i = 0; i < sb->map_nr; i++) {
> > -		struct sbitmap_word *word = &sb->map[i];
> > -		unsigned int off, nr;
> > +	while (1) {
> > +		struct sbitmap_word *word = &sb->map[index];
> > +		unsigned int depth = min_t(unsigned int, word->depth - nr,
> > +					   sb->depth - scanned);
> >  
> > +		scanned += depth;
> >  		if (!word->word)
> > -			continue;
> > +			goto next;
> >  
> > -		nr = 0;
> > -		off = i << sb->shift;
> > +		depth += nr;
> > +		start = index << sb->shift;
> 
> The above statement reuses the argument 'start' for a new purpose. This is
> confusing - please don't do this. Why not to keep the name 'off'? That will
> keep the changes minimal.

OK, that will rename the parameter of 'start' as 'off', so that we can
save one local variable.

-- 
Ming
