Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1214582E1
	for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142434; cv=none; b=m5kDdGKE05S/BpmaG8vYdCnIF85vDzs5G/htGOiHHno6AyGNj0fI0Dl7qpNiTA/zgaIWOxCz58h2Ip2RgwVmm0amUG7tMWEd5ZZ15DJ/dW36Ju3aD+6Og5P5cfUqmypl9endpr1GktklYTHjLVUHS46JfYPvWOyP+EjeKeD80ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142434; c=relaxed/simple;
	bh=EwRXNP8tIugxzv8pAp3hfFOiAhX6X71PusXq27pU6+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOY6kOEREWqgfH1MMsAy35X5zjzc98Lp5vOW9jMeLOTOtfEUaq06zRHzby/wmPeD0jSvCfWh5BH2bybBj3K52RzvGbRfCrqoqQDbEapSTmSPO2miJAqOlCf5YPMoF3mG928oEnlfgtyjfwje7KqqOX6cUhfyVKzNPZdhXGlKm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7yYhN3Z; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7yYhN3Z"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so2093276eec.1
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2026 02:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792142432; x=1792747232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9h8Utli2sn9TOY9C79OD+M1xwwpfmXbyxA47Gi/ZqKg=;
        b=E7yYhN3ZgUx08ius+UxX/e13EhdgH/0bSYz3s+Xb4vfwibAUy23eLqfte0gdDSpPTu
         W5+b5FXTLxu+du+rmHpea6NqxrFnbhltSiEj5WcbIviCsPwPkQbsLwLHrsK/HgqIiZpv
         Z80e07ZHIoEyJqL9BGnq0yvh1Kg4rYigu84Cu18fptj/jffRGivS1XBAki19K0MEve9v
         qZQcrveprUfCCvQAx80uHGyr/kkQG0V8iXRJInC53FAJlDuLYvBNDE3IfTIO2w3ydKup
         XuZty0HYBm+PGxAWh4qcrEnTH1YvdAA2udot3OmjuFL3CjRv1S1p+FI6/vPaLbH7Qk5y
         YHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792142432; x=1792747232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9h8Utli2sn9TOY9C79OD+M1xwwpfmXbyxA47Gi/ZqKg=;
        b=zb57eIBwRS47DpzxHNGPS5wiyLP0KeSD9CLFUXeAxiVCxNN+DcWtrOe0hNpqi6cI3c
         64gnb+kHc0qEKmlyZiF7sHfmX4acmXHpr35SRrBD2NxO8NIZgGKjqCKcYj6c+6hu/qDA
         pzbe5gucPf+Nw5/NkBrwTPkakNTHPpeNzrYxopkYA2Db6zdhSOiSh0AWITWiMDvy43p9
         dKCJqN/rLAYJD7jwsPJ08V9UfL+QJkLyZBCdSdx2gNSOtHhAY05G3s+M4YgZ7Cx7v3kY
         D1DoWQM2ymYxnLhx1RRV0nUY9TDxL47qVH4EPIo5eTvX7x8THA1NiQeBzGJ5AaIPYXt+
         Vqcw==
X-Gm-Message-State: AFq9FYJjkY6KUxJQjk5Y2EGiFjpp5/vdOlR5evUzI7RC9asQzPh8VkmF
	UJ5HzflIAzA+NXKD+I8popNzCKQn5lGLdLkAdU/iPO9nIuzZyMDe/9A=
X-Gm-Gg: AYBFou2HGxsUV0SQSMsYFOPFHswUdOZvd1mK1SNtjsCOJoqJ1wJkmNZlJzsFia24QDv
	yl19KsBSZoVpP+aWsoy8Qlc/01ldPyNsl2DfnMja9QRzoPC8hJoHX1I7mrZ/tpa87xbKdNoB47Y
	xwXJXP2yXq9xhYF3hBDvFYL+b7RbUxPNOY/8pIkp8nN2q7AAKE+hTwp8gJ31JRNWoXrZ6X4XQMc
	5eZsdTub11zBDoGatW9NdaEKKaQ/5udNMJaWa9I88eoWulLouMnymAshQ/kTJdffeYLBumJAGUy
	Xge9mFkp6OaPr8iXLIiTZw0r00s7Z3vKvTZJlyVWnC7GCGkRPBsNozpqJmwZXGkLUbHd7fYA0ff
	laZkYF3uXptUIx+d7gVBcIV50VS6JGD9oHZm+PShVmPBt+byb4XF+mIH+S1u2Jw/YScFZi2eLAO
	n7Y8htyvnSLnDSJ7OPfLMhB3VWQliBsxoFmD4/CaDebuYZwx8S9VjMw1phFB25usXOELua3CDYK
	gn+tzaCgty/Eo48R96/uaUyR4Yu6Twrc0Vf/4aLvggYLpD7iY0=
