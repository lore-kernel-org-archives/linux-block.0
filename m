Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60EC6C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 20:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjC2Ur5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2Ur4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 16:47:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9647461B9
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 13:47:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGdaiJXp7sX7rzAudJJwJRsOycymzMscMtBTAdEoFZ4o0/9LEVwMvGwIxv3MOa8EgHYIHuE/C9T3WUwYMCywSktf5holi+pR9znTZiBkwTEjZZsnAxuh//tocH5awJAjdemEpFC/IuspvOpmF4rVPVpBGZ4mNtKY2V194KqxtOPaj0xyotywFbL1D4+dcQ99KLC955QADN9ERoxNBLGW+SN6sq3ghwaEX9/adnBoFlKsRUJFIXL4ZMMRu1Wzo0FcNsX9PeCZ8ggFw5JwriczfY5+gYNNZRDAtLOTBQib8DOIji9loPFnePVKVMwXQ5+HEuwyDplEZtPcXmmw9P28fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNAC7FxQ9HSzysDNPoc/e9E7FJns/Gzq3j9TnvIDYEw=;
 b=CElCFKkQ7TM1/sb4a4VWlUBJYO5/eodlmBOvAqTTGDaUftOyDB3u4/eEBEBB9kzVGcz5exXQ+/cTkhSbRtuL/1rIf8/Auu3pfbVDoxDErq75Tqlxlh1EjKgAtD7ZBZ1gsFBUpydxFb1l3xWdZlI8854bm6d0nY9fygk0gnA9tMvNnRzRdu+Ry7wWamXgIVnLfEEfD+3n7BBsuRxcO/kOc/j947OLIoYs7An2cI3NcMM78sG0x8Q5W7ghp7YHru5zuELEW3i2rvYzVW/o0NmdSyjEU+itp+nlxHxIty/vI3UuBLYrCv7eFtmo2E6CBWQ6+TzUocXCFYsdgkaDswveAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNAC7FxQ9HSzysDNPoc/e9E7FJns/Gzq3j9TnvIDYEw=;
 b=NSEr9c8Nkq5qknL10S2mTc4ppPHuT9Mvols0YMZ2/RDxzA8jSw2AiRwSN5F25w1m/KWRkGchNIxVEXSP90mdGeaVy0VnS+VCpwwB6s/kWEwzkYJJKKMj5zyBHegKkGr9CkXTTvdwMzpJL91gicEt8DQWZdAPo0nxMnvIu6nQmLFR8NpdLHpP1aI11bY/p0k4CpMNX/q4XeOfyRl58ft2ha1eFxh3mvEhx+TCzzLGrioREphEykuwwRSYgibwU20M/YDMsB34Ah3iFzVa1DWbs4WkkXlPYH5W+EEF1dUbTblyKMVgwX6X3EU/AfRVt8GNVPLh5sQlPTytEmrlZHwyoQ==
Received: from DM6PR07CA0108.namprd07.prod.outlook.com (2603:10b6:5:330::14)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 20:47:47 +0000
Received: from DS1PEPF0000E644.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::74) by DM6PR07CA0108.outlook.office365.com
 (2603:10b6:5:330::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:47:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E644.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:47:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 13:47:33 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 13:47:33 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/4] null-blk: use memset_page() to fill page pattern
Date:   Wed, 29 Mar 2023 13:46:51 -0700
Message-ID: <20230329204652.52785-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230329204652.52785-1-kch@nvidia.com>
References: <20230329204652.52785-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E644:EE_|SA1PR12MB7127:EE_
X-MS-Office365-Filtering-Correlation-Id: ea02b794-4116-43a2-b554-08db3096dab7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WChj+NzITuwf0hce9xNQbo5mva9vw+GKJ9yGxWp0YY4tutqxbpdPuiqxEjYh53KWkRRtxUFienmP8jyesjAqWighD0hX8GmSK8EZ+llWdPPLnhNV6z2EQciV31TNZxoql1WIT5/437vYOBv89shoU3yn6/PKtHqA1warXkkbXxV1m5ndXyEJ9gnt4kn6M/2V/zpJoZoz3aC2P8kVZU6uqa836kNF1AMv9NJ2N0ef/DK7c5qc089GMwUySdv2pc+XXzKVK2JLubWJPlzd16wRM9magl5g9KoT3A58R3hz3T1wZKzy1Cie3KQrv9JL0tslWcULQ8jJbe1zCrIRyOiUEtfzezXspKVXbIHCP7y9wfEm+ylKojJ6EopqyvpmHf6wPmHD7f5gvy9ctf6BwuDvY7qX1E7MK9ZJiAu0zL12TblOpc29It+npdyQtKKMaa6TMPiEQwElij3mhyMfc4lyA0oaauEWgsNaxzracfIfUrWdfbwKtmtt9ZPDJv1EhXwpVXZ4CJUXQ74R3AfzS6xfz17ttNM/E3jUInHJ2HxsMt8LqJkcW6b7N3Qhs22wnE+vW8cPnMfjIPQ8WBlxAAbGN4wbt4Dbk4Fp/QdHY7IMg9Fg1yrzd8h0/VHLTiLdRDhpcEcRd+7XvEg5vOla5EdJNau8Ie1MR8cyERtw2LUSgk3Wttttxrggdz62KmXIF57flFtqDqDADyfwumt7MONjLFIIW/yxXyud1CEmA/vEDqiS4F5/peIaR7K0lwadaWK
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(316002)(36860700001)(40460700003)(478600001)(54906003)(82740400003)(356005)(7636003)(82310400005)(8936002)(5660300002)(36756003)(70586007)(4744005)(4326008)(70206006)(8676002)(2906002)(6916009)(40480700001)(41300700001)(426003)(1076003)(186003)(107886003)(6666004)(16526019)(26005)(2616005)(336012)(83380400001)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:47:47.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea02b794-4116-43a2-b554-08db3096dab7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E644.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use library helper memset_page() to set the buffer to 0xFF instead of
having duplicate code. This also removes deprecated API kmap_atomic()
from :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2b344dcb4382..41da75a7f75e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1167,11 +1167,7 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 static void nullb_fill_pattern(struct nullb *nullb, struct page *page,
 			       unsigned int len, unsigned int off)
 {
-	void *dst;
-
-	dst = kmap_atomic(page);
-	memset(dst + off, 0xFF, len);
-	kunmap_atomic(dst);
+	memset_page(page, off, 0xff, len);
 }
 
 blk_status_t null_handle_discard(struct nullb_device *dev,
-- 
2.29.0

