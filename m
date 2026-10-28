Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793193554;
	b=E3FG5IM4bdReddbXNb/AS9JYWsOXS5Q479EUIB2dWGPuEyLoXH8AK0gBI/pmiV0bCSSp
	 kIPtlTwsm+PqqOwWiVavTEDO670h2iqnTSolrzwVVD6I7j7wiNKPaqkRqgm8WNl4oDB6A
	 cmlxcnnG2+Q7hHaXabb90zyYyacfeCsoZreLDCWEHiJmEkQgV00MO8RE/4S207tEfHwez
	 SbOfvOX0KJfxZWiQ5FfIw3FZdoYqDItyjalme1Ilcm4MEtmtNdwCh3ARGAuqZtAngmlV+
	 VUxbk569GINFxzBp6ySM7MOyneJJrSiSwmB8DsMiicNH1IrRD78hkc2is3oW4Y6QTJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193554;
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
	bh=zmbjojemNw9FGKFyrqknwBJZrNLAsQoloukqb3W/hGQ=;
	b=jXG4X8EEG6mrD/7aKS6fsdHBABA29mSKYOIQ/gcOZVR2eqoXn8iWPbIxYyidtf0SEoni
	 f1xc84/gpHVnIaRs0n2VpFpxUmwy4ly71771ztsBkxiG1GwU6HT1D2rGZLsWhU+tt+x4k
	 T+rnws+wrYcmWpcY9zXCARb/7nqasw8H7DmIB2xOdhJ5qlqAKf43KYRSBpZ9Fj35vsB3t
	 0yLk9U39Wzh5Eowr06Zbt5+bPTP/B6AMJCtkknGMPfOD1KmiyDbEY8hX1qVlcFq9a2UyS
	 BZBEfHbG3P46+k5/TtCmOBXdXFXyl7QmjYYicpBRr5uiT4DDY5SANl6FCFs2Hh3LYUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZgVMWjG2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.11
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9053606A339
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 13:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9053606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ZgVMWjG2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayCl9EXRSN7l5Y5AhLWmFu39II8bIVZhVN4CcCUlh0ukPoYvPnTkjA3J0338N3b44IdMK/673hFc3LclxofWq+CnrUQ/ky+/F/Oz+e5k2YQNiEYoGYPBh7Q8lqf0OeBnLiMihKRbJaKNw8n7A8lw6PEoaAFmFPg1pmPt1ATOoive9MMQFpEmMZHbYWgpOK9R1nhEIvD/5Ui3/qXJuV5VyuMELlh6E3CeOVO+9jiEWikhL26c8ZYwAkwO3sc425WKie3g4tJVpklgdTe1bNiaKz1F7b1bFxMyriatXyGo0E3T57iDW6D09qarkKaHK+fE37YVc7D4/G7pV4sxBZdWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmbjojemNw9FGKFyrqknwBJZrNLAsQoloukqb3W/hGQ=;
 b=f5ZTFEnZJjm7bvEX+FqTXyVTpaI3OMYqMhjqXmt1C0qIHICF1T36e3qcyEambQK90Bwg+yxRoNAtaO+qasbUG5LjUqCdUotwNe00q/M3IehuB9qRhosI05WB76cIUHat5xTIKw0ER+lnEtYGsCUoMeLgJQIU1+stPUq702hVdQatVVyS0webyvNEQbKVz+jF1dzQ6QhNh4Cm0sseUqNjAbD2B5CjUaX4Uw/T4Ka/uiyQzPpEAqm4Pba1Zge60KxddjBZTeuM2a31a1Pd8zsDQsIToHiXdie9Fb7DoPQPlH4HwQ8JyqUOIZuOme2TIsKXAwNm3AbyrcFylde/YSfNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmbjojemNw9FGKFyrqknwBJZrNLAsQoloukqb3W/hGQ=;
 b=ZgVMWjG28bdp4pd+VzZAAmtOl6HYUdLa7cnXB94x781rG/CTWzlx+aNAcJxHLuCRLAWJso0zqFQvoaB0/KdeOnHcQQ/zZ0jkKlF05mLSsFI7WdT7nx4BlzuAwSRfx9PEJq+p7CAoVHMqMMOjFAz7n/lJU17pe1T2yXZ1yU5y2kaxpCH0wSDRO+/5+48eK0QWuz+y0jWC137OI49uHEMrGp9jGrhOHbiRsDcoJOSD51joSB0ioN80TPXeVznyd0j5e/fOq07492F3HGusth9YhCwORsxSfSN/wz23WSHMTOoUC3cd3wgIR+HpW0CU5dPMhI6dEAPeek6m+AHFT6hw8w==
