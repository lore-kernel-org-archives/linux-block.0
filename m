Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152883191C3
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 06:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763706531; cv=none; b=u6mEkI6IxZZyYlQLNtDnVyzH16UPyCgXpiKMjOVdO9wZJSXyo/PEhwTMNRZGzYTyedgJQ3AeSMipYJFvdmHvbHyrUM4r0bMolNn4/J7upHEQMTi2i5CdeIgIiy+rpp66sH+2zj40zcE6xBEB0G2W9IfitgvBfUBUAEN0Ad2Nyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763706531; c=relaxed/simple;
	bh=rh+KRUIyXbzaTjhuTJ+/2x+qOK1rMSNMPxan0+bTUqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuhnMjkzit0I2vyE3oGP8NDqpfau0O5nIbqM/xFtzkD8eZjckH2kcDAcYC+eyopXmhaD7+P5ogNCwfGayNbP05wmmGN9WeAPxNDiSlYZ7MAu0aruwpIc9PG4+hVyh74SbnzSia/AZQKF8bJz+xGsPFMeumgdZ3YA5xNaIK/RFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E66C4CEFB;
	Fri, 21 Nov 2025 06:28:48 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	bvanassche@acm.org
Cc: yukuai@fnnas.com
Subject: [PATCH v2 8/9] blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze queue
Date: Fri, 21 Nov 2025 14:28:28 +0800
Message-ID: <20251121062829.1433332-9-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121062829.1433332-1-yukuai@fnnas.com>
References: <20251121062829.1433332-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently blk-iolatency will hold rq_qos_mutex first and then call
rq_qos_add() to freeze queue.

Fix this problem by converting to use blkg_conf_open_bdev_frozen()
from iolatency_set_limit(), and convert to use rq_qos_add_frozen().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-iolatency.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 45bd18f68541..1558afbf517b 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -764,8 +764,8 @@ static int blk_iolatency_init(struct gendisk *disk)
 	if (!blkiolat)
 		return -ENOMEM;
 
-	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
-			 &blkcg_iolatency_ops);
+	ret = rq_qos_add_frozen(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+				&blkcg_iolatency_ops);
 	if (ret)
 		goto err_free;
 	ret = blkcg_activate_policy(disk, &blkcg_policy_iolatency);
@@ -831,16 +831,19 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 	struct blkcg_gq *blkg;
 	struct blkg_conf_ctx ctx;
 	struct iolatency_grp *iolat;
+	unsigned long memflags;
 	char *p, *tok;
 	u64 lat_val = 0;
 	u64 oldval;
-	int ret;
+	int ret = 0;
 
 	blkg_conf_init(&ctx, buf);
 
-	ret = blkg_conf_open_bdev(&ctx);
-	if (ret)
+	memflags = blkg_conf_open_bdev_frozen(&ctx);
+	if (IS_ERR_VALUE(memflags)) {
+		ret = memflags;
 		goto out;
+	}
 
 	/*
 	 * blk_iolatency_init() may fail after rq_qos_add() succeeds which can
@@ -890,7 +893,7 @@ static ssize_t iolatency_set_limit(struct kernfs_open_file *of, char *buf,
 		iolatency_clear_scaling(blkg);
 	ret = 0;
 out:
-	blkg_conf_exit(&ctx);
+	blkg_conf_exit_frozen(&ctx, memflags);
 	return ret ?: nbytes;
 }
 
-- 
2.51.0

