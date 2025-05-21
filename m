Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B38823958D
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747866679; cv=none; b=KNaZvexSBkvtV5wb1nNLdVxMEAcpVNbQm3AGafrJLAUf0bWl4RAEtyNifSKXHdgf5KPXxvcFmHBaeHYQI+Sa/TwcKvjz2ThvHEfZRWvAA9RqkF9pJDX9rml2LQnlZErdVC4PqccbSTCuYFcwcVPyW88e2/2pVv+qJ+KzChjj2BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747866679; c=relaxed/simple;
	bh=RBgNaR7H6HTC5uyL+GKmzltg4/smxz7w9un+Rw6hrL8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coTbSrRW6rWLREizS236d3I7R5/QW/XI07pMkXiUYa0ncO9ykEuLAy7uethOmije4JWby9sf9GH9QydvHZKG3m0/IPGjPA28yPtpdFRrUU3247m8LxSj1aIq2Fh1gOR6MtvjaAx6hfiwKxHKKB2mdIrj11D8/pEen2hKHIKP8Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=jQma/pFI; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="jQma/pFI"
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LMQXcb002432
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=mZ20q90cuzIDMnvbv2G/OC471GJ5nYMbY/KN84m1fJ0=; b=jQma/pFI+CHK
	RlkX/qCoVaXaXreYvTS5/uZh8PFINU8y8Eiybdn1zp5qC5e4pmZQ6EzwuxifCVn2
	vFXd8AihzpysBsC+K+BSysEB0F4TJ0Xnhp8GOcEQivUkn6QqLFNZHeMNY+UZh5bV
	4X4DYK2QowvE/qe9reJJJGf9uk/xcmPQA/jesER7SlRuk+tRjIhtDKa9T5JpD577
	3O68yz6jVIMN/BuFYMZQbl7YI+bPmL1mGiDZsgLDRkS4IT9px6nEOZt/hdZLCJLG
	MNG9B3c0SwltG30PSB1SRrAgPvz+BUiweMv3oq97/RoL2mcn+7DbM3OB5MplISy/
	PTfbzVc+dQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 46rwfgkp1x-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 15:31:16 -0700 (PDT)
Received: from twshared18153.09.ash9.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Wed, 21 May 2025 22:31:14 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C91D91BE54AC9; Wed, 21 May 2025 15:31:10 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 4/5] block: add support for vectored copies
Date: Wed, 21 May 2025 15:31:06 -0700
Message-ID: <20250521223107.709131-5-kbusch@meta.com>
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
X-Proofpoint-GUID: xYiwOBOVOCFCxrP7UFdrvKwW6IVWWVqQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDIyNCBTYWx0ZWRfXxah0pjszM/yp 1OSckYz7syhtZggY+4/hyWVs79v8DGfUDplGsCYZikaWwxveHKfkehJmk8Fz4lKDBaWUdMuyhPJ g635sdD5tLd4QBGxf/2iHqyuA2+vBk6wt/hc2CpEdE0f/xSa/obJri0qshiQpd8NdHA2zGSWK0x
 o/tmvqD1yxfSe1mop5AKSYqKDupWxZIxZ3TCeiuadcz0cvtIQQlN694sxxEQBP5r6aWr6iM/jUR G8Miwh0SBybUeWNqdHms598KjeEnzLeb7RZE/KtdM3XN8V2Qr4hNjae9dC7iUNL2tTm1bngTFij 5BZcLCLms60IFdE915Vn7kj8RM7qXw4PhrgPxYyCKeTk6EPQxZNjK3rl2ekQI0f9gN5eZ/KACRc
 U27idTYReiu9BEiuLrYVz3B4gB8lRxemnLIiauYPWwWezMNCc6eJW+dKYzw50XAWtP0uSW2s
X-Authority-Analysis: v=2.4 cv=I9BlRMgg c=1 sm=1 tr=0 ts=682e5434 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QX-hf833l84o4JQLY-wA:9
X-Proofpoint-ORIG-GUID: xYiwOBOVOCFCxrP7UFdrvKwW6IVWWVqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_07,2025-05-20_03,2025-03-28_01

