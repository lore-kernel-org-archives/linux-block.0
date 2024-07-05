Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2349219EB
	for <linux-block@vger.kernel.org>; Fri,  5 Jul 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720157480; cv=none; b=QKg6i3ag2wqnxqwcqwK37VsD9zQnyJQA2bHEdyJ5+Q7S9rW15oftO6VVk2xC9vY7LwTejDAUjvoEW72NHawMgvPIS7UFvmO4j6e943HcY3MhJWqBfUijNw70lTkxeAEULJywLRLlx5x/ALMQrW4YryhI3Bl8Tyj+XsNvTjVCbcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720157480; c=relaxed/simple;
	bh=AgDcQ2LBOxRnRE6Yqf9vkoWcyRh1DoNvW9EzuezdE0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTYPobgYQ1YNwDkmF9YeXrxqy13WeIpkuCCkHSv/zRiQfd9eDfVKm560goESXJtVa4hTJDmuecHf58XWUAiDFBXHWCq4ueypYzFFK84UcbO+JL0W/Q3bgKBaYwg+BICOd5zQ3cYMCRTW7qqYf9/andWJyvbzRWT4HRY13oPYkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ISqR0tWS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISqR0tWS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=KZnwbJgKSZrQKDFHNUd+08s4+ykrKcwXIoLp6rIcwDU=; b=ISqR0tWSFM1S2D5tjAQiOc/sfa
	xyllTfldxXxJ19b2XresrsCoj2nYjsPwcJyN5SgFQIK1Pk+YAQKQJM8KXlfWDwFNOswtglmPOO/l4
	vBtDfSf6HDzUj8itMZpOrRE/YYaq/x2WlNdxLuHScOhtQVBVADVrNll7yyccumXrKyS7tQKjupymt
	Rd3YTI9IpFp0A9a/VpNMugMS5vfKZ53t30Y8/363Qf4vqt1Whe5WpKAroUcZD7ImYk3s+Ys/uSf6m
	1aXyaRzJRqkpWVznHDCn/W5BxOWj+fsV6xvskjSmBFxV9NCflmbrvsSuVthJGXxn+qdu4su3URtrd
	9z3gmzZA==;
Received: from 2a02-8389-2341-5b80-7f6c-d254-a41c-2a9c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7f6c:d254:a41c:2a9c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPbXR-0000000Ewai-2UGE;
	Fri, 05 Jul 2024 05:31:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] loop: remove the unused inode variable in loop_configure
Date: Fri,  5 Jul 2024 07:31:14 +0200
Message-ID: <20240705053114.2042976-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Remove the inode variable now that the last user is gone.

Fixes: a17ece76bcfe ("loop: regularize upgrading the block size for direct I/O")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index bba4c920508f88..1580327dbc1e15 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1019,7 +1019,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 			  const struct loop_config *config)
 {
 	struct file *file = fget(config->fd);
-	struct inode *inode;
 	struct address_space *mapping;
 	int error;
 	loff_t size;
@@ -1056,7 +1055,6 @@ static int loop_configure(struct loop_device *lo, blk_mode_t mode,
 		goto out_unlock;
 
 	mapping = file->f_mapping;
-	inode = mapping->host;
 
 	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
 		error = -EINVAL;
-- 
2.43.0

