Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFC5C433F5
	for <linux-block@archiver.kernel.org>; Wed, 20 Apr 2022 04:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiDTEOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 00:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEOG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 00:14:06 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2076.outbound.protection.outlook.com [40.107.100.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A400167E8
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 21:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S5o1z5GeAor0ho7nk/9i4fMMQjElA+kL2PfRu4LNdaoHTP0eh1W+MseG6E/aR3FDsKBUyUZLG1ivudOX6RzNA8kxlaG68iC8a5b8zWRgO3p/rHfpLRsQNCmdYwD7Tdzc5batpXWr+eilEe/CNWfKZjbq9GXAvad2n5Ei6ly9MXvcRkMmSZ1ZzgMDBEinzSlPhqje8vPAJ01ivEvyYQFpoo/4rFqP8Zp7gdYJg+gsf+2WKBI8hkhAAJsm9lopbC/CLUInqGMasg8V/8sV0uO7HOPXSc98SamXiA5TQylY0FnEA54063VCE7Zid8SAGLeBodwFGi8VkzvIgYTmpkZ5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sf2OpQbVTQ8RZLwUAVXaE9Kt6IaF45WsAt/7cpPJfl4=;
 b=HJ5an3ox8MfMyAFGdMO2EKExoM2ZfzcXU3LN1iKvPaam+mjs+vBdpfm8weOdCadlErW04c8EZ/IIioB5/HFMA5LlgsYBWR6pn0mGxBGYwzdtxMQQAfZr8WdReJOIPQbynLWNMFOtRLPFodTM4B5wclu8E6C1aH7ziIfjrtfBa3Y3V352FOZOSL25euom6Y34pQo0bmoP2r04Uyn+TZt9TnS5OCtRSOo1UGkSQPPvnpDYWFLoDNPHbZuRyo1A3upnjb/rCkZ9tgHrwDXblpy7eUfx3t9y4FGeLfInAD6x6AiyTSqBO7OiyxWcCFIHGOtF5HgDAP09BGVuvO8AvtE2tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf2OpQbVTQ8RZLwUAVXaE9Kt6IaF45WsAt/7cpPJfl4=;
 b=pQ28YKMxrY0jTpLLc5+0xlkb/TE2y6mUYR1pIZUadE9xURo1p2mO/JAINCsna9VJcqh80qMvcmBXQV1ybAfjYJnWTRFjD3J0S8bVBlz684p06QRT9jGLexY4KM9Wi/CM2tEnNPZS8pE6Rxb/k4q4tWjqNEmz9eRh+mBzHwtvxVEmVisYn7fcMSFnWthpk5TEhzFaeemERQ7oFz29dz0KjmxMcH7FAxpd0azW3V9/E1SBPtZDqpvCkrl29Ss2N28kuSuxJWZfcDiZVqnvt8ADMHY7oC6d6/0decSZvYf7tiJUl0Lh6dOJRqiW4C9w3wSiZ3yEoagpYOZUuAvztJqIyA==
Received: from MW4PR02CA0015.namprd02.prod.outlook.com (2603:10b6:303:16d::6)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 04:11:19 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::a3) by MW4PR02CA0015.outlook.office365.com
 (2603:10b6:303:16d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Wed, 20 Apr 2022 04:11:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Wed, 20 Apr 2022 04:11:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 20 Apr
 2022 04:11:11 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 19 Apr
 2022 21:11:10 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>, <pbonzini@redhat.com>,
        <stefanha@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/4] virtio-blk: remove additional check in fast path
Date:   Tue, 19 Apr 2022 21:10:50 -0700
Message-ID: <20220420041053.7927-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c8e791b8-a9d1-4343-34c5-08da2283d20b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4277:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB42770BDC5B05BAA9B95E1892A3F59@CH2PR12MB4277.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97G4+Nv2o2ETXyryL43avsbtJbsj/rn1JwT9BfCgwhXvq9Crn+euBbp/mYFL9y/m6NyxZPpkMGYdKOMBgpR7yPwL4m799zERkhVaFC4CuzwQbFGTFWpLoiHmUDnNKs6Iv4Ozv7cae1BqiMZ4W1MqDmrgaxopGtxM4Gtqfm6xrNwxq6H2SQyPwUd8vTl6nBo4TZw3fGQqTgcJlC5ERYPBoX1EEVJrv44AwyVsiA6oU/VBIkaFxxSosLhDqaa0mE/GikzA67K+HF0yW4ch7TYOVd0WA3RZIN+sAdstAJc9izoV/gX/eMmrGEgxbrv3tFzq20ZhL4J2xTDIrMqGZYbUmO3XorPKcghid28LLbr94bovJ4KqA/b3Xt/eQp2aDNngS+BKm8z5d++AuIJ3PTMSEFqPAIX0x0gnmC5HXBJg42Wn22dJ2lHuUiwlk8VjbS6MSOn7BSdeBU/oDGfyPNgrjsKUFqLxkeyfEzJblxYXLhj4iQKK7kitqv4dKmdnZ9reAFOejBEJPYREipD5zzbDFQUZI9tXJfwGgpPtVtImG+3FHq6R1t+/G6/tX/kL1z5Wu1LR9YuFAdMyy/kX/Hdo8P8w3RJrlcSIayBFD0g7B11XeCmE3I+TWjGc1dug1x+M6Sd+p1eFYzAlcedMWsbybP401Wj6aGMwsVRnzIXl09rII0/xYAZwlDVFR/7W0Axb1mAgKJsefMNu5Vapn07UDg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(110136005)(54906003)(1076003)(70206006)(82310400005)(508600001)(70586007)(40460700003)(316002)(4326008)(81166007)(5660300002)(47076005)(356005)(336012)(36860700001)(426003)(83380400001)(186003)(16526019)(8676002)(107886003)(26005)(8936002)(6666004)(7696005)(2906002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 04:11:18.5106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e791b8-a9d1-4343-34c5-08da2283d20b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function virtblk_setup_cmd() calls
virtblk_setup_discard_write_zeroes() once we process the block layer
request operation setup in the switch. Even though it saves duplicate
call for REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES it adds additional check
in the fast path that is redundent since we already have a switch case
for both REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES.

Move the call virtblk_setup_discard_write_zeroes() into switch case
label of REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES and avoid duplicate
branch in the fast path.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/virtio_blk.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6ccf15253dee..b77711e73422 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -223,10 +223,14 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 		break;
 	case REQ_OP_DISCARD:
 		type = VIRTIO_BLK_T_DISCARD;
+		if (virtblk_setup_discard_write_zeroes(req, unmap))
+			return BLK_STS_RESOURCE;
 		break;
 	case REQ_OP_WRITE_ZEROES:
 		type = VIRTIO_BLK_T_WRITE_ZEROES;
 		unmap = !(req->cmd_flags & REQ_NOUNMAP);
+		if (virtblk_setup_discard_write_zeroes(req, unmap))
+			return BLK_STS_RESOURCE;
 		break;
 	case REQ_OP_DRV_IN:
 		type = VIRTIO_BLK_T_GET_ID;
@@ -239,11 +243,6 @@ static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
 	vbr->out_hdr.type = cpu_to_virtio32(vdev, type);
 	vbr->out_hdr.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
 
-	if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES) {
-		if (virtblk_setup_discard_write_zeroes(req, unmap))
-			return BLK_STS_RESOURCE;
-	}
-
 	return 0;
 }
 
-- 
2.29.0

