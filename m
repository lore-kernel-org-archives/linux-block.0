Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11583239E7F
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401139; cv=none; b=dY6NWm89f4/whTLzq7ihYDIPro9lTZjuBZswezA9JQ1jl13GpWhBLIbvObGFBIuYdjeKkfF5qKmtt2GfyuiL3CfNGaPF2Hq1PPIiaiQ80nYoei8irXYXI0CJ2IRyPajAVEQxbXJRFxabKfEoOAkQqdA8rsQmhiHhZACapKFQ500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401139; c=relaxed/simple;
	bh=pCk7tNgIwSX/BqQVkiiF45BFNbrK8R2HQ9AWSJrKW7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLJvrlkvSr+llMP6VH6jKsyNSPFkQzMs3LHMxl5U5V4Fa7vGtB/lGixXMTNMRoiGrpa0i7C28lOQBO59dJsJBy6aF1MfuiCk8Gc30COJVoziRkf4unKiamUULq8vViUAsXX9fb8RG7LIyELvgtDUhGTHooAJW74jSUVYjI0to4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=b28ZHZ2g; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="b28ZHZ2g"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-29f3018dfc3so39968715ad.0
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ESaTf+FkqQQjJpUF1UJK92O+2WrA8U4keQEbEqsXOmU=;
        b=b28ZHZ2gpFW8Zk1VytPKQrrTgYUYGHC2lnv/2D8ajJbK/HsDlcIbtVF0VN3cNaeOCt
         ocE3X9v5+dd6gZXwOmRsu6b4KLh2kg04xFcY5i/PryGGj307AThaukxW+iaC7LsPpmFR
         RJmuv6bs/OhzcWlEJpA5XAobvtqTmebxlGYLZiHOS8fbMxVYy0JmOzqNvJJCIz/tRviY
         MMKpqE/ikwhBGdLKCIfFZWbpDlm7iz+krmrxc7kQj85oO9Ffc2+LRX5Gz3nbrIr5W0fU
         ilGpjCJgQLKJ/byIT9T9hv3NGAy83DNRmev5C7ARgNHEtRkAcXTVainIkw6TQQEBK2Ey
         Mlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ESaTf+FkqQQjJpUF1UJK92O+2WrA8U4keQEbEqsXOmU=;
        b=xUT0yGbskygLjWTGiTlx7AkCA0/xiVTUaz1wG8BV35VkvO/geuXffyZe+1JUU+2tEf
         yGgJhPbj1f9MyeziXrgpWC4cmG1KTXGyZ8rWAu9Khg+AOWqrvxEUZL5+/7m9xWVPYqjx
         G/l2OjWfabedrHyim98rLAusk/JI9xRz9yzOXKL/r/ZAljLtAOzu53mU4So4rC15F/ya
         j5Cp/eiPYUQD4RL9dgQU9FBEnoqwnyzSmATUH0qUGNt1qswqudr4BoMQT9A9l43V3els
         /aSWUlh0SyhsJz36MWbRDYISeh+aPcKzw7+30iTCq3wnba/2bC1ovRBA7H671HBG53ui
         5xgw==
X-Gm-Message-State: AOJu0YxrdWbmJQTpCTwMaIaKzTd5NFw9hiBxmnpc2ntYYSkJLtXG/n9t
	DsihYIr4n7amExIyaeEpYR3tobD4hc40o6EGjmxhD7hx1bqjk0aNGBZrZa3Zruph9KX9UAKJ2Iy
	lg22J6VKMocVSzKm4uGSBqg1qirHGMTA9mutn
X-Gm-Gg: AY/fxX5smqj0lhK2bwH5i8D2oj6m5i3OjqR1qsjkZpz3fegFB7HdQfa+l7lfiE/xRAh
	UQfLz8wwQEa+n8pYGyIy7CqtQgFhvdwo4izSHhxsaa9ZOnIxg48fw9MW3ayXUI3BH2Eu4iIY4Sb
	4ab7xUORU1IOretCBAoICPwBML70kMcweaCMQQYtKI5ZqAoaFoOTXNdlSc+XxcwGstVZXzvoGAS
	Q4+17s0bRVxHjzhue29jp+QY+SrTj1bZHacCI2mtxzmX6ltPk/gPScOXkXW+b4/7xYYdY/pjntC
	Rz2XafFLS8oGjmUreH4HuwsOidhe2nTJgflpx7Y1BD8K+PEn2wrpmMox4Csze/rl7JE9a5Kz4hS
	M4zuXTFYJTxtM9PcARRLoEDWSK+mSpQpos7V5XND1Hg==