Received: from MW4PR04CA0069.namprd04.prod.outlook.com (2603:10b6:303:6b::14)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 13:19:05 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::a5) by MW4PR04CA0069.outlook.office365.com
 (2603:10b6:303:6b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 13:19:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Wed, 28 Oct 2026 13:19:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 06:18:46 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 28 Oct
 2026 06:18:43 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH v4 1/2] ublk: honor rq_affinity on request completion
Date: Wed, 28 Oct 2026 15:18:28 +0200
Message-ID: <20261028131829.45803-2-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261028131829.45803-1-yoav@nvidia.com>
References: <20261028131829.45803-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 35214677-b49d-4d81-5301-08df34f60a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|261021121427099003|261026140227099003|11063799006|5023799004|261009223027099003|261022105027099003|10067099003|261021123027099003|22082099003|261026121527099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wYn0Ba5Mb6BpynQu6KVnjyO4R8GNssj/rG0Xbn6xi3I4NmxNNQdFKqwrKHxr0mg/vVBTB66TEgrvhkSJ90ymQk8fVSIogCFaZQoW8FzEUuVziS+Oo1+mGBha2QGrzbk/szvfEaRXwVAJbJdz4HaRUAo+0EyfAbEKbL216vYdt6ysEHx79x/fY/TQu8oIlrzeZjC6oHUuNG4EbcEGXmugLAtw34H/4L3ZfxBMowgexc9IYZCB4eeK/vBkLYSuEkJX0VODwe7AYu/Mv1QQklEyY6ICMLOMPW4lVMh0qTMUNe6jkm0d4EztL38KEW4EFwRjqZ6KR0tGj1NgclU28Vmuo9u21Hkw+jiKDtmGnL0refw5y5tP2ifRxbZl/1ROgGlzFZ9kqlHvMEDOWbw98UES1H74WEQyCZhn/meZdG6/nwg46sbpjnNke2ip2/4MCgjhe2Z5FCULISrQOovowEFv3FpWE6D2XCSSSH/HBMolJ1GVe2cici2L03v78MRhpsY1Ub0py03WdIONMSvv5IxU6XGbQIzGiWbXFZAsiccMlRlIevBZp6YE2PhHwEu8fSy2umxlWRJ8bNFwLg8NiVMpku5XtmG31IZ2mjBk0yWB/83TAzofEzEtotkUunoM/oIhHo/u8E00WZMRJ2iucCRiBGBDog5Ky2jZrymampAAAK/+qH8R5K73iVTNquE4HWfMt9n1ui72PUC3JSzh+5062w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(261021121427099003)(261026140227099003)(11063799006)(5023799004)(261009223027099003)(261022105027099003)(10067099003)(261021123027099003)(22082099003)(261026121527099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yym9mzunZZ/EK4IOpCOG1/Ryvo0bSn42pGxmakOw3cT+20l6RU2XWzh2lzQzc88CrdCAqy+7Y9vRZFGcmLrc3MfDqcTIrXg7VBdD933xb41PNbOSZ+72FXuhMjlTsdcq5KBAcHEZjfdysL1uqjsuBlt95fahs0xE4uWcZ/XlI/q9bmCkF8PjfUl4ejJYBUlyDgZQX6ZPw+sNlphXL3A117ByAO/Oku9job4LXxK5cy9vHzSp8q4qOjDNUbJKufaEVwu3GiF06KbXOLgY+V8LP2JsNN3I9D/amoepvbfyK5Ti69QXUWVrtpLtrdfdNFopVwcDvijPzWi8TdUsRESPwvdyvUVCGq/iiiLQAdqMStV6ZE1fh5FDcLb5M3giGLUMUmtFIigzACWDJNll0J3cWcI+7nTDyCq4XV20WqHj2RG3MM6TtCyXiFhTSIxdJuCv
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:19:05.2028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35214677-b49d-4d81-5301-08df34f60a7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

ublk completes requests inline on the server thread, so rq_affinity has
no effect: completion work always runs on the server's CPU instead of
the submitter's, unlike NVMe and other drivers.

Add UBLK_F_SUPPORT_RQ_AFFINITY. If the server sets it, a request that
completed in full is passed to blk_mq_complete_request_remote() and
ended from ->complete(), unless rq_affinity is 0. Partial completions
and errors still complete inline.

Servers that don't set the flag see no change.

Signed-off-by: Yoav Cohen <yoav@nvidia.com>
---
 drivers/block/ublk_drv.c      | 68 ++++++++++++++++++++++++++++-------
 include/uapi/linux/ublk_cmd.h |  8 +++++
 2 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 72e9c435208c..378f19429e56 100644
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
@@ -466,6 +467,11 @@ static inline bool ublk_dev_support_user_copy(const struct ublk_device *ub)
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
@@ -798,7 +804,8 @@ static void ublk_setup_iod_zoned(struct ublk_queue *ubq, struct request *req)
 #endif
 
 static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
-				      bool need_map, struct io_comp_batch *iob);
+				      bool need_map, bool rq_affinity,
+				      struct io_comp_batch *iob);
 
 static dev_t ublk_chr_devt;
 static const struct class ublk_chr_class = {
@@ -1210,13 +1217,15 @@ static inline bool ublk_get_req_ref(struct ublk_io *io)
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
@@ -1560,9 +1569,33 @@ static void ublk_end_request(struct request *req, blk_status_t error)
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
@@ -1599,6 +1632,9 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 		io->res = unmapped_bytes;
 	}
 
