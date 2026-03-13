Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F053AC0FB
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773413247; cv=none; b=iav9plcLMVXmkYx6Sb2poc9VdSJTaTyHyNMrYw8pzyUx+oRFJBC85fvwlOgwDFqwDVrOy1ctcF4FL+Hbl2q5J/yYDcpzNw2qHwmi9oiFJFrNVWDkNzbIvblgsAe6pbSf1Eq18wRNfOrexpPxTC3lxDox6mgFaYPRp3MtLGQ24a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773413247; c=relaxed/simple;
	bh=m/YwuHPY9oLKTAP5H8+At4LsaxQLvpb18Tn+uB5hwvg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EbUtK0slNja8p+AtO+zXvEkpsVK3vbT0V8yQoMrtULWBxSVsS9fbzYEUBNjkcJnPUOi7OJMwsY+sjx7zKubrfFZIP7Jcc8Isd4oKOm2TBRlPHLW3LxDEQThnyitQXgqFKZT6n/X9wNvnqwb6E85V/NNNShrVoCOOMYhmXZIDQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=H3uNv0Nh; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="H3uNv0Nh"
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D8op383817689
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 07:47:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=wM0UDpJRp6QOFTtsFT
	dfYMBg36gAI2McbfOUdi4ik5E=; b=H3uNv0NhQXQNLFGoq3lKx6/GLfeovKEZCz
	N4oqpM/yBtwOAmBYWwzANXWP5pK9GTGZfA/0Lp/f2pG/FfC//agNV1TeYWI9ySBB
	qvuINd7fWLwtT7Av8F1m7KrO7VUb9V44sbHDlWlm0AwU46dLq1GdmuMqUsSawXd9
	NB5r506OLZZmzJM0ICoXT0rUW4gH77ZFRgyCRKcj57+fsf0Q8BSTpAkwsYuojsWG
	iiRfvvWnmtafMH/N9BcX1LU8xabqi8vcAVvn3IL7oNviPQsY/SEb9A+7AB84jOEI
	uEyaaZHITCkZ3Cd+wz21ETS9bMPcf6hb6Pie6pznEuvVsksL3Qsw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cv9h4f7ec-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 07:47:24 -0700 (PDT)
Received: from twshared10897.36.frc1.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Fri, 13 Mar 2026 14:47:20 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 044EEB3BB9E3; Fri, 13 Mar 2026 07:47:01 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists-infradead.org>, <linux-block@vger.kernel.org>,
        <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 0/2] block for-7.1/integrity rebase for mem alignment
Date: Fri, 13 Mar 2026 07:46:59 -0700
Message-ID: <20260313144701.1221652-1-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y5AKr8Cjt6ZYp_Elag6ktrx7lQ42L1DV
X-Authority-Analysis: v=2.4 cv=Afi83nXG c=1 sm=1 tr=0 ts=69b4237c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=VN40FoYtMKXBmFH6IBkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNyBTYWx0ZWRfX5SIAGOXbfqkI
 TIZAcJ28bEmGF83qpIT+K8NiscbGsbXScRLjOyTCJpieaUkrVYR9cOaQLqW6h1mno3i+tBN1958
 f9oYkxnYrFBkgIhWDfejEjVsls1x/DgRrtIzRSmgFuQvrdelrTkIB4aq62b4amBPK4VES27rZ9G
 SwebZ1j3ZLBb0B3NqI1cqpuyQdaJ0AfH+v1Uc9ituoTgo2wn/m5uC9DYe4EvjyfDR4JX+jnUMK4
 1r0FhP+jhIJIrzsxfodQEn4bo4tJfqS6DRJowV9Fj5rAPwPSCH1iNs/AnEzPPLutfD0d2Cvhati
 iIu5xQsx5GGDXEoqlhfR9JLvH9gV2FsWl2/c0zwQD6d4yO1qcy5wrIy8GFSkqbsmDMquzLJgYCX
 8iq9+30BvuV1Gt+RrYHUIeLZ/j89h1OBXN0vCNoK1MCWQOfwNz6kGhD+kSzPQub33JsEqd19jab
 DjG1WpyiJRCuykJQ9vg==
X-Proofpoint-GUID: Y5AKr8Cjt6ZYp_Elag6ktrx7lQ42L1DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

This is the rebased version of the flexible t10 alignment feature on top
of block's for-7.1/block-integrity branch to apply atop Christoph's
fs-integrity:

  https://lore.kernel.org/linux-block/20260223132021.292832-1-hch@lst.de/

The only change from the previous version is to incorporate the function
name changes and verify's status code return type that were introduced
in the file system integrity support patch set.

I've also included the ublk support for this feature since it was
previously accepted and has a dependency on patch 1.

For reference, here is the resulting diff from the previous version's
implementation before fs-integrity to this new one after fs support:

---
--- block/t10-pi.c.orig	2026-03-12 16:04:57.191719482 -0700
+++ block/t10-pi.c	2026-03-12 16:09:04.304084389 -0700
@@ -304,7 +304,8 @@
 	return ret;
 }
=20
-static void blk_integrity_iterate(struct bio *bio, struct bvec_iter *dat=
a_iter,
+static blk_status_t blk_integrity_iterate(struct bio *bio,
+					  struct bvec_iter *data_iter,
 				  bool verify)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
@@ -342,11 +343,10 @@
 		kunmap_local(kaddr);
 	}
=20
-	if (ret)
-		bio->bi_status =3D ret;
+	return ret;
 }
=20
-void blk_integrity_generate(struct bio *bio)
+void bio_integrity_generate(struct bio *bio)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
=20
@@ -361,7 +361,7 @@
 	}
 }
=20
-void blk_integrity_verify_iter(struct bio *bio, struct bvec_iter *saved_=
iter)
+blk_status_t bio_integrity_verify(struct bio *bio, struct bvec_iter *sav=
ed_iter)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
=20
@@ -369,11 +369,12 @@
 	case BLK_INTEGRITY_CSUM_CRC64:
 	case BLK_INTEGRITY_CSUM_CRC:
 	case BLK_INTEGRITY_CSUM_IP:
-		blk_integrity_iterate(bio, saved_iter, true);
-		break;
+		return blk_integrity_iterate(bio, saved_iter, true);
 	default:
 		break;
 	}
+
+	return BLK_STS_OK;
 }
=20
 /*
--

Caleb Sander Mateos (1):
  ublk: report BLK_SPLIT_INTERVAL_CAPABLE

Keith Busch (1):
  blk-integrity: support arbitrary buffer alignment

 block/blk-settings.c          |  12 +-
 block/t10-pi.c                | 816 +++++++++++++++++++---------------
 drivers/block/ublk_drv.c      |   2 +-
 drivers/nvme/host/core.c      |   1 +
 include/linux/blk-integrity.h |   1 +
 5 files changed, 466 insertions(+), 366 deletions(-)

--=20
2.52.0

