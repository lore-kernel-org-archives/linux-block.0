Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59818 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933853AbeFVWTu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:50 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 09/15] Makefile: Do not suppress useful shellcheck warnings
Date: Fri, 22 Jun 2018 15:19:40 -0700
Message-Id: <20180622221946.10987-10-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

All the shellcheck warnings that are currently suppressed are useful.
Additionally, it is easy to avoid false positives for the currently
suppressed categories of shellcheck warnings. Hence stop suppressing
shellcheck warnings. See also commit 17a59e0dc212 ("Fix all shellcheck
warnings").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 Makefile | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 14ba8341dae5..c4bffa2d3f32 100644
--- a/Makefile
+++ b/Makefile
@@ -4,21 +4,8 @@ all:
 clean:
 	$(MAKE) -C src clean
 
-# SC1090: "Can't follow non-constant source". We use variable sources all over
-# the place.
-# SC2034: "VARIABLE appears unused". All test scripts use this for the test
-# metadata, and many helper functions define global variables.
-# SC2119: "Use foo "$@" if function's $1 should mean script's $1". False
-# positives on helpers like _init_scsi_debug.
-# SC2154: "VARIABLE is referenced but not assigned". False positives on
-# TEST_RUN[foo]=bar.
-# SC2209: "Use var=$(command) to assign output (or quote to assign string)".
-# Warns about DMESG_FILTER=cat, which is not going to confuse anyone who knows
-# how to write shell scripts.
-SHELLCHECK_EXCLUDE := SC1090,SC2034,SC2119,SC2154,SC2209
-
 check:
-	shellcheck -x -e $(SHELLCHECK_EXCLUDE) -f gcc check new common/* tests/*/[0-9]*[0-9]
+	shellcheck -x -f gcc check new common/* tests/*/[0-9]*[0-9]
 	! grep TODO tests/*/[0-9]*[0-9]
 
 .PHONY: all check
-- 
2.17.1
