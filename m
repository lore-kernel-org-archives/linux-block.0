Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2516544C50B;
	Tue, 15 Sep 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502473; cv=none; b=HkCWBuTEs6mnkCcRkvZ4mrPuoP7NJmdr5I4n6+6wkLCEp0JZrSrTq7dVlt37EraiO+iYBZsDWPeeruFy5U1yGXfxGYfq0uwPXD2zzWl0j6Nqt5sT+3bAIY6Ux2cE7pSu/4pCjdiRA0bDdIP4coiLcdg2+nqjFF+Bl2n96oGqseY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502473; c=relaxed/simple;
	bh=5BXj3GYAp+K0PEWPKETO0y+KRxP+PxfG6Uos6q6Hx2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kz8sPpsKFI0NPzq5jeBrSm2Wz/1HoNwstMJQ5x2x007ii4GRFuE29czosrhGc0lMsI/IPSWwj5igwGgkUjpYAHWcDKvL7Y4minpdSXBN025KpK64fXDKA0QPs6ZgCOk7Xu9XrqZvbs4A9aDCiz0iaLrWdGd7wAwbaXip9egmjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IG5+8vNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IG5+8vNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E68BD1F000FF;
	Tue, 15 Sep 2026 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789502471;
	bh=92nr8IGaQH5EjHNWCGT9F67ybnm5tD52y6P8CzHrxf4=;
	h=From:To:Cc:Subject:Date;
	b=IG5+8vNdUIUVZTp/0K6hwT1phJUCkIKpdU+PJguUwgpD2C35hLKBmdqA6jKx2e7ji
	 Jpbie10mWoQ5u4s7aAUZdA41yew/dLcbvKRkiqXBWrvptltkZ1yBeDUACsCap2VEz3
	 wJyVmvDTtuw8kZyswcikFz1zwttOohsd7GAyLIwF/v0S1qm/FfuVJyg3TzwpBk6cbi
	 gPFnIRwXHJlND3A4L0p7+0UxllaUVBL6V2+ij1Mj46hXgJQcO4AgWwxs2Deq4pGset
	 3N34WpWvpRuev/qgMm0YStZoJDF5QXJdZNLO2GWXDFS6FutNhaYMWbJJ+FTvwiVpHh
	 M7GVE4A9a0v3Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: reduce stack usage in __ublk_shmem_remove_ranges
Date: Tue, 15 Sep 2026 22:00:56 +0200
Message-ID: <20260915200107.3522560-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The array in __ublk_shmem_remove_ranges() is one kilobyte long,
which is really too much for an on-stack allocation, as can be
seen with a frame warning limit of 1.25kb that otherwise produces
a clean build on my test system:

drivers/block/ublk_drv.c: In function '__ublk_shmem_remove_ranges':
drivers/block/ublk_drv.c:5573:1: error: the frame size of 1392 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]

Maybe half the size is good enough here, so try 32 entries.
If 64 entries are really required, the array could be dynamically
allocated, but that would risk an allocation failure.

Fixes: 309e02dccf64 ("ublk: avoid unpinning pages under maple tree spinlock")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have really no idea if the 64 number was significant or just chosen
to fit within usual stack frames.
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..6fe85aba32ce 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5531,7 +5531,7 @@ static void ublk_unpin_range_pages(unsigned long base_pfn,
  *
  * Returns true if the tree walk completed, false if more ranges remain.
  */
-#define UBLK_REMOVE_BATCH	64
+#define UBLK_REMOVE_BATCH	32
 
 struct ublk_unpin_range {
 	unsigned long base_pfn;
-- 
2.53.0

