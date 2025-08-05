Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8412580F1
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389219; cv=none; b=OxaLvD+HJUkg0Qw9K0y1fGjP8jtIu2wmMs7tUa1pHehX+wHTwT3EKiucvi6ySAu7Gd2BNLiNNseCFXtyGXcW/na7WGOY+nG2LbndNrsdhDsAPJyyjON7b5NgF0PUEOt27RyLQsInYssIqdBB4X97EttRhU+PWMA8PZJQHFRlmmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389219; c=relaxed/simple;
	bh=yHS07nMwU4DvQAKXhw05BCSFbHkQtv4jF/xqOUl6vKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dfwzUxrCpjyKDuUuU8ut+aY4IpBeEm07Vc2jBw0qvsr1b13XvlO/Kl85oWj7RMHkVNcQXTKCQz/ag1M/9VEsZPZEH8rWUWqdRosq3PhmoTDHkTPUnb03LnZpLaNYZK5KBi6/VPS9uQEugn0ewMJ6olHaKbDIldG3tl8c+dpDhSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CpioAsAF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CpioAsAF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76b36e6b9ddso4443329b3a.1
        for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754389216; x=1754994016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ID/O+jpa5Id4ySA0O281Ba8wApOW+JtPIM75o1GLIzc=;
        b=CpioAsAFk+SNSyTqcpZTu6b25BQbEIq3uEXBepL5DFE2yyRZkOewSyBHAzHH/kFTMC
         DuMHTN6yO2YYPMruxnFSaJ27h2InAcevytck/WwYLfAPj3lRPkNMI0aYN8tA6h8d6f2G
         64cNIvhUygUHpdElRifYZ2Hkn0AIPJcVIQsEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754389216; x=1754994016;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID/O+jpa5Id4ySA0O281Ba8wApOW+JtPIM75o1GLIzc=;
        b=HE/UNtAAQD9cgzufIREiwye1IhesExGQP5os1lWOdUm0bwFs9TpmE43eoJS+5G7tVu
         iNm642t4AG03MNWmSdvnXtvUzwWG+S1juERooGl2rsvOCtIqr0QDheN1EH9B1h4Yogk7
         o6Ng0EsIs16Z1Uef+Gs1smO7oq33T+Tm3wDwUV5kpduYEv6JMKTmmggtDK1j9UHioU8c
         fPH0cVpNgGxJUQ6NbssmwUaUia5lN9F1fDEuv+KjIPHsRfCyVj9Q0WPylF+BRg98AEaW
         lQXqR0f0x4gQ++xxs7DI723qYG1OL9FsO1wIGQlWGEcbuAThahs3mlx7o34gIyju3sO8
         ffbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxz5jMUvzHpGGMaEL7O/Nho8F23K022iwbgNCKrVBNOhmLrLaWMndSwSt3I+ek5aNGz4ghetYPOvylqw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9Obv58VVL4QZt566uTAmCDd7u02FETwfivTi7ZWRinMATpdal
	k5foGnFO9YSfJHR3edEzM83sEGmRwllciLaWnQIAocTiZwhCJyKLI1b31VCUsq/K3w==
X-Gm-Gg: ASbGncumWCIlZWPiicDIJ/OODNlxNuxFW6CSBzDgAZhhVmZ1QJu3+Gn39Hj/slnhvoZ
	M6vN9jGBqZLIkHLDgZgPZoWetCHrFjHZOJqqmaaOnEbhNjk4BM6mtlR8v4SUvQCJdMdR5qt5uBB
	Cr1ioPaOaGU9r7z69DKfJ6cK9JS5YyIN+TNymiF8HzMAfnBrrC12Fa2E/INDthTgaqlrgPXJ8+u
	CZSWhmykz3ypghMDNuQa0X980M+tfcay+2/fHP5+tzNWVVfFxS9160/CwnICRzthFHUXWm0Hp/o
	U7n46O8AjtXEGr2CHzyVujl9Do0RLOGcE2P6+EasvxUMa4rOWI1UgfbLM4w3QCGHuv8WKSohkHj
	dmVkdzQ+bqsE+LbzbdsHWez/65Nfv/N+vLXeJL+3UuzZlx7ur4YW7Yjjc
X-Google-Smtp-Source: AGHT+IHS7XFrrCxOiBykpYR1RvBX10iSlM+rgsdsXMYDtW6cReThVLsKUIzXwtUEYfThTbVIyH+8+A==
X-Received: by 2002:a05:6a00:21d4:b0:76b:da70:487b with SMTP id d2e1a72fcca58-76bec4bf096mr14993206b3a.15.1754389216404;
        Tue, 05 Aug 2025 03:20:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:5a2c:a3e:b88a:14d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f30bsm12587965b3a.16.2025.08.05.03.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:20:15 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	Minchan Kim <minchan@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Seyediman Seyedarab <imandevel@gmail.com>
Subject: [PATCH] zram: protect recomp_algorithm_show() with ->init_lock
Date: Tue,  5 Aug 2025 19:19:29 +0900
Message-ID: <20250805101946.1774112-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sysfs handlers should be called under ->init_lock and are not
supposed to unlock it until return, otherwise e.g. a concurrent
reset() can occur.  There is one handler that breaks that rule:
recomp_algorithm_show().

Move ->init_lock handling outside of __comp_algorithm_show()
(also drop it and call zcomp_available_show() directly) so that
the entire recomp_algorithm_show() loop is protected by the
lock, as opposed to protecting individual iterations.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Seyediman Seyedarab <imandevel@gmail.com>
---
 drivers/block/zram/zram_drv.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 8acad3cc6e6e..9ac271b82780 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1225,18 +1225,6 @@ static void comp_algorithm_set(struct zram *zram, u32 prio, const char *alg)
 	zram->comp_algs[prio] = alg;
 }
 
-static ssize_t __comp_algorithm_show(struct zram *zram, u32 prio,
-				     char *buf, ssize_t at)
-{
-	ssize_t sz;
-
-	down_read(&zram->init_lock);
-	sz = zcomp_available_show(zram->comp_algs[prio], buf, at);
-	up_read(&zram->init_lock);
-
-	return sz;
-}
-
 static int __comp_algorithm_store(struct zram *zram, u32 prio, const char *buf)
 {
 	char *compressor;
@@ -1387,8 +1375,12 @@ static ssize_t comp_algorithm_show(struct device *dev,
 				   char *buf)
 {
 	struct zram *zram = dev_to_zram(dev);
+	ssize_t sz;
 
-	return __comp_algorithm_show(zram, ZRAM_PRIMARY_COMP, buf, 0);
+	down_read(&zram->init_lock);
+	sz = zcomp_available_show(zram->comp_algs[ZRAM_PRIMARY_COMP], buf, 0);
+	up_read(&zram->init_lock);
+	return sz;
 }
 
 static ssize_t comp_algorithm_store(struct device *dev,
@@ -1412,14 +1404,15 @@ static ssize_t recomp_algorithm_show(struct device *dev,
 	ssize_t sz = 0;
 	u32 prio;
 
+	down_read(&zram->init_lock);
 	for (prio = ZRAM_SECONDARY_COMP; prio < ZRAM_MAX_COMPS; prio++) {
 		if (!zram->comp_algs[prio])
 			continue;
 
 		sz += sysfs_emit_at(buf, sz, "#%d: ", prio);
-		sz += __comp_algorithm_show(zram, prio, buf, sz);
+		sz += zcomp_available_show(zram->comp_algs[prio], buf, sz);
 	}
-
+	up_read(&zram->init_lock);
 	return sz;
 }
 
-- 
2.50.1.565.gc32cd1483b-goog

