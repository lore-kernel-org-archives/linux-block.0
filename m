Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6219377EBC
	for <linux-block@vger.kernel.org>; Sun,  5 Jul 2026 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783252605; cv=none; b=josEByXXhVqfLfWS5YEh5UZabAcnJLtcLL36ih2hV+Te/bWx7jTTAPZHJQb7ifI0pcbrzx6TU5bRJ2hN27cZa81TRtipuoXGzqUgM4xlieesTfcG6lQFFEkdpiSdvCfcCXqQKfwBw3egOn9OrDP9n1qrNzRPkUhHkHdJbzSiZhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783252605; c=relaxed/simple;
	bh=psdL2ehjhK1+otPuT+qxaqnsGupxQEbTsh2uBQHmRy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAne8+9382NXJyYFB45fVWBOwf4u5IPnygNSpzjGW0CuLDCgG0Y7RqHUeaxtSosHpVNSSU8822lcRhLFWwbxuv3YU8gOXid2pc5ubEQFh/8G/xp9dZIK0vVAk71+b63Wh/moOnDGqF+3G6YTeVJ001q9GTnucYwxoOPmK5hguFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=k+DIDVzr; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="k+DIDVzr"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4758b2a9e2aso1208159f8f.2
        for <linux-block@vger.kernel.org>; Sun, 05 Jul 2026 04:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783252602; x=1783857402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwRuSlbR797Mkzk8fZcr08AJmiX5cll2qBttTfovZeo=;
        b=k+DIDVzrLzklVsV3ENFHFunWW8O8Ho35rpail8JmCa1wxn2niCAMlDdU10/J8u0dZa
         oSFWrHK6yqrl1dmMeI4NX7CQ7LiIHTsnlQ590B3RQijkubkEH6LSxmtU3VvRoUtfIorU
         oagZI8MBIlfm4K1ar44FV1cWz2KmO48p/9qxCpNvrXDr2c2luCPvLItZ2VKeP4kCqIId
         xUif8IMLO8cKmR2GjMJUVzY03Tk5mFZDTRGPrk/MsGWWHrwxA7uuFIDUkTzXfP5NEZjO
         s8l95r2izTiL9W9PyW0vo49HzmO5KhAD1I2Go0kgAWnJi3AUAxlPwTFEkg8WeVkeOJ5i
         Jh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783252602; x=1783857402;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwRuSlbR797Mkzk8fZcr08AJmiX5cll2qBttTfovZeo=;
        b=tYNKs5cVTkRI1YHHJo7Me9B8O9XwLrI6YHzo3CZfNbI2u7D92vz8PjRo2y4tS6Z1Tj
         1woYNalfMxRtA0IEVbxBoSmlsLXyZOxUv33tEbcyWp1uGHCLoZNovN8sF4Oi1Y0RUECg
         PkPY1sASQ/dYQBZW95prZrt1Ljh3M5l2QbcNnfzmxwscAjx2tV7Hex3jruvfesbjk9NN
         Xj+TjuO6zbf0VHRA2R9pSg4rKL6uJoaPVerh3GBA5vBkZpFCw88A9m96GGALhYedm8Qd
         1Z0UX2GHKa5SzyPHlO4XAtCJzF4DkbQboYDL8ks0EhvduMcA4jg27WZun/S6T8uTE/tV
         T5XQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5q0qMZ5J+TpxuVZKjUAhxBJCk9W645zCGhQDV23HeDT4rtGv5p2mNZuVmjpgRwBgUgPt+nNK55ACINw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLh9MOpPJUxDJUitOXVbcH3XvnZO+jzfi6+5VUERsq6Ww5nVZ
	4E9vnizJ2rSL6+KxaqbsYOs4H675+ANPJLEmHfOkFe5HXC0i371S/JFGstHTsxs+RCCE
