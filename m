Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 25 Jul 2018 08:53:57 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Max Gurtovoy <maxg@mellanox.com>, axboe@kernel.dk,
	linux-block@vger.kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, vladimirk@mellanox.com,
	linux-nvme@lists.infradead.org, keith.busch@intel.com
Subject: Re: [PATCH v3 2/3] block: move dif_prepare/dif_complete functions to
 block layer
Message-ID: <20180725145357.GD14596@localhost.localdomain>
References: <1532508421-2711-1-git-send-email-maxg@mellanox.com>
 <1532508421-2711-2-git-send-email-maxg@mellanox.com>
 <20180725112247.GA24190@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725112247.GA24190@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 25, 2018 at 01:22:47PM +0200, Christoph Hellwig wrote:
> > +			pmap = kmap_atomic(iv.bv_page) + iv.bv_offset;
> > +			p = pmap;
> 
> Maybe:
> 
> 			pmap = p = kmap_atomic(iv.bv_page) + iv.bv_offset;

Max pointed out that even with this, we're still calling kunmap_atomic()
with an address potentially at an offset from the page that was kmap'ed.
While currently harmless, perhaps for correctness:

 			pmap = kmap_atomic(iv.bv_page);
			p = pmap + iv.bv_offset;
