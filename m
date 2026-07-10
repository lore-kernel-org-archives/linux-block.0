Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264A3B47D7
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718247; cv=none; b=DPPssNVc9j0oSzLxfZJaVLRA82sFkIlzDMfZ7+JSheWAH30O08aqSZsHSayDoQ1HdFibsA0/dOCeMMlnyxMido+qk98ONbyAOcx6jwn/KaJT21gsBxw9CqkjD8HDKDNQR+6KlOwTpGp7jSHOt2GViQJYfs0KZpqjNx0jpP0wsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718247; c=relaxed/simple;
	bh=6ERSF6ryDcx0TbMDYmFk7KUh2TmJgZf0hpodIU9tf/U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnNugK6AarqVDEMKMFyW09Ies/y7uycyyfgT3JRVPyyUK36JKAvCrEj++DjX+eIKnintxVSnL5m8G+U02nnt92iODMSrlIcIwUCWaK65om+TxXmwpYyJWdwYOqU9Z5w2DI4Fx1nbfCzDysS7r9++v1Zi0LdoWdSOMuF9uNOQto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=An0itSPr; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="An0itSPr"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66AK4Hsc2117081
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:17:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=x8TxgEgZ50NKSAxdVZCc/M4ZywYRdPGr0pKf7nc2CgQ=; b=An0itSPr6HdN
	alBofYUTXgczOokCggBb2PmGRmCGZA0qsCcHyeVw+8b8A+QOsfY3wS93SAHonBLN
	BgHMePcimBGKvs9BTsYBtE5E2z2snDkfyNBsL/q8VNYmVz571EgcWnrnuHQBraTX
	oQAK5blH2R/vx54MsJGv5TRAYGp0lncBdEGI48a6by9TivoX+T8jTgTp0BQ/8iND
	FsfMrc4Fp9jfSUhRQUIpq2zYnvRw3JiOBQFbPMJnFoDgegaiBBns+jHNuZNUmwQG
	yZzT4PAs0v5ns4Luu0M2VEr7Cd7kXy7EacO50N4v0HKH0+DeOME71KAv6wDqC6qK
	bMSUz5MwTA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4fafb0rrhu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:17:23 -0700 (PDT)
Received: from twshared20290.04.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 10 Jul 2026 21:17:22 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5CDF324F006FB; Fri, 10 Jul 2026 14:06:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC: <axboe@kernel.dk>, <jack@suse.cz>, <brauner@kernel.org>, <cem@kernel.org>,
        <jaegeuk@kernel.org>, <aalbersh@kernel.org>, <tytso@mit.edu>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 3/5] xfs: report direct io attributes through file_getattr
Date: Fri, 10 Jul 2026 14:06:44 -0700
Message-ID: <20260710210646.3576365-4-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710210646.3576365-1-kbusch@meta.com>
References: <20260710210646.3576365-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: K5YgMQOSgwaIGOGNMTgQpVmSWPURXhDv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfX6qvvt1XCqw2r
 +akRK6b+XCa4JR9jkDU/787TIFGjBmP1FVbEbOxG/OPRxDUL+HAN2b3JKq3NGza8ZqtEX4aAChB
 ms9WwlfvL6k/1Vxjw8gIhnIZUAtVd74Cw8NdP+Oaxw92ICTMVUcfbUOMZCga1gwN62YW6uYltUp
 7p2Y8IPkY4dngdjSvcq/dbH6b6T31l0KLKuzXmOuz1Wjqug9dYiWqyw8RJ4pJzud01SGJMEtRLj
 wtGMFbF/dwQqeTtRjkfI0uxotletJ0ylTjM4jTPARzCfdmfZnVPO/ICgDs37gdWWORnPOosZmnK
 ejZ8gu8N7giJt+MrlANyfy+KpYG57/fYFD3u4FlWRJYoL2uosmN8cBV2D2kvLLGoaXjbodBc6GP
 3Jl7K6RdvXCdimVTB2Q/FhqvD7CA5UofXT74YXBfGGds+kX3eOUvYTr1TuHa5KKOWRZ+KzYi5Ke
 yuKJcctDdBbttbiB2lQ==
X-Proofpoint-ORIG-GUID: K5YgMQOSgwaIGOGNMTgQpVmSWPURXhDv
X-Authority-Analysis: v=2.4 cv=ca7iaHDM c=1 sm=1 tr=0 ts=6a516164 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=aFTrS7NZ_-S66cRtsDsA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfX1W0RznY0satz
 7ekE6GYa4d9M06CLmc89ZUo445OessFZ/kpX5bXmrGlDV6WICaedtjbZOY3e7RtcKUz0BoLJmNW
 /WxzOM3/Gu55U48v/XM2/XHuTS64WOI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Fill in the direct io alignment attributes for regular files, reporting
the larger write alignment for CoW inodes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/xfs/xfs_ioctl.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 1b53701bebea1..d585242a8fe9f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -49,6 +49,7 @@
=20
 #include <linux/mount.h>
 #include <linux/fileattr.h>
+#include <linux/blkdev.h>
=20
 /* Return 0 on success or positive error */
 int
@@ -468,6 +469,29 @@ xfs_ioc_rtgroup_geometry(
  * Linux extended inode flags interface.
  */
=20
+static void
+xfs_fill_fsxattr_dio(
+	struct xfs_inode	*ip,
+	int			whichfork,
+	struct file_kattr	*fa)
+{
+	struct xfs_buftarg *target;
+
+	if (whichfork !=3D XFS_DATA_FORK || !S_ISREG(VFS_I(ip)->i_mode))
+		return;
+
+	target =3D xfs_inode_buftarg(ip);
+	bdev_fill_dio_attr(target->bt_bdev, fa);
+	/*
+	 * CoW inodes must write whole allocation units out of place, so report
+	 * the larger write alignment while leaving the smaller read alignment
+	 * from the queue limits in place.
+	 */
+	if (xfs_is_cow_inode(ip))
+		fa->fsx_dio_offset_align =3D xfs_inode_alloc_unitsize(ip);
+	fa->fsx_xflags |=3D FS_XFLAG_DIO;
+}
+
 static void
 xfs_fill_fsxattr(
 	struct xfs_inode	*ip,
@@ -517,6 +541,8 @@ xfs_fill_fsxattr(
 		fa->fsx_nextents =3D xfs_iext_count(ifp);
 	else
 		fa->fsx_nextents =3D xfs_ifork_nextents(ifp);
+
+	xfs_fill_fsxattr_dio(ip, whichfork, fa);
 }
=20
 STATIC int
--=20
2.53.0-Meta

