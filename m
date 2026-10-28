Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205913;
	b=xe0TIiRxI+TNDQBD2nxeEBaj5zDhKBa+tB+hepj3FQZbmUb/jDlV/SCkkmkEleSvs04M
	 P3oKq7sxg8EZZVv958Dijq6RzNBm8obhLHYmtBl2VIa/Xy0jsiMM8NlYfVlKBLKCiVFeh
	 6mQRNoeTpUHrZosvqFRfgWuRDHZiPTNifiOR/e6CEqc+vuZ75n8nUgRNqJlFn4hC3BV8d
	 LoEI1aCU52ORx+O7QJVjbvB2txgelr7a871wzPT9x7YSuPVQHAfb5INMrzUT9cGGJWhJu
	 xK2DhJ7f4SRXX9r0NZlWx7ch979GZfdI37n9SCYSjVsc9xljQx269JiyFx8YLGpig6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205913;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n6G8uFLujVXSXZbv/mvNrXyT/hFd/zpeAt3noC2YTR8=;
	b=K6QMPB+wVf5FGOKsdA78GSRoDo0Kphw1IV2npSSKRG8fQKQ0340XKeTXOnLew92GgaAO
	 n/qqsJQnaPchdlmZCGN3pvq20dmZxBOmic/wYHfD+LbGg80uGUrSlB0J/rz1afV0kG1h2
	 VvUdl8/UWJeoY9IV2muGPjNlNvv0wsLMCr0/y2GscIz8Vnx9ccazmnP6ROAYBtODiZwlO
	 kAo9Wf+AI1dhVYWFuAvkPyRAJYGREGoBmv/JGykdyQia/FcdT59faVAU5xjtxLwMfD2V2
	 YRSIV6S1aXhJE+uhkMp/oS+tXf4oM8ZdMeAsqHpeHl/tlLYn3mBKfIoH4xVbVIxakaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pzHs9VM4;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB562606A327
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB562606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=pzHs9VM4
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-823e4047037so900894a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205912; x=1793810712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6G8uFLujVXSXZbv/mvNrXyT/hFd/zpeAt3noC2YTR8=;
        b=pzHs9VM48Ci8DHwrOkRiLGv+Q6AcF+MhK+zO+Y3Wf5RCoorTuwM0W/RJzGiNT9GNKz
         h0XWU79QhjDwhgnmZniyr8k49xGUh5EcafcBNHHYQg6RaBmpPwYPbdPFS0rbI8+lzLgy
         bY/+Nv5W+WBg/OAomsYZuF4DVXoZbNuXKmsTXagfbW2b5c2Ch1KeRob4aDSvP/ACYY04
         qBdePc/1Ba0mW7ADDsBfJVro5iaM102Ui1utSDhlwpT1mtg/OtVPZG0Rook8UPW03XkW
         uw00dDSWFsaF6Ae/NJUiqxLDrbw0H9JGWbRSBWQjBIKcS6rc+l3Zzru2if0zahxQlIf0
         /7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205912; x=1793810712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n6G8uFLujVXSXZbv/mvNrXyT/hFd/zpeAt3noC2YTR8=;
        b=CL9wuW+GATZdtnU942rE+mQJmxKjJ3uivHr6s7FZYxO0R3xIuf8OHwUgVeGRSaHWYO
         EBYjJXlsnW/mRxE3ZtYUb3imefFfk90qt6ONiJ9H9aq3AtPxOMy9e3G1csFwuWZfK+Xw
         oone1JrnA7mYIFbOi1jo3DdD0fyeIWULxcOmr6ERDrCkAI65V/VKiAOKPPJZoXJtGXEi
         PjbImFn2Yvm/ONsxkWMYEodJbfY8aDkEAB1hNZ8qqWmAnXj9q5ehP+uZKy7uOU7GCnNp
         pqpgIeEo0xGnlkKkRDxllBN1bfm6wcNlthfSTBGT6TZQP+M7WxlQBRey0OP/NA5xjWt+
         6Now==
