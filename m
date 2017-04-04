Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33217 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754293AbdDDS4w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 14:56:52 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
Date: Tue,  4 Apr 2017 22:56:35 +0400
Message-Id: <1491332201-26926-4-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

SCSI drivers do care about bip_seed so we must update it accordingly.

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio-integrity.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b5009a8..82a6ffb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -425,6 +425,7 @@ void bio_integrity_advance(struct bio *bio, unsigned int bytes_done)
 	struct blk_integrity *bi = bdev_get_integrity(bio->bi_bdev);
 	unsigned bytes = bio_integrity_bytes(bi, bytes_done >> 9);
 
+	bip->bip_iter.bi_sector += bytes_done >> 9;
 	bvec_iter_advance(bip->bip_vec, &bip->bip_iter, bytes);
 }
 EXPORT_SYMBOL(bio_integrity_advance);
-- 
2.9.3
