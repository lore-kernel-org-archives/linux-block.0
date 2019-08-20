Return-Path: <SRS0=6fCZ=WQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026EC3A589
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 12:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB4A22CF7
	for <linux-block@archiver.kernel.org>; Tue, 20 Aug 2019 12:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbfHTMmp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:42:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbfHTMmp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Aug 2019 08:42:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06B9830860DC;
        Tue, 20 Aug 2019 12:42:45 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.2.10])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A5C2E5C21F;
        Tue, 20 Aug 2019 12:42:41 +0000 (UTC)
From:   Julia Suvorova <jusual@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@gmail.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@redhat.com>
Subject: [PATCH] liburing/barrier.h: Add prefix to arm barriers
Date:   Tue, 20 Aug 2019 14:42:36 +0200
Message-Id: <20190820124236.19608-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 20 Aug 2019 12:42:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Rename the newly added arm barriers and READ/WRITE_ONCE
to avoid using popular names.

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 src/include/liburing/barrier.h | 46 +++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/src/include/liburing/barrier.h b/src/include/liburing/barrier.h
index 8efa6dd..fc40a8a 100644
--- a/src/include/liburing/barrier.h
+++ b/src/include/liburing/barrier.h
@@ -26,9 +26,9 @@ after the acquire operation executes. This is implemented using
 #define io_uring_barrier()	__asm__ __volatile__("": : :"memory")
 
 /* From tools/virtio/linux/compiler.h */
-#define WRITE_ONCE(var, val) \
+#define IO_URING_WRITE_ONCE(var, val) \
 	(*((volatile __typeof(val) *)(&(var))) = (val))
-#define READ_ONCE(var) (*((volatile __typeof(var) *)(&(var))))
+#define IO_URING_READ_ONCE(var) (*((volatile __typeof(var) *)(&(var))))
 
 
 #if defined(__x86_64__) || defined(__i386__)
@@ -49,27 +49,27 @@ after the acquire operation executes. This is implemented using
 #define io_uring_smp_store_release(p, v)	\
 do {						\
 	io_uring_barrier();			\
-	WRITE_ONCE(*(p), (v));			\
+	IO_URING_WRITE_ONCE(*(p), (v));		\
 } while (0)
 
-#define io_uring_smp_load_acquire(p)		\
-({						\
-	__typeof(*p) ___p1 = READ_ONCE(*(p));	\
-	io_uring_barrier();			\
-	___p1;					\
+#define io_uring_smp_load_acquire(p)			\
+({							\
+	__typeof(*p) ___p1 = IO_URING_READ_ONCE(*(p));	\
+	io_uring_barrier();				\
+	___p1;						\
 })
 
 #elif defined(__aarch64__)
 /* Adapted from arch/arm64/include/asm/barrier.h */
-#define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
-#define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
+#define io_uring_dmb(opt)	asm volatile("dmb " #opt : : : "memory")
+#define io_uring_dsb(opt)	asm volatile("dsb " #opt : : : "memory")
 
-#define mb()		dsb(sy)
-#define rmb()		dsb(ld)
-#define wmb()		dsb(st)
-#define smp_mb()	dmb(ish)
-#define smp_rmb()	dmb(ishld)
-#define smp_wmb()	dmb(ishst)
+#define io_uring_mb()		io_uring_dsb(sy)
+#define io_uring_rmb()		io_uring_dsb(ld)
+#define io_uring_wmb()		io_uring_dsb(st)
+#define io_uring_smp_mb()	io_uring_dmb(ish)
+#define io_uring_smp_rmb()	io_uring_dmb(ishld)
+#define io_uring_smp_wmb()	io_uring_dmb(ishst)
 
 #else /* defined(__x86_64__) || defined(__i386__) || defined(__aarch64__) */
 /*
@@ -83,19 +83,19 @@ do {						\
 /* From tools/include/asm/barrier.h */
 
 #ifndef io_uring_smp_store_release
-# define io_uring_smp_store_release(p, v)	\
+#define io_uring_smp_store_release(p, v)	\
 do {						\
 	io_uring_smp_mb();			\
-	WRITE_ONCE(*p, v);			\
+	IO_URING_WRITE_ONCE(*p, v);		\
 } while (0)
 #endif
 
 #ifndef io_uring_smp_load_acquire
-# define io_uring_smp_load_acquire(p)		\
-({						\
-	__typeof(*p) ___p1 = READ_ONCE(*p);	\
-	io_uring_smp_mb();			\
-	___p1;					\
+#define io_uring_smp_load_acquire(p)			\
+({							\
+	__typeof(*p) ___p1 = IO_URING_READ_ONCE(*p);	\
+	io_uring_smp_mb();				\
+	___p1;						\
 })
 #endif
 
-- 
2.21.0

