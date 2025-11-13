Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D417C227EA4
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763041470; cv=none; b=JUwsXqg+yYEVx34mwBA/HBFSFFm9bXUy70eb6Tuj3lwHeVVQkELkan1H3bwtH3MUVkzFtF4XXL0zI7z5hxn8dgQv7gRtX4RM+XLWiRSkkG7rBxVJNKT8zKBKKngcug5Ju/lkJ7b5dGadk1mxTXH5d0VBAZ3e2RIxjukZ7Jy9X68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763041470; c=relaxed/simple;
	bh=Lhc+NPT+uwR6YP1/afH8dFPu0glCSw1Jhl433PH8b/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tnl6Bqmr1O7p9T+HZf1ffxpOtPki5qJvwzyyvSrsZlHk0XayuWnBInt+BtyyoMS9hm5f86C7fCKM5uHLcgZYiLvLtjMlC57O4zQ54GJrZnbeeiOWZiN315xwqePf2Y894lc2zm4Z9edNz8+9O0nz6H06O9PP/lQQizF7zo2FvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMB4nSsE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMB4nSsE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68CD9C116D0;
	Thu, 13 Nov 2025 13:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763041470;
	bh=Lhc+NPT+uwR6YP1/afH8dFPu0glCSw1Jhl433PH8b/k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fMB4nSsEOZPM2t1BuEsuBpjD52keAylXgdB8kiyB85rSnF1hqERdCkoinfIrk+ZKW
	 18DHtbZkBqgI00BL4khAq46Xl6nBi9t+3J5x+GvIeaXNfGhb2JK2j8A13HCCo5A3/Q
	 lcz/noNSPMmnGpbDKN4pOxdniZUOs/Wj9FkUPo5MF9cZrY98iyzAKRxpziva202tMq
	 80SbFdb7vjSa3GM9Jb8zVC76lRl06BwgQT36edJVPbqmVbrhCPRcNnfCRq/xKVlmZf
	 Byl9NFFnfduu42w8MjZxIoOcgma8Xu4e80lyXRo1DmNzBZshizdlJeLOcEDZEbzQqE
	 p9ERLSxhaE2BA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] dm: fix zone reset all operation processing
Date: Thu, 13 Nov 2025 22:40:28 +0900
Message-ID: <20251113134028.890166-4-dlemoal@kernel.org>
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

dm_zone_get_reset_bitmap() is used to generate a bitmap of the zones of
a zoned device target when a REQ_OP_ZONE_RESET_ALL request is being
processed. This bitmap is built by executing a zone report with a report
callback set to the function dm_zone_need_reset_cb() in struct
dm_report_zones_args. However, the cb callback pointer is not anymore
the same as the callback specified by callers of the
blkdev_report_zones() function. Rather, this is a DM internal callback
and report zones callback functions from blkdev_report_zones() are
passed using struct blk_report_zones_args, introduced with commit
db9aed869f34 ("block: introduce disk_report_zone()").

This commit changed the DM main report zones callback handler function
dm_report_zones_cb() to call the new disk_report_zone() so that callback
functions from blkdev_report_zones() are executed, and this change
resulted in the DM internal dm_zone_need_reset_cb() callback function to
not be executed anymore, turning any REQ_OP_ZONE_RESET_ALL request into
a no-op.

Fix this by calling in dm_report_zones_cb() the DM internal cb function
specified in struct dm_report_zones_args.

Fixes: db9aed869f34 ("block: introduce disk_report_zone()").
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/md/dm-zone.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 984fb621b0e9..5a840c4ae316 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -113,6 +113,15 @@ static int dm_report_zones_cb(struct blk_zone *zone, unsigned int idx,
 
 	args->next_sector = zone->start + zone->len;
 
+	/* If we have an internal callback, call it first. */
+	if (args->cb) {
+		int ret;
+
+		ret = args->cb(zone, args->zone_idx, args->data);
+		if (ret)
+			return ret;
+	}
+
 	return disk_report_zone(args->disk, zone, args->zone_idx++,
 				args->rep_args);
 }
-- 
2.51.1

