Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE89C74A5B
	for <linux-block@archiver.kernel.org>; Wed, 29 Mar 2023 20:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjC2Urx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjC2Urv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Mar 2023 16:47:51 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90084C30
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 13:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EX8JzWiSYNZ5Y19qQPAI651WfZSQ4dMTJfl8BreQn0FJsh0u274pdrbuGon6Rlr4wQ4dZ7tfvJtt2wJr1bWj+/v0nYASERwwaSc0XIfgLErl1gxi7nPX3LIs7cU4D73uVVBYgQA2PnEvL70SS7M9iH+rvoV4y4DsdZOrVOhAOx5bQuLca+YdweynVC6gSRS03R2jbNGP2xQT1zxyfcclHUbfzaXBGS5LePuGlN5ahQvZk+m09iY+lculgSq4T15npTZfbpjqhJOGrsAMFf2NSnzalOfHlDulvpXtZXC0aKEBYoPBMiyd1jIKpqGc+w+MGJCrVxIH0eyU+wRzicRviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwTeG1Fg0h4XFbMPuGPABmD+RK0S4M+NKz5lIgyblnU=;
 b=JC6nOoVcmAJzJ7MfCpow0uJd0GUCPS+mUi+pB6OQwvZiNZYS9yar4lAqZ9j02TmD8PSbJwgCNstz187weinuk1A6lQx/ezQxjP7CAKrP7Vbj95I8AMxM5aD+Q1YtJQmeVwOSOj18aa3twA/ZWL3lQBWSh7iy/VXTEXGHyCh9Me6W9sjRU7wnac7JEqrYI4DnXtqscY+2M+z298u6sKl8vCv/+Jle/hW6e+/7b0Bm8tczXSzXfzKBhxZConRiJxZ+SR5rjrTyBOCvpYQCqxWR+Jwprl4BMkU8hObEDlQfLgyRDODDNJJ/0gPbSlzK4NUOWOOCtI1CCUAkn8q4PBLMWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwTeG1Fg0h4XFbMPuGPABmD+RK0S4M+NKz5lIgyblnU=;
 b=LNy9vdTBPPv1yuvds9hf3V5tpawfwZerkylmAiBQaiXjPDpevnh7gae/TQ1dB1RqoatVXJlhj+d6XCCLdd0vXuEiGZQaqFlhRBPNithf29bjdIGInTmuGJcc+7QxBq9jE+FR0JDlZvMfNyqzVWdMgjl1PzLE9njbTlRUF8C4dHQYXx4p0iPQacU4XFB909Bh1TQCcU/zbQLqr5mYYS9+B0tqiQA3Oks+2XWwxKslWoHVp9NkFmqdzXa8xlAdkvXuu+Tzom68C5fpSpcclqOXCTDHQKDuKPz2EaZ8aBSMQltQ9r4KJqTdUhYoA2nxEeS/JWMt4dgofTQqX9/A8gn21A==
Received: from DM6PR07CA0069.namprd07.prod.outlook.com (2603:10b6:5:74::46) by
 SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:47:31 +0000
Received: from DS1PEPF0000E62F.namprd02.prod.outlook.com
 (2603:10b6:5:74:cafe::54) by DM6PR07CA0069.outlook.office365.com
 (2603:10b6:5:74::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0000E62F.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 29 Mar 2023 20:47:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 13:47:22 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 13:47:22 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <kbusch@kernel.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <error27@gmail.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] null_blk: use memcpy_page() in copy_from_nullb()
Date:   Wed, 29 Mar 2023 13:46:50 -0700
Message-ID: <20230329204652.52785-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230329204652.52785-1-kch@nvidia.com>
References: <20230329204652.52785-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E62F:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 53bad0df-04b3-4b59-2657-08db3096d0c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rWR8JJdut5ZJu/GucW/8axTkRyjTg8OkYSs4ishKEXjv1PQcL3qm6wEP/XkXyLmZkhE6SM5NqRgXHuxmeu9oYS8x02whKOu3jPaTqwSAW/4eMb8wIktPbObDjp+02RLZYVWhzv9k22fFR+sEuaYl1h81Y4lu/IAywZqCz94p50A79uBjv2UeSWy63iapKfPjVYTFIvjntR+5TNrd8CwVT1PRgDS86+GQbfdmsd3PwthZh5mw/o02psbRWRj6idNt1PHL3+Vrj09CKjGETg4IGYFGc+mt1rKpWq1yZ6ZTeDE6uh4L+goRAhHIkCP7w94wkulVkcF/W4JJSg6xDO00GjMiAIr0tbSASmCIPKAeX/TNgyL7mhPzHctvzPJ3QC8tZ/WNmWi7kY8W+J/DG5sm1WswOULPyC6BkxfE1gxgERPF4a3qqT0aOJfMt35YAPeqG36Zq7ILe9ToRCPkf3tAEgobO/fmW38mGM0wllHZbPTA1EICN8AWOF8Rf7P06t/cG96jlornNABexDqk3de/q/hgbhX3jnuM6YkVfl+x2wrjs6MYNSwKiLM5TY4kaqSrQrce+qCEHp31qHJ8DQdzoncV2Aj+J/mDK41jlrgx88Z3ZbPliFuE0JfMp15q+DD+MEfCCBii3n+DXmz6jmIzJwT4yxnzGDmQhX9VoXVMW392tugOcfrGzZGu7InmrgJPy0u47PjFAXeezy+hUpONouJU6o20xa8HtxfaSa6mxFwOaiIeKwSDWR2SO7LKGRLi
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(36756003)(6916009)(70206006)(4326008)(316002)(6666004)(41300700001)(7696005)(70586007)(478600001)(54906003)(5660300002)(40480700001)(82310400005)(8676002)(2616005)(8936002)(2906002)(36860700001)(7636003)(356005)(82740400003)(1076003)(186003)(16526019)(47076005)(107886003)(83380400001)(426003)(336012)(26005)(40460700003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:47:30.7303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53bad0df-04b3-4b59-2657-08db3096d0c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E62F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use library helper memcpy_page() to copy source page into destination
instead of having duplicate code and zero_user() instead of memset as
this removes deprecated API from :include/linux/highmem.h:
"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 947bba174e1e..2b344dcb4382 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1144,7 +1144,6 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 	size_t temp, count = 0;
 	unsigned int offset;
 	struct nullb_page *t_page;
-	void *dst, *src;
 
 	while (count < n) {
 		temp = min_t(size_t, nullb->dev->blocksize, n - count);
@@ -1153,16 +1152,11 @@ static int copy_from_nullb(struct nullb *nullb, struct page *dest,
 		t_page = null_lookup_page(nullb, sector, false,
 			!null_cache_active(nullb));
 
-		dst = kmap_atomic(dest);
-		if (!t_page) {
-			memset(dst + off + count, 0, temp);
-			goto next;
-		}
-		src = kmap_atomic(t_page->page);
-		memcpy(dst + off + count, src + offset, temp);
-		kunmap_atomic(src);
-next:
-		kunmap_atomic(dst);
+		if (t_page)
+			memcpy_page(dest, off + count, t_page->page, offset,
+				    temp);
+		else
+			zero_user(dest, off + count, temp);
 
 		count += temp;
 		sector += temp >> SECTOR_SHIFT;
-- 
2.29.0

