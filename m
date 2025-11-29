Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2128727C
	for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764406935; cv=none; b=WCb/cgDDxVyJJxBTzXa3tG7KNOFWLqNq8MrI+uxoAUCiyQc+OCAHmN/6rLc6CNyLeRtMgxjjo3rc5dVPZFlAO+tKNUFSt1M+6RZTBMta8mXCacA8zBLLDoTnfd51nGcWqf4YK49FWxqDSof5+axKLbOg1q+GeExKl2jy0M4nVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764406935; c=relaxed/simple;
	bh=TbxNohFMmSKnHTWH+mnyMfPFRdWdcWW/LS3/VsufZdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ER1tGsVbbMoSxa/nzLxdPQBW5rzdbVsH2knnpmURwjbfPuoXSR1flbQxDBW/3yl86mW9ApXg4rxvK3Mrfca9kDCRiCERBcAYgR4MgMA58Js9ul+7MVzXZ8VxDP07SmJLRTPcE6mcK2BUKT7xR6ruXnYaAjmEPdN9CKikS3+J2Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abasbWaq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abasbWaq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc8ceb76c04so1731987a12.1
        for <linux-block@vger.kernel.org>; Sat, 29 Nov 2025 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764406933; x=1765011733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=abasbWaqd2EQERmVlO4+ix+ajwq4zsnMGSqN0AiBTP/gJ07Tfm06jAFcO97v9VmLvq
         2zub/alv8m+QU99JxygnzsSvlBqLcnvPzmaEEVtofoaQFB3jwxu6Ll3W2IXlWVopXnQc
         Pn3EV3vbwgxxtRqMiQpaDA3dR6TwFtmjPdyui0q2WWwkiLg6cP3j6K7nlQzGzgaejRoI
         aNvzNqaO3kk3ZUIOnUE0htZAq3vokOzxgl6U7LuI9oSKoXvAC78ng7k6uIANfEekogbq
         W4DIW8SXZWtA6HvnzHQiJS7GejvH99MZ9VGNpqiKqAadXcnQN6NXFuhC3Tgz0BKKCS9b
         2x0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764406933; x=1765011733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=lujp9MCPpzFLY/kKdEiQd+UNpJSu/JB9GNUFpDZq+UtNzSSKDCRiA43DO9riWu+0xz
         FNICiz9piCNEq7xP8ZMCy6ZYRKFtJPpEdFTlfYeG8be2SV3piUWuEtgJ4K2HXQeyceAz
         VtJU9E1gHsUkNZpE6AB9QFgu6W4QGu86nW0FQfgnHTaxCFm6Y6PZVqP2i1T5Y3FEqNTN
         aXv9hTSjSg78xzo4SPo1A1iATrGO0uTKf5puLfGuHSwr8dE/LCWqMv1yk8roWGR3p+ZP
         IpTdt+Hrpn+aS8MQspYnTgDmXvHwYnQi5rN8cfh/nv16+RnLQs1cuhYjxdIZmkDCd4RH
         JTnw==
X-Gm-Message-State: AOJu0YyBD0NitmWvRxB1xfHUcS0Wy79vuDOFlG+jhz/G6yCS4SfS3L9y
	RO02vNeFYh9cUuSRLpGhSpM5Yq6DnvBka1OzpbqJe3oFb4UypveXMU+b
X-Gm-Gg: ASbGncsu7HThVDM6ui2ScYnGBvtly1mOke1cOSMtdynRS7ibdB+kMegvpa4iD+xzXwd
	VAeIxpSPCAbE/pI/2xssyqi1+q9yB35tj7y3qIR0NSpK8to7AkwOvHsW6+mwCIJ26Dg83D6Ulxh
	B002fmr9g6LTRdinWUChy3PEsKwy8xITWPbRMBYzIWibBFWWrPltowU78jVKzMD6NOxdai+PTSc
	PzsS7HhjPTIXZxcOts9B5qcLT0G/Fa10TNxPI+IihdhPvZLDMKK/CzygkMLKio95tXV1fGo+XTh
	yvmxg/vO+Lo//kfFdUxQ6HtUe5j7wPj1nilpNADAZV6IDYwTsQN8840SXEOze50hX3JjElGZpGR
	BynbnTIiGeDqydqR97GAS+ZPPVt5nG209ShfIi5kQ73kH5/lgmlbYWBLwEqFx9+J0L/KwKrNVTg
	26JGHY48l1EjQkHinzVl3k0rt8TA==
X-Google-Smtp-Source: AGHT+IFlPlVYDb7yoZVR+mp1/g2QkqJgugDSidMl3HlYfTA53/2piBoQC1SYt0i5BZxdW5Dqskhrig==
X-Received: by 2002:a05:7022:3c84:b0:11b:9bbe:2aac with SMTP id a92af1059eb24-11c9d863a7dmr14635218c88.40.1764406932641;
        Sat, 29 Nov 2025 01:02:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcae73bedsm28114394c88.0.2025.11.29.01.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:02:12 -0800 (PST)
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
Subject: [PATCH v3 8/9] zram: Replace the repetitive bio chaining code patterns
Date: Sat, 29 Nov 2025 17:01:21 +0800
Message-Id: <20251129090122.2457896-9-zhangshida@kylinos.cn>
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

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a4307465753..084de60ebaf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -730,8 +730,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-	bio_chain(bio, parent);
-	submit_bio(bio);
+	bio_chain_and_submit(bio, parent);
 }
 
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-- 
2.34.1

