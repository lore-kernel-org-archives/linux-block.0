Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29608 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933824AbeFVWTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:53 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 11/15] make check: Also check tests/*/group files
Date: Fri, 22 Jun 2018 15:19:42 -0700
Message-Id: <20180622221946.10987-12-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c4bffa2d3f32..8031d2ed0eca 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,8 @@ clean:
 	$(MAKE) -C src clean
 
 check:
-	shellcheck -x -f gcc check new common/* tests/*/[0-9]*[0-9]
+	shellcheck -x -f gcc check new common/* tests/*/group \
+	    tests/*/[0-9]*[0-9]
 	! grep TODO tests/*/[0-9]*[0-9]
 
 .PHONY: all check
-- 
2.17.1
