Return-Path: <hch@lst.de>
Date: Wed, 1 Aug 2018 16:52:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 1/3] block: don't use bio->bi_vcnt to figure out
	segment number
Message-ID: <20180801145224.GA28668@lst.de>
References: <20180731104914.17249-1-ming.lei@redhat.com> <20180731104914.17249-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731104914.17249-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31, 2018 at 06:49:12PM +0800, Ming Lei wrote:
> It is wrong to use bio->bi_vcnt to figure out how many segments
> there are in the bio even though CLONED flag isn't set on this bio,
> because this bio may be splitted or advanced.
> 
> So always use bio_segments() in blk_recount_segments(), and it shouldn't
> cause any performance loss now because the physical segment number is figured
> out in blk_queue_split() and BIO_SEG_VALID is set meantime since
> bdced438acd83ad83a6c ("block: setup bi_phys_segments after splitting").

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
