Return-Path: <BATV+ec6d521f801fb612d965+4989+infradead.org+hch@bombadil.srs.infradead.org>
Date: Fri, 21 Apr 2017 04:31:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: NeilBrown <neilb@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
	Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH 05/11] rbd: use bio_clone_fast() instead of bio_clone()
Message-ID: <20170421113108.GG12523@infradead.org>
References: <149266645258.27388.14083229348123176454.stgit@noble>
 <149266672920.27388.16945242936892893803.stgit@noble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <149266672920.27388.16945242936892893803.stgit@noble>
List-ID: <linux-block@vger.kernel.org>

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
