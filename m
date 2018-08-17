Return-Path: <hch@lst.de>
Date: Fri, 17 Aug 2018 08:55:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@intel.com>,
	Bart van Assche <bart.vanassche@wdc.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
	groups
Message-ID: <20180817065514.GC11170@lst.de>
References: <20180814073305.87255-1-hare@suse.de> <20180814073305.87255-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Aug 14, 2018 at 09:33:02AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I only reviewed the original patch without the lightnvm additions.
Please drop reviewed-by tags if you make non-trivial changes.

In this case I also wonder if you should have just kept the original
patch as-is and added a new one for lightnvm.