From: Keith Busch <kbusch@kernel.org>

Copy offload can be used to defrad or garbage collect data spread across
the disk. Most storage protocols provide a way to specifiy multiple
sources in a single copy commnd, so introduce kernel and user space
interfaces to accomplish that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-lib.c         | 50 ++++++++++++++++++++++++----------
 block/ioctl.c           | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/blkdev.h  |  2 ++
 include/uapi/linux/fs.h | 14 ++++++++++
 4 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index a538acbaa2cd7..7513b876a5399 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -424,26 +424,46 @@ static int __blkdev_copy(struct block_device *bdev,=
 sector_t dst_sector,
 }
=20
 static int blkdev_copy_offload(struct block_device *bdev, sector_t dst_s=
ector,
-		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
+		struct bio_vec *bv, int nr_vecs, gfp_t gfp)
 {
+	unsigned size =3D 0;
 	struct bio *bio;
-	int ret;
-
-	struct bio_vec bv =3D {
-		.bv_sector =3D src_sector,
-		.bv_sectors =3D nr_sects,
-	};
+	int ret, i;
=20
-	bio =3D bio_alloc(bdev, 1, REQ_OP_COPY, gfp);
-	bio_add_copy_src(bio, &bv);
+	bio =3D bio_alloc(bdev, nr_vecs, REQ_OP_COPY, gfp);
+	for (i =3D 0; i < nr_vecs; i++) {
+		size +=3D bv[i].bv_sectors << SECTOR_SHIFT;
+		bio_add_copy_src(bio, &bv[i]);
+	}
 	bio->bi_iter.bi_sector =3D dst_sector;
-	bio->bi_iter.bi_size =3D nr_sects << SECTOR_SHIFT;
+	bio->bi_iter.bi_size =3D size;
=20
 	ret =3D submit_bio_wait(bio);
 	bio_put(bio);
 	return ret;
+}
+
+/**
+ * blkdev_copy_range - copy range of sectors to a destination
+ * @dst_sector:	start sector of the destination to copy to
+ * @bv:		vector of source sectors
+ * @nr_vecs:	number of source sector vectors
+ * @gfp:	allocation flags to use
+ */
+int blkdev_copy_range(struct block_device *bdev, sector_t dst_sector,
+		struct bio_vec *bv, int nr_vecs, gfp_t gfp)
+{
+	int ret, i;
=20
+	if (bdev_copy_sectors(bdev))
+		return blkdev_copy_offload(bdev, dst_sector, bv, nr_vecs, gfp);
+
+	for (i =3D 0, ret =3D 0; i < nr_vecs && !ret; i++)
+		ret =3D __blkdev_copy(bdev, dst_sector, bv[i].bv_sector,
+				bv[i].bv_sectors, gfp);
+	return ret;
 }
