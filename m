Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8C373BF4
	for <linux-block@vger.kernel.org>; Sun, 19 Apr 2026 05:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776575434; cv=none; b=jrE2LH09e2f2Ds5C4vYfATYXTm7836f+McmfqV58zE0yQ+492av1whZMY55G/zYElTpnJm9wmqaSxaAsfH4JHf42fZBH+Js2ufeZGFekXqFODKUOrEHb95Xdkxlj6e+WqtHI2vnIrP0szasCVY6OhveWuJovVItSF10WFKYgWU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776575434; c=relaxed/simple;
	bh=5MwVA/avRYegt4COjNqWWOOrT0cfgB4W4A2vtGXLGjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LnIAqsxx6mznUnBqGDviVrX0nknNc1P/m1F5wMmxRKrXzMAAru+xfwI7eDcLIyPAZr/EFpTlISaLBL6EAayD1efr6sMSjNqG87BMsyHfCmDRrpSBMP2T3CDzdylbLxc8p8um0pK21iJYjoWiN9B9qMGbFN9BgXVgYlNH3zPjOpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=gVgyP4Hb; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="gVgyP4Hb"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c156c4a9efso2375189eec.1
        for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 22:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776575430; x=1777180230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfy9Yu3HO+uTZe9CvyyvIAi/v/P3eFhIORnPWGxSiwA=;
        b=gVgyP4HbwmC642uVFt1vJfuBFIJCsnDNoPle+zTKmFxWBC9GcNKo+B24fwM20zBIgC
         3ORPbiDdrop+MHMn5uieysdQ+Hsf5wKmVZjAVBuZRTuRwAr4HPvjLa/Kf2eq6QYa8zMq
         hy1mAP7rYh4W/GyCIB9qLam3ydpzCKIrtWA/pZ80dxhKatvWIy0XEOk1Pf8Zv+tHNE8t
         q91fVoe5k4y1k3etjZjxwJ/AbzRuWHl9W11JPzVJimUBO1u1PgsJd3f56Uf6V4Tp1/7N
         R3aswEGyjPqKnVzyPGobbTH/ShDnMN45uAIlr+qkSw6XDcSyLMDBL1jB3odyhmBuolxh
         MS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776575430; x=1777180230;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nfy9Yu3HO+uTZe9CvyyvIAi/v/P3eFhIORnPWGxSiwA=;
        b=B0YmFVRARL7jRbYdxBKnGwrnN12vSTd+XEYwQzxoN7R0YBmBOziLzStmwq2BCU4BJG
         GKe0kgTnl7fCwAcQCCCR2peJQQ3vro2SB+QAf346XCuTzo7gmavKXWBj2bFu6vsf4o4c
         Q3bgzSHVcG+8UUgX2Klj62fNXQtHVgzf9+n6BsPOa1kbFqwiQLgjXX8hR/OKiKZ5eB+p
         kq40OioLFc2f2yYhQmiLoZ413aAIqg+mpiVlvuZldrqOe0cKzmCsEnPj4BaPJrrm3HC1
         /zWHj6uwFzTn4bZclvveiaAVg9/gqiBfSZhtWUgRVJ/5y6CyON797UESgT9XRe83rkB/
         g3tw==
X-Forwarded-Encrypted: i=1; AFNElJ+w+ewuLZnE11ZEawcoPxoVi97fyIICz6BDjVwlFPEujD+cbOLrwfq10j+UC9xe00m6GcIsaFKBRHYazQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDego0Jjxr5bzF1+ehBCdbAAqIpqqb/h3ObbaqYqzvXW9PSlU
	e9iuVgqg4WD9ciCclHdKIGbBCzTX3U/dcqHKEfOWizJd3KCx0mb6bBQRzhBg60SLyWc=
X-Gm-Gg: AeBDieuBrIVKteCARgOGnJxhpL2IhIFzIJMB9mVNhcAlbLulveC2W8uXF7rSIK+ARs0
	usnBR18NWLm0hWukA7ZWN/F2sEfmuTb2AXHGWT+a6GRkncsy5VNTAN42LT/4t/cFAk2VysOjIgb
	irsHB1u+X26WdKGejabZtR9sTQkNXNWNoBf5CmS6LCwEYnWW7qVlyiRMGmvR59T4OHPKhVZIBu7
	I1USQYjknupKMMfYT2AJHX/2sYz1uhn5xoOjGX3mMEn/7NFV0Yo1AMy/PKZIBOxKF+wSCLud7Lw
	9dqeyqcl/FQEccw3pVAFrdV2dZSOI7bOQfTpoTgSQmJ1ItCQWXqXHCu9GWvyZy1Ao16ha+F3BZg
	vz5UCfSjmOZfHNBTNs+f5q8Z3p9dNVBKLxUv6H0oHEaG17/MGPQtCoE8gz1eW+u65A2hCyJtUun
	oSACJwNKZyoVpxh3CWmraVmhNlp3ca8Al3Gcj/GMUl5zbsXg==
X-Received: by 2002:a05:7301:4593:b0:2da:1874:f3bd with SMTP id 5a478bee46e88-2e47883907fmr3798140eec.16.1776575429627;
        Sat, 18 Apr 2026 22:10:29 -0700 (PDT)
