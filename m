Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66027308F2C
	for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 09:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456901; cv=none; b=fY2g1mOryL3oQ9K6H37nyuVEA+SOujG2pHWruFfNV4j/lce1DVBIl7dLrAX4KxlfTd0ULgGNW/saMFxrUbF9sQN0SbSMjFI7X8ns5RjsKZc6aeZUO2hm+nJ8Qb1VCWxlIEL1cIi1qLBBVF+MAG4cuOPHFyveoCmbF8ijbWx1eWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456901; c=relaxed/simple;
	bh=vkQlFPq8ocqHKInH2zJe6fSLDmytFJtiXmmnPZIRwpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qRpAvLrWtSjO81BH4Wrw1Ed0vVNdL5heJObDCDyZPhRlSB9KtiH12SUVJkPM4wMKTUnos78uxhE93BTFJlN338ROt8Bpx0BuQWDMMlDSl1wa4BZ7AxLY1mxFIMvxq/YT7bqsAW5FLP2+Id52uFS4xoc0kaZFepSVJ3kor76YyAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGdjJAjs; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGdjJAjs"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2957850c63bso54346445ad.0
        for <linux-block@vger.kernel.org>; Tue, 18 Nov 2025 01:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763456900; x=1764061700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtXQT/OdWgiT+1HPVergpURbuzBj46MXXs88yjk/ACU=;
        b=AGdjJAjswwYOdBcf0XAIY+5AQYQrOiwHfJvS4bM2ePrzNw6SV+Iim3NaCOUvBT5tG3
         AGvHD/udhc3JVVstPQ3I6bjqM6CbIaKVNeEUDggVK05vtcCAr/lAnSvAImr1qSq960Xh
         omSaqMwNKdeqWWMUdUlEEQzIB23nrEHNUhdwWo2dTKhjZr/b5v66oOfZj8LUBKDeGJs5
         NsVE7kxYusoWXt3vC2MReT1dKW5Z25NB4ig4A5nno/FuK0Y/AryqtDG3umJkA7Mj01se
         k7v8m94Aeqf3rf6DrYgrTPlAn4+SxvnVX8BJYaD0H4Q+tNdXaQ6Sx6rxlrmPQUCU1km2
         7hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763456900; x=1764061700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtXQT/OdWgiT+1HPVergpURbuzBj46MXXs88yjk/ACU=;
        b=bOOS+B61nv/qGdZe0qqaObT38x9PFKQJZRk26UMFDVHorrAW6J5TnEizkd2eUxtlnI
         WZwt9rOJc126+8grViKc6iRQBohmNfDVALyQbXURCBNpNa/ZPPZbECYfuvJycpQyfVAV
         mGIAozilWVNjgnbTmzMms3e7b2jBfsv8mnXqLTl5CzxD4iE48ns0U8cOFda36QDSEAN8
         YEaau9m2tPXdW60PQ2qcUn7jZGiuxm42GhdHFkmT6dk6N5Ol8yWn7+Dx1ZCajIAqkM7i
         bMVtAlKQvYYwyEf7t5FuOdvnZVjZVdsYUdTDnt7MSwCHYqs2feODC9lE1DvrDFh0f/du
         raiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUd68PfbnSrfzv8p7rIRKD5yhtmD8Z2buEBbA+pXEyrfCDbmd4nYF9plBHMaEctx+ISMYwJXqqvdL6xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfZ9uwrA3X8S7ueGKp8YX5K9Eeiz2TTlRlq97B2GVNNntjIGJ9
	EerRwJsY62saXTSQ0KjNOznNjcMVeeMS0HW1Sr8q1RYZm+SXLXLRoOsT
