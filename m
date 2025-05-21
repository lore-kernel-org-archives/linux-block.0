Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E514517BB0D
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 16:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747843645; cv=none; b=YkyIi1qkzU1o+i9VzWrY/H0Efp+OXk088Wt/n/5ORAO8u7v/VuhjosyaA0ldeKDtuToeTCuCv2twfi4sxRGllKLiYjZrdzUdV87T3GKwyZn8RbOKWMzG5IqcZs5XE9GtuXcE66P9zCbgXUrPLNSU+mEFayGiAS2WLj/Itl4PjB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747843645; c=relaxed/simple;
	bh=3ThejoLiMkpabs5CE1WBPTbZj0YfkJafUiYWBh0n+rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jVnXUXjezQYVaniPbpnYKjpMFR0H76oCuvMVWcYrDikaQj4FvTj6P6hftQX5MSm2f6SZHIsnhFGbo/SZ8BPsDkyZPE40VJLqv7LH91jFgQ2UORuXVJ3pxAvT11yOMnhvmfYw8Ea8Q0scSaBg7OCmw3IWoN6IWPp693AKR7j9p80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ROM1aknv; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ROM1aknv"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-231bfc4600bso7893245ad.1
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 09:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747843642; x=1748448442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGAacLh9ZKO/sc4ZekzKsbI6RbRxPuIDS876rsFYht0=;
        b=ROM1aknvM+SaYX+c5n6KqNQm79ZNACIqE2fApnudDZOEvewj4ZvQ6dWdCsndFLHQMr
         7E7V+oJlw2NYqGbpSGuNh6AtGyHNhsdsE4yK8trq/NygGpsXUfTcn+Pp8WW6Z3XoPXt/
         09cKmNfvNZQKkWHMBQLEdjTGdW+6sGBbut6EudT4iAJ/pg9MelqpmDJJXIhjJXP/evEr
         e9tk7UZ5MgfZsfYDXlwZCk6fyoV2KL4Ms1x3uOPUNOAMKLm6yWteAGntJcnnT/916mEt
         n4CsQ+6/4obLv7OW3gJ1ObnOqGyly0rSFq22gwS99cy5BsvGL4CSCgVRBSlKf+VkVJVV
         u48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747843642; x=1748448442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGAacLh9ZKO/sc4ZekzKsbI6RbRxPuIDS876rsFYht0=;
        b=jYA8eXtbDDGKyqEycBGa8Cmx3es+6xs/GYxH+kSdeSjGKrKNo8iechTqY/gz7XpuX5
         8tC7An2ix52GSsKswZJsYHwOXtQmGeDjMvB/f0RG5FI5qZQlBM+vCm3c/RGnabPAT+ph
         AyW46t8Flwx3WAMM1KKOO8/T9cKLvTdV/nh3YwQG9QK+oz/uYw4vlVoYHro3E6nDlgxR
         ljyEicD0GsetFLwAZKUTlbmtXSxFQP69bXaLY7vwdTezAZKJa7ftx9qoXYUut24FiBFF
         ildvgCi2YDuO1M4cyWcOnR1Ux/fsY9sEELpifwvqDRCptZ9asnMrJKCzziqyfrLKEB7p
         2/Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV+rg52zxPt8mPkJpLWRDNW6aN/XFQCfOff3tlqN8boDw64s/bHGLDigjAiPfyYecudOSVDeLsIxbD1Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzjhA21E7wkoaZCDmENk2NilG8ef7NcAi/n7KMKmmYJlwF7Ttjx
	NttDNNpRrlLJqVpB1gUVHbxTqWZCbYSmk0u9sWp41gLuo6vZC7pI32oejG6JpN1BK/QXtwlRa7L
	A+Yaiyy085ut4VyFazoLDkVeMEVjpG04gBRi5dkJyy5NoQajWCzpi
X-Gm-Gg: ASbGncsfrEJlIEWpME7RqEkOFU6XUXy32GjgKv49HugnERGx6eMRvJPDprFiQC0onTN
	8/8w6SfLVEXCgUcaMnho192SDpzM9OA9Vt7oWfwyoNkB2U6lwuZWr4lKqCaKxG50P9UBYPTJwBG
	g1CATt+M5+ZYy94GSYDlNjc1v1dVxGELtRCaKSTwhn1xtDB5O5fZrKOEsZg/e2QYeep54E/f2Bv
	X2a1ZfMfcPhyrk9+h1SHI9VoUp4+4Ym2oJ78K0o5EcICfGHRgnmG+gkfPGbqQme8KZ/iI7cb/SM
	QMGnn+nJiAVXUBW6UoPVOaG7R0rrBg==
X-Google-Smtp-Source: AGHT+IF2kF1m9LkkoJKrZ/FEcg38Fj39w2AzGUaOy5/vh7l4c0L6fk/PMc5E0B4+fMIoji+2MmlqVClPh6k8
X-Received: by 2002:a17:902:ea0d:b0:224:1579:b347 with SMTP id d9443c01a7336-231d43c6220mr113533045ad.7.1747843642133;
        Wed, 21 May 2025 09:07:22 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-231d4ecf61bsm6804655ad.123.2025.05.21.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 09:07:22 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 87F6E3400E9;
	Wed, 21 May 2025 10:07:21 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 81A95E41D24; Wed, 21 May 2025 10:07:21 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: remove io argument from ublk_auto_buf_reg_fallback()
Date: Wed, 21 May 2025 10:07:19 -0600
Message-ID: <20250521160720.1893326-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The argument has been unused since the function was added, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1800cb14677e..7dffddd3fc7a 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1181,11 +1181,11 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
-static void ublk_auto_buf_reg_fallback(struct request *req, struct ublk_io *io)
+static void ublk_auto_buf_reg_fallback(struct request *req)
 {
 	const struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	struct ublksrv_io_desc *iod = ublk_get_iod(ubq, req->tag);
 	struct ublk_rq_data *data = blk_mq_rq_to_pdu(req);
 
@@ -1207,11 +1207,11 @@ static bool ublk_auto_buf_reg(struct request *req, struct ublk_io *io,
 
 	ret = io_buffer_register_bvec(io->cmd, req, ublk_io_release,
 				      pdu->buf.index, issue_flags);
 	if (ret) {
 		if (pdu->buf.flags & UBLK_AUTO_BUF_REG_FALLBACK) {
-			ublk_auto_buf_reg_fallback(req, io);
+			ublk_auto_buf_reg_fallback(req);
 			return true;
 		}
 		blk_mq_end_request(req, BLK_STS_IOERR);
 		return false;
 	}
-- 
2.45.2

