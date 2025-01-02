Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2A4A00
	for <linux-block@vger.kernel.org>; Thu,  2 Jan 2025 01:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735782994; cv=none; b=FRe68t87X+hHyjnycVw63kix8YwM7gC0tZKZGuXGlkWCLj866tg49q4xmL7rah11TUrQsjUVk9/22947bopWfH3oV1d5FWi/XtMXYxejztrwfI23Q0mASV9wy+i3bpW3H8kM4Pd112LzmsXztn89Gw17+JKHpqzBoqeORZTYTF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735782994; c=relaxed/simple;
	bh=NFPvyoW/A2Xv/GnzBEa1G/J1irquFvFj7InOa+Szg80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUmhMtFPR0P9kEtMbY0Ea1mu1Ncut2DZEMRbztPAGEdAD5Ct9G1PMcAhk3bjPZWaHGSkkRH1Xhe8soEeFScl2YfkPv9wpmv0xxzyP+mVvbpOXX6Bj0FeH2XVgMOE87rHXtQ7/kXhp9ZM9Q7ollec2gbCyCO0OmOb55ba/smGywM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IqSMXJ5g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqSMXJ5g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735782991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FY0LbQTym8kFi5yPGPWe1CqQs/gOC6lmG8lg5IOIgvc=;
	b=IqSMXJ5giIZCHvhGg5ZS9fqRg956CApd+IEtPSU5Y3edNoMRIP6RN8dWrFpAu4ZrfpdYo6
	Fukf8AYmee6NLvpLnblZEd6vYg2XIk6OmmBGZ/aoOD54ORq+c/sIuQLBgt1NQ4wAKi7FWY
	0F/wYsea/MlOB60lOdfYQYQ3GTcb0g0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-g_9w_SxtMA-WPo7X4UKqMQ-1; Wed,
 01 Jan 2025 20:56:29 -0500
X-MC-Unique: g_9w_SxtMA-WPo7X4UKqMQ-1
X-Mimecast-MFC-AGG-ID: g_9w_SxtMA-WPo7X4UKqMQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EAA79195609D;
	Thu,  2 Jan 2025 01:56:28 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AB1971956052;
	Thu,  2 Jan 2025 01:56:27 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>
Subject: [PATCH] block: make queue limits workable in case of 64K PAGE_SIZE
Date: Thu,  2 Jan 2025 09:56:20 +0800
Message-ID: <20250102015620.500754-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

PAGE_SIZE is applied in some block device queue limits, this way is
very fragile and is wrong:

- queue limits are read from hardware, which is often one readonly
hardware property

- PAGE_SIZE is one config option which can be changed during build time.

In RH lab, it has been found that max segment size of some mmc card is
less than 64K, then this kind of card can't work in case of 64K PAGE_SIZE.

Fix this issue by using SZ_4K in related code for dealing with queue
limits.

Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-settings.c | 6 +++---
 block/blk.h          | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8f09e33f41f6..3b6918c134b1 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -300,7 +300,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	max_hw_sectors = min_not_zero(lim->max_hw_sectors,
 				lim->max_dev_sectors);
 	if (lim->max_user_sectors) {
-		if (lim->max_user_sectors < PAGE_SIZE / SECTOR_SIZE)
+		if (lim->max_user_sectors < SZ_4K / SECTOR_SIZE)
 			return -EINVAL;
 		lim->max_sectors = min(max_hw_sectors, lim->max_user_sectors);
 	} else if (lim->io_opt > (BLK_DEF_MAX_SECTORS_CAP << SECTOR_SHIFT)) {
@@ -338,7 +338,7 @@ int blk_validate_limits(struct queue_limits *lim)
 	 */
 	if (!lim->seg_boundary_mask)
 		lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
-	if (WARN_ON_ONCE(lim->seg_boundary_mask < PAGE_SIZE - 1))
+	if (WARN_ON_ONCE(lim->seg_boundary_mask < SZ_4K - 1))
 		return -EINVAL;
 
 	/*
@@ -359,7 +359,7 @@ int blk_validate_limits(struct queue_limits *lim)
 		 */
 		if (!lim->max_segment_size)
 			lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-		if (WARN_ON_ONCE(lim->max_segment_size < PAGE_SIZE))
+		if (WARN_ON_ONCE(lim->max_segment_size < SZ_4K))
 			return -EINVAL;
 	}
 
diff --git a/block/blk.h b/block/blk.h
index 2c26abf505b8..570d66f1e338 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -357,7 +357,7 @@ static inline bool bio_may_need_split(struct bio *bio,
 		const struct queue_limits *lim)
 {
 	return lim->chunk_sectors || bio->bi_vcnt != 1 ||
-		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > PAGE_SIZE;
+		bio->bi_io_vec->bv_len + bio->bi_io_vec->bv_offset > SZ_4K;
 }
 
 /**
-- 
2.44.0

