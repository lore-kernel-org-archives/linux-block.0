Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9A9374731
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671934; cv=none; b=V5XWhS/6kEBvnsqoFvy0pRKkQGvjb4E1Wfx+Wk5cNduasmwjw9skrxmcQHukN6UmE05Fw+jQKa9c3Q13iNUNGKcQE4ah7xtL/1GlqGrpUFTc5Xt0Kta9BwFoV3sPSkFJKEJGDOmxThb7mVwuDulWC+ms5MePzmXnk41zX5fCYjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671934; c=relaxed/simple;
	bh=AkViob5+TxtFCQ43CbplvbofciMpOiLo8XwJ4uxJsag=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IwIkS7rtfkTXEYOHh+YxDSMjDuG3+Pzw+pdak1G+uXfCui7o6CjyESX+567M/NbOC2POqp+zRm3nmQwNb1RIOSIye1XEF21n0M8P+rzHBIwSI/GmOIIK7n6TG0871CtzjYcvHoTVBgqpoASFlQ/IqML4LeAJ1G3DGIwcutfk1Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1sCmNCg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1sCmNCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D59C16AAE;
	Thu, 29 Jan 2026 07:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769671934;
	bh=AkViob5+TxtFCQ43CbplvbofciMpOiLo8XwJ4uxJsag=;
	h=From:To:Subject:Date:From;
	b=A1sCmNCgCN/G3cNBxM7RdIrKndZE+UhQBkjNE+JuTjdJUDBVIPlKJk4t1RTh/gDcL
	 E6au6k0/cVHobDUKiNgN8WbyMfyF/bVjCF4tBNy1WGGuG9cz9CyPqiJItvLPZPXav8
	 Ph3QB1iZLmCrEos+4BauawdlidvozT27AfKtwEEcEUjwWiP8Mq4YZqEgoRXUcDv6ZS
	 b7VMQQAwFmKWCIIvaFUPnhp8csLuO+QVpDqR52AVW20V9ppBQ4i8fyi590dxMq016r
	 7IyzurXYbvlekHZkswGTfBH3L8B/1IxV68wgfe1pJ3B1pa4sKN2NV+966eLhgmjW6a
	 zG74YfZYG1poQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 0/2] Cleanup patches
Date: Thu, 29 Jan 2026 16:27:13 +0900
Message-ID: <20260129072715.1107336-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

Here is a couple of cleanup patches for the block layer.
No functional changes are introduced by these patches.

Damien Le Moal (2):
  block: cleanup queue limit features definition
  block: introduce blk_queue_rot()

 block/bfq-iosched.c    | 20 ++++++++++----------
 block/blk-iocost.c     |  2 +-
 block/blk-iolatency.c  |  5 +----
 block/blk-wbt.c        |  5 ++---
 include/linux/blkdev.h | 11 +++++------
 5 files changed, 19 insertions(+), 24 deletions(-)

-- 
2.52.0

