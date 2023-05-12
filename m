Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D278FC77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 08:31:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239907AbjELIbd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 04:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239803AbjELIbc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 04:31:32 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578C10E63
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 01:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V7HC3NXh2pRqkxPhKoQ4DeC7gKPbXPlFRtULkeQozJpjQ/xJc/DrnNbVeL/SDkOW8derTMITpaltyjFEVwoyh55rBIPnOMtvIOHBHrgoEWXUXyhQcYJ0R1ZS2JpDoHo8wZn8Sl0V4VaqpXim2kZrq72yzMznz42SlOXN/3TwEWLWLlcA3VOHFvopvxi5BOmuL31qZq3PushMVFSo5wzvxKSNqb8n4PXZ7XCjvo8Xwa4PHBhxComAUEADfcF6SXgqmaU0kFO6OxKJINchM6MLK4QvIRF8yhiue6NraORThTerXTTfmLIhNYyMhQVK7UrKyfbIadUrEgl17sZUzKgmwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEss8p2RQeb1WIxNaWZtnb3ov20xDwsu0v0+V918nxY=;
 b=bQK2esEbUxnKQumjY0c3oIjRwzQWn+41CVJi/X6E8u/0/DDcfm7mAnSwVkbcrVmISRfXrXBxc5h+kDom8bN8t0R6OAixo5IicMAZqbHKNEMzQIhsEiDkOZT/ZqyOACm330NZJPBPzPXYPNT+LKjU54zkLzTqn7OW3KOXC966yCksEX52wY5e71bEVV25SDTG/Kepkljz1VMXdOuZfvY4X6G2TPdl9xEn76ieybKb9BV9TVxfq6euwpzN3ZGypnVdkafy+LSImuglIcHsEVoUaMUNVBXLdpDxdDAlr9IrzY57msaOQ/otSZcULlEumj26yE8O/orEDpuTopooLhfN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEss8p2RQeb1WIxNaWZtnb3ov20xDwsu0v0+V918nxY=;
 b=JYP1YtC6RFxmJwXxIUY4DwYU2LG06JEoF8PLxk4yi5S+oZaw2Nms+53evUuqyIaFswxEhHxjB0PhKrXgBSsqh+ma2iFx9Nu6OPQf9xMeWYHNiOVaJEi6AmyYTOk5O01oOcqmJ2Uge6XkrnO6B6zW3XCvlyDfy2d+y8FnThiyuw2dNWzgpy3UIK1aQUqM9Gqul9f1nJOGrZX5ovsJNWPkRCPHkXchh2bX+ixP0hqwl53YXu7fP2JC3tyPMDFAdXan71vihdPI1ssf02s/Lj2+SZbuN/3VDV9B2txE9PzTsgYRXPqY26P0Fhcgq40qi2qaIMfXwEUuSZjaAZafSs3NxQ==
Received: from DM6PR07CA0071.namprd07.prod.outlook.com (2603:10b6:5:74::48) by
 MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Fri, 12 May
 2023 08:30:53 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::39) by DM6PR07CA0071.outlook.office365.com
 (2603:10b6:5:74::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 08:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20 via Frontend Transport; Fri, 12 May 2023 08:30:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 01:30:38 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 01:30:38 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/3] zram: add flush_dcache_page() call for write
Date:   Fri, 12 May 2023 01:29:58 -0700
Message-ID: <20230512082958.6550-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230512082958.6550-1-kch@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|MN0PR12MB5908:EE_
X-MS-Office365-Filtering-Correlation-Id: b98df24e-dd3d-4d88-a6fb-08db52c3335e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JMAAJuHiMLewcXajsRAJXOP719Qj0SbQyrpaG6bybsuamJ3vTgk9gzVFlcNsQL5i1zn4myhuHbxxGQb3kiodKELAehLt0smmI+1XP85k2BtXOxyDcVBDKvmF4V0rO5jEsTcBBh2uYMWMuitCg/J4Aou/jKVPY7ZyrYiSJ4PRVHfpHxTzLqiZN1ekPFPR/uLjsY3j9Mj4THAPzCyDfZHJRekpUG4/vOrbbW5aodl/1OP9VbvxBuDOrj+WgCrjMmm0/JTG8WvPaejhTU1WAizPVOiVpZIGG8GsiyjNbi1+lWIsXAuKzMP84QGGkCDhvnB8N3cQtbDbqkoF92oGzX+nb2nnF8Fya2RDYLAGjxzioqRWopUGiw33GHBVmRlvKZwldN72j7FXSsald0/UadfrHCk0qRzZOPA3Qw1jXSVUKQ0UQDzowrmy4KXcGw0AScTtZJzCb+pBmOx4jHWR1rEKXg8Qwrkm6Ob399pGEfALTexf8STseJksVk6hizhWuPZFfxMFWgWQxowy1n/feYK2xjwqQRtAgh1Arm1np9Um3D9a7+phULMkZwzeY3lRmxCadHEWB3xNqpPZN0K1m4keLha1L0vzy1Nq8oQRWlpVgQC/sL5f9nfDbH2J7RsMRVcK4IPYFQtgEl/mvGCkGrygg4fNt9xh9WQl+B1xkS0V4Tt/U1jSjA+ORDi/OkiJC/KdR/iCAEk+IpaYWkkxRs0QUw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(4744005)(2906002)(336012)(36860700001)(5660300002)(4326008)(36756003)(41300700001)(8936002)(8676002)(316002)(110136005)(478600001)(54906003)(70206006)(70586007)(6666004)(40460700003)(82310400005)(83380400001)(7636003)(82740400003)(1076003)(47076005)(7696005)(107886003)(40480700001)(426003)(16526019)(186003)(2616005)(26005)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:30:53.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b98df24e-dd3d-4d88-a6fb-08db52c3335e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Just like we have a call flush_dcache_read() after zrma_bvec_read(), add
missing flush_dcache_page() call before zram_bdev_write() in order to
handle the cache congruency of the kernel and userspace mappings of
page for REQ_OP_WRITE handling.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/zram/zram_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fc37419b3735..a7954ae80d40 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1887,6 +1887,7 @@ static void zram_bio_rw(struct zram *zram, struct bio *bio)
 				SECTOR_SHIFT;
 
 		if (op_is_write(bio_op(bio))) {
+			flush_dcache_page(bv.bv_page);
 			ret = zram_bvec_write(zram, &bv, index, offset, bio);
 			if (ret < 0) {
 				atomic64_inc(&zram->stats.failed_writes);
-- 
2.40.0

