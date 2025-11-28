Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D6A2FE071
	for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 08:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764318811; cv=none; b=ISda0irsdPdfaDzRg2qJ7kxKcTDO4PRiZtKoH7VNcZIoLBSxi0OTMPziXcU+CsWy+oGdjCADYw6X+I92R9ppZOKRzR0qppGL7Znbcyl5ysieuougshISmU2f3Vz/906CYZctHfi5E0JB+H3zgEN5pEjmzxSzFEnqEZgwpYaayhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764318811; c=relaxed/simple;
	bh=TbxNohFMmSKnHTWH+mnyMfPFRdWdcWW/LS3/VsufZdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rzDSDThCc6LPGJJMyzQmJYYB1MbB6AYK22MFKZlzsYj29l05qql5T5Ctaf2m1EupW0Mo3ywmpjSxJiOLenKCecBjA6g7oXAyX3f21NAZtmPQ+EG/d+0JTBO0Y50HdDiN6+QZkeoZixhjGosV9VX9u2mYxScPUWqmnHpJslvui1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjmpIAyJ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjmpIAyJ"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-bdcae553883so1459164a12.0
        for <linux-block@vger.kernel.org>; Fri, 28 Nov 2025 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318808; x=1764923608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=AjmpIAyJf6JuyIrhAGiNid6XUAa4g4RrZwnHclHp/pVWuzH1VLVvZppOCoNcecZmRJ
         TsroiT53VAQOILzAKA/KT9wWusG74M9XHGbLDWt9nWP5Ig7woXGHCDNlIisELR81PsjM
         Gj1gSPdcetRXXQOL5NzyCj2+NiUSYFYbhosk8SNnwkX1mSVNFWcpBxxhZDts2K+D6eiy
         qBcXBeSo4t2Bb2D74uAI9RGN+1hwtAaIr89QCc9QNUnf5EF1ZsEJCCrBHz98uJ9cM/qA
         YaESTKuRxQR7U4wZ/SDPPSNnnICcG0SsaBX0ZTDgsGddCJFYqBHmxOsLbs3KuYOtZYGx
         rQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318808; x=1764923608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=ZfHrbAsCWGOpRXZRraCBB0CCqpaEIXvVoIhAH804Ge7PLleWrLQa6ou7h03Vl3dKvU
         jjEVUlaKdSC2b+SxxkzU5yEN9lrLsbda489aL3huUuYS7br19zoUyHwS+2oBwkq94Z25
         JAyDbZXIZFuNqs821nf99LW8kgevKDRfcJHzx0JRWG5mjDzl0Fgc9W9KrTyDbO27C7Lj
         BbmtYQdB0MsUza4/zuJviqVrtD+4UcbkLibXaVSG8/ncQGhpWImz5APXCA2LxiqUXM9a
         ZJKk6b/fcsn61GvZO6ohhC0oKeue5Z49BPzRkmxyNxuHHLmKTjXmN3sj3l4vRAGLgHPd
         kxMA==
X-Gm-Message-State: AOJu0YwaRy58LVFRSmxeICtAVjqGEkOAUu3MeKXqTKK5zKeAulRi2A8l
	1xKmRcF9I1cXRIJJGsBjT2/u6k86n7JtUjAVG7pocmYiqpk3mzzN6yP8
X-Gm-Gg: ASbGnct9JJ46vbSei4nzNkaFjR8R/IQKD+UtW4er4cj55T5LX+/VHV0Hscv6V/RhaT1
	t1wIGvwKf51Pp1LoS9m/BoEnh3jwSDDxGOqik3rTwXFllt1R3T2cxm/6WzIVg4Cs2mNIAzJgIUi
	6zI0zI1+EncCswIpaBG0q/tzv/SHvhGNfNcdeP+uzzMKu7d+3C3yGkDae009WQj91zxi3IYJwMY
	1lq6xQAxvTDYBtq6ewYqx32CGb9ycYmYCTy0u0lCfsTD/xKtSMhJ+Dt15o8YGC1lSLGCabl6agV
	BiOG6TBnH63L4JaJS/XPk3lkb1M985eyiVIWFgTtBJndeSuL1J9OinDUv0w96A/lWIv4Cli1WXY
	th+r6KGI2LjAbGkl0cwX0eTrF06gF7lCN+YZbBEgArYcyPgTD2zXUkHlox+rYQfxjVn8vzIs6Cy
	aahh4E5JTPIwGCrf04h+GoiCViFiTKrN9L5XuW
X-Google-Smtp-Source: AGHT+IHDsMToqUoj0PcNSA32TYDuHE8zhBuDir1BrYt+w5Y/wAZYCWlUzMNg1Dgih3T9wVkLcbd8Tg==
X-Received: by 2002:a05:693c:2488:b0:2a4:3593:6464 with SMTP id 5a478bee46e88-2a71929687fmr16240699eec.20.1764318807899;
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
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
Subject: [PATCH v2 10/12] zram: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:17 +0800
Message-Id: <20251128083219.2332407-11-zhangshida@kylinos.cn>
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

