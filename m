Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7F3F8EA1
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445945; cv=none; b=H2+6u3hZyLevER+GaGNeBjvEHSt1zYKTy08C5I3Ttqly1NDV+mxt6xmYiG9IHR2G08xrVPj1GSH7vfYR3sk7DY3v0eNRiFCGA8vUoogAr9ezS64P/rxWc/ojB59vvL3CbmEHUaYuyIlzT4KsdWlc3JD04QNdBDZiK/ZtBJxGf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445945; c=relaxed/simple;
	bh=CoZasLqM7bsdcDna0iTVwXUZ90ysE5OwlrLU1JZnnsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V9ObyLxHjUh4fwhbF6cjWL+r+yEwZotYRinApA9Y2uPkhqLTellcsJsRAvcvahHsUy56Km8pw5ZBtjZh/G99vqfEJox3nSH04UIKSTSRZwFXQBybV2hw4WEdzaokdm1WaP/jRtF08Ru4KPrFDRTxYRx9szQ0trmQvgIYgh+Rif4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETKBdq+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETKBdq+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BA81F000E9;
	Tue, 11 Aug 2026 10:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786445944;
	bh=poRG6c1HQLO4XYkjtm1vMtmbmp/KNdICGpplGd0j1ug=;
	h=From:To:Cc:Subject:Date;
	b=ETKBdq+WSTyeTjBRmJC3RE1EdO0gMk3RhoFPqYOY4W2sfpa5eTA7Xk5QzDVlwzhtW
	 G45N4iq+RhMP1y+EjnhaWhX8ox6CsXXYIlGKhVIIanzqj5/1lLhjf/6zXJecu9THyj
	 +PWCNWuZN+VBJwUCVbnYcvMZeazprndtLU5wx27C2qHmfzZXbvaxyQu2nuVLypi621
	 vs6t/I8tDuwVtKws5tH21uadbvElEA78owWgV1zzR8YfRYlWYbYyzfxCBySevIa7nc
	 uqC4AH4qXfa3D1j5JxeoLIwRmlqeCcAee7pESH1lOrRvVlI4gUIUDHTZ2mCnoQXU1S
	 wNal/jqm78x+g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 00/13] Improve handling of offline and read-only zones
Date: Tue, 11 Aug 2026 19:58:39 +0900
Message-ID: <20260811105852.1245357-1-dlemoal@kernel.org>
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
 block/blk-zoned.c      | 787 +++++++++++++++++++++++++----------------
 block/blk.h            |   6 +
 block/genhd.c          |   7 +
 include/linux/blkdev.h |   2 +-
 5 files changed, 495 insertions(+), 314 deletions(-)

-- 
2.55.0

