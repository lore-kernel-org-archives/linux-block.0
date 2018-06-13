Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935691AbeFMOrr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jun 2018 10:47:47 -0400
Date: Wed, 13 Jun 2018 07:47:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        David Sterba <dsterba@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Coly Li <colyli@suse.de>, Filipe Manana <fdmanana@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH V6 12/30] block: introduce bio_chunks()
Message-ID: <20180613144741.GC4693@infradead.org>
References: <20180609123014.8861-1-ming.lei@redhat.com>
 <20180609123014.8861-13-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180609123014.8861-13-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> +static inline unsigned bio_chunks(struct bio *bio)
> +{
> +	unsigned chunks = 0;
> +	struct bio_vec bv;
> +	struct bvec_iter iter;
>  
> -	return segs;
> +	/*
> +	 * We special case discard/write same/write zeroes, because they
> +	 * interpret bi_size differently:
> +	 */
> +	switch (bio_op(bio)) {
> +	case REQ_OP_DISCARD:
> +	case REQ_OP_SECURE_ERASE:
> +	case REQ_OP_WRITE_ZEROES:
> +		return 0;
> +	case REQ_OP_WRITE_SAME:
> +		return 1;
> +	default:
> +		bio_for_each_chunk(bv, bio, iter)
> +			chunks++;
> +		return chunks;

Shouldn't this just return bio->bi_vcnt?
