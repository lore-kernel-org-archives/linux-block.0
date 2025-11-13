Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A71FF7C7
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041468; cv=none; b=uXjOXjSobdBZK6BXx6KI1Dch3Kv+YgMV7pCHvUL3+5D73kQnI/A6iQK9PfdJa6DTuAZFRb/tj9ja0CVYKwkWOE4z4f0/l9xVVIhpuiDd2kHCUeatBIj5ThJjQ9bHug3D8WjLEoGApxLoAtnqleDJRCJ55FVnbpE9Qz4l4Q0tUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041468; c=relaxed/simple;
	bh=bN7gH/+18S2Dc/GnFG/o12TFKQVX3BqsbenOBKpYHa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAiCRMuAw7Ey3tQdiXSWv/ZbJo3/AIn3GlU1gtRFNp9POwJ5hgR+olZ9ZwGp4SMXq4KikUn1Pt5eJyVHrjc4xz0p7YN1bAVXGJFeJoUzvnvZduzMbFkihYgy8tTMZhOIzMrZVdKRMkjtVlx3WKZCLM6F6P00qavGxTVOPDMDnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZwCIrOH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZwCIrOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A89C113D0;
	Thu, 13 Nov 2025 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041467;
	bh=bN7gH/+18S2Dc/GnFG/o12TFKQVX3BqsbenOBKpYHa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RZwCIrOHhRdLBdOqRSlgjB2zUkZFCPW2Wk+Ql3IxnnT6zTpkdhCdrrnt0fWUCYsnQ
	 UWhue6NIWbpaNS9INGft9vUH1DxtoxUm///6heI4a1F8+wxN3XFJlW5qc2ljrm9eye
	 ob7+qB4Ylhg/Et0Q38K7iex5V7E6UpBlN7+e4yUzQgJIUGM9j/OISe7rq7kulmPX4n
	 3ojb7NgjIU+MYTZzDyb7c1Sn+UWiBvxR8krlKyZLdhr8nuU0RZJjZqRb2TQ+FjLs5M
	 3FWf4IedBc861Z2YjICzPWWBGwm8F5+S6dCS9zAGBqqqGOFYtcY4e3zqKuE2N6Hg7e
	 urlk1Z1TaOX5A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/3] block: fix NULL pointer dereference in blk_zone_reset_all_bio_endio()
Date: Thu, 13 Nov 2025 22:40:26 +0900
Message-ID: <20251113134028.890166-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113134028.890166-1-dlemoal@kernel.org>
References: <20251113134028.890166-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For zoned block devices that do not need zone write plugs (e.g. most
device mapper devices that support zones), the disk hash table of zone
write plugs is NULL. For such devices, blk_zone_reset_all_bio_endio()
should not attempt to scan this has table as that causes a NULL pointer
dereference.

Fix this by checking that the disk does have zone write plugs using the
atomic counter. This is equivalent to checking for a non-NULL hash table
but has the advantage to also speed up the execution of
blk_zone_reset_all_bio_endio() for devices that do use zone write plugs
but do not have any plug in the hash table (e.g. a disk with only full
zones).

Fixes: efae226c2ef1 ("block: handle zone management operations completions")
Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 85de45c3f6be..98c26af01e24 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1118,17 +1118,20 @@ static void blk_zone_reset_all_bio_endio(struct bio *bio)
 	sector_t sector;
 	unsigned int i;
 
-	/* Update the condition of all zone write plugs. */
-	rcu_read_lock();
-	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
-		hlist_for_each_entry_rcu(zwplug, &disk->zone_wplugs_hash[i],
-					 node) {
-			spin_lock_irqsave(&zwplug->lock, flags);
-			disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
-			spin_unlock_irqrestore(&zwplug->lock, flags);
+	if (atomic_read(&disk->nr_zone_wplugs)) {
+		/* Update the condition of all zone write plugs. */
+		rcu_read_lock();
+		for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
+			hlist_for_each_entry_rcu(zwplug,
+						 &disk->zone_wplugs_hash[i],
+						 node) {
+				spin_lock_irqsave(&zwplug->lock, flags);
+				disk_zone_wplug_set_wp_offset(disk, zwplug, 0);
+				spin_unlock_irqrestore(&zwplug->lock, flags);
+			}
 		}
+		rcu_read_unlock();
 	}
-	rcu_read_unlock();
 
 	/* Update the cached zone conditions. */
 	for (sector = 0; sector < capacity;
-- 
2.51.1

