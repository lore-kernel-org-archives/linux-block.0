Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50394 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdKCS07 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Nov 2017 14:26:59 -0400
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Cc: Shaohua Li <shli@kernel.org>
Subject: [PATCH RESEND] badblocks: fix wrong return value in badblocks_set if badblocks are disabled
Date: Fri,  3 Nov 2017 11:24:44 -0600
Message-Id: <20171103172444.13799-1-bo.li.liu@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

MD's rdev_set_badblocks() expects that badblocks_set() returns 1 if
badblocks are disabled, otherwise, rdev_set_badblocks() will record
superblock changes and return success in that case and md will fail to
report an IO error which it should.

This bug has existed since badblocks were introduced in commit
9e0e252a048b ("badblocks: Add core badblock management code").

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Acked-by: Guoqing Jiang <gqjiang@suse.com>
---
 block/badblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/badblocks.c b/block/badblocks.c
index 43c7116..91f7bcf 100644
--- a/block/badblocks.c
+++ b/block/badblocks.c
@@ -178,7 +178,7 @@ int badblocks_set(struct badblocks *bb, sector_t s, int sectors,
 
 	if (bb->shift < 0)
 		/* badblocks are disabled */
-		return 0;
+		return 1;
 
 	if (bb->shift) {
 		/* round the start down, and the end up */
-- 
2.9.4
