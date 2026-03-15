Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458B84207A
	for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773588878; cv=none; b=urgqaZwDRckZJ3UkEcRG+pxAg9TVGqEIWf64KidK9s/k9KiA6HsO2Krw3txKxF4MCSUEeswNN1azXIcREqvIQtqS505oL4CrjXtqWhwmzyge0FlJ2j9zwzu9u+82nY+5x6W6Iquzdck6pS7iVDvgYycHOwZYfgQ/UBaUr7UWBOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773588878; c=relaxed/simple;
	bh=WxJyDOdEuPuJun7+1+bEyN4QPlJwqVWIl0S4346FmHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RqpuUfMDQ3HLhtxN8WMDuUpATi4dllWvEx79jE1+Z2/Mbl/4skinJIJZNOHh5gs17xvWMA04Yp2dDQHaI2u3GFZbBfk2ij2f0rr84Wiid2KR/vQz4NT/+rKoAUTIbM9F+iv5r5igiE9DB5EtsGCMpbgjF61oEr7o0deZgA5WxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvrN4SOX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvrN4SOX"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b9b190easo2613376f8f.2
        for <linux-block@vger.kernel.org>; Sun, 15 Mar 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773588875; x=1774193675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WR0DKVtIy9pyWhIQ6wb5mRwGUmKGi61Wcre0R5+SJlU=;
        b=UvrN4SOXm6Q2FKLjgP7tBFMytxg3+qTZ5VbS3YvBHBrRumj83mNOV67GPGVqefN45r
         r67p/0PYAfpfDUIEwOf07IeK0ICGfUlKdaJu7992uHHbhNIB7vz/cJL0Et80H5EEn815
         HupzLOqMtpBtLX2ms1Yg7VvvsuAseCluOWvy24TeU7qRIRDTJr63abXEcquy9dLQXSIy
         pOGHohycGEp3ApOg6VEacE3CcdrR/6KP/JahtjTKhseSnWuXooj3pUz9UBgdblZSbUt1
         NOB2+thws88diqyzp0oCOioe4XExxNe9IFxmPSjbt7+a+XJ01AeO+7riyIcRRijTu075
         M0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773588875; x=1774193675;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR0DKVtIy9pyWhIQ6wb5mRwGUmKGi61Wcre0R5+SJlU=;
        b=DhUoYeR19LsrZ6/fQQZP1jQQGRAvRjBHSP3+eEvi0zrLO6yWCj5+C0YtVuxE8mXPCT
         y30GWOOi8xfhzcC9NDtSV4kF/TIa/DuL/XSOV042HDJTsuyw9FEaDluvoLkyNBFZmXym
         Vymmfr/ADQmyHX10SOeEovzxQPF+wKr0uKCyoQpwNqrlZeKKtnlCaUYpQL35aOOsxxe6
         DtYKZLkMzltOpuaZwDhsuiIN1fV9OoBuMAY98eytWtBC7EJkq0Rdg2tsvefytLSsAWEE
         PeKvTRLB4lD7JWZIdxhCvLHQFdJgZV7iJh7vgsLL/NGPtpB8/lRlinuD0Rr0zZUlyHCi
         zbWQ==
X-Gm-Message-State: AOJu0YyVIkoyWdEG0PnJP9Wd2xTNV7FWAOgQ9N6YZrUx9C4hi9mjwtU0
	MwpdHHXq+7SFBos/2IDviErAv93PxLplCwb+v5lbRlIiY2ZZ6P+vKS1OlZZCZDtR38c=
X-Gm-Gg: ATEYQzyRxPeMQa8Stw48F0YJdkAK6V0tbHe3104/HvdpVXj8qt9nUnxtj4l6ObsU071
	G8zH0Run49gAb6VIllRbsEG0ZRFTJ9B1My0abGNOC0gFofkmdcyjoYr8mZve+/VCdhMtfKXoLMK
	J0rySOvmrjNtkissvVhE0Qxi+wcF3KK+w1CdJV8WUsS8DP6H+ube5wTvRtgobp2fEObRZUj4Yww
	c4OteecGwML2n0ML3N4k4zC+RThF7PfFuUYa5yIApokHJac+O+LlnKaQBO/h/veKhbaakWETncw
	HgajJfT5KqnYniBalXxZFTk/U4EakHu0sKEVzcCMrULaxJ5FHxKhu07gdFvN6+M5o9SD6MtlJt5
	Gl4Okk5az9VJiI0ecFm5mUzy0hvrN0Z8WBcElbQCcUNzEJV8u02tnop4/U5l92XgvEOjlAEPk1R
	Ud1niSKlCfCAPZgmw0Bb3sFfPn5qBIwnDj8W37TOCAM9mFdhqQ13gOPa+1AxeewcTIzDaTfoTJk
	H4+DgQd+EKsLeZSfxi3UYxXq7IiKNGhKVWIoWai
X-Received: by 2002:a05:6000:4287:b0:43b:43ae:8c25 with SMTP id ffacd0b85a97d-43b43ae8d39mr1153303f8f.52.1773588874560;
        Sun, 15 Mar 2026 08:34:34 -0700 (PDT)
Received: from DESKTOP-TILNSD1.localdomain ([139.47.104.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe228986sm31626578f8f.35.2026.03.15.08.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 08:34:34 -0700 (PDT)
From: Kit Dallege <xaum.io@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kit Dallege <xaum.io@gmail.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 2/9] block: add missing kernel-doc for memcpy_from_bvec() and memcpy_to_bvec()
Date: Sun, 15 Mar 2026 16:34:24 +0100
Message-ID: <20260315153424.48391-1-xaum.io@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the @to parameter for memcpy_from_bvec() and the @from
parameter for memcpy_to_bvec() that were missing from the kernel-doc
comments.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Kit Dallege <xaum.io@gmail.com>
---
 include/linux/bvec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 06fb60471aaf..3cf51889c6d4 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -256,6 +256,7 @@ static inline void *bvec_kmap_local(struct bio_vec *bvec)
 
 /**
  * memcpy_from_bvec - copy data from a bvec
+ * @to: destination buffer
  * @bvec: bvec to copy from
  *
  * Must be called on single-page bvecs only.
@@ -268,6 +269,7 @@ static inline void memcpy_from_bvec(char *to, struct bio_vec *bvec)
 /**
  * memcpy_to_bvec - copy data to a bvec
  * @bvec: bvec to copy to
+ * @from: source buffer
  *
  * Must be called on single-page bvecs only.
  */
-- 
2.53.0

