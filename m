Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7669D38D3FE;
	Tue, 29 Sep 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665237; cv=none; b=fbfEqy3QVZrTNviXxldqBBJuaJc7mNH5RvlPq1VcGbM7yt+Ux6PLtDE139whZIU71hcDm5PkK18rGN9m4wtddwJHZMQdpcB+N1dlXPoiZmDmIY0PiZr5EWdjb1yXHowXmuy+0HYpTyNnNVfQey+iAMbshatqntBvZ2/d2HSXHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665237; c=relaxed/simple;
	bh=he2Jhog2fO6QthrLvj+Qgd+uJiyktRleTSC9oYPV/tE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D17LcHEx/UpcWy/sEY12+YaGR3yogjSpou6+kLHmjUGNvSy9SKFBQdDgmEiZWXqsCjPMONFPeItBVlORs26OHkQcDkGe3UD9MaiQWvQ+qb7dikF68JfNF4kNZWjTTQqszKMf+1EL76oBk2v9Ul9qHDQ5MAL1W/aBiSmmMe0W9+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=dCiHeIrI; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="dCiHeIrI"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Ming Lei <tom.leiming@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andreas
 Hindborg <a.hindborg@kernel.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] ublk: use global index for reported zones
Date: Tue, 29 Sep 2026 15:00:12 +0800
Message-ID: <20260929070012.2325-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790665220;
	bh=D2EK+Epbkq5EfN506jVqMJ4gve+oBKhx2WfKjHKTbdM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=dCiHeIrI7MVFNfXuDz3hCfxGWLPOebZJzyuYi63OBcqow6JGhKNG4XnA2U4w6SN3g
	 YtAHmisoseKBXxHQexGbW7mq5DQwEuqsC9yt9F6EStdBujaKWXAWaR2XtafxZSRlPQ
	 WKLcQRSIiB+R1pTze2neLU2AANYwNPR0e3SbgRRn733ug+nCniCeyV0jvCMvhFQoRI
	 kak0V7I5HBdozmOzletUnShx6anFmaqlqXOgEZui8I2JHrh5/x0Xk0qyPGfIEIIm2g
	 eAbi8aqewpOh1HK/TcxaFxCedNnY25+a592yF2BR4gZQ3WnTn3W7Lrro7k2XGWmGv+
	 oUiDW/yQHB2/A==

From: Li RongQing <lirongqing@baidu.com>

ublk_report_zones() may split a zone report into multiple requests when
the number of zones exceeds the temporary buffer capacity. The index
passed to disk_report_zone() must refer to the zone position in the
whole report, rather than the position within the current request.

Currently, the per-request loop index is used as the callback index,
causing each chunk after the first one to restart from zero. This can
make userspace callbacks receive duplicate zone indices and may result
in blk_revalidate_disk_zones() updating incorrect entries in its zone
state array.

Use the number of zones already reported as the base index for each
request so that zone indices remain continuous across all chunks.

Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e..007e703 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -649,6 +649,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int remaining_zones = nr_zones - done_zones;
 		unsigned int zones_in_request =
 			min_t(unsigned int, remaining_zones, max_zones_per_request);
+		unsigned int batch_start = done_zones;
 		struct request *req;
 		struct ublk_zoned_report_desc desc;
 		blk_status_t status;
@@ -687,7 +688,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			if (!zone->len)
 				break;
 
-			ret = disk_report_zone(disk, zone, i, args);
+			ret = disk_report_zone(disk, zone, batch_start + i, args);
 			if (ret)
 				goto out;
 
-- 
2.9.4

