Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAD2E266C;
	Mon,  2 Feb 2026 08:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770019543; cv=none; b=VxhW7W7TdL7AT0mNsI/85V9XCnC3I3K/UxCjmt+WPfGQ7d+xs4NRAC6RYSbZzP5Z/qkAi6CmaW5j+PhcDAuvlRXL5WFRPkRUi6CEEl9n28XEWCJV47AVu3ctUAYvy0PGt1+B9gk1STys3o+Lj8yqjtxkTTdt5q09L5zYnZ1Mj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770019543; c=relaxed/simple;
	bh=dIyfkG4jYJUUKVfMapTtdGMGgtz+ZeVnkS58TLNdc7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i572kmEDenoZN18XJzT7s4GeHuRSOn8pCzWv18MDSefne3uibsiWHRmXYyPbEkC7Re9hNqc38f5xlcbs97r50FjfLF7yKRFUp2HthYKjLimmxDRhx4QeZN4Ajcta99ZTYcjclamFR7gY06Mme7lt0BRV9Xd7U5Iu1MaWpyJqNX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37545C116D0;
	Mon,  2 Feb 2026 08:05:41 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Hannes Reinecke <hare@suse.de>,
	yukuai@fnnas.com
Subject: [PATCH v9 7/8] blk-mq-debugfs: add missing debugfs_mutex in blk_mq_debugfs_register_hctxs()
Date: Mon,  2 Feb 2026 16:05:22 +0800
Message-ID: <20260202080523.3947504-8-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202080523.3947504-1-yukuai@fnnas.com>
References: <20260202080523.3947504-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In blk_mq_update_nr_hw_queues(), debugfs_mutex is not held while
creating debugfs entries for hctxs. Hence add debugfs_mutex there,
it's safe because queue is not frozen.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/blk-mq-debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 22c182b40bc3..5c7cadf51a88 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -679,8 +679,10 @@ void blk_mq_debugfs_register_hctxs(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
+	mutex_lock(&q->debugfs_mutex);
 	queue_for_each_hw_ctx(q, hctx, i)
 		blk_mq_debugfs_register_hctx(q, hctx);
+	mutex_unlock(&q->debugfs_mutex);
 }
 
 void blk_mq_debugfs_unregister_hctxs(struct request_queue *q)
-- 
2.51.0