Received: from chrysanthemum.. ([2804:7f0:b081:9846:8d5b:e745:5172:e188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8b3dd9sm8745052eec.27.2026.04.18.22.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:10:29 -0700 (PDT)
From: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
To: axboe@kernel.dk
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	Gabriel B L de Oliveira <gabrielblo@ime.usp.br>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 2/2] nullblk: zoned: use lock guards
Date: Sun, 19 Apr 2026 02:10:09 -0300
Message-Id: <20260419051009.796491-3-ricardo.kojo@ime.usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260419051009.796491-1-ricardo.kojo@ime.usp.br>
References: <20260419051009.796491-1-ricardo.kojo@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() for handling spin locks instead of manually
locking and unlocking. This prevents forgotten locks due to early exits.

Signed-off-by: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
Co-developed-by: Ellian Carlos <elliancarlos@gmail.com>
Signed-off-by: Ellian Carlos <elliancarlos@gmail.com>
Co-developed-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
Signed-off-by: Gabriel B L de Oliveira <gabrielblo@ime.usp.br>
---
 drivers/block/null_blk/zoned.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 384bdce6a9b7..6f59531e9b1d 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -471,13 +471,12 @@ static blk_status_t null_open_zone(struct nullb_device *dev,
 	}
 
 	if (dev->need_zone_res_mgmt) {
-		spin_lock(&dev->zone_res_lock);
+		guard(spinlock)(&dev->zone_res_lock);
 
 		switch (zone->cond) {
 		case BLK_ZONE_COND_EMPTY:
 			ret = null_check_zone_resources(dev, zone);
 			if (ret != BLK_STS_OK) {
-				spin_unlock(&dev->zone_res_lock);
 				return ret;
 			}
 			break;
@@ -487,7 +486,6 @@ static blk_status_t null_open_zone(struct nullb_device *dev,
 		case BLK_ZONE_COND_CLOSED:
 			ret = null_check_zone_resources(dev, zone);
 			if (ret != BLK_STS_OK) {
-				spin_unlock(&dev->zone_res_lock);
 				return ret;
 			}
 			dev->nr_zones_closed--;
@@ -497,8 +495,6 @@ static blk_status_t null_open_zone(struct nullb_device *dev,
 		}
 
 		dev->nr_zones_exp_open++;
-
-		spin_unlock(&dev->zone_res_lock);
 	}
 
 	zone->cond = BLK_ZONE_COND_EXP_OPEN;
@@ -526,7 +522,7 @@ static blk_status_t null_close_zone(struct nullb_device *dev,
 	}
 
 	if (dev->need_zone_res_mgmt) {
-		spin_lock(&dev->zone_res_lock);
+		guard(spinlock)(&dev->zone_res_lock);
 
 		switch (zone->cond) {
 		case BLK_ZONE_COND_IMP_OPEN:
@@ -542,7 +538,6 @@ static blk_status_t null_close_zone(struct nullb_device *dev,
 		if (zone->wp > zone->start)
 			dev->nr_zones_closed++;
 
-		spin_unlock(&dev->zone_res_lock);
 	}
 
 	if (zone->wp == zone->start)
@@ -562,17 +557,15 @@ static blk_status_t null_finish_zone(struct nullb_device *dev,
 		return BLK_STS_IOERR;
 
 	if (dev->need_zone_res_mgmt) {
-		spin_lock(&dev->zone_res_lock);
+		guard(spinlock)(&dev->zone_res_lock);
 
 		switch (zone->cond) {
 		case BLK_ZONE_COND_FULL:
 			/* Finish operation on full is not an error */
-			spin_unlock(&dev->zone_res_lock);
 			return BLK_STS_OK;
 		case BLK_ZONE_COND_EMPTY:
 			ret = null_check_zone_resources(dev, zone);
 			if (ret != BLK_STS_OK) {
-				spin_unlock(&dev->zone_res_lock);
 				return ret;
 			}
 			break;
@@ -585,13 +578,11 @@ static blk_status_t null_finish_zone(struct nullb_device *dev,
 		case BLK_ZONE_COND_CLOSED:
 			ret = null_check_zone_resources(dev, zone);
 			if (ret != BLK_STS_OK) {
-				spin_unlock(&dev->zone_res_lock);
 				return ret;
 			}
 			dev->nr_zones_closed--;
 			break;
 		default:
-			spin_unlock(&dev->zone_res_lock);
 			return BLK_STS_IOERR;
 		}
 
@@ -611,7 +602,7 @@ static blk_status_t null_reset_zone(struct nullb_device *dev,
 		return BLK_STS_IOERR;
 
 	if (dev->need_zone_res_mgmt) {
-		spin_lock(&dev->zone_res_lock);
+		guard(spinlock)(&dev->zone_res_lock);
 
 		switch (zone->cond) {
 		case BLK_ZONE_COND_IMP_OPEN:
@@ -627,11 +618,9 @@ static blk_status_t null_reset_zone(struct nullb_device *dev,
 		case BLK_ZONE_COND_FULL:
 			break;
 		default:
-			spin_unlock(&dev->zone_res_lock);
 			return BLK_STS_IOERR;
 		}
 
-		spin_unlock(&dev->zone_res_lock);
 	}
 
 	zone->cond = BLK_ZONE_COND_EMPTY;
-- 
2.34.1

