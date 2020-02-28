Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB395C3F2CD
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44F1246B4
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 23:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IE8N0BuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1XQW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:16:22 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46826 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725957AbgB1XQW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 18:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582931780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FFNtyPEO7ZLHkoemtDDIXS2+6UBUM9dbd+oueyee19E=;
        b=IE8N0BuN2zLjG1R79ao46VJYi3KhZm8w4VXbg+5PLoFjOndQj+Erm5GFP0F93Bs0jT/3T2
        X2LJP9NvWhly9KdKrYnNDj7sj7ijbkGLeSpyONbLSxZBVpElIrhQPZbzlwI076BdzKPeqN
        qa5nnaDGUnCz0oAkyNLbUR+IABrQHWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-KhxuM6SaPZK063QXXdeFHQ-1; Fri, 28 Feb 2020 18:16:13 -0500
X-MC-Unique: KhxuM6SaPZK063QXXdeFHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A40698017CC;
        Fri, 28 Feb 2020 23:16:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFE4119756;
        Fri, 28 Feb 2020 23:16:02 +0000 (UTC)
Date:   Sat, 29 Feb 2020 07:15:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        ajay.joshi@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com, luoshijie1@huawei.com
Subject: Re: [PATCH V2] block: rename 'q->debugfs_dir' and
 'q->blk_trace->dir' in blk_unregister_queue()
Message-ID: <20200228231557.GA18123@ming.t460p>
References: <20200213081252.32395-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213081252.32395-1-yukuai3@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 13, 2020 at 04:12:52PM +0800, yu kuai wrote:
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
>  ----------------------- | ------------------------ | --------------------
> loop_control_ioctl       |                          |
>  loop_add                |                          |
>   blk_mq_debugfs_register|                          |
>    debugfs_create_dir    |                          |
> loop_control_ioctl       |                          |
>  loop_remove		 |                          |
>   blk_release_queue      |                          |
>    schedule_work         |                          |
>                          |                          |loop_control_ioctl
>                          |                          | loop_add
>                          |                          |  ...
>                          |                          |blk_trace_ioctl
>                          |                          | __blk_trace_setup
>                          |                          |   debugfs_create_file
>                          |__blk_release_queue       |
>                          | blk_mq_debugfs_unregister|
>                          |  debugfs_remove_recursive|
>                          |                          |loop_control_ioctl
>                          |                          | loop_remove
>                          |                          |  ...
>                          |__blk_release_queue       |
>                          | blk_trace_shutdown       |
>                          |  debugfs_remove          |
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
>  add device name to the new dir name
>  fix compile err when 'CONFIG_BLK_DEBUG_FS' is not enabled
>  add treatment of 'q->blk_trace->dir'
> 
>  block/blk-sysfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index fca9b158f4a0..1da8d4a4915a 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/blktrace_api.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk-cgroup.h>
> +#include <linux/debugfs.h>
>  
>  #include "blk.h"
>  #include "blk-mq.h"
> @@ -1011,6 +1012,46 @@ int blk_register_queue(struct gendisk *disk)
>  }
>  EXPORT_SYMBOL_GPL(blk_register_queue);
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

If blk_trace->dir isn't same with .debugfs_dir, you will just rename
blk_trace->dir, this way can't avoid the failure in step3, can it?

I understand that we just need to rename .debugfs_dir, meantime making
sure blktrace code removes correct debugfs dir, is that enough for fixing
this issue?

> +	if (old == NULL)
> +		return;
> +	while (new == NULL) {
> +		sprintf(name, "ready_to_remove_%s_%d",
> +				kobject_name(q->kobj.parent), i++);
> +		new = debugfs_rename(blk_debugfs_root, *old,
> +				     blk_debugfs_root, name);
> +	}

The above code can be run concurrently with blktrace shutdown, so race might
exit between the two code paths, then bt->dir may has been renamed or being
renamed in debugfs_remove(bt->dir), can this function work as expected or
correct?

And there is dead loop risk, so suggest to not rename this way.


Thanks, 
Ming

