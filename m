Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC415820C;
	Tue, 18 Jun 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714476; cv=none; b=cA08tMpdN8nTnN9P0WhV3yFIcrA0YfO1GU9WAWbc9B2y8YaLhNgicGrznDoogjmQEvG9zIaFQKez0snhJJdCa61ymwU395gmlnU5fkmlP9tbmUQLr7YViBSFFUXXP0GDpxGvIMNWVu46wyGIpGeFhP5j6J5EDtdIE1gHjZQ5qfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714476; c=relaxed/simple;
	bh=O6HQjA5C8MJ8iubKtctGkp5VYKVligBjZlLdnuQD9AM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pUaGsmlCHjmKrgD1h8WKehSz+U+TsOy2elmk8uym7S3sIxZo/sKTt70+4MdPR4aiRfpLFT5Ih1h71quokPgyYLNefefBrWvZv0sKe5KLI+AamMTjMwIypqbu2n29Tbefb9ZsszNkqUZHEyhZeKrUWDerPypp7PQEihS57Hf2hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVfmAiDp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVfmAiDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00194C32786;
	Tue, 18 Jun 2024 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714475;
	bh=O6HQjA5C8MJ8iubKtctGkp5VYKVligBjZlLdnuQD9AM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVfmAiDpkEJ9DREKyd9UCxuEx4Nqw/Sh0/r4xsrxv+DBXmwBvs+mTxrl9yC/53wbT
	 +UrJPhDb9WhUFsp+e9GVR668p3/XUlBL6nX7mV8TEfrda8qascn6OV2YwrjsF2GBce
	 fc5M0+DwGIiXdquevU4t5bE9ar5Gk6QzdTOh2XYTjY5zMO65kqfr6YJ63NCjR6ljkd
	 66wZilgVc3jOrjVA91pzA3DoBBPjeC29p5m0BVrUbXd7ukyfFYCVIuAu5iDw71uyGf
	 mABHp89iOflY4Rx0eGvDMRxJlj5aBADEvp1k73rXd5jBHeU8VshYc64kgZAZdDsk5e
	 Od07opQLG6ZGQ==
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
Subject: [PATCH AUTOSEL 6.1 26/29] null_blk: fix validation of block size
Date: Tue, 18 Jun 2024 08:39:52 -0400
Message-ID: <20240618124018.3303162-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124018.3303162-1-sashal@kernel.org>
References: <20240618124018.3303162-1-sashal@kernel.org>
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

