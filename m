Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA70C433F5
	for <linux-block@archiver.kernel.org>; Sat,  5 Feb 2022 09:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiBEJMP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 5 Feb 2022 04:12:15 -0500
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:50529
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237149AbiBEJMP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 Feb 2022 04:12:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANZmF8qNEYJW1eIHWszFd6+ONERCEd2GqF4vpFPZ3Vf6GVr3x56DOjH5xqPSjr+uuP3MCTjS5V5H6N1Nc1UIoEfHqF1XtXWZFJfURbGM+wdlYJV8qZC8ReU+KwOktIlgCR+feZYMnvS1zzj8PxyiGvpxtexphUp6kSmJb6+g2tbudqnXFSRFrhWrR6psBSLYu5xpYgJEZ/x3is2X1HPvD6PNgoKvj61RUeg8yPHh+9dU6WS2uJmySGfBg1IOn8uwieq9dpnSRbuaVIMvoIo5oIENKn8UUY7S+VybGB/Yfw04dq3RgYKZh/X/l9DZrhVjXFKq9ql+TigwInyCW7oqNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/0BCEvyx2xUbhx8IoG6k9KKrWt/X4dMvFwzs2jhsjw=;
 b=HjqsDfwouVHO5bv0ncjs331iPerHSFTzf9nTUStXjl+tRPdH+S/F8nb7809MOWcMIXhZECaXc5st5+h91MPFigs02RBmp3cYnCR6OGetdhD4vFmKoIrLbof/Cwwqff01rrXTuj7gDS3WQRo1wu2IKpBOpehQ+MuRmx7q2APZNXKcUmXGMZkmu0V+5zah7rPSDEG1Fmb+hj0aJRWU7rLEUOAJu01LS/Ca9gPzfskA84sbbDRRHP60UQ3jc+ZJVMAONUlZrSTVSnmE924B4VPhJmM0lKgsGQvhS4q5T5qkeJiUzUWm7Eo0z6alk9Xi0J90lYP+H/xO7SdGS6j0FhcoRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/0BCEvyx2xUbhx8IoG6k9KKrWt/X4dMvFwzs2jhsjw=;
 b=XuzoS9qwBwPunnpPgVUykJSSbdA3KAszStvGrI9Xy2PaDxn4C/nLnAw9ZrSyoWnS06wlxpiM3vyzqaZ0VI8E9VhjJ7+6VDIuwC6T1piFYihvmfu0I7BymmNzUCPKIEr1axRSf4Z5ZB/+JjlLe+Hw+YEoyjo1/siKHujJfC5LatwDk0noGgSCNSASj34KgisZ9gCfQitaNouqcZ1dFyFqOt8Tf+9PqagxgjYHKvN3XAZYnWoEJ56ffU0g59tdriDp2blF0v6f4WR3Kw8qvnmjZdz5a3wCHssAvBihKVFP6qbagUDu4b1RmCaFf11QcDE3GY5BM6NV0W8YVZ/JUK1Kqw==
