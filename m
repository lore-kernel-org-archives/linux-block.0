Return-Path: <BATV+148dcdbe689cdec89501+4740+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 15 Aug 2016 11:23:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@canonical.com>
Cc: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Eric Wheeler <bcache@lists.ewheeler.net>,
	Sebastian Roesner <sroesner-kernelorg@roesner-online.de>,
	"4.3+" <stable@vger.kernel.org>, Shaohua Li <shli@fb.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] block: make sure big bio is splitted into at most 256
 bvecs
Message-ID: <20160815182328.GA13886@infradead.org>
References: <1471273882-3938-1-git-send-email-ming.lei@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1471273882-3938-1-git-send-email-ming.lei@canonical.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Aug 15, 2016 at 11:11:22PM +0800, Ming Lei wrote:
> After arbitrary bio size is supported, the incoming bio may
> be very big. We have to split the bio into small bios so that
> each holds at most BIO_MAX_PAGES bvecs for safety reason, such
> as bio_clone().

I still think working around a rough driver submitting too large
I/O is a bad thing until we've done a full audit of all consuming
bios through ->make_request, and we've enabled it for the common
path as well.

>  	bool do_split = true;
>  	struct bio *new = NULL;
>  	const unsigned max_sectors = get_max_io_size(q, bio);
> +	unsigned bvecs = 0;
> +
> +	*no_merge = true;
>  
>  	bio_for_each_segment(bv, bio, iter) {
>  		/*
> +		 * With arbitrary bio size, the incoming bio may be very
> +		 * big. We have to split the bio into small bios so that
> +		 * each holds at most BIO_MAX_PAGES bvecs because
> +		 * bio_clone() can fail to allocate big bvecs.
> +		 *
> +		 * It should have been better to apply the limit per
> +		 * request queue in which bio_clone() is involved,
> +		 * instead of globally. The biggest blocker is
> +		 * bio_clone() in bio bounce.
> +		 *
> +		 * If bio is splitted by this reason, we should allow
> +		 * to continue bios merging.
> +		 *
> +		 * TODO: deal with bio bounce's bio_clone() gracefully
> +		 * and convert the global limit into per-queue limit.
> +		 */
> +		if (bvecs++ >= BIO_MAX_PAGES) {
> +			*no_merge = false;
> +			goto split;
> +		}

That being said this simple if check here is simple enough that it's
probably fine.  But I see no need to uglify the whole code path
with that no_merge flag.  Please drop if for now, and if we start
caring for this path in common code we should just move the
REQ_NOMERGE setting into the actual blk_bio_*_split helpers.
