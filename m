Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D2374E67
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313483; cv=fail; b=Rn2MHuOmNqVliOk2G19uaL1mzr9wxXSizyHBGGccM8pVb3EfSB1/5Vjc3BZG4111R5PkWsJcmkZ+oLwA/BjH6iNvUB4heoQI2/xVTeRwdVxrXYcnQUISsArLIDWbEvfy4Ca4NTFKQoB0JQ4/A0K6vJM4cJ3J6upq/EuBIxnlAMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313483; c=relaxed/simple;
	bh=TKFdDjcsA9jR0eeLOhB6bUayZ8AdHTNEbRSfwemajpE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PyvxH/cCKpyDMgGQBIE0EDO8wMeVhv7aCjLzL+LPaJQQEvZs22bznuDpBMtssDveQtK+qaTfgZZKVoyNWD181e6Zscfhea0F7PwFeFpTeUdIit4lmuzRe8ijSbI7KI/1G7ZAiPuAAq8ksqPqV9b42fEkymZEVpatlZa5zWr/oLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mc2ddAj2; arc=fail smtp.client-ip=52.101.85.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mc2ddAj2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u18upC78mU/534201GgRwhUtK0/XyfjQjsK0DB2BQBdKQMHn8MpDqHUbcWLd/4XNRXMU52Kd17lUGEDX8iCqpxfvQTPJqDqRQqd64zzoCN9a4t3DNtyctkGdouOh6sB0xuMnXjC3SPtn9SkXKPiwMpZy+6joNO3zgbqhav8p8hip8g8M3rg8m9J6l8Y3dDBLGlAs6ehf0LKOteuv95I8Dk/5dUnSv4qr4T/rMljHM0pQ7soaDKtZX+0pjXVflEjRtyFHW5JCAsqeOHoOI9Ows4u+VWbxo8U3BoYU0g9k+TbFcREKRq0Qbdn9cND86SD5qn4T9+bTTZCHQJB7MD0VWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbMmNWaAJ2NNMux3r54cknTvxONFdRCr+N8ixjwsTjM=;
 b=DAkSzu/JYZBc0rcPp8roloPV+gyUyFXJuXPtQj5BBM6My0A88fdFp6XL9jggtsxhkA+GdHmeuNw+Fkg7QF0+PI6DYAja8FJHO9lgVIoPSxAeLxKpLBZLavmd5WEHqxTqtWI7yKFjF9krOJNWsJngUQhJIuGModyu0pN2/XuyguNtvadwCc2QHiqoJR7gl0jzV2zB8dn6Mmba0uU9bh2LsCoVdozrzZNTvHg0Bt4sL+nut+1ABNVPMDIUHX8dypCNI4j8hhXkTbmgufYZYbV1TU41jME6dLIHmzz8vI2mMYP59i/OXKJwaZVDhFT01lq8pRP7mh+Ci0iYx7tmkFADwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbMmNWaAJ2NNMux3r54cknTvxONFdRCr+N8ixjwsTjM=;
 b=Mc2ddAj2j46QtS/a2WF0d8Bfo0xrL9LmDZ6d2iP+O37PhuZalQoNmk8PkYpYH7pRLLqM6Ll7+LU1MUTgK5/fGbYS2nl4QjUA20KxzgRlU6L+5KZlkLYEs/WBAzzH38aa2dF9cAGj+t64iMqMgqnqCtIh/QOWcdnALAxLRedBnvTn2fpDhn8UbC1JBL2zUEGt90Hf517SyG+3wdvXCq1Qf9h28B2QWp17ThYwKuFAjc34lY1F/gXasineX3CD9EDYFvBPHc2Lq7XZgIsXDUsk90WsnG9l3BL314EOhv0epuPfUhzmF/37XkqJQ7i6TV03KUEgptZl7IXPNRgQrXZ5Dw==