Received: from DM5PR07CA0026.namprd07.prod.outlook.com (2603:10b6:3:16::12) by
 CY4PR12MB1477.namprd12.prod.outlook.com (2603:10b6:910:e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.20; Sat, 5 Feb 2022 09:12:13 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:16:cafe::64) by DM5PR07CA0026.outlook.office365.com
 (2603:10b6:3:16::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 09:12:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 09:12:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 09:12:12 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 01:12:12 -0800
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <shy828301@gmail.com>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V7 1/2] block: create event class for rq completion
Date:   Sat, 5 Feb 2022 01:11:49 -0800
Message-ID: <20220205091150.6105-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220205091150.6105-1-chaitanyak@nvidia.com>
References: <20220205091150.6105-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6aa49130-9519-4712-5734-08d9e887990b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1477:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14776B355FB3C1FCB2CEC535A32A9@CY4PR12MB1477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IWOo4cg665IHOgGmC47Ce/x2hjOVPJ8hWSW+jWU5KxhGVC5Fw74N4jBPGnw0LV4GR9CrgEOeuHu4OlbFWP0/+08/DSOp0vZNMxGCU9Z/kHsVrMdgqWHnRonHDCI2i1C/66jI38nWQuBnoVs0G2nVm46Y3ZvTnRF2NASK9QHCFjd5KzahGjx3Oox7Z7uOP5D53WUoInBxZHszX5KfvJOqa96vjrf/U86TkiwqFEFywbFOpUl5Qmb4c32e7mnXEXBmRCATzwgl4H44ISzjswo0UQTCKjbBJLOlHjq17jJgsgku9HXAJxYaRiloXfCT7mmMk1VIWy6nTZIDibe7UoartIaUcIsQHua41YwarqhR7A4mAfvb2tjB6ALuFYpESKa7FSgPDKsxTGJLA7szLvhocdGj7FBX6syYeUaOPZV21Ww2SoD4PAOSfFu/JOs6wtv83PZX1BAqvhNXvPiYaBhrL1QmoPko4Ye6r8qPiVm9+k7Lg8O3Fkxe2aBSXcsRduFRfKVTc5mJ+2jWen8BEAzHYYu41EVFk93BXUSGj8Z+3I+OidwbUCESrFoB0Rkd2bCg0oKVckW/tPZYmWpxRAy3SOWxUwdj5AWjPlFH5gwIpv9yfNs5e/k+dLfi0mVFd0pSULQhir6UeJuEmNWar/CufNfuq9Py4aoxyLzSU3RYj35bJzReJP7h5AhAPqFZQcWyusNm7GPhWK15TenoW3OWyQ==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(36860700001)(8936002)(8676002)(70586007)(70206006)(7696005)(36756003)(6666004)(356005)(81166007)(508600001)(40460700003)(54906003)(6916009)(316002)(2906002)(86362001)(47076005)(83380400001)(5660300002)(16526019)(2616005)(1076003)(426003)(107886003)(186003)(26005)(336012)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 09:12:13.4428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa49130-9519-4712-5734-08d9e887990b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1477
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Move the existing code from TRACE_EVENT block_rq_complete() into new
event class block_rq_completion(). Add a new event block_rq_complete()
from newly created event class block_rq_completion().

This prep patch is needed to resue the code into new tracepoint
block_rq_error() in the next patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 include/trace/events/block.h | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 27170e40e8c9..1519068bd1ab 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -100,19 +100,7 @@ TRACE_EVENT(block_rq_requeue,
 		  __entry->nr_sector, 0)
 );
 
-/**
- * block_rq_complete - block IO operation completed by device driver
- * @rq: block operations request
- * @error: status code
- * @nr_bytes: number of completed bytes
- *
- * The block_rq_complete tracepoint event indicates that some portion
- * of operation request has been completed by the device driver.  If
- * the @rq->bio is %NULL, then there is absolutely no additional work to
- * do for the request. If @rq->bio is non-NULL then there is
- * additional work required to complete the request.
- */
-TRACE_EVENT(block_rq_complete,
+DECLARE_EVENT_CLASS(block_rq_completion,
 
 	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
 
@@ -144,6 +132,25 @@ TRACE_EVENT(block_rq_complete,
 		  __entry->nr_sector, __entry->error)
 );
 
+/**
+ * block_rq_complete - block IO operation completed by device driver
+ * @rq: block operations request
+ * @error: status code
+ * @nr_bytes: number of completed bytes
+ *
+ * The block_rq_complete tracepoint event indicates that some portion
+ * of operation request has been completed by the device driver.  If
+ * the @rq->bio is %NULL, then there is absolutely no additional work to
+ * do for the request. If @rq->bio is non-NULL then there is
+ * additional work required to complete the request.
+ */
+DEFINE_EVENT(block_rq_completion, block_rq_complete,
+
+	TP_PROTO(struct request *rq, blk_status_t error, unsigned int nr_bytes),
+
+	TP_ARGS(rq, error, nr_bytes)
+);
+
 DECLARE_EVENT_CLASS(block_rq,
 
 	TP_PROTO(struct request *rq),
-- 
2.29.0

