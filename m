Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192C1DDC1A
	for <linux-block@vger.kernel.org>; Tue,  3 Jun 2025 18:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748975528; cv=none; b=bJQQPl/IsoylVgj8DW59cMhk9FxgVDCpF9jzTnEBmRFFiHXylPgq9Xsn5tDEFhVtRvIXdymhKkCs8Ei+xQtKb02/9cIa89g8SRZFKXuX+fDB/Lc3Rj63wytCJu+IyVAUGWKi5N+CH18Q5LYypG3H6J4yUDq64tsyp2Ob/GrEeS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748975528; c=relaxed/simple;
	bh=VpCnu/vgkMXoRizxEVcXipW9pE06TvbWDwZZnY+eyHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bikqCaiZt/ahU69ocGZVqhsGvx13zg7k1GfrV5EW5AtTBkXNSD7WchE5CzpzqRWJEdHX2m1vVvs0Twfp0MXMfLSrfxYzebNzcBcAM6tYceYzheutaZ1h4dnOtA47Aqub7JQnl16cclvbFvnGzWiTXxw9GgRx0qs/ek0SM4M3NG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=ACGM6Mix; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="ACGM6Mix"
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-86cf36df8bdso22777139f.3
        for <linux-block@vger.kernel.org>; Tue, 03 Jun 2025 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748975526; x=1749580326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nSEqmtH8cAoHSrP17Ob/VSrxyz6o4t+D0NIScOXkFbc=;
        b=ACGM6Mix3TNlXAZ2RDuAUoIiyLd9uTl702TEQiRE1rNSpOyN5U7POcn3qoNV/jbP2y
         A22nO7s9Hi2lh9TRkk28suEIHsw0XvCUjaH5J7xtlxCjerwXWsg4yjOZ/lKU8tKuNSTD
         mUsgCwFlclWzJnZadWAj8IvAUkttWtk0Sybq4MMqzYiiT7L7HEvEv+MBDPKEgMVdU9K+
         5YnxsTSis5rOSFMdQQBuVOEpHj2ec5pb0r46R1xXhEhp50S9v4LbqUeWDJYKjeWWtlYO
         ngY+AR3haKKEJ9BErtgzo2lmeUFsUgBpKDZv1aDuH1dRrNx1jEmIPpqOKXVsGHawpc1r
         rZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748975526; x=1749580326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSEqmtH8cAoHSrP17Ob/VSrxyz6o4t+D0NIScOXkFbc=;
        b=Yb1pCpbl9CBmvqGguKbyzDUX6K4TjbiXS7OcNIrfXzM6Q5lo9iVThY1PmOSVL/nGQ1
         pHmFUgpnh9uYsWZoumwi8GMFYcsXP+fT8dGEs4x3Hhvxg8TIA+vh8iHBirhjQKDNHAyu
         3OAW5Pfe6+H+1GjoV2jB3s0V1MIL4B4sdloou5p4UpI0EL7uTkVjvngmilq6Bchf+njr
         +N5qPYv1t/3qOyXm7N8ZRliTBkAEVSIdxOYsItTCZ7pgXKAiQBRXVbrf52arhjNbx+Ne
         +UMPO1rqEq/rQaYLv/wQQgwwAaIvQ53V12BfilqENKWFA/otOQOxDtZQrpH3DEeOU0tR
         W/9w==
X-Forwarded-Encrypted: i=1; AJvYcCVPGllilVnp0lkINf+BXb+ufN9VhhnxjGRwEPXo2l0L6EsdhfnmXRvgLG0IcQvHgEQkRaqYl2XjnKSpQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzTY/+POcaouy7z+UU3TCnJ/+VCJmxKfFhHfiLlogIyx8sCGs
	GCzfQF9P1Bd50TAy+keT+8J4ctGKqPhw9FkNPjr2Rh+KmmiNTvq3+tOzHwIgezfvTf5NXmhNNt1
	3qji0cf2d5m++ExOX6Geqcyqh6oOqcr/G82mgV2hAxhVIKj8/sWz7
