Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4863A5FDCC
	for <linux-block@vger.kernel.org>; Tue, 20 Feb 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708421569; cv=none; b=OcDvD1NrcXRxQ4yWR+fYS6TXsuhX2tStjzTtbc1Jh9I6jm2KgdES3617NbMJCOfDAOZK4Lr81BjtckLwyLS7LxKhg2ouMRtjyCBla6x4sQedvueIhBkEaW75NTb5ZcPUSU6YHKUM+NgXYaIakFC4v5agR3HT1Ba/Xtvi1dgoTsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708421569; c=relaxed/simple;
	bh=Q2zEtfyrvbQKvSDDS1iBz40O0ob9edGXduqUpyrH2kM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MtlybS6x0g0XwPE/SwwqBSrWZzUTTy5s/BI2pfZaJHb/9paeDU9KSa4ybRN3I7DUy7+EReGnLLbOIDXtNkeYjr/2pbGMqUw+SUIF5aqOFsgorremgY/hzyc5fIPXV8oxm4OIZvDg31TrBX1ZfZuyqnob3mBb1FzlAyLLfS2dg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qbpl9nH4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qbpl9nH4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sH+kjSsCvB+Neo0QCxyzpfVwed/MMI7b9p+HqVipfiI=; b=qbpl9nH4et+geJOi8ar1/jh8OJ
	7jTNTRo6iSm8VxB9GMFX4UHIDf8Nw6Gamctf+6l8c91sv4IaU6Wp0CiA37E+hGTXItR44kGvyoCOd
	36d3TnPqdPd4tmwLVdQxzKG9zFX+sWo5V+eUxrm0fwbexpiszmZdMcTuqNO/94zKxPH4heUcQ60AQ
	Hc9dzdeUchAOReAqkt5nLzFa/pw69uWNykPtZPKJFCeiuS7WW2LfAtmGGIeCp2rC/Bg71+pd2pY2R
	bF+/EcVs0BNxHT/IXrWETBPJEL/tauZRuLFEo4bgxMcZ2g40W6+hkcsEfWf/vEndppmQ10UwugaI2
	f7YQ43Zw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcMUZ-0000000E0jv-1PzY;
	Tue, 20 Feb 2024 09:32:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/5] null_blk: initialize the tag_set timeout in null_init_tag_set
Date: Tue, 20 Feb 2024 10:32:45 +0100
Message-Id: <20240220093248.3290292-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220093248.3290292-1-hch@lst.de>
References: <20240220093248.3290292-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Otherwise it will be reset to the always same value when initializing a
device using the shared tag_set.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Tested-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6836327eefb42..89e63d1c610362 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1797,6 +1797,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	set->nr_hw_queues = hw_queues;
 	set->queue_depth = queue_depth;
 	set->numa_node = numa_node;
+	set->timeout = 5 * HZ;
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
 		set->nr_maps = 3;
@@ -1921,7 +1922,6 @@ static int null_add_dev(struct nullb_device *dev)
 	if (rv)
 		goto out_cleanup_queues;
 
-	nullb->tag_set->timeout = 5 * HZ;
 	nullb->disk = blk_mq_alloc_disk(nullb->tag_set, NULL, nullb);
 	if (IS_ERR(nullb->disk)) {
 		rv = PTR_ERR(nullb->disk);
-- 
2.39.2

