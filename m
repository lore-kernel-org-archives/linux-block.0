Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795503885;
	b=zucF5TncOVW9ITnv+laMwnYkEbsiDAIjcqWKlfGXsPCh5cRhEiWOjXMSzLO63EoJkb1o
	 +Pe43/vv03fkI99+NUShdSX9pnz8wkVtmuP2jvHd3yYf+ptEZK23RfZGIC51GUOjVhnge
	 XzO8dfLln9E1kmgDLY50oOOW/25jxBTz5EJE1O0ungOQUXcaVGt+E6gD7GJ3lAd9QqlWT
	 XOOIkvrtx84cEMGE+QUhMOvkgEq8TDjU1Y5XRvl+BRWWeMA9mMUPXAGoBfzW5Z142YFcU
	 q68QBCPo2XuduwGLxHG2VKI3zjClmN3NtgLriVNiuqGu+j0B7vbLPA1vniINgKs/cHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795503885;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=FneVd9HPGe76BAHC2HiE5FOgWfmPkq08EI5hUr/7QcM=;
	b=SBIzOevDIHItQyVYagRe7UGAIQtjXdY3AkqpK1JcS+ay5xISIfeM1wA3uGPzoL32eFb3
	 gKvmlRkM3jfFyuEdrTWr+19s6zP+qkckX4vVPCyUgcAoXqbVui9R/AEFalb3rXsABG1Ki
	 D1JFE84k0Fyk6MHuepWhSxAvcg35ofhimcB1FXvhpzIUNXpdnDbsJybQlXAvrNfGqRKDF
	 AJc+O1SlwEkN/RlkFmiRaSfyYs40XpIiw0FG/yqMgaVU+zIHz4qEFKYIDFNJGJareQEqL
	 HDwwzVl4TGZQ3ZaYHFK+9nZ5bfUASet3ivXHkqcg8PdrAE+x5CyrtdtdeZsI2ktrO4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oA8enXEt;
	arc=none smtp.remote-ip=91.218.175.89
Received: from mta0.migadu.com (out-89.mta0.migadu.com [91.218.175.89])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA8606A31E
	for <linux-block@vger.kernel.org>; Tue, 24 Nov 2026 07:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21FA8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oA8enXEt
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=t6YXwSAmDQJPc54iy/hwJ1j907khbXZPfCf6hQ4kUnk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795503882; v=1; x=1796108682;
 b=oA8enXEtkTj7MUn/q5LsPNvMAvKbSMkpUmsNtXUrVujkWNLlwDmGTcVn1xBuMGRKFs8ZSCXY
 7ReFWj9+QtxbFjnBzDiXzjExazk3gthQIEELr9hdnqqE5j9TY6A3DMwany+pCxEBR+6oaQzOWqA
 aECq4Rr358pTXbyW8y/MQ5Gc=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 10f512a1bc9c2d9b;
	Tue, 24 Nov 2026 07:04:42 +0000
X-Mizu-Trace-ID: 10f512a1bc9c2d9b
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Tue, 24 Nov 2026 02:04:34 -0500
Subject: [PATCH v2] block: don't wait for all RCU callbacks when freeing
 zone write plugs
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev>
X-B4-Tracking: v=1; b=H4sIAAE3BWsC/33NQQ6CMBCF4auQWTuGVijqynsYFi0MMtEUM4UGJ
 dzdSuLW5f8W31sgkDAFOGcLCEUOPPgUepdB01t/I+Q2NehcG6V0jh3ZEd3jju/BU4vSTOisJEO
 wcae8KMhU1h0gAU+hjucNv9apew7jIK/tK6rv+mPVPzYqVFgZc6xKV+rS0eXBfpr3LUWo13X9A
 IhCwdnEAAAA
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

Zone write plugs are allocated from a per-disk mempool and freed with
call_rcu(). Before destroying the mempool, which happens every time a
zoned disk is released, disk_destroy_zone_wplugs_hash_table() calls
rcu_barrier() so that no zone write plug is still waiting to be returned
to it.

rcu_barrier() waits for the RCU callbacks queued on every CPU by anyone,
which usually takes a grace period or more, even when the disk had no
zone write plug left to free. Removing many zoned disks, such as the SMR
drives of a storage node taken offline, pays this once per disk.

Count the zone write plugs of the disk that wait for their RCU callback,
and wait only for that count to drop to zero.

Removing 32 zoned null_blk or scsi_debug devices, base and patched
kernels alternating over 2 rounds of 3 runs, median of the 6 runs and
range in parentheses; "with plugs" leaves four partially written zones,
and so four zone write plugs, on each null_blk device:

  devices                      before (ms)      after (ms)   change
  null_blk                   820 (805-885)   438 (424-454)     -47%
  null_blk, with plugs       876 (852-883)   844 (805-877)      -4%
  scsi_debug, host-managed   958 (945-991)   642 (630-652)     -33%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
V1 -> V2:
- Keep the original comment above the wait (Damien Le Moal)
- Add Reviewed-by (Damien Le Moal)

v1: https://lore.kernel.org/r/20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev
---
 block/blk-zoned.c      | 10 ++++++++--
 include/linux/blkdev.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4c58892961912..463c93db467b0 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -18,6 +18,7 @@
 #include <linux/mempool.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/wait_bit.h>
 
 #include <trace/events/block.h>
 
@@ -724,8 +725,11 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 {
 	struct blk_zone_wplug *zwplug =
 		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
+	struct gendisk *disk = zwplug->disk;
 
-	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
+	mempool_free(zwplug, disk->zone_wplugs_pool);
+	if (atomic_dec_and_test(&disk->nr_zone_wplugs_freeing))
+		wake_up_var(&disk->nr_zone_wplugs_freeing);
 }
 
 static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
@@ -745,6 +749,7 @@ static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 
+	atomic_inc(&disk->nr_zone_wplugs_freeing);
 	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
 }
 
@@ -2149,7 +2154,8 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	 * Wait for the zone write plugs to be RCU-freed before destroying the
 	 * mempool.
 	 */
-	rcu_barrier();
+	wait_var_event(&disk->nr_zone_wplugs_freeing,
+		       !atomic_read_acquire(&disk->nr_zone_wplugs_freeing));
 	mempool_destroy(disk->zone_wplugs_pool);
 	disk->zone_wplugs_pool = NULL;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 215753171cef0..b3b356f832267 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -204,6 +204,7 @@ struct gendisk {
 	u8 __rcu		*zones_state;
 	unsigned int		zone_wplugs_hash_bits;
 	atomic_t		nr_zone_wplugs;
+	atomic_t		nr_zone_wplugs_freeing;
 	spinlock_t		zone_wplugs_hash_lock;
 	struct mempool		*zone_wplugs_pool;
 	struct hlist_head	*zone_wplugs_hash;

---
base-commit: 5f22fb20497f4983094131f00a734362300d22d2
change-id: 20261120-feat-blk-zoned-rcu-barrier-cb9044e67ab3

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

