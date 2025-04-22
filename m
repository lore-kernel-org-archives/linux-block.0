Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C02264A89;
	Tue, 22 Apr 2025 02:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288292; cv=none; b=oRFoWRaxxwt+FCxZ3MWx+4X1bPX0QJ5mKDbiAS4bCvUZwPDGLmhg4aSj029v/HDDN9LagaOAmbHwq+RSoUvf8fyKk7xYpbvDpPA902qwujinoyj+QnBqx1TJv2KZ4+rk/Hg5iGvbKQaxsBqRO5Y5YVQI02HEb3tbwvsOSsArVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288292; c=relaxed/simple;
	bh=dIs/3MMGkwcUSQYWarLU7DGTiAON1Tzxo8yHY4tgY68=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sYhiAKWRomGiSd/JAGUMPBes2qmu26bfx7+aBMft0LWsJL4bxJTAxiOeEk8115d80fdbh6WGm7EzBMakcNst/rvqvhANCKDfvER8SgDIHRayF//ZwiDIqDL+aDn97pPxmjcD7+/zC+b1xoAlwOZIGyHBjchs9uAPUXO1DLPD7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2R2uDGR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2R2uDGR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A223C4CEEE;
	Tue, 22 Apr 2025 02:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288292;
	bh=dIs/3MMGkwcUSQYWarLU7DGTiAON1Tzxo8yHY4tgY68=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j2R2uDGRnvmzG7/99CBc5OZPkRpoh/GSnvXOuPcoHSLdLCsK5OLlFS1xuq99s78QH
	 QihowSLm3CoK9+kVQ/6pL+FwFYp9vTFhX4H1AbGYTNEI8d5z6rwpYySmr7LXqnZTiL
	 EIiwJu9aNGvKqvqcDYqjACRCPh9h96eBXnTiPFgLX6K6lp53d9EFnyp5SqeiQSaHRG
	 kBWMsL+JznRDTTEc4ANndbjua5xuLkf/b2370fyNBOZIjVukfGvWVVXorXA8iuRKr2
	 iC2+R0wYQ4RbOlMGRlytJPnPoL+LWyp85FFQJQcVs26ut0FPs6TlDfHhMX/bDIRGKo
	 FSFiZdnqO8r+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlong Xing <yunlong.xing@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 07/15] loop: aio inherit the ioprio of original request
Date: Mon, 21 Apr 2025 22:17:51 -0400
Message-Id: <20250422021759.1941570-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021759.1941570-1-sashal@kernel.org>
References: <20250422021759.1941570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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
index 886c635990377..b9f192c66755c 100644
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

