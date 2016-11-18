Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38633 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753237AbcKROoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 09:44:02 -0500
Received: by mail-wm0-f45.google.com with SMTP id f82so41997802wmf.1
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 06:44:01 -0800 (PST)
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 05/20] lightnvm: rrpc: split bios of size > 256kb
Date: Fri, 18 Nov 2016 15:43:27 +0100
Message-Id: <1479480222-18790-6-git-send-email-javier@cnexlabs.com>
In-Reply-To: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
References: <1479480222-18790-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Javier González <jg@lightnvm.io>

rrpc cannot handle bios of size > 256kb due to NVMe using a 64 bit
bitmap to signal I/O completion. If a larger bio comes, split it
explicitly.

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <m@bjorling.me>
---
 drivers/lightnvm/rrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/lightnvm/rrpc.c b/drivers/lightnvm/rrpc.c
index 2b71b7e..60ca9d4 100644
--- a/drivers/lightnvm/rrpc.c
+++ b/drivers/lightnvm/rrpc.c
@@ -943,6 +943,8 @@ static blk_qc_t rrpc_make_rq(struct request_queue *q, struct bio *bio)
 	struct nvm_rq *rqd;
 	int err;
 
+	blk_queue_split(q, &bio, q->bio_split);
+
 	if (bio_op(bio) == REQ_OP_DISCARD) {
 		rrpc_discard(rrpc, bio);
 		return BLK_QC_T_NONE;
-- 
2.7.4