Received: from DSZP220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::6) by
 BY5PR12MB4306.namprd12.prod.outlook.com (2603:10b6:a03:206::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 19:04:37 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:5:280:cafe::24) by DSZP220CA0002.outlook.office365.com
 (2603:10b6:5:280::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 6
 Oct 2026 19:04:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 19:04:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:04:09 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:04:06 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v2 1/2] ublk: honor rq_affinity on request completion
Date: Tue, 6 Oct 2026 22:03:47 +0300
Message-ID: <20261006190348.85094-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261006190348.85094-1-yoav@nvidia.com>
References: <20261006190348.85094-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|BY5PR12MB4306:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ca70c6-e94f-4955-384b-08df23dcaa6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RCXWi3QyA60XnsfzEEm2lMG1NaiOgxkwYCkATdTKZ0rDFAH2LUETVtpn3T4rU2AscKUXGf8LJVNku6L+axnW+9LKRBFzKtsdIFqYjoEnEepV2VsniXnp9/1H4B0VoUdrjjdVTkhy5Db1h8CrCjcA7bSOkDvTqFCRBlXGWU0Hwsb8kmvM5n+LMveN90mzAecPWkrS3iy1/aA3vXBj4tnYY6ezP4nPoIwYBgt5D18SdAXJYvoK5uhVsIEx3Mdp3MR1WwAYu0dzHury29FjmZnwAm1dSeNE3z1JZJfpxFMMsGViK7qTjoJGKvB+GTQBeUK1Lg9EDK1TOQPvDcFTHLmiOQx8D4Swc9Gh2WMubjwQcVDHvf+sxmHGkVlVGwLkBbBjG9evS2vbsekOJVAqLdo+XEC/TfZ7cJkd6SeoCWqGtM8oCPcRxBBqbVuS/CW+/OdDgxgUKKg4re9HP4wnGNsR3rtkKPg0JLn6YVc8AhUeTGXv73NT9nCbi+Q+o632Tuj6hh21OgBU8s7fcyx9tCCG3yeYaECL9+K4IfUZV5mDe/78OEyqXibyQezOYP546iD9VCMAMrcsEI51YKWpeMikAjDwqHrG4LbVwV+kvV7GaQCGAC95RFBw/AXwSyLGbOxxFbWCn/UvY1FQpWBjfa0dDGR/F7aWRYMZ/GNAvAv/2Isq3S6iaQ3otyx9RWYgc8btwhZWxUvUq90jE76ammCEog==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GldTZSkqBHH//AahIIi77rWLjbKXu4uAuX+Efba9XRdn2KXawdYlymgR2BrlDHn0L5GBMjrn+cmIw3g7+sL9IWxvIoZUoK+zFYPfojOejM5W16hvseVCwveyc0y39/XxGw0NbLgcOZdBzzKYUrtBloxSLA8b5u4OCHR1qXbxZeYTkFUJiOIc2gljIyB7bWLUvbHFadGwTe+5mvpjKwhRogN7HpJkL/vrLkpqx4/ovsLcEL8r5xzSul70BRu8hC04uwS247zMKmbVn5SmafBE4AnONVLOjZgdBgiPDdPgoCFDJTplx50dpmwxqccE7orHJ9yd5jLjyEWDc/Y0YEsNsIDZU0gUwoFDEoP2YjlQkihAtm0+STId6/m2DxIkQEqXmmWLGz/CECqNaDDjUyIvryToMGQ2m6Dh/mH/IWvq3IHs4rUdSOe3bBBVZVsjvoOS
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 19:04:36.7532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ca70c6-e94f-4955-384b-08df23dcaa6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4306

ublk ends successfully completed requests inline on the server thread
that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
redirects completion back to the submitting CPU, unlike NVMe, SCSI,
virtio-blk, loop, nbd and rnbd.

Route completion through blk_mq_complete_request_remote(), with a new
->complete() callback, ublk_end_rq(). This covers every completion
outcome -- reads, writes, flush/discard, errors, and the zero-copy/
user-copy/auto-buf-reg/shmem-zc paths that skip the copy-back step --
not just the classic-copy-mode successful-read case, since
ublk_end_rq() re-derives which of those __ublk_complete_rq() took from
@req and @io state rather than assuming one.

