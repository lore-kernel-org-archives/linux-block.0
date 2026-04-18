Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F71E25D1E9
	for <linux-block@vger.kernel.org>; Sat, 18 Apr 2026 04:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776487169; cv=none; b=R3aRLYM9FiFKH94biwgrkzOKhY9BPG4oBFs9XGwEHlfx93t5SFU3pLtYPCVCYsuFgI7+v0DAPHrHAcsZHpb9fXTPtHYDugVnkZqeHj58GDxKE9sIx6m1MPitjGwIpBh7mbb4maxOyT8bIwO8fpRKcYQmeZ/4bCm1+zYBEvCAb7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776487169; c=relaxed/simple;
	bh=5MwVA/avRYegt4COjNqWWOOrT0cfgB4W4A2vtGXLGjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PRIWqsqxABpjkfr++4/ja/b+r2NQlU2t+38Y6nFi7/BzwhE81+ozp01LJ7E3udYPvSlmy5huGi7pX/hkZicI+9wyKi2m/9KFC9jJgMJFlaZ2KbBVrtTQsg9BPuz79f34vytbGITVZ4JrN1O8IOIlPzkIMFYM6FxABbLvxXIASoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=TzaSy/0i; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="TzaSy/0i"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12c726f46baso1817153c88.1
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 21:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776487167; x=1777091967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nfy9Yu3HO+uTZe9CvyyvIAi/v/P3eFhIORnPWGxSiwA=;
        b=TzaSy/0iLJ5Td9h/4A1Prfh5O5Dse0gyKc6FkjpAzP97qlAMY8E8wJ8aYUesz2O8o2
         bCPKXlS8qqphRltqfpP2bP7OTHRxzv5AJaoALNgi0nejpqYoww1g+GiP3MB6hgQmAHft
         fXq+KNQ0m+90Nyo0+c4NuvNsFSeAZlsla9glfIqsc1PVaoAvro3qbgy5w4WKVLSbEgKY
         PDDvuDUzyh6n7BjCR1kxkOY6Ln7jY/dPtVq9RuNf6XO7sBDyfmtsYzO/0YelzzoJtYm1
         /eSZuxnjb05s6mim0ehWu5ciegAt/9liwkjmjy8yyTIXVmN/MNcbQ8nIACXfWCd8PBuC
         ToDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776487167; x=1777091967;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nfy9Yu3HO+uTZe9CvyyvIAi/v/P3eFhIORnPWGxSiwA=;
        b=bFIXvwrKmF8vZ5o5w4sNpt5s8SDz9iviErfUeiReIdFg8kgNeMyi3enKneL7Y0owyO
         0Z7cFT/Yu7POovvkgjnfNFC3OGD0y0/z+a8QW90JLPLDPu3qrcW6u+S+kbCbhcBh06lR
         Ga75gkJqV5LsY3AN7ewvnj8arNstctxsE4pNlgXtlj+Blyjyw59TpIFUFaCON0FPo6RL
         A0s9hxL4pkKVntA9f3sgavNiBG6SB4L3wgh6B1PWCvZm09a5Gop1tK1Nz54b9NaT3bql
         Idfl8dl1DGLKQ48kiAoP6ruI+0tNUkGkf+N4cxKFRLBYBH54ZJiaLvuXmz6q01kUhlwR
         4aMg==
X-Forwarded-Encrypted: i=1; AFNElJ+Cgb7QSYQw2g0WBr48tpYxCmOAJsy/5WDv3ZR/1aZxhZ2HTeEWekXDqlaeqQLNDhJqXi2qxb4NUyTogA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYJyt8ZGfSCsrpvlhC89skTuy/Mr3a7FDXckeoXwnGhASAbGFX
	B33EtskVrQ+Zqw7Vn+6QqHEXslMEo/1F+00qKK4H8WDGuyGTzKayXFskBiyJJYSeH7c=
X-Gm-Gg: AeBDietadUnvzwZoBaALsiI/pSGY963XwNyw/zdcQl4ehfk3BG3f/kkIbjA7T9k7JAA
	+cjbzwYWDGF1RDnDsrVmLlsDB4SOgAbiVyU2IKA5nwH3dLYa5JOtZlPSeJQV1iL6T/x7HMtLrh6
	h3nqSrzCE4IF5x51rK8IuIW5nK+MVRbmUFOCFfeTT3ol5P1OBOntcuHlPq/ktQi1DuaIFYUSK7O
	UA3HEArkIcIp2sz16zsmiX7jksLaEmE9SKMg2BGPtRHTDLKdOYlfSFNM13Y5y5eL/DhGzrC+kl5
	frnKXXTM+Rnv4cZWDutFwFh6V1lYYlwhP9QOKh8XCT4c+04VPR5PaIaI2we8eoON7Xh+F8TPnju
	AruIZ9G2lQ20FKQ2D9COs2ss+KScTe8e9/rGrAF7b5gDM0b8GYe6m4XO3vJQymuNCMNjOqcPXSm
	oYZeNH2Bg1ufVDldj4Ot+3waTb32tL6vrBgndmSRDIJ4dJHw==
X-Received: by 2002:a05:7022:e22:b0:119:e56c:18ab with SMTP id a92af1059eb24-12c73f90bffmr2475926c88.19.1776487167418;
        Fri, 17 Apr 2026 21:39:27 -0700 (PDT)
Received: from chrysanthemum.. ([2804:7f0:b081:9846:727f:bf80:6632:6056])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce460sm5273734eec.19.2026.04.17.21.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 21:39:27 -0700 (PDT)
From: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>
To: axboe@kernel.dk
Cc: Ricardo H H Kojo <ricardo.kojo@ime.usp.br>,
	Ellian Carlos <elliancarlos@gmail.com>,
	Gabriel B L de Oliveira <gabrielblo@ime.usp.br>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] nullblk: zoned: use lock guards
Date: Sat, 18 Apr 2026 01:38:37 -0300
Message-Id: <20260418043837.721045-3-ricardo.kojo@ime.usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260418043837.721045-1-ricardo.kojo@ime.usp.br>
References: <20260418043837.721045-1-ricardo.kojo@ime.usp.br>
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

