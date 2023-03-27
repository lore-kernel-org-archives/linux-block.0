Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94014C7619A
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 07:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjC0Hfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 03:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbjC0Hff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 03:35:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29290527A
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 00:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdRzKYMTsErXrqOT6ebHaq3bgg6MPnAi8fAjd784FmTIebBciObfc+jqov1+bJPmmoZ4LpQp5DmZn/M9FCPgzgiUu6JLJrjLjoT8dY5cvvM2fF3DovmBUHsE2fr3bS5htyHIZ4Wm2bFk7cyIPAHugdTGrlw2Cldycb11K9lu6Azg7Nt6vr5oJtWr8AiD37IYQ2NuXX20WxLYqsWRTdkyjZEqzMkCwXjS/PSBYP27kgXksv1xoCZsBnkMJRMvhVTu1Kt1m10KKiS8iHdkgALYoBCstK1Gk+FKodZCWmALFH8pq9TU0dyDVB4q75LyutJfH9Oz2WWsOyalm1blUcO0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrH6vCp4+l0HL91ABe/7+CVygcVguYjesNrlkI9K9e0=;
 b=dhQLJ1Y+vPdiVvqdXp6oAjSrSuonQZjfB0WBApxla3iOhTMlNEfbdo4tD6xkekAm3DwsCdLRVyEcXwtvItHlox+WTFFGp54pQpDWdyIuyUJJuiHsnE5WXuANEbTOMdk4pbIJC1XEdG98G5vt7g9oLSlobmkSTG86AZl3xomfz81ozvaHbUajBDjBWqV5sLL/ZAm9LTMnid8pZTaKHIJILHo7JRv8mie+5hxZlp3ZHxmsXb/h17VLnjGqi+sfYpV3GoChjlFTaT6Jiuy2X78HMNfQOTUcnXPlBFCYH275Idy6TXDtzjDwmH7WAzDzMAAXEvLEckozGeIGcRFrE7S+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrH6vCp4+l0HL91ABe/7+CVygcVguYjesNrlkI9K9e0=;
 b=DvVItwHKtkVGCM3Vc4cezXmATGpHbqByfYrEvpRsKLwH2h2J4TG4cv2C43XxIzPLLLvBt6SoaxU2ujcrHY4i20rr+p+Dfdq5wCxM9cJotMNzLWQh3+YtK1BJvDrtCE3p7LbBrPtbTv0y7O9js5dH5ROHOBeKpZdOSp9bh9jog447FCh919aFo2aMQGaLvb5XB4KAoB7rM5N3K6C2JUsE1IyiEiA7dk29/bEIC5NavOgENJZY5W093ArfChPfV7TkBJYR6QiKxOL/G3TvYFIuro7rRdb0sfgEYituCE7Krx7aJvpmdkXtmpcIODPTovTQgrRe29g8XIX2ZLVxN5EI3Q==
