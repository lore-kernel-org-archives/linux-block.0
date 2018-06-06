Return-Path: <hch@lst.de>
Date: Wed, 6 Jun 2018 16:42:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH] block: pass failfast and driver-specific flags to
	flush requests
Message-ID: <20180606144208.GA20487@lst.de>
References: <20180606142140.64146-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180606142140.64146-1-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 06, 2018 at 04:21:40PM +0200, Hannes Reinecke wrote:
> If flush requests are being sent to the device we need to inherit the
> failfast and driver-specific flags, too, otherwise I/O will fail.

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
