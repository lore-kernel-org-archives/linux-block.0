Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A43AC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221E96112F
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhIUJXM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:23:12 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:63482
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231310AbhIUJXL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbEyEDntcbv5I7aQq8sFKEXfvd5aj2hMYctxLl/whSrFULfRmRcARXfGh4XbzyC0sa7TJpq3yDaTgFu8aBwXXWDPv530S0Cev/DEIIqkOZdye5R2OJZJ2H0AgoEMok1FjJnZaKoSfJ6A2O1TFma5IjEdwDJcDAzkwZ2oIT1xE6DJgLPW2/qXsPbMPCyfERN78HG4umQyFTxGswQwvtN5ihxjWv9CMHvq9KBupb0dftBY0197S1LLcI9GqXird86GLJUebhIxNctpeW1qtVy8+QVuyMJpxk8QFIbYYxNWvWhE7iXyZU+YsJNmc4yOQ00WXEkIa3mMTjUZbzKYVAtzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=XtFKyiJ1M3Zy42t1+rO6sn6EKlM6OUwxQ4sjIwnFnQ0=;
 b=bveyybrdmDLKcgLfgtvcVcs//QSBFHAGn8hG9Tc5AV3QqUW+JDkXuzv9n4DjImz9TcEaqw0KJLC7D5XjgUGdzo4oNy6Pr/MpmxJFhGZo/HcPnHPpIR60veJ/Y0+IswT+MC9is2Y50eIjaoT/H+L4JImlRUvZdSM1t878iWFl273az3A9wtUopxsILKygMvmE0nKMZrLVG8+COUoaddwb+11dMqmxACotTL+sqs9g+uRBci/gjCyYtf+eYem3ZKGh79U57pjsNwC9PCkRJFTBUUhvyg369+sQq3mcSRaVpQO7ogpmisTi2kjirY3+PlOHfuBu/ddoRXdIDTDNM9cYZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtFKyiJ1M3Zy42t1+rO6sn6EKlM6OUwxQ4sjIwnFnQ0=;
 b=UxDm98CUK7xPXHf1XRCJd0SpfEXYA3oNZnxGR+6c477QhHn7z8+ZLyYfXcpa1ZlK1Kzui2WneCG6M6wsXviJ3DMGnnAfVuLT5CAoQXOm1iRsoDN/tQNo/RILOyma6xcXRmE3rSoLYx8dB/TBgCZmuwZ1wPzV7GTC26vAfDwXtPnYd3/j1/OZQsmh7jaBGzCj0v1cnQKr801IBEcOQKCBltXT7wDQ5npNjKGSHvssEki0gh68qS0u0XwaUoESfHI98sWY3TrL8PNuR4F0e7BrvmZfFrzH74z/+GzW8MKs4fytLkawjDE1cO83OpquMvGqsKz15GYkwWfnd3Qbjt1c0w==
Received: from CO2PR04CA0110.namprd04.prod.outlook.com (2603:10b6:104:7::12)
 by MWHPR12MB1469.namprd12.prod.outlook.com (2603:10b6:301:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 09:21:41 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::3d) by CO2PR04CA0110.outlook.office365.com
 (2603:10b6:104:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:21:41 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:21:41 +0000
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:21:40 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/8] loop: use sysfs_emit() in the sysfs offset show
Date:   Tue, 21 Sep 2021 02:21:16 -0700
Message-ID: <20210921092123.13632-2-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: ced3b469-ed93-4c6f-f390-08d97ce138ff
X-MS-TrafficTypeDiagnostic: MWHPR12MB1469:
X-Microsoft-Antispam-PRVS: <MWHPR12MB14691510452876420A06EA2DA3A19@MWHPR12MB1469.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT6AdVzwE601CzTf8Hl9O5tcM0Q2kZIN1ggkB2wcjuPbZoH+cR0symJf/PIHfbjmM8JNOxFu7Vp6h7D/3V7TkSYUFCwy+Wl7/Z3E1GnoFFQk7URKXk92uGvpRitQT3FL2TpDjGRTLGlTNoCY3kQXKuI4JRq0aKR5zkwZxGIpJqyOhEOQ4owPyUehDNuNDj6PMw/VEFDC1FYLE6RmLixsfPNN2TM6AVchfLPO+PLzPa6EeOd704QsPcJv/d3luaDGSo4LQzCrwE1N08lS7na2Az4eLRklpyhJ1b72S/lH7dNVi41gL4CS0AaF0BdpEl4924cPhZ/86M14Pfk48shwSEae0abo1mIS6Fr8BHgv4Ff82VY4QrcuPmUlZLKJzUzaXoYYPs37TFEWaJrQRbsYfywzNQ3mrcdDGynKk6jqliGATYTpXRe7JXG80QJExGN1KlkzwYkQqj55ebNX7phwkb+8XMjryfdlsYeeWeXsmI/C8d6gU2Svfy+ITN33US/tDEUe8H4Stiusku5ctN2mET176PJ/oFB99gSFM0l/995R4ngyP3Uc3OB14AOo/P28qotep/+eODW6AjUbhhc9gmxxgIUMvalOHJu7euHJYAwhDajU7UHqtmjKMpgHPHrIj/xGo3fNA2sNVZC+qvjC60wlIApFaWgYNbyrdY3jEwIUQlsq62uRRLftBuYtHRRJxT884cLEdXZjfSwzye8lIQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(356005)(47076005)(107886003)(4326008)(7696005)(16526019)(26005)(2616005)(336012)(6916009)(8676002)(70206006)(86362001)(1076003)(36756003)(6666004)(316002)(508600001)(36906005)(2906002)(426003)(36860700001)(54906003)(5660300002)(186003)(8936002)(7636003)(70586007)(83380400001)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:21:41.4340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ced3b469-ed93-4c6f-f390-08d97ce138ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1469
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for offset
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7bf4686af774..e37444977ae6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -856,7 +856,7 @@ static ssize_t loop_attr_backing_file_show(struct loop_device *lo, char *buf)
 
 static ssize_t loop_attr_offset_show(struct loop_device *lo, char *buf)
 {
-	return sprintf(buf, "%llu\n", (unsigned long long)lo->lo_offset);
+	return sysfs_emit(buf, "%llu\n", (unsigned long long)lo->lo_offset);
 }
 
 static ssize_t loop_attr_sizelimit_show(struct loop_device *lo, char *buf)
-- 
2.29.0

