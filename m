Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48625383E8
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172403; cv=none; b=lYiHh79C4SrSzMw3IH0jS8uKMYerb3Gb3mZam91BoqUSN8awuFsXhchoAjwZYh3NpB3bSt+j+LZuXVtMDQubxgGM8h1FuphHGsJSlV7V9AZez69eg47jpp4WnyXo19qXCkBPTXTS/2zIhzVkUMHB7CgfoWV1n6X22dDvkr4T7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172403; c=relaxed/simple;
	bh=rmGcpoIKRjU/t1b9m5XR4fyG3dTYuOf8eWB6EDUthNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nR3x8yxc6nyxSmjcnlhyeLtamAz89UyLmKTq6IgVb9lAvrUw2EvrbvQpbehyyKNqs//avQBYYreJnjKG6ZHHAq0fq+TkIuv+Gb+bbQYqKre431azE8xZe1cjmMHl9iv1+xBsaCQvtvROySApMXn74dYQs1X1KqunO4aA4wPq6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=H37oPexO; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="H37oPexO"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso5585945e9.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 07:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1790172398; x=1790777198; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vL+K9FciO0t0sxXo6V8h49AzokhOlta0lk/EZzHWy48=;
        b=H37oPexOvEFoEw8qFERT9dsom/peKVNGEkGSdEIgFUYBZ0dA8bE0B+bTEa7zrU70Ok
         N8udaaEcnHXz7Ize0nspriP5Zv62P7eRzWCXpr758vS19CEYpVtzWLz+JzfJXc3Jj5ge
         HMe+/HCg8A96mKAJ1hNsjrBeXGFErhwLlMPYyDWDWi3EiDuavLuySnqnMPclX98Tvccl
         98HyPKztkd5bKD89b+r4793lR9ahyQrxSyo5zQK7mlwBUvh3AllCFBY0o2U017ejRnSM
         4qVouAFfce5LcJfnMLnMTh+aj9Xnr08NhdQqgdw4/OlXkq2a7E0yf2TWUtQPR2Fnf52j
         5LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790172398; x=1790777198;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vL+K9FciO0t0sxXo6V8h49AzokhOlta0lk/EZzHWy48=;
        b=SmMNBuQDofnxT3RIAChN3uEq+LoyTHG/3YjDlQHd+cQCWfm5fbvs8sXM+NQsmeY02u
         Ih4I8anZeoNUs0tl1/ZVcJO87nupYbx9xi3c95ymLDMAt67YGNUDjn+9DYnQBoqTa7jZ
         nJM4s3ULJpp6fwqiwXkZns1ZK4SIwJIq6h/C2+hS6DIL49I1fpIYx66+SewLsbBqDD1v
         OG6HvJIHq6h4we3jnTK6MTRubr3VbecrNjbJb/oz1xZmmiGil94thAiH/pOIB3T+A1K5
         TcFp/gjrJHQG5ry9esWQIBrUuVCenHMpT+y/I9Z8UAocgek+hf5FLeMDo2w4lm6skbSx
         9ysg==
X-Forwarded-Encrypted: i=1; AKwUvBx53bf3V+o2eVkGgRwvy1NVPZIwSuSg2WDmIE5q62Pw99ZwwCCZa4dlfWjbp7R4jn0cAXcnMFEnU9oLtA==@vger.kernel.org
X-Gm-Message-State: AFuF++nscnMSEQm0DwvdoWvR5gjBmfXr1f9sRuSXuMkq3tih0ZhBdobc
	6eeclRO9IHnK+kjLD3gI5JUG0gHaT3jTACp4oH5xKBgJY9MJfsa+WIK/6N/zulDLL48=
X-Gm-Gg: AYBFou20IjTIykX2dV+JrnoKG+JXpK21aTENTwi0ZAIw5vNFLwjCGrVF276TqTj3jSP
	swMfABk2yBaFoVz17wbWomv+EWesygoIFZvqHvgOu6pVfTHjstcgGXMDC4ZnBFPlscg0akOkryg
	BqYGjPrYafPeofmcfQJaIswxqILm84B916c5JTYAmyrEf66ZQ8ly0gUciN5zN2Se7TRM0frM93A
	YCPZbOnIxpg/zgrAtmWbkeq9PPfPm8igAVED4qiEJHBWZfkxQKTL8zfKt1dgZmFnBoxCSaz2Af3
	RdOTAPBJtbnB0eDX8MIOmJwjIfbbapaJkO3Ih6mbp3O2Z/sCtoqk25EFsjFHJFKgh93lv4OplHv
	qGelTMPAIkGkXVvcmtGqpN2kmtcHDKc0jEiNHxuzuHknBt5p+rxPNnFrDZ3nNSSwoepmLy2Y57k
	/sI8Eyy2iulIfMtbGPG3tmOELbxMJD+7qv9i0ni9vbWcGM3gZZK49NagRHu7BoGIfd53HYJXIfn
	z/u2XdDtKiI5T4DMR+40SlGyU1bT5k=
X-Received: by 2002:a05:600c:198e:b0:49e:642a:4f6f with SMTP id 5b1f17b1804b1-49fdf151742mr33674895e9.33.1790172397954;
        Wed, 23 Sep 2026 07:06:37 -0700 (PDT)
Received: from localhost.localdomain ([2001:4bc9:b01f:2334:39d8:9506:1776:f780])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde18a8a0sm78087455e9.5.2026.09.23.07.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:06:37 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars@linbit.com>,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH 1/7] drbd: rename drbd_worker.c to drbd_sender.c
Date: Wed, 23 Sep 2026 16:06:02 +0200
Message-ID: <20260923140608.1116713-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
References: <20260923140608.1116713-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "worker" thread has long since become the thread that sends data
and resync requests to the peer; the receiving side lives in
drbd_receiver.c. The out-of-tree DRBD 9 code base has called this file
drbd_sender.c for years.

Rename the file up front, with no content change, so that the upcoming
DRBD 9 rework of this thread shows up as a modification of one file
instead of the removal of one file and the addition of another.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile                         | 2 +-
 drivers/block/drbd/{drbd_worker.c => drbd_sender.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/block/drbd/{drbd_worker.c => drbd_sender.c} (100%)

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 5faaa8a8e7f0..1a6dc0f482f5 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 drbd-y := drbd_buildtag.o drbd_bitmap.o drbd_proc.o
-drbd-y += drbd_worker.o drbd_receiver.o drbd_req.o drbd_actlog.o
+drbd-y += drbd_sender.o drbd_receiver.o drbd_req.o drbd_actlog.o
 drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nl_gen.o
diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_sender.c
similarity index 100%
rename from drivers/block/drbd/drbd_worker.c
rename to drivers/block/drbd/drbd_sender.c
-- 
2.55.0

