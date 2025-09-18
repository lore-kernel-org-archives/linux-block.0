Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70C323E33D
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160241; cv=none; b=GXsIgeeIWQbh18TmWGH78Gi+LbysOO3uKT/443CD0THohc8i60R6qw6AMfiRiV+bOwY1iMDkJ/YkzxrlGwkSp9IQEiFF9TubW7mCxrWU/bzS/phyoTZXe7fyGKtTT/zNPt9GdHRa5/K5epF5HvzKchkaSKW3rVTxf74z03q1GFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160241; c=relaxed/simple;
	bh=zfz/gYCKgPbXaPfFVFWWf+19XwzZGVoc4uv1OP/g800=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcpVQGg/3U8yFnak/ulU8kp9s5UtbthKFGPzpbvI6aGDdhrHradlFSGZaBF3YqjVOrQi3XgeDD9MeSRBRRAkqXOh0Mei2+QOpu6a9ZCGwSSfIHgEfbTrt4VcTSd/DW9jKjzANpBekTjqUhkzB8L1gE4D0+XY2un0pJ1DJ8k86+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gHUoRWRP; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gHUoRWRP"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3fa08c4cd02so280775ab.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160239; x=1758765039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/08O5ct26XjjcFayvy4DoyctrCQbnzFyOWJ7wIG13g=;
        b=gHUoRWRPn1Aiep8xTmI1hgsWGfvzd11eChWO3zIhHx0Wr8edthBcBWFWJyUCXjM9AH
         QYl1oPqDltCuo4kIwTk/6r4S7j6Fu7x6pAdQDo5WudFiW01bJqHtN3WuYGM3w4alnfSB
         QFnyLnWVwToBNCHt48FOpkIM0vv8BOK0WBB/7azEMfiEd0kqfZuV1xtrlLmTAZBgs3YD
         k0SonXdYBLWGnOfmp+rMsfZgxWml4wiM54FdlueDjmG+f2Ac2xCSB/6Ftp0szx5aZ3z0
         iYQpH4zQnl9p8gy07x8LhheDH4KxyfJYwTD1iTM5D6dxPG7KO6OghR9bByAcZ3Una8PT
         tXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160239; x=1758765039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/08O5ct26XjjcFayvy4DoyctrCQbnzFyOWJ7wIG13g=;
        b=l5edGKsbirya61+EGHpck0LNSGpfCZMANVXleCLltYnR9Bxna4hoQQyQ4Yfge0t/uZ
         TJ0puMARcIR2EE5T8Igrku5eJkKvxAtBXBUTWQYBNWYD40LmldBIx8gtvRj/10MKhwdT
         l4XPerM2JSAHG9tJJ+QvhVjizW4nwqOw3jJvmBrsNvHvbx2cf8fY38sm06Rlbhi7Ed2F
         Iy8nwMGcD6RYBL2zLvsUDUCLmNpWJMnpSMfCao8GN5PBj88q9XigsPlA4svYH7WMTSti
         zKN1TbrWZuZVg3cZfmsaOX9VEh2uX7G10fFwyjjeiJ53wJ00MBNL0KvqrHz2LDDoQw5X
         sU5A==
X-Gm-Message-State: AOJu0Yw7AVCpfmixRc9uvjYnEkYkhnnmdI+MCCfU0xHy9SHTHeYELtYe
	rNJqKMyh8TjmJrPSmqXJ87mMUnAD7dDxSdNYpDnETenirJG9o4eerBtDSq1nuVQzydRjahNQJmy
	cjJG5kyFE//IMSrYtoq2HDlxBMWZp1z0Kkq11
X-Gm-Gg: ASbGncu6KNY6UfIsCoLSj9xuu0bA1KurU8SZeKS0Btk8fJkneHb76W52TLwb2Y4wLye
	1tomBQXd3bisZXQI68UHUnZ4Y+hd2A2kh44TAC+SuuPf1NS+zy6oJjG6j0KlX4SniKJujPozdrA
	XvOQszMVa9yylmhWJhy9skzB6cgE/hnJgZ4E4G2w3f8N58yWz0i4E7Ar1IKWGSmNONvQ3uC8SiV
	HU/0YJylxQoODeg0p7S+eWbfdTA3/kTJble+HrsxQu6HLoJEdvuupCZAlwrjQSsXAaxWYwYmh/O
	ZxzkcYATQzu+VeUy2sXKiJKlasesUh3DnJed1J7MdVu23T6PgEqdBhqXOUMV12m/r2+vPMm6
X-Google-Smtp-Source: AGHT+IFwV7/cCArhTFk0dnQU9dG5dLjsZdbEFMe7441dgyvXdznn33rndbNgDx3tArY7+0ABCVOa5dY83RwJ
X-Received: by 2002:a05:6e02:190d:b0:424:64c:5b5b with SMTP id e9e14a558f8ab-4241a4111dcmr23332505ab.0.1758160238764;
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-4244a39134esm879735ab.11.2025.09.17.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 20E93340508;
	Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 1D6DBE41B42; Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 11/17] ublk: don't access ublk_queue in ublk_check_fetch_buf()
Date: Wed, 17 Sep 2025 19:49:47 -0600
Message-ID: <20250918014953.297897-12-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Obtain the ublk device flags from ublk_device to avoid needing to access
the ublk_queue, which may be a cache miss.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index cb61f6213962..9c6045e6d03b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2188,18 +2188,18 @@ static int ublk_unregister_io_buf(struct io_uring_cmd *cmd,
 		return -EINVAL;
 
 	return io_buffer_unregister_bvec(cmd, index, issue_flags);
 }
 
-static int ublk_check_fetch_buf(const struct ublk_queue *ubq, __u64 buf_addr)
+static int ublk_check_fetch_buf(const struct ublk_device *ub, __u64 buf_addr)
 {
-	if (ublk_need_map_io(ubq)) {
+	if (ublk_dev_need_map_io(ub)) {
 		/*
 		 * FETCH_RQ has to provide IO buffer if NEED GET
 		 * DATA is not enabled
 		 */
-		if (!buf_addr && !ublk_need_get_data(ubq))
+		if (!buf_addr && !ublk_dev_need_get_data(ub))
 			return -EINVAL;
 	} else if (buf_addr) {
 		/* User copy requires addr to be unset */
 		return -EINVAL;
 	}
@@ -2338,11 +2338,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		goto out;
 
 	io = &ubq->ios[tag];
 	/* UBLK_IO_FETCH_REQ can be handled on any task, which sets io->task */
 	if (unlikely(_IOC_NR(cmd_op) == UBLK_IO_FETCH_REQ)) {
-		ret = ublk_check_fetch_buf(ubq, addr);
+		ret = ublk_check_fetch_buf(ub, addr);
 		if (ret)
 			goto out;
 		ret = ublk_fetch(cmd, ubq, io, addr);
 		if (ret)
 			goto out;
-- 
2.45.2

