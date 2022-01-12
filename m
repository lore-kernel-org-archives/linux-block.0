Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA64EC433F5
	for <linux-block@archiver.kernel.org>; Wed, 12 Jan 2022 06:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347741AbiALGHH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jan 2022 01:07:07 -0500
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:40929
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237360AbiALGHH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jan 2022 01:07:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffe+hTmmNTq6z/VLu9DPcikpaCQPtvjzJtu+cvCi5L+Mq0Bu+8CyYQ/2Q2LkiXCjtSFEvGkpVQY0D7hgNxvyCHl5tJ5Si151d3yH9FPXfJXyNLKfLDUUHtGSInCHLFxLqZu/uxvMnhXPk89h4AntYG/qo5O/rIgFpUOpiIY5pxB3BdH+XZ0J60BfWKf8SN8Mlh5ELGaZGkHVj5kpyMVNxuq6zKdVxqp8ZUtI6KFl1ncf/ES7Z1TuGIA5aYFIQU3S2UbnLTmIzxLJ64/NImaMj3JepAtc/KjakWrlsSepJy+Xr9CualN9Zq14VI4Lxum/sUpNBtaK8KNeuyDVOdqAgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7rbl7laOoWWc8LiyDF6hCtYL9WgQ49bctjFSBTzUy0=;
 b=fivlXTygYVIcDGpxv0TuPdpnU126trBgg1Ll2DwFckIbX8/aFn12EolsvlDjhhct5ikZS23Ra3gfAagGG2tzs1DBa69g07BpUbLWlCHGHccGKD31nte4ifo4LcuDe25Kz0H5yvMJlalfBPYj+96QJFkvYvg1bvnwIS8KF2hzKchLUhBZ8pd6XgFkWw3emTOfIi7KqRanN2rND8zxtc19KBRVymMPgIQWu2oEaXuJeH25EXsayIgBDf146DJcGXgNG+C+v6+zaBuaAgoszV+I7gmxopNOIVb/C2CMSXpIvCRwj4oPZc4lhB2I4oS1J/1O8N9t/7OTsm+yFiPnuaHFvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=fb.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7rbl7laOoWWc8LiyDF6hCtYL9WgQ49bctjFSBTzUy0=;
 b=bPmY/ngD02dqkNGF9xjs9R0baiInydkKeng9/Z1xS87hTQ53mcEjPSeYJHaqOiC5sgnHXS0d+Ny5UBh1+bJSFCWy8r177Koaz4qKbmRyxTTvyMIHIfMlNV874eaxBE7D0lYCXN6/M1oDTuiLApNd9YeU8m5FfSGTFv6yuUkFxkjLr8kOIP7KoXoAoQv/HfyIupT+sy028sUDJCowJVlJnEgwVg3afZrwa18E8l0GVhlCTrxn3fZCGQT2Xcba9QY3aDkIlTW9pgPtnorMIMhXgbJE4bEd32Z7YqJWI5CQ9huyYpMeYouV++7jh/cCy3cmEehxq9bxkHogDwgOSd5/5g==
Received: from MWHPR19CA0049.namprd19.prod.outlook.com (2603:10b6:300:94::11)
 by BL0PR12MB4897.namprd12.prod.outlook.com (2603:10b6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 12 Jan
 2022 06:07:05 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::6c) by MWHPR19CA0049.outlook.office365.com
 (2603:10b6:300:94::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 12 Jan 2022 06:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.9 via Frontend Transport; Wed, 12 Jan 2022 06:07:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 12 Jan
 2022 06:07:03 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:07:02 -0800
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <osandov@fb.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests 3/3] tests/nvme/017: adjust to new nvme disc page output
Date:   Tue, 11 Jan 2022 22:06:14 -0800
Message-ID: <20220112060614.73015-4-chaitanyak@nvidia.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8ef9714-1831-457f-da18-08d9d591c1e2
X-MS-TrafficTypeDiagnostic: BL0PR12MB4897:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4897D348952C2BEC7F7AD4AEA3529@BL0PR12MB4897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee3n0rpMWxQ8p6m8gHWhreS/2Kz9vohxib1TKqqeMlxiiqj6J34cTdmm5r6eIswcoHdwU8liVCWSKmLEcvxA8lxzyyima1Xl6zwfc2cwobh8ET7bhsRQGtRX5m8svFcAhBR8/TaWmcil0XaQA9Tlre+TmoIp9Btuz3l3oYr5e0wSjfe2ZmefRGjxT4V54V1Pi1dNQZ48SzLJPUknEIy7uOqyP23B4jaAqkIy9B3QSPCDwW7yIkYwcUDuG6X+4AADsbCIKTeKy7rrK7o0r0AAVZ5b/49TayaYXeeTMgDOt8aY+rVsaX7ENAptLoi9JaejLH6FUeaWf6Dm0ZzEZLnIkDuUqCoCUgLJJ8GnbL/cc06lSGck/GnTL52FfnhLO7L2JxPzSDcRd7YssIxOfrqxwbfuIPHANwm29+uj0CEZ6Pp3feFYbDcY2k7ZZHlfIvlg+D04e09dZLgV/lzAb3fZuDiBTZQu8mdIwGaoJozYzA9MnbL+ZU2ENcNxsjPEk7Xg0eNSwkgd/kxayaegc7eY0Dhen1D3htbM2EYncFntwYIZb1bzYXULP/7AlCJUN7IIdHWSihs6z2eIJgB0v87nPcI5TLkVkZo+4dIXUMgtaGc9Se4meBgowpv12hCInmVW+xiij23Qi5cTK71NT3dxUfCkBri4BztxYk3xtrzBLoSDi9Zy/w1tcn4dKOMwkgPT+C3ZdyyXOrJD4TGIrqtssP8NtL0mTJ+vuQgSO7WjsxjjRaqrtU0m/RH+AyvrKgxCdshAr4RYXrZC7kPThHKH5A2+DWPxgERT2cBLHn1Kct3hKINlmetfedqRHOlx1wAj
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(4326008)(1076003)(8936002)(356005)(8676002)(86362001)(26005)(426003)(4744005)(2616005)(508600001)(186003)(6666004)(16526019)(316002)(82310400004)(81166007)(336012)(40460700001)(36860700001)(110136005)(54906003)(2906002)(36756003)(47076005)(7696005)(5660300002)(83380400001)(107886003)(70586007)(70206006)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:07:04.8386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ef9714-1831-457f-da18-08d9d591c1e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4897
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

The latest code counts and prints the dicovery subsystem.
Update expected output file.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 tests/nvme/017.out | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/017.out b/tests/nvme/017.out
index 14a3164..12787f7 100644
--- a/tests/nvme/017.out
+++ b/tests/nvme/017.out
@@ -1,6 +1,9 @@
 Running nvme/017
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

