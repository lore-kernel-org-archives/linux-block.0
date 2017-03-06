Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 6 Mar 2017 17:04:59 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 02/11] block: Fix race of bdev open with gendisk shutdown
Message-ID: <20170306220459.GJ26127@htj.duckdns.org>
References: <20170306163404.1238-1-jack@suse.cz>
 <20170306163404.1238-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170306163404.1238-3-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Mon, Mar 06, 2017 at 05:33:55PM +0100, Jan Kara wrote:
> +	disk->flags &= ~GENHD_FL_UP;
> +	/*
> +	 * Make sure __blkdev_open() sees the disk is going away before
> +	 * starting to unhash bdev inodes.
> +	 */
> +	smp_wmb();

But which rmb is this paired with?  Without paring memory barriers
don't do anything.  Given that this isn't a super hot path, I think
it'd be far better to stick to a simpler synchronization mechanism.

Thanks.

-- 
tejun
