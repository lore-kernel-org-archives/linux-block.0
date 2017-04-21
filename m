Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:36240 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034979AbdDUD43 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 23:56:29 -0400
From: damien.lemoal@wdc.com
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 05/10] dm: Fix REQ_OP_ZONE_REPORT bio handling
Date: Fri, 21 Apr 2017 12:55:53 +0900
Message-Id: <20170421035558.2657-6-damien.lemoal@wdc.com>
In-Reply-To: <20170421035558.2657-1-damien.lemoal@wdc.com>
References: <20170421035558.2657-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

A REQ_OP_ZONE_REPORT bio is not a medium access command. Its number of
sectors indicates the maximum size allowed for the report reply size
and not an amount of sectors accessed from the device.
REQ_OP_ZONE_REPORT bios should thus not be split depending on the
target device maximum I/O length but passed as is. Note that it is the
responsability of the target to remap and format the report reply.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 1d98035..cd44928 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1098,7 +1098,8 @@ static int clone_bio(struct dm_target_io *tio, struct bio *bio,
 			return r;
 	}
 
-	bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
+	if (bio_op(bio) != REQ_OP_ZONE_REPORT)
+		bio_advance(clone, to_bytes(sector - clone->bi_iter.bi_sector));
 	clone->bi_iter.bi_size = to_bytes(len);
 
 	if (bio_integrity(bio))
@@ -1275,7 +1276,11 @@ static int __split_and_process_non_flush(struct clone_info *ci)
 	if (!dm_target_is_valid(ti))
 		return -EIO;
 
-	len = min_t(sector_t, max_io_len(ci->sector, ti), ci->sector_count);
+	if (bio_op(bio) == REQ_OP_ZONE_REPORT)
+		len = ci->sector_count;
+	else
+		len = min_t(sector_t, max_io_len(ci->sector, ti),
+			    ci->sector_count);
 
 	r = __clone_and_map_data_bio(ci, ti, ci->sector, &len);
 	if (r < 0)
-- 
2.9.3
