Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF82222CB;
	Wed,  5 Nov 2025 03:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762311855; cv=none; b=j9F9ipdzRqWQTCw5XVO6RmLw7PB0YW387b96LpnV+hiZJ2yCsfy8WoJsc7svtN+sQMzP3RPt3HVg63MxUzWxRoEgl5JZmFqeJakT/0DXMuiredzEZg/tP/EnPHhYI24g5ML31Oqo1rDHYmk7DtioZ/x12w5grN5Yl4cmFAKQsfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762311855; c=relaxed/simple;
	bh=EYe5bn5+pWPaZKRizWsa4rQFl0NSIZQeStp8fFoQuXg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=owc63/YB0guaemD1MuqIdPNJ0hMGJwhasYcmecPOQx9uTqE3XDJJXM/oTVZsTmyPZa/w7402JO7znKrMbNbKF9A81Vx5A/4Wiyx2kFAadbuinbJEF6f2TJiIu2KSmyW7kaoP50MAwIEFR2vEeYzGPwLZb6W8JLe4VSWEMj1dPCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qX+36mnn; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qX+36mnn"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1762311849; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=avKJ2M+nhkiKkwQaDLh9kOvywgRDFhXu3Wyry+jipq0=;
	b=qX+36mnnGzXfcbI50gQbMRvYhHaZ529HQ3b3dtfYavBczuNzI853KJKNdyHo6T2R3IPkEJ7OMLFGBOLfqc+m5OH7oVXO69AG0HHqkYBOy3P2qmfxGZPYWzpnsN/TxqWpBDpTvLnhyy8Vdj+CSL2erlHawFskehl+e2m/xzKpqno=
Received: from 30.50.177.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrjSX1X_1762311847 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 05 Nov 2025 11:04:08 +0800
Message-ID: <893184b5-57a8-4ba8-b923-614978a4c1be@linux.alibaba.com>
Date: Wed, 5 Nov 2025 11:04:06 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: question about bd_inode hashing against device_add() // Re:
 [PATCH 03/11] block: call bdev_add later in device_add_disk
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 Joseph Qi <joseph.qi@linux.alibaba.com>, guanghuifeng@linux.alibaba.com,
 zongyong.wzy@alibaba-inc.com, zyfjeff@linux.alibaba.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20210818144542.19305-1-hch@lst.de>
 <20210818144542.19305-4-hch@lst.de>
 <43375218-2a80-4a7a-b8bb-465f6419b595@linux.alibaba.com>
 <20251031090925.GA9379@lst.de>
 <ae38c5dc-da90-4fb3-bb72-61b66ab5a0d2@linux.alibaba.com>
 <20251031094552.GA10011@lst.de>
 <7d0d8480-13a2-449f-a46d-d9b164d44089@linux.alibaba.com>
 <2025103155-definite-stays-ebfe@gregkh>
 <2a9ab583-07fc-4147-949e-7c68feda82f2@linux.alibaba.com>
 <ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com>
 <2025103106-proposal-jogging-a076@gregkh>
 <83b9dac8-815e-4990-8cc7-5aaf4ba85f42@linux.alibaba.com>
In-Reply-To: <83b9dac8-815e-4990-8cc7-5aaf4ba85f42@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christiph,

On 2025/10/31 22:44, Gao Xiang wrote:
> 

..

