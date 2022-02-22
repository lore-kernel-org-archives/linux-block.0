Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA20C433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Feb 2022 15:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbiBVP3m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:29:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiBVP3l (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Feb 2022 10:29:41 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1543815F60B
        for <linux-block@vger.kernel.org>; Tue, 22 Feb 2022 07:29:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jp2okHPRDInDAP36xg3vA1kBLhCGS+NuMiYoNxKdrBSR/tnfj+p9nfLgPl80z2K0lq1zmqIIM6RlDnWQSsUhzTvkCvpjgApRPdlKtmc/LS+W5KhR3NWIF9H8k/Z8NaT1xMX85gjTdf0TdUkYZ3yVS5hbvE8cH2djfYpIyJU02Wnjmoxj26V4p1Y9PrZUoSsYS3PgihsL9h06nHUkrPuhKvcr2UfZgWCorlWVitJMem6QZKm0fhoLD4pJRqZcIlsiGmBF1tTI5NP1tprEufOk84XJ0yR5MO1nfTBWEyPgi13keH8y5/EwlO66GPwNcyqYglltIT8ByCPR+NjKO3G2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vmH2p/TQt+mDpz12Enhq80zPGCF3WYoGUqslcszLwNM=;
 b=Vu2vaRmJiPeQq/Lu/+L783uqRHITxfDViR7M+PZSDe77SvhD87QyNsJre3Sa0oG1DkL/RPkYrYPFk8DKKDiuQH7WRntfsapgiAxyO4YjEtDCMqyY2iudnJRwpCTmnXtdr3wnG/dxRLjfs1OQj2M0nTVCjPpgE1G5vfzTbyWz5cSZUYrgnR989ZHE044C0pW6zyKi2nlYye3QDL9smW8qLfeXu7bQfNQrJ92dbzkqnGZ6nlNlEFFFC6rCr7aZZM3u6OMp9OKqhOQu4XKZhUvfW2F6Dcsx/rxKuYlaI6mp1J9qVQqpBlJ0Yn7ebohwoTFIA0aDXrUaiSFMLhPgAcgRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vmH2p/TQt+mDpz12Enhq80zPGCF3WYoGUqslcszLwNM=;
 b=duMdPQOwUhf58spmoamc2e2wr9r2a2K4RzHBVdz2lTaw0T/jBvLeO4HsV2+CDHCXg1U/N33HjMyjGVGdmkAipL6TLgCyL2SjA1ATJCnNw5e9HKz7HEZV0mDDO3rz6JDwRgkjjRAOqRgJV2S/8B1P9jTvTW+/WRUsMnRnjTRzKEJ0uWO8MiApz9oSCV6/pbulBvs01J6WC1rizsWDl2Uv4VNI0k1sb1a4x79+uzU83/IZVdGawDSeS1Xw92L2Tu1EukP/TxugxAurGCfVym2t8i2Nfi7sRTc98nRNqJzlk/dJxETI0ECqKIFD9lYSMyvFyT5lVk/lVifPpGHPEDI+6Q==
Received: from DS7PR06CA0031.namprd06.prod.outlook.com (2603:10b6:8:54::11) by
 SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.26; Tue, 22 Feb 2022 15:29:13 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::cb) by DS7PR06CA0031.outlook.office365.com
 (2603:10b6:8:54::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 15:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:29:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 15:29:12 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 07:29:10 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <shinichiro.kawasaki@wdc.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] null_blk: remove hardcoded null_alloc_page() param
Date:   Tue, 22 Feb 2022 07:28:51 -0800
Message-ID: <20220222152852.26043-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55952f1b-e860-43b2-f2d6-08d9f6181464
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5453:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB545381C61C29065B9BFD42D3A33B9@SJ0PR12MB5453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GTE9YVszwc204qy6ERP9KNHb+2F0tEvmkeA4Sv1f9EpNgXwGhrV8ipz34qqVpyEWmnen95+QAWbvBeTvIMD3MDEBimFZlhkv6cNweFz5qBzewfP09XKgrkYpkoBT1gGtB8utyNSdzQI3PYJkBE+RXCTVWzw7yj40wJQruq0QIP0BRw9yMyrDOK5lzx2H6wfAkLfyZaIUV//Satd1oTP9NA/1TmLSGAA/ZL9ITMI0DAfLIF96gfLsriHvZVo9PLb5lNiHEu1gaH/D9xIAHgwDDefLncistPjwHgVy5bBzROYcAbXERgheesIxK2S3gdtWjT60kmHxO5gldDPBsBi6KBROHZQVe7Zivy07GMzHzo1aRSfKDSFa+i5OVzBxz3SRG3h1lg9cah+tZfppPwQd5noNem4LDcEtTBNs4DvAMe7q2iNWIEFmgH+flrVaBw5pWde2p2hmHxP+FJKkZXTWmcXMxzdh8g2zKRIMDff8FCVuxQrE/kGAiDS45Tut5BB7aIJSsjp+iBc+4qYbKm19TGVTosS5Y1wMuLR14HZlUkUk9/Du4Y0W3838VTsYAoxrK36Z0wslxOU1a04pfqDORKUFAmI+yNg6tsj6Nf1d5FPgg8MMSSZ983+jKp2VevXh77FME40HP9nFFJImuYvXgtLngj1IgOdt61sutftHFr0AYshoNLBzfYL5Wg78zlogoBmNkWXAxZXEjPDpAWQS3A==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(2906002)(81166007)(316002)(83380400001)(508600001)(107886003)(6916009)(70206006)(5660300002)(70586007)(336012)(26005)(36860700001)(356005)(186003)(16526019)(2616005)(426003)(8936002)(8676002)(36756003)(6666004)(1076003)(40460700003)(82310400004)(47076005)(4326008)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:29:12.9412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55952f1b-e860-43b2-f2d6-08d9f6181464
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only caller of null_alloc_page() is null_insert_page() unconditionally
sets only parameter to GFP_NOIO and that is statically hard-coded in
null_blk. There is no point in having statically hardcoded function
parameter.

Remove the unnecessary parameter gfp_flags and adjust the code, so it
can retain existing behavior null_alloc_page() with GFP_NOIO.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 29e183719e77..80f9a6ba376d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -777,15 +777,15 @@ static void null_complete_rq(struct request *rq)
 	end_cmd(blk_mq_rq_to_pdu(rq));
 }
 
-static struct nullb_page *null_alloc_page(gfp_t gfp_flags)
+static struct nullb_page *null_alloc_page(void)
 {
 	struct nullb_page *t_page;
 
-	t_page = kmalloc(sizeof(struct nullb_page), gfp_flags);
+	t_page = kmalloc(sizeof(struct nullb_page), GFP_NOIO);
 	if (!t_page)
 		goto out;
 
-	t_page->page = alloc_pages(gfp_flags, 0);
+	t_page->page = alloc_pages(GFP_NOIO, 0);
 	if (!t_page->page)
 		goto out_freepage;
 
@@ -932,7 +932,7 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 
 	spin_unlock_irq(&nullb->lock);
 
-	t_page = null_alloc_page(GFP_NOIO);
+	t_page = null_alloc_page();
 	if (!t_page)
 		goto out_lock;
 
-- 
2.29.0

