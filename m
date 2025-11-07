Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6107082D
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762521329; cv=none; b=Wvv4y7Gbrk1s/UOMHDZ36JTbX/L5zo3PQDrVyP649xDt1t2gr7qmZupi+FoKxRuuDhOiieDc5uLO+722PIkdGp3MSXOSY5kZj9cuMpgAOZDihZyn97jrX9NHMRoBAVN7+n7HWAPmgzCn2dYf3aUbayojBAK0j2N3e+aFwb3hfLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762521329; c=relaxed/simple;
	bh=nx/tsrSF8zawOhIPvM1UhNWIE9Vf1GAQ8z5rTT1nr+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPx0gT6ldQq/oEY9mriuSa9HrkfUj4I8fEG8Q87KcAxH8KSBlny3RPufbwIpotm/d0BgHTLQWy1TB98qI4FrhvgGPQTsuYHLQo9FkN0YOk44HUY1qUj0t2ffDtrHkMfqraivDCmS1xaKRkjvnNYmCFVOyxwG6hHQhj1BQ9krSPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 46BD6227AAE; Fri,  7 Nov 2025 14:15:20 +0100 (CET)
Date: Fri, 7 Nov 2025 14:15:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, axboe@kernel.dk,
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] blk-integrity: support arbitrary buffer alignment
Message-ID: <20251107131519.GA3975@lst.de>
References: <20251107043447.3437347-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20251107043447.3437347-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2025 at 08:34:47PM -0800, Keith Busch wrote:
> This was tested using recently proposed io_uring metadata test case
> here:
> 
>   https://lore.kernel.org/io-uring/20251107042953.3393507-1-kbusch@meta.com/
> 
> The test purposefully contructs metadata with offsets that have the data
> integrity field straddle pages. As longs as they're not physically
> contiguous, that will split the field across multiple segments and test
> those conditions, which will either get a copy buffer if the device
> doesn't support multiple integrity segments, or get a temporary data
> integrity field copy during the reftag remapping.

Any chance we could get this test or something like it into blktests?

That way it would get regularly run as part of block layer validation.

The changes looks sensible to be, and pass very basic sanity testing
using my PI setup.  I have few cleanups we should get into (attached).

1: pass the union type down instead of casting to the t10/crc tuples
to improve type safety
2: fix W=1 warnings due to not quite kerneldoc comments
3: cleanup the copy wrappers that are only used once each
4: just always use the unaligned handlers.  I guess this might be a
bit contentious, but at least for x86 it actually generates better
code.  Alternatively we could require dword (4 byte) alignment for
PI, and only the guard tag in the crc64 format would require any
unaligned handling at all.

--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0001-pass-union-pi_tuple-down.patch"

From 0160966a9f74c9d60f3a8092a56ad5b429ae8bcb Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 7 Nov 2025 07:27:18 -0500
Subject: pass union pi_tuple down

Provide some extra type safety.
---
 block/t10-pi.c | 70 ++++++++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index dd0986b272bb..2702fe97e4fd 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -102,7 +102,7 @@ static void __blk_integrity_copy_from_tuple(struct bio_integrity_payload *bip,
 }
 
 static void blk_integrity_copy_from_tuple(struct blk_integrity_iter *iter,
-					  void *tuple)
+					  union pi_tuple *tuple)
 {
 	__blk_integrity_copy_from_tuple(iter->bip, &iter->prot_iter,
 					tuple, iter->bi->pi_tuple_size);
@@ -132,17 +132,16 @@ static void __blk_integrity_copy_to_tuple(struct bio_integrity_payload *bip,
 }
 
 static void blk_integrity_copy_to_tuple(struct blk_integrity_iter *iter,
-					void *tuple)
+					union pi_tuple *tuple)
 {
 	__blk_integrity_copy_to_tuple(iter->bip, &iter->prot_iter,
 					tuple, iter->bi->pi_tuple_size);
 }
 
