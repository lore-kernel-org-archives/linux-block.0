Return-Path: <hch@lst.de>
Date: Tue, 24 Jul 2018 09:57:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>,
	linux-block@vger.kernel.org, axboe@kernel.dk, keith.busch@intel.com,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH 1/2] block: move dif_prepare/dif_complete functions to
	block layer
Message-ID: <20180724075730.GD7859@lst.de>
References: <1532252998-2375-1-git-send-email-maxg@mellanox.com> <20180723072854.GA18365@lst.de> <yq1bmax5rfl.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <yq1bmax5rfl.fsf@oracle.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 23, 2018 at 09:54:38PM -0400, Martin K. Petersen wrote:
> 
> Christoph,
> 
> >> +void blk_integrity_dif_prepare(struct request *rq, u8 protection_type,
> >> +			       u32 ref_tag)
> >> +{
> >
> > Maybe call this blk_t10_pi_prepare?
> 
> The rest of these functions have a blk_integrity_ prefix. So either
> stick with that or put the functions in t10-pi.c and use a t10_pi_
> prefix.

Yes, I suggested moving it somewhere in my reply.
