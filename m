Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357516C448
	for <linux-block@vger.kernel.org>; Fri, 10 May 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715336977; cv=none; b=gxLzeoZEWkLJbSzXE4D8Kca7R/kpASscr223A3ryMNk36tVDiUoExV+KOBByWH8S5UaU90M0o5ZnyQedZoaEQpRCPo3cGw5+PyP8Do6EGl84m3z0cbjVjiPIknJ8gOG9rCgtjYcCIn1Cm+katEIdaWHq1iLpuypnf6T0FXNDsTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715336977; c=relaxed/simple;
	bh=SfTqYqjeY1DMHHy8PsIgRfckqhfnwz8Z8GXownPO+64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N89CkVSOuXrW3a9ep3eRn5B0yLOybPp1vEyoP+JYXKftIU3sy4pAEaRtjaBe17ODYQzujTeRyYpda3s+Up5oJ50svsd+P/k+p4aC6DoWG+n2Lt9DLe7DpXdGyFlSHQBusVuvm6yLVkVFxMEEKDJwB241SQTfAFWr637g/T3/uO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irQ3S8Oz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irQ3S8Oz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFA2C2BD11;
	Fri, 10 May 2024 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336977;
	bh=SfTqYqjeY1DMHHy8PsIgRfckqhfnwz8Z8GXownPO+64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irQ3S8OzolMWOpoNPU6k4yiLO+Q3uFep0TbWy9iN+uKud3i3oLTy/d+Fs1L9Ry2qW
	 CPKvLYHiPOChuU8PhajLs/58GCJG5iNVewUu1De+RDeST80RSrDqZBBu2SpcYgbdCH
	 FSfvC5uUToWdmFwUKymeLImDLsB2XvEpLfSwlGKP497VX5s1YHe0iozvbDMTfJE8wk
	 fCQARAptqSgb1AhS6B6abOuz79J/lr7zvdGVKou4wA8WwzIM5mrGdg7YzEkkUd1lKh
	 WfzojuBhuKlmmxK2flrLxMAPU9H184vuUBUyVxbC71B93pa+FjITd+7q1NcLNFlldi
	 IlT4/VyH8zRkg==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Date: Fri, 10 May 2024 12:29:04 +0200
Message-Id: <20240510102906.51844-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@suse.de>

We now can support blocksizes larger than PAGE_SIZE, so lift
the restriction.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b8e32d933a63..d37aa51b99ed 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -146,8 +146,8 @@ static void set_init_blocksize(struct block_device *bdev)
 
 int set_blocksize(struct block_device *bdev, int size)
 {
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	/* Size must be a power of two, and larger than 512 */
+	if (size < 512 || !is_power_of_2(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
@@ -170,7 +170,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
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

