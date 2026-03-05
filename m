Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC07C1FC8
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772676991; cv=none; b=cbGHxFxNS08k4MmtBzu+9NatZyjdyj4nBWe3aWNWp/4bN25/xVz6XFnZahQO0zjE/VPWNvquAu5ezZrxg9ThFrIbXc5A23nMWWJGqVWf+iNYgHH4W+6XG2ZWyLrvy9fj1atCND0kDoxyALu3BvVxOpYrFp85vjlhLjlFgocQHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772676991; c=relaxed/simple;
	bh=UgQuqL9mKi7usxwmoZ0Z6h8hhDBUm+TVxQca+UGSs5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FacTdfem4yZXDcqFCMX9qI+4M3pohKSgvFJI6jtC2t+/GUq60LgPxsn1eEy/NXHmS9FD7nd+sgrUC4ItO4y2Ej20aLuMdesgm6PPqFLvogyVWFoi8QlUsXgdPM6SDiyfDrqdEeu3IZpnPENzUbSp6HOGbxUvKp7vKPXLBKTHQmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TWjsFJJX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TWjsFJJX"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82748257f5fso3984258b3a.1
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 18:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1772676990; x=1773281790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esyn4MiJLCvi8Tm+OqaXpfyuFYdwvpybvevGJy0UR3M=;
        b=TWjsFJJXe7/96U6FSXE5TNwr4bBneauJOc+nBbh0+yp4nXYp9ZhpdjukATvFYsvdeG
         KKCS4VEPuKFew4MFei0yLjKoNBurcq2ESxqlFw3uVcTBQibykT/B30CG2niR6FxEjMAn
         UcRpUc/WUc/4BSqnq7Hqh7O1KLotrlSCQecSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772676990; x=1773281790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esyn4MiJLCvi8Tm+OqaXpfyuFYdwvpybvevGJy0UR3M=;
        b=bSiVoI4uRghnlRDXrszH/SoVCM81Srp6ypXCvJpzWw4ygWeLJTNY5oElxwji1Pe2s+
         32b2URs+DZGENxJ3mYIeRyeNNxH215zjJL2BbuqTZs/t0X5D1EE+c+7H3qUV474McdpI
         pZgmCe7U0DfgI0zWWUVb/zPLYBd8lkmj1PBkgeU5duXlil28+8zi/gmr+tT9am6Q/AY3
         xJebh1j1h7x70XyKX9JFqPO19p9Xm4KX+mFXw0LkA1sJOd/uTeONFeDqXoZuuevCj5EH
         fgFhln9UVyQ6y+UvwfNbAWxX/YrIVA1Ih2gOszak+wF+M7yoTCLHk2yqp6wqPtKWCmZG
         ydlw==
X-Forwarded-Encrypted: i=1; AJvYcCXAhoYuYpozvGOXqLh52WVPduajIfT/hrgTaMpmv2BXYB9dUH8g4wrvI+X1GzpQmcdaOIpmWAfw4am5kQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym52Fxg2389yD7KF2V162XVMullMGry4vR8PMcGfV2/0jDv4IH
	slakg85JWU9weFbtoaz4SEsu8QL11KI8nYya2L8EsQukXaOS5xsnhWv7T5fsvB3Vvg==
X-Gm-Gg: ATEYQzyJQw56kKNSbAviB5HRWCmRn/S2TTkB8PBq46I48omobZrP61mc6RutyBxiicJ
	5utPmeyNHxpv1V/zn0UNeWd2v7/atpc3F4lGemtkYOTOWRr0OckFXMqy5YDMBvcWeO9doyrqv2v
	mKS7Q0o5gIxM9eetvJowJTyUc2rf/0YaBJFWukoddEOmhziTr6M0J+muq1ET13KvEJJ+9Qaxb86
	bTEkMJSuaMb+JeCGc3WKVuUJywxdlRx8kc9HMSO3QwyH8pnGunc2YwSpOcVT4iKylfSyoOTGMoe
	KHi71YFX356NhFEJpAinRzN1LduCWFt2oJrl5zTDx2WIXbZg7ik+EMU5291MfLfO4zXE6EUZRTa
	b3vaK7HlzzvWCxkXk/ZWM//rZQgyac/LKHwQKCrxtrDqrBDaLX7N1khl2oXc4HWKsn3zBx3dqhB
	YcYAwQPNtcoWMND8bLt0KO+PnxMD1cPIZc26U1yLpdt3/MDsz7hia7EQHidLbwlUlp8YD9FuAUa
	pOzPCSeHfrsyZqLas3ibZ8V
X-Received: by 2002:a05:6a21:6492:b0:394:5fdc:cd19 with SMTP id adf61e73a8af0-3984239bf6dmr701023637.10.1772676989980;
        Wed, 04 Mar 2026 18:16:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2a00:79e0:2031:6:713c:a5b2:ae9d:686d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c738d87b2c3sm418348a12.13.2026.03.04.18.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 18:16:29 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Brian Geffon <bgeffon@google.com>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] zram: use GFP_KERNEL for post-processing slot allocation
Date: Thu,  5 Mar 2026 11:16:03 +0900
Message-ID: <20260305021619.617481-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Post-processing slot allocation used to be performed under
slot bit-lock, so gfp was restricted, then we switched to
a sleepable slot lock but gpf still remained restricted.
Drop that restriction and use GFP_KERNEL instead.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fa38d26119ec..6a6fd08a5a15 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -297,7 +297,7 @@ static bool place_pp_slot(struct zram *zram, struct zram_pp_ctl *ctl,
 	struct zram_pp_slot *pps;
 	u32 bid;
 
-	pps = kmalloc_obj(*pps, GFP_NOIO | __GFP_NOWARN);
+	pps = kmalloc_obj(*pps, GFP_KERNEL | __GFP_NOWARN);
 	if (!pps)
 		return false;
 
-- 
2.53.0.473.g4a7958ca14-goog

