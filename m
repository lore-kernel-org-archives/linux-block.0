Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91303C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 07:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC0HgN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjC0HgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 03:36:11 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6713640E3
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 00:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gnk4KyVvPvEJYOnabel8wWbx7A0VXOfIZN8FfLr+aJyc+qls14cGgOsBSBSLxggg4073KAQhb21nJ7Inqwqpq2UyjW6L6LGai5Dg0Xz4tZO/dF0y9hkW87SZ/kz0e05r2IimbyMf/4cUiK5vthjwZtF1DGYH1L6yw5k7mToNxROtMWK+V+7QgKgXgGwJcRA4RpBBfE0RCW3OHK5Lb28y0kpPniiQa5OpmcoSBDJIt+lmUhyg5cG9ZKfTvbEjH8cYfo/BQI5db6pf1FgmxQgUicuifIF+Ggr8ZOuCqWzhmnwzlkH60fPU7H6mGebvvEwppnhH4y9XAQZUMkwK7ZYD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RzIQL+w0ng/PFbNguEE4WF5LM7zr2O4ky6fPLVA9Sw=;
 b=NfVNwSYnfwXHIU2Im36HnkZB5ceArFXRhZllasCcMOVXOqfMf0aToj2Lu0SnxmKsy3DXWUyufj+3Sd4R9UBmJtVJDMpagIMqp5ChNL0f6/gCnun1AVcOVfRav/svPErLq3nrfFSSq+lBwetFcWvUXZZrFgeFKPT+oEvK+Cnadw52YhpOH2kGxb8OlN/vwtrzbvqNDl6Q/ygWTSHp9B6GXRK8ACnNP9t9DbbVVYZ8ppQk4QPf8uvXcaFO5pgaQb4gEcJuIvoS4KbX1PAYXqvbQ6KFR81QF8xV7eqr5eD3F67cG1TPCOTDAI0ymWnmDNOZWVvJEz0eRvtGYJyJxdb0og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RzIQL+w0ng/PFbNguEE4WF5LM7zr2O4ky6fPLVA9Sw=;
 b=gSL3Z8xKA5m4DA6T6EniVBOSEdq3j1AK6gTOPATnhlL1d3GblMAJMGCQI4fneHsRyie+fW71o4MkWp41bco8XFNE3aj0gvFH5/vrpNGBwc/QFN3xHxnaGKwyvHBcUqXqC5fU6ldo0fJzFUOc9ubfzGaWIoi0SBC4FC99tlz6niXByuwntqErnvVDMKf0kLcxReMKKt8w0qQ5yKtaaA3o3f/XwiVnWRrzqcy9MYGeslanP/UfQTG0nl/DAxw8H/rjGd0XRv7vKPm4b8e7Oypzh91h4IkjKySJ0MooLnR5x5tUQi3DUl1HvegRofjiaUnem62oeDFny/GOm3K0WP7V9g==
Received: from DM6PR05CA0047.namprd05.prod.outlook.com (2603:10b6:5:335::16)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 07:35:10 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::96) by DM6PR05CA0047.outlook.office365.com
 (2603:10b6:5:335::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 07:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 07:35:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 00:34:57 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Mar
 2023 00:34:56 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] block: open code __blk_account_io_done()
Date:   Mon, 27 Mar 2023 00:34:27 -0700
Message-ID: <20230327073427.4403-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327073427.4403-1-kch@nvidia.com>
References: <20230327073427.4403-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e0596f-ed6f-4c83-7901-08db2e95cb5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hYUCh5oXMx1HJe6MNhQzjxrHe1o2C7bezwFQXkTzSxSWm3Hp3XlP7tB3jtz6baVLPeHFWWCPHo/rCUttKHguNbYnfPNCJ+TjIxzZIL0pGyShZKakMAiGCwgomxPM8FUYSQT8+Kaw3hQ8DGFxR7ZeGsUTkHFO+FLXn27ZxBXNICjPDR50dmyx10i5yEtnBTQ1/Y9hckNehmcxWorhnJ6mdiPcnrFL5pXATZrEnFZw8xALAbvMHqSNNEvmjJd6twWeYWznz+d2QqQGDJ47OVuiDWGy4Rm2cGuHFA7dUHPZ5aGHHgcVq9NO4DhAy1SLOXB9nj6DWVR96vOizlEgY+tpVXzFa9k7of4Qx0uyIKWN48mAem62vKc3M2NmHsfO4QZwx2Fw20aT3aEOUKwem2LT2IIMgjroE3akc+7r96+ZN5M/awvVpv+aNt7fmQyFHmj7hfULx9cO+ta4VikVudnH8eOrvT+bwLnDBLnUnuVlyhQXXxz1MT/n/sDeQPF9mhsWWtotc27HlU4Cj9X/62DQv6Ljg1q2fzU+oURCB06TWyh7qt1+qGELkRIepU0Wzth/hbl3zuWVSlcQFUqrb0Pzk3UpvhWPOe6yrvPlU/KQPee1QlGTWjMgELB5RObDPoTDnMbSLeBf8/0gEsQYmTJtb12095t9ggJKkwywV7buPQriqzIn5aF4pSD5Ge4T7pghzkRmV8LNUUeMwM1/t8AHYTFbOsJ7datf4evbMUYhR6eXltE8k3FtvvO8X/X+HuB
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(107886003)(6666004)(356005)(2616005)(7696005)(40460700003)(40480700001)(426003)(47076005)(70586007)(70206006)(4326008)(8676002)(82310400005)(82740400003)(41300700001)(316002)(54906003)(186003)(36756003)(16526019)(478600001)(36860700001)(336012)(83380400001)(26005)(6916009)(2906002)(8936002)(7636003)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:35:09.8374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e0596f-ed6f-4c83-7901-08db2e95cb5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is only one caller for __blk_account_io_done(), the function
is small enough to fit in its caller blk_account_io_done().

Remove the function and opencode in the its caller
blk_account_io_done().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f514128f7dad..c782d556488c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -953,17 +953,6 @@ bool blk_update_request(struct request *req, blk_status_t error,
 }
 EXPORT_SYMBOL_GPL(blk_update_request);
 
-static void __blk_account_io_done(struct request *req, u64 now)
-{
-	const int sgrp = op_stat_group(req_op(req));
-
-	part_stat_lock();
-	update_io_ticks(req->part, jiffies, true);
-	part_stat_inc(req->part, ios[sgrp]);
-	part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
-	part_stat_unlock();
-}
-
 static inline void blk_account_io_done(struct request *req, u64 now)
 {
 	/*
@@ -972,8 +961,15 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 	 * containing request is enough.
 	 */
 	if (blk_do_io_stat(req) && req->part &&
-	    !(req->rq_flags & RQF_FLUSH_SEQ))
-		__blk_account_io_done(req, now);
+	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
+		const int sgrp = op_stat_group(req_op(req));
+
+		part_stat_lock();
+		update_io_ticks(req->part, jiffies, true);
+		part_stat_inc(req->part, ios[sgrp]);
+		part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
+		part_stat_unlock();
+	}
 }
 
 static inline void blk_account_io_start(struct request *req)
-- 
2.29.0

