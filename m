Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65B299A94
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949721; cv=none; b=nxy7Nt/mBoX77ECZyd+L/e0/AkD1JG0EGGTx+ctZYB9I98WfJqk1i7ND63H6rBx34661YHrfiGBIKxZX8a/p5JfVVRdH6CiDG9Tn03LYajNVzfd6AuGKLiWB3rEr6fpKoFrzOnRDpMszkMPc6tlK++20cVjXdaaQTi/rjOKTT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949721; c=relaxed/simple;
	bh=gCDcxrwsQIo9Zl4D9+H5tFsOAIyHBgcO/hwZeW+CHUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CdjiY/q5+2PEz3voOFGKeB3hn1KMOl9oUEDHkOKVj07z+3z4E62qI+g9O+evlJZGrKEOWgc36XdhYJ4/WiKIEm6nFkr225EcePOkH75ON+T2kdriDjTrPQvPMTrIRGsPZCwZfRT0+oEimciyB+31fmNgeWf+O3mx6CLebm/BZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KPEueBWg; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KPEueBWg"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c78003b948so1095963a34.1
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949714; x=1766554514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2OvJx7AxTUJ0pacBHpfR4EB7axuem5OmBv1tntyjd18=;
        b=KPEueBWgGwFpRBHMsmlxq+17449raT7ttquKsRKjNsssQxetX3ulLY7866k/dwShWw
         5Tm9ENFk/TOFJwhRLAGay1NBoN8m+tD51thMeLoC1WbUG8U957EzPYrqQiBSmGoDbO6s
         nR4Og2Qz+z03peiVFERzOfjBW2bXcCjrjEvOdibugyDL1iRNQlosBPXhAGGKQa7ilDev
         /GX1stlQj2fxDySShZUcxHPI5bgxFRlr7QrNewYs4SPBT2857m1bhsZI6AD38KO1X5Lt
         6Y+FQa1fv3IUITOKmWt9FNlGYSj83JBRTdg+j+ddPCUDG/HqlRiWk5T8gr6iHmOBobrZ
         vAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949714; x=1766554514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2OvJx7AxTUJ0pacBHpfR4EB7axuem5OmBv1tntyjd18=;
        b=acD/G2dyY+2BqYnze8bf/9r1AsTGFtygZvrznXn62yZSMCaDEQj3OoEKnuaRbUUupZ
         sUYyqlFvyb5s55vISlFBnsQPsOcehpXFtz3jXqVxD/RF1NdYsFTYShFfOKcgQ2weqT0K
         m0P3Aohuxx3NfzYzwYozesU9Sk+hzRLr6y+aYbEy1xEboH8TkieOnhXaQ+AR48ISDNgB
         8ngyOYEnEvDogNDrwJidhXawC2GNuJfLI0G2i89zEr9xEHOe9TuLYPqT4Y85q/76yLWT
         Hzg7iA4baDOYgMb0fJL3ddssvlIFsKtP/ZoP1+mJoG8Pz1wtyJLIJNMzAvdCwtxC3ukF
         UC/g==
X-Gm-Message-State: AOJu0YzoczyBF90CfCpd0jukzg96q7C0bcN/1xEQLmol1HSLLrGDnjuC
	G07grZRJj2zYsShL3bqYC9fZnb7BNIVWG5uypPw/mYnrF0ufp0ssbH5qZtriVz/VDWkWTZJJrSY
	8ToQOxy3ZbHKpcJI+A+Z+fN/0A/RpG5d4TXA1V3MAFMC4UdRoCEjp
X-Gm-Gg: AY/fxX4WEZ2L1ha7GTIeIb27UNl26TLZnUTO4LGtT4xw8NJtVgH8XCZ1Qza5kjNu7Qd
	qzZTAE9piAkjmGzqlFNNQIMIycu2Um1fp3keM5X6Ekx8CYjiDP5aM7Jb4qJLSJMfNDUB1Ue2gFH
	/S9foebhc6vIfpyE1jWaSBZhLdvpgyhQ9GFYKfjPFzACBJeCJAvZTgBcfdyj77XqyIaTSVVHGPK
	CltBjMyCiMWGJr+A6JNuYrxmfTVhoIjxX6XD96ziXpoIS+DiHbLkBwi+uinx4f2u9YE6gqGZu5c
	SxSXzfyIiZ/pBNSEbLLRviVse0M2kH2KYiNwAaYNUBnieHHL5KkcNZEO2GySMJgUsia2DAXdDNt
	Gz/VLTnbk+FMry6K3/TLLRIbEU3Q=
X-Google-Smtp-Source: AGHT+IFbG6sbuUMK8Z52DIdwdRmhPJfwF/v7UIPe9gL8Y8b6oOH7po6qZZFyRaDqM7Jnd07PI/nXVcYALu2n
X-Received: by 2002:a05:6870:e8e:b0:3ec:3bfe:bda7 with SMTP id 586e51a60fabf-3f5f8a3a5admr7121872fac.1.1765949713810;
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f614e7dab4sm1520399fac.18.2025.12.16.21.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:13 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E028D3420F0;
	Tue, 16 Dec 2025 22:35:12 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id DCFA5E41A08; Tue, 16 Dec 2025 22:35:12 -0700 (MST)
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
Subject: [PATCH 13/20] ublk: optimize ublk_user_copy() on daemon task
Date: Tue, 16 Dec 2025 22:34:47 -0700
Message-ID: <20251217053455.281509-14-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251217053455.281509-1-csander@purestorage.com>
References: <20251217053455.281509-1-csander@purestorage.com>
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
---
 drivers/block/ublk_drv.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 042df4de9253..a0fbabd49feb 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -180,11 +180,11 @@ struct ublk_io {
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
@@ -2644,10 +2644,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
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
@@ -2670,13 +2671,24 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
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
@@ -2697,11 +2709,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
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

