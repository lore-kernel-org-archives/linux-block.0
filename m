Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38893B4EB3
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718252; cv=none; b=mtKc9cg7n+Vzc1RJYGHVgVCwSYhH9zgRVNyFDRUnUMzX45l+o/7jYoFncyCg/NDt/458xrZIXlXyWH3Prl5GzatoRm3XWX2NaIsrJJ+an1Uup/fPEGLLlAOTc80er5cyNZWFh3FUgUfQgYFY19sec9i/fgMVb01bGIKkSd3xmTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718252; c=relaxed/simple;
	bh=FkP3AUBSRLhuO8aUT4xsg+Y6VlQlkk9STUOSPTqaQMo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bdItf08h/C8u195vIgoK8B88EtPc1ysX0Q4/oJhi03EYvSw5mwu11TzaatNbeCPNL0TUpUdaRwcjAT33HgqqhJj4GyVx2QuOc7ACjXpPYgKtARM49jouknxcCuUcS/iJiFCHjIBzlVwQsC8ZSA6yZ3D9ZUV5r8jr/ar0c4TSAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Ot4Lu/ZK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Ot4Lu/ZK"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK4AP02308718
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:17:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=NS1QjaM7KqlyEkyaHi1hRKu76qygyqAC7YHvMQnkRIU=; b=Ot4Lu/ZKo32+
	M/R8XRizJRuVFbKdxo8YdR4tF9lGfQE6Evh1eE2/yGHI3KWzcOojKGnQSKXwhG2R
	zgje5s/LiwoaXC+aXkNA5/HOtzH5IUVHz1wjS4neNLi9p+hjI5LbHkdRhPEmLGEr
	QfYJzMw1yTNIC81moDSF0NM3p24UFtBgjp9HkbafeaSPq9noATtYD1Rivy+ZVGJ3
	bcaoUEBuwtO+z6xIzXfJhX4wq4/oQsXgdsDfL9GaJpTT2li0FRP6qG9R6LvsybfM
	B97QuXbV6RpdqBoxNXEIk5MIAOROdJPofYh0R7AaHGD8Ocon/ebRsh2OJmNNIm3c
	kW5gIN4yEQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fa9djk4mv-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:17:29 -0700 (PDT)
Received: from twshared4282.01.snb2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 10 Jul 2026 21:17:23 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 5128424F006F6; Fri, 10 Jul 2026 14:06:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC: <axboe@kernel.dk>, <jack@suse.cz>, <brauner@kernel.org>, <cem@kernel.org>,
        <jaegeuk@kernel.org>, <aalbersh@kernel.org>, <tytso@mit.edu>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 2/5] block: report direct io attributes through file_getattr
Date: Fri, 10 Jul 2026 14:06:43 -0700
Message-ID: <20260710210646.3576365-3-kbusch@meta.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfXxuhfJwA7MueJ
 Lff9fnYLJWH5nDacfn7QbuufTKReHZ6ym4qpnCfyDCzpQy5jzx1IDnjc0FmXuN1VpqW+cvnIiHA
 cKFgX1OCks1DeRaAUho/Vky+863bycg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNCBTYWx0ZWRfXz+wUbqsyz9Ld
 TJIbXtbV8F+n42yQLMU/5gArGDidvkZXMEPbTi+5l4/g3KJBv65lvPnHCuKemMNpO4GuTaGNlt9
 b8CQ1+vg9O9FtKxwYzc6o+WtjF6mlOTGtyMQLy4fK8U4t9ZALqDPWyIsn5EazFbFta5P+N8BPsj
 9+mMvu0pvC1oiWyCWGGrF9rmDW/HJYVIA6kvT3YodgegYc9XcbkuNy9R9clljbxFBbQaFlfJS2k
 ROceD3OrH7wPTgqPcn/il31K12wkjysqJI2pBzH7vxkTcDmZAC+TwxVU6wdrBy8ztSsDQO17i2O
 nJvSa0cRXbNEtdAs7W+o8gqUQVGlNEWuELcolhFcPi9Pt3q3C5QiJ3dYPJ57NYGj7pXiGvpri/7
 +vszba+RrvtJ/IECJaBdENSlzUrFu9vCSbrL4C844WNiK0Dtkb9WGzwsa9RU69c9zVKv3geq330
 QkFieEInV/eGbDtuU1A==
