Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bn1bon0093.outbound.protection.outlook.com ([157.56.111.93]:28672
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750789AbcFNPRd (ORCPT <rfc822;linux-block@vger.kernel.org>);
	Tue, 14 Jun 2016 11:17:33 -0400
Subject: [PATCH 1/3] block/partition-generic.c: Remove a set-but-not-used
 variable
To: Jens Axboe <axboe@fb.com>
References: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <50e4a887-3b50-9d53-c3dc-4280b58e21d2@sandisk.com>
Date: Tue, 14 Jun 2016 17:03:13 +0200
MIME-Version: 1.0
In-Reply-To: <25262742-283b-fc4d-30df-d6a9196c85a5@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

A value is assigned to the variable 'info' but that value is never
used. Hence remove the variable 'info'.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
---
 block/partition-generic.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index d7eb77e..71d9ed9 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -495,7 +495,6 @@ rescan:
 	/* add partitions */
 	for (p = 1; p < state->limit; p++) {
 		sector_t size, from;
-		struct partition_meta_info *info = NULL;
 
 		size = state->parts[p].size;
 		if (!size)
@@ -530,8 +529,6 @@ rescan:
 			}
 		}
 
-		if (state->parts[p].has_info)
-			info = &state->parts[p].info;
 		part = add_partition(disk, p, from, size,
 				     state->parts[p].flags,
 				     &state->parts[p].info);
-- 
2.8.4

