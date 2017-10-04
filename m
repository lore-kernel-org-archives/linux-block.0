Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33935 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752247AbdJDNzh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Oct 2017 09:55:37 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, shli@kernel.org,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 9/9] dm-mpath: Add nowait support
Date: Wed,  4 Oct 2017 08:55:11 -0500
Message-Id: <20171004135511.26110-10-rgoldwyn@suse.de>
In-Reply-To: <20171004135511.26110-1-rgoldwyn@suse.de>
References: <20171004135511.26110-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

If there are no queues, bail if REQ_NOWAIT is set instead
of queueing up I/O.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 drivers/md/dm-mpath.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
index 11f273d2f018..d714c1b1b066 100644
--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -542,6 +542,11 @@ static int __multipath_map_bio(struct multipath *m, struct bio *bio, struct dm_m
 
 	if ((pgpath && queue_io) ||
 	    (!pgpath && test_bit(MPATHF_QUEUE_IF_NO_PATH, &m->flags))) {
+		/* Bail if nowait is set */
+		if (bio->bi_opf & REQ_NOWAIT) {
+			bio_wouldblock_error(bio);
+			return DM_MAPIO_SUBMITTED;
+		}
 		/* Queue for the daemon to resubmit */
 		spin_lock_irqsave(&m->lock, flags);
 		bio_list_add(&m->queued_bios, bio);
-- 
2.14.2
