Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019C3C4542
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276965; cv=fail; b=dLwhG6mjTdLd0sRNn/N6Yoktl8kkUY4GAG/wG6gw6rvInsDdE1ag7SWRnJW1+IYmpjlNYMnJd88arZpCYXg2DJAnfnY+vVxdLmTRhp8hfLwwF1f7bpVtx+3SGpHw8tRHXSIv9IoLbIjRJHIb5mI1obxQ0c/4HfygZqd4CZNqa4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276965; c=relaxed/simple;
	bh=TBwFcTP90/SJAYzDA9KON8f/e+HT342/j915WrdI8AY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCaBpuJ8YyLTXCcfmqG6NlRqgM5BSPKutchRcyu2V1D2DkJaASZXZl/2NtQ4GdOACoi+jRaHkuixRTYvUGBZRfKreBLNC8KmRW7I+vjJl7RIuGUwaesNJRhpuBuAGvaRP0v9c3xUqWgPFPe8gkQ8KqvgzBWm7GtChCUQ4LS48Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tsj6M/M8; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tsj6M/M8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNBt/VSV4m0QECfbdf258FVIUqS5s3N8WlUofBrXG5Azc8+SdojBdgkUDK2cX4D7fVC81K9y4bCTDiy8NNgEF5otbtWSjJkpo/fqyBgaFiuL0U2n+lEeOMjQls5/n4zOC6breFhs0rgyl9apcn0zfcOENJgd3sHsSx+V7JnghXHp5QbXO0yClxUdpZyVlOOyQqEAaG5x7+YUbWrCF47y7cuENF76vTB5VuA889SarAhWk1bkWhtoD6P1bvkncyeLfkCSDl4+PxF1h4l1LgA2WbZc/OHPCVOtYF8FuocHpW7MNmhp3kENq4TNT+7OZmUvfXGzBKXC/e1YQ+3KJCdrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/yVC65grSlKLljAUYUj800bZeeujFr0BgdbwdAW91M=;
 b=J3xhjvlmrKaZzMPKqF+ezszrb/RXD5lv2tiMvK+8FeH4unhGR2jkA4In2l9vyxpTOcm8PIykUgpQ6fRPBmwEJiJZTSFujl80EaGT3rUeBQHwxQtHFjsMHzKwrHlTDeex59anDjJsZTafuwcJQ+Y4idBibpYtZz4xL8B6Rc8j0Gj7c5OseEE0nO7IBp9xgqewrr6oxSDwmULMXiVMRHWyzIiT/iYBvzySV83KEQ+nTv8++LZL/IIS4FQ+Hmr5y+XyTAECr5g5tw6TxDL/eeXWXC3qRuiVUBMTRPmSQek+00CjVbWRrQECTaS/UDJreo5EjCn0UkDWYaIoH/2JgyHoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/yVC65grSlKLljAUYUj800bZeeujFr0BgdbwdAW91M=;
 b=Tsj6M/M8KDkEiea05H+AZWtNIgINLhjZMe9zwiAJXyHK63zq07wBZDh9VQIqfIyr8YF4D6RMKT8fxbecRZTEOU9msqHGGZ3jnvny0RMzXTJHId/0zJgjNerur9fvZOjAzceHlIgBZhHILl4kcFHAvC/oWwEg4VfBSlAOOIqzH3GfVkEYh2GIUFjjDAlUQqX7oUZ3as19x81YoF3/QnqinTxAX90RYAIHOTiCou+5f6vOCmMszKOpIqN7goLeTV3yLCLuhH25CTNvvDWNZkI+9KQbOevwLualiswEkVf+47D2RGjMHD0gfXsn3EpO7uTS0hbmhDkL3Ic6WAuRQ9c9Bw==
