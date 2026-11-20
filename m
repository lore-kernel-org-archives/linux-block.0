Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795190411;
	b=C6vzXqlzerWxegR+JdwzlCSBDY0GzGwsOpraK95Dhgs7p3M/Mc9pHwFGDceSboiQj4c1
	 mUW83dUdlZ2N+I+lvEmsw3UCIvS1SrFcSB0s83pnRCOvpRtWIdj0pIVAXxn+EYCmjsf3n
	 S02RPMlbmG/gaw4njTx/jhcJCqmMhBaqAxpI55jHDRpb1r5eqiKS6glWQw7uwQc9EAVtB
	 1HtoJRW68kDt8nZfHe+43vni70lgb8GVDND5lOC0U3YEmscsyjHZsg9qHi4npPZrqfpI1
	 xlZTmoeub6EUHhkhqOo5Y0rLXqMZFtcHcknuoYCKXpxepS8LsmVOlywEz96Tl/cHdOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190411;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SRS-Rewrite;
	bh=Gyd+o3rbJ0cvanHvrmWmlBzYCWCHR5gVRmr27oWkjQg=;
	b=ox/4j8fkIMCWpMAcnviAB7Lwm/HMTOazkKRGNgJhaHPOGt5SeVpyb73FgRo2W6l+FXTy
	 OqU7gFRwNpgJWbB6uKs7oBH+0YKkOypOZrRCUmScxooJxU2ph0zvgMsy6Djdst6wK8+1V
	 zy7vUNuXa/08IGG95HAWcPklZZjzFWL6x/Mw37R7drHTg4r+/oy1sBpdXqnRr5Bntf8rp
	 xuvsUYPiXEl8CCWP0OUEqySFxMLx/4iG94gRQUosV+HZjdhsE41ELZf6za0p4SDfBapky
	 C2BGgfpp2RFpyb6ECSMPVwWHp8rqDvS/YnHOjiQxsjvXxA6JcexDvZG4SebdA+c63ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=bombadil.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UObdxYBY;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E58606A332;
	Fri, 20 Nov 2026 16:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E58606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UObdxYBY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Gyd+o3rbJ0cvanHvrmWmlBzYCWCHR5gVRmr27oWkjQg=; b=UObdxYBYxDlovD3ovoOjHcRlGv
	cLU2YR6B7FghjvIZBOI+W/O7XTQgTP1gV9QY3mXxMoEnIYibO7tcw0RSwBB3NvrjJPWniHn4dxdkO
	HKbJh8SQ3dLCTRH8uth8z5EYhLjTSA0d3UX2phRXt+6TZCGbv37lM9eIcBDLRsGSwbXRT7cuSv/+9
	Jlo2n4WmDuq3nCJaGEs+q+G1crPOhb47IKhUX7vT2GIo0TTVSlrdYmfdD0OVcKojJfn6WN8BGRnao
	hNAhHt8a20Pt+cz0SmkiyqeSr7FyrfTsSfNscX/rZ7kdYr7JFLE1o15kSQpTSYosF8zll8WuXz9rE
	2Znj1YWw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUR21-0000000FUim-1fwT;
	Fri, 20 Nov 2026 16:00:09 +0000
Date: Fri, 20 Nov 2026 08:00:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block/t10-pi: deduplicate
 blk_reftag_remap_{prepare,complete}()
Message-ID: <awBuiVyOQj_YHCZD@infradead.org>
References: <20261120064806.752251-1-csander@purestorage.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120064806.752251-1-csander@purestorage.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Good idea.  But I think the new function name is a bit misleading and the
double ternary operators on a single initialization line obfuscate the
code compared to the old if/else.

Can we do something like this instead?

diff --git a/block/t10-pi.c b/block/t10-pi.c
index a19b4e102a83..f24ededd70a8 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -436,69 +436,32 @@ static void blk_tuple_remap_end(union pi_tuple *tuple, void *ptuple,
 	bvec_iter_advance(bip->bip_vec, iter, len);
 }
 
