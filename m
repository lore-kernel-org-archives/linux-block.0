Return-Path: <SRS0=cIdD=UP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AD5C31E49
	for <linux-block@archiver.kernel.org>; Sun, 16 Jun 2019 10:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD78B2173C
	for <linux-block@archiver.kernel.org>; Sun, 16 Jun 2019 10:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbfFPKPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Jun 2019 06:15:52 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:24282 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1725957AbfFPKPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Jun 2019 06:15:52 -0400
X-ASG-Debug-ID: 1560680148-0e41085062309630001-Cu09wu
Received: from BJEXCAS02.didichuxing.com (bogon [172.20.36.211]) by bsf02.didichuxing.com with ESMTP id AuTerZmMdvK2kygl; Sun, 16 Jun 2019 18:15:48 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 16 Jun
 2019 18:15:48 +0800
Date:   Sun, 16 Jun 2019 18:15:47 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tj@kernel.org>, <hch@lst.de>,
        <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>, <cgroups@vger.kernel.org>
Subject: [PATCH v2 3/4] genirq/affinity: allow driver's discontigous affinity
 set
Message-ID: <459c7850e1b67738a4b68fa92e6949ee7d8154d3.1560679439.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v2 3/4] genirq/affinity: allow driver's discontigous affinity
 set
Mail-Followup-To: axboe@kernel.dk, tj@kernel.org, hch@lst.de,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1560679439.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.211]
X-Barracuda-Start-Time: 1560680148
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 756
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0001 1.0000 -2.0204
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.72767
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The driver may implement multiple affinity set, and some of
are empty, for this case we just skip them.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 kernel/irq/affinity.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index f18cd5aa33e8..6d964fe0fbd8 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -295,6 +295,10 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
+		/* skip empty affinity set */
+		if (this_vecs == 0)
+			continue;
+
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
 					       curvec, masks);
 		if (ret) {
-- 
2.14.1

