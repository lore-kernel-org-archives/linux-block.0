Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA349302CBD
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 17:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624110; cv=none; b=OTacpjoo9DimsAv+LLbdQ6RKbjam0TX4n3/D8oNxybwz7BvoMTXuvD7HaJVbmhtwC7dnsiz1cC9JoCdgGROcnbnGY0pO64IEyOlAHOUTfnPgfBigiUDEsZCvQ2q3X9bCSngVZWkHRvmD6vkfjy1CvSgGZ22wpCPzgodN40s5d0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624110; c=relaxed/simple;
	bh=TWoOsiZ0IFt8B4EUf1EUA6ESHMfjgikOE6nFuSSlrdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLAjTutwvivMDYvTBIH1XGs5fMkb1pM4YOgwrTA3JLmYQi5cIESPA4g54xrrVpiGvSmfcR+73doQO8Ai9xIgt8d0Xdfw5aHm4USoFWHww9udJnJew8/9vXunGmgBcvcMtnt0RJSXkyQn3lwsrr4UmNV4Ikc/3at+bOdsiz+AcGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jjXIsKaa; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jjXIsKaa"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JF431I1371927
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:21:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=NiaPiqR2hZXsEYHHljegcFsS1Sik31TtdKS1Obn1qik=; b=jjXIsKaaZuV1
	S1tnHc53Qiofa+del4vP3QabdYhRW2uXUBmJzOY0P5QX5kZmHL8BbweeJNRLW2Kl
	HDD94FuTHkGUeQQwpmqlAVpfjoax4n19owjHXcGrduEwqBhCkvAomht/O7PJze1f
	XEJVdNrqOuIyrJaJwzJ6Fqt1fHLWeqGR/3YxmUTdteQQuGiC6pS2/0+kw7TSPEpC
	3wC8Gm+x5ZbMSsx+JW3LRogZfPD4SnonDMu98+/685VsPFo/PFHtK96Jpdj2BTHZ
	/J3YqNxE4xw7MD0oTMsYDFxJa+w5MYHGd96Ak/WXiHbDoqfDB7iWUaOp9ig5qk5q
	JHK8dgtQAA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48mujxsbau-13
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:21:47 -0700 (PDT)
Received: from twshared42488.16.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:21:41 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 781B1C89F20; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/8] block: align the bio after building it
Date: Tue, 19 Aug 2025 09:49:17 -0700
Message-ID: <20250819164922.640964-4-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250819164922.640964-1-kbusch@meta.com>
References: <20250819164922.640964-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VFwxk3-k8BJjzLXyNeGIh-sFtZ7_0DHb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MSBTYWx0ZWRfX1jVGahKc5gMN
 7MhR0QTdlHwsi10wn9UAprmoIlyQd4iGU5ow6N/bfnzFASlxIeSmLFnpBr8Uz1owAYqsW/kAZ4e
 m7wkmS+Vulor95+ef3SEypVvuh6nKFlr7vPX43pjcoaGmdYpjyoOYMUA7anLGB98JDgugDQ8/E9
 fij1nGl4fXqMasS62Ty0mynCMSH7T4qt0SzefqZ/HRsSIe45mwdxa97KsYkp8XhnNtoiUo5O0wc
 6orWJAcbYqyVq3Q3pP/8TueIBiu6AjN/l1KNk0Jn/iobWT6eDOyhsL38o5xCcPJ1qrQNtrMUzBO
 u+4eGC0nDM7nxgRZn9SQUeldz6wSqvQa+5TELu4kRi1TyuX5WNvbBGTmRDF8fbRgtXQLvJeI9Oq
 KSHdwOWZir5SEIryN6rI72IlbSAtofYrZNlFToxuau0TBWVGtn6thmB5NPiuPZjYLLfWonF5
