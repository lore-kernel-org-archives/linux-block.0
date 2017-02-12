Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Feb 2017 13:40:27 +0900
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 08/10] block: Fix oops in
 locked_inode_to_wb_and_lock_list()
Message-ID: <20170212044027.GF29323@mtj.duckdns.org>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-9-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209124433.2626-9-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Hello, Jan.

On Thu, Feb 09, 2017 at 01:44:31PM +0100, Jan Kara wrote:
> When block device is closed, we call inode_detach_wb() in __blkdev_put()
> which sets inode->i_wb to NULL. That is contrary to expectations that
> inode->i_wb stays valid once set during the whole inode's lifetime and
> leads to oops in wb_get() in locked_inode_to_wb_and_lock_list() because
> inode_to_wb() returned NULL.
> 
> The reason why we called inode_detach_wb() is not valid anymore though.
> BDI is guaranteed to stay along until we call bdi_put() from
> bdev_evict_inode() so we can postpone calling inode_detach_wb() to that
> moment. A complication is that i_wb can point to non-root wb_writeback
> structure and in that case we do need to clean it up as bdi_unregister()
> blocks waiting for all non-root wb_writeback references to get dropped.
> Thus this i_wb reference could block device removal e.g. from
> __scsi_remove_device() (which indirectly ends up calling
> bdi_unregister()). We cannot rely on block device inode to go away soon
> (and thus i_wb reference to get dropped) as the device may got
> hot-removed e.g. under a mounted filesystem. We deal with these issues
> by switching block device inode from non-root wb_writeback structure to
> bdi->wb when needed.  Since this is rather expensive (requires
> synchronize_rcu()) we do the switching only in del_gendisk() when we
> know the device is going away.

So, the only reason cgwb_bdi_destroy() is synchronous is because bdi
destruction was synchronous.  Now that bdi is properly reference
counted and can be decoupled from gendisk / q destruction, I can't
think of a reason to keep cgwb destruction synchronous.  Switching
wb's on destruction is kinda clumsy and it almost always hurts to
expose synchronize_rcu() in userland visible paths.

Wouldn't something like the following work?

* Remove bdi->usage_cnt and the synchronous waiting in
  cgwb_bdi_destroy().

* Instead, make cgwb's hold bdi->refcnt and put it from
  cgwb_release_workfn().

Then, we don't have to switch during shutdown and can just let things
drain.

Thanks.

-- 
tejun
