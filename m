Return-Path: <keith.busch@linux.intel.com>
Date: Fri, 28 Sep 2018 08:15:16 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
	Bart van Assche <bvanassche@acm.org>,
	linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Message-ID: <20180928141516.GB21979@localhost.localdomain>
References: <20180928061723.13180-1-hare@suse.de>
 <20180928061723.13180-3-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180928061723.13180-3-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

On Fri, Sep 28, 2018 at 08:17:20AM +0200, Hannes Reinecke wrote:
> We should be registering the ns_id attribute as default sysfs
> attribute groups, otherwise we have a race condition between
> the uevent and the attributes appearing in sysfs.
> 
> Suggested-by: Bart van Assche <bvanassche@acm.org>
> Signed-off-by: Hannes Reinecke <hare@suse.com>

Thanks, looks great!

Reviewed-by: Keith Busch <keith.busch@intel.com>
