Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 2/9] bio-integrity: bio_trim should truncate integrity vector accordingly
Date: Wed, 10 May 2017 19:20:45 +0400
Message-Id: <1494429652-9488-3-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
References: <1494429652-9488-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 888e780..2f01f1b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1889,6 +1889,10 @@ void bio_trim(struct bio *bio, int offset, int size)
 	bio_advance(bio, offset << 9);
 
 	bio->bi_iter.bi_size = size;
+
+	if (bio_integrity(bio))
+		bio_integrity_trim(bio, 0, size);
+
 }
 EXPORT_SYMBOL_GPL(bio_trim);
 
-- 
2.9.3
