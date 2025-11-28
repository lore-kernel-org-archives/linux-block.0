Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109E22F7AAD
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318785; cv=none; b=gZnkdvqLu6XAHpRiz8LuNezXDnSmorZjO6+nuAn093Lsd4sUekmp7r+rt1iXBTsXcE+wojDK9RIWoD5SXIAPTgsTmor/3QWfbzMB8nFm4HHB0G9nrov1DpCn3Lo0DQA+uZ+4mO/1bT9IJRQwR1cCRjp+3OE9zOpMWcNEgCMyv0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318785; c=relaxed/simple;
	bh=+kdxszjTpaHcpdO+OsTg3+9Bb8a87RQlO+SGH8oGptU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0/nWypD9PwrMbQFqfcE5QGZ5+EHQzc9khlczyxGQpdjRXZmURjzQnM0z24+e/TdoGK82BvF6S8JLc9EEP5hD7mbIFfYRQEtAfeZoW+Jz7SAdtOuBY6/Z/k2qOFIUE4REpudtrwLFQxqKizvNc2nY2h3Tl6K0X1ImvZZus6ys0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhCDL1Ws; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhCDL1Ws"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso1389251b3a.2
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318783; x=1764923583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=;
        b=BhCDL1Wsgz2qKihch1wO4CLq72D8pMTuQKp7V3DyN38kesed6BOxzCgXNGMbwkE5fx
         aYxqxqmf7GGfGIDefKebcCUlo5c1TKq3JapQr6aLALpmpHtkxdsMkxrRerFmjjJt6Hid
         EB5IBxJ/uWXG3ataKDrGiAbmmtEbOw2Bp18k5STbhdzeCc0bjSGGyQb4Ss9AS6CRlofN
         6aHQLCbkg+YcFz/eOBdmk7eTmQ142LJrcBFPGIUzM77IipIigdR5sFpqPxHFv15kbyLS
         eYOxNGdub2N0DxI/+veH1eJhqjH7eq6kjqqT+Zx44xBisBVFERmoiIarMGe38OCHPZjQ
         Tb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318783; x=1764923583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WOTI9zrIzg7zm0suBs1FvPesu0SkZxT8M/7CVofybKk=;
        b=KIIURd67rLuGgiuW3rfr7oWI6SX2A14ypcUwA0OYoxNZlV23EUmcGNOmX4YXMG6oip
         LrqsBxfFNu4/zFkTZ04UHiWtiIhk4pjo22p9AJRrUWCBEzgNqFoz6QsWd9PNT/TgB3cF
         4t6EbaS4Yb7F2isU8ufMtNTQam7t5Y85ZcEuKTP9+yZlNnkeayNcfoaxfLBgQ5mOeSkt
         hAl5lg8CwzjooXgnppSJ5qK4vJgL/otQTcc2Jdh4VI7T46MKV+KIEJW4vs0KfhySO+xL
         Tah1vGZDq8aSXy2WMkyt366zLSDq7wXuJ/gYDKjQD0pPQ2Mq0Z0Uxjv1RwZ5b8MUqhFQ
         FY2g==
X-Gm-Message-State: AOJu0YyT1hxyGCa4nMmHDm83Q4LpDY3t/0IcsFDcemzEuiMPezqiaksL
	BwQ72OpcHShmtsrfhH+gKXzFWngphj2HbdjnEX9Zi2eR8gY0uvPW1IEA
X-Gm-Gg: ASbGncubLbots66Q1PchtHoSl+3eYiiaaHonV13ECoLQhhdI9DO8SaCC6v5dQyBUnvd
	TKhMY5J52yPKsmdNPiJSIg5PDmLc8LqtgnJkskBKmlu98igkHoZ08e+M3LyD/MGpPU1tdj1ZYPq
	wd027yS9w9N+BC2mKxbF0FpMlTVJb6U+9nPBGUOE1SUsLO3EVZ84wD65OCelL/gNNdjXBwUo87O
	wu5Megl/I+J4AWLwdBwaKe/UcgLJodMCacDdrI8iKqoewgxlXz5MRBrAv391ozInD7PIlkdY33A
	NfBbBjuLsNE0NMRDfUM90rsN+Hv46Uv4o42CNilrSZc+fd3BiX2903X73IkIK/2ug2Dsro3L5/6
	k4UO3ROU6iBsgG6WtDNGe3sL4CNTxoZXyXFkW3hnKozoGCTT4TCJCKxebZyOya8fNuxFmmYvdYc
	60Arh5HEJO5q87R2/3dT8Ta+Qymw==
X-Google-Smtp-Source: AGHT+IG9KZ7rWCO0ABhUceCtzlD+O/EyLZjlRlvHPaAHNjz6G3IYpmLI91Aw7ItyMwREv8ZXa06T1A==
X-Received: by 2002:a05:7022:671f:b0:119:e56b:91f2 with SMTP id a92af1059eb24-11c9d870411mr17435747c88.35.1764318783005;
        Fri, 28 Nov 2025 00:33:03 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:02 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 05/12] block: export bio_chain_and_submit
Date: Fri, 28 Nov 2025 16:32:12 +0800
Message-Id: <20251128083219.2332407-6-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Export the bio_chain_and_submit function to make it available as a
common utility. This will allow replacing repetitive bio chaining
patterns found in multiple locations throughout the codebase.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 2473a2c0d2f..6102e2577cb 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -371,6 +371,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

