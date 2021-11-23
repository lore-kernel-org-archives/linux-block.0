Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425B4C433F5
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 18:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbhKWS4h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 13:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238515AbhKWS4g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 13:56:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76ACFC061574
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 10:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=z8Xr/Z/0PP4SdcHgiteRdf2lJOhryKJbOn4LkfOh/n4=; b=HHVqFkzf3Vi/9BIOzpnjdaAuyz
        uVOEqMZ51btQaR2AIwTAShduq7mtJQ71/TOCVt7+3rbnR9+JjMDC9VsGB0X+K3PPIqTBWGKhP/1Pr
        t308DyPQio0BfHHwhZYtOJQLXBXmzIQ4McmNpz0hTj2W+5CGLg33z/WQzEaLRJVwflZkwp0SMWx2d
        gytUrkK32Df/8IZcTKaRlBscL7i5ZDy8ig2N4zoTIMYzk+klnVggcS38hghiXzN823Z879MxQ7mpA
        mlQQCWMOpD4BsX9QuiKiiGGcT2jh1i0Q7EMNGC6Y783Gtkfbu2vnezqW79OOBj7wmi8HOa+P++PHJ
        5tAYDJzQ==;
Received: from [2001:4bb8:191:f9ce:a710:1fc3:2b4:5435] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpauz-00FzTk-VG; Tue, 23 Nov 2021 18:53:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 8/8] block: don't include <linux/part_stat.h> in blk.h
Date:   Tue, 23 Nov 2021 19:53:12 +0100
Message-Id: <20211123185312.1432157-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123185312.1432157-1-hch@lst.de>
References: <20211123185312.1432157-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not needed, shift it into the source files that need it instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 1 +
 block/blk-core.c   | 1 +
 block/blk-flush.c  | 1 +
 block/blk-merge.c  | 1 +
 block/blk-mq.c     | 1 +
 block/blk.h        | 1 -
 block/genhd.c      | 1 +
 7 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 663aabfeba183..650f7e27989f1 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -30,6 +30,7 @@
 #include <linux/blk-cgroup.h>
 #include <linux/tracehook.h>
 #include <linux/psi.h>
+#include <linux/part_stat.h>
 #include "blk.h"
 #include "blk-ioprio.h"
 #include "blk-throttle.h"
diff --git a/block/blk-core.c b/block/blk-core.c
index f9b77f4ce3703..143cc21db5ef5 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -39,6 +39,7 @@
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
 #include <linux/psi.h>
+#include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
 
diff --git a/block/blk-flush.c b/block/blk-flush.c
index 86ee50455e414..902e80e48e4ae 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -69,6 +69,7 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
+#include <linux/part_stat.h>
 
 #include "blk.h"
 #include "blk-mq.h"
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 456fb88c49b1d..e07f5a1ae86e2 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -8,6 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-integrity.h>
 #include <linux/scatterlist.h>
+#include <linux/part_stat.h>
 
 #include <trace/events/block.h>
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index cb41c441aa8fa..871220a038225 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/sched/sysctl.h>
+#include <linux/part_stat.h>
 
 #include <trace/events/block.h>
 
diff --git a/block/blk.h b/block/blk.h
index 4089aeffca4b0..a57c84654d0a1 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -2,7 +2,6 @@
 #ifndef BLK_INTERNAL_H
 #define BLK_INTERNAL_H
 
-#include <linux/part_stat.h>
 #include <linux/blk-crypto.h>
 #include <linux/memblock.h>	/* for max_pfn/max_low_pfn */
 #include <xen/xen.h>
diff --git a/block/genhd.c b/block/genhd.c
index 01606db8c625d..5179a4f00fba5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,6 +25,7 @@
 #include <linux/log2.h>
 #include <linux/pm_runtime.h>
 #include <linux/badblocks.h>
+#include <linux/part_stat.h>
 
 #include "blk.h"
 #include "blk-mq-sched.h"
-- 
2.30.2

