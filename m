Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A9AC433EF
	for <linux-block@archiver.kernel.org>; Sun, 16 Jan 2022 04:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiAPETS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jan 2022 23:19:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52890 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230092AbiAPETS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jan 2022 23:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642306757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biGUH1oiTGywnoaM3JKSTu9JpCIQbrwqgYqLkaPFOEU=;
        b=Jp2VPd3aKzjLaBaw4HkTi+rCOdkJZc5vq7g89fAO0t7Se/EhI5whbkchTfgOMQCXNsd2Tf
        NRMz+xQDM4nO7cW4ZE3/infRZErw71ASfmYMvTsLW8uwhKypulsZSXswjx6L4KjpZ3uc27
        RB2sxsQuod3/3/98vfthmLil0LJbYRg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-186-4rEg_21XM7uTBi0X3yoVxQ-1; Sat, 15 Jan 2022 23:19:14 -0500
X-MC-Unique: 4rEg_21XM7uTBi0X3yoVxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3EEF218397A7;
        Sun, 16 Jan 2022 04:19:13 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0182E60657;
        Sun, 16 Jan 2022 04:19:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] block: move freeing disk into queue's release handler
Date:   Sun, 16 Jan 2022 12:18:13 +0800
Message-Id: <20220116041815.1218170-2-ming.lei@redhat.com>
In-Reply-To: <20220116041815.1218170-1-ming.lei@redhat.com>
References: <20220116041815.1218170-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

So far block_device(for disk), gendisk and request queue are supposed to
be killed at the same time, because we can retrieve request queue from both
block_device->bd_queue and gendisk->queue directly, meantime disk is
associated with request queue directly via q->disk. Also request queue's
refcnt is grabbed when allocating disk, and released in disk's release
handler.

Also we put request queue in disk_release() and clear queue->disk there.
Meantime disk can be released before running blk_cleanup_queue(). This
way isn't reliable:

- some block core code(blk-cgroup, io scheduler, ...) usually deals with
request queue only, and sometimes they need to retrieve disk info via q->disk,
but both io scheduler and blk-cgroup are shutdown in blk_release_queue()
actually, and q->disk can be cleared before releasing queue.

- q->disk is referred in fast io code path, such as io account code, but
q->disk can be cleared when queue is active since queue is still needed
for handling passthrough/private request after disk is deleted

Move freeing disk into queue's release handler, so that block_device(for
disk), gendisk and request queue can be removed at the same time basically,
then q->disk can be used reliably. This way is reasonable too, since
request queue becomes dying actually in del_gendisk(), see commit
8e141f9eb803 ("block: drain file system I/O on del_gendisk").

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 13 +++++++++++++
 block/genhd.c     |  7 +++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e20eadfcf5c8..dc8af443b29b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -12,6 +12,7 @@
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
 #include <linux/debugfs.h>
+#include <linux/fs.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -811,6 +812,18 @@ static void blk_release_queue(struct kobject *kobj)
 
 	bioset_exit(&q->bio_split);
 
+	/*
+	 * Free associated disk now if there is.
+	 *
+	 * Follows cases in which request queue hasn't disk:
+	 *
+	 * - not active LUN probed for scsi host
+	 *
+	 * - nvme's admin queue
+	 */
+	if (q->disk)
+		iput(q->disk->part0->bd_inode);
+
 	ida_simple_remove(&blk_queue_ida, q->id);
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a..6357cab37eef 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1112,9 +1112,12 @@ static void disk_release(struct device *dev)
 	disk_release_events(disk);
 	kfree(disk->random);
 	xa_destroy(&disk->part_tbl);
-	disk->queue->disk = NULL;
+
+	/*
+	 * delay freeing disk/and its bdev into request queue's release
+	 * handler, then all can be killed at the same time
+	 */
 	blk_put_queue(disk->queue);
-	iput(disk->part0->bd_inode);	/* frees the disk */
 }
 
 static int block_uevent(struct device *dev, struct kobj_uevent_env *env)
-- 
2.31.1

