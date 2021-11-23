Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30569C433FE
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhKWS4a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbhKWS43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65415C061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7nEqMYsJhbdlX5eIb63u3eZVXGHGiChmlRNPsu/7+us=; b=gWkS8myWDQLdMJRvEfoEZLVY5h
        JxssYgc/GutnYGHJPcm0Z6YjIK2qBXOgIed3eCdYaThSWLgHnHqNpPvuC41i0zyW8GHXG1XPycOwb
        +rt9SpDqH86QpVzt3W4vkXEoKriQNpiz8DA03Gqnbq5kuVRDSr8lKwOYH+fnaz0vQkhN+8uKw90wM
        07pkc5bbwjGxGXAvuBsN7ODEd/pJM/xQ0su0oRozZ/h1LCxwvwpqvoF5YHmC86uMdoczuP1DcRYus
        ZX34m9vHvazlKEWmIZQ8uq7piYqrXdB6k3dPaq5bgm0dsWtQAac+fm93yMInPI10iWkx1qPLXwj4X
        0QN1luHg==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpaut-00FzSB-0W; Tue, 23 Nov 2021 18:53:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: don't include blk-mq-sched.h in blk.h
Date:   Tue, 23 Nov 2021 19:53:08 +0100
Message-Id: <20211123185312.1432157-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No needed, shift it into the source files that need it instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c       | 1 +
 block/blk-ioc.c        | 1 +
 block/blk-merge.c      | 1 +
 block/blk-mq-debugfs.c | 1 +
 block/blk-sysfs.c      | 1 +
 block/blk.h            | 1 -
 block/genhd.c          | 1 +
 7 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 6ae8297b033f7..f9b77f4ce3703 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -46,6 +46,7 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-mq-sched.h"
 #include "blk-pm.h"
 #include "blk-throttle.h"
 
diff --git a/block/blk-ioc.c b/block/blk-ioc.c
index 736e0280d76f7..35c6b26a9f776 100644
--- a/block/blk-ioc.c
+++ b/block/blk-ioc.c
@@ -11,6 +11,7 @@
 #include <linux/sched/task.h>
 
 #include "blk.h"
+#include "blk-mq-sched.h"
 
 /*
  * For io context allocations
diff --git a/block/blk-merge.c b/block/blk-merge.c
index ba761c3f482ba..456fb88c49b1d 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -12,6 +12,7 @@
 #include <trace/events/block.h>
 
 #include "blk.h"
+#include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 #include "blk-throttle.h"
 
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 4f2cf8399f3de..d83ae7dac6081 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -11,6 +11,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
+#include "blk-mq-sched.h"
 #include "blk-mq-tag.h"
 #include "blk-rq-qos.h"
 
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 87ce3b1414c81..73b4a8730dc4d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -16,6 +16,7 @@
 #include "blk.h"
 #include "blk-mq.h"
 #include "blk-mq-debugfs.h"
+#include "blk-mq-sched.h"
 #include "blk-wbt.h"
 #include "blk-throttle.h"
 
diff --git a/block/blk.h b/block/blk.h
index 4df2ce8d4999b..db6efa351d3ec 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -10,7 +10,6 @@
 #include <xen/xen.h>
 #include "blk-crypto-internal.h"
 #include "blk-mq.h"
-#include "blk-mq-sched.h"
 
 struct elevator_type;
 
diff --git a/block/genhd.c b/block/genhd.c
index 8e9cbf23c510a..01606db8c625d 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -27,6 +27,7 @@
 #include <linux/badblocks.h>
 
 #include "blk.h"
+#include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
 
 static struct kobject *block_depr;
-- 
2.30.2

