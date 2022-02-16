Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E858EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiBPJbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:31:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbiBPJbL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:31:11 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E906A25BD7A
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:30:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNaIG5qwl7Tc6pUkItQz6s3diIHXstRsGe0MMcqSFQuTf1otnhWVI8LgBi2Zc8gaLrntyOAddD0WgesafjcuG8Om+pYrA3+Cfl8Ssrihh9aNUaZuCNnqfnHQ1/3SDC4FgLwq6iJY8ldq8UbBaygpN7NhkoFmrTzHVjgoeSlOjvr4dW674BmuHdPJ3lNgNsU9JVAArH9QEN9le2h59PpxdXMLjTdxMF4GpT+4cJxmKmL0e1RjBUjWBuOcj9NXDSjbMc2F+S2cH3xUm064mM046l+XR+kdBc3VdyHiNkPytlw5YFru6GcvBducqhe60tG7VjrJgXHH1FBsP7LQ9yLE0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0JXwLE5ow7VXE722TKghz2cdmCWTL1yer0j6O9ddoM=;
 b=Gk+vGz+dsy2jrQJO1AazCytxxj2F/5LcQubiGZbj3+3FY4ZW1jr21qB9CZx+nNUyfYKWa6R2V0JBP8g1hv/SpxAtmI8kzk3zhJGJbDUwEJAFDZ8oaS3QO3auUtPMC09JADZkJEnJXQHWS7dtdk2yNkFXbJZbIqaP4lq4XaeiV0ny8ylVh6NGasbZ9iAH1wbyUf46cLh1b6ayVqpMylIT7RlEs1kG6xue76P9+kaVuiEt9vzbpUFUixtktGxWNars6kXC4opvxiVDRryLcfCWuQKwcOPpbFBJ0nigDzBWq7Ypu4mqeddX8gW/dqsP5xQqi7dhZyNSG9plAyaxiLYkgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0JXwLE5ow7VXE722TKghz2cdmCWTL1yer0j6O9ddoM=;
 b=fsjT/uOfO7T1M3e4U3L9xF4Gb6sDlN0y34pB5QljHXMRmy5aZFs8yTCRGJJobeWu657VZ59qSba7fu1Yqq7TjyzhbcmbqPfFS7tctmd8AeiyHP9t6ANWxf+pixb3/Fq0mf55qNMioEPCUr7VAv1w53D9CWcErJQvLX5sZex5kFb9JFyUr4Ecylcr1R31ccsSb0xIUk2Vb/3I/uL52r5VmKaZdpx42envrw52HBu/h1wFXep/ME4zkkgPvuuihZSnk9/zxnTRWCGotw+tToFJh3sI8tVElFMhfzoqgreA4aFUnHXBH3tfQRWmv1UJrvBNUfBEwGmCwm1rtD8qXpzlPA==
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by DM5PR12MB1403.namprd12.prod.outlook.com (2603:10b6:3:79::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Wed, 16 Feb
 2022 09:30:52 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::f1) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18 via Frontend
 Transport; Wed, 16 Feb 2022 09:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:30:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:30:50 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:30:49 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] null_blk: remove local var & init cmd in alloc_cmd
Date:   Wed, 16 Feb 2022 01:30:20 -0800
Message-ID: <20220216093020.175351-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220216093020.175351-1-kch@nvidia.com>
References: <20220216093020.175351-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be134ae1-fae6-4917-1fa7-08d9f12f0603
X-MS-TrafficTypeDiagnostic: DM5PR12MB1403:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB140359424B69AE95ECC3000BA3359@DM5PR12MB1403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p2BWdAVh8pIHskc1AJ2jgIVkrMc3FtOV7Jl1RuOrgChf8/XeZeoXMpmbdDuw7oRtE0gHaOQHs9GklD+l/kJD+7WZVS+dyUDHQPKhUBS9sInQlQaLAn0fyWGgJ4knkD/5V+UVMFUeL6CFGN91LqWV3viIVGl5W+PA/bM0qRZO+MZ5j7Sw7kMpIMgAlPBoFmgo/RdZVZydsBHOCgcnKX2CQzcV9mD/IDvgSg5XK9dphB+Jb0ehWRkBfuqkwuNgMbvxXuKUSMzHqQXpnRn+omPo/orvx0rQqj5K2EmZ56CAO2ZMMZb9sUN9+jK3EFGxOhPNqZH9XmPDhZuvpe8s6uS4G+9j6AKt2OMOyactvIr3LlqQd6bsevguABeJ6J6eEGJZLMXniWJaXGyXDzqMcx0iHUYQVr/MVROsZmz3AuOGJzVw6KMV6tRJk8JR3YP0ADphh6RW/1UHzXV3WRCURaFFy/yXk3A/gx7Bi5rECGhqQJrWi3EUxxYW2B16wDKW4/RxrYznIRcUVUDMxpTcHcsn7FMDBqNgwVeMU+5LgzRVnF+dHdsa/7rQ9OxGsK3ipG1OOLXrkv5fNvkiG34j5BzWhE8bGFnE7Uqiq7I5GLEwIA2mMi7zsk/fwjMB3MHiM3YYDdaR5sjpB9yNnp9859otv/cX4dGRDSm7MXJ2kAIvuDk8kZWHGolGD+Gj8ve0zSpVQnhGEiTvPGl5kiAfgtbGLA==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(81166007)(356005)(5660300002)(8936002)(4326008)(70206006)(2906002)(40460700003)(36756003)(70586007)(508600001)(7696005)(83380400001)(6666004)(6916009)(316002)(47076005)(36860700001)(54906003)(26005)(186003)(336012)(2616005)(16526019)(426003)(1076003)(107886003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:30:51.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be134ae1-fae6-4917-1fa7-08d9f12f0603
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1403
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Follow the pattern what we have in bio_alloc() to set the structure
members in the structure allocation function in alloc_cmd() and pass
bio to initialize newly allocated cmd->bio member.

Follow the pattern in copy_to_nullb() to use result of one function call
(null_cache_active()) to be used as a parameter to another function call
(null_insert_page()), use result of alloc_cmd() as a first parameter to
the null_handle_cmd() in null_submit_bio() function. This allow us to
remove the local variable cmd on stack in null_submit_bio() that is in
fast path.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d78fc3edb22e..e19340f686a8 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -719,7 +719,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 	return NULL;
 }
 
-static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq)
+static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
 {
 	struct nullb_cmd *cmd;
 	DEFINE_WAIT(wait);
@@ -730,8 +730,10 @@ static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq)
 		 * __alloc_cmd() and a fast path call to prepare_to_wait().
 		 */
 		cmd = __alloc_cmd(nq);
-		if (cmd)
+		if (cmd) {
+			cmd->bio = bio;
 			return cmd;
+		}
 		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
 		io_schedule();
 		finish_wait(&nq->wait, &wait);
@@ -1473,12 +1475,8 @@ static void null_submit_bio(struct bio *bio)
 	sector_t nr_sectors = bio_sectors(bio);
 	struct nullb *nullb = bio->bi_bdev->bd_disk->private_data;
 	struct nullb_queue *nq = nullb_to_queue(nullb);
-	struct nullb_cmd *cmd;
-
-	cmd = alloc_cmd(nq);
-	cmd->bio = bio;
 
-	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
+	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
 }
 
 static bool should_timeout_request(struct request *rq)
-- 
2.29.0

