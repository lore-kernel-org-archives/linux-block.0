Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F154FC38A02
	for <linux-block@archiver.kernel.org>; Mon, 31 Oct 2022 01:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJaBwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 21:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaBwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 21:52:09 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567306550
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 18:52:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N0x105lR4zl9vT
        for <linux-block@vger.kernel.org>; Mon, 31 Oct 2022 09:49:56 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgC3E+ZFKl9jpbbdAQ--.1600S3;
        Mon, 31 Oct 2022 09:52:06 +0800 (CST)
Subject: Re: [PATCH 7/7] block: store the holder kobject in bd_holder_disk
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221030153120.1045101-1-hch@lst.de>
 <20221030153120.1045101-8-hch@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <fd409996-e5e1-d7af-b31d-87db943eaa25@huaweicloud.com>
Date:   Mon, 31 Oct 2022 09:52:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221030153120.1045101-8-hch@lst.de>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC3E+ZFKl9jpbbdAQ--.1600S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWxKw4UGF17GF1DtrWDArb_yoW5Cr1DpF
        Z8XFyxtrW8Ga1UWw4jgw47uFyjvryYq3W8CFyI9ryS9rZ8Jr1vkr13Jr1UJFWxGrZ7trs0
        qF47Xws8AF4qkFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi

ÔÚ 2022/10/30 23:31, Christoph Hellwig Ð´µÀ:
> We hold a reference to the holder kobject for each bd_holder_disk,
> so to make the code a bit more robust, use a reference to it instead
> of the block_device.  As long as no one clears ->bd_holder_dir in
> before freeing the disk, this isn't strictly required, but it does
> make the code more clear and more robust.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/holder.c | 23 ++++++++++-------------
>   1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/block/holder.c b/block/holder.c
> index dd9327b43ce05..a8c355b9d0806 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -4,7 +4,7 @@
>   
>   struct bd_holder_disk {
>   	struct list_head	list;
> -	struct block_device	*bdev;
> +	struct kobject		*holder_dir;
>   	int			refcnt;
>   };
>   
> @@ -14,7 +14,7 @@ static struct bd_holder_disk *bd_find_holder_disk(struct block_device *bdev,
>   	struct bd_holder_disk *holder;
>   
>   	list_for_each_entry(holder, &disk->slave_bdevs, list)
> -		if (holder->bdev == bdev)
> +		if (holder->holder_dir == bdev->bd_holder_dir)
>   			return holder;
>   	return NULL;
>   }
> @@ -82,27 +82,24 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	}
>   
>   	INIT_LIST_HEAD(&holder->list);
> -	holder->bdev = bdev;
>   	holder->refcnt = 1;
> +	holder->holder_dir = kobject_get(bdev->bd_holder_dir);

I wonder is this safe here, if kobject reference is 0 here and
bd_holder_dir is about to be freed. Here in kobject_get, kref_get() will
warn about uaf, and kobject_get will return a address that is about to
be freed.

Thansk,
Kuai
> +
>   	ret = add_symlink(disk->slave_dir, bdev_kobj(bdev));
>   	if (ret)
> -		goto out_free_holder;
> -	ret = add_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> +		goto out_put_holder_dir;
> +	ret = add_symlink(holder->holder_dir, &disk_to_dev(disk)->kobj);
>   	if (ret)
>   		goto out_del_symlink;
>   	list_add(&holder->list, &disk->slave_bdevs);
>   
> -	/*
> -	 * del_gendisk drops the initial reference to bd_holder_dir, so we need
> -	 * to keep our own here to allow for cleanup past that point.
> -	 */
> -	kobject_get(bdev->bd_holder_dir);
>   	mutex_unlock(&disk->open_mutex);
>   	return 0;
>   
>   out_del_symlink:
>   	del_symlink(disk->slave_dir, bdev_kobj(bdev));
> -out_free_holder:
> +out_put_holder_dir:
> +	kobject_put(holder->holder_dir);
>   	kfree(holder);
>   out_unlock:
>   	mutex_unlock(&disk->open_mutex);
> @@ -131,8 +128,8 @@ void bd_unlink_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   	holder = bd_find_holder_disk(bdev, disk);
>   	if (!WARN_ON_ONCE(holder == NULL) && !--holder->refcnt) {
>   		del_symlink(disk->slave_dir, bdev_kobj(bdev));
> -		del_symlink(bdev->bd_holder_dir, &disk_to_dev(disk)->kobj);
> -		kobject_put(bdev->bd_holder_dir);
> +		del_symlink(holder->holder_dir, &disk_to_dev(disk)->kobj);
> +		kobject_put(holder->holder_dir);
>   		list_del_init(&holder->list);
>   		kfree(holder);
>   	}
> 

