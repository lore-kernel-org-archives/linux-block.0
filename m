Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B144CC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9009B61159
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 09:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhIUJXy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 05:23:54 -0400
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:5088
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231301AbhIUJXx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 05:23:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZgbMP7syMKT8BcFZurG7zc9wfbgOCphEnQ2lnV8D+oeo3mvNbRu61/HfnDQBgvFIxcD41g52u91HfKQOH/qRQQCRneQmQkTIEMp4HJ2gWK1o8N8fkHbHXsrvPaf83aysb+Hw7E0IRlnQZMGa6TAWvs7l5zOQbujtTq3MVIbbVkxhbccrvnJa78+vQ4qJzUDfl0RzCyYaeLz57PqHq+5w4yOwaX/NpxWBd5pWg8gNS7GXDSWXxYwGYhd14KlB5wUFslM5a6wFUbhc7rFmqo3ThcgcleCYXfQIcVHJvXc6uRfU4F3ye8eN+bk+Bcbf1oUDM53MqHQS6i6gqHcACcDYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=+hofEBzIjHIGAx/kafNyoatEN83I/reMA8RMvOyxDMY=;
 b=R2jG7beJtQv8RbbA+wFZ3egmIFBOY/O0nsuHKlHPJfiA7BNzG2+QV43mGDVjgFUJxLcy4Ec7Xop2F3XhgBcfA9bccDCWKmuNnfMn5INIO++dXNWj3mIxBh9d4yoQzFkTKhAj4OiQQnW8Itm4foQxJHavWQmHYf9aBihZ3EvudKe0drVaXf8SPyyVqQQMIaPcNW2O78kveOZTHQdQDjaMtq6gpC4w1Prmzxpc+atBIizrIhvvhrTGLos55CT0H38SbEALpM1Rn+ovmQgA0DSWE1ZQqnJvlJNmbFCu/oHFgwYAjHXhsYGA9Y4sbZCRBwQBqZSfr4p/09c6BaIYQ6v3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hofEBzIjHIGAx/kafNyoatEN83I/reMA8RMvOyxDMY=;
 b=eWbeE2IWfYb9ydpl7WU82pr8RCThUH/WP559d9liUWMxv8u09gPeKzNqIJnQqc5M9w+2Sku+XAgwl7JOREhUjuugbfe5lcM1sFuvYQSPJEvINCVQ/t3YLI94JC9vQQIsFpk29kBRdvvoeCMIELEoP7egvUoYCIKkYYzQyHyXKiEektJKe+q9c0GnCTYGPZKlufrj1Yh0gXybEImB178W8pRvha7HZ2iejtk7VtkscQWgYSxvJBfj5E7w3pIdDLwSjM+m5mhMnHP461elgW/jFXC/N1HulDhajYq/GViJoH9NamldE/xOhBhE0b46WjV87nkxSGNqa7OguKOb+Im7Hg==
Received: from MW4P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::23)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Tue, 21 Sep
 2021 09:22:24 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::3) by MW4P223CA0018.outlook.office365.com
 (2603:10b6:303:80::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Tue, 21 Sep 2021 09:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 09:22:24 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:23 +0000
Received: from dev.nvidia.com (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 21 Sep
 2021 09:22:23 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/8] loop: use sysfs_emit() in the sysfs dio show
Date:   Tue, 21 Sep 2021 02:21:20 -0700
Message-ID: <20210921092123.13632-6-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: c1337aaf-bc16-4903-492a-08d97ce15276
X-MS-TrafficTypeDiagnostic: BL1PR12MB5318:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5318EFC0913A5AE9007D7986A3A19@BL1PR12MB5318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDdFXMa71bWEOo2zNu0Gi5SrZjOm1N72AqqCVpqmeu7zQCRojZ/PJNFEf0sd4riGhyNz6NTroFWhO9Joub+Z+Ex7V4YlvHYpyGMX6SZlv11rAtaFjuy5li4lNQcRHskXI5vzk4SSEwBm9mJci7Tu1/Yho30qtFHxJuSDItg4xNTSfcEgi6nMl2GXg7z0h9s1SDnlrDkwJ2YY8k8qKTddsmMKmwQwAXXWoQLzl+nvWfIAciOEJV6G2LqxIEnJJEbnIbUnjze788k+WK17knjxQx948K3Y6YpMMTPFUujYNeFKdnv+4I42OaUMhJeB232A2RtLtoSjg4nz5CrMquiMZyMkqSg0EXq3sMIe3aKeakgtLW2ADWrLwhmgln6IH/lW9RRYXtCsMqpgPsKpCxPPoBzT0X+Kc2/6JAu0NR2VvjTmdj3UqvVp7GDSbykzpHxova0sr8e1TTAcs5ukT88WuBB+Unvz3ZdzKxjN0ON78quPENiQdVh2EVrnweiVR4bZCst9YpyF67INh396desuAGZMHdgXNI9Yc0Qy7LH8iIpDMsof9DnrzWEWYgZqc4EVPn6pZq7d6kchVrr8smy0kUPQQY+UQbG4tXEAMjkixwezdktthaCYHUHmz1o/8KhVGa/WIoXddAImOapsK3LL+XcmLCQ07ACl7VHvomUqiIGWy4+eszTWlPWO5wtC+/clHfmzJUR65N2CjyOihsdi2A==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2616005)(6916009)(107886003)(4326008)(16526019)(36756003)(8676002)(8936002)(426003)(2906002)(336012)(83380400001)(36860700001)(356005)(316002)(36906005)(508600001)(7636003)(186003)(86362001)(82310400003)(47076005)(70586007)(70206006)(1076003)(7696005)(54906003)(26005)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 09:22:24.0996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1337aaf-bc16-4903-492a-08d97ce15276
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Output defects can exist in sysfs content using sprintf and snprintf.

sprintf does not know the PAGE_SIZE maximum of the temporary buffer
used for outputting sysfs content and it's possible to overrun the
PAGE_SIZE buffer length.

Use a generic sysfs_emit function that knows that the size of the
temporary buffer and ensures that no overrun is done for dio
attribute.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 63f64341c19c..fedb8d63b4c6 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -882,7 +882,7 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.29.0

