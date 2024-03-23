Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAB1EB34
	for <linux-block@vger.kernel.org>; Sat, 23 Mar 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711210295; cv=none; b=fe7W1DV/RmsiGk0l2WSeoL9fUtJtR79Ky9cOta0zpd1SIQKjRFYtD/HlUyxCXgyP7f560ziwlgmJJzjupV7hLJf0zr778Mbk5qQYuTlL+4xHF81/C14+J4bt/OlNnHu9OoGB4DlLzpg2QY/BNYU4Q/dMq0SJwto/71CziKsjbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711210295; c=relaxed/simple;
	bh=72k07Vg0UKLZ4eCoZd/amAxTFixToiDtGZ28b+Er4cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5xjMgERYWZMW+1WD6LVNgiVkWxIiJu9byZv2VVKiOOE1uXe2G+UXf7SzP0rpLORtW8VWNfbOucb6TWUJdjlQd8tA0+SnAS0JY0TmKr3+cpr3lPW73plzFqplg7Z1SMy5cMnWqAbw/GLTEMNZmtJhCzhpSGNECMh/z7hZjh9lMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWFmuQdR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWFmuQdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAABBC433F1;
	Sat, 23 Mar 2024 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711210295;
	bh=72k07Vg0UKLZ4eCoZd/amAxTFixToiDtGZ28b+Er4cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWFmuQdRsmkMgk2Of/GJ5TGMMjbEEeKEhKjn1BdQQqFqtnDujG0ASq+pahdFugSdc
	 ikvWbAZ6dphQRGy1RPd4PyWBHI2iZqh5/CFDpcg4u+TPilTrUo3zZLNPExC2Awz33u
	 B4esPfHeu8D2qd8MaCfry+965BiR2YJ5/5bVZ+CnY2AM8CT/0rJ3K+udHrVrlAey5m
	 TQ3o1lYS7k/7hNu9qEsXoiiHdYLz155Ue3y3TYLZ0ciQCjX019a3uk1UBEPoMdtqNH
	 ueQTLnTf9sruASZv9rwPa/lQYKes4A6trVFY/lMQQaUWLEb1ZqbKaEz3x/lV060tEJ
	 ghrNTmzA+KL+A==
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] [RFC]: block: count BLK_OPEN_RESTRICT_WRITES openers
Date: Sat, 23 Mar 2024 17:11:20 +0100
Message-ID: <20240323-abtauchen-klauen-c2953810082d@brauner>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
References: <20240323-seide-erbrachten-5c60873fadc1@brauner> 
 <20240323-zielbereich-mittragen-6fdf14876c3e@brauner>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132; i=brauner@kernel.org; h=from:subject:message-id; bh=72k07Vg0UKLZ4eCoZd/amAxTFixToiDtGZ28b+Er4cI=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaT++6+Z9mVitUr5spTTlR35kue2iU235Jj5+Hagv33sp yQ/6/PTOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZS68vI0K27Zdd//mqDKq3L y8W2znXTn3zj8v8pLE/WT73kniyiuoHhr1ihusyV8LfFpU3Gfx7UL1gc9Vj9HStHcYLI6+nnCuN ZWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The original changes in v6.8 do allow for a block device to be reopened
with BLK_OPEN_RESTRICT_WRITES provided the same holder is used as per
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

If that's right then fix this by counting the number of
BLK_OPEN_RESTRICT_WRITES openers. So we only allow writes again once all
BLK_OPEN_RESTRICT_WRITES openers are done.

Fixes: ed5cc702d311 ("block: Add config option to not allow writing to mounted devices")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 block/bdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index f819f3086905..42f84692404c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -776,17 +776,17 @@ void blkdev_put_no_open(struct block_device *bdev)
 
 static bool bdev_writes_blocked(struct block_device *bdev)
 {
-	return bdev->bd_writers == -1;
+	return bdev->bd_writers < 0;
 }
 
 static void bdev_block_writes(struct block_device *bdev)
 {
-	bdev->bd_writers = -1;
+	bdev->bd_writers--;
 }
 
 static void bdev_unblock_writes(struct block_device *bdev)
 {
-	bdev->bd_writers = 0;
+	bdev->bd_writers++;
 }
 
 static bool bdev_may_open(struct block_device *bdev, blk_mode_t mode)
-- 
2.43.0

