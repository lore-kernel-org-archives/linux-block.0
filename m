Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D219DC76196
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 19:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjC1T5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjC1T5q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 15:57:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8249C3C07
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 12:57:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uct8y8bBlJ/Au8hq7lPC7g76zsIjsrf1qObT7pvG07ffko5pjWnALtUR1Y7EfmNcN2ZQ2cv6vOKs6D40d5mjOd5DXDWQNMVuc6z9QvgRvUeAfmEnlCMydwYGaoxbXzwxJ4+mmSR9++i9Dp+F9sjjMmNvAUMbnNa8Ji6k5Qn+PdEE3Elxz+XVjQquRvwJ+VKf9s4hQRuf8rtiuZvdhO09d2HXzWay+D7TUX8nlBPK0o9g5tAJ6qLDG7FnXtbbQDM15ohLFvq1v8RZzpJgsDqeTt6TKpJPB0kAEnqzXbcltE+58vQMyVfELqyBo8TfhcSzHBfJoiazbIslt5TlQii3Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zuf7NqPGvTY8NOarg3vG5UR1d22Bxs+nsqK6A2Chkd0=;
 b=LmT5VgrA4KWZJysaIxOpD2BocGP0GKTT9TdCGRHWcJeqW+LQUMOkpfMYu82LrtGJ+4YquKU5b94x6gHSTURrLmTvRh2gQhpkieAvBjaPuzZtmOdn6zbtgK8qmGfW/E8hneYGauCyNRUhCLMVWdv2dYNtIyYQ9N8/+Eshe7x1kmkJYutVe3SoIL2PglL/GC5AU7WssUnYg7HibFjmgOQ2hy+3zywNIPnA29t/nXHZOLQOmxH4F6clq/il4F6LAHzZBElOjOnpPJu0FxCIiBoIE1QYvYYTeoT1vcW3ooeeMjF0/Uqk69MToag0mrgvqow84es7Wjz/7VyOsQJr22ml8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zuf7NqPGvTY8NOarg3vG5UR1d22Bxs+nsqK6A2Chkd0=;
 b=LtWBkjIWukfPkLkdOcP8sDSrWh1im9aTCiRcuC+Af+83U8h5Z8suPdURFGowNKPC74ee4K5+O7xNHP9vG4JjgydakO0nUM5sZ7Ke+5hls+3dX7GQZLqWIn+LCTHTQllLiLml9obR+WWn3SYbTkeqX/FV7tAOSquCRfRmvyq8vhw+bCjp+GCF0QZ2dSJe9mMBxISe3jY2HpvT4UVNjD4yQBaqq1siDIwp8TWn7mEi92CBxo9eHfx7HCkmZl77a9BIEOsqtGZKP8NS0H0ijCY1W2pupk6v2pWFDXJ8sLNAhiEsv4WzZylsrGNXBP11oOsbu2XWotrzVrJXrkc11VMIZQ==
Received: from MW4PR03CA0337.namprd03.prod.outlook.com (2603:10b6:303:dc::12)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 19:56:56 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::30) by MW4PR03CA0337.outlook.office365.com
 (2603:10b6:303:dc::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 19:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Tue, 28 Mar 2023 19:56:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 28 Mar 2023
 12:56:44 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 28 Mar
 2023 12:56:43 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/4] brd: use memcpy_to_page() in copy_to_brd()
Date:   Tue, 28 Mar 2023 12:56:23 -0700
Message-ID: <20230328195626.12075-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1d5b3c-f8fd-4f45-d3f9-08db2fc6957c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yupTjSoPBTNKtry+5dw07tmtO0Z4mvWm+J1VlIRUit4V/fsJuEwxUIWDgHC7WE6ZOkUwG/+QpLMI322J2gqKjoAjkrdKjXQzICBhGNv1/Q5LtORQa5ZA6rVHPtCNnqXYl2LglOfJMZl+JlGJwMOFrm/k/A6rt4a2fk5mUl2olqAucxHTH3HI8MFu7iZ+OvxONhuc1oErJnrMqKgj/UrS3Tp0vW2fjyymEwE+Zs58lNreUZeXuh7sc9ir1qShUxEOTxsivTyBdf5BzGUm6T6BLk0OnpH7vhf56eeI0hfpRITfLY9gPxxOcwC7M7Yj+69U8ekH5ffXDdJMyAbMrcCObE88d62nrfp+lbm+Z9L43YNQXuLFteQ2MC8FGz5GsHgp4AMPdN9xgIIOpwQq3/rITekzAS5YSXpQsbDulSNBDgFcU8A3WQk2NVytlIEVY5y47sO1RfVfrW2jTbAcF/Nm1M3i+tnrF6q2fCSzicPkDbCgONVuKoUO1xWpOEkrFSflg5RK4eIdBKYD6ewzDqKaKZ1l2S6JGYz2lWxMA0bdiEFz2zOGoUYhg5I4SsxgUhRNfP+9klj/7E/XfsqQ2K6/uahJM0c7E+fVAhKt95yn5z19geoLDmVORaKjmnIHDxaY1iiyipukhoS8VakC03p4SgL8lg4dQr/BZiTSven7oIJymFI+P/zy3FRexoFEYeE+/TghsbQdLlYuYnDfNtNRwpmE+mkWF2iv3SxpVXj50jd2FDAapf+fHCGhEKyljBFmDe3N2tej9UKocuJajgi1eRGpNV9cpKW21ujaBRAdCKE=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(47076005)(426003)(336012)(83380400001)(2616005)(2906002)(34020700004)(41300700001)(36756003)(36860700001)(5660300002)(7636003)(40460700003)(82740400003)(356005)(478600001)(40480700001)(54906003)(7696005)(70586007)(8676002)(6916009)(70206006)(4326008)(16526019)(6666004)(186003)(107886003)(82310400005)(316002)(1076003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 19:56:56.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1d5b3c-f8fd-4f45-d3f9-08db2fc6957c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In copy_to_brd() it uses kmap_atomic() call on the page in question to
create destination page mapping on buffer (dst), then it uses memcpy()
call to copy the data from source pointer onto mapped buffer (dst) with
added offset and size equals to number of bytes stored in copy variable.
Then it uses the kunmap_atomic(), also from :include/linux/highmem.h:

"kmap_atomic - Atomically map a page for temporary usage - Deprecated!"

Use memcpy_from_page() helper does the same job of mapping and copying
except it uses non deprecated kmap_local_page() and kunmap_local().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/brd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 34177f1bd97d..91ab0a76a39f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -197,9 +197,7 @@ static void copy_to_brd(struct brd_device *brd, const void *src,
 	page = brd_lookup_page(brd, sector);
 	BUG_ON(!page);
 
-	dst = kmap_atomic(page);
-	memcpy(dst + offset, src, copy);
-	kunmap_atomic(dst);
+	memcpy_to_page(page, offset, src, copy);
 
 	if (copy < n) {
 		src += copy;
-- 
2.29.0

