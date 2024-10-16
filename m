Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68A1C1741
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109609; cv=none; b=DQmpi6UNMTHXu6vEkekIsl+jvisIauBTO7TzUfXu/SS7U2+fEhL37337yTJ7Zl2QQUpgiuyjWUE0wiPf91BkZp5AKRz2W3R/75zBpk/e56wWZP6+uGY4xgrUghG+nXqnwxaXvt5bW3w1lOUtisZ25Jf52aKFZ3RRl6eDdDzPo50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109609; c=relaxed/simple;
	bh=W6sG4XInhRzCu8cDMzCc51e1cYCKaqsFe9Eeb5BE+gw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gpLKRGYHl2CmQwRzAB+S0CyvJqE7uzG01nJrPvw9xZDtDBNL9JLaNR6abmhJT65Ct2O+f+2cAv/3W2JD0GYuu2tQCcjbAm7Cwco3oOtPxkqVOSL1Ecz3frDl5B3OursUWt6MEhteEBapYrbj+3VBHB6GoYJb3tcafUIw2fRCkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=nWOSfs2l; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="nWOSfs2l"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49GJEwOQ001765
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 13:13:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=CoZ2NfTGVLahbkZYF3
	aIpD95P8EHEfquqQlIum/cS/Y=; b=nWOSfs2lZmonST4quBXdvxt8iElPBjQwL4
	Qdvv39YpsQWeOdUoBrwe3MYqabR7w9c6sJh7YLjRuTvKKSdENFGdlEdXvmmiTAPW
	qACxoy2jbk51K4KNXkXEaXUqe3N/glvCzAu/qAtKi6r67OgmHdZk8+lPYmgA7Uqa
	U+5MsenFIBlkE+BZyRR26GMBp0lbg2x5H74deyT81Qb0vqDsDxU84ua+lFfHDOgA
	1i4jGqNeQdqfjCp32CeJSX2YXyafg902zSJLbGtPnb6d5p29R8nqSyZAE01D3Dp+
	RDJXsjhdNf9NMrhzyborhm0YSmv318xdVTAxYGdh81PcpVh8Jaxg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42a8wm4mys-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 16 Oct 2024 13:13:25 -0700 (PDT)
Received: from twshared29849.08.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 16 Oct 2024 20:13:23 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DD5C914344E5F; Wed, 16 Oct 2024 13:13:09 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <anuj20.g@samsung.com>, <martin.petersen@oracle.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] blk-integrity: remove seed for user mapped buffers
Date: Wed, 16 Oct 2024 13:13:09 -0700
Message-ID: <20241016201309.1090320-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: itGscruqgwIAdox55m1JhFsEAiAH7V7z
X-Proofpoint-ORIG-GUID: itGscruqgwIAdox55m1JhFsEAiAH7V7z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01

From: Keith Busch <kbusch@kernel.org>

The seed is only used for kernel generation and verification. That
doesn't happen for user buffers, so passing the seed around doesn't
accomplish anything.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bio-integrity.c         | 13 +++++--------
 block/blk-integrity.c         |  4 ++--
 drivers/nvme/host/ioctl.c     | 17 ++++++++---------
 include/linux/bio-integrity.h |  4 ++--
 include/linux/blk-integrity.h |  5 ++---
 5 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 88e3ad73c3854..2a4bd66116920 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(bio_integrity_add_page);
=20
 static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec=
,
 				   int nr_vecs, unsigned int len,
