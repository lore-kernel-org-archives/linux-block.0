Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EDF1D63D3
	for <linux-block@vger.kernel.org>; Wed, 16 Jul 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673002; cv=none; b=RgF9C9YSAKJtqzLM7Iwr4f2OIV7rLwFkHNK5pmG+qtgiVqq0Jf8Fxu38/OGdbFzTI/KYKNJ57kNN5C5Z7BjRg9EoFylSYW5dRY36IzXsal6YnIK/M/rUbXFIc4Z0ATxmg0WanLKd6b9CdHQMwk840EsG1fB/fjlKMh8wm0ip/Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673002; c=relaxed/simple;
	bh=Mp5cuLp2D+8y6VA0YTw4IxOI2YK2LuOHvr6LOpDRQtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pf3yB/vlzF1h2PGfmznsfnNFw4uW0aejLNIBbTj4RboaFudkbiBPSuJKDsvPO17OkqQ/Q1yjq8vaHs0Ydne2vanarskG2ujxlxi6E5HX/QwPqs8gaOM083wck85HnarYwju29emWRM7dbtUorWS54IJqXYGhi1WdonJPpJkXV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=IVFRUQEf; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IVFRUQEf"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752673001; x=1784209001;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Mp5cuLp2D+8y6VA0YTw4IxOI2YK2LuOHvr6LOpDRQtQ=;
  b=IVFRUQEfyEkPyEm6gFS57yjBRENrmIqnGHA/F8jncHv39nS146gmcOg6
   I4rp3X9OrB75r40BnACA1xyUzRYFm50LYqTeoYXg3QJk2jO8Kyi9TwnkG
   97B4zP7eK6z5k6UEmvZa/Og6Z1qriX5R0QlfQOo9sqFn3lsRYFicmMXPt
   4wBiqJ+ynTaYzA+PWSvb+Al2PNbUraPmKUk8w2ZCvmPQteTkjLoll24Fh
   aEbR0rVvWMZ/UQw406e+pUeSeNeAnKc7riO6MIOWevS88fG2ua+MGjDr1
   wSvsqNJvPKeBlFOhqdc/xFtNLk03+QniYdYTY3YaBAZ1gCTCtFDCVese6
   Q==;
X-CSE-ConnectionGUID: HWaqnZouRnKzVflMInUpIw==
X-CSE-MsgGUID: QdjVKiP5QP6e7/wS6gPjTw==
X-IronPort-AV: E=Sophos;i="6.16,316,1744041600"; 
   d="scan'208";a="88380644"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2025 21:36:40 +0800
IronPort-SDR: 68779c46_9F3x/hxIXx4KfoFFxXTokB4PsptMwMkHr26XPy9SOJgwNyP
 wd2/bBfEoZhSWiDEzQ++9koXuEjqBP4dhK4UQrQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2025 05:34:15 -0700
WDCIronportException: Internal
Received: from c02g55f6ml85.ad.shared (HELO C02G55F6ML85.wdc.com) ([10.224.183.46])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Jul 2025 06:36:39 -0700
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] block: fix blk_zone_append_update_request_bio() kernel-doc
Date: Wed, 16 Jul 2025 15:36:31 +0200
Message-Id: <20250716133631.94898-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Stephen reported new 'make htmldocs' warnings introduced by 4cc21a00762b
("block: add tracepoint for blk_zone_update_request_bio").

One is a wrong function name in the tracepoint's kernel-doc and one is a
wrong function parameter.

Fix these so 'make htmldocs' is warning free again for the block layer
tracepoints.

Fixes: 4cc21a00762b ("block: add tracepoint for blk_zone_update_request_bio")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/trace/events/block.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 3e582d5e3a57..6aa79e2d799c 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -405,8 +405,8 @@ DEFINE_EVENT(block_bio, block_getrq,
 );
 
 /**
- * block_zone_update_request_bio - update the bio sector after a zone append
- * @bio: the completed block IO operation
+ * blk_zone_append_update_request_bio - update bio sector after zone append
+ * @rq: the completed request that sets the bio sector
  *
  * Update the bio's bi_sector after a zone append command has been completed.
  */
-- 
2.50.0

