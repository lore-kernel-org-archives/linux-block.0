Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77C43B774F
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788147701; cv=none; b=TTS1uIgeG+9Fq8x7+Yv1gE55uxDD4QPcbbdICsUQdlf88z49qo4bcwyuaKDu0tqLD+eRRPIOCblfzZVtTo9ZSHESSTA6W2yu7n1IrYTr5k5ByT6z/mtS6BIgFQIml/sb3OhoQRG7HgLzjQ8JeMYZHtvS5ePY1X/dPtSL91Omt9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788147701; c=relaxed/simple;
	bh=P6cy7Yc8/oohVLZ2pjHLSOdnU4YVoEPMV3p3/k+s964=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CHu5x7TR98lLNU0au3ok2IUeVKW9niTVMN0hU23yEAlBdOiKOL8TomZ3Eku94fVkri/wrzoXxWOWiigyGx96OK/EAL40AFO70rg6pXX5RRkSohRKv+hjwVNRFOMRgUcJtbz/w9yGbRTjR/Gn3CCo9q4B00HI3yJHvTdcMlwBVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1Z7RUdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1Z7RUdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F291F000E9;
	Mon, 31 Aug 2026 03:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788147681;
	bh=tv6aqAVtMY5a53JrH5wy//DFbbHS6GSOArpFwsjyNqY=;
	h=From:To:Cc:Subject:Date;
	b=H1Z7RUdc9Awb/N6FiRhxP2H2Na8xZu5+pYooIhXB4nPwte8o5QycBaT06lb2FNR8T
	 AHxAQlI6qHVdDEjYPQtgRxBIL2YlXprCO11YtPtJd8ZmbvIGrUXJ4na40q+as2MB8u
	 GCioafThQN/WSO2WBk1FtxHOv3l/urFtyG8dqfz4yEW0X0tf7Y2SL+vuGqXQPKNjb/
	 d7yenvSUEA3nyQ+2fkVmbvSoQBymw1woq43CJn7bmxX7zffULT1CZSe0TqoRR/nahq
	 xb952Iuray+g3SL4Ap2k3UH/alwlj26tZppHK96pou4xo1Zm7FPWsxhmIxGNTBJobb
	 PUAj88wh6ZQUQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 00/12] Improve handling of offline and read-only zones
Date: Mon, 31 Aug 2026 12:40:57 +0900
Message-ID: <20260831034109.744039-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

This patch series refactor some zone related code and improves the
caching iof zone information and the management of zone write plugs in
preparation for fully supporting storage element depopulation.
Most of the functional changes here are around the management of zone
write plugs to better handle read-only and offline zones as these
conditions can become more common with storage element being depopulated.

Changes from v5:
 - Rebased on 7.3-rc1
 - Removed patch 13 as it was sent separately as a fix patch

Changes from v4:
 - Renamed bdev_check_zone_mgmt() to bdev_zone_mgmt_allowed() in patch 10
 - Added Fixes tag to patch 13
 - Added review tags

Changes from v3:
 - Rebased on latest block/for-next
 - Small modification to patch 4 to address Sashiko review comments
   complaining about the potential for out of bound accesses to the zone
   state array.
 - Added review tags

Changes from v2:
 - Minor changes to patches 1, 5, 7 and 8 to address some of the Sashiko
   review comments (a lot of these comments point to cases that cannot
   happen in practice or that are non-fatal and would generate errors due
   to a user invalid use of the device).
 - Applied review tags

Changes from v1:
 - Fixup error path change in patch 1
 - Use WARN_ON_ONCE in patch 4
 - Dropped patch 14
 - Applied review tags

Damien Le Moal (12):
  block: remove disk_free_zone_resources()
  block: refactor disk_revalidate_zone_resources()
  block: refactor disk_update_zone_resources()
  block: remember a zone type regardless of its condition
  block: refactor bdev_zone_is_seq()
  block: introduce disk_for_all_zone_wplugs()
  block: drop all zone write plugs on capacity changes
  block: propagate readonly and offline conditions to zone write plugs
  block: always treat offline and read-only zones as dead
  block: fail zone management operations to read-only and offline zones
  block: allow read-only and offline conventional zones
  block: simplify disk_zone_set_cond()

 block/blk-core.c       |   7 +-
 block/blk-zoned.c      | 788 +++++++++++++++++++++++++----------------
 block/blk.h            |   6 +
 include/linux/blkdev.h |   2 +-
 4 files changed, 489 insertions(+), 314 deletions(-)


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0