Received: from CH5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:1f1::13)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 08:55:58 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::34) by CH5PR03CA0015.outlook.office365.com
 (2603:10b6:610:1f1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 08:55:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 08:55:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 01:55:34 -0700
Received: from yoav-mlt.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 01:55:31 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH 1/2] ublk: complete requests via blk_mq_complete_request() so rq_affinity applies
Date: Tue, 6 Oct 2026 11:55:16 +0300
Message-ID: <20261006085517.33974-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261006085517.33974-1-yoav@nvidia.com>
References: <20261006085517.33974-1-yoav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5652631a-4033-4b7b-8fba-08df2387a38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|5023799004|56012099006|22082099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	rpa8pzOT/WHQdOp6dxKaEeakND2LQY37ycoe00OocNVAhJ9kd1IfvULw0LK9K1aiUT8RNo8dLMNpnv9lUoUDzpdCjkj4ismUdawNU/Uk33UnnmDarDpGq6VH6swHTMKJoCROTFcb9NvWbVmOYpAiDUSutSAsciOiIZg9LEpvILekJ+P6wl29QJ/RrES/PrqCLh2yH6Xz8NTSjR6AjP5Spj473vQcI9LPaF9bt8GR7VHlcUhmZ6YuFGefSpI2o58uH1KWmRH0RINvm8sQhy5vgWN2j97Gg/bJEhsUONzn/RpkD4kko2Sls04JhY7EtNNTPbkpX+ssizEVQcLCaJLZX2uNxFHrKMU3KSuhpCpYRXwc6sX9ZNgvprILIbh0KWECcxQ2BorjNizWgNocQJAa8HiqVqcrWoJPKndFZB+6t6gUlxAi9bF6CTYXg4NBEmsirVFmSCY3okf/3L2S6tZEoNwD4B/nV51bIZmslArsazf822MaPcAd2dcPW/KFutRKZahDdXJd8RKnqJmnUSPNWhNgBccscP6yFg2wRT9nDPcFU5LASgXgVyxUZCLD6QDSO0goUf9B/duLoX4DrIYQ9qiBDJ2NM/nCXNuKVKS1+lc6G3CDDs1688tTMCWrBN9cYCENQYAwNg+DXjzDLnK6WMv6a6okos3CqePK/WMBQNA57fC0+5dCeX7RAZdPiv2WEY5OcRbjD7+QdH8tGdovGQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(5023799004)(56012099006)(22082099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o4Lsj4ly1XgPRNYBQQ5Cd3FDbM1kRuYFa77K/y/Rsi1nnlV70uP9ChywPHJ3/G2BpVGv4xU5xoOsZ/9HQNdfyzxNMCJFdFnPEbJo48woZ4ckjvAyTmpSJEnxAkbhhd6wJPpdMOtqytwe5c17BvHJXUhDGo2V9HuSfscyINpbWov3JpmacmEhTuW2G4W1yX2g93y+TIpxrfOBfMwkQy4StQyArUD9InGF61JNsWQaOZn6eMzsr0+5Zux1R/mg4SF89rgXXFuxmzWebZHTZ7okyDMnjQHgMibjrfEvHsztGk9j2dL2QqqUzSnL9YLYPdR6N6Api9r909kfFMCT3PKyBbU6eb1tbhO1NaH13at4W2CjICQ5M6ULHoyhkJOpL3/MVG+BLtVxRAPM+GAxitWyowq3iqFnc5U/ip3SB+59vnoWIx6ZfghbaB1j90GLpt9E
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:55:57.9964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5652631a-4033-4b7b-8fba-08df2387a38f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909

ublk ends successfully completed requests inline on the server thread
that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
redirects completion back to the submitting CPU, unlike NVMe, SCSI,
virtio-blk, loop, nbd and rnbd.

Route completion through blk_mq_complete_request_remote(), with a new
->complete() callback, ublk_end_rq(). Add UBLK_F_SUPPORT_RQ_AFFINITY
so servers can detect support via UBLK_CMD_GET_FEATURES.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 72 +++++++++++++++++++++++++----------
 include/uapi/linux/ublk_cmd.h |  8 ++++
 2 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..48bdb5d782ee 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -90,7 +90,8 @@
 		| UBLK_F_BATCH_IO \
 		| UBLK_F_NO_AUTO_PART_SCAN \
 		| UBLK_F_SHMEM_ZC \
-		| UBLK_F_IO_DESC_SIZE)
+		| UBLK_F_IO_DESC_SIZE \
+		| UBLK_F_SUPPORT_RQ_AFFINITY)
 
 #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
 		| UBLK_F_USER_RECOVERY_REISSUE \
