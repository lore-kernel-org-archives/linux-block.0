Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615881AED5C;
	Tue, 18 Jun 2024 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714541; cv=none; b=g0Z5zDC2Y8JyfPZHsbRfGFMquyJLA9JXfIKuOlnTsUxUPX5mrzcqw/YXNNJkoVsbA1V/kXRqlM+D+62Fv3awhTkvc9VrPUHUwi20Qn7wZPRnS/XdPNHG5/hTL8LwRRYeuur6FdhuigjaGfbUlob9lIMqbvfMAwZXoq7QL8zS2JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714541; c=relaxed/simple;
	bh=D448ZoV/9zsFaLm4hdJ2TqO6XtuiHJ0fgi3i1hWjrvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W9Ct82fdamFpWeyE6XMTcyz28AaDsVxyoieLlmCMVp02TzmAMWzJ+hW6FO/iloxIbcPIC0Oq3mB/xKlDFz3C17yCVUR1BJr58GNHDvF/eHvoD3v80AiMpevcfI6kZTnUkXwybhhzQI16dU3snw/lmhJE5qZSSVL35iAbeiuBDbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCUfOaMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCUfOaMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8ECC3277B;
	Tue, 18 Jun 2024 12:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714541;
	bh=D448ZoV/9zsFaLm4hdJ2TqO6XtuiHJ0fgi3i1hWjrvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mCUfOaMYk1JhHTQuy8K3sGa5dPCoIzDjChl7wZP93r7NmczSB6OkV1l4qiPtLFZRP
	 LZTQQsaEhQgZsyAwhFA8k1ToE7Z3LmT/t+HzT3o0+WIZiW9gS/S30zITsciyQiYYJP
	 1b4ZruOlkS0YjYLnntrqsas4z2KtX4sAvm2RFF/MhjVF3wtaCqCb+b981TZe2ozKs5
	 OwXqdQX4TU/k+M4lPywi+4gM2vJQmBia9+lt6u6b2ajTT9EDENPR3Jb6dJNNO8TT4w
	 fJMpvdEKbdQL4yUpvjglrZZEapT67UaVhnEsP2v3TChDsTQNP9PGyyJGj1X5LV5+/N
	 GsVYPV3Yl/TVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	hare@suse.de,
	kch@nvidia.com,
	johannes.thumshirn@wdc.com,
	zhouchengming@bytedance.com,
	yanjun.zhu@linux.dev,
	yukuai3@huawei.com,
	shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 19/21] null_blk: fix validation of block size
Date: Tue, 18 Jun 2024 08:41:18 -0400
Message-ID: <20240618124139.3303801-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124139.3303801-1-sashal@kernel.org>
References: <20240618124139.3303801-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.161
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

[ Upstream commit c462ecd659b5fce731f1d592285832fd6ad54053 ]

Block size should be between 512 and PAGE_SIZE and be a power of 2. The current
check does not validate this, so update the check.

Without this patch, null_blk would Oops due to a null pointer deref when
loaded with bs=1536 [1].

Link: https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20240603192645.977968-1-nmi@metaspace.dk
[axboe: remove unnecessary braces and != 0 check]
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 87791265e09bf..ad0172f3fd4da 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1749,8 +1749,8 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize))
+		return -EINVAL;
 
 	if (dev->queue_mode == NULL_Q_MQ && dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
-- 
2.43.0

