Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89377288C99
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632315; cv=none; b=pdj3j32FT2U4mslnm5AOBbhqRRc7V9k3FaTp51mis04YcWP+C7fY+s5tssIb8mo1yHU5K3EYudwFZjyKvf+UgrhBaompFtpYRnfH8PIGuBxzTRgHMxGmpZJp2V2pRwyvJTzDz9ycvRaqop+olnqLssDCRZdWiFpl2xHm1SGMUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632315; c=relaxed/simple;
	bh=dk9dnFAPyf4Myb62CEu504+uzYdF9yHYD0VsDgFvafw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sRUIwk+nlF0jJRpAxkXWt0ocLykv8lNLesGOzlcVXYyPKz5yoHfktegpjBgvYS1PskHHZNWGUsXC5GH4aauQBhnpn2K9MHU1Q9/o+TZGsxisSe3Loe7e+2Ek05rvff41h83d+1URXwYXe1A3bgljHQKBSLzV7YdEjU0tX6dP7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=U5g9mRCY; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="U5g9mRCY"
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547EddAc012882
	for <linux-block@vger.kernel.org>; Wed, 7 May 2025 08:38:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=rNoL8K/YjCVBot/1jy
	p9WgKstw9ejeofy6Ms1NqXej0=; b=U5g9mRCYrFNKbf7Xm4pttZuKpIsD8wOE4o
	s2b2C8SCCesDJJpKdPeLdLR8qXplrTlpZMbg8x5KL3+84XXcX3J684B6Pje/eIEL
	YjwF3Gc1t23i+vp1PgYeEFYMF+tsUTl9NtYk4EhOfEWaEHEUXAUS8aWU2xKYg0+G
	qcmT15WlSZmYrpL7YAgS+knNHKi/TmvKiAs0XOGogdgJYYbBL8+5IZGHiABmDquC
	PQm1JSSz06Uj+ed443eLD4ZJj+Zeqm77wwUUCHoJGjwsx2CboR79p0GlrXHb7ZT6
	8lQcnyM7k1OjkY4uXXAQzf6LiNNvbH3SwsEpoRHlnE9phyjrYgiQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46g6auhuyg-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 07 May 2025 08:38:30 -0700 (PDT)
Received: from twshared0377.32.frc3.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 7 May 2025 15:38:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 3E6C61B74097F; Wed,  7 May 2025 08:38:00 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>
CC: <hch@lst.de>, <linux-nvme@lists.infradead.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] block: always allocate integrity buffer
Date: Wed, 7 May 2025 08:37:59 -0700
Message-ID: <20250507153759.1199895-1-kbusch@meta.com>
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
X-Proofpoint-GUID: JmcPk4MIjerdX_c1eWByAQuyKTgeqs8K
X-Proofpoint-ORIG-GUID: JmcPk4MIjerdX_c1eWByAQuyKTgeqs8K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0NyBTYWx0ZWRfX9zyTTrjuqW14 8qzdhN8JT7s4eUjGep3jShQmRXaOAntjehIEw5Rxo1EciHADk1u0qh0Pxb+xpDvwdZBi7VsJP/Q kRfOZIWuacVv7VgBiyZAaOGN0EB6uA84LrmVkRFJZIY5APSlFusbsBLA61G5LQgy1RUpNPzyO3X
 sALh5Er9dLMYEAJETsHzVTMzNPPhcDI3iAQo4rBmzMzkFlKkIRgwKgXqKgQxySTi0AfaIp5I98R oX1N+xq0Utc/3+fjjRo29I0WVQRkjPMiEgpH+4w6PQKb0IZBBj3df/PbogB5544d+9NgdXu6I41 xYxN4aw8Q5lzdn94pJs6+vyeiPHrK4SZCkDXis+lr7JLNKqXrubk2u9DcavMZYVLOk8MRQiknSL
 7stY54otLzjJAmThsy+Fl88DQH0QxEHP0DPtNv22FRaeb1MvraCQMpHz/Eh1hklpDBT8dksr
X-Authority-Analysis: v=2.4 cv=W+w4VQWk c=1 sm=1 tr=0 ts=681b7e76 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=ZRoeV-iSnVhfcXUvIQsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01

From: Keith Busch <kbusch@kernel.org>

