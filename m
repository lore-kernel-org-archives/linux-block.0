Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E93C6FD18
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjC1T5v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC1T5t (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:57:49 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1DB3C0A
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCWDl0lfGhAEKAPpXVoWQnaR7aQFIRXMSRKiZhyIWMIv+FeXJ0SpbJuAaTiRjfFqehSe7ySNAx7dNUlRMN1NcXW0BRDEFtqZ9ibsUtQHqKAG5W1yXdOJsXYQeUkUs0RphmHM7521mMQx+bB1FF5b74vbBpJ6ARI8SDcdshfuFMkyUgq7HuLIguTqz0MRAuek8r5votR2+LpGhe+UtOpfz7P5EYkASDwYTOwCBA754kD6FkhwwVgWb7zdHdyO789HwzGjtQt7uc58p5gvAbWAD5ZL3LbALqekOaSRV71Y7+bB/Gk16hd2YZSwSxvR2uayrq7XHaczcB2zJWV22NoXIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdbymjXlHcqVEtPrvrOB18iTp+mF1nybaePS+vKz4Uw=;
 b=h/1UHDMKpcXMBLxha1V8E6JYrINu7HwWuhu7k2Dbso+8/S8RZs+kc9kTyw4586i00ggc2hsFB5dJZaINYrUK1CrPlP5KQV/ZDATuZo2Ll7rzzP5cAAxi93xOyfhFJTScQsZ+zDIne6/45K7kzpVoksgxZV7NcNcGGpYj5hHQdwLhHH7Yqt8hGiOMnZgHmzR7dlet8UNdPjnMo5kU0rNgIP1DNleBkmTYfbxJlNhmv1UZpEF2FZ6O69L4mWRzZTJLokELxs7vI5MbYj7nWt1uj+M2s1eog2+LzKWkc/DBE7xkqBt9/oAhP+9mi3rzlvGQDajFuXWzzJc/izwr3EHmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdbymjXlHcqVEtPrvrOB18iTp+mF1nybaePS+vKz4Uw=;
 b=okuEd82Lyj7T0o/VWr/825Z4hD56knsnhkP7MZvTuowBlGwpMg4FNJkk5MQNGwvW0xKoxom7SoBwwt+ESifCI5FWQLaHpCbWny2hv2AtrP08Adkw8cKWFdntnouNIpuNTPCHFWYrBQyNtF95yDIf9byOduBRgg5Er8inlSBjwRLC0e4pxHRvI++gvfT7pFnUd3sHz347qxqz6pKuH0cWZSitnO2S3GJzWO1f/j0vPsEfja/68fduwzOwOqQGMUGV3xEyo6i/23sigdRSSC9LaLefXR17bsGc8Mrq4C3Y4wByGOCdoGHIStCZeQG0a5gTHyMJ3y9phZueyBV8SiuxgA==
Received: from MW4PR03CA0359.namprd03.prod.outlook.com (2603:10b6:303:dc::34)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Tue, 28 Mar
 2023 19:57:19 +0000
Received: from CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::3f) by MW4PR03CA0359.outlook.office365.com
 (2603:10b6:303:dc::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 19:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT113.mail.protection.outlook.com (10.13.174.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.32 via Frontend Transport; Tue, 28 Mar 2023 19:57:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 12:57:06 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 12:57:06 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 3/4] brd: use memcpy_from_page() in copy_from_brd()
Date:   Tue, 28 Mar 2023 12:56:25 -0700
Message-ID: <20230328195626.12075-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230328195626.12075-1-kch@nvidia.com>
References: <20230328195626.12075-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT113:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 0523d7fb-a656-40eb-1557-08db2fc6a377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 26Gt1MHhVpu2INYrseh6wsG6+v25qKuXKvviPmBRq85Toif+u8khBCHea48AlUkKZebVHSh6y3cTaBvcyRRsenUwJQtCSzW5/uC4IcAWZFwYetrF7e6PMoUW8pAgST9+Nx4Biel8Pvq7IRFwfopjalgpFKbPsP80EfcUIKHqxOxC9q9NyUYBBF9a/oOnqq4FjNM5bP5MyYm9ioT0bapOjz7gd3JEj77NZK73vaATy6MI1Wcn3p+5/16LbMu2X2SSm07cLRT5KlUPmJHw/aiD99MWDfB3n9AZiTa+Xxa+9ldhxrbMELmdzP07gmGw/NMWZpRDIjsUkR69t/i5ZEPbvaPPK1/freh3ZdReVNdI52CjUcZcrrOibTBL3evILqg3+bK+xpGLvsm5JiSXiNlgiV4EdpmirIiw9gHXzq397+Sdx8lQNtCeN0oBHzfDLs7YYtkDIzt7UVTHWdiH2yOsJwgGsDifFJVxg7nVu9wQ6O/zTMnOjFuqXTKfzQVmNXSU8rYw1qjYdX7ki8/pM/Zh/CxvS3Ikso3iJVjgoNR7Xy2opvrgvOyCrRqR/rgNuySmWiyQ5YFRdmC8leXry9ulDsRRiOwvOlj8rWIrqxl7TS5LIA/TanIJGNhKNBcnvGsWN6jqEG9kbuJ+SWbNpDCWDefEDlgd6lka3MPoaX2AVF6axr5UmN+G7pnvzdVbuKVbdd/a14pYloIQLlKOy796t+/Mu63FqTCpq5O4jh0LeqREZx+0/pb1fkE9ZkTMApUWQSXQFAtwb4wxMdSScSCqFP5Rc5HE9ubF5n9kYEnfSR0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(7696005)(2616005)(426003)(336012)(47076005)(16526019)(186003)(107886003)(6666004)(478600001)(34020700004)(316002)(36860700001)(54906003)(70206006)(1076003)(26005)(83380400001)(8676002)(70586007)(4326008)(8936002)(41300700001)(6916009)(356005)(7636003)(5660300002)(2906002)(82740400003)(40460700003)(40480700001)(36756003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 19:57:19.4640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0523d7fb-a656-40eb-1557-08db2fc6a377
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT113.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In copy_from_brd() it uses kmap_atomic() call on the page in question to
create source page mapping on buffer (src), then it uses memcpy() call
to copy the data from mapped buffer (src) with added offset and size
equals to number of bytes stored in copy variable.
Then it uses the kunmap_atomic(), also from :include/linux/highmem.h:

"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() helper does the same job of mapping and copying
except it uses non deprecated kmap_local_page() and kunmap_local().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/brd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 4948cfdd83ac..3df4b45eded3 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -222,11 +222,9 @@ static void copy_from_brd(void *dst, struct brd_device *brd,
 
 	copy = min_t(size_t, n, PAGE_SIZE - offset);
 	page = brd_lookup_page(brd, sector);
-	if (page) {
-		src = kmap_atomic(page);
-		memcpy(dst, src + offset, copy);
-		kunmap_atomic(src);
-	} else
+	if (page)
+		memcpy_from_page(dst, page, offset, copy);
+	else
 		memset(dst, 0, copy);
 
 	if (copy < n) {
-- 
2.29.0

