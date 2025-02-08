Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F388F154C12
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 03:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738986755; cv=none; b=GfQ3l/macrtZhW/L5TERzOo0OKl55tXaNsrGPF8FR+PKgX/u0w8wtusGPG9BdkiIcHJpfEfxwn/Jbu+zibPI+6+udlyn1jk7L+6NJDtQOGbefvy9HH81Et1I1ys8eQ+iETzF8GFFEv2oPCcdqn84eiMX5hmP4UpYkFg22Sji3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738986755; c=relaxed/simple;
	bh=SORSH/ImDYoh+TAweGyN2HwoBB0Xh2PsjahK0zneKLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBXPd7E0INDmWIl2ycCNbqRyI9luj10hyYEZQ58wm8zWrmY9bYCO5zgEL+LbpVXwMwBiPVkc8JlHOaCvEPehvxRvxdqS2gW9IBjkWx7+VH7/bRgQG4s1bgRPUffvh97/KUKWt5LY0IFYoEI+TF8o+P4jXwgqRdziB1FsVwhzo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NQygxrHx; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NQygxrHx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738986748; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mKYOap0+iYJeaXGCzqIQIdF7eSQ07QFtiOe4d+pzOtA=;
	b=NQygxrHx/Z9uhJGwXle3WeKh/JpLAq7YixzugpPCkaIezRA3txWveUdG2Lka06iKXmDQfkytZY+xOAuWazb1dCtIv0hyTEKw3rRdmORBSaOOmzfnZk7i115fm7FUyAP+aWzV0a8ZfnV+nYRbw/7gy/OalbrR0+KwHuDvsGXnTRk=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WP.DuC6_1738986744 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 08 Feb 2025 11:52:28 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH RFC] block: print the real address of request in debugfs
Date: Sat,  8 Feb 2025 11:52:24 +0800
Message-ID: <20250208035224.128454-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since only root user can access debugfs, for easier issue
identification, use '%px' to print the request's real address in
debugfs.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Hi,
  I notice that block dont print the real address in
debugfs for a long time, I wonder what the community's
concerns are, thanks, so this is a RFC patch.
Best Regards,
Guixin Liu

 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index adf5f0697b6b..c430d931512f 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -265,7 +265,7 @@ int __blk_mq_debugfs_rq_show(struct seq_file *m, struct request *rq)
 	BUILD_BUG_ON(ARRAY_SIZE(cmd_flag_name) != __REQ_NR_BITS);
 	BUILD_BUG_ON(ARRAY_SIZE(rqf_name) != __RQF_BITS);
 
-	seq_printf(m, "%p {.op=", rq);
+	seq_printf(m, "%px {.op=", rq);
 	if (strcmp(op_str, "UNKNOWN") == 0)
 		seq_printf(m, "%u", op);
 	else
-- 
2.43.0

