Return-Path: <hch@lst.de>
Date: Sun, 21 May 2017 08:22:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Zhang Yi <yizhan@redhat.com>, stable@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 2/3] nvme: avoid to use blk_mq_abort_requeue_list()
Message-ID: <20170521062203.GC12287@lst.de>
References: <20170520035605.21785-1-ming.lei@redhat.com> <20170520035605.21785-3-ming.lei@redhat.com> <20170520053409.GA22317@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170520053409.GA22317@ming.t460p>
List-ID: <linux-block@vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
