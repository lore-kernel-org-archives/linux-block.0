Return-Path: <ming.lei@redhat.com>
Date: Mon, 22 May 2017 22:49:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	stable@vger.kernel.org, Zhang Yi <yizhan@redhat.com>
Subject: Re: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
 nvme_kill_queues()
Message-ID: <20170522144920.GF15872@ming.t460p>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-2-ming.lei@redhat.com>
 <20170521062002.GB12287@lst.de>
 <20170522013557.GD15872@ming.t460p>
 <20170522125140.GE11869@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170522125140.GE11869@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 22, 2017 at 02:51:40PM +0200, Christoph Hellwig wrote:
> On Mon, May 22, 2017 at 09:35:58AM +0800, Ming Lei wrote:
> > In theory, it should be OK to stop and start queues again before the final
> > removal, so how about the following:
> > 
> >  		 * Note: We must make sure to not put the queues into being stopped
> > 		 forever from now until the final removal.
> 
> Maybe:
> 		 * Note that we must ensure the queues are not stopped
> 		 * when the final removal happens.
> 
> ?

Yeah, that is it, :-)

Thanks,
Ming
