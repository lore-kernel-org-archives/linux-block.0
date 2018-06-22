Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26982 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933865AbeFVWTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 18:19:53 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests 13/15] src/Makefile: Fix pattern rule
Date: Fri, 22 Jun 2018 15:19:44 -0700
Message-Id: <20180622221946.10987-14-bart.vanassche@wdc.com>
In-Reply-To: <20180622221946.10987-1-bart.vanassche@wdc.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

According to the GNU make documentation, the syntax for pattern rules
is as follows:

<target pattern>+: <source pattern>
	<rule>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 src/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile b/src/Makefile
index 612282d14af8..d7ae832fc4fd 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,7 +13,7 @@ all: $(TARGETS)
 clean:
 	rm -f $(TARGETS)
 
-$(TARGETS): %: %.c
+%: %.c
 	$(CC) -Wall -o $@ $(CPPFLAGS) $(CFLAGS) $^
 
 .PHONY: all clean
-- 
2.17.1
