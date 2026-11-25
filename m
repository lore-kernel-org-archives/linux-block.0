Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596104;
	b=uVHIKvGN5nth+eZwj19BAAyHnrcnGkWXUkqq818sVuwMpg/6HyXiQTIbuzlEFjAbiTBK
	 vr88iUXbEKQmQSV7u2EuGhMqn+FMR9suNyEkilZSH0i1VD7qFyPVLUE/oDYuCbTUYwh2j
	 xIZwWsybgpNHtpEvStnGKh4X4vGlT7Gk4G36/3A6Cjef5WnV9uT5TdjOEI29mFKUTOEyA
	 TSRAi/oWRxjfXQuocRv7f95t9YC64JZ+X6UTP3KcgU1FAbpzG3iqCnifCadX+r7lDeqb9
	 SeW6Ao3nwK9ycXloz77MlRtSkohA76UAmtMCsZvsIcDXGJobWSFnQdhGZbM1t8X5qaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596104;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:To:Cc:
	 X-Mailer;
	bh=0loQZHPBjLNYdasA1EMZfMX85Vaac5IkP7Fw5i4r2dI=;
	b=nqnDj6URljEIDR82uUjjqPLykdkwUpCWQ0CmVupMakzR9sTyw/1L2o9DNNwpBP64IZAI
	 F/qf1Hr1qy9cAzBHB/ZbMPDzmM0a4cnsEzU8A30Pfhk/Itbu4NMjef1i46tpPrQzinROC
	 bw/2+6igAshPptQg77bpSk/gSaUk6OiVWVbg9MdWD+LXAuy5HW/i+CXFNBLgTVMcFy6zH
	 PhuURNOFdgwZqG2dnTL+kNWhPGj2z4jmynohvggHT8SdM2u8i/mai7MQe3qelFX5rf1S5
	 ACl3bENdBHITmjJ8C/CeNUPO3LJdRy6EU8L7N/D/K/Rhv14lBujM/I3ovd89fuzG3/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xGwLo4wE;
	arc=none smtp.remote-ip=91.218.175.37
Received: from mta0.migadu.com (out-37.mta0.migadu.com [91.218.175.37])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45C2606A31E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 08:41:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45C2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xGwLo4wE
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sERThpnRkKY48QAqz89vLAJFHQqh6vsXe+M60btYjZY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795596101; v=1; x=1796200901;
 b=xGwLo4wEaxrU5CInGeA7c4e9uw/CXWn+0nJSVQDRi4SmU6apH1j+hmQI/5cIJS1A/PpfaXCK
 BFulhbOFLbRhISiS6U9tbrhqJpDCvUvfTUgiaIJAmqqcgfyWVl4RM4DnOfR68Ww5IbWidDR5L2b
 lEDjuUkoNHqB8dfXbxTuN4xk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8ce7b261336591e2;
	Wed, 25 Nov 2026 08:41:41 +0000
X-Mizu-Trace-ID: 8ce7b261336591e2
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Wed, 25 Nov 2026 03:41:36 -0500
Subject: [PATCH v3] block: don't wait for all RCU callbacks when freeing
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
Message-Id: <20261125-feat-blk-zoned-rcu-barrier-v3-1-707f65bae05a@linux.dev>
X-B4-Tracking: v=1; b=H4sIAD+fBmsC/33NSw6CMBSF4a2Qjr2GXmhBR+7DOOjjIo0ETIEGJ
 ezdQmLCiOF/Bt+ZWU/eUc+uycw8Bde7ro2RnRJmatU+CZyNzTBFyTmmUJEaQDcv+HYtWfBmBK1
 8NDwYfUnznGShdMYi8PZUuWnD74/YteuHzn+2r8DX9c/yIzZw4FBIWRZCCxSabo1rx+lsKbCVD
 bin8kMKIyUtIkeVl0aYPbUsyw/TjuQ8DwEAAA==
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
V2 -> V3:
- Initialize nr_zone_wplugs_freeing in disk_init_zone_resources() (Damien Le Moal)

V1 -> V2:
- Keep the original comment above the wait (Damien Le Moal)
- Add Reviewed-by (Damien Le Moal)

v2: https://lore.kernel.org/r/20261124-feat-blk-zoned-rcu-barrier-v2-1-6d2212a48c5c@linux.dev
v1: https://lore.kernel.org/r/20261121-feat-blk-zoned-rcu-barrier-v1-1-766875b525be@linux.dev
---
 block/blk-zoned.c      | 11 +++++++++--
 include/linux/blkdev.h |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4c58892961912..2e61a9f23b270 100644
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
 
@@ -2022,6 +2027,7 @@ void disk_init_zone_resources(struct gendisk *disk)
 {
 	mutex_init(&disk->zone_revalidate_mutex);
 	atomic_set(&disk->nr_zone_wplugs, 0);
+	atomic_set(&disk->nr_zone_wplugs_freeing, 0);
 	spin_lock_init(&disk->zone_wplugs_hash_lock);
 	spin_lock_init(&disk->zone_wplugs_list_lock);
 	INIT_LIST_HEAD(&disk->zone_wplugs_list);
@@ -2149,7 +2155,8 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
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

