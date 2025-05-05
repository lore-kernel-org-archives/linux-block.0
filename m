Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936A305F37;
	Mon,  5 May 2025 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484074; cv=none; b=q+EhGBeIzOOf6EgOD3rW+UD/CCLr8Qxr0Pji5y7wWhwtBHQ0WbKX3iAovb2Yh5uTNTyD/D7evHX09EL0peX67MAhM5ds52XOejCjF7GG09zdgwxUFJZ5YSDxliGm4BgNAPSYaVmM6SPORyMcFsvtiklJlLqWD/EuJESlQBHBJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484074; c=relaxed/simple;
	bh=aFQhGFvxnrjur6qu9AGhaT/avWTiCZyTVs2nMq3QG5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dtcegr2J3gIxxc7pQrYjQJsk05H2iwKsSMFajNSJqaULCcdxEL9qowMQ3ULfEM9J2rP8+GXAJZKzpFRJgG0Vspc2lNCTjaHTQ7zQ1+ZyRPnmiLRR+XVA980EsnG1MTwH+jRiiZDL5UjNbP3/dyupdqKjDgRVU9fBajBzhrcsf3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDynibQd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDynibQd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0822C4CEE4;
	Mon,  5 May 2025 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484074;
	bh=aFQhGFvxnrjur6qu9AGhaT/avWTiCZyTVs2nMq3QG5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iDynibQdjByp9zNcdwwVQXBOq89ayPWkfrVmcCU2RcXugJeRwcKjuxi+2MJK4P5Vc
	 gfS9EoKg6ZYhhLjps5O+0DHjpgqCIG1oewIBYckONyB+YUTRSFR9pYIBOUqk7Vdtmd
	 inY/rbemajyVgURDOfFAC38mtgV+uRA6hjrnGaiOKXNC9Afbre0UbhwtePqlWrr82E
	 DliJB9juuIQQxq5RvYMkqs95mNJh3BCXf6ZWmb4KwB5dgLo0tTaDBBPrPzH3eLoai9
	 uOVKok2tTH7+qoe5NzS5D/4qamdH//0KKebhSQ8XYXPXTjRsfU1l2WkDL9Ij9DofaS
	 vliMVEOWDbVSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 337/642] loop: check in LO_FLAGS_DIRECT_IO in loop_default_blocksize
Date: Mon,  5 May 2025 18:09:13 -0400
Message-Id: <20250505221419.2672473-337-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 1a90d7bd212e6..b8dcf24fab7de 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -900,7 +900,7 @@ static unsigned int loop_default_blocksize(struct loop_device *lo,
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

