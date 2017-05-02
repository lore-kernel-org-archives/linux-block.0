Return-Path: <ming.lei@redhat.com>
Date: Tue, 2 May 2017 18:22:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] block: don't check for BIO_MAX_PAGES in
 blk_bio_segment_split()
Message-ID: <20170502102223.GB1803@ming.t460p>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654638.5146.3067734913419940612.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654638.5146.3067734913419940612.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

On Tue, May 02, 2017 at 01:42:26PM +1000, NeilBrown wrote:
> blk_bio_segment_split() makes sure bios have no more than
> BIO_MAX_PAGES entries in the bi_io_vec.
> This was done because bio_clone_bioset() (when given a
> mempool bioset) could not handle larger io_vecs.
> 
> No driver uses bio_clone_bioset() any more, they all
> use bio_clone_fast() if anything, and bio_clone_fast()
> doesn't clone the bi_io_vec.

Maybe in future, some drivers still may try to use 
bio_clone_bioset() again, I suggest to add some comments
on bio_clone_bioset() to make this usage explicitly. Also
better to trigger a warning if a big src bio is passed to
bio_clone_bioset().

Thanks,
Ming
