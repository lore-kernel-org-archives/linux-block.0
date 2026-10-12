Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B535C2E8DEA
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814558; cv=none; b=TsvDo9HeKizTLrpFERpAN8anSeZN+VH/hZMJsy4QqXbuooVqGCMgpvxuFODlUjFRod5vDIpxH7h7zN8ywnoxQuj4IxVMzAg5mi98JtTKXMyipCbL6oqMaGjZt8aRVDRHHMSaoBWY+9t22iIPHisips6BoKVWrNA4H040/SPCXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814558; c=relaxed/simple;
	bh=KNPHM08XBUMmpjECqyvnNVWHVLagsxbfRsADgvksY2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTVsSAo4WNDd84/VL2+9nAFac3wLvIddiMrebQjyswpMoJ4ut07Ijsy93nmcNI/umwZi4MD05GasCOVZR2e1bveuKtLJJHQYn3PR/7Epm8dqszjusmfv7eRXts0cmEiQ23j9Oz/aLLv09vw+F1AqfRX7M3IeawTuAERMH9d6bIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gojoXDSL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gojoXDSL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=W06pHCVplIpL7TJP9Oggjp6aGSOXxyPQlLU025IqIcw=; b=gojoXDSL5ENwkuAt+WuiHy1j9a
	1JamFCdUx+RS+LB4x4hLvMNPeGefjnCFEKMYs1RCK2HzDxRUcVc9DHhsZnnwCBHR2wgIQv0qGhwoL
	ubj250EJ58zB3/IPRlKbVcHIh72SbsU68Xtv0whGs9saOZRaLyb4CDWj+IkpGLnJzSGvzMwLaQssU
	Q1s84fKheyLO6aZ+zosh8o3XG/m48h5+EL/K1AzsIr2YisGpiL/8rtPDlTFnCSzWHpHunB+X4fjB4
	31MhyJZXSRH57xUbRCw+Firk9f5mOxZ+Sqveb68QYJMfPIkBRgCWTFAxuuRyQe0vedf7Rb1VXXFM7
	dZi4npAw==;
Received: from 2a02-8389-2301-9f00-e8f6-a58b-9f49-a02b.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:e8f6:a58b:9f49:a02b] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGok-0000000AfPv-16Kc;
	Mon, 12 Oct 2026 14:15:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk,
	dlemoal@kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH v2] zloop: explicitly mention zone condition when a write fails to it
Date: Mon, 12 Oct 2026 16:15:34 +0200
Message-ID: <20261012141551.1336261-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Don't print the impossibly large write pointer, but directly mention
the zone condition when a write to a zone in a condition that does
not allow writes is received.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - print the zone condition

 drivers/block/zloop.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 394dc2408ed7..8f485ef51557 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -603,8 +603,13 @@ static int zloop_seq_write_prep(struct zloop_cmd *cmd)
 		}
 	} else {
 		if (cmd->sector != zone->wp) {
-			pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
-			       zone_no, cmd->sector, zone->wp);
+			if (zone->wp == ULLONG_MAX)
+				pr_err("Zone %u: write to %s zone: sect %llu\n",
+				       zone_no, blk_zone_cond_str(zone->cond),
+				       cmd->sector);
+			else
+				pr_err("Zone %u: unaligned write: sect %llu, wp %llu\n",
+				       zone_no, cmd->sector, zone->wp);
 			ret = -EIO;
 			goto out_unlock;
 		}
-- 
2.53.0

