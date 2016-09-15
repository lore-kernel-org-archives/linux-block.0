Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 15 Sep 2016 12:11:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Hugh Dickins <hughd@google.com>
Subject: Re: [bug report] fs/block_dev.c: add bdev_read_page() and
 bdev_write_page()
Message-ID: <20160915091110.GD26713@mwanda>
References: <20160804140206.GA11852@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160804140206.GA11852@mwanda>
List-ID: <linux-block@vger.kernel.org>

Let's try reporting this again to new email addresses...

Btw, belated thanks for creating a linux-block mailing list Jens.  :)

regards,
dan carpenter

On Thu, Aug 04, 2016 at 05:02:06PM +0300, Dan Carpenter wrote:
> Hello Matthew Wilcox,
> 
> The patch 47a191fd38eb: "fs/block_dev.c: add bdev_read_page() and
> bdev_write_page()" from Jun 4, 2014, leads to the following static
> checker warning:
> 
> 	include/linux/genhd.h:382 part_inc_in_flight()
> 	warn: buffer overflow 'part->in_flight' 2 <= 72
> 
> include/linux/genhd.h
>    380  static inline void part_inc_in_flight(struct hd_struct *part, int rw)
>    381  {
>    382          atomic_inc(&part->in_flight[rw]);
>                                             ^^
> This should either be READ or WRITE.
> 
>    383          if (part->partno)
>    384                  atomic_inc(&part_to_disk(part)->part0.in_flight[rw]);
>    385  }
> 
> 
>    444  int bdev_write_page(struct block_device *bdev, sector_t sector,
>    445                          struct page *page, struct writeback_control *wbc)
>    446  {
>    447          int result;
>    448          int rw = (wbc->sync_mode == WB_SYNC_ALL) ? WRITE_SYNC : WRITE;
>                                                            ^^^^^^^^^^
> But here we're setting it to WRITE_SYNC.
> 
>    449          const struct block_device_operations *ops = bdev->bd_disk->fops;
>    450  
>    451          if (!ops->rw_page || bdev_get_integrity(bdev))
>    452                  return -EOPNOTSUPP;
>    453          result = blk_queue_enter(bdev->bd_queue, false);
>    454          if (result)
>    455                  return result;
>    456  
>    457          set_page_writeback(page);
>    458          result = ops->rw_page(bdev, sector + get_start_sect(bdev), page, rw);
>    459          if (result)
>    460                  end_page_writeback(page);
>    461          else
>    462                  unlock_page(page);
>    463          blk_queue_exit(bdev->bd_queue);
>    464          return result;
>    465  }
> 
> regards,
> dan carpenter
