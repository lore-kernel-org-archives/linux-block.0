Received: from mta0.migadu.com (out-57.mta0.migadu.com [91.218.175.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AE456DE0
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979901; cv=none; b=QbnKgnBIbKSR+ePmgm3toFA7SlV5cvDGJqFfE95A5KjBXAURitc0sFaliuVo6n1Mqoofmewm8dHkhGFmPKkAKCn7blEC2uS4Aiidi1scqOYo291AXg5it1zYsnhYFBI6f0C7+jF48081A4GVihcmvo4mSVpXmpn6WeSGDxBZOCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979901; c=relaxed/simple;
	bh=NHMCDWteuexNV3uSWdsxCXrqYhHELeMCl+JXW4IoR8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3eyjCvNxFmI5/f+UJgLtv3fEnTjpZaxJzwAm3mdagLCySZr99EksPKEPRFUdgp3UmmSsVTdCvm7vfSQsIM+CpjyM7vtUAq9SgAYodaMpHCa7fsFJioBufhflb4VB/MqfXimyA96QleobfHyAjspiyS86p1W9bhvAemKBs4hrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QOEPF9I2; arc=none smtp.client-ip=91.218.175.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QOEPF9I2"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=NHMCDWteuexNV3uSWdsxCXrqYhHELeMCl+JXW4IoR8I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789979897; v=1; x=1790584697;
 b=QOEPF9I2LI1TrBdOlk28v8xDTpgTSAydGMg24017vRCcePMlECQu/uhRwNKSwIam0LfNUaqR
 ozcQ8aASaRAlXH7mRN3+j0cNEa4/SqhvMRAUUy6Qnt6XwmBIvX7UQQ67OcY7he1Kql+hKzmuTTh
 0VUjN1XgRi7FpyQ9zH7tnS4U=
X-Envelope-To: linux-block@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 92277e0fc02bb1cd;
	Mon, 21 Sep 2026 08:38:16 +0000
X-Mizu-Trace-ID: 92277e0fc02bb1cd
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v4 2/4] block: don't show partition diskstats for GENHD_FL_HIDDEN
Date: Mon, 21 Sep 2026 09:37:50 +0100
Message-ID: <20260921083752.1154316-3-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921083752.1154316-1-john.garry@linux.dev>
References: <20260921083752.1154316-1-john.garry@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When flag GENHD_FL_HIDDEN is set for a disk, normally the partition table
is not available and so we won't get its partitions showing in diskstats.

However, now hidden disks may partition tables.

The diskstats for partitions on disks with GENHD_FL_HIDDEN can bloat
the output and is not too interesting, so always hide it.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 block/genhd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 10ca8b4d6eea..60dc7a61ea8a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1376,7 +1376,8 @@ static int diskstats_show(struct seq_file *seqf, void *v)
 
 	rcu_read_lock();
 	xa_for_each(&gp->part_tbl, idx, hd) {
-		if (bdev_is_partition(hd) && !bdev_nr_sectors(hd))
+		if (bdev_is_partition(hd) &&
+		    (!bdev_nr_sectors(hd) || (gp->flags & GENHD_FL_HIDDEN)))
 			continue;
 
 		inflight = bdev_count_inflight(hd);
-- 
2.43.0

