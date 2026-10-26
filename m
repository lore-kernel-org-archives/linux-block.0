Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793016422;
	b=E99I8TR0Hv2gRtm2o00w2Y6+q2JcB3e7dfVLZ79G9UXlFB6miOpcoDfkAr3K/WFWcYLC
	 B4zSLpCkde170m4RsYynytXLZHEA9/7t9XovwIranOJyCb8AmjgNJaa151TCYOA9OjWxc
	 e5IjbkX+w5Q93/ExwU2Oag8VvbjLMyDE+Z6QqJdopLMnVcC+Gq8LE8lUAiDUK4kiRykQh
	 xUKxSQD5W1X9fK0CXmmDbgRLjQc8Z+j1oNIwpjmZuJbLF3rO/E/mTidFpA1ZXRY8U8LKN
	 TQi0iNRUMZ/zaPKa9GpxTMSdRKE7r0m67yT7B6ok68H3FoQgroqq9kvJDnzOBE6Qb3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016422;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=v/gMyUR45l6gynXaSquR/c45MhzTwku6p4RurOJoCnY=;
	b=arID7IIOzBwOuc8wTQR6dSZ/UTsKgyceaSeDxX9MHu4fB7evq9rhj1LKqxxj7gNLTzFM
	 8UjEU1EnkYk8YOwjYjm09SGqnS7rYNaVNU8OasrkMttUOJ6Il9nTOCAaSruL800ENyEuj
	 q0DGuKeOB9CQuWufLQxOkCOB6SOHbJ7bR+DftjGmaurVH+dGH9pp8DoFz+TCmKsloiNEa
	 CHL9bIGVD9FdXEYkU2cBdJZdII21/TvhxY0HPaaAA/AmHcQj2f/zFFCYR6THadVwsGgid
	 nZ1ediF86RGHng927oCPQxnOlssmYcKnWSy1oTX4eFkiqD0ZntKxAbcFMmimgn5r9Vw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="CD0/DaZe";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.63
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA4606A31B
	for <linux-block@vger.kernel.org>; Mon, 26 Oct 2026 12:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12BA4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CD0/DaZe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPVRnrY2PxX+GvUxOPICjmWX5Zyntk0tTWrEW6FBjk8sz6x4f67gk4VOy9ZvjfEYRWasaHMjNwFLqrmyxGgtgarpbgvIRSffaV1IhbGiPJud+6C4cXsNqlDEmIc44cFJgCr9kNAU7bX5oGz9WRV8ouWkDsb0dEYcp0WEqaTBdaZditjVochQw6UMokdZ7gmsPvsayiUyXQPwPv3Z2yEzKC0m0MkhNocE9OfgFIlTO7ma7x/BiVdte1kJ2dXe3nHdQGv4VUN6eB0jVMd9EGvcAVa9Vz6T097fSkruGJ0jnMQr6VgQQ537O9wH95FI6T6YFK6vq+Ciu2Y/lF/7FisQyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/gMyUR45l6gynXaSquR/c45MhzTwku6p4RurOJoCnY=;
 b=qs03gwntBMnO9DOES4VZqG1xhIM/ETNnI11Snt2SH5L7Xf5E7ai5W7WEKulLSg4CuUgnkFx1sE0r3jXhFVibOj5f1jgmp8s+FkDZ/8GN5y4UA1G0UTPK34iANtgeHaYImqlNsmHFM44kn8sjW/4cBfKlIShAe+eT45lXXdoTPFCAuXHuWCyOCN3pqXVriwQpahoZCbBIbu51OiqkXCThloJWnapCH9knnmCHZ+0HMBF3tIYJzdGOitykrsXYbECRQLXO1xSzpbMjlS1VsPpQv4iS9eKvBtydYUGWcrY2hMv1imIZF+uiqvAQzv1+Zg44K7gSRIezKuq/hZ9GhvCEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/gMyUR45l6gynXaSquR/c45MhzTwku6p4RurOJoCnY=;
 b=CD0/DaZeqv/tps97p1QfM3jolCP5O39C+xmevKYoTgFOvjbkBwcDDwbZR1ynX7/W/Dkkdd3HJ9r/O6PGs+sftZHSxcSeexh/U8NDu3h1fmuKpl70ZCnlWQ4dMdLCnqTjP0eac6yLqJoAOYr6o2P6izhJrV64Dx5yj4uNc8e5VGwbJ1z+klOqSNshINOU5yh5AGn9MEZABdPIgMKC70Up6Z9A/F8yye36D5+Y+bpXkUIkaJW3PB1jJwcEhazgP321Bl1MVUkI/15+HPYzKCGMaVuhsV0NZ2QmOVpz+amMSTEQ9lUmoMeAoAbjQ3dSRm76d7+aNd7mMWqUZzOoBYax0A==
