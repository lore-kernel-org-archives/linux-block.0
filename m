Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715AF1C68BE
	for <linux-block@vger.kernel.org>; Tue, 19 Nov 2024 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732032592; cv=none; b=AMbm76PlxB7o4EM6mXO3EY2CEl3vRZHOJuu1jmpsk4fVM9h9rg0m5yveoQABoX0ow/ROx5FmgIMageRd90cUsi6OVunDPZQHhDag51oTXSd1cUID/5kKW2b7ru5uoEes9byCXL+bPda7SgKKw38qhMrILmfzgyKK0ilLjeIcmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732032592; c=relaxed/simple;
	bh=TDCzhPd6p+L3lX2ARyL7hMBsqNMn41zO9a99N+P1hfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuLltF4Xgkz5J1FtO2/A/Th8L3MbrBeqzTjGzE7bFGXvnzbanC4enz275SCOifXCcTfxvPJRMkv7pzJmcgcNtR7gufN6U4yp6dtTyvffQS4VAismXlZV/BVpit/2thTOzEmN1nymn+wgXYLDH3DVg+Nbx7lLoaG9l4bBoj6hyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IDVog/Ca; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IDVog/Ca"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1b9Xv4/vvL/9ZsDPTiC1iS2VEPwEcbtgu0kRuHezA0c=; b=IDVog/CaMgrnSdnrtvbdEKwdIu
	uplmAt3janzy0sgmam/1RrNgaluPoZUQk2fDsABnYJ95oczf+IC+9UpNarDHLbKW8m3CwbwdnkRGb
	fnnONE4sUQXakGBNHYYLDt81yrE7IqIJtQQfMvtj3M7o8IG3ejcf3A42iUYGOrJfqCeApCNI/a8pu
	+lxb3Vybg0ux4V1rgj/nROyok2LNqn7rLZta7mJRLiVyp6MukTZuWRfyuH8hs87KCVJ3iniYJxU3b
	7psv2XHl5jFT0Okeiog0iCuQKuK0LXMCDCespqPYEzeM3uQiAxHQscoxHw9MPyKGb7mo61uDtWhY4
	XptFMYnA==;
Received: from 2a02-8389-2341-5b80-1731-a089-d2b1-3edf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:1731:a089:d2b1:3edf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDQnW-0000000Cymm-1x1O;
	Tue, 19 Nov 2024 16:09:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 5/6] block: remove a duplicate definition for bdev_read_only
Date: Tue, 19 Nov 2024 17:09:22 +0100
Message-ID: <20241119160932.1327864-6-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241119160932.1327864-1-hch@lst.de>
References: <20241119160932.1327864-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

bdev_read_only is already defined as an inline function in blkdev.h.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e4fc967e8cb9..957767c0cafd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1582,7 +1582,6 @@ static inline void bio_end_io_acct(struct bio *bio, unsigned long start_time)
 	return bio_end_io_acct_remapped(bio, start_time, bio->bi_bdev);
 }
 
-int bdev_read_only(struct block_device *bdev);
 int set_blocksize(struct file *file, int size);
 
 int lookup_bdev(const char *pathname, dev_t *dev);
-- 
2.45.2

