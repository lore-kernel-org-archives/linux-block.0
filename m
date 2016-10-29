Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34587 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbcJ2INt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:13:49 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 25/60] block: pktcdvd: set NO_MP for pktcdvd request queue
Date: Sat, 29 Oct 2016 16:08:24 +0800
Message-Id: <1477728600-12938-26-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

At least pkt_start_write() operates on the bvec table directly,
it isn't ready to enable multipage bvec yet, so mark the
flag now.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/pktcdvd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 817d2cc17d01..403c93b46ea3 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2518,6 +2518,9 @@ static void pkt_init_queue(struct pktcdvd_device *pd)
 	blk_queue_logical_block_size(q, CD_FRAMESIZE);
 	blk_queue_max_hw_sectors(q, PACKET_MAX_SECTORS);
 	q->queuedata = pd;
+
+	/* not ready for multipage bvec yet */
+	set_bit(QUEUE_FLAG_NO_MP, &q->queue_flags);
 }
 
 static int pkt_seq_show(struct seq_file *m, void *p)
-- 
2.7.4

