Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635EC3FCB32
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784293007; cv=none; b=hZo0p465KyqKCPsnPtftAF4WjW/Gnt+btAC3b2p3ESTfuptaRsQ1D7eJovuR6zKoszg7ESPesmLnRiubaw2mePUto+f8NPlJSO97DNUdkS1qlLf7hugKBHHEgKLlgrGyVcJENs5IobcHH4l57O7NuR3kT4roeHL56UruHjec4wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784293007; c=relaxed/simple;
	bh=FW3N48228B+7+KawEAaNdPT4kZxS3+zxeKAz+scVLlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=fQyFRbtaLSIJYV7iynOzRhB7gkNelCGoilnQYAAfLDSUtCikhl2WkhjJ5Xe3FZonzv3NVPY+FIGquvYWADLP1su07HTxz0o5uN21ewDJfZK40nw2yWT5YgqyXtjlm2kgEzDdUiWnbcjFGcqMsrqQwqPx8gA7yPXsWIWPXMBF920=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DGti/VbU; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DGti/VbU"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260717125643epoutp0113124a2ec2869ee13d65140489b4aded~DFQhim5Uk1410614106epoutp01y
	for <linux-block@vger.kernel.org>; Fri, 17 Jul 2026 12:56:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260717125643epoutp0113124a2ec2869ee13d65140489b4aded~DFQhim5Uk1410614106epoutp01y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784293003;
	bh=6R4jmvD8daF+EKnzKMMsPcwippaY7PBJ8RG5dZMwLmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGti/VbUAth7kDDyoYc9FUoYV08uxwtuHxUkuxmtAqbb3ixD/r9gfaK+T+wPjiXTy
	 9SgdU0aHkeFYZFhpdbyzT6EEivJD8mWdxjY9VPM2VcKl/JFICf1Rxe1AOjPFif4g6z
	 OY2TlHkjzH/0BC5AbNWq23QpKjzkXK53gokVXjdU=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260717125642epcas5p32335ec5df4be4efc77e8cab6f4927501~DFQhFgOQe1965319653epcas5p3V;
	Fri, 17 Jul 2026 12:56:42 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4h1qfx4rpZz6B9m5; Fri, 17 Jul
	2026 12:56:41 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260717125641epcas5p4db010135831340515003215b57e12823~DFQfvAvmi2735927359epcas5p4X;
	Fri, 17 Jul 2026 12:56:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260717125638epsmtip2b8dc63e5af7cf372f0a4bc7b3c8307e6~DFQdoMEvP0173501735epsmtip2J;
	Fri, 17 Jul 2026 12:56:38 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: brauner@kernel.org, hch@lst.de, djwong@kernel.org, dgc@kernel.org,
	jack@suse.cz, cem@kernel.org, axboe@kernel.dk, kbusch@kernel.org,
	ritesh.list@gmail.com
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v4 6/6] xfs: introduce software write streams
Date: Fri, 17 Jul 2026 18:25:38 +0530
Message-Id: <20260717125538.508925-7-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260717125538.508925-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260717125641epcas5p4db010135831340515003215b57e12823
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260717125641epcas5p4db010135831340515003215b57e12823
References: <20260717125538.508925-1-joshi.k@samsung.com>
	<CGME20260717125641epcas5p4db010135831340515003215b57e12823@epcas5p4.samsung.com>

Even when the underlying block device does not advertise write streams,
XFS can choose do so, as that enables logical spatial isolation and
dynamic AG-set based concurrency for the standard storage, excluding
rtvolume.

Use AG count based heuristic to derive AG set size and software streams.
Larger filesystem (i.e., more AGs) get wider fanout (i.e., larger AG-set).

XFS_SW_WRITE_STREAMS_MAX bounds the software fallback. The mount-time
write stream bitmap allocation now also falls back to it when the data device
reports no hardware streams.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 fs/xfs/xfs_inode.c | 22 +++++++++++++++++++++-
 fs/xfs/xfs_mount.h |  2 ++
 fs/xfs/xfs_super.c | 12 ++++++------
 3 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index aafc3ffa6e0a..638bee3e4ac2 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -53,6 +53,9 @@ xfs_inode_max_write_streams(
 	struct xfs_inode	*ip)
 {
 	struct block_device	*bdev;
+	struct xfs_mount	*mp = ip->i_mount;
+	int nr_streams;
+	xfs_agnumber_t nr_ags, ag_set_size;
 	bool			is_filestream, is_realtime;
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
@@ -64,7 +67,24 @@ xfs_inode_max_write_streams(
 	if (!bdev || is_filestream || is_realtime)
 		return 0;
 
-	return bdev_max_write_streams(bdev);
+	nr_streams = bdev_max_write_streams(bdev);
+	if (nr_streams > 0)
+		return nr_streams;
+	/*
+	 * Enable software-only streams if hardware streams are not available.
+	 * This helps to
+	 * - improve isolation; reduce allocation interleaving.
+	 * - improve concurrency using AG-set based steering within and across streams.
+	 */
+	nr_ags = mp->m_sb.sb_agcount;
+	if (nr_ags >= 16)
+		ag_set_size = 4;
+	else if (nr_ags >= 8)
+		ag_set_size = 2;
+	else
+		ag_set_size = 1;
+	nr_streams = nr_ags / ag_set_size;
+	return min_t(uint16_t, nr_streams, XFS_SW_WRITE_STREAMS_MAX);
 }
 
 uint16_t
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 1376963fb7e8..ad51115594d3 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -45,6 +45,8 @@ enum {
 
 #define XFS_ERR_RETRY_FOREVER	-1
 
+#define XFS_SW_WRITE_STREAMS_MAX	16
+
 /*
  * Although retry_timeout is in jiffies which is normally an unsigned long,
  * we limit the retry timeout to 86400 seconds, or one day.  So even a
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 0e2bf6f7b378..d698be504c45 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1711,12 +1711,12 @@ xfs_fs_fill_super(
 		return error;
 
 	nr_streams = bdev_max_write_streams(mp->m_ddev_targp->bt_bdev);
-	if (nr_streams) {
-		mp->m_streams_in_use = bitmap_zalloc(nr_streams, GFP_KERNEL);
-		if (!mp->m_streams_in_use) {
-			error = -ENOMEM;
-			goto out_shutdown_devices;
-		}
+	if (!nr_streams)
+		nr_streams = XFS_SW_WRITE_STREAMS_MAX;
+	mp->m_streams_in_use = bitmap_zalloc(nr_streams, GFP_KERNEL);
+	if (!mp->m_streams_in_use) {
+		error = -ENOMEM;
+		goto out_shutdown_devices;
 	}
 
 	if (xfs_debugfs) {
-- 
2.25.1

