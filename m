Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324778;
	b=0RwOBUrYmdlyCLeoCMBwtttjNBEBbckwEZEmDkxlSkeFpHB8cPhprHicRkZRxB4tyWU6
	 D2FI24Ys3uQnngHYqLXGKDIx0ycKX+W5E1VhufjJb81dTf1BxgSfOm+51YNxx5k1htWnH
	 fRDL9f+Aa1VCPjKlszig70LbMiB7zLbnotOYJtsU1fxVHjMfMH/xTguiliw2N10Epn/Sr
	 ncsv4q98qiz6593GTQqIZm4TI3iKsIf1ug8bG/o6aDcg8+cmSqLiitfRsUyTemobC2l03
	 HraOY8Zg2HjDDFjXlxw0vNg2uyBJ60d/1OC3J/Fs9oyCfOAWeuYgjQprNG/CO61OfpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324778;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KBjoHjefEpt6gXeu0uBAO7mx6fOzElk1Inu+2ky7I1c=;
	b=JcuwuHhqYBJ1LIkMS5oPMWbFvca4LSXt7sKTTJtHR4kpSsgoadcrtgAGid5wTAyBtcc1
	 a2LlafFLAEFCxD8UMfpc6m7/kp7g8v3gNXHTWlECS6dNF8TXKsLITf0wuJY04ZIVX9WCI
	 tnaDziNbQ3YoaVopz4jusWYBJUfFFMPvy0BogM3WX7SzuPsvatumRdCzmarda/slkjmNz
	 OzWHHYoOCx39LwSzwHQuDKnbzpGNvI4ssN3gYyqO80B1x1sg715IxL4/BN3ppj1f5IGfI
	 buwAbC0GTy8Po8gEaO0TfEm+YtQVnPMPKa/HULaGvBcq1CKAboCB45wViXLI6/+sZ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QMZuKhWs;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6E8606A31D
	for <linux-block@vger.kernel.org>; Fri, 30 Oct 2026 01:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6E8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QMZuKhWs
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a17a332ecso455682eec.1
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793324777; x=1793929577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KBjoHjefEpt6gXeu0uBAO7mx6fOzElk1Inu+2ky7I1c=;
        b=QMZuKhWsa2erUSLf/IY0zFqF2nVXuVqGGow6hvJMlomv9revsAHZYtIipxTsntNl4t
         FQ7slvlyN4kPaRu/yminnBrxoZrysIIsJ6hGIY30J2/8Xbb44S3Ama35r1FCk/14kvLT
         JgtZgKfYW9MheOcj7q9UT5HlPOOWkaLnE5LvDN1lqddtxp74P9bzIk6XnRWxw/RRotau
         CjIsHFxy0GmMzeiHLRePiEBnnNa+IWyO3lPMGziXTaOWZ009vGpGbxKpLu2GRqT7ZMMd
         RhfBQ26czyEpfpIphKYWgg9cDNdHTpQoZLHZ+LFl88pj1WD4gZksSTTyojdHYii1csQQ
         20OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793324777; x=1793929577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KBjoHjefEpt6gXeu0uBAO7mx6fOzElk1Inu+2ky7I1c=;
        b=0bWcxYriHQhfB7opB6DqeLVGQSiCygtMoXFbLHtay32LeyF6p8Tal7kON3f3OWySTb
         hNjim5+0TQ+zyIo32S78bmitX0UCV6BpF0L7XGTXAtCkM/0IDF6Q5fM5ZuwDaKA1+UwD
         JehbmCNhPr/Hy6e8UKLhEPBR+XvmT/eiMKTW0L7WF0dMohbMO680D/6pfVzhnzedFeZd
         0Lpb9Cy/0+Rih6e+My8Nv2pZGu8riIYA7tr3jHOZtjqaJUPP7Sh3xrOFZSh8FPRZdQJe
         ehJVlD5udwI3AWPQmIC1R9YMSPbr6La4o8O/zRR+D2IJEDSNM9OgiSA4MPjGQhZ+KYAg
         x75w==
X-Forwarded-Encrypted: i=1; AKwUvByp/ROAJ03qKR9ghNYILYbLI1CNXKpgEOGxl6msxO5NEJJFu2JAO1iTDqmPR+5ZitHRCpyWacVroGYgtg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLbKmoKWRvn376Ew09sb0qofOnAS2qu3UdTPLVOitIbwdudCpOx
	9fDVlPPABWBDrfV0e9EFos7TT1Bng6K/OepzeFeKz/pPEZT52jPcILg=
X-Gm-Gg: AYBFou26Jlnv8cm+vml0bzSW6v6M54cDmMyTsuFCiuSpfy2nWpvdGMRWMMKvqFWqcTV
	5NVlZMv6lkNATv2DMROFbwWmSH+4y88fX3NrIBWf1q0qv2jAR8YFKH4mQ4s8ru/6jLm75fI/u4U
	V6UtFtOblt2pHZlUaPkxGLOJLH7xEMHr6CTB3EaWOACm7YipQoKeJC0Mfvj0VXLM9zC+etS3ihO
	KY2JZznavdWXNbQzCwc3/ZJdRRgFyxK5F3fuhfC51DbYA+JtVKlaPwBszyDocoInTmJApEIfrG0
	iAKkSo+gsg9/FrwwaYNyP2ZCo15zhSEWl4/v/BIOHntxuR3EmL7JCsiKuEcq23tQcAsJggfghPo
	OyT/JRIRlZQaHR0Y9saJaa6KQZl/WfATzBSEysylPRzT0BUFgcUoFng4nx+l0Cp9j/lUKpOCGfl
	wqlwFDB3cwWWxuEYV4cWnv2vUwIAUjOzjwEcoqN/D3xoPYhe9oTwBdo9YRjzL+pidzyJismvwkd
	HIEubw4QeaCIXZ7RJo4dCWvBh9Cce2HzA8F0c1FgUpsqL+CrslreTEREN2ILo3EHJltDkRb/oLa
	lMAyWqx5k6FfFV7pKjAqlOXiV+Q+Os6gO1P1xhM8CPY9OhGsUYV0SNjyxtfzJYu7dAPCCnXlT7W
	2dekYeIERsmAj1JpH
X-Received: by 2002:a05:693c:20d3:10b0:369:fa21:ba0b with SMTP id 5a478bee46e88-36a42451227mr1548074eec.33.1793324776753;
        Thu, 29 Oct 2026 18:46:16 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:75fd:f9a4:4062:7980:1324])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428fa380sm2209020eec.12.2026.10.29.18.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 18:46:16 -0700 (PDT)
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
Subject: [PATCH v3 4/5] block: map dma-buf iterators in blk_rq_map_user_iov()
Date: Fri, 30 Oct 2026 07:15:39 +0530
Message-ID: <20261030014540.3065403-5-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-map.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 7369aba74771..a65b255b229c 100644
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

