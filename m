Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D253C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 13:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2527D2084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 13:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCNAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:00:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:53636 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfDCNAj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 3 Apr 2019 09:00:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 35512AEB0
        for <linux-block@vger.kernel.org>; Wed,  3 Apr 2019 13:00:38 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-block@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] block: Remove redundant union declaration
Date:   Wed,  3 Apr 2019 16:00:35 +0300
Message-Id: <20190403130035.29024-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is no point in declaring bi_integrity inside a union so just
remove it.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 include/linux/blk_types.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 791fee35df88..92f576ebfc15 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -182,11 +182,9 @@ struct bio {
 	struct blkcg_gq		*bi_blkg;
 	struct bio_issue	bi_issue;
 #endif
-	union {
 #if defined(CONFIG_BLK_DEV_INTEGRITY)
-		struct bio_integrity_payload *bi_integrity; /* data integrity */
+	struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
-	};
 
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 
-- 
2.17.1

