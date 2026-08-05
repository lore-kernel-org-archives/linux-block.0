Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DF623BD05
	for <linux-block@vger.kernel.org>; Wed,  5 Aug 2026 02:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896852; cv=none; b=Zctdb6XIXdlp1pSj/KrvJjuiHqK69nGxBNJUYkNtUR4zhnXuPmTqjqbZG3x/htRkto8KbNaa2sqicwEEm0cTMlya41eT345d8lECQ/5N8O3FItOgZUoyFBmNbn8ADy873fHuDkG6Jx+NJvXMxlxtuWchAadxw3JP+namShZJ/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896852; c=relaxed/simple;
	bh=ciUQtf4jYtkWjfrVwwWq8icuvlOGUTLOOMM/nPdur5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ID+YA6NYbYbLwh64D+Lw9HPHusrw/gLyTX+0Pl9hXYAxw8oFkhqwK8kprYESXfD/hRAz7asBHDHT/1NL6TN2Y6i/Bo7Ziq7aPv3FsMIc1wYl1XMAlJ8UlmANqlujzVMFGXOZbQtdBVaLqrc4S3qpjJ4NzYvRVBquTs2F2W0x9cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5Pg/cRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5Pg/cRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A9F1F000E9;
	Wed,  5 Aug 2026 02:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785896851;
	bh=FCzTiYdew11OnFoCVJFsCfLRWvnWKKnqY5WX3lj8n6s=;
	h=From:To:Cc:Subject:Date;
	b=F5Pg/cRePJ5Hn1oE9rJl0c7M/frrntEpLNES0pr1Qyna9nQd2wExE+gjRxwLlJU2F
	 IhyRo7xED7h9auS7osTcn35wtkFvzUhzZsFVDoPi5Oqb74Oi9sZcQXxZHww9dJyiKV
	 daermrRp/jDEwyExeKw1zujVUBbTf1jH+n0VwJsWx1/IThJU9jH/LF/dwfC2JM+f3x
	 f4pvezFE4j7dH07rrx12vJJJV7vw7Jud1HPE+2jW2oHmNH6sH3C3I2T6A8iCqX36ln
	 FHznOH4DMEJ4bqnZOHo53P3HdNw2Sglr527Sjksp6kMl3r89aAZoEnf/S/qoHdvGEF
	 wqKHeszYJKkDg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 00/14] Improve handling of offline and read-only zones
Date: Wed,  5 Aug 2026 11:27:05 +0900
Message-ID: <20260805022719.735323-1-dlemoal@kernel.org>
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

Damien Le Moal (14):
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
  block: fail reads to offline zones early

 block/blk-core.c       |  12 +-
 block/blk-zoned.c      | 795 +++++++++++++++++++++++++----------------
 block/blk.h            |  12 +
 block/genhd.c          |   7 +
 include/linux/blkdev.h |   2 +-
 5 files changed, 514 insertions(+), 314 deletions(-)

-- 
2.55.0

