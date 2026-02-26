Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF319328B75
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 04:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772079341; cv=none; b=XuSN1xC0LKNJWCNLmTvtB0bDR43pL2NkbPk2P4Vwm0i59spu4+K/zeE5gGQZJI0AGtfGGho5jNVFDfP1MRXdW3O8NMAdETdzEs4dlieef3oPsIKiIIkCXULJVzCcgxL5hN9CKmfWRU4oJzdzkeDWmaZF2FmkfWxXiyK67gZw7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772079341; c=relaxed/simple;
	bh=9M8xoinSiMVO3BCht5NVWvit/M+i61f/Mujbsy4XTts=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UO6kogUlxTeQWlKgyUSz8YK3RyAp+VHLxIxVFzJ6bcK3xRSvB1lshwWARfkhYqIiFC9AqGkIwpdalDlkQYB/S+NboC1Gvtg/aijkZWqqcquVAY/vYp8wJbkT6ev1ADLqgBZ7KRglSvYBAd04RqeNWlbSSNjLkDxriKWQYMFOF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5Cqeurm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5Cqeurm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD6AC116C6;
	Thu, 26 Feb 2026 04:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772079341;
	bh=9M8xoinSiMVO3BCht5NVWvit/M+i61f/Mujbsy4XTts=;
	h=From:To:Subject:Date:From;
	b=G5Cqeurm6zek8oXa+IkhPIBAU0KTHHReKd0BgDtl/fvBn06rLzG4D6xInKeFN5Efb
	 vLOLjeYcs48YVuNRqWRoT5SADUELPL9R/on0vlj5VHfWRhNTYxUgnj8fbSVTxIw3SS
	 Rm/IYBcae19dIxJkz/GIP3Zt6QOvVi1kRQw5n6uwis3OoIkC6aOrLe0L4IPubLyku4
	 IrOnntdbbrlbWGIyqyEDetfdM416B7+MN23VRRdkloam9PUmIAtndHOU5RrEXvjSA1
	 bMTEAGNO0ezcAYM3f0ORlmIOEcVRGzNfe5UXXpXaTyLxn2qDuQjiTfmXMlpFM/Pl90
	 ktLISN9gI8GiA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 0/7] Improve zoned (SMR) HDD write throughput
Date: Thu, 26 Feb 2026 13:10:17 +0900
Message-ID: <20260226041024.2154806-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

This patch series cleans up the zone write plugging code and introduces
the ability to issue all write BIOs from a single context (a kthread)
instead of allowing multiple zones to be written at the same time using
a per zone work. As shown in patch 6, raw block device tests and XFS
tests with an SMR HDD show that this can significantly increase write
throughput (up to 40% over the current zone write plugging).

Changes from v1:
 - Reworked patch 1 to remove the fragile use of refcount_read. Zone
   write plug removal is now more solid by being controlled with
   refcount_dec_and_test().
 - Changed patch 2 to keep the refcount increase before scheduling the
   BIO work but drop that reference if scheduling the work did nothing.
 - Dropped the patch "block: remove BLK_ZONE_WPLUG_UNHASHED" as the
   patch 1 changes make it unnecessary.
 - Modified patch 5 to have the zoned_qd1_writes attribute visible only
   for zoned block devices.
 - Added review tags

Damien Le Moal (7):
  block: fix zone write plug removal
  block: fix zone write plugs refcount handling in
    disk_zone_wplug_schedule_bio_work()
  block: remove disk_zone_is_full()
  block: rename struct gendisk zone_wplugs_lock field
  block: allow submitting all zone writes from a single context
  block: default to QD=1 writes for blk-mq rotational zoned devices
  Documentation: ABI: stable: document the zoned_qd1_writes attribute

 Documentation/ABI/stable/sysfs-block |  15 ++
 block/blk-mq-debugfs.c               |   1 +
 block/blk-sysfs.c                    |  46 +++-
 block/blk-zoned.c                    | 368 +++++++++++++++++----------
 include/linux/blkdev.h               |  10 +-
 5 files changed, 308 insertions(+), 132 deletions(-)

-- 
2.53.0

