Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:52596 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754529AbeGIW4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jul 2018 18:56:45 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v3 4/6] src/Makefile: Move -Wall from the C compilation rule to the $(CFLAGS) variable
Date: Mon,  9 Jul 2018 15:56:41 -0700
Message-Id: <20180709225643.10537-5-bart.vanassche@wdc.com>
In-Reply-To: <20180709225643.10537-1-bart.vanassche@wdc.com>
References: <20180709225643.10537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/Makefile b/src/Makefile
index 7d15d115f6df..efbf393f4c58 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -8,7 +8,7 @@ C_TARGETS := \
 
 TARGETS := $(C_TARGETS)
 
-CFLAGS := -O2
+CFLAGS := -O2 -Wall
 
 all: $(TARGETS)
 
@@ -16,6 +16,6 @@ clean:
 	rm -f $(TARGETS)
 
 $(C_TARGETS): %: %.c
-	$(CC) -Wall -o $@ $(CPPFLAGS) $(CFLAGS) $^
+	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
 
 .PHONY: all clean
-- 
2.18.0