-				   unsigned int direction, u32 seed)
+				   unsigned int direction)
 {
 	bool write =3D direction =3D=3D ITER_SOURCE;
 	struct bio_integrity_payload *bip;
@@ -247,7 +247,6 @@ static int bio_integrity_copy_user(struct bio *bio, s=
truct bio_vec *bvec,
 	}
=20
 	bip->bip_flags |=3D BIP_COPY_USER;
-	bip->bip_iter.bi_sector =3D seed;
 	bip->bip_vcnt =3D nr_vecs;
 	return 0;
 free_bip:
@@ -258,7 +257,7 @@ static int bio_integrity_copy_user(struct bio *bio, s=
truct bio_vec *bvec,
 }
=20
 static int bio_integrity_init_user(struct bio *bio, struct bio_vec *bvec=
,
-				   int nr_vecs, unsigned int len, u32 seed)
+				   int nr_vecs, unsigned int len)
 {
 	struct bio_integrity_payload *bip;
=20
@@ -267,7 +266,6 @@ static int bio_integrity_init_user(struct bio *bio, s=
truct bio_vec *bvec,
 		return PTR_ERR(bip);
=20
 	memcpy(bip->bip_vec, bvec, nr_vecs * sizeof(*bvec));
-	bip->bip_iter.bi_sector =3D seed;
 	bip->bip_iter.bi_size =3D len;
 	bip->bip_vcnt =3D nr_vecs;
 	return 0;
@@ -303,8 +301,7 @@ static unsigned int bvec_from_pages(struct bio_vec *b=
vec, struct page **pages,
 	return nr_bvecs;
 }
=20
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t b=
ytes,
-			   u32 seed)
+int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t b=
ytes)
 {
 	struct request_queue *q =3D bdev_get_queue(bio->bi_bdev);
 	unsigned int align =3D blk_lim_dma_alignment_and_pad(&q->limits);
@@ -350,9 +347,9 @@ int bio_integrity_map_user(struct bio *bio, void __us=
er *ubuf, ssize_t bytes,
=20
 	if (copy)
 		ret =3D bio_integrity_copy_user(bio, bvec, nr_bvecs, bytes,
-					      direction, seed);
+					      direction);
 	else
-		ret =3D bio_integrity_init_user(bio, bvec, nr_bvecs, bytes, seed);
+		ret =3D bio_integrity_init_user(bio, bvec, nr_bvecs, bytes);
 	if (ret)
 		goto release_pages;
 	if (bvec !=3D stack_vec)
diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 83b696ba0cac3..b180cac61a9dd 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -113,9 +113,9 @@ int blk_rq_map_integrity_sg(struct request *rq, struc=
t scatterlist *sglist)
 EXPORT_SYMBOL(blk_rq_map_integrity_sg);
=20
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
-			      ssize_t bytes, u32 seed)
+			      ssize_t bytes)
 {
-	int ret =3D bio_integrity_map_user(rq->bio, ubuf, bytes, seed);
+	int ret =3D bio_integrity_map_user(rq->bio, ubuf, bytes);
=20
 	if (ret)
 		return ret;
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index b9b79ccfabf8a..f697d2d1d7e42 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -114,7 +114,7 @@ static struct request *nvme_alloc_user_request(struct=
 request_queue *q,
=20
 static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
-		u32 meta_seed, struct io_uring_cmd *ioucmd, unsigned int flags)
+		struct io_uring_cmd *ioucmd, unsigned int flags)
 {
 	struct request_queue *q =3D req->q;
 	struct nvme_ns *ns =3D q->queuedata;
@@ -152,8 +152,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
 		bio_set_dev(bio, bdev);
=20
 	if (has_metadata) {
-		ret =3D blk_rq_integrity_map_user(req, meta_buffer, meta_len,
-						meta_seed);
+		ret =3D blk_rq_integrity_map_user(req, meta_buffer, meta_len);
 		if (ret)
 			goto out_unmap;
 	}
@@ -170,7 +169,7 @@ static int nvme_map_user_request(struct request *req,=
 u64 ubuffer,
=20
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer, unsigned bufflen,
-		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
+		void __user *meta_buffer, unsigned meta_len,
 		u64 *result, unsigned timeout, unsigned int flags)
 {
 	struct nvme_ns *ns =3D q->queuedata;
@@ -187,7 +186,7 @@ static int nvme_submit_user_cmd(struct request_queue =
*q,
 	req->timeout =3D timeout;
 	if (ubuffer && bufflen) {
 		ret =3D nvme_map_user_request(req, ubuffer, bufflen, meta_buffer,
-				meta_len, meta_seed, NULL, flags);
+				meta_len, NULL, flags);
 		if (ret)
 			return ret;
 	}
@@ -268,7 +267,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct =
nvme_user_io __user *uio)
 	c.rw.lbatm =3D cpu_to_le16(io.appmask);
=20
 	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, metadata,
-			meta_len, lower_32_bits(io.slba), NULL, 0, 0);
+			meta_len, NULL, 0, 0);
 }
=20
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -323,7 +322,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, stru=
ct nvme_ns *ns,
=20
 	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, 0, &result, timeout, 0);
+			cmd.metadata_len, &result, timeout, 0);
=20
 	if (status >=3D 0) {
 		if (put_user(result, &ucmd->result))
@@ -370,7 +369,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, st=
ruct nvme_ns *ns,
=20
 	status =3D nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, 0, &cmd.result, timeout, flags);
+			cmd.metadata_len, &cmd.result, timeout, flags);
=20
 	if (status >=3D 0) {
 		if (put_user(cmd.result, &ucmd->result))
@@ -504,7 +503,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, =
struct nvme_ns *ns,
 	if (d.addr && d.data_len) {
 		ret =3D nvme_map_user_request(req, d.addr,
 			d.data_len, nvme_to_user_ptr(d.metadata),
-			d.metadata_len, 0, ioucmd, vec);
+			d.metadata_len, ioucmd, vec);
 		if (ret)
 			return ret;
 	}
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.=
h
index dd831c269e994..dbf0f74c15291 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -72,7 +72,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struc=
t bio *bio, gfp_t gfp,
 		unsigned int nr);
 int bio_integrity_add_page(struct bio *bio, struct page *page, unsigned =
int len,
 		unsigned int offset);
-int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t l=
en, u32 seed);
+int bio_integrity_map_user(struct bio *bio, void __user *ubuf, ssize_t l=
en);
 void bio_integrity_unmap_user(struct bio *bio);
 bool bio_integrity_prep(struct bio *bio);
 void bio_integrity_advance(struct bio *bio, unsigned int bytes_done);
@@ -99,7 +99,7 @@ static inline void bioset_integrity_free(struct bio_set=
 *bs)
 }
=20
 static inline int bio_integrity_map_user(struct bio *bio, void __user *u=
buf,
-					 ssize_t len, u32 seed)
+					 ssize_t len)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.=
h
index 676f8f860c474..c7eae0bfb013f 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -28,7 +28,7 @@ static inline bool queue_limits_stack_integrity_bdev(st=
ruct queue_limits *t,
 int blk_rq_map_integrity_sg(struct request *, struct scatterlist *);
 int blk_rq_count_integrity_sg(struct request_queue *, struct bio *);
 int blk_rq_integrity_map_user(struct request *rq, void __user *ubuf,
-			      ssize_t bytes, u32 seed);
+			      ssize_t bytes);
=20
 static inline bool
 blk_integrity_queue_supports_integrity(struct request_queue *q)
@@ -104,8 +104,7 @@ static inline int blk_rq_map_integrity_sg(struct requ=
est *q,
 }
 static inline int blk_rq_integrity_map_user(struct request *rq,
 					    void __user *ubuf,
-					    ssize_t bytes,
-					    u32 seed)
+					    ssize_t bytes)
 {
 	return -EINVAL;
 }
--=20
2.43.5

