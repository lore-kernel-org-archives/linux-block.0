Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944BDC12002
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 06:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F8161009
	for <linux-block@archiver.kernel.org>; Wed, 21 Jul 2021 06:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhGUFvG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Jul 2021 01:51:06 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:52384 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbhGUFvC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Jul 2021 01:51:02 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 952D3FAEFA;
        Wed, 21 Jul 2021 14:31:20 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P13644T140561943324416S1626849079568135_;
        Wed, 21 Jul 2021 14:31:20 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <77a0db2e198c30d823326db2b8920101>
X-RL-SENDER: liubaozhu@uniontech.com
X-SENDER: liubaozhu@uniontech.com
X-LOGIN-NAME: liubaozhu@uniontech.com
X-FST-TO: paolo.valente@linaro.org
X-RCPT-COUNT: 5
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   liubaozhu <liubaozhu@uniontech.com>
To:     paolo.valente@linaro.org
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, liubaozhu <liubaozhu@uniontech.com>
Subject: [PATCH] block/bfq: the delta_from_first should be ns rather than us
Date:   Wed, 21 Jul 2021 14:30:47 +0800
Message-Id: <20210721063047.92122-1-liubaozhu@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the block/bfq-iosched.c,the function bfq_update_peak_rate(),
bfqd->delta_from_first = now_ns - bfqd->first_dispatch,
according to the subtraction operation here,now_ns is ns,
and bfqd->first_dispatch is also ns,so bfqd->delta_from_first should be ns.

Signed-off-by: liubaozhu <liubaozhu@uniontech.com>
---
 block/bfq-iosched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 99c2a3cb0..7cf4fc8c3 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -632,7 +632,7 @@ struct bfq_data {
 	u64 tot_sectors_dispatched;
 	/* max rq size seen during current observation interval (sectors) */
 	u32 last_rq_max_size;
-	/* time elapsed from first dispatch in current observ. interval (us) */
+	/* time elapsed from first dispatch in current observ. interval (ns) */
 	u64 delta_from_first;
 	/*
 	 * Current estimate of the device peak rate, measured in
-- 
2.20.1



