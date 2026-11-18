Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795037834;
	b=fEqHD+q97pxxPDQBlqZWtXH69k3Wtz+HRtvmJTAwilbj9c+zn9vYc/rRVI7kcUxWVZa1
	 LdU2Nrxjfxgm12UKODew5pAdbKkeTsEWYHxPjF3whvjq7ytxZwDaqqBcTwEXVNLZr8dec
	 QY4iBvS0ynUnF/4s+2ew4BFM5suWNv0NbDjgkZV142aRafQwZTQo8BuSdB/1Xgm/0fftu
	 fyRCbof4MyR7YOhIYXhHqE/QHH7DddQF3+RNN8SmlRH9e6D7rTBxemJ7tA7L6x8D9idtD
	 MyFSLseOL+FZOY662d9LQ0apHEm2Do7h8aMLuy5YGBdJXKVX4vVGrSORR5Wnpwxzh7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795037834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vnbJtG27pIY995fyqbhJH3BDZH2+CKUmjSvhuUbO5lA=;
	b=FA7yIUe1nZGNhMuPg8P0lkQ//g+7jgaaAZZZvz934bU8t8XzyVySd78wPhTo2Jwma7Am
	 Qisx9nGHNrzD0WqoGDyNTXHuIOFC65IWQmcMmQ+U3U+yDCObvXe1FEkTEL+92OLrjqrM8
	 bWy1RAHJmo2pum7frZhRdTiHZMu/NPhVl75dMCOeDRBxtTnqmDM9oh2EzeeyqhdiFOfxM
	 1CFj0HpsuJMSf99IXAM0i0kgV5W/HOSRaYqkGcXyKNPxBzAHq1igxsFwedQZP+3t4yLA5
	 7IcHwj0RTd89NuPCNMtsgOO0ioObelntGzlGPC2PUSlyhq/pA5JqHoxcSPGugmn2BQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCEIiHK1;
	arc=none smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4972606A32A
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 21:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4972606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rCEIiHK1
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b30ff12f84so10315507b3.2
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 13:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795037832; x=1795642632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vnbJtG27pIY995fyqbhJH3BDZH2+CKUmjSvhuUbO5lA=;
        b=rCEIiHK1j+9F+/7njnTEtrXp0zGyIP9MO667HkATGBYY//stBY4Nddtg87xJ/errRL
         LmNSNNg9qUTodUPHGJlbcwYe8UR3qL9JA8CEAj7EsNZbdjH2TVoz3OH2F1XPRJDFUbtc
         NOAZBXfIcWrklLeewObr/5D/UKth1lJnAeiaLuF1bmVaw5ZI8ByrOTf7ZjJEUe7LgEv0
         3k0CfKahU8pl5sUvVyVZXDH1uLJoI4EDl1mnLNuO7zSUDfTOFnyL6t4aSe+A4qmKR9Cu
         IzpL5cndaVmWZkYSvYsn+FqZ5buL2D5QWGv6W7SFXy4CVKPmCXwLcKXkPKNZ/+g5KTLC
         08kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795037832; x=1795642632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vnbJtG27pIY995fyqbhJH3BDZH2+CKUmjSvhuUbO5lA=;
        b=PBbFKEIV82dOxaJq/OKehR6rm4rqWtSgZuvzOTaKSVTxMj4Mt21MivH3eJ8PbCKwuG
         qsU0RVPVbT0o2y0xc+JMbMuGIZzFQlB+Dz/zYadkA+QSCA6EoegYsRYKOqUgg4saykC7
         MxM1QbKDCFub8eKLZ+VHYSsrxuxf8o/oBc5gCtH9C09icX6HRP4+MhyyALTM9eUbVeJ1
         MjcwC2UveACQ+6osYH/ndFjMlDFiYCIrPuVWt8JJkR4MsNEdol+2Olm7GY+UBGxwPssi
         vztK7J5rGsnH6srwIxMmI7/LS+L6rOG6df8zl7wKkRWeCbPe2mmUwi0LPG0DuOjWARIQ
         Jd6w==
X-Forwarded-Encrypted: i=1; AL+hErFydy0R1TKlpNj4kRzTwmKfSpWUb3fUCjtHU4kDlwVWrHBkl7RBJ61WjbcJ0IotoYW7MOY8YU3Es4STbg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9lEH4gjm65kawj8Y3gE3QZ7JA0odl7Ed5l01zjI5uWPq0doaqL
	VrQaPHbM3/1ePnqi90opnGpyWVZNp0JbDtJhcg52pbxrQqYa272e95xh
