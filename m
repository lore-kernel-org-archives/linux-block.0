Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Feb 2017 13:22:22 +0900
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 03/10] block: Revalidate i_bdev reference in bd_aquire()
Message-ID: <20170212042222.GC29323@mtj.duckdns.org>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-4-jack@suse.cz>
 <20170209155417.GA15818@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209155417.GA15818@quack2.suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 04:54:17PM +0100, Jan Kara wrote:
> From aaf612333753b948a96aebe4a2f8066ed45ef164 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Thu, 9 Feb 2017 12:16:30 +0100
> Subject: [PATCH 03/10] block: Revalidate i_bdev reference in bd_aquire()
> 
> When a device gets removed, block device inode unhashed so that it is not
> used anymore (bdget() will not find it anymore). Later when a new device
> gets created with the same device number, we create new block device
> inode. However there may be file system device inodes whose i_bdev still
> points to the original block device inode and thus we get two active
> block device inodes for the same device. They will share the same
> gendisk so the only visible differences will be that page caches will
> not be coherent and BDIs will be different (the old block device inode
> still points to unregistered BDI).
> 
> Fix the problem by checking in bd_acquire() whether i_bdev still points
> to active block device inode and re-lookup the block device if not. That
> way any open of a block device happening after the old device has been
> removed will get correct block device inode.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
