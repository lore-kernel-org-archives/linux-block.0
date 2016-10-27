Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35902 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S942052AbcJ0SB6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2016 14:01:58 -0400
Received: by mail-lf0-f46.google.com with SMTP id b75so38487430lfg.3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2016 11:01:57 -0700 (PDT)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 7/7] lightnvm: rrpc: split bios of size > 256kb
Date: Thu, 27 Oct 2016 20:01:39 +0200
Message-Id: <1477591299-26504-8-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
References: <1477591299-26504-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

rrpc cannot handle bios of size > 256kb due to NVMe using a 64 bit
bitmap to signal I/O completion. If a larger bio comes, split it
explicitly.

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

