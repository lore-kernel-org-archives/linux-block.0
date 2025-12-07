Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3302C11CE
	for <linux-block@vger.kernel.org>; Sun,  7 Dec 2025 12:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110114; cv=none; b=gI2/V7kevSHkmcxUqwOEPRCXbLTR55j/J1ewiT1HOH7YNxmCBj8t3N86m3hoGb0m7EwxhBRKMK8Wab4NpfuAfW8wH0vQsURKDx9jPXSdOMQ4zeOU1weRddxuXkJrRti5ICIqEjeBxf0AbXdCO+Gy0uLmo0vEAFPF+QLGbJ8zO1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110114; c=relaxed/simple;
	bh=54Xh/j2WhG2Ei4a1qEnIpkmDGonn8ZggrBoCMAcXO3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bQktSDH8G25FcelRs3zGtEqbUjYYaea/qP9q8Nks2DKZKetd0TCkfR+UhuEOV8TxH/CZvp/Q1UGGni7Y0SxuXGvuIF17Sa8cIECXXRez30uHFJP0IzKU+gyTVOogyhfIef5nQfPPc9EFecOmCzYFji2uJ1R+imlqlKLpgiMJrQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIps9MXg; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIps9MXg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297ef378069so31099225ad.3
        for <linux-block@vger.kernel.org>; Sun, 07 Dec 2025 04:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765110112; x=1765714912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/7vzy1FUoDsUfjpWUzueUpIzsuHBaOImPA4L+Mj+ZI=;
        b=lIps9MXgArmN91wavXUc49twuZy+fZdUvCItADOejMyZFcw7TxXGTVflAC0WSqz8yK
         K46EEucCKjjKQgXMDkX8wFF63Flc3R3ycovlyUIe22SSr6NrkjwFEV0JgMxzZ3umKlwp
         eyHn59khjfHUiY3+axufKMjbF0wl4fG/ZCsO0HW9THHMEYUJNEgiPJ8cTgiYglnQ+Xnw
         XREz95pgqYBZ5TSeQddJOvdqfpvKMRjN5sK8exIz0P3RBG60iI+K9Q4TREmlU+imLGQU
         +4OwGhDRhAPQ6uPKdCXeDM47Gmp8cius5zfZdEdGUNYhGikxV08seuV5GRvssIDLS3dX
         V4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765110112; x=1765714912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i/7vzy1FUoDsUfjpWUzueUpIzsuHBaOImPA4L+Mj+ZI=;
        b=gaTUmJL8GlFLMVopLcHIrcET1oQ0qV3TT6pYTMjHDUp+xijr85x01EIeUaf0KS3W8H
         bJ5BOFHT04wQVoJKbg3NxF7gqfXke42b+J+tcJ8L11qp/HT0UZxb1mL9zYlOOfdU0P69
         Pvvxwv2OzuTvZEgp9mFJfPybw+YMXX4k7GMBxMuq5yIhQtmL/C9jgwOaKg20UCdP80Th
         hItjP8BQ9XFxDsBlyY8gQb7HfMft8xUXgaEXwh9C70toiTP9sRcqoJPymFSYsLC19nGJ
         gSpntWkSmFAs1/zQtWRZpgSVslfTjAesWcXKLyVYYZBkxSxPJKH62rkxZdHGxxcoscys
         aCxg==
X-Gm-Message-State: AOJu0YwjqwHek55T0gaDcrqrus/4UvQYdqh6GfFpCrrLAyyIebod77hT
	q/14zrAXDrT4uXAqS8l2zeJg5JjLBJGUVj740FLj7K5cfl3j+EoO6Bbr
X-Gm-Gg: ASbGncsB4XbNE+btvKthyGppmAOrUR33X6+isHfuiCi9VyO3FhJDaQVmBy1jV/WgIOj
	o4uOOFTWeG11IVenj41e17Iu4iFVCbUMugcqaZQUlL/f2EtY2f/zxR4FSCELJo++Jahm765eIV/
	jFC3zO2Tr+JWMvl6eN+D5F018w3eW2XMPI6G6EcI1D866i6cir6qGhBW74W7XPGNHJ7JvXV08h4
	/H99ECgukzEK3uAno9D6T1M/YzavVrDi8Q45OYXnh6mr2JD33ujJQqmwcT3OPnfjGiCQynqSdN+
	eRAFgO9naptI2qJe/6bmVDhw3WmpQzajfVgycMjNKB5U6zn8X3N7u05dflvsIKyvSZxaUJfYRXo
	jkiI5Fu/zrgWZCvQ9P+6/KeyOrDoh/Z9iDAGGkxxqBZG6zyKTKEj++3NrEhwT8tTDpVfuIO4k7k
	PVaBFte4bpl94OGH2whYBxYSaT8w==
X-Google-Smtp-Source: AGHT+IFnUgbCbzWKaHX3DgU1C71Wvw3pYFn2ma/gYdiJLLhx9hJu0uDqdIfBQDxlroW91cHZjfSAcw==
X-Received: by 2002:a05:7022:21d:b0:11b:9d52:9102 with SMTP id a92af1059eb24-11e0315b334mr3249541c88.6.1765110111933;
        Sun, 07 Dec 2025 04:21:51 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df76e2f3csm38598822c88.5.2025.12.07.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 04:21:51 -0800 (PST)
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
	starzhangzsd@gmail.com,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 1/3] bcache: fix improper use of bi_end_io
Date: Sun,  7 Dec 2025 20:21:24 +0800
Message-Id: <20251207122126.3518192-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251207122126.3518192-1-zhangshida@kylinos.cn>
References: <20251207122126.3518192-1-zhangshida@kylinos.cn>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

