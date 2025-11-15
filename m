Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38BD2877CF
	for <linux-block@vger.kernel.org>; Sat, 15 Nov 2025 12:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763209198; cv=none; b=XEweXJwa+Lt2alRbQ07FlU+JmLuY+19pHSgCvuaPQGWuAGj2/9qZo81oN/XdLAcCshmwe7qzui15VlkSqb5Js+OrMfiDd6kAfrwMCGZhhYrNaYvkfjqwMU+IGZtn8GRTam1ud4c49KmtMq/9WdQXd5OHt1HG8TLrjX9uObS8g3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763209198; c=relaxed/simple;
	bh=mDweGqmebyFPe2zVflYVy7xRe7lDNXXX204FfFWC/sI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szz+CdUL8TJ5YxXftW5N6Rz1KlcF72MlO6jSw9f6UIliKzjk3vRSqG1qkSgVZ+tykwXwxjbLUIaL1fpTMEifvdWzIXrm78YD25Bci7me9s3qAXjixpB+buj0EG2CfFND3XPlD79JHH0XYJw3tQMeQ0dX4Gv0Q27uBRDEYA8bYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5TqujON; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5TqujON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958F7C4CEF5;
	Sat, 15 Nov 2025 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763209198;
	bh=mDweGqmebyFPe2zVflYVy7xRe7lDNXXX204FfFWC/sI=;
	h=From:To:Cc:Subject:Date:From;
	b=L5TqujONcU0rZmU/HMTgnlrO/gEBbtraQfUlYtwD8VXKvYzKUFeTT+anB5oRoiVme
	 01xhFEYxjLX/9gHvB3jQiDbPjUlPw8TMzdg8zn13BVrMSZDEcxdipYUp8xN11A4sft
	 MqnuQb1A1dGXQFq7YqYb88FfEqBXVKyiBTM4Plk8nnO8uYqsLC10gtgDe6Ec8ny1Qf
	 uoiM6eCQZcRf1AG+N1azxQmvsI9204Uh5MeC6bE0DI09JeyKvs0SA96Z/Smv8h0AbT
	 Xyn5jNtv84vo01oqsjpj0KfQJayAIS6H+uwo5ZoPKaIj4wUCaYVoaGv2D5A+1ZivtT
	 4bqejE9jLQ/ow==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 0/6] zloop fixes and improvements
Date: Sat, 15 Nov 2025 21:15:50 +0900
Message-ID: <20251115121556.196104-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jens,

The first 2 patches are simple fixes for the zloop driver. The third
patch is a simple refactoring. Finally, patch 4 and 5 introduce new
configuration parameters that are very useful for testing the block
layer zone append emulation done as part of zone write plugging (patch
4) and to test file systems that use zone append (XFS and btrfs) by
changing the processing behavior of zone append operations in zloop.

The last patch updates zloop documentation.

Damien Le Moal (6):
  zloop: make the write pointer of full zones invalid
  zloop: fail zone append operations that are targeting full zones
  zloop: simplify checks for writes to sequential zones
  zloop: introduce the zone_append configuration parameter
  zloop: introduce the ordered_zone_append configuration parameter
  Documentation: admin-guide: blockdev: update zloop parameters

 .../admin-guide/blockdev/zoned_loop.rst       |  61 ++++---
 drivers/block/zloop.c                         | 151 ++++++++++++++++--
 2 files changed, 171 insertions(+), 41 deletions(-)

-- 
2.51.1

