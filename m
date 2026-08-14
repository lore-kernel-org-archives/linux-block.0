Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B8D377006
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 06:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786689136; cv=none; b=NdK56/dFHXuEL9xmTEcqlbr8Ki514+haF1BULlnjfi/af8YvkPDZ+5tKfAYq2DQxO3qI098jquSD/0JiKYVWvM/0HWEwz7MxVbZSj3N6lZymXp+VhK2lAPl4XJDbqnENlp54NzcuG5wRWcysrnq7qny5a7w+l2KuSSMvBxlHKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786689136; c=relaxed/simple;
	bh=+w606DjRr/35m0l6ODBGKrHTGBTwm2PFTJNTwFr73Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJhBhnC8lef9bCYB/DlwyCJBAtEkAbKYG8L/NFc7YdWR+RVQoKN1UlXxhD49uhltGqCiwmJWhNEEpIruP9vFbNq4lEtho4TmvihpsHDLQQF41oybvJxIZ8rIxlJr/W7Rt8Fxd7RXoluXtr2SqQAg8H6GgmihZuSizYH24tdBu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCGFvEH8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCGFvEH8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3328F1F000E9;
	Fri, 14 Aug 2026 06:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786689133;
	bh=l6AxwQXGf008PaDX9PUmqJOTcrpHr78kky6iYWF6dTI=;
	h=From:To:Cc:Subject:Date;
	b=KCGFvEH8Y+g7Uma+tD6Geuk5flSGeXlMK4iUIg3bLwZqm0RPOa8dpc2m+W2MKTnHr
	 9EyhjFPDswqBYSiD+Z0860azqYpriq6V/9bZCVYMmz1D2Iat7GO7N9aJipYozIv82A
	 lcS5tFvrtcLfFR0V3E/R+HTb8bYQN0URBAQ2Ia6h8pUuoMKWaBzHlSXDEbyrFEJMPK
	 wkuBIryn5aY0VoTy4Z11AbJ/MsgJ7a8lmFKRACo6a+NfWFJaoXPu0z9Q/Am3Olyh0R
	 SPmmvpWG4uvQvayey517Akx7pcSKeusIOdDo5qwDjnQ9DE2xuh32qzHxejhYHolb+k
	 LOOB5sYST1WBg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 00/13] Improve handling of offline and read-only zones
Date: Fri, 14 Aug 2026 15:31:48 +0900
Message-ID: <20260814063201.1762743-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

This patch series refactor some zone related code and improves the
caching iof zone information and the management of zone write plugs in
preparation for fully supporting storage element depopulation.
Most of the functional changes here are around the management of zone
write plugs to better handle read-only and offline zones as these
conditions can become more common with storage element being depopulated.

Changes from v3:
 - Rebased on latest block/for-next
 - Small modification to patch 4 to address Sashiko review comments
   complaining about the potential for out of bound accesses to the zone
   state array.
 - Added review tags

Changes from v2:
 - Minor changes to patches 1, 5, 7 and 8 to address some of the Sashiko
   review comments (a lot of these comments point to cases that cannot
   happen in practice or that are non-fatal and would generate errors due
   to a user invalid use of the device).
 - Applied review tags

Changes from v1:
 - Fixup error path change in patch 1
 - Use WARN_ON_ONCE in patch 4
 - Dropped patch 14
 - Applied review tags

Damien Le Moal (13):
  block: remove disk_free_zone_resources()
  block: refactor disk_revalidate_zone_resources()
  block: refactor disk_update_zone_resources()
  block: remember a zone type regardless of its condition
  block: refactor bdev_zone_is_seq()
  block: introduce disk_for_all_zone_wplugs()
  block: drop all zone write plugs on capacity changes
  block: propagate readonly and offline conditions to zone write plugs
  block: always treat offline and read-only zones as dead
  block: fail zone management operations to read-only and offline zones
  block: allow read-only and offline conventional zones
  block: simplify disk_zone_set_cond()
  block: flag zoned disks with GENHD_FL_NO_PART

 block/blk-core.c       |   7 +-
 block/blk-zoned.c      | 790 +++++++++++++++++++++++++----------------
 block/blk.h            |   6 +
 block/genhd.c          |   7 +
 include/linux/blkdev.h |   2 +-
 5 files changed, 498 insertions(+), 314 deletions(-)


base-commit: 413ba2c89c48abdd0bafd5115806d43e1f414df5
-- 
2.55.0

