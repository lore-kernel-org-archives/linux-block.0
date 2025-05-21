Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8FE23BCED
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866692; cv=none; b=FQih2QZmYrv0QPRCD+GAeqdATaQIaWOWN9XTWq9j5s1lvkev2HUteVbE+1IXaB++LOtWd2azxPhe3zj0M6tMtvZYHy7Avt4j44e6A44iXKgE15r7jrjjrxB25yuzqh32AVkKSFp8FZOgb7i7yEwOcXw4eBQBFzuZ24jlDtdCahQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866692; c=relaxed/simple;
	bh=zRa6cTUPyozA2DL5xXDar3qB5ojsOalHkqz1mNTJCz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPqiiT1FzQ8KGbPCEM1dGiHOrpL7NpI/wZBsGw6ISWaKz4Zpxe67nFvD93M6QOemelwBWoiahspkOvK5LPGoOAY4JuuRc9iYzMmQUR0Y7xgwGpgZPTHkzZqtvRRAwHlITJk40hGVQ6Vahps2lPY+gpsvvIAqMIsTY3EcZPswLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=PrsQ227B; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="PrsQ227B"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQWgL029158
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ZE38SQlUTxOdL6Eq/GiFvrJf6fdbU3j3t94O5PZNxg4=; b=PrsQ227BREKm
	JW2HN66lcmLKUzvFmzqZ7/66VNmkrUbeTBTCeAaW6Xq3pXCyAJY4CyGh685f4ZIV
	2b8rguVrQwcTLyAlsEwF8azpnWx5yD1WO97joUk5ct7u0RA5EmjXVyGAtvRyDhuc
	oCpNGB2w92zpCkGzoEvJPMuJziiFqWDpZmVMTD2plM5IppXsYj5lNbZKTkJnnqOH
	mUC2Xh6w2067ER6g2TVm3avBeIVrpOWSOehmrPvaRq2yuqA0v9zLIlilQudq0/w0
	qPi2MllCYl7j60PZ812q2fbshlObepZ4bE62j0RY2oyNMpaHQKZcPooFdkEqrLCe
	rd3vl1dYAg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46sd06wf38-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:29 -0700 (PDT)
Received: from twshared37834.15.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:25 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A1EF21BE54AC4; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/5] block: new sector copy api
Date: Wed, 21 May 2025 15:31:03 -0700
Message-ID: <20250521223107.709131-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521223107.709131-1-kbusch@meta.com>
References: <20250521223107.709131-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=MaBsu4/f c=1 sm=1 tr=0 ts=682e5441 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=s5lGTWZQ5RyZ_Hens2EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfXxh3KQhb1mB/0 JGiRIYVU8bKlZ8TF5vWUgRqYGrvqKI+nG4OGaWGe+nBXn4Reac1u74urHBlrFs8IzGNmrOpbfWc pJfAe9VmlN1tePWA9Qk/gCQNFLOnLr8tz6pZhcBdorN2ZVYLulw0ewKNDAOBlyfWBgRGpfwhSv/
 bbalRILGcBJwQCt7sgqmjvo3wS0Cidu7hRXH6BpXVFKz0aPPcTqkACFd9Gv1iiikD9jiJGRWwUO bGwyrVY+AkB4j82619DP9sraaxBndbkFaJq41DlvDSItn2wyXQO+og/Sz5kWziQucP5e6kfOpal Ad5zBKs4yloSIHZaMFuV1AnKbiweOgiPJTZthg14GBBNrplnQpUi50XXdPPlQyf5VhVh6bofMll
 ROzlaXXLS/PG/YxSA/nlHtYW+pPp0wDPvx/yT3vwwmGzCAnoyHudvRmMpjC/t69ZCbtTDYau
X-Proofpoint-ORIG-GUID: fi5OOtkhK-JaKsWuTUjFDmann_F6rBPP
X-Proofpoint-GUID: fi5OOtkhK-JaKsWuTUjFDmann_F6rBPP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Provide a basic block level api to copy a range of a block device's
sectors to a new destination on the same device. This just reads the
source data into host memory, then writes it back out to the device at
the requested destination.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c         | 62 +++++++++++++++++++++++++++++++++++++++++
 block/ioctl.c           | 30 ++++++++++++++++++++
 include/linux/blkdev.h  |  2 ++
 include/uapi/linux/fs.h |  3 ++
 4 files changed, 97 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 4c9f20a689f7b..a819ded0ed3a9 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -368,3 +368,65 @@ int blkdev_issue_secure_erase(struct block_device *b=
dev, sector_t sector,
 	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_secure_erase);
