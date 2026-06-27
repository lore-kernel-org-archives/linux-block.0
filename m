Received: from mail-ua1-f101.google.com (mail-ua1-f101.google.com [209.85.222.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF835AC12
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 06:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782541181; cv=none; b=B6/Ks1HQvlPKMsb7rzWXpccA8uwWT77oDKH2JKiqHo3ILBGKM9aRNg3Nkw2T6d972b9sZ+/upRR4U5hPwBSpkkk1qzFDIZIZVE91yb91yzzsZaL6jCEhhdCHL9VjZ+y6RUzjSIkIl+91lZkFoJBpbZeBXZWtRxf+QXtNoWjZcBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782541181; c=relaxed/simple;
	bh=u9zKfTLVgVFdloT0bkUEf2OGEZ/bTNohRvlKgt+PhLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smwy6OSI85PcHa5z0gVyGM+7nFouDPd4aw3nDPDhVM4SYb0b7sdN/8vqm/uel+D9qQvwjAaDQ4ZHDYMLnoJOipyBk2NBoNOlUT01+IwWlqmzjHAi3zJti2Zi/Miefx4N8j3P1oddZCtVEC11p3B4DQUVl0SpKhPLs8LnpxaRgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=HjEVVLUq; arc=none smtp.client-ip=209.85.222.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="HjEVVLUq"
Received: by mail-ua1-f101.google.com with SMTP id a1e0cc1a2514c-9674f14207fso28567241.3
        for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782541179; x=1783145979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqfsBjO22oyS+9rLfQyq3JIhryb7923Ij1b+1n+khmA=;
        b=HjEVVLUqMUjMtWs2ed7BahIrp3Knk6Ppy98iNcVbLLStwlB8BJbGdBJRw0QhQ7TXSX
         Ev0uYiZ4I6AZYlPX2iO7lHPqiqT1UfCf5rSLYxpPhorfVAZgQWCzUpByUcq958k5LnHp
         rpbT7RQJXB86yKjizfxfoK8zlaXR+f3Pog5g5LqhZQxWEmNIOS+pE/ayLRl8n4LAWQ+t
         IVGhqQ4Wh2o5CB/3HpUwDzhbJgk8DOJnobb0iac3krULJgsX4HF1H93ptNgTKseI8hkU
         QAQXcICAcdVPpxWx7B43etL8647ifjRdxpD9Pg3QFh7t8pVPDX/yh9X+wXpnw7JVbL40
         JSgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782541179; x=1783145979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MqfsBjO22oyS+9rLfQyq3JIhryb7923Ij1b+1n+khmA=;
        b=Pa0lBBzOaor3N0+Z46Vzmq1v0FYKQkdeM08g8TZCBqFXm1PkCIeQZFwIQRKMYS1UEJ
         Bj6JVF5GajwX+mo8RNS7xGGGiJcTOP4vsfL0e2x1Ewe4tcltj7LGh+WwqAD7qtQeLTOK
         7HtLEOFSM4q7fTGak3gmuk/YFC1O3/F+BRh78IJH3KzcFZH5SBuvYoXBrpzTysdsRyKc
         Imf3o0FXLyXkGNGfruCKfCtjZ1RlWifkxO4veQmNUQj8MRvCASV/7qwMh8iFFQMiFj/5
         LYbE4/1j5PG9aLfPEySc+ccBPiV8YsIsSkYLQ8C9iHFm7C+iYqIXlOK476smSqfMJg80
         gHJA==
X-Gm-Message-State: AOJu0YwDkJ6lNco6aCPGC2wEyB7LHCnpZU1O3PYvI0Sluz1+sX1BOkKH
	xIeXIUSxlho+fAjjz1L5kHt1LJAaN1DSCwQrG3qH0MBqd0+EU34imBv4prPiScGySntLlFTTnp+
	hO/m8F9ZU1NYY3k6SKJV+MbihR4szwu0DTNZl9FCkLv4yRc8Xg7qR
X-Gm-Gg: AfdE7ckrJq7YprFUxA+oH97CnWYMLECfRbB9ok/ctOsKVW4SbKsTG9R8+TJ4actDT4m
	goajVijlGsrpU3KlKNtHJ7Dj8y4jEEg/P77YQ4hAoQHALXiBgHMbPqXIiVEFBhVD3osZkqilEP4
	O+tfG6fg4YT32gTN7fhcX5ZxyZ0uVAmm+DnaMf5ROKocNJWIXU2GmSKtU8hpg7J0FFRmT6l2W9M
	38Zeouhmt9NQKFTLnkQXmW2KX62c+kyXcG7EvTNAJDTvGMDT9ZTzTEcCmmV4Z0ONbr/uLghff1i
	m/DtOOmHFNrtf+DDydngXIJ8reHWaW40nukWiDXeXc81G8nm1YWS0cbEOr4F0S33V+Zx0uJnk9l
	P+AlLBu7ASY0tadlVfnNrIOBOcRYr
X-Received: by 2002:a05:6102:148e:b0:6c2:7d0d:e09f with SMTP id ada2fe7eead31-73433e3675amr1676645137.1.1782541178797;
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-73568fa2fb3sm414403137.15.2026.06.26.23.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 23:19:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id CBBBA402AE;
	Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C8D0DE40789; Sat, 27 Jun 2026 00:19:37 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [RFC PATCH 1/2] blk-integrity: add BLK_EXPECTED_REF_TAG_CAPABLE
Date: Sat, 27 Jun 2026 00:19:32 -0600
Message-ID: <20260627061933.2187447-2-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627061933.2187447-1-csander@purestorage.com>
References: <20260627061933.2187447-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BLK_EXPECTED_REF_TAG_CAPABLE to enum blk_integrity_flags to allow a
device to report support for specifying an expected initial ref tag in
I/O. Make blk_integrity_remap() a no-op if the flag is set, as the ref
tag seed used to generate/verify ref tags in the protection information
can be passed as the expected initial ref tag.

Ref tag remapping is necessary to merge bios with non-contiguous ref tag
seeds, as it converts both bios' ref tags to/from absolute integrity
interval numbers, which are contiguous. So don't merge bios to a
BLK_EXPECTED_REF_TAG_CAPABLE device if the next bio's ref tag seed
doesn't match the ref tag that would follow the end of the first bio.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/blk-integrity.c         | 18 ++++++++++++++++++
 block/t10-pi.c                |  3 ++-
 include/linux/blk-integrity.h |  2 ++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 964eebbee14d..85ebe13f0912 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -139,10 +139,12 @@ EXPORT_SYMBOL_GPL(blk_rq_integrity_map_user);
 
 bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 			    struct request *next)
 {
 	struct bio_integrity_payload *bip, *bip_next;
+	struct blk_integrity *bi;
+	u64 intervals;
 
 	if (blk_integrity_rq(req) == 0 && blk_integrity_rq(next) == 0)
 		return true;
 
 	if (blk_integrity_rq(req) == 0 || blk_integrity_rq(next) == 0)
@@ -155,10 +157,17 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 
 	if (bip->bip_flags & BIP_CHECK_APPTAG &&
 	    bip->app_tag != bip_next->app_tag)
 		return false;
 
+	bi = blk_get_integrity(req->bio->bi_bdev->bd_disk);
+	intervals = blk_rq_bytes(req) >> bi->interval_exp;
+	if (bip->bip_flags & BIP_CHECK_REFTAG &&
+	    bi->flags & BLK_EXPECTED_REF_TAG_CAPABLE &&
+	    bip->bip_iter.bi_sector + intervals != bip_next->bip_iter.bi_sector)
+		return false;
+
 	if (req->nr_integrity_segments + next->nr_integrity_segments >
 	    q->limits.max_integrity_segments)
 		return false;
 
 	if (integrity_req_gap_back_merge(req, next->bio))
@@ -169,11 +178,13 @@ bool blk_integrity_merge_rq(struct request_queue *q, struct request *req,
 
 bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 			     struct bio *bio)
 {
 	struct bio_integrity_payload *bip, *bip_bio = bio_integrity(bio);
+	struct blk_integrity *bi;
 	int nr_integrity_segs;
+	u64 intervals;
 
 	if (blk_integrity_rq(req) == 0 && bip_bio == NULL)
 		return true;
 
 	if (blk_integrity_rq(req) == 0 || bip_bio == NULL)
@@ -185,10 +196,17 @@ bool blk_integrity_merge_bio(struct request_queue *q, struct request *req,
 
 	if (bip->bip_flags & BIP_CHECK_APPTAG &&
 	    bip->app_tag != bip_bio->app_tag)
 		return false;
 
+	bi = blk_get_integrity(req->bio->bi_bdev->bd_disk);
+	intervals = blk_rq_bytes(req) >> bi->interval_exp;
+	if (bip->bip_flags & BIP_CHECK_REFTAG &&
+	    bi->flags & BLK_EXPECTED_REF_TAG_CAPABLE &&
+	    bip->bip_iter.bi_sector + intervals != bip_bio->bip_iter.bi_sector)
+		return false;
+
 	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
 		return false;
 
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 71367fd082bd..becf3e316b06 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -545,11 +545,12 @@ static void blk_integrity_remap(struct request *rq, unsigned int nr_bytes,
 	struct blk_integrity *bi = &rq->q->limits.integrity;
 	u64 ref = bio_integrity_intervals(bi, blk_rq_pos(rq));
 	unsigned intervals = nr_bytes >> bi->interval_exp;
 	struct bio *bio;
 
-	if (!(bi->flags & BLK_INTEGRITY_REF_TAG))
+	if (!(bi->flags & BLK_INTEGRITY_REF_TAG) ||
+	    bi->flags & BLK_EXPECTED_REF_TAG_CAPABLE)
 		return;
 
 	__rq_for_each_bio(bio, rq) {
 		__blk_reftag_remap(bio, bi, &intervals, &ref, prep);
 		if (!intervals)
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index c82b2f6fe194..e314d22d9922 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -13,10 +13,12 @@ enum blk_integrity_flags {
 	BLK_INTEGRITY_NOGENERATE	= 1 << 1,
 	BLK_INTEGRITY_DEVICE_CAPABLE	= 1 << 2,
 	BLK_INTEGRITY_REF_TAG		= 1 << 3,
 	BLK_INTEGRITY_STACKED		= 1 << 4,
 	BLK_SPLIT_INTERVAL_CAPABLE	= 1 << 5,
+	/* Device I/O specifies expected initial ref tag independent of LBA */
+	BLK_EXPECTED_REF_TAG_CAPABLE	= 1 << 6,
 };
 
 const char *blk_integrity_profile_name(struct blk_integrity *bi);
 bool queue_limits_stack_integrity(struct queue_limits *t,
 		struct queue_limits *b);
-- 
2.54.0

