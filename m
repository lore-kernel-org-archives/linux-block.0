Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39506 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752455AbdI0XQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2017 19:16:09 -0400
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v8RNG8XY015482
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Wed, 27 Sep 2017 23:16:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id v8RNG7vX009514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Wed, 27 Sep 2017 23:16:08 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id v8RNG7Z2016677
        for <linux-block@vger.kernel.org>; Wed, 27 Sep 2017 23:16:07 GMT
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Subject: [PATCH] badblocks: fix wrong return value in badblocks_set if badblocks are disabled
Date: Wed, 27 Sep 2017 16:13:17 -0600
Message-Id: <20170927221317.31237-1-bo.li.liu@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

MD's rdev_set_badblocks() expects that badblocks_set() returns 1 if
badblocks are disabled, otherwise, rdev_set_badblocks() will record
superblock changes and return success in that case and md will fail to
report an IO error which it should.

This bug has existed since badblocks were introduced in commit
9e0e252a048b ("badblocks: Add core badblock management code").

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
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