-static void blk_set_ext_pi(void *prot_buf, struct blk_integrity_iter *iter)
+static void blk_set_ext_pi(struct crc64_pi_tuple *pi,
+			   struct blk_integrity_iter *iter)
 {
-	struct crc64_pi_tuple *pi = prot_buf;
-
-	if (unlikely((unsigned long)prot_buf & (sizeof(*pi) - 1))) {
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
 		put_unaligned_be64(iter->crc, &pi->guard_tag);
 		put_unaligned_be16(0, &pi->app_tag);
 		put_unaligned_be48(iter->seed, &pi->ref_tag);
@@ -153,11 +152,10 @@ static void blk_set_ext_pi(void *prot_buf, struct blk_integrity_iter *iter)
 	}
 }
 
-static void blk_set_t10_pi(void *prot_buf, struct blk_integrity_iter *iter)
+static void blk_set_t10_pi(struct t10_pi_tuple *pi,
+			   struct blk_integrity_iter *iter)
 {
-	struct t10_pi_tuple *pi = prot_buf;
-
-	if (unlikely((unsigned long)prot_buf & (sizeof(*pi) - 1))) {
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
 		put_unaligned_be16(iter->crc, &pi->guard_tag);
 		put_unaligned_be16(0, &pi->app_tag);
 		put_unaligned_be32(iter->seed, &pi->ref_tag);
@@ -168,12 +166,12 @@ static void blk_set_t10_pi(void *prot_buf, struct blk_integrity_iter *iter)
 	}
 }
 
-static void blk_set_ip_pi(void *prot_buf, struct blk_integrity_iter *iter)
+static void blk_set_ip_pi(struct t10_pi_tuple *pi,
+			  struct blk_integrity_iter *iter)
 {
 	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));
-	struct t10_pi_tuple *pi = prot_buf;
 
-	if (unlikely((unsigned long)prot_buf & (sizeof(*pi) - 1))) {
+	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
 		__put_unaligned_t(__be16, csum, &pi->guard_tag);
 		put_unaligned_be16(0, &pi->app_tag);
 		put_unaligned_be32(iter->seed, &pi->ref_tag);
@@ -271,29 +269,29 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 }
 
 static blk_status_t blk_integrity_verify(struct blk_integrity_iter *iter,
-					 void *tuple)
+					 union pi_tuple *tuple)
 {
 	switch (iter->bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		return ext_pi_crc64_verify(iter, tuple);
+		return ext_pi_crc64_verify(iter, &tuple->crc64_pi);
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		return t10_pi_verify(iter, tuple);
+		return t10_pi_verify(iter, &tuple->t10_pi);
 	default:
 		return BLK_STS_OK;
 	}
 }
 
 static void blk_integrity_set(struct blk_integrity_iter *iter,
-			      void *tuple)
+			      union pi_tuple *tuple)
 {
 	switch (iter->bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		return blk_set_ext_pi(tuple, iter);
+		return blk_set_ext_pi(&tuple->crc64_pi, iter);
 	case BLK_INTEGRITY_CSUM_CRC:
-		return blk_set_t10_pi(tuple, iter);
+		return blk_set_t10_pi(&tuple->t10_pi, iter);
 	case BLK_INTEGRITY_CSUM_IP:
-		return blk_set_ip_pi(tuple, iter);
+		return blk_set_ip_pi(&tuple->t10_pi, iter);
 	default:
 		WARN_ON_ONCE(1);
 		return;
@@ -467,18 +465,18 @@ static void blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
 	bvec_iter_advance(bip->bip_vec, iter, len);
 }
 
-static void blk_set_ext_unmap_ref(void *prot_buf, u64 virt, u64 ref_tag)
+static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
+				  u64 ref_tag)
 {
-	struct crc64_pi_tuple *pi = prot_buf;
 	u64 ref = get_unaligned_be48(&pi->ref_tag);
 
 	if (ref == lower_48_bits(virt) && ref != virt)
 		put_unaligned_be48(virt, pi->ref_tag);
 }
 
-static void blk_set_t10_unmap_ref(void *prot_buf, u32 virt, u32 ref_tag)
+static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
+				  u32 ref_tag)
 {
-	struct t10_pi_tuple *pi = prot_buf;
 	u32 ref;
 
 	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
@@ -495,16 +493,16 @@ static void blk_set_t10_unmap_ref(void *prot_buf, u32 virt, u32 ref_tag)
 		pi->ref_tag = cpu_to_be32(virt);
 }
 
