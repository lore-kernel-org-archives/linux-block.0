Return-Path: <SRS0=eQE1=4P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB87C4BA35
	for <linux-block@archiver.kernel.org>; Thu, 27 Feb 2020 01:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2993E208E4
	for <linux-block@archiver.kernel.org>; Thu, 27 Feb 2020 01:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgB0Bi6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:38:58 -0500
Received: from mx1.didichuxing.com ([111.202.154.82]:14709 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1727964AbgB0Bi6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Feb 2020 20:38:58 -0500
X-ASG-Debug-ID: 1582767527-0e408867dbad9510001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.204]) by bsf01.didichuxing.com with ESMTP id MIJQmmBFQF7ir8EJ; Thu, 27 Feb 2020 09:38:47 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 27 Feb
 2020 09:38:47 +0800
Date:   Thu, 27 Feb 2020 09:38:46 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <tj@kernel.org>, <linux-block@vger.kernel.org>
Subject: [PATCH] blk-iocost: remove duplicated lines in comments
Message-ID: <20200227013845.GA14895@192.168.3.9>
X-ASG-Orig-Subj: [PATCH] blk-iocost: remove duplicated lines in comments
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.204]
X-Barracuda-Start-Time: 1582767527
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 640
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0005 1.0000 -2.0176
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80281
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-iocost.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 27ca68621137..6a7788f31c22 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -46,9 +46,6 @@
  * If needed, tools/cgroup/iocost_coef_gen.py can be used to generate
  * device-specific coefficients.
  *
- * If needed, tools/cgroup/iocost_coef_gen.py can be used to generate
- * device-specific coefficients.
- *
  * 2. Control Strategy
  *
  * The device virtual time (vtime) is used as the primary control metric.
-- 
2.14.1