+	if (ublk_complete_rq_remote(req, io, rq_affinity))
+		return;
+
 	/*
 	 * Run bio->bi_end_io() with softirqs disabled. If the final fput
 	 * happens off this path, then that will prevent ublk's blkdev_release()
@@ -1625,6 +1661,8 @@ static inline void __ublk_complete_rq(struct request *req, struct ublk_io *io,
 
 	return;
 exit:
+	if (res == BLK_STS_OK && ublk_complete_rq_remote(req, io, rq_affinity))
+		return;
 	ublk_end_request(req, res);
 }
 
@@ -2358,6 +2396,7 @@ static const struct blk_mq_ops ublk_mq_ops = {
 	.queue_rqs      = ublk_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static const struct blk_mq_ops ublk_batch_mq_ops = {
@@ -2366,6 +2405,7 @@ static const struct blk_mq_ops ublk_batch_mq_ops = {
 	.queue_rqs      = ublk_batch_queue_rqs,
 	.init_hctx	= ublk_init_hctx,
 	.timeout	= ublk_timeout,
+	.complete	= ublk_end_rq,
 };
 
 static void ublk_queue_reinit(struct ublk_device *ub, struct ublk_queue *ubq)
@@ -2715,7 +2755,8 @@ static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
 		blk_mq_requeue_request(req, false);
 	else {
 		io->res = -EIO;
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub),
+				   ublk_dev_support_rq_affinity(ub), NULL);
 	}
 }
 
@@ -3266,7 +3307,7 @@ static void ublk_io_release(void *priv)
 	if (current == io->task && io->task_registered_buffers)
 		io->task_registered_buffers--;
 	else
-		ublk_put_req_ref(io, rq);
+		ublk_put_req_ref(ubq->dev, io, rq);
 }
 
 static int ublk_register_io_buf(struct io_uring_cmd *cmd,
@@ -3288,7 +3329,7 @@ static int ublk_register_io_buf(struct io_uring_cmd *cmd,
 	ret = io_buffer_register_request(cmd, req, ublk_io_release, index,
 					 issue_flags);
 	if (ret) {
-		ublk_put_req_ref(io, req);
+		ublk_put_req_ref(ub, io, req);
 		return ret;
 	}
 
@@ -3559,7 +3600,8 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		if (req_op(req) == REQ_OP_ZONE_APPEND)
 			req->__sector = addr;
 		if (compl)
-			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub), NULL);
+			__ublk_complete_rq(req, io, ublk_dev_need_map_io(ub),
+					   ublk_dev_support_rq_affinity(ub), NULL);
 		break;
 	}
 	case UBLK_IO_NEED_GET_DATA:
@@ -3616,7 +3658,7 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
 
 	return req;
 fail_put:
-	ublk_put_req_ref(io, req);
+	ublk_put_req_ref(ub, io, req);
 	return NULL;
 }
 
@@ -3907,7 +3949,9 @@ static int ublk_batch_commit_io(struct ublk_queue *ubq,
 	if (req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = ublk_batch_zone_lba(uc, elem);
 	if (compl)
-		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub), data->iob);
+		__ublk_complete_rq(req, io, ublk_dev_need_map_io(data->ub),
+				   ublk_dev_support_rq_affinity(data->ub),
+				   data->iob);
 	return 0;
 }
 
@@ -4239,7 +4283,7 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
 
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

