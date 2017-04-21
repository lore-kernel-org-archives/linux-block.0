Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:28:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] block: Improvements to bounce-buffer handling
Message-ID: <20170421112825.GD12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672902.27388.15322863417005890204.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266672902.27388.15322863417005890204.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Do we want to doctor around the bio bouncing or leave it to the dma_ops
like other subsystems do?  These days dma_map_* is supposed to handle
any memory we throw at it, even if that means using bounce buffers
at that level.
