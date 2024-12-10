Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1A522616F;
	Tue, 10 Dec 2024 06:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811834; cv=none; b=pJrRqWzVCA6ueWKlgzima+eFoO2OSDdm0Wk5eqppTwhv29HwLbJXCkUCwsANLSTuW79fCJDd/+MNPADbgWBVGkeXahVUzp60IvJpVXWEXrYVHwHqdC/Uu9mhxX9BzzZEFOaNerT21l35JRsn6zLxs5qEnNNJDlUq9sVVSZh5/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811834; c=relaxed/simple;
	bh=xRvvrjUxKz2nWrCJgsnH8yraPNb1mNCoN0ABG8nfzaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azRtrYxKlZnEwrNndNppcB3aOGOIAKMiaI9sbvWGqRR4KfVcGPVOLyw8codWR/9t7wyflbE/L7oWsLCoaEGLPpkCg7F8//wynSpnPoJxYmycKqJZRpJ5z4bP2XMajzvgCQCGlAmDdLEwsn5dNcxm1uHq12xo9VqIIuuWkMi0jP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yur6H+di; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yur6H+di"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7258cf2975fso4480002b3a.0;
        Mon, 09 Dec 2024 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733811832; x=1734416632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HUZ78Vqtej2xrHt5B10G9F3oL/3KWnxzxs/tzOCC2fY=;
        b=Yur6H+dicgVPspq+ty150Q8EKVtNVwPJ5sJUhKTYeTj0qSms8qQNuIV2AEGAXJu7JI
         h5pjtB8o+mI21T3Fdr/vpWEZuUIYw4cf63y8iLGq1LkMu3SVtuX320WquNt1oqU3WYHp
         c0DJclZ1S29OZurHvhbatWG2IW37M8plfD0jUd4xBTzDIWFdpJqFVUtGEEYq+arAzT7P
         Ai7ltls6rKpC8U/Mv3UGi8clUmKrkG383hFZTnY8eDMMIaT18afkQAeqA9KPcG0Wtf/a
         BRv0rcqHCnXAG4J+fOnZSs/tywhPMQckDVou9awL06Ows8OHc72+aBH9kFhuB7D/ICqS
         asng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733811832; x=1734416632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HUZ78Vqtej2xrHt5B10G9F3oL/3KWnxzxs/tzOCC2fY=;
        b=Ol8O/sS5Ch2G5i8trJ4K02Y87tVtxnED5DHZYaA5KZKxyJktcTGBCIESxmMTbaK7/2
         rNCW60o1CuVesFbVrZTRq/wKZkc+gKTI1fOn2aw7fWXSFL9r8CcuRuw+G6viwzISgegR
         UCSIV7U/9WNEl6Um7ESLxDmvrVcx0WIvS7PiinXG0Eczr4OjZGMe6UEUqAimAeFg3b45
         TOsfSTfHh7sIp7Pkqsq2uoJPbTN87i2V7pT7SXY/rEdF/BZwQ8dS0NdriAqM+GL85llg
         HhmUutuSTAcJV97vwYQxJs9ujWmeZfzx6r1yg/nvlHTY7v9ZbKxrXqSguWfI44d6xGC2
         5evg==
X-Forwarded-Encrypted: i=1; AJvYcCUN6iSb9zbzptWdSfVDkmqkmSbVjVUL0ptm67mPV7fZeQVcr6zcuI+w0j37rtNpWEqtMckiQ8aSkey+Zw==@vger.kernel.org, AJvYcCUalCcbkf6KrQhMPqFGdsH8OKbEvg9V7ng0+gHM79o5cscUXgwo/K05bncVfvPDglLgrZzQxiK9ju1JYCdw@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7mt7BAFWD643vm6nGHozoxfegvnJC8hdsHka5CYxKjyHrIIr
	BIoczs51R04XUZ6fmctwm/YYP6LKxnw5WCh+F59O2zk06iEJZTO7
X-Gm-Gg: ASbGncvVZWtJONUA9sZFNqcmvUNpvOmd1EbB75axyoZK+N1v/jjmijkC2QQIw0++MvQ
	WZlzarI2UKga4N7KFRz6U0e7A2xLcUMsbffFNXAyOZEy5AcMC2YGUe0Wq96waCYHbCzUpoasF1H
	BqGKl/r+1rj1gCy0dSOG25YPzigxJA+8jYrKLu67ejNTZSV9D0t0/VCYU4SwvtNaHGpPDnZxw2z
	4XkoGHCtCkjoQieM1BMcJ0a3pOxcHqHWVnPzLbNKtiUeuzIHhZNJdTdRV/JthT31662zA==
X-Google-Smtp-Source: AGHT+IHEc7BDd6s3tGoqndv77nK0dHDhIwoGwxQVsS2Ewy+e6AiBdGdS/mFsjZryLq058Erg2PvpIg==
X-Received: by 2002:a05:6a20:1589:b0:1e1:6ef2:fbe3 with SMTP id adf61e73a8af0-1e1b1a79c58mr5398021637.5.1733811832231;
        Mon, 09 Dec 2024 22:23:52 -0800 (PST)
Received: from kernel-VirtualBox.. ([2401:4900:8899:46e4:646:c8ea:ef7d:d291])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4757691dsm3480120a12.18.2024.12.09.22.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 22:23:51 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
To: 
Cc: evepolonium@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] THE INITIAL VALUE OF wp_offset MAY BE NOT THE POWER OF 2
Date: Tue, 10 Dec 2024 11:53:37 +0530
Message-ID: <20241210062340.2386-1-evepolonium@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
---
 block/blk-zoned.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 263e28b72053..60f8bddf9295 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1,3 +1,4 @@
+
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Zoned block device handling
@@ -530,7 +531,7 @@ static struct blk_zone_wplug *disk_get_and_lock_zone_wplug(struct gendisk *disk,
 	spin_lock_init(&zwplug->lock);
 	zwplug->flags = 0;
 	zwplug->zone_no = zno;
-	zwplug->wp_offset = sector & (disk->queue->limits.chunk_sectors - 1);
+	zwplug->wp_offset = bdev_offset_from_zone_start(disk->part0, sector);
 	bio_list_init(&zwplug->bio_list);
 	INIT_WORK(&zwplug->bio_work, blk_zone_wplug_bio_work);
 	zwplug->disk = disk;
-- 
2.43.0

