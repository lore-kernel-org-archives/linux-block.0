Return-Path: <SRS0=j1eM=WF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8123EC433FF
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 02:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579FF2173C
	for <linux-block@archiver.kernel.org>; Fri,  9 Aug 2019 02:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfHICle (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Aug 2019 22:41:34 -0400
Received: from smtpproxy19.qq.com ([184.105.206.84]:60667 "EHLO
        smtpproxy19.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729419AbfHICle (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Aug 2019 22:41:34 -0400
X-QQ-mid: bizesmtp18t1565318459tyoge4im
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 09 Aug 2019 10:40:58 +0800 (CST)
X-QQ-SSF: 01400000008000R0XR80000A0000000
X-QQ-FEAT: zpGAPzVkzFcvlKNuxPWR158M8vtvETvzrWcbUhUOzmFB/8mPmGSJr1/1PKi9A
        h/v0aufabz1IbT6g03aL0D22e70lfotUjNAgn8wA3GRxuqGAdIMu6h5Ky+W4IGRDLHVDDWo
        joAHYNad/bB/6njRsFodlGsc0lOghX4pdDC6mygXmJaxpSm43ZeUmKCetDPLW/sexCVrHTP
        4ze38+NZFF0f/ftzXrOWe4kEik+d0rIT+zqEDeg4og0pj92Ejjj/uWwy75ttzItAkmfsqN4
        Ay3JCTsmKpQUXpMkKf1QwkgUWLCQ+kO73/SKxhBcoDtNnRw4S98CN5cNq8dUv/OeIkP+taS
        Opi+X7uztktJ08slK4yDAWn1XVzEg==
X-QQ-GoodBg: 2
From:   Jackie Liu <liuyun01@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Jackie Liu <liuyun01@kylinos.cn>
Subject: [PATCH] Add arm64 memory barriers support
Date:   Fri,  9 Aug 2019 10:40:39 +0800
Message-Id: <1565318439-13992-1-git-send-email-liuyun01@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

making liburing on arm64 platform failed. let's support it.

root@Kylin:/# cat /etc/os-release
PRETTY_NAME="Debian GNU/Linux buster/sid"

root@Kylin:/# gcc -v
gcc version 8.2.0 (Debian 8.2.0-20)

root@Kylin:~/liburing# make
make[1]: Entering directory '/root/liburing/src'
cc -g -fomit-frame-pointer -O2 -Wall -Iinclude/ -c -o setup.ol setup.c
In file included from include/liburing.h:14,
                 from setup.c:10:
include/liburing.h: In function 'io_uring_cq_advance':
include/liburing/barrier.h:73:2: warning: implicit declaration of function 'smp_mb'; did you mean 'smp_wmb'? [-Wimplicit-function-declaration]
  smp_mb();    \
  ^~~~~~
include/liburing.h:111:3: note: in expansion of macro 'smp_store_release'
   smp_store_release(cq->khead, *cq->khead + nr);
   ^~~~~~~~~~~~~~~~~

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 src/include/liburing/barrier.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/include/liburing/barrier.h b/src/include/liburing/barrier.h
index 98be9e5..b98193b 100644
--- a/src/include/liburing/barrier.h
+++ b/src/include/liburing/barrier.h
@@ -56,7 +56,20 @@ do {						\
 	barrier();				\
 	___p1;					\
 })
-#else /* defined(__x86_64__) || defined(__i386__) */
+
+#elif defined(__aarch64__)
+/* Adapted from arch/arm64/include/asm/barrier.h */
+#define dmb(opt)	asm volatile("dmb " #opt : : : "memory")
+#define dsb(opt)	asm volatile("dsb " #opt : : : "memory")
+
+#define mb()		dsb(sy)
+#define rmb()		dsb(ld)
+#define wmb()		dsb(st)
+#define smp_mb()	dmb(ish)
+#define smp_rmb()	dmb(ishld)
+#define smp_wmb()	dmb(ishst)
+
+#else /* defined(__x86_64__) || defined(__i386__) || defined(__aarch64__) */
 /*
  * Add arch appropriate definitions. Be safe and use full barriers for
  * archs we don't have support for.
-- 
2.7.4



