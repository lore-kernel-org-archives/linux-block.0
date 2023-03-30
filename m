Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDFBC74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjC3Fw4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC3Fwz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:52:55 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FC149FE
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:52:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELzF79Ln7DgrbCTgaQtrBHcMsSyYKtMnzjjjooEEAws+uPU1oelbJWJ3Jit5U9jspyo6uayo2b8E38qARHC4UgK8/b44BROkE7tfhwJhDIWDS/5rXvzUKox5BpIdEQhycvYXCBd6H6jmpR9QdOrDwu9IxC16DFmzFELnb0mfLzAUHwHbLdAjqKZXNksn+3h3IASs0FGef2VVdGc/sn3AYRstCGMwNr34X2LVLokOcK46ukvTtQHCvvRRY8cWkTfsIl9xvepE3TetwOqkGHR4Z+GgwEG+D9XDoMpYyhkCgCVtXbEFfjAwxOeOyKW1TU8bf4qb0jaoj5EjEuq2YvMNwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rhL85XEERYkQDfbI7NGkA6TTlVmWKwCDKOaBub5UKM=;
 b=oJEoaE580u6W10oxwS1jw5Utb/Po40q0yQ+bkh29RwH2T9ysjU40Ep9UbTU9H/OW3fsTGi0fZK4aktceugCV4u09N6Q6aMgWb1OH0SwA+EHNOZuQ87mj+qnjo3qRLfKyM0Zc+Jyz6hnbSrbDgJBExdeqlW/wNrLF/ikr9WAp1SxYMaPzLGsugpoD/UI5dVUfkDOv2FS6LyZYaJQ4bPr4Do1dY6FyfALdufCX9wLf89q1ufUXVfFAMQBvULZlz+dYDLH8ejcIfNJ+ev4YbwJ1I667oGVfZmb2ZrPxRAlHWjo87NiWgnlfOTSm2Fuq1+LsDYxBDTLEMOp1AfhSIaGsjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rhL85XEERYkQDfbI7NGkA6TTlVmWKwCDKOaBub5UKM=;
 b=h9dAFVPqCo4SnRmKs7LEpW4//ecd3rnF9RjRfAzmrKV3lUILfQodvNPYfRKcfH9fWk9iWcC+aqbBWcS2i5RTWUDvAZevODWhm4NiZREo5oGXDoOBgvEUEpNhMXzwWbl8gtETXDJNOA5BvOkaZqB6+7zln+/oT776m8nd6b1ACNsCxlsQB+lzLcvhEUZjwbjrvHyse4vDx6hNzT7lv/T6GHwiZ5gV1fWUU6udpz9yjOk/ouy9tHNBoyT1BRN6OGfHGdlssMOA6tQpYwCvjzR7Ud/Jc+uiu4GxHXFdF3cOz2XqFM+Mg9VBKDycf4LCP2GylMTMHVAkNxjWhszdfB6SPA==
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 05:52:52 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::8e) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 05:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:52:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:52:34 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:52:33 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 2/9] null_blk: check for valid submit_queue value
Date:   Wed, 29 Mar 2023 22:51:56 -0700
Message-ID: <20230330055203.43064-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 665f9624-b3b9-4f59-abdc-08db30e30039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgJD0bkSBf6T9ZmJkHlECiFO9W/+enDaiOqtouqmnaPcx+Rr4mMLpKiZMyQOZ30wDPDYDj+qR6BpSNsbO1NbQ5hCQx8FH6xjEyCa/JOnItq7HOJxqI8Mz60BNF6sbtVjQHU0zbBvIZoAqsuW/1jFRflHEdIKBC1XHsnezCMYXbdKfjI8kCAhuqeJKQWWYVm7o1FLjHDct/NhCXTE/peVcx9FBpqHmYvwoYHHzmhE8rVILgFW7yuncppXwT4qOmT+O/dIS8wBEyFrSXFrdxu/AuTMimtarghV1c6vjSL3vkrFVdhzsTiVF/5YEwCQ84m7miz85PohP482U5G+wKR9/gineON9CEDL2V7gAxvZnUEfMe6SA8cBtUo6vpAsZeaMHhhLUT/z/Ly1NK5tDfLNtKmvbo52fFcK/Kqm2qVfT5CCuPFLC64tU2gjtAqfpvk3+FY26wUfibyM7+csSTVcoweFawpTfQxo2t9Vw9KYhEhi46BS6XX4p1JFgrO3QVk4Efq67aU04xFomBoXDH/okowzXMBBfPajF9F1AI2de2h9qhdCaFsw4QUywX27+LvYKUEA7GkagCJ4wfG8y2O00Qt3qPnV+6bYJZ8zAQ1R5Re1x4zpzCaqEqVV1gkU40ZiVlgGXnk/e1zp+9fqaJtDMy5ghw7WeKEI0+6Vhjs8g6PWvy8RCpSkzv5Ym6pgAPw2lcUPKkeSVgshdeZbz7VlKsU3k4wN6TwAoElPi5GeNpuTqAdhcayJiKhMFCRcd70L
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(40460700003)(8676002)(70206006)(2906002)(6916009)(70586007)(16526019)(4326008)(186003)(36756003)(426003)(336012)(82310400005)(83380400001)(47076005)(5660300002)(7636003)(82740400003)(356005)(36860700001)(40480700001)(2616005)(8936002)(478600001)(6666004)(54906003)(7696005)(26005)(1076003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:52:52.0516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 665f9624-b3b9-4f59-abdc-08db30e30039
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
submit_queue, that allows user to set negative values.

Add a callback null_set_submit_queues() to error out when submit_queue
value is < 1 before module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index cf6937f4cfa1..9e3df92d0b98 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -100,8 +100,18 @@ static int g_no_sched;
 module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
+static int null_set_submit_queues(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_submit_queues_param_ops = {
+	.set	= null_set_submit_queues,
+	.get	= param_get_int,
+};
+
 static int g_submit_queues = 1;
-module_param_named(submit_queues, g_submit_queues, int, 0444);
+device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
 static int g_poll_queues = 1;
-- 
2.29.0

