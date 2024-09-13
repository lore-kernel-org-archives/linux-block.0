Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD8F15381F;
	Fri, 13 Sep 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216515; cv=none; b=UQ8IzHfXvBY59/Wzz+Vj3iRdLT0P5HObgrQEd5/Iem41mstDQpu0+/oxsPrlaLpZrmLBQJrWwHUFkM0zNXuk4vTMrpIACGDJ265xsimNlKl66DW5KLAUR0mYTwZCyjbfQdYmxijNMwMvrHfK63aITjNiFZdrmOPDXRiePqh6Ey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216515; c=relaxed/simple;
	bh=ndTMI7Ta5mkzEp+G+rl2QJDEsX+BahwLi0B2IW6AhGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nzs5s6lFCc7NuVrD8CbOU2/rFbmmrtvYbORlmMZbCfVlfclWo38Us3FQKtOo3S1z2YzuJJ1ryKxnPvIFBaJqxvlHg4JvbMaLvjIblG9+qDxoz/1dsT8sqOs4vs0Q1Bj41FmtT70sj/WRZJev9N1A4xwqOXRA4e8S6qeSM/mOnQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk6T0X1r; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk6T0X1r"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-7d4fbe62bf5so387316a12.0;
        Fri, 13 Sep 2024 01:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726216513; x=1726821313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kC1E6rGRaMKkAAHcPV87FQ7r8LHjz2Mgn/xn2HhiS4I=;
        b=Mk6T0X1reQai0sHUmCP1/CQVNMAHsPXNoPSiXZCYDZ/rs5wc7KzJ1kjpneX0Tbal5X
         YsD3YE7oszcDpZIklVQsWPYS1KN+UaKulOMBpu0oRRokI2j8L1SpGLECricP6oACUHWo
         Yk1QK8/Uv0C8+axlA9jytAV1qrG6umw6phrhcEWYqykkUOdhYlXxpTifCl9imIEvUZse
         Xv18pHQOn94ABX1oQ5I457n8AP2Gw2XEVsdNA8aKxfbPolCsnkG7nZQAeednWB+bOLFH
         yAjyIXlJpdGhBU384f1AQtqmWrbjvEwIHdolq316rpkj4jLSe67k38bfVEf8JFQZjxa+
         u1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726216513; x=1726821313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kC1E6rGRaMKkAAHcPV87FQ7r8LHjz2Mgn/xn2HhiS4I=;
        b=iZuE7/q2dYo6d3cjo3Fng5GmK3BFR7Qr+NDAWm4vioQ5yct+B0/QFE9pnSnDS5J+5u
         jP/vt6Qaw9KV18QNoR1vHUBO4/2ICz1UfHkKGzd3QT9W21c68fVnvSC1pJtyMe0ODnSk
         Ow2vyJ+eV38uJq0NFiwt4qNqkSnaAGGjNTq6ks5VMuVGMBbPjd42/om5rCxtMvwbAJYU
         43xP6hDIOdfi+Q6d4MvQQP/cjPUM2vjex1vjTyiGDEzhYgdZVV06Lddt3HvbU4BNq+oz
         ZsCxkn6EbBc2C2IE6M+QXcvLFj6/jtqVOKHgKyqxfxv9DwLvBp1CbeBz+RCAXDicfeUD
         dKzw==
X-Forwarded-Encrypted: i=1; AJvYcCVCxP60pOxTt/hZovghpvgoN2vSTsu9Vr2uwIVTXoHOyvbVudbZEkgfDpLhI76LYgW5hdLy3A+oMluOYQ==@vger.kernel.org, AJvYcCVOrJh29PzK1Ci3YAvrthx2W1mTmTG8pTNrdhzEEkqM+PDrusWE827cKnHrU7VMkJHDhYSQw1Bo@vger.kernel.org, AJvYcCWfOw7glNO77xsTItTCVVT3dgpYCWvt392m2ht2Cqy+6q36aLEj0oggeC6RbK5AT4cR7Cx5zQ+b99OXXBO2@vger.kernel.org
X-Gm-Message-State: AOJu0YxI7fdesHS0izKyk9ECFQjN4Q4/eF3tXeu1oCOJOXq42bF270wK
	05czGp1+o9xUpXCizIPFkFajE5mJ+w5F2gSSIFof1tNWrV8H6Tz3
X-Google-Smtp-Source: AGHT+IGhOiHOH2ZzR9kqH7H6Mz2LbLdj+bggZwXEzS9FbvIrM15f4iZFYOTdBo7HUQ+io4t6nMbhvw==
X-Received: by 2002:a17:90a:d149:b0:2c6:ee50:5af4 with SMTP id 98e67ed59e1d1-2dbb9dc1163mr2394189a91.6.1726216513004;
        Fri, 13 Sep 2024 01:35:13 -0700 (PDT)
Received: from tom-QiTianM540-A739.. ([106.39.42.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9d37e01sm1123613a91.52.2024.09.13.01.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:35:12 -0700 (PDT)
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
Subject: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
Date: Fri, 13 Sep 2024 16:35:04 +0800
Message-Id: <20240913083504.10549-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The violation of atomicity occurs when the drbd_uuid_set_bm function is
executed simultaneously with modifying the value of
device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
zero. In this case, the check in drbd_uuid_set_bm might refer to the old
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

