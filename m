Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91C31A55F
	for <linux-block@vger.kernel.org>; Sat, 21 Feb 2026 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771634970; cv=none; b=D3F9s5vAx3PH+37BZ6EV6MFDzoFL1qtNUwKh7WcY9IDGe5USZTpVdgtUaRuN9k/PWjjAPg4Uxte/GzeeGt4vZ6j5KYZk7fULMCrZ5jJ8V0ULGJKjCrQPN6+yf0rjURSnechAepM4ckeXdQse8baz8EmAS/aVZVlXEgrpBKKFnNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771634970; c=relaxed/simple;
	bh=cZhXm/E+R7M/q1RPVIeNXcjwmyahrvTX+LlU1an1X6E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOSL/8hejFx1vqG866c4I8wSJ4xLg5SW2YIWgc3AwrmctZRZPuUkL+RPKtCo4AY1CKTcADOYMp8cy+bkH0tRcW/8HXkkEIqIn8TTtF4jXurCAs6E5g8ya+0M8lqMuAB0Q/dVoMHJs7vNQabwiycbWhTMu8PIG/2l+NXqHmDpyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3TQIoM1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3TQIoM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E245C19423;
	Sat, 21 Feb 2026 00:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771634970;
	bh=cZhXm/E+R7M/q1RPVIeNXcjwmyahrvTX+LlU1an1X6E=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=e3TQIoM1+rsbKWvYya2ygxGFGTSqUucm7ZrgbfvPWQRVawgSLc5OGtSFildAlp8Gi
	 s2pWWns3gcMIGQe0HluS0tm23DAyQgp54q9Kn6VcTwsVlRvMu3ko/UcUVFzB5YZEMC
	 azMppaHU62DofcatVkIJ1WQ36dku7UmB7i7MPfC2hUwQAI532XKt/+WRIScSjT8axb
	 WC0yq1t7PpALR3cKSaBf3jE97Jg36ll8ZNorW217xI3sFMWT/9/cqVcHta34wVPach
	 dy+wIHoit1jRPEMIOMycQliqoN0JADj4r9C2PZG9UUIuG/I1rGb/KF8KMwck/f70FG
	 B3BLmFW9/lijg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/8] block: remove disk_zone_is_full()
Date: Sat, 21 Feb 2026 09:44:06 +0900
Message-ID: <20260221004411.548482-4-dlemoal@kernel.org>
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

The helper function disk_zone_is_full() is only used in
disk_zone_wplug_is_full(). So remove it and open code it directly in
this single caller.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3dd50b2ba2bb..c5c91f927a71 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -484,18 +484,12 @@ static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
 	return zone->start + zone->len >= get_capacity(disk);
 }
 
-static bool disk_zone_is_full(struct gendisk *disk,
-			      unsigned int zno, unsigned int offset_in_zone)
-{
-	if (zno < disk->nr_zones - 1)
-		return offset_in_zone >= disk->zone_capacity;
-	return offset_in_zone >= disk->last_zone_capacity;
-}
-
 static bool disk_zone_wplug_is_full(struct gendisk *disk,
 				    struct blk_zone_wplug *zwplug)
 {
-	return disk_zone_is_full(disk, zwplug->zone_no, zwplug->wp_offset);
+	if (zwplug->zone_no < disk->nr_zones - 1)
+		return zwplug->wp_offset >= disk->zone_capacity;
+	return zwplug->wp_offset >= disk->last_zone_capacity;
 }
 
 static bool disk_insert_zone_wplug(struct gendisk *disk,
-- 
2.53.0

