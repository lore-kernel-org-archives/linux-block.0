Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 3/9] bio-integrity:  bio_integrity_advance must update integrity seed
Date: Wed, 10 May 2017 19:20:46 +0400
Message-Id: <1494429652-9488-4-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

SCSI drivers do care about bip_seed so we must update it accordingly.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
