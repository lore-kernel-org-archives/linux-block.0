Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCFEC04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819A920850
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 819A920850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbeLEPua (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:50:30 -0500
Received: from mx2.didichuxing.com ([36.110.17.22]:21326 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727103AbeLEPua (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:50:30 -0500
X-ASG-Debug-ID: 1544024235-0e4108668b50e990001-Cu09wu
Received: from BJEXCAS004.didichuxing.com (bjexcas004.didichuxing.com [172.20.1.44]) by bsf02.didichuxing.com with ESMTP id XqYWDRAQ4Izhc4QY; Wed, 05 Dec 2018 23:37:15 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 5 Dec
 2018 23:37:16 +0800
Date:   Wed, 5 Dec 2018 23:37:09 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] block: get rid of BLK_MAX_TIMEOUT
Message-ID: <997df532a176a435c3581ce180f318a298084393.1544023832.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH 1/2] block: get rid of BLK_MAX_TIMEOUT
Mail-Followup-To: axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1544023832.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1544023832.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS002.didichuxing.com (172.20.1.42) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bjexcas004.didichuxing.com[172.20.1.44]
X-Barracuda-Start-Time: 1544024235
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1903
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -1.52
X-Barracuda-Spam-Status: No, SCORE=-1.52 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.63115
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since io_timeout was added to sysfs, the user can tune timeouts
by that attribute, so kill this limitation.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-timeout.c | 13 +------------
 block/blk.h         |  4 ----
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 124c26128bf6..6b2b0f7e5929 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -89,17 +89,6 @@ void blk_abort_request(struct request *req)
 }
 EXPORT_SYMBOL_GPL(blk_abort_request);
 
-unsigned long blk_rq_timeout(unsigned long timeout)
-{
-	unsigned long maxt;
-
-	maxt = round_jiffies_up(jiffies + BLK_MAX_TIMEOUT);
-	if (time_after(timeout, maxt))
-		timeout = maxt;
-
-	return timeout;
-}
-
 /**
  * blk_add_timer - Start timeout timer for a single request
  * @req:	request that is about to start running.
@@ -130,7 +119,7 @@ void blk_add_timer(struct request *req)
 	 * than an existing one, modify the timer. Round up to next nearest
 	 * second.
 	 */
-	expiry = blk_rq_timeout(round_jiffies_up(expiry));
+	expiry = round_jiffies_up(expiry);
 
 	if (!timer_pending(&q->timeout) ||
 	    time_before(expiry, q->timeout.expires)) {
diff --git a/block/blk.h b/block/blk.h
index 848278c52030..f0d0a18fb276 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -7,9 +7,6 @@
 #include <xen/xen.h>
 #include "blk-mq.h"
 
-/* Max future timer expiry for timeouts */
-#define BLK_MAX_TIMEOUT		(5 * HZ)
-
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *blk_debugfs_root;
 #endif
@@ -151,7 +148,6 @@ static inline bool bio_integrity_endio(struct bio *bio)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
 bool bio_attempt_front_merge(struct request_queue *q, struct request *req,
-- 
2.14.1

