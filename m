Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1B7C433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 529C661376
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 15:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEKPya (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 11:54:30 -0400
Received: from mail-mw2nam08on2075.outbound.protection.outlook.com ([40.107.101.75]:21728
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231839AbhEKPya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 11:54:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlCazRqnmmDEEkINCiMafLz/qBx30DnyGP3U2+jjBc2K/nlskWxWC1PAxlnjNykmSMViKvIzpj6BCHTB/jpqonCVPQ12MEvqcZmqj4G4Zkj3dwAGRQgJV0USAYnfzxfOrWYOVzGN2pXVqZYsOYqrL1TlX9z0R0DhI/3QJgzlX26/wd0+W4skCFRdhQs4j1E82FOqjsvUxXJJiqyDczKmEG6W3GTUrHhO4GxsxMyspZ6xjDP5oB9zJdowToiPyOYRRJ8o9kuhhkZmjnGCuFUEG6Qlum1mvQIZdc2PZko4e3JKkQNmOpxXbSsX9D9EMjK8Lir8pCOVnKabyl5Ao8TKWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nROV7X6PKNE2vDmY9ky2PijbvDaeTkvZ1h7k37H6Yao=;
 b=gqbuNooT6Louhz35TzYOmh7ktST6AsGeYZIN4eEndHmbgmttU/JT2RxctOvVUGm+NH7upQF3/avxPAFnW3D4dRLeoW7z4SG8xqtnVLyDIVjbDuH5OHKzTb0PwlDpXFk35YEjsNkE14JuR2VfJmVC6U3XE2OzvorxIeDdgK648/O0w1yRTM/Ny9P37JWFrSkQWXH6rd7c2x2NGqjBOClC3SdyKVABr9pJ0RXOvDp3eaIsa0p8HtFg830YByoe+uHK7qGcJSwdZ3hf84OVRRjdE4XGP/p/DK27+x5zQMOxzoxDrFViyInMlWcLFz0VCT7nZJ1Chk3H06ZLadBG7puEYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nROV7X6PKNE2vDmY9ky2PijbvDaeTkvZ1h7k37H6Yao=;
 b=NiJ8bYuILhnfugIZsZkX8PdbcQJO8JXN2KtipScFcARKZ5dBiNOQLKr9qFdDE8klAG3Yxed+SlBCA1RKl6Y3ekkURq88GjjygYaclXmPv/s50IMAB0WMpFJZj1+4xLNZh+Rc9/u1cnUNUFVFxLoNIBJT/DrM4SxZukDoDK0KyNhjGfQnw77/lSWgK3xLgwaJV08MZQi5zpZzDjSgxxpsOSH88xeJvvCO1zKZ/excobXOjYHcRRhEMu7vKtahGzyPlwroBH5fBHVGtNeBNMPl177lEUu85uoGK3Ko4yuCEo4fnBMCZfdQ9O+Ca8kJGDmgD4A+9Cqu9y2/HL6qtThKIA==
Received: from BN6PR13CA0015.namprd13.prod.outlook.com (2603:10b6:404:10a::25)
 by MN2PR12MB4013.namprd12.prod.outlook.com (2603:10b6:208:163::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 15:53:22 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::54) by BN6PR13CA0015.outlook.office365.com
 (2603:10b6:404:10a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.20 via Frontend
 Transport; Tue, 11 May 2021 15:53:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:53:22 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 May
 2021 15:53:22 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 May
 2021 15:53:21 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 11 May 2021 15:53:20 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>
CC:     Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] block: remove unneeded parenthesis from blk-sysfs
Date:   Tue, 11 May 2021 15:53:19 +0000
Message-ID: <20210511155319.1885277-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 171cdf4d-5f03-4511-b76f-08d91494e7bd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4013:
X-Microsoft-Antispam-PRVS: <MN2PR12MB40135E700CDEFC3224FD2155DE539@MN2PR12MB4013.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:277;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RVdEwaBDnQobbj+qTS5z9A7+K5RGrYICOwa+rpu141809uqqqw4P5oUTZb0OUvvo1eJcwTtPT6SB49d5qQkPKrSLI9hWsqzIdbT/FeWV05GRL/c/R7lW0n70CCzzS8SLLYktixyHMvRqkSyKnF+i/jht3E+SycjpSesH19ziY/ohJgctvltGYz38I4gMIt4BygtXGmDojjNwDslL7Y1eKJVjy7OUSh6eoBngliHHFgRrUCGMjwCErwqpJlys4eAVZHcxr+BsRlPL1xTR8RF88/pPnS5FD0OtZe/66ZvpeaCFOv1LaHV48Eh4lKnuj37Dm9bEkBYRdBlB9dAG3FbuliyneBTioV0eoG9jxRB4Bs6j0QW6n9W47T/PnztnYTzMxUWXviRGG17tD6t9KSPaq8Nbv6jA6SpeDzeimFLPQ9c0m8QEVdAwk2dS4VGjPmtRVAyd16+R40ZhTLYSRwZzzD2PaaNLcL2yuFb+IknhY0LJZSitwJVrHJzUcUl1LjyX65i9TjYOzZbZQlIuoYKvy5Hlw4PtzhZD0Wxl48ncRoLCidJyOj+DqUaAQiTZ+k9hNCNEmB3M54Z0tgGI2N5EvI6GnNrVaCjtYeuQ01aNdrFK1Ufcg4y1IZheyeSAA7gRSGrRwaw5pNQ37dyymn/JKtsgh/kvNjVqP/zVdG4w0jU=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(36840700001)(8936002)(1076003)(426003)(8676002)(26005)(336012)(2906002)(4326008)(2616005)(70586007)(36860700001)(7636003)(356005)(82310400003)(107886003)(83380400001)(70206006)(186003)(110136005)(5660300002)(36756003)(86362001)(47076005)(82740400003)(36906005)(478600001)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:53:22.3472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 171cdf4d-5f03-4511-b76f-08d91494e7bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4013
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Align to common code conventions.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 block/blk-sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index e03bedf180ab..f89e2fc3963b 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -91,7 +91,7 @@ static ssize_t queue_ra_show(struct request_queue *q, char *page)
 	unsigned long ra_kb = q->backing_dev_info->ra_pages <<
 					(PAGE_SHIFT - 10);
 
-	return queue_var_show(ra_kb, (page));
+	return queue_var_show(ra_kb, page);
 }
 
 static ssize_t
@@ -112,28 +112,28 @@ static ssize_t queue_max_sectors_show(struct request_queue *q, char *page)
 {
 	int max_sectors_kb = queue_max_sectors(q) >> 1;
 
-	return queue_var_show(max_sectors_kb, (page));
+	return queue_var_show(max_sectors_kb, page);
 }
 
 static ssize_t queue_max_segments_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(queue_max_segments(q), (page));
+	return queue_var_show(queue_max_segments(q), page);
 }
 
 static ssize_t queue_max_discard_segments_show(struct request_queue *q,
 		char *page)
 {
-	return queue_var_show(queue_max_discard_segments(q), (page));
+	return queue_var_show(queue_max_discard_segments(q), page);
 }
 
 static ssize_t queue_max_integrity_segments_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(q->limits.max_integrity_segments, (page));
+	return queue_var_show(q->limits.max_integrity_segments, page);
 }
 
 static ssize_t queue_max_segment_size_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(queue_max_segment_size(q), (page));
+	return queue_var_show(queue_max_segment_size(q), page);
 }
 
 static ssize_t queue_logical_block_size_show(struct request_queue *q, char *page)
@@ -261,12 +261,12 @@ static ssize_t queue_max_hw_sectors_show(struct request_queue *q, char *page)
 {
 	int max_hw_sectors_kb = queue_max_hw_sectors(q) >> 1;
 
-	return queue_var_show(max_hw_sectors_kb, (page));
+	return queue_var_show(max_hw_sectors_kb, page);
 }
 
 static ssize_t queue_virt_boundary_mask_show(struct request_queue *q, char *page)
 {
-	return queue_var_show(q->limits.virt_boundary_mask, (page));
+	return queue_var_show(q->limits.virt_boundary_mask, page);
 }
 
 #define QUEUE_SYSFS_BIT_FNS(name, flag, neg)				\
-- 
2.25.4

