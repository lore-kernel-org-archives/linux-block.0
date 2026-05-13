Received: from mail-vk1-f231.google.com (mail-vk1-f231.google.com [209.85.221.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B063A9013
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 18:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696982; cv=none; b=ZAXSUsMbptZAywhq/iiBCSIyetKgZ5h7ABRmZVmxAg5iIZFWLz+iPxodJ0Xg9broW7gQ0yAK5c8x9KJMKErLOYIF8a3Fc/bXuhSH16Jf1XdunqsoAkeV5ryouc6fidphvTnYTlGyzQwpt/2AQTOX9UacrfeS82IVuM5Ev9qmAKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696982; c=relaxed/simple;
	bh=ijqnHNRqzTPIoYtrjuvejJohxFAC5Z8oMtw30slZKCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZbWwTtVqHf4DBxCqznlyUfRvX8wM9FvterLZHSPr0mHlohLGQlefZHJNlnaLqSSCdjg95DjIS0Ux40yyzNcENE1MR3L1QWjKU9eVxwS/BmzOOwKXl1wZA3ryVeoqE2Y1rULf0JCe2micI/kmgC4lNO0n+PhmimyQhVP/L3D4YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=e201+8pw; arc=none smtp.client-ip=209.85.221.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="e201+8pw"
Received: by mail-vk1-f231.google.com with SMTP id 71dfb90a1353d-57513e5f082so341037e0c.0
        for <linux-block@vger.kernel.org>; Wed, 13 May 2026 11:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1778696979; x=1779301779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFyi/JhFD26c7uSrv4bNuKOmxou2ucg11KYi5FCIQ9E=;
        b=e201+8pwnOc5FSCaa32DvnKsMhuJU8ZlpwECUli3jO0nnqKoijgi4ZvmUEZcSaIleN
         /7ASteldGX2OXlSiRR83b1tv5qKiDN+Hqp7ofxcuj7bqZq2sxyxllzqHCaqRx55qXgY9
         6OmPklLA5laQlnhloTjowqzBQg1BY5JT4PG46AX9GEx89zMiLc9RYd+0SU+fcFOfzfyK
         v/h63fLCYHhyu7XGvP7PTHO6PW4qbMUcDjg5BRZtmw+9dUpCqFw1M44ZfqNjVmwfUDsX
         oRCAWs26zV671V6qdjaJ+EaD9klYaUAmb01ec1KemMts9kXhNBrMudl9NuKNc4oW9aIM
         d9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696979; x=1779301779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFyi/JhFD26c7uSrv4bNuKOmxou2ucg11KYi5FCIQ9E=;
        b=WTKS0wwFEzWEC1FbqdnIbFp2nh0wbRk/1eqhpnDJ0yDZA1FuAqBmdgMtqOgrWTQp5x
         6Fh0ufXfTcDc5oiDq9rfADeapfG8NhnfEauCWq2OcRzLzJrKSvN64mb6hR4fgk5u9Xx/
         P8/LaS4722NtGXB7pR1FXKxmNI4e+dSLo8SxZpiaJpCcTNNk56vx5ezra9XsGT1dK0u6
         rHV8nqW5ONaxI9mPs7rDZrqxasQOpfBpj442UrU7gxppQ2lMbG8wnDimJAflRFhuYQM9
         8UBLacsvfz7/JQikkS+uPWoOst84NHh5SDlGgTEY/WiUWXcN6RikU6P5URbDF7J7GRG9
         +vWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5xcyY3Bh4Len3TNaB1I7S5TyVixJbCQ3n7d5d0miFDr/ucRV2MYlPadS9gZjecEkw4rl2ar+Z7iqGXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5vXsKII4IEglct3XM2UfpA/L6KzhvXkuKrDq/Hr6hrE6zfvbU
	q3XDefqwO8LkdT7JVEFa0H7rhkRwtK7xo6YUUuBqlhIz7lrXODtD82l9OzM5xoqN7t7zhw/63zu
	IZVwVYfX1/t4D+TuXZJdpJOE4s38fzh/DO3cG
X-Gm-Gg: Acq92OG3KE3Zv8ThFOOx6h59K+sobR5SWf/UsZhsH+KP3wocxB23oUm+my1vvkKCG0o
	2qX5IeBILJe5alGURFPOdTJNa1euU92IRvL0NzGWC+UQNAE68YNq7BOI85qLyIJqaLn9u7zStNC
	+gEoHZrEXk/bVaoHe6Iah6SYnos+G6jQFeLLJaeJOyvQjLMrBM+PhB9dIjLkwjiG29XheCZAgNy
	DSc8mGZOvtnNfBddr2C/GoxHg3mj2lluT7SfzvQE+LrLCuezMIe3IoaXUTP6i3Xomhs+r2FcssK
	9A+Ra+0ZXWgcmb7q0uluqRLUNjCk4izbbvMaqZPD6yHELlUMe+yoUC8NajitM1YaabIp3//mmYN
	TpPOs7Ho7xE1I4QJpIeawEdhmlEortgnpXghjX+W8dBcxzrzdzRSSug==
X-Received: by 2002:a05:6102:41a9:b0:633:13a:6e31 with SMTP id ada2fe7eead31-63774873756mr1082276137.8.1778696978816;
        Wed, 13 May 2026 11:29:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-63140170ea1sm1403342137.20.2026.05.13.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:29:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n22m09-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:449])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 255F93402D8;
	Wed, 13 May 2026 12:29:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 097D4E40CD8; Wed, 13 May 2026 12:29:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4] bio-integrity-fs: pass data iter to bio_integrity_verify()
Date: Wed, 13 May 2026 12:29:21 -0600
Message-ID: <20260513182924.1753582-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
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
v4: split from series changing ref tag seed units
v3: https://lore.kernel.org/linux-block/20260417015732.2692434-3-csander@purestorage.com/

 block/bio-integrity-fs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index acb1e5f270d2..0daa42d9ead7 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -53,21 +53,25 @@ EXPORT_SYMBOL_GPL(fs_bio_integrity_generate);
 
 int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 {
 	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip = bio_integrity(bio);
+	struct bvec_iter data_iter = {
+		.bi_sector	= sector,
+		.bi_size	= size,
+	};
 
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
2.54.0