Received: from BN9PR03CA0591.namprd03.prod.outlook.com (2603:10b6:408:10d::26)
 by MW6PR12MB8760.namprd12.prod.outlook.com (2603:10b6:303:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 07:34:45 +0000
Received: from BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::3f) by BN9PR03CA0591.outlook.office365.com
 (2603:10b6:408:10d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 07:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT071.mail.protection.outlook.com (10.13.177.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 07:34:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 27 Mar 2023
 00:34:34 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 27 Mar
 2023 00:34:34 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/2] block: remove unnecessary helpers
Date:   Mon, 27 Mar 2023 00:34:25 -0700
Message-ID: <20230327073427.4403-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT071:EE_|MW6PR12MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e57d73f-35f4-48e7-5557-08db2e95bcbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yToeo1bVuZMs3hBD6HcyUeO2IGR3K76tSrt0xxScz84jzP3BTZ1AdX7bCGqkHHpJfPpk8KxvcoATSBIhiGDWk+qpcPRnK14JsPnpRS6uNjqC9sZYZXCSq8nbv84Kre0d0+Su1whm2Nxya9+z8DkFkX1N2V8zCPKMWd+o7U1WvSRVvJrAao88OJ++wlNBqtSYtzajzTgpyk6dx4WyI8chSCUFrPXHAsu7Exgkj2rRWqV3riqPJTrfaAgSzJAWux2bWqa0DNBcG2L0WY9EmsdnQxnFcFUd93bT5cAJZIQO7plZ4nQDNPDUFjggvBij0bMLwJ2VmHq1WH4ernTk450qcKtZCrvOHbjTomYRVSdQjT+F7AKLedlA7qhWQrAemfxXbbcr0Z48yPTUPQ8QkA6Ipz1hF3xdK3J1HFyNqYFMZY6gz8mnUCzLdjQrQG+FzcapCeMFIRZLzalD9KDXauL9XVTpgsrr229uPvYkChGNcSJwXa0nB0QIF2r7aXdDllgsOJTjt69T1E5ug4u4JL+E7JOKsp4BV6BKvdqlDKexmlrlTYJErGec5RwSF1Ucinr5KtxfF51wba5YVdZBPNgIErRZ0+FEgsa22ikOON0pkPMMFaUzIrI35oyc/nhF+eZszLj67KFhaCMDiibRCpT+xPdHMkAnbZ7vHWw8tDAXRpy1TLcxt/BpiuxL0hZRfCaKzU4lL6bf0lppp6XjS173Yz2V3eOQwmXe7JW99vux0pphwpfpz/+QpFmjK+W8djXpHWjeBfwinsJve2XCnkGEUg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(16526019)(40480700001)(41300700001)(6666004)(186003)(107886003)(7696005)(2616005)(83380400001)(426003)(336012)(47076005)(478600001)(54906003)(316002)(34020700004)(36860700001)(40460700003)(4326008)(2906002)(6916009)(8676002)(70206006)(70586007)(82740400003)(7636003)(356005)(36756003)(82310400005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 07:34:45.2686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e57d73f-35f4-48e7-5557-08db2e95bcbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8760
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

There is only one caller for __blk_account_io_start() and
__blk_account_io_done(), both function are small enough to fit in their
respective callers blk_account_io_start() and blk_account_io_done().

Remove both the functions and opencode in the their respective callers
blk_account_io_start() and blk_account_io_done().

Below is a testlog with simple dd write command on null_blk

-ck

Chaitanya Kulkarni (2):
  block: open code __blk_account_io_start()
  block: open code __blk_account_io_done()

 block/blk-mq.c | 56 ++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 32 deletions(-)

Debug diff :-

linux-block (for-next) # git diff 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b304f66f4e8..c04fbe7cebc1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -960,6 +960,7 @@ static inline void blk_account_io_done(struct request *req, u64 now)
         * normal IO on queueing nor completion.  Accounting the
         * containing request is enough.
         */
+       printk(KERN_INFO" <<<<< -%s %d\n", __func__, __LINE__);
        if (blk_do_io_stat(req) && req->part &&
            !(req->rq_flags & RQF_FLUSH_SEQ)) {
                const int sgrp = op_stat_group(req_op(req));
@@ -969,11 +970,13 @@ static inline void blk_account_io_done(struct request *req, u64 now)
                part_stat_inc(req->part, ios[sgrp]);
                part_stat_add(req->part, nsecs[sgrp], now - req->start_time_ns);
                part_stat_unlock();
+               printk(KERN_INFO" <<<<< -%s %d\n", __func__, __LINE__);
        }
 }
 
 static inline void blk_account_io_start(struct request *req)
 {
+       printk(KERN_INFO" <>>>>>> -%s %d\n", __func__, __LINE__);
        if (blk_do_io_stat(req)) {
                /*
                 * All non-passthrough requests are created from a bio with one
@@ -989,6 +992,7 @@ static inline void blk_account_io_start(struct request *req)
                part_stat_lock();
                update_io_ticks(req->part, jiffies, false);
                part_stat_unlock();
+               printk(KERN_INFO" <>>>>>> -%s %d\n", __func__, __LINE__);
        }
 }

[   79.477154]  <<<<< -blk_account_io_done 963
[   79.477155]  <<<<< -blk_account_io_done 973
[   79.477157]  <>>>>>> -blk_account_io_start 979
[   79.477158]  <>>>>>> -blk_account_io_start 995
[   79.477343]  <<<<< -blk_account_io_done 963
[   79.477347]  <<<<< -blk_account_io_done 973
[   79.477354]  <>>>>>> -blk_account_io_start 979
[   79.477355]  <>>>>>> -blk_account_io_start 995
[   79.477538]  <<<<< -blk_account_io_done 963
[   79.477540]  <<<<< -blk_account_io_done 973
[   79.477542]  <>>>>>> -blk_account_io_start 979
[   79.477543]  <>>>>>> -blk_account_io_start 995
[   79.477721]  <<<<< -blk_account_io_done 963
[   79.477722]  <<<<< -blk_account_io_done 973
[   79.477724]  <>>>>>> -blk_account_io_start 979
[   79.477725]  <>>>>>> -blk_account_io_start 995
[   79.477752]  <>>>>>> -blk_account_io_start 979
[   79.477755]  <>>>>>> -blk_account_io_start 995
[   79.477910]  <<<<< -blk_account_io_done 963
[   79.477912]  <<<<< -blk_account_io_done 973
[   79.478005]  <>>>>>> -blk_account_io_start 979
[   79.478006]  <>>>>>> -blk_account_io_start 995
[   79.478091]  <<<<< -blk_account_io_done 963
[   79.478093]  <<<<< -blk_account_io_done 973
[   79.478348]  <<<<< -blk_account_io_done 963
[   79.478353]  <<<<< -blk_account_io_done 973
[   79.478360]  <>>>>>> -blk_account_io_start 979
[   79.478361]  <>>>>>> -blk_account_io_start 995
[   79.478551]  <<<<< -blk_account_io_done 963
[   79.478553]  <<<<< -blk_account_io_done 973
[   79.478556]  <>>>>>> -blk_account_io_start 979
[   79.478557]  <>>>>>> -blk_account_io_start 995
[   79.478731]  <<<<< -blk_account_io_done 963
[   79.478733]  <<<<< -blk_account_io_done 973
[   79.478735]  <>>>>>> -blk_account_io_start 979
[   79.478736]  <>>>>>> -blk_account_io_start 995
[   79.478906]  <<<<< -blk_account_io_done 963
[   79.478907]  <<<<< -blk_account_io_done 973
[   79.478909]  <>>>>>> -blk_account_io_start 979
[   79.478910]  <>>>>>> -blk_account_io_start 995
[   79.479086]  <<<<< -blk_account_io_done 963
[   79.479087]  <<<<< -blk_account_io_done 973
[   79.479089]  <>>>>>> -blk_account_io_start 979
[   79.479090]  <>>>>>> -blk_account_io_start 995
[   79.479262]  <<<<< -blk_account_io_done 963
[   79.479266]  <<<<< -blk_account_io_done 973
[   79.479273]  <>>>>>> -blk_account_io_start 979
[   79.479274]  <>>>>>> -blk_account_io_start 995
[   79.479448]  <<<<< -blk_account_io_done 963
[   79.479449]  <<<<< -blk_account_io_done 973
[   79.479451]  <>>>>>> -blk_account_io_start 979
[   79.479452]  <>>>>>> -blk_account_io_start 995
[   79.479631]  <<<<< -blk_account_io_done 963
[   79.479633]  <<<<< -blk_account_io_done 973
[   79.479635]  <>>>>>> -blk_account_io_start 979
[   79.479636]  <>>>>>> -blk_account_io_start 995
[   79.479797]  <<<<< -blk_account_io_done 963
[   79.479798]  <<<<< -blk_account_io_done 973

-- 
2.29.0

