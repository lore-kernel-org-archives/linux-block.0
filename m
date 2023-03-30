Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DEC74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjC3FxR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC3FxR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:53:17 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A7512E
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:53:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE2p6RaoVgSUJ55jcOCty3HFGxVW+4evZtoWLT94CvT/FOAFo6HHQpSu/bHMXENoly4ctCN+TDfa/fjyYfNk1ldLJVCZ6uWs0MN/XtprMPh0r1OM9ckOVpoDaw20r+fGtQ6EtkKvfDVsynpEcyEIdTSLilo+gV6X/FMBfhS10joe/aI+geWLYCTrd894jSBi8WD0tnRko4SEYukeWAO/YqHk/1BmPJbgWrNLlgj4u0W18yx6reLX+KlgDrGcOYgF6UmTIGGi/vTHXH2EgOYGXdjb37Wzfu1XNcJcNjkQQESp/bO9op67c5Ax5HwpDy6Cn3Bu1x53YU0Jery9/i2ITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mT1BwobzAmSXKMJqT3UWTa3C8DBTYxGwu9K90Go5wY=;
 b=Kzplg5qO4wxG4nYDJ1JJBlrtyL+b+AtTC6o4ITJVMBOMj5XMhmdcoIxnLPmaXnWDC4TAoVZq0LHUbRLqrcVDVlqjmZh/3RgUksPCmbUBTLDbXeyOvLf+b2pi4jJJwkII+sYR+5vnU9GjixtshAivP4GDJY7LsvEU9AhvgobBPdsxBCAJqTtTN/H1CSjsfKmj8PpqD7VXgQbcAO/aEj7T59HBJLo9y47F2L6XwIrf3gQ0+uypFM446I6T8YWgwJErPUp6pw/J4vX+icrQEOPl7Zp404bkJQHCZUCpi7LnYJe3UyvqNQlr35Z/dJmgGmF/TEm5yTvjEGIAcp4sSX48uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mT1BwobzAmSXKMJqT3UWTa3C8DBTYxGwu9K90Go5wY=;
 b=qmNVeKudYMFN8roGVjPh8iJXIbs0+L2exphrQ8GBcVcD7XLuT6ZTQATfqmfM2Pk61StGPJxdyc2Vsov4xZacXsTLghXqoxTht1KqFE1Fm3/VYWJRhtfRdiHHpCoYFkW1UAg9+TbmfNRv9AVN7ML+PkI+bPI2ui2V9SGA5xSAMnCYfvb7PKhcYgeb3npzuF26GjaG6gcaF15rukXkQ+E/s5pZyT+Mr3AMzzXyAu05vAb+S11OzrWYlTEbjUpT0AwUXPIdirffcU2qfdCXqXqA0h+S7AeS+cJr/3ISh6CBbLi+vOwr3TvdtUknMYuC9SZR8dm1GL7WdIWCFdUw8IeMiw==
Received: from BN9PR03CA0796.namprd03.prod.outlook.com (2603:10b6:408:13f::21)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:130::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Thu, 30 Mar
 2023 05:53:14 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::2e) by BN9PR03CA0796.outlook.office365.com
 (2603:10b6:408:13f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 05:53:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:53:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:52:57 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:52:56 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 4/9] null_blk: check for valid gb value
Date:   Wed, 29 Mar 2023 22:51:58 -0700
Message-ID: <20230330055203.43064-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: 32b6cc0e-9cb9-45d4-5737-08db30e30d0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eCu6r8PgatjV6Vk521+3ECvHvcuqTwM07COtQNDGypWfie7lyZxCbYfjuJbLmp9DKQCZYI1o7b45WEH1l+d7i32aFcDYQREvmUK0OebTxZmK7jYXwqQfoSOYjiglQO9+veH7c8IyAzPhYCd9KjyyscQob8JDDQ9NvE2IMDpp49IcUtXQEgWmxFxQ3xiXDlZY/SOIH2gNqVCfjtIyONv0fJLf8RrJNPx/Z6x0GBmfioBJ8rDDfe03/zoE6XONXWXpmjGCZ0KttZtpXsJHwt1scRex7CXDTjjXssdosBw34iNzs3sCJQZN2MketHvx6E0hCaWYIlJIx5mkhNEPpSxDpgy1QoUJ/FHzzMTvqU+MEb/gYVYmqmp/DJ+s0Ze7oJMXCTwYPPKGe0vDvyfK+JZrVntSM8+mntCdPFTpSUlaQhf599ydilLIFijBIozJQefCegZdvo4kyjnQJsZ8ZTFUfrflClOAyjDXhEdcTFt89FPFE/CFNCfCNldvtGXvfc5b42qE3RclpQ3S70eryg58nyZhaUGpSqLsIuYYkeyPysSzTf7oqV9+BmvFsMVfFZ/f03Gh8i2VX2yIr9ty3TyEQInZa6jfXjum6bxMBVJIWbINQ4ivtpBUDoDA+rDeL6xeg5D+1u58TZVSfYBhsbHNQkrqfw2r7cWra6fBG7of2H/A5hjEvPGoDje7pINp+uSj0IQgh+eUtqKYaQj55NL2JHefpVTJD7GeV9OxUSvV95xqUBL9QcE5s7aPRkCRttVU
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(26005)(16526019)(41300700001)(426003)(1076003)(40480700001)(186003)(7696005)(83380400001)(2616005)(336012)(47076005)(478600001)(54906003)(316002)(36860700001)(40460700003)(70206006)(4326008)(70586007)(6916009)(8676002)(2906002)(7636003)(36756003)(82740400003)(82310400005)(356005)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:53:13.5516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32b6cc0e-9cb9-45d4-5737-08db30e30d0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for gb, that
allows user to set negative values.

Add a callback to error out when gb value is set < 1 before module is
loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2d24c34ec172..51aa202159cb 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -165,8 +165,18 @@ static const struct kernel_param_ops null_queue_mode_param_ops = {
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
+static int null_set_gb(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_gb_param_ops = {
+	.set	= null_set_gb,
+	.get	= param_get_int,
+};
+
 static int g_gb = 250;
-module_param_named(gb, g_gb, int, 0444);
+device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
 static int g_bs = 512;
-- 
2.29.0

