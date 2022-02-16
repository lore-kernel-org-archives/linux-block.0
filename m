Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DDEC433EF
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 17:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiBPRbb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:31:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBPRbb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 12:31:31 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95001205749
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 09:31:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGbzhSg6bTG7Mx8cUaVI/YttvpzjdCfoV4knoSHSJ7VvK9BN20LJOEt4ZPgf7ruJ6EGvWnhwsaOGOx7o+javId9LOCr7fQO88wH4y2pcQ9ApCVG/72zUdY4qWQyFCiFCp2cNV+FHlkOfmf+pdAUcl2000WTAZn8y6H+4gfNQUJdijFxsPCM4Jvhx54BPad/WSQrbxRHXwiUPodywF8Sc3wPDpFdTF+8D5BtsosXc8HVk9ocSXcWE9yHo3IO0rVwP/Ep4DMq+fyB9r7VU3FuEQp+5IJizKRfODY3KdliMD8g0wxCBi/OSuOVCorAYQIXY5t6KUqabn+set/olMsPdJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luYC2Rp7l8XtyncAJXbmGCK5Sm2syh1s0Wo+MnpaUTU=;
 b=Oli0J3esI1GMsNvFwQW80XI6qBcLZqrUY/rkA1Ozk+mvJEbaHCXMjOHAScpWnMhXCWR0EcSxXKFYQqNtmG8pTO+svsyEgKFV0M6QpWnqB16zD3D7uLWPOeyyKSIGLAuQ9M/+h9jLE+SQicr1maSlSVB9H+DVzqEW0L5GPcjxFNxb2mRvYho68J3PGpR7lm+Lrmzv9GyAaepKTudllF5lcDhLQF2UcHQchAkkvl3DxfhUiVIigI+jhZ21SKaiuVa7OhR6gM/fneyfwDlYK0H6C4PNTFnFj6VkgfHKUhlul2RnYbhwGBl1KrvCPXttu8C3/xvWnS/BbfgsXK//Rn25Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luYC2Rp7l8XtyncAJXbmGCK5Sm2syh1s0Wo+MnpaUTU=;
 b=o6L2p1QuAHglIHchfI9Wx27iSrYmBdo8PyuX4p7aQdBfmmj+DeIFuJOSThfSfd2KHbl4NDLmDY+2BSx+80U/RuX7Wo0+tEr0zYzbf8hWxHrGTClups3uwyxAyfp8QG8Fw3K2H4U0LDFYNxthH3w7YKdCUOPDZM2UyKEPhp/N1TPF1KfL/yknmlbFvvCLui61wjTCJ/VmxttfpyJBWluZOrY3dL6Etv4GmcGGf7AumachFiBiM7eaaM/HPfQEBw34H+Ai+x0NbEK2qXvRIOdMschMOXfb3NhHtc3WRP2TWtzR/lldTmYqU7Yt0P6uV4hnmJhv3Ip9rBCA3lHXR+cj8Q==
Received: from DS7PR05CA0036.namprd05.prod.outlook.com (2603:10b6:8:2f::25) by
 DM6PR12MB3852.namprd12.prod.outlook.com (2603:10b6:5:14a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.18; Wed, 16 Feb 2022 17:31:17 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::f2) by DS7PR05CA0036.outlook.office365.com
 (2603:10b6:8:2f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.8 via Frontend
 Transport; Wed, 16 Feb 2022 17:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Wed, 16 Feb 2022 17:31:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 17:30:15 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 09:30:14 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/1] null_blk: remove hardcoded alloc_cmd() parameter
