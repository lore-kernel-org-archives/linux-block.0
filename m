Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DB63D64
	for <linux-block@vger.kernel.org>; Mon, 27 Jan 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737988251; cv=none; b=Hyuez+A/JU6eP3gr4/MaRyMhPVROo6MAUeuISDiYtD2yYRC0MicYx6rfxYwlBw553LkMS56q1AXgJwyQawTtccir5hGLWbKn7v4bD6qzjWJQnefSJG9/u2eGwolMiIom2GQPicvV3LDSn7e+8eBRguy+0SN2yQxUTt+SSB012K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737988251; c=relaxed/simple;
	bh=iGMGKMpV4xCIYWkwjOJo4bcAaA53d0FDTQkKF43z5L0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcF4z0N0H8dTySiSH6j60uc8StUC3Jdbujm/B1QTVdve25JFLVJG9LQvoyQdUAOLuTQhNVUVQVIyPvu/maeD4OcFWvsWuaSfkGlsydJhApUB0w8xTdvr2VLsWS6TBP5WIEAQnfVuTzlDrnTgOsDqiSWp7CIXELLyCX5pAk0L8Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FCQJKrvB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FCQJKrvB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=A5euc3rfHvuSF+HAr10HBoB3jMAXMCQD6VMxX1S4MIw=; b=FCQJKrvBklU1hieWHvFrqDyLMO
	0kpZbucJ5gmAiBB9alR3O8GkFxYQrPlO9B2WCGh9GdW8noX0FT9VpryVPoyleIqYtoDXIAgozi3m7
	xhDrZUfRNqq14/Qh/3u5y56xa1VyF9o08WLFzK72UUjKHJM4ERh1Finz4S0s5gWZoUIMn0b70eAWf
	jkRdOB9i4RkuK5uWzy0CZIlxaxE7Afht/LsdzaZOV9WIpJQSno0060vMnIToG22VrmDQtOXZU0m7o
	bx1nMdrFkkEgRuAY+xmbXWC0P2s0orZE0PB3wv4vHASOMKiIQoFU6QglwfCKbY1zjWijTmElrOkfB
	8N0lwNBw==;
Received: from 2a02-8389-2341-5b80-b8ca-be22-b5e2-4029.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b8ca:be22:b5e2:4029] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tcQ8W-00000002VX8-0MUV;
	Mon, 27 Jan 2025 14:30:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] loop: don't clear LO_FLAGS_PARTSCAN on LOOP_SET_STATUS{,64}
Date: Mon, 27 Jan 2025 15:30:44 +0100
Message-ID: <20250127143045.538279-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

LOOP_SET_STATUS{,64} can set a lot more flags than it is supposed to
clear (the LOOP_SET_STATUS_CLEARABLE_FLAGS vs
LOOP_SET_STATUS_SETTABLE_FLAGS defines should have been a hint..).

Fix this by only clearing the bits in LOOP_SET_STATUS_CLEARABLE_FLAGS.

Fixes: ae074d07a0e5 ("loop: move updating lo_flag s out of loop_set_status_from_info")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1ec7417c7f00..d1f1d6bef2e6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1281,8 +1281,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	partscan = !(lo->lo_flags & LO_FLAGS_PARTSCAN) &&
 		(info->lo_flags & LO_FLAGS_PARTSCAN);
 
-	lo->lo_flags &= ~(LOOP_SET_STATUS_SETTABLE_FLAGS |
-			  LOOP_SET_STATUS_CLEARABLE_FLAGS);
+	lo->lo_flags &= ~LOOP_SET_STATUS_CLEARABLE_FLAGS;
 	lo->lo_flags |= (info->lo_flags & LOOP_SET_STATUS_SETTABLE_FLAGS);
 
 	if (size_changed) {
-- 
2.45.2

