Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036932C85;
	Fri, 11 Jul 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752223635; cv=none; b=R+ZOBJMNOVkjB7J2Gkg0bfXWX90HHq6WsC1+O//XMgmopc4Dh7tCutfKQk5T9nMUoxeTSayHmE+YNNt+OFvWsNPg0TKeXxme4KmONfHOSwLLren9QV03f1DyQHeQdcxCL+VxUmjhLcPuMINecKCeOVlxPTrv822WSR+1j1ERH+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752223635; c=relaxed/simple;
	bh=baGQ5YS+ZK9z3gpBSNqV5jmIr/yj6WC3OsLe7dghTtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OLXJAbMapbjbVWmSVTG5GD6ioVsDOEe+oTp1dDXG2JfIs3tJIZVYgghyx9QibRU3pX2+dX9gS0HVJAuYsr3Ee959PPO76EinFeA5r2GJHF8m8/xVKNMJs93n91Ppha3ospxj7eYdg4rSMRnS/5syndyJVMtZ/8MxQAFz04KcxpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0ITwQRX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0ITwQRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D34C4CEED;
	Fri, 11 Jul 2025 08:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752223634;
	bh=baGQ5YS+ZK9z3gpBSNqV5jmIr/yj6WC3OsLe7dghTtY=;
	h=From:To:Cc:Subject:Date:From;
	b=X0ITwQRX/rlibabBo0I/BUxPaQ4zbbm4hbsuv71QWtie5V3oJDusa3w+A0YZsO6X5
	 dGXqnwxse2lM1QzeDt81+b+LuWUnVCxVKRfzcZc3qbEGtA7tTEpAGcZIvhn17I/yaZ
	 zfrdlglDOQzmIs5pgEm6Unl3i8t0hvzk6KruiAJdVEeBrViBUBnO2Z1RJMxZ5saDDO
	 s9wNQPG4Wmr0db2Yq/U68buOiCXP4xbfYKVuQr54RzqGk7NToumYMukJ7AFND4RAO6
	 wz0X36I0aTLXTCR19nxiH4Hk/c6pHZ8esLfCswLfn3hXBq6HqYGLIREquXvwWyK7kZ
	 fJtqkyhcFTGpg==
From: Arnd Bergmann <arnd@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in blkdev_common_ioctl()
Date: Fri, 11 Jul 2025 10:46:51 +0200
Message-Id: <20250711084708.2714436-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
handling in the blockdev ioctl handler breaks all ioctls with
_IOC_NR==2, as the new command is not added to the switch but only
a few of the command bits are check.

Move the check into the blk_get_meta_cap() function itself and make
it return -ENOIOCTLCMD for any unsupported command code, including
those with a smaller size that previously returned -EINVAL.

For consistency this also drops the check for NULL 'arg' that
is really useless, as any invalid pointer should return -EFAULT.

Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")
Link: https://lore.kernel.org/all/CA+G9fYvk9HHE5UJ7cdJHTcY6P5JKnp+_e+sdC5U-ZQFTP9_hqQ@mail.gmail.com/
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add the check in blk-integrity.c instead of ioctl.c

I've left out the maximum-size check this time, as there was no
consensus on whether there should be one, or what value.

We still need to come up with a better way of handling these in
general, for now the patch just addresses the immediate regression
that Naresh found.

I have also sent a handful of patches for other drivers that have
variations of the same bug.
---
 block/blk-integrity.c | 10 ++++++----
 block/ioctl.c         |  6 ++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 9d9dc9c32083..61a79e19c78f 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -62,10 +62,12 @@ int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
 	struct logical_block_metadata_cap meta_cap = {};
 	size_t usize = _IOC_SIZE(cmd);
 
-	if (!argp)
-		return -EINVAL;
-	if (usize < LBMD_SIZE_VER0)
-		return -EINVAL;
+	if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
+	    _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
+	    _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
+	    _IOC_SIZE(cmd) < LBMD_SIZE_VER0)
+		return -ENOIOCTLCMD;
+
 	if (!bi)
 		goto out;
 
diff --git a/block/ioctl.c b/block/ioctl.c
index 9ad403733e19..af2e22e5533c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -566,9 +566,11 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 			       void __user *argp)
 {
 	unsigned int max_sectors;
+	int ret;
 
-	if (_IOC_NR(cmd) == _IOC_NR(FS_IOC_GETLBMD_CAP))
-		return blk_get_meta_cap(bdev, cmd, argp);
+	ret = blk_get_meta_cap(bdev, cmd, argp);
+	if (ret != -ENOIOCTLCMD)
+		return ret;
 
 	switch (cmd) {
 	case BLKFLSBUF:
-- 
2.39.5

