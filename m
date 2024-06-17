Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE318BEC9;
	Mon, 17 Jun 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718630753; cv=none; b=KktKE4IbMLa20kcOQVVuHvB4Wr6sKw+FOvOHfGxpIoptM2yYbvbWECFm6k+eDPXHetTOm8QO7SQ9mu/mJq+HfMC06ltwsMV/fl3a8Rlhtgq7zVQYGaFZ0f9vZXz3hcxliIIVkNH4ya6aOPD/I1Xa3xzu+9oRqJZjnBLwPpziHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718630753; c=relaxed/simple;
	bh=O6HQjA5C8MJ8iubKtctGkp5VYKVligBjZlLdnuQD9AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwchrKM9eQqvybh/7rFJ25MjYj07M24pSdoTsMfsAxVZQQR9Q7NCyq1+Q+IOD2CBESk0EJT3YPK0EvE1w2bF0Tz5QTMWZUNPDzmefEOnA10MO6uPK2/Q1zLtiaHPxdEFDZlw9MrugMajQE52H2k8yfMYnr7y+ehHN+cZ4TJ0ATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfRHd4TC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfRHd4TC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93A0C4AF48;
	Mon, 17 Jun 2024 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718630753;
	bh=O6HQjA5C8MJ8iubKtctGkp5VYKVligBjZlLdnuQD9AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GfRHd4TCE7FHZG5DeyBuPe+rgAjIK7KrOkp3Rqm2/nmO+IYf3G+E0oaa2Im2NdlKv
	 Gi8KV7yh39+oSRiP1wARUKEigXnLaOcQarmgS5O9cdEFPszF+cnw2tIA9On9Zf6xFY
	 x8UIYcAvujtq6NiEsaFihiGPrNxrwwGtA4JD4wsKpdTe3UpDprhiXGV3fT8BhzsV+C
	 9AudNlTmSuNI4HvvAStqWYYW9jrPgazlhFPPCp3ADWXDcaWQHG/gXv99xMv0FxmmED
	 BVrPOuGibeO2/WKD9El84D8By1Pz54G3bw3aOcF/C+3lyLDZ45f1Jqpwlk0NiYJ1e7
	 7RNFZikos3H3g==
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
Subject: [PATCH AUTOSEL 6.1 26/29] null_blk: fix validation of block size
Date: Mon, 17 Jun 2024 09:24:30 -0400
Message-ID: <20240617132456.2588952-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240617132456.2588952-1-sashal@kernel.org>
References: <20240617132456.2588952-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.94
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
index 220cedda2ca7d..4d78b5583dc6a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1958,8 +1958,8 @@ static int null_validate_conf(struct nullb_device *dev)
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

