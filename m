Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012020.outbound.protection.outlook.com [40.93.195.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F06517A2F0
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099139; cv=fail; b=iwmhi3zuU9/ULBawVqfQNpewKLtDnzOzVQG9vz0yftUGRdIXzg0bIOWygKt8NAacgDCN8TF+PQ28OIJ1r2isBsNMZ59uJlAS1QqATMlcSQ/a2LWzritxo3R/M4qgo3WX4P1ay4SDqIuhb7W6ygebnTzWC2LAN7E31Lp+hrwByAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099139; c=relaxed/simple;
	bh=8rD3xbAd/fjuQmxreiDrIiswtX3HZUIT2IkvRcb0mls=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E2cwrooaMASHlLU844NUS/SAc6o9qUxqnPUvjRuraxT1LwFpnRn9UDL+0312XVhIW2bqf7gY5W4C62T7BGxQ1W2Cx6xVP59kQpSkgpRZ9BEhKU/g3KVBqCDI5685GTqo0X1hm5hK7DkqZlJoOD6Q6frKay28HbOX8yQ50zUB6tM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EQ+oK7H6; arc=fail smtp.client-ip=40.93.195.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EQ+oK7H6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEyKo66GvBlVjrX4MsOhHIw30TShXlAstvREJEqD6qCitEo+tOYGacrMuv2lXQLqIhdnmfgWD0HZThVA0GbC1NFOuu4gvBfhqHgz431YjcA4OFvWcS70BpWHgOtEr3IbaQvJiyZG6bU3O99elC1JMmD6N2OluxvDsMv4MGUvvDwdFoFtZqhVtQztW2ZvXkLpusNt2WPcI5h+WnqgctJIzOyayZeSR5YOaXQA9tmiE8dV1Nyk22F4Sr5FvutnUihkcRso0JiiQ1QbNjmPnb2//IZvnFrXsZ4tGoTn8mkkHDExj5nRyRxUxYAG6EhoiTzM8lf4IG/aEYuBXvQqcSD6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bf8kDc5BGo1hoqNZa1cFV9ywnRscoXTZV8TCHXJpQJc=;
 b=WQ+jbZ2pG0aS6fGHl6m8oYT5HqHj5JM9d+l0FS318x38K3+2zIt1b4/R8GHnxNdQHDhkqk0L9C328DuXgvSjrIBHFC6wRy4v4qH91CQ0LFXgpGaCQcia1meGGVf5atOwWW12rozGtM8ccrkj/ClvXqWhi8824hYEING2zmWSdWI/pGJr2egB/V8sNerOE3RrWiAOkpHInJ2VmXZEAKvfItJIoy1aGYty3SqUGgv1HtYWQZajWDdMXQnqYky/fdqEJ5UArjjFlXDK0/+lE7Mchhc/7C381hQfmIAeV9hFJ6inFj7MX5AohV77NzS7KWRUHCG2ikcuBJHQe2gHOQ5JWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bf8kDc5BGo1hoqNZa1cFV9ywnRscoXTZV8TCHXJpQJc=;
 b=EQ+oK7H61361cra55nXx4FuLnO1thv1OOcNmSrxwM3Z3KjG19vEjYBBmiJASKhNKdqlr9Oy+KOFD3MGgz9vqDsqknSSGEiakwSw+w3j59LO9xXDRJkal7GfAWTsTL8MKRl86284x3phgFx0w14A4J2d+j6bb85Nyk1A1CxXNorNhKGv+8/NmyjIgJGskvZ69yvLWwGipjMiK+GztJPXpGKPDpERSQpoA0YUs8m2+bInTpSsLx/Fum62MbdHzpvhxtGIjTGMuTVsWAaBrCFgfg5c+Gop8XWiWbFkh4yVxoBFLn3pHwi2heF4rgFNq/nqKDP252Yy0dlOceBNASvHEUw==
Received: from SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 12:52:15 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:334:cafe::8a) by SJ0PR05CA0103.outlook.office365.com
 (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 12:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 12:52:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 04:52:02 -0800
Received: from yoav-mlt.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 04:52:00 -0800
From: Yoav Cohen <yoav@nvidia.com>
To: <ming.lei@redhat.com>, <linux-block@vger.kernel.org>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, <ofer@nvidia.com>, Yoav Cohen
	<yoav@nvidia.com>
Subject: [PATCH 0/2] ublk: introduce UBLK_CMD_TRY_STOP_DEV
Date: Tue, 30 Dec 2025 14:51:38 +0200
Message-ID: <20251230125140.43760-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: de7944a7-fce9-4fe5-9649-08de47a241af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?btTiR92nQmgyHwQByLPPkmTfe7P4CYQB6tMLyObZQ5r8aILWUyq6y2VL0Xw9?=
 =?us-ascii?Q?mY0kOU2GEZeievdXtybg2EjHv1WdRkFAkCHsx2NFZsOHvcm1dOusm4OyJDe+?=
 =?us-ascii?Q?0P7xwJGjd7A3OhXewgUQFLjmSmxkzFEAELADbZlS613d/bynZhdrj7DWaqg9?=
 =?us-ascii?Q?mwzzy1H2NlXYGyUMrGXBUTU9QFVb09OBIA8kug//G8pHcJwtxxFpxofZ7pZW?=
 =?us-ascii?Q?15Ct+S/dO+E5ZfpvXxyXKmjjCwI7sTFIgAcOatC7GzUhFLRac5SV2HOl1ZYh?=
 =?us-ascii?Q?KKUsSg3nsEASOJTEODvCbrdm5S0AdqJz4PAbnx/bYERx0Tg7z1wnDYy3I2lb?=
 =?us-ascii?Q?eylv7uenkqylFln8/h7F6DHO5EAerzV5rngj6DxUn/ECLPBvzb0ObTVP8Li0?=
 =?us-ascii?Q?kXMNTVzhTB7++IlgiWKRmySYDTd2VuvadMjvy/PxB3CeH0t75DXc723+tUWs?=
 =?us-ascii?Q?+ozojZQn4P7VYQtOXVISK6Ng+ol/IkN81zdUv9T4xZmvgtFVuKh4LZ9NabxD?=
 =?us-ascii?Q?CBRNZtvxrjmWQtgGVNaD1ANXuPwmivoPLa1r2vAvemvHDukyhwAUCNyCxw6k?=
 =?us-ascii?Q?oNyH5RgtDHGdYTfBDWPdckDjslc9U4PuxARCGWf9qbjFqZTRw/2l+3F5/zDA?=
 =?us-ascii?Q?Dkb+3pLL8TQQO4R/9KDZf3UrsEDB98w5xC1EH2lrVHMo9POtRzjOU6cjnHgV?=
 =?us-ascii?Q?paJmr9JjbLVdiDBH+AbRKBNJkjybXf5ymRuKFCPwwrtvxyEuCnMly9nPu9H6?=
 =?us-ascii?Q?9739PA50l1NyeGm5u9NEptZ462ZbhjMY0RJV6JJBbkQL4iAZBMwFaTGHBPtZ?=
 =?us-ascii?Q?5BW3vHRWU1r6jRTe2LL9fC07mUM3SVo/q0YbxhgI+g5N8rrDNRXn0IeWq35M?=
 =?us-ascii?Q?vW4qnTg0z+2JR7all7K5BH+KZzOyHu7Iio4XG21kIO7/dTlZBdNHKgDt+ugp?=
 =?us-ascii?Q?EgN2ZvQOCuoDTLC6JrOsqv10VSe+jv4B5AGw8Oh9t7tAoHan6uGMapwfQviz?=
 =?us-ascii?Q?ByT1Yu5c8e6CGhfJraqEeWgyC8YcxpnbFFDI91Rm9SuK8pNX4BxkOuXKR7xF?=
 =?us-ascii?Q?L4w1vyk+XBAEnxRBfWcSzC99JXPh29EOSL1yfySR6D74Bo9GGAmwPPoe3maJ?=
 =?us-ascii?Q?74o+sxrnsAdxmkta5JEf2OMuLsYPwPQ7xk2av0302LAi+/jyjBTNqc6s6zFj?=
 =?us-ascii?Q?gcJoxGdD5RsDBcKTQ10dudIDsIcYVq/MkEYu1rhT1ZPZXceipYDKtWMmW/uG?=
 =?us-ascii?Q?JkhxMrBQGmLMWIO1eYNx18qA4ik04z7WzEy64ivcPZuWTHva/yPGM9Jqh6XP?=
 =?us-ascii?Q?cFx6eOrh5hEcIHUrsXdlem2+6cu4lDYi/B0b4Ld/BBsM+rx7EfWJ6OrxZQay?=
 =?us-ascii?Q?AvMQCiGsH/9J4ExxClIz4nQlp3xOslnHVkC278L7jkzHks/b8GuWcQddokc7?=
 =?us-ascii?Q?TFd2ViY2ZZCzABGSRWArmmS4S7/RE6CsjHgiIBSns6ioZ3G1lhjVIQMBoFsI?=
 =?us-ascii?Q?qn9AxVJFgj0lX2YnmcZIhdxdq3usnaZkRZuEj9VCaIlyBGQ6+9fHmDPMEJsm?=
 =?us-ascii?Q?MRrHTilM8K0IXjqwcHk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 12:52:14.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de7944a7-fce9-4fe5-9649-08de47a241af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271

Hello,

This patch series introduces a new command for ublk device management.

The first patch changes `ublk_ctrl_stop_dev()` to return void, since it
always returned 0. This simplifies the API.

The second patch introduces `UBLK_CMD_TRY_STOP_DEV`, which stops the
device only if there are no active openers. Unlike the existing stop
command (`UBLK_CMD_STOP_DEV`), this command avoids disrupting active
users by returning -EBUSY if the device is busy.

These patches only introduce the new command and API simplification
without altering existing behavior for active users.

Yoav Cohen (2):
  ublk: make ublk_ctrl_stop_dev return void
  ublk: add UBLK_CMD_TRY_STOP_DEV command

 drivers/block/ublk_drv.c      | 45 ++++++++++++++++++++++++++++++++---
 include/uapi/linux/ublk_cmd.h |  3 ++-
 2 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.39.5 (Apple Git-154)

