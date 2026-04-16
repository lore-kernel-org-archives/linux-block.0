Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F719539F
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298972; cv=none; b=TOdNb2pdRCXygbTwki+ZCnEX6inuQtrNWBR1SUzsvM7cwSZ0xKsqsN4P4ONVZtsqdM2eG2Dhy/Qx2yPot5QGRuG+BRdgZOJ1wie+iU8yKJjp2WNscWF7uL2fHNMVN5/nZIAt30QG/XIGFpxWKrqWdtP79gS9yhecgSBzDdbOWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298972; c=relaxed/simple;
	bh=FVwKbgioBZ+VO2vvdiCyvzfplqZuonuE42jMiRh7ulc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQpdTieFxMwi+tniDN7RRE6WWibBMEVWtch1VMvSYF/g2ZNIfvBfpocwj3hdz2RDkIBLkBTYTM+uuszzCpS88KGOQlMFm11d31LxTh9tuE3epvrgi19KnL3+1pkN+8jyVxyOJDXqTWXdxuhbl5J21ZTRYNICUknuvj1ndpA1+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=A/n/Ah/B; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="A/n/Ah/B"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8dddb65b7f6so103430685a.2
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298968; x=1776903768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTb4WYVL+QtfOgfKxr2rwJdF5OfB66I75dlU3VTdI6c=;
        b=A/n/Ah/BZ7Zj8v9yQwgw9Cu4aQ6WfKwC+hRGVwA4AHyKZa2Nbs9i+ELQuUPwQlnuTZ
         eyCuB3IlKTQXCmeRPe/c6C3rqeKkEHAmm1QLyjMu8s26OXW6ASdD+bj6Z/uansAf6sKX
         wOGV+Xh+ZJzHBxISK95ydcIkN+kof+IybXgBtRAXXUlZIh7+mRLpzQvAGewvkQkOFqQu
         tciz32ruqZAecMZi6npaY2c1Rh3DgOsk2cJ2sZow/FfkRJwRhcHnRgrBo4FYqekGg/ef
         WtHzecD5pENS5wkST1IwrjYpg/dUTsClHvSGFq+4nFPFEgbu3DFxqhw0wdzrJp+6k9zR
         Ac7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298968; x=1776903768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qTb4WYVL+QtfOgfKxr2rwJdF5OfB66I75dlU3VTdI6c=;
        b=WI5SYJG6aa9k5B+Bp78LTmdAjToImPw1wEa6C24ZhF8xe/VwAJEsfWe35R6p0OrpXk
         DGjWA9xzaaC4qP26F1CUQ/nW6A/nKElK/MjxZndIZr0A4TVqzrzvpjWgA9aReHPDToiE
         6QlW+l1Xyi8zSgMnf1Faf2A0HBrz3UZfbICdPoj4wJ1EOYtd7ctrEPsJ+yjEC8Ni5hk/
         kK6yLlbIQr/yVVc8SfQhWFwHB5FWQ2+ysMuD3Y1wL1jiWxrrKrUtP8rxg3Q+MpsRf0j8
         i/AlCiyQ5UVl2jYCilt6/NN3vOXZZw6J2YNn7QDBiegiyzfBJMT8duiWAPzMYmEST8b8
         X43g==
X-Forwarded-Encrypted: i=1; AFNElJ8pIOB63Nc3vjzAsEozFuEQJ0vfH4r+RsxL0Uw+4bNNSR0dW/hlMHH7Ygz8UEcTZqBFo2UYlMvasIp0DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwnvStZFY+7sNByCtwuuaC9KdFONvzcHKpkzY0TxsEYEAUP443m
	Vv6Jjn3b+A6Bqv6ShnWZQHxxm5XS1OTYWwN37t/T5BgT6rnIA+fv7aXplgPQyjWOKFS3vQpuHSJ
	JpwU9TYU161AoOgkTD/wm1o9ysNKuLy2VMxgd
X-Gm-Gg: AeBDieuOvYqzu6i2Fm3UXiuw7Vs0BBlORVPS+OyBQ8C8EGMHnuwQfmHx4b6KuavXVqR
	I8IT4la/tqhJ2iaqTIb4/GYIK4BqJRN9Ttvj6i8zHxFQqk9ePdEOlXSwRf9u65NxnRhiJnulM75
	MLCuvAn388sJ4f/PbZqRU25XePPHPRnGYijJIuHJx8uji8sY/LzQRQinuUqzM4s9SrcChyIDCU1
	+3U2aqD4L+L4O1lW9yncG5GRLFDAHtd/VH5MAVhJ3Em7Xw837dgFPtRzy+9Pn4OS3c5gPdYt4g7
	IDVlHQ7vL3RLAOmYpMcSfGgUhmcbTGyX1/vWhaIYbqvLsTxDpJkGQP9DR3+Qq4m3H7Dp7oAtTr7
	pSnOJkosDLnsnoT1F/OEsdkK/JvPsNlgeP1+mHu1oyVmuBc3Ql+dj7CsSwX+1mchp
X-Received: by 2002:a05:620a:4614:b0:8d2:394a:d3f3 with SMTP id af79cd13be357-8e6321e7da5mr60618285a.2.1776298968296;
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8ae6c93d2b9sm2589456d6.4.2026.04.15.17.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 07F4F3422D5;
	Wed, 15 Apr 2026 18:22:47 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F1B94E41B93; Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
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
Subject: [PATCH v2 4/6] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Wed, 15 Apr 2026 18:22:12 -0600
Message-ID: <20260416002214.2048150-5-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260416002214.2048150-1-csander@purestorage.com>
References: <20260416002214.2048150-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 389372803b38..5d1b0e33fc5f 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -62,11 +62,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
-	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_sector = bio_integrity_intervals(bi, sector);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
 	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
-- 
2.45.2

