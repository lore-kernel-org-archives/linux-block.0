Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F819FA83;
	Wed,  5 Jun 2024 12:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588965; cv=none; b=lCXOUdASKHQ1e+CZu64MiBOQ9eSBPO7o5AIWjb1OzHhWE5wr64f2FrW3/VShSjHrs+Cs/Z2PdtMyh9XdkN6HIALYYiJ1uwjFswwdsathA4vkN9cZ8T/3lnnTcZI/1Kb7kPMSpubJA2bAOei4MrTDniiO/JRkdi2nyUgu1ekZQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588965; c=relaxed/simple;
	bh=BQlbPAvxsdi3X1d2VhHNpiIeTwGwQryj+ROh8dfsSWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQdbBk03BoeyRpEQxW9c1gblESCLj1VR6edZ/0rLJgaz+MSFVOT4HNtEdnl8W8e0WupUX1VbvxmzmTNFdO9S/wp76o0OblzNh7Lxa8H6nC99H6CjdMRtnFeSJy1gL2eoxZTVBXKG6wngIqunXbICZ8Wicv1eKWQIZH92bPbXKH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfUB443L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfUB443L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408F5C4AF09;
	Wed,  5 Jun 2024 12:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717588965;
	bh=BQlbPAvxsdi3X1d2VhHNpiIeTwGwQryj+ROh8dfsSWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rfUB443LzP7TXG7N5SYUwYTseiYa7PFmIsm5QKtNDuZjxE5E3mCb3KvvVxFuhUarq
	 H1J+y9hCDXSNzxnrSRGJK8fWKU9V0KJZTl5tMyVIgVrz366T9aSrg6S9kYUavZBuOH
	 P2W8MuPMcKwyUW9/jstPUg8pa1+pbi+1+pBNhaVwszxJChR4zB9Xqbq/HAm/O5QnmY
	 iqDT0mUTOAYXlv8jyb2Z5IBJaTmzZtWM5SZVF2qY/g4jxk6oFbPx26/cNx7AdvZ++z
	 7EGovBcdCcm2QRoO/3nj7eo+MHkQ3PDfanOhI1jSC89S7yqHmD0eDVwyslyNLrXk88
	 mICsIYWZ8Whdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	John Garry <john.g.garry@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 13/23] block: check for max_hw_sectors underflow
Date: Wed,  5 Jun 2024 08:01:56 -0400
Message-ID: <20240605120220.2966127-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120220.2966127-1-sashal@kernel.org>
References: <20240605120220.2966127-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.3
Content-Transfer-Encoding: 8bit

From: Hannes Reinecke <hare@kernel.org>

[ Upstream commit e993db2d6e5207f1ae061c2ac554ab1f714c741d ]

The logical block size need to be smaller than the max_hw_sector
setting, otherwise we can't even transfer a single LBA.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-settings.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9d6033e01f2e1..b4272bd926370 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -104,6 +104,7 @@ static int blk_validate_zoned_limits(struct queue_limits *lim)
 static int blk_validate_limits(struct queue_limits *lim)
 {
 	unsigned int max_hw_sectors;
+	unsigned int logical_block_sectors;
 
 	/*
 	 * Unless otherwise specified, default to 512 byte logical blocks and a
@@ -134,8 +135,11 @@ static int blk_validate_limits(struct queue_limits *lim)
 		lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
 	if (WARN_ON_ONCE(lim->max_hw_sectors < PAGE_SECTORS))
 		return -EINVAL;
+	logical_block_sectors = lim->logical_block_size >> SECTOR_SHIFT;
+	if (WARN_ON_ONCE(logical_block_sectors > lim->max_hw_sectors))
+		return -EINVAL;
 	lim->max_hw_sectors = round_down(lim->max_hw_sectors,
-			lim->logical_block_size >> SECTOR_SHIFT);
+			logical_block_sectors);
 
 	/*
 	 * The actual max_sectors value is a complex beast and also takes the
@@ -153,7 +157,7 @@ static int blk_validate_limits(struct queue_limits *lim)
 		lim->max_sectors = min(max_hw_sectors, BLK_DEF_MAX_SECTORS_CAP);
 	}
 	lim->max_sectors = round_down(lim->max_sectors,
-			lim->logical_block_size >> SECTOR_SHIFT);
+			logical_block_sectors);
 
 	/*
 	 * Random default for the maximum number of segments.  Driver should not
-- 
2.43.0

