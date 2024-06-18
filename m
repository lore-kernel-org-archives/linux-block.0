Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143115F303;
	Tue, 18 Jun 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714267; cv=none; b=hmX5AOAfo62WRCaTXbyn5Dk9BaqnTtiy45R58vrgTLneZ60dIbTUmaXHKD7MbLF19EfnJ0Hpq+eoUXOgXgNBP+uovcNEUxetoFwQjCvro8ffJRzCoKFbxEKr2SESVwE6TPVpjgNB7P97lvVGiXwl/BSY7x2/shuIlhUQGEXlRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714267; c=relaxed/simple;
	bh=d5mtkQ4TSwEAW5aa2LmAOY5L8+c2WljHzZG5/10rc2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPotJ+77+RbE1s5+NLSOqzDRD+BYrQVZRcv0fBUwiTwV1SJBfHPlNBXnVm9SwDUYc3d9pWdyIna4Vo043Rh14sAlXtuhYus6mHbCtPuLLElPWAZ0JrhM3DxLS01WxgLkqgAXJIg395P1tefEMSR2eNNtZs8JxiXhH2y0lFrwQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOI6K04n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOI6K04n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0770C3277B;
	Tue, 18 Jun 2024 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714266;
	bh=d5mtkQ4TSwEAW5aa2LmAOY5L8+c2WljHzZG5/10rc2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EOI6K04n66M4sXI8qkxzDsgZX/GQwRV+i9ZePMxba0eSjng5J76HazvufxxnsZ7B7
	 GyG5fkfrjZmQs5mL07hoEzLxoMcXjvX2ok6grY8rE41ggJLmQt2gFDqf25A7dq0nPw
	 W1AyHhtOKQZirYQGAgw8fj934g8jl8duqX5xXkHit6saJw2jaTLIO8oIXsoKeOyzU8
	 GUm/L2b8QFqQOEYaFILg6Ss/AuvhvkzbCq6P1YrRzby3UZvG32/vF/nl/5lSIE0wgf
	 5yI067e2e+nquSO7TMkgNpl9M/fbpzNUN0MhqyIHQb5Xbf4UL/LcPSJ9NIkmi7hnna
	 h5bCr4cWvooEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	dlemoal@kernel.org,
	hare@suse.de,
	johannes.thumshirn@wdc.com,
	kch@nvidia.com,
	zhouchengming@bytedance.com,
	yanjun.zhu@linux.dev,
	yukuai3@huawei.com,
	shinichiro.kawasaki@wdc.com,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 39/44] null_blk: fix validation of block size
Date: Tue, 18 Jun 2024 08:35:20 -0400
Message-ID: <20240618123611.3301370-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 620679a0ac381..26e2c22a87e1c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1810,8 +1810,8 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->queue_mode = NULL_Q_MQ;
 	}
 
-	dev->blocksize = round_down(dev->blocksize, 512);
-	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
+	if (blk_validate_block_size(dev->blocksize))
+		return -EINVAL;
 
 	if (dev->use_per_node_hctx) {
 		if (dev->submit_queues != nr_online_nodes)
-- 
2.43.0

