Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F49C7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjC3Vc1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbjC3VcZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C31EF9C
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:32:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVpwukiGV+WkPrsnS8dhXLSr68p0yVviYs/+oALXNIYF55G0+51nBf74EvllN4WK19yRQsdVqCBRfDe5BSYicZTiTsbFg9Bp3U7A/1xLNpBPFbZgWUVpLTVAHeNgrYd43BCwXl0eIs6zoradHnBUO8AbWLY/5VdqOI5UJGiRPqRIMxV5yUln5ZAcN03xROk8hq9f5+Bxsf6rsLoR+tUGH2gcBabBfeTTIcJkcSmzUZmpcRVlVZ3+hzk6pCZqfJId1OZS1d+mY/TSNW73CHba3pd10obmwzLL9+nab4zV4aLlIq8qQdPvqh73UIFhD1+IpgMo3/HhTVyl6Pv8KTLjMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rhL85XEERYkQDfbI7NGkA6TTlVmWKwCDKOaBub5UKM=;
 b=B7QrVWtxtk8X9q/vUSDqomlK7Pv0XIwdS4W7WHl3qophNOP97RGp/cExXtRMVsRh6hBqAVwwY6+xTEAK/xioL+H+XI3MyvP7SEe78CBptiGm8zTyoSnCt0t9b8Fljz+fuGGe+ZYVeUD/RCVCDnRpl3O7wNqhAIyuJHUgl7hm7LIfWGqZBjU+msz6RYNRenj/nSRybzGqicm2x3w3C8L/aRsrdMDwyVHt7sAfEtdltPr37QXUBomkJ4QxO1+QNjqY9tqYoc3lhornSC/i3vVj0lpnmfCjkWFUSSjkvAeKfsdBqLj6q23BhrerEKT48DIoqa30UuXEWgfX9dlpKKdsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rhL85XEERYkQDfbI7NGkA6TTlVmWKwCDKOaBub5UKM=;
 b=ZgFJFul/T+S5d/GPeazxNyrHuvJMKvbAVrlNy0gyN3OIV1H9MRfYjr0rL6dowJErlFL+4M9c4cB/JYy4rR+9OIgMxSa48ONmaibT4rgLxN4OysSKkqTilWS5WLrZfYw8AVEwyJA63E6jc5VKb/iPGQjl/I4Lzo21TdWZ4q9Q4oIMu6bi6Pb5sR3pEP/uJ+louD4IcElntyspVBK2N+wV3jKZn8zjB1bOmMcA5jHhRkiYxD3OSIMiSbTZ5zBxvtqGXA5gtjUbO0/KZBXjykXA/9qWQJ2yUdIvyfOiKXq8dZdgksErf7OQghGH8bAYcB4go+jsLwoYeCa5Q78z5IbwrQ==
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.31; Thu, 30 Mar 2023 21:32:20 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::54) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 21:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 21:32:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:32:07 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:32:06 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 2/9] null_blk: check for valid submit_queue value
Date:   Thu, 30 Mar 2023 14:31:27 -0700
Message-ID: <20230330213134.131298-3-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 569cf018-3c03-4550-3d76-08db31663e09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6+V+zFf6Qk1hrov7hX122Jkr/pgbQ5ogRO12Wdrnm7csiylTVsXWfIglz4jVsG720lcJokOvB32nfInzllFA32MQUYby1VEmPRRGQWnKksIPAR6/Q/gVlxdAzUi0SawRKM9zKPaHzeyfdx3ckl7cZpBlpOQeSs27kJiPM83RFxrWDeUw00jMExxmfS4rmbVOC8C4C0d3t+1dT0zpzHWRhVah2dgwzjmQ43FXiO+dpS8/90Ab+p+br4RQSkI2jU2SQ0kA7+p0obMTOktrkKo0OK8GDDZVqOre2BjsmW/EVXlavTbZJHAVpQliF1P7e07PwkW2GaIQWoNtsDg1LWWksMhSBg4HPQtOzkUujWpAdJKn5ilU1ZlxeCbRVdiQ3513wW/fowj417KkNYRmFr4LLfIM+y0SDOmq9Nm9C2zhovuq53tSSj7QjSNAWG9HKfzqUIdEYZoGRcmhsMJvhPQu+vZU5dWJT8YY6z6jBqofRiWRZcEgqvgDe1+gnKUjeZjttFKgyKY0RAmylWFoRgtBxytwHvIFaFjk5UAYn0zUzOFq4b8X0dn2Yj5M6FStzvjoA3Qn1AA2ZM21sS9b0VSmZBqBnbNsckomP7yBcYvXD7yLlssfz2mPg66+Ho934K5i87Al1WQ3tvkFB6FZKXtwK2VMalhviqGWIqym1eTjqiMVvt2KvwRbDYIkqI6EJh1CH+cg+czOcber8lZMqu6OJwFljd0mG/E/8sx8Dhpi+cqXNd8rfCwmBNtxRalZHRgX2DPj02CtQkRxOa8c1lDsFWXkteOHFx9Aa+U6W/yrNDs=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(6666004)(1076003)(7636003)(26005)(82740400003)(186003)(426003)(34020700004)(2906002)(47076005)(2616005)(16526019)(5660300002)(36860700001)(8936002)(54906003)(82310400005)(36756003)(478600001)(316002)(7696005)(70206006)(40460700003)(4326008)(336012)(41300700001)(8676002)(6916009)(40480700001)(70586007)(356005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:32:19.8869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569cf018-3c03-4550-3d76-08db31663e09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
submit_queue, that allows user to set negative values.

Add a callback null_set_submit_queues() to error out when submit_queue
value is < 1 before module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index cf6937f4cfa1..9e3df92d0b98 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -100,8 +100,18 @@ static int g_no_sched;
 module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
+static int null_set_submit_queues(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_submit_queues_param_ops = {
+	.set	= null_set_submit_queues,
+	.get	= param_get_int,
+};
+
 static int g_submit_queues = 1;
-module_param_named(submit_queues, g_submit_queues, int, 0444);
+device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
 static int g_poll_queues = 1;
-- 
2.29.0

