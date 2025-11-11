Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB0C324B06
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762888610; cv=none; b=EwGd0ZrZ3OBV/d9pWgeDLuhxYE68puxQ6vnv5Tx3aEIiddPRkV4XRk8Cz4UetcpivSGK48duOvasP7BejPbM1tXRIekAQh5mClMQlte4h8nKlwphPr2L3wfcIqDKXXOJ6cMyccCKU9eHrcZSL1I2cD3njn3eRrlfWFXd+6WzzZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762888610; c=relaxed/simple;
	bh=D+BAn20i2/h8zTJGQCbUN6IaOPL16Ku7UQB3Umu6Q5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P30MAfXQZt02PAy2exrWMVKB9Sx21yMLGEZ2uVD7O1ArNzZt1YKRyvCoFyinJfkISvRRKoS4rqE9b/xpWDGTq2TA5g8oxOzxxbtOQaKL85lXfJT/K9g3e4+9DRlDA8YGbhcUBTdt8N3bLaoKDIxrDrPy3LXCvHw8KahRli8Y1Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LxZp6mtX; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LxZp6mtX"
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-b7128683174so1306666b.2
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 11:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762888607; x=1763493407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ePhqIVmUrD4gb+YCmSt8wJnO+7LTI5Hos8JeLjUX4TI=;
        b=LxZp6mtXlr6pTNxPMW/C2ufF7IFjqCGXaZ5HmWamagI91Z/vccYOYSFPWR+lqJNGfX
         TT7eUzEqA0jBRk1b59rqTMnreOjhl59NVl+2rZdPZ9oAufqQza7lLjt/pahBDXwFnMVa
         5yN3kOBoT4x1Cfwli0t+O37IZctyokDylWpfGDuWX6AxaQNpy+fWkfx9Kwk5Q7/02lyj
         I47rKLbpjwHOI2fZWxPwXHup+NAoKwdHRI4eccNlrCHUTsEmfuypgRBI0NWvu+7XtnwM
         R/hd5KdmMbFrXnDB137u2bvrnll2qxMTdem+ijC7sLQSF24cyBJL0VfWyuAy8js7oEXr
         yXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762888607; x=1763493407;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ePhqIVmUrD4gb+YCmSt8wJnO+7LTI5Hos8JeLjUX4TI=;
        b=b2cM2oYCbSgpH4HRpTjJioLuS/IzO/hEmrC8N97ft1rh8vyhj3TmJ0gUnn7PsaFe64
         q29/Fj5eki6xlbN556rx2FJd7dznzgDKOvXoxjEOFCeYhvjF/ztUzXGsPJhMme/w5YK5
         n3jTQOpOy+v2cUm7cwA2I5Irxaz0dKU9r/Q6W8KIo9JmnhXe8DH79TEjlODGXMjl7uyf
         VF8PE1gVNROeE6oq0wyTwLfNrDpzsbTUs3b1jva47rXZZ10j2FNt53xeL6aloFMJZGJW
         U3Yl+sN6PoagVpU4WE0AwYnL52jUr1icyWJSz7pVF/nrBMpmQ8u80ftQIvBjzbVQJMDD
         bOrA==
X-Gm-Message-State: AOJu0YzOha+nKUtZSlRlozRYKVrvN4sShVNPGPfPt2Ph6Qs9X4k/c8ab
	KR8Fu0srN1S24RMA711LIQhSDQrh2CQiMM8xNFnI+1qXUcs204k6wFADdfYhzk0zpwEjz1VQQfV
	1+/edV/tkHTmN+VTSa65Ji44w2YZ++YH1loyPuxV9eloJ2uk4Siz3
X-Gm-Gg: ASbGncsVIYk892aer6rkVF1cvd3cVFCCj8HRt9goOvcM0EKL5vY7F9NrzaYj/2gE07z
	jpuFvDew4g35l/4YeD3gg4YtZxvBYNU6JNamF5nf9jOyhpHRKHhAWzf1LcGk5ZLLNsqRWTgqz7D
	4ZXRlVH5ZSkcSDKUw0rdm5OeXXHhvU+wmIRU8WxLFTplWePSyyyjcGj1T+b7pmbNwT8/hoBA2Jv
	kwv9XNyzBwF3TcLjdkv0zLKeZf4HGL5WAFNDYaKvv6PD603Q5NQ5S+iZiesmBomx7Ibrur4guyh
	zjGB479517EXCx9czf+LPeVdF3wcDMseRAc255eD/RT6h9LOKVSNz5C6JiRald9zR2n54nxVGqK
	fcX3bVBiOAVfjtdTI
