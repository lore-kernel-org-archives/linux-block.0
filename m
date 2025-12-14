Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DFE2040B6
	for <linux-block@vger.kernel.org>; Sun, 14 Dec 2025 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765707273; cv=none; b=S/SnpffMFiP0eNwXTwm0AJmXe2KJ1MV1efWuUmRDy1wL/u+M90nc+LRNcStMhF8iENzToO7+OXeHW1I+SSMyv+Ob2cp4oEzYGqPvQFbPi2bmTzY8yloSk/LJtAlRyaa7QRl4cxNpqA1deN2edrl7UhszoHcGggKAi/qx+AdLRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765707273; c=relaxed/simple;
	bh=9FUMAn6C0T/pJY65brtKDorc+Sy0+brKb8o1TEyqLdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRgSd/dv4U8ZvqXGRTGn8hwQvRfxE6cNgzlo6Pt8DXEloLOc2U5ux05BVFDazuUHQ5RJgObuBDK5IDiixOtDbPZqMDBgoq/YcEZtW34OVCb4aQMKVOUdUHpAY5cKWw5pRyC6NK3H4TzHKNHSbi+LhDdfojG1ukxpE5W8vHVnSpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F2C16AAE;
	Sun, 14 Dec 2025 10:14:31 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com
Subject: [PATCH v5 07/13] blk-throttle: convert to GFP_NOIO in blk_throtl_init()
Date: Sun, 14 Dec 2025 18:14:02 +0800
Message-ID: <20251214101409.1723751-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214101409.1723751-1-yukuai@fnnas.com>
References: <20251214101409.1723751-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_throtl_init() can be called with rq_qos_mutex held from blkcg
configuration, hence trigger fs reclaim can cause deadlock because
rq_qos_mutex can be held with queue frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 97188a795848..5530a9bb0620 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1313,7 +1313,7 @@ static int blk_throtl_init(struct gendisk *disk)
 	unsigned int memflags;
 	int ret;
 
-	td = kzalloc_node(sizeof(*td), GFP_KERNEL, q->node);
+	td = kzalloc_node(sizeof(*td), GFP_NOIO, q->node);
 	if (!td)
 		return -ENOMEM;
 
-- 
2.51.0

