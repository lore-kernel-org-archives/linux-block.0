Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAA142A807
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864012; cv=none; b=kEeCbSsjomeL1+w4cpnahdS483xaNwJpO6/7BGEQAl2qyMEgqogq8FQr1/DsLcBrunqonjEFXzWHJg6OKgyjItUi82C6IVzgnV0WY4ya/xNkp9CcT7bapec5ECacehPjGkE0KN5kA8AMkJ5rvx+UsnnR14zqoGX9aZDgPMHYuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864012; c=relaxed/simple;
	bh=9D4GyOJD6io8F4P0S/cxnoZEefdej4J2wab8Tdm/MgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VOHqA4xjUL9JM7TnKOm9Ki/qivFP6qUXAQOhPh36in8MUN2MX+yUkokwqIwPjvoVpbwA6eYF15T0580URSzP7BRA19lPA8YFrcKPC7qXx/H1XU7JVA35maIwFVeeFY9hg3zpBMN6MR5DGhDjCi8Yta6zr2E0Y+eZuWp6UVWiECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BcIVmSXN; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BcIVmSXN"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5ed048478b0so59292137.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863998; x=1768468798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSXckNgZ5ICG+taX3/Ya5CBeOAwOb38yMX5qmoedbkY=;
        b=BcIVmSXNyUBaHeqL02EgOVuVHgT7hFyN4ONyCGynpvDOUNGAlqMOAuNgdEzSubchl2
         iA3bWN8vPKJ93x/i7UxzgbDQpZ0+MyLxN/mu+bGpfX+ZrzJ0YGKbP7n5x1JuihVOZIlJ
         x9kiuiKw8nKvAdAOcHzOU1z4aIGpe9DV+m4rt9kjFi6GZMyPLlO9SlmnQjUijXBQ/Xyc
         yXAkb76JQeHsgsv9KBkyJfICtEuZQrU2YnZCIeTQOIgk6eoZqdkS1AZGFuvtY76M9tOd
         YTjd8E6K+HHR74L/fol9G1ga0L4b9BLwFkhBwG2Ma272rptcGqha452DJ2w7EDP2eMcJ
         BeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863998; x=1768468798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kSXckNgZ5ICG+taX3/Ya5CBeOAwOb38yMX5qmoedbkY=;
        b=tXadimc2RhKAhvlHoyTDmIAaDvlbdD9jBFIfkZNBtr4g2PIWLTCH3rhNoYW6XfFcEb
         IQqODTyZhOuSuaVIVwu+bDBOSaII/pLurcwYuwbc7IA20Gsa1EoJJ8X14j6lEUkSG9W6
         4mb+vDLHScCmj90jLhol6Iijgt2Iem12V7ygnxbole2IDg+81EIgFwuAb1dL9h0UEGF+
         v4+odlpjSU4PiA0XIQTthLCkcVCs3NZBfBun5kktgaExmsJHKU7REkllVneAZ7gVAM/j
         vXFfVBMffrmuWANv+UCcBNLB1WbUZWsrQ5LIFI/OGl+e2+XFM9f00EMWymKZTodVc3OU
         9a9Q==
X-Gm-Message-State: AOJu0Ywv+QYduPuLiJMR3rITrk8Qg28xu++fF8fPhPiHQTyDC4GhikMQ
	6zc/HVGBX8UPie02+67OUL6caeeIKW5ym4iRrTKJsjWkxmwJpT/Gm2Vf8vnfjKrOgmSU6puYj9m
	Kli3AMwVbIFlranaPGiipA1/MAi+l8IlKWeaq
X-Gm-Gg: AY/fxX4hpY6LyouA5H+c82ok4BCDvBygPjjK8HW0b8OvxKzvs8Uoe1pbsr2sq1pwcaw
	VgIQb99y2UpECqhI50kLa8zc4agI/aUnn3osxA1Ts6hVwIbkpunsJ/WGbz9Mrx05V/fIwaRyNh2
	DoDObW3Q8s2zquDpGRzcPfZfW/FVdskLJbZ4mmNJ4hzPZ2JxhCOc+AQJy0lDPWIhxoc4pN9LYE0
	1U2tEVS6Gp6L9QiJxLYxaj85xwRS/mSx0KOrvJ69akV4QFe84v/EIHqv2K9peqXAJvnRyssbZmv
	PV/P3fqdv/N9TrHTNuHE+6+BuNnbwOHtwc6V8Fmk0SQv7IFrNS2jz5Yeg32jNG7XXJRkQ9hfD5K
	jcII9xom3Z7KewOnnZ+pkZ4PFytTLdn1U4cS7qE+Wiw==
X-Google-Smtp-Source: AGHT+IE7Ge1AcENQX9O/MS5JVNja68MmFbDGu7d8jgtYr1HGUxQVFEkLjbdXGKK42kA/Gk87KY6YQpwurEsq
X-Received: by 2002:a67:e701:0:b0:5db:e851:9386 with SMTP id ada2fe7eead31-5ecb1e75d6amr1271152137.2.1767863997587;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5ec76e62f92sm1109185137.0.2026.01.08.01.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9BCE6340794;
	Thu,  8 Jan 2026 02:19:56 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 95F68E42F2C; Thu,  8 Jan 2026 02:19:56 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 11/19] ublk: optimize ublk_user_copy() on daemon task
Date: Thu,  8 Jan 2026 02:19:39 -0700
Message-ID: <20260108091948.1099139-12-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
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
index 08674c29cfdc..707a74ab083a 100644
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
@@ -2689,10 +2689,11 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
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
@@ -2718,13 +2719,24 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
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
@@ -2745,11 +2757,12 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
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

