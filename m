Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723341B0430
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735997163; cv=none; b=BWVwvwIzJ0sZfKnXi3VBvOPyE03vQEKjlW0zioCLdJ0DL2ZhkX9QBZDDjkrR7YBGkscR4UJgR0ujSuUtkE99ngwgciBQFGquKpIx/53juUmICDo8op19U1I1sEbVodnBt5WcOgxwWrT6NMFms8v85j8NyaiqNNJE8T7PW4pdDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735997163; c=relaxed/simple;
	bh=COVE0bvwII+G60ByWk+rzuxwByQi7P/2T3NJasfjEeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PgUG5bumXxJ1rVLNDpkZcDbIFE4+64OoKB227shO1VCVecg/Nmnl3dFWQ4sp8YtdrLSd+tpLd31f62G/cIhkqGtRKE7oehNtoVpZa+K/BNrDWJoUqGnMF8bsXD6ApdF67dpa1R/yO4AFBbmalToMLuSB3raviFAPi6M3U2RTSkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7YAIA0y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7YAIA0y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058DBC4CED1;
	Sat,  4 Jan 2025 13:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997163;
	bh=COVE0bvwII+G60ByWk+rzuxwByQi7P/2T3NJasfjEeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7YAIA0yjkNnWkkNU5CJThD0r/hOGucsvMxakh/NbL2tf7+2fhE6wXGm9bt4ISPJR
	 nwwH+7AoFGdLr//bXhUkf7Bz7Xqshzh3oEmFu78I6dCFxtO/TqzJ/gBrJA/1YiN0Xf
	 qChanWG2U73ONHEKYEbFhxhu2VFQBFnlSvQU69dTdnFmJC6jQqqDI4FKB11fRXOzC2
	 RcewRngEPM7BoRliPwgIWnbj5R1Kq/MtivgFWZ3tekVKFZoCmjLAmVEHhoDrD/UpBh
	 6S+kWywgZ62duvbsNYe73TpFp7DfftjcKhgVXEqDv+YAmQuy2BxeVgMsAWJYPq0w/n
	 uw+O88tgm2gew==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 3/3] nvme: Fix queue freeze and limits lock order
Date: Sat,  4 Jan 2025 22:25:22 +0900
Message-ID: <20250104132522.247376-4-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104132522.247376-1-dlemoal@kernel.org>
References: <20250104132522.247376-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify the functions nvme_update_ns_info_generic(),
nvme_update_ns_info_block() and nvme_update_ns_info() to freeze a
namespace queue using blk_mq_freeze_queue() after starting the queue
limits update with queue_limits_start_update() so that the queue
freezing is always done after obtaining the device queue limits lock (as
per the block layer convention for sysfs attributes).

Fixes: e6c9b130d681 ("nvme: use the atomic queue limits update API")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/nvme/host/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a970168a3014..8d4ae36c35fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2128,8 +2128,8 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	struct queue_limits lim;
 	int ret;
 
-	blk_mq_freeze_queue(ns->disk->queue);
 	lim = queue_limits_start_update(ns->disk->queue);
+	blk_mq_freeze_queue(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	ret = queue_limits_commit_update(ns->disk->queue, &lim);
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
@@ -2177,12 +2177,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out;
 	}
 
+	lim = queue_limits_start_update(ns->disk->queue);
+
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	ns->head->nuse = le64_to_cpu(id->nuse);
 	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
 
-	lim = queue_limits_start_update(ns->disk->queue);
 	nvme_set_ctrl_limits(ns->ctrl, &lim);
 	nvme_configure_metadata(ns->ctrl, ns->head, id, nvm, info);
 	nvme_set_chunk_sectors(ns, id, &lim);
@@ -2285,6 +2286,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		struct queue_limits *ns_lim = &ns->disk->queue->limits;
 		struct queue_limits lim;
 
+		lim = queue_limits_start_update(ns->head->disk->queue);
+
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		/*
 		 * queue_limits mixes values that are the hardware limitations
@@ -2301,7 +2304,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		 * the splitting limits in to make sure we still obey possibly
 		 * lower limitations of other controllers.
 		 */
-		lim = queue_limits_start_update(ns->head->disk->queue);
 		lim.logical_block_size = ns_lim->logical_block_size;
 		lim.physical_block_size = ns_lim->physical_block_size;
 		lim.io_min = ns_lim->io_min;
-- 
2.47.1