Date:   Wed, 16 Feb 2022 09:29:45 -0800
Message-ID: <20220216172945.31124-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220216172945.31124-1-kch@nvidia.com>
References: <20220216172945.31124-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa2dc10-e049-4b2a-1a6c-08d9f1722347
X-MS-TrafficTypeDiagnostic: DM6PR12MB3852:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3852ECBE3D0C5DF0A1EA8454A3359@DM6PR12MB3852.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a31WOumwTsxjM4tFfLStOo5WOcr4PvqJDEYfNlbTrqcsQmyH0s+0HjLdz1Q2TFlNhaJ/Qc2dmh5uc8Sb8MwdgciUyXtI2T82Zg6RMVaPfeijLePqHUZQ+Kakw3rDe4lsw2aK2qHlZeIaYGLgWb5UZ3ZihoCO6o/EnxphLkhnfKe9WX9nnJ97vZHeZLbuor4HM4RlxsXIe2OT8T+5Fi4VFmkuGdxb7kgvRwwszPLrJmwfZGryzV8gisVFMs06U/GHZebIvlUbiY4JTRwNKugZ1gTSLcF8Nvyg2T54xb4/zTs9wowkM+4Tr/RKqJSRSZ/Zbeq76HUVTe5HpWHLWJc7yoa88/ELwZO0AbnmWJAC3ra6CeL+r0pPxB/QDvrYrDfKONRbXwOTH0w80vheC12FM8fde/28rFyzCq7O9TKbv/CAXWYTJAWc5iY0W/SJfAJS2efNastx9+Mqi8D6e5Z7powqXXqI2P2xwkRiG3wlQoEBV3wSfuNXwajcnd/DbQsBTOriyZ6V25OltB1QfVRZDqMEGUq/AT2cv04FxH8YiYVVVOJPUYk2XJD0i14hFq87aoO+7AY5EzcrDqOozrHiRrduFuocts0mVqnDAhEKLAr+RrUIwGdn44LSRq19rmJwqwB6VUuEhnoKVJArGqZTQt58XX4zYlqUSQIP59u1xeVEdSKx/VHhe9RqeZ/F3AOjDfzNNrm3f9G0t3m9TGHEdQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(82310400004)(2616005)(36756003)(70206006)(40460700003)(356005)(8936002)(5660300002)(2906002)(26005)(7696005)(4326008)(6916009)(70586007)(107886003)(54906003)(316002)(336012)(83380400001)(1076003)(36860700001)(6666004)(8676002)(508600001)(186003)(16526019)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 17:31:16.8501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa2dc10-e049-4b2a-1a6c-08d9f1722347
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3852
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only caller of alloc_cmd() is null_submit_bio() unconditionally sets
second parameter to true and that is statically hard-coded in null_blk.
There is no point in having statically hardcoded function parameter.

Remove the unnecessary parameter can_wait and adjust the code so it
can retain existing behavior of waiting when we don't get valid
nullb_cmd from __alloc_cmd() in alloc_cmd().

The restructured code avoids multiple return statements, multiple
calls to __alloc_cmd() and resulting a fast path call to
prepare_to_wait() due to removal of first alloc_cmd() call.

Follow the pattern that we have in bio_alloc() to set the structure
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
 drivers/block/null_blk/main.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 90b6bd2a114b..29e183719e77 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -720,26 +720,25 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 	return NULL;
 }
 
-static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, int can_wait)
+static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
 {
 	struct nullb_cmd *cmd;
 	DEFINE_WAIT(wait);
 
-	cmd = __alloc_cmd(nq);
-	if (cmd || !can_wait)
-		return cmd;
-
 	do {
-		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
+		/*
+		 * This avoids multiple return statements, multiple calls to
+		 * __alloc_cmd() and a fast path call to prepare_to_wait().
+		 */
 		cmd = __alloc_cmd(nq);
-		if (cmd)
-			break;
-
+		if (cmd) {
+			cmd->bio = bio;
+			return cmd;
+		}
+		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
 		io_schedule();
+		finish_wait(&nq->wait, &wait);
 	} while (1);
-
-	finish_wait(&nq->wait, &wait);
-	return cmd;
 }
 
 static void end_cmd(struct nullb_cmd *cmd)
@@ -1477,12 +1476,8 @@ static void null_submit_bio(struct bio *bio)
 	sector_t nr_sectors = bio_sectors(bio);
 	struct nullb *nullb = bio->bi_bdev->bd_disk->private_data;
 	struct nullb_queue *nq = nullb_to_queue(nullb);
-	struct nullb_cmd *cmd;
-
-	cmd = alloc_cmd(nq, 1);
-	cmd->bio = bio;
 
-	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
+	null_handle_cmd(alloc_cmd(nq, bio), sector, nr_sectors, bio_op(bio));
 }
 
 static bool should_timeout_request(struct request *rq)
-- 
2.29.0

