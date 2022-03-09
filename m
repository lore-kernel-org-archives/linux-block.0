Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D904EC433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 22:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbiCIWDy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiCIWDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Mar 2022 17:03:50 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97858D683
        for <linux-block@vger.kernel.org>; Wed,  9 Mar 2022 14:02:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ubsc0FTULoXta9DxI4LZLoa5lqWfWh0HtZPOnZtxopMHmXuQ2VaC3ce13aoC9b5o+Ad6raL5F3olhY3u3fjH663drEU1YmJkyWUBCh2FI7VqJnlc0jaAaVhWdWMEx6G4/bcVuATfjLwukanyJaWl070QO0Zrt1q5JGN2AWEUb/VWaptLn44aL+Qmv2cQ/aXFG+Ma/XfQWrKHltwCSl3isY7mqYWDCsiaqVBOI6clyMbXg9jUZqI/2L00THXuHiCBm7Mgy0BkRqKG3jUUC6Dzyo1pIUXXzLzGw4c53eAqZsV+CS9HSnebBDksZDScV0Rwgc2RBDiLVH6QiQ6zyAcquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD2T2JuMi75Vy9SnTrKYE1czCS+deQtGbQ8zyg3tssU=;
 b=Kno1XrIjD2JexhKcJ7K4q9gxciOsb5TSS8abPUbXgf08XnuXPPMzj6Uxk7pRSmq2CWBCc+QekoPJqqZlYL7UC3BrIMpEIwIGQV6hM0zXjHG1CTNuYH19KV1Xx9aYBvs5MSf1sb8U7q05FJuL3irfghETNnUF7Zs9PUbyd2vhQXGcnBf0qmkjgCC3D/ITJ2F/n+VgacLL7jgM6SL1AOs84DcJZIt9udlp8cH0vTUVnnfNL6vAMe8k2XtDiOJP7iQOUcmx5T3Kz6uZ9m9GLzRloYCp47EXW8LDAu3EB+1q7+RWOydW6kHpHgaBJtyNXpZoodrKoiHEdRFheNJrxRNOvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD2T2JuMi75Vy9SnTrKYE1czCS+deQtGbQ8zyg3tssU=;
 b=MYylflmv75xqo7HWvq8Tb0EQQKpe4ZFapHyH+yvC+zIXzlMAFstMqFPXcz7Zo15jHUUAQs2+A2KnBXLtAkn4H2Le32Ok/TSmwbO9qYq++rhuoPOzM/fy6JIL1Svf0WZ9yXpuUta8E2S61wIFKarss77AvOwZe4InN1rZpMf6mt919xuEA2vRE2b+MAX7Fzwpyj4sfX/8U+LclleyDeAYzqxgvtOZEwCZKVr3afu5+ybZ+dkzh3YqgD04qv1vKt6YgyOD4DltncQB8sEGj6weo6CrPpUliGKSh6YwDDTDK7/eQTETnVmUB1Pt9BPiipKqoU18gfqz8pBowrlGZlXDxw==
Received: from CO2PR04CA0183.namprd04.prod.outlook.com (2603:10b6:104:5::13)
 by BN8PR12MB3026.namprd12.prod.outlook.com (2603:10b6:408:41::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:02:47 +0000
Received: from CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:5:cafe::3e) by CO2PR04CA0183.outlook.office365.com
 (2603:10b6:104:5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Wed, 9 Mar 2022 22:02:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT065.mail.protection.outlook.com (10.13.174.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 22:02:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 9 Mar
 2022 22:02:42 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 9 Mar 2022
 14:02:41 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <damien.lemoal@wdc.com>,
        <ming.lei@redhat.com>, <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 1/1] null-blk: replace deprecated ida_simple_xxx()
Date:   Wed, 9 Mar 2022 14:02:22 -0800
Message-ID: <20220309220222.20931-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309220222.20931-1-kch@nvidia.com>
References: <20220309220222.20931-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16cc603-d673-4140-dcd1-08da02188b79
X-MS-TrafficTypeDiagnostic: BN8PR12MB3026:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB302620A9F8F5C3A206CA5B93A30A9@BN8PR12MB3026.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cfRKf/b4XFO0wJnj69nTZbRFPGahYgwWsUAk0ypwGLmyyZKYV9NjxCUOEgHjF+m/B4erSW00Cr8SakUx2m+fVMNP1YhpWfNZKvs4az+cRTKOQ2CwAp+rLWVs59eI7abbwz0lakUN6MLmx/XYZJi8HH3VaHdPFRJ0UTDbHuUjy5hV8roEDSR5zxgJ9iwgSIudIh0irHAqxtAeEO/9GpZDU7Vde15xFaDutGthNmVQVTls4vP+MM2o3Iz3+BYxTjO0Gi6CBb0J+LXnmvhz7FtA5MWv9n6njbGq2nRfCkx0UlWTsswmnselWTqLp4jGnkUqlgsoN0PLRz1K2f0dPNIuY1R2EKuZ1nMZ5G9OE549OHxbhGYsqKqvoZwe39s0bhV+KJ6Q/1sAv6FYwLf4K2OLTJFohLPSqM+mo/DZsrErRrl639q304BY4WHfyFPjWFd5i3JguZBy3neErqIaEr+iVJUuUbPw57/kAXN50jgysTmR02W5wSoxXr9wCllE0H0xZbkpDRefsYumHmS9jXkgq7f/aUjW5AhgMB7WxaC75GnLri+lo5lZ0cPPhxQZNh4BdWmrsBWbhsNv+NK3PA95SbvdsLNJeCxoru3IOErdShtgxLCZ/+7BaswnvAUorUCidRz+iD7rLM0vqdY80B2yxy4Fl6lkn9qFu6Ynwz0l//Fl5m57uwQ2Zcz/aKTyPbtsrx7MzpZUiK0ktJ986uLV+A==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(2616005)(6916009)(81166007)(336012)(426003)(1076003)(4326008)(186003)(6666004)(36756003)(83380400001)(8676002)(356005)(16526019)(70206006)(70586007)(26005)(7696005)(40460700003)(508600001)(47076005)(36860700001)(316002)(8936002)(5660300002)(82310400004)(2906002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:02:46.7430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f16cc603-d673-4140-dcd1-08da02188b79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3026
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Like various places in kernel replace deprecated ida_simple_get() and
ida_simple_remove with ida_alloc() and ida_free().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e6623..e077be800606 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1724,7 +1724,7 @@ static void null_del_dev(struct nullb *nullb)
 
 	dev = nullb->dev;
 
-	ida_simple_remove(&nullb_indexes, nullb->index);
+	ida_free(&nullb_indexes, nullb->index);
 
 	list_del_init(&nullb->list);
 
@@ -2044,7 +2044,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
 	mutex_lock(&lock);
-	nullb->index = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
+	nullb->index = ida_alloc(&nullb_indexes, GFP_KERNEL);
 	dev->index = nullb->index;
 	mutex_unlock(&lock);
 
-- 
2.29.0

