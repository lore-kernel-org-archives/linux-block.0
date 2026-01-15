Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2437A235063
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495118; cv=none; b=prrus3YjZJtANm2Hyke0gCVvyYsSXcnPz+HUIIuxbtfHt8SgjQBO2ZDJtKqQBQyivOQeXHWaFx+uD0oqh0TJGlG1XHmp2wOC3BrahQTVaiIJCrCmKgw9vumG4AEiG6QLeu2FGYL3A4kEqIBZxaBm8vmkWE1P0kj52miPXFb+w7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495118; c=relaxed/simple;
	bh=6kR6IasYu2sBdvPKjsHORRqg6ilhuvQxTVVjKLiiMfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lSPj9mcfchCHdINtB2Fccm/BfhvLp5EBMSdz9r+yPHEcNDu0QlqQZsmkEV0NhbbvYpcYbEhQgaEA07i0JhyMjvtO/r7qQzXfQswk4tyH5nAqLR0xMv1tKqAh1ueRRp6CdoI70jGaWlg7lecyqi6+n+lLF3/FTP8Sw+spgQwy0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BFDC116D0;
	Thu, 15 Jan 2026 16:38:32 +0000 (UTC)
From: Yu Kuai <yukuai@fnnas.com>
To: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	tj@kernel.org,
	nilay@linux.ibm.com,
	ming.lei@redhat.com
Cc: yukuai@fnnas.com,
	zhengqixing@huawei.com,
	mkoutny@suse.com,
	hch@infradead.org
Subject: [PATCH 2/6] bfq: protect q->blkg_list iteration in bfq_end_wr_async() with blkcg_mutex
Date: Fri, 16 Jan 2026 00:38:14 +0800
Message-ID: <20260115163818.162968-3-yukuai@fnnas.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260115163818.162968-1-yukuai@fnnas.com>
References: <20260115163818.162968-1-yukuai@fnnas.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bfq_end_wr_async() iterates q->blkg_list while only holding bfqd->lock,
but not blkcg_mutex. This can race with blkg_free_workfn() that removes
blkgs from the list while holding blkcg_mutex.

Add blkcg_mutex protection in bfq_end_wr() before taking bfqd->lock to
ensure proper synchronization when iterating q->blkg_list.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/bfq-cgroup.c  | 3 ++-
 block/bfq-iosched.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 9fb9f3533150..4d8e331e5a98 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -940,7 +940,8 @@ void bfq_end_wr_async(struct bfq_data *bfqd)
 	list_for_each_entry(blkg, &bfqd->queue->blkg_list, q_node) {
 		struct bfq_group *bfqg = blkg_to_bfqg(blkg);
 
-		bfq_end_wr_async_queues(bfqd, bfqg);
+		if (bfqg)
+			bfq_end_wr_async_queues(bfqd, bfqg);
 	}
 	bfq_end_wr_async_queues(bfqd, bfqd->root_group);
 }
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6e54b1d3d8bc..316071e87679 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2645,6 +2645,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	struct bfq_queue *bfqq;
 	int i;
 
+	mutex_lock(&bfqd->queue->blkcg_mutex);
 	spin_lock_irq(&bfqd->lock);
 
 	for (i = 0; i < bfqd->num_actuators; i++) {
@@ -2656,6 +2657,7 @@ static void bfq_end_wr(struct bfq_data *bfqd)
 	bfq_end_wr_async(bfqd);
 
 	spin_unlock_irq(&bfqd->lock);
+	mutex_unlock(&bfqd->queue->blkcg_mutex);
 }
 
 static sector_t bfq_io_struct_pos(void *io_struct, bool request)
-- 
2.51.0