Gate it behind a new UBLK_F_SUPPORT_RQ_AFFINITY flag that a server
must request at ADD_DEV time; servers that don't ask for it keep
today's always-local completion unchanged. Add ublk_support_rq_affinity()
alongside the existing ublk_support_*() helpers, and check it before
calling blk_mq_complete_request_remote() at both call sites.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 98 +++++++++++++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h |  8 +++
 2 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..b94293296b73 100644
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
@@ -452,6 +453,11 @@ static inline bool ublk_support_user_copy(const struct ublk_queue *ubq)
 	return ubq->flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_support_rq_affinity(const struct ublk_queue *ubq)
+{
+	return ubq->flags & UBLK_F_SUPPORT_RQ_AFFINITY;
+}
+
 static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_USER_COPY;
@@ -1468,6 +1474,14 @@ static inline bool ublk_need_unmap_req(const struct request *req)
 	       (req_op(req) == REQ_OP_READ || req_op(req) == REQ_OP_DRV_IN);
 }
 
+/* Whether __ublk_complete_rq() takes the copy-back/partial-completion path */
+static inline bool ublk_rq_need_unmap(const struct ublk_queue *ubq,
+				      struct request *req)
+{
+	return ublk_need_map_io(ubq) && ublk_need_unmap_req(req) &&
+	       !ublk_iod_is_shmem_zc(ubq, req->tag);
+}
+
 static unsigned int ublk_map_io(const struct request *req,
 				const struct ublk_io *io)
 {
@@ -1549,13 +1563,62 @@ static void ublk_end_request(struct request *req, blk_status_t error)
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
+	/* matches the two outcomes __ublk_complete_rq() may have redirected */
+	if (io->res >= 0 && ublk_rq_need_unmap(ubq, req)) {
+		if (!ublk_update_and_requeue(req, io) &&
+		    likely(!blk_should_fake_timeout(req->q)))
+			__blk_mq_end_request(req, BLK_STS_OK);
+		return;
+	}
+
+	ublk_end_request(req, io->res < 0 ? errno_to_blk_status(io->res) :
+					    BLK_STS_OK);
+}
+
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 				      bool need_map, struct io_comp_batch *iob)
 {
+	struct ublk_queue *ubq = req->mq_hctx->driver_data;
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
-	bool requeue;
 
 	/* failed read IO if nothing is read */
 	if (!io->res && req_op(req) == REQ_OP_READ)
@@ -1568,7 +1631,7 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 
 	/* shmem zero copy: no data to unmap, pages already shared */
 	if (!need_map || !ublk_need_unmap_req(req) ||
-	    ublk_iod_is_shmem_zc(req->mq_hctx->driver_data, req->tag))
+	    ublk_iod_is_shmem_zc(ubq, req->tag))
 		goto exit;
 
 	/* for READ request, writing data in iod->addr to rq buffers */
@@ -1582,31 +1645,18 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 	if (unlikely(unmapped_bytes < io->res)) {
 		if (unlikely(!unmapped_bytes)) {
 			res = BLK_STS_IOERR;
+			io->res = -EIO;
 			goto exit;
 		}
 
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
+	if (ublk_support_rq_affinity(ubq) && blk_mq_complete_request_remote(req))
+		return;
+
+	if (!ublk_update_and_requeue(req, io) &&
+	    likely(!blk_should_fake_timeout(req->q))) {
 		if (blk_mq_add_to_batch(req, iob, false, blk_mq_end_request_batch))
 			return;
 		__blk_mq_end_request(req, BLK_STS_OK);
@@ -1614,6 +1664,8 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 
 	return;
 exit:
+	if (ublk_support_rq_affinity(ubq) && blk_mq_complete_request_remote(req))
+		return;
 	ublk_end_request(req, res);
 }
 
@@ -2347,6 +2399,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rqs      = ublk_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static const struct blk_mq_ops ublk_batch_mq_ops = {
@@ -2355,6 +2408,7 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
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

