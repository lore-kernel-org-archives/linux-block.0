Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF528C433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B244B6115A
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238840AbhIWBwk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:52:40 -0400
Received: from mail-bn7nam10on2071.outbound.protection.outlook.com ([40.107.92.71]:14915
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238817AbhIWBwk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:52:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz6twmDyXU4O6r3nY3X2aq82o1mE1GpBZnpIshXQsqmmL1w4Fnl6jNOfmtaQOMy4P2+hY469li0drGvSHOyUtCW7VGRnm71msLSMhJenV7grjLItBS4M1Dtc0VqJlqW9wlXSZ+wVJV6iAv6UPhawITMQnEsdRFQMHIY4Ju4of+7IyCWIDoQBJ1W9sjvjTDe8InY8MjsoZmBs62u0X8VNL6Tqfm8HDxt1pLxYSaku2nGflOZm3Ag+rECfMO2Xq/OBf4plWMODKKKAJPRgNCkUsmm7m79Rplmn3WbhWWDChIu/SYOvBLOapcBl46J7W3Ckw68XkTm+AImorRHBSFxZ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3KvSj+h078RU2g6dCUQIzA4y1ESajFKmU8Vl9gMI4d8=;
 b=OLtnv2nlfTG10t7AEqVTInT5EBkHfobK3ZFSkv9f41PRpte87PJ4my9mw3Rcd3b7KNKGpvrldnFxX1UqQRLHlLgr60QNVWUH3UsY0NNmMDVkQpMvPVQSu1GaHmqAb7a58tvkQfLaG9T8vvZCzMpr0U+feuX514styX6q89ubyaB1Zj25iG0w+Y5WR/hv4hnoHRt3uWJ2N1odZx5ktVvb+jwtizYUcCOOpU9nwgGVdcsqtl9V6axavSZd41fu0d5RVvQa3V1Q1BWaqw9ZmEN9DKS02nmAngqeVYgbDk8Mk7hcjOn3xYmMiXV2jdBvwAVTxO4wgELZX+QDjjhMWrZ3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KvSj+h078RU2g6dCUQIzA4y1ESajFKmU8Vl9gMI4d8=;
 b=FRnrTEcXq9Dd+K+3dUPiVCiHwvDLnpeFVt5+0s/BYa09e1GLGM55FTkWN+IS5LX0cid1fcxHe1Qy1s+xx0DAmpF83fiZd3F+xVLSxzIrEYgMVzzkuW0DiGAUhhmhFQMoZkL2Fkthg2g56zA7Kd/Q2wo3tPOk8HSvpNQa0YhRPc6lMbKP/KZsGOihLatA7R642etsfV2NGrXxSFgpRph0GXd1wQExJl3CC+TiX2See37GB5rSFETQf/I57hKlId2V1/JT13WIfLacXKf57iUMLbsZYC3fhf5uje06lxgt2hlojbPCQ4KvQnK74OcqLQWWGA9FtRFSFIjA9qo7U2vlow==
Received: from DM6PR18CA0029.namprd18.prod.outlook.com (2603:10b6:5:15b::42)
 by CH2PR12MB4024.namprd12.prod.outlook.com (2603:10b6:610:2a::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 01:51:08 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::fa) by DM6PR18CA0029.outlook.office365.com
 (2603:10b6:5:15b::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Thu, 23 Sep 2021 01:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:51:08 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 22 Sep
 2021 18:51:07 -0700
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:51:06 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 7/8] loop: remove extra variable in lo_req_flush
Date:   Wed, 22 Sep 2021 18:49:44 -0700
Message-ID: <20210923014945.6229-8-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe73300c-50fe-46eb-f3ae-08d97e349cb6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4024:
X-Microsoft-Antispam-PRVS: <CH2PR12MB402470CDACF1B09F48E7FDD8A3A39@CH2PR12MB4024.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JZCXc/7fPoIhLZORiY6ayw3XHttsRzjIUfcc+u13z4qPKcDBwxIf7yO89E9mwniLtESsR0nKYK5pq/PQcb9XoZttS+hi31N81TaGUvL4rqROUgmeU/T5aeEghLCaMEf0+cYd0h+eE3GxwAf027GpE6Hbi/XKwOlxeYcpMepAICYZ/aDTEqHNeuHj8pOfbfKOMnVzjfsdIFuZFPUBSp+yIyHf35Zg+ALeojlekArhskkc5BxsWjtF7Ojn2wN/My012TPzbud8V4gOEnmEFedtdF9T+IlCcq4COmOehQ4/E73m+tLrhLTyl3UmatHY/v6I8FPTGevrF9SaB51rZA6fo6sl8uKc4zpE7dxCESsKvRw3QEK6Y1JYqSNr/irlVdvij91fBOOvc5HqIraNUdnCFkBzolIpHdoxgonw6kNt/6olppS4123gQZ3e4lz1b0F8S2zLJ9FIazWEIs34C/bQ83fYxtWaCIVDFEPdP6v44QmmOkLQjLCWbcT7Q37y51isaJbmVoWbRmMDylRIpvDdgcZzz2JSGuXzO+AloPL/9zw/XwFyhn1XZ3MVX3YGaMEO6VYqk/9rABuFdPUEDajMhK2zKB5p6GmxEpQQZ3Cqrpfu9Pg+xRcjME/ebhynjVIDMn4lUUghnOCZ56QpJP1dHxtxVTiJw/vtMxEPgJZDbPvjvdQRRKEKUXq4PM/qMphYVmT96rgcga40scZmLM3zPQ==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(83380400001)(2616005)(86362001)(82310400003)(36860700001)(2906002)(16526019)(4744005)(5660300002)(508600001)(4326008)(1076003)(70586007)(426003)(8936002)(6666004)(8676002)(316002)(186003)(6916009)(7696005)(7636003)(47076005)(54906003)(356005)(36756003)(70206006)(336012)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:51:08.1171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe73300c-50fe-46eb-f3ae-08d97e349cb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4024
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

The local variable file is used to pass it to the vfs_fsync(). We can
get away with using lo->lo_backing_file instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
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

