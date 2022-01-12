Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351EDC433FE
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 06:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347369AbiALGGz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 01:06:55 -0500
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:14853
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237360AbiALGGz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 01:06:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJ75DYPmA0Nvav2Y8LkvTThzSVjCq4KMYE//ATQ2wh4mYDurAmvvugApN+qFhu7x1oU1ULO+d0xZ3mDc+vjlKXi7f8k6J2y0SQ2ZJMQvwkqRAVJdoDkT8jn3ioOzw1NeRLLjOytY5ZQSfwi7mjGE5r7Z/QBUOrMYKpiY7lWejwWZ53Bqyel9fFWyGdBQuKcwchruRY2VNqKB4c3Yz3c+UAWnK/Klyko4kkgAdBi1UZR6ImwQ/XbQrAzg0zgnwhSTAntX31j0HCUlvpkSslJzmh4G3ovlhE3eCKv1OMCB9t4qGvn0TjtYDrTB52aeNXqt4pzSY5N00bucl1A+KzeqDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ewIPaexh3bowNf7HnIrcqrErFh+2JVbmAwA+zqi9MqA=;
 b=XImZjdOxhsTFcfm/mm6VosMM0oOHIGD0+EqkHSxlemDYPzgYsPvDo6yO2I7p070U6wWKZituOUdPstRIFuWh1MKS1FwnA9K0ELe94ByP/n9Ne0EXC65eAAJlxpkdDJ3lI8Kcr3497ubxBbZUWsUG/6/vJrdaUuTm1GZOTgOKR1YwWukIai1F6fJ77Yxlr09bncQvEcj+2J0fY8n6PgltzCYZkCBIntX73qjfJovn1QW6yVqz9eMf0AW+8/RuLgWNIw+kJ13x3YE+T51hpePMhOM5mUCFHGTYve48EaIimmoT43NQNc+1WwtXHgdryFVmvIAD60HVe4mUcIB680dm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=fb.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewIPaexh3bowNf7HnIrcqrErFh+2JVbmAwA+zqi9MqA=;
 b=WmMeU+grshNxGQxspbYO3DGFMNClMMH6j3tNlbcl1K+UpMcLaZSw3vNvDw8CCeSOSEQauKYn3F8mIiA/WWlai7bRVHm0JpC/dbgE3ajcs2d/FTRy69oQmHzsi5avaNnopXaLRMfNi00/AKkYKg1AVOKkFWGP0L/twsfn2heXAVUYA7joAtq78MRrs1mPnwEToxD38D+DgmtocReBKPnlguXCcAhYKsSrjUECmfixb2EKus0Ng85f89/R8fgjljIT6ksGufx6CgSMcuIKrJtJPpXPh/KpMVoSv6qrIB/xRtCQGhSGTtVudq/4cf9STlL/qCEDLvg2osjsszuxCMmHIQ==
Received: from BN9PR03CA0238.namprd03.prod.outlook.com (2603:10b6:408:f8::33)
 by DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 12 Jan
 2022 06:06:53 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::50) by BN9PR03CA0238.outlook.office365.com
 (2603:10b6:408:f8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11 via Frontend
 Transport; Wed, 12 Jan 2022 06:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Wed, 12 Jan 2022 06:06:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 06:06:52 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:06:51 -0800
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <osandov@fb.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 2/3] tests/nvme/016: adjust to new nvme disc page output
Date:   Tue, 11 Jan 2022 22:06:13 -0800
Message-ID: <20220112060614.73015-3-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220112060614.73015-1-chaitanyak@nvidia.com>
References: <20220112060614.73015-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23c591b7-298b-43dc-906c-08d9d591bb12
X-MS-TrafficTypeDiagnostic: DM6PR12MB4958:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4958D96E786A18D3804971B6A3529@DM6PR12MB4958.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrLm6H+4TUGeIScFbf+UXKDKMzMqRJwjMjpf9dNWnSeSGyXrtpGvJDWYYpjm5FDrM4svXEbVSAOhzxPqhhNQ9HPPfSWrSPc/oCVePH6R3FVEmLG13Be57FDgb1/8Qm7w2eSnUlrqOYPiYklR55j/9DEoWeqFLyeptHG+AlGTml4Q8BDVxd7yRbKG3WGoJQpo71Ya9lGakavjO6of1wIqrrtCQBw6qPFN5+DAdcUgNjSIU8LNCFPVDMIspdbIVfPXPFlTilH5FkZbGNC3RHQ0Dc7B1LCkr7rEJAAXgH/IJarWY94Ppq4c1ltk2s/EU166jbjA5U91H7nByZKcphAwOMT2QCeyz6flQGM4u6As4iN9Xm9TFQ2q0Ie0KRY0Smd7kVPOTNpkjeaQnuj1yUrqnTBEWII/OkmoNbnijX7sBuYE37BK6bDn6EKU2O+bGUuMIG/I4NarOTrGSOKPzhUhxuyVTe1c+LRCAGVdntrJgkPR9q0zcyYHgJYnHtVKLzW7qIkmg2ZfjlwoUSy4pvgyOgeguC2mvlm5VgfBhMhDdh+lCLrlaBruLMstn7bWQSICyZlA27iZCLWtR4UsnOsX0S+mcO2FRQ9XMsiLBeAYVnNPwEbLv0gDbVHHngH+LS5utJMOPzloYpu30hRGeIUelWRDYK3E5g6/lUfq6xsoqV4fTaCCj4ISDwu5Qph0SshrPIseiS1TyfscXB7/5LBEnKlLecpftxvHZcP2tPx7stMv1dK8LDf2RRt5XKy4mWOwLliik+sFOF1R7AgMw7q+3Dutz9SBXO7NSOIZJVu86D1L7jGCgBzUlYlFsaAak6Qt
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(8936002)(36756003)(54906003)(110136005)(86362001)(336012)(2616005)(83380400001)(2906002)(426003)(508600001)(4326008)(1076003)(316002)(107886003)(70206006)(6666004)(186003)(16526019)(70586007)(8676002)(36860700001)(82310400004)(40460700001)(356005)(7696005)(81166007)(26005)(4744005)(47076005)(5660300002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:06:53.3447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c591b7-298b-43dc-906c-08d9d591bb12
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4958
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

The latest code counts and prints the dicovery subsystem.
Update expected output file.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/016.out | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/016.out b/tests/nvme/016.out
index f59410e..ee631a4 100644
--- a/tests/nvme/016.out
+++ b/tests/nvme/016.out
@@ -1,6 +1,9 @@
 Running nvme/016
-Discovery Log Number of Records 1, Generation counter X
+Discovery Log Number of Records 2, Generation counter X
 =====Discovery Log Entry 0======
 trtype:  loop
+subnqn:  nqn.2014-08.org.nvmexpress.discovery
+=====Discovery Log Entry 1======
+trtype:  loop
 subnqn:  blktests-subsystem-1
 Test complete
-- 
2.29.0

