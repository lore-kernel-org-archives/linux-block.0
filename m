Return-Path: <Damien.LeMoal@hgst.com>
From: Damien Le Moal <damien.lemoal@hgst.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>, Damien
 Le Moal <damien.lemoal@hgst.com>, Hannes Reinecke <hare@suse.com>
Subject: [PATCH v3 3/7] block: update chunk_sectors in blk_stack_limits()
Date: Wed, 28 Sep 2016 10:22:33 +0900
Message-ID: <1475025757-6340-4-git-send-email-damien.lemoal@hgst.com>
In-Reply-To: <1475025757-6340-1-git-send-email-damien.lemoal@hgst.com>
References: <1475025757-6340-1-git-send-email-damien.lemoal@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@hgst.com
List-ID: <linux-block@vger.kernel.org>

From: Hannes Reinecke <hare@suse.de>

Signed-off-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Damien Le Moal <damien.lemoal@hgst.com>
---
 block/blk-settings.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index b1d5b7f..55369a6 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -631,6 +631,10 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			t->discard_granularity;
 	}
 
+	if (b->chunk_sectors)
+		t->chunk_sectors = min_not_zero(t->chunk_sectors,
+						b->chunk_sectors);
+
 	return ret;
 }
 EXPORT_SYMBOL(blk_stack_limits);
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
