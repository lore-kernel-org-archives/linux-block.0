Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B32E2E11C5
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931275; cv=none; b=S/SJMWnZ8lhckANaY8cpjeJaBJOQd9wK3KoCagmQW8aNA+JYR1hvaS2j0JpGaEq6sn3bMAxYS0EYPAJHsXzzoM0QqD1tjDGvZ9bJwlJzGAt9UNHIAJa7U0zGJhzkXeuQWs/avfnegiTo3kHBEybkAwlVg6a6vKNdgviGsowDkFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931275; c=relaxed/simple;
	bh=aRwZS0oVphdV9COhELahnueVgbggxbpAXnh4srYDljc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h6YXkBgk3FPe8r+vBiIHxwrPk+CjllPDrziflHBkxo9zOSc5QDwHYKrvhK4m209bzFN50Nf8xxHRAM1u03G7mK2WOSgaOVS5NRn+osjJ0PNMBXMIFATYuVNb/pKTyDmhoReSB9rUeksOLxkdU7NF0zmPoxLsZEcAPvtCwxhm4JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=t9E1Mt6S; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="t9E1Mt6S"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 583J8AYR3689399
	for <linux-block@vger.kernel.org>; Wed, 3 Sep 2025 13:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=McjB7P6rRMKptcQ/za
	c8h7edTg/ofa/YAeLumtx1JA8=; b=t9E1Mt6STl4JAGEQ2Wtnah2JtA7UaBKsQE
	vrFTO1yiZgbKgHmVgdhwJTgQlblQuWDR4z6VLOQ/Ovk8j1nmwUqlEfudgXcq+iTi
	Trz0xNvp8tX+rW/xrNvQuynATaJTVtWvdICZ93je5FguePvDZZcVgNyr4cPXJrDv
	9bpK6nveuS4PHxyiZP0RlVEadFunrWOywE777dnmiYf/qbDPsOxH6GXl+Gg/02UG
	laTDECDmyPq1TUiO/rOnJLyCPv/ETehsTIxgI/gGVvQeDVdZPgQ6026kHAHd68mi
	rFQRZvOPh5/Y40ZFFAHEC8YM5Uv/10O+Tge/MmxXg0vsq6yPIn3g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 48xsv91mdy-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 13:27:52 -0700 (PDT)
Received: from twshared14631.07.ash9.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Wed, 3 Sep 2025 20:27:49 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 694E614D4B39; Wed,  3 Sep 2025 13:27:46 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <leon@kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] blk-map: provide the bdev to bio if one exists
Date: Wed, 3 Sep 2025 13:27:46 -0700
Message-ID: <20250903202746.3629381-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDIwNiBTYWx0ZWRfX7MuUp4X4ObuB
 k16dKgWqN2W+0QPejCZyoYQ+pdzTU8fi8tiTxjBD/gfRAxp1yJLBZQfhMEnxj6zv6BIKaDP0RyJ
 1QcE7o2AH7Set7Rev/oP85n5ZPyuWsZjmaL4WVpsmssB340ssC3rsDOHbJr/Z69raKUL15/itGM
 QBcCR45l5uh64UfH3q3gg5HcineALUEVkXyR/rVgae1gh5aL+qkcga1JR/OoDva7unashk+H57D
 mR9I5f+I6csLDaQIJJJE2Zh13F1Hvo+vNgznXod85UXGTZJyPwa8qwdVtEmW483aYOA/jqby2J8
 i5dzPz6g9vKoUALjihXhMTG9LntVJhkc5P/ZCBk3sqtqgFS3R6cg/9SHoXeFmI=
X-Authority-Analysis: v=2.4 cv=OZuYDgTY c=1 sm=1 tr=0 ts=68b8a4c8 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=54q1_fE8BhreCjNLvDAA:9
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: 2xVTQorDlAiASmL7mT6t90t7PcPEkg-9
X-Proofpoint-ORIG-GUID: 2xVTQorDlAiASmL7mT6t90t7PcPEkg-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_10,2025-08-28_01,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

We can now safely provide a block device when extracting user pages for
driver and user passthrough commands. Set the bdev so the caller doesn't
have to do that later. This has an additional  benefit of being able to
extract P2P pages in the passthrough path.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Note, this absolutely requires this patch series to be successful:

  https://lore.kernel.org/linux-block/20250827141258.63501-1-kbusch@meta.=
com/

Otherwise DRV_IN/OUT commands may fail because the interface assumes
logical block size, which is not a valid assumption for passthrough
commands, but we're not relying on the logical block size with the above
patch series, so it's fine.

The ability to test P2P data payloads with the passthrough interface is
the real goal of this path.

 block/blk-map.c           | 5 +++--
 drivers/nvme/host/ioctl.c | 5 -----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 6d1268aa82715..1098162c09393 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -253,10 +253,11 @@ static void blk_mq_map_bio_put(struct bio *bio)
 static struct bio *blk_rq_map_bio_alloc(struct request *rq,
 		unsigned int nr_vecs, gfp_t gfp_mask)
 {
+	struct block_device *bdev =3D rq->q->disk ? rq->q->disk->part0 : NULL;
 	struct bio *bio;
=20
 	if (rq->cmd_flags & REQ_ALLOC_CACHE && (nr_vecs <=3D BIO_INLINE_VECS)) =
{
-		bio =3D bio_alloc_bioset(NULL, nr_vecs, rq->cmd_flags, gfp_mask,
+		bio =3D bio_alloc_bioset(bdev, nr_vecs, rq->cmd_flags, gfp_mask,
 					&fs_bio_set);
 		if (!bio)
 			return NULL;
@@ -264,7 +265,7 @@ static struct bio *blk_rq_map_bio_alloc(struct reques=
t *rq,
 		bio =3D bio_kmalloc(nr_vecs, gfp_mask);
 		if (!bio)
 			return NULL;
-		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
+		bio_init(bio, bdev, bio->bi_inline_vecs, nr_vecs, req_op(rq));
 	}
 	return bio;
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6b3ac8ae3f34b..f778f3b5214bd 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -142,14 +142,9 @@ static int nvme_map_user_request(struct request *req=
, u64 ubuffer,
 		ret =3D blk_rq_map_user_io(req, NULL, nvme_to_user_ptr(ubuffer),
 				bufflen, GFP_KERNEL, flags & NVME_IOCTL_VEC, 0,
 				0, rq_data_dir(req));
-
 	if (ret)
 		return ret;
=20
-	bio =3D req->bio;
-	if (bdev)
-		bio_set_dev(bio, bdev);
-
 	if (has_metadata) {
 		ret =3D blk_rq_integrity_map_user(req, meta_buffer, meta_len);
 		if (ret)
--=20
2.47.3

