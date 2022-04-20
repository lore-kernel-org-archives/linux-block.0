Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8557EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243114AbiDTEOX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEOW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:14:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85C3186DE
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 21:11:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6B0zRs/fWhnbf2+Ge457MaKu5+wmoOy3z2vyY1qvelrQ2wNxDvS3NsupGSB8cDgP3rQY7SzfqU+CDaqzDpOgrYhLSta9FFiIfvxYCEV9bMg4a/EKcteY6LhxX/OhUWOeasyrXStwcymgL44xItXnSyLqmi8lAyWhKYurY5CiQI9cXo3Blq1+zVvsCUj1a040QI2jmlbCUOZDyF0jCY5Da85TRF9JPB6bCkaJWjwDefEd4YVhrtakpq82Suu3ueDPQ1/dnxHkNOKE+JKvm3NsjHCv0p70weNDarcW4N2xuIdKql3jg2IUj1lqOBRkAGmjTFWQphFCKqTS/ovog8mOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBat5LQ0XVMigUVfSsJ8wuxfijoJ6KKRfaPFE8e0xfY=;
 b=VczPvZk0sk4224w7exT2Zkg/nsGsksb28RsUEeMNb/z4iqA9Nw2sTYgM7Zys1ZtJ47SLfLx9HJDZk+18sWbQtLjriX/hXNj0eIxYYEcJ65zcuBIBKwx9UUTxLIBrHHVWSZT2mjaMqpWKjzVZ3D/ntF9aKaBCebF4QS42QdT4+hHNMAPJJ7vIoDk0LX/ArPn35zU2p6ln2ShjmeIumw9PCMvS9iap4jhALiK3/h81DJKejJ4W+4wS35UDFg4TbjIWTqCFr6OZ0ZAySfpuykqHLtnrYYrEFyQnNpxxyWfeSqyf9GosB+LcbbF94vn68fw55qCwTeDMdx2UToQ8AgL4iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBat5LQ0XVMigUVfSsJ8wuxfijoJ6KKRfaPFE8e0xfY=;
 b=snaDNN1gpfPM/JaWe8ElKAVqZVF+EQNsEjI6HR3QTYSCpKwSDqsiGgIe4fvy7s88bMMIz7jLe0bVj15CFzjYLZtXYwvf3P/OVrtO0kswDYJ4ltJKYqzh+kMkb/U6XoaEik9ITvxWt1km34Ncj/mD9sJWXxQhdlXUSj8VL6FB/1Tf5BkXng95LgC3r5gbmR39ymt5KLEzX3Fa6VAhkRN2ftLfeTS7kQ6Tl+eouLSpdHduO7V6eGtCC+4NsGd7kdlyfNYfVlH/BDjmQcZ7v2PE0hUpUPhyqpn78RqJKupOseeYIStbscrfWf5lIdgqcLPxL2CQ4zsUxRLUtbS59Pnl0Q==
Received: from BN1PR10CA0007.namprd10.prod.outlook.com (2603:10b6:408:e0::12)
 by CH2PR12MB3943.namprd12.prod.outlook.com (2603:10b6:610:2d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Wed, 20 Apr
 2022 04:11:36 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e0:cafe::24) by BN1PR10CA0007.outlook.office365.com
 (2603:10b6:408:e0::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Wed, 20 Apr 2022 04:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 20 Apr 2022 04:11:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Apr
 2022 04:11:34 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 21:11:33 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/4] virtio-blk: avoid function call in the fast path
Date:   Tue, 19 Apr 2022 21:10:52 -0700
Message-ID: <20220420041053.7927-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220420041053.7927-1-kch@nvidia.com>
References: <20220420041053.7927-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e28b90db-0785-4376-3e33-08da2283dc60
X-MS-TrafficTypeDiagnostic: CH2PR12MB3943:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39437FDC5710A5FF9387797DA3F59@CH2PR12MB3943.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kntnGFEvxT2bQDSlLZ7qnPMp0lfL/8o8M3B+zNquNecooNBL6Kb3VQRGSFcMDmSAryead1DJ4srB0ybs/YmEPN3OBIO/aqFvw5GbyWhVv18mjxhb/INsSFd4VvFz/bxX79PTAWRMdYlBBGMRhmAh/CIM5LSacuqKEl7KaWUCWTqyeTH5tJPsUTBDycqe1P3VSMlSsYxFQY3j+StdqegvoR0cDeadoJXkLYD42SUjfmKa8OuTT0qtHWlSDPEXP/s7164dktKpGKpeNKASrouR/znJTxuBPibbkaB5E5CiUFv86nDqak88o+VF1bK5scoDDTD/uJnaaXyvoJXTJVrQD/1rYAMpczO2N4EpgID66OxrdmuOZXIFo2iw3bkAt741WMYwXQTDZJPxLMNxBpHBgGW47pyvW/Fqtc01I4pz3H/TOwl11Q9AaZd4NL1hc5DyLbmY/ndvnZ5jhmFSfmmtXcJTpBQ2VWSbako4ou/ka6RmRHorK4NsX2NhJTG0XsFfAgGUvEPaPn/t4klzHhTssi36JS7Mf1ywVfXfi+VhJQl46t5iKarZ1xyrxjMJ8mh7jWlAbhG+i+5tDtfdVPDFsRtlWA3gGqrrz2oTYyRC3LfOfze56CCSQwumg/FEspSZRgZ3VlqF14eALY181AFjEXO3uFLA2BqMZu6j2FdHWHKfR0U/NPhsGk8ZzgJ1MD8WImXJOOiaeNP2C10R1iF7sg==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(316002)(70586007)(426003)(110136005)(8936002)(36756003)(336012)(54906003)(8676002)(5660300002)(6666004)(47076005)(40460700003)(70206006)(4326008)(508600001)(2616005)(107886003)(83380400001)(26005)(16526019)(7696005)(2906002)(186003)(36860700001)(1076003)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:11:35.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28b90db-0785-4376-3e33-08da2283dc60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3943
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We can avoid a function call virtblk_map_data() in the fast path if
block layer request has no physical segments by moving the call
blk_rq_nr_phys_segments() from virtblk_map_data() to virtio_queue_rq().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d038800474c2..74c3a48cd1e5 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -178,9 +178,6 @@ static int virtblk_map_data(struct blk_mq_hw_ctx *hctx, struct request *req,
 {
 	int err;
 
-	if (!blk_rq_nr_phys_segments(req))
-		return 0;
-
 	vbr->sg_table.sgl = vbr->sg;
 	err = sg_alloc_table_chained(&vbr->sg_table,
 				     blk_rq_nr_phys_segments(req),
@@ -303,7 +300,7 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct request *req = bd->rq;
 	struct virtblk_req *vbr = blk_mq_rq_to_pdu(req);
 	unsigned long flags;
-	int num;
+	int num = 0;
 	int qid = hctx->queue_num;
 	bool notify = false;
 	blk_status_t status;
@@ -315,10 +312,12 @@ static blk_status_t virtio_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(req);
 
-	num = virtblk_map_data(hctx, req, vbr);
-	if (unlikely(num < 0)) {
-		virtblk_cleanup_cmd(req);
-		return BLK_STS_RESOURCE;
+	if (blk_rq_nr_phys_segments(req)) {
+		num = virtblk_map_data(hctx, req, vbr);
+		if (unlikely(num < 0)) {
+			virtblk_cleanup_cmd(req);
+			return BLK_STS_RESOURCE;
+		}
 	}
 
 	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
-- 
2.29.0

