Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A227C433EF
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 13:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbiEWNL3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 May 2022 09:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbiEWNL0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 May 2022 09:11:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B5D27160
        for <linux-block@vger.kernel.org>; Mon, 23 May 2022 06:11:25 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L6Hh86zjyzQk9W;
        Mon, 23 May 2022 21:08:24 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 21:11:23 +0800
Received: from [10.174.176.73] (10.174.176.73) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 21:11:23 +0800
Subject: Re: [PATCH V2 2/2] block: fix "Directory XXXXX with parent 'block'
 already present!"
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220423143952.3162999-1-ming.lei@redhat.com>
 <20220423143952.3162999-3-ming.lei@redhat.com>
From:   Yu Kuai <yukuai3@huawei.com>
Message-ID: <15f31e85-9023-0e31-0237-206a20ce38e6@huawei.com>
Date:   Mon, 23 May 2022 21:11:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220423143952.3162999-3-ming.lei@redhat.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Ming

Is there aggrement on the solution? I really hope this problem can be
solved...

Thansk,
Kuai

ÔÚ 2022/04/23 22:39, Ming Lei Ð´µÀ:
> q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> created when adding disk, and removed when releasing request queue.
> 
> There is small window between releasing disk and releasing request
> queue, and during the period, one disk with same name may be created
> and added, so debugfs_create_dir() may complain with "Directory XXXXX
> with parent 'block' already present!"
> 
> Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> and the dir name is named with q->id from beginning, and switched to
> disk name when adding disk, and finally changed to q->id in disk_release().
> 
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Cc: yukuai (C) <yukuai3@huawei.com>
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-core.c  | 4 ++++
>   block/blk-sysfs.c | 4 ++--
>   block/genhd.c     | 8 ++++++++
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f305cb66c72a..245ec664753d 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -438,6 +438,7 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   {
>   	struct request_queue *q;
>   	int ret;
> +	char q_name[16];
>   
>   	q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
>   			GFP_KERNEL | __GFP_ZERO, node_id);
> @@ -495,6 +496,9 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
>   	blk_set_default_limits(&q->limits);
>   	q->nr_requests = BLKDEV_DEFAULT_RQ;
>   
> +	sprintf(q_name, "%d", q->id);
> +	q->debugfs_dir = debugfs_create_dir(q_name, blk_debugfs_root);
> +
>   	return q;
>   
>   fail_stats:
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb59..1f986c20a07b 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -837,8 +837,8 @@ int blk_register_queue(struct gendisk *disk)
>   	}
>   
>   	mutex_lock(&q->debugfs_mutex);
> -	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> -					    blk_debugfs_root);
> +	q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
> +			blk_debugfs_root, kobject_name(q->kobj.parent));
>   	mutex_unlock(&q->debugfs_mutex);
>   
>   	if (queue_is_mq(q)) {
> diff --git a/block/genhd.c b/block/genhd.c
> index 36532b931841..08895f9f7087 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -25,6 +25,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/badblocks.h>
>   #include <linux/part_stat.h>
> +#include <linux/debugfs.h>
>   #include "blk-throttle.h"
>   
>   #include "blk.h"
> @@ -1160,6 +1161,7 @@ static void disk_release_mq(struct request_queue *q)
>   static void disk_release(struct device *dev)
>   {
>   	struct gendisk *disk = dev_to_disk(dev);
> +	char q_name[16];
>   
>   	might_sleep();
>   	WARN_ON_ONCE(disk_live(disk));
> @@ -1173,6 +1175,12 @@ static void disk_release(struct device *dev)
>   	kfree(disk->random);
>   	xa_destroy(&disk->part_tbl);
>   
> +	mutex_lock(&disk->queue->debugfs_mutex);
> +	sprintf(q_name, "%d", disk->queue->id);
> +	disk->queue->debugfs_dir = debugfs_rename(blk_debugfs_root,
> +			disk->queue->debugfs_dir, blk_debugfs_root, q_name);
> +	mutex_unlock(&disk->queue->debugfs_mutex);
> +
>   	disk->queue->disk = NULL;
>   	blk_put_queue(disk->queue);
>   
> 
