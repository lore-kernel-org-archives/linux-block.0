Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24565 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034985AbdDUD41 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2017 23:56:27 -0400
From: damien.lemoal@wdc.com
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <Bart.VanAssche@sandisk.com>,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH 04/10] dm: Fix REQ_OP_ZONE_RESET bio handling
Date: Fri, 21 Apr 2017 12:55:52 +0900
Message-Id: <20170421035558.2657-5-damien.lemoal@wdc.com>
In-Reply-To: <20170421035558.2657-1-damien.lemoal@wdc.com>
References: <20170421035558.2657-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Damien Le Moal <damien.lemoal@wdc.com>

The REQ_OP_ZONE_RESET bio has no payload and zero sectors. Its position
is the only information used to indicate the zone to reset on the
device. Due to its zero length, this bio is not cloned and sent to the
target through the non-flush case in __split_and_process_bio().
Add an additional case in that function to call
__split_and_process_non_flush() without checking the clone info size.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index dfb7597..1d98035 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1318,6 +1318,10 @@ static void __split_and_process_bio(struct mapped_device *md,
 		ci.sector_count = 0;
 		error = __send_empty_flush(&ci);
 		/* dec_pending submits any data associated with flush */
+	} else if (bio_op(bio) == REQ_OP_ZONE_RESET) {
+		ci.bio = bio;
+		ci.sector_count = 0;
+		error = __split_and_process_non_flush(&ci);
 	} else {
 		ci.bio = bio;
 		ci.sector_count = bio_sectors(bio);
-- 
2.9.3
