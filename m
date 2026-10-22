Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680370;
	b=N+AwYbPmCLK3RjUIEWe2EKhrrlDbpnhYimljg4p7ppybuHXcxSRvJwKTfblRZVdj3b8G
	 7OvDusmem16BDyVvMiGo5V87M/sECm9mcoFvJnwq554isHD6A7k2sPxBLaRkhp0Bx1ec+
	 T2G+dQ598SfwSZcNC58aC4bjLJP+mdtA4SZZ/tW22iAfq+zpgLUS0HreWFnUHOfMcAN5v
	 AAvFbcpsxBRUKEQF0oSqWe64jRbjX0hthaWN3I1JGKUN8OgSShylH4rmODJmjiiyrSOnT
	 ciNBhPeSHN+jPW4FsiE9jwCw40QUwzxDHjZ9ONAyhJX6RhAOcHVu5QwPb5M6gKfWNtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PrklBKkcVwO3V8O9sw0CVF0qG6S9AFzj2KttEqdFQnA=;
	b=B6rtNZb8kD40XjMOE7uDiarmXyTwXrNcQkRf0097ppyJbh967J6u+ywDs8eZu55ZBJjV
	 lNf6QyTnWZSpLVGwBP5cktgeW/sd9xgYzgr5rj4qMDZThIgL+4uGdedA7Cfg8d0hZijxJ
	 jPneFoRwd5A6YsMQCTg35Gx65XOmltwcwBfKXVTUq3LwobQ4C4qXxIViYoY6+9rvEykn6
	 Zrq9CclxinKSXpcKxYiFcTmdFqM6wopEO3S7s13/+mtZEU+8+CaSYp1hjgCk8fmbPpQDQ
	 i3VZsWVr+7QhFk+lHToXH2yMyBS5a3FP6FJbbhT7wo3Myx6DBGrtkHq5kN1BvcSQlQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IBNXlLqR;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFA0606A321
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CFA0606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=IBNXlLqR
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3250807eec.0
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792680369; x=1793285169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PrklBKkcVwO3V8O9sw0CVF0qG6S9AFzj2KttEqdFQnA=;
        b=IBNXlLqRHyQGCpmfqrAk1ZBu2PX1oPbKF1Bzom9GXmhEu8LizS/ke1Fvza7ZyQfshg
         QJfTtjwJbSJisBpGdbuCV6LR3sIULH/hhUEfl13j/0rDedXrLHtF48OC0dRRoG2j+K+Q
         ybkLcWhu9uHq5h4b1MyTK4m0g7V6XM4zv1/UjXnaC4KWAh8xZiIPQduDV/7gfJe0Fzg0
         oaWWwrioxkk5QqRpIwqyfO8xzv47hgaYrgoHaNZbwvEOHEoy7nQMOc12C4mOIuuBu1f3
         3SbnjV39pX/g9v6ptoltyPbXYq1fdsMg6l0b7AYcOBHEbfA3oq58WUIh4Ilh2iG0UV9Q
         aDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792680369; x=1793285169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PrklBKkcVwO3V8O9sw0CVF0qG6S9AFzj2KttEqdFQnA=;
        b=odgB/bop5hkKUAXr9nrJgLaugm7mLQQTEnizmffpgi0SBZa7KE1Zx3S15xwXIlcAQR
         9nqMjiWxkLLz7BeHMPyv2P+L4LHkozz6T69yMtWx08KIVV3gcoVSEhFmWTYHtWx6BiUe
         4yA4WbFCX4QUdua+d3OUWxXYM27tuD3MJUxbEFqG0QfU2gONccfU/gePuLn5AMBsNXFU
         FtC/ssvFJ8dAdP6cN+g85u3idSh6krDSJEesQdCO2LUeFlSqL5FLdkBoXNpI6/o+oN2P
         W+rW4PBxpscec169emPK5orsmQF3RIK7/f/Ks5bL2WA78APLmHSvME4KeHBtW3T6C4IG
         ewsA==
X-Forwarded-Encrypted: i=1; AKwUvBwnnTWglJTHSLCPd4Bj0fmnOJcHUV3O+h3IHqscAgxl3EUtkdV+Hk947sGx9ZjXmJFfzSC2a3fZuTUljA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIz7DZPWQJcBpZCjKKF04AuLLr4qMMtRiXSnZuPLKQPermlc98G
	VoACYnSDWmJll68t/z19bzDfbL2yQ3Eeo/0UzkvGgTM0OeEEtam1dm4=
