Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159723770B
	for <linux-block@vger.kernel.org>; Tue, 23 Jun 2026 01:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.141.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178405; cv=none; b=FVUE9mpAPJVwW0hhbnnUGFEj/VWphhoyqKKnR3GIZz+yaE+qh9s8IZADmJLjE0LWmsIS8plgiF0v3ykgB2jyR6Q+Ho0COMQ6MVukOjDrA3YF02U4N03us6HFKdjMGbj0aEcxnCIR6NvGobzDjsUQf6ZiMpWHCYLyZkQr7Vq49KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178405; c=relaxed/simple;
	bh=iyQKGHD12eAAzii7w/c0dazu51aFA19NYiTITqwBPag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NBC92JohRSXBYPzfB4rLJQsVcu0n1BNn9qtT4/7nCdTvbUZYO4bCOqztCho07Ohir2nfhQYGV4KOzfuoq1oE+a0r2+Sk4x4894Csp94apzb5W6PAc2DOPCnV+Pm5kxkgYyOknM0QNiD7tshYxLVMgbYSiAxxS7li8ZnffZSVnzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UgGXftiH; arc=none smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UgGXftiH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782178404; x=1813714404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iyQKGHD12eAAzii7w/c0dazu51aFA19NYiTITqwBPag=;
  b=UgGXftiHpXMqQplI/an/A4XCgzNTcHEYm3mfQ0tuEUYKeqcyGL9HNj9C
   tTl6qLyAtfgxaoGEy03HYhs2kXLfrs3Q2Bgt/YCcbqiEcMHiRaMTAgBnD
   CmLPiLx5Zef01PswyHX1di+CCnFj4Is2dhrtrSD+4sOr7K0JtUYMW3Dsu
   FdFjEeFtTSrWCkFglGxsTdiIHKya+387qjBviICN0j4GopMcwyH2tbhgW
   8G7/h5duEYD48H2q9TPOL20vDBp3IA9ilkAG6bql2fBhC7tnTxITEK4oF
   94vJfF7W/TJq8j/cS6CYNaethS72KsC3NBpRpdborn2sCeKpSWlU0WSVU
   A==;
X-CSE-ConnectionGUID: pvu6jQ/lTReGvAqBQrOA9g==
X-CSE-MsgGUID: y+uDQE6zR3q1eb7X15ZuPQ==
X-IronPort-AV: E=Sophos;i="6.24,219,1774281600"; 
   d="scan'208";a="149300647"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2026 09:33:17 +0800
X-CSE-ConnectionGUID: lg4SqykCToCm47AwCEDF5g==
X-CSE-MsgGUID: rc/RE4SRRUisVb9NV3qRYg==
IronPort-SDR: 6a39e238_pUhPGHhctQJ8Z4hInowYSwgwHSIIUMdN8Fgv+yjnyZ5IrkH
 rx7j+IKL+ZWZESHac7Zn1Nb1u0ObaD9NIHPHGlQ==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jun 2026 18:32:40 -0700
X-CSE-ConnectionGUID: GafoTIpoQa6pJWxhMww/Pg==
X-CSE-MsgGUID: rJpHx3DdS+y32brnYvDb2w==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 22 Jun 2026 18:32:39 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <tom.leiming@gmail.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] block: serialize elevator changes for the same queue using a writer lock
Date: Tue, 23 Jun 2026 10:32:38 +0900
Message-ID: <20260623013238.642052-1-shinichiro.kawasaki@wdc.com>
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
---
I observed that the blktests test case block/005 hung on a specific
server hardware using a specific HDD as a block device. During the test
case run, the kernel reported KASAN null-ptr-deref and slab-use-after-
free errors. The failure happened when a sysfs queue/scheduler attribute
file is written concurrently. I reported the failure and shared a
candidate fix patch as RFC [1]. Based on the comments and discussion on
the RFC patch, I propose this v2 patch that avoids introducing a new
lock. My thanks go to Ming and Nilay for the discussion.

Please refer to [1] for details of the failure. Also, I created a
blktests test case that recreates the hang [2], which I used to test the
fix.

* Changes from RFC v1
- Instead of adding a new mutex to struct request_queue, replace the
  reader lock on update_nr_hwq_lock with the writer lock in
  elv_iosched_store().

[1] https://lore.kernel.org/linux-block/20260611074200.474676-1-shinichiro.kawasaki@wdc.com/
[2] https://github.com/kawasaki/blktests/commit/8e80b3ccc0bbbe3f209d00eacd138d020de97fc6

 block/elevator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/elevator.c b/block/elevator.c
index 3bcd37c2aa34..b03185a217ff 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -813,7 +813,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	 *   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
 	 *   kn->active -> update_nr_hwq_lock (via this sysfs write path)
 	 */
-	if (!down_read_trylock(&set->update_nr_hwq_lock)) {
+	if (!down_write_trylock(&set->update_nr_hwq_lock)) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -824,7 +824,7 @@ ssize_t elv_iosched_store(struct gendisk *disk, const char *buf,
 	} else {
 		ret = -ENOENT;
 	}
-	up_read(&set->update_nr_hwq_lock);
+	up_write(&set->update_nr_hwq_lock);
 
 out:
 	if (ctx.type)
-- 
2.54.0

