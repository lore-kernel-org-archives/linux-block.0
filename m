Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1F6159214;
	Tue, 18 Jun 2024 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714574; cv=none; b=SIDpZM/Bi2vLN8BmuPH85hJHWTRbJnoWYzgaIsBUzmI7482bnksB5QnYPfcjsCEZWAYKf9fsgmgTM+GEewMrFwKa0yUektScKmCvbM4iDKmGgsx/oecMQlujRA3eECyYTMsfiVmF98IBejnyGtEOs7TpBJbFHGTOZKirLzndqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714574; c=relaxed/simple;
	bh=78W19AZSwVFkGnxOStZSDIIIYz516zKD+y3vSn8zV1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmzQOf5W4absLmidkipfCqi0EUPYSoOzohiaqEJBbosbZYvdpGPkCpxCeKeRjLEEdme0qWZnMhTqAsUkNEFKueSjI72+s+Nj+ZDpaxgV3XiVgHPkTkt38z3t4hnCSfw89+A5W+lqiKQddU/pN5z4CfhCfme9SjIEHfCIPEtdouw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojyOF5v+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojyOF5v+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83EFCC32786;
	Tue, 18 Jun 2024 12:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714574;
	bh=78W19AZSwVFkGnxOStZSDIIIYz516zKD+y3vSn8zV1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ojyOF5v+IPL4h8r2x1zQB4PrDES5Bqq/jlUW3UpXu2pFLrLMc2EJ1CG3HpVYjLE0L
	 s3chuVTHk3jmyXIStfDUTLQI7pbKiE0zjkPCxvn722MR1xpPU/bU5uc2VkuIx1OdLu
	 O2auLtKCxN/yGF4WPm7MhzemyOJDNhCh6B49xKBplqQh9l8h4VuSnYTE76EaoRFLHo
	 CXly79rxNwe/fMwkwdtcHXvOHLdgmB3X9x51nyw1+ZiLtIr0Ge/nvKHXsntqQc6MJl
	 Z598kJxGvwqf+wndlwnujHxrqTDM869faZMxtm9HMu3FX61rfjibGmFH7AS61klFlj
	 tykGT4sv29aqQ==
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
Subject: [PATCH AUTOSEL 5.10 11/13] null_blk: fix validation of block size
Date: Tue, 18 Jun 2024 08:42:22 -0400
Message-ID: <20240618124231.3304308-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124231.3304308-1-sashal@kernel.org>
References: <20240618124231.3304308-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.219
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
index 35b390a785dd4..37beb94352728 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1743,8 +1743,8 @@ static int null_validate_conf(struct nullb_device *dev)
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

