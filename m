Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286251;
	b=PQ7s9OWQXpuC1Ejt7BjhKGayoGoNJF3m6yZsR1/Sk8xYsQk5jRcjTcxMEokebCCrx1hv
	 5x89Mb51woPHlSJ2Ftey2kUB6FxBeObeu+SOiKFV4UkKEMKISlZHqBwYKxYmhazOfbd7Z
	 0jKM2qC1nEdTUkCtc0wlylreaFu/Sao7AaYUUSgtF+HZ/Cx4p2USISRCXFNXlwRkO0IhF
	 XpOPBdms5hE0IawZm96V5ZhtOE2VsN8FNqtDxVczOEZxD/dxOdVjaprdcfDMKy9/Iy5R2
	 4IdFth1rxFb5uKGEQXvrgZsho+x9dRfHosOZE5MHEbet/9oMjMvSrUKgib7WrZbgwjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286251;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-SRS-Rewrite;
	bh=9SEfOhMvodAbVPym7tQway2vHe0sFisWgMP/A91Zwz0=;
	b=vCXn7rB/uUhyCIDm2FqNsKNuJ0OA5aAYOgUSwvx+V60ojUUdF7ll/ub97zluNYj275fh
	 Eux0otkGzMRL1x60xK1qeZ8UICjk1y7VtCPVqFokta2g4KAAcEpo0N6ThYWNUDgDrUgLB
	 l9wxYH208w4MUZNhxRdlGCmTdFw22u9jm6csmGXAL1G76+TIxkESHyOhED3IkMXJPW6EH
	 qj/A/3LjM0XcSEXCdfPfKIeljFwo4iwFXBe7/jSS4xXT9uk479GAWoXT4ZyWnAlQMnA43
	 1uHb3S6upBjyPrjSFDs3/hw2BXOnhGR7cJgM21I8saWxvERnF00ythL1CYmDSg6VUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=lst.de;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gP4UYhnx;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA07606A31C
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EA07606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gP4UYhnx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9SEfOhMvodAbVPym7tQway2vHe0sFisWgMP/A91Zwz0=; b=gP4UYhnxEcMfWtTjHmYSAxlaqx
	Z8x6+FqtAo0qmtRoghQ/PnYEThHLuMSfpit8crYXQbvAFDPDy9XZXcmHOnJbEwil8XXNPCJMDIzHs
	j9nvH+FqlP74Q3wtox37dQAjiT1vw3IR9OoTdxWDBvXp8h0C4lszbwz3tv0vn0fc9IYzZhaUD/etP
	7kEiAodlBDCRJCwLDAcw1frNbX1g6g3RebTA92ywmGApv1nDm3gSO5JMak8UdrJWs0mslYuMGZxbi
	ShOKHIp9wTIRdgUm3RS3ITV45whkYCtUSdbFQ4ytvvltUOkeogIcCW4bfgFM7OjN44p0j2QKfmBrB
	yIIU5AKQ==;
Received: from 2a02-8389-2301-9f00-31e8-efb6-e973-61ca.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:31e8:efb6:e973:61ca] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMRfl-00000009btj-2jrs;
	Thu, 29 Oct 2026 15:04:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Josef Bacik <josef@toxicpanda.com>,
	linux-block@vger.kernel.org
Subject: [PATCH 4/4] zloop: check that the zone backing file support ->{read,write}_iter
Date: Thu, 29 Oct 2026 16:03:35 +0100
Message-ID: <20261029150353.2503201-5-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029150353.2503201-1-hch@lst.de>
References: <20261029150353.2503201-1-hch@lst.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I/O to backing files requires support for iter based read/write, so check
for that upfront instead of dereferencing a NULL pointer later.

Fixes: eb0570c7df23 ("block: new zoned loop block device driver")
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/zloop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index f0aca9d43851..65634a39b0bf 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1132,6 +1132,11 @@ static int zloop_init_zone(struct zloop_device *zlo, struct zloop_options *opts,
 		return PTR_ERR(zone->file);
 	}
 
+	if (!zone->file->f_op->read_iter || !zone->file->f_op->write_iter) {
+		ret = -EINVAL;
+		goto out_fput;
+	}
+
 	if (zlo->block_size) {
 		ret = zloop_get_block_size(zlo, zone);
 		if (ret)
-- 
2.53.0

