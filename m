Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C84A2054
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857908; cv=none; b=PNGvILqUxjReUE85aB3tByyy+8oa0FH0/iOMb5TENYwVqI0lnvtTLQYPzCfHnYhbmRhKDYVeJ3r7H655QPrlhj1TEFEPRCJpiS6CFNYHTKA9aEl3KEgZxXajCBhNpBDWPgit7InOUPWKHnC2MRRLv+xinQcKVnMbZfAN8kT2P5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857908; c=relaxed/simple;
	bh=T6rDAwf1+wRQXy22LhS/xvD1QqlauibA4mH86WHelf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTvgXpr8PCpWFxnTBxvSVMpF8uX9m3vCehbXpBEnPjODWGfca+cnHI6CuV+F76t7THOh2YInddogr9TcNKPLbZzXo6crmroTBxS/BEc4orueDxs1DyVpVvTqE6nZIOKbuPu0h+oj6UhJBXEGum/ttEkl+w9y42g02+2brsejnzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO5sSDDo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO5sSDDo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20121F0155E;
	Tue,  8 Sep 2026 08:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857885;
	bh=co+HsxPmG7REONwVhPUIrs5/7ySjY8BK/rqP5jFpLOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IO5sSDDo0C+8u2wZLXs1GZvNZJCxQXBkPwE4HkyEdz/9CYysMlc12+lwfO3E+Dojp
	 q1271SYyX7ylUHHBVi5lNBsBtxZ41R8rGbOnDCVB0lmRKR0w3fectQ3VnmGoxSfXPw
	 kvOmta3XAMVznAfTgIvjV+ZCRRSV9Q6AtnE1dZdmvVnbfriUyZsFlxmjTVfdxuxZW8
	 IKvVwgLFU+nNx6hE68A1DagLQLmGpZf1iYTvBX/IlMsH+pENp6YDUmPtVxZ66VVnqI
	 KQ7VjFdTn2dRPkgVpbmh5FsvbbpDiYPMUSJNgPdeJ38294Fi/SxNbwaBOaryt4C7AU
	 SzGFGf8IoKaKg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 11/16] block: retry zone revalidation on capacity change
Date: Tue,  8 Sep 2026 17:57:40 +0900
Message-ID: <20260908085745.1082697-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908085745.1082697-1-dlemoal@kernel.org>
References: <20260908085745.1082697-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When disk_revalidate_zone_resources() detects a capacity change, -ENODEV
is returned, failing the disk revalidation. However, since a capacity
change may happen due to a storage element removal being executed
concurrently to blk_revalidate_disk_zones(), we can simply retry the
revalidation to capture the new zone state with the new capacity without
failing the revalidation.

Retrying the revalidation is driven by disk_revalidate_zone_resources()
returning -EAGAIN when a new valid capacity is detected. And to avoid
getting stuck in an infinite loop revalidating zones, retries are limited
to 2.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e7f20b5262c7..96e922b7a126 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2175,7 +2175,11 @@ static int disk_revalidate_zone_resources(struct gendisk *disk,
 	if (args->capacity != capacity) {
 		pr_warn("%s: Capacity has changed (%llu -> %llu)\n",
 			disk->disk_name, args->capacity, capacity);
-		ret = -ENODEV;
+		/* Force a retry if we have a valid (non-zero) capacity. */
+		if (capacity)
+			ret = -EAGAIN;
+		else
+			ret = -ENODEV;
 		goto unfreeze;
 	}
 
@@ -2491,6 +2495,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 		.data = &args,
 	};
 	unsigned int noio_flag;
+	int retries = 2;
 	int ret;
 
 	if (WARN_ON_ONCE(!blk_queue_is_zoned(disk->queue)))
@@ -2502,6 +2507,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	 */
 	mutex_lock(&disk->zone_revalidate_mutex);
 
+again:
 	ret = disk_revalidate_capacity(disk, &args);
 	if (ret)
 		goto unlock;
@@ -2546,10 +2552,18 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	return 0;
 
 free_args:
-	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
-
 	kfree(args.zones_state);
 
+	if (ret == -EAGAIN) {
+		if (retries) {
+			memset(&args, 0, sizeof(args));
+			retries--;
+			goto again;
+		}
+		ret = -ENODEV;
+	}
+
+	pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
 unlock:
 	mutex_unlock(&disk->zone_revalidate_mutex);
 
-- 
2.55.0

