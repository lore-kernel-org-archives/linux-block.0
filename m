Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:41441 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbdHZBQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Aug 2017 21:16:07 -0400
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id v7Q1G6IO006325
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Sat, 26 Aug 2017 01:16:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id v7Q1G6TA008276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-block@vger.kernel.org>; Sat, 26 Aug 2017 01:16:06 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id v7Q1G5qt004576
        for <linux-block@vger.kernel.org>; Sat, 26 Aug 2017 01:16:05 GMT
From: Liu Bo <bo.li.liu@oracle.com>
To: linux-block@vger.kernel.org
Subject: [PATCH RFC] Block/blk-wbt: do not let background writes block sync writes
Date: Fri, 25 Aug 2017 18:14:27 -0600
Message-Id: <20170826001427.23012-1-bo.li.liu@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

While using blk-wbt, sometimes sync writes are blocked by background
writes, for example,

a) a background write reaches the (background) limit returned by
get_limit(), so it's added into the rqw->wait (non kswapd's rqw in
this case) and goes to sleep.

b) then a sync write gets queued and goes to sleep when finding that
waitqueue_active() returns true and someone else is already on the
waiting list.

Thus, the sync write will get its rq after the background write
getting rq.

With this, only background writes will check waitqueue's status and
sync writes will only be throttled by the (max) limit returned by
get_limit().

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
---

- Besides the above problem, it seems waitqueue_active() also requires
  a smp_mb().

 block/blk-wbt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 6a9a0f0..698d9f7 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -519,7 +519,8 @@ static inline bool may_queue(struct rq_wb *rwb, struct rq_wait *rqw,
 	 * If the waitqueue is already active and we are not the next
 	 * in line to be woken up, wait for our turn.
 	 */
-	if (waitqueue_active(&rqw->wait) &&
+	if ((rw & REQ_BACKGROUND) &&
+	    waitqueue_active(&rqw->wait) &&
 	    rqw->wait.head.next != &wait->entry)
 		return false;
 
-- 
2.9.4