X-Received: by 2002:a05:7300:2720:b0:35a:84cc:d941 with SMTP id 5a478bee46e88-35a84ccdc1emr20515510eec.37.1792142432091;
        Fri, 16 Oct 2026 02:20:32 -0700 (PDT)
Received: from anuj-MacBookPro.. ([2406:7400:63:e55a:7bfc:fc3a:e718:89f6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm9840943eec.24.2026.10.16.02.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 02:20:31 -0700 (PDT)
From: Anuj Gupta <anuj1072538@gmail.com>
To: asml.silence@gmail.com,
	hch@lst.de,
	djwong@kernel.org,
	cem@kernel.org,
	brauner@kernel.org,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com,
	anuj20.g@samsung.com,
	nj.shetty@samsung.com
Subject: [RFC 4/4] xfs: support dma-buf registered buffers for direct I/O
Date: Fri, 16 Oct 2026 14:49:14 +0530
Message-ID: <20261016091919.971295-5-anuj1072538@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016091919.971295-1-anuj1072538@gmail.com>
References: <20261016091919.971295-1-anuj1072538@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nitesh Shetty <nj.shetty@samsung.com>

Add the init_dma_buf_io_ctx fop for XFS files.
XFS picks the device and calls the iomap layer with
the relevant device.

Refuse the iterator from every CPU-copy path: DAX, buffered
fallback from a -ENOTBLK direct write, and read/writes
without O_DIRECT.

If a file is switched between the data and realtime devices
after registration, the block layer cross-device check refuses
the I/O.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 fs/xfs/xfs_file.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 426a67b813a7..f97d5acfaf68 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -340,6 +340,11 @@ xfs_file_read_iter(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	/* a device mapping can only be read by a direct I/O bio */
+	if (iov_iter_is_dmabuf_map(to) &&
+	    (IS_DAX(inode) || !(iocb->ki_flags & IOCB_DIRECT)))
+		return -EOPNOTSUPP;
+
 	if (IS_DAX(inode))
 		ret = xfs_file_dax_read(iocb, to);
 	else if (iocb->ki_flags & IOCB_DIRECT)
@@ -1196,6 +1201,11 @@ xfs_file_write_iter(
 			return ret;
 	}
 
+	/* a device mapping can only be written by a direct I/O bio */
+	if (iov_iter_is_dmabuf_map(from) &&
+	    (IS_DAX(inode) || !(iocb->ki_flags & IOCB_DIRECT)))
+		return -EOPNOTSUPP;
+
 	if (IS_DAX(inode))
 		return xfs_file_dax_write(iocb, from);
 
@@ -1209,6 +1219,9 @@ xfs_file_write_iter(
 		ret = xfs_file_dio_write(iocb, from);
 		if (ret != -ENOTBLK)
 			return ret;
+		/* the page cache cannot copy from a device mapping */
+		if (iov_iter_is_dmabuf_map(from))
+			return -EOPNOTSUPP;
 	}
 
 	if (xfs_is_zoned_inode(ip))
@@ -2173,10 +2186,27 @@ xfs_file_mmap_prepare(
 	return 0;
 }
 
+/*
+ * A realtime file's data lives on the realtime device, anything else on the
+ * data device. If a file is switched between them after registration, the
+ * block layer cross-device check refuses the I/O.
+ */
+static int
+xfs_file_init_dma_buf_io_ctx(
+	struct file		*file,
+	struct dma_buf_io_ctx	*ctx)
+{
+	struct xfs_inode	*ip = XFS_I(file_inode(file));
+
+	return iomap_file_init_dma_buf_io_ctx(file,
+			xfs_inode_buftarg(ip)->bt_bdev, ctx);
+}
+
 const struct file_operations xfs_file_operations = {
 	.llseek		= xfs_file_llseek,
 	.read_iter	= xfs_file_read_iter,
 	.write_iter	= xfs_file_write_iter,
+	.init_dma_buf_io_ctx = xfs_file_init_dma_buf_io_ctx,
 	.splice_read	= xfs_file_splice_read,
 	.splice_write	= iter_file_splice_write,
 	.iopoll		= iocb_bio_iopoll,
-- 
2.43.0

