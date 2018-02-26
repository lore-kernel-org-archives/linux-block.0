Return-Path: <jiufei.xue@linux.alibaba.com>
From: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Subject: [PATCH 4/4] block: fix a typo
To: hch@lst.de, Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, caspar@linux.alibaba.com,
 Joseph Qi <joseph.qi@linux.alibaba.com>
References: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Message-ID: <e2b40779-497a-5b32-0ffe-c6d1800b7200@linux.alibaba.com>
Date: Mon, 26 Feb 2018 20:04:44 +0800
MIME-Version: 1.0
In-Reply-To: <fc363a8d-957c-be3a-e60a-a8b40727d727@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

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
