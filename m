Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751046;
	b=Hx6sPdsdBfhOI0hwbs3WvrtkoyqgRUYw829n3kfKCpDVcttH63yrg0OOzqsp//L2AYZS
	 oyeGeVQamDPGLWE8bpVpguxse8og3R1TaI0i176UaEvnodpM7YJskOJuqy8Y7Yg8QfUFH
	 kBUaltGzTAKMKpX7hE4YkVeOpNis2W+kyySEuXlphaNDiXRrPWfGeeWr6jJAQsf0F9dZ4
	 11FGh0vMJBTSgRWxbPXsO6kl1uQZ9JaI4TvzkMvvCbnxtTBx9oa2ue6Ga8F5LBOhqe9fg
	 kvY0eFFD7axYhDAAv1pWs981Dx1SV+6A98EDARHwJmue4PYrY0rHg1THaBlhW6FnMcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751046;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=xnz9SPA2N4GrYi+w79Arm95hPv5eJbHuQD/NfshiqKc=;
	b=EMVVzqnFubA6cGPUqJ9DEWui+Q9j13J8BSZuz1gG3A1SyRQMbONBBny8S3p86iXS44jd
	 jenhDHiyvlfyoHqeeRRVc3M8Wl7KaFUoJVAgEmH7+ZEP6mGFBiRYrE4XlPROBK/iVfPDl
	 Vq/SA+ZfDWh1hM7CgDeQdY1NX/UL4xcZY9Klt0YVS8XqsPUiZdlG6QQwU3/oiK9uSRrcS
	 TsSnhKQqTLnIFJa7CQBZc6s3Y9qguASbr+yHsXxSITSKdJfxQLlhmhatHjKESy+fLFddB
	 Efnzm9Scnbyc3OQt2zvOANa4YlvM27q6677UcP2Uy+0dvUd2fWN2ILV/k+hIhpKJZJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X43qaI9n;
	arc=none smtp.remote-ip=95.215.58.35
Received: from mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32139606A31E
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 03:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32139606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X43qaI9n
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+m5ccI/H+GeNSlQmpbjHRziaMSDzZfwYPH6F7UMwfzU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795751044; v=1; x=1796355844;
 b=X43qaI9nld4PkqF48+qPVdSTrIA//nJUKtOiRBFJXL6ZkWl/1m99Lx03sNE3GkeOc4bkt9de
 Aq3la+Qr74cf1jp95L+l75G/rsFkwX+5wc6wVRF4dSuEeZtqQ4JYJQJ8VEALrBX+2zABy0YH//e
 wJeDvUcpIk/lA+2cQBPEq4G8=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b5ad654151c09e4d;
	Fri, 27 Nov 2026 03:44:04 +0000
X-Mizu-Trace-ID: b5ad654151c09e4d
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 26 Nov 2026 22:43:50 -0500
Subject: [PATCH v4 1/2] block: don't wait for all RCU callbacks when
 freeing zone write plugs
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
Message-Id: <20261126-feat-blk-zoned-rcu-barrier-v4-1-a4ab1d2162e0@linux.dev>
References: <20261126-feat-blk-zoned-rcu-barrier-v4-0-a4ab1d2162e0@linux.dev>
In-Reply-To: <20261126-feat-blk-zoned-rcu-barrier-v4-0-a4ab1d2162e0@linux.dev>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
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
and call rcu_barrier() only when that count is not zero. Use
rcu_barrier() rather than waiting for the count to drop, so that lazily
queued callbacks (CONFIG_RCU_LAZY) are still flushed.

Removing 32 zoned null_blk or scsi_debug devices, base and patched
kernels alternating over 4 rounds of 5 runs, median of the 20 runs and
interquartile range in parentheses; "with plugs" leaves four partially
written zones, and so four zone write plugs, on each null_blk device:

  devices                        before (ms)      after (ms)   change
  null_blk                     848 (828-862)   424 (410-430)     -50%
  null_blk, with plugs         865 (854-876)   876 (866-886)      +1%
  scsi_debug, host-managed  1057 (1024-1092)   740 (722-779)     -30%

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 block/blk-zoned.c      | 14 ++++++++++++--
 include/linux/blkdev.h |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 4c58892961912..e181ddb1b41b2 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -724,8 +724,15 @@ static void disk_free_zone_wplug_rcu(struct rcu_head *rcu_head)
 {
 	struct blk_zone_wplug *zwplug =
 		container_of(rcu_head, struct blk_zone_wplug, rcu_head);
+	struct gendisk *disk = zwplug->disk;
 
-	mempool_free(zwplug, zwplug->disk->zone_wplugs_pool);
+	mempool_free(zwplug, disk->zone_wplugs_pool);
+	/*
+	 * Pairs with atomic_read_acquire() in
+	 * disk_destroy_zone_wplugs_hash_table().
+	 */
+	smp_mb__before_atomic();
+	atomic_dec(&disk->nr_zone_wplugs_freeing);
 }
 
 static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
@@ -745,6 +752,7 @@ static void disk_free_zone_wplug(struct blk_zone_wplug *zwplug)
 	atomic_dec(&disk->nr_zone_wplugs);
 	spin_unlock_irqrestore(&disk->zone_wplugs_hash_lock, flags);
 
+	atomic_inc(&disk->nr_zone_wplugs_freeing);
 	call_rcu(&zwplug->rcu_head, disk_free_zone_wplug_rcu);
 }
 
@@ -2022,6 +2030,7 @@ void disk_init_zone_resources(struct gendisk *disk)
 {
 	mutex_init(&disk->zone_revalidate_mutex);
 	atomic_set(&disk->nr_zone_wplugs, 0);
+	atomic_set(&disk->nr_zone_wplugs_freeing, 0);
 	spin_lock_init(&disk->zone_wplugs_hash_lock);
 	spin_lock_init(&disk->zone_wplugs_list_lock);
 	INIT_LIST_HEAD(&disk->zone_wplugs_list);
@@ -2149,7 +2158,8 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	 * Wait for the zone write plugs to be RCU-freed before destroying the
 	 * mempool.
 	 */
-	rcu_barrier();
+	if (atomic_read_acquire(&disk->nr_zone_wplugs_freeing))
+		rcu_barrier();
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

-- 
2.43.0

