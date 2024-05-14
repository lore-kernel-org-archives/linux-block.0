Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B861181337
	for <linux-block@vger.kernel.org>; Tue, 14 May 2024 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708367; cv=none; b=QeRExdIPLYYtb9jdGFKfiG7BQCCL9lRbZHbl8CDfiPzFo0VJX0e2Jz5cU3/c4+0o5nMNMPQfCvGklL6mI57KY9Zv4G9tyILUBXuApJTQVavm0RMS0rrGcE1RqjqbgC6g0xbstCuHZBZp8x4zSIyLMejYZKAflRx8lKKGA9VpYtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708367; c=relaxed/simple;
	bh=2MLs8aaNGq+Z9BPfM3fqM3TE7Pu96U6iUhQcyxpAkm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YUl8F0+g9rlig7/OdQrZ1vvMzI/E6TxijgVuVbRa35r0M/ygsqvcqy5fngUMwW3pnBBHbkNJywhhcdptLEIH15alAf/IOAEQv15G/BUGc7lEYWGEaNzmVs4BzSXpfS8KpeMQIR7o+WBl5+/ze+itOAcSjzvPWw8cnNMvK38sQY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iysJzMaR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iysJzMaR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E12C2BD11;
	Tue, 14 May 2024 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708365;
	bh=2MLs8aaNGq+Z9BPfM3fqM3TE7Pu96U6iUhQcyxpAkm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iysJzMaR5lswnCwhLkr1ZR9+Vqdq/KQOX48aG7GIum/4RIFSOG8pPPV09UFL/iN6g
	 wl5OuHTINhxJjJhdZ9ueImaQzD+9nGuHStjWbHAi+n9aIMx7jLKJXgHjP/YnIdac8P
	 58VVJITm3d+2gEc3vDHfLJS1/nlhwi0zeHIqtpfbQllvK5wmTd4CSdMPoW796mHnG9
	 l4nGZKqMdb/UbSV7FIAH1TcyrgayMvvHfSzsr5C6OiaVsw1sOXtoWXdtdRlQ2dJ33m
	 xGg8qwbyJNEGGExp4F7klBP0YMudQeJVEaSPCrFnWTTdiKCAt6X2iNqqvjLvOQiiUL
	 FmqbTTd7bySBw==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
Date: Tue, 14 May 2024 19:38:59 +0200
Message-Id: <20240514173900.62207-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We now can support blocksizes larger than PAGE_SIZE, so lift
the restriction.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/bdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index bd2efcad4f32..f092a1b04629 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -148,8 +148,9 @@ static void set_init_blocksize(struct block_device *bdev)
 
 int set_blocksize(struct block_device *bdev, int size)
 {
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	/* Size must be a power of two, and between 512 and MAX_PAGECACHE_ORDER*/
+	if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
+	    !is_power_of_2(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
@@ -174,7 +175,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 	if (set_blocksize(sb->s_bdev, size))
 		return 0;
 	/* If we get here, we know size is power of two
-	 * and it's value is between 512 and PAGE_SIZE */
+	 * and it's value is larger than 512 */
 	sb->s_blocksize = size;
 	sb->s_blocksize_bits = blksize_bits(size);
 	return sb->s_blocksize;
-- 
2.35.3

