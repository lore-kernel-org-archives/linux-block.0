Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0D5A7A4
	for <linux-block@vger.kernel.org>; Tue,  5 Mar 2024 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709646046; cv=none; b=DuTIARgdapnaK/SC5slIGbGgewWlL2GDdC/EQ4KStFkaDmjuDjTD6MuedHThyQmBfvIFD4XcRRZ7S4XaXD3WyH7qCOlZywLfc/h+QhXl76dkpT5he6StsolirlAOuJN1w0IBCJlCGyKBQQBr1G7VYCR3iIU16E4Ma/f+R9/K0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709646046; c=relaxed/simple;
	bh=XpLAWU/T29R3Tx7M5y0bBtN8HvoYCHtVCtBpYdyGND0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rofzoGA6DQ1KSybDckK4SUq1Ui9N8yrPbdSwSaGB3C60zJ6OiGHKn86L5unvnbm6uImJBkD2OIk7bUsg8l4zO4Nmm1ZK2R6Ory7o0l7Gh4YroHyqs9PaZ188eLHdiicGduAkIjmRbbE/NYdwQC9l3RW9fXWu8pJWDA/Z6dzoDuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/SuFmhR; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/SuFmhR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=f3zgMPRzyEaVBtSoLHLNya392ZrbcPY31mEsET5i7T0=; b=s/SuFmhRABlJihe04dU7SVg3al
	liZ5j3moGRX+lOh6f1gdCeUqjBGRciENRlMw1s+7qpjD3jmEABmXHP3BuarEZ28efhJajIrJFnXTA
	r5nZA8GME/Mzic/dbLGtm+ZaK27uy3fIR9+/s3bbWQT52j8QYIdnrQLMm3zI8JOkSg7l0qfK40Yiw
	lMNbXOd7g2LC6Sjqtnag/ILvhDhzDhhe71KPUSiaRAfXbRHaA4+Pq2kqjXUqzRQv794JzkehY1TiF
	81YdFKKP2LT0mP3J4YOlPFEh2KnlKi4WxE6hDvy3ZPkfh0uPaHCq+5ZolFgKKcc6PBNtG28/pjTp3
	mm+gyoWA==;
Received: from [50.219.53.154] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhV2A-0000000Dqwj-3i1T;
	Tue, 05 Mar 2024 13:40:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org
Subject: [PATCH 1/7] drbd: pass the max_hw_sectors limit to blk_alloc_disk
Date: Tue,  5 Mar 2024 06:40:35 -0700
Message-Id: <20240305134041.137006-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305134041.137006-1-hch@lst.de>
References: <20240305134041.137006-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Pass a queue_limits structure with the max_hw_sectors limit to
blk_alloc_disk instead of updating the limit on the allocated gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index cea1e537fd56c1..113b441d4d3670 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -2690,6 +2690,14 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 	int id;
 	int vnr = adm_ctx->volume;
 	enum drbd_ret_code err = ERR_NOMEM;
+	struct queue_limits lim = {
+		/*
+		 * Setting the max_hw_sectors to an odd value of 8kibyte here.
+		 * This triggers a max_bio_size message upon first attach or
+		 * connect.
+		 */
+		.max_hw_sectors		= DRBD_MAX_BIO_SIZE_SAFE >> 8,
+	};
 
 	device = minor_to_device(minor);
 	if (device)
@@ -2708,7 +2716,7 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	drbd_init_set_defaults(device);
 
-	disk = blk_alloc_disk(NULL, NUMA_NO_NODE);
+	disk = blk_alloc_disk(&lim, NUMA_NO_NODE);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
 		goto out_no_disk;
@@ -2729,9 +2737,6 @@ enum drbd_ret_code drbd_create_device(struct drbd_config_context *adm_ctx, unsig
 
 	blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, disk->queue);
 	blk_queue_write_cache(disk->queue, true, true);
-	/* Setting the max_hw_sectors to an odd value of 8kibyte here
-	   This triggers a max_bio_size message upon first attach or connect */
-	blk_queue_max_hw_sectors(disk->queue, DRBD_MAX_BIO_SIZE_SAFE >> 8);
 
 	device->md_io.page = alloc_page(GFP_KERNEL);
 	if (!device->md_io.page)
-- 
2.39.2

