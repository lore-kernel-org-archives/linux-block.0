Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059111367
	for <linux-block@vger.kernel.org>; Fri, 19 Jan 2024 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705627489; cv=none; b=oil5R/XEJ9HoPNddjyUWDHXir24J5bzivuRLA+XeKCyzwp4wQ8aaNr+g3qkF0QHXTAhtDcuP18ZdEpH+DmztDaT6fgGmjpyp969VUw0GQe78nW1/FIitCf9CY93mUn+eaZXZu9RNyfRylgRPK5KopoZbWiV1r+Er9nNI3vUmHxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705627489; c=relaxed/simple;
	bh=qHe413gfrqhWMzPS+kpL1P7lBu3BrHu/YwPYvmilhnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwiH1+PdvJ5tLy3TczF8lCMp/xYvuW5qM/bLi65Y9ZtSWgps2Mc7J7LsQsP65RW4Os5Vge78FwaIL3e+kxK+hyxbNFgFm27++zQMpO3qkWoe5U7rEMJ6nvSCKrnAkZ12k3HNrhOwIl0C3Kjy/Jq7UmuDQea8+N1cHoEblgVy9aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee/SpJLH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee/SpJLH"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3367a304091so212415f8f.3
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 17:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705627485; x=1706232285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc2bIqNsKQyWLXjcwoAS4v6rdrw7++mp5+Y3/zgcmhw=;
        b=Ee/SpJLH/g9jMDuq9g3QY+RLGfYRKvA893OvM/xReJ/rA4PC3XdvKY+xN0sMMo37M/
         kWm3UCSJDxPxhm5dJoJ9Q95AcTux3SoLs+LSgXgPbSvVi4x7LvtI7aMQ6n1jCC2uA+MY
         /ysArGlBGxEDQ+d1m4wPSn7glQZCj6A3UXptusEMgyNzYr7e7+QCfwcHKWxLkH+rkcTB
         LuZHJHb6D6Il0x2keB/Ai1BpmzSlNL7exVQD7+UbIHxs9Pa9CLhebnAsT9LcPVojMETI
         /WYwNxW1XNDsUg6F4yEH+HneybDlup4zfMLlxXJV/TnmdtMb9NVsZYQO1AaOWf5dmrvr
         tSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705627485; x=1706232285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hc2bIqNsKQyWLXjcwoAS4v6rdrw7++mp5+Y3/zgcmhw=;
        b=hOs/nBrGaMrPWB8xC2Sm5JL+fm5m7CciLn7O65ar7Qyh9q32GbDxzA5kDRGgjLfpkp
         u6npl9gmRn36hXZk4WBl2CmTjvRTWIvxGMKT6u4G1Ancp8/jluukCZK2Je+5pFhgw0Lu
         8OAXCuYZw1MLoMf5QRrw820Ac/DbRH0OMCC9vU+tNVml3b5H/sU+WQU54rSF8nKJ5hXa
         Pd4nL8a3DYWDoTaNZT5WHZueF+iSqcZaAaeIXJHS1Dms/u776no0KUWT4ku1rkVXTHwe
         1V6Ulh3xrY3FUjdRKu4xQRvegLdUyQRT0f7oJHIVPxx1E5yPx+roY0VU6TLHQfNgRjPm
         GPgg==
X-Gm-Message-State: AOJu0YzFpSSGj4YKSafhh4FOAIvRDF+/LJyYa2clV+0FtUJ4+xAUAoE5
	UySCt/gJQ5u9zoQSulE2Yc7XZz+hb8YdM/80DxOaLfGZTROBCgC34rLouN46
X-Google-Smtp-Source: AGHT+IHEk7NGgGUDCxnrVSECcptW8AI6T0Em7zJYmePneNUvQRLka+ixFkICPVvQhAYqPdL8QZa4RA==
X-Received: by 2002:adf:f802:0:b0:337:c331:b469 with SMTP id s2-20020adff802000000b00337c331b469mr698675wrp.49.1705627485432;
        Thu, 18 Jan 2024 17:24:45 -0800 (PST)
Received: from 127.0.0.1localhost ([148.252.141.25])
        by smtp.gmail.com with ESMTPSA id dw15-20020a0560000dcf00b00337beb77c86sm5176458wrb.67.2024.01.18.17.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 17:24:45 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com
Subject: [PATCH 1/1] block: optimise in irq bio put caching
Date: Fri, 19 Jan 2024 01:23:44 +0000
Message-ID: <dc78cadc0a057509dfb0f7fb2ce31affaefeb0c7.1705627291.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The put side of the percpu bio caching is mainly targeting completions
in the hard irq context, but the context is not guaranteed so we guard
against those cases by switching interrupts off.

Disabling interrupts while they're already disabled is supposed to be
fast, but profiling shows it's far from perfect. Instead, we can infer
the interrupt state from in_hardirq(), which is just a fast var read,
and fall back to the normal bio_free() otherwise. With that, the caching
doesn't cover in softirq/task completions anymore, but that should be
just fine, we have never measured if caching brings anything in those
scenarios.

Profiling indicates that the bio_put() cost is reduced by ~3.5 times
(1.76% -> 0.49%), and and throughput of CPU bound benchmarks improve
by around 1% (t/io_uring with high QD and several drives).

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 816d412c06e9..a8a4f3211893 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -763,26 +763,29 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 
 	cache = per_cpu_ptr(bio->bi_pool->cache, get_cpu());
 	if (READ_ONCE(cache->nr_irq) + cache->nr > ALLOC_CACHE_MAX) {
+free:
 		put_cpu();
 		bio_free(bio);
 		return;
 	}
 
-	bio_uninit(bio);
-
-	if ((bio->bi_opf & REQ_POLLED) && !WARN_ON_ONCE(in_interrupt())) {
+	if (bio->bi_opf & REQ_POLLED) {
+		if (WARN_ON_ONCE(!in_task()))
+			goto free;
+		bio_uninit(bio);
 		bio->bi_next = cache->free_list;
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
+		goto free;
 	}
 	put_cpu();
 }
-- 
2.43.0

