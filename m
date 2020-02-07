Return-Path: <SRS0=URwg=33=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5249C352A2
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 09:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F88F20838
	for <linux-block@archiver.kernel.org>; Fri,  7 Feb 2020 09:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gq/C1ANB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgBGJau (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:30:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52176 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgBGJau (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Feb 2020 04:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581067849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2zcFcANcwriVOtEJC7Hoo2E5jNGB5E64dHe/w1kBEZ4=;
        b=gq/C1ANB5hyrTg7ieNjIjV34p5Ii4XBQby1cm6QZ3Y6Rtt18hs+TgYqgHnOE3R1MDFujWz
        pQ8oqqtlTCwDEJVHWBNsGu3Rl5FhDCY3wNYdE8HiqtHrA/H94ZGE5ln0e/MhEY9fP8GrnX
        hv2EZzD+8JCT+75HzbpNiNMNZ5aUlSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-7i6290-JOlCcw1mkqoDF5Q-1; Fri, 07 Feb 2020 04:30:42 -0500
X-MC-Unique: 7i6290-JOlCcw1mkqoDF5Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1014DB2D;
        Fri,  7 Feb 2020 09:30:40 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B7A1989A7A;
        Fri,  7 Feb 2020 09:30:30 +0000 (UTC)
Date:   Fri, 7 Feb 2020 17:30:12 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, chaitanya.kulkarni@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        ajay.joshi@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com, luoshijie1@huawei.com
Subject: Re: [PATCH] block: revert pushing the final release of request_queue
 to a workqueue.
Message-ID: <20200207093012.GA5905@ming.t460p>
References: <20200206111052.45356-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206111052.45356-1-yukuai3@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 06, 2020 at 07:10:52PM +0800, yu kuai wrote:
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

Looks we should have called blk_mq_debugfs_unregister() from
blk_unregister_queue() because blk-mq debugfs uses disk name as debugfs
dir. Not sure why blk_mq_debugfs_unregister() is called from queue's
release handler.


> 4. BLKTRACESETUP, create two files(msg and dropped) inside the dir.
> 5. call __blk_release_queue() for q1, debugfs_remove_recursive() will
> delete the files created in step 4.
> 6. LOOP_CTL_REMOVE, blk_release_queue() will add q2 to release queue.
> And when __blk_release_queue() is called for q2, blk_trace_shutdown() will
> try to release the two files created in step 4, wich are aready released
> in step 5.
> 
> |thread1		  |kworker	             |thread2               |
> | ----------------------- | ------------------------ | -------------------- |
> |loop_control_ioctl       |                          |                      |
> | loop_add                |                          |                      |
> |  blk_mq_debugfs_register|                          |                      |
> |   debugfs_create_dir    |                          |                      |
> |loop_control_ioctl       |                          |                      |
> | loop_remove		  |                          |                      |
> |  blk_release_queue      |                          |                      |
> |   schedule_work         |                          |                      |
> |			  |			     |loop_control_ioctl    |
> |			  |			     | loop_add             |
> |			  |			     |  ...                 |
> |			  |			     |blk_trace_ioctl       |
> |			  |			     | __blk_trace_setup    |
> |			  |			     |   debugfs_create_file|
> |			  |__blk_release_queue       |                      |
> |			  | blk_mq_debugfs_unregister|                      |
> |			  |  debugfs_remove_recursive|                      |
> |			  |			     |loop_control_ioctl    |
> |			  |			     | loop_remove          |
> |			  |			     |  ...                 |
> |			  |__blk_release_queue       |                      |
> |			  | blk_trace_shutdown       |                      |
> |			  |  debugfs_remove          |                      |
> 
> commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression") pushed the
> final release of request_queue to a workqueue, witch is not necessary
> since commit 1e9364283764 ("blk-sysfs: Rework documention of
> __blk_release_queue").
> 
> [1] https://syzkaller.appspot.com/bug?extid=903b72a010ad6b7a40f2
> References: CVE-2019-19770

I guess your test case is more complicated than the above CVE, which
should be triggered in single queue case.

> Fixes: commit dc9edc44de6c ("block: Fix a blk_exit_rl() regression")

As Bart mentioned, the above tag is wrong.

> Reported-by: syzbot <syz...@syzkaller.appspotmail.com>
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>  block/blk-sysfs.c      | 18 +++++-------------
>  include/linux/blkdev.h |  2 --
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index fca9b158f4a0..3f448292099d 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -862,8 +862,8 @@ static void blk_exit_queue(struct request_queue *q)
>  
>  
>  /**
> - * __blk_release_queue - release a request queue
> - * @work: pointer to the release_work member of the request queue to be released
> + * blk_release_queue - release a request queue
> + * @@kobj:    the kobj belonging to the request queue to be released
>   *
>   * Description:
>   *     This function is called when a block device is being unregistered. The
> @@ -873,9 +873,10 @@ static void blk_exit_queue(struct request_queue *q)
>   *     of the request queue reaches zero, blk_release_queue is called to release
>   *     all allocated resources of the request queue.
>   */
> -static void __blk_release_queue(struct work_struct *work)
> +static void blk_release_queue(struct kobject *kobj)
>  {
> -	struct request_queue *q = container_of(work, typeof(*q), release_work);
> +	struct request_queue *q =
> +		container_of(kobj, struct request_queue, kobj);
>  
>  	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
>  		blk_stat_remove_callback(q, q->poll_cb);
> @@ -904,15 +905,6 @@ static void __blk_release_queue(struct work_struct *work)
>  	call_rcu(&q->rcu_head, blk_free_queue_rcu);
>  }
>  
> -static void blk_release_queue(struct kobject *kobj)
> -{
> -	struct request_queue *q =
> -		container_of(kobj, struct request_queue, kobj);
> -
> -	INIT_WORK(&q->release_work, __blk_release_queue);
> -	schedule_work(&q->release_work);
> -}
> -
>  static const struct sysfs_ops queue_sysfs_ops = {
>  	.show	= queue_attr_show,
>  	.store	= queue_attr_store,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 04cfa798a365..dff4d032c78a 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -580,8 +580,6 @@ struct request_queue {
>  
>  	size_t			cmd_size;
>  
> -	struct work_struct	release_work;
> -

Looks this approach isn't correct:

1) there are other sleepers in __blk_release_queue(), such blk-mq sysfs
kobject_put(), or cancel_delayed_work_sync(), ...

2) wrt. loop, the request queue's release handler may not be called yet
after loop_remove() returns, so this patch may not avoid the issue in
your step 3 in which blk_mq_debugfs_register fails when adding new loop
device. So release not by wq just reduces the chance, instead of fixing
it completely.

Thanks,
Ming