X-Proofpoint-GUID: VFwxk3-k8BJjzLXyNeGIh-sFtZ7_0DHb
X-Authority-Analysis: v=2.4 cv=VMTdn8PX c=1 sm=1 tr=0 ts=68a4b2ac cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=YLIuIqOInwJuuOtFGpUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Instead of ensuring each vector is block size aligned while constructing
the bio, just ensure the entire size is aligned after it's built. This
makes getting bio pages more flexible to accepting device valid io
vectors that would otherwise get rejected by alignment checks.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c | 65 ++++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 44286db14355f..00bd5c76c461f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1204,8 +1204,7 @@ static unsigned int get_contig_folio_len(unsigned i=
nt *num_pages,
  * For a multi-segment *iter, this function only adds pages from the nex=
t
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er,
-				    unsigned len_align_mask)
+static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er)
 {
 	iov_iter_extraction_t extraction_flags =3D 0;
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
@@ -1214,7 +1213,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter,
 	struct page **pages =3D (struct page **)bv;
 	ssize_t size;
 	unsigned int num_pages, i =3D 0;
-	size_t offset, folio_offset, left, len, trim;
+	size_t offset, folio_offset, left, len;
 	int ret =3D 0;
=20
 	/*
@@ -1228,13 +1227,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter,
 	if (bio->bi_bdev && blk_queue_pci_p2pdma(bio->bi_bdev->bd_disk->queue))
 		extraction_flags |=3D ITER_ALLOW_P2PDMA;
=20
-	/*
-	 * Each segment in the iov is required to be a block size multiple.
-	 * However, we may not be able to get the entire segment if it spans
-	 * more pages than bi_max_vecs allows, so we have to ALIGN_DOWN the
-	 * result to ensure the bio's total size is correct. The remainder of
-	 * the iov data will be picked up in the next bio iteration.
-	 */
 	size =3D iov_iter_extract_pages(iter, &pages,
 				      UINT_MAX - bio->bi_iter.bi_size,
 				      nr_pages, extraction_flags, &offset);
@@ -1242,18 +1234,6 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter,
 		return size ? size : -EFAULT;
=20
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
-
-	trim =3D size & len_align_mask;
-	if (trim) {
-		iov_iter_revert(iter, trim);
-		size -=3D trim;
-	}
-
-	if (unlikely(!size)) {
-		ret =3D -EFAULT;
-		goto out;
-	}
-
 	for (left =3D size, i =3D 0; left > 0; left -=3D len, i +=3D num_pages)=
 {
 		struct page *page =3D pages[i];
 		struct folio *folio =3D page_folio(page);
@@ -1298,11 +1278,44 @@ static int __bio_iov_iter_get_pages(struct bio *b=
io, struct iov_iter *iter,
 	return ret;
 }
=20
+/*
+ * Aligns the bio size to the len_align_mask, releasing any excessive bi=
o vecs
+ * that  __bio_iov_iter_get_pages may have inserted and reverts that len=
gth for
+ * the next iteration.
+ */
+static int bio_align(struct bio *bio, struct iov_iter *iter,
+			    unsigned len_align_mask)
+{
+	size_t nbytes =3D bio->bi_iter.bi_size & len_align_mask;
+
+	if (!nbytes)
+		return 0;
+
+	iov_iter_revert(iter, nbytes);
+	bio->bi_iter.bi_size -=3D nbytes;
+	while (nbytes) {
+		struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];
+
+		if (nbytes < bv->bv_len) {
+			bv->bv_len -=3D nbytes;
+			nbytes =3D 0;
+		} else {
+			bio_release_page(bio, bv->bv_page);
+			bio->bi_vcnt--;
+			nbytes -=3D bv->bv_len;
+		}
+	}
+
+	if (!bio->bi_iter.bi_size)
+		return -EFAULT;
+	return 0;
+}
+
 /**
  * bio_iov_iter_get_pages_aligned - add user or kernel pages to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be added
- * @len_align_mask: the mask to align each vector size to, 0 for any len=
gth
+ * @len_align_mask: the mask to align the total size to, 0 for any lengt=
h
  *
  * This takes either an iterator pointing to user memory, or one pointin=
g to
  * kernel pages (BVEC iterator). If we're adding user pages, we pin them=
 and
@@ -1336,10 +1349,12 @@ int bio_iov_iter_get_pages_aligned(struct bio *bi=
o, struct iov_iter *iter,
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	do {
-		ret =3D __bio_iov_iter_get_pages(bio, iter, len_align_mask);
+		ret =3D __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
-	return bio->bi_vcnt ? 0 : ret;
+	if (bio->bi_vcnt && len_align_mask)
+		return bio_align(bio, iter, len_align_mask);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages_aligned);
=20
--=20
2.47.3

