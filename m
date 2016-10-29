Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34367 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941434AbcJ2INM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Oct 2016 04:13:12 -0400
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 16/60] block: pktcdvd: comment on direct access to bvec table
Date: Sat, 29 Oct 2016 16:08:15 +0800
Message-Id: <1477728600-12938-17-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
References: <1477728600-12938-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/block/pktcdvd.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 90fa4ac149db..817d2cc17d01 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -1298,6 +1298,11 @@ static int pkt_handle_queue(struct pktcdvd_device *pd)
 static void pkt_start_write(struct pktcdvd_device *pd, struct packet_data *pkt)
 {
 	int f;
+
+	/*
+	 * Need to fix this usage for supporting multipage bvecs,
+	 * because the table can be changed in pkt_make_local_copy().
+	 */
 	struct bio_vec *bvec = pkt->w_bio->bi_io_vec;
 
 	bio_reset(pkt->w_bio);
-- 
2.7.4