@@ -1549,13 +1550,54 @@ static void ublk_end_request(struct request *req, blk_status_t error)
 	local_bh_enable();
 }
 
+/*
+ * Update @req with its result and requeue it if it was only partially
+ * completed. Returns true if @req was requeued, in which case the caller
+ * must not touch it any further.
+ *
+ * Run bio->bi_end_io() with softirqs disabled. If the final fput happens
+ * off this path, then that will prevent ublk's blkdev_release() from
+ * being called on current's task work, see fput() implementation.
+ *
+ * This matters for the caller completing @req locally on the ublk
+ * server's own thread: it may already be holding disk->open_mutex, e.g.
+ * reading the partition table from bdev_open(), and an fput() running
+ * inline there could deadlock on it. Preferably we would not be doing
+ * IO with a mutex held that is also used for release, but this
+ * work-around will suffice for now. A caller reached instead via
+ * blk_mq_complete_request_remote()'s softirq/IPI redirect never runs on
+ * that thread, so it isn't exposed to this hazard, but disabling
+ * softirqs here is harmless for it too.
+ */
+static inline bool ublk_update_and_requeue(struct request *req,
+					   struct ublk_io *io)
+{
+	bool requeue;
+
+	local_bh_disable();
+	requeue = blk_update_request(req, BLK_STS_OK, io->res);
+	local_bh_enable();
+	if (requeue)
+		blk_mq_requeue_request(req, true);
+	return requeue;
+}
+
+static void ublk_end_rq(struct request *req)
+{
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
+	struct ublk_io *io = &ubq->ios[req->tag];
+
+	if (!ublk_update_and_requeue(req, io) &&
+	    likely(!blk_should_fake_timeout(req->q)))
+		__blk_mq_end_request(req, BLK_STS_OK);
+}
+
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 				      bool need_map, struct io_comp_batch *iob)
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
-	bool requeue;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -1588,25 +1630,11 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 		io->res = unmapped_bytes;
 	}
 
-	/*
-	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
-	 * happens off this path, then that will prevent ublk's blkdev_release()
-	 * from being called on current's task work, see fput() implementation.
-	 *
-	 * Otherwise, ublk server may not provide forward progress in case of
-	 * reading the partition table from bdev_open() with disk->open_mutex
-	 * held, and causes dead lock as we could already be holding
-	 * disk->open_mutex here.
-	 *
-	 * Preferably we would not be doing IO with a mutex held that is also
-	 * used for release, but this work-around will suffice for now.
-	 */
-	local_bh_disable();
-	requeue = blk_update_request(req, BLK_STS_OK, io->res);
-	local_bh_enable();
-	if (requeue)
-		blk_mq_requeue_request(req, true);
-	else if (likely(!blk_should_fake_timeout(req->q))) {
+	if (blk_mq_complete_request_remote(req))
+		return;
+
+	if (!ublk_update_and_requeue(req, io) &&
+	    likely(!blk_should_fake_timeout(req->q))) {
 		if (blk_mq_add_to_batch(req, iob, false, blk_mq_end_request_batch))
 			return;
 		__blk_mq_end_request(req, BLK_STS_OK);
@@ -2347,6 +2375,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rqs      = ublk_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static const struct blk_mq_ops ublk_batch_mq_ops = {
@@ -2355,6 +2384,7 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
 	.queue_rqs      = ublk_batch_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 33b25dd13965..47b5fba9519c 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -420,6 +420,14 @@ struct ublk_shmem_buf_reg {
 /* ublksrv_io_desc size is specified by ublksrv_ctrl_dev_info's io_desc_size */
 #define UBLK_F_IO_DESC_SIZE (1ULL << 20)
 
+/*
+ * Request completion honors the block device's rq_affinity setting
+ * (/sys/block/ublkbN/queue/rq_affinity): the submitting CPU's completion
+ * work can run there instead of always on the ublk server's CPU. Without
+ * this feature, rq_affinity has no effect on ublk devices.
+ */
+#define UBLK_F_SUPPORT_RQ_AFFINITY (1ULL << 21)
+
 /* device state */
 #define UBLK_S_DEV_DEAD	0
 #define UBLK_S_DEV_LIVE	1
-- 
2.50.1 (Apple Git-155)

