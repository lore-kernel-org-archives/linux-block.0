Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2477F2A
	for <linux-block@vger.kernel.org>; Wed,  7 Feb 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707315373; cv=none; b=BlSXPpeoV+BbJr7dG0p0PsiObHDBysybugW/R4ExeXLoSEIZUp7JmAlYO7MjOIQ2nPqMWCY/qbeX8zQGWWIlq/kDSEfnuxsjgPE4Du0y82Zkj5eIpqL0uczVboNbAwFVGKPjR2g0kf/ewM68JkzyoQS6EvLtdT4KyTs5h75ONWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707315373; c=relaxed/simple;
	bh=3hP3euvkjSDtDA4jOw6DKgqrMcnb/Wl3i0FpsD+QN3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gklgx5oLj5HKLVd3FHF8j+Op+oyk0LybV3Odz3IM3mmJsTm9s/eCd8yb20dmFiSZSkRwSgrK6L0mRy8bGpYrYuzmE3qJnTgSUqy+rJiq0PTZnKPSckitl3b1UxfAJZX12FyoVEq+qBfTCUaBMbjE+XXY95p/vjfkd9z6N8H/p1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGOCNNEH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGOCNNEH"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511234430a4so1324749e87.3
        for <linux-block@vger.kernel.org>; Wed, 07 Feb 2024 06:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707315370; x=1707920170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR9xdRgHnym0JZxPFK7i8YTAchF0B0qcPwkx+kO+l4Y=;
        b=PGOCNNEHyQQMrw1+qeHPfbbiJKxsZqBCvkZDAhjAgq75rTn6TPmCKnbfs8JEoW6NwJ
         pcioCUbG+3tqSOh17PSVot8rubGCErp2ycTqIfdbXPiSbwCukbcTLGHYzmqs9YnwQVL9
         2QUR/Zt5hHIZAonRiQ3NngkLu9wIbmy5eG6ddfsXccMRMu+0on1Ir8kFsa1FWCWi1Rjy
         VpWxG9RFjPJy9MhdWa7zoglHu1rVlE6X8R0DsYYJmyTZ3m7duI/d4RVMkD8Oe4lLbfp3
         aMHzDeuW1BlhpCmD7rpII09o6icJ4fasEHpHMf12RrC0vyA8UMFyVrLR1l50MP4skZgK
         MvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707315370; x=1707920170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR9xdRgHnym0JZxPFK7i8YTAchF0B0qcPwkx+kO+l4Y=;
        b=YuzYjswjCyHSYx0zzqC0HShFPbwJt4HudShrsuSh5KtENjYN+G1x6oGRFQF59nyvH8
         HWQnWdj2mi14yRc0aikzDVfojdE+WxCxwyn4EFU7WYh8SanWnYp59liDPpiR0aRo0e2J
         y13/j4F0u94DmF/Fx0410I289h7xFl8I3DxiULhIDDr34u0Zyy+ad3TRRBPVAl0PEqi8
         txHt40zHUp2D5lJVHS1C2hcx9IxPpKyGx4WbMr4lH3Ki/ml8lfGjxm+X+2Tp+27hpxig
         YLEDjuFmAD2DmJiwqHA1CvnsGQKexiaM7x0XofqUqkGdr1llZfpNA+om3NLD+d+9UZJ7
         02gg==
X-Gm-Message-State: AOJu0YzBzxv7CUqnz0xr+BEncHVVR7APTP/VTbo2fjUKTPGLr+EMADpB
	bR8h73py8zhGzmw9LoE2k8BNrpDmz7arS9xKIEe3G1zXh1eRO2sbzEU3JzoQ
X-Google-Smtp-Source: AGHT+IFeuW+pn9/7DPxQm0sVvWGYNMbIzyrSF0v2xZ8zhgzDbFwAM4oGxaGUkjun6ZIQE20Rf3eKjg==
X-Received: by 2002:ac2:5207:0:b0:511:5008:2b94 with SMTP id a7-20020ac25207000000b0051150082b94mr3739182lfl.19.1707315369724;
        Wed, 07 Feb 2024 06:16:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUIP+It+722hOXgmBvYFNQFkbGVCg9w4n5G8qA6kJaMFWWE8XIhCiXBsSFBGHqPfkflAW3JrJ4VXOHFTuGUw3wMjwEoKaduAeEfgT/zJivgxjnc
Received: from 127.com ([2620:10d:c092:600::1:f25e])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a3758a1ca48sm791895ejc.218.2024.02.07.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:16:09 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	asml.silence@gmail.com,
	hch@lst.de
Subject: [PATCH v2 1/2] block: extend bio caching to task context
Date: Wed,  7 Feb 2024 14:14:28 +0000
Message-ID: <4774e1a0f905f96c63174b0f3e4f79f0d9b63246.1707314970.git.asml.silence@gmail.com>
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

bio_put_percpu_cache() puts all non-iopoll bios into the irq-safe list,
which entails disabling irqs. The overhead of that is not that bad when
interrupts are already off but getting worse otherwise. We can optimise
it when we're in the task context by using ->free_list directly just as
the IOPOLL path does.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b9642a41f286..8da941974f88 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -770,8 +770,9 @@ static inline void bio_put_percpu_cache(struct bio *bio)
 
 	bio_uninit(bio);
 
-	if ((bio->bi_opf & REQ_POLLED) && !WARN_ON_ONCE(in_interrupt())) {
+	if (in_task()) {
 		bio->bi_next = cache->free_list;
+		/* Not necessary but helps not to iopoll already freed bios */
 		bio->bi_bdev = NULL;
 		cache->free_list = bio;
 		cache->nr++;
-- 
2.43.0

