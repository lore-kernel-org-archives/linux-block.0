Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205874;
	b=EGN3mF9gC2+FruxS/IuNpc+GTTnWV5Cx1FYrj03u9JJA+sf6XMU8/zFOSrOwnNcyHE90
	 Y8rWUlNqvgWeGy4xi3aBr7C9W/rdvP1fuwwITtGEgk5W6MXpPFQtvUrDVUKabDUlv21B+
	 w6wkUAtqhBvw9NofkokZ+61k6CiqbA55xf2m88cm3Kv/e5Uk5SCROMag1F9WhzgzRn8ZU
	 zSfVP2jEx6YkpNen1VZk2bUKqu6SfE26UR45n9p0suIU2KcH8L+cFjjq/iRsG8ptXSlQK
	 cu/DvKI3PsX9ZhkvnOugE1IXSlcgD/uIOAzJaJkEn+dD853pLMSqfdXsxSrz5LXjrHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205874;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qsL6jSU2fAiO5+SQrhQ8gGcECP90YEFgJfsZAl9cPEI=;
	b=UBWrH24Zlc1ul9EbMUY0qewLFuXGCiHi7bnTWqWjWFKMNvF/p6KU8Aj7t3uRN9dAAmMZ
	 aHs0FMRPGKNoormrBSDPkKtKLh9eHJga4PCGgdXd70dhVhxFCf5wi0gBW0rghW77XaTER
	 D3x1hbGTmynahZQnrNtoDeTisYe8Ec6Q/cz7APexwkaIMPGeeyb1LDBFKuleQGjVezXiw
	 090uFqYHpH0NMr8IpHJpSYtAw2Ds/TWI+qzdQpo4a6vus0JsMedb1jkCOjcEJntJ25ZEV
	 sIYEiQ5rFCkB0jAm7+IDI0ELR5al7p4tVQBUIzMWthCY4x1MvfrxxuunOnqb01sbq0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tksphiLr;
	arc=none smtp.remote-ip=209.85.210.46
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDB606A31E
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1FDB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tksphiLr
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-8241a56cd70so808465a34.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205872; x=1793810672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsL6jSU2fAiO5+SQrhQ8gGcECP90YEFgJfsZAl9cPEI=;
        b=tksphiLrNp5P1f87dLvwlrAGpg3Auc9jS5Z4NMxKRIXG4ZkoH+s4nPRCDP0AVEhyX9
         cUfYXQXBGOeHzBErEB6fM56EcuPQaneeDb3YXc1yuShq66oCamRAhT1eXAGB4xIdqXDo
         PEc91hk5YVJY5DHSCc+Fve/MfulJ7c9ALa64Rv3wqSKFgmo04hHLRZhQtcPftVO7J/Ff
         qd47QgbO+TWrfZnFeGDCaEsRDo376qbwYuwo8ho124kuwon975EuN0TH+P/Dkmo67x8v
         30sqg5sGuyrmg4eWA0GTRyW0R9t1882cX652QX/VDwx8evpsM6RP2FkVEkL2A7QCGkIY
         qhRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205872; x=1793810672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qsL6jSU2fAiO5+SQrhQ8gGcECP90YEFgJfsZAl9cPEI=;
        b=Y0d2mn6vsULURj90cj3XIzfkKJQKxMlgPu4r4rvffFHh7A3Jyjuw24FlNmIoDUXW5Z
         3aDOQTAl0uxA4FMWamAiedO+7IrUAtCV3IVbXtO5haUupaYiK+p4gZ56coRJIkqjGAAT
         90P2nvoGcSD9yCsOwsu1SWWLfOUTf5GPJEilL5xCXw7SZFRQtUAu2ws0WkblMXrOcXK4
         mXDRoRQQiMzQdYXisZKK01ds+Hc+l1hbvI4E4SgVFSoKRqXF/i4Vw78nWrtDy4c/LlKQ
         np6HQwV9qi5x07hicsnkl0eUNrvxgntjZWGSFn6ZQxCsPq29ziIdkyD9U2JVPD2LFhk8
         MD8Q==
X-Gm-Message-State: AFq9FYKzhIgh5+4f3ts/Yg0afljB8Zkil4FYWak7MjwM6XqpeydijinI
	WN+NDFIZkpcBAKGNvrjSE+WQ/pKUG1e758ixW0/5nvAyUS3ET/1PV3Q2UxlinRWqckE72NE9Jac
	cCsxqXfw=
X-Gm-Gg: AYBFou1U/RfX05ZeeXlpNQpj5Xghi1+TPfRSpv7dE98gNGE3rxHghirnA0ZASMKsivb
	p575sJ/o3k3KdsaqWp8O4OpRg8T7HDARCMsIWvm9+jpJK2RuekEepbxDjEMQZosxGIeSZoIsgEn
	5h2UQ6uwhIkUfDCn1+nymNo6vGC3956qmMi162xWBATXqPkKaqdLCfKI0Th0urgDGJ7mO8wOm7z
	wziQBZ5+sCK1sFEEFutkzwo5LJVCiN8REAwkcveHitgJQ/nJQA544Kbv05cOD9FXZihjWqKfO6B
	S+bFHHVim5TEegv6jGMTiB+6k7QhzHISCaVHAJaP1vBQeneDwpJk/vZTmEFXGHlzyx6HmSD9L5s
	xC/IW7xH3UbG1JOurvAONNfbD48QDPHNDEiz7MJXtlhNk8QaH5y87zUuEu2gOUuDa/uP/gTOLQa
	gxr6JrPVrPQqJxlWQQBKXe9YUAZEk/drtbHeJdVWMy17W+jp5mqNRoL1gnIkmi8RrfPuL4eCKTK
	gFGeNLC1Gy9RrlDIFzkjh8213lbPGVbHL0CkIYxMjDgQWm+xRmkwQCV2aa4iL9bq6Oqgkms3KJK
	W3esLot26WEqofjeJhVuueebBZLOWSc5UZ+ojS82NYnaSFixDcUEoDMp/dcnQPLZQYGDzgJh05c
	=
