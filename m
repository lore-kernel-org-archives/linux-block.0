Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2645F13AD0F
	for <linux-block@vger.kernel.org>; Tue,  5 Nov 2024 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821709; cv=none; b=rImkB9fZ5HmyJTQ1zc6dIRQ4kGvUxMrC6940fJrSoxz74SpvIXRdMi3Y05LuIjC+XapKnzVJaItdKak7AC5vYBZaAtGiu/X16SksXRB/y1DIRJaDhCiqJAouyusr7klHSQK3g58EOfSCGnyme+BhaVhAqO9uwFiGrZB8XZvyRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821709; c=relaxed/simple;
	bh=ctJqDrzhar5r6p2ftiRxP6lLdozMnhy8hLmOe6TABlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=awd3YPeBzBpE6zeaq9kQSQBTYInW1ttcXgYnyp7zIUTMSnne5YPkmXqVV9pOm1L14GvRcgBMiTPrN6d+WPDf/f2wPSeZCwgNQfHN4zUdvSYK9EwRygMMb6666gZNCAB4uKi1aI47ygxf4kaHUbSWIcbXlrpQPhMMCzxYF7TUgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cl/1LXrk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cl/1LXrk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=O2pI4muBBDotpdXxdR5iT9OwjkhWYqDjshZgezWHTJk=; b=cl/1LXrkM4Do1TYr9mrS5hhQk6
	/8oErw0Q2seNwOsBxSprRfwk2FfMd9/SOrcuw6A64hEQvEsdPoRAUfRkEW4h1oInezuXNBfGrj8wN
	b6mUdtExuR0H6aAetVJ/+6uS8/7UEdX2JIdBdRh9U0vvsGrQaxN38iROz0DrBK/Dm5vUtmtszFfL9
	qQpWlu1JUb7lHKJvsZdnzRCnwnFa/yicAX82sh4nZtSulq/8Oh+mJgSVriM1R5+xY2AVzFSanxVpR
	0KsrB5IO5dWKgP1XycWMcbIpp7AHe1e6LpybLYwDDq34Ix9tbwoGrXJpha4CmF+lSmVrL6ylbBfA6
	DyZi95mA==;
Received: from 2a02-8389-2341-5b80-f6e3-83d3-c134-af6a.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:f6e3:83d3:c134:af6a] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ln8-0000000HU8v-24RA;
	Tue, 05 Nov 2024 15:48:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-multipath: don't bother clearing max_hw_zone_append_sectors
Date: Tue,  5 Nov 2024 16:48:12 +0100
Message-ID: <20241105154817.459638-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105154817.459638-1-hch@lst.de>
References: <20241105154817.459638-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The limits stacking now properly zeroes it if at least one of the
underlying limits clears it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c26cb7d3a2e5..f04cfe3fb936 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -635,8 +635,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
 	if (head->ids.csi == NVME_CSI_ZNS)
 		lim.features |= BLK_FEAT_ZONED;
-	else
-		lim.max_hw_zone_append_sectors = 0;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
-- 
2.45.2

