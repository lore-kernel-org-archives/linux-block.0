Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xhqqsl9u"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D222391
	for <linux-block@vger.kernel.org>; Tue, 21 Nov 2023 01:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700559212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdSSY5rOf4lsHswaV3d89efumkLwbwdqgzQh3zad72M=;
	b=Xhqqsl9uBuT+nMwfRoE4pJ3ZfTbDiwrAKBpe1hnMgkhVL9L3QV1Ri4cGUdzxDwEpEt/IeO
	Ni559G+14xOuhn/v+pGujK/hf9sPqwZJs4yCZdk7VlCgHjZjmL/AMdybwBj37WgljgJ0fo
	ZC8HNd00cx58Kebd7yKpYEpwegE94Ss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-34QdyQA-Mt2PkXGPYZTy5w-1; Tue, 21 Nov 2023 04:33:26 -0500
X-MC-Unique: 34QdyQA-Mt2PkXGPYZTy5w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1147C832D60;
	Tue, 21 Nov 2023 09:33:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.14])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F4635036;
	Tue, 21 Nov 2023 09:33:20 +0000 (UTC)
Date: Tue, 21 Nov 2023 17:33:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/2] block: introduce new field flags in block_device
Message-ID: <ZVx5XE3o+D8pGPib@fedora>
References: <20231121111927.2021846-1-yukuai1@huaweicloud.com>
 <20231121111927.2021846-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121111927.2021846-2-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Tue, Nov 21, 2023 at 07:19:26PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> There are multiple switches in struct block_device, use separate bool
