Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E46D3783D5
	for <linux-block@vger.kernel.org>; Sat, 30 May 2026 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780181503; cv=none; b=WwdW0Llrh0ObkdKAZ9DbbbNrxMIO+NaRJOb3YgEM09OtDhTRgp2CHKnahnQ7IW7iv+r30ge+VUDFY2D66QWx5CSAbGAyrgdw9Rd55/O6/cSJ3Q3CQ8jDpb2bn2+3miRuFwgragm02+XoRoGOqtSIQUYq5tJRXFtQYKG65FTH+14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780181503; c=relaxed/simple;
	bh=L2F2GESRF7c7j2F7oJSXsdNQh4FQ+xA/+Op/QHuoJp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnuA93NlIqUoEaeqKu/SuUrkwcecebGGQhFTOGK6LNGDo/RdLHQ6mUMi1IuDjKTBbUtyokKFI1ljbfOLr2GE/g4ob9DbTv+5I7TSdG8PNYmNcKIU+46d9xPBhQu/I9NTn+TTxmp1gCs9ETgB8kELPbGVPdz3DDNYe6880qf63v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=jNco05MX; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="jNco05MX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1780181499;
	bh=goOLpAjYkboC1fsjOAjhfQJMnz4HVLH5o4r+Xngqo5U=;
	h=From:Subject:Date:Message-ID;
	b=jNco05MXwDi6MaEUDxpDaPiXnAdImr2U6RCXDgTU2mFmaSpPOCiustbQp4mcP0DUM
	 VkGivN0eC6Y0ybGk3+myBjtob1CiTEGaf6jd0oreNhc3pUZjF9QaPCaCosuRiEoPSp
	 yJR5grDLvFQxM5unS9x4lfkaWZwi9SPwM+bXb8Uc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 6A1B69F0000028DD; Sat, 31 May 2026 06:51:30 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 472976685163
X-SMAIL-UIID: DB8065293FEC4C689523CF6966499A3A-20260531-065130-1
From: Hillf Danton <hdanton@sina.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Boqun Feng <boqun@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Qu Wenruo <wqu@suse.com>,
	Hillf Danton <hdanton@sina.com>
