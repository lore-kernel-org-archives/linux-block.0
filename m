Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CE3009C1
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624118; cv=none; b=kHvTTlOw/BYGltHL1bw8A0CgLCmmdmrrRcAR5dQTU8+tfG0oph/btyZSBId/PaCO94fuvPxmLjVSLruhi4nVyzlkas4xQVtcHwEQZv+4Xcd+w6wtI3eAG3Ok5Sw3cKe9PNJ9er8Zq+AxqrHMSl3Vg/MYRN9c+/nk5U86a9N0YBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624118; c=relaxed/simple;
	bh=d55kwcRMx1KoVkubZJSar3TZ+kanYObucfAJxZaoZMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9aBtUIX7oLl/epLBtmPgB1q1719gFq3Bhi023Hw6mtSqcTqbs9KEWG1Dmdi1MCNxVAPkeTiA+8cVmNemHILlD+cY/JOBrFllu6M8BR6e2C3QKwElkEfrpuKslHG9BVaDyqeWzEXwtTaaGOpWjvpVl1XBrzq4NQ8yDk0YtLRV4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=u6r1Smmg; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="u6r1Smmg"
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57JF48Xd1372251
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:21:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ywUH8rzLdPRtLd6zmKAam6emcQcvMZQwGCr+gJt0NgY=; b=u6r1Smmgnqfs
	yqDHdAABjzqEWMgpdSFpioSXufXTnCSUC0ZtnVKpNYIkfrpawvek17edAmG/QBkd
	DQv16yPyDrfHIWThvo6MQ38Lp8oAFphp0e1WoiIggvsCsuS+7qxLRITHQ36HH7O8
	mS5IKh7mLDieOMFckpQmVXIJOdvyjKtrsjeKcg5ELkIiqx7rUtZi1YEE1C+WNqCA
	Mf0P1fX0FFTdZys4Tx6Z1Z728gLzfAkkkQtZGY6AizXlhUuUfeAygTLIbwUcuy5N
	fTAm7GGxbCry2D3DAiwZHo9H2JUm8SK1heeuC9alEDMmrHV+Eb4LbNUlaSVDG8dn
	HNozSjDGHQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 48mujxsbc6-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Tue, 19 Aug 2025 10:21:55 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Tue, 19 Aug 2025 17:21:50 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 77208C89F1E; Tue, 19 Aug 2025 09:49:48 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <snitzer@kernel.org>, <axboe@kernel.dk>, <dw@davidwei.uk>,
        <brauner@kernel.org>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <djwong@kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/8] block: add size alignment to bio_iov_iter_get_pages
Date: Tue, 19 Aug 2025 09:49:16 -0700
Message-ID: <20250819164922.640964-3-kbusch@meta.com>
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
X-Proofpoint-ORIG-GUID: UEiS0dK6mtaUBZQGp2HzUy7tnlXNdph-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE2MSBTYWx0ZWRfX5r4pUPGJC9K8
 2t6M0odiulaUOF9tZ/pospbs7xQHeFPl1FoAYTp7s5CEYGFrwHApneRVnfCxVoOw58llYbXUD2Y
 /mQn+PRroBzvIJ2+sX2REDUCx+Bcv91v6/jZd2jmppHVPCByq1cYX7t8+GV+QeExsUb3/jJEhl9
 kwm8Qvjfr41zzl4ocMMMHsizWvAu5LI2QuBdPVlEZjJSqjn3tRTtNK1huzz5Ts7LIWg2/RWo5xm
 d70BuooT9MBscpaxF7UN1MUErbVeLTtjC76FnFmy7NQPI9eZcoZf1CttPbDdTLmqvAQhqjb6x0h
 fzz1V4p4XetlitXMfRROUwgNPBgbz2acuBaaYaMgw8T0ebQU4k+TD7DN3MHyW0h8LwcRMe4JL5z
 D1FhKwU7C0Soz6G40HZRTLs2UNZAW6YRauzVp6dbYY58+q3CMKF35mDjM+j/a3vX7fKcdRk8
X-Proofpoint-GUID: UEiS0dK6mtaUBZQGp2HzUy7tnlXNdph-
X-Authority-Analysis: v=2.4 cv=VMTdn8PX c=1 sm=1 tr=0 ts=68a4b2b3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yzNSm02vyakeHXeUMvAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_02,2025-08-14_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

