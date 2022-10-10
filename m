Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0CC433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJJRBa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJJRB2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:01:28 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A32BD3
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:01:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEuUXVM+058Exstjx14rZcN9h2gbjL/Dy2lWNI5UdS6QVc81Uh9jlYRSMCqS+Rv624O0MzYdSUC/dIbrNp1bDoxGbd+rb4Ma36BpQUnO/itIqjmu5jIDfHUO6nEP1aA9oBb4sLswDP7m+UNRb8IRuNV0lj971f8FmdkB+KV9bySoSTbdFhHuEWarZ2U99GtmyHQ/DcQlFna2cLlWcwP7HC0MkD5mTCcrek6TAdtzDWx5MnvqZ61Vp4Pl3FrUWLEKENIoM/kdFFR1i5oio8DOjLaGZIXlcqafCY7/oA0cBXbFUzUmHVHCnqXEGuOqseWg7qjGa0CIfyYMEnTawI/rBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EaUozEY/eysVdgrkNyJBIgddP6G1EQqtY8ZNOZKR5no=;
 b=jxtPU3ccRLRaE1sL4VMTEXB01XUFRSxGfXCV6E4TeGIdj3wby28Q1wSyeF75f5jBhcTAHVXku1PH0d63SQ8K6cKW694AuGmmVis+CSG6LU1iBmuLwKknGdpfFZhJcuUwk3D8+s2msqWkBlcDPg52YhyRWARxIkLVfmLycuCG4UXg2N5yUydceT2iQ80TZ+pjwujLytPzBn+4Le85wBF1iaOrAoMFmBAxHgosncWXkiuCkZp8nThj7A3wXumAr+1/QgqYBRpgDUP4IB19a9FlaCF2dbWYsVF/32z7fP3C68gqw8WsBvdDSlsxsgOn77xKMWXqF7tIFgCVLR37wApi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EaUozEY/eysVdgrkNyJBIgddP6G1EQqtY8ZNOZKR5no=;
 b=T324NJyeYpjOXXrb0iJBaM9MSd2dy3Hhv/U/AUBlZYaO/c/w3Qm4+EXvrqDYvn2XIxbrQh2yFP1W5pIESxM1+TwVSZ5Nu82jC/MguZTdfZvvpTpyMdxelTbGUhGYP+5ev62PLvKpNw6b751BxseG5CN/iGgvn2kW/zElYWTJdHUbijZm+BXQxfo2wOvtcYmlMAZFtjrt0Cf5fL8RLgVnQeQclBk8AGgmYrs2Q2i2rQrHLFn9rxK8YUQmlHypvUvWU7Nqp5XpC/ULlNEmZlC4TgzQFNLX1D3F3voWArJGpfbtKuXoeiKGt8ylELcXcanerxQtznWyERP/JAHPWs+0og==
Received: from DM6PR02CA0139.namprd02.prod.outlook.com (2603:10b6:5:332::6) by
 MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.36; Mon, 10 Oct 2022 17:01:23 +0000
Received: from CY4PEPF0000B8EF.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::ae) by DM6PR02CA0139.outlook.office365.com
 (2603:10b6:5:332::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 17:01:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8EF.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.13 via Frontend Transport; Mon, 10 Oct 2022 17:01:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:01:06 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:01:05 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 2/6] nbd: use init alloc tagset helper
Date:   Mon, 10 Oct 2022 10:00:22 -0700
Message-ID: <20221010170026.49808-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221010170026.49808-1-kch@nvidia.com>
References: <20221010170026.49808-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EF:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a8540d-a81f-4c2e-c5d6-08daaae10f72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPp8TMl7FkJnTkDYklw3KGJ+ytEyHi1eDIvcZmCJpnYwT6ZOBarpfDpzIggF78PrRcqMzEBsrK09HyALe+9qz1M/H54Svu2Bwjh8Z11iAXKzuexMFESQKVXlwEFowArhLd2jlndmLwnoPUiEvoWH0l6Q0wW7x5kEa52P+WjUPbIqAvbE/WaVycqqUqzZQ25Zpd+Y7EAIsrhhEe1YM2xQTm6vI0C6AZCrCb0wfK83Jvn177dWTpobvzuIuj9cu5KVHRbuCNHJAa+IeYpyHVZSwsJLZfDd7tI/M06g37p4DoZqSX8UO+nA9exDuiMCH3qddQRFi8RIVfqNcLvSWDqxROWvYlk/+QesyOtiJY34WmazjkZk1r7BexGXJyxlWLa+xEEirKAE5D1Jvxkk6PkH90TuKnmJTzQUbVWaiZ0vajJEUurMOdwEC5N3VJZPddu4kl6Mbo1k748z+47OIwwLE2xb3UjAcOkurPFlirZa4Zx8hZn5bk993ohbZ6Je3BoUOnBeSKTuY6ASFzIqezVvXuP1ZvXSv8959WubpddTBF21y41PFUJo2G8l9D15oihSvigcwZoujc26cvy4nXhs+Bc7eOTZaU4V0aMQRR+m+Hjiz/fFqbegYsfIWl7XaI3bwlb6MdfXs5acpU44j2vKf1MtM7WpdzaxKKdHyClZ5lS/pm5yRnCVvvEasTRes+IS65Q4THGk1EG9dvwUEefhvCxx5l3JmtV4oad2asrObb7FBrI/f7qDHGyUDJnDdBZfJotPr8EsGWZ9k0JS+u6uhw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(336012)(356005)(7636003)(16526019)(2616005)(426003)(186003)(1076003)(4744005)(82740400003)(26005)(5660300002)(41300700001)(70206006)(2906002)(40460700003)(40480700001)(54906003)(8936002)(36860700001)(7696005)(478600001)(4326008)(8676002)(6666004)(70586007)(82310400005)(316002)(6916009)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:01:22.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a8540d-a81f-4c2e-c5d6-08daaae10f72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/nbd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2a2a1d996a57..7a304812c280 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1749,18 +1749,15 @@ static struct nbd_device *nbd_dev_add(int index, unsigned int refs)
 	if (!nbd)
 		goto out;
 
-	nbd->tag_set.ops = &nbd_mq_ops;
-	nbd->tag_set.nr_hw_queues = 1;
-	nbd->tag_set.queue_depth = 128;
 	nbd->tag_set.numa_node = NUMA_NO_NODE;
 	nbd->tag_set.cmd_size = sizeof(struct nbd_cmd);
 	nbd->tag_set.flags = BLK_MQ_F_SHOULD_MERGE |
 		BLK_MQ_F_BLOCKING;
-	nbd->tag_set.driver_data = nbd;
 	INIT_WORK(&nbd->remove_work, nbd_dev_remove_work);
 	nbd->backend = NULL;
 
-	err = blk_mq_alloc_tag_set(&nbd->tag_set);
+	err = blk_mq_init_alloc_tag_set(&nbd->tag_set, &nbd_mq_ops, 1, 128,
+					nbd);
 	if (err)
 		goto out_free_nbd;
 
-- 
2.29.0

