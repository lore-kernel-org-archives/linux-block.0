Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497FE5D74F
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708418978; cv=none; b=JtlDpVVvZyOv22AH4RYYpiuaVVXpMbl1twVYYj+vJHUZshYN0wH813QRltljd+ASyRHmyezJUax3VOfO5n5LgVYnv4zRFeUeOFkXMA8hQIOE/oYXlAYgM3sNy+BjUttMgsHV3UonNr38NZgsDYr9joAlE//ZzmfRagki9KrgwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708418978; c=relaxed/simple;
	bh=m0MZ/452EuSFLuEjSxrzXmXuecrOIFX3cclr2s1yepA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DdvRM2Vb0jui4Qtp2GoBPZM6kaIFJVhrUGviTKPubkUb9gAlPEgQZmsC9DnJXYT7TA8sDNOtddlmZ4vjXykQoo+SVyNaMGPrUmjxIlDyyLsOI8TGe1PUX9SzZoQq8wv/d+3k/uUhFb0nkpE/X8dI721R9Q/1SfrXwkE/v6o+wcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MiwA9mC1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MiwA9mC1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-Type:Content-ID:Content-Description;
	bh=qIptjw8o7Oz7t0MBkVD69QjyMkpNVljZIeCgpSOPynU=; b=MiwA9mC1nUXdlp4EQ9i9PgWEcc
	zPQC3qBNpnwdxPm8TZxkbIhUkH9DVy5VbBvDvd5vK9z4cs7wyZpWo7K9ijlkJoBLZ4azIUJsK+AA6
	z+fghEuCvV7VbDZNb6gpNsMwiZBJKstzkf6HRABTqMX0LltW3i1VWQJscMPwb2guGUuN5ZHYm9WoM
	DLYQaU2kaY3KaH9tXa/CiU2lvl4KF5hMAOVh2mGQ++656UQx0Y4BlamhBHh/9nk+sdbD7XvOHvtnS
	SyqZB4+RBR5raaZoQ0BTTcijnSqjTXxxI2DmYhgSweS0VEuuYh8xYSCif+K1Ek+eBXXH6P1jhwGo8
	Oik2Hfdw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcLol-0000000DnUO-0bhr;
	Tue, 20 Feb 2024 08:49:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/4] xen-blkfront: rely on the default discard granularity
Date: Tue, 20 Feb 2024 09:49:33 +0100
Message-Id: <20240220084935.3282351-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220084935.3282351-1-hch@lst.de>
References: <20240220084935.3282351-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The block layer now sets the discard granularity to the physical
block size default.  Take advantage of that in xen-blkfront and only
set the discard granularity if explicitly specified.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/xen-blkfront.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index f78167cd5a6333..1258f24b285500 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -951,8 +951,8 @@ static void blkif_set_queue_limits(struct blkfront_info *info)
 
 	if (info->feature_discard) {
 		blk_queue_max_discard_sectors(rq, UINT_MAX);
-		rq->limits.discard_granularity = info->discard_granularity ?:
-						 info->physical_sector_size;
+		if (info->discard_granularity)
+			rq->limits.discard_granularity = info->discard_granularity;
 		rq->limits.discard_alignment = info->discard_alignment;
 		if (info->feature_secdiscard)
 			blk_queue_max_secure_erase_sectors(rq, UINT_MAX);
-- 
2.39.2

