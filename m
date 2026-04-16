Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A2E1A6809
	for <linux-block@vger.kernel.org>; Thu, 16 Apr 2026 00:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298970; cv=none; b=cBiowV5MHpvjMJXqn+HsG1+Jm7/MkCMxVn2Z6Ho23lMo/rE2ioXzq4L0voR9E9MKSizBmwDc0fIzLiAzHvKo+WWj7qFHZ/JwnLuNQx418+A5b3Vt0VDoCivGIAcyLwjUZ8sLWiSvW1FwzNqyo9zthlf33GcJARWHmu0TwIknTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298970; c=relaxed/simple;
	bh=OxwYPUsXcJJxrZKG40PE0m1JReSMAndHxHt1ouUG2w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=daWBdIm5/lzx4KOM1nYztf14vrDdDJVAMh517BWTMsbE5m+cUSJiQ53Z8JqtBcuFNy8e4XTw/P3YtTOIhs1JaWwKoJF3pxyYYdtGP2VzGne4fryYIhZ228NCNa4KZsGs1gTtgQ8QpUXbDXY5UlSjxUUJ64KTXrpedJX/viTenns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=WekJt2Zq; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WekJt2Zq"
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-68240e0d925so157251eaf.1
        for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298967; x=1776903767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KbrCUVte0mVKnP3wd9JwZ7YRnd40ug3Wdm2BJ0sYmnk=;
        b=WekJt2ZqrzMGGrjKyV48raQKDxHgeLv7u9UT7Uf82xNwpHea9ZuG9/f+qDxEQVQYYo
         dpT60UreSc4dI1o2ad5ZZBs5LvKpfNqF+Jf0aaaCSC+9WhAWWhNyAsH4QFrk7rBqIJHx
         TQvDgJzJ2/WrTFvV1Ec49WuEsJiXNPTkEhiNqSuERMU2wQnnaVsTDH2UqgLuBKZqIeI6
         ClHsL78aEWlMFk1zy9mfrD/Fu9safWTZmXiqd5wLSCqvIJ2C3zIrIZlcld0AGoltYu65
         pe3ggIkkeyUaKlD3VPFrEKfh9GlN6X2w7LWT5CZaV6BI4bp/YV7KWdHMdqvaPns1+Xb8
         J28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298967; x=1776903767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KbrCUVte0mVKnP3wd9JwZ7YRnd40ug3Wdm2BJ0sYmnk=;
        b=KU4YSqGuHuqivvkPzqtm96dkrwDvjooVdaW/Q2s4ttAji0mhfkDPQEwvff3X5qnOS9
         RtJOCi2OYjlUYJY837O+84PMHlC1XxMDRpnrS24H+3+32eYouMMy6F5vQTThJjakeXFY
         oeTMx/uT6A4rR1mi9PJtvFyVhk6xQeGcBaXqaAARy/KvzLQPse0OGDnV65Y9udfp9FFP
         FsjgU6g8bupGaG2N7U+zM6Fohc9AVArDYnUA4XvzQkWBHUiQagXWJsHLqo0IAvSnSMwQ
         87jQtjxez4kSy2Yod4k60PRwfUkDLnLKkbJQ6kKuGeDSGuJgccHymxcQa2amql827Gl8
         VW9A==
X-Forwarded-Encrypted: i=1; AFNElJ85/84jz2OtG7cHuJzcPI4vcPzDeoqjnQHLdhjgY3lB4TbWlJlbmN1Jx5OI16Wqo46W5wgThHxqnimdUg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5WN1Uy+IZ4+wBOxmxayhdWIhGWBL6wOUdhKqLwx4v/Zda6Fm
	05RLEnkRnPfAmOKsB9gIZhjjrzOuWZCho4OQYPk9gxu+F1IDxo1KlnQ4mfzyJo0kNTx3VFzjhMs
	mTza/tiK2QNnCcL9ZlNJe8SdwxNp99A1bb0aQn1hpzkOovSklM6yS
X-Gm-Gg: AeBDiev4/lBYQhXS2G9JqJUem/RDf5Y88huHnu+MZTJvKE0f6pW7+sYuheoIpNqUBPv
	zBYhCXNM69zM+a4cOtpXc8UwTYVJQelQjmcsT2Ge0vXrrOOT7wfurSUu90CWhSC820uIPjAlyWd
	kojy9OYiFnybK+SqxP5YCsOOnVOUis0d1lZXUrymcFXIOv4HFiYR83jmwmvKgTk1KcO1himGY2a
	+F8zszlNhRcwwjkPTgPTON3gd5fxl8zjNe/AdGrkI83cXWU0ihH7UOYYI70Pud/qoGXIJiXkL0G
	75uCZzaaRWLzz8U/4ZqOCLDyLFbyvzE5b1b+frJKjQaOqRMBQRqwS+0RMV4cZIIY46S/f6mRtit
	uicKvlJP53s8K7g/+7zIV+2E/6pvOcOIC5iDnSjeXRbK91rpnTQ==
X-Received: by 2002:a05:6820:488c:b0:67c:3021:908a with SMTP id 006d021491bc7-69456aa5cd1mr88811eaf.3.1776298967567;
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-6932a7959ddsm231360eaf.4.2026.04.15.17.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6AAE23422C7;
	Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5FA79E41B93; Wed, 15 Apr 2026 18:22:46 -0600 (MDT)
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
Subject: [PATCH v2 2/6] bio-integrity-fs: pass data iter to bio_integrity_verify()
Date: Wed, 15 Apr 2026 18:22:10 -0600
Message-ID: <20260416002214.2048150-3-csander@purestorage.com>
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

bio_integrity_verify() expects the passed struct bvec_iter to be an
iterator over bio data, not integrity. So construct a separate data
bvec_iter without the bio_integrity_bytes() conversion and pass it to
bio_integrity_verify() instead of bip_iter.

Fixes: 0bde8a12b554 ("block: add fs_bio_integrity helpers")
Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index acb1e5f270d2..389372803b38 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -53,21 +53,22 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
 
 int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bvec_iter data_iter = {.bi_sector = sector, .bi_size = size};
 
 	/*
 	 * Reinitialize bip->bip_iter.
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
 	bip->bip_iter.bi_sector = sector;
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
-	return blk_status_to_errno(bio_integrity_verify(bio, &bip->bip_iter));
+	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
 {
 	fs_bio_integrity_cache = kmem_cache_create("fs_bio_integrity",
-- 
2.45.2

