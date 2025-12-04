Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854803590D1
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764872009; cv=none; b=qHTN9HX5MqMZ//FNGfKgNWbsuxoyyy6ZY0SPsrHNNAW5i7l3bMifY8Pjew6h78TSknnsvlOlZZET6zQC7IWdIEWPaCsmLTLuEoWF+muX/Dytq26z7LJ2TaLM3G+uoPoQxnC121JLULVrfLqYJDy/55Y7Fqc8oim5pEuTM41sp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764872009; c=relaxed/simple;
	bh=2n8n/CrRkMQeGaIqTUKOtM84mqt2m1JWgo3BQ7O8D2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=crRh7GKEcgTVH+vfwKsBeO4Db9IDWVr8lxCS6WKBBE/l+2fJeXUPQB/3AcWFPLPTHA/63cYOYgDw6FMK/I+KOEJ7gu3bPxDbST+jtgxM6xXz1yII76wgTbCZDhPhlxQYdgls4Uq3zZyFHGzBjvnWmYOzeB/dT+QcGNsqxJ1RJic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in; spf=none smtp.mailfrom=ee.vjti.ac.in; dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b=M3wADcFv; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ee.vjti.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vjti.ac.in header.i=@vjti.ac.in header.b="M3wADcFv"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2958db8ae4fso13345335ad.2
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 10:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vjti.ac.in; s=google; t=1764872007; x=1765476807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PJvk/IXEAZzbwVmhdAwefI1fSD0T2f/TxkPdH+E3Fkc=;
        b=M3wADcFvZrxU3adDbJTATHIrCOyHJXadbAianGSwUwco/rW00sePOeFq5yJsVQrjkA
         nUbpHxETsHEko2NojHSPJYxJDuq5U30umuar4KMkTmeCxk2YbObksOHn8Pq3dVCnotEO
         Bvgq1FgRNSmsNYDILwd6arY4Al+BhYsPJ7EhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872007; x=1765476807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJvk/IXEAZzbwVmhdAwefI1fSD0T2f/TxkPdH+E3Fkc=;
        b=mKIo3LQE+pXdrp89IB8NX52yxRPUdhu1hCxBnt3fEeJscgBEDFhkX1odGKAA09VSah
         drobwPHJmKUZfK2RiQUcPMtPuV7tw4dPczlcdEn2Q462SdBdX8G/gtCOBz1qu2JxA0Bh
         yy7rSAQBrSUl1KhAm0e1GOF+6d6wquKXosTq2EEVCdRjJCg8zfTobADFPIANHf/mWRgx
         U6UF1sypmWU0d/NFLct9ktCzgOi7Hql4ku5l7igYg8gOpR3RwUrwUsAu8YtU0RUuzGw4
         dRpEIPy2saNXoiwda+LzRqZdtxApPVbi3+HaUU3u1JVtS42gByt+4sb12BnEbfKcWez7
         1FzA==
X-Gm-Message-State: AOJu0YxdWzRjtmZku3Xo2YY+p1kXVqr9dW9ZBXfdRs/2EZI+BKM9MvLm
	5Zsb+ZBE2po4hSW9GGHkEC3nxX554w/fJp80jH1DGpfRvy1FtNukqJbYoo8D+3J0kvs=
X-Gm-Gg: ASbGncuexSAIYvpL2iX+YubqwYIj5yNvvtepYoZi5rWvQwAZaCQ+9SDgRNeSdHoRkpj
	NqM9EhWDBXjU87kLcXtuxeEj3SrbS95K2d4+6AMZx+BUzu4BRomkwPc2ZiVV2sNf4KXPf11ASL0
	UaN4JlSO5msXOjCPBdR4xmsOvUQr/vfVLV6zKgOHFafxQ5bSWKKTnyy7X0RQWAUusur2PnLtfKJ
	FcLGj44rvDBBAff7ZlZ9LkXdcPReveQWwpdDfvlYZ6KJHs6qYEh2rLCSGw9HvSA7mOdGHy24tMm
	FbDD5YUFPoTJ4bS8eNwK2PgMrY9inlPCO686kHt1+nKaxyOL2bCc1tyR46/oJUOY/WjI71aec0P
	Ia8onb/ypjAtUdtcnpWcIVxhmJ34iNbJHPoE1dgSGTvKajosFfsghg1l/LT6aHodKGVdLbFJA7p
	SQP+MP8ltBCesBLN7dsZleDW0/7SFRwnbFaysAGJA0g8Ggn40wYyjNhRjPmtiXRU+v
X-Google-Smtp-Source: AGHT+IHW9Dzu/UH+wU35yc2U6yxRXsHH+wAiiYWkaNyB2KGKUs8KlgR+i4pk3Vixmtau8Xk1OhNnpA==
X-Received: by 2002:a17:903:245:b0:295:6c26:933b with SMTP id d9443c01a7336-29d682be6a7mr84675015ad.1.1764872006465;
        Thu, 04 Dec 2025 10:13:26 -0800 (PST)
Received: from ranegod-HP-ENVY-x360-Convertible-13-bd0xxx.. ([2409:40c0:1055:766e:b9ed:27c1:5f4a:4f11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae99effasm26060155ad.57.2025.12.04.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:13:25 -0800 (PST)
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
To: axboe@kernel.dk,
	martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>,
	syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: fix memory leak in __blkdev_issue_zero_pages
Date: Thu,  4 Dec 2025 23:42:59 +0530
Message-Id: <20251204181259.23864-1-ssrane_b23@ee.vjti.ac.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the fatal signal check before bio_alloc() to prevent a memory
leak when BLKDEV_ZERO_KILLABLE is set and a fatal signal is pending.

Previously, the bio was allocated before checking for a fatal signal.
If a signal was pending, the code would break out of the loop without
freeing or chaining the just-allocated bio, causing a memory leak.

This matches the pattern already used in __blkdev_issue_write_zeroes()
where the signal check precedes the allocation.

Fixes: bf86bcdb4012 ("blk-lib: check for kill signal in ioctl BLKZEROOUT")
Reported-by: syzbot+527a7e48a3d3d315d862@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=527a7e48a3d3d315d862
Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3030a772d3aa..352e3c0f8a7d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -202,13 +202,13 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
 		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
 		struct bio *bio;
 
-		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
 		    fatal_signal_pending(current))
 			break;
 
+		bio = bio_alloc(bdev, nr_vecs, REQ_OP_WRITE, gfp_mask);
+		bio->bi_iter.bi_sector = sector;
+
 		do {
 			unsigned int len;
 
-- 
2.34.1

