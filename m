Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E841E3DED
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 21:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625274; cv=none; b=qrrwfGQzR7F5Haf5Lnbbgcr7CkwzXB0YkNxf7OKvVsBWauaG5/K1Y2XKuGECDhL5Tbt49HuI4540HUfLW82RKPrFC67Z6luW7GT6wN0OptzqHfPnO7vljsEjo4hhMp80lPG/HlKKADV0Cefmdovg17BTmIbgQaSKzVW9n3RDCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625274; c=relaxed/simple;
	bh=T8weHn8otMphpEreUJWqv5SlzDSbz8VmMVimy7muyEw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K0oIx+bPYE7c0adEiGeOVFmi5WwTd/ErNhCvEv4RBQr8G87tO4uJ/J4mGqoTwXNNo6vuL4fkkzgtt4CxArc82ZFQzNSU7K7JWcoDbriwoSGjlW+XAzU26fVtaMMVr6FIKGTel3zJXMb5cbeYrY3WNZa5td2OAwcw3htPGpFuQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=V+TkjIr7; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="V+TkjIr7"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 5B1LcceI2417578
	for <linux-block@vger.kernel.org>; Mon, 1 Dec 2025 13:41:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=l/N0oNZdrOxC+sMk7wLBt3mzHipkA8OrRZGOO0xO1fI=; b=V+TkjIr7KWZb
	sRdL8/VOJPGgPW2bL/cMGaS/KBRtFcoKOttu+76x4hqtNMLkdpqHKW3v+QqUPRiF
	oxZRhhbX9SNSV9sOdtDFClD+M3F9xLwSMco23ZZlHuJZLdgrPT3PzP8q7YZ7B/AB
	vv5ecjvYwPinfcyN3yt3PpPjff8C7qj0jRtJw/cCukmFG+jKaPh7DDuWU7V+qHJq
	RCQ12lMGh/XVa/fVsyvBXNRteMBV8JmZ/lf6gC4ZixKOCYZ9Eghqe2qFl2qVEhx6
	m49T5XFMtWYsR6QlXkS9EG/L+y6fwPGyORjkHssnBZQBI/IgtNh7/iPIH2vrylPR
	I1EWs/1guw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ask4480p4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 13:41:11 -0800 (PST)
Received: from twshared71707.17.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.29; Mon, 1 Dec 2025 21:41:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id AC0FF45AA8A1; Mon,  1 Dec 2025 13:40:56 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <dm-devel@lists.linux.dev>, <snitzer@kernel.org>, <hch@lst.de>,
        <ebiggers@kernel.org>
CC: <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 2/2] dm-crypt: dynamic scatterlist for many segments
Date: Mon, 1 Dec 2025 13:40:52 -0800
Message-ID: <20251201214052.1531952-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251201214052.1531952-1-kbusch@meta.com>
References: <20251201214052.1531952-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAxMDE3MyBTYWx0ZWRfX55tdIC3EvAD7
 sMoKzGUg2PaXnxNVBaoWUJ8MWLUfFlLTU4zIHhF5F8IgNmIxwAkC1KZ7b8oq2VQDtCGH6rb+N7P
 EUhpNi+eJCAUlJN417CGZrCVN9vQbogq2l1tK+QbEqEkV5bR3bfXnR4QbFMrPjNc1znbT6qInmc
 bib9NxINC8y90YliSMgrHGeF3nlRNBdZrrucLlOMJfJWVo2wyLy45goAJ2zW6HDlQHhUl0q97zK
 oJpVbV3R9ISPG/M9vRBTBQ3dP3jnwlMIiQN/WrbJw3bZAAJmCaeeFP3CAoYY62inhDA424dD6GL
 hYHMLTFAst4ImDif0D+5MFBv0iii5c8fW4IeJhcDUtPDLAagkxFnt+B9Bk+mcguRgZ261fFrWzg
 6j01vvboElln0+5X5tiYZn2LkStXww==
X-Authority-Analysis: v=2.4 cv=LYExKzfi c=1 sm=1 tr=0 ts=692e0b77 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=uKr_gk69WBrFS6epR-gA:9
X-Proofpoint-GUID: QXaQBOQCEmA5buoU6Ii-tg0AgQ-cxpvu
X-Proofpoint-ORIG-GUID: QXaQBOQCEmA5buoU6Ii-tg0AgQ-cxpvu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

In the unlikely case where the base bio uses a highly fragmented vector,
the four inline scatterlist elements may not be enough, so allocate a
temporary scatterlist when needed.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/md/dm-crypt.c | 51 +++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 5304954b4574b..d659ea4573192 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -98,6 +98,8 @@ struct dm_crypt_request {
 	struct scatterlist sg_in[4];
 	struct scatterlist sg_out[4];
 	u64 iv_sector;
+	struct scatterlist *__sg_in;
+	struct scatterlist *__sg_out;
 };
=20
 struct crypt_config;
@@ -1426,18 +1428,32 @@ static int crypt_convert_block_aead(struct crypt_=
config *cc,
 	return r;
 }
