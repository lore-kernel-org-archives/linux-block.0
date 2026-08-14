Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529A0282F03
	for <linux-block@vger.kernel.org>; Fri, 14 Aug 2026 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715283; cv=none; b=BQC0km++mPQT2anl6wbGDVlFxF68g984y9+GQLxHGAaQJPjcRfv5/tKQIXs9NQubFXImUksaWRzecNXMPHut3D+IjK33weh84znfmF+uyJ0IIYLrbpnYOSoeGllEiMk8ieQ1AY0avm/XmMfIfcBm1Sqpl4qav3XtfJpKBGa69OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715283; c=relaxed/simple;
	bh=o+Z1ehHc4rbO3pqBALioDP0357lsiovdDoFRrnqiNr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EkUlAV3BmJs18dzPDhDP+RV9FdgP+zvaXg3VVV9QSTRVF9Zpdyc0UHCMJomq2t0RQpkvSZcuLIhiAOkbD9UtK8Q2wVXhzu6/h5STHy5uwfPxVLlAhPv0QA8fJX6n1IvF8cyroHVh1tlkEgex6OEba4NLArCmTypGypA/K1EQboM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4ikqECu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4ikqECu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DCE1F000E9;
	Fri, 14 Aug 2026 13:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786715282;
	bh=MMaRV+iL07oHiAqEc7pL9yM6QnP7yWVf+HrvYejjYZY=;
	h=From:To:Cc:Subject:Date;
	b=l4ikqECuf1kkfSofaDeArIoXMnk8W18Y61UNcfkZ4SHtRnW+oNeglAaAXwYRGQBZo
	 4+71XON14sDDxLpmRyYPsESIvYcuua+T0ZQup0XIk8q4TCtbJDQZFO31103JgFmORn
	 X0s0VhDXqTdm/OTobZ8Vr0gUXG0tGaqz9zCx+kHVE/47qhdKK5XOfdPDT+Z2SqBohz
	 ie+W3hCCve9jDTs9IGwjhkXhMhJTNrtqfVEf1JEfBjPBudgzSa9hE4EUa/5g5vo4Px
	 r3NmlNl7B8cC5kUsAaazV2CYl2+9MnYwhHWr1x5I64MpC1mqKAckkkh36KPdqzX1x8
	 oG6GlfjggBGeA==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 00/13] Improve handling of offline and read-only zones
Date: Fri, 14 Aug 2026 22:47:37 +0900
Message-ID: <20260814134750.2100304-1-dlemoal@kernel.org>
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

Changes from v4:
 - Renamed bdev_check_zone_mgmt() to bdev_zone_mgmt_allowed() in patch 10
 - Added Fixes tag to patch 13
 - Added review tags

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
 block/blk-zoned.c      | 791 +++++++++++++++++++++++++----------------
 block/blk.h            |   6 +
 block/genhd.c          |   7 +
 include/linux/blkdev.h |   2 +-
 5 files changed, 499 insertions(+), 314 deletions(-)


base-commit: 413ba2c89c48abdd0bafd5115806d43e1f414df5
-- 
2.55.0

