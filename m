Return-Path: <hch@lst.de>
Date: Mon, 22 May 2017 14:51:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	stable@vger.kernel.org, Zhang Yi <yizhan@redhat.com>
Subject: Re: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
	nvme_kill_queues()
Message-ID: <20170522125140.GE11869@lst.de>
References: <20170520035605.21785-1-ming.lei@redhat.com> <20170520035605.21785-2-ming.lei@redhat.com> <20170521062002.GB12287@lst.de> <20170522013557.GD15872@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170522013557.GD15872@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

On Mon, May 22, 2017 at 09:35:58AM +0800, Ming Lei wrote:
> In theory, it should be OK to stop and start queues again before the final
> removal, so how about the following:
> 
>  		 * Note: We must make sure to not put the queues into being stopped
> 		 forever from now until the final removal.

Maybe:
		 * Note that we must ensure the queues are not stopped
		 * when the final removal happens.

?
