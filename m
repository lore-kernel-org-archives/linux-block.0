Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3891FC43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42D921743
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4wrbg0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfD3Snc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:43:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56916 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727139AbfD3Snb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p3NrvrF6qnm7Dp1Moin+lw6Rw+p5qp0k6gGSnOMqM/w=; b=g4wrbg0rjuEpwgG6hZdlIgl3Zh
        L3pdV2nVKTjh00OPPW/KF+MmlDbIU4ObyrZT/JKc3fRq4FmNVLSJs52HEqiQgqV505Ki5ytLBLlPT
        IpfmU41GaYqisAnLJP+W9IZiP6s2N0FfThdtYAG0UyF/QcfoKx/cZcBJQ2dy88PhQivJd1zpo7WA0
        UeaKk8PnC6ZtvKTmNKS9ylIg0zzU5udjcThTHt9d2W+Uxk/KzfERhOOQs4Ei9TiLKrW25vzF5ImCG
        HSlKQx0YFiXY+lb/2zq2SbC+/QtphTQ50pqeUUTOfQK7g3ZuixfT+YrJB7L8yoXI/72fL3b3OG/0R
        HBaGa1VQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXix-0000t8-W4; Tue, 30 Apr 2019 18:43:28 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] block: add SPDX tags to block layer files missing licensing information
Date:   Tue, 30 Apr 2019 14:42:43 -0400
Message-Id: <20190430184243.23436-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430184243.23436-1-hch@lst.de>
References: <20190430184243.23436-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various block layer files do not have any licensing information at all.
Add SPDX tags for the default kernel GPLv2 license to those.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c        | 1 +
 block/blk-core.c          | 1 +
 block/blk-exec.c          | 1 +
 block/blk-iolatency.c     | 1 +
 block/blk-mq-cpumap.c     | 1 +
 block/blk-mq-sched.c      | 1 +
 block/blk-mq-sysfs.c      | 1 +
 block/blk-mq-tag.c        | 1 +
 block/blk-mq.c            | 1 +
 block/blk-rq-qos.c        | 2 ++
 block/blk-rq-qos.h        | 1 +
 block/blk-settings.c      | 1 +
 block/blk-stat.c          | 1 +
 block/blk-timeout.c       | 1 +
 block/blk-wbt.c           | 1 +
 block/blk-zoned.c         | 1 +
 block/elevator.c          | 1 +
 block/genhd.c             | 1 +
 block/ioctl.c             | 1 +
 block/ioprio.c            | 1 +
 block/mq-deadline.c       | 1 +
 block/partitions/aix.h    | 1 +
 block/partitions/amiga.h  | 1 +
 block/partitions/ibm.h    | 1 +
 block/partitions/karma.h  | 1 +
 block/partitions/msdos.h  | 1 +
 block/partitions/osf.h    | 1 +
 block/partitions/sgi.h    | 1 +
 block/partitions/sun.h    | 1 +
 block/partitions/sysv68.h | 1 +
 block/partitions/ultrix.h | 1 +
 31 files changed, 32 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 617a2b3f7582..b97b479e4f64 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Common Block IO controller cgroup interface
  *
diff --git a/block/blk-core.c b/block/blk-core.c
index a55389ba8779..b044829135c9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 1991, 1992 Linus Torvalds
  * Copyright (C) 1994,      Karl Keyte: Added support for disk statistics
diff --git a/block/blk-exec.c b/block/blk-exec.c
index a34b7d918742..1db44ca0f4a6 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Functions related to setting various queue properties from drivers
  */
diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 507212d75ee2..d22e61bced86 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block rq-qos base io controller
  *
diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 03a534820271..48bebf00a5f3 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPU <-> hardware queue mapping helpers
  *
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index aa6bc5c02643..f6e3b10b52eb 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * blk-mq scheduling framework
  *
diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 3f9c3f4ac44c..61efc2a29e58 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/backing-dev.h>
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index a4931fc7be8a..7513c8eaabee 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Tag allocation using scalable bitmaps. Uses active queue tracking to support
  * fairer distribution of tags between multiple submitters when a shared tag map
diff --git a/block/blk-mq.c b/block/blk-mq.c
index fc60ed7e940e..4f15adfbab29 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block multiqueue core code
  *
diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index d169d7188fa6..3f55b56f24bc 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -1,3 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
+
 #include "blk-rq-qos.h"
 
 /*
diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 564851889550..2300e038b9fa 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef RQ_QOS_H
 #define RQ_QOS_H
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 6375afaedcec..ec150f88db09 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Functions related to setting various queue properties from drivers
  */
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 696a04176e4d..940f15d600f8 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Block stat tracking code
  *
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 124c26128bf6..8aa68fae96ad 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Functions related to generic timeout handling of requests.
  */
diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index fd166fbb0f65..313f45a37e9d 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * buffered writeback throttling. loosely based on CoDel. We can't drop
  * packets for IO scheduling, so the logic is something like this:
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2d98803faec2..ae7e91bd0618 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Zoned block device handling
  *
diff --git a/block/elevator.c b/block/elevator.c
index 2e5399d9f40f..ec55d5fc0b3e 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  Block device elevator/IO-scheduler.
  *
diff --git a/block/genhd.c b/block/genhd.c
index 83f5c33d1e80..ad6826628e79 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  gendisk handling
  */
diff --git a/block/ioctl.c b/block/ioctl.c
index 4825c78a6baa..15a0eb80ada9 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/capability.h>
 #include <linux/blkdev.h>
 #include <linux/export.h>
diff --git a/block/ioprio.c b/block/ioprio.c
index f9821080c92c..2e0559f157c8 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * fs/ioprio.c
  *
diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 14288f864e94..1876f5712bfd 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  MQ Deadline i/o scheduler - adaptation of the legacy deadline scheduler,
  *  for the blk-mq scheduling framework
diff --git a/block/partitions/aix.h b/block/partitions/aix.h
index e0c66a987523..b4449f0b9f2b 100644
--- a/block/partitions/aix.h
+++ b/block/partitions/aix.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 extern int aix_partition(struct parsed_partitions *state);
diff --git a/block/partitions/amiga.h b/block/partitions/amiga.h
index d094585cadaa..7e63f4d9d969 100644
--- a/block/partitions/amiga.h
+++ b/block/partitions/amiga.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/amiga.h
  */
diff --git a/block/partitions/ibm.h b/block/partitions/ibm.h
index 08fb0804a812..8bf13febb2b6 100644
--- a/block/partitions/ibm.h
+++ b/block/partitions/ibm.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 int ibm_partition(struct parsed_partitions *);
diff --git a/block/partitions/karma.h b/block/partitions/karma.h
index c764b2e9df21..48e074d417fb 100644
--- a/block/partitions/karma.h
+++ b/block/partitions/karma.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/karma.h
  */
diff --git a/block/partitions/msdos.h b/block/partitions/msdos.h
index 38c781c490b3..fcacfc486092 100644
--- a/block/partitions/msdos.h
+++ b/block/partitions/msdos.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/msdos.h
  */
diff --git a/block/partitions/osf.h b/block/partitions/osf.h
index 20ed2315ec16..4d8088e7ea8c 100644
--- a/block/partitions/osf.h
+++ b/block/partitions/osf.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/osf.h
  */
diff --git a/block/partitions/sgi.h b/block/partitions/sgi.h
index b9553ebdd5a9..a5b77c3987cf 100644
--- a/block/partitions/sgi.h
+++ b/block/partitions/sgi.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/sgi.h
  */
diff --git a/block/partitions/sun.h b/block/partitions/sun.h
index 2424baa8319f..ae1b9eed3fd7 100644
--- a/block/partitions/sun.h
+++ b/block/partitions/sun.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/sun.h
  */
diff --git a/block/partitions/sysv68.h b/block/partitions/sysv68.h
index bf2f5ffa97ac..4fb6b8ec78ae 100644
--- a/block/partitions/sysv68.h
+++ b/block/partitions/sysv68.h
@@ -1 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 extern int sysv68_partition(struct parsed_partitions *state);
diff --git a/block/partitions/ultrix.h b/block/partitions/ultrix.h
index a3cc00b2bded..9f676cead222 100644
--- a/block/partitions/ultrix.h
+++ b/block/partitions/ultrix.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  fs/partitions/ultrix.h
  */
-- 
2.20.1

