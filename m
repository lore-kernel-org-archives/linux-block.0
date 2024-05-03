Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931A219EB
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723847; cv=none; b=qSgws/8NN9vXtuXLyK8JZVquP+o4TyiEQGpwlEcDarj7MSloePFPCRV+r1Nqf3T8UTtmU7cHxaw+xmHEHIdsQ5gYFume2i6IDQTKB6Ptl8QWo/gAjWxcRkCLvCYCOyecu9SL1+Z/LzflZJnj7FpU43SP2vmRIrGGI0+kH+/OLUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723847; c=relaxed/simple;
	bh=Ro3KWgZHuzwozytdPRVtAug80fm1EqjmjUwSCpXki3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Co86HzKTimSBiNwP1YmuljLGzbnvHZqThJj4esZDW1qxK1hhuwyK2IGQkRm6pPYIhhYLxMYmqsKd7RDAZ1Q3geniTfEQXtfCU3M//9RKOquOu5jtD2CcOz/8UKaTk+bYg0oyD4G9+ZORE0AgFdKqDre/88sPulNfSwwEEK4tpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0U5096T9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0U5096T9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5lOxySmfE6/YdtPBH9ro8KriQh8+zawqua1J9iMQF24=; b=0U5096T9qDNtfmMz13wMkf3/rD
	MYtChd9NdXRmwA+YlRfAawynDvIVvbNsNGi4nv5gBuUd66mPFeZEclHh1LX0iN1aSdQBAS2uJj4rQ
	UyJlt1Zyl/kN9vZtY1mKyYA4sTkdOrjdGAjMFD5JwtNTMw6k924ZKF8Y6jUDzsAEUMwlwBLLlNcgj
	qadEAbHttfSNxoq5IKYbN6Ehned+rn0NUAeN6SPwCV6m9/3RT0DIO8lf7rIdOQcOloHKcgvdXCArB
	wC1WYohx05Gw7QFXgQ1P06kQwMWfYrWCKeoQCZrrM7HcmSqx+rzjhqWU97/R33pQOLsQDGfhblFiD
	vFN9TJAw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2o0C-0000000FaS9-1ijD;
	Fri, 03 May 2024 08:10:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com
Subject: [PATCH] block: refine the EOF check in blkdev_iomap_begin
Date: Fri,  3 May 2024 10:10:42 +0200
Message-Id: <20240503081042.2078062-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

blkdev_iomap_begin rounds down the offset to the logical block size
before stashing it in iomap->offset and checking that it still is
inside the inode size.

Check the i_size check to the raw pos value so that we don't try a
zero size write if iter->pos is unaligned.

Fixes: 487c607df790 ("block: use iomap for writes to block devices")
Reported-by: syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+0a3683a0a6fecf909244@syzkaller.appspotmail.com
---
 block/fops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 679d9b752fe828..df2c68d3f198e1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -390,7 +390,7 @@ static int blkdev_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->bdev = bdev;
 	iomap->offset = ALIGN_DOWN(offset, bdev_logical_block_size(bdev));
-	if (iomap->offset >= isize)
+	if (offset >= isize)
 		return -EIO;
 	iomap->type = IOMAP_MAPPED;
 	iomap->addr = iomap->offset;
-- 
2.39.2

