Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2980023C9
	for <linux-block@vger.kernel.org>; Tue, 28 May 2024 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877735; cv=none; b=X3fjbOILEbI3six7C9TdBPmhTnSNU61m1E1MulZ+2fLJm6v/xuzhhHXgnNvnNbv2TVMTHLtNkz8XSTRCkp6MQbbqPfmQQ9vDNnOAPEqWKGkXhX4GScfuYHZF2bgMIP/hINALbeSH9iP6BbisUFBVtnKxHyMgdfvET6QKcgevgK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877735; c=relaxed/simple;
	bh=EZcPaKGqPkm4sCZIAQ4m6dMMeBWczsW78U41g2vY5us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vj3xsnNH+BiqZmf7oXzaO0HKbO4yL40Ky16G4luYkwDAFNP4QzQcW2FfKnrbaKwZELyRgUBM21+Sv51qhJ48Rvesibimsxl21Zxtywa0yQeZ3c2S12e26u2sQfSVcmtvYFt3L0k83kGANf4FcIxBrFMG4TF76/XwOWGJUUHhA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drjX7T5X; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drjX7T5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E065C3277B;
	Tue, 28 May 2024 06:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716877734;
	bh=EZcPaKGqPkm4sCZIAQ4m6dMMeBWczsW78U41g2vY5us=;
	h=From:To:Cc:Subject:Date:From;
	b=drjX7T5XSXQxINt3g4ymLAw8jqQqjpYSwydBapbB39WNpS4CRdfs/oxxMqSEjFrnB
	 f7BvjqgrNCiSX8UYPEPK1kj1JMiwc3OD06+5s9jF7RgkiVvFn6mvZxUyifd+rmf0jt
	 1t+CC3x1PMmBX41ZDOKi8UYEi/bcHY9ZDFSV9KkswoPAGraPh8LnjcmRajfdcQBpws
	 p3/mE/6FSGRQFDyn9ke9PDbjwJPFWi4Rfdz6CGpHSQMxDINXHipGrry4hcqjuR8SRM
	 4UfvsKOGBq2A5PsxssvOkHo2DNNOBoDLWas0Dh2Q1eoe1xAiZq9RjWt+C20pJsVo46
	 mpKG5QlJaveag==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] null_blk: Print correct max open zones limit in null_init_zoned_dev()
Date: Tue, 28 May 2024 15:28:52 +0900
Message-ID: <20240528062852.437599-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When changing the maximum number of open zones, print that number
instead of the total number of zones.

Fixes: dc4d137ee3b7 ("null_blk: add support for max open/active zone limit for zoned devices")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/zoned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 5b5a63adacc1..79c8e5e99f7f 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -108,7 +108,7 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	if (dev->zone_max_active && dev->zone_max_open > dev->zone_max_active) {
 		dev->zone_max_open = dev->zone_max_active;
 		pr_info("changed the maximum number of open zones to %u\n",
-			dev->nr_zones);
+			dev->zone_max_open);
 	} else if (dev->zone_max_open >= dev->nr_zones - dev->zone_nr_conv) {
 		dev->zone_max_open = 0;
 		pr_info("zone_max_open limit disabled, limit >= zone count\n");
-- 
2.45.1

