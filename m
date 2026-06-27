Received: from mail-pj1-f97.google.com (mail-pj1-f97.google.com [209.85.216.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E802375F81
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 05:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538970; cv=none; b=f3GwCPE3lqP2IrrSwlfREkpjy7+h+MKAsIDzSr8AP9J5jA3kRYRN9SKbAvevD2xIPfoABMdb0iMK/fiuQYeq/LRW11x43OLhS1vyz1prYD9dxA8Vmkxgtlcgrcml1j178NS5C9ON7lqieZZLBNVrdrMvBgpyFYNxMiHLgSFQINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538970; c=relaxed/simple;
	bh=9h7ZEz78Y6ScMBC88C8RHAAfRQ3ckL8zd/zOxP8SyRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yk66bKG+h6vGfoqmiZxxZnXUCBkGxBs5D2QwgRTJCDGSZXuv7sqZSODaFsSZRTjXifv3p6Lf6cpoigFoL9sgapep0fmQWDnP4DYzZX8rceIqCKS06SaiTywVdxkXCEfoPhvTYS1LiNDzVAnSwDOebuBNj94PO7YA4EVMRfxEgXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KHBEvlsj; arc=none smtp.client-ip=209.85.216.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KHBEvlsj"
Received: by mail-pj1-f97.google.com with SMTP id 98e67ed59e1d1-37c5dabff14so123423a91.0
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538968; x=1783143768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hJetzVCmipfxkIYaKGKmSSwqDl0tCRIuzU++fp89zak=;
        b=KHBEvlsj0AlvZ3tbCDrQwsZVc7TatkU9GOkSwpfGbO6ZlT7v47ERnBptLAwtNjVMkC
         FloXWLYQ5bZYXN4gT0GojAmmpnsCSj1JoagXyfDPT3NWx7yq5Yp+T7UARxJqe/PL5ZqK
         5cQEjxpvCo5ny9jhyMTfTGmLyUQwsgEeL7w8EYXIIYRt/FA0E2K1n46ZcqGqoqBJXZRI
         PebI0CRJQ0f7JXr7s2ZF9lUnsQkhhY+x2gmBaJ/HcQf0Z1CO54ldWHHxzeJs0SrQ5Ype
         LHXchCqaeS2w+gCrrYDXFmfDK+IeAjBKVUnJtPm0fJ3qD3LTgFSiEjIVJhYvJWDnAP/g
         esXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538968; x=1783143768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hJetzVCmipfxkIYaKGKmSSwqDl0tCRIuzU++fp89zak=;
        b=lafn7/FuaNtUJypKKpy+D9vX5Wk98IE16xklmQxyEWSx2iqpocB3rs/Po2zR8zvUch
         sSnUQE5I0pntKz9N5/CjFcrx+b1ptLbApzluKGQrwTiXMrWQU8VV8XQXXJxLmOIybmG/
         ZZCIcGb0PJ2oM/QjeGSmzg99XKpKzVktcb+T2RhTWSSzEHSgQfJwgHHBrKdUmQu+dg0W
         vLkmo7WlmWxeeRbw3ghZL0sfmxJ9K50EXubg9QPNqrUK19MHzrncfZSUZnA20wm2F6vN
         8xWc4G8oemRvovkiDjqUTvrcJ5SK0TW/PuINS6FdBZV7rQ9Is7o8nsYj+vZlscjU08Q6
         0TEQ==
X-Forwarded-Encrypted: i=1; AHgh+RojYVLFeG9/FsgD5auEyppDUFw+I4fwjt/0XQ1AG6D6aLMIdasImdo9MSBBG3zzq3Q509l6qecm9sKfxA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gU6SCLCw3JXO13EFQo90T9xImPlqs0jQqURSO1pOZ6JtMk04
	DNQ+wVZ50IjmvrGijpj8IfA27/4ounG0F+e3pxkawyDmb3ZvjRbLb023wDT2IjD0dQY5lujZsT4
	LZ1NQlgV1hgK5jMTGOphfA+OxD2MX24FNPbblHPOAedNOQcP7Kme2
X-Gm-Gg: AfdE7ckMDUYjhHTgBniWsxlM9bejDmtSZ7PMvldE904wYM6LqNMqkbm3SH6ZH3F4113
	733zOTDPLS+uhIhlUo1r7vX8LaHMR5gNXjOrw0f74hLhZ9q4w4iAxXz8mbUCyCftrZ7i+w3oY0H
	rY8ud818thh5pkcR4TkRkgRSuBGqs9nqBntK7yn0BRvYIyGl5gc8xbMzWKQL+qEYMaP/WLMqYky
	prtPaX24ZD11zOyG/CN+4aEpAtzq2dPY5ck+rIm6yS8IfLR8AelUly9W4iGtBIxb+LkMbn774eZ
	vBh4tITMuQxLpS4Gk+U96LM8DWiJrjH17R1ggn11sqWPI2c5specSpMxW6HhV9YGUC2XKSndSh5
	qlOtrxzYCoRA8JcXp/SpRN2X88E7J
X-Received: by 2002:a17:90b:53c3:b0:36b:9231:9718 with SMTP id 98e67ed59e1d1-37dfa2c9951mr5148619a91.6.1782538967568;
        Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37df39562besm848289a91.1.2026.06.26.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E8FAD402B5;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id E6AE6E40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 4/5] t10-pi: use bio_integrity_intervals() helper
Date: Fri, 26 Jun 2026 23:42:19 -0600
Message-ID: <20260627054220.2174166-5-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use bio_integrity_intervals() to convert blk_rq_pos(rq) to integrity
intervals to reduce code duplication.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/t10-pi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index e58d5eb6cefb..787950dec50a 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -541,11 +541,11 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 
 static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 				bool prep)
 {
 	struct blk_integrity *bi = &rq->q->limits.integrity;
-	u64 ref = blk_rq_pos(rq) >> (bi->interval_exp - SECTOR_SHIFT);
+	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
 	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
 		return;
-- 
2.54.0

