Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE0346E71
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495112; cv=none; b=ll2/ZDfPQusZnkufiFur/RXLVriQqco5jINoch3ueotDzAzBqbVmfg+67xmyg2eHXJ3e8X/kTAx/I31riGVCXeAnFNc9XFGTmCNomeiwfUwtgWZ3ybYVEcC+fqmcngVObbBD9O/qEcRstI8p/YDRweffIgoHcpdbd1KpRlk96Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495112; c=relaxed/simple;
	bh=rhAh8Qt6BcEMTM98R8MnFkUNtJyn1YPkVEfNxMDnwP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uoUSvV4lpC9hyMNV/ye1/GBO5Evc/TOTz/yhS6vVrMesI9v6q5natWCTXc80rjOUrXLXywGihGo4AyY6sZLz2F0rrcE22DLa5rAQrmyyddLRcfHehdsOc76GJk575iASU1jrfYa5l8de3VRTKZdg4BgtiWDq1IXUNpia1fWDSYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1089C116D0;
	Thu, 15 Jan 2026 16:38:29 +0000 (UTC)
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
Subject: [PATCH 1/6] blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with blkcg_mutex
Date: Fri, 16 Jan 2026 00:38:13 +0800
Message-ID: <20260115163818.162968-2-yukuai@fnnas.com>
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

blkg_destroy_all() iterates q->blkg_list without holding blkcg_mutex,
which can race with blkg_free_workfn() that removes blkgs from the list
while holding blkcg_mutex.

Add blkcg_mutex protection around the q->blkg_list iteration to prevent
potential list corruption or use-after-free issues.

Signed-off-by: Yu Kuai <yukuai@fnnas.com>
---
 block/blk-cgroup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 3cffb68ba5d8..0bc7b19399b6 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -574,6 +574,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 	int i;
 
 restart:
+	mutex_lock(&q->blkcg_mutex);
 	spin_lock_irq(&q->queue_lock);
 	list_for_each_entry(blkg, &q->blkg_list, q_node) {
 		struct blkcg *blkcg = blkg->blkcg;
@@ -592,6 +593,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 		if (!(--count)) {
 			count = BLKG_DESTROY_BATCH_SIZE;
 			spin_unlock_irq(&q->queue_lock);
+			mutex_unlock(&q->blkcg_mutex);
 			cond_resched();
 			goto restart;
 		}
@@ -611,6 +613,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
+	mutex_unlock(&q->blkcg_mutex);
 }
 
 static void blkg_iostat_set(struct blkg_iostat *dst, struct blkg_iostat *src)
-- 
2.51.0