-static void blk_reftag_remap_complete(struct blk_integrity *bi, void *tuple,
-				      u64 virt, u64 ref)
+static void blk_reftag_remap_complete(struct blk_integrity *bi,
+				      union pi_tuple *tuple, u64 virt, u64 ref)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_unmap_ref(tuple, virt, ref);
+		blk_set_ext_unmap_ref(&tuple->crc64_pi, virt, ref);
 		break;
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		blk_set_t10_unmap_ref(tuple, virt, ref);
+		blk_set_t10_unmap_ref(&tuple->t10_pi, virt, ref);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -512,18 +510,17 @@ static void blk_reftag_remap_complete(struct blk_integrity *bi, void *tuple,
 	}
 }
 
-static void blk_set_ext_map_ref(void *prot_buf, u64 virt, u64 ref_tag)
+static void blk_set_ext_map_ref(struct crc64_pi_tuple *pi, u64 virt,
+				u64 ref_tag)
 {
-	struct crc64_pi_tuple *pi = prot_buf;
 	u64 ref = get_unaligned_be48(&pi->ref_tag);
 
 	if (ref == lower_48_bits(virt) && ref != ref_tag)
 		put_unaligned_be48(ref_tag, pi->ref_tag);
 }
 
-static void blk_set_t10_map_ref(void *prot_buf, u32 virt, u32 ref_tag)
+static void blk_set_t10_map_ref(struct t10_pi_tuple *pi, u32 virt, u32 ref_tag)
 {
-	struct t10_pi_tuple *pi = prot_buf;
 	u32 ref;
 
 	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
@@ -540,16 +537,17 @@ static void blk_set_t10_map_ref(void *prot_buf, u32 virt, u32 ref_tag)
 		pi->ref_tag = cpu_to_be32(ref_tag);
 }
 
-static void blk_reftag_remap_prepare(struct blk_integrity *bi, void *tuple,
+static void blk_reftag_remap_prepare(struct blk_integrity *bi,
+				     union pi_tuple *tuple,
 				     u64 virt, u64 ref)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_map_ref(tuple, virt, ref);
+		blk_set_ext_map_ref(&tuple->crc64_pi, virt, ref);
 		break;
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		blk_set_t10_map_ref(tuple, virt, ref);
+		blk_set_t10_map_ref(&tuple->t10_pi, virt, ref);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -564,7 +562,7 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 	struct bvec_iter iter = bip->bip_iter;
 	u64 virt = bip_get_seed(bip);
 	union pi_tuple tuple;
-	void *ptuple;
+	union pi_tuple *ptuple;
 
 	if (prep && bip->bip_flags & BIP_MAPPED_INTEGRITY) {
 		*ref += bio->bi_iter.bi_size >> bi->interval_exp;
-- 
2.47.3


--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0002-un-kerneldoc.patch"

From 8e15595cf69757fd82623caaf7937cf49349c56d Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 7 Nov 2025 08:06:02 -0500
Subject: un-kerneldoc

Otherwise make W=1 complains.  For the copy helpers I dropped the
comments entirely as they don't seem to provide a value over just
the function names.
---
 block/t10-pi.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 2702fe97e4fd..203598f26596 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -57,9 +57,9 @@ static void blk_crc(struct blk_integrity_iter *iter, void *data,
 	}
 }
 
-/**
- * blk_integrity_crc_offset - update the crc for formats that have metadata
- * 			      padding in front of the data integrity field
+/*
+ * Update the crc for formats that have metadata padding in front of the data
+ * integrity field
  */
 static void blk_integrity_crc_offset(struct blk_integrity_iter *iter)
 {
@@ -78,9 +78,6 @@ static void blk_integrity_crc_offset(struct blk_integrity_iter *iter)
 	}
 }
 
-/**
- * __blk_integrity_copy_from_tuple() - copy from @tuple to @iter
- */
 static void __blk_integrity_copy_from_tuple(struct bio_integrity_payload *bip,
 					    struct bvec_iter *iter, void *tuple,
 					    unsigned int tuple_size)
@@ -108,9 +105,6 @@ static void blk_integrity_copy_from_tuple(struct blk_integrity_iter *iter,
 					tuple, iter->bi->pi_tuple_size);
 }
 
