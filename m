Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C19D2836B0
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157309; cv=none; b=h1XhgHqfgwh0RDbp62jgj2K2CaqZ38ZArldjzphBiteuGOR65FZ4Y+y92cAoAhAMzGMr7rUTOxNfXDl/g40abVf0GlWRlpJwBMeS9N9CFVblTUMybPagqrtLQeNrqceUFHSF3ZqOXojUDWtxs0Gx7Qz7Vg7xvTKXt1zYG+fo8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157309; c=relaxed/simple;
	bh=JrmtKR3qIblf1d0YMEAg3JylDtvrtiBubAblukTe3PI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaTZ4kKvgt3YCCxsMcnQBD4angObUwLQ029ziFONW7g2TxK+tKDMytKVoSZu+uwkOcpQE5SghJ2q3fw0KaC5bqAATn2bDwsA5s7svNpVdIRvr5F5wTj27JrgZqc4Kn05s3O9lnbYPTAJMxsXTfcYxLE/eHTVgHYRWrQ3G65ESMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKOePly9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKOePly9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F95C19425;
	Fri, 27 Feb 2026 01:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157308;
	bh=JrmtKR3qIblf1d0YMEAg3JylDtvrtiBubAblukTe3PI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=oKOePly9muK6kRp+bniKF2TfR04D2NFonB9EdF7R/NbXrGC9l60t6lt9/39xz4fkY
	 k835OVz6dNLohrYttloUFrw71EvOpieSmCbIBikIeHzSNd4ugtN5GU61GtxJLthbhX
	 56tHGOz1T09CYBosgZBKNoSptDNkUXK7KR8laJcNUUX7HGKWV9YrkGSJmdSvyOu+Ja
	 qbmU5bw+60medQUURLQIdgMf9w78RYPtkxmmxkXAuDeFOV0iHldI3PmCohKt5Zjthj
	 x+NdfGCmmRLtA7MJJ00Tc5W/vpXA1A2WnAYi54OSDujXr4L06iKqoD17vf0BM0El2o
	 iRGrR46uu6K4g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v3 2/8] block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
Date: Fri, 27 Feb 2026 10:49:45 +0900
Message-ID: <20260227014951.2327711-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227014951.2327711-1-dlemoal@kernel.org>
References: <20260227014951.2327711-1-dlemoal@kernel.org>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6e3ef181e837..7aae3c236cad 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1154,13 +1154,17 @@ static void disk_zone_wplug_schedule_bio_work(struct gendisk *disk,
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

