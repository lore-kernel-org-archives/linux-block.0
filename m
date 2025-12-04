Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E862FB97E
	for <linux-block@vger.kernel.org>; Thu,  4 Dec 2025 02:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764816504; cv=none; b=sfv8uXV6e6RfMklktPh/XxIJM9TtJQKM251JqUwc/n6N7u0EocMQFHXVmCId8FYk8qKvaCoVleNqOHmjiOBFM5M5wmfTtLh9TnjrxXSUTa+zp6Xn2ZPbbbFOtcaqSSWIa/qDYDl2AKT8BG06UmSwX0fGVSWjLStkZIHOhnVOod0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764816504; c=relaxed/simple;
	bh=JLIdNXPMejF737Jv1xzF5GicNRibkuRDb9iX4pmjoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UKQYnhzUD/KuwFTTGzVa4OzNw9B6wTyIhWaGWNm7KBjZyUkPedqBufo0EC27XcBSWBMhSBG5PxPdBNk1J7KeW11DyNm9fk+zYs5ThWT0dhtpkbppx6iLBja/nGqq9tHcjtaB6HPDnyM/0G21tog/0AoM11Nan9JcuOpyjtvODs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnTVzxer; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnTVzxer"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7d26a7e5639so507944b3a.1
        for <linux-block@vger.kernel.org>; Wed, 03 Dec 2025 18:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764816498; x=1765421298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=XnTVzxergD/1zjfx76F9BSZzo9o/r0VE4vDIgGpatGyKsylXlNTt8/JfEdgckLk/yr
         hkAFbZxasrhonowS2EDvdXciSVHsxS1pEeEoP8/jsN6c7EPCX8LgKfwHQRs00HoSy2lW
         l12VjGbzqTnuNwEfsX86Syi2dqwsBOwXG2OkPQ2C7m0Ym3ecytJMD5lRVQzeeZM6WiDF
         YZ3I4Jkqy2+DnLqyB2X1lej4eHSaRDqc1WxWgmdHns7VwFDY5nktnDDFdGLEaN3S2uln
         pQUl2mHUkCIasI1iUL6cJgi0HACsN38Yqbt/y36jBJ8IlOtC91rjigv9uWygK4qKoKyr
         nj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764816498; x=1765421298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=UVqPnjFnjG8LNYMFjj80B2LcUJKvXV74SE6XQ0APl+xKN4oFIHeWA+YawalCnRyEoY
         R2yUy84rYrO2RJ7RNB6ENyh7xatokBw9WxOq2nGx2M0TyE1EPehOmSSjXYVAek4AVY0d
         q9SoU97b2OUYdt01W9Kz75EjOtHWsRxl4BsUnzntDsyYgWq6w6C0cwMSF/vVi+4VEBmA
         UGGUerqY8WclZmb939khzpKq9N1a4YUj+NMwFbeWbrIaLNTahx6EC657X1zB1LvFqo3A
         7a1yKa/Sf1QefidTe0g4GCMs2R0bEsgs8Px/EgAoyfIQL7pJKl8M0dxAboHb/iZKH6Ol
         eUHg==
X-Gm-Message-State: AOJu0YyFfc5Fi26WljH3T1ZndE38EJ2ttjWjN3WPiY03lMhGVYR8riZs
	b59z19z1uUHQ/K1WYIFdH5GdEeER/dYuJmW7mpuRGX/7javz9d/vz9qq
X-Gm-Gg: ASbGncvmspGo8dTxiiNo6fcl3U60WsoVo3/H+cyqNlfGf5OV0AVqDCIfl3l/4R+8fPb
	DshWgIOH0yYAyRA8Cil4vTIQRXxT7nZoqVFHRwL9gG+WzisYQiy8pWnR4/gMsShXd8EvmtjxyAa
	0nYnVkZziOSD/dB9UR7s5LPZXoh22S+5zOS6/Rx48lbCxi63rGh33lBQgXwwAHwKT8M3PE1JhTw
	wAjeZqAJXUFo/Wl41r2bQjnEeT01fXhrkn8ZM4KJGJpytH40stz7L2Z/FDWNYpmJMlHYI+C+nwv
	cPzJiq244NkM/TNEYP9AhXvKOQFRx7kJcCpkWgQlka+5854BEPLArzUQFz6Uf+rB8LbsqkiwF08
	Z0UUy4yIvi0GUbYKj/fNz/FkAQpi+LDr8fd5gbNGpU+YuC8Y82UhfIeA48ES12yt67SdmeMtVMD
	T/mdP4MrwPdhNWwydJjX9tdrGH1A==
X-Google-Smtp-Source: AGHT+IEThN9cBQeL3cXuDOIc1+uCaHf9ep2wDNPFjuh/TeOr5B3FR/bA1QanG4XfS+l/fJbBKZDCrQ==
X-Received: by 2002:a05:7022:4595:b0:11d:f441:6c9b with SMTP id a92af1059eb24-11df4417192mr2091918c88.22.1764816497778;
        Wed, 03 Dec 2025 18:48:17 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm1838847c88.5.2025.12.03.18.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 18:48:17 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com,
	colyli@fnnas.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v5 1/3] bcache: fix improper use of bi_end_io
Date: Thu,  4 Dec 2025 10:47:46 +0800
Message-Id: <20251204024748.3052502-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251204024748.3052502-1-zhangshida@kylinos.cn>
References: <20251204024748.3052502-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Don't call bio->bi_end_io() directly. Use the bio_endio() helper
function instead, which handles completion more safely and uniformly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/md/bcache/request.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index af345dc6fde..82fdea7dea7 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1104,7 +1104,7 @@ static void detached_dev_end_io(struct bio *bio)
 	}
 
 	kfree(ddip);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
@@ -1121,7 +1121,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
 	if (!ddip) {
 		bio->bi_status = BLK_STS_RESOURCE;
-		bio->bi_end_io(bio);
+		bio_endio(bio);
 		return;
 	}
 
@@ -1136,7 +1136,7 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio,
 
 	if ((bio_op(bio) == REQ_OP_DISCARD) &&
 	    !bdev_max_discard_sectors(dc->bdev))
-		bio->bi_end_io(bio);
+		detached_dev_end_io(bio);
 	else
 		submit_bio_noacct(bio);
 }
-- 
2.34.1

