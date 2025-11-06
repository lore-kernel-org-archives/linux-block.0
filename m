Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992AA2F3C2A
	for <linux-block@vger.kernel.org>; Thu,  6 Nov 2025 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440818; cv=none; b=l7KW7cHWsiRLoWYRJLAciIEwF6Z0toagUxaqiGEUtRr+D9yFIv+B2l8yk1zzt0VJt3RMRY8ibgcXUgu/pR8v/ub+GxUZmnddsNDP1jmn9w1kBxrmCWKQxZh2mkL8B3/K/CDeTifAQKi4zibS7TYE4G8OjJwGaGoFOC0yMA8zFHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440818; c=relaxed/simple;
	bh=YGxA2MYPLrAfPt2XZMYmUXTB0lf8Im0yGIepfvK3uNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lH0siFArnaK7W9xmBCfzGF3MhtK/QyiehEyqG+jQz+NktSfCTmnkayG0mYdMcebs84MEkrDPoeHg0WttQQVHRo14prv1XoHxhffNjsKX8/GCf0iXkbawFMLF4ryMvP/VjL4/HK2QWLJaMKHaEKdRTC5YB7b4li4VHUOSjfw//IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B0184227AAE; Thu,  6 Nov 2025 15:53:32 +0100 (CET)
Date: Thu, 6 Nov 2025 15:53:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 3/2] block: don't return 1 for the fallback case in
 blkdev_get_zone_info
Message-ID: <20251106145332.GA15681@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

blkdev_do_report_zones returns the number of reported zones, but
blkdev_get_zone_info returns 0 or an errno.  Translate to the expected
return value in blkdev_report_zone_fallback.

Fixes: b037d41762fd ("block: introduce blkdev_get_zone_info()")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c5226bcaaa94..8204214e3b89 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -895,8 +895,14 @@ static int blkdev_report_zone_fallback(struct block_device *bdev,
 		.data = zone,
 		.report_active = true,
 	};
+	int error;
 
-	return blkdev_do_report_zones(bdev, sector, 1, &args);
+	error = blkdev_do_report_zones(bdev, sector, 1, &args);
+	if (error < 0)
+		return error;
+	if (error == 0)
+		return -EIO;
+	return 0;
 }
 
 /*
-- 
2.47.3

