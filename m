Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A04C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5812661131
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhIUJY0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:24:26 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:28001
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhIUJY0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:24:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH9kVfIOZftkseUP9MU4BjjxlivRqX0TgNTlpVDx8szi84/6MP81XNq5a7SRPAvO1b7X4+ZLnLyl+51tRRgyD6cOQ59n9Cbmg/dlu/ELzWutz54tPs++YHnM9uay13xwsyA/a+hp7qznhTKGKG1nj0pA1SKE5AHKUhY5jpOM7I5KzqyrWjzQN+miIyfABe3pA0bZb4OXDdfSCg97ZVUF5C+hlRJai0nFUjPFMzN8l4UKfbrtguLibwtqBN7Cbrdbvu67IPwvQyi7tNDCQDcoyOVdwtbLIRu4QnAgbMnpL2Y/lIrwQOwQGRHajZbM8HSMqlgdhRcObY7DFgmUcw9Yqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bLKmu5Np871dzCybS6J8teZsJ6qkWLSPl9AoueyjVwA=;
 b=WARmPEX6roHeZSg66Njoc+2j7vLVQNzUXJ1ihOXclU8taq3q95FhIw6Ubqv4Q5IrTwG064Fj2V10bEydiQDY8ZKtM8eLi818XjR7ISurE3nxQddcvhbZ4Y8eVXeL1GsX2r64FxC3viw+w1BpEf0CrbcFNRBghChzYopthbBZ5liE91U9k9+jEmH5HeMj2j/B8xzAxHxg5JXk03ZHyhpD1plFRxCqg7jLVCzBVjcr3tKrZrEOrMIThVFsRjGKmetC7c+oIiSYKvlr0I98SeKuKLNK7plz4J2v36webOskgktb2gH6OX6djaSnqb4VgvBu/BjLZtJuOCfBG5dlBC1xUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLKmu5Np871dzCybS6J8teZsJ6qkWLSPl9AoueyjVwA=;
 b=H+EsEIdFK2SK/xHqCxBZ8eoydOA/tiqQ1r5vZqs+87o69HmOMOCfla0lrzl73aMnp87XBkFs11+b3RQyly+B4Z60+pai7HSnk9QjT4q0AEYpkF8SDX5QKzqNE3AUdaxlYHtTr+pB7n9rFTA+pn69jED6rb33E+oOItR2mJsFCE38zq7LfSU+RmojPMgsDlsbft9hMH56TwWiET+/FPZI5dKs7mowxfqEblbSw+YBXKSkWJL1LZAFz0HHB2YfWrPhQFD7M+mtUYmNnQZqj7ma3711Iz9VlCg4nQCFE1KxBbesWBRiA6iAJ/kqaVPStKxO8ygZblYdRhu529MBteFfAw==
Received: from MWHPR13CA0014.namprd13.prod.outlook.com (2603:10b6:300:16::24)
 by BN8PR12MB3188.namprd12.prod.outlook.com (2603:10b6:408:6b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 09:22:57 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::8b) by MWHPR13CA0014.outlook.office365.com
 (2603:10b6:300:16::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.5 via Frontend
 Transport; Tue, 21 Sep 2021 09:22:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:22:56 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:56 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:55 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 8/8] loop: allow user to set the queue depth
Date:   Tue, 21 Sep 2021 02:21:23 -0700
Message-ID: <20210921092123.13632-9-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210921092123.13632-1-chaitanyak@nvidia.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c15b81-c2c1-48ca-61cb-08d97ce165df
X-MS-TrafficTypeDiagnostic: BN8PR12MB3188:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3188211D7919AFE58CEA0896A3A19@BN8PR12MB3188.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hCQ9RDkQcLudJxijI46uUxkKoKLHl9/oT0Jpgg+yMRmJAQlVDNEmaoX1npxjr5Y5bl4zpO6yjq628fjEMicweKkBvUM/CVaQFfCSCNOEsUEpK9LlBhRlXyQWaZcr/sHV+eyc52d3BUAzVLkt3R1ugZwz8ZK62AbMcE+GPg1J/KiiM8Vxn/w+M0J0HuiiRfXS0GF8v5/Zg4qpAsquS4B2yJxb7EjghmbdInyaILuDjZv6w9HILeXtquhp5foQJWoWPdFsxv0YTdPy0gxDCGIdljeJKcare8KgCSfwv6bqsED3G4TdAVHzh34e6WCpD+KtI57n7v9R1gciq/q+tfsbLKD3GS4B8VXR6R32kSI3SR/viCiRPBpYowH8Jk74YA8NIS9tw0V0gCkZIS3fAtUkGiQfCO0Z+0EPrm3kxvXyuEOADbpYJMubZ6HasBZO412E5fGaZDnRNK8HvwWrHzc1+9EXQMqPr2asEkHGxyZLDNURfmbOYSEy6DWiQMeeUAl7alGxUBWPYgybyKyWEHi7doXmL0D/XiM/ai/MDMpzt5AHlPOxrkFP4eaovfXrPKBkHGCMN9udPGPjHQLJEfXSBkD81NSxbPqgOpeg3BjSuFzqOwmQwQVs+Z5JCT8k8JLQ8e8agQVTW/DekcA4QZsVTFGgpWc53DZlsjCR0+JgKKyCK1xdsjXlJi1c9hQweL0Q+CFE1SL094zbRJJWBk6NA==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(1076003)(186003)(7696005)(508600001)(356005)(26005)(7636003)(16526019)(107886003)(6666004)(6916009)(4326008)(47076005)(54906003)(2616005)(5660300002)(83380400001)(8936002)(316002)(36860700001)(36906005)(336012)(426003)(70586007)(36756003)(70206006)(8676002)(2906002)(86362001)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:22:56.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c15b81-c2c1-48ca-61cb-08d97ce165df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3188
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Instead of hardcoding queue depth allow user to set the hw queue depth
using module parameter. Set default value to 128 to retain the existing
behavior.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6478d3b0dd2a..aeba72b5dd2d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2096,6 +2096,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static int hw_queue_depth = 128;
+module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -2328,7 +2331,7 @@ static int loop_add(int i)
 	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-- 
2.29.0

