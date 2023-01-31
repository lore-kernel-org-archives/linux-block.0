Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B844C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 14:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjAaOAN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbjAaOAM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 09:00:12 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D91227AE
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 06:00:08 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P5mry1lN9z4f3tqM
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 22:00:02 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR_iHtljr5sFCg--.13384S3;
        Tue, 31 Jan 2023 22:00:04 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221130175653.24299-1-jack@suse.cz>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
Date:   Tue, 31 Jan 2023 22:00:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221130175653.24299-1-jack@suse.cz>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR_iHtljr5sFCg--.13384S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWrtr4fXw1UXr17tw18Krg_yoW8tF4xpF
        W5AFWYkrWDGr40gay0v3WUXw45Kr47Ga97AryxCFWSvwsxJrn0yFn2k395uryS9r9rCrWU
        ZF45Jay3KFy8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jan

ÔÚ 2022/12/01 1:56, Jan Kara Ð´µÀ:

> -int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
> +int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
>   {
>   	struct block_device *bdev;
>   
> @@ -366,6 +366,9 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode)
>   		return -EINVAL;
>   	if (disk->open_partitions)
>   		return -EBUSY;
> +	/* Someone else has bdev exclusively open? */
> +	if (disk->part0->bd_holder != owner)
> +		return -EBUSY;
>   
>   	set_bit(GD_NEED_PART_SCAN, &disk->state);
>   	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);

It just by code review, but I think the above checking should be inside
open_mutex, which is used to protect bdev claming. Otherwise there can
be race that this check is pass while someone else exclusive open the
disk before blkdev_get_by_dev().

How do you think about open coding blkdev_get_by_dev() here, something
like:

diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331c..341af4db7d54 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -358,7 +358,7 @@ EXPORT_SYMBOL_GPL(disk_uevent);

  int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
  {
-       struct block_device *bdev;
+       int ret = 0;

         if (disk->flags & (GENHD_FL_NO_PART | GENHD_FL_HIDDEN))
                 return -EINVAL;
@@ -366,16 +366,31 @@ int disk_scan_partitions(struct gendisk *disk, 
fmode_t mode, void *owner)
                 return -EINVAL;
         if (disk->open_partitions)
                 return -EBUSY;
+
+       disk_block_events(disk);
+       mutex_lock(&disk->open_mutex);
+
         /* Someone else has bdev exclusively open? */
-       if (disk->part0->bd_holder && disk->part0->bd_holder != owner)
-               return -EBUSY;
+       if (disk->part0->bd_holder && disk->part0->bd_holder != owner) {
+               ret = -EBUSY;
+               goto out;
+       }
+
+       if (!disk_live(disk)) {
+               ret = -ENODEV;
+               goto out;
+       }

         set_bit(GD_NEED_PART_SCAN, &disk->state);
-       bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
-       if (IS_ERR(bdev))
-               return PTR_ERR(bdev);
-       blkdev_put(bdev, mode);
-       return 0;
+       ret = blkdev_get_whole(disk->part0, mode);
+out:
+       mutex_unlock(&disk->open_mutex);
+       disk_unblock_events(disk);
+
+       if (!ret)
+               blkdev_put_whole(disk->part0, mode);
+
+       return ret;
  }



