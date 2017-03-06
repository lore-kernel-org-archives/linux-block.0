Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 6 Mar 2017 17:01:16 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 01/11] block: Fix bdi assignment to bdev inode when
 racing with disk delete
Message-ID: <20170306220116.GI26127@htj.duckdns.org>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306163404.1238-2-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Mon, Mar 06, 2017 at 05:33:54PM +0100, Jan Kara wrote:
> When disk->fops->open() in __blkdev_get() returns -ERESTARTSYS, we
> restart the process of opening the block device. However we forget to
> switch bdev->bd_bdi back to noop_backing_dev_info and as a result bdev
> inode will be pointing to a stale bdi. Fix the problem by setting
> bdev->bd_bdi later when __blkdev_get() is already guaranteed to succeed.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
