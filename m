Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B82AF00
	for <linux-block@vger.kernel.org>; Sun,  7 Jun 2026 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780802326; cv=none; b=U/oDAEUgQS0iBAsZp5UfQcKBYc46PKb/d6ZnfQL2pkfEg06snuhNX3B4PaWbZFJ75JiqeRd8YkBC8t3PKbLx5jZPrd1hin6GFlCNP8BfArAWE9Q59LpkUzYc+hsJ3URihFPsS8D+Medfr1BhOiI+DHHQ+O7Ybh7G2wwLpCsvOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780802326; c=relaxed/simple;
	bh=IFbixWRGKE0u20wYOO7XRqct+hAF0Y/DLAGYzpRtVvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u1S5PJ5z0RBYUDmJ668+0YodGUOzk8COfF7xtw88eaqcHUyKYXOsLoiJ8eZ609KBF1jLdpQsdrhVs1wVEtv86aBC/lQ8e3jdBoANDW2BIxmSBwWD13Kj7Y9rPWqFh6LYg3s/VsatzeJwfWrBhaYnF49iHCJ9p0najvalqDVKHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eJyXtC+n; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eJyXtC+n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780802323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9l82/285Sk7i3oH+rwvv+WNTxk6AEQ5ADXUjqM/hCDM=;
	b=eJyXtC+nwdnVDiystBfDJKUYpg535J+SIuaHkb9JUK+Kb3DQCpB2Lh+PZElUgF4dsoN8OL
	yj274i8tWEDnpHvN/EJCS9c4lUv0ct+2r9n1rdO6F9mBkuyu5e0An8DjqWqlh2NyyJWulC
	I81592vMIe9Bo4mzi1WNp7HVt3AoXj0=
From: Jackie Liu <liu.yun@linux.dev>
To: dlemoal@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: clear zone write plugging flag before failing rejected BIOs
Date: Sun,  7 Jun 2026 11:18:14 +0800
Message-ID: <20260607031814.19188-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

Commit fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write plug
error recovery") changed blk_zone_wplug_handle_write() to fail BIOs
directly when blk_zone_wplug_prepare_bio() rejects them, for example
because the write is not aligned to the cached write pointer or the plug
needs a write pointer update. However, the BIO is already marked with
BIO_ZONE_WRITE_PLUGGING at that point even though it is not issued.

Completing such a BIO with bio_io_error() makes bio_endio() call
blk_zone_write_plug_bio_endio(), which treats the completion as a failed
device write and may poison the cached zone write pointer state by setting
BLK_ZONE_WPLUG_NEED_WP_UPDATE.

Clear BIO_ZONE_WRITE_PLUGGING and drop the zone write plug reference before
failing the rejected BIO.

Fixes: fe0418eb9bd6 ("block: Prevent potential deadlocks in zone write plug error recovery")
Cc: stable@vger.kernel.org # 6.13+
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/blk-zoned.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 6a221c180889..855767d8bfc1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1502,7 +1502,9 @@ static bool blk_zone_wplug_handle_write(struct bio *bio, unsigned int nr_segs)
 		goto queue_bio;
 
 	if (!blk_zone_wplug_prepare_bio(zwplug, bio)) {
+		bio_clear_flag(bio, BIO_ZONE_WRITE_PLUGGING);
 		spin_unlock_irqrestore(&zwplug->lock, flags);
+		disk_put_zone_wplug(zwplug);
 		bio_io_error(bio);
 		return true;
 	}
-- 
2.54.0