X-Gm-Gg: ASbGnctLRVcmNFiEAmp5ECJPu3eRY7HsvaZorJPdIu1h912X3bF5XiKa7dccMahFJgk
	baG9Ga1DWMlXcSFSEHdE0O1XhBlWXlnfwez2/updZe1OVyeNHznVQJsrQCQ0M1vUJLfzP7/vODa
	iPDTViegczwljUkunNbxpMi75b8+30SszYf83ufYAWboLGlZAKXNL84sz0I/SK2vrpOgk990Shs
	iOJwoQe9RAdDD5+x0zE1DBzqToNz890wEgokfzF/oZ+r9hq2venHGgnc71vkrSLFyu2K6ikYmQF
	pxZtPBqzzZ5K0BPpqYyZohtOfRWJCg==
X-Google-Smtp-Source: AGHT+IH1ugbkQ4Bd1c/ELDzPsfBlGebzYbxe7TsT0zkXX3K5ma/cS/EK4OHQptbYEMSeaz4a1vTV0VHHzVR7
X-Received: by 2002:a05:6e02:1d9a:b0:3dc:811c:db77 with SMTP id e9e14a558f8ab-3dd9bb51700mr53645675ab.5.1748975525910;
        Tue, 03 Jun 2025 11:32:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-4fdd7dffa46sm280255173.4.2025.06.03.11.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 11:32:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5E45F34027F;
	Tue,  3 Jun 2025 12:32:05 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5212DE41E07; Tue,  3 Jun 2025 12:31:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: drop direction param from bio_integrity_copy_user()
Date: Tue,  3 Jun 2025 12:31:32 -0600
Message-ID: <20250603183133.1178062-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

direction is determined from bio, which is already passed in. Compute
op_is_write(bio_op(bio)) directly instead of converting it to an iter
direction and back to a bool.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index cb94e9be26dc..10912988c8f5 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -152,25 +152,24 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 	return len;
 }
 EXPORT_SYMBOL(bio_integrity_add_page);
 
 static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
-				   int nr_vecs, unsigned int len,
-				   unsigned int direction)
+				   int nr_vecs, unsigned int len)
 {
-	bool write = direction == ITER_SOURCE;
+	bool write = op_is_write(bio_op(bio));
 	struct bio_integrity_payload *bip;
 	struct iov_iter iter;
 	void *buf;
 	int ret;
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	if (write) {
-		iov_iter_bvec(&iter, direction, bvec, nr_vecs, len);
+		iov_iter_bvec(&iter, ITER_SOURCE, bvec, nr_vecs, len);
 		if (!copy_from_iter_full(buf, len, &iter)) {
 			ret = -EFAULT;
 			goto free_buf;
 		}
 
@@ -262,24 +261,19 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
 	unsigned int align = blk_lim_dma_alignment_and_pad(&q->limits);
 	struct page *stack_pages[UIO_FASTIOV], **pages = stack_pages;
 	struct bio_vec stack_vec[UIO_FASTIOV], *bvec = stack_vec;
 	size_t offset, bytes = iter->count;
-	unsigned int direction, nr_bvecs;
+	unsigned int nr_bvecs;
 	int ret, nr_vecs;
 	bool copy;
 
 	if (bio_integrity(bio))
 		return -EINVAL;
 	if (bytes >> SECTOR_SHIFT > queue_max_hw_sectors(q))
 		return -E2BIG;
 
-	if (bio_data_dir(bio) == READ)
-		direction = ITER_DEST;
-	else
-		direction = ITER_SOURCE;
-
 	nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS + 1);
 	if (nr_vecs > BIO_MAX_VECS)
 		return -E2BIG;
 	if (nr_vecs > UIO_FASTIOV) {
 		bvec = kcalloc(nr_vecs, sizeof(*bvec), GFP_KERNEL);
@@ -298,12 +292,11 @@ int bio_integrity_map_user(struct bio *bio, struct iov_iter *iter)
 		kvfree(pages);
 	if (nr_bvecs > queue_max_integrity_segments(q))
 		copy = true;
 
 	if (copy)
-		ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes,
-					      direction);
+		ret = bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes);
 	else
 		ret = bio_integrity_init_user(bio, bvec, nr_bvecs, bytes);
 	if (ret)
 		goto release_pages;
 	if (bvec != stack_vec)
-- 
2.45.2

