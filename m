Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E822279795
	for <linux-block@vger.kernel.org>; Tue,  5 Aug 2025 14:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754403099; cv=none; b=IReRUV7inJ5WbJvHv0LQzZ54WIFB31U4seO4gw9LNDjxWgjHd6ZcYmuunU5w+sPeYqOtrxhQWf8kUlBTcaWXfdtMKaGD1zDGAMtIM0792hvh5RsQj1680OoEqHC2muOG6AG64vtISGhmHHdxgnytC9NYq4WBadomlP7Cc4QnMOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754403099; c=relaxed/simple;
	bh=UVyMyNSWmKVpdo2b8zlviQrB93mojZdGTaqeAGXZkZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3yOX+TVP2QeNq1r3SqD5bTB+THsOUE60Xsa2foKGzEsevzJMPmZkexeeyOJb/BOxu10eUjYtsN+ZGDzGMclKGpX499dHKvF9gL6/PXR1jPGdMqAGse/n36E+Xz6rPwVxhOwFJ+jVrfvb6ilqY0PdfrXfVu+1MXsSAQQH1tfYjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vR4z1u3E; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vR4z1u3E"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 575CYQMh015353
	for <linux-block@vger.kernel.org>; Tue, 5 Aug 2025 07:11:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=q9rfR/CPErdS7PfZ2eWN7JXXGJ1kaWhdntYdyMqVQE0=; b=vR4z1u3E4IGd
	cvf9AjEaKuc7OIhjv4AsUrX/xXOWuXH85irR+j9HGampukqIwqcpl5jBcWYf6O6A
	FV23TZPoMIko8cyNDuCHbe2Uqc6stltlfgZfCoi8rKU6I1amt26q5MGvqYG/wW+a
	BR7glaVT09yW5h7UZg0fr0yWsDOzz2LuWJ36gDSykO3/DlrfNHQksVKDp/2aRRvI
	WJWrLNh5XgBMyEZBhHvMaXzO5jND42+HFhEct1aKsT74bZA7cFiCph+d20R7aSsU
	8Jq/CjlW1+YWu46EYIuZx/HVydb+FjvlrshKVf4f7q30V/ziS1mTExPtG/3smSOi
	VpTEQKQpsA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48bdg9aay0-17
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 05 Aug 2025 07:11:36 -0700 (PDT)
Received: from twshared0973.10.ash9.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 5 Aug 2025 14:11:27 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 05F1D4FDD56; Tue,  5 Aug 2025 07:11:24 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 7/7] iov_iter: remove iov_iter_is_aligned
Date: Tue, 5 Aug 2025 07:11:23 -0700
Message-ID: <20250805141123.332298-8-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250805141123.332298-1-kbusch@meta.com>
References: <20250805141123.332298-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=dLymmPZb c=1 sm=1 tr=0 ts=68921118 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=S-mNSWGAXQVMvOK0xjcA:9
X-Proofpoint-ORIG-GUID: 5yoyu9uVUg4DcFmcHfk1Eldn39a1im3a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwNCBTYWx0ZWRfX76tNuSXda84n BcLl4vf21xyyeRV0TZxoVE5us03VzVuJ6FxSL92a3C3jdSRgxkUTbQZ5FRSN175Ob1nbRjRMVYR 6/crvTURYgtkJRRng9etSG7gq95N4n7+vYNMtO/7dGViJaMS36dc4QXbGRpRBO4tjgO+yizhn/1
 BujXMLhuqRxcvXtQo51HobBbXrMHK2cjDTcCHdkRxPUuRX2RJW6OUH1zVCVjfkVJkezA0jB/RHe ZfeIzbMpHnuoizOgrxYt39rOIGtHQyanBCmIxlP6sDZFlT9hept+grO1GyM4zGWJHZUWsWAUhkh QhAHberBYD33ZXQwR0o20Nphm2mJZ5m0uP5i3Pz1PH2mlhifE/vYmMEnq3qVR6QztRi0zEgfTfn
 uf3Yx7xgU6cUgRML8Fp+0Dshpg8bKZfVJ5pqWi2jmLUSUpVHcGq5nvgOwIWfmtWWwFVElIaF
X-Proofpoint-GUID: 5yoyu9uVUg4DcFmcHfk1Eldn39a1im3a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_04,2025-08-04_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

No more callers.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Mike Snitzer <snitzer@kernel.org>
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