Received: from CH0PR03CA0257.namprd03.prod.outlook.com (2603:10b6:610:e5::22)
 by SJ2PR12MB8846.namprd12.prod.outlook.com (2603:10b6:a03:549::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 12:06:53 +0000
Received: from CH1PEPF0005BD5C.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::2d) by CH0PR03CA0257.outlook.office365.com
 (2603:10b6:610:e5::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 12:06:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0005BD5C.mail.protection.outlook.com (10.167.244.245) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 12:06:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:06:36 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 05:06:33 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH v3 1/2] ublk: honor rq_affinity on request completion
Date: Mon, 26 Oct 2026 14:06:18 +0200
Message-ID: <20261026120619.47629-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261026120619.47629-1-yoav@nvidia.com>
References: <20261026120619.47629-1-yoav@nvidia.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD5C:EE_|SJ2PR12MB8846:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b3c5a23-9620-4d62-9177-08df33599f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|10067099003|22082099003|18002099003|5023799004|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	flyJGM/QYuQO/nSjgby1QNRggjpjUNWSGE1JfnA1cz5hijgv66HY84qJs3luvZCv5lzR/aQRPLxDvLt9W1a7YJDZw7t8dmlnBTveraRd5H1Ulwy1hsxsl4pzPYJEEhv3Ni2p/sKRY0D7gGvC9O/ygRcE701AKAJR5010uN3VFZR7YC1qQ8NmaUKZh0wWe6MBaIuj/a3hTGJ1Gzn26t4ndpeG8fF0Cr/MGS84b/mpPutJQQDvYdRA01Wl2AQYPHy2D9d+YSGWhHLBWvh6vos66i0cwmXZOG555hB6Zbvz+5W0Sh1mlv2tErlZlL+pDbb2IEihB4hlZ5ccqO61U6JyCxsxtIHiayEpT+qOKKTMU2SqAvKG1ncHvhu68g4EUrBBFG/fxKlJ/w/toLxvWqQLpMDyMx12kHX8XLCVbCQuo8OJ/+pzVpvLsaE8igXav82ZcOlzqhpGooXyf3bOvbUqlJDjjnAsge146nfoa5vCMJRknue3ioRwyM/bsB1FOI9ba4npYRJmaxu5+WaFqRzCt/APc4evgiHaYB4pSnznaWy8bJl5raaV8Sni6jP/+ripswO2eXQqPBSq+UoHPu7k9uZfVanTfN0DftXzBM+4bWFh2yjvAx6HHmafpTTo//jDJS+sjdlwSJLtqzkl2RYma6lVaeQYxWmh2yQCxTy8iUE3w70IqKwVX06d2lmaLD0llBSHWTxacW/KDJiPbGIYCw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+72jSKh5hSmwU2wBclMQxD7FBDP+ozvp5mz3O/mzj4RPnWYoHMaHHFUyFt8aYqjdRRwi6Feu4aQP30WxwK5cmbaWHTg1NG2t91PitAu9NvACRbOBLzR4FUzBAx7zeZdHsRprl2FTTW2Q3dSfeFBCfeWIRtIepv9ATP/7USXkQCJiDDtTRhySxLiZYSfrbShj9JQqB0aRdKAgnJDb0/mlzsNRf7HA7XvNtcKLn1ExbIyJEYH/cFTpxI4dUflPYs6OTeC4rZIoeLKSXC5DJLZYfEGSJAaVfiMD8qM0ZR3N/lDPDaQgybOimvZ1J1DO/VwhuyJUgyWPEY0q6buu9rS2H54wyCT1H5+EeTMFqdo+lEQgQOI4OFcoUwkMpHlNvIBAuY5wE7U/NS/TvrPhyAGSr7gQzF79PdsJVAblKJGmuSAon9HC7nUBUN+KD7WO3gxB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 12:06:52.4535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b3c5a23-9620-4d62-9177-08df33599f36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD5C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8846

ublk ends successfully completed requests inline on the server thread
that issued UBLK_IO_COMMIT_AND_FETCH_REQ, so rq_affinity never
redirects completion back to the submitting CPU, unlike NVMe, SCSI,
virtio-blk, loop, nbd and rnbd.

Add UBLK_F_SUPPORT_RQ_AFFINITY. When a server requests it at ADD_DEV
time, a request that completed in full (io->res == blk_rq_bytes()) is
routed through blk_mq_complete_request_remote() with a new ->complete()
callback, ublk_end_rq(), unless rq_affinity is 0. Partial completion,
errors and copy-back failures keep completing inline.

ublk_end_rq() may run on a CPU other than the server's, so it does not
touch ublk_io or ublk_queue. Whether the device opted in is taken from
the ublk_device the callers already have, avoiding extra dereferences of
the request's hctx and queue on the completion fast path.

Servers that don't request the feature keep today's behavior.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 68 ++++++++++++++++++++++++++++-------
 include/uapi/linux/ublk_cmd.h |  8 +++++
 2 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 66eb55e7162e..b626993936fc 100644
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
@@ -457,6 +458,11 @@ static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
 	return ub->dev_info.flags & UBLK_F_USER_COPY;
 }
 
