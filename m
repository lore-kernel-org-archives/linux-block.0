Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4A9414A1F
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 16:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380182; cv=none; b=SAObULYDHq6NTZ/OcTk7VKD8UQ/vJdC0x3hmZVM6Hv/eSmyf5152Ts9o4glzFBkl3XRpo+KSiQA0rAJ8YV2h9LvPbA6/ku39RSkmvwW4cnH0Beu9JdejwSR3wD1G8/88jIwXlj2k46MNTnZ+WN73ln22nBuTyeWnnQDMCH0So1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380182; c=relaxed/simple;
	bh=njPWa+VQ6dJJES63WuP7C/QeJUVXmTKDEQ1US3l+Aao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=szoXokggj+xGbV8LpfUuj4aCm/MYCgPLFoOktIPfqx27u0QS1ic0ULIF34UT8BFpGJ90wB9/R41VeZ1STqfqkJYPTQ4QsPYGs5bCntvU/yG/gZJbMF1W5cDMqJGhLMqh3LZv3GgJYU1R/zC+gElN6e4wKhwWus5Rfd01obZW7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=AjV0qs+c; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="AjV0qs+c"
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGWDPl1256800
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 09:42:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=RM/i3Aj+C
	uXgrfwxXdHkQzfSrvQP6n4P899foFoS0Ns=; b=AjV0qs+cKwZfytepI5+AF1awA
	71wbRKgPyjcywyAc8ZN+8r9orH0NhDrGW1QJIytApUSp28YeXQQ2d1x9dOz7Su2r
	OIoveP0bRrGfJDTwqxtji0SYq5WENAV5lMiU+bJCnsisdcthi/DFN0QtOdmOcDSw
	CYTKDbR0sAhLxmlxx3g/QEjSuanKgknSf8Ni6dRhWO5GGrewVoShU2SWn+k+GvR9
	XbYvdJ/HcyEeIuzMdgEucYT+/Ijvlt1y9aWhO72zlM+e0byC7ubKgE69QjJR2NPE
	mcWobLB9l1HhpdZX1ga4lmjaDW1DgqgASmwP5oxziDO/Ada7nLk1zooo02AlA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fxrftedar-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 09:42:53 -0700 (PDT)
Received: from twshared17359.34.frc3.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Mon, 10 Aug 2026 16:42:51 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id EB3FF278E868D; Mon, 10 Aug 2026 09:42:20 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>,
        <syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com>
Subject: [PATCH] loop, zloop: fix dma_alignment for large or unreported limits
Date: Mon, 10 Aug 2026 09:42:17 -0700
Message-ID: <20260810164218.3721636-1-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0MyBTYWx0ZWRfX4LM4iXy2Lq+w
 I4JgWby1GSg8Z+JUZ/ow2dipD80F01yOhZ/mVpP4qosxgLkhl/Ckjzb3MOL4KK/ffrO1K7yHDqz
 MJqFfDbdmLyL6G1cUBZoFesbYtec0BRUK+mxpZw/kQmch/+F3sjdg5HvBjvAUisZBVtbQx6E+SF
 o9mfJ/FJCd98I5btQaoLy+TRJZ/keBzB8sv3H4nZ1A2123lJPVNzQwD4yHqbupuhyF4YfIWOc5U
 ahCCD4/xlwko4FnUPY9tHjUuc5pAdt4x0jlUm5q7Wua3Y++Z1KMQ38eJAQmrCMH85xade2+JDxQ
 BKItEGKBkjNj8TNGU/XSOGpZoU5WQ4nIrxsf2fx9i3a3/VPW4d5GVptErf2000DNXoWfG1oRzNT
 nIuxwTSHBK8Ee86WEOM+QkTCxtf9WTgG+TgsbiCtJKEjdieziLrRAtB3pQgi41ekTOwhLJzfJfQ
 GdwgM7NVTU5s70E3dJA==
X-Proofpoint-GUID: mCKF3EhCtFAvCaEe2n7KSgnE4L-fYEgK
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0MyBTYWx0ZWRfX12I0L8LJTu2m
 XJMnxnlxF/aHK5ApyICxgoA9JUpi+yGRBt2kNB6lrtm+A2SG1wtw+MxY0Yy5pdqOvORfu+KsXXz
 gtWTgoYEMY+NH88JcrwkfsMwxIjzZU8=