X-Gm-Gg: AfdE7ckj8Nokw8zYyGlQuUuuZxavEH/RMcZUkk2LqpuGlgnieuN+YTwpvfa5cobGk6f
	hdQz9119G98DRNln0q1UuC2SP/YrwNrfD3ylk7MnSjuXxvxVSsgfmJRY5nu0uXM7u3WRII/JCu8
	H3E7J/ZuIhQ+fM3ImDkzmV8ysbFDN67j1pbiE3hFBchjXrr+8lUwWO3j48qxEaJxjGmqIPJFUox
	kDR1GGqI59X6OKV9C9zyx3dLO9SscyLCtUbxIFNDglONk+aT+QSmV85rQmOGBD9Vvhsk51sntTr
	N3npEUqaZmPPDWVx9z2JchKPuZdlnIbfGOgSRS1EmVSSXS7sP97chUY5bRAPDb2zR53n2Yjuaw3
	vV8mVWZDVzBkgQpu4RbOlbA1OeCCuhG3aCvdDpQ5glsLWds1KoICbVLX54e1k1xOiy2TFOulg/n
	iZDNTTxkYEyREs6j30a0J5J8n1GCsvzF7HxurUuDD/fZMbXZPYC5NIy4Nr9xStijXOmD2M3qRXY
	Usm0ibDossTI53S8UCYLacRBBGSWt1hxzU=
X-Received: by 2002:a05:6000:1818:b0:475:f0c2:5afb with SMTP id ffacd0b85a97d-47aad07e091mr5521587f8f.49.1783252601779;
        Sun, 05 Jul 2026 04:56:41 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.219.178])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d83bdsm15695537f8f.13.2026.07.05.04.56.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 05 Jul 2026 04:56:41 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Jens Axboe <axboe@kernel.dk>,
	xen-devel@lists.xenproject.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH] xen-blkfront: fix double completion of split requests on resume
Date: Sun,  5 Jul 2026 13:56:39 +0200
Message-ID: <20260705115639.72805-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a block request is too large for a single ring entry and the
backend does not support indirect descriptors, blkfront splits it
across two ring requests.  blkif_ring_get_request() is called twice
and both shadow slots (shadow[id] and shadow[extra_id]) are made to
point at the *same* struct request, linked together through
associated_id.

On the normal completion path blkif_completion() collapses the pair:
it recycles the second slot via add_id_to_freelist() and only completes
the request once.  The suspend/resume path in blkfront_resume() does
not.  It walks every physical shadow slot and, for each slot whose
->request is set, calls blk_mq_end_request() or re-queues
->request.  For an in-flight split request this visits the shared
struct request twice, so on resume/migration the same request is
ended (or re-queued) two times.  The second visit is a double
blk_mq_end_request() (refcount underflow / double free) and a
use-after-free read of req->bio, which was cleared on the first visit.

Skip the secondary slot of a split request in the resume walk, so each
logical request is completed or re-queued exactly once, matching how
blkif_completion() already treats the pair.  The secondary slot is the
one that is linked (associated_id != NO_ASSOCIATED_ID) and carries no
scatter-gather list (num_sg == 0); the first slot always keeps the
scatter-gather list.

This was found by 0sec automated security-research tooling
(https://0sec.ai).  The bug is only reachable on suspend/resume or live
migration of a guest whose backend lacks indirect-descriptor support, so
it has no local reproducer; the fix is by source inspection against the
existing blkif_completion() collapse logic.

Fixes: 6cc568339047 ("xen/blkfront: Handle non-indirect grant with 64KB pages")
Assisted-by: 0sec:claude-opus-4-8
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/block/xen-blkfront.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index f765970578f9..b2e83fd0c77b 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2079,6 +2079,15 @@ static int blkfront_resume(struct xenbus_device *dev)
 			if (!shadow[j].request)
 				continue;
 
+			/*
+			 * Split requests alias one request across two shadow
+			 * slots; skip the sg-less secondary so it completes
+			 * once, like blkif_completion() does.
+			 */
+			if (shadow[j].associated_id != NO_ASSOCIATED_ID &&
+			    shadow[j].num_sg == 0)
+				continue;
+
 			/*
 			 * Get the bios in the request so we can re-queue them.
 			 */
-- 
2.43.0