+
+/**
+ * blkdev_copy - copy source sectors to a destination on the same block =
device
+ * @dst_sector:	start sector of the destination to copy to
+ * @src_sector:	start sector of the source to copy from
+ * @nr_sects:	number of sectors to copy
+ * @gfp:	allocation flags to use
+ */
+int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
+		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
+{
+	unsigned int nr_vecs =3D __blkdev_sectors_to_bio_pages(nr_sects);
+	unsigned int len =3D (unsigned int)nr_sects << SECTOR_SHIFT;
+	unsigned int size =3D min(len, nr_vecs * PAGE_SIZE);
+	struct bio *bio;
+	int ret =3D 0;
+	void *buf;
+
+	if (nr_sects > UINT_MAX >> SECTOR_SHIFT)
+		return -EINVAL;
+
+	buf =3D kvmalloc(size, gfp);
+	if (!buf)
+		return -ENOMEM;
+
+	nr_vecs =3D bio_add_max_vecs(buf, size);
+	bio =3D bio_alloc(bdev, nr_vecs, 0, gfp);
+
+	if (is_vmalloc_addr(buf))
+		bio_add_vmalloc(bio, buf, size);
+	else
+		bio_add_virt_nofail(bio, buf, size);
+
+	while (len) {
+		size =3D min(len, size);
+
+		bio_reset(bio, bdev, REQ_OP_READ);
+		bio->bi_iter.bi_sector =3D src_sector;
+		bio->bi_iter.bi_size =3D size;
+
+		ret =3D submit_bio_wait(bio);
+		if (ret)
+			break;
+
+		bio_reset(bio, bdev, REQ_OP_WRITE);
+		bio->bi_iter.bi_sector =3D dst_sector;
+		bio->bi_iter.bi_size =3D size;
+
+		ret =3D submit_bio_wait(bio);
+		if (ret)
+			break;
+
+		src_sector +=3D size >> SECTOR_SHIFT;
+		dst_sector +=3D size >> SECTOR_SHIFT;
+		len -=3D size;
+	}
+
+	bio_put(bio);
+	kvfree(buf);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blkdev_copy);
diff --git a/block/ioctl.c b/block/ioctl.c
index e472cc1030c60..6f03c65867348 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -212,6 +212,34 @@ static int blk_ioctl_secure_erase(struct block_devic=
e *bdev, blk_mode_t mode,
 	return err;
 }
=20
+static int blk_ioctl_copy(struct block_device *bdev, blk_mode_t mode,
+		void __user *argp)
+{
+	unsigned int lbs =3D bdev_logical_block_size(bdev) >> SECTOR_SHIFT;
+	uint64_t dst, src, end, nr, range[3];
+
+	if (!(mode & BLK_OPEN_WRITE))
+		return -EBADF;
+	if (copy_from_user(range, argp, sizeof(range)))
+		return -EFAULT;
+
+	dst =3D range[0];
+	src =3D range[1];
+	nr =3D range[2];
+
+	if (!(IS_ALIGNED(dst | src | nr, lbs)))
+		return -EINVAL;
+	if (check_add_overflow(src, nr - 1, &end))
+		return -EINVAL;
+	if (end >=3D bdev_nr_sectors(bdev))
+		return -EINVAL;
+	if (src < dst && src + nr > dst)
+		return -EINVAL;
+	if (dst < src && dst + nr > src)
+		return -EINVAL;
+
+	return blkdev_copy(bdev, dst, src, nr, GFP_KERNEL);
+}
=20
 static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
@@ -575,6 +603,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
 		return blk_ioctl_discard(bdev, mode, arg);
 	case BLKSECDISCARD:
 		return blk_ioctl_secure_erase(bdev, mode, argp);
+	case BLKCPY:
+		return blk_ioctl_copy(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 332b56f323d92..b7d71b126ec9b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1176,6 +1176,8 @@ int __blkdev_issue_discard(struct block_device *bde=
v, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, struct bio **biop);
 int blkdev_issue_secure_erase(struct block_device *bdev, sector_t sector=
,
 		sector_t nr_sects, gfp_t gfp);
+int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
+		sector_t src_sector, sector_t nr_sects, gfp_t gfp);
=20
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index e762e1af650c4..534f157ce22e9 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -215,6 +215,9 @@ struct fsxattr {
 /* 130-136 are used by zoned block device ioctls (uapi/linux/blkzoned.h)=
 */
 /* 137-141 are used by blk-crypto ioctls (uapi/linux/blk-crypto.h) */
=20
+/* [0] =3D destination lba, [1] =3D source lba, [2] =3D number of sector=
s */
+#define BLKCPY _IOWR(0x12,142,__u64[3])
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
--=20
2.47.1

