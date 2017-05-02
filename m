Return-Path: <BATV+0ce91e3c8ec9178008cb+5000+infradead.org+hch@bombadil.srs.infradead.org>
Date: Tue, 2 May 2017 01:15:52 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] block: don't check for BIO_MAX_PAGES in
 blk_bio_segment_split()
Message-ID: <20170502081552.GF5578@infradead.org>
References: <149369628671.5146.4865312503373040039.stgit@noble>
 <149369654638.5146.3067734913419940612.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149369654638.5146.3067734913419940612.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
