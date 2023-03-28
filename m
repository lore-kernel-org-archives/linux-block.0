Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F20C761A6
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjC1T5u (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjC1T5s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:57:48 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04293C19
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:57:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgQC/2l8OsB7M3PP1Z4VOCelGGVyxwytdBCcaLB+Zoa9v7GmAMFK2YSwl7l4FsF1eNo0mZvlw9ogCZutzv5w7Qwe6UWIQ02ZuLgwzK1e7Qe3EntlBmYB8ezF7EAi0F7y7LPStHw/lNiJqjPGuwcRaA3FcGsmiXA+oGwKXkmeqHBYzdmeeno7YBwiFr/rW+k5ogbK5UjuCYvqPpqkePqbztysBnDD6h1zpc2stjOt96xBmR+Mp9oUeydG04hKJWA12VJNXO2+jXTvwhr1wiKgmMI6kF0fhH2fOAhZwOaAFVh1MUUrQS4o367D00wHs3zeqrcwlDFVKjOdAGuM3qEm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+cwlHTRv9D4ufe0iHxJrDbSkY+ZrLC+H+KcMvP4m1Q=;
 b=W6sa6Hnt56eNQQVd09tMa3nH01NCNMXfjoZzhhp3LDpK1GojtsORVqz9Si728V4FS9GMlISDeWsobIeROLoN0TS/5OfYWjUSI5ScraeFJivJDrn/chSDcZaMB4Fmtnb7xwIJ/U/kC9TjN+OuR0O9IfT3gBlqOln0Wg/dv5hHJgDtN0xeopxTsaFLDqA2cGWh1hJXusAdAcS5ijXKho8LikynAAiGfqv5NqRXBHjH/29sEtvnJvCJ/R2DE5NkJRNkz1a2PVJ7CRoblBrBONgU3A4UfNXS4NkkAmk0sEOSUgPOqoPxwJ6F7pAC/07u4mynpWW+210+27v1El8Ax259lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+cwlHTRv9D4ufe0iHxJrDbSkY+ZrLC+H+KcMvP4m1Q=;
 b=W2ujo0gTMkj6XXYx4kMqfqlVOfakUUVh+pLozuKWq/lGAWmZt/HzjCTnd8iKA8Zkc/eHSjJsH9QhnZY0cmMddwWXqaJecU+hc2dDI3WxU1t4kottJt/RddOmRSiSFEPvgjEtaC6gPGRXVQfNi9xRF+ubENjjzum89p+nTYOOiL7mB46OGnR6dlaeyUOUmU9i1KfC8kxSLvl5aU3ta6AvPkwq9Xv9u901EsZ1RZdqoZcEsOwnm7wrR2TTLmS4+tqaheE+FSDcu6ki7R6JEfqrwNjNPk5B9IivWRsdJbT5tJhUdM8HDpkIOMIQtxfUbEeBn51higSMW2VTfA07RVSuaw==
Received: from MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 19:57:08 +0000
Received: from CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::8b) by MW4P220CA0026.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 19:57:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT093.mail.protection.outlook.com (10.13.175.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.21 via Frontend Transport; Tue, 28 Mar 2023 19:57:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 12:56:55 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 12:56:55 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] brd: use memcpy_to_page() in copy_to_brd()
Date:   Tue, 28 Mar 2023 12:56:24 -0700
Message-ID: <20230328195626.12075-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230328195626.12075-1-kch@nvidia.com>
References: <20230328195626.12075-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT093:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bf8e3a-cfd1-43dd-3292-08db2fc69c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bwdv99iwboL+mFVywBWrDO0LgXG+gvjM5Xyrt+rLBay94zj2WDdOWfrLgHGjM5yvVW3CeGge9X47V5h+gVChwhM+go6n3L9bfdx6int9SQMYXtIHQMlGJBP3qG7RH9nxK0vedY0M94VjsySPHtRRcZkZZkCHypxKtS7sJdEDjFSK0K+aZ4fzSEEx2o6RSwbWOL3HTI1+AMjxvzdp3kL6VmRsorttSHibjPy3cZkZRS/8RtWdzm1iVxA13TXJ0yuEwYgExq2zEl7jiyOzZLRQSKWrCP4vadUd9BjEJLfiTup1k/6cr+nu/XopNZqmg1L/uVTyWhJgxRsGL2s5D0Jq7oYo9MeGKzjHRvzl+VWucqYPap2sdJU+rWGNcQxtk2tObOx3fvETVCzfdlhPC7qsCCTDv2QO3IXkSBitw/K3bjjazQi291yVPllVIiHfx62npxKK3NKAijb5g8Qot3dqjsPau0yUEDkbqrU/VXiadeVpDzjncXuj7FX0wzn2sL8kZ79JHfF3KwvE6NQ04G0icK3e0f4FqVfCNR458QsedG0H2TrKZbtmYKgALLEDVhB4ZxgLRcqr1Aj97Ln8G2SbPouQ190Zl4cdjPlA0ZfyD56A3SlX2oR/M4595Beo2T792UGUOwDkM/EC8gGzJZQjtKBcJ5EVig1uHbbW9hP86aqyUv+R/woohpU40gg3yZXwekyz+22ztPhqAzowob92E8CVd3l9/E4KCmHUO1xb6gILUcK3mcLfgnnFI8trjjG6AqYCETaDuohSM18TlWkkhD0Dfm95CkMmPyS/zClRxKY=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(83380400001)(2906002)(426003)(47076005)(2616005)(4326008)(336012)(356005)(70586007)(40480700001)(186003)(40460700003)(6916009)(16526019)(34020700004)(7636003)(82740400003)(41300700001)(36756003)(36860700001)(8936002)(8676002)(70206006)(26005)(5660300002)(1076003)(107886003)(6666004)(316002)(54906003)(7696005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 19:57:07.2947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bf8e3a-cfd1-43dd-3292-08db2fc69c36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In copy_to_brd() it uses kmap_atomic() call on the page in question to
create destination page mapping on buffer (dst), then it uses memcpy()
call to copy the data from source pointer onto mapped buffer (dst) with
added offset and size equals to number of bytes stored in copy variable.
Then it uses the kunmap_atomic(), also from :include/linux/highmem.h:

"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() does the same job of mapping and copying except
it uses non deprecated kmap_local_page() and kunmap_local().

Use memcpy_from_page() does the same job of mapping and copying except
it uses non deprecated kmap_local_page() and kunmap_local().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/brd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 91ab0a76a39f..4948cfdd83ac 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -189,7 +189,6 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 			sector_t sector, size_t n)
 {
 	struct page *page;
-	void *dst;
 	unsigned int offset = (sector & (PAGE_SECTORS-1)) << SECTOR_SHIFT;
 	size_t copy;
 
@@ -206,9 +205,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 		page = brd_lookup_page(brd, sector);
 		BUG_ON(!page);
 
-		dst = kmap_atomic(page);
-		memcpy(dst, src, copy);
-		kunmap_atomic(dst);
+		memcpy_to_page(page, 0, src, copy);
 	}
 }
 
-- 
2.29.0

