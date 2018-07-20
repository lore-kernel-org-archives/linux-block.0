Return-Path: <hch@lst.de>
Date: Fri, 20 Jul 2018 17:11:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.com>,
	Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v4 3/4] block: add bio_iov_iter_get_all_pages() helper
Message-ID: <20180720151146.GB17322@lst.de>
References: <20180720130552.21432-1-mwilck@suse.com> <20180720130552.21432-4-mwilck@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180720130552.21432-4-mwilck@suse.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Jul 20, 2018 at 03:05:51PM +0200, Martin Wilck wrote:
> bio_iov_iter_get_pages() only adds pages for the next non-zero
> segment from the iov_iter to the bio. Some callers prefer to
> obtain as many pages as would fit into the bio, with proper
> rollback in case of failure. Add bio_iov_iter_get_all_pages()
> for this purpose.

I'd much rather have you fix bio_iov_iter_get_pages.  It only has
three callers, all beeing slight variations of the same direct I/O
pattern.  There is no point in diverging in implementation details
for them.

> +	do {
> +		int ret = bio_iov_iter_get_pages(bio, iter);
> +
> +		if (unlikely(ret)) {
> +			struct bio_vec *bvec;
> +			unsigned short i;
> +
> +			bio_for_each_segment_all(bvec, bio, i) {
> +				if (i >= orig_vcnt) {
> +					put_page(bvec->bv_page);
> +					bvec->bv_page = NULL;
> +					bvec->bv_len = 0;
> +					bvec->bv_offset = 0;
> +				}
> +			}

I don't think we need any of the zeroing here.   Also for code flow
purposes I'd rather see a goto for the error handling here.
