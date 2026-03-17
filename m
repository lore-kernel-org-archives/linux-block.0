Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2403EFD1A
	for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 23:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789804; cv=none; b=Tig1X9xzwYbYO/839150qyGZ7P95xpriGMcDNXnmi0yRBMu9VtlXgeEZCYvt9WruxYSZNvBvAYPnoCrLZyIkrKJdS4NKSpTXs6iQBE5G7fJ3YIo59LhAwat/ulKwzNHOmDfAE5bpFTzjIAEHMz+//PSyhDoQWc1x6Q1zRo5KSmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789804; c=relaxed/simple;
	bh=PB4QUoC40I8Vz2PFxEtUkYeG9DwMnvMUVdft52S+vrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Coau3LCNrn+3LHPSn49IHienFSe24kyDPr5363FUDM5yI2ifHjHm+vPCcAyfOYYON/BkBzzKZLv6P11cdSh6mUNz9AvRn5g8L2qtVtQ0nMvo7irNjurVG1+P/UEnSE5OREK/OOVyO8TSg2ypMZvVyulp1VXPLcr7cR1i14h4jhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdVObZgG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdVObZgG"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79a7109f568so4980597b3.1
        for <linux-block@vger.kernel.org>; Tue, 17 Mar 2026 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773789802; x=1774394602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnaNOvfPGt1J4YqTrzM2VRxejeZjN9i1yPf1CzG0bKk=;
        b=hdVObZgGdZnJuDGO1FFdwEi1NPJDg8HG88C3x9VqAVq5Jc0QgRdLdqp7oRCutwfuwL
         6gad7xUsnFJfH5rR3IGDVm54Fu0z1AN/UXBoN0i3Xvicr6EzXIw8cppGV/eicRso0w98
         8OyHOe7IYhSc2f8PvKjhcRS0Yiy/i4zewMyrfDkCW63si3f8gkoZv8iUiddy6ORomckM
         nUAVw7Tx5O/em9AO+LtoyPyqCLkRxyCAgOxlgDC1rF2m4SZpBE2/No2QeAJWjiBvUJMo
         Z1xZFfLlcMiC3Ymn2CTI7ZzBp3DX84UycFm29DQR88X1oCKpVM/qLCamXWR4TRLKk9kQ
         rwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773789802; x=1774394602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FnaNOvfPGt1J4YqTrzM2VRxejeZjN9i1yPf1CzG0bKk=;
        b=n/UmEzHFaUxL0PiR0mrHoGlcB2SJoyzSebx7IXG3oTPmKYkIM6fOg1JjoZPMSJUANa
         ZCYd/Hi9Rp0sL+U2X6OfwJNd/lFLuDsYrKdu4wrDc/wArgLA2+efdRW6eVE/xMcL4pxm
         aEevbJdEvern/kPqft3/oagFd6UK9YuDonOo7sIfP5H8URfPwB9KrOKFwl+hlkV+XN8L
         b3AG0pGmqGxvbSc3/ba5dHaImp/wWXTehhDYnonKp83lKNPQ2uZpJogq4sb0nqEgDdf6
         3Gesffv1tWxBG0RShgQFrXuWZgLCgcFEYZpYsRgMitpchRZhtYwoljUcSGXQqi37nZKy
         m71g==
X-Forwarded-Encrypted: i=1; AJvYcCVc0bhaRoOAf2Yz7u7UURmMFr9q/NYPQxYvG/K8fo4iZFR59omMFNzJ0zyBogQ1ZIpyvPkJ4FR/bS7rkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhfQ6xC5FpMelsUHkm/LsHIQ4zOsyGhA0AzoxsGXR4S1I5Jqz
	Tv+WHAO2qihpdLJ6FZvfEwXjZxcenED1Y/5a32qDyW2plkHAlrKw+6CK
X-Gm-Gg: ATEYQzwNsdoAvx3PnYcLg1ZwKIDEAiAhcnblF4UJ4TXhxwQj1YYMXZbbQpN2MrqXj5n
	xt2HpEVps8zPqHCYrcUYjt/XEI9ydMV7hMuYcefBZ/KClpcJfJ0ZcjdKH5uZh07tByKS7RjIJnt
	oCegwn9m5GrSwA+p+N6QcPA+u66YRpqyHBXRrJ1Xwb6ZVFnDNDhTSzVM8i4fLsGPW9P5u7/F08H
	KyJQNiD5heaW8v24Q5PqQCDcuMZmWMEo63jOP1SC0UNw58CKZ/QTCYu1Z7a1in9wYxQ2zn7Ug4f
	+iqUxVlcqLMBH09Bq471iTSz4cmsGMZLt5XRl/7mtFerSZcjj1rsDrJmWlaPmxSKHWH8kCiR78r
	dY2rrqW96ys/D23D0oyG0rzeA+RYnKGXhqItycjxNN1/PtBV3aOnXXZU4SpihZ3CLOCI/QvIJoo
	lH2OarazOX3XMSi+cYlU9f153Oiz0UKiR8r2mLOjc8wP3uthaqB29ozLz58clbTSpCYIM+26SK1
	bD/XNWzba2JH7TvjJAxiNnU
X-Received: by 2002:a05:690c:c119:b0:797:f005:2dc0 with SMTP id 00721157ae682-79a71c88395mr12043627b3.50.1773789802632;
        Tue, 17 Mar 2026 16:23:22 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360::f769])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a715d221dsm6858217b3.37.2026.03.17.16.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 16:23:22 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 3/4] drbd: Add missing error code in drbd_main.c
Date: Tue, 17 Mar 2026 18:23:17 -0500
Message-ID: <20260317232318.18923-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317232318.18923-1-ethantidmore06@gmail.com>
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No error code is assigned in alloc_workqueue() error path.

Assign error code -ENOMEM.

Detected by Smatch:
drivers/block/drbd/drbd_main.c:4575 drbd_init() warn:
missing error code 'err'

Fixes: b2e550c8d1f54 ("drbd: rework module core for DRBD 9 transport and multi-peer")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index e2c3530cfa13..689b7cac5ec2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -4569,6 +4569,7 @@ static int __init drbd_init(void)
 		goto fail;
 	}
 
+	err = -ENOMEM;
 	ping_ack_sender = alloc_workqueue("drbd_pas",
 			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
 	if (!ping_ack_sender)
-- 
2.53.0

