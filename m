Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00082CCA47C
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiF2XeH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbiF2Xdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:33:51 -0400
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC3101F5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:30 -0700 (PDT)
Received: by mail-pg1-f179.google.com with SMTP id h192so16803829pgc.4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uyfMfNw2LRMdBPhbjTTC3Mdmhusj5mPRWNdxFiACMWk=;
        b=v0Qzo3rC58DHrv/GgpwPgfJxxVZ4vV/8RbnLhqL49yvZTKsN2MPfb/BcHQGdRMNBQB
         aeqSdmadWxZ02lkYO0u1Oi0sy4UiKJ3peznPMDlVMhjUWUlqDIjvDrlPFRTW18SuCSBq
         hV3+eB14xTuofaXSs8ne+MqDTX6MVAqHiXOfnaJnlSXx1ChprSjCEWQrPm+6SW9HIHxL
         nAdN375mL4S/UN90j9d8CdUiy6+HQIYfSoSYHIYGufS2Y6xTffutA7tEwOUmDVDOpsgP
         KuDdHVvT5PexsZNrsmm7yHMy86Cxh1JNPiFrWLCMLUuEo8M5P8+An84jHGXxpFoN62VM
         A56Q==
X-Gm-Message-State: AJIora87EPPoKM6EwVpOTj/b9POD5kjMxBAF1F4QN1ERciKyQtnq45Y2
        y+2gsc8k9M5S1P6MZUtQLupC5dENwqI3TQ==
X-Google-Smtp-Source: AGRyM1vl5Guve+oskQVdNsiEBD8bla9HppMoGq1mL2F5AgmKO/OoIHsTTQIYyoBZq6bySSXGtmQIpg==
X-Received: by 2002:aa7:9a4e:0:b0:527:c943:54d9 with SMTP id x14-20020aa79a4e000000b00527c94354d9mr10856358pfj.31.1656545604414;
        Wed, 29 Jun 2022 16:33:24 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:33:23 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [PATCH v2 60/63] fs/ocfs2: Use the enum req_op and blk_opf_t types
Date:   Wed, 29 Jun 2022 16:31:42 -0700
Message-Id: <20220629233145.2779494-61-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve static type checking by using the enum req_op type for variables
that represent a request operation and the new blk_opf_t type for
variables that represent request flags. Combine the last two
o2hb_setup_one_bio() arguments into a single argument.

Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/ocfs2/cluster/heartbeat.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index ea0e70c0fce0..5d7e303b0293 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -503,8 +503,7 @@ static void o2hb_bio_end_io(struct bio *bio)
 static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 				      struct o2hb_bio_wait_ctxt *wc,
 				      unsigned int *current_slot,
-				      unsigned int max_slots, int op,
-				      int op_flags)
+				      unsigned int max_slots, blk_opf_t opf)
 {
 	int len, current_page;
 	unsigned int vec_len, vec_start;
@@ -518,7 +517,7 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(reg->hr_bdev, 16, op | op_flags, GFP_ATOMIC);
+	bio = bio_alloc(reg->hr_bdev, 16, opf, GFP_ATOMIC);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -566,7 +565,7 @@ static int o2hb_read_slots(struct o2hb_region *reg,
 
 	while(current_slot < max_slots) {
 		bio = o2hb_setup_one_bio(reg, &wc, &current_slot, max_slots,
-					 REQ_OP_READ, 0);
+					 REQ_OP_READ);
 		if (IS_ERR(bio)) {
 			status = PTR_ERR(bio);
 			mlog_errno(status);
@@ -598,7 +597,7 @@ static int o2hb_issue_node_write(struct o2hb_region *reg,
 
 	slot = o2nm_this_node();
 
-	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE,
+	bio = o2hb_setup_one_bio(reg, write_wc, &slot, slot+1, REQ_OP_WRITE |
 				 REQ_SYNC);
 	if (IS_ERR(bio)) {
 		status = PTR_ERR(bio);
