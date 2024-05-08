Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262964CC0
	for <linux-block@vger.kernel.org>; Wed,  8 May 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154184; cv=none; b=ZFtmbBtRFcBSuJ3vlHqy6NKLufU1ElaXpR9NkvbNfBAXQoJ/6tYFyQN/0r0wm3xYhKv3D0nT+5k/jv5UTOOr9uVSXVjSwftTEH/AegijwWICmjKv908PcAEG/yqbItHGvM+NxC0eYCAswrc7hOoE7TF2nRAo4QwHVr0Dlpxi2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154184; c=relaxed/simple;
	bh=k8QWr7Ce151M14jHiuPdpQHPaGdK/slKGX2a8ui9kaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHM2BwYzYrVZVfnpDnuh+z1JEi5EqBi4elJ3tlbhuhm/5Woq+Y0/uphYKYqd3O0LfpSueZ45RiAGp1qk8rOcjK5HUZ7Ub2Xzm6QM7POIVcnbgfzyjn6moTLZsIjRd3qsMzuQgJPffuBpu3ErjCDXf0Ep2pHkxox6MlYLlFZi86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NLynwZUY; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NLynwZUY"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2b6208c88dcso381613a91.3
        for <linux-block@vger.kernel.org>; Wed, 08 May 2024 00:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715154182; x=1715758982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvvjJAe8l8tDTfecPvMLnwPB1eap8xtvETRDKvyj4SM=;
        b=NLynwZUYFJESBQ16y+8nyJagJoMLKS90eaX099lJBGiQygndJAxb6CBLLJi6k37smi
         CCOFZiBr4mtPnSAhxjVEai3Nw7zTYERJGWO40WGnyDn42p1sPqAh7Gc/1qn+NbXDglUF
         2fOmf5dnGroFENk+KcEGzW7VVhW+K7RJyVBgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154182; x=1715758982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvvjJAe8l8tDTfecPvMLnwPB1eap8xtvETRDKvyj4SM=;
        b=MxDwCLmMpdI6VZyiomh2rsGfbS17Acu9h9Vr0grhSS95KtigLNWv4mc3NIUt/GSXcr
         fgyI/sNb+m9eh7CGauD0knF4GzYy3NbWrsMJWGOzdOJt5OoWTmzXzhV67UUK8/KKSKW9
         kPPaBvAfpMsz+4TztbO1Smy3wG7AItqglCR6ZEDlMEowvls7KBHSL2hxXObYh36I06Cb
         04U/0MvFSA+ecYfBspF+CFvCDRqpX5ZDFB5xdTEENLfCvj73oG5obDgdcbH36Xb5rFXz
         EqvDRMTyIFa1f9doDI+RNKOZbWsbmzbnRBg7Za+kEpLQVlo1mFLTMOIEAU3MAe1cvxxU
         dFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdZ4KqD1sIKdryz78Giu73JVMhpsm1S2ZEZb0771V/iDeF5p6wczJmEbteT5U0/rA/Bt3MZkO0NynIr2bhlu9d0L9F3ff1rP2a4A8=
X-Gm-Message-State: AOJu0YzjhTz4Zc9ehJ7PA9p1KB+anrLwgz0aoXicdT4bcC/kvmQfhtWT
	B1Y4zfGE3v94VUrqmO//Nmb60bL1DleD29TziZjyTfL0Z7oajy8ry/DrETjCNg==
X-Google-Smtp-Source: AGHT+IGsT20V+REVmZfVALkjzCYeDrdJBAUngwmprLRShQjZLhtblQAF9Tf2N99ShaWbI2RxmWzVLA==
X-Received: by 2002:a17:90b:1046:b0:2a7:600e:ce0 with SMTP id 98e67ed59e1d1-2b616bfdb97mr1754458a91.42.1715154182204;
        Wed, 08 May 2024 00:43:02 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:ad4d:5f6c:6699:2da4])
        by smtp.gmail.com with ESMTPSA id l5-20020a17090aec0500b002b328adaa40sm780011pjy.17.2024.05.08.00.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:43:01 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 11/19] zram: extend comp_algorithm attr write handling
Date: Wed,  8 May 2024 16:42:04 +0900
Message-ID: <20240508074223.652784-12-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240508074223.652784-1-senozhatsky@chromium.org>
References: <20240508074223.652784-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously comp_algorithm device attr would accept only
algorithm name param, however in order to enabled comp
configuration we need to extend comp_algorithm_store()
with param=value support.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 6c36cd349431..bd8433363cbe 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1028,9 +1028,33 @@ static ssize_t comp_algorithm_store(struct device *dev,
 				    size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
+	char *args, *param, *val;
+	char *alg = NULL;
 	int ret;
 
-	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, buf);
+	args = skip_spaces(buf);
+	while (*args) {
+		args = next_arg(args, &param, &val);
+
+		/*
+		 * We need to support 'param' without value, which is an
+		 * old format for this attr (algorithm name only).
+		 */
+		if (!val || !*val) {
+			alg = param;
+			continue;
+		}
+
+		if (!strcmp(param, "algo")) {
+			alg = val;
+			continue;
+		}
+	}
+
+	if (!alg)
+		return -EINVAL;
+
+	ret = __comp_algorithm_store(zram, ZRAM_PRIMARY_COMP, alg);
 	return ret ? ret : len;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

