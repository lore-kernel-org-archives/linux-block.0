Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD981F5859;
	Tue, 22 Apr 2025 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288315; cv=none; b=Scid4prtqM/LKsSysBO6h7gemdaaRWrQnt6rwNF/7IbWz2NhAS2Gf6UwIkveuhv7AsLvkGiYXt28soNk0V2MNmDtuJ2rmsdGPFx+Q0F2sHbipiXrEaQEhL84QTeJrR1r6AO86ezLntSG06YZ54wCCJCvvKbuSnol0PPhSZy4uCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288315; c=relaxed/simple;
	bh=+yKm82fZjm2+yiM0PzkgbSKHxyzkfY0x9pSi3Z5THGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4NvfSB3c8XlLtupIKfI2qweWugKQHNZwM6cb23/XTd4s08SprBv4NSewkdflipwQFIKsGxeP/NawqKB6flVpB71Gse5a39qaI9kEF96c1Mr3g3oTf+aLJWY3rIntXWXRf0y8coSOz0nLMpumsIdSu0xA8ZWG8GKhEMg2DrSPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbOPPayi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbOPPayi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D63AC4CEED;
	Tue, 22 Apr 2025 02:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288315;
	bh=+yKm82fZjm2+yiM0PzkgbSKHxyzkfY0x9pSi3Z5THGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbOPPayieTD12hiWJ0cRvDLONDFfDbgUrbSzGFojXfnJuDMyP34Z0m+B6PpJj91kY
	 2foWywFlkPGWmH7SqaNa0WSi/i1um45v9UbzUQZLhFBk/0X1Me8dtIRbQCNZ1J4nW3
	 SiVhdeBZO4bulFxHbwgv3MALFxsvtxXuQwYQaDiu6RSQNWSoXFuzu5/fG4Sk3hi0ct
	 qNG2o49hawQJP4qAXxiOPmbEb3qNIjiiQoUXg0OkPap/vUIZgHwLByhWb47EWc1Em+
	 za6Ud8cwLvlSgWnZbhP3f9b7Gl1H7qzo51GfZb56t+Lun4kHb9FEdde6ERL7W2Pg8T
	 zBz4RimT2nyVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlong Xing <yunlong.xing@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/12] loop: aio inherit the ioprio of original request
Date: Mon, 21 Apr 2025 22:18:19 -0400
Message-Id: <20250422021826.1941778-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021826.1941778-1-sashal@kernel.org>
References: <20250422021826.1941778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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
index 041d307a2f280..cdc6cf3917bbc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -441,7 +441,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == ITER_SOURCE)
 		ret = call_write_iter(file, &cmd->iocb, &iter);
-- 
2.39.5

