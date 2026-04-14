Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0A39281F
	for <linux-block@vger.kernel.org>; Tue, 14 Apr 2026 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776154707; cv=none; b=Lo4LfSLhSKZLWTPXEAKLx8jmBq3JIQ5WA/NQZUIam0IVHho54yddfX8iHBJ7XKMlZ083biIMQSZzVEz5U484qJQ4pcNwYPKkClXwMwEyw4RCTnQVaAgyOJ2GLrnT8x55C+AAy4Xr3SASKHsMaKlGfHPhCqSHD0SGUjIC+cnjW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776154707; c=relaxed/simple;
	bh=xfrgGbK8OdHuzI8EnqCAwhZhRdpLwhxqVoxPRngK7zE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5P07juCFUrO+nX9BN2hTE05dPWASXKaARTDX+LCcwpa5WtkDTUAknCObq3V4mxPkG5owkiQ7E9seAKVFT8gIazUB8Jn6GyEogC3YEpgE9oyPefWP+XYkUD50IQssAFMfP7zCiDQfBuceEznZOWAxOQln6UnOTVTmzpoXYzNjkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tcOtd+f7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tcOtd+f7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/nMUZP1wDLZ/ff49wBcDfvYs3/IDauG+qhGcXLC8Nzc=; b=tcOtd+f7Sel6YW6cJRpPSYDt0p
	ydtsytU/UYCQM1yC2uEQgDI3kd2qBUgj6U8MUe30DcPteEMeic+PWgtEXZaTkDHeYTss+Kv/6RWes
	v+W27qGEZx7AQ/WqZ1aMF4ntepNAjsdZQD/B6TIG7W9vzqsNtBo+idvakI2MzyRjuulYjrZ1gfPXU
	Z7ctJvQv6JV23Urqpiv4RTI+CMRS9jWCp84+aDBpNgVN/Ds6FEfEZy5RZW2nO1dmG8Axw3+NS/dYk
	a7EZ+Pkc/byH6lho0sgda9EQp8JvUCczv/OHT4ZBgr6Xaqyg8l/5XuGWa/xCVNeMm6rXTEjCGi0h5
	7hXHWrKg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCYyX-0000000GxjW-1TWA;
	Tue, 14 Apr 2026 08:18:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 4/6] zloop: set RQF_QUIET when completing requests on deleted devices
Date: Tue, 14 Apr 2026 10:17:49 +0200
Message-ID: <20260414081811.549755-5-hch@lst.de>
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

Reduce the dmesg spam for tests that involve device deletion.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index a738f8629062..7257188dd3a8 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -891,8 +891,10 @@ static blk_status_t zloop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct zloop_cmd *cmd = blk_mq_rq_to_pdu(rq);
 	struct zloop_device *zlo = rq->q->queuedata;
 
-	if (data_race(READ_ONCE(zlo->state)) == Zlo_deleting)
+	if (data_race(READ_ONCE(zlo->state)) == Zlo_deleting) {
+		rq->rq_flags |= RQF_QUIET;
 		return BLK_STS_IOERR;
+	}
 
 	/*
 	 * If we need to strongly order zone append operations, set the request
-- 
2.53.0

