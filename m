Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE73156C69
	for <linux-block@vger.kernel.org>; Thu, 31 Jul 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753975353; cv=none; b=l1gRL3fjoTgY5hvDKpDQTfzCaXERMk2Yi15h+Htjm2FGm4eEzi1bQp/P6wlKezv7xL3xlGLAbi4ZCarFnpPfB+84JQgPmInyZOiCzJJZTz2q7AOjafJJJhRa3OQHoKSH+WJjzprVxFPnBykFZLVtNorLWO5XFVPqxizVivAD0Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753975353; c=relaxed/simple;
	bh=rw7Dh/vaI2hQ4S4TLjoxnPuzCP4jY/iiRILoptnBjCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDEGVBclwhiSxhKextYQRwInBWyws0ZyErJ9tTXGUBIesq2diVsopE3gU2IQLPJqy38eFcN+MbKStI3eR9jzOvhIkf95zDOoRChmKOA+3P2BuH2zgLoiNtQrcf/a983gbsVDeVThk96D6s1HDEILvQ5u+3mXJDkwBb/ukCV6I+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OwBcvdFx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OwBcvdFx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XDFtipXov46axeEuyIoBj2s8aeJUslrClE6tKPL317w=; b=OwBcvdFxEfg01nytgSxu0wjMOl
	mxDKCkLvIDe/bZlPijaDfm8wPDaaq5NaFYWuNl4RvssPmwk7TT3uJg/naUkO51Z/PLpZH8fGnVkIS
	vhut4lWtZP3Mve2QUAxRdlBIOvsdDpWpbppfv4mRpjSKZAs0i9944YFnQ3g23CvMKCdnuL1HfmAsq
	oqTYuK6uIN4bVHlKuPEjIZJAaEA0qicd9/gBTeoadv71RLPKydscQVGaoWq+ga0i+wEtTc/0mjNP4
	GfIaRWSguGwDLQO5EKEy78w3TJfpFkLXvnrArUf2dtdvr95Uet+yGZufNtXCuC10FZDhYe0hrUDqp
	AnSvYRFQ==;
Received: from [206.0.71.13] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhV70-00000003xQN-2WRE;
	Thu, 31 Jul 2025 15:22:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: anand.jain@oracle.com,
	martin.petersen@oracle.com,
	linux-block@vger.kernel.org
Subject: [PATCH] block: ensure discard_granularity is zero when discard is not supported
Date: Thu, 31 Jul 2025 08:22:28 -0700
Message-ID: <20250731152228.873923-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Documentation/ABI/stable/sysfs-block states:

  What: /sys/block/<disk>/queue/discard_granularity
  [...]
  A discard_granularity of 0 means that the device does not support
  discard functionality.

but this got broken when sorting out the block limits updates.  Fix this
by setting the discard_granularity limit to zero when the combined
max_discard_sectors is zero.

Fixes: 3c407dc723bb ("block: default the discard granularity to sector size")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index a000daafbfb4..20f8b207d5e8 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -336,12 +336,19 @@ int blk_validate_limits(struct queue_limits *lim)
 	lim->max_discard_sectors =
 		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
 
+	/*
+	 * When discard is not supported, discard_granularity should be reported
+	 * as 0 to userspace.
+	 */
+	if (lim->max_discard_sectors)
+		lim->discard_granularity =
+			max(lim->discard_granularity, lim->physical_block_size);
+	else
+		lim->discard_granularity = 0;
+
 	if (!lim->max_discard_segments)
 		lim->max_discard_segments = 1;
 
-	if (lim->discard_granularity < lim->physical_block_size)
-		lim->discard_granularity = lim->physical_block_size;
-
 	/*
 	 * By default there is no limit on the segment boundary alignment,
 	 * but if there is one it can't be smaller than the page size as
-- 
2.47.2

