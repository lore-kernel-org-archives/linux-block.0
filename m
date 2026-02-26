Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5C38947E
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079342; cv=none; b=nlESezZ2vxw8vGuZnuc6uj/NP1hzo2LbsW6niH7ad08fstUL9pX6Ldni2AS06Sq9+4KHu0pk9lj1MVrESSN6ivBpvLjh5Ogqk1Nf6l7zT7XDB8vZTO/LW2NNDMNoPJg2LOiAQUv9l8vvFmFlYFl5TvS2uY92OxSxkfG6T5QJLeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079342; c=relaxed/simple;
	bh=Ooh7QOwXTPTTENVQnnOJmUunLH1BMrkpouVhonLjYjA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lt20JPW7KT3I2wPHC9FzgDX9qfecFG0+uCmLUJjUf1ksm6YKS5cYJCuNXmuTefdQcX+NdrWAwZsW4lAIXh+w6K576r6x+KGH69Alx4W/mPamchgaWyYQcd0dS15l8033sT+Kdh4SZALb2Mc429cAKUEUBKhsgABrgz/OYmIrrWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wfp66RYl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wfp66RYl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38524C2BC87;
	Thu, 26 Feb 2026 04:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079342;
	bh=Ooh7QOwXTPTTENVQnnOJmUunLH1BMrkpouVhonLjYjA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Wfp66RYlNn31RyGX+QSm3wDzGjtoFF7sq5ryTrVkw0TDveRVt9exxh/o00ZgjGNtE
	 IG3X1UVmQ2p66y0ECt0IQkSCh5qJlNZ1XVhvBT899dXTyfzD+4IHdOduaLt6G/FVgG
	 0Bc9sKUczJQVLZEjmKVWlpWfHAb0ARJ/C3B/BZPNuMSYEgrM4uygP8X2TSw4TBNFBt
	 +woPQ+F5u+b08QwL1ZTyxnQuhIkIAA6Twv3RMkybj/V0g9WMcV7nEuM90zt3sPlEEY
	 YkxGrVB6sgv8fv2VDc6nhk5HYHGoDq9zL5aKIDKmw2GUQTi2Nlm/VEFkvrerxA3r38
	 gDjBVLsXkGp+A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 2/7] block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
Date: Thu, 26 Feb 2026 13:10:19 +0900
Message-ID: <20260226041024.2154806-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226041024.2154806-1-dlemoal@kernel.org>
References: <20260226041024.2154806-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function disk_zone_wplug_schedule_bio_work() always takes a
reference on the zone write plug of the BIO work being scheduled. This
ensures that the zone write plug cannot be freed while the BIO work is
being scheduled but has not run yet. However, this unconditional
reference taking is fragile since the reference taken is released by the
BIO work blk_zone_wplug_bio_work() function, which implies that there
always must be a 1:1 relation between the work being scheduled and the
work running.

Make sure to drop the reference taken when scheduling the BIO work if
the work is already scheduled, that is, when queue_work() returns false.

Fixes: 9e78c38ab30b ("block: Hold a reference on zone write plugs to schedule submission")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index fd404bdd5fa2..3f66e7ae699c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1165,13 +1165,17 @@ static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
 	lockdep_assert_held(&zwplug->lock);
 
 	/*
-	 * Take a reference on the zone write plug and schedule the submission
-	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-	 * reference we take here.
+	 * Schedule the submission of the next plugged BIO. Taking a reference
+	 * to the zone write plug is required as the bio_work belongs to the
+	 * plug, and thus we must ensure that the write plug does not go away
+	 * while the work is being scheduled but has not run yet.
+	 * blk_zone_wplug_bio_work() will release the reference we take here,
+	 * and we also drop this reference if the work is already scheduled.
 	 */
 	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
 	refcount_inc(&zwplug->ref);
-	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+	if (!queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
+		disk_put_zone_wplug(zwplug);
 }
 
 static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
-- 
2.53.0

