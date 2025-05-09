Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DAA226533
	for <linux-block@vger.kernel.org>; Fri,  9 May 2025 15:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805106; cv=none; b=bhiCk2QA4/QplwKT4FBuhfWc4zuPYRPSD6zdbhN1Lez/YRWWDv75OBDi+rDk0bbB+2WAd/mwFUWVQUCUuudpelG6qW9E8+L87oE8Sex/twMDvQwBf4iasG8FsIMH8p3fA8G97PeqXvhRwI7RYpf1Op4D9vS3a8UmKLzRPTSs9Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805106; c=relaxed/simple;
	bh=e+O5QB2boX9//YpzMs/dOAI9G6XnKbH46ubG42bJrVo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b7vWB+K0EgU/0xqpJD+wOynJ3KXJ3nPweYRrhe4OjFHKjAoK5zUY16DWHm1RqAaC9laQiEHukn3aeBiOPfFKaJdYW1Ch8w3GTb5oYtAja4TH82yeuZQF0IQasrShQ0vknKINuuu0TjVcYKq25imEymX+d39S7+25b8N+XUKdeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=hSPlSbCD; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="hSPlSbCD"
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549FX6ZA030408
	for <linux-block@vger.kernel.org>; Fri, 9 May 2025 08:38:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=3ehD4X2+c1diIKC/s9
	g+40dT/ZAYokXAyCM5j8yrStc=; b=hSPlSbCDlHDSJQPyiNUo3sD+1qu4mSI+JD
	kBiVSalIxtLgX8xfOVYvpxTByevOFG6hskvMZu7joYfW5O+Hdy0wnfjH1sCZYAHd
	pqD3CdPQRk1SdI9uSP8LmhEsW71KtUN1H0eM7uCRFoJlYnGx5zA6CD37l98lhfIE
	e8Z/o/uEPy97lK5qEX+81DZeMclsPO0KR/qcj2BhrHpTo8tLUOxerLms9YV+a4SL
	FU/d0K1dTAGg/fTQ1Rv0/U+/e6iI7PNKmhHf79mIbxT+qp3yxSSOJa22L5j29PKi
	yMgMdgcLCws4sPGu/mGrKFI3+6nfBAvOkESvXUau+gpABXs6jKXA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46hgeu9nfb-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 09 May 2025 08:38:23 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Fri, 9 May 2025 15:38:18 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6711C1B843A36; Fri,  9 May 2025 08:38:03 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv4] block: always allocate integrity buffer when required
Date: Fri, 9 May 2025 08:38:02 -0700
Message-ID: <20250509153802.3482493-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: UCSAvFyLFL4niuvlz00efEZBMQrbJXo3
X-Authority-Analysis: v=2.4 cv=fbmty1QF c=1 sm=1 tr=0 ts=681e2170 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=JDxxQ0Vu41mlFdkJbZYA:9
X-Proofpoint-ORIG-GUID: UCSAvFyLFL4niuvlz00efEZBMQrbJXo3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE1NCBTYWx0ZWRfX20UNYfyCq4ho 5eprVgHER36pCgqfEqwmiA2Zp9X2QULPcoGwDsmRvpgNFVmSc7DH2sm1xfNPRWWoEfDgCbHbiRX B3u4b83QUpliS/mTRUBDbkViyWREuYOhYiHm5/YlRB2B84osMnVxkTD2l1dvvQf9SvkdRmFRmhh
 JPgL2vs8DTv+TSZuWGbfCJuv+FyVcBVYJHPermPpgvAAllV8ydQfwMGJVbwAKF36BXDEtkVjqsC kSjnIOBlW1Hnc0QRhRSSoXs+WVGDlZ3ln2YcXXCv/5CB8AK+S+1UGxwpZ9JboudikUagoh+Jl61 k4+/iLVe1y3lN36cWwm5LCa4TtFB0cuGygDktRHUc3rB7AwAnYW5F5Db8SJhwgcx/yH28jvRHtv
 lI+W7XH7oR9h3LntUn0407NPpDU37cgtNl+1/EZBQUMsdIQmK7svUU2irMV5yRRPKwzo6Nb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01

From: Keith Busch <kbusch@kernel.org>

Many nvme metadata formats can not strip or generate the metadata on the
controller side. For these formats, a host provided integrity buffer is
mandatory even if it isn't checked.

The block integrity read_verify and write_generate attributes prevent
allocating the metadata buffer, but we need it when the format requires
it, otherwise reads and writes will be rejected by the driver with IO
errors.

Assume the integrity buffer can be offloaded to the controller if the
metadata size is the same as the protection information size. Otherwise
provide an unchecked host buffer when the read verify or write
generation attributes are disabled. This fixes the following nvme
warning:

 ------------[ cut here ]------------
 WARNING: CPU: 1 PID: 371 at drivers/nvme/host/core.c:1036 nvme_setup_rw+=
