Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39381 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935694AbeFMO51 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 10:57:27 -0400
Date: Wed, 13 Jun 2018 10:57:22 -0400
From: Kent Overstreet <kent.overstreet@gmail.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 12/30] block: introduce bio_chunks()
Message-ID: <20180613145722.GA17340@kmo-pixel>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-13-ming.lei@redhat.com>
 <20180613144741.GC4693@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180613144741.GC4693@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Jun 13, 2018 at 07:47:41AM -0700, Christoph Hellwig wrote:
> > +static inline unsigned bio_chunks(struct bio *bio)
> > +{
> > +	unsigned chunks = 0;
> > +	struct bio_vec bv;
> > +	struct bvec_iter iter;
> >  
> > -	return segs;
> > +	/*
> > +	 * We special case discard/write same/write zeroes, because they
> > +	 * interpret bi_size differently:
> > +	 */
> > +	switch (bio_op(bio)) {
> > +	case REQ_OP_DISCARD:
> > +	case REQ_OP_SECURE_ERASE:
> > +	case REQ_OP_WRITE_ZEROES:
> > +		return 0;
> > +	case REQ_OP_WRITE_SAME:
> > +		return 1;
> > +	default:
> > +		bio_for_each_chunk(bv, bio, iter)
> > +			chunks++;
> > +		return chunks;
> 
> Shouldn't this just return bio->bi_vcnt?

No.

bio->bi_vcnt is only for the owner of a bio (the code that originally allocated
it and filled it out) to use, and really the only legit use is
bio_for_each_segment_all() (iterating over segments without using bi_iter
because it's already been iterated to the end), and as a convenience thing for
bio_add_page.

Code that has a bio submitted to it can _not_ use bio->bi_vcnt, it's perfectly
legal for it to be 0 (and it is for e.g. bio splits).
