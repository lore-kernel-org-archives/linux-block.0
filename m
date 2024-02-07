Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874475A118
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315375; cv=none; b=ZjglFzXeCm0koQKkmPt9xX7G1M7GdRVr5U6sDiHBWbzQ1zRjWHKXKI+gy47QZAS59je0dxOxYchi/THEXpzo/nymaepZBSA2Gol0VWCq534qE4m66pZtY3KlycvuYEUFkcSHdY71Rwzk1x+wHLVcIvzGJ/4HUMgFsVRiGF3K8gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315375; c=relaxed/simple;
	bh=2WmJgkSenRxpIttZDu2dhZznDhKXDgzxN8bLvqnz9M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8t9Ma9vPYvVIW91L+A/p16QQWFvagWbvUw4KYWfOQtX76+qsV+YP0TREVjDpIYmY8uP3aFS5twnBP9i4+3Qqky047qeHJeHs78cWOe771UKa71kDcfMvjqya79QP6qGbDduyNWi5YsEiOCy1kXZ0VX2p/8zKupRVEUZ3wQLDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQqRmT19; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQqRmT19"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a37878ac4f4so91015366b.2
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315371; x=1707920171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d69RaVnD7kByVI7pxyit7iXMKvljSVP3hcG7RieBkXY=;
        b=ZQqRmT19M9dmzHj+AH+2rTk7830HS3NpVpw3xC6F+KVgI+3hNa9YXN2sNbNbLfXheo
         4a0nGHvp3Q4CBOcrLsEwDtk+KuxqPBEccdRg8+GmG5E26fK0+GtTpQL12h39dyRhLdVD
         OD2xF9odcwf9yGZe5i0+/kzV5QeA/VOHNpvWh3h5M4KZ7z8IRJeMhNRCPhvt7qGbDElK
         K+CJxDfg0F4r1ZX1Urd2NZNg3hKrEIwrXbvlp87U8YoZigSQoQNIz3ytANQHraelpxl/
         0IKVLwkQqp2bxCRERSHRA2965N+OhH1HycIdoRABGNSYXA21HLx7NWwJYhBZ/naVMPCv
         l5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315371; x=1707920171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d69RaVnD7kByVI7pxyit7iXMKvljSVP3hcG7RieBkXY=;
        b=a+qzQZYAE4waltcP+jq4OUv3D1sq7WJnSRIuBlaFVaVlRBr5s24livk/Brhyf3poGJ
         OR/cIiIfkU12SwCLdEwyQU0vS/T4m6/tiP4bLrOGCiQyXTXsmor7HJAWmdJyrg+T/SMd
         M2AWsFaT+Wr4SkvdPq9G3cq3Dk7UYnN+uV741uhamekMf4roPPRP3JT9iMb9D/dlSpCh
         68lglRoz6qvxr58CRIZ8NyFUt1DclBe5ARYa4t9HjjQsRvLOZhMq8UGa/0yqfCzDpEKQ
         hGn8zq6eFSNbB9shTP3V8gtqq2egzNuqkFtHQ5fLTMNn1FYopEdZReyPb1VR5fI0YeNW
         d1GQ==
X-Gm-Message-State: AOJu0YyCds/1xUA27e1p4czXmTUUGQsRTJCDCL4qurXkfJ7FZfUBwPpV
	C4Gc56AGFzd0XEXIRgM5MAG1ouEAWGTWJZeUGvHvpOi/RD/BpfPQaq2E6gMK
X-Google-Smtp-Source: AGHT+IHS7WyxKuouKhiyVHmE+FGqVrwXXMs9Ux5A15ndo69qMiflGcAaPfQhyblzcfht7Ec40DVNxA==
X-Received: by 2002:a17:906:3008:b0:a38:33bb:a7f0 with SMTP id 8-20020a170906300800b00a3833bba7f0mr3085485ejz.58.1707315370966;
        Wed, 07 Feb 2024 06:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV07gjwuCbEXt1gKq5xYI8qM4TwS05+aUFc/cYbiSEcozgS4Y9vaOQv1YJAEP6GJ6crjMPgySmF5F4EtG5bJ2o27Bx5QnQp4WNBNMOSbIkOgHc1
Received: from 127.com ([2620:10d:c092:600::1:f25e])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a3758a1ca48sm791895ejc.218.2024.02.07.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:16:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com,
	hch@lst.de
Subject: [PATCH v2 2/2] block: optimise in irq bio put caching
Date: Wed,  7 Feb 2024 14:14:29 +0000
Message-ID: <36d207540b7046c653cc16e5ff08fe7234b19f81.1707314970.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707314970.git.asml.silence@gmail.com>
References: <cover.1707314970.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When enlisting a bio into ->free_list_irq we protect the list by
disabling irqs. It's likely they're already disabled and performance of
local_irq_{save,restore}() is decent, but it's not zero cost.

Let's only use the irq cache when when we're serving a hard irq, which
allows to remove local_irq_{save,restore}(), and fall back to bio_free()
in all left cases.

Profiles indicate that the bio_put() cost is reduced by ~3.5 times
(1.76% -> 0.49%), and total throughput of a CPU bound benchmark improve
by around 1% (t/io_uring with high QD and several drives).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 8da941974f88..00847ff1415c 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -762,30 +762,31 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 	struct bio_alloc_cache *cache;
 
 	cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
-	if (READ_ONCE(cache->nr_irq) + cache->nr > ALLOC_CACHE_MAX) {
-		put_cpu();
-		bio_free(bio);
-		return;
-	}
-
-	bio_uninit(bio);
+	if (READ_ONCE(cache->nr_irq) + cache->nr > ALLOC_CACHE_MAX)
+		goto out_free;
 
 	if (in_task()) {
+		bio_uninit(bio);
 		bio->bi_next = cache->free_list;
 		/* Not necessary but helps not to iopoll already freed bios */
 		bio->bi_bdev = NULL;
 		cache->free_list = bio;
 		cache->nr++;
-	} else {
-		unsigned long flags;
+	} else if (in_hardirq()) {
+		lockdep_assert_irqs_disabled();
 
-		local_irq_save(flags);
+		bio_uninit(bio);
 		bio->bi_next = cache->free_list_irq;
 		cache->free_list_irq = bio;
 		cache->nr_irq++;
-		local_irq_restore(flags);
+	} else {
+		goto out_free;
 	}
 	put_cpu();
+	return;
+out_free:
+	put_cpu();
+	bio_free(bio);
 }
 
 /**
-- 
2.43.0

