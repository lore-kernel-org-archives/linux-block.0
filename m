Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68D93B14C2
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718548; cv=none; b=JCafp1IxtfsG288pYLXtTW3gWY/RibFIWH2M0QqDcWeZx487c4Yf6hxn8wkPdyf5CK0jQPlW/9Lob/f5BxHc/OQ89i5sZg77TPkO/xqFIiBkI0S/klpuJve4PkWSoAwinlLQhf7eRLzvOo6dVK1kkDzCthDmwsIvbGIAXETmvLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718548; c=relaxed/simple;
	bh=gBmff/S2QZrJgWTHySSSXXxR1EHOnaBgE43eAXRvrA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+bjnwmhY7+ImYUVjQW7wrn4ZJ1sd4ABGqNxip7R2x75N5e6Tqb9rYLohl8xuw9aEkxgl6g0JUP+UsRWBpQnCPIW27Uw4ybvxfLFYcdL4HkoPt8uqlA1AHr2UcWTGeUS5I47KJMu8wcOsmSs4oJXYpJ91mm6jqSpFPj4TjDzoeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=pAzbPZI+; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="pAzbPZI+"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66AK4HtG2117081
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=fBFW6r5qhutFJo5e1jNRGeTqFLwVtoEdyEwQDWofL+c=; b=pAzbPZI+Y1Uu
	adkhk8uUc21ooj2i5+pk7eYatt6jhMcpcM2nnUTkIiaOe/nCFppJN4mXAWW7gtzz
	3NOL+h4oTGpQtXWwjvH8z67aADnSmZb8gsGQlpdGZTA90Vmuk5aBTbdSlawjQriC
	EdXHCyIKd5ofawhaF4ul8tyqi0l1EJI0FEi/FZwOcFSf3tNrKzX97GxHqqoHRylh
	MT9g3i3EVD1mT+nCcWUt7uViVz7iAeE9yhA4R1mhQ8U2lWzytDTELwVAqvgFCyyo
	t69nKC7FgnSPZ+J0i4TXZPRalchZ7m/v6NhYOnR8BNRZGXRuRK19xUthdHf07KaT
	mf9Wl5x6Ig==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4fafb0rs67-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:22:25 -0700 (PDT)
Received: from twshared21331.34.frc3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 10 Jul 2026 21:22:20 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6716624F006FF; Fri, 10 Jul 2026 14:06:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC: <axboe@kernel.dk>, <jack@suse.cz>, <brauner@kernel.org>, <cem@kernel.org>,
        <jaegeuk@kernel.org>, <aalbersh@kernel.org>, <tytso@mit.edu>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 5/5] f2fs: report direct io attributes through file_getattr
Date: Fri, 10 Jul 2026 14:06:46 -0700
Message-ID: <20260710210646.3576365-6-kbusch@meta.com>
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
X-Proofpoint-GUID: 6Ccv22TjLHT0xuQmFqDCxFxD4jT7QTOQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfX+WRj5yP7P3wM
 gsaDkZe7d44ByiKEfibywLgo1JRudOiDdjk4NOyc+A+hcaMQ8ueXKvITwtli6dLBYD3jjk7Tc+I
 N3N57OjQCS0bnFCokJMe124h1hAxssmcaVNrsX0ajeCjOGatk4A3ootR9xfIKgq+jnARunZ72xi
 djdiS34gGKEOKmhCIuB/GvEEBWpFYgWyj7zswfFRtjQ9YO5Oia5YcG+L3182Gi1qGAo8dkBEoiM
 bem+FgEeQTiTrRfF+lDEdECfwmf1BsI6kIsiXDIErMSCCgp1CwVw9uL+FIRp73HaIzRNluge3XC
 YLhka5GjVNrzskAmZuZ8tMln/reY0eWHipONso0FPViziA1PTryxTdxyPsFxHzywlMtzRPw4z09
 Pr2D+Cle0/0xhNcK9+boOrA/fbfXeia0VpZpZayvMRjYQo6c5smkaquwIPiAZR1BIBdMHDhaGIT
 9Jm9OcUzYrbaW/uAKZA==
X-Proofpoint-ORIG-GUID: 6Ccv22TjLHT0xuQmFqDCxFxD4jT7QTOQ
X-Authority-Analysis: v=2.4 cv=ca7iaHDM c=1 sm=1 tr=0 ts=6a516291 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=iTomd4heqAZg2W2pUTYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfX+EIloM0N15wx
 YuChPsIlfJwKW2QWfvTUH9OBvXUSlZ0LulXPPkNIxtK3slkOTwbatLVlXYIt98yacminLOWmlth
 KyQJAHwmzlSxfVuwkGx9fDyI/lJ74eI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Fill in the direct io alignment attributes for regular files that support
direct writes.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/f2fs/file.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f07..230b0dca06251 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3452,6 +3452,25 @@ static int f2fs_ioc_setproject(struct inode *inode=
, __u32 projid)
 }
 #endif
=20
+static void f2fs_fileattr_get_dio(struct inode *inode, struct file_kattr=
 *fa)
+{
+	struct block_device *bdev;
+	unsigned int bsize;
+
+	if (!S_ISREG(inode->i_mode) || f2fs_force_buffered_io(inode, WRITE))
+		return;
+
+	bdev =3D inode->i_sb->s_bdev;
+	if (bdev)
+		bdev_fill_dio_attr(bdev, fa);
+
+	bsize =3D i_blocksize(inode);
+	fa->fsx_dio_mem_align =3D bsize;
+	fa->fsx_dio_offset_align =3D bsize;
+	fa->fsx_dio_read_offset_align =3D bsize;
+	fa->fsx_xflags |=3D FS_XFLAG_DIO;
+}
+
 int f2fs_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode =3D d_inode(dentry);
@@ -3472,6 +3491,7 @@ int f2fs_fileattr_get(struct dentry *dentry, struct=
 file_kattr *fa)
 	if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)))
 		fa->fsx_projid =3D from_kprojid(&init_user_ns, fi->i_projid);
=20
+	f2fs_fileattr_get_dio(inode, fa);
 	return 0;
 }
=20
--=20
2.53.0-Meta