+static inline bool ublk_dev_support_rq_affinity(const struct ublk_device *ub)
+{
+	return ub->dev_info.flags & UBLK_F_SUPPORT_RQ_AFFINITY;
+}
+
 static inline bool ublk_dev_is_zoned(const struct ublk_device *ub)
 {
 	return ub->dev_info.flags & UBLK_F_ZONED;
@@ -789,7 +795,8 @@ static void ublk_setup_iod_zoned(struct ublk_queue *ubq, struct request *req)
 #endif
 
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map, struct io_comp_batch *iob);
+				      bool need_map, bool rq_affinity,
+				      struct io_comp_batch *iob);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -1199,13 +1206,15 @@ static inline bool ublk_get_req_ref(struct ublk_io *io)
 	return refcount_inc_not_zero(&io->ref);
 }
 
-static inline void ublk_put_req_ref(struct ublk_io *io, struct request *req)
+static inline void ublk_put_req_ref(const struct ublk_device *ub,
+				    struct ublk_io *io, struct request *req)
 {
 	if (!refcount_dec_and_test(&io->ref))
 		return;
 
 	/* ublk_need_map_io() and ublk_need_req_ref() are mutually exclusive */
-	__ublk_complete_rq(req, io, false, NULL);
+	__ublk_complete_rq(req, io, false, ublk_dev_support_rq_affinity(ub),
+			   NULL);
 }
 
 static inline bool ublk_sub_req_ref(struct ublk_io *io)
@@ -1549,9 +1558,33 @@ static void ublk_end_request(struct request *req, blk_status_t error)
 	local_bh_enable();
 }
 
+/*
+ * Runs after blk_mq_complete_request_remote() redirected a fully successful
+ * @req to the submitting CPU. May run on a CPU other than the ublk server's,
+ * so don't touch ublk_io/ublk_queue here.
+ */
+static void ublk_end_rq(struct request *req)
+{
+	blk_mq_end_request(req, BLK_STS_OK);
+}
+
+/*
+ * Only a fully completed request is redirected: partial completion,
+ * errors and the copy-back failure cases keep completing inline.
+ * rq_affinity=0 also completes inline, even on a single hw queue.
+ */
+static inline bool ublk_complete_rq_remote(struct request *req,
+					   struct ublk_io *io, bool rq_affinity)
+{
+	return rq_affinity && io->res == blk_rq_bytes(req) &&
+	       test_bit(QUEUE_FLAG_SAME_COMP, &req->q->queue_flags) &&
+	       blk_mq_complete_request_remote(req);
+}
+
 /* todo: handle partial completion */
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map, struct io_comp_batch *iob)
+				      bool need_map, bool rq_affinity,
+				      struct io_comp_batch *iob)
 {
 	unsigned int unmapped_bytes;
 	blk_status_t res = BLK_STS_OK;
@@ -1588,6 +1621,9 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 		io->res = unmapped_bytes;
 	}
 
+	if (ublk_complete_rq_remote(req, io, rq_affinity))
+		return;
+
 	/*
 	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
 	 * happens off this path, then that will prevent ublk's blkdev_release()
@@ -1614,6 +1650,8 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 
 	return;
 exit:
+	if (res == BLK_STS_OK && ublk_complete_rq_remote(req, io, rq_affinity))
+		return;
 	ublk_end_request(req, res);
 }
 
@@ -2347,6 +2385,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rqs      = ublk_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static const struct blk_mq_ops ublk_batch_mq_ops = {
@@ -2355,6 +2394,7 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
 	.queue_rqs      = ublk_batch_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
@@ -2685,7 +2725,8 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub),
+				   ublk_dev_support_rq_affinity(ub), NULL);
 	}
 }
 
@@ -3180,7 +3221,7 @@ static void ublk_io_release(void *priv)
 	if (current == io->task && io->task_registered_buffers)
 		io->task_registered_buffers--;
 	else
-		ublk_put_req_ref(io, rq);
+		ublk_put_req_ref(ubq->dev, io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
@@ -3202,7 +3243,7 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	ret = io_buffer_register_request(cmd, req, ublk_io_release, index,
 					 issue_flags);
 	if (ret) {
-		ublk_put_req_ref(io, req);
+		ublk_put_req_ref(ub, io, req);
 		return ret;
 	}
 
@@ -3469,7 +3510,8 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
+			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub),
+				   ublk_dev_support_rq_affinity(ub), NULL);
 		break;
 	}
 	case UBLK_IO_NEED_GET_DATA:
@@ -3521,7 +3563,7 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 
 	return req;
 fail_put:
-	ublk_put_req_ref(io, req);
+	ublk_put_req_ref(ub, io, req);
 	return NULL;
 }
 
@@ -3812,7 +3854,9 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ublk_batch_zone_lba(uc, elem);
 	if (compl)
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub), data->iob);
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub),
+				   ublk_dev_support_rq_affinity(data->ub),
+				   data->iob);
 	return 0;
 }
 
@@ -4134,7 +4178,7 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
 out:
 	if (!on_daemon)
-		ublk_put_req_ref(io, req);
+		ublk_put_req_ref(ub, io, req);
 	return ret;
 }
 
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

