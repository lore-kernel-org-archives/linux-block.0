Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE637F01D
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476396; cv=none; b=nmVEbjycKTGKsykaEGgrqnmbX0Ovl+7e+QA8c4q0eet0y4dTJ5HDeueg+iRdxHoKZALTEh39uQYmh5Tx/GFeYIPRyBtopTJXc6MMBx1FXxEe95+m3/yjfukF6w5kU+LqYANrt7lqK7nJjVZ/KRVNikWMJC36kywG9Js+5hwvSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476396; c=relaxed/simple;
	bh=Rg4ViyjWjJ0uH1MionkRUKz+M0sp6VZkQ9UyDJex3kw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6zYxDYk5HivhG+KNbCeMGG3oT1NfVIERDy17lOBna7knCzFZDg59VhyqSbPIKzAnWE+Qlrm65pwwKBzxp90iUIphm4DHpRnftS6kdBJozdSUznEBYIsOpLqLRPKLwS9SIQCUMAQM5NgUWaLYXCb4xZzE7cMEf8LzhKLhQ3BHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxbT4MqG; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxbT4MqG"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so11153896f8f.2
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476393; x=1778081193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
        b=ZxbT4MqGYb41heJHzUNkeNrQqqbwivoko4YMr5UyQTxSL8WB1OyORAio38DxntrS6u
         auZrBgzdXlS/Zd+QO9j19xJeT986+p4M04JYGsA9Cy1qY7tyv6ZXSsqeu3lOu5KcvgSf
         bwH040Jp458XcQ78nGYH+2kcXG0HqNQhcSaQEopmU66xpyEEMarI7UgAdVTwheElzo5Z
         2HR0Fn7PnbcP6s0xfsjdbr5X0o3yQ4BN/63ISgNQnvQCaJQJJrImNwWpwl1p/TSCFX2Z
         otPWWi2MPrnCArGZBi2AILWhP9XjXJtLKVR4fjzxCf2rtAdcaSa+MtvsIi8IVnFvQkLk
         9NQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476393; x=1778081193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
        b=fpUIeDY057IRTT/FnaTjzXYLNUXvaeGJ99KU5foLHUPKpzmxWDkJfwAUzx6F5aVUw+
         R4MWdT9SfLWCEA71mKdnhtPqcTDz3pfUobbNnoORCOxVvkiVsXIIiE3f7G/NlXddCgDB
         XbaTAQnbN+uUHcvh/7iQX5h4nTxzOsa86tZ8+HVWEA22/8AfrPPD4JXc7zeSAGlwcTaB
         z7u6IasVNQSSCAYHkEAdr+ZMCNDBW3FlpMDXWRMUtPau+TQ7VXrRr3XNpVQz2b0Fh4vo
         v7CkyzrinKqI38QBIe5F9x411h8wS3wPCdPGsS9hM+CQAvYZz8CtOl4KBPUc1FJaSPdu
         u8IA==
X-Forwarded-Encrypted: i=1; AFNElJ+3XWYYi9eMHifwvzVKrer0IO/ONUUAZnCcAFSibnDo1onIo798E6MAn900APC/bx2/2kMcog7k9K/fSg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9O7Z9U3zxzyQ5wfirubesb0Ik+GqyNvPp6+slhYqnDiO3KSc
	1hM468hO0ZRrp69SQIZ1qeKYPQLuog2QCkKrgnxmoIHZ7+1VUj1uz23Z
X-Gm-Gg: AeBDievVXcC7qjRFsF1SQyVk5hqsA1FMmBsGmxqZoCW6W3ZKOMXzqMS59eygRnraOO0
	ILsnXHfjNArEGfiwQTjIsbzO+mPRnUOxfAhWMOgtfI1jmAKHRx3INwdaJ6Bygtr9mbO92UA94Vq
	AhtvdABTGt64qudKcCPvud03mrTZTajgVvG7O8TNNv1fUltZhh1gh+BDI6EduKmEKdgNoc/d/qJ
	8nSa+HTueUTO94JnhgVgYd1keS1SHltCnCxCedsw8i5G09qJzi/HXQ5zBR+MBOuSKdVvVct88n5
	gOiGZ4eMdfly/tE0Hmgt4/xlTqq0k00H88sJv2EXNyN4kvCO6tNTYgAkGxh/hThT9maGW2Wg8ez
	rS4AQgOTWxrQBjUMwf5IYiOkrGkI5hepQIIhwjJ6Y+DPjdgSZ0KwXiKA3ZgBV2Mrj/bXB9yu1Q3
	pC4IkmHSO3UY8ldJKbPX0I9Z80jHKVNoRTcYvC6subBIboBqys69QzeTKOKKqSz3HJhR9gkXK/6
	clQ9mZm90EoRslIGpnM1SD/si1N+aqS4Ly/QWjzEMFQ
X-Received: by 2002:a05:6000:250f:b0:43f:e41d:85f2 with SMTP id ffacd0b85a97d-4464839c9bcmr15101656f8f.2.1777476392719;
        Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 03/10] block: move bvec init into __bio_clone
Date: Wed, 29 Apr 2026 16:25:49 +0100
Message-ID: <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To quote Cristoph: "Historically __bio_clone itself does not clone the
payload, just the bio. But we got rid of the callers that want to clone
a bio but not the payload long time ago". So let's move ->bi_io_vec
assignment into __bio_clone(), so we have a single point where it's set.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4d46af0cd256..0734b50d4992 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,6 +851,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -893,8 +894,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -914,7 +913,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.53.0

