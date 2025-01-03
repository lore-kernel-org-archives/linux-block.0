Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8641CF5DF
	for <linux-block@vger.kernel.org>; Fri,  3 Jan 2025 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894879; cv=none; b=FBLWsMRd4mgC0Sf/wPVwxdgkuPs9jNFDubO2GoKB3Z3yJrIuPlhKCjVydBTBjMfK9rOXSEJPhCH2uCvVwI5bbMXbJ7dfAPDTdMGIVApgqKcoP7aLFj8wWTjMUSR1JsWxRzwiz341qZAuK7BNhUznTlpDy61D4jZ3gw9DwmDxSnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894879; c=relaxed/simple;
	bh=dn7zhgTJ3YzyxyCL7W4j/U7H5Q8WM3p6Invtk9IOMok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UF2RScSWYMQayWYLiyR85DYE1KnJgFmnAwOcPU8uUhpbSTeNjbS3mLSAP7W90Cqej+wvAV0lE1gfJnJf7M2DZwrhENhPFNLCQG3s14sBXSXFaRu2fLLlL1+E/jaEokOh4lKFzASwNgvXabrer2a4oOQXL30zSSU0SzblWOHEmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
	by gauss.telenet-ops.be (Postfix) with ESMTPS id 4YPckf4wQpz4wxLT
	for <linux-block@vger.kernel.org>; Fri, 03 Jan 2025 09:51:38 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:f66e:bd3:be87:168a])
	by baptiste.telenet-ops.be with cmsmtp
	id wYrW2D0070t5JgF01YrW6B; Fri, 03 Jan 2025 09:51:31 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tTdOy-00000001dmc-20mH;
	Fri, 03 Jan 2025 09:51:30 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tTdP0-0000000CaCA-1Cum;
	Fri, 03 Jan 2025 09:51:30 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Christoph Hellwig <hch@lst.de>,
	Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	Geoff Levand <geoff@infradead.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ps3disk: Do not use dev->bounce_size before it is set
Date: Fri,  3 Jan 2025 09:51:25 +0100
Message-ID: <06988f959ea6885b8bd7fb3b9059dd54bc6bbad7.1735894216.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev->bounce_size is only initialized after it is used to set the queue
limits.  Fix this by using BOUNCE_SIZE instead.

Fixes: a7f18b74dbe17162 ("ps3disk: pass queue_limits to blk_mq_alloc_disk")
Reported-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Closes: https://lore.kernel.org/39256db9-3d73-4e86-a49b-300dfd670212@gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Guessed based on the reported bad commit ID.
Compile-tested only.
---
 drivers/block/ps3disk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 68fed46c463e5aa9..dc9e4a14b8854587 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -384,9 +384,9 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 	unsigned int devidx;
 	struct queue_limits lim = {
 		.logical_block_size	= dev->blk_size,
-		.max_hw_sectors		= dev->bounce_size >> 9,
+		.max_hw_sectors		= BOUNCE_SIZE >> 9,
 		.max_segments		= -1,
-		.max_segment_size	= dev->bounce_size,
+		.max_segment_size	= BOUNCE_SIZE,
 		.dma_alignment		= dev->blk_size - 1,
 		.features		= BLK_FEAT_WRITE_CACHE |
 					  BLK_FEAT_ROTATIONAL,
-- 
2.43.0

