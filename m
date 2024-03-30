Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10AB7E2
	for <linux-block@vger.kernel.org>; Sat, 30 Mar 2024 00:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711759983; cv=none; b=ugPhfG7H82LK1dmgPWC3aFkt6lxAX2G7HqlyL2gFdnZ1FkO0iewZfLitR9dJFdbje4WXAvPSm/i/B3r9V1TsxMhABgLlIvvLYWCW2Jt7I38D35hamq2bdizzOMwqeooDZ23lBXAjnWH8lNl6KXYHfMQ0R80Pqnp9is1vLiqE45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711759983; c=relaxed/simple;
	bh=bW0SP64jbFe83aLCmUN1RZD6FQ2HugMn0icOdSsNxZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jn6BNJxr9YRqQggYk3glVSIh4I3CUznqEHjYvQ4UQcUgTn7HYjqrKQ2lTaI+oQFBLsl9HB7TDhJa69MyT8N5WHiJ2u5YfW7PdoP6aXLnVZf4bdNLCGnqik2eijYb0KpUM0iRZyXyYebonCqjhW/f4RvXnaMLWJANExQpiy9YJT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjvHmjZc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjvHmjZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1BDC433C7;
	Sat, 30 Mar 2024 00:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711759982;
	bh=bW0SP64jbFe83aLCmUN1RZD6FQ2HugMn0icOdSsNxZE=;
	h=From:To:Cc:Subject:Date:From;
	b=HjvHmjZcRuIGKKSaUTpOXDWNcBZQ/H6kKlfvfgYfASX3GOzpM3EWs5f1QQM9ATBxm
	 i+pQvRuReTRErWAI8KYNTKWANMZxN0YZCBxzn8OxuC6HmtD2RMfPHKZuiDU7537BHr
	 ZyKoUttfKgOLFxyikjqqThJHtpM7nOtDRQURuXEO5RJbt8W9+1XHdj2wgKeK/LCok6
	 OO+11U39HSa3t6bTJ0vqhHlIr/X/2cTlhhVBSAsLZzjIEe3kSI0yJ4HtNHSIZqOhFo
	 8RlEs1dh67F9b6R1BNE70JYBEOPOvPwRTY1t0ArTcx3vb2cR1Zfr4NgX9yNyidzEre
	 j4clBOxpR+0qw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nullblk: Fix cleanup order in null_add_dev() error path
Date: Sat, 30 Mar 2024 09:53:00 +0900
Message-ID: <20240330005300.1503252-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In null_add_dev(), if an error happen after initializing the resources
for a zoned null block device, we must free these resources before
exiting the function. To ensure this, move the out_cleanup_zone label
after out_cleanup_disk as we jump to this latter label if an error
happens after calling null_init_zoned_dev().

Fixes: e440626b1caf ("null_blk: pass queue_limits to blk_mq_alloc_disk")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 71c39bcd872c..ed33cf7192d2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1965,10 +1965,10 @@ static int null_add_dev(struct nullb_device *dev)
 
 out_ida_free:
 	ida_free(&nullb_indexes, nullb->index);
-out_cleanup_zone:
-	null_free_zoned_dev(dev);
 out_cleanup_disk:
 	put_disk(nullb->disk);
+out_cleanup_zone:
+	null_free_zoned_dev(dev);
 out_cleanup_tags:
 	if (nullb->tag_set == &nullb->__tag_set)
 		blk_mq_free_tag_set(nullb->tag_set);
-- 
2.44.0

