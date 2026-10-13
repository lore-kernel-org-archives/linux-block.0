Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B3391E44
	for <linux-block@vger.kernel.org>; Tue, 13 Oct 2026 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863537; cv=none; b=rQOTRBfd/00vzL4/2kginrba51sJtPJ5Br+lgdD4q1onDUJbimXQlBMjwwjeNk2ETdRFXDdASvWsNhmhNKTVr8WdyVSJQWuI00cTbHnn4cy+GjrGUYW14ZeKhah/tpSq3FFrDGxGUjoeYec8zJ4fo+rgZXHHZSw5QpVH0YrDQRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863537; c=relaxed/simple;
	bh=51+OtP2aeGNaUYP4I910l/wDDa+akp4WoYS6xLBGx9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHUr8B9VV71SGPXnaNWDk4aBAWZlI49IFgM4NUPJA1zMatB4IZ10RwlyPxuSWtcTCTuM/gJ2UI4ctvM3MMuuXkntB3fq2+Y2bI4S75cKYA7QmbXjkV257MhGQ+gZG9gy5A5mJXExmgIMehMiLN05PxR0s5lRXcJyn7nQsNsT9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pl2RkRtM; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pl2RkRtM"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8875d220446so1111504b3a.3
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 20:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791863536; x=1792468336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9JRVEvrxfwQIXEs8jD1qgXlnqM+VVYXSC/piCelGt8c=;
        b=Pl2RkRtMBy38j8H2YtSuTh93E/PQikuq4my5cx5/9H9XZDjfjPXxekA8IiDdmn3Y4L
         ALERztYZiAP3ocxgUM7X0Ldyz3WUfkLroS/40h4RaL4Pk74JzkpUiCE5QQ/DELazF9D2
         OSa7DOQkuPSZuTr+vDWUSsC1nyiW9111HRvCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791863536; x=1792468336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9JRVEvrxfwQIXEs8jD1qgXlnqM+VVYXSC/piCelGt8c=;
        b=JO7nj0qA5EOwpom09Gx6ywiYInRASY82/xB+tdQPFb5IVXVvJ1JLFOm8HP/E8k1ttn
         0SRu8JjiG4UzlVb+YxHCKj1cigsEAK7Kt07I4EGFjNN+hKnN/TiZmlbIX7wIzZ4flTcQ
         eIrjsGWHFDCcph4DpkitfC0aFqj2gxTnPVO/+5xzJpfYeagnPr+sNUGRh9GZsVbuKsXi
         1UKtN4CKK7kH3DWBGMIRgb66ILvpQNBlo4yF/oHeSwXG+XO8A6P6aOqzYNnUmcVBjqvA
         +SFBoPd+QPq/RmfNNs04eGity+u556klyQ+tuW/50gmLQgPMC3Mg0DgFA6d/YtPVJkDa
         qSZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzXsWtyfgZtsQXvHhsYhNqZQ4+QYBNiw7oBMvscLIYiLgcqLehhK0HCtsu3zIo1fSW1Hz6DQOo2YFcgZA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJlSCTsoJvBkceWJoU/Xp6aq2/A9xXtWN55BVVdQ9xbvw3meZlh
	cE99XZPfaAPU+eTWNVGFcwgggfEpVRvuQMhuXeUch3Kwa3q5yQ818n06R6klOWlQcg==
X-Gm-Gg: AYBFou1yOUMIHvERWaLCr8qm+ImZLpZydezNa7Li9dqyzxzySHy1VELJ9ichGARrVc6
	9+y4FgJmR//EU6Fe4w4Q2e9tVSagu8ysj75tzX2sV6Taa5FT9LjlTU9E+HqxwXJ6tlTwi/5Hdm6
	hTuHhLAuTvtiqac+x3lYGha+LHY5d/LKneoiPyuH1JsUyntr+f1ryheDM46prgeX7seAphAqKIx
	2CU4RHeA0KPrP5NxMhDk4tVT2Y4FHTK6dLziUofXdqpl/7wwaZWsuUrtHzx2bRFiQD36nIeQVKs
	BwNK+Vt4zvp+494qcbE4whg3uI5eved8BSwva9MXnJ4zYFLVaNUbMfMrlCB+jin0eFO5cClXypM
	BxFR/tTY+95m4Ll5irs9DQFjcs6d1D+um8WdgEshYOlIDUnKaEPzTZngHTN2XV1cN3f2SSMO1Pl
	Av0AiJFpPW6UvI76CvT1kOAuVvp2NVGY5qy45PhIna6yKno5aIXxC375Okw2GGY8PvZ4kjxezFG
	Xu6ykfTaetoe2x8IZcU894MlNcz8ail5tXYFQxnPSf40GXoJ072dxBABnRDPos=
X-Received: by 2002:a05:6a00:1254:b0:886:5438:e47b with SMTP id d2e1a72fcca58-897c73f4412mr8459670b3a.48.1791863534025;
        Mon, 12 Oct 2026 20:52:14 -0700 (PDT)
Received: from tigeriii.tok.corp.google.com ([2a00:79e0:2031:6:476:d384:7c2e:1579])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c41bbb27sm4326818b3a.40.2026.10.12.20.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:52:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v3 02/11] zram: remove debugfs entry on init failure
Date: Tue, 13 Oct 2026 12:50:49 +0900
Message-ID: <20261013035201.2809924-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
In-Reply-To: <20261013035201.2809924-1-senozhatsky@chromium.org>
References: <20261013035201.2809924-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not leak the debugfs entry when zram_init() fails to register
the block device.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ab064c84b092..593fa4ae47c4 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -3297,6 +3297,7 @@ static int __init zram_init(void)
 	if (zram_major <= 0) {
 		pr_err("Unable to get major number\n");
 		class_unregister(&zram_control_class);
+		zram_debugfs_destroy();
 		cpuhp_remove_multi_state(CPUHP_ZCOMP_PREPARE);
 		return -EBUSY;
 	}
-- 
2.56.0.385.gd3acb90ef8-goog

