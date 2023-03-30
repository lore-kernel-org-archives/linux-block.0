Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA3FC74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjC3Fxj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjC3Fxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:53:37 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12B85B8E
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGrcROSnJpcD7ckDzM5OFeVvAYINmOn7UxazVFYcjfxqxgAJKkx4iaygfHtpGimtHKX+P7KzQFglBOmkTQV6n5pPX2TEZuRO752aor8efDyH9QrawbRO3WEM+0u6xZ2XUTJaBOWxOmbsEiRn81b+BUo2v7nDNQv3MPA7Lw8mOaXcpk8/naA1sE/PF3POndVKfk3RWXfvg8ny8fU3laprl/y+d7sKsswgC+Hnce9yzmJbL3Yjca/+cKWgIJZsR8XPxqgOHW9/vGEFFRR4JCD9NklgXtX0tKRCSL6bNaykdjMKRCLZZiWr0qHHizaystzjtryfTXBpdk5aCxeM+23sYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0k8xp7R7h3I2FMVIW/rtUk+G3sJrYQqOyYYmN5ZpQb0=;
 b=QMef/poC9LEWjZ36TAunEy+raBhBHYiklRttTJP8HlT+U6VCQ2xT7tBPIdnUPY6BUAhOA1BeoMzuRmKaXtk9DhvYhAysSXjzbNiYTFmIZyjn9vL3mDK0TvySqBt9r47nbpXSqxylXNn8VeZQISZcSAcOSFazN+ACLEdMltPN7aTglYBTbe+6vAz9klmcm3pEVQyYxVAsoLqiLfYKcsEFjbeikEaX0o08ppzDqWWHxe+NR4IBCOa2Zpepdsm9Xs9bSzNpHaFd35xhYernLMfbM015iPHyVW+dVUjUgoJicOtKDiH7HlewQe017uNn1YoBZmSlEZ2XsTlbXPhNgyT6UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0k8xp7R7h3I2FMVIW/rtUk+G3sJrYQqOyYYmN5ZpQb0=;
 b=pv3Ee5ZPnUXHzG6E8Z3qNkVhsHo9KgwZOfde+Vke8BaKw/N5E5hjKy0bpbU2b4mY8IHnZkA/snnGSa+eAankMA2L3OKI0PVLbMMq4mP5TtcRJDTdiu3uCLdO03Kz7XeXE/FWw1MxXQSYT6i6YXOlIcd9wiXtltqgH63bxuFY19egMFa4bq5LOWpEIsVuQ1Y0pbnH6ItytDwxzTthrvq5F/I7uJRVZXoDM0WruoVN1noKgMy1xRjjLYoMzROFtYR7lcpEkF+QJtHwHdf2fUsRWIn0Hqiam2Xat6j5f9XzMFmzu0PD5R0NJCKyvZOPpZ9NiinpKQidyJ4O3CLmzlvgvg==
Received: from BL1PR13CA0126.namprd13.prod.outlook.com (2603:10b6:208:2bb::11)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 05:53:35 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::3c) by BL1PR13CA0126.outlook.office365.com
 (2603:10b6:208:2bb::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 05:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:53:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:53:19 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:53:18 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 6/9] null_blk: check for valid max_sectors value
Date:   Wed, 29 Mar 2023 22:52:00 -0700
Message-ID: <20230330055203.43064-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: 00151d83-0153-435c-791b-08db30e319ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YGOg2I4Ie2BGFVat5ygMpokFIj7drthEqgL2w8ate7YMfthxYiHgMnzJpRhihf9qUEgLxgOZ4sszIY4mwNalJCQ05JpvHdgsATb0YIoJnhRCw787PM8rAQ6aNRUOBW/edjNa8f0m3xTk9iZXllWr4GUfR3W/Gke/A191mOkVGlvnwdN+fl9p/p2paTW8GBYiUlbiJKyROBgsWnDvP7AA838VJtcUi1fo28uRCG8qtXXrGR6NzOYPuplXdwKF8T7Cz7yEKJZ0JnUlQ1/BHIQiNy+s3L8BVD9sxGThx8pe66OFlweLWa7b7Y8rAcrN15KAn6IMtOVZs+YM8pJW1Ju7PMcW87D/3Q1/ax5OxUJ1tyQF46AI2HJhVK6yWRNUzPEweRhRnReaAB0ASpsRNjFJ1dhxz+IUhhTweqZXsyxVyJe2XLcOTCgu6i0dUIyEuATDfjvv2yYe1tMj8IQc0Tpgeb9HO/N2kZ7PX/oajv9m4LZP7HbPH8ZasxFIIZonTrDW5QdfVlFPwG0KpfL6iKUjaRxgX5R4ClLW1bbSYMWtpGpiqGap4T0sKVMI8GKvWJOPsSPuqd0njY4Zeog9p4KJigcmZq5DyxnlYcEYF2wT7BcwawfJaPgMYaHuM1vrZsMOJTlw+tWBv3oML/4UIK9dReWbbvrxK3gX2+zVg2CkyTgFZBcLcajUvazmBsGPvmESI6LGNGUC9kRMXf59JFUlGgSout6TXu+1sGhTWONXQDX6a1qzriNI+aSxYq+IqMMz
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(396003)(451199021)(40470700004)(46966006)(36840700001)(336012)(47076005)(2616005)(426003)(82310400005)(83380400001)(36860700001)(1076003)(7696005)(478600001)(16526019)(316002)(186003)(54906003)(26005)(6666004)(2906002)(5660300002)(40460700003)(36756003)(7636003)(8936002)(6916009)(356005)(4326008)(70206006)(70586007)(8676002)(82740400003)(41300700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:53:34.7535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00151d83-0153-435c-791b-08db30e319ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
max_sectors, that allows user to set negative values.

Add a callback to error out when max_sectors value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8f7c6f8c2132..38f2c7c83de0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -193,8 +193,18 @@ static int g_bs = 512;
 device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
+static int null_set_max_sects(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_max_sects_param_ops = {
+	.set	= null_set_max_sects,
+	.get	= param_get_int,
+};
+
 static int g_max_sectors;
-module_param_named(max_sectors, g_max_sectors, int, 0444);
+device_param_cb(max_sectors, &null_max_sects_param_ops, &g_max_sectors, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
 static unsigned int nr_devices = 1;
-- 
2.29.0

