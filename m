Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7A1891AB
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759828020; cv=none; b=NA0LAUREB8Ha8DI2Nyuy8vFyHYsDv95LC3ncyGQX7WBHj/9vUyvO8VWCKxkZeToJYrBAcDRvGChQD2NVMQDqk2DG/s447LzbWqEJbttKPeQ7MoJ4ga1zxzvEHjkekYImknmYUyHBzXVj4sm0gI1LbN5T5qdu95N4D60lyrs9ZfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759828020; c=relaxed/simple;
	bh=JfxXNAKSOfqXqzrul3qPKkc14GMJqK+eXHwr62I/cpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVS/FXQCSMY27qVcdLcMN04e9pgNpzFQVcwZ6to/0upmnBxO1ndUOB/ZTx3OTyaLgrYMvRrcTJjWWBtJAaYQGb3Pl+nNTqraz7qB2luZIGbsT3R1OscbX+q9kIA6ZTq9agRHIE19NwHkF6r8kuNH4cLnvtXeocWR+Ktbrb0Mf30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2cZHULJS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2cZHULJS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=He/zWu/I15dj4iUcuBclXQ4Zjuhlk50AZJcPnYc4VJE=; b=2cZHULJSrm/33MZ8fFCRd3+VEK
	Ijp62KAvOp+tjLTRjqnBAQKrSlNaFOy/hiZPU2gOzjI4CvJ76BdikX7c40RXd4ziO7UVAZI8fpijT
	XZyTJD7EPpe7REwESF852WOSUcT8v44HJaSJ6yz1ev3qNtBgyxkpiyS7aUUwkc+3h376DSIINzqNU
	tfTskHlK5qCLO77+R+O47sR+DHcl3hwoVItScAeQ+JNmlIFP/q9S1AEgS3oq0AduRyrdreQVBqHma
	LdOJGvHHdb503EcL+odSiTOQ2KgElkMk8We2NJ+FmwFFOZVEsoHijWQxyKO+IrrGUNFf2e0Efn1gN
	0N9G+zPQ==;
Received: from [2001:4bb8:2c1:22e6:ca8d:97b7:39cd:b2e9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v63es-00000001fWi-05Rq;
	Tue, 07 Oct 2025 09:06:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] iomap: open code bio_iov_iter_get_bdev_pages
Date: Tue,  7 Oct 2025 11:06:27 +0200
Message-ID: <20251007090642.3251548-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007090642.3251548-1-hch@lst.de>
References: <20251007090642.3251548-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Prepare for passing different alignments, and to retired
bio_iov_iter_get_bdev_pages as a global helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/direct-io.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 9802b2cc29bb..5d5d63efbd57 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -433,7 +433,8 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		bio->bi_private = dio;
 		bio->bi_end_io = iomap_dio_bio_end_io;
 
-		ret = bio_iov_iter_get_bdev_pages(bio, dio->submit.iter, iomap->bdev);
+		ret = bio_iov_iter_get_pages(bio, dio->submit.iter,
+				bdev_logical_block_size(iomap->bdev) - 1);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
-- 
2.47.3