The block layer tries to align bio vectors to the block device's logical
block size. Some cases don't have a block device, or we may want to align
to something larger, which we can't derive it from the queue limits.
Have the caller specify what they want, or allow any length alignment if
nothing was specified.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio.c          | 19 +++++++++++--------
 block/fops.c         |  9 ++++++---
 fs/iomap/direct-io.c |  3 ++-
 include/linux/bio.h  |  9 ++++++++-
 4 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3b371a5da159e..44286db14355f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1204,7 +1204,8 @@ static unsigned int get_contig_folio_len(unsigned i=
nt *num_pages,
  * For a multi-segment *iter, this function only adds pages from the nex=
t
  * non-empty segment of the iov iterator.
  */
-static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er)
+static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *it=
er,
+				    unsigned len_align_mask)
 {
 	iov_iter_extraction_t extraction_flags =3D 0;
 	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;
@@ -1213,7 +1214,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
 	struct page **pages =3D (struct page **)bv;
 	ssize_t size;
 	unsigned int num_pages, i =3D 0;
-	size_t offset, folio_offset, left, len;
+	size_t offset, folio_offset, left, len, trim;
 	int ret =3D 0;
=20
 	/*
@@ -1242,8 +1243,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
=20
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
=20
-	if (bio->bi_bdev) {
-		size_t trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
+	trim =3D size & len_align_mask;
+	if (trim) {
 		iov_iter_revert(iter, trim);
 		size -=3D trim;
 	}
@@ -1298,9 +1299,10 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 }
=20
 /**
- * bio_iov_iter_get_pages - add user or kernel pages to a bio
+ * bio_iov_iter_get_pages_aligned - add user or kernel pages to a bio
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be added
+ * @len_align_mask: the mask to align each vector size to, 0 for any len=
gth
  *
  * This takes either an iterator pointing to user memory, or one pointin=
g to
  * kernel pages (BVEC iterator). If we're adding user pages, we pin them=
 and
@@ -1317,7 +1319,8 @@ static int __bio_iov_iter_get_pages(struct bio *bio=
, struct iov_iter *iter)
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
  */
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *ite=
r,
+			   unsigned len_align_mask)
 {
 	int ret =3D 0;
=20
@@ -1333,12 +1336,12 @@ int bio_iov_iter_get_pages(struct bio *bio, struc=
t iov_iter *iter)
 	if (iov_iter_extract_will_pin(iter))
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 	do {
-		ret =3D __bio_iov_iter_get_pages(bio, iter);
+		ret =3D __bio_iov_iter_get_pages(bio, iter, len_align_mask);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
=20
 	return bio->bi_vcnt ? 0 : ret;
 }
-EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages_aligned);
=20
 static void submit_bio_wait_endio(struct bio *bio)
 {
diff --git a/block/fops.c b/block/fops.c
index 82451ac8ff25d..6d5c1e680d4a7 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -78,7 +78,8 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *=
iocb,
 	if (iocb->ki_flags & IOCB_ATOMIC)
 		bio.bi_opf |=3D REQ_ATOMIC;
=20
-	ret =3D bio_iov_iter_get_pages(&bio, iter);
+	ret =3D bio_iov_iter_get_pages_aligned(&bio, iter,
+				     bdev_logical_block_size(bdev) - 1);
 	if (unlikely(ret))
 		goto out;
 	ret =3D bio.bi_iter.bi_size;
@@ -212,7 +213,8 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb,=
 struct iov_iter *iter,
 		bio->bi_end_io =3D blkdev_bio_end_io;
 		bio->bi_ioprio =3D iocb->ki_ioprio;
=20
-		ret =3D bio_iov_iter_get_pages(bio, iter);
+		ret =3D bio_iov_iter_get_pages_aligned(bio, iter,
+					     bdev_logical_block_size(bdev) - 1);
 		if (unlikely(ret)) {
 			bio->bi_status =3D BLK_STS_IOERR;
 			bio_endio(bio);
@@ -348,7 +350,8 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb =
*iocb,
 		 */
 		bio_iov_bvec_set(bio, iter);
 	} else {
-		ret =3D bio_iov_iter_get_pages(bio, iter);
+		ret =3D bio_iov_iter_get_pages_aligned(bio, iter,
+					     bdev_logical_block_size(bdev) - 1);
 		if (unlikely(ret))
 			goto out_bio_put;
 	}
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 6f25d4cfea9f7..213764bdee8f2 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -434,7 +434,8 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter=
, struct iomap_dio *dio)
 		bio->bi_private =3D dio;
 		bio->bi_end_io =3D iomap_dio_bio_end_io;
=20
-		ret =3D bio_iov_iter_get_pages(bio, dio->submit.iter);
+		ret =3D bio_iov_iter_get_pages_aligned(bio, dio->submit.iter,
+				bdev_logical_block_size(iomap->bdev) - 1);
 		if (unlikely(ret)) {
 			/*
 			 * We have to stop part way through an IO. We must fall
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 519a1d59805f8..788a50ff319e3 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -441,7 +441,14 @@ int submit_bio_wait(struct bio *bio);
 int bdev_rw_virt(struct block_device *bdev, sector_t sector, void *data,
 		size_t len, enum req_op op);
=20
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_get_pages_aligned(struct bio *bio, struct iov_iter *ite=
r,
+		unsigned len_align_mask);
+
+static inline int bio_iov_iter_get_pages(struct bio *bio, struct iov_ite=
r *iter)
+{
+	return bio_iov_iter_get_pages_aligned(bio, iter, 0);
+}
+
 void bio_iov_bvec_set(struct bio *bio, const struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
--=20
2.47.3

