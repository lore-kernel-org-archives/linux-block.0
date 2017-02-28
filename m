Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 28 Feb 2017 11:52:14 -0500
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Lekshmi Pillai <lekshmicpillai@in.ibm.com>,
	NeilBrown <neilb@suse.de>, Omar Sandoval <osandov@osandov.com>
Subject: Re: [PATCH 11/13] block: Fix oops in
 locked_inode_to_wb_and_lock_list()
Message-ID: <20170228165214.GG15287@htj.duckdns.org>
References: <20170221170958.21845-1-jack@suse.cz>
 <20170221170958.21845-12-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170221170958.21845-12-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 21, 2017 at 06:09:56PM +0100, Jan Kara wrote:
> When block device is closed, we call inode_detach_wb() in __blkdev_put()
> which sets inode->i_wb to NULL. That is contrary to expectations that
> inode->i_wb stays valid once set during the whole inode's lifetime and
> leads to oops in wb_get() in locked_inode_to_wb_and_lock_list() because
> inode_to_wb() returned NULL.
> 
> The reason why we called inode_detach_wb() is not valid anymore though.
> BDI is guaranteed to stay along until we call bdi_put() from
> bdev_evict_inode() so we can postpone calling inode_detach_wb() to that
> moment.
> 
> Also add a warning to catch if someone uses inode_detach_wb() in a
> dangerous way.
> 
> Reported-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
