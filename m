Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9622FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D6316113E
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238853AbhIWBwI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:52:08 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:58273
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238851AbhIWBwH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/P1bX+DclDaN1TPwnOH109a+p6tDvQd9ocscV9cbWKNzVAu+5Bzm4Kr2reKQYdHLOYj07nek0geJvPL8MpwNEauIXxKx0Wuk+jUOyuc/racImsdNc3zxxNAzX2B7bqTfpPfvZ8tGqiYkK90HlzAJ233bGETWOlCuHB/Vadi5CGXkIiRnveJ2D/0SxlV2KHNnxSJIC9PI8mNHyYhjTqa+DCG8ReWP22SgSIB5xYvoS+qaxK0tdN64HQG+PNJJmCVkgORM0F0B68rDtlVtBYq2Iequ1R7jqlizX6t3ubwmxIgZM/c6JC9C+UqPpWDazRNllFo3KvGgILWYtNFU+CoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4hPGlrU19cyAN3zQ6YIGQDDqItqVmU4ak+pQCItJfjk=;
 b=Jbwbcjnm+nz5CR+IUsqGZoPnTIKEBoCcAHE1mCPdDiuL9K5WdlVDq/dPgY8nh2PzRaF64Fvr81bRwETANHs4pO3BNmDkd/gAw9ZvDyoWiFAKd2U3ccRQTBbYGgJuTivTEdI8HOnxdDU0BnhiOJ9treOZaeim21GEkdx+6NqWUwvuPP5iyHxrDX5DRoGxNG/og4vnY4h+q2sLPNygBEnMriDwsg6tfah3WyAvcJvioshE7avLT7bWFXVMXCSDw1L7ghTi3tuYn3GCrud2ZBEtLKsEg9n3qQlnEZsajaNr6OvNoDASr0J2SrVjlJNq2rCH193GhvpULIInyc/ZmOyNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hPGlrU19cyAN3zQ6YIGQDDqItqVmU4ak+pQCItJfjk=;
 b=YPJGwP4D+PT+9KsJMBYIKa701pLOmwRXA0EsHE6PiLNyyfGqAtK2xMXIYM2q05Ml6pQY410kxx0Ugkwxwr6sTrusxIdtPN0pGwXU5B5V5qq7i/iEk9wnqStZ+2u29cX3ymea9mfPs0m83Y5y8OE0cTVjKcHFMiV/S55vWYVglz93GCOlOOinAqhYW//LhC4FMX+4dARneaDQTBONsyjArVPESC+VaeRbyaVe+E4J0BGfO6ur9WlIF0Ck0PGuoQi4XsXCFDgcDV/SgTq7R51423TLrkUJuyxbldMGOuVSFDORHUuSMXj9qZrlSlv+v0Cggau7Rk43KBXOnkJMP/KO5w==
Received: from DM6PR18CA0036.namprd18.prod.outlook.com (2603:10b6:5:15b::49)
 by DM6PR12MB3785.namprd12.prod.outlook.com (2603:10b6:5:1cd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Thu, 23 Sep
 2021 01:50:36 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::85) by DM6PR18CA0036.outlook.office365.com
 (2603:10b6:5:15b::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 01:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:50:35 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:35 +0000
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:50:34 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 4/8] loop: use sysfs_emit() in the sysfs partscan show
Date:   Wed, 22 Sep 2021 18:49:41 -0700
Message-ID: <20210923014945.6229-5-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a50f86c5-ef2c-4bd0-4508-08d97e348985
X-MS-TrafficTypeDiagnostic: DM6PR12MB3785:
X-Microsoft-Antispam-PRVS: <DM6PR12MB37858E214A3D3BF4CE8B40F8A3A39@DM6PR12MB3785.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IHzaC0RDij7JVhn6m5gBC0CkVUqeVMbPuiIwCz60awSUFIx5CNzr9HyP2EW8DB8+YS7uYz9J+2eGI6EP6l8maFRv/bkfiIAEfMx0KfA37NNOEHfxqgKEqW80t3ionfFHCYPeFr34dNl1kOdWLql1GieoXcaEqhhQYkRcpPueAWCAQQ8LIbZ6Xz8yzbMDBvRbNt5+xNpa9zWQ1cqcgTfklsUwi66qpUOXgQD1ER0YQt5UvI7D6H6zGNqTUoqP7mElVZ6y+MtVsKaCVO+uDTvNbEHyE7zt8AvOfvAT1Gvq0oM6mOcRzty0Oj/HvR3xtujX+/WDvFc9n8iwvl1YIptv3GXP2TxcArmNpdOKAZyEAhiBTf+kTqe4d8s9efwqEew3IZVIRsb8FyuXdm78KaY+eeUwzJpM0j5wKi6+lMt7hDYKYUcODFaVmKUEpQsJWCPUq0VglFpZEvxLO4bIvnjGWiTJWpMjLVnX4RXCLZrqu15ywqV4ue5FA7008wpHngznQ/HOGejWaT4Oo7pwfHV/cn5nQhNIP3YhHn/y+1ivt/41igiMxRckfF04dhvQbEfzBc16wIhs5mBQOB3uzbhRo3ugHKcbI40MFJHkYoz6cW6yN51k93SyakA+kMakZvGC5fYUjW4RoZwHZRpvUitHlhfGS/SRLaNK4t6Jwv1Gf8tmY4jMr89Zs+4atJrOEG1QCY/pkqfFt5fK/oTGJqeltQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(5660300002)(6916009)(426003)(2616005)(54906003)(7636003)(316002)(4326008)(6666004)(508600001)(356005)(26005)(70206006)(70586007)(47076005)(83380400001)(36860700001)(1076003)(36906005)(86362001)(8676002)(8936002)(2906002)(36756003)(16526019)(336012)(186003)(7696005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:50:35.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a50f86c5-ef2c-4bd0-4508-08d97e348985
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3785
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows the size of the
temporary buffer and ensures that no overrun is done for offset
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index fd935b788c53..63f64341c19c 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -875,7 +875,7 @@ static ssize_t loop_attr_partscan_show(struct loop_device *lo, char *buf)
 {
 	int partscan = (lo->lo_flags & LO_FLAGS_PARTSCAN);
 
-	return sprintf(buf, "%s\n", partscan ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", partscan ? "1" : "0");
 }
 
 static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
-- 
2.29.0

