Return-Path: <hch@lst.de>
Date: Fri, 28 Sep 2018 17:17:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Bart van Assche <bvanassche@acm.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Message-ID: <20180928151732.GC8079@lst.de>
References: <20180928061723.13180-1-hare@suse.de> <20180928061723.13180-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928061723.13180-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 28, 2018 at 08:17:20AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
