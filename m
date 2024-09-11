Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3041BB695
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085578; cv=none; b=MgiGz5OgZx4iNbS5iN1tMBRAnAp0GmogEVEssvfeYhqG+AOe19h3XyUT7SUnx10vpZfmEJjVtOHextL+40KXqrws5uAG4D4vWQT3fSIVBzD1399+1xfiekU1mLW7d+IauVy04fehlS5z4vS0g5aoPXVuAvaxDKQnbAAHRhIB10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085578; c=relaxed/simple;
	bh=+PxqwvKQOdT226UPkI94Z24P05vd+OAdFhcR7k3fUg4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfhMx2dC1jEITYarDqPY1c7mgd526K9AbP+8IfXQITSZ10jF+0QUgzgmta8K82JYPcQalqPuT0RZufwgTPDryBvUsABQmAlPtxz7svo+uBDTYtTFqg9P6AizXN/Yc1cUNvZgCRGqqM2Tfi9b629tYFxnFzrVNYQpTPSC01H7GiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=MLJOpA0E; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="MLJOpA0E"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 48BHjWcF004157
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 13:12:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=vK7qovxoMZszHB6W/2udkY9+/U6Fab7VLQCU0PsTo08=; b=
	MLJOpA0EQF3BNWDwY6W/0omrS8KKiE7SoujZvNEnq+YxGy+pVaLzVMKSgjOj3J4X
	6bKeN9j95lQ6YjYx7P8OrvHzWNo35yBn0q4dv00/c/OeAlG+hlUW7UXLy7mwt5pF
	xjbdbqL6NgYZkN76vUChu0ZU4imCWzyDBJoJyOZgTdun1lhXCINEC18aQxDJHk39
	ZUZjFcCd0fzwi2dFy7NxJIHQsEOyy1r6jd1ipzyajdHxGLyVhPPfwe38VwB7i2oY
	KAODWJjmMsfCn8ZwxeQMoZKuWzxSBtl7dd7rjX1J2d4H8s/OGQcrC2HxA0e2fqpY
	GkI63qj9GW5CE39NqWYA+g==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41k44nnb2x-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 11 Sep 2024 13:12:56 -0700 (PDT)
Received: from twshared4354.35.frc1.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Sep 2024 20:12:55 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id EAB7812E5EDAC; Wed, 11 Sep 2024 13:12:41 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4 04/10] blk-integrity: consider entire bio list for merging
Date: Wed, 11 Sep 2024 13:12:34 -0700
Message-ID: <20240911201240.3982856-5-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240911201240.3982856-1-kbusch@meta.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: dtOZSpr4LNAdvNG9VzfsSdLQK9yZc7qB
X-Proofpoint-GUID: dtOZSpr4LNAdvNG9VzfsSdLQK9yZc7qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-11_01,2024-09-09_02,2024-09-02_01

From: Keith Busch <kbusch@kernel.org>

If a bio is merged to a request, the entire bio list is merged, so don't
temporarily detach it from its list when counting segments. In most
cases, bi_next will already be NULL, so detaching is usually a no-op.
But if the bio does have a list, the current code is miscounting the
segments for the resulting merge.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index afd101555d3cb..84065691aaed0 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -134,7 +134,6 @@ bool blk_integrity_merge_bio(struct request_queue *q,=
 struct request *req,
 			     struct bio *bio)
 {
 	int nr_integrity_segs;
-	struct bio *next =3D bio->bi_next;
=20
 	if (blk_integrity_rq(req) =3D=3D 0 && bio_integrity(bio) =3D=3D NULL)
 		return true;
@@ -145,10 +144,7 @@ bool blk_integrity_merge_bio(struct request_queue *q=
, struct request *req,
 	if (bio_integrity(req->bio)->bip_flags !=3D bio_integrity(bio)->bip_fla=
gs)
 		return false;
=20
-	bio->bi_next =3D NULL;
 	nr_integrity_segs =3D blk_rq_count_integrity_sg(q, bio);
-	bio->bi_next =3D next;
-
 	if (req->nr_integrity_segments + nr_integrity_segs >
 	    q->limits.max_integrity_segments)
 		return false;
--=20
2.43.5

