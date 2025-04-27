Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5AE2288E3
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745729898; cv=none; b=pawk/6Sl+8pg/DOhqZ97PGgmrlxjr3LJZCA200SZ9rU3cVqCuDpBXcme0ggEqgR/5pi+i682J8fLzJ4SjTcT4lqLWZVu65jMygrb+w7+o609mdzOIaO3M/k0xCW/7Fc5nZw0hFCjfCOj/xaYFvOVItTAL6uKSkac7BDMcXzOXwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745729898; c=relaxed/simple;
	bh=oIBkaOzmzRNKwMu0Zka0IvPrQeilzVPo9yAnvSXcDVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YC8Sg5E+wreUtPVPoEoyQYCImOkaz0YjC0Q0cPdYt5J8bxj5F/Wdg8AQrTOerY/rhOB5umyuET0Toj0av4jy6CUasm/g2YEFBQl64k2F9QibxwRpyim8c//u4GC755a1YGYQE8TY+Gp1bjERpGA7aQm0jXsVzZtVTUn+sDtXdZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gaVFXBzz; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gaVFXBzz"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-85da20b2640so10529239f.1
        for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745729895; x=1746334695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojx7jbcUbWv7jMLWA0u2cWOta66QExx1ehN488w0QZ0=;
        b=gaVFXBzzw6eRWHTeR4Pmg/F+63ka7z+xyHfZqT/bg5ia+c/4aDBqsaZ0G5PagkaC3k
         6jgISxOnDQXTIcAAVZ85IxmC94YaRCfDqBnNWGS4u/1V16FvPuQlHJ13hmnC4upmZubH
         VBcvRkMv0AEh4uyym4bGA4xXlb/6e88b6+SU6OuQfm1GQN/YQkbXD3HoXWXHsZS7r2MO
         dYbkCAVlvqedhnbv+GJlg4aPrBCmQkzfImb3+hx0QMFA0zTOq401i2e02cAhzI8z6Bqp
         Iicfcp2CJg5Dze5OVghB4NpOigMCLqtzHPqUljVcBLNhhDnizxUr2oQeQQf4Ag1QtL+E
         WGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745729895; x=1746334695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojx7jbcUbWv7jMLWA0u2cWOta66QExx1ehN488w0QZ0=;
        b=OmEs4ld1eAE7nb9HWpbzcJNcfw+Z+uXRraO1+p8QF8VQBSWh2ROJdgJ8bTGDX4M2qC
         d+/IA6S3JmNTUoKketSfs+Egwl4sDqZSoCH/AOeH3U9J7A9uwgrI2VRhyWalrbQVWJSx
         MgbFBGFki83NK5lIlzurXrdcaI8bcKSjM83lCfeHtz5/tgVS7JMjbfCObJZf3wLFYUgD
         vBaRmzq0ldZkH2BWAmJFp1fMch7wZZfhOJBZzJdKzZeNQKd/OEFYmOIQsd3ceV+770l7
         XUF33+i0x24zo9tggjmJte7+w85Wtmtn/1RAkZxQaQEU5xk42wVFXemsPPecO3vx9v4Q
         IVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE8+R2KkSy8KRvT/0YXjoP/dr5zccjuTJl5DR+lIDIoSPK/7IEACfHR0pq8PqJWgN4wEv4wHeqY1rWPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymF9GnUP55OVeHn2pu+vS2eE12DV3L34wO+gKZVYmqpebVpamk
	rfcVKlqiwRhaB40dGkK4Qj3e3+C0jCoUoHeT1fTVYHf02hZ/P+UZFgKM7qHbTAohFuhK5qSpn4C
	D5SQdHA/Q/oBDR6nP+ilfqDBYk/8+AePo
X-Gm-Gg: ASbGncuXSmYK0Lcsyc0uCDCL2+nm/y1C2knGuViU4iba6rI6z9asFf3jlflRJ5bcsdr
	UY+y2TASEBNVT0+WaQ50f/nKborllYPKJH/0NumdFoTRAfYdKtAm27WAkMJn62SE29bONK87vHq
	Ji5pImpxWmbRIzqjZW4CMGd1yLbnbLtnuXQH/T3DZb68YFbeUB034QjeLiPN9cRgvHK5lGpnMXg
	warLOuODhM+KBckpe0uhIv3X8xycIRn4XBOUTzhRE089urj77ZWxKYCGitzerxVxxea6PqmwnNo
	vZcL8uvWyOj0SZGJ4JPbSryN1Gk7P2/KNlIPE0/Sp5O5
X-Google-Smtp-Source: AGHT+IHr4dhZ0gpkBaBAMcMjWm8ybAuIo3pPId6du74z65ESO+VJ5lRn6HigPxkY/wHyOmIw19BpuIFs0xJI
X-Received: by 2002:a05:6602:29ce:b0:855:d60d:1104 with SMTP id ca18e2360f4ac-8645cca3116mr219773839f.2.1745729894985;
        Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-864518f02b4sm47300839f.11.2025.04.26.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 21:58:14 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5A1A534042F;
	Sat, 26 Apr 2025 22:58:14 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 57A97E40C3E; Sat, 26 Apr 2025 22:58:14 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 7/8] ublk: check UBLK_IO_FLAG_OWNED_BY_SRV in ublk_abort_queue()
Date: Sat, 26 Apr 2025 22:58:02 -0600
Message-ID: <20250427045803.772972-8-csander@purestorage.com>
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

ublk_abort_queue() currently checks whether the UBLK_IO_FLAG_ACTIVE flag
is cleared to tell whether to abort each ublk_io in the queue. But it's
possible for a ublk_io to not be ACTIVE but also not have a request in
flight, such as when no fetch request has yet been submitted for a tag
or when a fetch request is cancelled. So ublk_abort_queue() must
additionally check for an inflight request.

Simplify this code by checking for UBLK_IO_FLAG_OWNED_BY_SRV instead,
which indicates precisely whether a request is currently inflight.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index ea63cee1786e..2296fa677d0d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1607,20 +1607,15 @@ static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq)
 	int i;
 
 	for (i = 0; i < ubq->q_depth; i++) {
 		struct ublk_io *io = &ubq->ios[i];
 
-		if (!(io->flags & UBLK_IO_FLAG_ACTIVE)) {
+		if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV) {
 			struct request *rq;
 
-			/*
-			 * Either we fail the request or ublk_rq_task_work_cb
-			 * will do it
-			 */
 			rq = blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], i);
-			if (rq && blk_mq_request_started(rq))
-				__ublk_fail_req(ubq, io, rq);
+			__ublk_fail_req(ubq, io, rq);
 		}
 	}
 }
 
 /* Must be called when queue is frozen */
-- 
2.45.2