X-Received: by 2002:a05:6830:4c0d:b0:815:e061:e72e with SMTP id 46e09a7af769-85ac0bed560mr2925657a34.23.1793205872512;
        Wed, 28 Oct 2026 09:44:32 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/98] block: check dma alignment of bvec iters in async dio
Date: Wed, 28 Oct 2026 10:41:14 -0600
Message-ID: <20261028164415.1262013-12-axboe@kernel.dk>
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

__blkdev_direct_IO_async() uses bio_iov_iter_set() for an ITER_BVEC
iterator and never gets to the alignment check in
bio_iov_iter_get_pages(), which is the one that exists for io_uring
registered buffers in the first place. A bio based driver has nobody
else to enforce its DMA alignment: a misaligned READ_FIXED from brd
returns the wrong data, and dm-verity with panic_on_error panics.

Move bio_iov_bvec_aligned() to blk.h and check in the async path too,
failing with -EINVAL like the other direct IO paths.

Fixes: 5ff3f74e145a ("block: simplify direct io validity check")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c  | 33 ---------------------------------
 block/blk.h  | 33 +++++++++++++++++++++++++++++++++
 block/fops.c | 10 ++++++++--
 3 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 06f805d3866a..57d84ca7170f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1272,39 +1272,6 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
 	return 0;
 }
 
-#ifdef CONFIG_DEBUG_KERNEL
-static inline bool bio_iov_bvec_aligned(const struct bio *bio,
-					unsigned mem_align_mask)
-{
-	struct bvec_iter iter;
-	struct bio_vec bv;
-
-	/*
-	 * Correct callers never break the alignment requirements, so this
-	 * exhaustive check is only paid for in debug builds.
-	 */
-	for_each_mp_bvec(bv, bio->bi_io_vec, iter, bio->bi_iter)
-		if ((bv.bv_offset | bv.bv_len) & mem_align_mask)
-			return false;
-	return true;
-}
-#else
-static inline bool bio_iov_bvec_aligned(const struct bio *bio,
-					unsigned mem_align_mask)
-{
-	/*
-	 * We forward the bio_vec as-is, so ITER_BVEC callers must provide
-	 * segments already aligned to the device's DMA alignment. The only
-	 * unchecked user-controllable offset that reaches here is an io_uring
-	 * registered buffer where just the first segment can be unaligned
-	 * (the rest is virtually contiguous), so checking only that one is
-	 * sufficient to know if the entire vector is valid.
-	 */
-	return !(mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
-							mem_align_mask);
-}
-#endif
-
 /**
  * bio_iov_iter_get_pages - add user or kernel pages to a bio
  * @bio: bio to add pages to
diff --git a/block/blk.h b/block/blk.h
index 2cc03aa54c53..a48665e10994 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -202,6 +202,39 @@ static inline bool rq_mergeable(struct request *rq)
 	return true;
 }
 
+#ifdef CONFIG_DEBUG_KERNEL
+static inline bool bio_iov_bvec_aligned(const struct bio *bio,
+					unsigned int mem_align_mask)
+{
+	struct bvec_iter iter;
+	struct bio_vec bv;
+
+	/*
+	 * Correct callers never break the alignment requirements, so this
+	 * exhaustive check is only paid for in debug builds.
+	 */
+	for_each_mp_bvec(bv, bio->bi_io_vec, iter, bio->bi_iter)
+		if ((bv.bv_offset | bv.bv_len) & mem_align_mask)
+			return false;
+	return true;
+}
+#else
+static inline bool bio_iov_bvec_aligned(const struct bio *bio,
+					unsigned int mem_align_mask)
+{
+	/*
+	 * We forward the bio_vec as-is, so ITER_BVEC callers must provide
+	 * segments already aligned to the device's DMA alignment. The only
+	 * unchecked user-controllable offset that reaches here is an io_uring
+	 * registered buffer where just the first segment can be unaligned
+	 * (the rest is virtually contiguous), so checking only that one is
+	 * sufficient to know if the entire vector is valid.
+	 */
+	return !(mp_bvec_iter_offset(bio->bi_io_vec, bio->bi_iter) &
+							mem_align_mask);
+}
+#endif
+
 /*
  * There are two different ways to handle DISCARD merges:
  *  1) If max_discard_segments > 1, the driver treats every bio as a range and
diff --git a/block/fops.c b/block/fops.c
index 375ec2c15926..dfeac910f126 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -365,9 +365,15 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	 * Users don't rely on the iterator being in any particular
 	 * state for async I/O returning -EIOCBQUEUED, hence we can
 	 * avoid expensive iov_iter_advance(). Bypass
-	 * bio_iov_iter_get_pages() and set the bvec directly.
+	 * bio_iov_iter_get_pages() and set the bvec directly, which leaves
+	 * its alignment check to us.
 	 */
-	if (!bio_iov_iter_set(bio, iter)) {
+	if (bio_iov_iter_set(bio, iter)) {
+		if (!bio_iov_bvec_aligned(bio, bdev_dma_alignment(bdev))) {
+			ret = -EINVAL;
+			goto out_bio_put;
+		}
+	} else {
 		ret = blkdev_iov_iter_get_pages(bio, iter, bdev);
 		if (unlikely(ret))
 			goto out_bio_put;
-- 
2.56.0

