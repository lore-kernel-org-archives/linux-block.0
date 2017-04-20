Return-Path: <hch@lst.de>
Date: Thu, 20 Apr 2017 17:25:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <jbacik@fb.com>, James Smart <james.smart@broadcom.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH 22/23] blktrace: remove the unused block_rq_abort
	tracepoint
Message-ID: <20170420152558.GA23516@lst.de>
References: <20170420140316.6546-1-hch@lst.de> <20170420140316.6546-23-hch@lst.de> <20170420152056.GP13676@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170420152056.GP13676@linux-x5ow.site>
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 20, 2017 at 05:20:56PM +0200, Johannes Thumshirn wrote:
> On Thu, Apr 20, 2017 at 04:03:15PM +0200, Christoph Hellwig wrote:
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> Just to be sure nothings forgotten, does this change need an update for
> blktrace as well?

I don't think so.  It will just never get this event before or after
this patch.
