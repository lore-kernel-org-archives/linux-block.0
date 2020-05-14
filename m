Return-Path: <SRS0=D5/G=64=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66504C433E0
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 08:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4281E20575
	for <linux-block@archiver.kernel.org>; Thu, 14 May 2020 08:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arxA8Gay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgENIp0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 04:45:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39036 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725925AbgENIp0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 04:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589445924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Nowl5Z8VIeuQ8ZkY+MtcH66StINrIz7IPkJyc9h7QS0=;
        b=arxA8GaybaH4zT65jvbj2rP93sRPuOcIeK6xF4lY0F/OaCjIsAgA3TcN2KQVdPAUau9J+P
        jX4AoKbTnVWQ7lc0yCNbowNMwj1togk0jyR2lfC1ZOS/dEs7p569OQqmFwEEfhSI7Qd2LZ
        VBrbtmxg0NiVKF8mzQl3uiHwuWNl3xE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-CCbG5HofNESB2w84AYkaUA-1; Thu, 14 May 2020 04:45:20 -0400
X-MC-Unique: CCbG5HofNESB2w84AYkaUA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CFC6835B40;
        Thu, 14 May 2020 08:45:19 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6844912A4D;
        Thu, 14 May 2020 08:45:14 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Satya Tangirala <satyat@google.com>
Subject: [PATCH] block: move blk_io_schedule() out of header file
Date:   Thu, 14 May 2020 16:45:09 +0800
Message-Id: <20200514084509.2117337-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_io_schedule() isn't called from performance sensitive code path, and
it is easier to maintain by exporting it as symbol.

Also blk_io_schedule() is only called by CONFIG_BLOCK code, so it is safe
to do this way. Meantime fixes build failure when CONFIG_BLOCK is off.

Cc: Christoph Hellwig <hch@infradead.org>
Fixes: e6249cdd46e4 ("block: add blk_io_schedule() for avoiding task hung in sync dio")
Reported-by: Satya Tangirala <satyat@google.com>
Tested-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c       | 13 +++++++++++++
 include/linux/blkdev.h | 14 ++------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index c4e306f0e6fd..6fc0b92c85b8 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -38,6 +38,7 @@
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 #include <linux/psi.h>
+#include <linux/sched/sysctl.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/block.h>
@@ -1827,6 +1828,18 @@ void blk_finish_plug(struct blk_plug *plug)
 }
 EXPORT_SYMBOL(blk_finish_plug);
 
+void blk_io_schedule(void)
+{
+	/* Prevent hang_check timer from firing at us during very long I/O */
+	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
+
+	if (timeout)
+		io_schedule_timeout(timeout);
+	else
+		io_schedule();
+}
+EXPORT_SYMBOL_GPL(blk_io_schedule);
+
 int __init blk_dev_init(void)
 {
 	BUILD_BUG_ON(REQ_OP_LAST >= (1 << REQ_OP_BITS));
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5360696d85ff..f9e4b21b051b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -27,7 +27,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/scatterlist.h>
 #include <linux/blkzoned.h>
-#include <linux/sched/sysctl.h>
 
 struct module;
 struct scsi_ioctl_command;
@@ -1221,6 +1220,8 @@ static inline bool blk_needs_flush_plug(struct task_struct *tsk)
 		 !list_empty(&plug->cb_list));
 }
 
+extern void blk_io_schedule(void);
+
 extern int blkdev_issue_flush(struct block_device *, gfp_t, sector_t *);
 extern int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct page *page);
@@ -1851,15 +1852,4 @@ static inline void blk_wake_io_task(struct task_struct *waiter)
 		wake_up_process(waiter);
 }
 
-static inline void blk_io_schedule(void)
-{
-	/* Prevent hang_check timer from firing at us during very long I/O */
-	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
-
-	if (timeout)
-		io_schedule_timeout(timeout);
-	else
-		io_schedule();
-}
-
 #endif
-- 
2.25.2

