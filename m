Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:36:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau Monne <roger.pau@citrix.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 08/11] xen-blkfront: remove bio splitting.
Message-ID: <20170421113620.GK12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672984.27388.11947154313852245586.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266672984.27388.11947154313852245586.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Btw, I really don't understand why this code even looks at bios over
just requeueing the request.  Can someone explain that bit to me?
