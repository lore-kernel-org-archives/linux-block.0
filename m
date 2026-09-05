Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F8233929
	for <linux-block@vger.kernel.org>; Sat,  5 Sep 2026 10:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603424; cv=none; b=LCXZCwo0zw8KohRZszXud6qOl12DKGvEFftZnc+jwTTzardvXU0bbHEu5n35WURKbJ4OTgxCTCh4pWN9Ch1orYEL6IDfHTBVbX4BeMU2rNCASmRNVsbaeHIVlFfIjGDuI6Dzz/QGviOH4E0ckqVz4f2pcS+kuRYXObMG1IzxVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603424; c=relaxed/simple;
	bh=LOej/AYRFpanqeFtrB12UCaSzUurAtWEeV/Opq5mv6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qCV/DBfFqNI1np5MRzs10Uy0rm4bO7V7M7rH6txDIXlLNFyf2AQ2AhA34CrrGDm/4K88yD4IbDkZ2fFou/mdDfzwuq2rI98dbt1nrMb9p4HBK9iZ3w2udsjaGCVrb422lS7P3MhrOYyXBLvreDUEKLeNvrfACKLNKjh3bOiHgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRN8rc0j; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRN8rc0j"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-485850cbac3so1190298f8f.3
        for <linux-block@vger.kernel.org>; Sat, 05 Sep 2026 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788603421; x=1789208221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hd94cO2LUptZCyLaPZ/4faK40v4+2cKldNglmmH7Ufo=;
        b=PRN8rc0jMfXrOj4bd0RDDIdSbeM29UESirqBoEF6Lv4mw+aBQCZcVALHeHpZzGpvD9
         /jdG9maUKhMsmVdePzI0PirkqrF4mjLzNORH1vBZYdNf8YAj4Y1sm5K+r+gFu6KSFIGe
         ID715ZQdi5dcSuJfl1GeR9hvWQi7TzAtVz3rxNT0wEjTopxZmO+tmkA40/0GoyWiuYGu
         DNFwGZ5CYsMrssigp42NWKz/sxLrCTlsrci172hyQidcTY2ZFRf14U3E0nM1FZuiDlwB
         m96K+F2w3cZXJqhi3yQtg1LVnmvwwX5KRtV8bRsjS9YcAvZ6ZQjHNKmZ5nDzCrkMhP+K
         udUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788603421; x=1789208221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hd94cO2LUptZCyLaPZ/4faK40v4+2cKldNglmmH7Ufo=;
        b=PcuOkbFfMPvBOzDCoKnkBLORcX0e1mnejMfGDnZ0foY/N+Swv3rlY8r9FQmjZrjIwP
         Rfhj4ANFNgeKwlMsdDSbkeUnwahWuJjgkuGm3418gEV3ohmLII4Xx9MbWPagv3yQ7Dqy
         KQpgZF2CydfsAm4o23qnaVLLuW6ZU111OrdEVHsu3IT5I52n2mN4aNItiRaZDxmSlVnF
         6twXtsrCuKcsBIMBZ8f4s/SjAQfEYxkAJ0dzphEH0Daeo2+Qq9bGkwUuH9KhEcRMSp+8
         /Gt91X6q6HfzQo4/0z9/fm4B1qV/xkM7LFtcAHhT/oiCyuzGwybz5exGOGHPF0hwyBL6
         X8Hw==
X-Forwarded-Encrypted: i=1; AKwUvBx9lAActYpAeqoaxWo1j1GgQGsplmTx5ZSC4butlQCJxf06FDY6kP5mYDZGjC9heJEdDj24o8xZROYfOQ==@vger.kernel.org
X-Gm-Message-State: AFuF++muB2yRxBP95yao403g5t48Or+lzGKAz0OaE6jSQxHC4Bs15dJl
	ri/0iCYextPTuOlE7EgiXgpfOPZ3WZhBW3QVNgiyPSKSof/lNANNvfLF
X-Gm-Gg: AYBFou2ZL97hbTcLq4qzjERGeZ4rxVt4sX+3/oa/yOC2UGkH1CXcg8aI7yMtrFpcZXR
	a1z+6EK68C+a21+fn+ZniKbD2qxs/2Vu4ihWF9sY3aQRlE5EW+Bg/NQt9qzjK465yljtuLFtx6A
	FSri9MK5ySG+EsmX6OMvFSm6K52ezgZisXxMB7AHe6cDzSqJi8/p6WPXuCRRyw2et/jvwcJWpRp
	cBqCqJv1FpXCmy+LwVxmxal14WtBNG6S8VDizxub5VPaLiapM9QL2Gl7CSkm82mE7xBtQdbYTi4
	oA+7GzY1bpFOdymKS/vQHchJGoDSlqdzYOGL31a4GPdiMelwXopq7v8s7qzGsNEepATfU5ZIST4
	llH2f0VSiarcRluLbOYycrYiuSP7qJWaj9c+ipGQqxztx/bHT/POxOROi39KMI3clzHOQOz31Tf
	FVIL1skoJp1mlsk4mURThwx5FNd9BofOlNjFBaSgFvj30VKN5EMYrLshKVyonGA2rdwNFLr/tt2
	g/cIiavqizs7WJ7TT49pnUjgVVQyBBVkBzrfV8pZB3lY6dnH2OFnYAl1kdP6i2Vlp8D0NM8NVoK
	OHl2t73iP7wYYPpNgNFVhrbejEaGrE83xXSmqIyAGZaW1WRiCl+lYePi5/LwKhZtryznyqFIr79
	Dzw==
X-Received: by 2002:a05:6000:288f:b0:485:8c16:a357 with SMTP id ffacd0b85a97d-4858c16a736mr9388870f8f.47.1788603421059;
        Sat, 05 Sep 2026 03:17:01 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858bcefd59sm9405888f8f.19.2026.09.05.03.17.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:17:00 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	linux-block@vger.kernel.org,
	Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH] block: Drop the stale @op line from the bio_copy_kern() kernel-doc
Date: Sat,  5 Sep 2026 12:16:58 +0200
Message-Id: <20260905101658.42774-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bio_copy_kern() lost its op argument in commit 05ce4c584cc6 ("block:
use bio_alloc_bioset for passthru IO by default"), but the kernel-doc
still describes it and kernel-doc warns about the excess parameter on
every docs build.

Drop the line.

Fixes: 05ce4c584cc6 ("block: use bio_alloc_bioset for passthru IO by default")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 block/blk-map.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..35212355b8cd 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -356,7 +356,6 @@ static void bio_copy_kern_endio_read(struct bio *bio)
  *	@rq: request to fill
  *	@data: pointer to buffer to copy
  *	@len: length in bytes
- *	@op: bio/request operation
  *	@gfp_mask: allocation flags for bio and page allocation
  *
  *	copy the kernel address into a bio suitable for io to a block
-- 
2.53.0

