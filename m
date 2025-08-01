Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC42288EA
	for <linux-block@vger.kernel.org>; Fri,  1 Aug 2025 23:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754092072; cv=none; b=q33r4fdFxPJKgKsir2Sc+8JClwpRhuavK/KEhPM25VNp6LL9zZOcqjcf+1+1gITZBo+5Rx80+NgxiI9myOd2izkUDsRK7o33UDpKjgpJO0czh7Vmbus7qDEoe/eTnae34keh4PCVgb10MzDvc8pUrTrl/JPtKvij/wogtZ1zDIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754092072; c=relaxed/simple;
	bh=nNMJpt4aTazPhFYIswuKSHnf0hEokcerPGAzDvlAalQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rk7oL7tTND0JsiZc1XtxASL+3uuJyo7CY6kYutZt5JkwdgWKudMD4tDC93xWaqh62UtKakVNEvLDkf/DKLikjlVh0w05d1d78iMsvSbKb9P5BFEI4GE7zjlchqzZfLtXJ6hqgia0RKc9G22BsG1NZ9+d9qnBSlq7mswTYynd/hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=VVON6fX2; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="VVON6fX2"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 571MmoTt020635
	for <linux-block@vger.kernel.org>; Fri, 1 Aug 2025 16:47:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=i1ss4/LYa+hED3hp9nPUkfjNAhsGNQe261dA6YSsJDQ=; b=VVON6fX2rCS9
	NvGEvPi3Aoog4HTdo3wmGbQqvwvMxeCcoYVF5XfH/s1cl7qe1CkxY9LTwWxBl7G6
	9qFP2Koysz53K5nRGPaAsB91GnLEmzMrax/G6fiMJ+aB+2rrOQSIHUSscqiFoU/K
	vFLmCTIn5PhyOwto7X9JnhO6fmwM/eh7BiPAz/f1tQ/tKgaHku0TF52InrZbPwVa
	rWN35li0oSB/woAZ1BXPwNQIVXb9EBOOZhcgkJCl+/hW0A0FosivSumlVXpwR5ae
	xEvQ7fRmQh8PMVe/o399ezy698mFyyNUgGANFqupraJhl+Htcf7Uvx8EWivCxeQs
	pcrVtbjSCg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 488rmynk9w-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 01 Aug 2025 16:47:50 -0700 (PDT)
Received: from twshared21625.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 23:47:45 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id CF7ED3105F8; Fri,  1 Aug 2025 16:47:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 7/7] iov_iter: remove iov_iter_is_aligned
Date: Fri, 1 Aug 2025 16:47:36 -0700
Message-ID: <20250801234736.1913170-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250801234736.1913170-1-kbusch@meta.com>
References: <20250801234736.1913170-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=DptW+H/+ c=1 sm=1 tr=0 ts=688d5226 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=S-mNSWGAXQVMvOK0xjcA:9
X-Proofpoint-ORIG-GUID: D-C0SZFoKyK_l-p1AcVtU5n1n3mIKydh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDE5MyBTYWx0ZWRfX6AV2cHXwDFpn 2sWkSswVaRVoZHJARiUKRFDuhMYtNJ7KcFSPK2PRfWZ1YlPYWHPHZopaL/iPk1SR5LUJLd7xdiX K7wRLN4sI1klyIsmOzPw7LotKC3gAODUHwxjkfXbO8Su89lsz8lNTZhXZZKHkbiQCGqnj3BizWQ
 7N7PeOj7Wn21485mZ2FQVcB8jhCTQdXaiG4klrOef549fwoce4k7kVTI032i6c/N943cPGtNC9m X5MtOzfpx+N9LMNgbvtFrCGEWlv7+pRqEvGv49NyqC+54dcvz+XED7LUE/8Q2UcjuZ7lZnyFjG7 HcjUfQiIfP6kYQpZ5h8CmQDjvafJKm6POkmG+UQggfgdlQAzQmt+RjyAof3Gs4+mMggBm9xSImK
 dc8uyhQBwBLi+pTcgBL/9cG4DxoCBveysmy5w0NYSW9grmPByndHFBF4lJXKhGHsDFHZxjOo