X-Gm-Gg: AZFdTZd9m992JuRvd8RQ6JbdE7YWJrhNhmh03/OimLLB+Fr1LmEPc1vaONW0aLiPK3c
	c442Rd1PLad5rbI2CwfKpdtCEsHoqH4IIloBa9iWc8OnwlNLnkKKL02rsijs3ZR5agiwoxjAbl3
	g679SuVmWxwe+Se8AjutHAgYcA5AkDcqAhwELiXqNue6hggzeLx7l1wHLKn/J1ewQzlvs90kIQR
	rhpSvxhZiskEiMYvqTh7AqKUInkpPYqz9KmmNTyiGZOxz01ImYw2POyzhIIZFtT+HzjeDwOEcW7
	Qpf3fv6MTvUuUS4yLsgLPrOs05YxxeKPER1FwOIV4I67YoQotDij8P5TSh1EBQSs5VDLtZMN3cI
	sjGFXb8cEPRflcMvf7CEgTnntCz4JRzBMK/KhIhqjcSE2W59bfRhc1eC2Xpvws3jgQ/UkCFU2+O
	/vRsNfRNy2EZuPBqaaSTQaWnRtdawtnpHTz55MI4wu7lznqYf1fcl1wlY4eUpYHvlA3RHIE3a7M
	Hace9+iO/E7mMOZ74sWm6lpGdVkaI0sT5t7k2FkSQgkXi1cLe23Ubs0ETZ51AptsUPh2FCMISlS
	2fCaDv/8dAjLV3sTuFsAzOs+gqI3REeYnyKD23YnSBmnGXKzF0PDrG0=
X-Received: by 2002:a05:690c:7486:b0:8b0:c71d:2b2b with SMTP id 00721157ae682-8b4fedae487mr20653577b3.45.1795037832273;
        Wed, 18 Nov 2026 13:37:12 -0800 (PST)
Received: from 5163NRD-SPrabh2.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4fe030be2sm24565697b3.10.2026.11.18.13.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 13:37:11 -0800 (PST)
From: Swarna Prabhu <sw.prabhu6@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	viro@zeniv.linux.org.uk
Cc: linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dave@stgolabs.net,
	riel@surriel.com,
	yeoreum.yun@arm.com,
	hch@lst.de,
	Swarna Prabhu <s.prabhu@samsung.com>
Subject: [PATCH 5/5] iov_iter: extract bvecs of user-backed iters from folio ranges
Date: Wed, 18 Nov 2026 13:34:58 -0800
Message-ID: <20261118213458.377258-6-sw.prabhu6@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118213458.377258-1-sw.prabhu6@gmail.com>
References: <20261118213458.377258-1-sw.prabhu6@gmail.com>
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

From: Swarna Prabhu <s.prabhu@samsung.com>

iov_iter_extract_bvecs() pins a page array placed in the bvec array and
then walks it with get_contig_folio_len() to merge pages that turn out to
belong to the same folio back into one bvec.

For user-backed iterators, have GUP fill folio ranges straight into the
free part of the bvec array instead. A folio range has the same size as
a bvec and becomes exactly one bvec, so each range is converted in its own
slot and trimmed to the requested byte range on the way. This removes the
page array and the merging pass. Ranges that are not converted are still
folio ranges and are unpinned with their exact page count.

Since one range covers many pages, the number of pages pinned per call is
no longer limited to one page per bvec entry; it is bounded by the bvec
array, plus a cap on how many pages a single GUP-fast walk looks at.

Memory that is not backed by folios, such as pages a driver inserted
into a VM_MIXEDMAP vma, makes pin_user_folio_ranges_fast() fail with
-EOPNOTSUPP when no pages were pinned; such iterators fall back to the
page array path.

Each extraction requests at most 1024 pages, bounding the amount of work
performed by a single GUP call.

Block direct I/O picks this up through bio_iov_iter_get_pages() without
any change to the block layer.

Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
---
 lib/iov_iter.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index fa4fe2e92383..457e226c0251 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1919,6 +1919,95 @@ static unsigned int get_contig_folio_len(struct page **pages,
 
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct page *))
 