=20
-static int crypt_build_sgl(struct crypt_config *cc, struct scatterlist *=
sg,
+static void crypt_free_sgls(struct dm_crypt_request *dmreq)
+{
+	if (dmreq->__sg_in !=3D dmreq->sg_in)
+		kfree(dmreq->__sg_in);
+	if (dmreq->__sg_out !=3D dmreq->sg_out)
+		kfree(dmreq->__sg_out);
+	dmreq->__sg_in =3D NULL;
+	dmreq->__sg_out =3D NULL;
+}
+
+static int crypt_build_sgl(struct crypt_config *cc, struct scatterlist *=
*psg,
 			   struct bvec_iter *iter, struct bio *bio,
 			   int max_segs)
 {
 	unsigned int bytes =3D cc->sector_size;
+	struct scatterlist *sg =3D *psg;
 	struct bvec_iter tmp =3D *iter;
 	int segs, i =3D 0;
=20
 	bio_advance_iter(bio, &tmp, bytes);
 	segs =3D tmp.bi_idx - iter->bi_idx + !!tmp.bi_bvec_done;
-	if (segs > max_segs)
-		return -EIO;
+	if (segs > max_segs) {
+		sg =3D kmalloc_array(segs, sizeof(struct scatterlist), GFP_NOIO);
+		if (!sg)
+			return -ENOMEM;
+	}
=20
 	sg_init_table(sg, segs);
 	do {
@@ -1446,7 +1462,7 @@ static int crypt_build_sgl(struct crypt_config *cc,=
 struct scatterlist *sg,
=20
 		/* Reject unexpected unaligned bio. */
 		if (unlikely((len | bv.bv_offset) & cc->io_alignment))
-			return -EIO;
+			goto error;
=20
 		sg_set_page(&sg[i++], bv.bv_page, len, bv.bv_offset);
 		bio_advance_iter_single(bio, iter, len);
@@ -1454,8 +1470,13 @@ static int crypt_build_sgl(struct crypt_config *cc=
, struct scatterlist *sg,
 	} while (bytes);
=20
 	if (WARN_ON_ONCE(i !=3D segs))
-		return -EIO;
+		goto error;
+	*psg =3D sg;
 	return 0;
+error:
+	if (sg !=3D *psg)
+		kfree(sg);
+	return -EIO;
 }
=20
 static int crypt_convert_block_skcipher(struct crypt_config *cc,
@@ -1484,18 +1505,21 @@ static int crypt_convert_block_skcipher(struct cr=
ypt_config *cc,
 	sector =3D org_sector_of_dmreq(cc, dmreq);
 	*sector =3D cpu_to_le64(ctx->cc_sector - cc->iv_offset);
=20
-	sg_in  =3D &dmreq->sg_in[0];
-	sg_out =3D &dmreq->sg_out[0];
+	dmreq->__sg_in =3D &dmreq->sg_in[0];
+	dmreq->__sg_out =3D &dmreq->sg_out[0];
=20
-	r =3D crypt_build_sgl(cc, sg_in, &ctx->iter_in, ctx->bio_in,
+	r =3D crypt_build_sgl(cc, &dmreq->__sg_in, &ctx->iter_in, ctx->bio_in,
 			    ARRAY_SIZE(dmreq->sg_in));
 	if (r < 0)
 		return r;
=20
-	r =3D crypt_build_sgl(cc, sg_out, &ctx->iter_out, ctx->bio_out,
+	r =3D crypt_build_sgl(cc, &dmreq->__sg_out, &ctx->iter_out, ctx->bio_ou=
t,
 			    ARRAY_SIZE(dmreq->sg_out));
 	if (r < 0)
-		return r;
+		goto out;
+
+	sg_in =3D dmreq->__sg_in;
+	sg_out =3D dmreq->__sg_out;
=20
 	if (cc->iv_gen_ops) {
 		/* For READs use IV stored in integrity metadata */
@@ -1504,7 +1528,7 @@ static int crypt_convert_block_skcipher(struct cryp=
t_config *cc,
 		} else {
 			r =3D cc->iv_gen_ops->generator(cc, org_iv, dmreq);
 			if (r < 0)
-				return r;
+				goto out;
 			/* Data can be already preprocessed in generator */
 			if (test_bit(CRYPT_ENCRYPT_PREPROCESS, &cc->cipher_flags))
 				sg_in =3D sg_out;
@@ -1525,6 +1549,9 @@ static int crypt_convert_block_skcipher(struct cryp=
t_config *cc,
=20
 	if (!r && cc->iv_gen_ops && cc->iv_gen_ops->post)
 		r =3D cc->iv_gen_ops->post(cc, org_iv, dmreq);
+out:
+	if (r !=3D -EINPROGRESS && r !=3D -EBUSY)
+		crypt_free_sgls(dmreq);
=20
 	return r;
 }
@@ -1590,7 +1617,9 @@ static void crypt_free_req_skcipher(struct crypt_co=
nfig *cc,
 				    struct skcipher_request *req, struct bio *base_bio)
 {
 	struct dm_crypt_io *io =3D dm_per_bio_data(base_bio, cc->per_bio_data_s=
ize);
+	struct dm_crypt_request *dmreq =3D dmreq_of_req(cc, req);
=20
+	crypt_free_sgls(dmreq);
 	if ((struct skcipher_request *)(io + 1) !=3D req)
 		mempool_free(req, &cc->req_pool);
 }
--=20
2.47.3

