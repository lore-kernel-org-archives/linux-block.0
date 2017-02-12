Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Feb 2017 13:31:29 +0900
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 04/10] block: Move bdi_unregister() to del_gendisk()
Message-ID: <20170212043129.GD29323@mtj.duckdns.org>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209124433.2626-5-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 01:44:27PM +0100, Jan Kara wrote:
> Commit 6cd18e711dd8 "block: destroy bdi before blockdev is
> unregistered." moved bdi unregistration (at that time through
> bdi_destroy()) from blk_release_queue() to blk_cleanup_queue() because
> it needs to happen before blk_unregister_region() call in del_gendisk()
> for MD. As much as it is fine for device registration / unregistration
> purposes, it does not fit our needs wrt writeback code. For those we
> will need bdi_unregister() to happen after bdev_unhash_inode() so that
> we are sure bdev inode is destroyed or soon to be destroyed (as soon as
> last inode reference is dropped and nobody should be holding bdev inode
> reference for long at this point) because bdi_unregister() may block
> waiting for bdev's inode i_wb reference to be dropped and that happens
> only once bdev inode gets destroyed.
> 
> Also SCSI will free up the device number from sd_remove() called through
> a maze of callbacks from device_del() in __scsi_remove_device() before
> blk_cleanup_queue() and thus similar races as described in 6cd18e711dd8
> can happen for SCSI as well as reported by Omar [1]. Moving
> bdi_unregister() to del_gendisk() fixes these problems as well since
> del_gendisk() gets called from sd_remove() before freeing the device
> number.
> 
> This also makes device_add_disk() (calling bdi_register_owner()) more
> symmetric with del_gendisk().
> 
> [1] http://marc.info/?l=linux-block&m=148554717109098&w=2
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