-static void blk_set_ext_unmap_ref(struct crc64_pi_tuple *pi, u64 virt,
-				  u64 ref_tag)
+static void blk_set_ext_remap_ref(struct crc64_pi_tuple *pi, u64 from, u64 to)
 {
 	u64 ref = get_unaligned_be48(&pi->ref_tag);
 
-	if (ref == lower_48_bits(ref_tag) && ref != lower_48_bits(virt))
-		put_unaligned_be48(virt, pi->ref_tag);
+	if (ref == lower_48_bits(from) && ref != lower_48_bits(to))
+		put_unaligned_be48(to, pi->ref_tag);
 }
 
-static void blk_set_t10_unmap_ref(struct t10_pi_tuple *pi, u32 virt,
-				  u32 ref_tag)
+static void blk_set_t10_remap_ref(struct t10_pi_tuple *pi, u32 from, u32 to)
 {
 	u32 ref = get_unaligned_be32(&pi->ref_tag);
 
-	if (ref == ref_tag && ref != virt)
-		put_unaligned_be32(virt, &pi->ref_tag);
+	if (ref == from && ref != to)
+		put_unaligned_be32(to, &pi->ref_tag);
 }
 
-static void blk_reftag_remap_complete(struct blk_integrity *bi,
-				      union pi_tuple *tuple, u64 virt, u64 ref)
+static void blk_tuple_remap(struct blk_integrity *bi, union pi_tuple *tuple,
+			     u64 from, u64 to)
 {
 	switch (bi->csum_type) {
 	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_unmap_ref(&tuple->crc64_pi, virt, ref);
+		blk_set_ext_remap_ref(&tuple->crc64_pi, from, to);
 		break;
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		blk_set_t10_unmap_ref(&tuple->t10_pi, virt, ref);
-		break;
-	default:
-		WARN_ON_ONCE(1);
-		break;
-	}
-}
-
-static void blk_set_ext_map_ref(struct crc64_pi_tuple *pi, u64 virt,
-				u64 ref_tag)
-{
-	u64 ref = get_unaligned_be48(&pi->ref_tag);
-
-	if (ref == lower_48_bits(virt) && ref != ref_tag)
-		put_unaligned_be48(ref_tag, pi->ref_tag);
-}
-
-static void blk_set_t10_map_ref(struct t10_pi_tuple *pi, u32 virt, u32 ref_tag)
-{
-	u32 ref = get_unaligned_be32(&pi->ref_tag);
-
-	if (ref == virt && ref != ref_tag)
-		put_unaligned_be32(ref_tag, &pi->ref_tag);
-}
-
-static void blk_reftag_remap_prepare(struct blk_integrity *bi,
-				     union pi_tuple *tuple,
-				     u64 virt, u64 ref)
-{
-	switch (bi->csum_type) {
-	case BLK_INTEGRITY_CSUM_CRC64:
-		blk_set_ext_map_ref(&tuple->crc64_pi, virt, ref);
-		break;
-	case BLK_INTEGRITY_CSUM_CRC:
-	case BLK_INTEGRITY_CSUM_IP:
-		blk_set_t10_map_ref(&tuple->t10_pi, virt, ref);
+		blk_set_t10_remap_ref(&tuple->t10_pi, from, to);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -524,9 +487,9 @@ static void __blk_reftag_remap(struct bio *bio, struct blk_integrity *bi,
 		ptuple = blk_tuple_remap_begin(&tuple, bi, bip, &iter);
 
 		if (prep)
-			blk_reftag_remap_prepare(bi, ptuple, virt, *ref);
+			blk_tuple_remap(bi, ptuple, virt, *ref);
 		else
-			blk_reftag_remap_complete(bi, ptuple, virt, *ref);
+			blk_tuple_remap(bi, ptuple, *ref, virt);
 
 		blk_tuple_remap_end(&tuple, ptuple, bi, bip, &iter);
 		(*intervals)--;
-- 
2.53.0

