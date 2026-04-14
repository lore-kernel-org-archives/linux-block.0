Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB95D1B4F1F
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154698; cv=none; b=KDN0h7RTKkRN2emoqtspPQPdVfU8U2j5SDGdCF8gYr22/cg/scv6gsnKQ2zTxKocl3w7kxJ/p07pAR7P/26jKsbEsqNQ+TZ+pEJHfPNEou63DqDMm34ouF+WYWAPi3bqcEnzTioJh36mr6EFdear97EerMqiE0aSeKeaG2MshPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154698; c=relaxed/simple;
	bh=zkjsgkhOxi5OmbbV3KMHq3VuwPY2iPhYOpzL/DZEXLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5wDhzkUfX3xp0gLjXz6cp8KQACX8DhmDNYm4WTMLuyP9Evrn8YTykIc1hkb3Nr4R7goq7FxPlXUgRmGM6jzc7JcLVppOmFXYDpYrROiFi7pXqCjzO0QnSW2E/AkGmZ95xWDitVFEHJLa7aQOPTPJESyK4/EB1cgwcnZ/J3XfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dXBRSpYQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dXBRSpYQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=x5WeJ/sfJtUmGIjWjV6WgS5MMtWvCgDze7Cl30PFm/8=; b=dXBRSpYQpvJ+pzwPNnFzY9lNya
	vFdCVrlqsFxkmh1fnwSQONyFgmYgmsR/a7EQ61h1OlLLSPduydYkkU4klcXWT1vqNXWxsJ1HFbRU8
	7D4wvEsTUCuM0jGb0MtjWCknoxY+lrS38I0CBhqEGr7eZ8v0/1nXj2lDypeSo3jTfnkJ26jS+cKiR
	K9zTIbsToDl7Fo3zoRIqB6DwOWVX10alMOemD9/rBCH3Iyyz9YDYBLCnQmpwQjfKQo7fPVkCKJHGj
	Of2gFNE4SY8ug5vILh2VdRaCwHB+3gnW0emVcI48gyWexFD8Z4iq1Z/lHtSBpqXx9eeM5TN3Nuq6U
	D+0k8ZFA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYyO-0000000Gxie-3mWY;
	Tue, 14 Apr 2026 08:18:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/6] zloop: fix write pointer calculation in zloop_forget_cache
Date: Tue, 14 Apr 2026 10:17:46 +0200
Message-ID: <20260414081811.549755-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414081811.549755-1-hch@lst.de>
References: <20260414081811.549755-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The write pointer is absolute and in sector units, so we need to
convert it to a relative byte address first.

Fixes: c505448748f7 ("zloop: forget write cache on force removal")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 8baf642037fd..672948d3653e 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1401,8 +1401,17 @@ static void zloop_forget_cache(struct zloop_device *zlo)
 				zlo->disk->part0, ret);
 			continue;
 		}
-		if (old_wp < zone->wp)
-			zloop_truncate(file, old_wp);
+
+		if (old_wp > zone->wp)
+			continue;
+		/*
+		 * This should not happen, if we recored a full zone, it can't
+		 * be active.
+		 */
+		if (WARN_ON_ONCE(old_wp == ULLONG_MAX))
+			continue;
+
+		zloop_truncate(file, (old_wp - zone->start) << SECTOR_SHIFT);
 	}
 }
 
-- 
2.53.0