The integrity buffer is mandatory for nvme formats that have metadata
whether or not you want it generated or verified. The block integrity
attributes read_verify and write_generate had been stopping the metadata
buffer from being allocated and attached to the bio entirely. We only
want to suppress the protection checks on the device and host, but we
still need the buffer.

Otherwise, reads and writes will just get IO errors and this nvme warning=
:

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
 block/bio-integrity-auto.c | 31 +++++++++++++++++++------------
 block/t10-pi.c             |  5 +++++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/block/bio-integrity-auto.c b/block/bio-integrity-auto.c
index e524c609be506..301406671f3b6 100644
--- a/block/bio-integrity-auto.c
+++ b/block/bio-integrity-auto.c
@@ -69,6 +69,16 @@ bool __bio_integrity_endio(struct bio *bio)
 	return true;
 }
=20
+static inline void bio_set_bip_flags(struct blk_integrity *bi, u16 *bip_=
flags)
+{
+	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
+		*bip_flags |=3D BIP_IP_CHECKSUM;
+	if (bi->csum_type)
+		*bip_flags |=3D BIP_CHECK_GUARD;
+	if (bi->flags & BLK_INTEGRITY_REF_TAG)
+		*bip_flags |=3D BIP_CHECK_REFTAG;
+}
+
 /**
  * bio_integrity_prep - Prepare bio for integrity I/O
  * @bio:	bio to prepare
@@ -83,6 +93,7 @@ bool __bio_integrity_endio(struct bio *bio)
 bool bio_integrity_prep(struct bio *bio)
 {
 	struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_disk);
+	unsigned short bip_flags =3D BIP_BLOCK_INTEGRITY;
 	struct bio_integrity_data *bid;
 	gfp_t gfp =3D GFP_NOIO;
 	unsigned int len;
@@ -101,19 +112,22 @@ bool bio_integrity_prep(struct bio *bio)
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
 		if (bi->flags & BLK_INTEGRITY_NOVERIFY)
-			return true;
+			break;
+		bio_set_bip_flags(bi, &bip_flags);
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
+		if (bi->flags & BLK_INTEGRITY_NOGENERATE) {
+			gfp |=3D __GFP_ZERO;
+			break;
+		}
 		if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_NONE)
 			gfp |=3D __GFP_ZERO;
+		bio_set_bip_flags(bi, &bip_flags);
 		break;
 	default:
 		return true;
@@ -134,16 +148,9 @@ bool bio_integrity_prep(struct bio *bio)
=20
 	bid->bio =3D bio;
=20
-	bid->bip.bip_flags |=3D BIP_BLOCK_INTEGRITY;
+	bid->bip.bip_flags =3D bip_flags;
 	bip_set_seed(&bid->bip, bio->bi_iter.bi_sector);
=20
-	if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
-		bid->bip.bip_flags |=3D BIP_IP_CHECKSUM;
-	if (bi->csum_type)
-		bid->bip.bip_flags |=3D BIP_CHECK_GUARD;
-	if (bi->flags & BLK_INTEGRITY_REF_TAG)
-		bid->bip.bip_flags |=3D BIP_CHECK_REFTAG;
-
 	if (bio_integrity_add_page(bio, virt_to_page(buf), len,
 			offset_in_page(buf)) < len)
 		goto err_end_io;
diff --git a/block/t10-pi.c b/block/t10-pi.c
index 851db518ee5e8..41c863c927cf4 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -380,6 +380,9 @@ void blk_integrity_generate(struct bio *bio)
 	struct bvec_iter bviter;
 	struct bio_vec bv;
=20
+	if (bi->flags & BLK_INTEGRITY_NOGENERATE)
+		return;
+
 	iter.disk_name =3D bio->bi_bdev->bd_disk->disk_name;
 	iter.interval =3D 1 << bi->interval_exp;
 	iter.seed =3D bio->bi_iter.bi_sector;
@@ -412,6 +415,8 @@ void blk_integrity_verify_iter(struct bio *bio, struc=
t bvec_iter *saved_iter)
 	struct bvec_iter bviter;
 	struct bio_vec bv;
=20
+	if (bi->flags & BLK_INTEGRITY_NOVERIFY)
+		return;
 	/*
 	 * At the moment verify is called bi_iter has been advanced during spli=
t
 	 * and completion, so use the copy created during submission here.
--=20
2.47.1

