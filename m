Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80AEEC7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 22:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjDXWyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjDXWyy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 18:54:54 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D8D7694
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 15:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae7LkB7i2xqJ8SGOGWK2eWPVQyk8yrjgxEPzGtwCF8Bt1MWsycU9tAfAfQtnREJc82hfwBYz93qTawNMDjyg0h91X+Xm8p9maVFWClDc1/6TPlEEdvzKpcZqVhvQNmXfMhido/uAK1/3turmohkXU/w0WtvXIZoQcDuGs0kg5+CqIm1mXFIp4Ag72hROWLbyFiAHLGt9tGcSVJL96u8IPZ/GsmMVOuZjL+ZqGu8C+MyX55kqm8PvJzOSYYSf2h8nvbTm9VuY9/L/Gn8YcwbYjzF110ymFapi0xYwJND3oKwZMaW/YS02oSIcWKmWjUhQJUYNHxmWY11nj08IpA8ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65mz5BvYnryaAQGixWkWGyx8T4ZBtvRhmoh/LbK8BwE=;
 b=R5SH4zTpdNlT60rMSwPVzNRa80VqS2pClpYeuqP3iMYg/zkCYZDdQDVcMDkYQDDcPHpMRLnhhlp3gESqLs2v8n3b7l4Aoss8jKyYrtwaNCmvmUuSQPAShg6Hq9yX7B3ykbNzzU/hh/E65Lh+tTio+5Bx1z7il/RoOkoF3SROihtivottUljkVfPZbrW+yAcjsX9j6o/JmJK3C2WMFZrEwpB2dCJbtPyPLTnVRTEOkKyGe/G9uaBjQvV+rIkPOv8++/yzsoEQjOl+d10EO0uBdXQLCQuaHNJ9afQq2nFx6QA5HlAgyD7eO/Lt2mSzrxqP6XIJbosGi3eInuaR22pqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65mz5BvYnryaAQGixWkWGyx8T4ZBtvRhmoh/LbK8BwE=;
 b=eFZjlEA+XZlvMxbBZtR3rvhKmp7GvMmEoqBLIfokh3pGvHippY3Gh6TwBoU77ldBAF40tVL/k7CDYvrBKvf/8eRMgcB2ZMJr22e2W7Y/h6btsCYUm6NRPnJZTWP8sxp1j9QVJUDk5SM69DGjBOa45YjsCIgBCPa0N4+k00HWCeuPO5guJdoCuY0C+3gNecKlpYG4av1zavhFRsGO7mRFsfUmGpz3lxAL5CEtZxjKrsOisJQyKNnchJ4QBpQsx0lWagvfP929Xpum/7j28oKmW5CiulqfZBIJx7cOkAO3swt2QWlsR1/VKsrv8BOCgq7wQzl15V9vhBbh2c5/md0W/Q==
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:54:51 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::74) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 22:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.20 via Frontend Transport; Mon, 24 Apr 2023 22:54:50 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 15:54:50 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Apr 2023 15:54:49 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 15:54:47 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
CC:     <hare@suse.de>, <kbusch@kernel.org>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <oren@nvidia.com>,
        <oevron@nvidia.com>, <israelr@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/2] block: bio-integrity: export bio_integrity_free func
