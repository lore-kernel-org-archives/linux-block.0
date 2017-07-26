Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46143 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751472AbdGZX6l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2017 19:58:41 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: hch@infradead.org, jack@suse.cz, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 7/9] dm: Add nowait support to raid1
Date: Wed, 26 Jul 2017 18:58:04 -0500
Message-Id: <20170726235806.12148-8-rgoldwyn@suse.de>
In-Reply-To: <20170726235806.12148-1-rgoldwyn@suse.de>
References: <20170726235806.12148-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

If the I/O would block because the devices are syncing, bail.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/dm-raid1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/dm-raid1.c b/drivers/md/dm-raid1.c
index a4fbd911d566..446ac581627f 100644
--- a/drivers/md/dm-raid1.c
+++ b/drivers/md/dm-raid1.c
@@ -1219,6 +1219,11 @@ static int mirror_map(struct dm_target *ti, struct bio *bio)
 		if (bio->bi_opf & REQ_RAHEAD)
 			return DM_MAPIO_KILL;
 
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return DM_MAPIO_SUBMITTED;
+		}
+
 		queue_bio(ms, bio, rw);
 		return DM_MAPIO_SUBMITTED;
 	}
-- 
2.12.3
