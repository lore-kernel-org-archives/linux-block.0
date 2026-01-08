Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94E42A81F
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 09:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767864020; cv=none; b=jnc7FrDcKeJW8/mpc6Ntygw9PFGMbBnbqkwCU8XzY+OPQRBA4A1/t0o9J83d5ZruaOCVKaJOsvpVZbJTxSca5qjmqFOCZrCKQP7/F0YA34xJUySFhVEXLpdPj8qJD/mfgp/Oox4cCwrqgDR0jA3KLvEtxQhQUOvc7pKzIx8qfpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767864020; c=relaxed/simple;
	bh=flmggBNU2hAB08i914C/deY3qRX3vSvGh6Sj4w2rzFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsy94ng/PlTepeRuykHFkjilDkVuQXLyjvXA1ihIZ1cfmqCXnuredAIQiTo/8GTsnj0ALx6450aUy8PrudL+L7DtXdTXHnyYRHlCVM8HGW3jnpjCiTQnzL3bUlQ9VboWVr6jQJiiszfZwEBysUpFB6qxzdXXGoi+08zuAQ22P+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xz9NOVdi; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xz9NOVdi"
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-88a279996f2so691546d6.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 01:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767863997; x=1768468797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRGJRe3q+wC2wVKVj2Ep1iCX4dbPSkat0FX8kDkrXQw=;
        b=Xz9NOVdio8N5vlCIeelxt/+gpPfk4GskIpVNJI8ic8pEETiJyupVj9IT4vpWoe8Nim
         VrqcC01Yo9lc9Hn1lArx5LZ4Mt68i4aL4TqOD+mskl/fQ99Fc7YUINONG14NzHlwKaSM
         nxzI02XE6VDVgdg8wqU39NFNcCWzLkU+Xew7UAyvg2ftU3BElXuk0SAgJJ9djd7FPJsT
         Ac5o+mVU0pbpBvLbq173WZJQd9jR0VipcWnlntNLR3yTR8C3smt9oRbiJ2j6cEiMJ3DA
         rrnDHI50Y7K2opkrik0Tm/ttaanXU0Sk9UIqzu790N1aKC76pSBo74x+j5w3tzz/8WMC
         WHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767863997; x=1768468797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MRGJRe3q+wC2wVKVj2Ep1iCX4dbPSkat0FX8kDkrXQw=;
        b=fRuWXdT7RXEOS2oyTM7/dx8kWWCjr4NGI2f96du97jlBRmPQU+yxBbXA96ays9Z7eF
         CK5zCT707AS7WyPakRSFdi2edD3ER+Zj+Rv2VZpmjJqrb7/fjPnL8c+CGGCpp9uyK45R
         2lwQrd3BmFW+OPYs3kgfBZGhSrmr2i9+S5ZRb0gxrNWtMwtgJ0mxuvhqbu4YXwZkhtwW
         osc+AbQ4cm/sno92dtHWgC5eHp7S2KKnEArfuB0YmHydaddRxXh7rsNINknbwUzmY9Vs
         MT6wBGE008WsGU7MBr7OMiVI561Acgqzcj3JuoMFWwvRZS0pPA0RvwezKabQjVmOQ4c9
         Pg9g==
X-Gm-Message-State: AOJu0Yxmn71zqE/MAGYICrL8csszoZc5wVK1sGjjBrpKCNvzaZ6+/lqz
	QR5kxr+nHOouDa20/eCT5sOaoyWluEQv2/g1HHiAFsA6dBr1kQv39n2WPPeET9gK/7JbA/SrohL
	2GeAlrsrh/LyeZ8QjFy4uXCMCaSlaP5Yw2WPUUVzQtOjw1OIMWDZg
