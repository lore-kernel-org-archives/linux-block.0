Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A85207DE5
	for <linux-block@vger.kernel.org>; Fri, 10 Jan 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494694; cv=none; b=bnSmLImPp3KTA0UfZjSNWt49dDEsmHlIbkrAQeAvf8CzPV59Hjm0q5XDAi36I8J3RBWIdT1+3RGRG1rMWoa4pisfGLCTsYOrUDujmzEuHKi6hxYUKCi11FXe2niH/m/jzQyjgjDdkEsjmyUrOkIrOUiCgFFqZT5Eb/M0Ll1T+Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494694; c=relaxed/simple;
	bh=B/CqjXNIn+4NPKDzVoJKydDehoEWa2uGacNRUZ8+R+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFYyY5XHNRWFBEwOtQQnlWaAIlFVayz7IqVr9wb4xjqmQ8iIIDg6Ciw/piu2CuxxWj5bYvk/06u20NNp+rRKRPh4Gl77p34Ep9NlOtBMSmKa36psJpabytOsR0YSqVJl7Euo1jYZ6JPHmgJcy47IBJZutu9i4mFqmx/+uui5Mbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0sSTghqq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0sSTghqq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sHe7CdWpC98PmbFIcWxI15Gbkx5EugCyXfHuarJeyOo=; b=0sSTghqqttRP4aBtfM474o96aX
	0PNT/j8gNBNOtax1pU+NAvkjh3cdzOQOgqi/kE5zULnbs+MnRfipFw8BEuAX/RqRBiVw2CLYDL9JZ
	3HklD1z4i5H8eN0PeGT2rZdkSzhCtO9UAV5Jm5kLnE2LX/KZfAMMw3qi4jb/JuELzuAsUEmys4Zc0
	wv4KgNPvcAgjTkTzcIrBSIvfIcuPGU/x3yr59+sgb0iX9Qyu7L7aMIAfr28Elezv4cOd7j2EnmNbK
	5eQMAKAroIMqGEUPFIjt1Hhvrkqg6NmsrG5igcG+QVFSLMJ93E6mxBYU7+MZIY/WmpsgqdL2j1Wyb
	maFOvdQA==;
Received: from 2a02-8389-2341-5b80-76c3-a3dc-14f6-94e8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:76c3:a3dc:14f6:94e8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tW9at-0000000EOTI-3Prr;
	Fri, 10 Jan 2025 07:38:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/8] loop: open code the direct I/O flag update in loop_set_dio
Date: Fri, 10 Jan 2025 08:37:35 +0100
Message-ID: <20250110073750.1582447-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110073750.1582447-1-hch@lst.de>
References: <20250110073750.1582447-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

loop_set_dio is different from the other (__)loop_update_dio callers in
that it doesn't take any implicit conditions into account and wants to
update the direct I/O flag to the user passed in value and fail if that
can't be done.

Open code the logic here to prepare for simplifying the other direct I/O
flag updates and to make the error handling less convoluted.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf80cdf5e440..6eb6d901151c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1455,16 +1455,28 @@ static int loop_set_capacity(struct loop_device *lo)
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
 {
-	int error = -ENXIO;
-	if (lo->lo_state != Lo_bound)
-		goto out;
+	bool use_dio = !!arg;
 
-	__loop_update_dio(lo, !!arg);
-	if (lo->use_dio == !!arg)
+	if (lo->lo_state != Lo_bound)
+		return -ENXIO;
+	if (use_dio == lo->use_dio)
 		return 0;
-	error = -EINVAL;
- out:
-	return error;
+
+	if (use_dio) {
+		if (!lo_can_use_dio(lo))
+			return -EINVAL;
+		/* flush dirty pages before starting to use direct I/O */
+		vfs_fsync(lo->lo_backing_file, 0);
+	}
+
+	blk_mq_freeze_queue(lo->lo_queue);
+	lo->use_dio = use_dio;
+	if (use_dio)
+		lo->lo_flags |= LO_FLAGS_DIRECT_IO;
+	else
+		lo->lo_flags &= ~LO_FLAGS_DIRECT_IO;
+	blk_mq_unfreeze_queue(lo->lo_queue);
+	return 0;
 }
 
 static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
-- 
2.45.2

