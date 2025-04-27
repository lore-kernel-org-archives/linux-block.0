Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C471C224B15
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745729898; cv=none; b=tXTvsc+Y0//0kUOI3sTrEevSI5jcTZcLyPtobJiKwl2A8S2J7Secw9BpYvvHvOLNNnCn/uXiaNwEUsYZ57aNXy0oZHrfgjwOPnAJhPXAU/G/dHgaOMKU2ODMmzr5oKCP0D3dvCK9vvei/6lnYjx/C24iRbidcrVmtFBjBJyk36g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745729898; c=relaxed/simple;
	bh=fSrQ31TL4AzH+H4LIKFWmsSEyKGj0KbMd3Gx1whPjEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2GttjHCcA6QpXawvVfuC7OFCtoJZ4LbGNW7wdnsQneAv6edMO/KobDOJGsMxGXUs95JBf3tlrgOAQVWaTxpOwPNFn4e+fyV9MJL7SwozC00LGjsTMsXifo0KR9NOlfbj6zOImfYRXez/kI7CXBV9Lv3pcoq+kUKODEft3SRoYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cveZO39r; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cveZO39r"
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-6feb4b2d41bso1563467b3.0
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745729894; x=1746334694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MPoBc+TiZg4nB9SBpZLnvMYWJGBPtb5HEuBhiraNEis=;
        b=cveZO39rcoLAyct0uM0Vs83cdLZJjkuZaO9crTlD1Uyts8c1YuWMZ8ObNkGd6XtcLe
         R7BHUEp1csNTeVl5WC4YZf1ITpN1M19RNcMNM/E4rXP0gZODkHO4rQAxYQE6MzZYHxzM
         67Sc9ZgDll/ttl2ueHOj0bxzvB7kqIce/cNYhVHm8OU6XMXd4XeDUyztQC5UiqS3L78/
         QPYOSfmqKJEqbED2oRJahqiFJEInXEE1G0o1DuPhDFp7DR1ZAfX2AT5RmrUvvIP0iRkh
         2J1z4HFpRSX5NVyYWxalbLe9yIRXPn8ZrE8tS2kw9nOUrvHmZqOGV+0uPxh/uC9Z1fn2
         XESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745729894; x=1746334694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPoBc+TiZg4nB9SBpZLnvMYWJGBPtb5HEuBhiraNEis=;
        b=t2jNmniFhTtLFd87F+HfWXx4uJfjjpNRbuVLK09LoneLUJ76ygqAAAJbI/5Pt5/Wh3
         QKjF7OI+Qu+yc6EE+9xMv1dgV81jsTm+1Tc/n08FVpdVqJh/stlNji9Y8uaxjUF6wM0y
         dpEIEw2L/utUqZSnPM1D3Di18niUMWQ3fKIlI8eZ3BLgCEZpCS/Mwi4sTe37gnlUhP4d
         2zGYp0VQsZHgAAjFJdVq5Hmn+cUHbh5NfZmfn4hv/mIYgQ5fPIv7qmtsqEwLcC3i9zpW
         PR6jMOk7CDGnesnkDJnz/D8F06RlYZOhPS/pioQFgLsPeyQd7YADIs3pI8YxfDKvzFqD
         nLMw==
X-Forwarded-Encrypted: i=1; AJvYcCWWnKyNfD633YdNQLEEGggCpqErUXtLY1vNTqDk+ueOygUVKhkPpEoIef5MN4Ho7E4SxDYASgI2LVb8lQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtk47FIzGA48XqpHe2mg33SdJDc0/zUR47JTWQKkB/1YsJ9pdM
	ZdYsiWBwr901lokIKHd6YS/0+TiaAqeaxn+WFoaupZP7L7uu+Qc8pA0T8cjKW8YOgnWkUB8zvLa
	kmk3ylM/bONwNGCu0kxUoA4UwK7aez1i0
X-Gm-Gg: ASbGncsmqRBoR8udDQJfRCxo+hFHmePbCYy7EXD64yiCRN3QnYWTvf55nxSYaK97m5W
	PT/cfRSpHhZxnYa0ViMuZ39DpTnVMUEegTPri2j2rhE1qwSktHm1G50d5HdfCnI8fDUSpVn85kv
	NoCABszVSuw51UGzSZq/YnyCFdANQ3c3mTgb6j7H5ceJeGXDZeuXqGFPE0k+9Z31+LnzQj8J+e5
	qI/WwqRAhVNfzmPhMGG86ONmf+CkDWbJlICP2/NoSNv/4VlTj9rX8as/rW/6DRvdGbWLxXktchC
	xKMeK4JNZar3CzDaisKwcGytyCF+/QshmaZgMtU3+d6F
