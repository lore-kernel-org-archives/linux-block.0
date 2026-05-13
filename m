Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AAC345757
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670697; cv=none; b=k5zA1oQqzDvTO/IVMBQPYk8sZ9lphIcAikD0r1i3u8VFcgs1qQSgdqRwJ/8rDEA/U7m/trSJLX603Edin3uAwo2p2XbhJFxwg2cfR1w7hAI7fZBtUQ3N+kDWY5/7I5NJI7IM2Dk1Vhp/i002ek+MgQfbTFRVcIApeBbltR7XS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670697; c=relaxed/simple;
	bh=HQEIG+tzDA3S/qLHC1nYQNI/o+I+qkXUb1kbs+52NgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6Z2rB7dYKaIGYi4hdXpfWYutXXyAfh7+QtX7aFrgci1P82ElwWC4TCqTq9uJqvP+6femtxtXxaTNfhI7H7g+3uWrcuIa6jHF4IFsiT0G3YIyscQ6MoKjbwrAe4nIangvkJplzxVZpGQY3zvetxqJRK4oZ42OGPVbCmYJSlgLeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0aEphFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0aEphFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A596AC2BCB7;
	Wed, 13 May 2026 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778670697;
	bh=HQEIG+tzDA3S/qLHC1nYQNI/o+I+qkXUb1kbs+52NgM=;
	h=From:To:Cc:Subject:Date:From;
	b=d0aEphFO1g+6gGa13kZ+oB/LePkOq6+HktTtjc0nzLNEJbusTk5wvTXCw34w0xm/X
	 Es/8dt3Cn2lM/M01LP8aE8/OaQklGwlqLrPBNcs9koRWbo/HyynYT5z/UkJpYwruRJ
	 Plv8mS0pmOjUFVUrUaWyZujiMMzbRST0tq4ea/LxWGlkQ+/MIACvdstruEoRPXFcgm
	 KZr69sokB/XAELjHmGlEBGiwMxxRQ018qXCwZP2RgBck2Y2zDkCcl4htavF644AYK+
	 rc9neuAIxNks9Yr5n9CRHZsxM0n3RlsuVGqN/GD0Jw9jmkw6D5mYrHETYecDwUhPRH
	 LgbMZmSRMxNAg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: fix handling of dead zone write plugs
Date: Wed, 13 May 2026 20:11:29 +0900
Message-ID: <20260513111129.108809-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shin'ichiro reported hard to reproduce unaligned write errors with zoned
block devices. Under normal operation conditions (e.g. running XFS on an
SMR disk), these errors are nearly impossible to trigger. But using a
"slow" kernel with many debug options enables and some specific use cases
(e.g. fio zbd test case 46), the errors can be reproduced fairly easily.

The unaligned write errors come from mishandling a valid reference
counting pattern of zone write plugs. Such pattern triggers for instance
if a process A writes a zone (not necessarilly to the full state), another
process B immediately resets the zone and immediately following the
completion of the zone reset, starts issuing writes to the zone. With such
pattern, in some cases, the zone write plugs worker thread of the device
may still be holding a reference to the zone write plug of the zone taken
when process A was writing to the zone. The following zone reset from
process B marks the zone as dead but does not remove the zone write plug
from the device hash table as a reference to the plug still exist. Once
process B starts issuing new writes, the zone write plug is seen as dead
and the writes from process B are immediately failed, despite this write
pattern being perfectly legal.

Fix this by allowing restoring a dead zone write plug to a live state if a
write is issued to the zone when the zone is: marked as dead, empty and
the write sector corresponds to the first sector of the zone (that is, the
write is aligned to the zone write pointer). This is done with the new
helper function disk_check_zone_wplug_dead(), which restores a dead zone
write plug to a live state by clearing the BLK_ZONE_WPLUG_DEAD flag and
restoring the initial reference to the zone write plug taken when the plug
was added to the device hash table.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: b7d4ffb51037 ("block: fix zone write plug removal")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 30cad2bb9291..42ef830054dc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -623,6 +623,28 @@ static void disk_mark_zone_wplug_dead(struct blk_zone_wplug *zwplug)
 	}
 }
 
+static inline bool disk_check_zone_wplug_dead(struct blk_zone_wplug *zwplug)
+{
+	if (!(zwplug->flags & BLK_ZONE_WPLUG_DEAD))
+		return false;
+
+	/*
+	 * If a new write is received right after a zone reset completes and
+	 * while the disk_zone_wplugs_worker() thread has not yet released the
+	 * reference on the zone write plug after processing the last write to
+	 * the zone, then the new write BIO will see the zone write plug marked
+	 * as dead. This case is however a false positive and a perfectly valid
+	 * pattern. In such case, restore the zone write plug to a live one.
+	 */
+	if (!zwplug->wp_offset && bio_list_empty(&zwplug->bio_list)) {
+		zwplug->flags &= ~BLK_ZONE_WPLUG_DEAD;
+		refcount_inc(&zwplug->ref);
+		return false;
+	}
+
+	return true;
+}
+
 static bool disk_zone_wplug_submit_bio(struct gendisk *disk,
 				       struct blk_zone_wplug *zwplug);
 
@@ -1444,12 +1466,12 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 	spin_lock_irqsave(&zwplug->lock, flags);
 
 	/*
-	 * If we got a zone write plug marked as dead, then the user is issuing
-	 * writes to a full zone, or without synchronizing with zone reset or
-	 * zone finish operations. In such case, fail the BIO to signal this
-	 * invalid usage.
+	 * Check if we got a zone write plug marked as dead. If yes, then the
+	 * user is likely issuing writes to a full zone, or without
+	 * synchronizing with zone reset or zone finish operations. In such
+	 * case, fail the BIO to signal this invalid usage.
 	 */
-	if (zwplug->flags & BLK_ZONE_WPLUG_DEAD) {
+	if (disk_check_zone_wplug_dead(zwplug)) {
 		spin_unlock_irqrestore(&zwplug->lock, flags);
 		disk_put_zone_wplug(zwplug);
 		bio_io_error(bio);
-- 
2.54.0

