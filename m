Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54738 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbdINB5Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2017 21:57:24 -0400
Date: Thu, 14 Sep 2017 09:56:56 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Laurence Oberman <loberman@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH V4 02/14] sbitmap: introduce __sbitmap_for_each_set()
Message-ID: <20170914015647.GA2258@ming.t460p>
References: <20170902151729.6162-1-ming.lei@redhat.com>
 <20170902151729.6162-3-ming.lei@redhat.com>
 <20170908204341.GA13673@vader.DHCP.thefacebook.com>
 <20170909093812.GE26081@ming.t460p>
 <20170910172027.GA2579@vader>
 <20170911040827.GB27079@ming.t460p>
 <20170913183720.GB30473@vader>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170913183720.GB30473@vader>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 13, 2017 at 11:37:20AM -0700, Omar Sandoval wrote:
> On Mon, Sep 11, 2017 at 12:08:29PM +0800, Ming Lei wrote:
> > On Sun, Sep 10, 2017 at 10:20:27AM -0700, Omar Sandoval wrote:
> 
> [snip]
> 
> > > What I mean is that you keep the same initialization above, but instead of
> > > 		depth += nr
> > > you do
> > > 		depth = min_t(unsigned int, word->depth, sb->depth - scanned);
> > > because like I said, the reasoning about why `+= nr` is okay in the
> > > `sb->depth - scanned` case is subtle.
> > > 
> > > And maybe even replace the
> > > 		scanned += depth;
> > > with
> > > 		scanned += min_t(unsigned int, word->depth - nr,
> > > 	   			 sb->depth - scanned);
> > > I.e., don't reuse the depth local variable for two different things. I'm
> > > nitpicking here but this code is tricky enough as it is.
> > 
> > It wasn't reused in old version, just for saving one local variable, and
> > one extra min_t().
> > 
> > Yeah, I admit it isn't clean enough.
> > 
> > > 
> > > For completeness, I mean this exactly:
> > > 
> > > 	while (1) {
> > > 		struct sbitmap_word *word = &sb->map[index];
> > > 		unsigned int depth;
> > > 
> > > 		scanned += min_t(unsigned int, word->depth - nr,
> > > 				 sb->depth - scanned);
> > > 		if (!word->word)
> > > 			goto next;
> > > 
> > > 		depth = min_t(unsigned int, word->depth, sb->depth - scanned);
> > 
> > two min_t and a little code duplication.
> 
> They're similar but they represent different things, so I think trying
> to deduplicate this code just makes it more confusing. If performance is
> your concern, I'd be really surprised if there's a noticable difference.

No only one extra min_t(), also it isn't easy to read the code, since
only in the first scan that 'depth' isn't same with 'depth', that is
why I set the 1st 'scan' outside of the loop, then we can update 'scan'
with 'depth' in every loop. People will be easy to follow the
meaning.

> 
> As a side note, I also realized that this code doesn't handle the
> sb->depth == 0 case. We should change the while (1) to
> while (scanned < sb->depth) and remove the
> if (scanned >= sb->depth) break;

In the attached patch, I remember that the zero depth case is
addressed by:

	if (start >= sb->depth)
		return;

which is required since 'start' parameter is introduced in
this patch.

> 
> > > 		off = index << sb->shift;
> > > 		while (1) {
> > > 			nr = find_next_bit(&word->word, depth, nr);
> > > 			if (nr >= depth)
> > > 				break;
> > > 
> > > 			if (!fn(sb, off + nr, data))
> > > 				return;
> > > 
> > > 			nr++;
> > > 		}
> > > next:
> > > 		if (scanned >= sb->depth)
> > > 			break;
> > > 		nr = 0;
> > > 		if (++index >= sb->map_nr)
> > > 			index = 0;
> > > 	}
> > 
> > The following patch switches to do{}while and handles the
> > 1st scan outside of the loop, then it should be clean
> > enough(no two min_t()), so how about this one?
> 
> I find this one subtler and harder to follow. The less it looks like the
> typical loop pattern, the longer someone reading the code has to reason
> about it.

Looks using 'depth' to update 'scanned' is easier to follow, than
two min_t(), since it will make people easy to understand the relation
between the two, then understand the whole code.

-- 
Ming
