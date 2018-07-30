Return-Path: <hch@lst.de>
Date: Mon, 30 Jul 2018 10:59:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 3/6] nvme: register ns_id attributes as default sysfs
	groups
Message-ID: <20180730085906.GC12038@lst.de>
References: <20180730071227.22887-1-hare@suse.de> <20180730071227.22887-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180730071227.22887-4-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Mon, Jul 30, 2018 at 09:12:24AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <keith.busch@intel.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
