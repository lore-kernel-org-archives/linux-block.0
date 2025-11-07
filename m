Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBC72FBE13
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762497758; cv=none; b=OsU5QaullH83B60VtvOc1oxe+/68sZV4DnUSWVCX4yDB4KSh/S20dR0e9AzEcszUMFWJDKUHxVl9BRICjn02IVSreVivL4j5k55oIs7OOil4Q6s6rnHWidOVLEY/jGGCyN72xVUOKMbRLOGlLZUSPV5o0kUccQlnJN6zkBxYYsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762497758; c=relaxed/simple;
	bh=tXDqtEd0mS9opq0+1PMt7hZITC/DKkesbm1nfuE6F4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHti5BkShffJxwoBR29J5+xvuATPr6yH+NrzlY66J32whmHpG66ufDxGbww8QlBQmlvGWnRFqUL4X5Aju+AjNcMu9V9SZVWYMc2XfdxkSK8I7ce4ZdKmxkEZlADXnhHgITuBIzjWR3uAdPhIzvp0PU1NvOeDNz/E1KQAkeHHwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9PhHA7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9PhHA7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D2C4CEF8;
	Fri,  7 Nov 2025 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762497757;
	bh=tXDqtEd0mS9opq0+1PMt7hZITC/DKkesbm1nfuE6F4s=;
	h=From:To:Cc:Subject:Date:From;
	b=l9PhHA7k4UbHyJsls3ykfYO4cW2H3hWH69sc06cMF9SXOn/hFZi8kKax343xiN+dW
	 vr7a8uF/QgFcbGu5DNzl4bngBvS+GpVZltCLbK0AUyjL4HDYMokUl+ND8PStC7cfjW
	 ISN/ETjcKYcOkqoDXUxnR5v/WqhDjPOWNDdYWtFTW+9yv1yvbyc2A17Ke7GpulPEDw
	 b5FSEfeG+5C0Ynznkri6Fd7HMv8O2LJ56PBvyvp85WYLArDaLBffVpCzpPvuX1CDIG
	 cCJmpVfm5daji2nXTyYNZoAtbr0jfvUMK3lmiJfbwLOH2OhsDMAsPn7CJ1rHZI4FNe
	 qgUKW6zPUfC1A==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/3] Zone related cleanups
Date: Fri,  7 Nov 2025 15:38:41 +0900
Message-ID: <20251107063844.151103-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

3 more patches to go on top of the cached report zone support (and its
fixes from Christoph)..
The first one improves blk_zone_wp_offset(), the second patch refactors
the use of this function to simplify the code a little. The last patch
introduces bdev_zone_start() as a replacement to using ALIGN_DOWN() for
getting the start sector of a zone.

Changes from v1:
 - Added patch 1
 - Changed patch 2 to not open code blk_zone_wp_offset() in
   disk_zone_wplug_sync_wp_offset().
 - Added review tags to patch 3

Damien Le Moal (3):
  block: improve blk_zone_wp_offset()
  block: refactor disk_zone_wplug_sync_wp_offset()
  block: introduce bdev_zone_start()

 block/blk-zoned.c      | 39 +++++++++++++++++++--------------------
 include/linux/blkdev.h |  6 ++++++
 2 files changed, 25 insertions(+), 20 deletions(-)

-- 
2.51.1

