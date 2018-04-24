Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757528AbeDXMPL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 08:15:11 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 3/6] bcache: count backing device I/O error for writeback I/O
Date: Tue, 24 Apr 2018 20:14:43 +0800
Message-Id: <20180424121446.130552-4-colyli@suse.de>
In-Reply-To: <20180424121446.130552-1-colyli@suse.de>
References: <20180424121446.130552-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
counts backing device I/O requets and set dc->io_disable to true if error
counters exceeds dc->io_error_limit. But it only counts I/O errors for
regular I/O request, neglects errors of write back I/Os when backing device
is offline.

This patch counts the errors of writeback I/Os, in dirty_endio() if
bio->bi_status is  not 0, it means error happens when writing dirty keys
to backing device, then bch_count_backing_io_errors() is called.

By this fix, even there is no reqular I/O request coming, if writeback I/O
errors exceed dc->io_error_limit, the bcache device may still be stopped
for the broken backing device.

Fixes: c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 4a9547cdcdc5..ad45ebe1a74b 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -244,8 +244,10 @@ static void dirty_endio(struct bio *bio)
 	struct keybuf_key *w = bio->bi_private;
 	struct dirty_io *io = w->private;
 
-	if (bio->bi_status)
+	if (bio->bi_status) {
 		SET_KEY_DIRTY(&w->key, false);
+		bch_count_backing_io_errors(io->dc, bio);
+	}
 
 	closure_put(&io->cl);
 }
-- 
2.16.2
