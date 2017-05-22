Return-Path: <hch@lst.de>
Date: Mon, 22 May 2017 20:48:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Zhang Yi <yizhan@redhat.com>,
	linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 0/3] nvme: fix hang in path of removing disk
Message-ID: <20170522184812.GA1360@lst.de>
References: <20170522150505.452-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170522150505.452-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Thanks Ming,

I'll add the three patches to the nvme-4.12 queue, assuming Jens
is okay with us queueing up the block path to remove
blk_mq_abort_requeue_list.
