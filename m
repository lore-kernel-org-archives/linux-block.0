Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:48315 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbdJMXgO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 19:36:14 -0400
Received: by mail-pg0-f65.google.com with SMTP id v78so2336965pgb.5
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 16:36:13 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Michael Lyle <mlyle@lyle.org>
Subject: [PATCH 12/15] bcache: rearrange writeback main thread ratelimit
Date: Fri, 13 Oct 2017 16:35:39 -0700
Message-Id: <20171013233542.20938-13-mlyle@lyle.org>
In-Reply-To: <20171013233542.20938-1-mlyle@lyle.org>
References: <20171013233542.20938-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The time spent searching for things to write back "counts" for the
actual rate achieved, so don't flush the accumulated rate with each
chunk.

This will maintain better fidelity to user-commanded rates, but it
may slightly increase the burstiness of writeback.  The writeback
lock needs improvement to help mitigate this.

Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/bcache/writeback.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 897d28050656..9b770b13bdf6 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -440,6 +440,8 @@ static int bch_writeback_thread(void *arg)
 	struct cached_dev *dc = arg;
 	bool searched_full_index;
 
+	bch_ratelimit_reset(&dc->writeback_rate);
+
 	while (!kthread_should_stop()) {
 		down_write(&dc->writeback_lock);
 		if (!atomic_read(&dc->has_dirty) ||
@@ -467,7 +469,6 @@ static int bch_writeback_thread(void *arg)
 
 		up_write(&dc->writeback_lock);
 
-		bch_ratelimit_reset(&dc->writeback_rate);
 		read_dirty(dc);
 
 		if (searched_full_index) {
@@ -477,6 +478,8 @@ static int bch_writeback_thread(void *arg)
 			       !kthread_should_stop() &&
 			       !test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags))
 				delay = schedule_timeout_interruptible(delay);
+
+			bch_ratelimit_reset(&dc->writeback_rate);
 		}
 	}
 
-- 
2.11.0
