Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CF6C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiJJRBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJJRBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:01:06 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B5A3FA09
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:01:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJS2izuA5nO5rgGgZBwgE94rxO6dmlRtgFRIzTA6jTAYOkkmBnU+1lZuwJVz4fhubU4g2ypsfRL9v5Dd+7gDvtRAJmL+gjWc8T2J9ci9C8ZI3mPQXd2+BACsWlgrkzo01Wif4VVR2p/n3pUJSQB+F7UEzCgmeWfIL5bDMvUW6dRKdsaKIzPih+Adh++KlI8Nsa8ZDgaBEaVznfzqehuQe/nK1FrHR/IcuRXB67e4Ukl23kFANZkI0wEgT6v0g3i6z27zKqwUbScnuvyrE7FZBbQcE2bXhRptG5s+20KevJJ4pGce5Q4xzClKp1ae2OI5OySE0N0Id5cBWKLfLNi1Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqcX13LGIxrt+38AapM+u1daoUuMxB5PQNcxzunNi4I=;
 b=EFfokmQLX2Tx2vYTfVs8H5H7isvlNbEADFSPZUtbL7qeAjsiFGBb1qnEnWcGwAK246HM5z8awEXb6XM20sLWdl62F5GwPNmwA5/VvhSPvcuF3UUyE16wlwo3zz5yUXCpXHW8LeziM8cAv64DbtyPnYTG4H1aUA+dABRarNQe0T/bWiX3kkDYtakIhYGsWLXlFi9v3hOLUFhtww2XrYonqDgzXaTTil2CFc/6rkv0OsbRWxCCddFZvQ3TZ03UvdG4AWFPHDBJ+tskplaVZ5fiNCOYT8BWuLMZNREuKTXtpwplUrniCx8wzaOH8FR2ern/CQhb/CnT/GlbWl8fPJcaTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqcX13LGIxrt+38AapM+u1daoUuMxB5PQNcxzunNi4I=;
 b=mHAs4g7y4TgfFMO/kTu8ae9Lzk5dlMJVCT8e7ZAEAZ987A5PHFlV2GNuL/zC8/qSX4VdSEFj8l6Vi5Bv858QriVw0FKp2g4nl7mERuR3j4SwuXxGbKWhZJlnF0E0cK17llZ/WEjKsLM6zlSaI4cA9YN2nt+Nfn7ZCEptX1FXkFleOiCJXcVptbWQ306+zn7KHe7jHQFsgPhQjdvNf/r0oMoB9GouZHz0crQEbzwsZ3Dd0/Cmx3Kwf5G6H5OA6T3iVdn7gDRrnkpgRRYEwYOYJKggrdIs5VHrgNZLPWR50G9QNCn96xlsBZK3StoiAce1w5tZMkKxot9LfUZssTrFgQ==
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.36; Mon, 10 Oct
 2022 17:01:02 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::f6) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 17:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 17:01:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:00:50 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:00:49 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 1/6] block: add and use tagset init helper