X-Gm-Gg: ASbGnctHSR2x52E2mNPwgIvFyxaVtsue5NhwGz4fxO6/acl+Depz5V7ljejvvbrBYxI
	4+g2nnMnYElkX2RgZuCcvC5gKHmKEg9zz3nGBqg8/UWsY6gjlXRJQyNO5LrzwqgwXxg5651gta0
	Vb+c1s1wuwGrV37HwK+dNOXiAOTdyZu6NAYteZtIGH0j/dOAPaf5tUz4NWwj1wkhpmXoxGPtHcg
	k4unSn30Re7pECUdyb1KX5lrwwezkbOoTQAiPGHT2pSyiNj/LdqIxL8SeLifGQBAYRIl/EyPxa2
	oW9aawChzrUNheSb4LxM+2IGzemVhHhTM8Z68VgXGJGkNc+9Ejc6az35PD0/k5rcyIhed5mKcrc
	fqpZvgDcwRSCWPRQKp3sallYuxIRwXOqmDN7N9MtVjnDtJ5NrunqjhnRFcVWPeJSE7N2r/JCce1
	qx4nVoeEQcwruwjR4QtA==
X-Google-Smtp-Source: AGHT+IFONSoGa0+pxHK7JiJvE0ZXp2Dp4GaKslWjRMI6qlRuZ4eG/9s+0oW21KZbEJFdUWjrjcUxMQ==
X-Received: by 2002:a17:903:fab:b0:297:e6ca:c053 with SMTP id d9443c01a7336-299f55b8dffmr32294565ad.28.1763456899674;
        Tue, 18 Nov 2025 01:08:19 -0800 (PST)
Received: from hsukr3.. ([2405:201:d019:4042:80a6:7dd7:b597:d951])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0c9dsm166669745ad.67.2025.11.18.01.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 01:08:18 -0800 (PST)
From: Sukrut Heroorkar <hsukrut3@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>,
	drbd-dev@lists.linbit.com (open list:DRBD DRIVER),
	linux-block@vger.kernel.org (open list:BLOCK LAYER),
	linux-kernel@vger.kernel.org (open list)
Cc: shuah@kernel.org,
	david.hunter.linux@gmail.com,
	Sukrut Heroorkar <hsukrut3@gmail.com>
Subject: [PATCH] drbd: turn bitmap I/O comments into regular block comments
Date: Tue, 18 Nov 2025 14:37:53 +0530
Message-ID: <20251118090753.390818-1-hsukrut3@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 build warns because the bitmap I/O comments use '/**', which
marks them as kernel-doc comments even though these functions do not
document an external API.

Convert these comments to regular block comments so kernel-doc no
longer parses them.

Signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
---
See: https://lore.kernel.org/all/20251117172557.355797-1-hsukrut3@gmail.com/t/

 drivers/block/drbd/drbd_bitmap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 85ca000a0564..d90fa3e7f4cf 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -1210,7 +1210,7 @@ static int bm_rw(struct drbd_device *device, const unsigned int flags, unsigned
 	return err;
 }
 
-/**
+/*
  * drbd_bm_read() - Read the whole bitmap from its on disk location.
  * @device:	DRBD device.
  */
@@ -1221,7 +1221,7 @@ int drbd_bm_read(struct drbd_device *device,
 	return bm_rw(device, BM_AIO_READ, 0);
 }
 
-/**
+/*
  * drbd_bm_write() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
  *
@@ -1233,7 +1233,7 @@ int drbd_bm_write(struct drbd_device *device,
 	return bm_rw(device, 0, 0);
 }
 
-/**
+/*
  * drbd_bm_write_all() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
  *
@@ -1255,7 +1255,7 @@ int drbd_bm_write_lazy(struct drbd_device *device, unsigned upper_idx) __must_ho
 	return bm_rw(device, BM_AIO_COPY_PAGES, upper_idx);
 }
 
-/**
+/*
  * drbd_bm_write_copy_pages() - Write the whole bitmap to its on disk location.
  * @device:	DRBD device.
  *
@@ -1272,7 +1272,7 @@ int drbd_bm_write_copy_pages(struct drbd_device *device,
 	return bm_rw(device, BM_AIO_COPY_PAGES, 0);
 }
 
-/**
+/*
  * drbd_bm_write_hinted() - Write bitmap pages with "hint" marks, if they have changed.
  * @device:	DRBD device.
  */
-- 
2.43.0

