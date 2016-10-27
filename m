Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36753 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbcJ0OuI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 10:50:08 -0400
Received: by mail-wm0-f47.google.com with SMTP id b80so38814291wme.1
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 07:50:08 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 7/7] lightnvm: rrpc: split bios of size > 256kb
Date: Thu, 27 Oct 2016 16:49:43 +0200
Message-Id: <1477579783-5289-7-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
References: <1477579783-5289-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rrpc cannot handle bios of size > 256kb due to NVME's 64 bit completion
bitmap. If a larger bio comes, split it explicitly.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/rrpc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 8deef2e..0b8251f 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -984,6 +984,12 @@ static blk_qc_t rrpc_make_rq(struct request_queue *q, struct bio *bio)
 	struct nvm_rq *rqd;
 	int err;
 
+	/*
+	 * Multipage is supported up until 256kb due to NVME's 64 bit completion
+	 * bitmap.
+	 */
+	blk_queue_split(q, &bio, q->bio_split);
+
 	if (bio_op(bio) == REQ_OP_DISCARD) {
 		rrpc_discard(rrpc, bio);
 		return BLK_QC_T_NONE;
-- 
2.7.4

