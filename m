Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FE3C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjC3VdE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjC3VdD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:33:03 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AED35B5
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:33:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nek/aHusYm9jnVn2NEfKoWztO92yAn+IlWNFOJXmDyeNNOLCAEEMgg5HBk+QIn/7hzNmvhhO8Akgq1Pf1KDUx02S3gdBAMntX4GOLjAHFf50Re84zbA1qLAsBZiFJ9synyhtbbLgD1lgBBdZ3yYgCSdxZjv8luOJNX3R03J371X/st1Sk9+IjjuFVAlmc4nKwaZ3ST3ak0AkQAe+uJiN/8eiPFkXnSlOtpBGxeX5UT/Ly3EFYh5z9Hwf3xhnM9illfXucLngGmLM9kIJHCz1CMu26c7G09Ucx4Zyye3sAwcIwAJrSTrI1MxPaUFND61RqSCsvMd8ElzsDvbTd3UV/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DpgpRO4z1okmq0mI60XQR47068UT4MFrSQ0Fu84M3lM=;
 b=PxpiryfGnwI7I6CqsGTGJ9nmGjV3Bc4/SxIrDHp+EQp51DzhYBVjN0V7Rb4jT2x/dFhUQdGX3HnKov+e48GRgdv+T/kMXDdrgvkPfg4hnOnxOvO9YdE8N963aLfKMsK7oV6VcNesr1lmHFKdTXAq/uj5TkuB/BiRT5POwUgHjOeIWOxCoxhB8wZ3lwHLVdvzv545p5snNJ2HSrw0SZefCHaH3//5u2BjhCfsRa4lz6/Ko/QEZsLQW3dyXeEwnEo9FVdQLfmZm5VDY7CzCpPLTMwmnNri7K2hLxFxcQsZ70LdJ5/HJijCRQ+gYl2yXpoPNi7Ac6LjjkWXgQPu2m36xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DpgpRO4z1okmq0mI60XQR47068UT4MFrSQ0Fu84M3lM=;
 b=Y5RCDZVS6qHWQVDUa/Fzg+N5gfQmaYjEwb2OZ2Dfyeo4dYRCL7Lq1I2YYIUXdPn840hd5PmWhHLvVjPf30lNa49PQZp/2VYTfJdI3AQofqCZMfbAje3jT7zkXXdTUMeDxabbdLmKzNNrZ3qHd5j8UuwmwJMBvLjNdQHmzn++3nxh9EzqPAStmDay3XdSjON7r73n/XKT/qQNdYrGg9UizngftpQKNAZZVA8lMhXHEx0EZAxSnQHyRlL8io8EYPKbnbX1CiN43Ct/np1qvk/mqV/pl9SP9hjGutOrQegexcl9ZEzBZxm2TSjWMp1R289B5pvq6V58YUZStE1MZygZAQ==
Received: from DM6PR06CA0083.namprd06.prod.outlook.com (2603:10b6:5:336::16)
 by SN7PR12MB7155.namprd12.prod.outlook.com (2603:10b6:806:2a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 21:33:00 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::9f) by DM6PR06CA0083.outlook.office365.com
 (2603:10b6:5:336::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 21:33:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 21:32:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:32:52 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:32:51 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 6/9] null_blk: check for valid max_sectors value
Date:   Thu, 30 Mar 2023 14:31:31 -0700
Message-ID: <20230330213134.131298-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330213134.131298-1-kch@nvidia.com>
References: <20230330213134.131298-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|SN7PR12MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a8f5e7-782e-4e3b-7f28-08db316655ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yMiu7LMJJW4yJ6c+0iYx7CN8s8pwwctYkcrzMHFU+s7cG0p55xTgEgGXcnQKf5fmDSygLEsOo87cSz5KTTUtjYlne37s/ZhJJn+AcnC+4UDi5jcumMyXQLfuu/NjBrhZZgh4ml3y6x076IVaLn0sLbV793JB8TWlOouXExEaNEO4abUb09dzpQ1k1+9JFTNSbGorkWBY/qwcvLis8lfTNxL5Ij7TaL9njbbOIrAJ7KlrQNax7UNmDI/6Z+5nD4FTCPN7gjL3VRqr1axd4VgZNeCC+zuTzI7Eeo1sLDWZ1TKJIsJbEiY5zptDciFTkBUEAIHY0CXXsJAAiAw8eu/57OwkWdQjsH9Fc2XJlGlWb4H2LX0/kiSEJTTqzLh6Fg5kRU/iUN4FBiDa+ULDip7rVq61wNh/8BoZZ48oeHe2b5LaJFMlO0W141uVCL59l9f4zg3dhIuhvdbmkQfoquSDl8e8yJl/ATxY9tcsW5Ddq9MR38GX0bx0vW5iMeXr1eacfH43xOxlWLt/OuA3bMP0RbQxkb2UMmF5ohpHCWnGVDNlEwwtulY35RzfhBMsdzIyj8uYx+ecm7achB4hNW5/DK6wr4p68ojRvtPAkR4R0x1zCckiWO+9KWNpqKy8g9dSAnb1YG9yIm74CrAg3Iau90a2sAcGSpi+hGkljc0dICJ5875AVjSq6We9398INdBIYhqOOSAleGa8k1Nrxi679HwfZGYAkoxkiCZTiQrvkXxStueGDJv6zNIaFME8+dz1HBfM7FCs0qd6w5cnm6PU0e80YMmdEprdD5Tz0eItE8w=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(82310400005)(40460700003)(186003)(40480700001)(26005)(1076003)(34020700004)(36860700001)(336012)(7636003)(36756003)(82740400003)(47076005)(83380400001)(426003)(356005)(316002)(70206006)(70586007)(2616005)(54906003)(2906002)(8676002)(8936002)(5660300002)(41300700001)(4326008)(6916009)(6666004)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:32:59.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a8f5e7-782e-4e3b-7f28-08db316655ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7155
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
max_sectors, that allows user to set negative values.

Add a callback to error out when max_sectors value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d8d79c66a7aa..c13f0f2b8d86 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -209,8 +209,23 @@ static int g_bs = 512;
 device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
+static int null_set_max_sects(const char *s, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = null_param_store_int(s, kp->arg, 1, INT_MAX);
+	if (ret)
+		pr_err("only positive values are allowed for max_sectors\n");
+	return ret;
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

