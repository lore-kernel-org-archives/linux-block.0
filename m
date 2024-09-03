Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD11619F41F;
	Tue,  3 Sep 2024 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.143.206.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364485; cv=none; b=QEoU/dQ3ZNz/DHSew7e/9tz4+0+SVxsVU4tqO52bvZSVJ0WTlCEavvnIkHBGhVgUjV5NwYaQuNP5eXtCOv2gegRNEeRHWrD/zCwwc6aJ94L48j2i/xCWccVDOzzg9JpnvaliVYJxBaq1aEpwUQwZ3so4JXq8xbUBSaVdou/8B2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364485; c=relaxed/simple;
	bh=CRGA5PPTM23DCJnXshXb/hofycYBMNRXVXaHxSf97zI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yi2sdtAeNKuhYfrgp0hidq+OYpzlzQ2b17vUZkD9B9RmAGseY/vYjmwVcli2OhJVGzaeRxAQrgCS/VzdwQkkH+W1VtalHswRaQlXTu6xgfqZpsHiZNj0tT3K79WWojWND3I+ioyNIctFFBTnJwqUJ4QK+WjRUC/bRLDedJ0RqRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=118.143.206.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: fQnLtxpPT2esNAeAloMwFg==
X-CSE-MsgGUID: 5aoV9IiqToCgFuju6KHxDw==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="95319094"
From: ZhangHui <zhanghui31@xiaomi.com>
To: <axboe@kernel.dk>, <bvanassche@acm.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanghui31@xiaomi.com>
Subject: [PATCH v3] block: move non sync requests complete flow to softirq
Date: Tue, 3 Sep 2024 19:54:37 +0800
Message-ID: <20240903115437.42307-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX15.mioffice.cn (10.237.8.135) To YZ-MBX07.mioffice.cn
 (10.237.88.127)

From: zhanghui <zhanghui31@xiaomi.com>

Currently, for a controller that supports multiple queues, like UFS4.0,
the mq_ops->complete is executed in the interrupt top-half. Therefore, 
the file system's end io is executed during the request completion process,
such as f2fs_write_end_io on smartphone.

However, we found that the execution time of the file system end io
is strongly related to the size of the bio and the processing speed
of the CPU. Because the file system's end io will traverse every page
in bio, this is a very time-consuming operation.

We measured that the 80M bio write operation on the little CPU will
cause the execution time of the top-half to be greater than 100ms.
The CPU tick on a smartphone is only 4ms, which will undoubtedly affect
scheduling efficiency.

Let's fixed this issue by moved non sync request completion flow to
softirq, and keep the sync request completion in the top-half.

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..06b232edff11 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1193,6 +1193,8 @@ static void blk_mq_raise_softirq(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
+	const bool is_sync = rq_is_sync(rq);
+
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 
 	/*
@@ -1210,7 +1212,7 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return true;
 	}
 
-	if (rq->q->nr_hw_queues == 1) {
+	if ((rq->q->nr_hw_queues == 1) || !is_sync) {
 		blk_mq_raise_softirq(rq);
 		return true;
 	}
-- 
2.43.0

