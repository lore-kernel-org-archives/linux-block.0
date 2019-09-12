Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F477C49ED9
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 04:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0337921479
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 04:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbfILECh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 00:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfILECh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 00:02:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D0B21308FBFC;
        Thu, 12 Sep 2019 04:02:36 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0FA05D9D5;
        Thu, 12 Sep 2019 04:02:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block: fix race between switching elevator and removing queues
Date:   Thu, 12 Sep 2019 12:02:24 +0800
Message-Id: <20190912040224.7554-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 12 Sep 2019 04:02:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cecf5d87ff20 ("block: split .sysfs_lock into two locks") starts to
release & actuire sysfs_lock again during switching elevator. So it
isn't enough to prevent switching elevator from happening by simply
clearing QUEUE_FLAG_REGISTERED with holding sysfs_lock, because
in-progress switch still can move on after re-acquiring the lock,
meantime the flag of QUEUE_FLAG_REGISTERED won't get checked.

Fixes this issue by checking 'q->elevator' directly & locklessly after
q->kobj is removed in blk_unregister_queue(), this way is safe because
q->elevator can't be changed at that time.

Fixes: cecf5d87ff20 ("block: split .sysfs_lock into two locks")
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 107513495220..3af79831e717 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -1030,7 +1030,6 @@ EXPORT_SYMBOL_GPL(blk_register_queue);
 void blk_unregister_queue(struct gendisk *disk)
 {
 	struct request_queue *q = disk->queue;
-	bool has_elevator;
 
 	if (WARN_ON(!q))
 		return;
@@ -1046,7 +1045,6 @@ void blk_unregister_queue(struct gendisk *disk)
 	 */
 	mutex_lock(&q->sysfs_lock);
 	blk_queue_flag_clear(QUEUE_FLAG_REGISTERED, q);
-	has_elevator = !!q->elevator;
 	mutex_unlock(&q->sysfs_lock);
 
 	mutex_lock(&q->sysfs_dir_lock);
@@ -1061,7 +1059,11 @@ void blk_unregister_queue(struct gendisk *disk)
 	kobject_del(&q->kobj);
 	blk_trace_remove_sysfs(disk_to_dev(disk));
 
-	if (has_elevator)
+	/*
+	 * q->kobj has been removed, so it is safe to check if elevator
+	 * exists without holding q->sysfs_lock.
+	 */
+	if (q->elevator)
 		elv_unregister_queue(q);
 	mutex_unlock(&q->sysfs_dir_lock);
 
-- 
2.20.1