X-Gm-Gg: AYBFou20Ief+w7G2zg8/TPLY+YbdP/I/kGwSPjKIOGNounudhTkZHVZwMZH4YB1oUGF
	mJCAwsVC5x4VOHYWmDqLln5oVj5Cua8smZ62HS/r5P+0u8v9VVS+bxNBTH4wzMrAD3b4sQnOJ22
	y0bSTY4kFHXaRV9KrxpnGW8INFxj3IDwUmYZwf8km5JPdewlUxMt7JHQ334BZbDyebPXxKWHODH
	lj+tNTiGBFszatuveugPFW/h/on69hlAD3AL1BeFBST6CPq6Ytrdu/II1TvEdskMm89PL4ANKIq
	2wzZcDX8qkS4rWd1lVO2Z5n5y7HRytQLfPUxO/zPu5GrdDPoYfrW/9ikAOYUfuS3lAC1jJnR5TW
	2Ca/ylXWZ1R+ZCt0+/7QJsg0+lzy/RoC8Z43E73BQ2JOf6E2sgxjYtDqywlCMQWPJwb1b+JqW+x
	FKf9w4yWJfrWbSr+3JrMCG5xwHNvrk38phgTRSSjANgX21oWD/ewe43E2dicwXBSwHpdIS/r0Qt
	owRs/0y5DQtWs+NK4CsAP4s1Prchd8J81/QJcQRQb81vz/1mhReFlK+lm6ajEAvyVlLyynCHxrs
	gdTI6Z0uOk48560kO3wJodtKvsg330Q9JMFeUcZLT5k=
X-Received: by 2002:a05:701b:270c:b0:190:d9bb:281f with SMTP id a92af1059eb24-190d9bb28b2mr6570477c88.18.1792680368388;
        Thu, 22 Oct 2026 07:46:08 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:5016:92c7:7a35:f3ff])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903a275026sm23625880c88.5.2026.10.22.07.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:46:07 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: axboe@kernel.dk,
	asml.silence@gmail.com,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	James.Bottomley@HansenPartnership.com,
	mkp@kernel.org,
	bernd@bsbernd.com,
	joannelkoong@gmail.com,
	miklos@szeredi.hu
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	joshi.k@samsung.com,
	anuj20.g@samsung.com
Subject: [PATCH v2 4/5] block: map dma-buf iterators in blk_rq_map_user_iov()
Date: Thu, 22 Oct 2026 20:14:55 +0530
Message-ID: <20261022144501.2478417-5-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022144501.2478417-1-anuj1072538@gmail.com>
References: <20261022144501.2478417-1-anuj1072538@gmail.com>
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

From: Anuj Gupta <anuj20.g@samsung.com>

A dma-buf iterator can't fall back to a bounce copy, so map it directly
with blk_rq_map_user_bvec(), which already handles it through
bio_iov_iter_set(). Fail with -EINVAL where a copy would otherwise be
needed, and update the blk_rq_map_user_bvec() comment to match.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 block/blk-map.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 9cb9605d1f62..d1e096fdb03d 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -459,7 +459,7 @@ int blk_rq_append_bio(struct request *rq, struct bio *bio)
 }
 EXPORT_SYMBOL(blk_rq_append_bio);
 
-/* Prepare bio for passthrough IO given ITER_BVEC iter */
+/* Prepare a bio for passthrough I/O from a directly mapped iterator. */
 static int blk_rq_map_user_bvec(struct request *rq, const struct iov_iter *iter)
 {
 	unsigned int max_bytes = rq->q->limits.max_hw_sectors << SECTOR_SHIFT;
@@ -506,6 +506,19 @@ int blk_rq_map_user_iov(struct request_queue *q, struct request *rq,
 	struct iov_iter i;
 	int ret = -EINVAL;
 
+	if (iov_iter_is_dmabuf_map(iter)) {
+		if (map_data || (iov_iter_alignment(iter) & align))
+			return -EINVAL;
+		ret = blk_rq_map_user_bvec(rq, iter);
+		/*
+		 * -EREMOTEIO asks the caller to fall back to a bounce copy,
+		 * which a dma-buf can't do.
+		 */
+		if (ret == -EREMOTEIO)
+			ret = -EINVAL;
+		return ret;
+	}
+
 	if (map_data)
 		copy = true;
 	else if (iov_iter_alignment(iter) & align)
-- 
2.43.0

