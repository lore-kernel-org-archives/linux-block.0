Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33810 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753399AbcJTVkJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2016 17:40:09 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id u9KLdJBD009561
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2016 14:40:08 -0700
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2675yk00rf-2
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2016 14:40:08 -0700
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.232.59) with ESMTP id
 c4d7fc52970d11e686260002c991e86a-e92e7a50 for <linux-block@vger.kernel.org>;
        Thu, 20 Oct 2016 14:40:07 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <tomasz.majchrzak@intel.com>
Subject: [PATCH] badblocks: badblocks_set/clear update unacked_exist
Date: Thu, 20 Oct 2016 14:40:06 -0700
Message-ID: <39f303dcb7bdf2958b6f82a0646467dfbc8d1abd.1476999400.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When bandblocks_set acknowledges a range or badblocks_clear a range,
it's possible all badblocks are acknowledged. We should update
unacked_exist if this occurs.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/badblocks.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/block/badblocks.c b/block/badblocks.c
index 7be53cb..139115d2 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -133,6 +133,26 @@ int badblocks_check(struct badblocks *bb, sector_t s, int sectors,
 }
 EXPORT_SYMBOL_GPL(badblocks_check);
 
+static void badblocks_update_acked(struct badblocks *bb)
+{
+	u64 *p = bb->page;
+	int i;
+	bool unacked = false;
+
+	if (!bb->unacked_exist)
+		return;
+
+	for (i = 0; i < bb->count ; i++) {
+		if (!BB_ACK(p[i])) {
+			unacked = true;
+			break;
+		}
+	}
+
+	if (!unacked)
+		bb->unacked_exist = 0;
+}
+
 /**
  * badblocks_set() - Add a range of bad blocks to the table.
  * @bb:		the badblocks structure that holds all badblock information
@@ -294,6 +314,8 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 	bb->changed = 1;
 	if (!acknowledged)
 		bb->unacked_exist = 1;
+	else
+		badblocks_update_acked(bb);
 	write_sequnlock_irqrestore(&bb->lock, flags);
 
 	return rv;
@@ -399,6 +421,7 @@ int badblocks_clear(struct badblocks *bb, sector_t s, int sectors)
 		}
 	}
 
+	badblocks_update_acked(bb);
 	bb->changed = 1;
 out:
 	write_sequnlock_irq(&bb->lock);
-- 
2.9.3

