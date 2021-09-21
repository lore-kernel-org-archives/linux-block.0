Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A29C433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF8161050
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhIUJXW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:23:22 -0400
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com ([40.107.94.46]:64161
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhIUJXV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lK9Gsr894KolGQXzZpWSex4q7cLOKjapDyxwig6EBoiDdxod4kj/noXGIOeBtFLS2efBdX4a2R0sp9m40Co40giazp2qXrT8IlW3LKrXuVWKQKMywDpmAjDrBsV8VidY/SoMjkLJqmwlSl8jKCRE2BtWTKWkmr2tKJY1HZ2HYTEpx5lN14Bt9cDYJpUXJSaXv2KHIO5FGCC1J6xW6QTqbp5nwOBEDRdfUB2HkdD8pxR7TOlNoL+KXBWAS3CZktNnuxjCelLv48BQBV3uZkG/PpIoTHuH3LzQL1MazgKNNFeChNAtLTCMEO752oX7YLmBHxZHDXY9WEnybzts89j7vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=JC4DAhPEq7lr4N5Q1PUa1GDAblU90slo0cTRZRF6OUc=;
 b=nesubadXLH2vA6Zwy4KDOq2WXG4zCCREWZKMXs094evVfYert/3ZtaXg3xlgWkhRl+wY2F7t4xnEKB7OwsmzrVUUCjIOrV0zkRN2RozilH3MAkWWGyffRpdDYd8fSxa11ozZ09auqAO7J4fQ/5lzacALhPGoosi9v7mvC9oU/kcoNITsukjWHHBlM55WrP+UFrZ7ebvICK/Q/f57NMLwP5Q6bezVheWIbqGl3o4fUMyKYnnnB4SGdEEK89YqpF3vdCSu6yZ6n5cb0hjsFt/rrdMej33uISbRxCqTl46iPlzgks7hSiL3MTFbBQNFETSjarT5y0NUxlNofQFiNyOHkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JC4DAhPEq7lr4N5Q1PUa1GDAblU90slo0cTRZRF6OUc=;
 b=XIc3Rx59Qmt8jlwZF0UszYg8WVM5p8NoZ8cjbY7+PoLJ2WzNfZ2bv3RHUtZOnWvMuFs6A9bEtpu5B1gm4OWm5abvg7UqLcRxkzljbkWEd2ML+5lYz66ElBomxs6CDYKcC4csrAHxFyqd9CIhFnWY+H/Z6HmmHFa5SJKDXbyWZC4ZGBQqY+3PPx3P7A7ObDTR7J4ro9CgUjhDqPdNYaJkujDdx7JpO+jBNaQoO0vyp+nKf6G+cdcHxR+Qbwe7XBWGCbDwFhBSJcxJPXHYBJ9NkCyCuvYAyE5TZmZByfMWQekR3rwHvdDrqfvdzA0MtB6e1qByCtLeapBZZ4EEJend9g==
Received: from BN6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:404:65::14)
 by DM4PR12MB5101.namprd12.prod.outlook.com (2603:10b6:5:390::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 09:21:52 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::dd) by BN6PR17CA0004.outlook.office365.com
 (2603:10b6:404:65::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:21:52 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 02:21:51 -0700
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:21:51 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/8] loop: use sysfs_emit() in the sysfs sizelimit show
Date:   Tue, 21 Sep 2021 02:21:17 -0700
Message-ID: <20210921092123.13632-3-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5fd3014d-4178-495b-4683-08d97ce13f83
X-MS-TrafficTypeDiagnostic: DM4PR12MB5101:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5101495F64FE6F77117AEF0EA3A19@DM4PR12MB5101.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6z8uHbMACKF7MVEjfXYwLCjpK34JXqGeAI3/xQIKzRhZNq8Ghwav25HlSU1thqRz6Ta2xJjp/VTupZGIZY3FuAvgWVeNWLVSez45Q+buwX1imts+qoLm1d+iLzFoi1QabIS1iVNI2YKOBc5t36F2Bis3fLzxLDq2+JmedV5oikUBtTeuJW6jvveWPYU0JxkZIFpuMj22Kc5vM4PSqNq8zNB0qLnVdo1bIooZeGYcSOzOiNl9sEVEIiMoPZtP02w6Xuia7mjdLj34UURoKqikwO/9RGlIoptCNHXtI0e3fFPqQX8zv5SPoPIr7NftjZkLX4NATtmw5GLN6Y4D8dfL+OxqJ0i9didrtC37hPQzQJzYBM2C0x3HNbGPcvEYc+tKrkCMJXP/jWy5/WfXAuriSTZBmP46kAKS63xnuJN3Duz10o1VPzNbX7ka4aKausHB6GJUJOHi+gSTRW1HuYOeturOBV55ZMynJtIEnLZo7BAnibuILNIwgcgaAuWLq3oV/+jW3Ejyac1P3OxIvT/eKIPcXnv9+u+XyQ+Ovnj4w4oF/hnY7PrX81v5yNZbFWgI8uD33KJrGAG2uIiSrn2ATbLSar18iq4YHiBl18xyY7iBGuAwZc5wC4jtiet+mOlp0jy8jKZtN2zbuPHM/sNRip6TvgmhdntZm/Omm6UzZ0JA2zzVqomrN/vbGi5Exc5xkCd11OQpS5rOup+AKQF9hA==
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6916009)(47076005)(4326008)(2616005)(86362001)(16526019)(186003)(7696005)(508600001)(426003)(6666004)(36860700001)(316002)(356005)(1076003)(8936002)(54906003)(5660300002)(7636003)(36756003)(107886003)(70206006)(70586007)(8676002)(336012)(82310400003)(2906002)(26005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:21:52.2890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd3014d-4178-495b-4683-08d97ce13f83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5101
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for sizelimit
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index e37444977ae6..ec1329afc154 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -861,7 +861,7 @@ static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_sizelimit);
 }
 
 static ssize_t loop_attr_autoclear_show(struct loop_device *lo, char *buf)
-- 
2.29.0

