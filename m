Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A43B058F
	for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 12:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476917; cv=pass; b=i1SD/XyBXNuc7ItIBabETsgO8+MrnHx1fDI6DLQrHyenOH2I8HJYvWfHVpUjqvQpsRiMsNRcC4r3um4lvfnihiv2fkpXziyDboeKXFMpnImpp5lMhEBNEFYoDLOuvDQGlo6xGQQUH53MukuJPfmrSo8xY9sZwQCS/lGSpFVouww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476917; c=relaxed/simple;
	bh=PowoG5tRiVRdkcWmwe+DMR/4ov1I1MdXXOl5AyioG/c=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=WbFJPKzmQk5h0TqDq+AdzGUgERRC4O5s57UKvgzHZu3Ud4DRvz+ETP2ZKaLJsfObw2H7lB04GP2HbLbGZ5PkkhDCkUXTKXdhKQPsFAY29cnN/8oDCZvWdCHkNfDJsWwWO6ZiNjqHkq4b+HhlPxyLoXSqaZOxFMvD8FP7Ke33fY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pBCFEsMf; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pBCFEsMf"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843c3ea1f6so1483299f8f.0
        for <linux-block@vger.kernel.org>; Tue, 15 Sep 2026 05:55:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476914; cv=none;
        d=google.com; s=arc-20260327;
        b=Q14R3wybQIfyv2ZZQeq5DycdA+ms0GGbhDiU/7DY4yKALyPLfBebxReO25TT0RUHtO
         szZifAIhWTE8tGSFWV/L36JqNe6ec/dSK61b1XTVKLwZme4OuTr57UKw1c9BerqcjVuP
         9qfSG8bUVRyCop4uPDZQWfDVKP7lCFtxrVRrU/OkZTnPgFay7XuRKLszJiNxU61CSsa6
         T5Fb7Opc9DbScrYVpRUI2UJ3T8XaWwFgr65QUa1dyFs3RD9f2Bw2Xt7MoNQA+g2zo5gY
         EMYERc2ypCNG1h13xCgCsy9DI+4rQ+ZN3c4Jx3HJOZRuqQDpnTBJtoUo5VDp5pg5wlod
         GyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=48wcYoDVZk5RKFCmMWziSOrj87z0dqzG3O91jppSiV8=;
        fh=Dlp5jqEOmZB7yTETkyDkkAQd6vZiCEyezIR7nPto060=;
        b=iitaH/SfGW4EP+4MqKV0pSWEdYQwGiEeySQ1vZ5Fvd9e1FWhZG8nGCIJzIPNBJZYbi
         6qpCq6udTCVqiEigFRHFOKHTapxOSafqm9Y1v2aRo0Fik1jve99z0Lqa9QjKfGuOwogX
         Ie6roxRVvViYx7fPBgnpv7Sa7TH8bmi87Gwkxi+j4gX1OzmCpTfgkE8EUKDjcEzzfoJY
         Lhe0Ipcm6EixQ37OMEBaKk4jJPJ56dyuA1J8FaTYK4dkvWH/DVdGYNNAKsL0+bwgRdlb
         ZL4AEPjm0DoKWPj7SQembZUQIAgGjq0TFtwVwGp6UtaB2B0UoJ+2NoFlMvu2+0+dnAj/
         iKuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476914; x=1790081714; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=48wcYoDVZk5RKFCmMWziSOrj87z0dqzG3O91jppSiV8=;
        b=pBCFEsMfMYI2JGvlIw0Mrpp/eTywtjzmD7noQq03qmqGg210yalnOmpm8wNHmHbPd2
         GRStU2+QkwmW+VyVDiBw3Y70RyQ585MbM0k7vGn3HVblSyqpdUUa260qxEEu/xSX+Ytw
         10DxRf/MR+vrH4ZIRnau4+YA/op3DneGEvAzUOFBtnNBhBtGzp4JM+kRTBsVS+zrOjWu
         6EsInEhrCQ1oPr6afiIYQnihxbUvPTQXxfJOK/XrN2ETtZ6zR/VY/CRuoZV6Ox5HqqRX
         1XA0gBx4k339rpsHcASzkfRuz2IvQkSXN2ZRy+5oNpPUXlSPt0IW9oGqB+qXxDBc/MqR
         35ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476914; x=1790081714;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=48wcYoDVZk5RKFCmMWziSOrj87z0dqzG3O91jppSiV8=;
        b=gdYerA0JuXH4kq/Rqw2MYzaLjQoYX1g3/VgrhA461E+3L1m1hMfZg1cps1bfrtKWlx
         ivdsKWr/RWNVjb8ncVDmBOowBP0CCIjtj3Q/TxnSxe2IJdYtcymo8NVc+4nAwRq46pP/
         KR4WvnTXRg8+louZ/r4AJ3ihgsvOF5Aq3zKqIQjO5JKH763EW5EKhoJod0qEsRfQtC3d
         JhZwU3WShrMLddQCIHR/9ep9xIKSFKCHyUp9ugxL0OVAooKkjBQrQzyeKQRLGCOUSj6O
         e+57UITSiLY6rA5yRxMVgyUvbArJORO1lf59ZcUZSCm91trhyV/fsYKEUP3tYjZ3+mOY
         OtOQ==
