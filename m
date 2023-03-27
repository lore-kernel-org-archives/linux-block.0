Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DE5C76195
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 07:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjC0Hfq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC0Hfp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 03:35:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2097D5266
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 00:35:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3qGECjq/4rTCVLuQek1P9sCaNqT3DrnsttxvVP/i0Fsu3w5p+K9UqOk5mKSNFYDmDNPugEX6eE5hX2HxUsqcQTGArHUlUh6IlIWbcsj7I0Fk7wLH62Ko91XKw4ajerpnPEfc67dvyh7u8KpKuwGRCTGr+jkvKvZLZbHAbQBi/10Yy/6Dpf2Y9Oo9iCW1qrvbypu9eg4dUG6eLQSTteEqgAsgvwxuqiOy/dmdTdEYBeKAH/8n4s6L6x1YVV1yn2Dnm8hLNzbrS4+jXN2XfPL93aD3dh5l0l7UHdsC8kEheuaDereSsZjFLh3dwn6VmOUgZR0L7qveZ+h01l35IsJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2RwlGRbZYOwMnCaC1eFZf9sTy7GQUbQNlAGI4LASKW0=;
 b=AKP1r/KiGbPAO1eHsEytKlcc46KT8imVGwLGB00ixo9sACPMROdXqdAGUFjZZV8SHwxmGEG4rGRYo0O3j+yNRAMc2cQj52Pe6RHy5C2C0bGsQG7gXTnIMnjOHDWMqtdWGn6zD77lY7GPMR8GjIGiGlwSqdg5EcwSV0rBJw/Jn8tUqkT2Z4wCc5COyBedMfhen6f4Ir+bzha1Kn5eAHn4fMzJzx33+6axhNkuPcAT3FAUP0HdVOqjTOkRwNd0MmKxqgkyanMEFiIu4alSlP7Mvv8GGxRq8IvuqECkMqsJXXucHT5eGn1mM5aqLZIZOrwSRQpfMuaaFgZwkTX576C3MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RwlGRbZYOwMnCaC1eFZf9sTy7GQUbQNlAGI4LASKW0=;
 b=BQQxhqtOd6sFp2VHruPdhFlUpWt3F1PSQS8/wdZqWW7JbvWAU3vbs/CMPST9C2AQmZ/QMvyGuWg5B/Qz/lmuceL8JPu0HsokMzBy1qT3JnOP/SbJFvKXNZN8H1ytlYnXo/KMDkGhtnq+tVvD2pKpG240GyV6bN8h8Qj8MigGoFGnpTWTBfQT1bbH1j7jGhTqukyz0vtxB/TuyX5yKuDcdEtEOoXhcGsPnDloMT1J/5bgXYIwE8YzsuNxWKGaqwWBUFi4RSw8CA38sz7AAkIgiDMHJN13g6o5e0X08YclBuXux62E9OJUdx5nAuMsRBSn0N71DMlGEGrXMG2sgvh32A==
Received: from BN9PR03CA0706.namprd03.prod.outlook.com (2603:10b6:408:ef::21)
 by DM8PR12MB5413.namprd12.prod.outlook.com (2603:10b6:8:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.30; Mon, 27 Mar 2023 07:34:55 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::47) by BN9PR03CA0706.outlook.office365.com
 (2603:10b6:408:ef::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 07:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 07:34:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 00:34:46 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Mar
 2023 00:34:45 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] block: open code __blk_account_io_start()