X-Proofpoint-GUID: D-C0SZFoKyK_l-p1AcVtU5n1n3mIKydh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_08,2025-08-01_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/uio.h |  2 -
 lib/iov_iter.c      | 95 ---------------------------------------------
 2 files changed, 97 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 2e86c653186c6..5b127043a1519 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -286,8 +286,6 @@ size_t _copy_mc_to_iter(const void *addr, size_t byte=
s, struct iov_iter *i);
 #endif
=20
 size_t iov_iter_zero(size_t bytes, struct iov_iter *);
-bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
-			unsigned len_mask);
 unsigned long iov_iter_alignment(const struct iov_iter *i);
 unsigned long iov_iter_gap_alignment(const struct iov_iter *i);
 void iov_iter_init(struct iov_iter *i, unsigned int direction, const str=
uct iovec *iov,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f9193f952f499..2fe66a6b8789e 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -784,101 +784,6 @@ void iov_iter_discard(struct iov_iter *i, unsigned =
int direction, size_t count)
 }
 EXPORT_SYMBOL(iov_iter_discard);
=20
-static bool iov_iter_aligned_iovec(const struct iov_iter *i, unsigned ad=
dr_mask,
-				   unsigned len_mask)
-{
-	const struct iovec *iov =3D iter_iov(i);
-	size_t size =3D i->count;
-	size_t skip =3D i->iov_offset;
-
-	do {
-		size_t len =3D iov->iov_len - skip;
-
-		if (len > size)
-			len =3D size;
-		if (len & len_mask)
-			return false;
-		if ((unsigned long)(iov->iov_base + skip) & addr_mask)
-			return false;
-
-		iov++;
-		size -=3D len;
-		skip =3D 0;
-	} while (size);
-
-	return true;
-}
-
-static bool iov_iter_aligned_bvec(const struct iov_iter *i, unsigned add=
r_mask,
-				  unsigned len_mask)
-{
-	const struct bio_vec *bvec =3D i->bvec;
-	unsigned skip =3D i->iov_offset;
-	size_t size =3D i->count;
-
-	do {
-		size_t len =3D bvec->bv_len - skip;
-
-		if (len > size)
-			len =3D size;
-		if (len & len_mask)
-			return false;
-		if ((unsigned long)(bvec->bv_offset + skip) & addr_mask)
-			return false;
-
-		bvec++;
-		size -=3D len;
-		skip =3D 0;
-	} while (size);
-
-	return true;
-}
-
-/**
- * iov_iter_is_aligned() - Check if the addresses and lengths of each se=
gments
- * 	are aligned to the parameters.
- *
- * @i: &struct iov_iter to restore
- * @addr_mask: bit mask to check against the iov element's addresses
- * @len_mask: bit mask to check against the iov element's lengths
- *
- * Return: false if any addresses or lengths intersect with the provided=
 masks
- */
-bool iov_iter_is_aligned(const struct iov_iter *i, unsigned addr_mask,
-			 unsigned len_mask)
-{
-	if (likely(iter_is_ubuf(i))) {
-		if (i->count & len_mask)
-			return false;
-		if ((unsigned long)(i->ubuf + i->iov_offset) & addr_mask)
-			return false;
-		return true;
-	}
-
-	if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i)))
-		return iov_iter_aligned_iovec(i, addr_mask, len_mask);
-
-	if (iov_iter_is_bvec(i))
-		return iov_iter_aligned_bvec(i, addr_mask, len_mask);
-
-	/* With both xarray and folioq types, we're dealing with whole folios. =
*/
-	if (iov_iter_is_xarray(i)) {
-		if (i->count & len_mask)
-			return false;
-		if ((i->xarray_start + i->iov_offset) & addr_mask)
-			return false;
-	}
-	if (iov_iter_is_folioq(i)) {
-		if (i->count & len_mask)
-			return false;
-		if (i->iov_offset & addr_mask)
-			return false;
-	}
-
-	return true;
-}
-EXPORT_SYMBOL_GPL(iov_iter_is_aligned);
-
 static unsigned long iov_iter_alignment_iovec(const struct iov_iter *i)
 {
 	const struct iovec *iov =3D iter_iov(i);
--=20
2.47.3

