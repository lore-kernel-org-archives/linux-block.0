Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BB125744B;
	Thu,  3 Apr 2025 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707224; cv=none; b=PCSoydxUBJNpq4spIsAmb0d8+Nk+Vt3x6Ab/Z+ij+BhNXM2LvAk3TkELtUlufXxdTUABGYYf/iZiXQF6ZRcYtKi9DuiSmDgmlcTuxkRNc6OKFtiWyGRoxdZ+KQBruXgOrehC8gsKMTy8WA5TlpnpLWuUdtmrdxnLwxo84iMk/hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707224; c=relaxed/simple;
	bh=PQmuVF7TVlVbaS0Np3Hi28Gvm+UX2ggkRgUN/zmBJSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MRy9ug5MSqVSonytsNvaBoRGYjjqL4RbAqnV25UxfgQRHH4skdlaer5R7883K90/GNOBA/C9nbX9E/x/uFnqKf1dznjfAXVSrPzuo5/GSXML1xuiUi7pTrmkY3QHweRnrSZ8mY4jtErVsj/JKwX6bnYnVPQIdBCaa95pBPiStPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDnPsXaS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDnPsXaS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5912C4CEE8;
	Thu,  3 Apr 2025 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707224;
	bh=PQmuVF7TVlVbaS0Np3Hi28Gvm+UX2ggkRgUN/zmBJSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDnPsXaSId3kWWzdB7hTFap3+M5KD/8AWDJXjH4Yxh0teXVKchS0vp3W/Ew9ISXcI
	 1e6fwt9g/8GW5dinIPhV+3vGogXHwLQvFPJpxUYwHJPiQ0uDxB+bN7bhlC9SyVcqLq
	 2DJyFBLsiJwKmrxKnA7jRX2fDDo1Rv0XAfTEuYJaqOdypBsPH5/alNswO8pU8osgDs
	 JAA6xbfTh0Gm/ca7ItN3y401SIRx2YmFTsAftGI172t0TOeSpTnEwkvNwpIMn8vnA5
	 u+iVmSuZCkJ47WCBXsVF0xvOvZgNTwZtEoeXMQpScvU8K48dUgwWa4LzMI+vkQKDlx
	 7qZXqKUBdv0lg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	yanjun.zhu@linux.dev,
	zhengqixing@huawei.com,
	yukuai3@huawei.com,
	martin.petersen@oracle.com,
	hare@suse.de,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 26/47] null_blk: replace null_process_cmd() call in null_zone_write()
Date: Thu,  3 Apr 2025 15:05:34 -0400
Message-Id: <20250403190555.2677001-26-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403190555.2677001-1-sashal@kernel.org>
References: <20250403190555.2677001-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.21
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 4f235000b1e88934d1e6117dc43ed814710ef4e2 ]

As a preparation to support partial data transfer due to badblocks,
replace the null_process_cmd() call in null_zone_write() with equivalent
calls to null_handle_badblocks() and null_handle_memory_backed(). This
commit does not change behavior. It will enable null_handle_badblocks()
to return the size of partial data transfer in the following commit,
allowing null_zone_write() to move write pointers appropriately.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20250226100613.1622564-4-shinichiro.kawasaki@wdc.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c     | 11 ++++-------
 drivers/block/null_blk/null_blk.h |  5 +++++
 drivers/block/null_blk/zoned.c    | 15 ++++++++++++---
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c479348ce8ff6..69c71195a9265 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1287,9 +1287,8 @@ static inline blk_status_t null_handle_throttled(struct nullb_cmd *cmd)
 	return sts;
 }
 
-static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
-						 sector_t sector,
-						 sector_t nr_sectors)
+blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
+				   sector_t nr_sectors)
 {
 	struct badblocks *bb = &cmd->nq->dev->badblocks;
 	sector_t first_bad;
@@ -1301,10 +1300,8 @@ static inline blk_status_t null_handle_badblocks(struct nullb_cmd *cmd,
 	return BLK_STS_OK;
 }
 
-static inline blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd,
-						     enum req_op op,
-						     sector_t sector,
-						     sector_t nr_sectors)
+blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
+				       sector_t sector, sector_t nr_sectors)
 {
 	struct nullb_device *dev = cmd->nq->dev;
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index a7bb32f73ec36..de464b5782e55 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -130,6 +130,11 @@ blk_status_t null_handle_discard(struct nullb_device *dev, sector_t sector,
 				 sector_t nr_sectors);
 blk_status_t null_process_cmd(struct nullb_cmd *cmd, enum req_op op,
 			      sector_t sector, unsigned int nr_sectors);
+blk_status_t null_handle_badblocks(struct nullb_cmd *cmd, sector_t sector,
+				   sector_t nr_sectors);
+blk_status_t null_handle_memory_backed(struct nullb_cmd *cmd, enum req_op op,
+				       sector_t sector, sector_t nr_sectors);
+
 
 #ifdef CONFIG_BLK_DEV_ZONED
 int null_init_zoned_dev(struct nullb_device *dev, struct queue_limits *lim);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 9bc768b2ca56b..09f972d9009cd 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -412,9 +412,18 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 		zone->cond = BLK_ZONE_COND_IMP_OPEN;
 	}
 
-	ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
-	if (ret != BLK_STS_OK)
-		goto unlock_zone;
+	if (dev->badblocks.shift != -1) {
+		ret = null_handle_badblocks(cmd, sector, nr_sectors);
+		if (ret != BLK_STS_OK)
+			goto unlock_zone;
+	}
+
+	if (dev->memory_backed) {
+		ret = null_handle_memory_backed(cmd, REQ_OP_WRITE, sector,
+						nr_sectors);
+		if (ret != BLK_STS_OK)
+			goto unlock_zone;
+	}
 
 	zone->wp += nr_sectors;
 	if (zone->wp == zone->start + zone->capacity) {
-- 
2.39.5