Date:   Mon, 27 Mar 2023 00:34:26 -0700
Message-ID: <20230327073427.4403-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327073427.4403-1-kch@nvidia.com>
References: <20230327073427.4403-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|DM8PR12MB5413:EE_
X-MS-Office365-Filtering-Correlation-Id: f66448b8-5baf-468d-7b0a-08db2e95c2b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsH5APHKylYWDftVyfXKHzwkFgGkretoJ6VIr+MtuhQ6ueC5BbjzQP74crykVA5OpawgHyAVq0WmqjSzJJlR0kVaekxK0uTtNkRcoDlCXhsMILs11GL1AajsqSHn5VF7ywU5Nk3+Sdk2T4C8AzHXwPwZg3tlLAALluAdF2CZt86AEYoebRgISH0OXYsLmqiSXK7Mo0T+5MO17/0vDo3E9Jv545yQv3aT5+4iuHtgev6nyU9V+MA+1+NVn/Q7DUeP5ID24TUtaEG3shwE181vWBUVS3DIX/6IxIkAKu7WWsPp/hrJlPtAlpRSDrA/pkndxE0lyZ4ZRyIFqy6Fud26UikoOzAowo/oY3ZnX1EYhLX+mj1G4xwNaRcxBdYy8BmFbzzOoQ3aS4k6oExO5FQ+YJCc7idnKrJAfiSswx1kQJzAESyw1RuM7Y+Y+aQdUuda4Z9PgVEkUyzTdTktGSuEmfPa0yAE+rYMGj/JGp25V88+7HXTXaigKWpWcvs2oxoNXZuUILpp16oVkOMbUFh/9QuRJ5ztzDK6PmR+Gz6mydrtM3W6O3/v7mjRHRMq/uQ9nt1LEkQkmthcRUjueT7VGIRD08XxBW3/WU2bT5E//aEBV9X9gD30+dLnZIsLiilZgKdV4pymthrg8NlaFmYuzbrayt5hpeT+AoHqWZ/Gd8dSzWMR8HxJ1TKwbKUXb3a15PdaXqOBgqgvX1OUEIBrafPbqvhcHK7FZKhMHzaJ9hL7K1k00geI7kpTP+VP7FGuNrJewqRh0zFlqy7LHuo+my7rJ8YQZMaPIqREHPHEYaE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(16526019)(40480700001)(41300700001)(6666004)(186003)(107886003)(7696005)(2616005)(83380400001)(426003)(336012)(47076005)(478600001)(54906003)(316002)(34020700004)(36860700001)(40460700003)(4326008)(2906002)(6916009)(8676002)(70206006)(70586007)(82740400003)(7636003)(356005)(36756003)(82310400005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:34:55.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66448b8-5baf-468d-7b0a-08db2e95c2b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5413
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is only one caller for __blk_account_io_start(), the function
is small enough to fit in its caller blk_account_io_start().

Remove the function and opencode in the its caller
blk_account_io_start().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c | 36 ++++++++++++++++--------------------
 1 file changed, 16 insertions(+), 20 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4d8d88d55217..f514128f7dad 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -976,28 +976,24 @@ static inline void blk_account_io_done(struct request *req, u64 now)
 		__blk_account_io_done(req, now);
 }
 
-static void __blk_account_io_start(struct request *rq)
-{
-	/*
-	 * All non-passthrough requests are created from a bio with one
-	 * exception: when a flush command that is part of a flush sequence
-	 * generated by the state machine in blk-flush.c is cloned onto the
-	 * lower device by dm-multipath we can get here without a bio.
-	 */
-	if (rq->bio)
-		rq->part = rq->bio->bi_bdev;
-	else
-		rq->part = rq->q->disk->part0;
-
-	part_stat_lock();
-	update_io_ticks(rq->part, jiffies, false);
-	part_stat_unlock();
-}
-
 static inline void blk_account_io_start(struct request *req)
 {
-	if (blk_do_io_stat(req))
-		__blk_account_io_start(req);
+	if (blk_do_io_stat(req)) {
+		/*
+		 * All non-passthrough requests are created from a bio with one
+		 * exception: when a flush command that is part of a flush sequence
+		 * generated by the state machine in blk-flush.c is cloned onto the
+		 * lower device by dm-multipath we can get here without a bio.
+		 */
+		if (req->bio)
+			req->part = req->bio->bi_bdev;
+		else
+			req->part = req->q->disk->part0;
+
+		part_stat_lock();
+		update_io_ticks(req->part, jiffies, false);
+		part_stat_unlock();
+	}
 }
 
 static inline void __blk_mq_end_request_acct(struct request *rq, u64 now)
-- 
2.29.0

