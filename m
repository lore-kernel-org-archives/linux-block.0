Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46062 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbdGZX6f (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2017 19:58:35 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: hch@infradead.org, jack@suse.cz, linux-raid@vger.kernel.org,
        dm-devel@redhat.com, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/9] md: raid5 nowait support
Date: Wed, 26 Jul 2017 18:58:01 -0500
Message-Id: <20170726235806.12148-5-rgoldwyn@suse.de>
In-Reply-To: <20170726235806.12148-1-rgoldwyn@suse.de>
References: <20170726235806.12148-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Return EAGAIN in case RAID5 would block because of waiting due to:
 + Reshaping
 + Suspension
 + Stripe Expansion

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/raid5.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index aeeb8d6854e2..d1b3bcf26d29 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5635,6 +5635,11 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				    ? logical_sector < conf->reshape_safe
 				    : logical_sector >= conf->reshape_safe) {
 					spin_unlock_irq(&conf->device_lock);
+					if (bi->bi_opf & REQ_NOWAIT) {
+						bio_wouldblock_error(bi);
+						finish_wait(&conf->wait_for_overlap, &w);
+						return true;
+					}
 					schedule();
 					do_prepare = true;
 					goto retry;
@@ -5672,6 +5677,11 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				spin_unlock_irq(&conf->device_lock);
 				if (must_retry) {
 					raid5_release_stripe(sh);
+					if (bi->bi_opf & REQ_NOWAIT) {
+						bio_wouldblock_error(bi);
+						finish_wait(&conf->wait_for_overlap, &w);
+						return true;
+					}
 					schedule();
 					do_prepare = true;
 					goto retry;
@@ -5700,6 +5710,11 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 					sigset_t full, old;
 					sigfillset(&full);
 					sigprocmask(SIG_BLOCK, &full, &old);
+					if (bi->bi_opf & REQ_NOWAIT) {
+						bio_wouldblock_error(bi);
+						finish_wait(&conf->wait_for_overlap, &w);
+						return true;
+					}
 					schedule();
 					sigprocmask(SIG_SETMASK, &old, NULL);
 					do_prepare = true;
@@ -5715,6 +5730,11 @@ static bool raid5_make_request(struct mddev *mddev, struct bio * bi)
 				 */
 				md_wakeup_thread(mddev->thread);
 				raid5_release_stripe(sh);
+				if (bi->bi_opf & REQ_NOWAIT) {
+					bio_wouldblock_error(bi);
+					finish_wait(&conf->wait_for_overlap, &w);
+					return true;
+				}
 				schedule();
 				do_prepare = true;
 				goto retry;
-- 
2.12.3
