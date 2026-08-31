Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C5538D8F
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788189692; cv=none; b=AAaWKXYX2SQdbqj1b2ETpiapT/2BSdt7qU16LJTZIN3y7Yzlx58gFs8SOusJT+zJuF+VfEi7+sPlyc/Hkkpi0dOlGZZcHCifYp7Hm+bRdWMqjgI5ML8Cwdgbw9UoKJe3lWrNaLKhEfb/MmdVkmwvw+PNFwcbSk5OBtYtWwWSx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788189692; c=relaxed/simple;
	bh=d4C+oISs8ASeTjE405C18tiA451W0TvVEaZooCCeh1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbAB+K1rIQ7ibRHlxmD2QG/9Azw8+CkM2cLSUXLWeVvV/SZ1HYf3ojGfRyBhUTXXznTBIdqslas29jDSmmKfu76RYQdSrZkSOuiPmFL780rK8GBmB+0EO/8/Q2rTgOZ2RoGpTd8CF1BGQZqmpJR20BTSAjYYn0RxBuesHT234aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rV5ZoH9M; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rV5ZoH9M"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-482e5733a5aso2152241f8f.0
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 08:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788189689; x=1788794489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EeDOa3UQ6qSuniQ8iVMBKVscy2UT6ZrGGYbSUHa/WVQ=;
        b=rV5ZoH9MLOAUQet/ZDRqvdwkiguJwC09jiMjTt21FF8HNPBEKovBiXpPgfNwnm51KA
         tMWr7r1/Pv5waSeceP8jMrKAn7IrPJZ+TPaB1KzSNrbQsK+fHhP8oi8pQSlpml3I1cgz
         /ghVmWI+WUXtRk505yAaivcW+5pvUBx1DywZvHdjFS1KDImRzFcmU2lpt/m2erP6fsML
         udD7YJJTJUGGsC1It7yHCm+FQZENCUC6GEgqeuJI+rPJED8BizWEUCxOQ042S6/V749I
         Q18ZoBac9Gcl7RJ483ORIipypQCWvf/KtSNffKNQpQ44hWuZ/fbJH5QrL429okyXDrGd
         iFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788189689; x=1788794489;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EeDOa3UQ6qSuniQ8iVMBKVscy2UT6ZrGGYbSUHa/WVQ=;
        b=XgKmCdJPreB/9zwV8HOTy6RcX7i8KRGf95Abize1xmDr03huV3voLvd/xpUyuROChN
         ERszo8JHoGRiEjNkicdxak3pHSUrc2thTKVqs74avK6/tLk3Rq1sFAdzS3dPcFGxjZZJ
         YD9isXyk2chqMWhEcp/NvTzSiuvcCLJAkKFjVU/GUzi9yG1D4FsyjWGgE26F+7f2FaTv
         hiKAYrR+nkd2V80XTJGiEdgKOOvrh+IGaSRyNtW0bgymYYt9e9L+g9/0cmifnl7d0R+l
         pFDIIs18X/4Jo+51vC1XQ/vQi2nzMbgVqvmTDPizY8Z2UGwbWIkhNxVAMC0qLFptUSIg
         UIkQ==
X-Gm-Message-State: AFuF++mAB4SQwmafWBzlnOyC9YmIEdLQESJ6xTRJFzvVaaUn8mZs2j9h
	RcOksNg4rQ1V95/x5VxLeB298/gGeWo3UfvJSq8rbCwGA41Q3MLYxhZu
X-Gm-Gg: AR+sD13lqBLNrCfPuPuMFodJrJSh+VaiDe3RBARYpImW94VkDf40gTt4LZ/2fxCxDxn
	GtHx6DubzixGuoYMbB6dokAID6l6MlmmAxcykIEAJ59jMgIRvLws+Kms4GVnduz1ne/ps2fVdss
	jL7uIkpOXdf5RSaQ9VKIAgDEoLxzwSbEE2scFKqGm7TBqYczO3evzorz7Sm2wYVQIrmMWi8LsVT
	xcd4zWDC0/GWVCAr1xfY8AYzWYcw+F0CHjeAjbM1Hj/ZurYQbBgdv6XWKxth4phqzM8ZVdVngij
	G5WqZXHWti6+Y81bOH8QoWdziqZOCmIrqMSkLaP0Kc2hjVE8Hp0NERkB5+z867ARvJS9S3+RQr6
	WUs+or5T1bgbTjyIuEbgGICDkjVi5FHadKmO9uKJa48ltXZ/f9LbJfuALXxZH2cCAXjrRU9CsaT
	fBNRtYFh+KhRR/aN5zN/8adyo9wCHZ8W3V+tygWwtol0nrROHnE5/WQUZI3EaV4wMSSIZCg+tXS
	VeUFnL6HrsNgmqKtgG7m21n
X-Received: by 2002:a05:600c:8b5b:b0:49a:5b88:f551 with SMTP id 5b1f17b1804b1-49cdc429f0dmr27121445e9.6.1788189689334;
        Mon, 31 Aug 2026 08:21:29 -0700 (PDT)
Received: from unix.. (244.red-81-44-253.staticip.rima-tde.net. [81.44.253.244])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b963c3c0asm528166815e9.10.2026.08.31.08.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 08:21:20 -0700 (PDT)
From: =?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Iv=C3=A1n=20Ezequiel=20Rodriguez?= <ivanrwcm25@gmail.com>
Subject: [PATCH v1 1/2] block: brd: destroy xa on allocation failure
Date: Mon, 31 Aug 2026 12:20:43 -0300
Message-ID: <20260831152044.166353-2-ivanrwcm25@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831152044.166353-1-ivanrwcm25@gmail.com>
References: <20260831152044.166353-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xa_init() runs before blk_alloc_disk(); on error the path called
brd_free_device() without xa_destroy(), leaking the xarray state.

Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>
---
 drivers/block/brd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 00cc8122068f..c18262295c39 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -346,6 +346,7 @@ static int brd_alloc(int i)
 out_cleanup_disk:
 	put_disk(disk);
 out_free_dev:
+	xa_destroy(&brd->brd_pages);
 	brd_free_device(brd);
 	return err;
 }
-- 
2.43.0

