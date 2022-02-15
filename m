Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66948C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiBOLwO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:52:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiBOLwN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:52:13 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F483985B0
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:52:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV+F/JJnO1HMfNKZgk4xNiwGdlrP/6i5G6nT7vqGhjweZrBlAJMQ5XmrUMJsbX8J9hchCDNwbjXSYAodZWxJuL/fvsHgIvjYRKUEUWc3NpwzFzvQ5rg/2n+s3utPbje2zLbTSBSCS46YvMjdySjtX6Ew6hQIi/rK5h/Rr7knpPd5BgAAbeDGeOnIV5Pq/4gxsdwnBdkmJXrY8wsNzWRhjvi+vHcZuMDxXOAdQTs0qFpe5oCR++7BlEXkCbodxE+FT73NSaLcv30T9jISqUANULqpTTReiciDManGr/ZBNFIjc6yFKS7dK73//4SS0hxTjDmCGRbpKqsD0ufG1kukBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZirCYQgO91Xa3Ta75VHvK+haR/Ieo9cvEFnC1t/Ya0k=;
 b=Ep1E/1KgorUD2gKm/hJNHM8UBnXuisOq5dYc5AL9F7qZQibahDXkCKBLDkeodoua5/ENAB0Z8JeZ1jnyW0L+aoNCWvV0OY32yy40qqNJtLY3rkGnzOO1l8lv/aWq+rR/Np92NwUiSBwjJFQDBogYwfyP7W/mz2kOJFzb2uQ8iOaHNItnSva7KMaJG7egtySAYfY57qYLPw/5URMfsRJ5J3IHWpeerfL3hCwc4GmSQKu+KK+dEkXylq1iLLtBEvCt+WCMLJB8r6wcil/xQvM2QFF80de55qefrDkf/JnIukJjRFOlU8DTyozOgkVz5MnCuxUzA+k8NJkG/3xmZTA9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZirCYQgO91Xa3Ta75VHvK+haR/Ieo9cvEFnC1t/Ya0k=;
 b=MlA4s2QfvCJ8aH8WgzmeOZ+BwhNSONWu2HZB7fFgVXxgc5F9EzYns2x4JTkpzAcFBXJz59jsI8mQvKndsTrgov85hcK1ijNBCQhSg3CcCO241k0LnmiZJkHe1+yLsu/xzpzihLxUjXkzsGmKP4wlAUSXB7Vay1vUFdqPRh/0gyzWr8ZFC186n5/8hBgaNyBz2/BZcDrhP4alHgz3tfSBL50/oXO8YFJzAqHQya/apX6nMm1RKi5D6WL+zyZGbd2Qz/tAPvHKDPSktKixOx48njSYgH1YbumP+8ViuVFU0R4/rTarg9ZleEJ3ZGrgBMQSTapQ92U1rl4CbuzV47NAPw==
Received: from DM5PR2201CA0014.namprd22.prod.outlook.com (2603:10b6:4:14::24)
 by CY4PR12MB1301.namprd12.prod.outlook.com (2603:10b6:903:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 11:52:02 +0000
Received: from DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::35) by DM5PR2201CA0014.outlook.office365.com
 (2603:10b6:4:14::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17 via Frontend
 Transport; Tue, 15 Feb 2022 11:52:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT021.mail.protection.outlook.com (10.13.173.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:52:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:51:59 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:51:58 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 4/4] loop: allow user to set the queue depth
Date:   Tue, 15 Feb 2022 03:51:04 -0800
Message-ID: <20220215115104.11429-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215115104.11429-1-kch@nvidia.com>
References: <20220215115104.11429-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa1065c7-2381-4e26-d2b6-08d9f0799476
X-MS-TrafficTypeDiagnostic: CY4PR12MB1301:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1301FEDC3D55400E35B16FDFA3349@CY4PR12MB1301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWjWKDtVjdiuJrBZ7W4ZDJqEPn6wQcJ+Ax+NN1U/PKDuWkS+3wGnFCIGegHmS1q+CewjQ+yoaOp3YDtrERqvuIXzeEYLwgQORmdyDE1k6N7yWbJ62/GaCXV/6NDvYmb4IKpw7MUzjHWuYoz0oubCVaBQIKz9k91Pl+TB1GwkiTqPIDAnU8njue48Ly/lkiqJ6oDPxj/1F3QJ78OVpZfDWkjVmERcX8l/7H76IHkhSAffNrVWPzcaJi7zQt+F9X6pt0RdOPcjQcUz5JTg94A33LJLOyWdtuN0FR8BIwSuyL1XKDlJLHpINIijpAGPoq6VfZqmmrwnfoUmX3YY2es4Xfd+TKe2tb38Swc6NDRrcWeyDNhouegTzXFDZ6TqQuJFyQvu5drCoU9NmDm8yI6bm/Vs8H4e4ILisB9heSqoXcF0nbRFilk2KnHIqxMaxT5aTLSUEL3MMbPyo+GgLAKldMyWQNreIzMt/4OWxZRHwcs/XF3C2kmJ+YJYCKsNw4fvJwd7H6pc0puApuBL+YNj2VM8OX8E0gK1jgtsBaqZZGaIBuSV00wDJ36pcnTQUp8Ft2dovOGVU2dsIw3AKf0b9OcygCURy8zOscDpF3t/xyN4sPfNFBhOyAc13qKFUyXsS6JCkYobdGgRLLze28MMqKK71zfHKx6I+i4MxytEWuj3n1ZYrZ5GPPYrq28HB+p4EOt89X33EujNfrxwnb8/ZA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(6916009)(54906003)(4326008)(8936002)(316002)(36756003)(36860700001)(508600001)(356005)(8676002)(70586007)(70206006)(81166007)(47076005)(2906002)(16526019)(40460700003)(336012)(6666004)(426003)(5660300002)(1076003)(7696005)(2616005)(83380400001)(186003)(26005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:52:02.0910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa1065c7-2381-4e26-d2b6-08d9f0799476
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1301
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of hardcoding queue depth allow user to set the hw queue depth
using module parameter. Set default value to 128 to retain the existing
behavior.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 18b30a56bfc4..fd2184d63c11 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1785,6 +1785,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static int hw_queue_depth = 128;
+module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -1979,7 +1982,7 @@ static int loop_add(int i)
 
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-- 
2.29.0

