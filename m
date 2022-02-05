Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32AC433F5
	for <linux-block@archiver.kernel.org>; Sat,  5 Feb 2022 09:12:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237149AbiBEJM2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Feb 2022 04:12:28 -0500
Received: from mail-dm6nam10on2072.outbound.protection.outlook.com ([40.107.93.72]:51645
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236403AbiBEJM1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Feb 2022 04:12:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hUvXXX6wKD8i4os/VIyLrlgaKC+VeRgG3fZVrE9rDXHRoPBRQmrcqvi5ZpyX02jjVITooq6Ae7UPgZOAxLFY76DMJFSudJ3fVinMPRIjkfPq0TaeVPlIGQNmyvYlmyGCUpVpZ4rp1hlz/gLfkhvxN/7hwCLBjSh6ci7EampCaMovUH0qbv1ojJiWi79Bhn38d4gSKuElZuCmZzIZSvMIcDWgo2ky6uHOWtN9GWP88/qK2ze7W5iTDtwOJ5g3mI5riuW4Z6tBwZ+2+QFXbHsEzNeTS8x7Wt9dXdmlB5USLBFWgPofuzQckFQD+ve8glSeOC1J+HZniOmWxJ5lYvtTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7kcORvHFth6HESXt6H/zpEjSdLgCctl8QM/nxS0Kgo=;
 b=aUC1zdUZR0sx19Gfs6ySR11ZKdWYDBYmA/TFfiwVnXfwNYd5OQAABtUlInp0xTXC/7f8W2TYlnJYMAqBTBZH72NqUamwg1kuWjSJnHW3kFf5p4mzG0pHuWMbH/XzBOmGETO/WygpBdq/P9Wjt3pLlW71cCOb6fFx/DygXnRfGhnxFmmaAT2YbWR+vHsExQ8VYnqWeBBsMmMsJF4BBMwUuzYS3/+R4p8GYWpNqxr3SEbWslaCwlFr/ZpJTRVJ4RqTHX72x1+uH7ij0JnvIDU7iKd8XibXYMGIOgDveAq4zCdQivQvN/2Sm3+HOhJt9Yx/H0m/CXLIbqU9BvjBTKTvfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=goodmis.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7kcORvHFth6HESXt6H/zpEjSdLgCctl8QM/nxS0Kgo=;
 b=rljc5IUi0zi0bFaOH3S8nYwa7J5StFTZNuA3HfTpyfkQSMCDgDh4LcWkHvkK91+hpiy3Pd5kGf4OjDMP3hlDB2wypxC0586nukj1qallvnG6F9buW5dTHOo3G53QxbzD7MADzdoUfQLXbBf9096lVjq2NxJkkLIglO9ipOKSXOjrah1VNBzW72sWSdyHwoV4fUOa3flMPEtEInpL8HHHQ9tuq6pPG7diWWDf7q63k7hu0wZGXrnmFlnlshShfpGFf8K8+yGflbveC/G2EbyFDVoZICKJ+MUsztfS0RdU+Qz/09f+tYGxKzmxFEFysALdVzpjeLtKC7luEJMBXh0MCg==
Received: from MW4PR04CA0374.namprd04.prod.outlook.com (2603:10b6:303:81::19)
 by CH2PR12MB5514.namprd12.prod.outlook.com (2603:10b6:610:62::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 09:12:25 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::6e) by MW4PR04CA0374.outlook.office365.com
 (2603:10b6:303:81::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 09:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 09:12:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 09:12:23 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 01:12:23 -0800
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <shy828301@gmail.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH V7 2/2] block: introduce block_rq_error tracepoint
Date:   Sat, 5 Feb 2022 01:11:50 -0800
Message-ID: <20220205091150.6105-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220205091150.6105-1-chaitanyak@nvidia.com>
References: <20220205091150.6105-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ac3a272-0f9f-4026-dcbc-08d9e8879f9e
X-MS-TrafficTypeDiagnostic: CH2PR12MB5514:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB55146BA91B1C0720BCAC98A8A32A9@CH2PR12MB5514.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIYFghx5wxArxFMmyTrllY/Vuxsr4Uc4j+Sibk5YUtoA73hpD8ug63wZo0axy2Uki99MVwHsf124ifxqpjsGhjx75vp/Z3tGmsy8KtKpQ9IvjdI80Tnz/5pEDtSPqAN3coCoKTle4zFtPLcm2uEU9CSgooeEeA+CEN/J9TGrK9Lkzy/y+RoXfvaPxQMOZINUY2BDe62sFlz7UAlteYskmvspK7WwHUPM6X31/T/Q0eVn8W8vtEiS01+emqvcgQo8k+b+twww8+oLwGAMfLjFcmJrIZiVtpaPEZ0z493VoYHxIySfF4xx3zSnKdFfzz+Awy9wM1cucnejTfuPwDcfPAlLdTtikMrTArTdKjlGuXZxss+SV27WPFVPfQuOISObsp12ZFHoLHeqODTjCBJUOhRf2iQxU3DRzE1Bcmeg/BXt6ABbCKJqKTxMolhLQ0As68u2fC7jtIhRgp+Xyb2zzCykKflJcfqYBdJja6OUJNrjGLXBzEZWKq9AhGA2Z/x1nsu0jZU4Ww0ITx9aw0HdGH7r/PMovY9rJJD1+CsqpZX7gpHGBzkhmXjfc2lzUoF91Ad8vf2lrZQLl7wHJQdcv4SdXAxEHLD4+fzCLb7ffqj75DLmLYa7ITfxi5mo3PKZP/GddFePJeOy7iN2G0XzkIduRDhVOYZkVXCa3cn8pUc3AGFomWVW87UaHE4bU/cCQwPv4pj7wlI/MYUZ6FUDtw==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(186003)(16526019)(1076003)(26005)(82310400004)(4326008)(508600001)(8676002)(5660300002)(86362001)(316002)(2616005)(6666004)(336012)(54906003)(356005)(2906002)(70206006)(70586007)(7696005)(6916009)(47076005)(83380400001)(36860700001)(40460700003)(8936002)(81166007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 09:12:24.4603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac3a272-0f9f-4026-dcbc-08d9e8879f9e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5514
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

From: Yang Shi <shy828301@gmail.com>

Currently, rasdaemon uses the existing tracepoint block_rq_complete
and filters out non-error cases in order to capture block disk errors.

But there are a few problems with this approach:

1. Even kernel trace filter could do the filtering work, there is
   still some overhead after we enable this tracepoint.

2. The filter is merely based on errno, which does not align with kernel
   logic to check the errors for print_req_error().

3. block_rq_complete only provides dev major and minor to identify
   the block device, it is not convenient to use in user-space.

So introduce a new tracepoint block_rq_error just for the error case.
With this patch, rasdaemon could switch to block_rq_error.

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
[kch]: instead of adding new event reuse the code from
block_rq_competion for block_rq_error.
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 block/blk-mq.c               |  4 +++-
 include/trace/events/block.h | 16 ++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b868e792ba4..6c59ffe765fd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -789,8 +789,10 @@ bool blk_update_request(struct request *req, blk_status_t error,
 #endif
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
-		     !(req->rq_flags & RQF_QUIET)))
+		     !(req->rq_flags & RQF_QUIET))) {
 		blk_print_req_error(req, error);
+		trace_block_rq_error(req, error, nr_bytes);
+	}
 
 	blk_account_io_completion(req, nr_bytes);
 
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 1519068bd1ab..7f4dfbdf12a6 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -151,6 +151,22 @@ DEFINE_EVENT(block_rq_completion, block_rq_complete,
 	TP_ARGS(rq, error, nr_bytes)
 );
 
+/**
+ * block_rq_error - block IO operation error reported by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_error tracepoint event indicates that some portion
+ * of operation request has failed as reported by the device driver.
+ */
+DEFINE_EVENT(block_rq_completion, block_rq_error,
+
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request *rq),
-- 
2.29.0