+/*
+ * Upper limit on the number of pages a single GUP-fast walk is asked to look
+ * at to cap spending too much time in the GUP-fast path.
+ */
+#define EXTRACT_MAX_PAGES	1024
+
+/*
+ * Extract bvecs from a user-backed iterator.  GUP fills folio ranges straight
+ * into the free part of the bvec array, one range per run of consecutive pages
+ * of a folio.  A folio range has the same size as a bvec and turns into
+ * exactly one bvec, so each range is converted in its own slot.
+ *
+ * Returns -EOPNOTSUPP, with @iter left untouched, if the memory at the start of
+ * @iter is not backed by folios, so the caller can extract it as pages instead.
+ */
+static ssize_t iov_iter_extract_user_bvecs(struct iov_iter *iter,
+		struct bio_vec *bv, size_t max_size, unsigned short *nr_vecs,
+		unsigned short max_vecs, iov_iter_extraction_t extraction_flags)
+{
+	unsigned short entries_left = max_vecs - *nr_vecs;
+	unsigned int gup_flags = 0, nr_frs = 0, i;
+	unsigned long addr, nr_pages;
+	struct folio_range *frs;
+	size_t offset, left, len;
+	long res;
+
+	max_size = min_t(size_t, min_t(size_t, max_size, iter->count),
+			 MAX_RW_COUNT);
+	if (unlikely(!max_size))
+		return -EFAULT;
+	if (WARN_ON_ONCE(!entries_left))
+		return -ENOMEM;
+
+	if (iter->data_source == ITER_DEST)
+		gup_flags |= FOLL_WRITE;
+	if (extraction_flags & ITER_ALLOW_P2PDMA)
+		gup_flags |= FOLL_PCI_P2PDMA;
+	if (iter->nofault)
+		gup_flags |= FOLL_NOFAULT;
+
+	addr = first_iovec_segment(iter, &max_size);
+	offset = addr % PAGE_SIZE;
+	addr &= PAGE_MASK;
+	nr_pages = min_t(unsigned long,
+			 DIV_ROUND_UP(max_size + offset, PAGE_SIZE),
+			 EXTRACT_MAX_PAGES);
+
+	/*
+	 * Range i is converted into slot *nr_vecs + i, which is the memory it
+	 * lives in, so converting cannot overwrite a range that has not been
+	 * converted yet.
+	 */
+	BUILD_BUG_ON(sizeof(struct folio_range) != sizeof(struct bio_vec));
+	frs = (struct folio_range *)(bv + *nr_vecs);
+
+	res = pin_user_folio_ranges_fast(addr, nr_pages, gup_flags, frs,
+					 entries_left, &nr_frs);
+	if (unlikely(res <= 0))
+		return res ? res : -EFAULT;
+
+	/* We may have pinned fewer pages than asked for. */
+	max_size = min_t(size_t, max_size, res * PAGE_SIZE - offset);
+	iov_iter_advance(iter, max_size);
+
+	for (i = 0, left = max_size; left && i < nr_frs; i++) {
+		/* Copy it out first: bv[*nr_vecs] is the same memory as frs[i]. */
+		struct folio_range fr = frs[i];
+		struct page *page = folio_range_page(&fr);
+
+		if (*nr_vecs > 0 &&
+		    !zone_device_pages_have_same_pgmap(bv[*nr_vecs - 1].bv_page,
+						       page))
+			break;
+
+		len = min(folio_range_size(&fr) - offset, left);
+		bvec_set_folio(&bv[(*nr_vecs)++], fr.folio, len,
+			       folio_range_offset(&fr) + offset);
+		left -= len;
+		offset = 0;
+	}
+
+	/* Not overwritten, so still folio ranges; no-op once i == nr_frs. */
+	if (unlikely(i < nr_frs))
+		unpin_user_folio_ranges(&frs[i], nr_frs - i);
+
+	iov_iter_revert(iter, left);
+	return max_size - left;
+}
+
 /**
  * iov_iter_extract_bvecs - Extract bvecs from an iterator
  * @iter:	the iterator to extract from
@@ -1966,6 +2055,17 @@ ssize_t iov_iter_extract_bvecs(struct iov_iter *iter, struct bio_vec *bv,
 		return -EINVAL;
 	}
 
+	if (likely(user_backed_iter(iter))) {
+		size = iov_iter_extract_user_bvecs(iter, bv, max_size, nr_vecs,
+						   max_vecs, extraction_flags);
+		/*
+		 * Memory that is not backed by folios cannot be pinned as folio
+		 * ranges; fall back to pinning it as an array of pages.
+		 */
+		if (size != -EOPNOTSUPP)
+			return size;
+	}
+
 	/*
 	 * Move page array up in the allocated memory for the bio vecs as far as
 	 * possible so that we can start filling biovecs from the beginning
-- 
2.53.0

