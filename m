Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B731A9FAF
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772157308; cv=none; b=LMvE2n0vLbHZ0NqLnvuZLzJWvnNUSejIv2/NW7PixCr2e9MIqkXS3yVGJP3jPNDgN88JFNZ057BtoUhIfkHVo1UyCTv0ZQTt5bUpHAzE12dp7QAXxygNU1lb/lUQGHDSQ3S/MXxuoirbjvLUepi0Qm66NI58jDLC0wscMhb9sEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772157308; c=relaxed/simple;
	bh=1Uu2Zo7vwohFI1wiL78HZ3DJYKQxpIrfYIi1ocLdUzc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=F5LtgOENNyylJRzkQZL4Su8EVlGuMbgxV5SOZ89T4jeRpExA2QZfrTVzZBFh/fAogg2eX6vwIvUEchEneHe13L923idOHk2RwkUVFxGLPtJvt9cCj9XNdU9tAESqXp71nW6tuNKiVpEpQl4AxCfRcfCzXIHJeuYbi7dxwT6BXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APpalWEa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APpalWEa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3B3C116C6;
	Fri, 27 Feb 2026 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772157307;
	bh=1Uu2Zo7vwohFI1wiL78HZ3DJYKQxpIrfYIi1ocLdUzc=;
	h=From:To:Subject:Date:From;
	b=APpalWEakg2ge4scxwmXZ45llN7ywPmPfZFjFZ/nwJKUvmziJm3Rc7zeDrltnvwrY
	 LiMGjbdkNyXUIbMzV2wINPoWbKy+TIoXjKlIVYPxpYuoDR8UV79i2gyonAD03R+vV7
	 egMbj8rG0lkCnMhwW80FnoGm5Y6sZOSvCeJV9/L6aa16Fa/TRWbhVcpBOMpNvpAg3F
	 1P3mMeL/x7ah9xw42eUgRuTQZLlTZmCYZAnGYDKOZ8ydNe5oUAnVr1aux6/ltF6jLE
	 fYkzkeKdSVym/YmohTX+XS5JiQqbHNwp4gyjLNmh5W1aiz69Go48aDnPhgGyhuOxaq
	 3Go2eceiPz10Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v3 0/8] Improve zoned (SMR) HDD write throughput
Date: Fri, 27 Feb 2026 10:49:43 +0900
Message-ID: <20260227014951.2327711-1-dlemoal@kernel.org>
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

Changes from v2:
 - Modified patch 1 slightly to not restore dead zones and instead check
   for such state in the BIO submission path and fail BIOs that are
   submitted to dead zones as that represents an erroneous use of zones.
 - Added patch 3
 - Added review tags.

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

Damien Le Moal (8):
  block: fix zone write plug removal
  block: fix zone write plugs refcount handling in
    disk_zone_wplug_schedule_bio_work()
  block: rename and simplify disk_get_and_lock_zone_wplug()
  block: remove disk_zone_is_full()
  block: rename struct gendisk zone_wplugs_lock field
  block: allow submitting all zone writes from a single context
  block: default to QD=1 writes for blk-mq rotational zoned devices
  Documentation: ABI: stable: document the zoned_qd1_writes attribute

 Documentation/ABI/stable/sysfs-block |  15 +
 block/blk-mq-debugfs.c               |   1 +
 block/blk-sysfs.c                    |  46 ++-
 block/blk-zoned.c                    | 402 +++++++++++++++++----------
 include/linux/blkdev.h               |  10 +-
 5 files changed, 323 insertions(+), 151 deletions(-)

-- 
2.53.0

