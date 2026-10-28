Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205910;
	b=OX9xHOXt2+bjhh+99HQNDiDRCOA/ecTExyWXA6z5LKku/PdeaFrYdqyaf4QE01vGPz0v
	 pkbmu5KNpfJbYGrQvor7jSQBIRc0vwq9eQgznHFrj95nty54BPzUUvNRUqOmQIs4HGZtq
	 +4MrAod6CDwbRZaXsK4BqKf35yKNMl8A6LK6UPSjH1l4LgrztHTf90gpuv3qHPHV3uGue
	 g6r+RbARWf7v3cgcqW3bScHpLBz4+RTKvOBPDGchZtzvZKp/9ACYgLvF/OcgUoGAYP8Bs
	 72iR8v6ugkjZ0UImbq6RwGcz7nsJOT487kZSjzZT0/mHFK1t/0PzRLhdVa75IEDyPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205910;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ECckEXZDjGQHYVNU41GOt5Zb46Dv/eEstRfu9RA6kR4=;
	b=FWjJs/o4Tu2iFrEUtm9MNvSmV/x4VN35k6tyzlFEqqrCymFp8V2Pt1f/rL0Z9zzXxf5b
	 rV0KkTANJeBm1EgYh+0weT1YJv63qHEQmxO3Pyed5dnQ5utIjhAOHWxUXA0BmM7uwq32h
	 c+hYvcWPR7vBuI3HlYk6g2lDWWskTpl+BI4gXVkI0VYcva17UxJRA1zeNBkQfco2/93m2
	 kKhAMfuNSP4qujkLfIMZ+bYA6wbmh3/S0v7zUlMHBuOJsfDPxJshxjpzgVZkeL8u2MLYh
	 6K7B7TMhodaa5M0bm7TaxyyM6sz9PTkeIj9eTGGyN2wq1Fg84A4O7J+YZVZs3AmREEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tvZ85dYX;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BC9606A31F
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58BC9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tvZ85dYX
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-844a8bf7e25so798650a34.1
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205909; x=1793810709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECckEXZDjGQHYVNU41GOt5Zb46Dv/eEstRfu9RA6kR4=;
        b=tvZ85dYXxSH+tbnHU1AWafLEXYwktKE3UCgo1Sf0wxHkWm6cGi+dhGDy5mi7xZpjea
         cuCnEm9bZUnWaluVdUbbuzGs6nI7AwrnMRa8t/nZuhuce8F26ofW2S34E3ybpNDZSqYY
         0yVbGT4DG1SwmwCaHFs/aKpbK4nnM5z1o4S8Q6ABui+XyKHrV4MXOsMMfXndBc6G4552
         JnF9q3Ojp2rQWXnuwfgOuEvkOx8SnlWNqAcq1FaXoVTEWsLP1k7tfEPA8Pa8HOxWjeqd
         SlGc/OzUcPQFF3Kc7plDs4gWpF4MA/PcFhZyBxN9ao72OfVxO93we02LtM3EcCi3PsLp
         GBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205909; x=1793810709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECckEXZDjGQHYVNU41GOt5Zb46Dv/eEstRfu9RA6kR4=;
        b=K+himgl2v6HqqmSrdTWkGRZGQCZgVEqUBMLWtbEk/EKX41B2VvLVbL6+R5ghF38Blw
         fYsNqpPbbq1tD9zLBq4KSmHkCL2cPOXsds/4osOIfFn/uMRupcyR2FxyonwfQVsfqk03
         ojgCFCqDuN0XzJm1oMh4thV5x43Sdwp1NG4mplrB3yuQVn9NToWDP0KJNhwGaGGy5aCb
         vy45F0bej8YsKxlGo8EVNKqB/GDC3tUhthf3ryXPuY2j/drIVypJvzuz2kJlFWdd5y3N
         3GS8EnbC6Bs8FOGsHwm7WAgTuCRRmYJvP2ZwH0xqz0wqwXAwVNwEph3YiloaB6EFPIA6
         GV/g==
X-Gm-Message-State: AFq9FYJiaV116FNNX+faS/1LCLSY2yp6+0JrF+rJk437668LvejR0wAB
	LiDx8kGnC9nUtQWywS+ZxgO6ohr2OaYEIsnR7kVZNZ8tzqGC30jVWcqExyxx297UwPkFs3LjCLx
	vQ28MW6Y=
X-Gm-Gg: AYBFou1uKbD6VS0Zej/Ty/A3TKCD/8PT8CVacYcANYJaJU2d4nL0wzSXJBPyrt2PJ93
	iZqDDLKgDt366cavklXc+fr8uSJqjeGEDPD5Q8QCzTNK1+sozrh5hD/GpcYJIGYc6JssYj1ZYv9
	e5TGISdoxxle62I1+xAFj/bp8MgxsE7tMx/1C5/8Vbdd2EfEyAUE3I7LMVtzOKDQLMU5R7YEyZJ
	gVp8Y0QDSpkSpn2aabfF2R71+J3c9aQcsNxQ4Tm/tK4mfMj8yH9xDyiYvkfU0FwWq7OXMVtxNEE
	xf4H6lb2pAFo71QRqgdu8SwglE1OvdjX3yVZWsVL457FFmZ0TkPgj/qvkROKSNhX8kv9uqQ+bEM
	FtSua1UaiKVCV4BW1ecK11q8dE6+cUz7eUTy9aTW6YLiubZKjWJFt9Lffd6fuvJpGyhMYKTYXWd
	rg985KaJdaALvMkvBp3HnGdFUYIQKWQ2LlhbAnd9U6vW+x9aBzVq4qCWjlxkd+wzeydApESNCy3
	YkZr+Hi960vejVUWJ5hsmKjGodk+7+5QPZBAdcvJ0hGd25bbUp18MiWeIPLYENpDn6T33ZsLAFs
	U3mCP6tuPM+YUMQX6sNgekjfKXcrvlkOLjc8Kz3M85/Do/8fdo56FyP+dEUHqaF/rU3NDCVaRQ=
	=
X-Received: by 2002:a05:6830:44a3:b0:7f6:ec23:7956 with SMTP id 46e09a7af769-85aba80b487mr2405358a34.2.1793205909361;
        Wed, 28 Oct 2026 09:45:09 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:45:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 42/98] block: partitions/mac: compute the sectors in 64 bits
Date: Wed, 28 Oct 2026 10:41:45 -0600
Message-ID: <20261028164415.1262013-43-axboe@kernel.dk>
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

start_block and block_count are converted to 512 byte sectors in 32-bit
arithmetic, although put_partition() takes a sector_t. With a block size
above 512 bytes anything beyond 2TiB wraps and the partition lands on
top of another one.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/partitions/mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index df03ca428e15..f372392af95b 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -97,8 +97,8 @@ int mac_partition(struct parsed_partitions *state)
 		if (be16_to_cpu(part->signature) != MAC_PARTITION_MAGIC)
 			break;
 		put_partition(state, slot,
-			be32_to_cpu(part->start_block) * (secsize/512),
-			be32_to_cpu(part->block_count) * (secsize/512));
+			(sector_t)be32_to_cpu(part->start_block) * (secsize/512),
+			(sector_t)be32_to_cpu(part->block_count) * (secsize/512));
 
 		if (!strncasecmp(part->type, "Linux_RAID", 10))
 			state->parts[slot].flags = ADDPART_FLAG_RAID;
-- 
2.56.0

