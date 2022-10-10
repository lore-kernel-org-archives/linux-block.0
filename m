Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9FDC433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJJRCO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJJRCN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:02:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8923F33A
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:02:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvjfo40Ox6V3rwUm+utvjib33FlFHPLKZUcq1uydBDRFuSMpXIjSPVtnIghjuqXpF/atBUpqY52JIC6fzSjVt4BMndljGvlBaHkzKQsUWM2HczN/1BV1XOpf3LQVKlIiXHAxTjtc6LYtpjSX6MRdy/W3hA1aVQ9AladxPdkT3EScwbNs739yZ2BfsCZ9v66kxUEaVbSKQd6CohUxLPsREUIWKWT/VdxBMmnWpjDG/aYqSP7pl7rnFWUj36aMr42p6TiGoudzGecaxH8wZ35K0BxMnhguO8434PwUT5+G/p2ZhRg6pIhZAR1z+BO2ktKNTw/tpUws6cv6U9/m3SEKMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGYt7wDNsJhkReIYKMLa1ALfeADXtj37NPpGS6t3jK0=;
 b=ncY6S8wqu81ZsWxoRPCeE047WiRgucQon31WkkikQKGiS1Px+KqEtBc1zUiIXQW5UeA7MobOhJ0IHxU/OWKqJewo/ofzBBeg6dvOqaynuV+afDNVkWs8AfzrfFFIUtqwe2n6RQ2LZkHoJwJBeE3X41DsLS+ooktiFMRNQDuOTCW1vYh8wJKe2CGwOgZxAzuVwYvIAFwDDVDLNMFaJ2i4eXtAvQWsHDIdW0ps8vCTYCa5mGS9x0LMYCotyuCWt3dcufEkXhVQAI60xbIokszUYJDwhBGzNc9YnCgqLn3ygbN5dFu0nJT/pIFeuq3+ehEYAATih9yyk/oBZSNPaO0RUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YGYt7wDNsJhkReIYKMLa1ALfeADXtj37NPpGS6t3jK0=;
 b=HNzT648xRISEqIkEPutPc9tWQic5UOOge8rG1Z5DirNDq1OV+v2Qm10hUPl9EE0qGQHx3B4jJ1EYclarJ8qv0aiaCTdmgbrEr39aPHw2ut6BdS2VYCtPWp6TRi8iIGbe4a6yv+618yBd5gk9OAa42SC1WZBqCPmNz7044E2Dq26NtFSd0CuOl1VW0pHOfAL2UwPfQ00iX8Bq9yIT6MXRV86wO2v0QMqEL6SP6hTDV0Vtr1YAjpYJm8albXM+le0lMsOdS2lOXKp3Mv++1f1wkIxADvHIRpZvHNVRYK8qTFUU2Cw0OshxV9Nk6Y1TqTVcix/aeNXMp5liBM3KBwW4Tw==
Received: from CY5PR22CA0050.namprd22.prod.outlook.com (2603:10b6:930:1d::17)
 by PH7PR12MB7209.namprd12.prod.outlook.com (2603:10b6:510:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16; Mon, 10 Oct
 2022 17:02:10 +0000
Received: from CY4PEPF0000B8ED.namprd05.prod.outlook.com
 (2603:10b6:930:1d:cafe::7f) by CY5PR22CA0050.outlook.office365.com
 (2603:10b6:930:1d::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.16 via Frontend
 Transport; Mon, 10 Oct 2022 17:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8ED.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 10 Oct 2022 17:02:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:01:52 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:01:51 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 6/6] nvme-pci: use init alloc tagset helper
Date:   Mon, 10 Oct 2022 10:00:26 -0700
Message-ID: <20221010170026.49808-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221010170026.49808-1-kch@nvidia.com>
References: <20221010170026.49808-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8ED:EE_|PH7PR12MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: e247c5cc-3b3d-4e3c-8eec-08daaae12ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RMVMAnkHUcuspSYcCC0M639n5yxvyjt+8pP+WQjgHIe6PPjtnpA1uC5z0OXUeytMaqbvB/nyugNa6vErz4f866QitZMXTHXmP6gSDUVeChN8a+wd7JIQ8wXyPj6nM60YSMhl7eEc+d11MbuhBoEHaAB0DZV82eK1LIpBplulS1A6oUd5bxiot17x8j54BudDKkzvZqb+R8s1H6zY13MI76SJHYEIoT1xGuWmfqQuSq3apG3mBCW08e0tWlzaKB7ECy2DTtc0Fffz1YimjZbXu0U4NR0qZ5HHvf14kgfxoVAvpBRSdr0dobCdI8R8LDUeSmJbzjycS4JzZaPI2aVzBxsojNexr649GfJn/DI/ecnzF8/xMBeMGknQk3y/Dd0ngRSexurXUhhiTH6VwnaHO2BJFdJWX7ZI/6MqpP4n2xdsyKpD0evCM0lZ22qNl+SCL5faLJUQ55H+JZ62nwozSrh0JYktAikYDAcwz/tTmm9F76hPbWzaxoDOQs6h9JjeLRrsdQY1AjZGe35OwZmBwd0PlFeidec1sC8UJ1qA8AOP1p1hg/qi+W3SxfScvxPlnYwHUvcEbcN3AZ+nmvrJ/XRa4mQig6v3qtmvNji/3coCJpoXFOow1w98my6TSImG2EaBJ0LD5ZliIDe0Uw2/s9kFpve81r5HcDoUvhoalVbMw7O+ZQwQ2e2px6FWG9qcXuqiLkumfOs+28Clsh6tGibeUKEsnIe2FrgpvslpTevvAsgSbBrCUrDVNtWZyhpi1Up7Y9DpjGhQuS6aijGdtA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(4744005)(7696005)(336012)(82310400005)(6916009)(478600001)(83380400001)(40460700003)(54906003)(70586007)(2906002)(70206006)(316002)(36756003)(4326008)(8676002)(186003)(356005)(26005)(16526019)(47076005)(41300700001)(6666004)(426003)(7636003)(2616005)(36860700001)(1076003)(40480700001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:02:08.5598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e247c5cc-3b3d-4e3c-8eec-08daaae12ab6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7209
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7bbffd2a9beb..2c153c08e418 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1756,6 +1756,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
 {
 	struct blk_mq_tag_set *set = &dev->admin_tagset;
+	int ret;
 
 	set->ops = &nvme_mq_admin_ops;
 	set->nr_hw_queues = 1;
@@ -1767,7 +1768,9 @@ static int nvme_pci_alloc_admin_tag_set(struct nvme_dev *dev)
 	set->flags = BLK_MQ_F_NO_SCHED;
 	set->driver_data = dev;
 
-	if (blk_mq_alloc_tag_set(set))
+	ret = blk_mq_init_alloc_tag_set(set, &nvme_mq_admin_ops, 1,
+					NVME_AQ_MQ_TAG_DEPTH, dev);
+	if (ret)
 		return -ENOMEM;
 	dev->ctrl.admin_tagset = set;
 
-- 
2.29.0

