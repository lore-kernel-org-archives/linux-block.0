Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C08B2BFC82;
	Mon,  5 May 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485320; cv=none; b=VaJDpC++i38kz8UcQ7GnwqiBP7wtnEbO3YwXDmOZLen32zYfbijgwbtlIe3El2c+N+AXEa9ceC16ZNPgyCvTOb3WpYjeB+R36J35NrQlDSKwhgpghLfLex/P9UGM9L2GHHmtJTYMBAh3zJ8DUsPr9dcG4ddCVG/48I6Qb0s6ux0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485320; c=relaxed/simple;
	bh=t+QCatSdLPN21Wm4l9aOfZivRhcWh+CBaN4H/deEcXQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kXDEdXvO4DaEe0/XT4/9MGvpFql2E9SU4DnhWB5kLF8SOxShdhQi4DuOsL21ZA4HG1mHfuMA3yCedW4u20B1UArJt1NDt6UgflyuoyXmUjC1NMf+bWnb9LGEjIVS9B/RYHgrE3srIq3M+oXezgKrAETVEFlzZbsAuo1g2hkgDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUNZLWfN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUNZLWfN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F485C4CEED;
	Mon,  5 May 2025 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485320;
	bh=t+QCatSdLPN21Wm4l9aOfZivRhcWh+CBaN4H/deEcXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lUNZLWfN9WLUDasz7iDlIcFrBEDAUzvn3G4/H4qmAP4XVW8tFAMWurmg2fC+3d7lD
	 zlkwTl6zZhcBCuKHVN1FxmaXFTtmIzVRI821aj8P1BGzkzW09J7X03/QfMZsV0k5iI
	 mU2KjE7zb9BBBoBbGppbjP1yuCr5sS6wYfQKfQZvPdZSdBS1PdueYWLTIipsTR5mpr
	 9HkYc0Ks6t2ZLe5Q5u3qF0RvFbA7Tk5udzVmTugldm3KHaZSD7f1jBNXuQjaLHk9Lr
	 UugKDSk4rIdj7itVhq7lUMWqyWjbFLLcibLdcSSZo2BrgSwMCq646PGA4Y39ng5v5l
	 ydPHlnOg0BUuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 265/486] loop: check in LO_FLAGS_DIRECT_IO in loop_default_blocksize
Date: Mon,  5 May 2025 18:35:41 -0400
Message-Id: <20250505223922.2682012-265-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit f6f9e32fe1e454ae8ac0190b2c2bd6074914beec ]

We can't go below the minimum direct I/O size no matter if direct I/O is
enabled by passing in an O_DIRECT file descriptor or due to the explicit
flag.  Now that LO_FLAGS_DIRECT_IO is set earlier after assigning a
backing file, loop_default_blocksize can check it instead of the
O_DIRECT flag to handle both conditions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Link: https://lore.kernel.org/r/20250131120120.1315125-4-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8827a768284ac..9f7147bf8646d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -905,7 +905,7 @@ static unsigned int loop_default_blocksize(struct loop_device *lo,
 		struct block_device *backing_bdev)
 {
 	/* In case of direct I/O, match underlying block size */
-	if ((lo->lo_backing_file->f_flags & O_DIRECT) && backing_bdev)
+	if ((lo->lo_flags & LO_FLAGS_DIRECT_IO) && backing_bdev)
 		return bdev_logical_block_size(backing_bdev);
 	return SECTOR_SIZE;
 }
-- 
2.39.5

