Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F11C4332F
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348337AbiBNKhK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:37:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348998AbiBNKgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:36:05 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2062.outbound.protection.outlook.com [40.107.95.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825FAA2F25
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:02:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3c/byQgwwklYk8QvfXIhjv9ffTaS8Rkp9Wevlf77zfaqnoPkUqrGRqhJXeqXn/gP6mGQ3fLbXgpAXxaacKFZutY3Aj4I9oTlm/oaeEMqyFza7sIgl7G7YzUJwnmgOHCly07Dyt8Qjpt4SNFsHzs13PHfi0vOZeFvVGvt72k8gu4iwYxWLw+6T3qXo7+R/BWzERI5LaoRCYOte2JfYXuGWAIShIBmqDP4zqJgdoALtdyFqokPv/JNTnsLbcY/KpiZmk1uMgsw4oQbIxjESBM7FZqmWOiTyuTAwZYrok9oqBsMZfq63AZGNbrMrrfpCZHaGuLDtaQfNnr+9ohx4g51w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rqf5KKvcQRTBo2JD5S+jsaS4BNf2pDZpa4zth07JTEw=;
 b=e4lCCg7CjHVn6D6ELzCsayIjZU1SYuivZuwZHa5arX/cgeWPL1qgy0IyjAMDDqEk4DYkuS8o5EMFv+yIu3oGKXoJiIvn4V+ddlIDpZgQW55Hrx+3MC+13IpwqPQRycm7/5LHH472O/3ADAUXKmJ0DJXCIhXR8WF+Ww0mARzfmReC2vE68UuD9J7BycIJ2aXtX0iybbs/Muj33TVfo6j0UVRJE4rGFeQ7vBijM7iN+APpWiMQ9XoFGMchXecaGFFYqTgTcQoxKPzLScgfj/9YMz8545jXL2ufpOEwlJg+/3McWYh9yUEzx127AapAFEBlYwSddJA8yY2ZP/dS56qK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rqf5KKvcQRTBo2JD5S+jsaS4BNf2pDZpa4zth07JTEw=;
 b=AOQMjEbzCZLL9LqbNn5ARUIIYczdGnLjexJ45ZzZfAueqqI2T391R6g8CEqsY0F8K9Fd95ps/8BiN/BOAumKDnoRXKaHTsvAI2vOnEpFGK6aqhKKNVOQN2vuhR0HaqBSUgDnLAqefpBktGJFOSJOUZvfc5JKtkh7yc/2JyPWLPzNwP/gQdAKWi0DPBYIIGQe1S+THppQRA4Pm652cQXxu3hP0Vzrqwcn6TjA4/rvpy2kQ/yr8+vT3LeMj177lEwXGUdfyjBCrc88EoSY42iX7hWTHmGvj9AN0EFsMItdy34qtxUTmEjnyihxn1ZKf5Lv0wQk7IwljBt89y4yEWLuSg==
Received: from DS7PR07CA0012.namprd07.prod.outlook.com (2603:10b6:5:3af::20)
 by DM5PR12MB1562.namprd12.prod.outlook.com (2603:10b6:4:d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.15; Mon, 14 Feb 2022 10:02:29 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::fe) by DS7PR07CA0012.outlook.office365.com
 (2603:10b6:5:3af::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:02:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:02:28 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:02:27 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 5/8] loop: use sysfs_emit() in the sysfs dio show
Date:   Mon, 14 Feb 2022 02:01:16 -0800
Message-ID: <20220214100119.6795-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214100119.6795-1-kch@nvidia.com>
References: <20220214100119.6795-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caefd28a-05cb-47b5-12c5-08d9efa11c06
X-MS-TrafficTypeDiagnostic: DM5PR12MB1562:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1562E9F056427E4925CDEBF2A3339@DM5PR12MB1562.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT8nmzhCaBoDmUoVugmmDbUfQYVI7Lpp4lRKZTlSsVYZra2jYUo6+0tSd6UlhSyZEpuEXm9vFk2sJn9A7eTcWVH2k3Lzjj+RiC6B+/NMSkP1q77sOlsLlT8HQxvT7aJ9ARjB8kHGdDhJr2GMJExnTNaiW7KeAXQPuwXHMIg6Yyvgo0JVdvjxTryqod1OLQ0W7eH76LjWvUujE3n0imnm/zXwHSLe4icAT3txVL5J3+e4rih0jbIyi/y1uhLMpIHdVM6l4kv9FFy2/m7eYvv1W5C8CuOZazOEGI1tTELLHn6Jr17xO368fwNB27X/flk9ViMmzSnBvmBRSSMOE10JtdPn1w+ya2J8h3oPCaUjNaEZwIHuPEqwAjtpDx5xvxY7A4Z6qklC3P8d9jh1Ll27ODjrSeu9vD+xtMVlUWPHNA3GLgbO1/BkNdL3YT0OMDd5z/fN/xlZpPNpqkAXBIZozKmDdk2erfBmA/8w0u5IHaYI4JgpYzr7pZI4OUb8BPPmjWIRgraYkRmWIqh+AR+jan6U7fhZcBJggOykD0ZnJk8yevzTBGZtmD/1qiTa9ojoPuwl1aaLPY1udjMAdd0cRovdleUQAEClUttGvYAGuZ7EMncJWop/qHF5QhN+RH8Cy6ErCgXcKqF8fexHpekgcXy6h96pNE7aZslZX7Xfjics2tutcPP/990dqQcXiP1k7OUOZh5XHYrr12KQMNpajw==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(2906002)(40460700003)(47076005)(82310400004)(356005)(6916009)(54906003)(316002)(70206006)(8676002)(81166007)(70586007)(36860700001)(4744005)(8936002)(5660300002)(2616005)(336012)(426003)(186003)(36756003)(6666004)(26005)(16526019)(7696005)(83380400001)(508600001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:02:28.7319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: caefd28a-05cb-47b5-12c5-08d9efa11c06
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1562
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
index 7fa6f68d7e41..a55e5eda1d17 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -706,7 +706,7 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
 {
 	int dio = (lo->lo_flags & LO_FLAGS_DIRECT_IO);
 
-	return sprintf(buf, "%s\n", dio ? "1" : "0");
+	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
 }
 
 LOOP_ATTR_RO(backing_file);
-- 
2.29.0

