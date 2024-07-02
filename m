Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9CB12D1E8
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 07:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719905556; cv=none; b=prr+IBsVXYuRxFO5/+ShLoh7e2w942N8G9qd/3dCsMofbjzI/zc53w4ceFCT9P0keLQX5OmrEICQ5bWQamso8JQ/LNkN7a8z7DZNEil0Fl+l8AdBlE9dgRmtVmUbupguqf9AMwzO0YCig9cmCW8+WEvSU0ooqeyPYrBjsXXQho8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719905556; c=relaxed/simple;
	bh=51do8JK2nANNS9yC0sXTfEh2IT4F7P6OTTLhaxAaFWE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aJ0CvG0aimjdrjz2J0epwgTbzqeQrKMKhqeyKFdmXnPG5goZIeYmLwDGuhkEDvjOt7mU7R7cUMh34rCf0jPqBN6KJpjjKcFN7977L9MXbHuZl8PRalBuf4ts72vcwHPL0rJsDM2RB60u7LsA/mdjLhAzkFVmdxetxAxTgKvP2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZG3ctTi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZG3ctTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B733C116B1;
	Tue,  2 Jul 2024 07:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719905555;
	bh=51do8JK2nANNS9yC0sXTfEh2IT4F7P6OTTLhaxAaFWE=;
	h=From:To:Subject:Date:From;
	b=sZG3ctTiYcudbOOfNhu2kFP60O34SLBG/T8gbFWGPx5GXSoLnH+fBq9K+g7Y8fSgP
	 BbMxURA2xPfMLN4yHn6/DRkz12xZ3sYualJ6DMGgsFMEBPA9as2gkox/gLwnC1pp8v
	 5/DN41pvBrSkSQEVlrGik4QFJ89zLBUV3oEJGHGrV2qHIUXubx+MClxHb2RQNe77e+
	 xtTu6AgXKbYrUAylZ3Xe+sHu4X8rTblBZZYvsExyWtR5Gk8y7g9drbENdZfqcV6xXf
	 6FlL6dXHvi8t/kxo30aFt7mpriWxyMXRfpn60lrOWlgpZFzByxpaJUQnwOPeQrv1L2
	 B2mn5UWqW4Obg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] null_blk: Fix description of the fua parameter
Date: Tue,  2 Jul 2024 16:32:34 +0900
Message-ID: <20240702073234.206458-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The description of the fua module parameter is defined using
MODULE_PARM_DESC() with the first argument passed being "zoned". That is
the wrong name, obviously. Fix that by using the correct "fua" parameter
name so that "modinfo null_blk" displays correct information.

Fixes: f4f84586c8b9 ("null_blk: Introduce fua attribute")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 83a4ebe4763a..5de9ca4eceb4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -227,7 +227,7 @@ MODULE_PARM_DESC(mbps, "Cache size in MiB for memory-backed device. Default: 0 (
 
 static bool g_fua = true;
 module_param_named(fua, g_fua, bool, 0444);
-MODULE_PARM_DESC(zoned, "Enable/disable FUA support when cache_size is used. Default: true");
+MODULE_PARM_DESC(fua, "Enable/disable FUA support when cache_size is used. Default: true");
 
 static unsigned int g_mbps;
 module_param_named(mbps, g_mbps, uint, 0444);
-- 
2.45.2