X-Google-Smtp-Source: AGHT+IEVdngswTujL30inxykVCIhXuWpdXDEL86ygWMGu+v/iUTsFZsJ36SVBDXSb2nwMd4IOzHmoK/NBtUj
X-Received: by 2002:a17:907:7254:b0:b72:5d4a:45d4 with SMTP id a640c23a62f3a-b73319922demr9522666b.3.1762888606677;
        Tue, 11 Nov 2025 11:16:46 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-b72bf93b18esm232935066b.94.2025.11.11.11.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:16:46 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 546A134027F;
	Tue, 11 Nov 2025 12:16:45 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 3F1E9E40669; Tue, 11 Nov 2025 12:16:45 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/rsrc: don't use blk_rq_nr_phys_segments() as number of bvecs
Date: Tue, 11 Nov 2025 12:15:29 -0700
Message-ID: <20251111191530.1268875-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_buffer_register_bvec() currently uses blk_rq_nr_phys_segments() as
the number of bvecs in the request. However, bvecs may be split into
multiple segments depending on the queue limits. Thus, the number of
segments may overestimate the number of bvecs. For ublk devices, the
only current users of io_buffer_register_bvec(), virt_boundary_mask,
seg_boundary_mask, max_segments, and max_segment_size can all be set
arbitrarily by the ublk server process.
Set imu->nr_bvecs based on the number of bvecs the rq_for_each_bvec()
loop actually yields. However, continue using blk_rq_nr_phys_segments()
as an upper bound on the number of bvecs when allocating imu to avoid
needing to iterate the bvecs a second time.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 27cb27b6d5ea ("io_uring: add support for kernel registered bvecs")
---
 io_uring/rsrc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index d787c16dc1c3..301c6899d240 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -941,12 +941,12 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	struct io_ring_ctx *ctx = cmd_to_io_kiocb(cmd)->ctx;
 	struct io_rsrc_data *data = &ctx->buf_table;
 	struct req_iterator rq_iter;
 	struct io_mapped_ubuf *imu;
 	struct io_rsrc_node *node;
-	struct bio_vec bv, *bvec;
-	u16 nr_bvecs;
+	struct bio_vec bv;
+	unsigned int nr_bvecs = 0;
 	int ret = 0;
 
 	io_ring_submit_lock(ctx, issue_flags);
 	if (index >= data->nr) {
 		ret = -EINVAL;
@@ -963,32 +963,34 @@ int io_buffer_register_bvec(struct io_uring_cmd *cmd, struct request *rq,
 	if (!node) {
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
-	nr_bvecs = blk_rq_nr_phys_segments(rq);
-	imu = io_alloc_imu(ctx, nr_bvecs);
+	/*
+	 * blk_rq_nr_phys_segments() may overestimate the number of bvecs
+	 * but avoids needing to iterate over the bvecs
+	 */
+	imu = io_alloc_imu(ctx, blk_rq_nr_phys_segments(rq));
 	if (!imu) {
 		kfree(node);
 		ret = -ENOMEM;
 		goto unlock;
 	}
 
 	imu->ubuf = 0;
 	imu->len = blk_rq_bytes(rq);
 	imu->acct_pages = 0;
 	imu->folio_shift = PAGE_SHIFT;
-	imu->nr_bvecs = nr_bvecs;
 	refcount_set(&imu->refs, 1);
 	imu->release = release;
 	imu->priv = rq;
 	imu->is_kbuf = true;
 	imu->dir = 1 << rq_data_dir(rq);
 
-	bvec = imu->bvec;
 	rq_for_each_bvec(bv, rq, rq_iter)
-		*bvec++ = bv;
+		imu->bvec[nr_bvecs++] = bv;
+	imu->nr_bvecs = nr_bvecs;
 
 	node->buf = imu;
 	data->nodes[index] = node;
 unlock:
 	io_ring_submit_unlock(ctx, issue_flags);
-- 
2.45.2

