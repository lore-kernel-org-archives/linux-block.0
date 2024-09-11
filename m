Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4423502B1;
	Wed, 11 Sep 2024 09:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726046197; cv=none; b=KAb1Hlhd7aLmmpDIgZrphZlEAjcwxvXDzqGELkHcVpsd6jR4Uw19LrLFDmyXiJGadTWqlhalw/a2NF/3LYblaa4+7uWQyyHQRh9F4cicuN7Wr5+7TKad5q4Zi8VnVzvCbnTRKSyAHFe3lP7tSegFhFhSmOml2a1k0ByHV40Glk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726046197; c=relaxed/simple;
	bh=ggRdZpKolLVLfeZ9LqWO2n2H2xuH2z3GmtMjXhaw+hE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JvxqTtUcYAYLjashO3M19Qh3o2ydAEISP9cpdJQX5ldIZnFy1PJZ6nYhx0xEyAIWvZxhoeZrT0BA2ip9HECseDSKsCaloYHkvfMXMCfC1s0SiIljws2pg00fcjEdMCz+5Kl0HGB9xhOJOnD18QklbY61fOqyBRkuXXuxRAGqv0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO/Gg0Oq; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO/Gg0Oq"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2068a7c9286so60959035ad.1;
        Wed, 11 Sep 2024 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726046195; x=1726650995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WcDJb5QYEy4QSNbCqr1Ub2x3UYsUcQg9U2wYJLfZOgA=;
        b=SO/Gg0OqJ8Ss1+9XhD2ve9HVm4dJ8pWBV1f4dI1ingK+4LnB3ZEKZ3S4+1Xab9XNMO
         1LL0NOtJcYUUzKdX6yLCpMIt/LpfkAl6/xAZZEyZql7L5Audy+Az+iYn9NILAIPHBtDS
         WvitmHZoEQuGUXjiHmnxSfm93693P+ktdxu1mKmF8oEvobOwH1wZ62QY5HS43Up7mEKS
         M/j4FWvunGbtzMs17lduCreH4AVSB/NTtsxddf5txS/GI8vbNSV9sPej5XfJ4E+CbC0B
         GmREnIAFtLqFUmAYxxiUBNVjeaiG6dfWTkQ8f5yjPZvHGNKFsnHO7SLPi1MM6ZkPlfYp
         Ak/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726046195; x=1726650995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcDJb5QYEy4QSNbCqr1Ub2x3UYsUcQg9U2wYJLfZOgA=;
        b=MSVPdbj0bLsify1cCiMSRx06+NvIsw34SEznmUl7950jJusR12Fr47aUSUY4lRE4Sv
         IJMDu6hNGvi216qebHgnDflxM8inSFs2VpO3Ip29kQ+yneXisR9X3ZgB4g9ZUfd7tsnC
         2Bwf6GRZHHjBECvtoxugnzbY8zvgiGOxhMpbrC+SCAnvW3qyYOsJtWnnU0LjfC1dE2k/
         NhkGCmUrRhuScUsUHuD5vhg9dufpxzaNeG0myO+r0U2iqBW+P9+bgqUVu8yO6Q3iJ8gu
         ZKM1qaRhH3Lc+pflK9cyAfEmFgIhzpCp+uOwdAuMG+JyKBWtA9YLC42uyAlOu0wfajb2
         Xytw==
X-Forwarded-Encrypted: i=1; AJvYcCV97J2yR+w4CN7r0tQtCHXn3rYXL4o3lJBKbIkvGO4HL0TMGl36mbpuY6HpXrEAPygUITRN4lx0eiqqldW7@vger.kernel.org, AJvYcCVTO+u/sxHW7sMd+Mfd6FWE6Zwvd5mpmA++AcpZUFA+SwCeBb2irSfupyo8QGJansjURlOVi8IR4p341A==@vger.kernel.org, AJvYcCXK4uO5O08tp+YIYNn5J4VeihZwRGBGR4ANQfP8cBNQA+fI6QbrentBa1/LTw268jsjwHoK/ALo@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2+OkpXASn4wXfjEZKaqDRMwUltHjJVm+ZIUyHK61BNMSoZYJ
	vg526dZXfSJtBu+XPDjYqZ9f4xstHzQhjwEbVbXWKAX9JuMMFgsg
X-Google-Smtp-Source: AGHT+IEhYB+6J+0UCltGlnaoCjtSirBu3Qn2up1kXKerpnf9BCxeM5frLfc6fpa0E+C/vwJef/J/OA==
X-Received: by 2002:a17:902:c946:b0:205:7f87:ba3e with SMTP id d9443c01a7336-2074c5e4cf2mr55804235ad.13.1726046194685;
        Wed, 11 Sep 2024 02:16:34 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e32e2fsm59844995ad.101.2024.09.11.02.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 02:16:34 -0700 (PDT)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: philipp.reisner@linbit.com,
	lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com,
	axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] brbd: Fix atomicity violation in drbd_uuid_set_bm()
Date: Wed, 11 Sep 2024 17:16:19 +0800
Message-Id: <20240911091619.4430-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The violation of atomicity occurs when the brbd_uuid_set_bm function is
executed simultaneously with modifying the value of
device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
zero. In this case, the check in brbd_uuid_set_bm might refer to the old
value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
an invalid value to pass the validity check, resulting in inconsistency.

To address this issue, it is recommended to include the data validity check
within the locked section of the function. This modification ensures that
the value of device->ldev->md.uuid[UI_BITMAP] does not change during the
validation process, thereby maintaining its integrity.

This possible bug is found by an experimental static analysis tool
developed by our team. This tool analyzes the locking APIs to extract
function pairs that can be concurrently executed, and then analyzes the
instructions in the paired functions to identify possible concurrency bugs
including data races and atomicity violations.

Fixes: 9f2247bb9b75 ("drbd: Protect accesses to the uuid set with a spinlock")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
---
 drivers/block/drbd/drbd_main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index a9e49b212341..abafc4edf9ed 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3399,10 +3399,12 @@ void drbd_uuid_new_current(struct drbd_device *device) __must_hold(local)
 void drbd_uuid_set_bm(struct drbd_device *device, u64 val) __must_hold(local)
 {
 	unsigned long flags;
-	if (device->ldev->md.uuid[UI_BITMAP] == 0 && val == 0)
+	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
+	if (device->ldev->md.uuid[UI_BITMAP] == 0 && val == 0) {
+		spin_unlock_irqrestore(&device->ldev->md.uuid_lock, flags);
 		return;
+	}
 
-	spin_lock_irqsave(&device->ldev->md.uuid_lock, flags);
 	if (val == 0) {
 		drbd_uuid_move_history(device);
 		device->ldev->md.uuid[UI_HISTORY_START] = device->ldev->md.uuid[UI_BITMAP];
-- 
2.34.1

