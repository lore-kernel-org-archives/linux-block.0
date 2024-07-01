Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4B15E5DC;
	Mon,  1 Jul 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719852780; cv=none; b=ivUi1sb6jtBcftlcqrlv5wpToJvgudjzQNMYY0BEfPGaPeRJRcheq+I8bbpWKDSyiLH531Cv5Kk6hPILZ4kjuIr3oH5tGNBDWXWMf3irZPJPlUxTNhdpYxRZZ8kkMGlhReonsEqqtRtpRFnASsUFUVmsbPkbqjWPl3j13oFM1BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719852780; c=relaxed/simple;
	bh=47dIZbwgMC3t2R5R5EDJKwmDnPgVrNlLoqy5xt3jicg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/tVXUdAmyzlP+/axeehmyiKjCq+duqLPZ+WV06l8bnEvWJqCiG0USVCQLJZT2x2mEKQTFsVNwDiCTZm3SQCs0pp4K42/19IO2VoBzPXqa6SvqzIxMUeWcWZmJM06tEPto0gRIa4jD4SqAwJzv+LElhT8Kj7W903f/MNOVL+KUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hxvJcNmV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hxvJcNmV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=htpY4Iv5A+ZWvUcYE7jcvpatTqys0xWVtBJ1A5kLVR0=; b=hxvJcNmVhtO+HPxvvvabRgxEhg
	jVJ78cJgEtcUQQeWoVnXOe6F2ZnCK91eLq4aMOPUc8xJUfH9yw6mLdJaVGjRuAxg6+3nsEhCQpJwN
	467JfI+nKGkxt6LRLDXRcaVj8jBsU10z4j4puMvcwy/1ExEqhSAMQLMTb881XUJsiprtHoX1j9fNc
	3kmbXOEV0Cj6i5Lqd7XQqIGVxfHRZxrOaWQVEtNqddSBNdEy5WKOJXPoLz919/zRqMYRwtHYOwHFg
	oITgw5NLEYpaW6QXdw8CQC1C9GnxJsp1aI0uEHvdTjWdKD7dIS4zTfkDmQOeZBVBypObBB9Rg35qn
	AMYqzt5g==;
Received: from 2a02-8389-2341-5b80-6bfa-ffbf-d1d1-ec94.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6bfa:ffbf:d1d1:ec94] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOKGw-00000004Boj-0DaI;
	Mon, 01 Jul 2024 16:52:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Conrad Meyer <conradmeyer@meta.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 09/10] block: limit the Write Zeroes to manually writing zeroes fallback
Date: Mon,  1 Jul 2024 18:51:19 +0200
Message-ID: <20240701165219.1571322-10-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240701165219.1571322-1-hch@lst.de>
References: <20240701165219.1571322-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Only fall back from hardware Write Zeroes failures when
blkdev_issue_write_zeroes returns -EOPNOTSUPP;

Note that blkdev_issue_write_zeroes turns any failure into -EOPNOTSUPP
when the write zeroes queue limit has been cleared to 0, so this still
catches all I/O errors where the driver detected missing support
for the hardware acceleration.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 9585178a51a60c..95a22e7b1d3b85 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -287,7 +287,7 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	if (bdev_write_zeroes_sectors(bdev)) {
 		ret = blkdev_issue_write_zeroes(bdev, sector, nr_sects,
 				gfp_mask, flags);
-		if (!ret)
+		if (ret != -EOPNOTSUPP)
 			return ret;
 	}
 
-- 
2.43.0

