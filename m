Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A07DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Apr 2022 02:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiDVCzp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352185AbiDVCzo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 22:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA0884D266
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 19:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650595970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mgRvJTkWinEYm+uYE1pdoXTgJf9s7yC4/9X/JS6ceA=;
        b=EyhCGv3d/cWhyrPP1oIVyi8EFmpyrfEckS6vLc1TEgsh0fYj7ENXrezEIO2h9J6h+stj0d
        O+c+y1olzsHGxULqR0iswJSmCuJx9yZ7BytspzHCLcS+yd58ppQCVmDyqd/77BuDCMTjVC
        qRsw/AQSbVFYFFeM/N+0xcXu8JpwoZ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-q5Vv563RPSSndGNiu45Kgg-1; Thu, 21 Apr 2022 22:52:49 -0400
X-MC-Unique: q5Vv563RPSSndGNiu45Kgg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 024F4101AA42;
        Fri, 22 Apr 2022 02:52:49 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DC66A416151;
        Fri, 22 Apr 2022 02:52:44 +0000 (UTC)
Date:   Fri, 22 Apr 2022 10:52:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: fix "Directory XXXXX with parent 'block' already
 present!"
Message-ID: <YmIYdzOGRPFGMA4v@T590>
References: <20220421083431.2917311-1-ming.lei@redhat.com>
 <54eea05d-bd3a-22ca-eab0-0bb493631f6c@suse.de>
 <9648097e-25a5-009e-c95f-6a76ea606f5b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9648097e-25a5-009e-c95f-6a76ea606f5b@huawei.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 22, 2022 at 09:23:40AM +0800, yukuai (C) wrote:
> 在 2022/04/22 1:28, Hannes Reinecke 写道:
> > On 4/21/22 10:34, Ming Lei wrote:
> > > q->debugfs_dir is used by blk-mq debugfs and blktrace. The dentry is
> > > created when adding disk, and removed when releasing request queue.
> > > 
> > > There is small window between releasing disk and releasing request
> > > queue, and during the period, one disk with same name may be created
> > > and added, so debugfs_create_dir() may complain with "Directory XXXXX
> > > with parent 'block' already present!"
> > > 
> > > Fixes the issue by moving debugfs_create_dir() into blk_alloc_queue(),
> > > and the dir name is named with q->id from beginning, and switched to
> > > disk name when adding disk, and finally changed to q->id in
> > > disk_release().
> > > 
> > > Reported-by: Dan Williams <dan.j.williams@intel.com>
> > > Cc: yukuai (C) <yukuai3@huawei.com>
> > > Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > ---
> > >   block/blk-core.c  | 4 ++++
> > >   block/blk-sysfs.c | 4 ++--
> > >   block/genhd.c     | 8 ++++++++
> > >   3 files changed, 14 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/block/blk-core.c b/block/blk-core.c
> > > index f305cb66c72a..245ec664753d 100644
> > > --- a/block/blk-core.c
> > > +++ b/block/blk-core.c
> > > @@ -438,6 +438,7 @@ struct request_queue *blk_alloc_queue(int
> > > node_id, bool alloc_srcu)
> > >   {
> > >       struct request_queue *q;
> > >       int ret;
> > > +    char q_name[16];
> > >       q = kmem_cache_alloc_node(blk_get_queue_kmem_cache(alloc_srcu),
> > >               GFP_KERNEL | __GFP_ZERO, node_id);
> > > @@ -495,6 +496,9 @@ struct request_queue *blk_alloc_queue(int
> > > node_id, bool alloc_srcu)
> > >       blk_set_default_limits(&q->limits);
> > >       q->nr_requests = BLKDEV_DEFAULT_RQ;
> > > +    sprintf(q_name, "%d", q->id);
> > > +    q->debugfs_dir = debugfs_create_dir(q_name, blk_debugfs_root);
> > > +
> > >       return q;
> > >   fail_stats:
> > > diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> > > index 88bd41d4cb59..1f986c20a07b 100644
> > > --- a/block/blk-sysfs.c
> > > +++ b/block/blk-sysfs.c
> > > @@ -837,8 +837,8 @@ int blk_register_queue(struct gendisk *disk)
> > >       }
> > >       mutex_lock(&q->debugfs_mutex);
> > > -    q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
> > > -                        blk_debugfs_root);
> > > +    q->debugfs_dir = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
> > > +            blk_debugfs_root, kobject_name(q->kobj.parent));
> > >       mutex_unlock(&q->debugfs_mutex);
> > >       if (queue_is_mq(q)) {
> > > diff --git a/block/genhd.c b/block/genhd.c
> > > index 36532b931841..08895f9f7087 100644
> > > --- a/block/genhd.c
> > > +++ b/block/genhd.c
> > > @@ -25,6 +25,7 @@
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/badblocks.h>
> > >   #include <linux/part_stat.h>
> > > +#include <linux/debugfs.h>
> > >   #include "blk-throttle.h"
> > >   #include "blk.h"
> > > @@ -1160,6 +1161,7 @@ static void disk_release_mq(struct
> > > request_queue *q)
> > >   static void disk_release(struct device *dev)
> > >   {
> > >       struct gendisk *disk = dev_to_disk(dev);
> > > +    char q_name[16];
> > >       might_sleep();
> > >       WARN_ON_ONCE(disk_live(disk));
> > > @@ -1173,6 +1175,12 @@ static void disk_release(struct device *dev)
> > >       kfree(disk->random);
> > >       xa_destroy(&disk->part_tbl);
> > > +    mutex_lock(&disk->queue->debugfs_mutex);
> > > +    sprintf(q_name, "%d", disk->queue->id);
> > > +    disk->queue->debugfs_dir = debugfs_rename(blk_debugfs_root,
> > > +            disk->queue->debugfs_dir, blk_debugfs_root, q_name);
> > > +    mutex_unlock(&disk->queue->debugfs_mutex);
> > > +
> > >       disk->queue->disk = NULL;
> > >       blk_put_queue(disk->queue);
> > 
> > I don't think this is the right approach.
> >  From my POV the underlying reason is an imbalance between
> > debugfs_create_dir() (which happens in blk_register_queue()) and
> > debugfs_remove_dir() (which happens in blk_release_queue())
> > 
> > So there is a small race window between blk_unregister_queue() and
> > blk_release_queue(), during which the queue might be re-registered and
> > then traipses over the (still-existant) queue.
> > 
> > So we should rather move the call to debugfs_remove_dir() into
> > blk_unregister_queue() to have them both symmetric.
> > 
> > Basically the patch '[PATCH RESEND] blk-mq: fix possible creation
> > failure for 'debugfs_dir'' from yukuai ...
> Hi,
> 
> I forgot to move 'q->rqos_debugfs_dir' which causes a UAF in
> block/002, and Ming was worried that:
> 
> blktrace still may work for passthrough req trace after disk is
> deleted.

There are other issues in your patch:

- "debugfs directory deleted with blktrace active" in block/002 could
be triggered.

- disk_release_mq() calls elevator_exit()/rq_qos_exit(), and the two
may trigger UAF if q->debugfs_dir is removed in blk_unregister_queue().

> 
> I can shutdown blktrace in blk_unregister_queue(), however I was
> worried that concurrent blk_trace_setup() might reenable it.

blktrace does work for tracing passthrough request after
disk is removed, and your patch makes it not possible.

blk_trace_shutdown() should have been done after releasing disk.


Thanks, 
Ming

