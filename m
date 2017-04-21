Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:34:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] block: don't check for BIO_MAX_PAGES in
 blk_bio_segment_split()
Message-ID: <20170421113408.GJ12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266673048.27388.6882396367486800999.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266673048.27388.6882396367486800999.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 03:38:50PM +1000, NeilBrown wrote:
> blk_bio_segment_split() makes sure bios have no more than
> BIO_MAX_PAGES entries in the bi_io_vec.
> This was done because bio_clone_bioset() (when given a
> mempool bioset) could not handle larger io_vecs.
> 
> No driver uses bio_clone_bioset() any more, they all
> use bio_clone_fast() if anything, and bio_clone_fast()
> doesn't clone the bi_io_vec.

Hmm.  From Jens tree:

drivers/lightnvm/pblk-read.c:           int_bio = bio_clone_bioset(bio, GFP_KERNEL, fs_bio_set);
drivers/md/raid1.c:                             mbio = bio_clone_bioset_partial(bio, GFP_NOIO,
drivers/md/raid1.c:                             mbio = bio_clone_bioset_partial(bio, GFP_NOIO,

I did not see your series touching either of those.  They probably
don't matter for the code removed as the bios are controlled by the
drivers, but the changelog still seems odd.
