Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8565C433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 12:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiKBMWd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKBMWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 08:22:32 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469E29344
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 05:22:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2Qtx6VQGz6P8J4
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 20:19:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgD33NECYWJjG8T2BA--.21321S3;
        Wed, 02 Nov 2022 20:22:26 +0800 (CST)
Subject: Re: [PATCH 8/7] block: don't claim devices that are not live in
 bd_link_disk_holder
To:     Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20221102064854.GA8950@lst.de>
 <1dc5c1d0-72b6-5455-0b05-5c755ad69045@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <2a618e55-33d7-1090-c906-0b44ad4832b8@huaweicloud.com>
Date:   Wed, 2 Nov 2022 20:22:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1dc5c1d0-72b6-5455-0b05-5c755ad69045@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgD33NECYWJjG8T2BA--.21321S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fWF4fWFWUZr4ftFyDtrb_yoW5WFW3pr
        95KrW8GryUJr1kXF4Utw1UXFy5Zw1UJ3W8Jrn7XF12qr43Jr4qvr1UXryjgr17Jr4Ivr4U
        Jr1UXr43ZF1UCrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUF9a9DU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

在 2022/11/02 20:17, Yu Kuai 写道:
> Hi,
> 
> 在 2022/11/02 14:48, Christoph Hellwig 写道:
>> For gendisk that are not live or their partitions, the bd_holder_dir
>> pointer is not valid and the kobject might not have been allocated
>> yet or freed already.  Check that the disk is live before creating the
>> linkage and error out otherwise.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/holder.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/block/holder.c b/block/holder.c
>> index a8c355b9d0806..a8806bbed2112 100644
>> --- a/block/holder.c
>> +++ b/block/holder.c
>> @@ -66,6 +66,11 @@ int bd_link_disk_holder(struct block_device *bdev, 
>> struct gendisk *disk)
>>           return -EINVAL;
>>       mutex_lock(&disk->open_mutex);
>> +    /* bd_holder_dir is only valid for live disks */
>> +    if (!disk_live(bdev->bd_disk)) {
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
> 
> I think this is still not safe 🤔
> 
> How about this:
> 
> diff --git a/block/holder.c b/block/holder.c
> index 5283bc804cc1..35fdfba558b8 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -85,6 +85,20 @@ int bd_link_disk_holder(struct block_device *bdev, 
> struct gendisk *disk)
>                  goto out_unlock;
>          }
> 
> +       /*
> +        * del_gendisk drops the initial reference to bd_holder_dir, so 
> we need
> +        * to keep our own here to allow for cleanup past that point.
> +        */
> +       mutex_lock(&bdev->bd_disk->open_mutex);
> +       if (!disk_live(bdev->bd_disk)) {
> +               ret = -ENODEV;
> +               mutex_unlock(&bdev->bd_disk->open_mutex);
> +               goto out_unlock;
> +       }
> +
> +       kobject_get(bdev->bd_holder_dir);
> +       mutex_unlock(&bdev->bd_disk->open_mutex);
> +
>          holder = kzalloc(sizeof(*holder), GFP_KERNEL);
>          if (!holder) {
>                  ret = -ENOMEM;
> @@ -103,11 +117,6 @@ int bd_link_disk_holder(struct block_device *bdev, 
> struct gendisk *disk)
>          }
> 
>          list_add(&holder->list, &disk->slave_bdevs);
> -       /*
> -        * del_gendisk drops the initial reference to bd_holder_dir, so 
> we need
> -        * to keep our own here to allow for cleanup past that point.
> -        */
> -       kobject_get(bdev->bd_holder_dir);
> 
> bdev->bd_disk->open_mutex should be hold, both dis_live() and
> kobject_get() should be protected.
> 

And kobject reference should be decreased in the following error path

Thanks,
Kuai

