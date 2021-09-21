Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D6E61131
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbhIUJXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:23:34 -0400
Received: from mail-bn8nam11on2066.outbound.protection.outlook.com ([40.107.236.66]:14944
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhIUJXd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcF301AevUJKL7S2howE6pSRavYnHaCUE5oybCwIAYAmMaFyD7EMA81rBWQC4aRvEuj9r2C9JERJSuV4uFilz4Bqe+xOZdo3E9FNzUX2FdJ87od9XbQjpHeqJhcWYFH+/ZfiQnzWQDqxVilEwT38ZWFHqEjS7AKVVHOX+CSiczC0HZuma1QL437ba2AGIYr/qU/M8vl3eqYK0KIJgTUVYv1JL1JHcrj2FAy/UCUgKnrII8UP5PJ16MOgMgeMCKPvzByXetF7hjcdSuU6I0fZqIawTT+rOX7qYG/z/LaH6OIYV+VL+mvgv7TNVWnoY8WOpVl2UqqS8NBViTCRKhTrVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=g21bEP7qQSxlu7u9SAaH6Bavwe7ziNMzUH/+g/I+s/4=;
 b=LuCFt03Rryky5/DWC0ICdoDjkHxw5TXQCFN27Z6+z0PmvL2g0TisRwSXkP7u9oIhGrML3LxPGrdkxNa1ebX6dxLYKeCUb1VYYCOaUGPjv5MP+BOgXrc8ZJHBQHapR4bUSFP5E24FSqmX2akYS6ht6P5MEbZkyqbRsXxh9jITFiqn4jcnxsYrJAp3iq1vwD0sFuZiGB/wBHrU+7dUEHKeLUzL6w6sqxoCs+vA2OpUv3IOUjTrk70SXPihLjQ3O6NucSmFgaFUtGH78h8RYybjg3Fz8VyUI1BpuPOOSe4rhWW/LOlL7r9U61Ypt+3z+K1iVOE9AymxKVqxM5qKdnsAmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g21bEP7qQSxlu7u9SAaH6Bavwe7ziNMzUH/+g/I+s/4=;
 b=susj02/t1oMsxi0nh/ZAZlP7P4naQXAYkHbi7nNP3a43v9wnzfikxTUPMHr7EEEcWc6CJouhAXTeyzPmDHxPloQyNGfGnW7oUi1oXI5Mcprq4ob1mDyiENQ+2uwf4q/QjjfncXt5X3/crfvtF9fvdAV7F3iXNnuqvmiLvgAflEBhnYamClpUT70uCbSUCXdFznjBobS9Nf1CB5aKhP1oQLSFQXBKH7XVy3aB9oD+DNf8mmf1jGPtk+eRJV3tI9G0JgGiOtWp2e3jd99eUqQTWo4c3hIWMHZobZvbyNfbGUuFkEHrfdB2uD0dbV/6xR8gZEz0PH+DxLiIoW6FBnAdCA==
Received: from MW4PR03CA0192.namprd03.prod.outlook.com (2603:10b6:303:b8::17)
 by BYAPR12MB3303.namprd12.prod.outlook.com (2603:10b6:a03:131::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 09:22:03 +0000
Received: from CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::7c) by MW4PR03CA0192.outlook.office365.com
 (2603:10b6:303:b8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT006.mail.protection.outlook.com (10.13.174.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:22:02 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:02 +0000
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:01 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/8] loop: use sysfs_emit() in the sysfs autoclear show
Date:   Tue, 21 Sep 2021 02:21:18 -0700
Message-ID: <20210921092123.13632-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210921092123.13632-1-chaitanyak@nvidia.com>
References: <20210921092123.13632-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c70d2ed-71e2-4c2e-30a0-08d97ce145c9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3303:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3303E33AEFA4E7D79E94BADFA3A19@BYAPR12MB3303.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xd9liSbItH21s4yEE6SpBaoR87dHAroE1E6vZhMI3u0WMqPenYv/FZH7HcPkvtlwvQOvwiCc2WvLY8Vu1B80DYlCcvkbbtq6cQVNUSaXreUQXCkuzgNlbIWodrSn07mwiGWUJhIFbTAuLZ/BB0gTJXKs4mNkA+LTGANps1sR3aq43OjPrc/q/VutclwDdrv2/YYd/i4M8Af22O7+5DjKEIKrh1jDCwhlFS/EPW+wCsWJfhEVS3UKvGuaWdM+sq2gSw3x+QrVyy+p5KfMjlF+185sdsiWMv/4MYjV3Jms8GQadVRUR0ZDYAG7Au3R7HlMZZ/T0jH3SaVtRszT//NA004hN7W3WluS0IWSnVH5jSiPGIJko2rVNvpHNdL7wmra6J1Jq1Zsm+KOemU9HVdTtKUdXKB6PZX9Dfww/C4ihN0x3x5S1eVpMt8D5Dw8Ino2upYH1L1uql7ITFjrtCSC5R2SPlxwmYDFzRstH37Q9EyMEjnDoA6sFesuYv9gpfUSJoZEh3OKiLumMkf3QhrXKdguo1SExqRI5W58OQvC+zek3r19ozGIdotZQvDedo9ZaofGIMis/xts5M9dwvWgZWW0LaG+5h6VAVDamj4nUrf0W7sRpaktJ0ocesmtNwnfyHrj2y+7ztRoJV4G3ty6vrcA+XEYfE9CeOk/K0gZ9HYR5fBE64oKweVd9mlCKv57bs0FNL2ZydTxwXJn3q53Dg==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(336012)(4326008)(1076003)(7696005)(36860700001)(7636003)(2616005)(2906002)(6916009)(8676002)(47076005)(83380400001)(508600001)(186003)(26005)(54906003)(70206006)(316002)(82310400003)(70586007)(16526019)(356005)(36756003)(36906005)(107886003)(5660300002)(86362001)(6666004)(8936002)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:22:02.8966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c70d2ed-71e2-4c2e-30a0-08d97ce145c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for autoclear
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index ec1329afc154..fd935b788c53 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -868,7 +868,7 @@ static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
 {
 	int autoclear = (lo->lo_flags & LO_FLAGS_AUTOCLEAR);
 
-	return sprintf(buf, "%s\n", autoclear ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", autoclear ? "1" : "0");
 }
 
 static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
-- 
2.29.0

