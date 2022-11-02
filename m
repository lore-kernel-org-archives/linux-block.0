Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F26DC433FE
	for <linux-block@archiver.kernel.org>; Wed,  2 Nov 2022 12:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKBMRn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Nov 2022 08:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBMRm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Nov 2022 08:17:42 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A623BCB
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 05:17:41 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4N2QnQ4lL1z6S3M3
        for <linux-block@vger.kernel.org>; Wed,  2 Nov 2022 20:15:06 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP1 (Coremail) with SMTP id cCh0CgCXcXrhX2Jj3Fa+BA--.40938S3;
        Wed, 02 Nov 2022 20:17:39 +0800 (CST)
Subject: Re: [PATCH 8/7] block: don't claim devices that are not live in
 bd_link_disk_holder
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20221102064854.GA8950@lst.de>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <1dc5c1d0-72b6-5455-0b05-5c755ad69045@huaweicloud.com>
Date:   Wed, 2 Nov 2022 20:17:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20221102064854.GA8950@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCXcXrhX2Jj3Fa+BA--.40938S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW7Gr1xXw1fJr48AFWkJFb_yoW8uFWrpa
        9YgFyrKry8JF47ua1qqw1UXrWY9w10gF18JasIvr1IvrW3Jrs29F1fAryUWF1Igrs2vrs0
        qF1UZayYvF1vkFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE67vI
        Y487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8
        JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

在 2022/11/02 14:48, Christoph Hellwig 写道:
> For gendisk that are not live or their partitions, the bd_holder_dir
> pointer is not valid and the kobject might not have been allocated
> yet or freed already.  Check that the disk is live before creating the
> linkage and error out otherwise.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/holder.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/block/holder.c b/block/holder.c
> index a8c355b9d0806..a8806bbed2112 100644
> --- a/block/holder.c
> +++ b/block/holder.c
> @@ -66,6 +66,11 @@ int bd_link_disk_holder(struct block_device *bdev, struct gendisk *disk)
>   		return -EINVAL;
>   
>   	mutex_lock(&disk->open_mutex);
> +	/* bd_holder_dir is only valid for live disks */
> +	if (!disk_live(bdev->bd_disk)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I think this is still not safe 🤔

How about this:

diff --git a/block/holder.c b/block/holder.c
index 5283bc804cc1..35fdfba558b8 100644
--- a/block/holder.c
+++ b/block/holder.c
@@ -85,6 +85,20 @@ int bd_link_disk_holder(struct block_device *bdev, 
struct gendisk *disk)
                 goto out_unlock;
         }

+       /*
+        * del_gendisk drops the initial reference to bd_holder_dir, so 
we need
+        * to keep our own here to allow for cleanup past that point.
+        */
+       mutex_lock(&bdev->bd_disk->open_mutex);
+       if (!disk_live(bdev->bd_disk)) {
+               ret = -ENODEV;
+               mutex_unlock(&bdev->bd_disk->open_mutex);
+               goto out_unlock;
+       }
+
+       kobject_get(bdev->bd_holder_dir);
+       mutex_unlock(&bdev->bd_disk->open_mutex);
+
         holder = kzalloc(sizeof(*holder), GFP_KERNEL);
         if (!holder) {
                 ret = -ENOMEM;
@@ -103,11 +117,6 @@ int bd_link_disk_holder(struct block_device *bdev, 
struct gendisk *disk)
         }

         list_add(&holder->list, &disk->slave_bdevs);
-       /*
-        * del_gendisk drops the initial reference to bd_holder_dir, so 
we need
-        * to keep our own here to allow for cleanup past that point.
-        */
-       kobject_get(bdev->bd_holder_dir);

bdev->bd_disk->open_mutex should be hold, both dis_live() and
kobject_get() should be protected.

Thansk,
Kuai
>   
>   	WARN_ON_ONCE(!bdev->bd_holder);
>   
> 

