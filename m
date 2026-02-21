Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269F9476
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634971; cv=none; b=q0DvfsZeIvZ/ie3lIdE97MTFn8ri/5uB1cdFlqg8MdtlSI9Z9dpzIfjCLt0BMZdx83lFfwFuDfxcgxacZHkmbtcGk4eKaSUeqRi+6yyAqOmUcX/GaFSPDdJ/2An2I3InTQRiV7LF4/7IdsDurmvYL3IGTOWm9A4PQyq4FODvVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634971; c=relaxed/simple;
	bh=GPazoD95sQhWQS0PsTlYwH7xzpjxyUhtIJKyJZEyUjk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVcRKEle6xsKCdPxrU1iArM4YiHHTLmABmBIjlGXbpZH90wHs6pVhcPew2UaSSTISgmZPF7t1PSAXSNMYfSMMH2EZ+27DqPblDWZiR3uc6s7yGFK1Rk5JXy6KI7r6OmyPS77ucDG17NqalwD9mDMV2MbkIVawwKRypgV+9oLto8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvEIyUZl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvEIyUZl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D8DC116C6;
	Sat, 21 Feb 2026 00:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634971;
	bh=GPazoD95sQhWQS0PsTlYwH7xzpjxyUhtIJKyJZEyUjk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=gvEIyUZlg6SN9xduFNkQqqIScXfM42Ak4fewEUAcOtaey4JdaCU9daMMZrLtHupPv
	 4RDG9NrX95FpQfLIbRgo/XvjbYLDHwwORnZM68Zti/tMEFovtTGgT41jkm+2STEuPL
	 5jbL0K0uVoDpyXvdyMmg9KMREQApDPsKYDwZqOyGPBIROLGJhd5EOHPxMg5VPputmk
	 4kU6ym3kgjVXe451mNGHTd95TwnJx7bQw/odp13rdknH7yyD9hqhHkFkDtmcDGOEpM
	 9/6LColZh4IXPtOx7qQBanV65XIOgGJYaaHp/k1J4FHyUW0YfBWic5u0LnZ/WtWasN
	 qSCwKIVo0ztNg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/8] block: improve disk_zone_wplug_schedule_bio_work()
Date: Sat, 21 Feb 2026 09:44:07 +0900
Message-ID: <20260221004411.548482-5-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260221004411.548482-1-dlemoal@kernel.org>
References: <20260221004411.548482-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function disk_zone_wplug_schedule_bio_work() always takes a
reference on the zone write plug of the BIO work being scheduled. This
ensure that the zone write plug cannot be freed while the BIO work is
being scheduled but has not run yet. However, this unconditional
reference taking is fragile since the reference taken is realized by the
BIO work blk_zone_wplug_bio_work() function, which implies that there
always must be a 1:1 relation between the work being scheduled and the
work running.

Make this less fragile by taking the reference on the BIO work if and
only if the BIO work has not been already scheduled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c5c91f927a71..4b388ae1acaa 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1205,13 +1205,15 @@ static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
 	lockdep_assert_held(&zwplug->lock);
 
 	/*
-	 * Take a reference on the zone write plug and schedule the submission
-	 * of the next plugged BIO. blk_zone_wplug_bio_work() will release the
-	 * reference we take here.
+	 * Schedule the submission of the next plugged BIO. If the zone write
+	 * plug BIO work is not already scheduled, take a reference on the zone
+	 * write plug to ensure that it does not go away while the work is being
+	 * scheduled but has not run yet. blk_zone_wplug_bio_work() will release
+	 * the reference we take here.
 	 */
 	WARN_ON_ONCE(!(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED));
-	refcount_inc(&zwplug->ref);
-	queue_work(disk->zone_wplugs_wq, &zwplug->bio_work);
+	if (queue_work(disk->zone_wplugs_wq, &zwplug->bio_work))
+		refcount_inc(&zwplug->ref);
 }
 
 static inline void disk_zone_wplug_add_bio(struct gendisk *disk,
-- 
2.53.0