X-Gm-Gg: AY/fxX6PfjtrwBUtDxB5rDdAgXBijdPG+Ds3B93KC6e6hP+rEuo/OCh1MPMdm9DyTb3
	d/aWbk3a7LQANMOanOBLpc43BoLNK/Wndz/fuc/8RL4Cc+hPReHlRcjhrMu9vFYOPKibRxeYLRe
	oC3eu6NWJpIt5bJxle8YJxwia4fS6GtBHcb+7VEcMSckdgtXVgAckVvCLC+58COTfDPPEl1u+MV
	gz5HX06eemUwJVOLEXsVKUECK1E9Pxsh6l9GC7fwKawY+Z1gFclkAvweq/Wz/wN2q6z+LWNgD8J
	VjBzICGOO2WoTsnFzyxnIbCOKwz2oeXGLKy8p+7cwLAeA9gYI9oHZCwziXrlNKXPLd7Q2Gz1qC5
	8VJI7BZKzWAjhf/R3NpcqnXupLpk=
X-Google-Smtp-Source: AGHT+IFZEqHTD1jRd6BPZWZ92EgtYzPKA4eYdLHsiPbwryg/dB7+Hp2FHML2KxtaKefC9IyFoEQAGq0IYNyQ
X-Received: by 2002:a05:6214:19c6:b0:890:6330:97b9 with SMTP id 6a1803df08f44-89084184f5dmr61349676d6.2.1767863997313;
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-890770a55bcsm9018466d6.10.2026.01.08.01.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 01:19:57 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C6236342243;
	Thu,  8 Jan 2026 02:19:55 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C0460E42F2C; Thu,  8 Jan 2026 02:19:55 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 05/19] ublk: split out ublk_copy_user_bvec() helper
Date: Thu,  8 Jan 2026 02:19:33 -0700
Message-ID: <20260108091948.1099139-6-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260108091948.1099139-1-csander@purestorage.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor a helper function ublk_copy_user_bvec() out of
ublk_copy_user_pages(). It will be used for copying integrity data too.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 52 +++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7310d8761d2b..22e82bbf50ce 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1005,10 +1005,39 @@ static const struct block_device_operations ub_fops = {
 	.open =		ublk_open,
 	.free_disk =	ublk_free_disk,
 	.report_zones =	ublk_report_zones,
 };
 
+static bool ublk_copy_user_bvec(const struct bio_vec *bv, unsigned *offset,
+				struct iov_iter *uiter, int dir, size_t *done)
+{
+	unsigned len;
+	void *bv_buf;
+	size_t copied;
+
+	if (*offset >= bv->bv_len) {
+		*offset -= bv->bv_len;
+		return true;
+	}
+
+	len = bv->bv_len - *offset;
+	bv_buf = kmap_local_page(bv->bv_page) + bv->bv_offset + *offset;
+	if (dir == ITER_DEST)
+		copied = copy_to_iter(bv_buf, len, uiter);
+	else
+		copied = copy_from_iter(bv_buf, len, uiter);
+
+	kunmap_local(bv_buf);
+
+	*done += copied;
+	if (copied < len)
+		return false;
+
+	*offset = 0;
+	return true;
+}
+
 /*
  * Copy data between request pages and io_iter, and 'offset'
  * is the start point of linear offset of request.
  */
 static size_t ublk_copy_user_pages(const struct request *req,
@@ -1017,33 +1046,12 @@ static size_t ublk_copy_user_pages(const struct request *req,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	size_t done = 0;
 
 	rq_for_each_segment(bv, req, iter) {
-		unsigned len;
-		void *bv_buf;
-		size_t copied;
-
-		if (offset >= bv.bv_len) {
-			offset -= bv.bv_len;
-			continue;
-		}
-
-		len = bv.bv_len - offset;
-		bv_buf = kmap_local_page(bv.bv_page) + bv.bv_offset + offset;
-		if (dir == ITER_DEST)
-			copied = copy_to_iter(bv_buf, len, uiter);
-		else
-			copied = copy_from_iter(bv_buf, len, uiter);
-
-		kunmap_local(bv_buf);
-
-		done += copied;
-		if (copied < len)
+		if (!ublk_copy_user_bvec(&bv, &offset, uiter, dir, &done))
 			break;
-
-		offset = 0;
 	}
 	return done;
 }
 
 static inline bool ublk_need_map_req(const struct request *req)
-- 
2.45.2

