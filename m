Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D831C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 10:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03A8A60295
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 10:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbhJZKPC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 06:15:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42504 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234341AbhJZKPB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635243158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MUWeAnkmCXxskoYpNhqSlCYbD0/gmEs3noUV5WuWzjE=;
        b=g3W1X0jRjb1ky838MI4GsvRpXnXK+W3cD8xuPdjYjXLFV8Y06ZQXOgZ6kmbJmzpmosU4BO
        kKVmNu6Z+MyHLKzGGzc3qL0DUvITZ6chXpgFMW6umg3c/8kZVkf2cTXy6hGLBtUxRlFFg5
        s7aqq9VZi0I6Iqqp4EPnsb7dwNZwgmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-JJbJ0wL9PKqLZr8yehxJlg-1; Tue, 26 Oct 2021 06:12:36 -0400
X-MC-Unique: JJbJ0wL9PKqLZr8yehxJlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 892BC18414A2;
        Tue, 26 Oct 2021 10:12:35 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6A515D6BA;
        Tue, 26 Oct 2021 10:12:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] block: drain queue after disk is removed from sysfs
Date:   Tue, 26 Oct 2021 18:12:04 +0800
Message-Id: <20211026101204.2897166-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before removing disk from sysfs, userspace still may change queue via
sysfs, such as switching elevator or setting wbt latency, both may
reinitialize wbt, then the warning in blk_free_queue_stats() will be
triggered since rq_qos_exit() is moved to del_gendisk().

Fixes the issue by moving draining queue & tearing down after disk is
removed from sysfs, at that time no one can come into queue's
store()/show().

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Fixes: 8e141f9eb803 ("block: drain file system I/O on del_gendisk")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/genhd.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 64f83c4aee99..2052aeffa39b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -589,16 +589,6 @@ void del_gendisk(struct gendisk *disk)
 	 * Prevent new I/O from crossing bio_queue_enter().
 	 */
 	blk_queue_start_drain(q);
-	blk_mq_freeze_queue_wait(q);
-
-	rq_qos_exit(q);
-	blk_sync_queue(q);
-	blk_flush_integrity();
-	/*
-	 * Allow using passthrough request again after the queue is torn down.
-	 */
-	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
-	__blk_mq_unfreeze_queue(q, true);
 
 	if (!(disk->flags & GENHD_FL_HIDDEN)) {
 		sysfs_remove_link(&disk_to_dev(disk)->kobj, "bdi");
@@ -621,6 +611,18 @@ void del_gendisk(struct gendisk *disk)
 		sysfs_remove_link(block_depr, dev_name(disk_to_dev(disk)));
 	pm_runtime_set_memalloc_noio(disk_to_dev(disk), false);
 	device_del(disk_to_dev(disk));
+
+	blk_mq_freeze_queue_wait(q);
+
+	rq_qos_exit(q);
+	blk_sync_queue(q);
+	blk_flush_integrity();
+	/*
+	 * Allow using passthrough request again after the queue is torn down.
+	 */
+	blk_queue_flag_clear(QUEUE_FLAG_INIT_DONE, q);
+	__blk_mq_unfreeze_queue(q, true);
+
 }
 EXPORT_SYMBOL(del_gendisk);
 
-- 
2.31.1