Date:   Tue, 25 Apr 2023 01:54:41 +0300
Message-ID: <20230424225442.18916-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230424225442.18916-1-mgurtovoy@nvidia.com>
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 33de6a1a-1792-4e1c-5715-08db4516e957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+rWX+y5uHZz1/Js2nU4FbX+Yomh2HBOUBBbMUmBkR/FPwmFIyYq8FL0Cf/BwTm1iF/acL2b/G/K3f73aku9ehXU0gJHO/NN+0R73w7wQVttQq9Sk1NRAUQnzw69ZwxMnNQ6aPiMGcQccASWhOFhnBnQl4HsQjyXpArf1muw1MKIOjbAreQrcqSmOveglRIw4CtRwOm2IZHfjrgNWiihqe+vxpqgsEBsv2kiDNr4vwS9L5Ab7h9RgPXi82t9xG4KhMT5RLhaYTqMlf09tg6NsRCMK4UKjAKW7k5IvOOCikZS8ITVugE0LzmKRwhFTUaPHl93AbBeQSj7IxVdhIYwSKX4+7jY2nzv+IXFUHQQFmePqm8JIDpGTYHW7h0vR9z9VjsYdIpbBnG7BMl58j9lIZ68Woy/cHJen1g5EBAnFqwvNDmEAbbecvDAvSwU5S+Mx7ykje0gatbObyNwmVuK3nVms0X1zhe0CSc9spL0SfzTdbNgrzqNIayWdXkUS7uE5LuUL0Fh33p6bmkeJCP/O5QeCmRsbYB3SBK3HcAetuORHPYkTzw+r+dQDXWi0VCanQBIGcS1CePEZ6r+JxvaoUITvHzUbMFaKttaQ9tqhpdPQHENUsIUqKfLvigc8DbwQQcAPYubXN7vEWAIM8w4klEHDQit8obbFkhrucda/EmqBq0dFWn9D/CF9o+SuZiazIo6xMrMs7CRUSSISkT0ioHwQ9F1weiuFkJFsQ3PIP0=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(2906002)(107886003)(2616005)(6666004)(186003)(40480700001)(26005)(1076003)(70206006)(70586007)(8676002)(8936002)(41300700001)(4326008)(316002)(478600001)(5660300002)(54906003)(110136005)(82740400003)(356005)(7636003)(82310400005)(36756003)(86362001)(40460700003)(36860700001)(47076005)(336012)(426003)(83380400001)(34020700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:54:50.8063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33de6a1a-1792-4e1c-5715-08db4516e957
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function is the complementary function to bio_integrity_alloc.
Export it for users that would like to free the integrity context
explicitly.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 block/bio-integrity.c | 1 +
 block/blk.h           | 4 ----
 include/linux/bio.h   | 6 ++++++
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4533eb491661..276ca86fc1d3 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -110,6 +110,7 @@ void bio_integrity_free(struct bio *bio)
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
+EXPORT_SYMBOL(bio_integrity_free);
 
 /**
  * bio_integrity_add_page - Attach integrity metadata
diff --git a/block/blk.h b/block/blk.h
index cc4e8873dfde..644e5f30a983 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -179,7 +179,6 @@ static inline unsigned int blk_queue_get_max_sectors(struct request_queue *q,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 void blk_flush_integrity(void);
 bool __bio_integrity_endio(struct bio *);
-void bio_integrity_free(struct bio *bio);
 static inline bool bio_integrity_endio(struct bio *bio)
 {
 	if (bio_integrity(bio))
@@ -245,9 +244,6 @@ static inline bool bio_integrity_endio(struct bio *bio)
 {
 	return true;
 }
-static inline void bio_integrity_free(struct bio *bio)
-{
-}
 static inline int blk_integrity_add(struct gendisk *disk)
 {
 	return 0;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..64aabdacac24 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -700,6 +700,7 @@ static inline bool bioset_initialized(struct bio_set *bs)
 		bip_for_each_vec(_bvl, _bio->bi_integrity, _iter)
 
 extern struct bio_integrity_payload *bio_integrity_alloc(struct bio *, gfp_t, unsigned int);
+extern void bio_integrity_free(struct bio *);
 extern int bio_integrity_add_page(struct bio *, struct page *, unsigned int, unsigned int);
 extern bool bio_integrity_prep(struct bio *);
 extern void bio_integrity_advance(struct bio *, unsigned int);
@@ -764,6 +765,11 @@ static inline void *bio_integrity_alloc(struct bio * bio, gfp_t gfp,
 	return ERR_PTR(-EINVAL);
 }
 
+static inline void bio_integrity_free(struct bio *bio)
+{
+	return;
+}
+
 static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 					unsigned int len, unsigned int offset)
 {
-- 
2.18.1