X-Gm-Message-State: AFuF++mBCmLV8lTYzsb/169uWsQHjvadUZz8I24Onru3mNJlwRLblM7A
	Dk7Wulq9QHDKaOHDjTti2zQp3yv0kwX2DShJ/2iEOhu0Sk5cU3c+C5sFGOa2hl/6NeP/r1nSQGM
	G1C9kuJViQn5CtunXMVVRSzMxUVzoEcEmdAIjOqISTQ==
X-Gm-Gg: AYBFou3FWTVeA19yLbFu9CJz98hdunqCzsL5KAgHBUlLLgvrKoBpNdq3T2ubVB/8Zp7
	jJEWAJRVwUbfO40KxxOq99YG9vLm+LnStDCZcuNJgApqtlBs7l2hf1tgkmWdpHuzAHtBIbAtRUW
	FRnvwJTFTzwKtD0IcLUrKJA/5jK7H951sKbRcGjGtqaTOqt7JMvg5n+vAslK4268Vi0XmIO9eWU
	fkKiG4BtX3INJvcWejHd4kzQ4iCG21R0IRwl2RResF75qgLaATd/JdNq6O5Id/OQFB1ZZLHN9Au
	NWRuIIrWiNH9zmwdd0Ebm8twxdm6jQ1K2djubzahNWgNhwNCvuE/jg==
X-Received: by 2002:a05:6000:178e:b0:487:725:8210 with SMTP id
 ffacd0b85a97d-487072582eemr3548383f8f.21.1789476914385; Tue, 15 Sep 2026
 05:55:14 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 07:55:14 -0500
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 07:55:14 -0500
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 07:55:14 -0500
X-Gm-Features: AcwNN1VbiGM7i9VJ9PU7ubfe8bPnB5PYWLZX_LpO9D_nOUw3WjKSh_NfDhAFJm8
Message-ID: <CAF9RqJ4zT5saHf_HhWBLsKKL1zBPcC=AQOd72g2Vun0Y+_nA-w@mail.gmail.com>
Subject: [PATCH] block: fix comment typo in blk-merge.c
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 block/blk-merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-merge.c b/block/blk-merge.c
index 258a726071d1..6b87b0d34f34 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -401,7 +401,7 @@ int bio_split_io_at(struct bio *bio, const struct
queue_limits *lim,
 	 * there may either be too many discontiguous vectors for the max
 	 * segments limit, or contain virtual boundary gaps without having a
 	 * valid block sized split. A zero byte result means one of those
-	 * conditions occured.
+	 * conditions occurred.
 	 */
 	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
 	if (!bytes)
-- 
2.54.0.windows.1
