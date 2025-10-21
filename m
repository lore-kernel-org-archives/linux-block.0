Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A61D2882B8
	for <linux-block@vger.kernel.org>; Tue, 21 Oct 2025 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761081734; cv=none; b=At1RHRBhWWJIKTivoj/5/XZkHFYt2/8SgrtovlKGuwvROOsL6AAdE2tZ+cGGBuYfAX9W/cXSysf/CRf4YiWVMSXfNb8VktVVFnoAre0dx/84k1HE59bNGpNq9rZu1od2Nz6ow8QzshTU43M4LZHOE6F/3qdcLQnVH2h13ekwe3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761081734; c=relaxed/simple;
	bh=q6m3pqEfFNqonoGk3HnQW9Ia5Pn+yeRafy5QPihLP10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD9cEtQNayguZbKDJRnkz3k7YKNIo5CVDz8Py5TP06ShfoM88TsWUduQixo8A8P8YSzfCZrJTb7d2RxDQDLqfT95pc97o7hVi/CFdJB4fFRjlanvbMGf0V+V0mbrqG4aJX+6sEA83jdXErr48lPuYFSks8BtMe97wmIY67/PnGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuoLnv9g; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuoLnv9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B4CC4CEF1;
	Tue, 21 Oct 2025 21:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761081730;
	bh=q6m3pqEfFNqonoGk3HnQW9Ia5Pn+yeRafy5QPihLP10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuoLnv9gnDX4SRIwnvDI2WkJpGWi04N2LNwoFQdh0BEGI3MYvFhn4J6MqoXaFOFSi
	 Mxq4j/PS4DDowvmDSxN3kMIUyYrebWq7jehZF7RxIKf6ms5Qnu6bUFakD8lkBJ2rZl
	 heA0w8ivVHPwg9K3bYXR7VpJ7vpy2NADqRoPNx4qoP2FI6nHTdcX4ZnVQIS+dM2rC1
	 ROjv1Mati1KAD95OxdBjAYrnh69uJKHHp6Wu6u9jhWDyDlzVzCRh8PZIehLZiIL1Xu
	 fgKY/h3vl8JauIAzqmxcK2uow5zNP4UGnM4o9ZmwMNWZvrxnBKg16Be/joKHJepgX6
	 qSDvCiG952WAw==
Date: Tue, 21 Oct 2025 15:22:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH blktests] create a test for direct io offsets
Message-ID: <aPf5gAOlnJtVUV6E@kbusch-mbp>
References: <20251014205420.941424-1-kbusch@meta.com>
 <aPIk3Ng8JXs-3Pye@infradead.org>
 <aPZhWIokZf0K-Ma9@kbusch-mbp>
 <aPcZ6ZnAGVwgK1DO@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPcZ6ZnAGVwgK1DO@infradead.org>

On Mon, Oct 20, 2025 at 10:28:09PM -0700, Christoph Hellwig wrote:
> seems like a huge win.  Any chance you could try to get this done ASAP
> so that we could make the interface fully discoverable before 6.18 is
> released?

I just want to make sure I am aligned to what you have in mind. Is this
something like this what you're looking for? This reports the kernel's
ability to handle a dio with memory that is discontiguous for a single
device "sector", and reports the virtual gap requirements.

---
diff --git a/block/bdev.c b/block/bdev.c
index 810707cca9703..5881edc3bf928 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1330,6 +1330,12 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 		stat->result_mask |= STATX_DIOALIGN;
 	}
 
+	if (request_mask & STATX_DIO_VIRT_SPLIT) {
+		stat->dio_virt_boundary_mask = queue_virt_boundary(
+								bdev->bd_queue);
+		stat->result_mask |= STATX_DIO_VIRT_SPLIT;
+	}
+
 	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue = bdev->bd_queue;
 
@@ -1339,6 +1345,10 @@ void bdev_statx(const struct path *path, struct kstat *stat, u32 request_mask)
 			0);
 	}
 
