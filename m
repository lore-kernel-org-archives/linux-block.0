Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19724887E;
	Mon,  9 Feb 2026 08:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625815; cv=none; b=c5r/n+hNbWj2FIfamCYLl2IA9Eq7kZ6HJDnSmP1fK055EM4/TZXJtaK2JiTEiiywoSZLT05XxdVnuRn0VhB/ercv2deVGYN+JAe2yYA18uPQBWOatyHwiRZsnxtY/W0B+McqmdeEWV2X7+5n4KcaLtIizmCyHpl1C/gcgKUXLj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625815; c=relaxed/simple;
	bh=sXFRIJREhuh7cCFtvF+hsw0v8CGsjZ9tD0CEzZccQVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O18UsyGiPv7dagPjX2Iw8wspZ1qO9P8+BXKxNXBzulmhxKMyzwro4Yp5OmhcyIFIzLXvd3yltIEUtWL7q/IXkqn9Kfy+tWWgWKW1TqFdWFxo3GBEFeLQm73tv77RlqAO5ONjaeWRaGmszx9Ucsi99OE98VswuRgHNmdGAys2aww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4E9C2BCB1;
	Mon,  9 Feb 2026 08:30:11 +0000 (UTC)
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
Subject: [PATCH 4/4] blk-mq: use blk_queue_enter/exit to protect debugfs file creation
Date: Mon,  9 Feb 2026 16:29:53 +0800
Message-ID: <20260209082953.3053721-5-yukuai@fnnas.com>
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

Replace the freeze depth check with blk_queue_enter()/blk_queue_exit()
which properly waits for the queue to be unfrozen and prevents new
freezes while creating debugfs files. This provides correct
synchronization without false warnings.

If the queue is dying (blk_queue_enter returns error), skip creating
the debugfs files as the queue is being torn down anyway.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/aYWQR7CtYdk3K39g@shinmob/
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-mq-debugfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index faeaa1fc86a7..03583d0d3972 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -613,11 +613,6 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 				 const struct blk_mq_debugfs_attr *attr)
 {
 	lockdep_assert_held(&q->debugfs_mutex);
-	/*
-	 * Creating new debugfs entries with queue freezed has the risk of
-	 * deadlock.
-	 */
-	WARN_ON_ONCE(q->mq_freeze_depth != 0);
 	/*
 	 * debugfs_mutex should not be nested under other locks that can be
 	 * grabbed while queue is frozen.
@@ -628,9 +623,19 @@ static void debugfs_create_files(struct request_queue *q, struct dentry *parent,
 	if (IS_ERR_OR_NULL(parent))
 		return;
 
+	/*
+	 * Avoid creating debugfs files while the queue is frozen, wait for
+	 * the queue to be unfrozen and prevent new freeze while creating
+	 * debugfs files.
+	 */
+	if (blk_queue_enter(q, 0))
+		return;
+
 	for (; attr->name; attr++)
 		debugfs_create_file_aux(attr->name, attr->mode, parent,
 				    (void *)attr, data, &blk_mq_debugfs_fops);
+
+	blk_queue_exit(q);
 }
 
 void blk_mq_debugfs_register(struct request_queue *q)
-- 
2.51.0

