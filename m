Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98890C43462
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A661C42
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 15:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbhELPS6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 11:18:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:51490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234276AbhELPQY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 11:16:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E67C9B17D;
        Wed, 12 May 2021 15:15:12 +0000 (UTC)
Subject: Re: [PATCH v1 5/8] block: add initial error handling for *add_disk()*
 and friends
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, osandov@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-6-mcgrof@kernel.org>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <d4621662-aa4b-4e1e-b390-f0aab5af1135@suse.de>
Date:   Wed, 12 May 2021 17:15:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512064629.13899-6-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 8:46 AM, Luis Chamberlain wrote:
> This adds error handling to the *add_disk*() callers and the functions
> it depends on. This is initial work as drivers are not converted. That
> is separate work.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>   block/blk-integrity.c |  12 ++--
>   block/blk-sysfs.c     |   5 +-
>   block/blk.h           |   5 +-
>   block/genhd.c         | 152 +++++++++++++++++++++++++++++-------------
>   include/linux/genhd.h |  14 ++--
>   5 files changed, 127 insertions(+), 61 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 410da060d1f5..e46f47f2dec9 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -431,13 +431,17 @@ void blk_integrity_unregister(struct gendisk *disk)
>   }
>   EXPORT_SYMBOL(blk_integrity_unregister);
>   
> -void blk_integrity_add(struct gendisk *disk)
> +int blk_integrity_add(struct gendisk *disk)
>   {
> -	if (kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
> -				 &disk_to_dev(disk)->kobj, "%s", "integrity"))
> -		return;
> +	int ret;
> +
> +	ret = kobject_init_and_add(&disk->integrity_kobj, &integrity_ktype,
> +				 &disk_to_dev(disk)->kobj, "%s", "integrity");
> +	if (ret)
> +		return ret;
>   
>   	kobject_uevent(&disk->integrity_kobj, KOBJ_ADD);
> +	return 0;
>   }
>   
>   void blk_integrity_del(struct gendisk *disk)
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index e03bedf180ab..8a0978a0623c 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -862,9 +862,10 @@ int blk_register_queue(struct gendisk *disk)
>   	if (WARN_ON(!q))
>   		return -ENXIO;
>   
> -	WARN_ONCE(blk_queue_registered(q),
> +	if (WARN_ONCE(blk_queue_registered(q),
>   		  "%s is registering an already registered queue\n",
> -		  kobject_name(&dev->kobj));
> +		  kobject_name(&dev->kobj)))
> +		return -ENXIO;
>   
>   	/*
>   	 * SCSI probing may synchronously create and destroy a lot of
> diff --git a/block/blk.h b/block/blk.h
> index 8b3591aee0a5..01ec7aba8d70 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -132,7 +132,7 @@ static inline bool integrity_req_gap_front_merge(struct request *req,
>   				bip_next->bip_vec[0].bv_offset);
>   }
>   
> -void blk_integrity_add(struct gendisk *);
> +int blk_integrity_add(struct gendisk *);
>   void blk_integrity_del(struct gendisk *);
>   #else /* CONFIG_BLK_DEV_INTEGRITY */
>   static inline bool blk_integrity_merge_rq(struct request_queue *rq,
> @@ -166,8 +166,9 @@ static inline bool bio_integrity_endio(struct bio *bio)
>   static inline void bio_integrity_free(struct bio *bio)
>   {
>   }
> -static inline void blk_integrity_add(struct gendisk *disk)
> +static inline int blk_integrity_add(struct gendisk *disk)
>   {
> +	return 0;
>   }
>   static inline void blk_integrity_del(struct gendisk *disk)
>   {
> diff --git a/block/genhd.c b/block/genhd.c
> index baa68192ebb3..eafcd256fc6f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -37,8 +37,8 @@ static DEFINE_IDA(ext_devt_ida);
>   
>   static void disk_check_events(struct disk_events *ev,
>   			      unsigned int *clearing_ptr);
> -static void disk_alloc_events(struct gendisk *disk);
> -static void disk_add_events(struct gendisk *disk);
> +static int disk_alloc_events(struct gendisk *disk);
> +static int disk_add_events(struct gendisk *disk);
>   static void disk_del_events(struct gendisk *disk);
>   static void disk_release_events(struct gendisk *disk);
>   
> @@ -494,8 +494,9 @@ static void unregister_disk(struct gendisk *disk)
>   	disk_invalidate(disk);
>   }
>   
> -static void register_disk(struct device *parent, struct gendisk *disk,
> -			  const struct attribute_group **groups)
> +static int __must_check register_disk(struct device *parent,
> +				      struct gendisk *disk,
> +				      const struct attribute_group **groups)
>   {
>   	struct device *ddev = disk_to_dev(disk);
>   	int err;
> @@ -511,15 +512,20 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>   		WARN_ON(ddev->groups);
>   		ddev->groups = groups;
>   	}
> -	if (device_add(ddev))
> -		return;
> +	err = device_add(ddev);
> +	if (err) {
> +		/*
> +		 * We don't put_device(ddev), the driver is responsible to
> +		 * issue the last put_device(ddev), however it instead uses
> +		 * put_disk().
> +		 */
> +		return err;
> +	}
>   	if (!sysfs_deprecated) {
>   		err = sysfs_create_link(block_depr, &ddev->kobj,
>   					kobject_name(&ddev->kobj));
> -		if (err) {
> -			device_del(ddev);
> -			return;
> -		}
> +		if (err)
> +			goto exit_del_device;
>   	}
>   
>   	/*
> @@ -534,7 +540,7 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>   	disk->slave_dir = kobject_create_and_add("slaves", &ddev->kobj);
>   
>   	if (disk->flags & GENHD_FL_HIDDEN)
> -		return;
> +		return 0;
>   
>   	disk_scan_partitions(disk);
>   	disk_announce(disk);
> @@ -543,8 +549,19 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>   		err = sysfs_create_link(&ddev->kobj,
>   			  &disk->queue->backing_dev_info->dev->kobj,
>   			  "bdi");
> -		WARN_ON(err);
> +		if (WARN_ON(err))
> +			goto exit_del_block_depr;
>   	}
> +	return 0;
> +
> +exit_del_block_depr:
> +	unregister_disk_partitions(disk);
> +	if (!sysfs_deprecated)
> +		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
> +exit_del_device:
> +	device_del(ddev);
> +
> +	return err;
>   }
>   
>   /**
> @@ -557,20 +574,24 @@ static void register_disk(struct device *parent, struct gendisk *disk,
>    * This function registers the partitioning information in @disk
>    * with the kernel.
>    *
> - * FIXME: error handling
>    */
> -static void __device_add_disk(struct device *parent, struct gendisk *disk,
> -			      const struct attribute_group **groups,
> -			      bool register_queue)
> +static int __device_add_disk(struct device *parent, struct gendisk *disk,
> +			     const struct attribute_group **groups,
> +			     bool register_queue)
>   {
>   	dev_t devt;
>   	int retval;
>   
>   	/*
>   	 * Take an extra ref on queue which will be put on disk_release()
> -	 * so that it sticks around as long as @disk is there.
> +	 * so that it sticks around as long as @disk is there. The driver
> +	 * must call blk_cleanup_queue() and then put_disk() on error from
> +	 * this function.
>   	 */
> -	WARN_ON_ONCE(!blk_get_queue(disk->queue));
> +	if (WARN_ON_ONCE(!blk_get_queue(disk->queue))) {
> +		disk->queue = NULL;

Please don't.
We don't set disk->queue here in this function, and we don't know what 
the caller will do with that value.
If we start setting it to NULL here we'll need to audit all drivers to 
ensure they don't look at disk->queue after calling this function.
Plus it's good coding practice to only clear fields which you set in the 
first place, which is not the case here.

> +		return -ESHUTDOWN;
> +	}
>   
>   	/*
>   	 * The disk queue should now be all set with enough information about
> @@ -585,21 +606,24 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>   	 * be accompanied with EXT_DEVT flag.  Make sure all
>   	 * parameters make sense.
>   	 */
> -	WARN_ON(disk->minors && !(disk->major || disk->first_minor));
> -	WARN_ON(!disk->minors &&
> -		!(disk->flags & (GENHD_FL_EXT_DEVT | GENHD_FL_HIDDEN)));
> +	if (WARN_ON(disk->minors && !(disk->major || disk->first_minor)))
> +		return -EINVAL;
> +	if (WARN_ON(!disk->minors &&
> +		    !(disk->flags & (GENHD_FL_EXT_DEVT | GENHD_FL_HIDDEN))))
> +		return -EINVAL;
>   
>   	disk->flags |= GENHD_FL_UP;
>   
>   	retval = blk_alloc_devt(disk->part0, &devt);
> -	if (retval) {
> -		WARN_ON(1);
> -		return;
> -	}
> +	if (WARN_ON(retval))

Don't we need to reset GENHD_FL_UP here?

> +		return retval;
> +
>   	disk->major = MAJOR(devt);
>   	disk->first_minor = MINOR(devt);
>   
> -	disk_alloc_events(disk);
> +	retval = disk_alloc_events(disk);
> +	if (retval)
> +		goto exit_blk_free_devt;
>   
>   	if (disk->flags & GENHD_FL_HIDDEN) {
>   		/*
> @@ -611,34 +635,62 @@ static void __device_add_disk(struct device *parent, struct gendisk *disk,
>   	} else {
>   		struct backing_dev_info *bdi = disk->queue->backing_dev_info;
>   		struct device *dev = disk_to_dev(disk);
> -		int ret;
>   
>   		/* Register BDI before referencing it from bdev */
>   		dev->devt = devt;
> -		ret = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
> -		WARN_ON(ret);
> +		retval = bdi_register(bdi, "%u:%u", MAJOR(devt), MINOR(devt));
> +		if (WARN_ON(retval))
> +			goto exit_disk_release_events;
>   		bdi_set_owner(bdi, dev);
>   		bdev_add(disk->part0, devt);
>   	}
> -	register_disk(parent, disk, groups);
> -	if (register_queue)
> -		blk_register_queue(disk);
> +	retval = register_disk(parent, disk, groups);
> +	if (retval)
> +		goto exit_unregister_bdi;
> +
> +	if (register_queue) {
> +		retval = blk_register_queue(disk);
> +		if (retval)
> +			goto exit_unregister_disk;
> +	}
>   
> -	disk_add_events(disk);
> -	blk_integrity_add(disk);
> +	retval = disk_add_events(disk);
> +	if (retval)
> +		goto exit_unregister_disk;
> +
> +	retval = blk_integrity_add(disk);
> +	if (retval)
> +		goto exit_del_events;
> +
> +	return 0;
> +exit_del_events:
> +	disk_del_events(disk);
> +exit_unregister_disk:
> +	unregister_disk(disk);
> +	return retval;
> +
> +exit_unregister_bdi:
> +	if (disk->queue && !(disk->flags & GENHD_FL_HIDDEN))
> +		bdi_unregister(disk->queue->backing_dev_info);
> +exit_disk_release_events:
> +	disk_release_events(disk);
> +exit_blk_free_devt:
> +	blk_free_devt(disk_devt(disk));
> +

Same here: In the error path we might end up with the GENHD_FL_UP being 
set. I would expected that flag to be unset once we return with an error 
here.

> +	return retval;
>   }
>   
> -void device_add_disk(struct device *parent, struct gendisk *disk,
> -		     const struct attribute_group **groups)
> +int device_add_disk(struct device *parent, struct gendisk *disk,
> +		    const struct attribute_group **groups)
>   
>   {
> -	__device_add_disk(parent, disk, groups, true);
> +	return __device_add_disk(parent, disk, groups, true);
>   }
>   EXPORT_SYMBOL(device_add_disk);
>   
> -void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
> +int device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk)
>   {
> -	__device_add_disk(parent, disk, NULL, false);
> +	return __device_add_disk(parent, disk, NULL, false);
>   }
>   EXPORT_SYMBOL(device_add_disk_no_queue_reg);
>   
> @@ -1817,17 +1869,17 @@ module_param_cb(events_dfl_poll_msecs, &disk_events_dfl_poll_msecs_param_ops,
>   /*
>    * disk_{alloc|add|del|release}_events - initialize and destroy disk_events.
>    */
> -static void disk_alloc_events(struct gendisk *disk)
> +static int disk_alloc_events(struct gendisk *disk)
>   {
>   	struct disk_events *ev;
>   
>   	if (!disk->fops->check_events || !disk->events)
> -		return;
> +		return 0;
>   
>   	ev = kzalloc(sizeof(*ev), GFP_KERNEL);
>   	if (!ev) {
>   		pr_warn("%s: failed to initialize events\n", disk->disk_name);
> -		return;
> +		return -ENOMEM;
>   	}
>   
>   	INIT_LIST_HEAD(&ev->node);
> @@ -1839,17 +1891,23 @@ static void disk_alloc_events(struct gendisk *disk)
>   	INIT_DELAYED_WORK(&ev->dwork, disk_events_workfn);
>   
>   	disk->ev = ev;
> +
> +	return 0;
>   }
>   
> -static void disk_add_events(struct gendisk *disk)
> +static int disk_add_events(struct gendisk *disk)
>   {
> -	/* FIXME: error handling */
> -	if (sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs) < 0)
> +	int ret;
> +
> +	ret = sysfs_create_files(&disk_to_dev(disk)->kobj, disk_events_attrs);
> +	if (ret < 0) {
>   		pr_warn("%s: failed to create sysfs files for events\n",
>   			disk->disk_name);
> +		return ret;
> +	}
>   
>   	if (!disk->ev)
> -		return;
> +		return 0;
>   
>   	mutex_lock(&disk_events_mutex);
>   	list_add_tail(&disk->ev->node, &disk_events);
> @@ -1860,6 +1918,8 @@ static void disk_add_events(struct gendisk *disk)
>   	 * unblock kicks it into action.
>   	 */
>   	__disk_unblock_events(disk, true);
> +
> +	return 0;
>   }
>   
>   static void disk_del_events(struct gendisk *disk)
> diff --git a/include/linux/genhd.h b/include/linux/genhd.h
> index 7e9660ea967d..5a23d97ccb90 100644
> --- a/include/linux/genhd.h
> +++ b/include/linux/genhd.h
> @@ -205,16 +205,16 @@ static inline dev_t disk_devt(struct gendisk *disk)
>   void disk_uevent(struct gendisk *disk, enum kobject_action action);
>   
>   /* block/genhd.c */
> -extern void device_add_disk(struct device *parent, struct gendisk *disk,
> -			    const struct attribute_group **groups);
> -static inline void add_disk(struct gendisk *disk)
> +extern int device_add_disk(struct device *parent, struct gendisk *disk,
> +			   const struct attribute_group **groups);
> +static inline int add_disk(struct gendisk *disk)
>   {
> -	device_add_disk(NULL, disk, NULL);
> +	return device_add_disk(NULL, disk, NULL);
>   }
> -extern void device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
> -static inline void add_disk_no_queue_reg(struct gendisk *disk)
> +extern int device_add_disk_no_queue_reg(struct device *parent, struct gendisk *disk);
> +static inline int add_disk_no_queue_reg(struct gendisk *disk)
>   {
> -	device_add_disk_no_queue_reg(NULL, disk);
> +	return device_add_disk_no_queue_reg(NULL, disk);
>   }
>   
>   extern void del_gendisk(struct gendisk *gp);
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
