Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4516EC4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 06:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E946121775
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 06:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgIYGAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 02:00:34 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38094 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIYGAe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 02:00:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UA06tRT_1601013631;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UA06tRT_1601013631)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Sep 2020 14:00:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: [PATCH] block: remove unused BLK_QC_T_EAGAIN flag
Date:   Fri, 25 Sep 2020 14:00:31 +0800
Message-Id: <20200925060031.4435-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit 7b6620d7db56 ("block: remove REQ_NOWAIT_INLINE") removed the
REQ_NOWAIT_INLINE related code, but the diff wasn't applied to
blk_types.h somehow.

Then commit 2771cefeac49 ("block: remove the REQ_NOWAIT_INLINE flag")
removed the REQ_NOWAIT_INLINE flag while the BLK_QC_T_EAGAIN flag still
remains.

Fixes: 7b6620d7db56 ("block: remove REQ_NOWAIT_INLINE")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 include/linux/blk_types.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 4ecf4fed171f..b3fc5d3dd8ea 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -497,13 +497,12 @@ static inline int op_stat_group(unsigned int op)
 
 typedef unsigned int blk_qc_t;
 #define BLK_QC_T_NONE		-1U
-#define BLK_QC_T_EAGAIN		-2U
 #define BLK_QC_T_SHIFT		16
 #define BLK_QC_T_INTERNAL	(1U << 31)
 
 static inline bool blk_qc_t_valid(blk_qc_t cookie)
 {
-	return cookie != BLK_QC_T_NONE && cookie != BLK_QC_T_EAGAIN;
+	return cookie != BLK_QC_T_NONE;
 }
 
 static inline unsigned int blk_qc_t_to_queue_num(blk_qc_t cookie)
-- 
2.27.0

