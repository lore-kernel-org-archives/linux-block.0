Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB35EC04EBF
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78944206B7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 15:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78944206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbeLEPid (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:38:33 -0500
Received: from mx2.didiglobal.com ([111.202.154.82]:30746 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727182AbeLEPic (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 10:38:32 -0500
X-ASG-Debug-ID: 1544024298-0e4088301228cfb0001-Cu09wu
Received: from BJEXMBX011.didichuxing.com (bjexmbx011.didichuxing.com [172.20.2.190]) by bsf01.didichuxing.com with ESMTP id vCjOpBTmEzfHkUhk; Wed, 05 Dec 2018 23:38:18 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1263.5; Wed, 5 Dec
 2018 23:38:19 +0800
Date:   Wed, 5 Dec 2018 23:38:13 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH 2/2] block: add BLK_DEF_TIMEOUT
Message-ID: <25ab1fca7ef2f21673d147fe1ec7579997dc7fdb.1544023832.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH 2/2] block: add BLK_DEF_TIMEOUT
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
X-Barracuda-Connect: bjexmbx011.didichuxing.com[172.20.2.190]
X-Barracuda-Start-Time: 1544024298
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1051
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0003 1.0000 -2.0190
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

Add an obvious definition for default request timeout.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 2 +-
 block/blk.h    | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 900550594651..53337d5c37af 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2845,7 +2845,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		goto err_hctxs;
 
 	INIT_WORK(&q->timeout_work, blk_mq_timeout_work);
-	blk_queue_rq_timeout(q, set->timeout ? set->timeout : 30 * HZ);
+	blk_queue_rq_timeout(q, set->timeout ? set->timeout : BLK_DEF_TIMEOUT);
 
 	q->tag_set = set;
 
diff --git a/block/blk.h b/block/blk.h
index f0d0a18fb276..7905b952b7b3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -7,6 +7,9 @@
 #include <xen/xen.h>
 #include "blk-mq.h"
 
+/* the default request timeout */
+#define BLK_DEF_TIMEOUT (30 * HZ)
+
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *blk_debugfs_root;
 #endif
-- 
2.14.1

