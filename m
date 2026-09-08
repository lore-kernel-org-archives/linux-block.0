Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE74AE8D3
	for <linux-block@vger.kernel.org>; Tue,  8 Sep 2026 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857887; cv=none; b=eE/4iAQc30ZrfVd/IfU7SGsTMqfNZzpmSS7nr6mCP3b8SiDCYwSS6E837QtvmQ3145G/y1DiuwhEN6nWMdZJBSEoH9SlOgiQmNUseigRFhLlvFUgZ927Akia2YUw3asvxjUmpr9LV+X3oye0yJBYQ1UhdErcFug+MPLierL9N30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857887; c=relaxed/simple;
	bh=OK/s0kx1+IKjoawGcTjYBg2tkLA8LFewJzQabY9vyaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bSQv82ant2D+/CFgcpg++M6h+jxh86QLRh2YKBCXzJXc4TV3o8RsViW1E4AyQTFzl9OBStHrNnd/Ucq3L7YFK3P9lPj2JYpcFVaH96wZf76cvYpxpMtqsQVUZjhn+GKqhaZ3cDpmYepkR5Gw3viFMPuDP1HkliGY1MyL9pvywok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW7MlTj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW7MlTj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE4F1F00A3A;
	Tue,  8 Sep 2026 08:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857877;
	bh=yhU5NXKm5xeSkn2fIv7ebQRRc5ivP87kujryZ3kaVYk=;
	h=From:To:Cc:Subject:Date;
	b=LW7MlTj21n7ukdqgBGzM90zd/dKzsK940vLEv+7a1CGGxlcdFKheY6LNxGVNiryC/
	 uQT+POKAgYwRaNu5AZv2I0k39+0V+lnZthCnPH8FhfaWrfUVWS8Zg5WWmN5leurKdb
	 HYkl7afO1t27mxmkSXK9+96HTUi0MTsedvgyYOojmqXcSR9FsilSAqeGSRbrsTZeFN
	 NxOURBEMt8YLRhbEUPqkmrKg5cjJ/lk4Qbozn17NY7FvpSPxbpGjAIJePleeWfhQGf
	 AdI9gxViI/yveoYenntWsp7Jdaq0FKxNFKUUSL1QRu4M8eed9XdWhP3e52wpqY/SLD
	 KrSeIHK23W0EQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 00/16] Improve handling of offline and read-only zones
Date: Tue,  8 Sep 2026 17:57:29 +0900
Message-ID: <20260908085745.1082697-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

This patch series refactor some zone related code, improves the caching of
zone information and the management of zone write plugs in preparation for
fully supporting storage element depopulation.

Most of the functional changes here are around the revalidation of the
device capacity and the management of zone write plugs to better handle
read-only and offline zones as these conditions can become more common
with storage element being depopulated.

Changes from v6:
 - Rebased on block/for-next
 - Added patch 2, 9 and 11 to make revalidation more solid against disk
   capacity changes. Due to these changes, review tags for patch 4 were
   dropped.
 - Added patch 7 to improve cached report zones.

Changes from v5:
 - Rebased on 7.3-rc1
 - Removed patch 13 as it was sent separately as a fix patch

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

Damien Le Moal (16):
  block: remove disk_free_zone_resources()
  block: improve capacity handling during zone revalidation
  block: refactor disk_revalidate_zone_resources()
  block: refactor disk_update_zone_resources()
  block: remember a zone type regardless of its condition
  block: refactor bdev_zone_is_seq()
  block: improve blkdev_get_zone_info()
  block: introduce disk_for_all_zone_wplugs()
  block: serialize zone revalidation
  block: drop all zone write plugs on capacity changes
  block: retry zone revalidation on capacity change
  block: propagate readonly and offline conditions to zone write plugs
  block: always treat offline and read-only zones as dead
  block: fail zone management operations to read-only and offline zones
  block: allow read-only and offline conventional zones
  block: simplify disk_zone_set_cond()

 block/blk-core.c       |   7 +-
 block/blk-zoned.c      | 848 ++++++++++++++++++++++++++---------------
 block/blk.h            |   6 +
 include/linux/blkdev.h |  11 +-
 4 files changed, 550 insertions(+), 322 deletions(-)


base-commit: ba285edf3fd1a27f8ec739b5b396d45c98eabee0
-- 
2.55.0

