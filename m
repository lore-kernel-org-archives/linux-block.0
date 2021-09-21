Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50071C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E1661131
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhIUJXo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:23:44 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:12892
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhIUJXn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBnUl0MFpUggQrl4weEc2cGqQeTet6wIzGccW56jnvZFpO7NG5/lf17Ug6XkFlRPcWFF2OYVxXgtobYLi7uTFX+ENpBKLaaI2GAOMzjvkNvprctgQ8GEirYMpAJpPH3OIfMi6atYZ9ERPwquXBu92R7d1YXI6wbjCmbjGgDsA3jPsuNKHIw10phUDQhZNxEkmMv8LIuwCB4zwiWHbOgcVg127dP8SsDcp1MAeoA1M7DWS7Gu5a6lrRKEXWxG/eGCiaK7VDfE5zcj7d+zBHX5Y0IycBbzqbCFjTo3nthxLrTGQQ6mAbXIL48lLId29lweLzWWjEBphumCpi+bvXXFog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=lSQm8OH6e8TKVdWYPj5V/Cy/TzpZpmNerTwTpse3eUQ=;
 b=kbb5Ub4ba5emOnfYJsg5J/l/YQ7bhjPmnGHbVIRRtfL/uCb88cDRBXjKLXruasttSyMV85z6YfYAtSkpmLpuig6XNplCi4s0lCqIiEmNIe368V9D0LjQ8FE7MT+2fQ3X9WRwPAaChRNQOT0s5/U7IvuqrwSi0Q7cLKyHo65d9EuFD+Ff5I7FsJ3kh3BA141AQHGWcCoJ7t0Sv4U9S35iMdfawHfStRVibaTADuTCxvuNxbtLf10rmul8FBOZfBySflFWO1GlMctJhF5Hp0nBf0eRGp1tsyB7zrErG5mireD30Rf6pei3tkAongEwTMrB09BEcc0zBxXXPRJuvtVQqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSQm8OH6e8TKVdWYPj5V/Cy/TzpZpmNerTwTpse3eUQ=;
 b=VgcOFqLp/2/XAuC6HdgB89bttLsFSb1eiALT+DWNgDI5CAXz8+3pRrL/LVJRW+UaJXc8qfzGBz8uU8CMU98e3D5SkI8WCjjbJq2+sQZc6mO247qh6B3cQ4cc/jjEwEhRkONuQX+YqXcORwOPG5AmpHl4HTCZEKuph0XEdKBiVO0FuWaLHeqwbat9pA2jINQZ4OezsxLOsRkaORUBBCP+31if2H0zUelSsnI70SSvyx6dJkpMp7zVNxoGyMxstS9FGcR7145IWGvaA5gM4pnIB+emtkj+g5P5Yv2wEl8YtTfLr/lCHi4goYxOa1dLeTfjjn20nncNUvm8GhFSHBTKNQ==
Received: from MWHPR11CA0003.namprd11.prod.outlook.com (2603:10b6:301:1::13)
 by BN7PR12MB2641.namprd12.prod.outlook.com (2603:10b6:408:30::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Tue, 21 Sep
 2021 09:22:14 +0000
Received: from CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::48) by MWHPR11CA0003.outlook.office365.com
 (2603:10b6:301:1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:22:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT052.mail.protection.outlook.com (10.13.174.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:22:13 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:13 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:12 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/8] loop: use sysfs_emit() in the sysfs partscan show
Date:   Tue, 21 Sep 2021 02:21:19 -0700
Message-ID: <20210921092123.13632-5-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f856f272-9aa5-478e-756a-08d97ce14c2e
X-MS-TrafficTypeDiagnostic: BN7PR12MB2641:
X-Microsoft-Antispam-PRVS: <BN7PR12MB26416AF6F653A3E0557E6261A3A19@BN7PR12MB2641.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8GieMS/2dlAD2uolSzsXiEhQL0ppNpmUyFcnk0SVsIA5i9jHi8QJrSQ3IpQcn8uP12+xQLlPkcY49lsbMirwbecKsrMp/xCPvOgiE83OnmL9P6bbfeKSejX4e3Il1t+TlAkWAV7im7PqRrpBpbjka54XtirOYseQysjiXTr9UEo3Q9LGL0p9WHNWiC6kiYKhNLHB43UBnOWstpQcI+THmC3RetGq82pm+mBcauDd4r04hyijYWoeC4BuXBVxDERrBp45YFVqwZBk/d6HFJ7o5q3IwNDaLOmdOt7LYUlQjP6/CyidPoswLJm/pMnHP6WAYYaN6Wxs0dptCq5E7cXKMAKJilkxJrR6aVbKdnTa8JJd0iA2YpBzJBRRIAjzbGhcXGTk0HD7KrgiA7P3qafaC36SVdWHjszh9HNsKZd4GoSNkRSZLUDZy7/Sm5romuKSE41Zng6hYYBceMWF8fWh0JVFOk8aJDaE2f75aRmmYAW4/hJ1GTR7139a8oqFtM1uUVc48XCzmKyWbKeZ+Cry/BrxGIq4Qd6OS1abpmn3ou1TG2lTYxtsJXZ9yIiUe/5JCWOliA5x0AF6VKn1DPMNIY0K6bbcCCcTj6b42012Sck6A2hC/8AGz+e8Lm7LS/U1mqAOrjuE/pJeYC7ppJU19Lbj4Vwcwx5ua4FjsQRnJjMNdW8KPNyqbd4ewlnX25OPMHZUuWLjWjzEjOXFjg4lw==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(107886003)(86362001)(186003)(316002)(36906005)(7636003)(70586007)(70206006)(508600001)(7696005)(47076005)(356005)(6916009)(5660300002)(8936002)(36756003)(54906003)(4326008)(36860700001)(1076003)(2616005)(426003)(336012)(26005)(2906002)(82310400003)(83380400001)(16526019)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:22:13.6145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f856f272-9aa5-478e-756a-08d97ce14c2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2641
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for partscan
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
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