X-Google-Smtp-Source: AGHT+IHPx4oUP4OgdRQho0yiWF6/WSdZRd1uXdseJU2Ldj7lWavP3/uk4w2qTSfcD83l8uIyadV4gzE1i8+1
X-Received: by 2002:a05:690c:d90:b0:6f2:851e:7c82 with SMTP id 00721157ae682-70854225a19mr49563997b3.8.1745729894626;
        Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-708417e4bf4sm4174637b3.0.2025.04.26.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CC8B534031E;
	Sat, 26 Apr 2025 22:58:13 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CA77DE40C3E; Sat, 26 Apr 2025 22:58:13 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 5/8] ublk: factor out ublk_start_io() helper
Date: Sat, 26 Apr 2025 22:58:00 -0600
Message-ID: <20250427045803.772972-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250427045803.772972-1-csander@purestorage.com>
References: <20250427045803.772972-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for calling it from outside ublk_dispatch_req(), factor
out the code responsible for setting up an incoming ublk I/O request.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 53 ++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 01fc92051754..90a38a82f8cc 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1151,17 +1151,44 @@ static inline void __ublk_abort_rq(struct ublk_queue *ubq,
 		blk_mq_requeue_request(rq, false);
 	else
 		blk_mq_end_request(rq, BLK_STS_IOERR);
 }
 
+static void ublk_start_io(struct ublk_queue *ubq, struct request *req,
+			  struct ublk_io *io)
+{
+	unsigned mapped_bytes = ublk_map_io(ubq, req, io);
+
+	/* partially mapped, update io descriptor */
+	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
+		/*
+		 * Nothing mapped, retry until we succeed.
+		 *
+		 * We may never succeed in mapping any bytes here because
+		 * of OOM. TODO: reserve one buffer with single page pinned
+		 * for providing forward progress guarantee.
+		 */
+		if (unlikely(!mapped_bytes)) {
+			blk_mq_requeue_request(req, false);
+			blk_mq_delay_kick_requeue_list(req->q,
+					UBLK_REQUEUE_DELAY_MS);
+			return;
+		}
+
+		ublk_get_iod(ubq, req->tag)->nr_sectors =
+			mapped_bytes >> 9;
+	}
+
+	ublk_init_req_ref(ubq, req);
+}
+
 static void ublk_dispatch_req(struct ublk_queue *ubq,
 			      struct request *req,
 			      unsigned int issue_flags)
 {
 	int tag = req->tag;
 	struct ublk_io *io = &ubq->ios[tag];
-	unsigned int mapped_bytes;
 
 	pr_devel("%s: complete: qid %d tag %d io_flags %x addr %llx\n",
 			__func__, ubq->q_id, req->tag, io->flags,
 			ublk_get_iod(ubq, req->tag)->addr);
 
@@ -1204,33 +1231,11 @@ static void ublk_dispatch_req(struct ublk_queue *ubq,
 		pr_devel("%s: update iod->addr: qid %d tag %d io_flags %x addr %llx\n",
 				__func__, ubq->q_id, req->tag, io->flags,
 				ublk_get_iod(ubq, req->tag)->addr);
 	}
 
-	mapped_bytes = ublk_map_io(ubq, req, io);
-
-	/* partially mapped, update io descriptor */
-	if (unlikely(mapped_bytes != blk_rq_bytes(req))) {
-		/*
-		 * Nothing mapped, retry until we succeed.
-		 *
-		 * We may never succeed in mapping any bytes here because
-		 * of OOM. TODO: reserve one buffer with single page pinned
-		 * for providing forward progress guarantee.
-		 */
-		if (unlikely(!mapped_bytes)) {
-			blk_mq_requeue_request(req, false);
-			blk_mq_delay_kick_requeue_list(req->q,
-					UBLK_REQUEUE_DELAY_MS);
-			return;
-		}
-
-		ublk_get_iod(ubq, req->tag)->nr_sectors =
-			mapped_bytes >> 9;
-	}
-
-	ublk_init_req_ref(ubq, req);
+	ublk_start_io(ubq, req, io);
 	ublk_complete_io_cmd(io, UBLK_IO_RES_OK, issue_flags);
 }
 
 static void ublk_cmd_tw_cb(struct io_uring_cmd *cmd,
 			   unsigned int issue_flags)
-- 
2.45.2