X-Authority-Analysis: v=2.4 cv=ToHWQjXh c=1 sm=1 tr=0 ts=6a516169 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=m71_QMC5m3MnXAGbFz4A:9
X-Proofpoint-ORIG-GUID: cJI5tdqytUZRFEvKYxQpYIpdj37perGi
X-Proofpoint-GUID: cJI5tdqytUZRFEvKYxQpYIpdj37perGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Add bdev_fill_dio_attr() to fill the file_attr direct io alignment
fields from a block device's queue limits, so filesystems can share the
derivation. Use it to report the attributes for block devices opened
directly.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bdev.c           | 37 +++++++++++++++++++++++++++++++++++++
 fs/file_attr.c         |  6 +++++-
 include/linux/blkdev.h | 14 ++++++++++++++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 85ce57bd2ae4f..3b56f6696d3a3 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -28,6 +28,7 @@
 #include <linux/part_stat.h>
 #include <linux/uaccess.h>
 #include <linux/stat.h>
+#include <linux/fileattr.h>
 #include "../fs/internal.h"
 #include "blk.h"
=20
@@ -1353,6 +1354,42 @@ void bdev_statx(const struct path *path, struct ks=
tat *stat, u32 request_mask)
 	blkdev_put_no_open(bdev);
 }
=20
+/*
+ * Fill the direct I/O alignment attributes derived from a block device'=
s
+ * queue limits.  Filesystems override the offset alignments as needed a=
nd
+ * set FS_XFLAG_DIO once they have decided direct I/O is supported.
+ */
+void bdev_fill_dio_attr(struct block_device *bdev, struct file_kattr *fa=
)
+{
+	fa->fsx_dio_mem_align =3D bdev_dma_alignment(bdev) + 1;
+	fa->fsx_dio_offset_align =3D bdev_logical_block_size(bdev);
+	fa->fsx_dio_read_offset_align =3D bdev_logical_block_size(bdev);
+	fa->fsx_dio_virt_boundary_align =3D bdev_virt_boundary_alignment(bdev);
+	fa->fsx_dio_offset_align_max_vecs =3D bdev_max_segments(bdev);
+}
+EXPORT_SYMBOL_GPL(bdev_fill_dio_attr);
+
+/*
+ * Handle DIO alignment for block devices via fileattr.
+ */
+int bdev_fileattr(const struct inode *inode, struct file_kattr *fa)
+{
+	struct block_device *bdev;
+
+	bdev =3D blkdev_get_no_open(inode->i_rdev, false);
+	if (!bdev)
+		return -ENODEV;
+
+	memset(fa, 0, sizeof(*fa));
+	bdev_fill_dio_attr(bdev, fa);
+	fa->fsx_valid =3D true;
+	fa->flags_valid =3D true;
+	fa->fsx_xflags |=3D FS_XFLAG_DIO;
+
+	blkdev_put_no_open(bdev);
+	return 0;
+}
+
 bool disk_live(struct gendisk *disk)
 {
 	return !inode_unhashed(BD_INODE(disk->part0));
diff --git a/fs/file_attr.c b/fs/file_attr.c
index b37a55f54a449..b637eff9081aa 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -7,6 +7,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/namei.h>
+#include <linux/blkdev.h>
=20
 #include "internal.h"
=20
@@ -88,13 +89,16 @@ int vfs_fileattr_get(struct dentry *dentry, struct fi=
le_kattr *fa)
 	struct inode *inode =3D d_inode(dentry);
 	int error;
=20
-	if (!inode->i_op->fileattr_get)
+	if (!inode->i_op->fileattr_get && !S_ISBLK(inode->i_mode))
 		return -ENOIOCTLCMD;
=20
 	error =3D security_inode_file_getattr(dentry, fa);
 	if (error)
 		return error;
=20
+	if (!inode->i_op->fileattr_get)
+		return bdev_fileattr(inode, fa);
+
 	return inode->i_op->fileattr_get(dentry, fa);
 }
 EXPORT_SYMBOL(vfs_fileattr_get);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95a..2d435fadfdcb9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1607,6 +1607,17 @@ static inline unsigned int bdev_dma_alignment(stru=
ct block_device *bdev)
 	return queue_dma_alignment(bdev_get_queue(bdev));
 }
=20
+static inline unsigned long bdev_virt_boundary_mask(struct block_device =
*bdev)
+{
+	return bdev_get_queue(bdev)->limits.virt_boundary_mask;
+}
+
+static inline unsigned int
+bdev_virt_boundary_alignment(struct block_device *bdev)
+{
+	return bdev_virt_boundary_mask(bdev) + 1;
+}
+
 static inline unsigned int
 blk_lim_dma_alignment_and_pad(struct queue_limits *lim)
 {
@@ -1805,6 +1816,9 @@ int sync_blockdev_range(struct block_device *bdev, =
loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
 void bdev_statx(const struct path *path, struct kstat *stat, u32 request=
_mask);
+struct file_kattr;
+void bdev_fill_dio_attr(struct block_device *bdev, struct file_kattr *fa=
);
+int bdev_fileattr(const struct inode *inode, struct file_kattr *fa);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
--=20
2.53.0-Meta

