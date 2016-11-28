Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:35602 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755559AbcK1Vjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2016 16:39:44 -0500
Received: by mail-wj0-f193.google.com with SMTP id he10so1527354wjc.2
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2016 13:39:43 -0800 (PST)
From: =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: axboe@fb.com, =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <jg@lightnvm.io>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <m@bjorling.me>
Subject: [PATCH 07/23] lightnvm: rrpc: split bios of size > 256kb
Date: Mon, 28 Nov 2016 22:38:58 +0100
Message-Id: <20161128213914.12516-8-m@bjorling.me>
In-Reply-To: <20161128213914.12516-1-m@bjorling.me>
References: <20161128213914.12516-1-m@bjorling.me>
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
2.9.3

