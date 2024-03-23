Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D21B17583
	for <linux-block@vger.kernel.org>; Sat, 23 Mar 2024 14:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711205668; cv=none; b=T5AhmVLrj4C6lsLF7kx7IJ1TsZxTJsmjYYMGPeIzp0c+VOI2cBde0IZ01pFSo+DLkUFgB7KvErHefAQ+k0W5zQFPCKSFXF9ILa3KZTdLXh2KvmQPqSSA59ZEk0k+zwjisirwaqWVRBRHdm+ipaHK0vIzTX55kHOdVlA1jkSvhCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711205668; c=relaxed/simple;
	bh=FvcziWK1Wa23PWpNbLs629FKv7tHF/26TbVguwHEfUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaZA5eqAITsh98Cpyq7ibL9EoVPrtLCtujl/9c+U1l4tJyQfgKjGq7BIMe49PuVeozMjs4AcyNL4x9lZSAAa3SKstGk0Wfp+qpiYAljPw57s+TrR5VduO5fCXWLNLbsB8UHtanynBXFpzzb8ltNSzLAiA1trQ/rgDX5u9HZlMrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSUf7v7K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSUf7v7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B43C433C7;
	Sat, 23 Mar 2024 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711205667;
	bh=FvcziWK1Wa23PWpNbLs629FKv7tHF/26TbVguwHEfUc=;
	h=From:To:Cc:Subject:Date:From;
	b=bSUf7v7KzMbndbxsxm7hEk/sNMGOdj7yb+w4vv5mJDkDKv8sZ7g7jXo4JQzIs71AK
	 pB0iDr8pAcQl9cXlD3WZyTCnR83pDqp+y6/fGbDVpF0aDhPbIsBziUHnJOU0tUuegM
	 ktuU/U8pzshwP1s6hDL2rjv0slTt1X3OowyylWZH/2Ity3yT6au0wPYsmtVz7gPhw7
	 mPwg/wHk+SEymAFtc2KIIkE0Rs0ks8ioOH2DE3lTDsUq4qBgD1Wi+dg4vMvbeomZJC
	 BOWYrdD2g0wpv8MSSL0EYGja0693Wpn/iCgNw8gBmKuftzWnySPGnE2a1QIqmNb714
	 DlMNEBacVdGKg==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH] block: handle BLK_OPEN_RESTRICT_WRITES correctly
Date: Sat, 23 Mar 2024 15:54:00 +0100
Message-ID: <20240323-seide-erbrachten-5c60873fadc1@brauner>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5821; i=brauner@kernel.org; h=from:subject:message-id; bh=FvcziWK1Wa23PWpNbLs629FKv7tHF/26TbVguwHEfUc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT+e8sf/G3mqwum80MyJGaxfqypCpvMxsHT7bFmXxbft 1VWTQypHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOJ38TIcDUzXEVwVvq+cM2A 9gVr/m755JliMz20bmryWT6G9CnMmxkZFt5s5Fi31erhQmYR560FOQIBfIejhN+07um2lfxjZrq IDwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Last kernel release we introduce CONFIG_BLK_DEV_WRITE_MOUNTED. By
default this option is set. When it is set the long-standing behavior
of being able to write to mounted block devices is enabled.

But in order to guard against unintended corruption by writing to the
block device buffer cache CONFIG_BLK_DEV_WRITE_MOUNTED can be turned
off. In that case it isn't possible to write to mounted block devices
anymore.

A filesystem may open its block devices with BLK_OPEN_RESTRICT_WRITES
which disallows concurrent BLK_OPEN_WRITE access. When we still had the
bdev handle around we could recognize BLK_OPEN_RESTRICT_WRITES because
the mode was passed around. Since we managed to get rid of the bdev
handle we changed that logic to recognize BLK_OPEN_RESTRICT_WRITES based
on whether the file was opened writable and writes to that block device
are blocked. That logic doesn't work because we do allow
BLK_OPEN_RESTRICT_WRITES to be specified without BLK_OPEN_WRITE.

So fix the detection logic. When we open a block device with
BLK_OPEN_RESTRICT_WRITES we know that a holder must've been specified as
we forbid BLK_OPEN_RESTRICT_WRITES without a holder in
bdev_permission(). The holder will be stashed in
bdev_file->private_data. So we check whether bdev_file->private_data is
set and whether writes are blocked. If so, we unblock writes. Otherwise,
if the bdev_file was opened writable we just decrement the write count.

