Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0A6275864
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406902; cv=none; b=G+2XTT+IWCdQK9jiGq6EP8EwnxghAdljQIoZKSfh+lNZTlr+wklEZ6t+5wQD1d8lCmklnTiJw5yMCL/2aGDCrLtk3IcNFH5d/ouG/xA25LI8W3WDIwm2Me/bYLrLllwb7P018FuusO7qz22TRzyJbtqSmu5RypCveeAiEClIoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406902; c=relaxed/simple;
	bh=JLIdNXPMejF737Jv1xzF5GicNRibkuRDb9iX4pmjoI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EboZp8lCOqUSw5VTqMHEO77u9lA+mIHjih6QuILcCcWvk6REbwqVGl+/F+a/ArCFOnXeRO3p/HphkXSyGNV+Z0WxNOT3VUfNGi3VoPiKGv3/nfiUXrQ1w8+fUg7LuQrEheTs+QH+dYVZ5zym0owWbAEHrnV7BIW16bZJvJ6O3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRn9SGir; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRn9SGir"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7ade456b6abso2091433b3a.3
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406900; x=1765011700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=KRn9SGir2pBgh1mKiywJ7/hOt0zGejR1vm2MBrEsl9f98GNlgZ/GLGwsccVj/GsjQX
         WJaVuzCpvoMb/UJx1OOcLfeoU1A/jDTVXGHxrowGhucL/qEMCFP1gcKC54LawCmjQwvH
         4LehKy4Y1P+381T+jI5VC/xbtgUkSPJ8vWy2Ve0ciJcUgnMJA+TeWj72zRDM22mSCA3+
         HaVLwYO7KEArcs+UnmlxLk2MfYaOC13SfWk+mkQ4qx3hXXJpFEIUY1uGw5HMKKQv2vIJ
         hlgUAzJiWWPKKU6SZX/HM3Tc2Mts55PI6bwy4Ie6e3qKFW36wyCvXBwAwa2vzNj5MqbY
         FzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406900; x=1765011700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3B+NwUppxNtx5dO3GeNOAlGv3QVGc2Q+cteUdMRhiTw=;
        b=X0yvvQ9aR4BssApFE5A8Hnxqh+P44sH+ZZNcSWCuRdHKUsJDmjVQ+iptEOL2KP5/8R
         w4ozDVYeWAIIHztz0d9GqKlRcgv4F99N1ZnK6Ww6hEeCNjGJV55yqoBzNpl1E9BBAIlX
         b6EUQ+N4N2Ym7mj+19IE1KBYXqt8RoqYRWU5SPlWEdHlFsy1cW9wZM76ye4um/xVn4Km
         rh1FeFjqXj1TEPZ5Dlst9M2qMAHxrZO9BWjL88BYqBZw1yM9wD5a0gdtJ9zDIc5ERCu7
         EFsZNPhMiN4o5eQFquf50RBwTD48FxA+NaEqrS2eAIhmVZgWAiv6Lm4BxN1mn5h7YLSc
         t6KA==
X-Gm-Message-State: AOJu0YwgoH0RpCJahFRiPqX5ct26QDKcm3GeF6O7EHCFWfIF8Zc+md+c
	Mzie3CdnQBXVqUDJwr5DYL84EFB1wIqsbsnLvtppPmwXNGktT+bkGqZ9
X-Gm-Gg: ASbGncvdVwveyjBM24DJzm4C7sJEV3v3AU5cnp4pDeB6p0Wr3IqoozS1hK9tlw0G9lF
	h+S2dvnZtNjLcj08PEYrbD8AfroQr3Fp+Pd4EL8HghGLKS98LxA6nbRCVnZtSSO6mm4QSecbyI4
	l9nyPB83eVrJRim+5/n+lXv9TIorv7bPCX/iS9D7kkVZZ2XglhlgHsjqbGerOuGt1TaaFc1mhLE
	ILu2RZLGG7/5tunjzwZaytRfrtZ45w9T2D2UGhCtrEqa0cHmEkQLChRKUS75V4zdzac4l20eLg3
	9+v74WlJSeLyibXqQwdFnA6/vCm/IzG5/GJlEfsZp66c4vj4j+ra2WXK+vcJ7YrA+hwBJMGIjUh
	XJn+lkMnjrY6mok8a/0LCzmqY41tE1JEr9WrBdqZGzU+cB4kE1SVusY3OLE2VwTyUFG5y4cQQ3i
	DD16WdnN3ZfKPbOlcwenbbEth2oBVsVd9YZI2N
X-Google-Smtp-Source: AGHT+IF9fpUjxnsoJ856uo76C4AbEbv+isvtq3QMxPEeI8s0lui+ms4Diwary4B5eKv1gtl0O4hKMQ==
X-Received: by 2002:a05:7022:ec0d:b0:11b:9386:825b with SMTP id a92af1059eb24-11dc87b150cmr7316305c88.48.1764406900072;
        Sat, 29 Nov 2025 01:01:40 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:01:39 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	agruenba@redhat.com,
	ming.lei@redhat.com,
	hsiangkao@linux.alibaba.com,
	csander@purestorage.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v3 1/9] md: bcache: fix improper use of bi_end_io
Date: Sat, 29 Nov 2025 17:01:14 +0800
Message-Id: <20251129090122.2457896-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251129090122.2457896-1-zhangshida@kylinos.cn>
References: <20251129090122.2457896-1-zhangshida@kylinos.cn>
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

