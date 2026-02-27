Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8174622B8C5
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198709; cv=none; b=Uoi4q0jPKZSJ/xvj1B4x5mFNbPEHh3F0DtBt0lCTCihanF6jXhIIaV92XVbDdDas5L80FqUBJgXLHVFSCGCB7awI/IG90FVpPGfd1gF4v/jP/28gupjRgLKmkI4e1T7/RSLTrbh0Z03Ak1iFTXCodFFh8ANMKU2gMUs9QxJzsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198709; c=relaxed/simple;
	bh=XDEqZXCMvz2SaHT/irez081sJ6mHC0olrEq0ylG3cao=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVyicyAyDJnou4dReVgQdRXsI8XFDCSSyuSwW/pcl1izmkEd1ltKXTsqE+zy3JF+EhKpXPc+3NNXwZsK9KYVkYfcQ+M2gwBFHZQf2V6J4+/b8fPtbknDiF3SDlymCHOw28e3gW8yIm0B664DB9fBfART97/8s/Mp8xQYTP7RvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODvn1dCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODvn1dCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC2A3C116C6;
	Fri, 27 Feb 2026 13:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198709;
	bh=XDEqZXCMvz2SaHT/irez081sJ6mHC0olrEq0ylG3cao=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ODvn1dCoahUm3k5bAMczfdbfNS24IJHHaOZkgpBd6KnNLqAU9O7rTV2HZE9u4mwXM
	 yBtHo2/dwiIGMqoKiiEfxp907XRTKbd7wRjzer8KBZVP6vqYPZbY3NQVmjFr6DQwrS
	 d5K4kzP9tDBN+hi1mIueZ34bzRKlXyPlaGeau8IrVq2LgsclShRb/exKOM/Yi61+37
	 fmAn3wEBOzc5iikMspGYZBbiURDkoROs1nljqWSVEbwMS9/kEK+ICY6ozCkrmydUaV
	 xRMmF5EJ9N2haj37VJ/yEI8w2gYihaMhROwwlGr2NVtosXRs+Xmah+UmZdUVlsho0P
	 36qIqe11mR0EQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 2/8] block: fix zone write plugs refcount handling in disk_zone_wplug_schedule_bio_work()
Date: Fri, 27 Feb 2026 22:19:45 +0900
Message-ID: <20260227131951.2464150-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227131951.2464150-1-dlemoal@kernel.org>
References: <20260227131951.2464150-1-dlemoal@kernel.org>
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