Note that BLK_OPEN_RESTRICT_WRITES is an internal only flag that cannot
directly be raised by userspace. It is implicitly raised during
mounting. So any concurrent writable request from userspace will fail
and so recognition based on bdev_file->private_data is safe.

Passes xftests and blktests with CONFIG_BLK_DEV_WRITE_MOUNTED set and
unset.

Fixes: 321de651fa56 ("block: don't rely on BLK_OPEN_RESTRICT_WRITES when yielding write access")
Reported-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/r/ZfyyEwu9Uq5Pgb94@casper.infradead.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
@Jan, I have one question for you. Currently your original changes in
v6.8 do allow for a block device to be reopened with
BLK_OPEN_RESTRICT_WRITES provided the same holder is used as per
bdev_may_open(). I think that may have a bug.

The first opener @f1 of that block device will set bdev->bd_writers to
-1. The second opener @f2 using the same holder will pass the check in
bdev_may_open() that bdev->bd_writers must not be greater than zero.

The first opener @f1 now closes the block device and in bdev_release()
will end up calling bdev_yield_write_access() which calls
bdev_writes_blocked() and sets bdev->bd_writers to 0 again.

Now @f2 holds a file to that block device which was opened with
exclusive write access but bdev->bd_writers has been reset to 0.

So now @f3 comes along and succeeds in opening the block device with
BLK_OPEN_WRITE betraying @f2's request to have exclusive write access.

This isn't a practical issue yet because afaict there's no codepath
inside the kernel that reopenes the same block device with
BLK_OPEN_RESTRICT_WRITES but it will be if there is.

If that's right then either this needs to be fixed by counting the
number of BLK_OPEN_RESTRICT_WRITES a la [1] or we simply enforce that
BLK_OPEN_RESTRICT_WRITES means that there's only one opener a la [2].

[1]: count BLK_OPEN_RESTRICT_WRITES openers

     diff --git a/block/bdev.c b/block/bdev.c
     index 4b28a39fafc4..ea3f219310f5 100644
     --- a/block/bdev.c
     +++ b/block/bdev.c
     @@ -776,17 +776,17 @@ void blkdev_put_no_open(struct block_device *bdev)

      static bool bdev_writes_blocked(struct block_device *bdev)
      {
     -       return bdev->bd_writers == -1;
     +       return bdev->bd_writers < 0;
      }

      static void bdev_block_writes(struct block_device *bdev)
      {
     -       bdev->bd_writers = -1;
     +       bdev->bd_writers--;
      }

      static void bdev_unblock_writes(struct block_device *bdev)
      {
     -       bdev->bd_writers = 0;
     +       bdev->bd_writers++;
      }

 static bool bdev_may_open(struct block_device *bdev, blk_mode_t mode)

[2]: enforce that BLK_OPEN_RESTRICT_WRITES is unique

     diff --git a/block/bdev.c b/block/bdev.c
     index e9f1b12bd75c..cefb94a75530 100644
     --- a/block/bdev.c
     +++ b/block/bdev.c
     @@ -758,7 +758,7 @@ static bool bdev_may_open(struct block_device *bdev, blk_mode_t mode)
             /* Writes blocked? */
             if (mode & BLK_OPEN_WRITE && bdev_writes_blocked(bdev))
                     return false;
     -       if (mode & BLK_OPEN_RESTRICT_WRITES && bdev->bd_writers > 0)
     +       if (mode & BLK_OPEN_RESTRICT_WRITES && bdev->bd_writers != 0)
                     return false;
             return true;
      }

But maybe I'm just not reading this right. Let me know.

Christian
---
 block/bdev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e..4b28a39fafc4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -821,13 +821,14 @@ static void bdev_yield_write_access(struct file *bdev_file)
 		return;
 
 	bdev = file_bdev(bdev_file);
-	/* Yield exclusive or shared write access. */
-	if (bdev_file->f_mode & FMODE_WRITE) {
-		if (bdev_writes_blocked(bdev))
-			bdev_unblock_writes(bdev);
-		else
-			bdev->bd_writers--;
-	}
+	/*
+	 * If this was an exclusive open and writes are blocked
+	 * we know that we're the ones who blocked them.
+	 */
+	if (bdev_file->private_data && bdev_writes_blocked(bdev))
+		bdev_unblock_writes(bdev);
+	else if (bdev_file->f_mode & FMODE_WRITE)
+		bdev->bd_writers--;
 }
 
 /**
-- 
2.43.0

