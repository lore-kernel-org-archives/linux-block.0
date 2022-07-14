Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 830ABC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiGNSJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240594AbiGNSJT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:09:19 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40A113F1E
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:14 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id x21so1121261plb.3
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q9B/UQwROmLkAN4a7ICAKR8KbtppShCg87LLhZPn48o=;
        b=aTjVHl2XQ2BbXFlLPdaxVu82FCns1nf/WXMWvylQ/L/6ImRnPlK3lBSWZSKQecjKvB
         IrmcHbmYvq2OlTVSta+ovkbOMTjXPNFVZzvEjxqOy8jgWHcip6IiUTO9OpryCUkdeqOC
         1xkBHHVCuI5HQYtnmIJFebgzur9TO/aGHAoz1X5/qJQwvAAn5Cp39RaDv8IJgmELiQVV
         Wzp2JAmRUvkcVn9djDDZir+NIY/8wj4RCRmXYEvl1h7GXA5P6X5DE2QMYB9yJQ6XUMlZ
         nWiCl9tatbF2Pz7IbRwY4trlI8Jkn1ERoPyulJOkEVPekQIrqtF+s9kMlePSmzGLbh5A
         H22g==
X-Gm-Message-State: AJIora++aLN9sciFDx/itcb/WsVSx5tQFDThKfM9OmaeKGypI93iB4jD
        yEJXCElwKxPP0bKOrlU4nzt8vTQTC7E=
X-Google-Smtp-Source: AGRyM1usFPogHIeeAw8XTtAhqsDVgHRveFHN2YnSgz5KGhqv/sDI+GCtjJnpNcGvRCNm/c60wNGfYA==
X-Received: by 2002:a17:902:f708:b0:153:839f:bf2c with SMTP id h8-20020a170902f70800b00153839fbf2cmr9222612plo.113.1657822154374;
        Thu, 14 Jul 2022 11:09:14 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:09:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
Subject: [PATCH v3 60/63] fs/ocfs2: Use the enum req_op and blk_opf_t types
Date:   Thu, 14 Jul 2022 11:07:26 -0700
Message-Id: <20220714180729.1065367-61-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the last two
o2hb_setup_one_bio() arguments into a single argument.

Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/ocfs2/cluster/heartbeat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 5f83c0c0918c..b13d344d40b6 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -501,8 +501,7 @@ static void o2hb_bio_end_io(struct bio *bio)
 static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 				      struct o2hb_bio_wait_ctxt *wc,
 				      unsigned int *current_slot,
-				      unsigned int max_slots, int op,
-				      int op_flags)
+				      unsigned int max_slots, blk_opf_t opf)
 {
 	int len, current_page;
 	unsigned int vec_len, vec_start;
@@ -516,7 +515,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(reg->hr_bdev, 16, op | op_flags, GFP_ATOMIC);
+	bio = bio_alloc(reg->hr_bdev, 16, opf, GFP_ATOMIC);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -564,7 +563,7 @@ static int o2hb_read_slots(struct o2hb_region *reg,
 
 	while(current_slot < max_slots) {
 		bio = o2hb_setup_one_bio(reg, &wc, &current_slot, max_slots,
-					 REQ_OP_READ, 0);
+					 REQ_OP_READ);
 		if (IS_ERR(bio)) {
 			status = PTR_ERR(bio);
 			mlog_errno(status);
@@ -596,8 +595,8 @@ static int o2hb_issue_node_write(struct o2hb_region *reg,
 
 	slot = o2nm_this_node();
 
-	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE,
-				 REQ_SYNC);
+	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1,
+				 REQ_OP_WRITE | REQ_SYNC);
 	if (IS_ERR(bio)) {
 		status = PTR_ERR(bio);
 		mlog_errno(status);
