Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B8CC7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6B621BF6
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 08:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfGXIZM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 04:25:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfGXIZM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 04:25:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60AC330C1342;
        Wed, 24 Jul 2019 08:25:11 +0000 (UTC)
Received: from localhost (ovpn-117-162.ams2.redhat.com [10.36.117.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7889719C70;
        Wed, 24 Jul 2019 08:25:09 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Aarushi Mehta <mehta.aaru20@gmail.com>,
        Julia Suvorova <jusual@mail.ru>,
        Jeff Moyer <jmoyer@redhat.com>, linux-block@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH liburing 4/4] src/Makefile: keep private headers in <liburing/*.h>
Date:   Wed, 24 Jul 2019 09:24:50 +0100
Message-Id: <20190724082450.12135-5-stefanha@redhat.com>
In-Reply-To: <20190724082450.12135-1-stefanha@redhat.com>
References: <20190724082450.12135-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 24 Jul 2019 08:25:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is not possible to install barrier.h and compat.h into the top-level
/usr/include directly since they are likely to conflict with other
software.  io_uring.h could be confused with the system's kernel header
file.

Put liburing headers into <liburing/*.h> so there is no chance of
conflicts or confusion.

Existing applications continue to build successfully since the location
of <liburing.h> is unchanged.  In-tree examples and tests require
modification because src/liburing.h is moved to src/include/liburing.h.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 examples/Makefile                     |  2 +-
 src/Makefile                          | 14 +++++++-------
 test/Makefile                         |  2 +-
 src/{ => include}/liburing.h          |  6 +++---
 src/{ => include/liburing}/barrier.h  |  0
 src/{ => include/liburing}/compat.h   |  0
 src/{ => include/liburing}/io_uring.h |  0
 examples/io_uring-cp.c                |  2 +-
 examples/io_uring-test.c              |  2 +-
 examples/link-cp.c                    |  2 +-
 src/queue.c                           |  6 +++---
 src/register.c                        |  4 ++--
 src/setup.c                           |  4 ++--
 src/syscall.c                         |  4 ++--
 test/cq-full.c                        |  2 +-
 test/eeed8b54e0df-test.c              |  2 +-
 test/fsync.c                          |  2 +-
 test/io_uring_enter.c                 |  4 ++--
 test/io_uring_register.c              |  2 +-
 test/io_uring_setup.c                 |  2 +-
 test/link.c                           |  2 +-
 test/nop.c                            |  2 +-
 test/poll-cancel.c                    |  2 +-
 test/poll.c                           |  2 +-
 test/ring-leak.c                      |  2 +-
 test/send_recvmsg.c                   |  2 +-
 test/sq-full.c                        |  2 +-
 liburing.spec                         |  3 ++-
 28 files changed, 40 insertions(+), 39 deletions(-)
 rename src/{ => include}/liburing.h (98%)
 rename src/{ => include/liburing}/barrier.h (100%)
 rename src/{ => include/liburing}/compat.h (100%)
 rename src/{ => include/liburing}/io_uring.h (100%)

diff --git a/examples/Makefile b/examples/Makefile
index ed73fcd..1539ecc 100644
--- a/examples/Makefile
+++ b/examples/Makefile
@@ -1,5 +1,5 @@
 CFLAGS ?= -g -O2
-override CFLAGS += -Wall -D_GNU_SOURCE -L../src/
+override CFLAGS += -Wall -D_GNU_SOURCE -L../src/ -I../src/include/
 
 all_targets += io_uring-test io_uring-cp link-cp
 
diff --git a/src/Makefile b/src/Makefile
index aa93199..cbd3fda 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -3,7 +3,7 @@ includedir ?= $(prefix)/include
 libdir ?= $(prefix)/lib
 
 CFLAGS ?= -g -fomit-frame-pointer -O2
-override CFLAGS += -Wall -I.
+override CFLAGS += -Wall -Iinclude/
 SO_CFLAGS=-shared -fPIC $(CFLAGS)
 L_CFLAGS=$(CFLAGS)
 LINK_FLAGS=
@@ -27,7 +27,7 @@ liburing_srcs := setup.c queue.c syscall.c register.c
 liburing_objs := $(patsubst %.c,%.ol,$(liburing_srcs))
 liburing_sobjs := $(patsubst %.c,%.os,$(liburing_srcs))
 
-$(liburing_objs) $(liburing_sobjs): io_uring.h
+$(liburing_objs) $(liburing_sobjs): include/liburing/io_uring.h
 
 %.os: %.c
 	$(CC) $(SO_CFLAGS) -c -o $@ $<
@@ -46,10 +46,10 @@ $(libname): $(liburing_sobjs) liburing.map
 	$(CC) $(SO_CFLAGS) -Wl,--version-script=liburing.map -Wl,-soname=$(soname) -o $@ $(liburing_sobjs) $(LINK_FLAGS)
 
 install: $(all_targets)
-	install -D -m 644 io_uring.h $(includedir)/io_uring.h
-	install -D -m 644 liburing.h $(includedir)/liburing.h
-	install -D -m 644 compat.h $(includedir)/compat.h
-	install -D -m 644 barrier.h $(includedir)/barrier.h
+	install -D -m 644 include/liburing/io_uring.h $(includedir)/liburing/io_uring.h
+	install -D -m 644 include/liburing.h $(includedir)/liburing.h
+	install -D -m 644 include/liburing/compat.h $(includedir)/liburing/compat.h
+	install -D -m 644 include/liburing/barrier.h $(includedir)/liburing/barrier.h
 	install -D -m 644 liburing.a $(libdir)/liburing.a
 ifeq ($(ENABLE_SHARED),1)
 	install -D -m 755 $(libname) $(libdir)/$(libname)
@@ -57,7 +57,7 @@ ifeq ($(ENABLE_SHARED),1)
 	ln -sf $(libname) $(libdir)/liburing.so
 endif
 
-$(liburing_objs): liburing.h
+$(liburing_objs): include/liburing.h
 
 clean:
 	rm -f $(all_targets) $(liburing_objs) $(liburing_sobjs) $(soname).new
diff --git a/test/Makefile b/test/Makefile
index 98f863c..4d056f8 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -1,5 +1,5 @@
 CFLAGS ?= -g -O2
-override CFLAGS += -Wall -D_GNU_SOURCE -L../src/
+override CFLAGS += -Wall -D_GNU_SOURCE -L../src/ -I../src/include/
 
 all_targets += poll poll-cancel ring-leak fsync io_uring_setup io_uring_register \
 	       io_uring_enter nop sq-full cq-full 35fa71a030ca-test \
diff --git a/src/liburing.h b/src/include/liburing.h
similarity index 98%
rename from src/liburing.h
rename to src/include/liburing.h
index a350a01..fb78cd3 100644
--- a/src/liburing.h
+++ b/src/include/liburing.h
@@ -9,9 +9,9 @@ extern "C" {
 #include <signal.h>
 #include <string.h>
 #include <inttypes.h>
-#include "compat.h"
-#include "io_uring.h"
-#include "barrier.h"
+#include "liburing/compat.h"
+#include "liburing/io_uring.h"
+#include "liburing/barrier.h"
 
 /*
  * Library interface to io_uring
diff --git a/src/barrier.h b/src/include/liburing/barrier.h
similarity index 100%
rename from src/barrier.h
rename to src/include/liburing/barrier.h
diff --git a/src/compat.h b/src/include/liburing/compat.h
similarity index 100%
rename from src/compat.h
rename to src/include/liburing/compat.h
diff --git a/src/io_uring.h b/src/include/liburing/io_uring.h
similarity index 100%
rename from src/io_uring.h
rename to src/include/liburing/io_uring.h
diff --git a/examples/io_uring-cp.c b/examples/io_uring-cp.c
index 97f61aa..adb7b29 100644
--- a/examples/io_uring-cp.c
+++ b/examples/io_uring-cp.c
@@ -12,7 +12,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
-#include "../src/liburing.h"
+#include "liburing.h"
 
 #define QD	64
 #define BS	(32*1024)
diff --git a/examples/io_uring-test.c b/examples/io_uring-test.c
index 0b975ad..4f5ebf6 100644
--- a/examples/io_uring-test.c
+++ b/examples/io_uring-test.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "../src/liburing.h"
+#include "liburing.h"
 
 #define QD	4
 
diff --git a/examples/link-cp.c b/examples/link-cp.c
index a4c02e5..af80a2e 100644
--- a/examples/link-cp.c
+++ b/examples/link-cp.c
@@ -13,7 +13,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
-#include "../src/liburing.h"
+#include "liburing.h"
 
 #define QD	64
 #define BS	(32*1024)
diff --git a/src/queue.c b/src/queue.c
index 72b2293..74a077f 100644
--- a/src/queue.c
+++ b/src/queue.c
@@ -6,10 +6,10 @@
 #include <string.h>
 #include <stdbool.h>
 
-#include "compat.h"
-#include "io_uring.h"
+#include "liburing/compat.h"
+#include "liburing/io_uring.h"
 #include "liburing.h"
-#include "barrier.h"
+#include "liburing/barrier.h"
 
 static int __io_uring_get_cqe(struct io_uring *ring,
 			      struct io_uring_cqe **cqe_ptr, int wait)
diff --git a/src/register.c b/src/register.c
index 7561575..f5fc196 100644
--- a/src/register.c
+++ b/src/register.c
@@ -5,8 +5,8 @@
 #include <errno.h>
 #include <string.h>
 
-#include "compat.h"
-#include "io_uring.h"
+#include "liburing/compat.h"
+#include "liburing/io_uring.h"
 #include "liburing.h"
 
 int io_uring_register_buffers(struct io_uring *ring, const struct iovec *iovecs,
diff --git a/src/setup.c b/src/setup.c
index 343a317..47b0deb 100644
--- a/src/setup.c
+++ b/src/setup.c
@@ -5,8 +5,8 @@
 #include <errno.h>
 #include <string.h>
 
-#include "compat.h"
-#include "io_uring.h"
+#include "liburing/compat.h"
+#include "liburing/io_uring.h"
 #include "liburing.h"
 
 static int io_uring_mmap(int fd, struct io_uring_params *p,
diff --git a/src/syscall.c b/src/syscall.c
index d0c58cf..3fd8713 100644
--- a/src/syscall.c
+++ b/src/syscall.c
@@ -5,8 +5,8 @@
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <signal.h>
-#include "compat.h"
-#include "io_uring.h"
+#include "liburing/compat.h"
+#include "liburing/io_uring.h"
 
 #ifdef __alpha__
 /*
diff --git a/test/cq-full.c b/test/cq-full.c
index 82c5a65..25fa42c 100644
--- a/test/cq-full.c
+++ b/test/cq-full.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static int queue_n_nops(struct io_uring *ring, int n)
 {
diff --git a/test/eeed8b54e0df-test.c b/test/eeed8b54e0df-test.c
index 9083d3e..84237d5 100644
--- a/test/eeed8b54e0df-test.c
+++ b/test/eeed8b54e0df-test.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 #define BLOCK	4096
 
diff --git a/test/fsync.c b/test/fsync.c
index 44264f4..e6e0898 100644
--- a/test/fsync.c
+++ b/test/fsync.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static int test_single_fsync(struct io_uring *ring)
 {
diff --git a/test/io_uring_enter.c b/test/io_uring_enter.c
index b25afd5..c2030c1 100644
--- a/test/io_uring_enter.c
+++ b/test/io_uring_enter.c
@@ -22,8 +22,8 @@
 #include <sys/resource.h>
 #include <limits.h>
 #include <sys/time.h>
-#include "../src/liburing.h"
-#include "../src/barrier.h"
+#include "liburing.h"
+#include "liburing/barrier.h"
 
 #define IORING_MAX_ENTRIES 4096
 
diff --git a/test/io_uring_register.c b/test/io_uring_register.c
index 32e5217..59c8a86 100644
--- a/test/io_uring_register.c
+++ b/test/io_uring_register.c
@@ -21,7 +21,7 @@
 #include <sys/time.h>
 #include <sys/resource.h>
 #include <limits.h>
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static int pagesize;
 static rlim_t mlock_limit;
diff --git a/test/io_uring_setup.c b/test/io_uring_setup.c
index 09e16e5..2dd3763 100644
--- a/test/io_uring_setup.c
+++ b/test/io_uring_setup.c
@@ -13,7 +13,7 @@
 #include <unistd.h>
 #include <errno.h>
 #include <sys/sysinfo.h>
-#include "../src/liburing.h"
+#include "liburing.h"
 
 /*
  * Attempt the call with the given args.  Return 0 when expect matches
diff --git a/test/link.c b/test/link.c
index e7ca3e3..603b507 100644
--- a/test/link.c
+++ b/test/link.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 /*
  * Test failing head of chain, and dependent getting -ECANCELED
diff --git a/test/nop.c b/test/nop.c
index 8e6bfb0..1373695 100644
--- a/test/nop.c
+++ b/test/nop.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static int test_single_nop(struct io_uring *ring)
 {
diff --git a/test/poll-cancel.c b/test/poll-cancel.c
index 19efc5f..4761569 100644
--- a/test/poll-cancel.c
+++ b/test/poll-cancel.c
@@ -12,7 +12,7 @@
 #include <sys/wait.h>
 #include <sys/signal.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 struct poll_data {
 	unsigned is_poll;
diff --git a/test/poll.c b/test/poll.c
index d22d9c5..ed424fc 100644
--- a/test/poll.c
+++ b/test/poll.c
@@ -11,7 +11,7 @@
 #include <sys/poll.h>
 #include <sys/wait.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static void sig_alrm(int sig)
 {
diff --git a/test/ring-leak.c b/test/ring-leak.c
index 99466e4..02b06f9 100644
--- a/test/ring-leak.c
+++ b/test/ring-leak.c
@@ -21,7 +21,7 @@
 #include <string.h>
 #include <linux/fs.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static int __io_uring_register_files(int ring_fd, int fd1, int fd2)
 {
diff --git a/test/send_recvmsg.c b/test/send_recvmsg.c
index 9187906..ada6559 100644
--- a/test/send_recvmsg.c
+++ b/test/send_recvmsg.c
@@ -9,7 +9,7 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 static char str[] = "This is a test of sendmsg and recvmsg over io_uring!";
 
diff --git a/test/sq-full.c b/test/sq-full.c
index 5bf7f72..3fbe0a5 100644
--- a/test/sq-full.c
+++ b/test/sq-full.c
@@ -9,7 +9,7 @@
 #include <string.h>
 #include <fcntl.h>
 
-#include "../src/liburing.h"
+#include "liburing.h"
 
 int main(int argc, char *argv[])
 {
diff --git a/liburing.spec b/liburing.spec
index 189a16a..e577a8f 100644
--- a/liburing.spec
+++ b/liburing.spec
@@ -47,7 +47,8 @@ make install DESTDIR=$RPM_BUILD_ROOT
 
 %files devel
 %defattr(-,root,root)
-%attr(0644,root,root) %{_includedir}/*
+%attr(0755,root,root) %{_includedir}/liburing/*
+%attr(0644,root,root) %{_includedir}/liburing.h
 %attr(0755,root,root) %{_libdir}/liburing.so
 %attr(0644,root,root) %{_libdir}/liburing.a
 %attr(0644,root,root) %{_libdir}/pkgconfig/*
-- 
2.21.0

