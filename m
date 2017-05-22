Return-Path: <keith.busch@intel.com>
Date: Mon, 22 May 2017 01:35:00 -0400
From: Keith Busch <keith.busch@intel.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Zhang Yi <yizhan@redhat.com>, linux-block@vger.kernel.org,
	Johannes Thumshirn <jthumshirn@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
 nvme_kill_queues()
Message-ID: <20170522053500.GF7850@localhost.localdomain>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170520035605.21785-2-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>