-/**
- * __blk_integrity_copy_to_tuple() - copy to &tuple from @iter
- */
 static void __blk_integrity_copy_to_tuple(struct bio_integrity_payload *bip,
 					  struct bvec_iter *iter, void *tuple,
 					  unsigned int tuple_size)
@@ -405,10 +399,9 @@ void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_iter)
 	}
 }
 
-/**
- * blk_pi_advance_offset - advance @iter past the protection offset
- *
- * For protection formats that contain front padding on the metadata region.
+/*
+ * Advance @iter past the protection offset for protection formats that
+ * contain front padding on the metadata region.
  */
 static void blk_pi_advance_offset(struct blk_integrity *bi,
 				  struct bio_integrity_payload *bip,
-- 
2.47.3


--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0003-simplify-copy-to-helpers.patch"

From 6b14968fcbcc6e0a5c9c13b02f467d04a12d8bb6 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 7 Nov 2025 08:08:39 -0500
Subject: simplify copy/to helpers

No real need for the wrappers that have a single caller.  Also make the
trivial comments non-kerneldoc as they don't document all paramters
anyway.
---
 block/t10-pi.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index 203598f26596..a3da845f03d9 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -78,9 +78,9 @@ static void blk_integrity_crc_offset(struct blk_integrity_iter *iter)
 	}
 }
 
-static void __blk_integrity_copy_from_tuple(struct bio_integrity_payload *bip,
-					    struct bvec_iter *iter, void *tuple,
-					    unsigned int tuple_size)
+static void blk_integrity_copy_from_tuple(struct bio_integrity_payload *bip,
+					  struct bvec_iter *iter, void *tuple,
+					  unsigned int tuple_size)
 {
 	void *prot_buf;
 
@@ -98,16 +98,9 @@ static void __blk_integrity_copy_from_tuple(struct bio_integrity_payload *bip,
 	}
 }
 
-static void blk_integrity_copy_from_tuple(struct blk_integrity_iter *iter,
-					  union pi_tuple *tuple)
-{
-	__blk_integrity_copy_from_tuple(iter->bip, &iter->prot_iter,
-					tuple, iter->bi->pi_tuple_size);
-}
-
-static void __blk_integrity_copy_to_tuple(struct bio_integrity_payload *bip,
-					  struct bvec_iter *iter, void *tuple,
-					  unsigned int tuple_size)
+static void blk_integrity_copy_to_tuple(struct bio_integrity_payload *bip,
+					struct bvec_iter *iter, void *tuple,
+					unsigned int tuple_size)
 {
 	void *prot_buf;
 
@@ -125,13 +118,6 @@ static void __blk_integrity_copy_to_tuple(struct bio_integrity_payload *bip,
 	}
 }
 
