Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADC24A06B
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198710; cv=none; b=qDwDP9459OOaJ7ikM1T0KVRUd5nDq5nsY1GFVQXz45Eu7B0PyHY03cyopGZiFOkCylBZKNUtiVQrnX/5ULhje+LtmxTI9fAxT2EtO74ecAGgI2wXTGE2so5Td085BdKIm+Ly1tS2I43VVl+v195J+CPHbgE5yUoCgjo9JCTql4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198710; c=relaxed/simple;
	bh=As2ibBLl5r+2aKTaTEMRVnYM3vHgUNPIooXxj66F9/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOF6gAJH6iIF59dvGFgpT4VVC9AXNd1/TamA82ShH6T+T7G0XDGyepeJpawSBDUDTtsk6K3XmPniO7KOGY6tu/ZpkxWwRLXHT6Coqw0mCmuo8VXTBPpPihTYQmkBwKNbF92ueb9iyQaKk7iPslk1gNimdVvN6ZgXBAJkzYMJMLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKqrpxJm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKqrpxJm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13144C116C6;
	Fri, 27 Feb 2026 13:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198710;
	bh=As2ibBLl5r+2aKTaTEMRVnYM3vHgUNPIooXxj66F9/8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DKqrpxJm3KZF7L5wO8TGu+/4c/rz3ADco1a/5q0tjgT8Z2EMV6DjGx8Yf97+mRbkf
	 0yFS1tPpdhL2Dcjlkg78uoEsORfFSayS8E4iO1Ht83YiDWKBKIuQy1Ku03VXEVOIRW
	 L1Nm9em/3scrXAN0xCSxWkEPFMGk+Tb8+PAYv5MUBVOYiCI9g7NsgHbZaqj4m68o0c
	 F6dm2gz42IfdjwFS0Rk/48rpVNhntm/tJNlfuwA/tEGKHG3ARPWIHHN1Oi1bhB5DZp
	 doyPpomu9hhxKI885Opi9M7ipdchYpYu27JMz2MFw28zFiXIi1qgDYh0ZbrXSlbfrc
	 S3fahqBH14Qpw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 4/8] block: remove disk_zone_is_full()
Date: Fri, 27 Feb 2026 22:19:47 +0900
Message-ID: <20260227131951.2464150-5-dlemoal@kernel.org>
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

The helper function disk_zone_is_full() is only used in
disk_zone_wplug_is_full(). So remove it and open code it directly in
this single caller.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-zoned.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 185651a0d617..26c2aa79faf6 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -492,18 +492,12 @@ static bool disk_zone_is_last(struct gendisk *disk, struct blk_zone *zone)
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

