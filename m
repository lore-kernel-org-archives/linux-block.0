Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B9AC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244415AbiBOVdz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:33:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244427AbiBOVdz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:33:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C36F5437
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:33:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlN5DjckrGPNmRDSpY3gLP7J6P5lU3StG5RzJwWqpHgGuJsx+WwfwQ1KHLGvWreRzZgaUASQ/A8Jh6MwRbifDNrW7QDGCrKbHWGQsk1FF/1gkJGmeoV7GjOJAHVgTBd6UKZ2lGA6i40u0w75xPl14RWeHWxangMlKLRABcxb9IU7Wm6omoxyBE48hZWCP0237hupmwFs6xvf5s8bUrNCKJM7bCiB99Wc6dVH++qEr4PeG6V5KduJGGlKUWkCik1LisA5dLJCk1WWjEZ+a3fgxMltNuWpZEzGtyDvkp400ff7CyiPJZrh2+Id5qkTm0YX7f76OCiZ9FmPLOm44oL5JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPRL8HISYCbWUWa86yzKyPNqFQr5skJ1vmQY5DJJ4s4=;
 b=FG6clXy+h4+ZEEPG08EeYrICOqEPkdfZb6GP/tv+0jTW4BJbAWuKvAbHfe9oie+ROHE4UQveloVq0gchIPY3f3l/E6sYRnF6euN5sbBtL8ejxlu17Bewqo+DI1caKjN1H9eTnCGf0GB7phc7UglbjvTPypTNPHFhpoZ+xnbPL6Oqxl7cTEMRbR1pNhe51JnR8hFkzL/zirEZokCn9/xzy5JzQdlnYLxIGzVApb8rse5O9iKfYRWTcNM5aVYSzTOCDQ0+CFmvE9u/L2IioFT6FqwduhI3ZaHy9djjyN82mTfsnilMc9S09aFZ8YkVZ0ipWz4GdA0SG8mW0laIK5ayNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPRL8HISYCbWUWa86yzKyPNqFQr5skJ1vmQY5DJJ4s4=;
 b=mHBs3eicdUnEa7YEyhyV3x3SJ4D9bVwDEEjUQb/TQgKuwGzYSD0IRns5yYyABa4zTe57l00/ckYeK8UrwFGpbDLkpkkG8tRs9i0DY+9EDT4SmLwnL0EoTyKKakSpYu+APaDqiGjWhco29mZ+kXlGmlIrCJqw6Njj6lSBMqHi2XNuka2kQkArXG9DL08VXe4kH7B/8dxBU/NFXm/R3uNT37eKxlAbyUXzXr0/lQbW+69xVSoQvhomR67NPJURLq/weyYeZ2bqYt003LyGOIV991UpX5JaRKzDxdduP2jESDc1s0+UsNbvGVQ0LULYO+WA+AIXcckb460IdpRjwu3QFA==
Received: from BN6PR14CA0031.namprd14.prod.outlook.com (2603:10b6:404:13f::17)
 by BY5PR12MB3940.namprd12.prod.outlook.com (2603:10b6:a03:1a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.16; Tue, 15 Feb
 2022 21:33:40 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::94) by BN6PR14CA0031.outlook.office365.com
 (2603:10b6:404:13f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:33:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 21:33:39 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 13:33:38 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V3 2/4] loop: remove extra variable in lo_fallocate()
Date:   Tue, 15 Feb 2022 13:33:08 -0800
Message-ID: <20220215213310.7264-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215213310.7264-1-kch@nvidia.com>
References: <20220215213310.7264-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4df9a6a-a4a9-4887-1f21-08d9f0cad58f
X-MS-TrafficTypeDiagnostic: BY5PR12MB3940:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB394031C9782C2DDC1F1A7A8BA3349@BY5PR12MB3940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kscNHtOS8TEb9J8oqLoYAj8WRO2X5HvC2ACOAecWkGr/kKyB31rn14defUIJJds6K8YG01b5dXA4zbLNWcup/kWWxC/ZiojJEsSEY3q3A+vh7PHLP4vTvkHqlA8+F5GUU3Ts3Eje1gs4l5Fu5iJ6p5iqaJUWripp3uZyBchPr5zmsWmXvo3198dQEJs1+3CpfVqM5ct9BBSZfZF7rCwpu37FpYQQThboW1j4nZegIAt447+ymGYI7WUyITURhNtDpABYoXWlUx+46qr5mXAgwR9wLK/jXm54llGPR/cu82DmbYScefdKiO+TpFQ+pQ/sQ1eNYbtsV6FY86GvDoT2eRTrbKhMA9vrLcOUYFoaJMHFmBmizg5s9O/rD99qnEUveuN5hZ17yQcWuErRDCq/t954dl7ubIxOyYYFF7eH05JbyqMAI7ArNeCcJsZIQibQrAVIMgASW5Hj2xE4MHi2noEtS97PEQJHQNPYKctkGjgBfp9Q7OB9LlHtz6pDpWa1WdHDas4acd3XrZtwrTUKoMzI7a4saNZ7gX+23TvrP2zMq3WwtTSfqET0PWMVNYT5BN/YE1rgK1T23+qlS8fOLvvnh8PqTUwqp4YaBuiaPicf881wnAHrV0SnRYLsyRTI/7kcMCUhUem9c44RQnRWtodVb3nsvhdXO96+3PPofzMmOMVdbXjFyEZdpx35vuZUPA8lXGbhOcmelIxQHenSTQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6666004)(26005)(16526019)(1076003)(7696005)(186003)(4744005)(316002)(508600001)(6916009)(2906002)(426003)(36756003)(336012)(2616005)(8936002)(47076005)(5660300002)(36860700001)(54906003)(8676002)(4326008)(70586007)(40460700003)(83380400001)(356005)(82310400004)(70206006)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:33:40.4903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4df9a6a-a4a9-4887-1f21-08d9f0cad58f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3940
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a55e5eda1d17..77c61eaaa6e4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -308,12 +308,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * a.k.a. discard/zerorange.
 	 */
 	struct file *file = lo->lo_backing_file;
-	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(q)) {
+	if (!blk_queue_discard(lo->lo_queue)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.29.0

