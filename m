Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205960;
	b=1i/lnjPM11sztKoQaKNJ3JO7y8PclC+ua/HS8KttOrVdqkbkD8j0BhcUpSSAizR6ulhC
	 0Dp85PD2IThNr9melG0ZJFM2dZYERFxmTFNgWpyF7PSaexF3x0yuW7Xuzhu0+HHppU8V4
	 KHwVTeYDdFcweun5rbIKEhAijJ9QRqSXV/F3b9pXV8hUJZ9e/cxYH7E6Bh97pxjDBHIXS
	 jEai2QlmGB1fYYi4YaXtcGTC/+5YLjPntA89Vob4uSYgo919bBzzPmMM3vKledTq2CiGm
	 vrVQgVwGbu6f9UWPFOvFeQE14d1wEofQdH1M3VRsQCzffEAW1Keqp1dd1tvYtO3LuAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205960;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=blaCVQMZbyZt62XbSQmcQ+kA7PtfLor2XbKG6Ph7ZTY=;
	b=lXDHtqNc/eeyldSdX6JydTHf+DqRmIkB2jutML6FVF340YchJ1hchK6kkqVOiGpBiOMV
	 wRmG4YiNYBA7UOBjkkjFz0hR7VlE1y8GbV7/Ch7+b8l7lHhSpkCZ/rEnbQRdk3mWMFNev
	 b9Zlq4b1A3vUi1UZIJVwp/GaGs1sfTltQ6gKtDWQUxHmjo1RtRCyEw3bPokoE5RZk3t7z
	 6y0uD/YOUCr3MkW5WjRiJ78a/jYDM8x225MlRptowPM57qKemMtBMJQQAzdLN5+Q6pUNf
	 BzPi2JNqNdqJyencmqPbpKijhURNBEXVMMHnhp6Yvr5v5cabqQA8MIdgNZnXNXTplMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fVrTfCO1;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC5606A329
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABDC5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fVrTfCO1
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-846566246e8so1081558a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205959; x=1793810759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=blaCVQMZbyZt62XbSQmcQ+kA7PtfLor2XbKG6Ph7ZTY=;
        b=fVrTfCO1Roj01Iu58rhj3Ify2VysA0B3yqpKP5UQSyQoEf/baV1Fz2S5EFgO966ca/
         oNSMGBRc49mZ1T2ajwypG5EQYOtFNz5eMcA5PDouIRNOe5JPrZFjW0sInhuKgDB46CnI
         AI5i4kRLp77OtyyThSrT71QAcUBa071ofW8z5v1ibhv4PyEvygZIZz4ED0mOM3YyBDza
         CjV4wtEo7Pr23CvdPweBr8vewhjuAVyx6o2g0UsDj4LQadfpmOXQPcuXGfDJbBjK7Fnj
         hq7lRmfjL5aF893e0Sb6skVtLt01ujQhhq5v4vdUwjqvAiJfBLDLrA80OUOgtRE2ILum
         blQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205959; x=1793810759;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=blaCVQMZbyZt62XbSQmcQ+kA7PtfLor2XbKG6Ph7ZTY=;
        b=D0DolNAg3eh4MsaWmItEn1e2zgZaC//CJyPoEFpefG7C4jhYGETa0c91O9dhfasu3k
         tpsq5fy2oPUIzGyRx8fQXP/Ha90ZVz+9925BFpX+26bz4JgYKqGhBzWvSLEQ5O3WcD51
         DXrBh5hbTACOxjBzH5G4+xLzUCfoehNFFnBgFuYMy1kiK9IsKQsCBfXO5xo0sFG6eLFv
         omJzvi5U09P1OJMvHmsEHHdCaZErV3bxIIaYfPsd776LtKcHZvmV7S6N3RrN272NLgv1
         9OyGkCjhTo8qsj03YU3/h+IGSalsrTco4kLWTahiwFfFejrRQfl8Dz9CYUmGTw8D1iVg
         KqsA==
X-Gm-Message-State: AFq9FYJFLt9/tXMBHCtrqysoEO0fT0+Xj4A+Ez07yirGmlSztXUvlGY7
	qISNJGrkqteLUkIO/miE6jcwuTezftQhuwZ9QyG2lAlCSiFaZH0szqQgssNsXVuBM0mV2YyFbnK
	JABQbeTg=
X-Gm-Gg: AYBFou26Wk5aEk6oJ5t6niEQTuSU1S5J/gcAfS74Nezw1iGnpp9X3/cSOZYUCw8nxsE
	Hfi23G7e/LH5R94CeFLcItUvzJPt8Y3kchDvK08t9AicFdeqxvpFdAL+bFyt6eWzb9hha5xdEEr
	r5LiKbKDHeKjilsNwYlxiJtKT7SRnYtxEoZOS+OJnCFZB/Nvz6rNx1FFtfnK/VdBRg9I/XasIu5
	WqXNWgUc+ExkWo6xL49vyt2RPU3d8wYPMQhwixFZ2YvPxoxj4GFtvJtvC8jDayD156fslHyWVLU
	R/udcLfhaarTx9/KUGCaTNLSRxWUtu8ALb2x+ZaSu/jsmI9CHg3oBkE2JT6OAtdaWybEzmSyXQK
	o3R6KlmcuH47489zaQgHwPAWoBO3bZgO+7NBWo5w3lpAVneHxohXsfl2wvpCKFZJIRs2/YNQFNR
	cob0ueawBXl4LikELDBZQg82gbIgjvJuduYqhvPqi3autMDdydGIgasz2MyTNzGfAA1MQ03KmlO
	7igjch6EIUz6lgfPWjMfxhuoaXCH5CR3UGb2vR5wqxWR7HLX/SnlSaZf4ScyF6PzrayGZRk/tIc
	xbTP1e81Y9+Crz+s2HfsDywqjndDrX712/zf50k4pjHO5SpUIWto6qrwbeKep8uHJgINCLLkfg=
	=
X-Received: by 2002:a05:6830:2e12:b0:847:dff3:3c78 with SMTP id 46e09a7af769-85c20a9ece1mr75263a34.12.1793205958622;
        Wed, 28 Oct 2026 09:45:58 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:57 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 80/98] nvme-loop: don't BUG() if a scan runs beside a reset
Date: Wed, 28 Oct 2026 10:42:23 -0600
Message-ID: <20261028164415.1262013-81-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

A reset sets queue_count to 1 while it destroys the I/O queues and
counts it back up when the new ones are made, and it doesn't stop the
scan work. A new namespace found in that window trips the check in
nvme_loop_init_hctx() for every hctx but the first:

  kernel BUG at drivers/nvme/target/loop.c:224!
   nvme_loop_init_hctx+0x7d/0x80
   __blk_mq_realloc_hw_ctxs+0x3af/0xa80
   nvme_alloc_ns+0x1a2/0x22f0

The check protects nothing. ctrl->queues has nr_io_queues + 1 entries
for the life of the controller, the tag set never has more hardware
queues than that, and nvme_loop_queue_rq() rejects requests until the
controller is live again.

Remove it.

Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/loop.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 93ba6357a850..80b67608eb15 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -221,8 +221,6 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(data);
 	struct nvme_loop_queue *queue = &ctrl->queues[hctx_idx + 1];
 
-	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
-
 	/*
 	 * flush_end_io() can be called recursively for us, so use our own
 	 * lock class key for avoiding lockdep possible recursive locking,
-- 
2.56.0

