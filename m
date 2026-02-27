Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6C2459D4
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772198708; cv=none; b=DhBbHg0XFLcq5Q1EGMBo4i/jLWRiR5uPI4uv4v/7Wg6st37v+I5WpEA4Z+oWBUqkJB9hp+VROwXuOlnwoRO+MDkGTlQE6EgH3q7ulSNee5eGMzFdwPPOCvvztLRuG25rBaP7f8j1Qad68bLMaou+IvVEILJBivoHsqMJ8daadlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772198708; c=relaxed/simple;
	bh=QSpwSQft7U+rchtdnPYLjC0TIArc019TqAHu7ffhxPg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=boCLmsG2DVZFtdIrSbtGI3GcOX7sdskP8AFICeeqSFiX4X64oJI5GMf5u6wOcMDuVSrCNPLZvbxOUdl9K68iVvwcGPADarA8TY5XAn2zY62eZhg2ZQAGW6/oEEUfW0FarGtyI7sURIJyOwMLndN8Ptwk9rrpkjXDmh9voAJd6bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdMErAOm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdMErAOm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF16C116C6;
	Fri, 27 Feb 2026 13:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772198707;
	bh=QSpwSQft7U+rchtdnPYLjC0TIArc019TqAHu7ffhxPg=;
	h=From:To:Subject:Date:From;
	b=GdMErAOmLxgkUlYN5cLZcrN7EG2oa2NeRHqjulB4rJted5jgdYhULgoZb4YPIH+t4
	 XUY9O5QsGw/VecxEL+pXS+L7IfM/JrEiZMZJ6lcoCPydNPDArFs1NsOaPNScM2BWen
	 YnE2DCe+MKN6eD8uDMdGtN31mznYIy4sd3rtyoECTGRqG+HgSjJMUEE984KWoxH4om
	 JPIP/yvYI8fiLqxKEzSFOOMkJRI5ePCux8tCevMPEcbFqmLkhk4RSKSPbB5TFddUx9
	 HEtheI5153Xhgh7zkxF9cK1OmO8S3O1oeftYLNW8o3H+LFPoTYPRclnl47ceJCx6Ir
	 d9+enhK6g/Xgw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH v4 0/8] Improve zoned (SMR) HDD write throughput
Date: Fri, 27 Feb 2026 22:19:43 +0900
Message-ID: <20260227131951.2464150-1-dlemoal@kernel.org>
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

Changes from v3:
 - Corrected patch 6 to remove the unnecessary blk_queue_is_zoned()
   check in queue_zoned_qd1_writes_store(), as well as the commit
   message to mention the visibility of the zoned_qd1_writes sysfs
   attribute.
 - Corrected the documentation text in patch 8 to better describe the
   visibility of the zoned_qd1_writes sysfs attribute.
 - Added review tags.

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
 block/blk-sysfs.c                    |  43 ++-
 block/blk-zoned.c                    | 402 +++++++++++++++++----------
 include/linux/blkdev.h               |  10 +-
 5 files changed, 320 insertions(+), 151 deletions(-)

-- 
2.53.0

