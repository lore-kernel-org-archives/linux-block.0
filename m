Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1bon0075.outbound.protection.outlook.com ([157.56.111.75]:61952
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751202AbcFNPSD (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 11:18:03 -0400
Subject: [PATCH 2/3] block/bio-integrity.c: Add #include "blk.h"
To: Jens Axboe <axboe@fb.com>
References: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <28463abe-4bb3-a606-265c-f80c3358ca9c@sandisk.com>
Date: Tue, 14 Jun 2016 17:03:45 +0200
MIME-Version: 1.0
In-Reply-To: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch avoids that building with W=1 C=2 triggers the following
warning:

block/bio-integrity.c:35:6: warning: symbol 'blk_flush_integrity' was not declared. Should it be static?

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/bio-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 711e4d8d..15d37b1 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -26,6 +26,7 @@
 #include <linux/bio.h>
 #include <linux/workqueue.h>
 #include <linux/slab.h>
+#include "blk.h"
 
 #define BIP_INLINE_VECS	4
 
-- 
2.8.4

