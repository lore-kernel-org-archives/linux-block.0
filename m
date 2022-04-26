Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621BCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Apr 2022 02:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242480AbiDZCwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Apr 2022 22:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiDZCww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Apr 2022 22:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6750CB3E
        for <linux-block@vger.kernel.org>; Mon, 25 Apr 2022 19:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650941386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yWPALs8uJKV2FitTsEwzJhp/PL0P34ZnIyshRWZfzkg=;
        b=i1AZHCVYS3wSpBko2ilp4e7mmFLhIPZWV3SfRYjoCJzzcBKhM5Zz2sxdGcfoPOaNTzWlY1
        iQAvVpOC5icaOkNRgQ6p0K01qiDNKGYUMSTyEeGbX0bT0Ftxh+baYfnD2hYdzBkzwNmKUu
        hEbPJxeFs7agiezvVECYFGJIqrPCQcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-I4pNaqjQMX-MABL5JZVizQ-1; Mon, 25 Apr 2022 22:49:43 -0400
X-MC-Unique: I4pNaqjQMX-MABL5JZVizQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0524185A794;
        Tue, 26 Apr 2022 02:49:42 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5F505671D0;
        Tue, 26 Apr 2022 02:49:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] Revert "block: release rq qos structures for queue without disk"
Date:   Tue, 26 Apr 2022 10:49:36 +0800
Message-Id: <20220426024936.3321341-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit daaca3522a8e67c46e39ef09c1d542e866f85f3b.

Commit daaca3522a8e ("block: release rq qos structures for queue without
disk") is only needed for v5.15~v5.17, and isn't needed for v5.18, so
revert it.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 245ec664753d..d44a93ad8fcb 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -50,7 +50,6 @@
 #include "blk-pm.h"
 #include "blk-cgroup.h"
 #include "blk-throttle.h"
-#include "blk-rq-qos.h"
 
 struct dentry *blk_debugfs_root;
 
@@ -315,9 +314,6 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 
-	/* cleanup rq qos structures for queue without disk */
-	rq_qos_exit(q);
-
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
 
 	blk_sync_queue(q);
-- 
2.31.1

