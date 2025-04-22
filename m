Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5726FA76;
	Tue, 22 Apr 2025 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288332; cv=none; b=KBtF4y8J4XaPZtwJQEwzTHN6stbbGg8DueGRRNMBCuq//MXIMA6cbihY+W8ga/leKQn8H+uvfckcOeAFTYw/d2vEhF+CvxN8d2Lf4eEtYYpxYFxo37OUVg2MhjO37+mdtvr1/t0rLXq288yLiPsgSp7GiN2oWwxWZ+d04H2z7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288332; c=relaxed/simple;
	bh=1AOoWB8Qal5mN/kSUMXxbm5YmswbNgetkMmE1rfW8mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uDrFRDuXwIHB22NLJXqpl6ncBH8fmlJtgyt/Nl6bBkrFkcpQuZTrEyQ5UbtDCN9n5DS+Rhp1RB72NK+cxMNwKEPQA4OqGGix+ZvVzX9Q12dwzX8BLbpdMMfB8G1nfudcHmZZJvtaHgWfcY91JJkIrS8As/3ek1lYvfDd+s7Olh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUAilTgh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUAilTgh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F93C4CEEC;
	Tue, 22 Apr 2025 02:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288332;
	bh=1AOoWB8Qal5mN/kSUMXxbm5YmswbNgetkMmE1rfW8mI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mUAilTgh9vvaf/67JRlaxcJROAf50lK+x/5siYL37F5WerNVwNR4MZfDBs1vV+c78
	 w0AaFAD53DeDbjVlH/IRisAkU13y1Mb8jg51LnKgYz2KjlfFLmMh0lTpxcjG5RqcM3
	 mKJ1WIJsZ6lK2DeTsKinBO2o9um/gkCk6Oy9sNYr/ISVckR3G6i7Aj2kdMmuaisMpq
	 n5m6/aZ3ORwt6XYkQEvGNTnsRqncCIej94otcDKuZ/qJ9Ey8+FmqcquOYblvMLzhQ5
	 9gtU6qyg9n6Cf++cIzfOLvtcYO3Xpk56DzMZSeRqnNIvGnI4uwwoygGJE/q3vZPUgG
	 HT1oRGv3OItMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlong Xing <yunlong.xing@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/6] loop: aio inherit the ioprio of original request
Date: Mon, 21 Apr 2025 22:18:43 -0400
Message-Id: <20250422021846.1941972-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021846.1941972-1-sashal@kernel.org>
References: <20250422021846.1941972-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit

From: Yunlong Xing <yunlong.xing@unisoc.com>

[ Upstream commit 1fdb8188c3d505452b40cdb365b1bb32be533a8e ]

Set cmd->iocb.ki_ioprio to the ioprio of loop device's request.
The purpose is to inherit the original request ioprio in the aio
flow.

Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20250414030159.501180-1-yunlong.xing@unisoc.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 1d60d5ac0db80..cae3cda6a482a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -605,7 +605,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == WRITE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
-- 
2.39.5

