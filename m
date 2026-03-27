Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A67394470
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651131; cv=none; b=YZPNKoslg9Bvtj/XIv3CrPfmAnNiPjRkf27wurQ/CcrHBzxrOHwjK5iJpW1DXiChuaP1Z+y+gPDY6GS8Q1qoTyhhP+YN2Gq5UrbnkilxajjWu2FQZLlKarwEcWNIjXxZZvAnPWmTPqTi91GBf5IXUGgEZ1C5pIcJedXuHN5i/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651131; c=relaxed/simple;
	bh=WSb/Dar7CuUZusCwHnM/NiM1oo4nZTZnSW8WdbK11CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifPot/5qxvAR3YWaWyY2jbK6eQK8pIBPx7Hj4DidDdvoTWo2gXMP9I/1QNEG4l/YcXg1Wqxytk6xh+YorSHgByp6wJ3dLBD8HnVTz5owmbr0BZ10Vvejc/gzVkBjYH5HmIzej1j0l0RQ76ikvAaveRGsNMm3pZtC2Znr033mWWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=05WJ3/i2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="05WJ3/i2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b87970468so2436461f8f.3
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651128; x=1775255928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+4sneUti/b8Rpw1YtgfXCWa4T3JT6LBHzjjUYkhTX8=;
        b=05WJ3/i2rTwV0/T3lZpiEAxZEFjwHig37bGQcGH5O18kyGtQEx7V1lFKGER3QK9QDz
         OxNj8aXxigaw+eRcn0c5WnBkqpEO9Sxu8QlwkhWXIHF9J4Z1o3qxKu9/i0RO68Qvv4l3
         sR//c890KFxvNu6sFejPg4ACbjdQiFF0Ws+e3DtAFwnZlqIHdSZdDwBGfvsxBydE12Vq
         ZUDNYVgyDRsz5gFpuDj2cmDEDMCJPzF2ZZ/8QOwZYnnEE9cLbk0iYlRRFV+SaMcNCu8W
         htF6bwOHRAtCEt/oue0LqS8GXqwN+8iwAPSJHcOAQe582xifHXZUsvG+6aFTBKDaq4L2
         VqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651128; x=1775255928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k+4sneUti/b8Rpw1YtgfXCWa4T3JT6LBHzjjUYkhTX8=;
        b=N/O2Yqv5C+aRku32ILcUuyrX0F5kztSQzaIEVzFjUfgYLg3NdyBWV4tdeX3DXCXtSC
         t/SQUuai+jjrc+EGILNIVYTwMgGUkkIRiTaotF034AVBTW3HjS445P5+mFSo2Wp+OjFd
         cQw7am76zqHXDMwVfnylSCcVsYlu8x1gGB3pNnurqnO2hBfLOP4RfsafQ8Js0Uatr9o3
         wZUPjE0TDZPrOrO1cX7MPXMtLYZ8XqCOmNiIlPKVydfxKwBYJXoEnB3u60sMPuxlDYUF
         Va376EYa9tWWX4iP+8BOAkMachflQK5DF0voNRQMzrw6UxcZ3/jCmiGHIHvY9x8L3Ah8
         Dl1w==
X-Forwarded-Encrypted: i=1; AJvYcCWPP6Si+Z03Q7H8Ew/FC+fQWTHqe4ux9yRjP0G9aBynu11Co0HDtZ1HHnYOTy6M6OmUgmCxgidZTLsi9w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4CyYVrf0AyAOEQmk0LLwTjr+0lxPrsf3CkveOY/cQ8tcEJiro
	WLNCJUd/LwYlUJpImFlSKzdiKkXcH0GAsZw5nGav4KY+Vz0sXd4y5PJ+0zrN1wjtM+E=
X-Gm-Gg: ATEYQzw2K6EcHM2FP3q80iRVgWrUePli6DCsyUcYXA7uAswG/+ztaI2qKH12+22g13y
	7wmzoxshPAcfxmlG+tVLxIHXu0dOGPR+/mzq7Ijb7VxgowET4FYn67949Ef9ufJBowCi4dAkb7P
	mZMkrGfstvlh+/rNX2J8+/KjnycHn3jLsYh8L26lcvAjXtgXTMRrfgDF7yvhbJv+IFC2Q1DimZ6
	ueNXleqA/1z9lPZZPhYJUoKiO0sEVv6dTflyiR28HM9k3bMF6pVxuTqNf2g4jwB+RIv1KUznymh
	7HURFRkj3AX/S0u8wi8eWfa+ljOvxCC3Hy3cG9N6vt+gLkZzAMGWES5uTXNl0LsAR0/zja8eDP7
	u3bdR49Z57a6xYDgRjEcO/yMuSVaXuj9daPP37Bd8zUFmRvWyiyd96KqnhmLWph1O4jmh4o6PhV
	xpxHJxQcdHzjM/V7kx8KcowRlSwJQ0f8d4bFx/n2r8LE4DAySJDHXdcSI45NWvlF9ADxYGonXwk
	UzUZ9tdtSBQcX2b9Ar0SQ==
X-Received: by 2002:a05:6000:22c3:b0:439:b114:60c0 with SMTP id ffacd0b85a97d-43b9ea9afcemr7594435f8f.35.1774651127984;
        Fri, 27 Mar 2026 15:38:47 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:38:46 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Subject: [PATCH 01/20] drbd: mark as BROKEN during DRBD 9 rework
Date: Fri, 27 Mar 2026 23:38:01 +0100
Message-ID: <20260327223820.2244227-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Mark DRBD as BROKEN while the driver is being reworked for DRBD 9
multi-peer support. The following commits restructure the driver
extensively, and intermediate states do not compile. DRBD will be
re-enabled once the rework is complete.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 495a72da04c6..b907b07468bb 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -8,6 +8,7 @@ comment "DRBD disabled because PROC_FS or INET not selected"
 
 config BLK_DEV_DRBD
 	tristate "DRBD Distributed Replicated Block Device support"
+	depends on BROKEN
 	depends on PROC_FS && INET
 	select LRU_CACHE
 	select CRC32
-- 
2.53.0

