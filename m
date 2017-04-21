Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:29:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] pktcdvd: use bio_clone_fast() instead of
 bio_clone()
Message-ID: <20170421112920.GE12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672965.27388.264586329955894592.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266672965.27388.264586329955894592.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 03:38:49PM +1000, NeilBrown wrote:
> pktcdvd doesn't change the bi_io_vec of the clone bio,
> so it is more efficient to use bio_clone_fast(), and not clone
> the bi_io_vec.
> This requires providing a bio_set, and it is safest to
> provide a dedicated bio_set rather than sharing
> fs_bio_set, which filesytems use.
> This new bio_set, pkt_bio_set, can also be use for the bio_split()
> call as the two allocations (bio_clone_fast, and bio_split) are
> independent, neither can block a bio allocated by the other.

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But didn't we decide we want to kill off pktcdvd a while ago?
