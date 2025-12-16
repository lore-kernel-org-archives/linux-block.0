Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4263228A72B
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 17:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905762; cv=none; b=BfTbSCHFU4RtBaunF08nGwac3LINxnPrLjZb7VfeovIjNGNGSjKkYnCnLA/WSrf/1zf+51jYDExGmXPAoYPCn4XhCkMezuOnkUTnC2LuE09RW93P2WCFHgytrDcjSpLYODXoLks7/oDgMiyy46fx5S3enTuacqtL+TAzP1SoC40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905762; c=relaxed/simple;
	bh=UFuXGJl87VVFRtOHjho6NIFl+kVD765QpReolS459wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b+cWeOxapKxTryTGaH+WhwcGVzuszV4ZtatNJM2Gy2smlg3UggkpXB3LPxNGjoUhpakq1TMGY/jHuLzyBis4pr+x3SjuE+RsDgNonIt2rLyOUJmNlcz8V2u4JgVPvQ3tNDWSVoBLN9ClXeNnE/HPSUb0T+5iaOOcQCz8eCV6hGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WeJXlrfC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeJXlrfC"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b55ba1e62so133501f8f.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 09:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765905759; x=1766510559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mKyLdQEGhgJbQ0rcfGz63d+VAIFpbamsmpk3rRxDquY=;
        b=WeJXlrfCU9b2BeOuO6FhxXCKu+1LGv1gwxMq0vkr7PA15yPbD42humEPlmrCoU9ZMJ
         ktDCCdFISzk/+pOIOP5yDHYN1DFvv+canLb/jxvmhwTNuz5aklg+YP2O8yrjJgLzyaeS
         tO+dRAaeo+2zwiRNw1rIBXdDtNDEER5MYaNwiVr4D24/ooRkq8iqUFoBnkP2z20MJClj
         DjHTsviPLm2bXzZ53q5GDhrHRjTg1Lk0AkD2gO7QSKdZ2boxSzlB51Nz2wbk/B9hNnLu
         br7ZI8+KIt/CE6ZxD7r7vxeFk5F7W0Pv4Zos1hlgB1EfMGidDrMe71+Ug+cMwsJRBB+T
         Cdpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905759; x=1766510559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKyLdQEGhgJbQ0rcfGz63d+VAIFpbamsmpk3rRxDquY=;
        b=MXHVim6NQF+lXtDWxgrwnS6t0LVh6GVkrnRgTB+8wgkRekIdwzm6wWcnvxP2i9gB7G
         akMD9JDlc1p+Tlz+0PUrxg7XTSYwOIHPvbypv5GTig84u2wHKHsEFqiliJtFFTjPKKQE
         x9iJRfJKLo2NVGG/35BeA9BaTfjbfO+yh6Adl9Cmz4IIZiZtjj9qYI4GT29DZErFfyMt
         KduLKhmk17X4yK/8JMrNNNv/HiolCGgpzvUAO2qiLCXkQd1sWJL8H+QOxYWao+iV4UZZ
         qKxmJjWLUAQ5MPJwfXToqx6gGy9ndl3j5HetCpXDTfNPK9lG/vKwv8u6QnlbngwhknU0
         YPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUSCJQ6pUZ9OYBEODU3cj/db0txXjlb2C9xNwTVwMDZvAFRyEzhuyFmJr2WtMTtZsKQBQkm6djiK7qPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQPgWxQzyJh+x5EmGKLoeFSYAiUqOABlUNMmXQUfI6Oy3KVsV
	zy+5fNhUQTgLEg1x8mHmVIQ6gbvp5iJcdVXL3Lq73HsOryK1TnJg/R97
X-Gm-Gg: AY/fxX6+tw9jOp/izbbp59K4LmYmCTvAJbEEobeG37VcpBCSwHWbhKZ3zpzFoR600Zw
	X62b+Qafp7YqfhgV5/UIR2wFclcSblr+DhtIUk8WTzmpKM1rXTVA0aSMjuXHqix5D7e6qFKZDsd
	Kh2DI6V6KdRunDh/tD2bYMuLH/u0+B8itt2rp2dxY41KreAmf6Ws9k09w6FUIDLxIxK+i3m3p0X
	QU7aKf/UhJI0dl04HPZO9YACP66nXvJr8Y4WdHchpWb88AMTHSLigBezYDVMj9mVVbw/N6MwpsO
	lWjCUaPtPYvtpTnFdTHjb4ZsdEwmZIF38nFbQRxQv8KkNuZ0H+Q9b0N3kBbzWhNj2JG0/k5l3G9
	FgRhW/PU0Gq9mMkgunU8JniObpkCnuS+y0ne/itlELk2jYyxm45GUa7xO+ryqxLO46WM+al2RjK
	tuMyEEnl3iFXXNOZGhhrQjW4r/vj1H8xED4VIbT02zWQUXs1Il6RfLSHrLctcUqfwX3roglxtuL
	0Rwwy8=
X-Google-Smtp-Source: AGHT+IHmQS6RGAHTr+Y/wsnGe/COASXW2A2kF5M/0v+c+2mbcCvu35+0lzvO+L74CHYn9f2xAPJB6Q==
X-Received: by 2002:a05:600c:3146:b0:477:a450:7aa2 with SMTP id 5b1f17b1804b1-47a8f8a8e4cmr107678965e9.1.1765905759518;
        Tue, 16 Dec 2025 09:22:39 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47bdc1ddf2csm231635e9.7.2025.12.16.09.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 09:22:39 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>,
	Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
	Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: rnbd-clt: Fix leaked ID in init_dev()
Date: Tue, 16 Dec 2025 18:22:01 +0100
Message-ID: <20251216172203.48947-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If kstrdup() fails in init_dev(), then the newly allocated ID is lost.

Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/block/rnbd/rnbd-clt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index f1409e54010a..d33698eb428d 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1434,7 +1434,7 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 	dev->pathname = kstrdup(pathname, GFP_KERNEL);
 	if (!dev->pathname) {
 		ret = -ENOMEM;
-		goto out_queues;
+		goto out_ida;
 	}
 
 	dev->clt_device_id	= ret;
@@ -1453,6 +1453,8 @@ static struct rnbd_clt_dev *init_dev(struct rnbd_clt_session *sess,
 
 	return dev;
 
+out_ida:
+	ida_free(&index_ida, ret);
 out_queues:
 	kfree(dev->hw_queues);
 out_alloc:
-- 
2.43.0

