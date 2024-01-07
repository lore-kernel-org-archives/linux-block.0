Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199312B69
	for <linux-block@vger.kernel.org>; Sun,  7 Jan 2024 07:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjgJX/X1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D09C433C8;
	Sun,  7 Jan 2024 07:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704612134;
	bh=AczaJteAuUYqJT6WdtMvTQGegUGBq3FdlwuD0OVS0sM=;
	h=From:To:Cc:Subject:Date:From;
	b=NjgJX/X1PLsNZ6PqovYGqwOZSWrMmyaYkhmbLLkeP+xUnDZSe1WOT5+beD782d4ZD
	 ZGm1VWb7YUk/CEM/gip5hSu72wMhpkNkxDO9rQJ/q9YCPJVwXaBoKxCx0tAQT9JaZJ
	 Bf16wQQK8ACCmM3nDc77uRtg/dzYu5lP51Q2nZGTjZQrfKVWLa5nxCNxg5o660sS/x
	 J2A7VXWzDFtKRLNdtHLTEXJ7t5uXOC7I5R5EbQ2fwKI0ChiDJ4MCKw5MYMe2koPSkR
	 pwA9Y6lqrnzfBQu3Iw2OtA+lWcGKw233SQbrr/GVYVNuVVRD7YpRP0XdUukF46+WaN
	 w7dqCPrtkjxRg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] block: Treat sequential write preferred zone type as invalid
Date: Sun,  7 Jan 2024 16:22:12 +0900
Message-ID: <20240107072212.1071080-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the removal of the support for host-aware zoned devices,
blk_revalidate_zone_cb() should never see the zone type
BLK_ZONE_TYPE_SEQWRITE_PREF (sequential write preffered zones). Treat
this zone type as being invalid.

Fixes: 7437bb73f087 ("block: remove support for the host aware zone model")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c59d44ee6b23..48252d9e3b0d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -498,7 +498,6 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 		set_bit(idx, args->conv_zones_bitmap);
 		break;
 	case BLK_ZONE_TYPE_SEQWRITE_REQ:
-	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 		if (!args->seq_zones_wlock) {
 			args->seq_zones_wlock =
 				blk_alloc_zone_bitmap(q->node, args->nr_zones);
@@ -506,6 +505,7 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 				return -ENOMEM;
 		}
 		break;
+	case BLK_ZONE_TYPE_SEQWRITE_PREF:
 	default:
 		pr_warn("%s: Invalid zone type 0x%x at sectors %llu\n",
 			disk->disk_name, (int)zone->type, zone->start);
-- 
2.43.0