X-Google-Smtp-Source: AGHT+IFyJYp4u7U4WwMHxxOkMI331gI+Wu/mlmy8krgk5adiu1FvdRx1nSYXyq9v1fovCnToKv/G22ERPl9q
X-Received: by 2002:a17:902:f611:b0:298:535e:ef34 with SMTP id d9443c01a7336-2a2f2937c7dmr333704335ad.5.1767401134376;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a2f3d2e16bsm47126995ad.61.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CA76B3420C0;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C7F3AE43D1D; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 11/19] ublk: optimize ublk_user_copy() on daemon task
Date: Fri,  2 Jan 2026 17:45:21 -0700
Message-ID: <20260103004529.1582405-12-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk user copy syscalls may be issued from any task, so they take a
reference count on the struct ublk_io to check whether it is owned by
the ublk server and prevent a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ
from completing the request. However, if the user copy syscall is issued
on the io's daemon task, a concurrent UBLK_IO_COMMIT_AND_FETCH_REQ isn't
possible, so the atomic reference count dance is unnecessary. Check for
UBLK_IO_FLAG_OWNED_BY_SRV to ensure the request is dispatched to the
sever and obtain the request from ublk_io's req field instead of looking
it up on the tagset. Skip the reference count increment and decrement.
Commit 8a8fe42d765b ("ublk: optimize UBLK_IO_REGISTER_IO_BUF on daemon
task") made an analogous optimization for ublk zero copy buffer
registration.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 8b2466b5de07..2d4f8ffda01f 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -181,11 +181,11 @@ struct ublk_io {
 	/*
 	 * The number of uses of this I/O by the ublk server
 	 * if user copy or zero copy are enabled:
 	 * - UBLK_REFCOUNT_INIT from dispatch to the server
 	 *   until UBLK_IO_COMMIT_AND_FETCH_REQ
-	 * - 1 for each inflight ublk_ch_{read,write}_iter() call
+	 * - 1 for each inflight ublk_ch_{read,write}_iter() call not on task
 	 * - 1 for each io_uring registered buffer not registered on task
 	 * The I/O can only be completed once all references are dropped.
 	 * User copy and buffer registration operations are only permitted
 	 * if the reference count is nonzero.
 	 */
@@ -2721,10 +2721,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 	struct ublk_queue *ubq;
 	struct request *req;
 	struct ublk_io *io;
 	unsigned data_len;
 	bool is_integrity;
+	bool on_daemon;
 	size_t buf_off;
 	u16 tag, q_id;
 	ssize_t ret;
 
 	if (!user_backed_iter(iter))
@@ -2747,13 +2748,24 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 	if (tag >= ub->dev_info.queue_depth)
 		return -EINVAL;
 
 	io = &ubq->ios[tag];
-	req = __ublk_check_and_get_req(ub, q_id, tag, io);
-	if (!req)
-		return -EINVAL;
+	on_daemon = current == READ_ONCE(io->task);
+	if (on_daemon) {
+		/* On daemon, io can't be completed concurrently, so skip ref */
+		if (!(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV))
+			return -EINVAL;
+
+		req = io->req;
+		if (!ublk_rq_has_data(req))
+			return -EINVAL;
+	} else {
+		req = __ublk_check_and_get_req(ub, q_id, tag, io);
+		if (!req)
+			return -EINVAL;
+	}
 
 	if (is_integrity) {
 		struct blk_integrity *bi = &req->q->limits.integrity;
 
 		data_len = bio_integrity_bytes(bi, blk_rq_sectors(req));
@@ -2774,11 +2786,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 		ret = ublk_copy_user_integrity(req, buf_off, iter, dir);
 	else
 		ret = ublk_copy_user_pages(req, buf_off, iter, dir);
 
 out:
-	ublk_put_req_ref(io, req);
+	if (!on_daemon)
+		ublk_put_req_ref(io, req);
 	return ret;
 }
 
 static ssize_t ublk_ch_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-- 
2.45.2