Date:   Mon, 10 Oct 2022 10:00:21 -0700
Message-ID: <20221010170026.49808-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: e62e075b-b445-4816-3b48-08daaae10353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZuNDf4gax3QXAEbcTAkLYNm8ZzQrE4FiwH06AnF0RajAAshr9d+hKZ/ICbDOc+e+vYM60p/bLfPdGvSLcLhq68Pta56n57Nm2xp0M3XGmet4jvSmfa6hShkxu9xfQ5aXOrD4hkuSneToj2WWAV6zLr6srzENh4x6KwRougqc7Ibr8c95NfViJvRWV4sNHH3WRXA7+PLhwwn9qtD7TyScCrr59XaVFkeV4k8L/vd3s5XU3/ZOXoVoS/F/sJI36clJGW4RMa2YYodLrlW4BT7lylJnBXYS8QEZK3ORDHmtbqUR112YuHYrMDawY1bvDa/nQqdpnb7Jvr5a26p6LqtWkZyfrhncN1sd++zYRqfr34fewYUG2Uy4IRVD+MFwwnc1e8Pw5Q1s0+pFOkLTL7STidauqYbySl9zoUJGqnGNcS0X4Nufl4tuGrCPdzGAt07PFYSX1Mk0/OZcOtXJKwWgYMVtg8gryOJraqfG+9CbTv8/rjBzeOxFofOZqZazgpYR95oRWG9fnfAw8YjFV0P0A0t7qPrbOky8LpAMg+iLWUwIeZhZkTg7DcA0Ad6fNgzA8eKwpucyRjPg44YjEQMhZ3Jv0TlGXDsYApPNSiCjjiDaeZO6ZgLMUCEeklpuMN3rQIEID6DmtElkTYM70j6jBXqgAX4fTBDj3cWo62YXztybNNZobveP2Ho6+qeVMTp+ZOymQGsZvS0nG8xCLpvMfiHlVx3zeYhbr3OmTDjQ96IrXCRh3SNmr19wD1Nto1OnCX3QzUZXSIojEISViZ2Qg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(376002)(346002)(451199015)(40470700004)(36840700001)(46966006)(6666004)(8936002)(40480700001)(356005)(82310400005)(54906003)(7636003)(478600001)(2906002)(70586007)(5660300002)(70206006)(6916009)(36756003)(1076003)(186003)(82740400003)(26005)(47076005)(316002)(8676002)(426003)(16526019)(2616005)(336012)(4326008)(41300700001)(7696005)(40460700003)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:01:02.5558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e62e075b-b445-4816-3b48-08daaae10353
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add and use a helper to initialize the common fields of the tag_set.
The newly added helper blk_mq_init_alloc_tag_set() replaces existing
call to blk_mq_alloc_tag_set() and takes following arguments to
initialize tag_set before calling blk_mq_alloc_tag_set() :-

* blk_mq_ops
* number of h/w queues
* queue depth
* driver data

The number of arguments to the new API are similar to the existing API
blk_mq_alloc_sq_tag_set() used in block layer to eliminate the common
code to initialize and allocate tag_set.

This initialization is spread all over the block drivers. This avoids
code repetation of inialization code of tag set in current block drivers
and any future ones.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c                | 12 ++++++++++++
 drivers/block/null_blk/main.c |  7 ++-----
 include/linux/blk-mq.h        |  4 +++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8070b6c10e8d..0060c6b37b69 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4429,6 +4429,18 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 }
 EXPORT_SYMBOL(blk_mq_alloc_tag_set);
 
+int blk_mq_init_alloc_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
+		unsigned int queue_depth, void *driver_data)
+{
+	set->ops = ops;
+	set->nr_hw_queues = nr_hw_queues;
+	set->queue_depth = queue_depth;
+	set->driver_data = driver_data;
+	return blk_mq_alloc_tag_set(set);
+}
+EXPORT_SYMBOL_GPL(blk_mq_init_alloc_tag_set);
+
 /* allocate and initialize a tagset for a simple single-queue device */
 int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int queue_depth,
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..3b32d5231eab 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1926,12 +1926,8 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 			flags |= BLK_MQ_F_BLOCKING;
 	}
 
-	set->ops = &null_mq_ops;
 	set->cmd_size	= sizeof(struct nullb_cmd);
 	set->flags = flags;
-	set->driver_data = nullb;
-	set->nr_hw_queues = hw_queues;
-	set->queue_depth = queue_depth;
 	set->numa_node = numa_node;
 	if (poll_queues) {
 		set->nr_hw_queues += poll_queues;
@@ -1940,7 +1936,8 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 		set->nr_maps = 1;
 	}
 
-	return blk_mq_alloc_tag_set(set);
+	return blk_mq_init_alloc_tag_set(set, &null_mq_ops, hw_queues,
+					 queue_depth, nullb);
 }
 
 static int null_validate_conf(struct nullb_device *dev)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..b34d55fe79e0 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -707,7 +707,9 @@ struct request_queue *blk_mq_init_queue(struct blk_mq_tag_set *);
 int blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 		struct request_queue *q);
 void blk_mq_destroy_queue(struct request_queue *);
-
+int blk_mq_init_alloc_tag_set(struct blk_mq_tag_set *set,
+		const struct blk_mq_ops *ops, unsigned int nr_hw_queues,
+		unsigned int queue_depth, void *driver_data);
 int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set);
 int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int queue_depth,
-- 
2.29.0

