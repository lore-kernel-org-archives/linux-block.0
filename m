Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260D13B293
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 00:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782434579; cv=none; b=NhsOBuBHmtfxK1lqFAijvqcdXLdxiAzbWkU66GXCu7jULbqKI6+YmYmdhYj7faue/q8Xx3BfsNGPCl+4nXjlcFZ8gr7FF8E5rZ6hBxO1A0lTorF4hGJBJlUgkSy3DYgvqDJLuUOlnUq33mdQLJ5TQwaLqDySOIEtZ//S8+gdFVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782434579; c=relaxed/simple;
	bh=0AHizUA1If405xWtsorLZx3IQVnzKKtByqC2p/WjqXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmceOm9ZXs3KFwf50GH+iOu2R7GMAmCfcE7uNxq8ZBQaMSDhxSqAvJps0mmNhcYVaPBKqbOkTbcRIGOoVulJxbSvKLNMWyGk/bBB4YjAdXn9ufMID9qeq6Op2vaxflkJ9MBWbOeRSljJilXBN3MPYAMRQ+3sK8SJy3hzxthtSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oE6/WxJT; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oE6/WxJT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782434577; x=1813970577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0AHizUA1If405xWtsorLZx3IQVnzKKtByqC2p/WjqXM=;
  b=oE6/WxJTUUsTPtPK6c/yYR5xYzj0bXA1pLLRY3tlvHQPE7TV55HWTYED
   2iWlyhZaWhGvCHRv5pM/kC5oZkHiU2Pe/NRX5IiMKWyIFVkxfe8b+1w0d
   VrhyYWlSoeV/HcHM9xBvPKg40n2y9tOYV8B/oS6vjpg/O8Bxub78irUoS
   mrISpFViXi2jZRysH/agG9lrbsbYLRAJ5cC3u58tLA2u4gbu9dexgj5PH
   IhO/61QdDt41q1/z2iAWehtBWMjcLFFcFyToP6SXMYE8u3hyhIRgz6zyd
   kjQfRJkUlcQxstCVrKDoVYyEOr7Ql9pMf/dxPxzhIC/SnN6xWC3Xv0n+W
   g==;
X-CSE-ConnectionGUID: l12NIqUdStKB3uk6riXA8A==
X-CSE-MsgGUID: Uezm/ECGR767wZzNxzVs6g==
X-IronPort-AV: E=Sophos;i="6.24,225,1774281600"; 
   d="scan'208";a="148892215"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2026 08:42:51 +0800
X-CSE-ConnectionGUID: FowJsGk3RFGjAcDutTUntg==
X-CSE-MsgGUID: KQL84uT+QRyHrbVIef8Qnw==
IronPort-SDR: 6a3dcaee_AZaDF908dzIqkTImK7bkTyYaVVYi/6srefS5SQ2UXv9no4o
 614z2xxjichcpIx8tJJPAd8KtQZCqcbilZdjcqg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2026 17:42:22 -0700
X-CSE-ConnectionGUID: cf20M0BPQByd5BjMHqnChw==
X-CSE-MsgGUID: c817CIhIR8Cl7POzEaxBIg==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 25 Jun 2026 17:42:21 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] block: serialize elevator changes for the same queue using a writer lock
Date: Fri, 26 Jun 2026 09:42:21 +0900
Message-ID: <20260626004221.711326-1-shinichiro.kawasaki@wdc.com>
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
[2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00eacd138d020de97fc6

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

