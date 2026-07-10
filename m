Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF153A4513
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718544; cv=none; b=N1xMDa1iFinTkbCeXynCQeAF3QJhsBeZC+dntUTMull94vWRKbHsH9gAZnCdR54p6XKkoDRrfYN/w8CNf6y2W2oFoCiKV7ztFn+bueWDaxcPtJLtQv0nnRdAG0MlvTZHK2bzwnXFmYktQ2Qcy9dWKfJt7PPK5lqbE/J6OX5Qzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718544; c=relaxed/simple;
	bh=TU+LUGwCziPtGXz/xcEn7xp/7aDfzxrCTocRmbm6emM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSvnWGjoWvZnt39kqk1eLSedQT/IKlGLrhVdZr1cFiD9yD0GIKuwBq0Ls+pwLzIQ5wmxGHIkmjLyEiz2h/n7cCU4ECzV6REfv0PWDUoPFsj/BnS+obvtj/trYIwpUYCw3WDdIVczX4cu1wZ9SXgVg+bTSSwxiytDY/JUH0kJfnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=YPwm8hGk; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="YPwm8hGk"
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66AK4Ht82117081
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:22:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=2ra2M14mPjMEDwZtVI1Y4/LFgJcvxGANhXPScPmJWN0=; b=YPwm8hGkNags
	M8mgdioBCyh0E1DdmwOyquzs/9fSMb0JyEfcZrL8NUwndTL5aTD2H/vJtEllH7oG
	XouRNg3WNgDTaFaNRBad1s8wTwN3vW2L8f/BzDDmF6cIRyr1Im5vP3NIea4Eo2O/
	0mYc/hORdUyc+al6rmt93mXljY4gjRRO6O9I5BCXyE+1sqcufuOO+++wSjh/Iy15
	Z5beoej/l5D7ztBRst5EPSPhNCQuKgeM0lUOEOF05KbdgcaVZVLAz7VWbQ7YkLdd
	3UugrGnI98n4YtUPp/QnuBfLAbp3chlXRgbffETMf1XFw5p6JTXLF0Ddtg3ggW0P
	K3ojrZdufw==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 4fafb0rs67-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:22:22 -0700 (PDT)
Received: from twshared17991.01.snb2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 10 Jul 2026 21:22:19 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 651C524F006FE; Fri, 10 Jul 2026 14:06:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC: <axboe@kernel.dk>, <jack@suse.cz>, <brauner@kernel.org>, <cem@kernel.org>,
        <jaegeuk@kernel.org>, <aalbersh@kernel.org>, <tytso@mit.edu>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 4/5] ext4: report direct io attributes through file_getattr
Date: Fri, 10 Jul 2026 14:06:45 -0700
Message-ID: <20260710210646.3576365-5-kbusch@meta.com>
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
X-Proofpoint-GUID: hSuWjUQX8NiQu73EMuofzuCDKUcSOVcG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfXyylfkTp0DbDU
 D4zAXmQ/yZm2SnJ34jS8ZoIbjoG7acOFmkmnDoKKdtiBO/KDnXalXXqtme5mrNt3H0nmcvADjfv
 lWPCqjPHi5N0hknivT86MtaijJLQat7gCf9YGUp5ACV7TRtcIB793zxksoxzEDLQqDfgtqODgqw
 q+KSE67w6idSHkhvbow396O/Jv3HhMpjX15E2+G+aGvfobRNZdZIGqusUwCXeMRZcX4GJbikSDk
 yytc/3mSAUPiqC94KE1PjhlOU9Nly8y+l2Ev+8Lfk3MXfIasXCBS6fNwSGGUYopIbMOTB1RdXUA
 x+X8FVCUSW68bEA+4kgDkCFCvHXcryokqMpOBHOuZrtmX5bfdNDru6DqpMC83HUOPzR/ysXLDB3
 is4nUB3bR7aJ984b9nFYu4kS/KETq9hyX1ptpJ3hWMfqVDrcINXebWUCMzwR781BumQ8t+9zAgX
 bMUHwuGe5NbJDecEvRg==
X-Proofpoint-ORIG-GUID: hSuWjUQX8NiQu73EMuofzuCDKUcSOVcG
X-Authority-Analysis: v=2.4 cv=ca7iaHDM c=1 sm=1 tr=0 ts=6a51628e cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=_78whYxrdx1mplLwxq1U:22 a=VwQbUJbxAAAA:8 a=Rmsuq2NR91XQagnBW_8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfX7w5r4dw5uEid
 t6EMMFR5wo3h+mb48GZLB8gjC/wHzZW65fBZ6iP7rcnByCmNDnDr+YBv1YWWvjW7HTMo68CRbDk
 6tamm8rxQjlfqmdranY/dRVXz7w8H54=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Fill in the direct io alignment attributes for regular files, using the
block helper and overriding the offset alignment for the cases where ext4
requires filesystem block alignment.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/ext4/ioctl.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index c8387e6a2c6e9..01617edff17a8 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -21,6 +21,7 @@
 #include <linux/iversion.h>
 #include <linux/fileattr.h>
 #include <linux/uuid.h>
+#include <linux/blkdev.h>
 #include "ext4_jbd2.h"
 #include "ext4.h"
 #include <linux/fsmap.h>
@@ -992,6 +993,27 @@ static long ext4_ioctl_group_add(struct file *file,
 	return err;
 }
=20
+static void ext4_fileattr_get_dio(struct inode *inode, struct file_kattr=
 *fa)
+{
+	u32 dio_align;
+
+	if (!S_ISREG(inode->i_mode))
+		return;
+
+	dio_align =3D ext4_dio_alignment(inode);
+	if (!dio_align)
+		return;
+
+	bdev_fill_dio_attr(inode->i_sb->s_bdev, fa);
+	if (dio_align !=3D 1) {
+		fa->fsx_dio_mem_align =3D dio_align;
+		fa->fsx_dio_offset_align =3D dio_align;
+		fa->fsx_dio_read_offset_align =3D dio_align;
+	}
+
+	fa->fsx_xflags |=3D FS_XFLAG_DIO;
+}
+
 int ext4_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode =3D d_inode(dentry);
@@ -1005,6 +1027,7 @@ int ext4_fileattr_get(struct dentry *dentry, struct=
 file_kattr *fa)
 	if (ext4_has_feature_project(inode->i_sb))
 		fa->fsx_projid =3D from_kprojid(&init_user_ns, ei->i_projid);
=20
+	ext4_fileattr_get_dio(inode, fa);
 	return 0;
 }
=20
--=20
2.53.0-Meta

