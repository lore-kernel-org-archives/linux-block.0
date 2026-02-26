Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D63389E18
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079343; cv=none; b=U3+w2AaBuIn8hrNt8yJkl+NXyQmG6aknPU559AR71YT53QTudUKxwv3kgVY0b31d9a4VD7VWnXiEA+Rux9FsfxMyn8tDsNBCb5r2BpMIfF+2xTUD0mT8jNQFToDFdeQKJRLq9VyNvQmX35A6pKb+54tHuhGxeiPdTkH0R/BSnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079343; c=relaxed/simple;
	bh=NIuoj63Rje6SM/8sXjXV4z1kc8c1OwPr/WEfPN16Co8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ob7jHS/w6+lrfweqRWntRBLXbAhoWgAGCLi7BWRubrAxUYp5/4ijFul0ivcKNR4you+aQVYo2zi1vdgPxFd34LHrCF6NL0fThG2rRUz6dcosikT9zc/V6Vz9ApWJAdLI7AxbWff21fyhtJgW1Q3aRSX2AJXpZs4O7d6HOcGA6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbQHvQ4P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbQHvQ4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE24EC19424;
	Thu, 26 Feb 2026 04:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079343;
	bh=NIuoj63Rje6SM/8sXjXV4z1kc8c1OwPr/WEfPN16Co8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=dbQHvQ4PdELUO9BWA9CCI81jP1TnJZ/ApcFgUXAXhsJEfsKn38HjaPzjz0zvB0nNs
	 +Ha6crnsl3jVd1PmRuUKahUALYaKqXr4DJw6I5lYp/6qqzo4O1EGoeILSTnKYCcYyc
	 iFYZbRxQk8MUUzeifrCDUderK300WNdgrxLbzu9Z2jgAsnEN/APzuOvwyARhjlQD7F
	 Okawr6Oz6quFqAYI0nNTWcdfkRjlziaofD1su0p6/5pJ1fjre5U88EnWsdVPXIUMdl
	 B0dmLQfdm7LHRS+vLN4m+EorQh9TDJe7tY9MAuEEouGcGltgs/wknG96P61dJFqAnG
	 sXxgputkXsILA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 3/7] block: remove disk_zone_is_full()
Date: Thu, 26 Feb 2026 13:10:20 +0900
Message-ID: <20260226041024.2154806-4-dlemoal@kernel.org>
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

The helper function disk_zone_is_full() is only used in
disk_zone_wplug_is_full(). So remove it and open code it directly in
this single caller.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 3f66e7ae699c..12829e14fcda 100644
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