+EXPORT_SYMBOL_GPL(blkdev_copy_range);
=20
 /**
  * blkdev_copy - copy source sectors to a destination on the same block =
device
@@ -455,9 +475,11 @@ static int blkdev_copy_offload(struct block_device *=
bdev, sector_t dst_sector,
 int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
 		sector_t src_sector, sector_t nr_sects, gfp_t gfp)
 {
-	if (bdev_copy_sectors(bdev))
-		return blkdev_copy_offload(bdev, dst_sector, src_sector,
-					nr_sects, gfp);
-	return __blkdev_copy(bdev, dst_sector, src_sector, nr_sects, gfp);
+	struct bio_vec bv =3D {
+		.bv_sector =3D src_sector,
+		.bv_sectors =3D nr_sects,
+	};
+
+	return blkdev_copy_range(bdev, dst_sector, &bv, 1, gfp);
 }
 EXPORT_SYMBOL_GPL(blkdev_copy);
diff --git a/block/ioctl.c b/block/ioctl.c
index 6f03c65867348..4b5095be19e1a 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -241,6 +241,63 @@ static int blk_ioctl_copy(struct block_device *bdev,=
 blk_mode_t mode,
 	return blkdev_copy(bdev, dst, src, nr, GFP_KERNEL);
 }
=20
+static int blk_ioctl_copy_vec(struct block_device *bdev, blk_mode_t mode=
,
+		void __user *argp)
+{
+	sector_t align =3D bdev_logical_block_size(bdev) >> SECTOR_SHIFT;
+	struct bio_vec *bv, fast_bv[UIO_FASTIOV];
+	struct copy_range cr;
+	int i, nr, ret;
+	__u64 dst;
+
+	if (!(mode & BLK_OPEN_WRITE))
+		return -EBADF;
+	if (copy_from_user(&cr, argp, sizeof(cr)))
+		return -EFAULT;
+	if (!(IS_ALIGNED(cr.dst_sector, align)))
+		return -EINVAL;
+
+	nr =3D cr.nr_ranges;
+	if (nr <=3D UIO_FASTIOV) {
+		bv =3D fast_bv;
+	} else {
+		bv =3D kmalloc_array(nr, sizeof(*bv), GFP_KERNEL);
+		if (!bv)
+			return -ENOMEM;
+	}
+
+	dst =3D cr.dst_sector;
+	for (i =3D 0; i < nr; i++) {
+		struct copy_source csrc;
+		__u64 nr_sects, src;
+
+		if (copy_from_user(&csrc,
+				(void __user *)(cr.sources + i * sizeof(csrc)),
+				sizeof(csrc))) {
+			ret =3D -EFAULT;
+			goto out;
+		}
+
+		nr_sects =3D csrc.nr_sectors;
+		src =3D csrc.src_sector;
+		if (!(IS_ALIGNED(src | nr_sects, align)) ||
+		    (src < dst && src + nr_sects > dst) ||
+		    (dst < src && dst + nr_sects > src)) {
+			ret =3D -EINVAL;
+			goto out;
+		}
+
+		bv[i].bv_sectors =3D nr_sects;
+		bv[i].bv_sector =3D src;
+	}
+
+	ret =3D blkdev_copy_range(bdev, dst, bv, nr, GFP_KERNEL);
+out:
+	if (bv !=3D fast_bv)
+		kfree(bv);
+	return ret;
+}
+
 static int blk_ioctl_zeroout(struct block_device *bdev, blk_mode_t mode,
 		unsigned long arg)
 {
@@ -605,6 +662,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, blk_mode_t mode,
 		return blk_ioctl_secure_erase(bdev, mode, argp);
 	case BLKCPY:
 		return blk_ioctl_copy(bdev, mode, argp);
+	case BLKCPY_VEC:
+		return blk_ioctl_copy_vec(bdev, mode, argp);
 	case BLKZEROOUT:
 		return blk_ioctl_zeroout(bdev, mode, arg);
 	case BLKGETDISKSEQ:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e39ba0e91d43e..a77f2298754b5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1182,6 +1182,8 @@ int blkdev_issue_secure_erase(struct block_device *=
bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp);
 int blkdev_copy(struct block_device *bdev, sector_t dst_sector,
 		sector_t src_sector, sector_t nr_sects, gfp_t gfp);
+int blkdev_copy_range(struct block_device *bdev, sector_t dst_sector,
+		struct bio_vec *bv, int nr_vecs, gfp_t gfp);
=20
 #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
 #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 534f157ce22e9..aed965f74ea2c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -218,6 +218,20 @@ struct fsxattr {
 /* [0] =3D destination lba, [1] =3D source lba, [2] =3D number of sector=
s */
 #define BLKCPY _IOWR(0x12,142,__u64[3])
=20
+struct copy_source {
+	__u64 src_sector;
+	__u64 nr_sectors;
+};
+
+struct copy_range {
+	__u64	dst_sector;
+	__u16	nr_ranges;
+	__u8	rsvd[6];
+	__u64	sources; /* user space pointer to struct copy_source[] */
+};
+#define BLKCPY_VEC _IOWR(0x12,143,struct copy_range)
+
+
 #define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
 #define FIBMAP	   _IO(0x00,1)	/* bmap access */
 #define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
--=20
2.47.1

