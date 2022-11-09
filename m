Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74133C433FE
	for <linux-block@archiver.kernel.org>; Wed,  9 Nov 2022 02:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKICIV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Nov 2022 21:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiKICIU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2022 21:08:20 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6090F686AD
        for <linux-block@vger.kernel.org>; Tue,  8 Nov 2022 18:08:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N6Szx3C4kz4f3wtR
        for <linux-block@vger.kernel.org>; Wed,  9 Nov 2022 10:08:13 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgC3YK+OC2tjAinPAA--.44026S3;
        Wed, 09 Nov 2022 10:08:16 +0800 (CST)
Subject: Re: [PATCH 5/7] dm: track per-add_disk holder relations in DM
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-6-hch@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9b5b4c2a-6566-2fb4-d3ae-4904f0889ea0@huaweicloud.com>
Date:   Wed, 9 Nov 2022 10:08:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221030153120.1045101-6-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgC3YK+OC2tjAinPAA--.44026S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGFy7Jry7Cr4xKw48GF1fCrg_yoWrGFyfpF
        Z8WasIqrW8JFsF9w47Xw4j9Fy5Krs5ta4F9r1xC34I9wnYyr909FWfGFy3XFyDJ397GF45
        XFWUtrs8ua18KrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

ÔÚ 2022/10/30 23:31, Christoph Hellwig Ð´µÀ:
> dm is a bit special in that it opens the underlying devices.  Commit
> 89f871af1b26 ("dm: delay registering the gendisk") tried to accomodate
> that by allowing to add the holder to the list before add_gendisk and
> then just add them to sysfs once add_disk is called.  But that leads to
> really odd lifetime problems and error handling problems as we can't
> know the state of the kobjects and don't unwind properly.  To fix this
> switch to just registering all existing table_devices with the holder
> code right after add_disk, and remove them before calling del_gendisk.
> 
> Fixes: 89f871af1b26 ("dm: delay registering the gendisk")
> Reported-by: Yu Kuai <yukuai1@huaweicloud.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/md/dm.c | 45 +++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2917700b1e15c..7b0d6dc957549 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -751,9 +751,16 @@ static struct table_device *open_table_device(struct mapped_device *md,
>   		goto out_free_td;
>   	}
>   
> -	r = bd_link_disk_holder(bdev, dm_disk(md));
> -	if (r)
> -		goto out_blkdev_put;
> +	/*
> +	 * We can be called before the dm disk is added.  In that case we can't
> +	 * register the holder relation here.  It will be done once add_disk was
> +	 * called.
> +	 */
> +	if (md->disk->slave_dir) {
If device_add_disk() or del_gendisk() can concurrent with this, It seems
to me that using 'slave_dir' is not safe.

I'm not quite familiar with dm, can we guarantee that they can't
concurrent?

Thanks,
Kuai
> +		r = bd_link_disk_holder(bdev, md->disk);
> +		if (r)
> +			goto out_blkdev_put;
> +	}
>   
>   	td->dm_dev.mode = mode;
>   	td->dm_dev.bdev = bdev;
> @@ -774,7 +781,8 @@ static struct table_device *open_table_device(struct mapped_device *md,
>    */
>   static void close_table_device(struct table_device *td, struct mapped_device *md)
>   {
> -	bd_unlink_disk_holder(td->dm_dev.bdev, dm_disk(md));
> +	if (md->disk->slave_dir)
> +		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
>   	blkdev_put(td->dm_dev.bdev, td->dm_dev.mode | FMODE_EXCL);
>   	put_dax(td->dm_dev.dax_dev);
>   	list_del(&td->list);
> @@ -1951,7 +1959,13 @@ static void cleanup_mapped_device(struct mapped_device *md)
>   		md->disk->private_data = NULL;
>   		spin_unlock(&_minor_lock);
>   		if (dm_get_md_type(md) != DM_TYPE_NONE) {
> +			struct table_device *td;
> +
>   			dm_sysfs_exit(md);
> +			list_for_each_entry(td, &md->table_devices, list) {
> +				bd_unlink_disk_holder(td->dm_dev.bdev,
> +						      md->disk);
> +			}
>   			del_gendisk(md->disk);
>   		}
>   		dm_queue_destroy_crypto_profile(md->queue);
> @@ -2284,6 +2298,7 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>   {
>   	enum dm_queue_mode type = dm_table_get_type(t);
>   	struct queue_limits limits;
> +	struct table_device *td;
>   	int r;
>   
>   	switch (type) {
> @@ -2316,13 +2331,27 @@ int dm_setup_md_queue(struct mapped_device *md, struct dm_table *t)
>   	if (r)
>   		return r;
>   
> -	r = dm_sysfs_init(md);
> -	if (r) {
> -		del_gendisk(md->disk);
> -		return r;
> +	/*
> +	 * Register the holder relationship for devices added before the disk
> +	 * was live.
> +	 */
> +	list_for_each_entry(td, &md->table_devices, list) {
> +		r = bd_link_disk_holder(td->dm_dev.bdev, md->disk);
> +		if (r)
> +			goto out_undo_holders;
>   	}
> +
> +	r = dm_sysfs_init(md);
> +	if (r)
> +		goto out_undo_holders;
>   	md->type = type;
>   	return 0;
> +
> +out_undo_holders:
> +	list_for_each_entry_continue_reverse(td, &md->table_devices, list)
> +		bd_unlink_disk_holder(td->dm_dev.bdev, md->disk);
> +	del_gendisk(md->disk);
> +	return r;
>   }
>   
>   struct mapped_device *dm_get_md(dev_t dev)
> 

