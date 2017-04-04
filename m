Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35049 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755440AbdDDS4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2017 14:56:51 -0400
From: Dmitry Monakhov <dmonakhov@openvz.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH 2/9] bio-integrity: bio_trim should truncate integrity vector accordingly
Date: Tue,  4 Apr 2017 22:56:34 +0400
Message-Id: <1491332201-26926-3-git-send-email-dmonakhov@openvz.org>
In-Reply-To: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
References: <1491332201-26926-1-git-send-email-dmonakhov@openvz.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index e75878f..fa84323 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1907,6 +1907,10 @@ void bio_trim(struct bio *bio, int offset, int size)
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
