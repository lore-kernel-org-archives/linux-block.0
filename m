Return-Path: <BATV+5a9af4245aa9ea14ad45+4813+infradead.org+hch@bombadil.srs.infradead.org>
Date: Wed, 26 Oct 2016 23:37:17 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	jack@suse.cz, kernel@kolivas.org
Subject: Re: [PATCH 1/8] block: add WRITE_BG
Message-ID: <20161027063717.GA1165@infradead.org>
References: <1477515135-16469-1-git-send-email-axboe@fb.com>
 <1477515135-16469-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1477515135-16469-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

>   *			non-volatile media on completion.
> + * WRITE_BG		Background write. This is for background activity like
> + *			the periodic flush and background threshold writeback
>   *
>   */
>  #define RW_MASK			REQ_OP_WRITE
> @@ -202,6 +204,7 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
>  #define WRITE_FLUSH		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH)
>  #define WRITE_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_FUA)
>  #define WRITE_FLUSH_FUA		(REQ_SYNC | REQ_NOIDLE | REQ_PREFLUSH | REQ_FUA)
> +#define WRITE_BG		(REQ_NOIDLE | REQ_BG)

I've been trying to kill off these WRITE_ flags as they aren't exactly
helpful, see my branch here that I'm waiting for the previous serious to
go in:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-flags

Which also begs the question why you add the REQ_NOIDLE flag above, as
it's only applied to synchronous queues in cfq as far as I can tell.

And while I'm at nitpicking about the most trivial patch of the
series anyway:  any good reason to not just spell out the "BACKGROUND" ?
