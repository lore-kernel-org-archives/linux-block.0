Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01862277818
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713097; cv=none; b=pq6sraeevXQD/idMmljfcuBAZ8+EzDkYlejGnSpr1igNygouCrxoW1oB7HUP9Vv2WiHphrUK6DXYVPnVQ4ZKqn3s0Q7BmPsHGQb1rGyUIRDC+jAfEynEwXKOqKwyr6xxQbeRr88AxJgUVSdxMT4dCNekX7Zw6D77h2+ErtaSHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713097; c=relaxed/simple;
	bh=ERpHvRnw+l3wstR+WAIvwtnoTvXWleFvGGT+ROO3fSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INm0wcTTC4syt//xHGHMNzrhGmlGvT6yRhzmZBQnPWV2lvjUA2lJsvm4RSCqWEq/IPfoIJmwEpJ3AshUpSN8tTFD1J2c+5ZMLSVIHN0E33CCwCPfo/jWb9hvPEWpIx5JDrMNMH4D2Qn24Xew5/9trEKAkiv8YeuS+65U4ETDoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWk7DRuW; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWk7DRuW"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so1555982b3a.1
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713095; x=1764317895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=mWk7DRuWqfJmo5GZxya3mRbNRQlRIZ07jM8fCQ1fxXLsUubL336YGi5xWzoXb78D3I
         11SVKyjJtCvje11D9kwVdXDFGyjZg4iz/xEmFIDBrKQiqBBBINoxfVlkmesijLZ/+oQ6
         13RFzP3b5D6NgaKDA3UxqNHOS1oOjpFkivlXz9H81K3ifPZYoKaLyP0ET8/FSHs2DwyA
         Ym4+rcWjvXTevpJmVRSSCyrrPEptEFS5tL/LKZGpCUDV+WSwxSSicOljfZuCFPLNJqxD
         Snq+ZR1bgCMkuzmuNTiuznqmzzIK8Hak527bMyYGW42z2ZIaVlrgUz7u0De3yW9YK8NG
         Gd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713095; x=1764317895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=IGKoOx90He/3P3YoSw9vCBRDYJzJGfGyU9bqjTUqvApBVP1NMSv1mmQ3xG6X6qyKEw
         iffV/ig05T4JsjymJujZJSteunxbkAakakegKsa9100Hdkat7iEmRTICQUuXb6xb6rSf
         o17H1JOhN78bRqtQEO7n2kG2TvMbSDvzQeK3cAhAxmvwm62nWghd3QpRFjKG1iuq8S0M
         4WVF5OL4qFMFpISC6bIqZifXiknlauhyoZ9MkvzHjK1xAj4szahFJj87mDYJt2OQrUR9
         poTHmaFBbcYM/BOSuldvyvJBnmuaNvBbiOb+lPkAhZxDsbUE4T31txuJhWN7HO3P7Au3
         Iocw==
X-Gm-Message-State: AOJu0YxweVwYTSeJxgi4o+eQd4GQtot+tRPSvNavn67VBiUc5F1Z1eYd
	/73+DhISvxp8XDYx5EL2s+LYDFGJUHIgR0ibV3de3Quv68WKOR3DvWkL
X-Gm-Gg: ASbGncuDJyCPJDoTF/Ll2hgLa76NEuBrCiCgcTfjvlG/sw94vswfQ1GamlBkDx3EtVE
	Fil8lcxiGxkbM67b/VK7uP/a9L76BME1dErtxBeZ+ucpDSzBwqqEqkmHmzyGsXXD06dqXnYqcKh
	VGsNh/d/spEMXdk0tlf3BdpJ7+McSeuufGavlnl5yX8hh9nK86ars0lrpRggFcLj9QPbQ2Zgdco
	QdIvwLw0xAM7mSy7Af6B9XzH046vk4svZtBaQDhKbxbvjesL6Gsgest1WejkyEPKGHuqXS4MDsa
	K1iunGMeWJ71zb9pGw4ZJkSW3F9GxNBVz4tnnX/9RMBfwP9bF1ztqz9wLaEqhYhL+n44VSugUeQ
	iixBVytzhyzT02JPVuBw8awbz7OPjJFMetYDC7uUOYLT8rITz10u4u/++hfV8vXXfAVCsnTP3MJ
	DsgeDLlvIpXQTNlq+GqQYRrKUNUw==
X-Google-Smtp-Source: AGHT+IEHu/E6NqM3wgnO0PzNJHfm7ylIJ91XqRa53EvuqqhyyBcUb7YMg890bib+mDDMVjekZVw8IQ==
X-Received: by 2002:a05:7022:4419:b0:119:e569:f25f with SMTP id a92af1059eb24-11c9d70b0d1mr568161c88.8.1763713095153;
        Fri, 21 Nov 2025 00:18:15 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:14 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 3/9] gfs2: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:42 +0800
Message-Id: <20251121081748.1443507-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..c8c48593449 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(new, prev);
-	submit_bio(prev);
+	bio_chain_and_submit(prev, new);	
 	return new;
 }
 
-- 
2.34.1

