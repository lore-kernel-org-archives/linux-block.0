Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:31:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@gmail.com>,
	linux-bcache@vger.kernel.org
Subject: Re: [PATCH 09/11] bcache: use kmalloc to allocate bio in
 bch_data_verify()
Message-ID: <20170421113140.GH12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266673005.27388.9415706764616504556.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266673005.27388.9415706764616504556.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
