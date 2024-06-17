Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE4719DF5B;
	Mon, 17 Jun 2024 13:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630853; cv=none; b=nlHPzKSDpV06MkcGScLboUatk3cNPEqaT4HFFoywUIesCVJNyIkEGb+MGtj9JR6ToML3HBTGgAzQnquIxYsDyj//imde/00IAJie4dk2Wyze0QBJzwmfVQcFkir3edCfdyY3XZQquy1Y0jDEMpDvDAHY+RMWGxqejKV2dplv5A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630853; c=relaxed/simple;
	bh=78W19AZSwVFkGnxOStZSDIIIYz516zKD+y3vSn8zV1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cKbn9w1ICGF9Gq+8lCxyEe9kAQOnPahNjz8M5hrzpVkOGhQHKjjAlcxaZU/wBa87Ud81i67IktOhyHHnWhrENaruWT53Zw87EcEvJWWUNyuaOGrkHWUwwUadQGEypVVqqDf5ngknPuRJbs0oEGdXV+e5/a17sdu4nE+/3mxcKGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3kQTiq7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3kQTiq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A169EC2BD10;
	Mon, 17 Jun 2024 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630853;
	bh=78W19AZSwVFkGnxOStZSDIIIYz516zKD+y3vSn8zV1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j3kQTiq7uWenUzxal3h5Sgp1r5wTXmY7pZBNjDZheBcydE8fNL/t0x11OWe5dcYSF
	 wZsHdEYsH8+CLZoLvT2D+NPJnEMP6GtoKjYvlcu7PiNiOZTToemyhzFMyZbopm035T
	 LNFOnCahh6c4h5Mu42ncKzwosg8NxrluvOKx0xqdQkDklS46F2hEP9M7Ux58twap1e
	 MtZzPvqUfFaARnrh0CcUFt4yK/dugkAxk/A5RPopAUBKc08Ay8S/TA3pZJySl40TMz
	 2GFiIlkLgBCb52qEwECXylSdJCRpHTOS9jyx0w5CLtvhII5t4ZeViCOayFWhH0obAR
	 SjIRgcCPwWLRA==
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
Subject: [PATCH AUTOSEL 5.10 11/13] null_blk: fix validation of block size
Date: Mon, 17 Jun 2024 09:27:00 -0400
Message-ID: <20240617132710.2590101-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132710.2590101-1-sashal@kernel.org>
References: <20240617132710.2590101-1-sashal@kernel.org>
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

