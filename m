Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34851 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbdIJRU3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Sep 2017 13:20:29 -0400
Received: by mail-pf0-f176.google.com with SMTP id g13so10934747pfm.2
        for <linux-block@vger.kernel.org>; Sun, 10 Sep 2017 10:20:29 -0700 (PDT)
Date: Sun, 10 Sep 2017 10:20:27 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V4 02/14] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170910172027.GA2579@vader>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-3-ming.lei@redhat.com>
 <20170908204341.GA13673@vader.DHCP.thefacebook.com>
 <20170909093812.GE26081@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170909093812.GE26081@ming.t460p>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Sep 09, 2017 at 05:38:13PM +0800, Ming Lei wrote:
> On Fri, Sep 08, 2017 at 01:43:41PM -0700, Omar Sandoval wrote:
> > On Sat, Sep 02, 2017 at 11:17:17PM +0800, Ming Lei wrote:
> > > We need to iterate ctx starting from any ctx in round robin
> > > way, so introduce this helper.
> > > 
> > > Cc: Omar Sandoval <osandov@fb.com>
> > 
> > A couple of comments below, once you address those you can add
> > 
> > Reviewed-by: Omar Sandoval <osandov@fb.com>
> > 
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >  include/linux/sbitmap.h | 54 ++++++++++++++++++++++++++++++++++++-------------
> > >  1 file changed, 40 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> > > index a1904aadbc45..2329b9e1a0e2 100644
> > > --- a/include/linux/sbitmap.h
> > > +++ b/include/linux/sbitmap.h
> > > @@ -211,10 +211,14 @@ bool sbitmap_any_bit_set(const struct sbitmap *sb);
> > >   */
> > >  bool sbitmap_any_bit_clear(const struct sbitmap *sb);
> > >  
> > > +#define SB_NR_TO_INDEX(sb, bitnr) ((bitnr) >> (sb)->shift)
> > > +#define SB_NR_TO_BIT(sb, bitnr) ((bitnr) & ((1U << (sb)->shift) - 1U))
> > > +
> > >  typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
> > >  
> > >  /**
> > >   * sbitmap_for_each_set() - Iterate over each set bit in a &struct sbitmap.
> > > + * @off: Where to start the iteration
> > >   * @sb: Bitmap to iterate over.
> > >   * @fn: Callback. Should return true to continue or false to break early.
> > >   * @data: Pointer to pass to callback.
> > > @@ -222,35 +226,57 @@ typedef bool (*sb_for_each_fn)(struct sbitmap *, unsigned int, void *);
> > >   * This is inline even though it's non-trivial so that the function calls to the
> > >   * callback will hopefully get optimized away.
> > >   */
> > > -static inline void sbitmap_for_each_set(struct sbitmap *sb, sb_for_each_fn fn,
> > > -					void *data)
> > > +static inline void __sbitmap_for_each_set(struct sbitmap *sb,
> > > +					  unsigned int off,
> > > +					  sb_for_each_fn fn, void *data)
> > >  {
> > > -	unsigned int i;
> > > +	unsigned int index = SB_NR_TO_INDEX(sb, off);
> > > +	unsigned int nr = SB_NR_TO_BIT(sb, off);
> > > +	unsigned int scanned = 0;
> > >  
> > > -	for (i = 0; i < sb->map_nr; i++) {
> > > -		struct sbitmap_word *word = &sb->map[i];
> > > -		unsigned int off, nr;
> > > +	while (1) {
> > > +		struct sbitmap_word *word = &sb->map[index];
> > > +		unsigned int depth = min_t(unsigned int, word->depth - nr,
> > > +					   sb->depth - scanned);
> > >  
> > > +		scanned += depth;
> > >  		if (!word->word)
> > > -			continue;
> > > +			goto next;
> > >  
> > > -		nr = 0;
> > > -		off = i << sb->shift;
> > > +		depth += nr;
> > 
> > I had to think hard to convince myself this was right. If above we set
> > depth to (sb->depth - scanned), then we must have already looped at
> 
> It should be so only in the last loop, in which the 1st half of
> the word is to be checked because we start from the 2nd half of
> the same word.
> 
> > least once, so nr must be 0, therefore this is okay. Am I following this
> > correctly? I think reassigning like so would be more clear:
> 
> Yes, you are right, nr can be non-zero only in the 1st loop.
> 
> > 
> > 		depth = min_t(unsigned int, word->depth, sb->depth - scanned);
> 
> If nr isn't zero, the depth to be scanned should be 'word->depth - nr'
> in the 1st loop, so the above way can't cover this case.

What I mean is that you keep the same initialization above, but instead of
		depth += nr
you do
		depth = min_t(unsigned int, word->depth, sb->depth - scanned);
because like I said, the reasoning about why `+= nr` is okay in the
`sb->depth - scanned` case is subtle.

And maybe even replace the
		scanned += depth;
with
		scanned += min_t(unsigned int, word->depth - nr,
	   			 sb->depth - scanned);
I.e., don't reuse the depth local variable for two different things. I'm
nitpicking here but this code is tricky enough as it is.

For completeness, I mean this exactly:

	while (1) {
		struct sbitmap_word *word = &sb->map[index];
		unsigned int depth;

		scanned += min_t(unsigned int, word->depth - nr,
				 sb->depth - scanned);
		if (!word->word)
			goto next;

		depth = min_t(unsigned int, word->depth, sb->depth - scanned);
		off = index << sb->shift;
		while (1) {
			nr = find_next_bit(&word->word, depth, nr);
			if (nr >= depth)
				break;

			if (!fn(sb, off + nr, data))
				return;

			nr++;
		}
next:
		if (scanned >= sb->depth)
			break;
		nr = 0;
		if (++index >= sb->map_nr)
			index = 0;
	}
