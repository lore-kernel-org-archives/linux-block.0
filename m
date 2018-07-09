Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35639 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754508AbeGIW4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jul 2018 18:56:45 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v3 3/6] src/Makefile: Introduce the C_TARGETS variable
Date: Mon,  9 Jul 2018 15:56:40 -0700
Message-Id: <20180709225643.10537-4-bart.vanassche@wdc.com>
In-Reply-To: <20180709225643.10537-1-bart.vanassche@wdc.com>
References: <20180709225643.10537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch does not change any functionality but will make it easier
to add support for building C++ code.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 src/Makefile | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 612282d14af8..7d15d115f6df 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,4 +1,4 @@
-TARGETS := \
+C_TARGETS := \
 	loblksize \
 	loop_get_status_null \
 	openclose \
@@ -6,6 +6,8 @@ TARGETS := \
 	sg/syzkaller1 \
 	nbdsetsize
 
+TARGETS := $(C_TARGETS)
+
 CFLAGS := -O2
 
 all: $(TARGETS)
@@ -13,7 +15,7 @@ all: $(TARGETS)
 clean:
 	rm -f $(TARGETS)
 
-$(TARGETS): %: %.c
+$(C_TARGETS): %: %.c
 	$(CC) -Wall -o $@ $(CPPFLAGS) $(CFLAGS) $^
 
 .PHONY: all clean
-- 
2.18.0