0x122/0x210
 ...
 RIP: 0010:nvme_setup_rw+0x122/0x210
 ...
 Call Trace:
  <TASK>
  nvme_setup_cmd+0x1b4/0x280
  nvme_queue_rqs+0xc4/0x1f0 [nvme]
  blk_mq_dispatch_queue_requests+0x24a/0x430
  blk_mq_flush_plug_list+0x50/0x140
  __blk_flush_plug+0xc1/0x100
  __submit_bio+0x1c1/0x360
  ? submit_bio_noacct_nocheck+0x2d6/0x3c0
  submit_bio_noacct_nocheck+0x2d6/0x3c0
  ? submit_bio_noacct+0x47/0x4c0
  submit_bio_wait+0x48/0xa0
  __blkdev_direct_IO_simple+0xee/0x210
  ? current_time+0x1d/0x100
  ? current_time+0x1d/0x100
  ? __bio_clone+0xb0/0xb0
  blkdev_read_iter+0xbb/0x140
  vfs_read+0x239/0x310
  ksys_read+0x58/0xc0
  do_syscall_64+0x6c/0x180
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v3->v4:

  Assume tuple size and checksum type can be used to infer if the
  host is required to provide an integrity buffer, or if that can be
  offloaded to the device. No need for format specific flags in that
  case.

 block/bio-integrity-auto.c | 62 +++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index e524c609be506..9c66576647920 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -9,6 +9,7 @@
  * not aware of PI.
  */
 #include <linux/blk-integrity.h>
+#include <linux/t10-pi.h>
 #include <linux/workqueue.h>
 #include "blk.h"
=20
@@ -43,6 +44,29 @@ static void bio_integrity_verify_fn(struct work_struct=
 *work)
 	bio_endio(bio);
 }
=20
+#define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_=
APPTAG)
+static bool bip_should_check(struct bio_integrity_payload *bip)
+{
+	return bip->bip_flags & BIP_CHECK_FLAGS;
+}
+
+static bool bi_offload_capable(struct blk_integrity *bi)
+{
+	switch (bi->csum_type) {
+	case BLK_INTEGRITY_CSUM_CRC64:
+		return bi->tuple_size =3D=3D sizeof(struct crc64_pi_tuple);
+	case BLK_INTEGRITY_CSUM_CRC:
+	case BLK_INTEGRITY_CSUM_IP:
+		return bi->tuple_size =3D=3D sizeof(struct t10_pi_tuple);
+	default:
+		pr_warn_once("%s: unknown integrity checksum type:%d\n",
+			__func__, bi->csum_type);
+		fallthrough;
+	case BLK_INTEGRITY_CSUM_NONE:
+		return false;
+	}
+}
+
 /**
  * __bio_integrity_endio - Integrity I/O completion function
  * @bio:	Protected bio
@@ -54,12 +78,12 @@ static void bio_integrity_verify_fn(struct work_struc=
t *work)
  */
 bool __bio_integrity_endio(struct bio *bio)
 {
-	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_payload *bip =3D bio_integrity(bio);
 	struct bio_integrity_data *bid =3D
 		container_of(bip, struct bio_integrity_data, bip);
=20
-	if (bio_op(bio) =3D=3D REQ_OP_READ && !bio->bi_status && bi->csum_type)=
 {
+	if (bio_op(bio) =3D=3D REQ_OP_READ && !bio->bi_status &&
+	    bip_should_check(bip)) {
 		INIT_WORK(&bid->work, bio_integrity_verify_fn);
 		queue_work(kintegrityd_wq, &bid->work);
 		return false;
@@ -84,6 +108,7 @@ bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
 	struct bio_integrity_data *bid;
+	bool set_flags =3D true;
 	gfp_t gfp =3D GFP_NOIO;
 	unsigned int len;
 	void *buf;
@@ -100,19 +125,24 @@ bool bio_integrity_prep(struct bio *bio)
=20
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
-		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
-			return true;
+		if (bi->flags & BLK_INTEGRITY_NOVERIFY) {
+			if (bi_offload_capable(bi))
+				return true;
+			set_flags =3D false;
+		}
 		break;
 	case REQ_OP_WRITE:
-		if (bi->flags & BLK_INTEGRITY_NOGENERATE)
-			return true;
-
 		/*
 		 * Zero the memory allocated to not leak uninitialized kernel
 		 * memory to disk for non-integrity metadata where nothing else
 		 * initializes the memory.
 		 */
-		if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
+		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
+			if (bi_offload_capable(bi))
+				return true;
+			set_flags =3D false;
+			gfp |=3D __GFP_ZERO;
+		} else if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
 			gfp |=3D __GFP_ZERO;
 		break;
 	default:
@@ -137,19 +167,21 @@ bool bio_integrity_prep(struct bio *bio)
 	bid->bip.bip_flags |=3D BIP_BLOCK_INTEGRITY;
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
-		bid->bip.bip_flags |=3D BIP_IP_CHECKSUM;
-	if (bi->csum_type)
-		bid->bip.bip_flags |=3D BIP_CHECK_GUARD;
-	if (bi->flags & BLK_INTEGRITY_REF_TAG)
-		bid->bip.bip_flags |=3D BIP_CHECK_REFTAG;
+	if (set_flags) {
+		if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
+			bid->bip.bip_flags |=3D BIP_IP_CHECKSUM;
+		if (bi->csum_type)
+			bid->bip.bip_flags |=3D BIP_CHECK_GUARD;
+		if (bi->flags & BLK_INTEGRITY_REF_TAG)
+			bid->bip.bip_flags |=3D BIP_CHECK_REFTAG;
+	}
=20
 	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf)) < len)
 		goto err_end_io;
=20
 	/* Auto-generate integrity metadata if this is a write */
-	if (bio_data_dir(bio) =3D=3D WRITE)
+	if (bio_data_dir(bio) =3D=3D WRITE && bip_should_check(&bid->bip))
 		blk_integrity_generate(bio);
 	else
 		bid->saved_bio_iter =3D bio->bi_iter;
--=20
2.47.1

