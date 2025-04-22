Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E50523373A;
	Tue, 22 Apr 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288182; cv=none; b=cljvQjf/TRtsfj+Xx8BOunYpMXBcJcj4MG8tGJO0zGhGjB8GJbitCr1DV/ZppWUdTsWw1qUv4usEscRQSNm2TjCC4SjyT8nWJNxH18EDpq4a+hYZBEkj8HNgryKLGhEFKq6WfiLY9yOIZ1VvBk5aLdMJT3RdsvnjhEikEEdkGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288182; c=relaxed/simple;
	bh=sj1bRN6e8Wglz53+XZXogI3wtEn/6aQTHxnLrj5Me/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsR6DX/6mvz5ABPePHEnDtFbNgL8c5/FTMrReMhf2Mw3uZfqXviEyzhYTUBAf5eg8AqxmeUKKYKrw1Gb33PqBBDRjTUNzv8l48ECsBCbNrujLZINTwiuKA5eqkzRtQymgL+C0wHWSbmMFmNVCJXjKlrYQTCUmdElPyHeUeoydSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktjs5zpg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktjs5zpg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89CFC4CEED;
	Tue, 22 Apr 2025 02:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745288180;
	bh=sj1bRN6e8Wglz53+XZXogI3wtEn/6aQTHxnLrj5Me/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ktjs5zpgs7FhlVIHqLaMPjz6AKBuci1Qfa8cdRQhRS5y1Xy/zOWdw/o7XxPBdunFH
	 4NXEQi2O0insb9fynV6rVKq5va33HSiXkQMfpE+yFprAm8GNSu1Z2LiqwGD6UDJbki
	 jr+iTasnzi29qWvhPyEY6p5v7NKEneiiNg1N8/ZZSBgYMYtuO+a8tn0feJ5y5ngWAM
	 AdUrCidGZqGNVjySxf1sgvtBsuX9rIy54n6/CcukmYFHvDOkjsPTLNop/0nTxkjfz6
	 suTjAsYoeHkKIZjZbiGplAVWZSPIkKmVe76ZVQZbfYrnPl3wOH9TNFLdJS3fsdzCiJ
	 m3GaUOUkFwRMw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunlong Xing <yunlong.xing@unisoc.com>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 16/30] loop: aio inherit the ioprio of original request
Date: Mon, 21 Apr 2025 22:15:36 -0400
Message-Id: <20250422021550.1940809-16-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250422021550.1940809-1-sashal@kernel.org>
References: <20250422021550.1940809-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.3
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
index c05fe27a96b64..1a4dbd4116069 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -471,7 +471,7 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_filp = file;
 	cmd->iocb.ki_complete = lo_rw_aio_complete;
 	cmd->iocb.ki_flags = IOCB_DIRECT;
-	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
+	cmd->iocb.ki_ioprio = req_get_ioprio(rq);
 
 	if (rw == ITER_SOURCE)
 		ret = file->f_op->write_iter(&cmd->iocb, &iter);
-- 
2.39.5

