Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A49C433ED
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 13:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FE6613AE
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 13:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhDENUZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 09:20:25 -0400
Received: from mail-dm3nam07on2049.outbound.protection.outlook.com ([40.107.95.49]:45000
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232694AbhDENUY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Apr 2021 09:20:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axPlif6P/YbJKkUaqK+yEdlmAJY4Y2L9kgLbanO5dbeaaOMCQnJqjkUyAIQ2RjY7ZUYxXqcLJspNkEqyX9TqxVSUCs5xea+RMkum6WIWZK8f9Qb4fd5RS6StFMdapNVm4RjGM2ysBIOEVTmO/02dJgf+ihVJmHzyhtjMTJQYXbyJM2VBmD7NJ1oLoqKVkn8/bcLNnKpDLKynCjeECy2B5F9X0BsDKR94tabkJh1iXh41Gxhvyru5gTtHCnggofjpeJlOv/tF4HNFBVDqQCeLpMwmjb9fwLavvjOw9YU6rhZn6WOJCKTfK33jbjdQIijcH7cNYqKZK9r97cYfKcg9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to0N8QFexrmupZi8CX3TpuFBC9JIrfSfEhsEtL1Dnv8=;
 b=NohcdLVUDsDmzGxy+62Xk4FlDYqQ064F8e/XFQwV34+KISJAZ/zJFtMsXmHI6RZLhRKgW+kagCoqINrLF5pY1d/8maXO1ZUq35oNikhM0f2VbynwURKgNBat0L9V6IWuQFXL7/ENKiKYJFrBdtwzQi+OgdLhXZNl1nXGH9kcKqmF6mSHVQj/uPYBAMydkS9MesfDNJbepsBsmsuak1IOsl6OCORMUrvH0BE8KJlNtvZoxBLMob4yvSTffUTNHvSg+qsr0l++9Ro+FRiK5haQnQ+9cCyzM1x7iRoy2uvI/aVOWhgDSuM7vc7uUoNVcSv7bHFJwtUl8H56d1raswehZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to0N8QFexrmupZi8CX3TpuFBC9JIrfSfEhsEtL1Dnv8=;
 b=WpxzIYZl1hnlDCIEztAJIBXkIxXvtJWX1PM2ol9ed0nhPq1gNHTLdv0PeF3bC7r1kGIUR7CSiFv+uMyU0jeUmRoQj/OjqVTclmQcxMJBQv6rW3KzsR99jsxkq+fjG8AR/Wgq1W/1Rqjptb6RO2IY5TpAGFrjw9sDFi2oLsaNAkUkQbcV4SrA3d/CHDGgwAb5/WfhK0H4zndlDXKEZtOUDwCFc/dEkLAqyOmHfxlt4kJZ2NDn54HaZJbP6MwEuVef1aqp/DjJbvsaZFMGSQl/NkSN3rfVyGWnLVd2eXQ0JWsT3saXo/Z8zqkaS7CUHVulTMEFAVil89TBClL4y8jiIA==
Received: from MW2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:907::44) by
 MW2PR12MB4684.namprd12.prod.outlook.com (2603:10b6:302:13::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.29; Mon, 5 Apr 2021 13:20:16 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::50) by MW2PR16CA0031.outlook.office365.com
 (2603:10b6:907::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26 via Frontend
 Transport; Mon, 5 Apr 2021 13:20:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Mon, 5 Apr 2021 13:20:16 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Apr
 2021 13:20:15 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 5 Apr 2021 13:20:14 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <martin.petersen@oracle.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] block: add sysfs entry for virt boundary mask
Date:   Mon, 5 Apr 2021 13:20:12 +0000
Message-ID: <20210405132012.12504-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4311ec4-abb8-4130-c2cd-08d8f8358d68
X-MS-TrafficTypeDiagnostic: MW2PR12MB4684:
X-Microsoft-Antispam-PRVS: <MW2PR12MB4684479D4F98B5511ECB89CCDE779@MW2PR12MB4684.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UuqOPyDebyn9RTXDf1BpK6FXOfbmDgi/Q0Zr1hKhxaAoPDNIpp7PPrO3uKidJPmjNpynyI3uiW5xZwRHldavHXQaZYPSu40+mWxIzjoyft8JJNTDTQWuJonKc/JUV+6vGMPqoFvxYaxoBpdZGxUMQP0SeRFYRhvRCNnJxGH6oYzskZ7RGv6F7Po8iQp3GSaMeX0dQXFTUPx5+id9/awG3OGKVKTr+haT6JBbfPqfn1b+AVfBnOGyCgDvrb/feyqY3pRXL5rgjWWC8MkM4MCXdlyNpfWOIrESUXOJT6H3blqlI5iLMD6+6zNK7LJDhhAQ2uN9K/FiFNB6PxEpb5r6UFztzbLVeYmpDnP/jZnjx2FKFyLXJIO3jB/kmTQYlKsd+AB0XKL6v9hOzm9QNdvp3wi/dAPaiZ35xEh3HDE1ZWlrtaLtjccWHuXrTdPHEU1LcOraxzcg/olYqqR87e4h1S2g5J/0sVFcFLXAxKcGhVgq1eUtzGqf3yaNPdn2DwrBRRZY0aQ4+9SNfyjAQvLLVov94fJB6W/iTZCJPP5UGNoiuc6kDmJbbAt+JYPhnN96Eb1jYHFpGhyWkmwM+lbWp8LayxfmwRWOz9wIlWD1wAnTafR+OmTiTI1xj7I4fYR2g849gkBVeZunYEOgtkBlDg==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(478600001)(316002)(2906002)(36756003)(1076003)(82740400003)(83380400001)(4326008)(8936002)(2616005)(36906005)(336012)(47076005)(5660300002)(426003)(82310400003)(356005)(110136005)(8676002)(70206006)(86362001)(26005)(36860700001)(54906003)(107886003)(70586007)(186003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2021 13:20:16.1264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4311ec4-abb8-4130-c2cd-08d8f8358d68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4684
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This entry will expose the bio vector alignment mask for a specific
block device.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 block/blk-sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 0f4f0c8a7825..86a545e6d82d 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -264,6 +264,11 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
 	return queue_var_show(max_hw_sectors_kb, (page));
 }
 
+static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page)
+{
+	return queue_var_show(q->limits.virt_boundary_mask, (page));
+}
+
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
 static ssize_t								\
 queue_##name##_show(struct request_queue *q, char *page)		\
@@ -610,6 +615,7 @@ QUEUE_RO_ENTRY(queue_fua, "fua");
 QUEUE_RO_ENTRY(queue_dax, "dax");
 QUEUE_RW_ENTRY(queue_io_timeout, "io_timeout");
 QUEUE_RW_ENTRY(queue_wb_lat, "wbt_lat_usec");
+QUEUE_RO_ENTRY(queue_virt_boundary_mask, "virt_boundary_mask");
 
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 QUEUE_RW_ENTRY(blk_throtl_sample_time, "throttle_sample_time");
@@ -670,6 +676,7 @@ static struct attribute *queue_attrs[] = {
 #ifdef CONFIG_BLK_DEV_THROTTLING_LOW
 	&blk_throtl_sample_time_entry.attr,
 #endif
+	&queue_virt_boundary_mask_entry.attr,
 	NULL,
 };
 
-- 
2.25.4

