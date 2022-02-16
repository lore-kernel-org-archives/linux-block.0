Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CEDC433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Feb 2022 09:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiBPJa6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Feb 2022 04:30:58 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiBPJaz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Feb 2022 04:30:55 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB532599E9
        for <linux-block@vger.kernel.org>; Wed, 16 Feb 2022 01:30:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cd8IM2f+vEMRYWSYU1wq0LrFdM2GXFP3I2v2vyboLabgpF5hXqbFvoIi74lgCigZdRAuuEYbmiIOQxSWjbGbw0ytxdQeUFtWdlbeFUqzjc4lERZj26zrr5RjfqPwqLcdk5YqnsnXdwb9nDKAunRQCPtogvfoDN2CPSOcFvQzB5yTOrrMxCCNhLI4GhPTX4tepiUKJbCVyerJB+81ltlowKh6M6EB0Rk8CFVQs8quH2IGnva9f1cZTs5sFIP+IgzmrIjZmpTnFqJd22+fXFPuEFWhJVWniBZv/T+m4VgKbbsrQht/LpA+A3+PM0+/Df9Wr8WFsc0hu1nC87S6VTJzcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7aWx8BWDS3RIVpIZmra8ab7iZb4TKZYUcObP6a3PcE=;
 b=UKNWw4d++WzVuFAERpynnsYGqu1JfTwcJ/1upir+PHVrsH4ZYQNpl8+GogKVUC3gZFxsUD6qf5oAb6gxIBDQJSGHL/bCDeuxs9cHE0kJYvph7xaUXxQ2hBuGYY+zi/YUpN5kefveroDGnFbO2COneeGx+m7pESTjCoz9YJOMt4KA/d3cyKe5vg5LRHwc/Pwzhvi9pRT364kDe7D76R/zTyMOYq2vGwBSpV9bPIoKn+0XBTG7L8T/aLCjUPNITtZ/jEdkd3b0+HfyDJ4Ieb0i1gc0JzeQQAimyEaxHLmq2EokdRkHVoJ3D+8TFUg+2YNlBWQaP4A17QoadcusTN8Urw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7aWx8BWDS3RIVpIZmra8ab7iZb4TKZYUcObP6a3PcE=;
 b=ikUGpxRQvdja21erJkYL2yJFR//gVFzK6/ol4JbrRxOpAHEk8V2rc5+Tl8szxTWOwO9iXnXjRXucn7qLcdwL6xxAVmvm/OFdm3udEilK5nDNK/EboGA0yBwBZRtv/T8ke0+RQTo/PJDCeoo9BwA5pYMxF8MMsAa4Yq09zhIffPKWf6qOh59FOuRs3xR43HUzCIjjNUtvty6J0XuKfSUzUkO1YJwN3MRSkuxnU4Kj9LR53bRmSmKViyou+HGtZKuAK6pJ+IsprWZc82ytsZoIqQZN8C+VK2O9mrN8j8Z6VuWJwRSDVgKSuETTmuBMGsH0E0ir2e7KTSgLgonP5fVqOA==
Received: from MW4PR04CA0219.namprd04.prod.outlook.com (2603:10b6:303:87::14)
 by BN8PR12MB4628.namprd12.prod.outlook.com (2603:10b6:408:a8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Wed, 16 Feb
 2022 09:30:41 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::2f) by MW4PR04CA0219.outlook.office365.com
 (2603:10b6:303:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Wed, 16 Feb 2022 09:30:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Wed, 16 Feb 2022 09:30:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 16 Feb
 2022 09:30:39 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Wed, 16 Feb 2022
 01:30:38 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <damien.lemoal@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/2] null_blk: remove hardcoded alloc_cmd() parameter
Date:   Wed, 16 Feb 2022 01:30:19 -0800
Message-ID: <20220216093020.175351-2-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: b44ff2f8-b2c1-4c5a-e4a9-08d9f12eff4f
X-MS-TrafficTypeDiagnostic: BN8PR12MB4628:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB46280F5D4D188BAD63480034A3359@BN8PR12MB4628.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dmNXZjGvM1Fqq/SZ7Qpol3YQEUX0bGG5Xtsj9CxfZ3SX3v3IYEgwG73207U7cN2mOueNbkHPTugwGx+DPOSbxqfDWUcJt24vdYh7OyUAwIIvwDNkikIeyJpGb1dciLdrZaesfWDYQ23o/PkrF3NdiE6yIa9fDVvoZQ0IPqC1usuLi1HxPNW7vk00B05+htCIXXVDL7wUZWsqlpOpZEMQhiMLMX/1HzVDUAIt9m0ucQWYqA7vZ/D2NmtIFRpcP7gMJJhMMzoe52qWlypSIH29xpR01WpabY9fmk2HvuQCiqoOrH4Jma0pnh8mDCphY49xB/F3O3rWKEHzyPq7QqGw6nt/ToD1am6zAfxXYKXD2jYc1AkdYjAU+KbLvtEvGSMfPbBwozHjqvypnUbUmQ+cD7B8y2lf0zRnFWOvZMIIEGWO8BTeAruQUe8/9Z9NPva8++n4p6BEvQmcqbrzCsJZpx4A9zat2hHxBnGN0cjyH+5PhG+STO0FMIGbYghPthdSEcqBxmHaQDcqJGLNQIx+sMAcZgdgo65Z9BwIzEu3UvB3fy10e9K2pHPEELRilF3HE4q4wBxo+k/gvk9UxNZGp+EJoQuumGiNcTI5p5XOfNkC7LeEA0ZvAYJpdSgz43eOX6B9vTb5ly8Z/QMFW+qojaHgtmWR52dPS+lhwOykVa62snDqhOSLvWrcUpWwwOJAkCVI4LNVVHD2KSNgbfLzfQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(54906003)(40460700003)(2906002)(316002)(6916009)(8676002)(5660300002)(4326008)(36860700001)(83380400001)(47076005)(82310400004)(356005)(508600001)(336012)(1076003)(186003)(107886003)(426003)(2616005)(26005)(81166007)(70586007)(8936002)(70206006)(16526019)(36756003)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 09:30:40.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b44ff2f8-b2c1-4c5a-e4a9-08d9f12eff4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4628
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only caller of alloc_cmd() is null_submit_bio() unconditionally sets
second parameter to true & that is statically hard-coded in null_blk.
There is no point in having statically hardcoded function parameter.

Remove the unnecessary parameter can_wait and adjust the code so it
can retain existing behavior of waiting when we don't get valid
nullb_cmd from __alloc_cmd() in alloc_cmd().

The restructured code avoids multiple return statements, multiple
calls to __alloc_cmd() and resulting a fast path call to
prepare_to_wait() due to removal of first alloc_cmd() call.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 13004beb48ca..d78fc3edb22e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -719,26 +719,23 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 	return NULL;
 }
 
-static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, int can_wait)
+static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq)
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
 		if (cmd)
-			break;
-
+			return cmd;
+		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
 		io_schedule();
+		finish_wait(&nq->wait, &wait);
 	} while (1);
-
-	finish_wait(&nq->wait, &wait);
-	return cmd;
 }
 
 static void end_cmd(struct nullb_cmd *cmd)
@@ -1478,7 +1475,7 @@ static void null_submit_bio(struct bio *bio)
 	struct nullb_queue *nq = nullb_to_queue(nullb);
 	struct nullb_cmd *cmd;
 
-	cmd = alloc_cmd(nq, 1);
+	cmd = alloc_cmd(nq);
 	cmd->bio = bio;
 
 	null_handle_cmd(cmd, sector, nr_sectors, bio_op(bio));
-- 
2.29.0

