Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46152 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751327AbdGZX6o (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2017 19:58:44 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: hch@infradead.org, jack@suse.cz, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 8/9] dm: Add nowait support to dm-delay
Date: Wed, 26 Jul 2017 18:58:05 -0500
Message-Id: <20170726235806.12148-9-rgoldwyn@suse.de>
In-Reply-To: <20170726235806.12148-1-rgoldwyn@suse.de>
References: <20170726235806.12148-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

I/O should bail out if any value for delay is set.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/dm-delay.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index ae3158795d26..97da97c3c039 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -240,6 +240,10 @@ static int delay_bio(struct delay_c *dc, int delay, struct bio *bio)
 	if (!delay || !atomic_read(&dc->may_delay))
 		return DM_MAPIO_REMAPPED;
 
+	if (bio->bi_opf & REQ_NOWAIT) {
+		bio_wouldblock_error(bio);
+		return DM_MAPIO_SUBMITTED;
+	}
 	delayed = dm_per_bio_data(bio, sizeof(struct dm_delay_info));
 
 	delayed->context = dc;
-- 
2.12.3