X-Gm-Message-State: AFq9FYJ6pZaQv0e1lPGP5cO6foITTrwWkzQDdxwrX3miaJFCOEQFAFEp
	EETVfKSUJZLqSvNku5O3plynH8W3nEF4XUCe7TsUoYBsuwaPUoHVdk5v1qceDeN+bAMgRdhfzqD
	+HjgNzn0=
X-Gm-Gg: AYBFou3IqFasnvbOiVLfguOiRUhr7txoJUycYPQozhm4M/9x9/5qtj3ctaeVf13x2+b
	3enTDCf1S7I7ALepWxD6rdQCyGS/YhPuI3lyeq7FA4Xoy9Lb7LTgBsDM+Ax9C8Bnbt2WeTNO6Yv
	HI4nQZ4gdLw8Pk4kWIw0AiokvlgNEWEYvxFGu0vIMu2rOYQW+08WoVrzlj79I57RVSO16B90aki
	SMCC6NSfUQEOFbXC6yMifdSfZNBprTFfnWm1bq9rYo//lAaqndsDxHgbqyEYjorLFjadJch8y9D
	PiKS0gTOao4VvDPQwlyEz0hKujDqLzXO7d0eBXueYFvMnq3T8l2UhoHksjGUlVQr/Jdg/sOYHSq
	iSyVeE+Rwvh71sFdtGOS2BrQJGd6vkscdERPv7jhCsaC9//au+k0QGgRcYy80EgRWP8LBKLd2w2
	ihb6Sbc5gCaIBPloBjBd94CtfrKUTuKO5zCqSZic7oWeIP97ObhQQEYvSPUjOPAHfqWHpcVygPT
	/DvVDogMrI0abZuMMadz8sszEox06m2opoEDe3wzeINYDvmvrOZO3IDvBlcyeQdio1jcvwP0dOO
	GvfbFSaactSPv7uIEi/o9gAMx/Xu+uNQtYrRiPCiI+OuLIrMDg+Fzsax6K2SVmI8RK/uJMcmLA=
	=
X-Received: by 2002:a05:6830:7196:b0:80c:d34f:5f61 with SMTP id 46e09a7af769-85abdb035famr2694074a34.26.1793205911949;
        Wed, 28 Oct 2026 09:45:11 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 44/98] block: apply the segment size to the integrity buffer
Date: Wed, 28 Oct 2026 10:41:47 -0600
Message-ID: <20261028164415.1262013-45-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

The integrity buffer is a single segment and must not exceed
max_segment_size. max_integrity_io_size() applies that limit to the data
size instead, which is off by a factor of 64 for 8 bytes of PI per 512
bytes of data. A SCSI host that doesn't set a maximum segment size gets
64KiB, lpfc and qla2xxx among them, so a DIX disk behind one of those
does no IO above 64KiB.

Limit the buffer and derive the data size from that, which makes it 4MiB
for that case.

Fixes: ec7f31b2a2d3 ("block: make bio auto-integrity deadlock safe")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/blkdev.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..1a965fb5ae6f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1819,11 +1819,12 @@ static inline int bio_split_rw_at(struct bio *bio,
  */
 static inline unsigned int max_integrity_io_size(struct queue_limits *lim)
 {
-	u64 max_intervals;
+	unsigned int buf_size = min_t(unsigned int, lim->max_segment_size,
+				      BLK_INTEGRITY_MAX_SIZE);
 
-	max_intervals = BLK_INTEGRITY_MAX_SIZE / lim->integrity.metadata_size;
-	return min_t(u64, lim->max_segment_size,
-		max_intervals << lim->integrity.interval_exp);
+	return min_t(u64, UINT_MAX,
+		(u64)(buf_size / lim->integrity.metadata_size) <<
+			lim->integrity.interval_exp);
 }
 
 #define DEFINE_IO_COMP_BATCH(name)	struct io_comp_batch name = { }
-- 
2.56.0

