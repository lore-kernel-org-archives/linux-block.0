Return-Path: <hch@lst.de>
Date: Wed, 8 Jun 2016 16:10:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, keith.busch@intel.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@lightbits.io, ming.l@ssi.samsung.com
Subject: Re: [PATCH 01/11] Revert "blk-mq: add blk_mq_alloc_request_hctx"
Message-ID: <20160608141019.GB1020@lst.de>
References: <1465389066-19119-1-git-send-email-hch@lst.de> <1465389066-19119-2-git-send-email-hch@lst.de> <x49mvmv235d.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <x49mvmv235d.fsf@segfault.boston.devel.redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 08, 2016 at 09:58:38AM -0400, Jeff Moyer wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Just for book keeping. The next patch brings it back with some changes.
> 
> That's a strange thing to do, and breaks bisectability.  Why not just
> update the function?

Because it's just an updated to a not yet applied series.  The idea is
that Jens could just take patch 2 if we get a positive review or two for
it.
