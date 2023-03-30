Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0F3C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 18:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjC3SuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC3SuT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 14:50:19 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11hn2211.outbound.protection.outlook.com [52.100.172.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F5DD33C
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 11:50:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xr+D45L71x4WYCecOA/Xw75CdQebCsti5hXeIA1n6VGv5jH9OCU/t8C4+ljLQlTWqWEr25bN8YxS38pRM6cRdPocAErQIpYVSslosAUxa7Hpf4rdNJ+BHRlUy5hWQdLFUZ7GGlpaboaVYPcHsl1wEFvLroBlNZcrCZVtoGMJ7KuIeZ6A/4Mz7Lb6osWvehKt/6Y46a+mu/aFIBFoCEknND3nXk2RtNwt9QTNL74zYNXSwCkdXTcpWSEFe8IB97ysfhPlg9SMKrYlZsa2vUw79gD++BGIsW444/sF5PgQhs6l8EegO7pGj6nqsj6WWQb2DnTYW9l7NP/7iGMs3rWHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oe/xv6g1oimWIxOkSZBCMqmkdMvjYyoJ01N1ZMeibGw=;
 b=dCexJn6a8xtU9CN0un+p/+9BiLBD+LVLltKAQuew1+19my/R8fRxCqWSRukNPCUkE2jSUz/+Pt42Z7L0nDJ5GcZb8zEPFgX3WxNjg2kjQJZpP06XeO26v4NOEed9XYdAm1TnM4VtmQwYhtj9cOaDboTOZPMdxWHby9up1Ssf0Jr8cfZg6cnmIbeg5AyuhQ4Uu0EL7F1vfJ/5/BlQHznaGS7dNqXZb00woYAEfCWZF6g+P25e3dbHK5v9C1ypC1ZsyZqT1/qnoKciMEexWmP3hs/ukL1spRPApbegbw/fRZQnkSh7Ycn2+cwav2n1g3QAwLtHekISWRunt1ketIYRrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe/xv6g1oimWIxOkSZBCMqmkdMvjYyoJ01N1ZMeibGw=;
 b=aMluR2/hXQU54mL2joV5Kiizm37G+lwb0A15Ncn5dNogysck4Tko5CbJvMzFsNuGfhIDUS5sECE1gGbkFST0OMgpz8X2qRKuIsqSGlRs7kADbxLP3x4Jveq2MlkWhDQa+3nIzW5/lc1K+UC2ERXLuSjAlJ6JMmsK9B9Fh2/DBuRIhB/Caa1nHakOdZmijPzUAmNpx/1TxbnxqoO2nBp5v5bb/gUCiCcWTzY1rqzSuRj11ivq2z5QZefHjAxIdpsePjD3vutIrM3kgtGoEpCjhW4OSLYn+BGhLP4Xk+tMpgIHfZom7Nurzk3GQszJIz9SENn0XCIo/b1Bpp6vYC8yAA==
Received: from MW4PR04CA0209.namprd04.prod.outlook.com (2603:10b6:303:86::34)
 by SA1PR12MB8841.namprd12.prod.outlook.com (2603:10b6:806:376::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 18:50:16 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::a4) by MW4PR04CA0209.outlook.office365.com
 (2603:10b6:303:86::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.44 via Frontend
 Transport; Thu, 30 Mar 2023 18:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 18:50:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 11:50:03 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 11:50:02 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 2/2] null_blk: use kmap_local_page() and kunmap_local()
Date:   Thu, 30 Mar 2023 11:49:26 -0700
Message-ID: <20230330184926.64209-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330184926.64209-1-kch@nvidia.com>
References: <20230330184926.64209-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT016:EE_|SA1PR12MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b496f2-bdec-4429-8bb7-08db314f9a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/TMbYenthV0ltAQMXMvuRTDEVZoFr86OqjpttfvEfAH/P2ZMnJdve3Ek0cd8whlKqmr4WI79TreM865tykVYfch+VdVtDt2truJqOPoUXQbCsrw8GOtnjmA6InBK9F8LDcZA0Op1YllOna61vE6NA7wIw5viXK+qP18w4xNe3ak/mJkWi55ZXZBE0YFT9VRAo3wKPmgaWI3YD6d+qQFGVnYCoGv3e6CEKhA/R/iUzitCW6nmhjigXZA0RwBQr3Houn7a9mu0JbJgmca70CC7oPt6EsX7PeQdlus83NwKaX2yN23zWeKGtMWKykwUA6q594Teu9MTn3oS48OQ8ZwYxDVmVEMQpsBfkViHlVk6LJPQ/DF/GwZsUPnXOvAkbfM/x56aNkymmUf/zCibebDmslUMerQM+K208Ww3V9GC4cgmqVls7KeQVO4HVu5HY8pwPJwOUb5yjWar9GLUAFn9Ltivs0e9DZDWO4X7ZrusFAk/E9Tnj75POWaG03DS33Kxeuq4vmGLdPbDL0cba5BLeY1DqZVBnKC44mT91VE771EslsAEfl/995uOhU8D2evZYxFUV9OcSu5UvQ82NUpeVZJ0VxYiKRJCtNIWofsSaBbt/jPM745TmyUxkLiq6H43R/SaXW1+tCmMAWRnYQkQG/KX/izfSreRfceN537VQOB7EzO8feNvylLn2igfhU/fhgZsodVnCeT7VcxtPaT3gE7Xzof/c36mo/J+TDY+f1Em/fCLwRbGxjrtbXuwdCkQnnxHSkMmIFS9UR/QSMwBMrd0afbA65itXiaRAsd8B0naVIRqQa9GGYgnWS9fP1k
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(47076005)(36756003)(70586007)(40460700003)(7636003)(4326008)(356005)(8936002)(5660300002)(82310400005)(82740400003)(6916009)(8676002)(40480700001)(70206006)(41300700001)(36860700001)(83380400001)(34020700004)(426003)(336012)(2616005)(107886003)(1076003)(26005)(54906003)(2906002)(6666004)(316002)(478600001)(7696005)(16526019)(186003)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 18:50:16.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b496f2-bdec-4429-8bb7-08db314f9a30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8841
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the deprecated API kmap_atomic() and kunmap_atomic() with
kmap_local_page() and kunmap_local() in null_flush_cache_page().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 41da75a7f75e..bc2c58724df3 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1030,8 +1030,8 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 	if (!t_page)
 		return -ENOMEM;
 
-	src = kmap_atomic(c_page->page);
-	dst = kmap_atomic(t_page->page);
+	src = kmap_local_page(c_page->page);
+	dst = kmap_local_page(t_page->page);
 
 	for (i = 0; i < PAGE_SECTORS;
 			i += (nullb->dev->blocksize >> SECTOR_SHIFT)) {
@@ -1043,8 +1043,8 @@ static int null_flush_cache_page(struct nullb *nullb, struct nullb_page *c_page)
 		}
 	}
 
-	kunmap_atomic(dst);
-	kunmap_atomic(src);
+	kunmap_local(dst);
+	kunmap_local(src);
 
 	ret = radix_tree_delete_item(&nullb->dev->cache, idx, c_page);
 	null_free_page(ret);
-- 
2.29.0

