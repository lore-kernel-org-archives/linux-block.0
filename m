Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC92827FD78
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938309; cv=none; b=axjTPzM4dj6P1F+samwTXwUlneCWD5us6bOCvhcBmcWy4+Brk1iW8t20WFtk9Ma4HEMJBv91OCr2gfFyAqD/HEDpVR+nCZHEg9atpxX4sA54rtwIVnCRbBgOP7rd3NVl7e63QoQCe/ArLdh2aCliK8IgzdlT/S/RZlshrb1eOFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938309; c=relaxed/simple;
	bh=2QAhGEFKNmLFH3rV8w4M1xXti7VQ8PITqhdQLrQ5sfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TrOs1m5yTAUvjtWynYbTxpcycXj7u/MoOoHY5uTBycxMbE8kpnH+qVdXxG9C0Yk3fJjIFGHqoEI2URvNDdVVI52XLlUVfxswDq7VECsvlwCId6uwEo67a0rkWQjYqiL2hqjrri68n2n3OrFNHHbtSBTzKvUswIMygBVSlQAMEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExMtn78q; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExMtn78q"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b31507ed8so3157898f8f.1
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938306; x=1764543106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=;
        b=ExMtn78q7qR6pIUKU/7VGEUjfVV6bk4JomIs0V7n3OZ75PBi4JcasAliBmf1wTvoyx
         b92OsjRkMwvIJuHVXeRbVuryPNFAwkzKf4EGn7EO8szNtfK1k5krVOdZmS8No32ZESGv
         ImPPNTwX7bmkJ1IhqUNvIU76EZji1bIfOQtq1ljfyidK+oNXUJ7XWwa6MNxvVFiP8HHs
         B48v9HxDqE527c99oqmHROtvLt21uqMQkqSXO9ArUQjRm7NuOAtbNBiuF1oPNo1YAURf
         n7K4uaIjeMzrer6TJnVDiPQbQLbmf5Oe9zgZDmAiVIE3QFQMktiqlGywBqIateN1ldED
         3Ohw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938306; x=1764543106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=;
        b=ahUi4S7774eTqF6SCusAonJi5d4mPDc+RSIkzJaW6v/TFXpnigKRfu4l9GvPg4Fopj
         o/h9hM5PSy1HM71PVwDhAtyWwgjrGFC0CN4iOTnXGfU3631KmN/pdFCMlcrzYi/3nfdL
         4i/T+XBopzeU0FoUBiXfWKDRlv31F3Gm5rOEafu6rSIFY05m/U+ZVFU+Va/YisnWiQ1b
         rbHWBRBvQGj1R3MlRNbq/AZnbUSQdJc7K2mRcYC1Lnv4qT7HqryShJKPkZ35ExJzKk1h
         1KN3XzSui5bKRb0kEgPcOKtKR84b7h0FbnAPxuEq1lEeJzBvtuoy6buFZ3ThzSWuSAy8
         5wJw==
X-Gm-Message-State: AOJu0Yw8i3TsLrtYFNnLrqo5hCTe/K2ph4gPtKGm70LCU93VHvy/XwiY
	+3wQHGDLMQN81gV3onFUGMz3IxE4NyDiBgXADty3MtAJYYOTfEmB73Z5hle+8Q==
X-Gm-Gg: ASbGncsZCVa+CunKjhyT990Un5MpxBNjoBpcuQ79NDeUMgPC5vvv3rgjTFVMFCDN60M
	nbj7U81VCQQLGNMYJa+c4SqQRrFH+027zla9iGhGe2uw9GcJHC6fXe5V29NwtDaHlIwPHE/aSTD
	Xvu/xLYIxi442eK9ZHNTES+52EaxzS68Ll36Mclfy6JjvygGn2Ik0Tss5FL36hdBL4TY2yl1sbD
	mACPfRbbQuhjrsNkfLozEBCw11D8b3U6DdOb4uKy3V0AOi4650M+01vOHnyFm5+WbeYRjREf/Wi
	+mekoQ6R/xiu9Af4Lk4sv/j2LVIailKV9VZb6TY1YrxFXURprDNf/xWbGe4bl2lvJnwj8nWPp84
	v0os1K/J2jKfQ7lYQu8zE9yvmaVWD2fXbnnQKYyzEzO1etGeVDpM3JqpqAFNQfg5Z9TuHyXf7MH
	dI2SBdZYrLj/ez4A==
X-Google-Smtp-Source: AGHT+IG6zETWdv1uNEXL1H7qlBK8rzCntcx0G5cI2YCnUx99f9VimwWWKVBIKAVqjQPLH9huSPPJwA==
X-Received: by 2002:a05:6000:1448:b0:429:d3e9:65b with SMTP id ffacd0b85a97d-42cc1d23c3emr9659226f8f.59.1763938305625;
        Sun, 23 Nov 2025 14:51:45 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:44 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 03/11] block: move around bio flagging helpers
Date: Sun, 23 Nov 2025 22:51:23 +0000
Message-ID: <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We'll need bio_flagged() earlier in bio.h in the next patch, move it
together with all related helpers, and mark the bio_flagged()'s bio
argument as const.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bio.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad2d57908c1c..c75a9b3672aa 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -46,6 +46,21 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
+static inline bool bio_flagged(const struct bio *bio, unsigned int bit)
+{
+	return bio->bi_flags & (1U << bit);
+}
+
+static inline void bio_set_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags |= (1U << bit);
+}
+
+static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags &= ~(1U << bit);
+}
+
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
@@ -225,21 +240,6 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
 	atomic_set(&bio->__bi_cnt, count);
 }
 
-static inline bool bio_flagged(struct bio *bio, unsigned int bit)
-{
-	return bio->bi_flags & (1U << bit);
-}
-
-static inline void bio_set_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags |= (1U << bit);
-}
-
-static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags &= ~(1U << bit);
-}
-
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-- 
2.52.0

