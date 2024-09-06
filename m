Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B181C8FB1;
	Fri,  6 Sep 2024 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725616469; cv=none; b=TuNPU4ku4o2zmKijXur2RmiCw9tf0y/G0Zz80/wnIrw0UDmpJ99U/n7mtkFDsyL+YzdYIAu87La46OjZnOFP/VETuuyCEXVv+sBzOnzeDuXSBzduAu/RmWUIlItpffk6HcZfpiVYLDLTIzLbHeKqQ5RLIVOf9CMUMMH0yy0/+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725616469; c=relaxed/simple;
	bh=LhLOIknncOR8nUXzZVU6X5nmS6RSB0q0J8kz29/WyQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qCYtbC9CJwZoZcZfZ2lcueh7mo1yq+AJK9lvvdrBO98n7IS2S04u0gWn4iCrtKdKVYhE1cFoxA8bZ/GMLJF35B4JSr72/kL4kns8o+9nw6crXnRq8nKFSzyheXXzScDKx6sb+2MhehhS472QRcL62VgJSShI4j6/o4kXUKlNdx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: A++tOMZaQyqvWvmqSK8N9Q==
X-CSE-MsgGUID: 8MqO5s3/QCGwNUwcO5XlIw==
X-IronPort-AV: E=Sophos;i="6.10,207,1719849600"; 
   d="scan'208";a="121317229"
From: ZhangHui <zhanghui31@xiaomi.com>
To: <axboe@kernel.dk>, <bvanassche@acm.org>, <ming.lei@redhat.com>,
	<dlemoal@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanghui31@xiaomi.com>
Subject: [PATCH v5] block: move non sync requests complete flow to softirq
Date: Fri, 6 Sep 2024 17:54:14 +0800
Message-ID: <20240906095414.386388-1-zhanghui31@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX13.mioffice.cn (10.237.8.133) To YZ-MBX07.mioffice.cn
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

Let's fix this issue by moving non sync requests completion to softirq
context, and keeping sync requests completion in the IRQ top-half context.

Signed-off-by: zhanghui <zhanghui31@xiaomi.com>
---
Changes in v5:
- modify the commit log
- remove unnecessary variable and add comment

Changes in v4:
- fix commit log from "scheduling efficiency" to "interrupt response latency"

Changes in v3:
- modify op_is_sync to rq_is_sync

Changes in v2:
- fix build warning
---
 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c21b55..45e4d255ea3b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1210,7 +1210,11 @@ bool blk_mq_complete_request_remote(struct request *rq)
 		return true;
 	}
 
-	if (rq->q->nr_hw_queues == 1) {
+	/*
+	 * To reduce the execution time in the IRQ top-half,
+	 * move non-sync request completions to softirq context.
+	 */
+	if ((rq->q->nr_hw_queues == 1) || !rq_is_sync(rq)) {
 		blk_mq_raise_softirq(rq);
 		return true;
 	}
-- 
2.43.0

