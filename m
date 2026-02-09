Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D0325B662;
	Mon,  9 Feb 2026 08:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625807; cv=none; b=NWASyd1u21byOnJ9jVBsIuhnuXi9zSE02AIXoi+WgO+46LO2Z97/YTX4+6stwT1fCBBVzz1n6LPnZT6qqvtykB5tY0LTGeDohjE3HKcY7UjDlzXFlZ7/ZNebxAIhiJPaKVH0i5al61c/EsxsPqDNoii7YsJJkw2hpFYhJzmh/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625807; c=relaxed/simple;
	bh=Z8XY86SbilQF3jFqmqDdH6b7NvL72k5A+I8GMGnjMMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CLkuODp/v4+7CUfE7QjJA8aEkBK5WiyyCtyV0ih1KklPg3Z6nxvfaXX9a/34dvGqXcwDmYzYL5w7jW1EomhWSAgbT1/njQ+XCTRIuDeWS9gjsgAM8ZAXv+mFE2KqR5LnTa578bBOIPn+UpxdOso10PgzmruRjo4HUh21suEF2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B28C19422;
	Mon,  9 Feb 2026 08:30:03 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	sven@kernel.org,
	j@jannau.net,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	yukuai@fnnas.com
Subject: [PATCH 2/4] nvme-tcp: move blk_mq_update_nr_hw_queues after nvme_unfreeze
Date: Mon,  9 Feb 2026 16:29:51 +0800
Message-ID: <20260209082953.3053721-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209082953.3053721-1-yukuai@fnnas.com>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
When the queue is already frozen before this call, the freeze depth
becomes 2. The internal unfreeze only decrements it to 1, leaving the
queue still frozen when debugfs_create_files() is called.

This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
debugfs_create_files() and risks deadlock.

Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
so the queue is unfrozen before the call, allowing the internal
freeze/unfreeze to work correctly.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/all/CAHj4cs9gNKEYAPagD9JADfO5UH+OiCr4P7OO2wjpfOYeM-RV=A@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..daa02afbc9f5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2203,9 +2203,9 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 			nvme_unfreeze(ctrl);
 			goto out_wait_freeze_timed_out;
 		}
+		nvme_unfreeze(ctrl);
 		blk_mq_update_nr_hw_queues(ctrl->tagset,
 			ctrl->queue_count - 1);
-		nvme_unfreeze(ctrl);
 	}
 
 	/*
-- 
2.51.0

