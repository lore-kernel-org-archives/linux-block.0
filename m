Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309059;
	b=XFgUmkDVv5gQixqTr4erEKm3ayAtrtJLwsBuLk/6fv0iEE9PaARodYSDnUC3yUDqL5lj
	 ulS5fYmZKl3IeUxP8TYOSAdjGAdh2XGpYqNsAWrZ+0TjQwbAmX6jjnKYPFqV2jRtA7+zn
	 8Kiy016SZU5g7xDovzidB7QW0f+/U02LKLmB8RKBLnfDJQEkc4Hvt1E8tcejKdWHDzUSX
	 Zj+yciTAa7hVKo1MTwSvL4He1/HIIvnqU+qqkOvyu3NYcAXJgo9JqVfKyNk0NtSnMRsNK
	 Zfl6MRxR0JTunue5ITX/09gNsS1McyhCFqlBEoJ+g3FR6GpmszfbizJfrW8ki5NdrMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309059;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=5qiTfHtMv+niJqz2yTq4s5klVLBj+/MWrZ+Nij26h8E=;
	b=p8tZ8PlMWJtXUM/8YLZcX5ffyiAB+D3bRbEksrkSzEaTpPmkRTMExONOQCZNY5zSnPiu
	 +2aIRkPTn0OUVtV6RTmCG2oA+d0icfRkOl6+GWeJhM8C/nAs3ck7scMxWgJpiHTATC0fy
	 Tj/R6fGtCjBl22ZM3NhUjjxmoG78gX+skOducCZG5pFwTpwHqr2wYVMd9ur15XC7KSABI
	 TdX+/Ymbj3kUPK3aeQT/Y83u+XYLJjKNS6G49xpaaQPmgOxRBv0K5t0Shyg+8kdeplBWc
	 RQzw/sbWTrxbgRPQiHbbq8mqTR/Ju4Ul8aSvrZ9rRpc90xO4TD7OLNako+g1gx2yU4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U7M4woAy;
	arc=none smtp.remote-ip=95.215.58.236
Received: from mta1.migadu.com (out-236.mta1.migadu.com [95.215.58.236])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F551606A320
	for <linux-block@vger.kernel.org>; Sun, 22 Nov 2026 00:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F551606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=U7M4woAy
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gyLcTDWPGgSTZ7tu9njnU1tg90rupxsnyNpI+2dNF/o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795309056; v=1; x=1795913856;
 b=U7M4woAykQ8Tjw+GyQ3ons2Ksqv/9E+P7MRRQlKXEvAWlplJjkYtX00wSi//CzQhOmuGqDIy
 Zb7IA0ldfIWJBPHprRhiCTZXGjR3Sd5I8sBguHs5iA74ZTSTvGGGW8bdxuGSm5hvDVmtbYElqPy
 mHujTs+KlYS5aRX96drAN1Qo=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 170146f985efa10a;
	Sun, 22 Nov 2026 00:57:36 +0000
X-Mizu-Trace-ID: 170146f985efa10a
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sat, 21 Nov 2026 19:57:31 -0500
Subject: [PATCH] block: don't wait for all RCU callbacks when freeing zone
 write plugs
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
Message-Id: <20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev>
X-B4-Tracking: v=1; b=H4sIAPs9AmsC/x3MQQrDIBAAwK/InrugRgzpV0oPajbNkqJlTUJoy
 N8rPc5lTqgkTBXu6gShnSuX3GBuCtIc8ouQx2aw2npjrMaJworxveC3ZBpR0oYxSDsEUxy0c+T
 7EDtowUdo4uOfP57X9QPihNf4bAAAAA==
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
---
 block/blk-zoned.c      | 14 ++++++++++----
 include/linux/blkdev.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4c58892961912..d4e50657519f3 100644
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
 
@@ -2146,10 +2151,11 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	disk->zone_wplugs_hash_bits = 0;
 
 	/*
-	 * Wait for the zone write plugs to be RCU-freed before destroying the
-	 * mempool.
+	 * Wait only for the RCU callbacks freeing the zone write plugs of this
+	 * disk before destroying the mempool.
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