-static void blk_integrity_copy_to_tuple(struct blk_integrity_iter *iter,
-					union pi_tuple *tuple)
-{
-	__blk_integrity_copy_to_tuple(iter->bip, &iter->prot_iter,
-					tuple, iter->bi->pi_tuple_size);
-}
-
 static void blk_set_ext_pi(struct crc64_pi_tuple *pi,
 			   struct blk_integrity_iter *iter)
 {
@@ -307,7 +293,8 @@ static blk_status_t blk_integrity_interval(struct blk_integrity_iter *iter,
 		bvec_iter_advance_single(iter->bip->bip_vec, &iter->prot_iter,
 				iter->bi->metadata_size - iter->bi->pi_offset);
 	} else if (verify) {
-		blk_integrity_copy_to_tuple(iter, ptuple);
+		blk_integrity_copy_to_tuple(iter->bip, &iter->prot_iter,
+				ptuple, iter->bi->pi_tuple_size);
 	}
 
 	if (verify)
@@ -315,10 +302,13 @@ static blk_status_t blk_integrity_interval(struct blk_integrity_iter *iter,
 	else
 		blk_integrity_set(iter, ptuple);
 
-	if (likely(ptuple != &tuple))
+	if (likely(ptuple != &tuple)) {
 		kunmap_local(ptuple);
-	else if (!verify)
-		blk_integrity_copy_from_tuple(iter, ptuple);
+	} else if (!verify) {
+		blk_integrity_copy_from_tuple(iter->bip, &iter->prot_iter,
+				ptuple, iter->bi->pi_tuple_size);
+	}
+
 
 	iter->interval_remaining = 1 << iter->bi->interval_exp;
 	iter->crc = 0;
@@ -436,7 +426,7 @@ static void *blk_tuple_remap_begin(union pi_tuple *tuple,
 	 * copy_from_tuple at the end, so make a temp iter for here.
 	 */
 	titer = *iter;
-	__blk_integrity_copy_to_tuple(bip, &titer, tuple, bi->pi_tuple_size);
+	blk_integrity_copy_to_tuple(bip, &titer, tuple, bi->pi_tuple_size);
 	return tuple;
 }
 
@@ -450,8 +440,8 @@ static void blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
 	if (likely(ptuple != tuple)) {
 		kunmap_local(ptuple);
 	} else {
-		__blk_integrity_copy_from_tuple(bip, iter, ptuple,
-						bi->pi_tuple_size);
+		blk_integrity_copy_from_tuple(bip, iter, ptuple,
+				bi->pi_tuple_size);
 		len -= bi->pi_tuple_size;
 	}
 
-- 
2.47.3


--/04w6evG8XlLl3ft
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="0004-unaligned.patch"

From c73943c50ce29d8c453e9339a84258ea16340266 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 7 Nov 2025 07:42:38 -0500
Subject: unaligned

The unaligned handling isn't any more expensive on "sane" architectures.
In fact on x86 it compiles down to the same code as the aligned version,
just using slightly different register allocation.
---
 block/t10-pi.c | 97 +++++++++++---------------------------------------
 1 file changed, 21 insertions(+), 76 deletions(-)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a3da845f03d9..8225f4cc972d 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -121,29 +121,17 @@ static void blk_integrity_copy_to_tuple(struct bio_integrity_payload *bip,
 static void blk_set_ext_pi(struct crc64_pi_tuple *pi,
 			   struct blk_integrity_iter *iter)
 {
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
-		put_unaligned_be64(iter->crc, &pi->guard_tag);
-		put_unaligned_be16(0, &pi->app_tag);
-		put_unaligned_be48(iter->seed, &pi->ref_tag);
-	} else {
-		pi->guard_tag = cpu_to_be64(iter->crc);
-		pi->app_tag = 0;
-		put_unaligned_be48(iter->seed, &pi->ref_tag);
-	}
+	put_unaligned_be64(iter->crc, &pi->guard_tag);
+	put_unaligned((__be16)0, &pi->app_tag);
+	put_unaligned_be48(iter->seed, &pi->ref_tag);
 }
 
 static void blk_set_t10_pi(struct t10_pi_tuple *pi,
 			   struct blk_integrity_iter *iter)
 {
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
-		put_unaligned_be16(iter->crc, &pi->guard_tag);
-		put_unaligned_be16(0, &pi->app_tag);
-		put_unaligned_be32(iter->seed, &pi->ref_tag);
-	} else {
-		pi->guard_tag = cpu_to_be16(iter->crc);
-		pi->app_tag = 0;
-		pi->ref_tag = cpu_to_be32(iter->seed);
-	}
+	put_unaligned_be16(iter->crc, &pi->guard_tag);
+	put_unaligned((__be16)0, &pi->app_tag);
+	put_unaligned_be32(iter->seed, &pi->ref_tag);
 }
 
 static void blk_set_ip_pi(struct t10_pi_tuple *pi,
@@ -151,15 +139,9 @@ static void blk_set_ip_pi(struct t10_pi_tuple *pi,
 {
 	__be16 csum = (__force __be16)~(lower_16_bits(iter->crc));
 
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
-		__put_unaligned_t(__be16, csum, &pi->guard_tag);
-		put_unaligned_be16(0, &pi->app_tag);
-		put_unaligned_be32(iter->seed, &pi->ref_tag);
-	} else {
-		pi->guard_tag = csum;
-		pi->app_tag = 0;
-		pi->ref_tag = cpu_to_be32(iter->seed);
-	}
+	__put_unaligned_t(__be16, csum, &pi->guard_tag);
+	put_unaligned_be16(0, &pi->app_tag);
+	put_unaligned_be32(iter->seed, &pi->ref_tag);
 }
 
 static bool ext_pi_ref_escape(const u8 ref_tag[6])
@@ -172,18 +154,10 @@ static bool ext_pi_ref_escape(const u8 ref_tag[6])
 static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 					struct crc64_pi_tuple *pi)
 {
-	u64 guard, ref, seed = lower_48_bits(iter->seed);
-	u16 app;
-
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
-		guard = get_unaligned_be64(&pi->guard_tag);
-		app = get_unaligned_be16(&pi->app_tag);
-		ref = get_unaligned_be48(pi->ref_tag);
-	} else {
-		guard = be64_to_cpu(pi->guard_tag);
-		app = be16_to_cpu(pi->app_tag);
-		ref = get_unaligned_be48(pi->ref_tag);
-	}
+	u64 seed = lower_48_bits(iter->seed);
+	u64 guard = get_unaligned_be64(&pi->guard_tag);
+	u64 ref = get_unaligned_be48(pi->ref_tag);
+	u16 app = get_unaligned_be16(&pi->app_tag);
 
 	if (iter->bi->flags & BLK_INTEGRITY_REF_TAG) {
 		if (app == APP_TAG_ESCAPE)
@@ -211,19 +185,10 @@ static blk_status_t ext_pi_crc64_verify(struct blk_integrity_iter *iter,
 static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 				  struct t10_pi_tuple *pi)
 {
-	u32 ref, seed = lower_32_bits(iter->seed);
-	u16 guard;
-	u16 app;
-
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1))) {
-		guard = get_unaligned_be16(&pi->guard_tag);
-		app = get_unaligned_be16(&pi->app_tag);
-		ref = get_unaligned_be32(&pi->ref_tag);
-	} else {
-		guard = be16_to_cpu(pi->guard_tag);
-		app = be16_to_cpu(pi->app_tag);
-		ref = be32_to_cpu(pi->ref_tag);
-	}
+	u32 seed = lower_32_bits(iter->seed);
+	u32 ref = get_unaligned_be32(&pi->ref_tag);
+	u16 guard = get_unaligned_be16(&pi->guard_tag);
+	u16 app = get_unaligned_be16(&pi->app_tag);
 
 	if (iter->bi->flags & BLK_INTEGRITY_REF_TAG) {
 		if (app == APP_TAG_ESCAPE)
@@ -460,20 +425,10 @@ static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
 static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
 				  u32 ref_tag)
 {
-	u32 ref;
+	u32 ref = get_unaligned_be32(&pi->ref_tag);
 
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
-		ref = get_unaligned_be32(&pi->ref_tag);
-	else
-		ref = be32_to_cpu(pi->ref_tag);
-
-	if (ref != ref_tag || ref == virt)
-		return;
-
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
+	if (ref == ref_tag && ref != virt)
 		put_unaligned_be32(virt, &pi->ref_tag);
-	else
-		pi->ref_tag = cpu_to_be32(virt);
 }
 
 static void blk_reftag_remap_complete(struct blk_integrity *bi,
@@ -504,20 +459,10 @@ static void blk_set_ext_map_ref(struct crc64_pi_tuple *pi, u64 virt,
 
 static void blk_set_t10_map_ref(struct t10_pi_tuple *pi, u32 virt, u32 ref_tag)
 {
-	u32 ref;
+	u32 ref = get_unaligned_be32(&pi->ref_tag);
 
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
-		ref = get_unaligned_be32(&pi->ref_tag);
-	else
-		ref = be32_to_cpu(pi->ref_tag);
-
-	if (ref != virt || ref == ref_tag)
-		return;
-
-	if (unlikely((unsigned long)pi & (sizeof(*pi) - 1)))
+	if (ref == virt && ref != ref_tag)
 		put_unaligned_be32(ref_tag, &pi->ref_tag);
-	else
-		pi->ref_tag = cpu_to_be32(ref_tag);
 }
 
 static void blk_reftag_remap_prepare(struct blk_integrity *bi,
-- 
2.47.3


--/04w6evG8XlLl3ft--
