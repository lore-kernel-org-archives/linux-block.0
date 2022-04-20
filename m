Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB95C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiDTEON (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEOM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:14:12 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C06167C3
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 21:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7zVBMjXxSQQb98rjkAzrACC0i6h1ZaOPRRkXjwtrW4sjFxLFORb042tyCCGRWbR5hT0le54Wy56UK0quOntFdCETucov/KvA/8F7L/J8pydbWukbUiizL+LwEE5Iryv4724DElE0/pPxFUKcaGEw2nD1lN9WMyZ1HbUoEXEjp3I+n9+EKmFgmosbMjUIuRaETQFaTC+M8hNdm7OFznf4chsItHGXf2+vgwlm1bGgZ+obEsFQ/gwJg427a+QJMQ683Sl6vaWLr6E5wtjsLZsD4RQ4eSgKbgxNwFxBOFCT5DWo7UhFrp3yUbQc0L7nC7AvwDzI8rJqvcG/ENDHUozrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDqO5AwzrUxvTPFHFvDsZOD4YFInJK1DvpkeDXPvFCk=;
 b=GMer6fPb1WrxGrzQNlnu8JULtsI3VqSeoP6Qi1fKfFY0rfJOtMHY6ybyWMZMjO3vCzWiAkf+PiRyuPonDnhVqN1aMdus/OiHv+q4Dao0a2+FsyRIXVBlF1Et3IcefhyfPrRIp6r87lf5qlfw+Krc6howfn8M36qrSke1RF+7LZRiTKvhZ4PAC2TCnuMAf6itIh8vsoL+dQwM9wTF+Gp5JYUdX2wu7G1aDLluH2eCBf6aSgAOdHlzwIzaTCGZO8OAW31P+w3qWO9uR6PmwvfoW5MF0xqBx6gb7g6ipNHwAvThFQjVQX++LHgN9DiWQNwDfu5EulgQK3MKeZ3Pyo9mGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDqO5AwzrUxvTPFHFvDsZOD4YFInJK1DvpkeDXPvFCk=;
 b=JuID19hsu0+0PLtLe7rnYMY2MOKrRsomO7dYguaICnqo6pRNGgQ5iPtI9e9FNm8QLbuYFYdo9yJpXpNzngiECgAgmw7TqnkQNvojyUd+DGc3/0ZCV8NiGsnuebyMXeahO2Y7MVipoFHslE/vC6aJ5fn4j3rkSIPT6pu3m0DxGkRd3x16po/r2d7q10I+plANybufhSmsREcjetrngma9n/zkEyMn+9Uymj3y3SQvnA4hi4+IMUsnZoLKZQd6vsA2WCqsfwKxixukHbXVB1Dj2tT+O+p+Y8dVqDbAod4HgTxNsNt/v0KAnBRoaVl3ec/EdKQx76RtpyA3EwfCYuJiFQ==
Received: from MW4P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::29)
 by DM6PR12MB2778.namprd12.prod.outlook.com (2603:10b6:5:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:11:27 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::f8) by MW4P223CA0024.outlook.office365.com
 (2603:10b6:303:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 04:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 04:11:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Apr
 2022 04:11:23 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 21:11:22 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] virtio-blk: don't add a new line
Date:   Tue, 19 Apr 2022 21:10:51 -0700
Message-ID: <20220420041053.7927-3-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: d8f92c97-9b6b-4bf9-ec03-08da2283d6b0
X-MS-TrafficTypeDiagnostic: DM6PR12MB2778:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2778A5AF5CCA022FF2754667A3F59@DM6PR12MB2778.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f/2KtcVSdN2exa7aI5dcG46zT3kxFKoCrCVe6gGqH7BwqYY/1kVTX7Q0n4RXHJOhN4b7JnHYWjf0S+P3WnSyhK9VlZchGhH4sSFvuQ3kgb5FBO/lkKDvwfrGnuW8mitNVyf5S8rbbk4mb0RyLar3fDI1hyttdXBCCVTPyYXIgbgFoWsDi7Rlhdc6RGpZu5Pfv4J3QfiL7fd+KPyaE5OIMlsaJDQ9bjz+cH4oUuPl9nm00fuO+L7Fjr6KaaLPQwx5C2DvzpsUEu2RnoEFiQ0TE+w72VBFq90hVD2SWBr9618cIZsJ6k+YESWXNCKGqw2EYiqg+eaeUwl9uUiowXoAxW1YcCDzEWM6XNo66UD2zW3sKHFf3Rd5sQ5ozFjetwJTyhJLYTkhsqpkMrvFSmE0eBlTohoZw5leH5Bon9y+jb97G3t6NxrUfEt5LrvpVRgpJgA50P0+TIQO5wVuBNnm+hKO0bZv6zFJ3mz7VwJqdKvc9Q4JvggPJmzWWuNwSruKd7RVmBmd+zpu/+mKS27aOC6DyRW9PnNIMngd4q8DKdV+Bl8+vvZTtG+uTQMqFwOU9tkuhmi/bY4e6cYDzRituQ4sMBrLDYtl8teUgaEXC9+vsnQO+p+25nGUamlPncyuInqsxn4yjiajkzT06W929CZDch5fsaORsz3hYhhOLqOaSIfI61D+oe4DxACTrJyMmmZj+HEEjAygsld/W1S0ZQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(4326008)(6666004)(8676002)(36860700001)(26005)(70206006)(70586007)(508600001)(82310400005)(316002)(110136005)(16526019)(336012)(47076005)(54906003)(426003)(107886003)(2906002)(36756003)(2616005)(40460700003)(186003)(83380400001)(81166007)(356005)(1076003)(5660300002)(8936002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:11:26.3231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f92c97-9b6b-4bf9-ec03-08da2283d6b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2778
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't split sector assignment line for REQ_OP_READ and REQ_OP_WRITE in
the virtblk_setup_cmd() which fits in one line perfectly.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b77711e73422..d038800474c2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -210,13 +210,11 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	switch (req_op(req)) {
 	case REQ_OP_READ:
 		type = VIRTIO_BLK_T_IN;
-		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
-						      blk_rq_pos(req));
+		vbr->out_hdr.sector = cpu_to_virtio64(vdev, blk_rq_pos(req));
 		break;
 	case REQ_OP_WRITE:
 		type = VIRTIO_BLK_T_OUT;
-		vbr->out_hdr.sector = cpu_to_virtio64(vdev,
-						      blk_rq_pos(req));
+		vbr->out_hdr.sector = cpu_to_virtio64(vdev, blk_rq_pos(req));
 		break;
 	case REQ_OP_FLUSH:
 		type = VIRTIO_BLK_T_FLUSH;
-- 
2.29.0

