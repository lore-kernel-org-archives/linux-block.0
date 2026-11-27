Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795751052;
	b=HmsS57jbuKmsP1zJ/49/2J3AcakaPLn0Ms1FwW82KBlvefrCeX1vPWH1+ejjMxVF+Ca2
	 f+DkNSBOUa6/kBasOaRzkxamZHjtnp3Ivd1khfzCb+6/Zh8x04MyVeQLS2x4uC8hKFnFn
	 vJrIQEFsnnZMV6s5bJz0GAd7ET5KjCaTV5xLXY+jWybb+8Xyf+9v2Aguc2MaDvRNQB+s+
	 OMH7QcOaRb56zMdlp4OFGmnpeTJFx59EV8FExU1JFmq1ZYs/7XNM3535K5Ybd0YOZ5t5R
	 neu8T+Ps+TMZu0UtH6rGeAgBGt1BdaKew5v3+EsEoDubb9EZuAuX0qxtE8bquDLZhAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795751052;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=MWtgvDghZjAiJk5GBj+UkRMP6MvoginNnDKycsPiWA0=;
	b=2J1NJr8mDEREo4RmhglpMlU/TjyFIKz/WyL2q7mzFKp2kFSTu3AXCq78Cm5q4xi5Zmfc
	 xwjxZGDS59T0s4Iuh1Iy2A7B2HN51HI4NXnwzglNZp/6n5V2qrctYGefqGbs0XQw3oxHy
	 b0xDBAnzsDMqnhDHzERXsVosWCmigjXYAKy53plip8xE4750YtuVGcmvUNu88uF5ZuMJr
	 ZpfeP2oY6jZUEN989h3Rltsx/E3AVMbnMY9cx2z9fC3hCesdKBSdXHLPqzfkl0fMi+Gsu
	 5zkK8gb/Oj1DYakuywtmNxlj6hkhV+o4KZOcJm5jr6pe0NTWQjyln8GtpJF1bCAWJEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C5CNRHjQ;
	arc=none smtp.remote-ip=91.218.175.136
Received: from mta0.migadu.com (out-136.mta0.migadu.com [91.218.175.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC62606A31C
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 03:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAC62606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C5CNRHjQ
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8Ol/PKrbweaBzRspalgJ2j73OId9pQRKjPo5PqpqTQg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795751048; v=1; x=1796355848;
 b=C5CNRHjQsBQpBMFGcZwiboCDMMkHM7dMAEdpzgRft51MP2Sbb1s2mZ0BwyJqkOS6/ov5x4H3
 MqzS0f3Dq+fYMZN/FN+jFT9lXiKnuPHkBPJdrdU/GOKTI9jfS0at2y/lyVnn5FM+PUqElvZ8BQb
 MGkg7PsVUgprdPHhIwETqdpQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 80c73c27dae344da;
	Fri, 27 Nov 2026 03:44:08 +0000
X-Mizu-Trace-ID: 80c73c27dae344da
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Thu, 26 Nov 2026 22:43:51 -0500
Subject: [PATCH v4 2/2] block: free remaining zone write plugs directly on
 disk release
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
Message-Id: <20261126-feat-blk-zoned-rcu-barrier-v4-2-a4ab1d2162e0@linux.dev>
References: <20261126-feat-blk-zoned-rcu-barrier-v4-0-a4ab1d2162e0@linux.dev>
In-Reply-To: <20261126-feat-blk-zoned-rcu-barrier-v4-0-a4ab1d2162e0@linux.dev>
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

disk_destroy_zone_wplugs_hash_table() runs from disk_release() and frees
the zone write plugs still in the hash table by marking them dead, which
drops their last reference and queues them for RCU freeing. Nothing can
look up a plug at that point: the function already walks the hash table
without zone_wplugs_hash_lock and frees the table itself with kfree().

Zoned drives taken offline usually have partially written zones, so
their plugs are still in the hash table when the disk is released. Each
such disk then queues RCU callbacks and waits for them in rcu_barrier()
before destroying the mempool.

Unhash these plugs and return them to the mempool directly, keeping the
checks of disk_free_zone_wplug(). The zones state array that freeing
them would update is freed right after by disk_release_zone_resources().

Removing 32 zoned null_blk or scsi_debug devices, kernels with and
without this patch alternating over 4 rounds of 5 runs, in the same
rounds as the previous patch, median of the 20 runs and interquartile
range in parentheses; "with plugs" leaves four partially written zones,
and so four zone write plugs, on each null_blk device, and the
scsi_debug devices have no plugs left at release:

  devices                     before (ms)      after (ms)   change
  null_blk                  424 (410-430)   428 (414-438)      +1%
  null_blk, with plugs      876 (866-886)   433 (426-438)     -51%
  scsi_debug, host-managed  740 (722-779)   742 (722-767)       0%

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
 block/blk-zoned.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e181ddb1b41b2..bb8e614bf1bb3 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2138,14 +2138,21 @@ static void disk_destroy_zone_wplugs_hash_table(struct gendisk *disk)
 	if (!disk->zone_wplugs_hash)
 		return;
 
-	/* Free all the zone write plugs we have. */
+	/*
+	 * Free all the zone write plugs we have. The disk is being released, so
+	 * no one can look them up anymore and there is no need to wait for an
+	 * RCU grace period. The zones state array is freed right after this.
+	 */
 	for (i = 0; i < disk_zone_wplugs_hash_size(disk); i++) {
 		while (!hlist_empty(&disk->zone_wplugs_hash[i])) {
 			zwplug = hlist_entry(disk->zone_wplugs_hash[i].first,
 					     struct blk_zone_wplug, node);
-			spin_lock_irq(&zwplug->lock);
-			disk_mark_zone_wplug_dead(zwplug);
-			spin_unlock_irq(&zwplug->lock);
+			WARN_ON_ONCE(refcount_read(&zwplug->ref) != 1);
+			WARN_ON_ONCE(zwplug->flags & BLK_ZONE_WPLUG_PLUGGED);
+			WARN_ON_ONCE(!bio_list_empty(&zwplug->bio_list));
+			hlist_del(&zwplug->node);
+			atomic_dec(&disk->nr_zone_wplugs);
+			mempool_free(zwplug, disk->zone_wplugs_pool);
 		}
 	}
 

-- 
2.43.0

