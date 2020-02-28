Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A550C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 10:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C6D246A8
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 10:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgB1KOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:14:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbgB1KOw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 05:14:52 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 74996682768A73C0462D;
        Fri, 28 Feb 2020 18:14:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.66) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 28 Feb 2020
 18:14:41 +0800
Subject: Re: [PATCH V2] block: rename 'q->debugfs_dir' and 'q->blk_trace->dir'
 in blk_unregister_queue()
To:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <chaitanya.kulkarni@wdc.com>, <damien.lemoal@wdc.com>,
        <bvanassche@acm.org>, <dhowells@redhat.com>,
        <asml.silence@gmail.com>, <ajay.joshi@wdc.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>,
        <luoshijie1@huawei.com>
References: <20200213081252.32395-1-yukuai3@huawei.com>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <710eb24d-801e-b843-d02e-8a5b16b60265@huawei.com>
Date:   Fri, 28 Feb 2020 18:14:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200213081252.32395-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.66]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping...

On 2020/2/13 16:12, yu kuai wrote:
> syzbot is reporting use after free bug in debugfs_remove[1].
> 
> This is because in request_queue, 'q->debugfs_dir' and
> 'q->blk_trace->dir' could be the same dir. And in __blk_release_queue(),
> blk_mq_debugfs_unregister() will remove everything inside the dir.
> 
> With futher investigation of the reporduce repro, the problem can be
> reporduced by following procedure:
> 
> 1. LOOP_CTL_ADD, create a request_queue q1, blk_mq_debugfs_register() will
> create the dir.
> 2. LOOP_CTL_REMOVE, blk_release_queue() will add q1 to release queue.
> 3. LOOP_CTL_ADD, create another request_queue q2,blk_mq_debugfs_register()
> will fail because the dir aready exist.
> 4. BLKTRACESETUP, create two files(msg and dropped) inside the dir.
> 5. call __blk_release_queue() for q1, debugfs_remove_recursive() will
> delete the files created in step 4.
> 6. LOOP_CTL_REMOVE, blk_release_queue() will add q2 to release queue.
> And when __blk_release_queue() is called for q2, blk_trace_shutdown() will
> try to release the two files created in step 4, wich are aready released
> in step 5.
> 
> thread1		         |kworker                   |thread2
>   ----------------------- | ------------------------ | --------------------
> loop_control_ioctl       |                          |
>   loop_add                |                          |
>    blk_mq_debugfs_register|                          |
>     debugfs_create_dir    |                          |
> loop_control_ioctl       |                          |
>   loop_remove		 |                          |
>    blk_release_queue      |                          |
>     schedule_work         |                          |
>                           |                          |loop_control_ioctl
>                           |                          | loop_add
>                           |                          |  ...
>                           |                          |blk_trace_ioctl
>                           |                          | __blk_trace_setup
>                           |                          |   debugfs_create_file
>                           |__blk_release_queue       |
>                           | blk_mq_debugfs_unregister|
>                           |  debugfs_remove_recursive|
>                           |                          |loop_control_ioctl
>                           |                          | loop_remove
>                           |                          |  ...
>                           |__blk_release_queue       |
>                           | blk_trace_shutdown       |
>                           |  debugfs_remove          |
> 
> commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") pushed the
> final release of request_queue to a workqueue, so, when loop_add() is
> called again(step 3), __blk_release_queue() might not been called yet,
> which causes the problem.
> 
> Fix the problem by renaming 'q->debugfs_dir' or 'q->blk_trace->dir'
> in blk_unregister_queue() if they exist.
> 
> [1] https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
> References: CVE-2019-19770
> Fixes: commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression")
> Reported-by: syzbot <syz...@syzkaller.appspotmail.com>
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
> Changes in V2:
>   add device name to the new dir name
>   fix compile err when 'CONFIG_BLK_DEBUG_FS' is not enabled
>   add treatment of 'q->blk_trace->dir'
> 
>   block/blk-sysfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 42 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index fca9b158f4a0..1da8d4a4915a 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -11,6 +11,7 @@
>   #include <linux/blktrace_api.h>
>   #include <linux/blk-mq.h>
>   #include <linux/blk-cgroup.h>
> +#include <linux/debugfs.h>
>   
>   #include "blk.h"
>   #include "blk-mq.h"
> @@ -1011,6 +1012,46 @@ int blk_register_queue(struct gendisk *disk)
>   }
>   EXPORT_SYMBOL_GPL(blk_register_queue);
>   
> +#ifdef CONFIG_DEBUG_FS
> +/*
> + * blk_prepare_release_queue - rename q->debugfs_dir and q->blk_trace->dir
> + * @q: request_queue of which the dir to be renamed belong to.
> + *
> + * Because the final release of request_queue is in a workqueue, the
> + * cleanup might not been finished yet while the same device start to
> + * create. It's not correct if q->debugfs_dir still exist while trying
> + * to create a new one.
> + */
> +static void blk_prepare_release_queue(struct request_queue *q)
> +{
> +	struct dentry *new = NULL;
> +	struct dentry **old = NULL;
> +	char name[DNAME_INLINE_LEN];
> +	int i = 0;
> +
> +#ifdef CONFIG_BLK_DEBUG_FS
> +	if (!IS_ERR_OR_NULL(q->debugfs_dir))
> +		old = &q->debugfs_dir;
> +#endif
> +#ifdef CONFIG_BLK_DEV_IO_TRACE
> +	/* q->debugfs_dir and q->blk_trace->dir can't both exist */
> +	if (q->blk_trace && !IS_ERR_OR_NULL(q->blk_trace->dir))
> +		old = &q->blk_trace->dir;
> +#endif
> +	if (old == NULL)
> +		return;
> +	while (new == NULL) {
> +		sprintf(name, "ready_to_remove_%s_%d",
> +				kobject_name(q->kobj.parent), i++);
> +		new = debugfs_rename(blk_debugfs_root, *old,
> +				     blk_debugfs_root, name);
> +	}
> +	*old = new;
> +}
> +#else
> +#define blk_prepare_release_queue(q)		do { } while (0)
> +#endif
> +
>   /**
>    * blk_unregister_queue - counterpart of blk_register_queue()
>    * @disk: Disk of which the request queue should be unregistered from sysfs.
> @@ -1039,6 +1080,7 @@ void blk_unregister_queue(struct gendisk *disk)
>   	mutex_unlock(&q->sysfs_lock);
>   
>   	mutex_lock(&q->sysfs_dir_lock);
> +	blk_prepare_release_queue(q);
>   	/*
>   	 * Remove the sysfs attributes before unregistering the queue data
>   	 * structures that can be modified through sysfs.
> 