+	if (bdev_max_segments(bdev) > 1)
+		stat->attributes |= STATX_ATTR_DIO_VEC_SPLIT;
+	stat->attributes_mask |= STATX_ATTR_DIO_VEC_SPLIT;
+
 	stat->blksize = bdev_io_min(bdev);
 
 	blkdev_put_no_open(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e99306a8f47ce..aec3ed6356aa8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6105,6 +6105,13 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
+	if (request_mask & STATX_DIO_VIRT_SPLIT) {
+		struct block_device *bdev = inode->i_sb->s_bdev;
+
+		stat->dio_virt_boundary_mask = queue_virt_boundary(bdev->bd_queue);
+		stat->result_mask |= STATX_DIO_VIRT_SPLIT;
+	}
+
 	if ((request_mask & STATX_WRITE_ATOMIC) && S_ISREG(inode->i_mode)) {
 		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 		unsigned int awu_min = 0, awu_max = 0;
diff --git a/fs/stat.c b/fs/stat.c
index 6c79661e1b961..7f0e12b3b82e8 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -738,6 +738,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_dev_minor = MINOR(stat->dev);
 	tmp.stx_mnt_id = stat->mnt_id;
 	tmp.stx_dio_mem_align = stat->dio_mem_align;
+	tmp.stx_dio_virtual_boundary_mask = stat->dio_virt_boundary_mask;
 	tmp.stx_dio_offset_align = stat->dio_offset_align;
 	tmp.stx_dio_read_offset_align = stat->dio_read_offset_align;
 	tmp.stx_subvol = stat->subvol;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index caff0125faeac..ce3234d1f9377 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -599,6 +599,18 @@ xfs_report_dioalign(
 		stat->dio_offset_align = stat->dio_read_offset_align;
 }
 
+static void
+xfs_report_dio_split(
+	struct xfs_inode	*ip,
+	struct kstat		*stat)
+{
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct block_device	*bdev = target->bt_bdev;
+
+	stat->dio_virt_boundary_mask = queue_virt_boundary(bdev->bd_queue);
+	stat->result_mask |= STATX_DIO_VIRT_SPLIT;
+}
+
 unsigned int
 xfs_get_atomic_write_min(
 	struct xfs_inode	*ip)
@@ -743,6 +755,8 @@ xfs_vn_getattr(
 			xfs_report_dioalign(ip, stat);
 		if (request_mask & STATX_WRITE_ATOMIC)
 			xfs_report_atomic_write(ip, stat);
+		if (request_mask & STATX_DIO_VIRT_SPLIT)
+			xfs_report_dio_split(ip, stat);
 		fallthrough;
 	default:
 		stat->blksize = xfs_stat_blksize(ip);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index e3d00e7bb26d9..57088eedb6f92 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -55,6 +55,7 @@ struct kstat {
 	u32		dio_mem_align;
 	u32		dio_offset_align;
 	u32		dio_read_offset_align;
+	u32		dio_virt_boundary_mask;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
 	u32		atomic_write_unit_max_opt;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 1686861aae20a..3f79359cf7154 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -184,7 +184,9 @@ struct statx {
 
 	/* Optimised max atomic write unit in bytes */
 	__u32	stx_atomic_write_unit_max_opt;
-	__u32	__spare2[1];
+
+	/* Virtual boundary mask between io vectors that require a split */
+	__u32	stx_dio_virtual_boundary_mask;
 
 	/* 0xc0 */
 	__u64	__spare3[8];	/* Spare space for future expansion */
@@ -219,6 +221,7 @@ struct statx {
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields */
 #define STATX_DIO_READ_ALIGN	0x00020000U	/* Want/got dio read alignment info */
+#define STATX_DIO_VIRT_SPLIT	0x00040000U	/* Want/got dio virtual boundary split */
 
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx expansion */
 
@@ -255,6 +258,7 @@ struct statx {
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
 #define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
+#define STATX_ATTR_DIO_VEC_SPLIT	0x00800000 /* File supports vector crossing dio payloads */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
--
