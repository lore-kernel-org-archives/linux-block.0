Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9347BC6FD18
	for <linux-block@archiver.kernel.org>; Sun, 23 Apr 2023 14:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjDWOOr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Apr 2023 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDWOOm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Apr 2023 10:14:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04235211D
        for <linux-block@vger.kernel.org>; Sun, 23 Apr 2023 07:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx1uy3OWUZpTf4yppV0cACdLe961XU5qLZG1f3yDUlMsSCaLAaQHypkjRCZO19V6r26NZaM9ZzV2IiwyrQLaq6mUWIQORlDnZiebbEEwoxyFsn+YXMyWr3pTmhGqnkP+Ce7opP1SAMHVzmmn+ZutTVmUElcn6yNPytjh/AQ3YL+dUufRDvTdmLQZKlxJFvICJ54RNqf0HtSopiO2pHcfGYfFfXhBWhvx0ZEvkcVqrErheZld7YV+RRLUH0EMnDJxq5izLLKRwzBxeimgWVseWxu4AQ2JZXKkDr6jWpwvq5JU6EThJSWRPyRVnrR1/q0TybVwd4RkzpVuUaoy5ycu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=;
 b=PLlOf7s2eH6DkMirkGUto4T6mKO+oKpuQ7Au2hSH4x7RDwjb9AlE0ut+KnIaO2+gmUhEjRhpvnECjtqhNGxTRe3OZ9xHM86S1lCIQ/NRA0pbtJEWr+WKQbpna8mL8B0wVUu4pzaYbQpt1c+GpYzGNHLTg19ospm4AZeVNBsti+J9JIDjQ3qtWYXHWFDNBR/kkotbG3TvjdMqGTUkFPqV3IVdr5vG3P1IfJ1pFO5ZtZ0mN15AQJjx5iEDTOvTTJECXU5zQb+4HYK+QKG4kaua3MRahwdUwX0rxe+FpESol9tlTeh1mhWoy4O4aWlWGE37m85ifECrR4uvURvzTzSiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=;
 b=pIHI99CY3Ll+IZ83FM3mzRuXV6t2HWdBCCsE6y1mLYGF7Eendlj+nXGFuA/nfqApiIEqaPLLYzmbymAt2lMChtEbln1/5nQ47E+QehsUfFZ36Ca9Rp+4fUNY0pgbqSy8xWYV5NHDlWOmkE5qs5Zpr+x3XqbiXtb1v2qG4ul058uP+osLe2iKj90chUM+ePmPTqP8PGXAs+yOgPtcL9WD4phBfZvEhNBomrC9t9G8BRfHeb1uP23Wi1jUQGqX2RGXx07SwsZ1LLknAcl3yfG5DyN7oDOzJagYj9Xq9Sc475JSjeiyaADlrkyVRvQmTEkG9NHgbf+UWXyhjpahUK0WTA==
Received: from DS7PR05CA0053.namprd05.prod.outlook.com (2603:10b6:8:2f::34) by
 SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Sun, 23 Apr 2023 14:13:43 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::6a) by DS7PR05CA0053.outlook.office365.com
 (2603:10b6:8:2f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19 via Frontend
 Transport; Sun, 23 Apr 2023 14:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Sun, 23 Apr 2023 14:13:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 07:13:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 07:13:39 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 07:13:37 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
CC:     <kbusch@kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <oren@nvidia.com>,
        <oevron@nvidia.com>, <israelr@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 2/2] nvme-multipath: fix path failover for integrity ns
Date:   Sun, 23 Apr 2023 17:13:30 +0300
Message-ID: <20230423141330.40437-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230423141330.40437-1-mgurtovoy@nvidia.com>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b78630a-e23e-4f18-ca06-08db4404f1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h2bxQCZMxYEEIjecJt5su/egkaExJt9gajVed96ckmS5FlrNrtyjNql4mbSXDKdStL/hj45ykdpM8Vavgwk7ZYysE1vpS/5X2vfDjgyms9r7/hMi8tt51SHc4YSl/JrJjnvWPVgvMLQ9AJC0shanrlZIU2d/HnbS9XDOZOOmbqI2bfOffCmieTF7iXuWz2JQJ/A1MtxuIT82Ket+XH6od2C5P3eltCM1mZF184dKzZHH+EXjra0+CV59GdMoqgBxdpOY8Ir6LI78w3SdSkQrulV8DRg9V65t82K4u/XRBjhV6XpQ/jiP814yqkBoZoWmu0n4PU1HV+Cdm/6kriR0kQ6y2JOqAIta+BmoaHc+w4XaDeGpqVh+6NuYVfAzppOSIMSB+jcFCLOxp3HLMvimnM+fnKOwcSJWc0/Margj7n3nWyeoqWzmnGF7tKY3dldh/qKL9E2wse/2wQ6FJ7PjrLHxexeNC0V8yu09yW7UBhYeVIlHeJWP15wIlPZL8p06a12H5fI74DH5n7fYGngpsqRaF61JBYFJXqobiEyDB5T8sDqfiRGGlR0U5/wf7i6xAWMoERunpuB55PHjTnNmik/Rud4iynSMu5mEFZVuxNyAW6zt8cTVpJp3IvlwzfGwPv8dPNRh2nzDi9o9kkklU5YcrsLWQ0ttBbh/AJlFwB5BQvQI6BwIhDK1+aGRHpfN7az0ZRNsLa8a+SyHhbspnzYfVoGm712F9fLSRXtho1E=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(34020700004)(36756003)(54906003)(83380400001)(478600001)(2616005)(36860700001)(47076005)(40480700001)(1076003)(107886003)(26005)(6666004)(316002)(110136005)(4326008)(186003)(336012)(426003)(82740400003)(70206006)(70586007)(5660300002)(8936002)(2906002)(8676002)(356005)(40460700003)(7636003)(41300700001)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 14:13:42.8414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b78630a-e23e-4f18-ca06-08db4404f1c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case the integrity capabilities of the failed path and the failover
path don't match, we may run into NULL dereference. Free the integrity
context during the path failover and let the block layer prepare it
again if needed during bio_submit.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Tested-by: Ori Evron <oevron@nvidia.com>
Signed-off-by: Ori Evron <oevron@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/multipath.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9171452e2f6d..f439916f4447 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -6,6 +6,7 @@
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
+#include <linux/blk-integrity.h>
 #include <trace/events/block.h>
 #include "nvme.h"
 
@@ -106,6 +107,14 @@ void nvme_failover_req(struct request *req)
 			bio->bi_opf &= ~REQ_POLLED;
 			bio->bi_cookie = BLK_QC_T_NONE;
 		}
+		/*
+		 * If the failover path will not be integrity capable the bio
+		 * should not have integrity context.
+		 * If the failover path will be integrity capable the bio will
+		 * be prepared for integrity again.
+		 */
+		if (bio_integrity(bio))
+			bio_integrity_free(bio);
 	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-- 
2.18.1