> fields for them is not gracefully. Add a new field flags and replace
> swithes to a bit, there are no functional changes, and preare to add
> a new switch in the next patch.
> 
> In order to keep flags in the first cacheline, define it as u32 and add
> new helpers to set/clear/test each bit like 'bio->bi_flags'.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/bdev.c              | 15 ++++++++-------
>  block/blk-core.c          |  7 ++++---
>  block/genhd.c             | 15 +++++++++++----
>  block/ioctl.c             |  6 +++++-
>  include/linux/blk_types.h | 27 +++++++++++++++++++++------
>  include/linux/blkdev.h    |  5 +++--
>  6 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index fc8d28d77495..6b420cbd4f3d 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -408,10 +408,10 @@ struct block_device *bdev_alloc(struct gendisk *disk, u8 partno)
>  	bdev->bd_partno = partno;
>  	bdev->bd_inode = inode;
>  	bdev->bd_queue = disk->queue;
> -	if (partno)
> -		bdev->bd_has_submit_bio = disk->part0->bd_has_submit_bio;
> +	if (partno && bdev_flagged(disk->part0, BD_FLAG_HAS_SUBMIT_BIO))
> +		bdev_set_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	else
> -		bdev->bd_has_submit_bio = false;
> +		bdev_clear_flag(bdev, BD_FLAG_HAS_SUBMIT_BIO);
>  	bdev->bd_stats = alloc_percpu(struct disk_stats);
>  	if (!bdev->bd_stats) {
>  		iput(inode);
> @@ -612,7 +612,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>  		bdev->bd_holder = NULL;
>  		bdev->bd_holder_ops = NULL;
>  		mutex_unlock(&bdev->bd_holder_lock);
> -		if (bdev->bd_write_holder)
> +		if (bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER))
>  			unblock = true;
>  	}
>  	if (!whole->bd_holders)
> @@ -625,7 +625,7 @@ static void bd_end_claim(struct block_device *bdev, void *holder)
>  	 */
>  	if (unblock) {
>  		disk_unblock_events(bdev->bd_disk);
> -		bdev->bd_write_holder = false;
> +		bdev_clear_flag(bdev, BD_FLAG_WRITE_HOLDER);
>  	}
>  }
>  
> @@ -878,9 +878,10 @@ struct bdev_handle *bdev_open_by_dev(dev_t dev, blk_mode_t mode, void *holder,
>  		 * writeable reference is too fragile given the way @mode is
>  		 * used in blkdev_get/put().
>  		 */
> -		if ((mode & BLK_OPEN_WRITE) && !bdev->bd_write_holder &&
> +		if ((mode & BLK_OPEN_WRITE) &&
> +		    !bdev_flagged(bdev, BD_FLAG_WRITE_HOLDER) &&
>  		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
> -			bdev->bd_write_holder = true;
> +			bdev_set_flag(bdev, BD_FLAG_WRITE_HOLDER);
>  			unblock_events = false;
>  		}
>  	}
> diff --git a/block/blk-core.c b/block/blk-core.c
> index fdf25b8d6e78..f9f8b12ba626 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -482,7 +482,8 @@ __setup("fail_make_request=", setup_fail_make_request);
>  
>  bool should_fail_request(struct block_device *part, unsigned int bytes)
>  {
> -	return part->bd_make_it_fail && should_fail(&fail_make_request, bytes);
> +	return bdev_flagged(part, BD_FLAG_MAKE_IT_FAIL) &&
> +		should_fail(&fail_make_request, bytes);
>  }
>  
>  static int __init fail_make_request_debugfs(void)
> @@ -595,7 +596,7 @@ static void __submit_bio(struct bio *bio)
>  	if (unlikely(!blk_crypto_bio_prep(&bio)))
>  		return;
>  
> -	if (!bio->bi_bdev->bd_has_submit_bio) {
> +	if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO)) {
>  		blk_mq_submit_bio(bio);
>  	} else if (likely(bio_queue_enter(bio) == 0)) {
>  		struct gendisk *disk = bio->bi_bdev->bd_disk;
> @@ -703,7 +704,7 @@ void submit_bio_noacct_nocheck(struct bio *bio)
>  	 */
>  	if (current->bio_list)
>  		bio_list_add(&current->bio_list[0], bio);
> -	else if (!bio->bi_bdev->bd_has_submit_bio)
> +	else if (!bdev_flagged(bio->bi_bdev, BD_FLAG_HAS_SUBMIT_BIO))
>  		__submit_bio_noacct_mq(bio);
>  	else
>  		__submit_bio_noacct(bio);
> diff --git a/block/genhd.c b/block/genhd.c
> index c9d06f72c587..57f96c0c8da0 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -413,7 +413,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
>  	elevator_init_mq(disk->queue);
>  
>  	/* Mark bdev as having a submit_bio, if needed */
> -	disk->part0->bd_has_submit_bio = disk->fops->submit_bio != NULL;
> +	if (disk->fops->submit_bio)
> +		bdev_set_flag(disk->part0, BD_FLAG_HAS_SUBMIT_BIO);
>  
>  	/*
>  	 * If the driver provides an explicit major number it also must provide
> @@ -1062,7 +1063,8 @@ static DEVICE_ATTR(diskseq, 0444, diskseq_show, NULL);
>  ssize_t part_fail_show(struct device *dev,
>  		       struct device_attribute *attr, char *buf)
>  {
> -	return sprintf(buf, "%d\n", dev_to_bdev(dev)->bd_make_it_fail);
> +	return sprintf(buf, "%d\n",
> +		       bdev_flagged(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL));
>  }
>  
>  ssize_t part_fail_store(struct device *dev,
> @@ -1071,8 +1073,13 @@ ssize_t part_fail_store(struct device *dev,
>  {
>  	int i;
>  
> -	if (count > 0 && sscanf(buf, "%d", &i) > 0)
> -		dev_to_bdev(dev)->bd_make_it_fail = i;
> +	if (count > 0 && sscanf(buf, "%d", &i) > 0) {
> +		if (!i)
> +			bdev_clear_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
> +		else
> +			bdev_set_flag(dev_to_bdev(dev), BD_FLAG_MAKE_IT_FAIL);
> +
> +	}
>  
>  	return count;
>  }
> diff --git a/block/ioctl.c b/block/ioctl.c
> index 4160f4e6bd5b..a64440f4c96b 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -394,7 +394,11 @@ static int blkdev_roset(struct block_device *bdev, unsigned cmd,
>  		if (ret)
>  			return ret;
>  	}
> -	bdev->bd_read_only = n;
> +
> +	if (!n)
> +		bdev_clear_flag(bdev, BD_FLAG_READ_ONLY);
> +	else
> +		bdev_set_flag(bdev, BD_FLAG_READ_ONLY);
>  	return 0;
>  }
>  
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 52e264d5a830..f7a7965eeb25 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -37,6 +37,11 @@ struct bio_crypt_ctx;
>  #define PAGE_SECTORS		(1 << PAGE_SECTORS_SHIFT)
>  #define SECTOR_MASK		(PAGE_SECTORS - 1)
>  
> +#define BD_FLAG_READ_ONLY	0 /* read-only-policy */
> +#define BD_FLAG_WRITE_HOLDER	1
> +#define BD_FLAG_HAS_SUBMIT_BIO	2
> +#define BD_FLAG_MAKE_IT_FAIL	3
> +
>  struct block_device {
>  	sector_t		bd_start_sect;
>  	sector_t		bd_nr_sectors;
> @@ -44,10 +49,8 @@ struct block_device {
>  	struct request_queue *	bd_queue;
>  	struct disk_stats __percpu *bd_stats;
>  	unsigned long		bd_stamp;
> -	bool			bd_read_only;	/* read-only policy */
> +	unsigned int		bd_flags;
>  	u8			bd_partno;
> -	bool			bd_write_holder;
> -	bool			bd_has_submit_bio;
>   dev_t                   bd_dev;
>   atomic_t                bd_openers;
>   spinlock_t              bd_size_lock; /* for bd_inode->i_size updates */

As I mentioned, you can convert the above/original 4 fields into single
'unsigned int', otherwise one extra 'int' filed is added. Then, 'bd_size_lock'
is moved to the 2nd cache line, which isn't big deal since the field isn't
touched in fast path. Anyway, it can be one future cleanup, so:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