Subject: Re: [PATCH] block: assign caller-specific lockdep class to disk->open_mutex
Date: Sun, 31 May 2026 06:50:42 +0800
Message-ID: <20260530225120.1346-1-hdanton@sina.com>
In-Reply-To: <147ed056-03d9-4214-b925-0f10fc00cf27@I-love.SAKURA.ne.jp>
References: 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 30 May 2026 22:45:55 +0900 Tetsuo Handa wrote:
> The block core currently allocates a single monolithic lockdep key for
> disk->open_mutex across all callers. This single key conflates locking
> hierarchies between independent block streams. For example, if a stacked
> driver like loop flushes its internal workqueues inside lo_release() while
> holding its own open_mutex, lockdep views this as a potential ABBA deadlock
> against the underlying storage stack, leading to numerous circular
> dependency splats [2][3][4][5][6].
> 
> To reduce false-positives structurally, this patch splits the global
> monolithic lock class into distinct, per-caller during disk allocation;
> by changing "lock_class_key" into a 2-element array:
>   - lkclass[0]: Used for the legacy "(bio completion)" map.
>   - lkclass[1]: Assigned to target caller's disk->open_mutex.
> 
I wonder how this works given e966eaeeb623 ("locking/lockdep: Remove the
cross-release locking checks").

> This patch was tested by adding drain_workqueue() to __loop_clr_fd() during
> testing of a patch for [1], and actually helped stopping [2][4][6].
> Even if our final solution for [1] does not call drain_workqueue() with
> disk->open_mutex held, keeping locking chains simpler and shorter should
> be a good change.
> 
> Link: https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28 [1]
> Link: https://syzkaller.appspot.com/bug?extid=2f62807dc3239b8f584e [2]
> Link: https://syzkaller.appspot.com/bug?extid=c4e9d077bcc86bee08dc [3]
> Link: https://syzkaller.appspot.com/bug?extid=0f427123ae84b3ba6dc7 [4]
> Link: https://syzkaller.appspot.com/bug?extid=4feabfc9641267769c97 [5]
> Link: https://syzkaller.appspot.com/bug?extid=fb0ff9bfe34ad282ebd4 [6]
> Suggested-by: AI Mode in Google Search (no mail address)
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  block/blk-mq.c         | 4 ++--
>  block/blk.h            | 2 +-
>  block/genhd.c          | 8 ++++----
>  drivers/scsi/sd.c      | 4 ++--
>  drivers/scsi/sr.c      | 4 ++--
>  include/linux/blk-mq.h | 8 ++++----
>  include/linux/blkdev.h | 6 +++---
>  7 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 28c2d931e75e..01a15ac40754 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4492,7 +4492,7 @@ EXPORT_SYMBOL(blk_mq_destroy_queue);
>  
>  struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
>  		struct queue_limits *lim, void *queuedata,
> -		struct lock_class_key *lkclass)
> +		struct lock_class_key lkclass[2])
>  {
>  	struct request_queue *q;
>  	struct gendisk *disk;
> @@ -4513,7 +4513,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
>  EXPORT_SYMBOL(__blk_mq_alloc_disk);
>  
>  struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
> -		struct lock_class_key *lkclass)
> +		struct lock_class_key lkclass[2])
>  {
>  	struct gendisk *disk;
>  
> diff --git a/block/blk.h b/block/blk.h
> index b998a7761faf..1744748f9b68 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -614,7 +614,7 @@ void drop_partition(struct block_device *part);
>  void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors);
>  
>  struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
> -		struct lock_class_key *lkclass);
> +		struct lock_class_key lkclass[2]);
>  struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
>  
>  int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
> diff --git a/block/genhd.c b/block/genhd.c
> index 7d6854fd28e9..303bd5e619e7 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1444,7 +1444,7 @@ dev_t part_devt(struct gendisk *disk, u8 partno)
>  }
>  
>  struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
> -		struct lock_class_key *lkclass)
> +		struct lock_class_key lkclass[2])
>  {
>  	struct gendisk *disk;
>  
> @@ -1467,7 +1467,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  		goto out_free_bdi;
>  
>  	disk->node_id = node_id;
> -	mutex_init(&disk->open_mutex);
> +	mutex_init_with_key(&disk->open_mutex, &lkclass[1]);
>  	xa_init(&disk->part_tbl);
>  	if (xa_insert(&disk->part_tbl, 0, disk->part0, GFP_KERNEL))
>  		goto out_destroy_part_tbl;
> @@ -1482,7 +1482,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  	device_initialize(disk_to_dev(disk));
>  	inc_diskseq(disk);
>  	q->disk = disk;
> -	lockdep_init_map(&disk->lockdep_map, "(bio completion)", lkclass, 0);
> +	lockdep_init_map(&disk->lockdep_map, "(bio completion)", &lkclass[0], 0);
>  #ifdef CONFIG_BLOCK_HOLDER_DEPRECATED
>  	INIT_LIST_HEAD(&disk->slave_bdevs);
>  #endif
> @@ -1506,7 +1506,7 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>  }
>  
>  struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
> -		struct lock_class_key *lkclass)
> +		struct lock_class_key lkclass[2])
>  {
>  	struct queue_limits default_lim = { };
>  	struct request_queue *q;
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 599e75f33334..d8a1bbd4f19e 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -112,7 +112,7 @@ static DEFINE_MUTEX(sd_mutex_lock);
>  static mempool_t *sd_page_pool;
>  static mempool_t *sd_large_page_pool;
>  static atomic_t sd_large_page_pool_users = ATOMIC_INIT(0);
> -static struct lock_class_key sd_bio_compl_lkclass;
> +static struct lock_class_key sd_bio_compl_lkclass[2];
>  
>  static const char *sd_cache_types[] = {
>  	"write through", "none", "write back",
> @@ -4021,7 +4021,7 @@ static int sd_probe(struct scsi_device *sdp)
>  		goto out;
>  
>  	gd = blk_mq_alloc_disk_for_queue(sdp->request_queue,
> -					 &sd_bio_compl_lkclass);
> +					 sd_bio_compl_lkclass);
>  	if (!gd)
>  		goto out_free;
>  
> diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
> index c36c54ecd354..421b8bd37db0 100644
> --- a/drivers/scsi/sr.c
> +++ b/drivers/scsi/sr.c
> @@ -106,7 +106,7 @@ static struct scsi_driver sr_template = {
>  static unsigned long sr_index_bits[SR_DISKS / BITS_PER_LONG];
>  static DEFINE_SPINLOCK(sr_index_lock);
>  
> -static struct lock_class_key sr_bio_compl_lkclass;
> +static struct lock_class_key sr_bio_compl_lkclass[2];
>  
>  static int sr_open(struct cdrom_device_info *, int);
>  static void sr_release(struct cdrom_device_info *);
> @@ -634,7 +634,7 @@ static int sr_probe(struct scsi_device *sdev)
>  		goto fail;
>  
>  	disk = blk_mq_alloc_disk_for_queue(sdev->request_queue,
> -					   &sr_bio_compl_lkclass);
> +					   sr_bio_compl_lkclass);
>  	if (!disk)
>  		goto fail_free;
>  	mutex_init(&cd->lock);
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 18a2388ba581..57d805c78827 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -726,15 +726,15 @@ enum {
>  
>  struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set,
>  		struct queue_limits *lim, void *queuedata,
> -		struct lock_class_key *lkclass);
> +		struct lock_class_key lkclass[2]);
>  #define blk_mq_alloc_disk(set, lim, queuedata)				\
>  ({									\
> -	static struct lock_class_key __key;				\
> +	static struct lock_class_key __key[2];				\
>  									\
> -	__blk_mq_alloc_disk(set, lim, queuedata, &__key);		\
> +	__blk_mq_alloc_disk(set, lim, queuedata, __key);		\
>  })
>  struct gendisk *blk_mq_alloc_disk_for_queue(struct request_queue *q,
> -		struct lock_class_key *lkclass);
> +		struct lock_class_key lkclass[2]);
>  struct request_queue *blk_mq_alloc_queue(struct blk_mq_tag_set *set,
>  		struct queue_limits *lim, void *queuedata);
>  int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 890128cdea1c..3cd2056cde28 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -974,7 +974,7 @@ int bdev_disk_changed(struct gendisk *disk, bool invalidate);
>  
>  void put_disk(struct gendisk *disk);
>  struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
> -		struct lock_class_key *lkclass);
> +		struct lock_class_key lkclass[2]);
>  
>  /**
>   * blk_alloc_disk - allocate a gendisk structure
> @@ -990,9 +990,9 @@ struct gendisk *__blk_alloc_disk(struct queue_limits *lim, int node,
>   */
>  #define blk_alloc_disk(lim, node_id)					\
>  ({									\
> -	static struct lock_class_key __key;				\
> +	static struct lock_class_key __key[2];				\
>  									\
> -	__blk_alloc_disk(lim, node_id, &__key);				\
> +	__blk_alloc_disk(lim, node_id, __key);				\
>  })
>  
>  int __register_blkdev(unsigned int major, const char *name,
> -- 
> 2.47.3
> 
> 
