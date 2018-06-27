Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:46714 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934499AbeF0VtK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jun 2018 17:49:10 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v2 1/3] src/Makefile: Rename $(TARGETS) into $(C_TARGETS)
Date: Wed, 27 Jun 2018 14:49:06 -0700
Message-Id: <20180627214908.26379-2-bart.vanassche@wdc.com>
In-Reply-To: <20180627214908.26379-1-bart.vanassche@wdc.com>
References: <20180627214908.26379-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Additionally, move -Wall from the C compilation rule to the $(CFLAGS)
variable.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 src/Makefile | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 612282d14af8..efbf393f4c58 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,4 +1,4 @@
-TARGETS := \
+C_TARGETS := \
 	loblksize \
 	loop_get_status_null \
 	openclose \
@@ -6,14 +6,16 @@ TARGETS := \
 	sg/syzkaller1 \
 	nbdsetsize
 
-CFLAGS := -O2
+TARGETS := $(C_TARGETS)
+
+CFLAGS := -O2 -Wall
 
 all: $(TARGETS)
 
 clean:
 	rm -f $(TARGETS)
 
-$(TARGETS): %: %.c
-	$(CC) -Wall -o $@ $(CPPFLAGS) $(CFLAGS) $^
+$(C_TARGETS): %: %.c
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
 
 .PHONY: all clean
-- 
2.17.1
