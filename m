Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375C0231858
	for <linux-block@vger.kernel.org>; Sun, 16 Nov 2025 02:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763260925; cv=none; b=kOMi+Ay7ztBNaK8lSioe/XGgdlnjjn70OkeHwgCZtaxo3MIU9Q2A+FurGZUFr0LKYcqOBfWFmXInCk0PlUH/bWU9hmwvVXPeT3J2YwUHtG3UeAkRLM82HC/ElsKmHeLR8AXrPbcs4C+O5deSZc261Cl1S4nDQTGKSD5JCoK0+VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763260925; c=relaxed/simple;
	bh=7C1jdElV3z6qjeQHdb4I32t7OCyHyKk5pj58qZW9db8=;
	h=Content-Type:Date:To:Mime-Version:From:Subject:Cc:Message-Id; b=tIU1+tf51EAlGLSjvCcTIX1jJiQPT9biawxqcPb553sMt4iwUovyWpqR0u0Q1bf0K8F5n6OT8rYwA48kQYbFPtgu9U3axBp8Rnp3o4LiW5erAm/ElrbXF1Sy0utWTcBmik0YEKUxmq0Rk1z5REjrxHDworKLB0ppsUbVOUFgFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=ohwaXKJ1; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="ohwaXKJ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763260916;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=rt2lBTrJ6XZaPIw3g5bw9uo9R7KiJyGtcK/9C0d6GXE=;
 b=ohwaXKJ14DzRmiKfwUJ5SGFWs2IanD5rOGiaXO1E4NeNlPIRStv27Dop72Z2iIRJcBuRYe
 7PlP8bxgtzGjOCodQxDqQ7JIOI9Gl7UlyKaEjWsT8KIdcNbsnaChjcGnt88EcOwRoT90Xg
 7vFDGEPBAGoS6OQG8Rm4hIddcBSQXJv3wLenxgA2U8koGNKHWHiOtpuDzFXBLQqJI1akii
 NJ0ueFQpRRSwHbhz2eHjuql5fCtQzSB1NTKj0hR3WdID3MdU2Sg+DXPOdWWU/5A9+mQ56O
 cNhwzhFbO/ALN1ee5qobMyQ4P12kt7QWj8BCC+Wyp1dmmQmKI23CJ7WKlWmZNg==
Content-Type: text/plain; charset=UTF-8
Date: Sun, 16 Nov 2025 10:41:33 +0800
X-Lms-Return-Path: <lba+2691939f2+73f8b6+vger.kernel.org+yukuai@fnnas.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <tj@kernel.org>, <nilay@linux.ibm.com>, 
	<ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0
X-Original-From: Yu Kuai <yukuai@fnnas.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: [PATCH 4/5] blk-iolatency: fix incorrect lock order for rq_qos_mutex and freeze queue
Received: from localhost.localdomain ([39.182.0.135]) by smtp.feishu.cn with ESMTPS; Sun, 16 Nov 2025 10:41:53 +0800
Content-Transfer-Encoding: 7bit
Cc: <yukuai@fnnas.com>
Message-Id: <20251116024134.115685-5-yukuai@fnnas.com>

Currently blk-iolatency will hold rq_qos_mutex first and then call
rq_qos_add() to freeze queue.

Fix this problem by converting to use blkg_conf_open_bdev_frozen()
from iolatency_set_limit(), and convert to use rq_qos_add_freezed().

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-iolatency.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 45bd18f68541..1565352b176d 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -764,8 +764,8 @@ static int blk_iolatency_init(struct gendisk *disk)
 	if (!blkiolat)
 		return -ENOMEM;
 
-	ret = rq_qos_add(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
-			 &blkcg_iolatency_ops);
+	ret = rq_qos_add_freezed(&blkiolat->rqos, disk, RQ_QOS_LATENCY,
+				 &blkcg_iolatency_ops);
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
