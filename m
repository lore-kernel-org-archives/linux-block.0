Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F333C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045F4218A3
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 12:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfBFMEs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:04:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:50026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729735AbfBFMEs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 07:04:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DD4FB681;
        Wed,  6 Feb 2019 12:04:47 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E8C1B1E3FE7; Wed,  6 Feb 2019 13:04:43 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] blktrace: Show requests without sector
Date:   Wed,  6 Feb 2019 13:04:40 +0100
Message-Id: <20190206120440.26557-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, blktrace will not show requests that don't have any data as
rq->__sector is initialized to -1 which is out of device range and thus
discarded by act_log_check(). This is most notably the case for cache
flush requests sent to the device. Fix the problem by making
blk_rq_trace_sector() return 0 for requests without initialized sector.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 include/linux/blktrace_api.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index 8804753805ac..353fd8c70760 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -116,7 +116,8 @@ extern void blk_fill_rwbs(char *rwbs, unsigned int op, int bytes);
 
 static inline sector_t blk_rq_trace_sector(struct request *rq)
 {
-	return blk_rq_is_passthrough(rq) ? 0 : blk_rq_pos(rq);
+	return (blk_rq_is_passthrough(rq) || blk_rq_pos(rq) == (sector_t)-1) ?
+		0 : blk_rq_pos(rq);
 }
 
 static inline unsigned int blk_rq_trace_nr_sectors(struct request *rq)
-- 
2.16.4

