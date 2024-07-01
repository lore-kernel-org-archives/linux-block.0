Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE22BB0D
	for <linux-block@vger.kernel.org>; Mon,  1 Jul 2024 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719811093; cv=none; b=cRWAlPJMD7LYPkwqu/uw9PJ3BN6jGefuLi9Kck5TrVO1Ta9F3n42DDDa+ROyhbkodHyyVKntyphSXC+452T8tCx4gJhg4ouc3XH9Rjirfazb1J5p4tOwdp5n7yOPnnyX/slFHCjEblF6P/ioYgEwnYbJHyj2thTOFNspIc/Oldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719811093; c=relaxed/simple;
	bh=78oPaiT5fIP5Ap/kwsz966ZjEM9W/5vvGfAO9TqJ4ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrQHUwDqWDF++J5Hcg14v0ca77Luy3W30h8gEXXFHBFeW3bp+6WwTPDJzOcxBqBiNg5+22ClSjLejeUF2XMPM+6sIGWbiUQ/GdpT5siAGVjz4C+x4tW31ZnlT2m1oTJz+wOv15DG6k2pJ6J2Rsn8dsHok0Rm+XM7zzfkn5kPr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=twbmOjqA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="twbmOjqA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/CijqbYlkFh+sW64CWr9CSIh+vK9hGYl7zQAQz0uqRY=; b=twbmOjqA62RtPt6aus5e2NwulN
	8Q12ESllHNZl0cXAZcLpFuWJ7JjzI9gyDqlWY43GUiuPwPDD1ioPpsr9nqqtriWA43/Yn+SxOou/t
	8PQ6edbhXkfJlHD31WlJCit3F+1rpGWvxHpm+BCtTdUiL/tsLX0E/cQlETROr2qrBFz6YfJjuAHAW
	UIw3+ls5gycaemP94azI00G3us1vR5rJQ345fKVUaRYBVfX6alXuaA2U+5jbBEa//RNc6/Fy1z2u5
	tQMjCg6D1BSUC3M0qwaN/Osl8zhNXdVdTYhhfj9NC2EwVnK5fDrB0Q5EZ3aKdM1dk66VMuMZhgTXE
	LMQiKaaQ==;
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QY-00000001iwr-07vB;
	Mon, 01 Jul 2024 05:18:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Date: Mon,  1 Jul 2024 07:17:52 +0200
Message-ID: <20240701051800.1245240-4-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701051800.1245240-1-hch@lst.de>
References: <20240701051800.1245240-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

NOWS is one of the annoying "0's based values" in NVMe, where 0 means one
and we thus can't detect if it isn't set.  Thus a NOWS value of 0 means
that the Namespace Optimal Write Size is a single LBA, which is clearly
bogus.  Ignore the value in that case and don't propagate an io_opt
value to the block layer.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab0429644fe378..6784fc6e95625e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2025,7 +2025,8 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
-		io_opt = bs * (1 + le16_to_cpu(id->nows));
+		if (id->nows)
+			io_opt = bs * (1 + le16_to_cpu(id->nows));
 	}
 
 	/*
-- 
2.43.0

