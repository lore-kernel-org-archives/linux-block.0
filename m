Return-Path: <jiufei.xue@linux.alibaba.com>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 4/4] block: fix a typo
To: Christoph Hellwig <hch@lst.de>, Shaohua Li <shli@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block <linux-block@vger.kernel.org>, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Message-ID: <8c723675-5798-a25e-612e-4115938f39cc@linux.alibaba.com>
Date: Tue, 27 Feb 2018 20:10:22 +0800
MIME-Version: 1.0
In-Reply-To: <014d8f0c-31db-c18b-855e-5e425b9499be@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Fix a typo in pkt_start_recovery.

Fixes: 74d46992e0d9 ("block: replace bi_bdev with a gendisk pointer and partitions index")
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
---
 drivers/block/pktcdvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 531a091..c61d20c 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1122,7 +1122,7 @@ static int pkt_start_recovery(struct packet_data *pkt)
 	pkt->sector = new_sector;
 
 	bio_reset(pkt->bio);
-	bio_set_set(pkt->bio, pd->bdev);
+	bio_set_dev(pkt->bio, pd->bdev);
 	bio_set_op_attrs(pkt->bio, REQ_OP_WRITE, 0);
 	pkt->bio->bi_iter.bi_sector = new_sector;
 	pkt->bio->bi_iter.bi_size = pkt->frames * CD_FRAMESIZE;
-- 
1.9.4
