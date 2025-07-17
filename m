Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD2F189513
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719579; cv=none; b=SxplZvM1Tjav0CFlSMRfIcTtypEIdtwV7hngaLW+p/4fFyFvJ+TgV/jaLWEdiV/nc9fPSrJqL11YPm1D2T9LDuIy7gdOv7GaMBsjB5H6on/Y6U7HxSXaNLvuwTd80vMCg+F9YtzFyFTZdMN3efaqWt1d2kfo8svw+TPvHN5fLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719579; c=relaxed/simple;
	bh=UF/u13h4hxPxP58t3GXA14Lp9KMsTs7NAjm+nMLSmsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLVq/Zt3S7NcK+PIYHsToPy3lOPK1i9BaOvora9YuRW0+w8+MSVGWoIWQljgVhZu/Y8th9JCw1EWsV491BuA5HgfXrcHjmvzGMk0apjCbzuWF+cNKa1flMmHsUOEwuo1dUH6hK1O1DZ1aNCfs03Pz/cVrQ2Rk+lb+a/pR6Yxw0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PauJRyD4; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PauJRyD4"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752719577; x=1784255577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UF/u13h4hxPxP58t3GXA14Lp9KMsTs7NAjm+nMLSmsM=;
  b=PauJRyD4tugoEKGaqf9XrIJy5auFCDpqk2E2n7RQiXc6ljbceC6usVgW
   pGRxcpCQySKU0KFn5Y+ALscuBiaNObX/d+l30FHqa/w5HYKEQMrtaXk8T
   +lRSGC8eBWC5Bo2KX+W1seOmgYylZxyF0dsqbgYzDVlHz/ROJOgefUF+x
   JqEPnsslwPBOrRrZ0AoTWYUbTllDi8ZalidIDeCOQyIFQXxTpfGm25auN
   GlckmjDak+emZZZNL9HOsd+h09161aervuYAEBeXJJna0aYMC1jcT7gw7
   mUEMj992+E0UovePMqnILoH18Pxst14WfiqtaP18vyx236crvlRehibRX
   A==;
X-CSE-ConnectionGUID: C0wicDeyTe6/nJwYurk/UQ==
X-CSE-MsgGUID: gmkDjLaTTqSzJTGZ1rGwIg==
X-IronPort-AV: E=Sophos;i="6.16,317,1744041600"; 
   d="scan'208";a="89339885"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2025 10:32:57 +0800
IronPort-SDR: 68785236_BNtpWNW1ggRi0b88gysVA5akgMTPdACcHye1Fk9qD4hXTzN
 j7g+TnVqKlfd9+ilPXXt43xvaH4p3AckXaygKGg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2025 18:30:31 -0700
WDCIronportException: Internal
Received: from wdap-jiufci53qv.ad.shared (HELO shinmob.flets-east.jp) ([10.224.173.117])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jul 2025 19:32:56 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next] dm: split write BIOs on zone boundaries when zone append is not emulated
Date: Thu, 17 Jul 2025 11:32:55 +0900
Message-ID: <20250717023255.15111-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f70291411ba2 ("block: Introduce
bio_needs_zone_write_plugging()"), blk_mq_submit_bio() no longer splits
write BIOs to comply with the requirements of zoned block devices. This
change applies to write BIOs issued by zoned DM targets. Following this
modification, it is expected that DM targets themselves split write BIOs
for zoned block devices.

Commit 2df7168717b7 ("dm: Always split write BIOs to zoned device
limits") updates the device-mapper driver to perform splits for the
write BIOs. However, it did not address the cases where DM targets do
not emulate zone append, such as in the cases of dm-linear or dm-flakey.
For these targets, when the write BIOs span across zone boundaries, they
trigger WARN_ON_ONCE(bio_straddles_zones(bio)) in
blk_zone_wplug_handle_write(). This results in I/O errors. The errors
are reproduced by running blktests test case zbd/004 using zoned
dm-linear or dm-flakey devices.

To avoid the I/O errors, handle the write BIOs regardless whether DM
targets emulate zone append or not, so that all write BIOs are split at
zone boundaries. For that purpose, drop the check for zone append
emulation in dm_zone_bio_needs_split(). Its argument 'md' is no longer
used then drop it also.

Fixes: 2df7168717b7 ("dm: Always split write BIOs to zoned device limits")
Cc: stable@vger.kernel.org
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/md/dm.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index ca889328fdfe..a64809f04241 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1785,8 +1785,7 @@ static void init_clone_info(struct clone_info *ci, struct dm_io *io,
 }
 
 #ifdef CONFIG_BLK_DEV_ZONED
-static inline bool dm_zone_bio_needs_split(struct mapped_device *md,
-					   struct bio *bio)
+static inline bool dm_zone_bio_needs_split(struct bio *bio)
 {
 	/*
 	 * Special case the zone operations that cannot or should not be split.
@@ -1802,13 +1801,10 @@ static inline bool dm_zone_bio_needs_split(struct mapped_device *md,
 	}
 
 	/*
-	 * Mapped devices that require zone append emulation will use the block
-	 * layer zone write plugging. In such case, we must split any large BIO
-	 * to the mapped device limits to avoid potential deadlocks with queue
-	 * freeze operations.
+	 * When mapped devices use the block layer zone write plugging, we must
+	 * split any large BIO to the mapped device limits to avoid potential
+	 * deadlocks with queue freeze operations.
 	 */
-	if (!dm_emulate_zone_append(md))
-		return false;
 	return bio_needs_zone_write_plugging(bio) || bio_straddles_zones(bio);
 }
 
@@ -1932,8 +1928,7 @@ static blk_status_t __send_zone_reset_all(struct clone_info *ci)
 }
 
 #else
-static inline bool dm_zone_bio_needs_split(struct mapped_device *md,
-					   struct bio *bio)
+static inline bool dm_zone_bio_needs_split(struct bio *bio)
 {
 	return false;
 }
@@ -1960,7 +1955,7 @@ static void dm_split_and_process_bio(struct mapped_device *md,
 
 	is_abnormal = is_abnormal_io(bio);
 	if (static_branch_unlikely(&zoned_enabled)) {
-		need_split = is_abnormal || dm_zone_bio_needs_split(md, bio);
+		need_split = is_abnormal || dm_zone_bio_needs_split(bio);
 	} else {
 		need_split = is_abnormal;
 	}
-- 
2.50.1

