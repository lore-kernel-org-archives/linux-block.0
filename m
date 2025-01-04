Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003D1B6CE3
	for <linux-block@vger.kernel.org>; Sat,  4 Jan 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735997162; cv=none; b=Bbwa2gp1Fq+djoaKMrYcrdKMP4EFbwZA45MqEpRxT8zn2ruavtd3iDTq69+TxO4jeRK6LA/tSff8siV1/8InZkQphIqaDdj8BNEbfbhSHocaS3dHRcLqUD6gR0oxVMW2zsXLk3ymfie6uwOxZhv//Y6FiVWxL+1zWXAlVJ2KCuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735997162; c=relaxed/simple;
	bh=2am3FapwRA8t0IL3zu3UkrLfm2C8ws46MF9QDum4EY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPT0gH+mP7fIg0gFZm2u3eF9CCiFrG21qPaPH1WudePn6KoB1BGAuWV2cVgKdLPaJHn+ONgktFgm3zTUWu/pXJH4nr/8zY58+lNLPxUsIqXvqqwKyJmwXR8xMeoBCzshs3fkieH1ksSD2bVchXZdZnjQcsKhYW1OBV3EC/DKkb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ets+EtRs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ets+EtRs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5884C4CEDF;
	Sat,  4 Jan 2025 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735997161;
	bh=2am3FapwRA8t0IL3zu3UkrLfm2C8ws46MF9QDum4EY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ets+EtRsm2yOvtZgSBvtRg44/RkWIIjTwc1QUHKg3FukZWGr5hBbeULLCDiyKvGzj
	 gsePPpSPaHYYgJ5EpCVw++oj2bi844ygJONT4r+UbloUhMaKXGOmW3Ap6KxmLiy09T
	 BFRInbln8ySSDa2eg8FozL/TjJokO/c90u17eueeWGfXCZnsNvpPmzUEFNqk3Dr+Vi
	 cuZDU65qIQuP0XoREtRLc7++Ahe8HTgxQQX/Yb4VX/nGbph6O8Kmt5jjpp7op4GYWS
	 QkUXnf53m9sfXBktIwjpJo16wa59D/PEFB3v2gQ6sD7vk1awUUBdTOjazidEqFIGN8
	 6qdB3ZkCxJC0A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue freeze and limits lock order
Date: Sat,  4 Jan 2025 22:25:21 +0900
Message-ID: <20250104132522.247376-3-dlemoal@kernel.org>
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

__blk_mq_update_nr_hw_queues() freezes a device queues during operation,
which also includes updating the BLK_FEAT_POLL feature flag for the
device queues using queue_limits_start_update() and
queue_limits_commit_update(). This call order thus creates an invalid
ordering of a queue freeze and queue limit locking which can lead to a
deadlock when the device driver must issue commands to probe the device
when revalidating its limits.

Avoid this issue by moving the update of the BLK_FEAT_POLL feature flag
out of the main queue remapping loop to the end of
__blk_mq_update_nr_hw_queues(), after the device queues have been
unfrozen.

Fixes: 8023e144f9d6 ("block: move the poll flag to queue_limits")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-mq.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8ac19d4ae3c0..1f63067790c8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5021,8 +5021,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 fallback:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		struct queue_limits lim;
-
 		blk_mq_realloc_hw_ctxs(set, q);
 
 		if (q->nr_hw_queues != set->nr_hw_queues) {
@@ -5036,13 +5034,6 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 			set->nr_hw_queues = prev_nr_hw_queues;
 			goto fallback;
 		}
-		lim = queue_limits_start_update(q);
-		if (blk_mq_can_poll(set))
-			lim.features |= BLK_FEAT_POLL;
-		else
-			lim.features &= ~BLK_FEAT_POLL;
-		if (queue_limits_commit_update(q, &lim) < 0)
-			pr_warn("updating the poll flag failed\n");
 		blk_mq_map_swqueue(q);
 	}
 
@@ -5059,6 +5050,22 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		struct queue_limits lim;
+		int ret;
+
+		lim = queue_limits_start_update(q);
+		if (blk_mq_can_poll(set))
+			lim.features |= BLK_FEAT_POLL;
+		else
+			lim.features &= ~BLK_FEAT_POLL;
+		blk_mq_freeze_queue(q);
+		ret = queue_limits_commit_update(q, &lim);
+		blk_mq_unfreeze_queue(q);
+		if (ret < 0)
+			pr_warn("updating the poll flag failed\n");
+	}
+
 	/* Free the excess tags when nr_hw_queues shrink. */
 	for (i = set->nr_hw_queues; i < prev_nr_hw_queues; i++)
 		__blk_mq_free_map_and_rqs(set, i);
-- 
2.47.1

