Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9A331EC2
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032298; cv=none; b=ceiSf+8yr1pBWAbqPpato7GtpttBIgiegEZGlWIFa1mXuuvK4A9uyYerINGLsgwfiaUXJjj773gzlBOEYcJWMCpbsA0tUWdtc2iO25vcLB8AyAy+sD0s47ucOrx/bQ4zGLCUOI8F9gnN5N7U/16+3jCk491wjLHJ/NiEQYYLiFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032298; c=relaxed/simple;
	bh=TJVUp541FZvXuB2tJ2aLIrwaBMxPVwdtcSnwusitp6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y+q5lkYihDV4CT9NM1SJGi5fUfpAu9U0mBOMY1aEvTJSaF5kV0KNuCqcl29ziY+IjnTyS+mWAZIaNuG1P3YOeUJNSNW8xkiWRWbQ5CjN/bCZs7it0dEQEAprGiQdTAFf1fZbN2DqNwhjrtDZ555aDGSzKNOykRwEkqQKuwVcKdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVL3J+wY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVL3J+wY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE2CE1F000E9;
	Thu,  6 Aug 2026 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786032297;
	bh=5adyzzCgULZCdRj8Dj1r8weDuXmOUIAubxtmaxphgvk=;
	h=From:To:Cc:Subject:Date;
	b=FVL3J+wYg6rcXch9/kDDD3OhBRCohlM7A/orAb+C8XP0J6RvsPSkSE5u3r0E601CA
	 l52Py+mvQKoTKznKtw8JkMg/u/wKoS/AlrNpf3ai3N5Cs8uTEUOPgS7vmP1ELuW7sI
	 U+fWGT9j/HE0DsjJhGBJWB4rHoBqjNzYRAnxk1xINrx0KBH2BjBn/jgfB7d9LH6pny
	 couYRydh1E98+4McNqYdcQWZa6KOWEM4XiDQl/FdQOciosC//AMJ7BYd1ynAFAXYWg
	 xc4PeRyx2GH2M8/ymtNpaHzMPbifl1ANd4IWgHVwfh47m6OclbIHSojW9+9IgDHmym
	 PZmexkS27fK1Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 00/13] Improve handling of offline and read-only zones
Date: Fri,  7 Aug 2026 01:04:32 +0900
Message-ID: <20260806160445.848337-1-dlemoal@kernel.org>
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
 block/blk-zoned.c      | 778 +++++++++++++++++++++++++----------------
 block/blk.h            |   6 +
 block/genhd.c          |   7 +
 include/linux/blkdev.h |   2 +-
 5 files changed, 486 insertions(+), 314 deletions(-)

-- 
2.55.0

