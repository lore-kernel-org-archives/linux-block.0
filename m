Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDBE248F4E
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 22:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762640274; cv=none; b=hXzgNQAMSuX2iocOOf2sLCUSB98tl043x76CWJXjqBW5IQN4XTo93TqTbIzuur9t9jXaIR/s0nzb21mtxBBXzAKahaj+Egi71rLyj200Cr07YjTCDzxJDXgfrOdi/P5KmQj3Rn8etaOed14QRzen3L/kLOO2rNKmeOTzzbuPum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762640274; c=relaxed/simple;
	bh=HpXdnsKGl8f3ZdJWCYZs6bXUwzb8MdHsTvazkNMvbiw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKbogeojwOQ/1MKLWvbgGy9ei6UhZzWr6AYBVi9XKBmZDlGPTghIyLPaUhOYEt5PuCfjNn1hx6oB8A5QVCraN2Q0m+wiVJtNSF4ELTxlvzzp6/KgeC4kfH405HVv9zkPO4ROTNegYedWrd/8ts1d4qcOOlI9nABthBNEyUYMVRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YK5Ny6qj; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YK5Ny6qj"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-343514c781fso236144a91.1
        for <linux-block@vger.kernel.org>; Sat, 08 Nov 2025 14:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762640271; x=1763245071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVtp/TihtZiV599Q5SwMcHksrPDyGi+psc7b80OThX4=;
        b=YK5Ny6qjmRPu7Z74luvI5CnaCef8aPiWnsBW4kcsWfP+ypn8+gbD9KsAwMheDEXfg1
         UUuBPhriMi7EU9itD8xJYOS0FGeS6Jp0BP817d5xQNwKUDlE6elQchPXoQEa3dqcfiVG
         jAKRycRXQNRp0XkduumbbctjdPwg+MMN+P42pG+zHhioKnY1w1AcoDi92BQq2dYwOqHl
         iMnDq7dEfGC+TXm6wRvLp0Lky5M/4HvEO6Qw+IHpFEo4cVcwDIyfq0sFwXgpr4zNaT1k
         nxXhnUpjud+YlHZOtTbtCx2jd/LD8c4yF0OU/OgCPzPyZupvP2Y54Iqt9cJd7/lTJfxq
         7IvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762640271; x=1763245071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVtp/TihtZiV599Q5SwMcHksrPDyGi+psc7b80OThX4=;
        b=s5ZTtld2yj0YlHbaEJFTEDfkzfU22CjPLeTRzI8povZNWoX7GGlX3GRAOyx0/oNG8B
         YVvtQ4xNeNpReEhWf1R9owBpImAQl8kHJ5xZEvl00g4jxAaPAIFdgnVygfQMXhvGDeER
         j7tVVeWBsbOXMQfi/QxmpU/nYID3eal9NvLn2DxLqRfZH/taWdMGdHEnWbVBWzKXatz8
         TClOBkxZLiBP0YobvE3oF1sBwTD7eARw5G5OiRaeRS/fRfj3BSeWWzG0hT6nXd84UJOG
         tgZZ4c4B+YMH3495vYAsV3+H8cZ9+aCUg5Sb04gW+4/jLVz30jKtTWK7JlJ9WS7FCnol
         MoPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpDeQPSZVZW5IcEm8su2ZICm06ZqpMSDmrVVoHv2Ly2quj9OE4OH8d+pn1hPYAC2iho+jtpxVdUF/PKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzepm962jdWZLRZuiacS6+t5czvGP5Rlu3/7wXy9QMKwsRGM0DQ
	g/9B6fll3gxiqS9WPGSWpSQ/RymmQXRgfic/+WQzd3dF+G7AORKlzMdt2ABfSsll+8Qz1GHdNTs
	7okLEP2XZOVTQiwwulz5/vWmO1niuNMUjjenU
X-Gm-Gg: ASbGnctxssd2sNGkqIxh+E676Y02DcwX+peXkmoYQ6PLo4SGlglOcpqdMJ1Ls3jUx+J
	wrsUR5Vumca/9H8N47TVO13TpujBH3xtXxcVF7KaDqa5xbYpe1ouHcBB0Jl4kjIxvxzFQJGyNi6
	XR4aemwt95SM/pVGudD6/FB2iM38T4E9m0F3PDp3jY1iklhUG17FxRVPXVcRPS4OfudxKyB4uZ3
	UoCCUrlGLnOBcq2Pcku7/chM2E7mCa67FjA5JL2V1hXytDGyUE0wwMOhnjBynmmrFWzj5TlbONt
	m2FxHoIF0PghmR/2AaenHRzfKDIzv/9QhF4lWwJTJC1Ah6jL1pEAZYi4AElczoGPky57nuExSXg
	rXw+53n6j90/PO/CIKcr2p+4HF7nvSu8=
X-Google-Smtp-Source: AGHT+IENkf73LWELz0Ah62e6rAda1J0LMmJ48u1MBqhcSP49bvDbtVIlI7I4ESKVRKphpJij3jcKLGJXOdSZ
X-Received: by 2002:a17:902:d4cd:b0:295:a1a5:baf6 with SMTP id d9443c01a7336-297e56d674fmr24544315ad.6.1762640271235;
        Sat, 08 Nov 2025 14:17:51 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29651cc6766sm8432385ad.66.2025.11.08.14.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 14:17:51 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 778643401C3;
	Sat,  8 Nov 2025 15:17:50 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6B7F3E41D41; Sat,  8 Nov 2025 15:17:50 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove unnecessary checks in ublk_check_and_get_req()
Date: Sat,  8 Nov 2025 15:17:45 -0700
Message-ID: <20251108221746.4159333-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ub = iocb->ki_filp->private_data cannot be NULL, as it's set in
ublk_ch_open() before it returns succesfully. req->mq_hctx cannot be
NULL as any inflight ublk request must belong to some queue. And
req->mq_hctx->driver_data cannot be NULL as it's set to the ublk_queue
pointer in ublk_init_hctx(). So drop the unnecessary checks.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5cf288809226..30e798f062ef 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2506,13 +2506,10 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 	struct ublk_queue *ubq;
 	struct request *req;
 	size_t buf_off;
 	u16 tag, q_id;
 
-	if (!ub)
-		return ERR_PTR(-EACCES);
-
 	if (!user_backed_iter(iter))
 		return ERR_PTR(-EACCES);
 
 	if (ub->dev_info.state == UBLK_S_DEV_DEAD)
 		return ERR_PTR(-EACCES);
@@ -2534,13 +2531,10 @@ static struct request *ublk_check_and_get_req(struct kiocb *iocb,
 	*io = &ubq->ios[tag];
 	req = __ublk_check_and_get_req(ub, q_id, tag, *io, buf_off);
 	if (!req)
 		return ERR_PTR(-EINVAL);
 
-	if (!req->mq_hctx || !req->mq_hctx->driver_data)
-		goto fail;
-
 	if (!ublk_check_ubuf_dir(req, dir))
 		goto fail;
 
 	*off = buf_off;
 	return req;
-- 
2.45.2

