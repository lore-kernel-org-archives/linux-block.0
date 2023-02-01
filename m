Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7301C38142
	for <linux-block@archiver.kernel.org>; Wed,  1 Feb 2023 01:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjBABEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 20:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbjBABET (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 20:04:19 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324BE5140B
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 17:04:18 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P63bJ2JKnz4f3t1K
        for <linux-block@vger.kernel.org>; Wed,  1 Feb 2023 09:04:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgCHgR+Mutlj1nAgCg--.56457S3;
        Wed, 01 Feb 2023 09:04:14 +0800 (CST)
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
To:     Christoph Hellwig <hch@infradead.org>,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
 <Y9kiltmuPSbRRLsO@infradead.org>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <92d53d6b-f83d-0767-4f6a-1b897b33b227@huaweicloud.com>
Date:   Wed, 1 Feb 2023 09:04:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <Y9kiltmuPSbRRLsO@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCHgR+Mutlj1nAgCg--.56457S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1DuFy7JFWxXw1rXr15CFg_yoW8Wrykpr
        Z5XFWrKFWDWF1v9ay2ka1qqrn0gw1xtF18Aa4DAryIv39IywnI9Fyvk34Dtw15KrWkZr47
        uF45JFyIqF1SkF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Christoph

ÔÚ 2023/01/31 22:15, Christoph Hellwig Ð´µÀ:
> It might be easier to just move the check into blkdev_get_whole,
> which also ensures that non-excluisve openers don't cause a partition
> scan while someone else has the device exclusively open.
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index edc110d90df404..a831b6c9c627d7 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -666,25 +666,28 @@ static void blkdev_flush_mapping(struct block_device *bdev)
>   static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
>   {
>   	struct gendisk *disk = bdev->bd_disk;
> -	int ret;
> +	int ret = 0;
>   
> -	if (disk->fops->open) {
> +	if (disk->fops->open)
>   		ret = disk->fops->open(bdev, mode);
> -		if (ret) {
> -			/* avoid ghost partitions on a removed medium */
> -			if (ret == -ENOMEDIUM &&
> -			     test_bit(GD_NEED_PART_SCAN, &disk->state))
> -				bdev_disk_changed(disk, true);
> +
> +	if (ret) {
> +		/* avoid ghost partitions on a removed medium */
> +		if (ret != -ENOMEDIUM)
>   			return ret;
> -		}
> +	} else {
> +		if (!atomic_read(&bdev->bd_openers))
> +			set_init_blocksize(bdev);
> +		atomic_inc(&bdev->bd_openers);
>   	}
>   
> -	if (!atomic_read(&bdev->bd_openers))
> -		set_init_blocksize(bdev);
> -	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
> +	/*
> +	 * Skip the partition scan if someone else has the device exclusively
> +	 * open.
> +	 */
> +	if (test_bit(GD_NEED_PART_SCAN, &disk->state) && !bdev->bd_holder)
>   		bdev_disk_changed(disk, false);

I think this is wrong here... We should at least allow the exclusively
opener to scan partition, right?

Thanks,
Kuai

