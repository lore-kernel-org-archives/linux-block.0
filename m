Return-Path: <keith.busch@intel.com>
Date: Thu, 19 Oct 2017 09:14:27 -0600
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/17] nvme: use ida_simple_{get,remove} for the
 controller instance
Message-ID: <20171019151426.GC2768@localhost.localdomain>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171018165258.23212-8-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This is a good cleanup, and I'd support this patch going in ahead of
this series on its own if you want to apply to 4.15 immediately.

Reviewed-by: Keith Busch <keith.busch@intel.com>
