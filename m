Return-Path: <jack@suse.cz>
Date: Wed, 1 Feb 2017 13:28:14 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/4] block: Make blk_get_backing_dev_info() safe without
 open bdev
Message-ID: <20170201122814.GF11567@quack2.suse.cz>
References: <20170131125429.14303-1-jack@suse.cz>
 <20170131125429.14303-5-jack@suse.cz>
 <20170201095320.GD17386@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170201095320.GD17386@infradead.org>
List-ID: <linux-block@vger.kernel.org>

On Wed 01-02-17 01:53:20, Christoph Hellwig wrote:
> Looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But can you also add another patch to kill off blk_get_backing_dev_info?
> The direct dereference is short and cleaner.  Additionally the bt_bdi
> field in XFS could go away, too.

OK, I'll do that. Another cleanup I was considering is to remove all other
embedded occurences of backing_dev_info and make the structure only
dynamically allocated. It would unify the handling of backing_dev_info and
allow us to make bdi_init(), bdi_destroy(), etc. static inside
mm/backing_dev.c. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
