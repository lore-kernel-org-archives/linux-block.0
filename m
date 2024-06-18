Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD815531B;
	Tue, 18 Jun 2024 12:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714387; cv=none; b=Rw8X8WwdUj+SoC4kx5P18kjVyDCi+393P8rnu9zCfyD/P/1VUo/AqKKLIAy3scm+iCzd0AAv3Xgb+O1rj1qrVRWBOwLr1pIPQKmZgtBXb8OB9EBZO+RA8WxnfTDj8gMx6DQpE7eguf2K1VPiOwxp+MEBZQZXaP/6AUNRouSc2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714387; c=relaxed/simple;
	bh=02JGWHfhWfg2HWwtQpkb82yHU0MEbN5MEFu8uNXbW+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8npSUX2Tn3uQy8LlbzbtOKM2F7tTYx4xBsl4wq4T2Pmp+/0nQf88sY4z4Ys5ZrtuYHaBAhXCot/pOCY6bvKXphVtJlIPYtDnkDq+Eb31fXl/X15MwD+R5J3V0iET9yQNZ0EP/IKfxxGBETOOUGfRHZ81Qd2kN7j9Q8jpaQvF8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngw33NO/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngw33NO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F24C32786;
	Tue, 18 Jun 2024 12:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714387;
	bh=02JGWHfhWfg2HWwtQpkb82yHU0MEbN5MEFu8uNXbW+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ngw33NO/WykZ2halXSj+MHOkEC6zTAvN3Cv6zCXjyuv71MwOIpvYOJn+XruzhzODi
	 3pVcnthNDWo5N5aT4G4QYpwNrzScmmM4/a7YRzos0MiDw8ve4+XvC6Y7nfnQmESFXM
	 YI4c7FgIZbOoxFuC3EJLvecCEmvpIhLwqx9a4lLbuciG67mJfgawaQ0ZEmgzdjm+yk
	 hu7MqI9t6snTrIvrw4MlZVnH7BoExpJScwNKLUf/qN8u039LLfamZmjiAVpH51zNjF
	 +zUHEgm1cDBgFCsnxsgryBqrQtczv2RPfOjkfzT2bGumtSUmsqiNKB6LUHhrpAaJ1V
	 WAtQ3mm4ZNMgg==
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
Date: Tue, 18 Jun 2024 08:37:50 -0400
Message-ID: <20240618123831.3302346-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123831.3302346-1-sashal@kernel.org>
References: <20240618123831.3302346-1-sashal@kernel.org>
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

