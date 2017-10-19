Return-Path: <hch@lst.de>
Date: Thu, 19 Oct 2017 17:12:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/17] nvme: use ida_simple_{get,remove} for the
	controller instance
Message-ID: <20171019151255.GA24354@lst.de>
References: <20171018165258.23212-1-hch@lst.de> <20171018165258.23212-8-hch@lst.de> <20171019151426.GC2768@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019151426.GC2768@localhost.localdomain>
List-ID: <linux-block@vger.kernel.org>

On Thu, Oct 19, 2017 at 09:14:27AM -0600, Keith Busch wrote:
> This is a good cleanup, and I'd support this patch going in ahead of
> this series on its own if you want to apply to 4.15 immediately.

Ok, will do.