X-Authority-Analysis: v=2.4 cv=c8Wbhx9l c=1 sm=1 tr=0 ts=6a79ff8d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=4h92JMTCafKA-fb_NiOh:22 a=edf1wS77AAAA:8 a=VwQbUJbxAAAA:8 a=hSkVLCK3AAAA:8
 a=FuhZsodB_9_TbugH65AA:9 a=DcSpbTIhAlouE1Uv7lRv:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: mCKF3EhCtFAvCaEe2n7KSgnE4L-fYEgK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

A file system sets STATX_DIOALIGN with zeroed alignments when the file
can't be used for direct I/O. The zero underflowed to UINT_MAX and
triggered a queue limits validation warning. Fall back to the block
device's limits when dio_mem_align isn't reported.

A file system with a block size larger than PAGE_SIZE may also report a
memory alignment that can't be expressed as a queue limit. File systems
fall back to buffered I/O for requests that don't meet their alignment,
so cap the reported limit to the largest possible value.

Fixes: 6c8dec275ccc ("loop: set dma_alignment from the backing file for d=
irect I/O")
Fixes: c5059c1af2bd ("zloop: set dma_alignment from the backing files for=
 direct I/O")
Reported-by: syzbot+ac00e7bf7ac8c91af921@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3Dac00e7bf7ac8c91af921
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/block/loop.c  | 8 +++++---
 drivers/block/zloop.c | 8 +++++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 8639fa34b8470..cbf1e2ce27126 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -458,12 +458,14 @@ static void loop_update_dio_alignment(struct loop_d=
evice *lo)
 	 * Use the dio alignment of the file system if provided.  The incomoing
 	 * request's bio_vec is forwarded to the backing file unchanged, so its
 	 * required memory alignment becomes the device's dma_alignment when
-	 * used for direct-io.
+	 * used for direct-io.  The file system reports zeroed alignments if th=
e
+	 * file can't be used for direct-io at all, so fall back to the block
+	 * device limits in that case.
 	 */
 	if (!vfs_getattr(&file->f_path, &st, STATX_DIOALIGN, 0) &&
-	    (st.result_mask & STATX_DIOALIGN)) {
+	    (st.result_mask & STATX_DIOALIGN) && st.dio_mem_align) {
 		lo->lo_min_dio_size =3D st.dio_offset_align;
-		lo->lo_dio_mem_align =3D st.dio_mem_align - 1;
+		lo->lo_dio_mem_align =3D min(st.dio_mem_align - 1, PAGE_SIZE - 1);
 		return;
 	}
=20
diff --git a/drivers/block/zloop.c b/drivers/block/zloop.c
index 4323ac108cae8..f0ca221524db6 100644
--- a/drivers/block/zloop.c
+++ b/drivers/block/zloop.c
@@ -1042,12 +1042,14 @@ static int zloop_get_block_size(struct zloop_devi=
ce *zlo,
 	 * Use the dio alignment of the file system if provided.  The incoming
 	 * request's bio_vec is forwarded to the backing file unchanged, so its
 	 * required memory alignment becomes the device's dma_alignment when
-	 * used for direct-io.
+	 * used for direct-io.  The file system reports zeroed alignments if th=
e
+	 * file can't be used for direct-io at all, so fall back to the block
+	 * device limits in that case.
 	 */
 	if (!vfs_getattr(&zone->file->f_path, &st, STATX_DIOALIGN, 0) &&
-	    (st.result_mask & STATX_DIOALIGN)) {
+	    (st.result_mask & STATX_DIOALIGN) && st.dio_mem_align) {
 		zlo->block_size =3D st.dio_offset_align;
-		zlo->dio_mem_align =3D st.dio_mem_align - 1;
+		zlo->dio_mem_align =3D min(st.dio_mem_align - 1, PAGE_SIZE - 1);
 	} else if (sb_bdev) {
 		zlo->block_size =3D bdev_physical_block_size(sb_bdev);
 		zlo->dio_mem_align =3D bdev_dma_alignment(sb_bdev);
--=20
2.53.0-Meta

