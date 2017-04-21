Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:25:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] blk: use non-rescuing bioset for q->bio_split.
Message-ID: <20170421112529.GC12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672879.27388.10034843544514097987.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266672879.27388.10034843544514097987.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
