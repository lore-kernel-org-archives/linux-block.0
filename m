Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A702EC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbiBOVeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:34:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbiBOVeE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:34:04 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF48AFABEF
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:33:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y/dkl1p8Um7GQZjXytdffEJKPfkG50P5R/YAHMch/cM+AWyXQqmO2odOpldsBO0nmdPk+Ww6R9k7CoznLroN/sg8Aq2IA9yiB8WOAn35m6LWOTuVkjt93N/OMU8+BSjj2NqLrLX62phXpzIzGvZBoW6GBWrnPyCYh+IGH3gWETlIhHDE22DuMmwN121ARSUF4Zw0dIgQpTpa2XmXRrDoiAdX2Fvgk90YNPeGoV7EgXKlWmQbWz0emU/44UWYHL1fsvD08zsJmxVsW87RmIYCTiYgX7G3lxIv1wSKSHXyRMv0hxRVMGTlSrJl9maOYCgTgxAYHYN8KCgHeBczWDouzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBaNSjKaFgvWSO7NQJV5wU9zY8iE7LQJaYZZRHkKAwQ=;
 b=YtkAzKq73EysGKOSGQk6x8JpR78nVu49pXSq+0Qr68GKEcTx+SAcVONdBVbo9P83geOrQwh5BX/jZFiskv/HOFOF/Ds0F+WFHEPoFOjm/PgznOEWCcva4qku01JdR1Oug/mIQeEbLn7EEQ6Slu9fKtFISegZsdPo2krDj2LYC4aFxf9Llt7JJK1wjmSWoxKUPyxMAotkeAHUpSqi3aDdCtaKQG814cMLlb8VOR/vif9KNoKAte0Vso/+U6rZzGW6zJK6TA+VJBnIXmBGkXQKwpo6+TgIU2eihLaJi9JsF/5E6Bn1ueBThptyx4A6tqp/5/UWBkYnfoqrVp8Pv0sV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBaNSjKaFgvWSO7NQJV5wU9zY8iE7LQJaYZZRHkKAwQ=;
 b=O7KRopY8Mr5/wMAs53sDYnQDafA/Osq1puUUtg/Oa/dKGi/T9ANUMd96IMlY+X3/B9cORJnORrDe2rmHeD74hY6jy1zMzJfGbm8DsBDubZ70/E7vNG4Z1yMwdYCqZRFCQ9wlqbv6jmj3QHUhzZKDEtjtb8MlKY0c+nz9as/TuYFsD38tATqU/AgZ3CQHLv9V7fviibIAMhg/KVc0rXeLb3GsZTimERn8MIyjzUko1vPPoSfbRAr/vteZgJEfFQXhnFUXYmX5nEYNcKQCyihZ10cG2E4K6SaxcExNE2ZXdkwIcb0xHzUvJJT3xBj2AHj0R3bEwJajKJR8oYlJALaoVw==
Received: from BN6PR1401CA0005.namprd14.prod.outlook.com
 (2603:10b6:405:4b::15) by LV2PR12MB5776.namprd12.prod.outlook.com
 (2603:10b6:408:178::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Tue, 15 Feb
 2022 21:33:52 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::73) by BN6PR1401CA0005.outlook.office365.com
 (2603:10b6:405:4b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 21:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:33:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 21:33:50 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 13:33:50 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V3 3/4] loop: remove extra variable in lo_req_flush
Date:   Tue, 15 Feb 2022 13:33:09 -0800
Message-ID: <20220215213310.7264-4-kch@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: afb56daa-0326-4eda-ca16-08d9f0cadc40
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5776EFD74854855924390F4BA3349@LV2PR12MB5776.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOPm+mY5Bhx63Z6QtoAh+729hd3XEyUdGElA61BIL04Y6ZG3IeWDxGSD/Yl289vlzrcikYgAgrHih3zBaDqVcvIpg5qxpdHB1zI0g+RQbmrVwYBaZcnQbtH/oVaobAfLmsVNlPypGk6g+F5iYaLhFZyyWkpAbS+mfyjxj4ikGb/FpoCwd1Wq264KRZi6wvVBoEAbBUG+KEHQMMKl2FGza4XtGEkAebxa9gs4Hoj4wHy/UrmRQZ9IfnHthwhY4lDTJgJAhTGA8t8RkCMOljJQTb71xAM+uluzefkdBaKnFzFEHdruPJ4j19aXZp7G8VRaGV7pmvjDudxHFNq9mt6mlHo57MGyx2Pt08gkdk8y5asBANWRdN7jj8F8/lofT7GqfQXuFDbod5XrzLP4ZWvh21Cjxsjd9dGv5b/lsapB3Ff5Ll1gnS1u2E8brSa94GKB6B3CcOl8dL7O3nx/9JEqYmM1sP7d3EimAO3ROS9MKwCMrwbRtqRshhIxJNJkB5T1RkkdGiX3UetKD7p7uzL2tVdB8e9v5UbFLb5+35+ik0NmdV986ZzeKRURC/1f6KERF+qLCySg/FZzvL/08g4mCTn7MNNLjsD+geK3NLsJ6eTZMJheGiEdThnELnn961Gz7lB8eF09BAMuh9T9HKF+ulbEkg981zMT7zSriKlJO883gQ0gqzvVRRFe7JPpzG2ZlpdqqJNxfR8ILddfn8kZrA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(7696005)(6916009)(6666004)(54906003)(2616005)(36756003)(8936002)(16526019)(5660300002)(82310400004)(83380400001)(356005)(70586007)(2906002)(40460700003)(4744005)(4326008)(336012)(508600001)(26005)(1076003)(47076005)(81166007)(8676002)(316002)(186003)(426003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:33:51.7210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afb56daa-0326-4eda-ca16-08d9f0cadc40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable file is used to pass it to the vfs_fsync(). We can
get away with using lo->lo_backing_file instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 77c61eaaa6e4..18b30a56bfc4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -326,8 +326,7 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 
 static int lo_req_flush(struct loop_device *lo, struct request *rq)
 {
-	struct file *file = lo->lo_backing_file;
-	int ret = vfs_fsync(file, 0);
+	int ret = vfs_fsync(lo->lo_backing_file, 0);
 	if (unlikely(ret && ret != -EINVAL))
 		ret = -EIO;
 
-- 
2.29.0

