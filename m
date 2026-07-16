Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024D346E56
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 09:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193839; cv=none; b=tlg1ZLc24Dw5X2biNwydmLQC0OlRTMHQPCknknmSKjVXYdRRHdm76niujw569OlZAVD6ZLRkJO3xBanAV4qjSGp2ebhN5YPHAUmhc8PC4y8C3KltUDLtCAMV/qW9mMFvEnbr5VsUaB6bs6o97XT6GK8NBAlE6zTl1ut4C5sAMgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193839; c=relaxed/simple;
	bh=742027i9bcci710nO3K5V0ftJvcBeVy42Na6yZE6KJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaJW/4uPGoZl7sJrLCbvw+rbE0chYuXvEYeRg/c7Nmd0d04GfwJzmILrkDb7PN05savW+6AwpjlLpwafc5VAFL0ulY6JFCpJN+KEm3U0HD/RVKwR3d2aqo1q6hqdZEMfYXUKbByDfKC16auytuXDU9NyW7PtGX89DgthAoMkwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=XEZdEDiT; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XEZdEDiT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1784193837; x=1815729837;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=742027i9bcci710nO3K5V0ftJvcBeVy42Na6yZE6KJo=;
  b=XEZdEDiTmZCavO2zmNwcC3/YuFNrYF8Bi5oAXY9ikPQOEVJlJjMpMVPa
   QxnxgwK4UrEM6DFYGvr5w4wafO1z6Mz1VDuL9vKZ1BmHcBIHGXdSd9yPf
   8s+cAI0VyXiSqAUw8bXVWBMStJbntmoBIZtQXBwFagvj67IhwVgy9ItnD
   xnBSpdvQ6n7fF6y69CXFgcfHt5I3okZ6xM7QiUAFGJzFFxqVVEMe/CwRK
   wVu8LN1cMBXO9IzBYAXPJ+fQpU9H9IqwotH8hDcaTBscR0S/kg5E1VmqT
   4HSy0xdh3tSel3LYYcOuKotoXt9Rwo+Yzj/Jfg1Sob1BZhCPPAkC34F8o
   g==;
X-CSE-ConnectionGUID: 70EtigXRS7y4/Ru07udD9w==
X-CSE-MsgGUID: fOHqupc3QqCfNE+T2kYwIA==
X-IronPort-AV: E=Sophos;i="6.25,167,1779120000"; 
   d="scan'208";a="146981741"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2026 17:22:49 +0800
X-CSE-ConnectionGUID: z11FxkgJRU+v5QShlJDPlw==
X-CSE-MsgGUID: 4O9u5SkRTvapj214jayO1w==
IronPort-SDR: 6a58a2de_AcGcAf3fR0hGDkygm/npea5ucfHPfUjASkzjx5a/+O2t0b2
 +unxrlu8VdwmBBUuQ6VO+v6dAksTBbxYceMrEdA==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jul 2026 02:22:38 -0700
X-CSE-ConnectionGUID: /6Bc1imXRFGaThiAHzdDPQ==
X-CSE-MsgGUID: EBZJWwX7RimoeFjZ1tu1qg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 16 Jul 2026 02:22:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3 REPOST] block: serialize elevator changes for the same queue using a writer lock
Date: Thu, 16 Jul 2026 18:22:37 +0900
Message-ID: <20260716092237.1305030-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When elevator_change() is called concurrently for the same queue, the
elevator_change_done() function runs concurrently as well. This function
adds or deletes kobjects for the debugfs entry of the queue. Then the
concurrent calls cause memory corruption of the kobjects and result in a
process hang. The core part of the elevator switch is protected by queue
freeze and q->elevator_lock. However, since the commit 559dc11143eb
("block: move elv_register[unregister]_queue out of elevator_lock"), the
elevator_change_done() is not serialized. Hence the memory corruption
and the hang.

The failures are observed when udev-worker writes to a sysfs
queue/scheduler attribute file while the blktests test case block/005
writes to the same attribute file. The failure also can be recreated by
running two processes that write to the same queue/scheduler file
concurrently. The failure is observed since another commit 370ac285f23a
("block: avoid cpu_hotplug_lock depedency on freeze_lock"). This commit
changed the behavior of queue freeze and it unveiled the failure.

Fix the failure by changing elv_iosched_store() to acquire
update_nr_hwq_lock as the writer lock instead of the reader lock. This
serializes the whole elevator switch steps, including the
elevator_change_done() call.

Fixes: 559dc11143eb ("block: move elv_register[unregister]_queue out of elevator_lock")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
Jens, please consider this patch for the upstream. I reconfirmed that
the problem still exists with v7.2-rc3 kernel and the patch applies
block/for-next branch tip.


I observed that the blktests test case block/005 hung on a specific
server hardware using a specific HDD as a block device. During the test
case run, the kernel reported KASAN null-ptr-deref and slab-use-after-
free errors. The failure happened when a sysfs queue/scheduler attribute
file is written concurrently.

Please refer to [1] for details of the failure. Also, I created a
blktests test case that recreates the hang [2], which I used to test the
fix.

* Changes from v2
- Added the source code comment to explain why using the writer lock
- Added Reviewed-by tags
- Link to v2: https://lore.kernel.org/linux-block/20260623013238.642052-1-shinichiro.kawasaki@wdc.com/

* Changes from RFC v1
- Instead of adding a new mutex to struct request_queue, replace the
  reader lock on update_nr_hwq_lock with the writer lock in
  elv_iosched_store().

[1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinichiro.kawasaki@wdc.com/
[2] https://github.com/kawasaki/blktests/commits/block_045/


 block/elevator.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 3bcd37c2aa34..2161b6eea680 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -812,8 +812,13 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 * reference during concurrent disk deletion:
 	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
 	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
+	 *
+	 * Use the writer lock instead of the reader lock of update_nr_hwq_lock
+	 * to serialize the two-stage elevator switch steps in
+	 * elevator_change(): the core switch step under the elevator lock and
+	 * the elevator_change_done() step outside the elevator lock.
 	 */
-	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
+	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -824,7 +829,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	} else {
 		ret = -ENOENT;
 	}
-	up_read(&set->update_nr_hwq_lock);
+	up_write(&set->update_nr_hwq_lock);
 
 out:
 	if (ctx.type)
-- 
2.54.0