>>> I just spent time to reproduce with dynamic loop devices and
>>> actually it's easy if msleep() is located artificiallly,
>>> the diff as below:
>>>
>>> diff --git a/block/bdev.c b/block/bdev.c
>>> index 810707cca970..a4273b5ad456 100644
>>> --- a/block/bdev.c
>>> +++ b/block/bdev.c
>>> @@ -821,7 +821,7 @@ struct block_device *blkdev_get_no_open(dev_t dev, bool autoload)
>>>       struct inode *inode;
>>>
>>>       inode = ilookup(blockdev_superblock, dev);
>>> -    if (!inode && autoload && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
>>> +    if (0) {
>>>           blk_request_module(dev);
>>>           inode = ilookup(blockdev_superblock, dev);
>>>           if (inode)
>>> diff --git a/block/genhd.c b/block/genhd.c
>>> index 9bbc38d12792..3c9116fdc1ce 100644
>>> --- a/block/genhd.c
>>> +++ b/block/genhd.c
>>> @@ -428,6 +428,8 @@ static void add_disk_final(struct gendisk *disk)
>>>       set_bit(GD_ADDED, &disk->state);
>>>   }
>>>
>>> +#include <linux/delay.h>
>>> +
>>>   static int __add_disk(struct device *parent, struct gendisk *disk,
>>>                 const struct attribute_group **groups,
>>>                 struct fwnode_handle *fwnode)
>>> @@ -497,6 +499,9 @@ static int __add_disk(struct device *parent, struct gendisk *disk,
>>>       if (ret)
>>>           goto out_free_ext_minor;
>>>
>>> +    if (disk->major == LOOP_MAJOR)
>>> +        msleep(2500);           // delay 2.5s for all loops
>>> +
>>
>> Yes, so you need to watch for the uevent to happen, THEN it is safe to
>> access the block device.  Doing it before then isn't a good idea :)
>>
>> But, if you think this is an issue, do you have a patch that passes your
>> testing to fix it?
> 
> I just raise it up for some ideas, and this change is
> buried into the code refactor and honestly I need to
> look into the codebase and related patchsets first.
> 
> Currently I have dozens of other development stuffs
> on hand, if it's really a regression, I do hope
> Christoph or other folks who are familiar with the code
> could try to address this.

I've provided a reproducible way:
https://lore.kernel.org/linux-block/ec8b1c76-c211-49a5-a056-6a147faddd3b@linux.alibaba.com

As the author of these gendisk/bdev enhancement commits, what's
your opinion on this?

In other words, do you think it's a regression, or just a behavior
change but not a regression? Also, a minor confirmation:
if it is a regression on your side, would you like to address it?

Due to further code changes, I proposed a temporary workaround
for our 6.6 kernels as below (I don't think it's clean but we will
do more tests), but due to limited time, currently I don't have
time to come up with a cleaner solution and track this until the
upstream fix lands.

Thanks,
Gao Xiang

  block/blk.h             |  1 +
  block/genhd.c           | 18 ++++++++++++++++--
  block/partitions/core.c |  6 +++++-
  3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index 475bbb40bb83..4410ae9da378 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -419,6 +419,7 @@ static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
  #endif /* CONFIG_BLK_DEV_ZONED */
  
  struct block_device *bdev_alloc(struct gendisk *disk, u8 partno);
+void bdev_inode_failed(struct block_device *bdev);
  void bdev_add(struct block_device *bdev, dev_t dev);
  
  int blk_alloc_ext_minor(void);
diff --git a/block/genhd.c b/block/genhd.c
index 039e7c17523b..cb4313a7c618 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -383,6 +383,14 @@ int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode)
  	return ret;
  }
  
+void bdev_inode_failed(struct block_device *bdev)
+{
+	struct inode *inode = bdev->bd_inode;
+
+	make_bad_inode(inode);
+	unlock_new_inode(inode);
+}
+
  /**
   * device_add_disk - add disk information to kernel list
   * @parent: parent device for the disk
@@ -452,8 +460,12 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
  	ddev->parent = parent;
  	ddev->groups = groups;
  	dev_set_name(ddev, "%s", disk->disk_name);
-	if (!(disk->flags & GENHD_FL_HIDDEN))
+	if (!(disk->flags & GENHD_FL_HIDDEN)) {
  		ddev->devt = MKDEV(disk->major, disk->first_minor);
+		disk->part0->bd_inode->i_state |= I_NEW;
+		bdev_add(disk->part0, ddev->devt);
+	}
+
  	ret = device_add(ddev);
  	if (ret)
  		goto out_free_ext_minor;
@@ -505,7 +517,7 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
  		if (get_capacity(disk) && disk_has_partscan(disk))
  			set_bit(GD_NEED_PART_SCAN, &disk->state);
  
-		bdev_add(disk->part0, ddev->devt);
+		unlock_new_inode(disk->part0->bd_inode);
  		if (get_capacity(disk))
  			disk_scan_partitions(disk, BLK_OPEN_READ);
  
@@ -546,6 +558,8 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
  out_device_del:
  	device_del(ddev);
  out_free_ext_minor:
+	if (!(disk->flags & GENHD_FL_HIDDEN))
+		bdev_inode_failed(disk->part0);
  	if (disk->major == BLOCK_EXT_MAJOR)
  		blk_free_ext_minor(disk->first_minor);
  out_exit_elevator:
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 549ce89a657b..c69e369955b9 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -376,6 +376,9 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
  			goto out_put;
  	}
  
+	bdev->bd_inode->i_state |= I_NEW;
+	bdev_add(bdev, devt);
+
  	/* delay uevent until 'holders' subdir is created */
  	dev_set_uevent_suppress(pdev, 1);
  	err = device_add(pdev);
@@ -398,7 +401,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
  	err = xa_insert(&disk->part_tbl, partno, bdev, GFP_KERNEL);
  	if (err)
  		goto out_del;
-	bdev_add(bdev, devt);
+	unlock_new_inode(bdev->bd_inode);
  
  	/* suppress uevent if the disk suppresses it */
  	if (!dev_get_uevent_suppress(ddev))
@@ -409,6 +412,7 @@ static struct block_device *add_partition(struct gendisk *disk, int partno,
  	kobject_put(bdev->bd_holder_dir);
  	device_del(pdev);
  out_put:
+	bdev_inode_failed(bdev);
  	put_device(pdev);
  	return ERR_PTR(err);
  out_put_disk:
-- 
