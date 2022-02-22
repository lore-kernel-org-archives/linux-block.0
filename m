Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C6C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 15:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiBVP3w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBVP3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 10:29:51 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B2115F614
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 07:29:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emnIy+W8HDj9Uy5yhYWg40dmhwmGR/xzxm3qf29bFwc+mLtePJ9HzbYnSSfMf6+X2IWzEfnSZdvXJC83vWtdYTTRX3JubH7emNSQJkdkUsmvUnFj4AxB6/bKSNtaau3s7BCFn3l/HwOHwhITge6D0hPuxhhiH6P1NRymBgbnG9x2tpyiPaUBuBYhXnKHUgXvR3T3zPgilOgcY7dkdDGnwxslVkZApHv84hQmipTapqrXbt/motA5JBJzoVEC25zrdIOjqDLSvb0WPGv4Tvl/xDUbksIdTVcm5vOg2L+CsGahP1OyyozNmduM5qhFDZNGps+XTv0C+x02rP7pyc2h7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g35IJEMF3mVP1ZZU5gD3Zf8+Lm1F72HrYoX8p0rVYys=;
 b=Y5VPqPsePwr4AkiauyJAL8YrsgJsfgt57tLiAdsB4o6HgJmFRLZIkKJgTlChP7pdDlFGM60CANsb2iJu0brGnQ2dWuRpj9iNhBbf5ZGP7hBicG95xrwT0GRPLGMMEJCGa/CDj8q7aTKudJpPbCB3RokFtfdnDI5/HQt1qMha45GvsyAFYCl6ZBayRoMVlvtaSt7T3KsCISvElnQuZ37YfK1uPWGvWJuzer5PxfEUkIiwVduQHWUXs5JakQMcO3L+PP3MDMtQb6oAl1M8tvUiBc9XEXhjMJHGO9UxKJrZ21K3DM+mr2IXJ5FqiCMvH4lv09E2xI4vbMSDeKCXEn6HsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g35IJEMF3mVP1ZZU5gD3Zf8+Lm1F72HrYoX8p0rVYys=;
 b=l1xZl4Q40uY0bFGEN1IMxjMpjSkGkGbkic7n8xYY774glbcYP9HMHR9CTHehPcpyivtUQYZbYIfmf25WGO16AmfPZg9O/GCKPMx+4uiyEMkeM2SxSYp97kUgu6ns455TdnBlpWyzWNqbp74N7PRKSXLqWLk8yATugnT/m7XZrq1ev2R8NzBF6ykYJ9LUAgd1OatdjyBr6HD5y1SmN/Q7Z070Yp10bqC4LnWeKFQ0GLMfMe3NpfOnqnDkdNnf7FNNrt4rrE+ZL8BAWhfi0M1SfwlVOYRH18c5rPH3VESbprB/idlvmGO6NBErMAEhNZpp72OWCnne+K7G1iZNzsvDuw==
Received: from DM6PR03CA0089.namprd03.prod.outlook.com (2603:10b6:5:333::22)
 by DM4PR12MB5071.namprd12.prod.outlook.com (2603:10b6:5:38a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 22 Feb
 2022 15:29:25 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::67) by DM6PR03CA0089.outlook.office365.com
 (2603:10b6:5:333::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 15:29:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:29:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 15:29:23 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 07:29:22 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] null_blk: null_alloc_page() cleanup
Date:   Tue, 22 Feb 2022 07:28:52 -0800
Message-ID: <20220222152852.26043-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220222152852.26043-1-kch@nvidia.com>
References: <20220222152852.26043-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 714f3842-9c3b-4041-6b97-08d9f6181b71
X-MS-TrafficTypeDiagnostic: DM4PR12MB5071:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB50717F6E799405D78C6C9E25A33B9@DM4PR12MB5071.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3CDI18tw+k8Z33NPZR9eEIhqzRhnvlKU/m7FkeLWFdDzL5wCWk8q5bZu+9Aspi/uHCIaNnFGRIqydPI6q9ovCzWTus04svrfI+xAj3WyTj45QJpmAPPFWnZWcDLpxG5QGFaBNCF8PtK79m/Kjyv5fmNRUX9cl6Ck7saem91KqR9D+6LfgI9viMaU5x2KLG+MWG8/ToLGIf0ihJZ0jPJbSfO1kqSfAyGs6OQiPEIbDNTnOrNSRDCx9oONsmDpYJDIVC9iTUzIj6mrsrUXT6ykDQ+7O9nReUbRc8xgcVm63HbvF9i8yCggCSIpQ09f5Y8ev8ulSw7b8N0QAbumB3yz5EF8qNAkYrosJT4Zgu8528rB7iLMBc+YFiHbLjFaR7jykHlHKC++WSJdjXaNOmlo4Ypvi2mxE2cuAgyz5ffJbREotOxc6urAXSPDacNFBQ4RPTPT4Ye/4zFaX0anfee5ookrb9IPoMuM4DTPCM5+oLRrwVNSVYLd9aRPZ7wkzlFJd6hRZ2T6+znHSxq/oAPWff8HNDGmsR8EQc++BxNnsz4H4k1FT19zVQA8pRFyDJ7CHyl3hr99XD+1ltL2zrYsRWRPZz2TwLfgM6M4Cm0Xu4uUQ/SGBRH3ePjUQMx911riNMX93ycwiHPivRsktI1lvYvGk4oM38XmzSPg8WB13WCc7ORTCA6oNO1+r7BB3VzRWGN0UDuxgdb8i6LeSRBYg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(83380400001)(36860700001)(82310400004)(508600001)(81166007)(6666004)(7696005)(2616005)(47076005)(107886003)(16526019)(426003)(26005)(186003)(336012)(1076003)(54906003)(6916009)(70206006)(8676002)(70586007)(316002)(36756003)(40460700003)(2906002)(4326008)(356005)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:29:24.8451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 714f3842-9c3b-4041-6b97-08d9f6181b71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5071
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove goto labels and use direct returns as error unwinding code only
needs to free t_page variable if we alloc_pages() call fails as having
two labels for one kfree() can be avoided easily.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 80f9a6ba376d..05b1120e6623 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -783,18 +783,16 @@ static struct nullb_page *null_alloc_page(void)
 
 	t_page = kmalloc(sizeof(struct nullb_page), GFP_NOIO);
 	if (!t_page)
-		goto out;
+		return NULL;
 
 	t_page->page = alloc_pages(GFP_NOIO, 0);
-	if (!t_page->page)
-		goto out_freepage;
+	if (!t_page->page) {
+		kfree(t_page);
+		return NULL;
+	}
 
 	memset(t_page->bitmap, 0, sizeof(t_page->bitmap));
 	return t_page;
-out_freepage:
-	kfree(t_page);
-out:
-	return NULL;
 }
 
 static void null_free_page(struct nullb_page *t_page)
-- 
2.29.0

