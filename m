Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34FB385D92
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 07:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076492; cv=none; b=GPcjphI5SHL/OZMBzpKT6Bee0fq5TkVI/LX3AJtkqRVsuHCJdbCL2yFuskRjyI/RbS7HKYyB3ho5thUgwIZLRsny0vlVg7SvtyUx5AZgYkfIMVJs2HMZyPcInlUqG8qfy61AY84IVQw8F8G/iLm3C/CxysMyrJ8QZsfK1LJ8Q2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076492; c=relaxed/simple;
	bh=tnhYIZbexmwH4l4TRimSaSmIA4vWf+v04RpPLFtes/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FP5t+YjrXjWHJ0Dn0xXZpeHxekUWtR0zr4Fxwhjv7mGlk1uTRbDXjB9bTJwG8JHjiyTFoA0VdLi0/+dg17Xsd4DYOvN6xzJNE1ADcp6rnVpwvQDz2qFymI61juqz3q/etNDGZWnXNyDwlQnyB1/rCW5n1J0CdFWoDPiiRTXEVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=c1xRuTi7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="c1xRuTi7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4602e2a0372so4630973f8f.3
        for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 00:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781076488; x=1781681288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXd9KxkewHf3chFLOC35bnc60+vMTwcuOgv1/AoH/Uo=;
        b=c1xRuTi7/nW7L4xNfP2MHMgbUR7M541ECwamTZWWPU816R4KYt/iV1hsZ34HxETUxk
         ildjVTorfpn74Iiw1yiNYmay5qdcBvCXEjtNaOUyNfZUg56kXIA2tct9z07Og6ybDbk0
         gd2QuNFOhr8pm47Trswct1ac8UVNIds73EVFJfPbjjGc/OuFVSWjylj8aL/Mg+LTP9+X
         qnO2lLE1hZELL5pn5Vf1SOIh6aoNcWulsTGu4IOrONkxQUErlNg32ORv4S6jENQPhano
         D58PCUT/NTc+Ns9xXe0cGtbDZg8K5vhW9USLEC0tPQk0PMKI5NptX/CPzHKl8aa0TlX8
         pXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781076488; x=1781681288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXd9KxkewHf3chFLOC35bnc60+vMTwcuOgv1/AoH/Uo=;
        b=QRJBwrQ3oflJ8zKBlHpV50ygA8TQkfuv3IwRQxpUKkAV4+w7dvR/rDx2ShhtcMqpRR
         hW6K0dNV1oFNZjKoEGlOUKm2/0R6oVFlWxbvuWgKI7+dxKQxPYx1Lzq3cVScLenQmrgL
         0ZhSHK+tR9hStxAWyTmWO4LAgCkaDxqhKJ+PvrJmcVMAXJq1ShreNyr5+HIvCiY5z93N
         KcqkmjD1YKlBQg3ZOXiUiBwRGYfHtbiklp6H6Oga8M2U6Y4zatqR09dYEVzw8/WGC9k2
         5iUgVwf0cI0qNH4/c0dpGg+TuSMUfEkOwU5PBem88cYHzPXaTvdL4hLSkOIjvEUgQU+Q
         S6Cg==
X-Gm-Message-State: AOJu0YzdaeiiU+NwvFNF7uA4PCLSLpJOGmqHwF4V/+Y4IIgI32KL7trZ
	LByGUgB86s4zI29L7UqEK/RDve8kd/UzYlSeOGtvlFY7gKy4GEYnb7aP+ZGDY7cvlzU=
X-Gm-Gg: Acq92OELg+aKvdiCnvCleD3HB/VVvDMJk0aWoZjFTZBXwzMFaNI/ulTg5sFxUBA5KjC
	8V4rNPeJa1zb4R5X5UJA3TDlYA20q6QJyMiZWOpUJYcbVmtqjopBuUp1lLiYGGhsCly2Btok22l
	sXY1CdVDCTyPVLdr1p3boolJOimdM5XMJIlGectEqIasxZr2nECkjh/xph+vR69zhXU7UHqL6vH
	kFYJgOAtuioC5ohnlQlx0aGCslfZiE5aD66xbFUhTXmk+1m7vpVuDb90TppXMrzfiPT6U7yD6NH
	1sgSQtVYBq3NGFQmYrAN+1/JkQExQxRpE7xrxxYiBjyS6p6YakIqbcEzZs5Bl9Cmmvu9jnqOC3V
	8Hm/hnTRycprdi1DlxYffdIz/o7gEzqAWoDAPvyJFTrErNYHC/cHrmBIZBHN4FCOMp8z0BKLWVs
	W1HJHh7w1SsO9BQLF4o6+l3rSLf0V9/IBPMXtN+Iw=
X-Received: by 2002:adf:e743:0:b0:45e:f1c5:709 with SMTP id ffacd0b85a97d-4603076cb46mr27254307f8f.37.1781076487885;
        Wed, 10 Jun 2026 00:28:07 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f351d69sm123651994f8f.29.2026.06.10.00.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 00:28:06 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Denis Efremov <efremov@linux.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] floppy: Drop unused pnp driver data
Date: Wed, 10 Jun 2026 09:27:55 +0200
Message-ID:  <99dbf851ffb99229ea1dcfd8f58e9ee6a1f05349.1781075967.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1675; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=tnhYIZbexmwH4l4TRimSaSmIA4vWf+v04RpPLFtes/c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqKRH7dMH/5rxc/b3AdszYqPTzbBZ46Gpn4WzAd aKeUbneBTSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaikR+wAKCRCPgPtYfRL+ Tr2qCACGLybsumZx0CFZ7UZAU07KHx37pMsgCiCZSf9fFz4+NH8fw6gx7dLosonKrz6HQH8UIbK I9tQKl3AXDExAEww//7O9Oe0S/yIiu8vIVpPFxCFD7Uj9B9RT5EEPcNa6lfGmZz/hiV/udecnkq 2+4oJVxC4f9kpULfZ6pA2D412nOI5Om0JUMNLCXOtgovpbg0Q98megzt2RyNeDajdJiUET1wScQ YCLq+aDzqdG4n8+7f/hSJ7behLp0iErxZuhS3+wBdwVpz2PstiasED4UpMSG+RwZbLUfu0o/R+1 AMkLouoqfNxpcaOW+i+tKLQP2qryiDKlKSp2HYYZpd0D5lk+
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The pnp_device_id array is only used for module data to support
auto-loading the floppy module. So the .driver_data member is unused and
this assignment can be dropped.

While touching that array, align the coding style to what is used most
for these.

This patch doesn't modify the compiled array, only its representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

I intend to change struct pnp_device_id and for that it's required that
.driver_data is not assigned using a list initializer. Instead of
converting it to a named initializer, drop the assignment as the value
is unused. So this is both a cleanup and a preparation for a later patch
series.

See
https://lore.kernel.org/all/cover.1779878004.git.u.kleine-koenig@baylibre.com/
for a more verbose description on the mentioned change to struct
pnp_device_id (though this is about platform_device_id, but the idea
here is the same).

Best regards
Uwe

 drivers/block/floppy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 0509746f8aed..dca495be0683 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -5012,8 +5012,8 @@ MODULE_LICENSE("GPL");
 
 /* This doesn't actually get used other than for module information */
 static const struct pnp_device_id floppy_pnpids[] = {
-	{"PNP0700", 0},
-	{}
+	{ .id = "PNP0700" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(pnp, floppy_pnpids);

base-commit: 49e02880ec0a8c378e811bc9d85da188d7c6204c
-- 
2.47.3

