Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35639 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754326AbeGIW4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jul 2018 18:56:45 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Omar Sandoval <osandov@fb.com>
Cc: linux-block@vger.kernel.org,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH blktests v3 1/6] dir-locals.el: Add c-mode settings
Date: Mon,  9 Jul 2018 15:56:38 -0700
Message-Id: <20180709225643.10537-2-bart.vanassche@wdc.com>
In-Reply-To: <20180709225643.10537-1-bart.vanassche@wdc.com>
References: <20180709225643.10537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add c-mode settings for the files in the src directory. Additionally,
make indent-tabs-mode global such that it also applies to the
.dir-locals.el file itself.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 .dir-locals.el | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.dir-locals.el b/.dir-locals.el
index 46961929fac9..994103c63d39 100644
--- a/.dir-locals.el
+++ b/.dir-locals.el
@@ -1,4 +1,6 @@
 ((sh-mode . ((sh-basic-offset . 8)
 	     (sh-indentation . 8)
-	     (fill-column . 80)
-	     (indent-tabs-mode . t))))
+	     (fill-column . 80)))
+ (c-mode .  ((c-basic-offset . 8)
+	     (c-label-minimum-indentation . 0)))
+ (nil .     ((indent-tabs-mode . t))))
-- 
2.18.0
