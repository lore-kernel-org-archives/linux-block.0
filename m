Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 12 Feb 2017 12:58:33 +0900
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	NeilBrown <neilb@suse.de>
Subject: Re: [PATCH 01/10] block: Move bdev_unhash_inode() after
 invalidate_partition()
Message-ID: <20170212035833.GA29323@mtj.duckdns.org>
References: <20170209124433.2626-1-jack@suse.cz>
 <20170209124433.2626-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170209124433.2626-2-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

On Thu, Feb 09, 2017 at 01:44:24PM +0100, Jan Kara wrote:
> Move bdev_unhash_inode() after invalidate_partition() as
> invalidate_partition() looks up bdev and will unnecessarily recreate it
> if bdev_unhash_inode() destroyed it. Also use part_devt() when calling
> bdev_unhash_inode() instead of manually creating the device number.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Acked-by: Tejun Heo <tj@kernel.org>

> @@ -648,9 +648,8 @@ void del_gendisk(struct gendisk *disk)
>  	disk_part_iter_init(&piter, disk,
>  			     DISK_PITER_INCL_EMPTY | DISK_PITER_REVERSE);
>  	while ((part = disk_part_iter_next(&piter))) {
> -		bdev_unhash_inode(MKDEV(disk->major,
> -					disk->first_minor + part->partno));
>  		invalidate_partition(disk, part->partno);
> +		bdev_unhash_inode(part_devt(part));
>  		delete_partition(disk, part->partno);

So, before this patch, invalidate_partition() would have operated on a
newly created inode and thus wouldn't have actually invalidated the
existing bdev / mapping, right?

Thanks.

-- 
tejun
