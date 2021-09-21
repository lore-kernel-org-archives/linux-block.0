Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58410C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F42D61131
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhIUJYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:24:16 -0400
Received: from mail-co1nam11on2053.outbound.protection.outlook.com ([40.107.220.53]:3937
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhIUJYP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:24:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgE7EC8j4LPhP6dSKag6SX77dJtEnP+d3VvFixevLQYH1aH8Y7kjjSQ8icyBqHUuRNmTv4KjsW5lwVb2uklAN2riDIW2yzgTRq/sfCDf7f5eAWfLpsS86Cyh/kbre34oDWGZhzZbHCq8zajRVwFUkmxKnqaIrf8p/a9h/mYpxbR5LiJowv3BVFIy0S4o4T36RBsqtZnKYanKwzjGkIJujFCaXeDTJdy0fOw0aP97vG7O0iumPp6CmJGudVABYrpNzq3ye3UPtNLwvJIelOIz5yERYNTdPn23i6JkUIUqs+i0wTQx2CqEGwEJLwxPejOFN1jQOXBoO4UFagJJMJs0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=o6jIC3QNLi8cmLPriTYoHfRE5LpuuqrBuDSAy+oYsQY=;
 b=IN4kbfW7P+lofPLYnexkhScmsAIfjP4m42iKSqW52ha5jWbfoAXd9dGhYZTBJCwWEvMwicKkwaHaUu4qpLVFla5h7YpnhXu/j/qJwACZkl/6Zpo+cY+JPoyy0N4oYNRFTG37OwcsWlYST/17/iFPmQ+444CZBZXsVyBoTXjO3yRgVBLhifLjKmERGLn1t5DfPPk90xuzkVq+BbApQuLIEAdzghwp5P05CLrsmULUWEtrz1rqjWk9frLLJixm59yNfj/ez6LlLSUYm+4eu1RQeK+okUOa+rNUT/dOLggk+VIiLrErajPIPw55mwLDA2BknHu1cVbEhlV9Seargn3wnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6jIC3QNLi8cmLPriTYoHfRE5LpuuqrBuDSAy+oYsQY=;
 b=AgnAvMf2Yx2ARszhzJBG54iSHkmpFxe4LVwF1q+TX6IyIIxwE18NrIsJ3OepdhR+xMVXpYqbCPSJiH7saCv57O2U5Mq9zCIbthUY8CX/Wn+WJb25DIBFoQ4370Ef5GQOU/GgZ7bn9exXRr0Cqhoep4CSZWdf/Q0/U1vFfz1lA0Pj/YkmjuCfI2lqrMpqGzlR+2GGMVB+2f3P4AfcCOaREfTWwBBmTd4eSS/yCa5IG8Ay8PYypcktEJ6J3Qmw6zyRmR3dfrTBtgpHgDhARVuc8a9Jf5w6WaiKwxqyVjKVVamnLeOJFjpbVtHhES5AzNKIpXCdBuGDdHkvE7SDbHWgWg==
Received: from CO1PR15CA0096.namprd15.prod.outlook.com (2603:10b6:101:21::16)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 09:22:46 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:21:cafe::40) by CO1PR15CA0096.outlook.office365.com
 (2603:10b6:101:21::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:22:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:22:45 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:45 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:44 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 7/8] loop: remove extra variable in lo_req_flush
Date:   Tue, 21 Sep 2021 02:21:22 -0700
Message-ID: <20210921092123.13632-8-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210921092123.13632-1-chaitanyak@nvidia.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ada2e52-2163-44a8-5ded-08d97ce15f64
X-MS-TrafficTypeDiagnostic: PH0PR12MB5403:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5403D917E9C7817874E415D2A3A19@PH0PR12MB5403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsq2nF4HNs2wypID9UgPAIfobbjOO8ezpa1LK2giFP51XhWG2R569StUmAYG0AwZu3+gXYd9Gdi76iTASHz1Vo6mc7/xk1ReORJbs9hpYbx/AVgiNAwbPWPm+qmW3QVf8lm8iK8TSThOC+oiZ/FwltpnDEYebDwO6dbuynBWft76mE7Z+5BmI5WoGlM7sXcgxC5rOHYS3zfPAaRbMe5OmuZ4l3MMBZKQdgrxo05sYXNxDUdeOyQ6IM5aHf1XOaMldjCVvvkT3wjhOHCGRrm6l6XO6qS99nOzCH71g/UKAdfRO0Dg2fGRhJUd01YC4w0JDOXj/9v1fbAxnbuETLO2GRatZWuhBVa3cvTaPctcHVLpclA2PujNTXBn6c9/MF1pX669C8uRHlMHfYzeywX3IlUahgVBCgGdU8JEMV/PcOXM60raTKIwqcNT2z3NdzHFeD9Zm3Ms4L5r+9snA2lWcHdX1L++8A/iEC3ObMn/O05s1FayQAzsqtCOCmGfvyRz4/QL2gkwM/fsdNadan/t/BtZf/wQDK0KJ2UUSN7m8dMSrDf4HI/ecbPVMD46Y5cftPSeohgDGODqISC1u7vMO/AGDzKyx0hLzwkASaq7j80VIDWgzjn8/h9bjKGHP+AvlFNR2ikCNCR9Npr5+Vk80bIMclCXM7P8dtYurryGLbKkpAvWkpQk1Rc5VGUqgnkIECdo+RkxpACk6NCJNslXog==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(2906002)(508600001)(47076005)(426003)(8936002)(70206006)(8676002)(36906005)(1076003)(83380400001)(316002)(82310400003)(6916009)(7636003)(107886003)(86362001)(4744005)(6666004)(186003)(16526019)(2616005)(4326008)(5660300002)(7696005)(70586007)(54906003)(36756003)(26005)(356005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:22:45.8515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ada2e52-2163-44a8-5ded-08d97ce15f64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

The local variable file is used to pass it to the vfs_fsync(). We can
get away with using lo->lo_backing_file instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 51c42788731a..6478d3b0dd2a 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -498,8 +498,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
-	struct file *file = lo->lo_backing_file;
-	int ret = vfs_fsync(file, 0);
+	int ret = vfs_fsync(lo->lo_backing_file, 0);
 	if (unlikely(ret && ret != -EINVAL))
 		ret = -EIO;
 
-- 
2.29.0

