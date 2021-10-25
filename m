Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C01C433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BB06054F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 09:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbhJYJte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 05:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232773AbhJYJri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 05:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635155116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o/S6HQ4Ssm1A8LulMUp+0nugUdaKq+w0SOncyS3ljZ8=;
        b=DLFmbt/PQfwUWUfPKLTJqCwPJp4PxANp2gB4aXV1BrGHab2rd7z6tk5h5+pCfZCxQLQgah
        J9X22C6K5NeHi7NajKAn+2TTVjRMQSdvXjW2bPyMB1Uhx54FZsgcRW3FsmXBoIKhdK/W02
        NuoVInNOB+kua7c/0csR8EApCrgmX7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-kbRTtmYtPbehZfefj7z6Sg-1; Mon, 25 Oct 2021 05:45:11 -0400
X-MC-Unique: kbRTtmYtPbehZfefj7z6Sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D3698C12A1;
        Mon, 25 Oct 2021 09:45:10 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A67560BF4;
        Mon, 25 Oct 2021 09:45:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 7/8] loop: remove lo->use_dio
Date:   Mon, 25 Oct 2021 17:44:36 +0800
Message-Id: <20211025094437.2837701-8-ming.lei@redhat.com>
In-Reply-To: <20211025094437.2837701-1-ming.lei@redhat.com>
References: <20211025094437.2837701-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

lo->use_dio is just a copy of (lo->lo_flags & LO_FLAGS_DIRECT_IO), no
necessary to keep it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 12 +++++-------
 drivers/block/loop.h |  1 -
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f42630246758..e42c0e3601ac 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -226,13 +226,12 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		use_dio = false;
 	}
 
-	if (lo->use_dio == use_dio)
+	if (!!(lo->lo_flags & LO_FLAGS_DIRECT_IO) == use_dio)
 		return;
 
 	/* flush dirty pages before changing direct IO */
 	vfs_fsync(file, 0);
 
-	lo->use_dio = use_dio;
 	if (use_dio) {
 		blk_queue_flag_clear(QUEUE_FLAG_NOMERGES, lo->lo_queue);
 		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
@@ -622,7 +621,7 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
 static inline void loop_update_dio(struct loop_device *lo)
 {
 	__loop_update_dio(lo, (lo->lo_backing_file->f_flags & O_DIRECT) |
-				lo->use_dio);
+				(lo->lo_flags & LO_FLAGS_DIRECT_IO));
 }
 
 static void loop_reread_partitions(struct loop_device *lo)
@@ -1207,7 +1206,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	lo->worker_tree = RB_ROOT;
 	timer_setup(&lo->timer, loop_free_idle_workers,
 		TIMER_DEFERRABLE);
-	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
 	lo->lo_device = bdev;
 	lo->lo_backing_file = file;
 	lo->old_gfp_mask = mapping_gfp_mask(mapping);
@@ -1495,7 +1493,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	loop_config_discard(lo);
 
 	/* update dio if lo_offset or transfer is changed */
-	__loop_update_dio(lo, lo->use_dio);
+	__loop_update_dio(lo, lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
 out_unfreeze:
 	blk_mq_unfreeze_queue(lo->lo_queue);
@@ -1682,7 +1680,7 @@ static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 		goto out;
 
 	__loop_update_dio(lo, !!arg);
-	if (lo->use_dio == !!arg)
+	if (!!(lo->lo_flags & LO_FLAGS_DIRECT_IO) == !!arg)
 		return 0;
 	error = -EINVAL;
  out:
@@ -2094,7 +2092,7 @@ static blk_status_t loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		break;
 	default:
 		cmd->use_aio = !lo->transfer;
-		cmd->use_dio = lo->use_dio && cmd->use_aio;
+		cmd->use_dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO) && cmd->use_aio;
 		break;
 	}
 
diff --git a/drivers/block/loop.h b/drivers/block/loop.h
index b7d611e4f517..feb92efb3b57 100644
--- a/drivers/block/loop.h
+++ b/drivers/block/loop.h
@@ -61,7 +61,6 @@ struct loop_device {
 	struct list_head        idle_worker_list;
 	struct rb_root          worker_tree;
 	struct timer_list       timer;
-	bool			use_dio;
 	bool			sysfs_inited;
 
 	struct request_queue	*lo_queue;
-- 
2.31.1

