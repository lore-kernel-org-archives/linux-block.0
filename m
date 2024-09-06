Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A45288D1;
	Fri,  6 Sep 2024 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725592484; cv=none; b=aCxYfZAv7qyTclO5Gi+6+jWxabn/AVZYMIoKyC00Yx1t+grKYo47XGvDjK2ikpgIkRo5VNoa4bd/VEQ8V2IBziMJLAop6Y1Px54t2AvYDli762K5oGhzY6UrFl+RYRB/iybl79TChtR5F7bT84BPPzpAxEbJsqouX1UjCyOeB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725592484; c=relaxed/simple;
	bh=QBvDdVuFMOspk3RqPLm+psR5nYvokT0D947cBogvxHg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sg5zFLHaGF6Jam0fBAYFV+ndKeTbjD2M/4ere7kZ9c8CpwXdhN/P3dAEaymxfj5f4Ok9+63ifls24z5/KpJcoGXq5OgRKGTEsU7fO8dy35vikcBnQlTxUwDsv9iepDJU4i1az3QOG6aoPx27urcnkSICvdo3X/PBG2EDxPB0EcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: PSsKz5G3QrqvcsLJGReCaQ==
X-CSE-MsgGUID: /yItTc/AQTqWd9CXJbBtSQ==
X-IronPort-AV: E=Sophos;i="6.10,206,1719849600"; 
   d="scan'208";a="121273283"
From: ZhangHui <zhanghui31@xiaomi.com>
To: <axboe@kernel.dk>, <bvanassche@acm.org>, <ming.lei@redhat.com>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanghui31@xiaomi.com>
Subject: [PATCH v4] block: move non sync requests complete flow to softirq
Date: Fri, 6 Sep 2024 11:14:31 +0800
Message-ID: <20240906031431.366806-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX05.mioffice.cn (10.237.8.125) To YZ-MBX07.mioffice.cn
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
cause the execution time of the top-half to be greater than 100ms,
which will undoubtedly affect interrupt response latency.

Let's fixed this issue by moved non sync request completion flow to
softirq, and keep the sync request completion in the top-half.

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
Changes in v4:
- fix commit log from "scheduling efficiency" to "interrupt response latency"

Changes in v3:
- modify op_is_sync to rq_is_sync

Changes in v2:
- fix build warning
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

