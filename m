Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A58196C96;
	Mon, 17 Jun 2024 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630664; cv=none; b=DXbZ2Zq5Q+ZVpODKAsTDIChhO6PeEOkvZY4VR/qqoADYAOlx2XPbl3fPBlZRvnUom73zWArP0aPlr3UhS9CIv1cDvRa1WrNp5cJ6vnB06rUbjkN7YcBaB1FU5C84GfqHMrsMHfeZr41z2jB4ykSnJA/ieJ9mZ5ti91vxH6YuCUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630664; c=relaxed/simple;
	bh=02JGWHfhWfg2HWwtQpkb82yHU0MEbN5MEFu8uNXbW+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2tSvxFcgfw1dA2n8n//Q9ickSk26Pixg3NigCfO+0D2hzGai1lEh6gPuy6h7yFyCx+9IvXWjRN+KqE9KOfETgTEWydU84G8U/6QWVAwMaDdQnNAESqb69LYZTvDg1gqKfxXk6jbDalVlYL0v+6jnlzK/YK8QWgd4v88bWpBIfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMvu1AOL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMvu1AOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACD4C4AF1D;
	Mon, 17 Jun 2024 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630664;
	bh=02JGWHfhWfg2HWwtQpkb82yHU0MEbN5MEFu8uNXbW+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OMvu1AOLM96ViO+CCSr/gSfC0UfqdCogx2vxCUhhbiSPADlRP9qPV5imYjgoArp8w
	 zKKoJD6Eb2kQKSiv8m49fdDAn44ohaWlMisjdHAG+WHQ6rrppYkTzcHXB1I+cnNhpc
	 wIF+DEF52JB6tkqGD3qnHi3iHXncwTIyHfWxCMKc68RRswsPq4CzdcnxJOWRQCDdZw
	 boOd4gUq0B2ADLAeBz+RcLUJYb2EhTxEr6vS6D9BCW9NA3zRK8D/VAfEHxWLxIjGOC
	 tLH7pLecX6++aznZsgBP4aiTJEtDYJbJhfXQ4XwyH/DxQ3k1+a9xXVhuYo5WqzHRkq
	 uJ5p8zLnMFA0Q==
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
Subject: [PATCH AUTOSEL 6.6 30/35] null_blk: fix validation of block size
Date: Mon, 17 Jun 2024 09:22:28 -0400
Message-ID: <20240617132309.2588101-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132309.2588101-1-sashal@kernel.org>
References: <20240617132309.2588101-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.34
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
index 561706fc2cd8e..f1b7d7fdffec8 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2013,8 +2013,8 @@ static int null_validate_conf(struct nullb_device *dev)
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

