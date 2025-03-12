Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AB156F3C
	for <linux-block@vger.kernel.org>; Wed, 12 Mar 2025 08:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741769281; cv=none; b=mI4dCaVp3z+OzJsGgf2PP6G3lxK+qzALKGJjg8Za5j0n/LJH3Q7/EJ6trel8LDreqUxX63sPvePuWt9H5Nc7wiGc9RxewqJctl1Ci2FA71H7aV5TxT1nSXvaREL0dJHiCwDewzV5jE1Fg5L/yKl7cFCesXnG+2ynFhWKNvbyWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741769281; c=relaxed/simple;
	bh=Ypq9r9kFuJdNbNBpH6m7knjb5ptBHdwrK1lPPQC1usE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jw9wSIOQeiNrbBbEjTnnKVKuaLpVMoMPEQtOpDzW/DYSup5CN3adKWh+RK3lt/HUqFlEOeMkWjMTNaf5e/gzgP0Ix3joB/zG14wUGJ+rLJHo9RMdfPI5YPcohacYhkAvZeh1LiUztt/7w+b/oFf9fR+iMn7ffOmw0awUrVvPZmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TSWanY8A; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TSWanY8A"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741769269; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OvoAhV+yIscRPngG1ebngSPzoxXDEOhBNldb9QXVSFY=;
	b=TSWanY8Aep4y1+oq6jyX8y8wqpCYDUNy6MJmJfwEDfQrMgihmsmSWgLG7dmpM7Zoutj/aZ2YYICRMEGlYuHkiXnFzsQOmcbgZ4ohF7/0DD092ggWOR7/EuPVu9t1lJQKwSdbDOuIpTGezDeKIehzhpcdkyPtBUUPuIgBDfXiDbk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WRC4IfO_1741769263 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 16:47:49 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove useless req addr print in debugfs
Date: Wed, 12 Mar 2025 16:47:43 +0800
Message-ID: <20250312084743.130021-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using %p to print kernel address will only print a hashed address
which is not the real address, this is useless for issue
identification, simply remove it.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index adf5f0697b6b..b4da95150d8d 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -265,7 +265,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
 	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
 
-	seq_printf(m, "%p {.op=", rq);
+	seq_printf(m, "{.op=");
 	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%u", op);
 	else
-- 
2.43.0

