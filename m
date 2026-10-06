Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F50303A37
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276960; cv=fail; b=DS50fDcgtdPAGzzAP42WWoAvFBCfiXyxLUqFFsoPqBkjbThbPUxocdVLHkV5vyOXG9VpOkvRirPfP1b74/+N/rUO+OPUgeg1T2JWOMjhGaMTkJnoMxtBtzYbe4UieDaDWU9wlbzp+I1M0dWy0vAu6hb5cdLU/NZbrxr2Fs73wwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276960; c=relaxed/simple;
	bh=p4gY5EGHLsqwUmhJaKsKFY6DyHTF+thQ+OR9SqSn2CQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QMo6XtFUgn8HgdVaCtaowONxRSWvv6TJc3SGs9P+LgPUaAAQdXpIPX8LA8nCggH+TD4QQzNO5hVjOUcqkYh7L3dCkj+UFIa2568u0nE5OO97Xsgh0vIvu1DM1/rKynXCzOrE/S7Mc7p+GRl2rLe2mIrMKnf8yLFjgI8qQwyXc60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJwyX44V; arc=fail smtp.client-ip=52.101.53.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJwyX44V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/kDMa9pA+b0WjVNS/igJKr8GXlCPI0h6lukjK43YenBx6KD8y2tqHjtzePRd6hJfhX9eC192aSO5C5+0DZZUy2CiV5Ak8MMSzNLLWr2jvxjS6DmsNcx9mQNsDBhKD1WDr8r4IziiFYZ9OfvtycpQIPFaZFCO9x3tuKwtX4/Y9LEvhqRRuya8LfPg42rORBTIG8utM4Mk1linsvduU7uNp3Wbu4nddVqpNDECT+cJmIHjyK8boMc+t7FAu5Oa8AjasbdL4H3F81vbOOASBwta3jp9PB2sDwz4CGC6YJVVLM+kIfW+8DxthEiafFGaztVy35iuq7rlmlErL1FusUzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWecoSq6hwpltoW24YoX7SzhWiLv8K15OUGQUsMJs5A=;
 b=itB9boqYK9VjnWBC8qecIh/sNFzECh3S8yvua4iWpOvy2HZp6tPCjpoqKCN8odcrVROWdPlkCu2ed6HxHy620uWqDlPNssmaAcXOlsGAccQRjkCG6GI/p8A5hggGw5ghiQBjeerwKrVas6Tdpx28CRG6bVp1ZRmwG91qVR0nZlQa5HB3SqjZviszlAxMdc6zUQG+mKFZujPHlqlVEEQJh78u1DI+DERbnBCPwcWL4CcYKUcLvrdbsAhbnC2w3qrbAMOaRsF+W+EyNZvCovj3lfA+E4RD3zVqdv4Z/ltbkNGacfAkhLBNLupAmspD1ZCfiT0Hz3oEN3rFzec0aAmJjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWecoSq6hwpltoW24YoX7SzhWiLv8K15OUGQUsMJs5A=;
 b=oJwyX44V1CzasqpHN5HnrJ6hXVmQpJtx5SvW9/1/XmcYhUz0Jfnw+Xgh++sVUipR0ypH++2W+VaSWZAfreFhZnRukJuS4L1kvmZb3FDz08XO9VdEUz3L+rYyAjLvl2MiFjxxOwIBtaYJ1muwiYql+6mSjmxx0ADG5cj3U3MjfM+34HqbWrLZobNRVX5jPZS1iWI69UBah4Y6FyzbZ5fqgbt8db2v0xGDTxAR59ovMKDdAdRvIj6D7/eonoZXt2ckWCY8YEJnqKfd1rAD2R07RxmtOwYcrGQHeXhJZRm05o5yLCu028FATSeT815L14VLDh+Xn9ZCHqXEw0uj7dFDlw==
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 6 Oct
 2026 08:55:55 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::82) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 08:55:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 08:55:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 01:55:30 -0700
Received: from yoav-mlt.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 01:55:28 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>
Subject: [PATCH 0/2] ublk: complete requests via blk_mq_complete_request() so rq_affinity applies
Date: Tue, 6 Oct 2026 11:55:15 +0300
Message-ID: <20261006085517.33974-1-yoav@nvidia.com>
X-Mailer: git-send-email 2.50.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: ea7fef74-e3f5-41c0-20c0-08df2387a193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	6QDZZa70kEcuv05JOeV9eqjiCKTi2QTYVXnGQN4/leI2LI8S5pOXKxAaxjDEoLcGDTMrJStkLlRANbPQ9LLDn+0OyfsradRtRkr1gc1dYrDH7vwqGb9wmmZYzrPuaabafvruQStCTtrtYD/IMgHn0lV1LeXzGQPSlRVSe5mMICDHpAGhkqEifmlzUNKuNSYKeB5l9IrL/2A6GztVJ203+K6/VCGxsqyFGjDbUId70d2mvnDzKlYEGQcDQtciVxqyAIXDQrumW4Ac26xloDuswEycmF5zEGo7D/zjYvMAtBoY8DYbmrbZ+8w+GZ+OzR5Ah2GT8hrDSELflEBZqg2626zlqzLQXbD0Fc/BexxXAImfGttJ4BK87atPR0qkidimlpBwcGy8/dWR+N/uAqhPvdTaxOBp1jT84AVS3MTrpMJ/UM++I5duhQSPF0EsBmCPZH7E3LfjlqCmTxhoObKF88PLdYvRHjxq3WgTOxEURJUb+Jdeb/uDHJwqOmREgrW+mXMfVkar70imm6KXvSSagVJvDB7g5VYzM0QdihU2R+SOTFtnWjfB+Ny6OuYHb91sb3wAsEOu8e3wcM5OOG+lGRbqSnaSKm/qmktS2wIkDeMnmqVO4G4yLO0nM3pE+pyUsqS7Ku16iCvzZ3s86j2A3dNVQ6MZUf4She8PSZ2Nnow1cp2ymYaFQQzkNML1xEPY3c2Jl/jihipZ1MIySjXRng==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jzxGzlea5GQzKY8W6N5YdIM9f0rdOmIN6Ds+ZRxAWhqcvHGoY7IfC+QyeD8juFMkS+UAWvx0dlCDPA7FPHQnD0t4k04521lZhmMvvIQXEEvT3g2L0csw+7dgZFaDvOIdqos7yiSAonHscaeuQZ70rRziHQvliD+Y0ccaQVwLY6/JqiWn7qhKnKposY/FMihrZpFoZ6tyxDkSKc1G0/0TXGe/zdAp5ON4eRuAkDylI4sHCWjLBok1g+8omQFv9ivAHyt7A/S5htfbcdBqftKm1CuDfHuY6xbqYsmBzHzWuO19o/UyxGjRtQn7X3OPt2piG28zU72CgVMw0OLWLPV6MlfDcVCU+6ZfwU3gDcX0UcU6HqCwk/syHlvh6Aa3AuNYeLqPtWd9oEHORvIkXV+85FMvdQ9DTT1Ibf82+/gyBB4DpX3tk3Jw4ymG/0u+UJWd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 08:55:54.6646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7fef74-e3f5-41c0-20c0-08df2387a193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

ublk ends successfully completed requests inline on the server thread,
so rq_affinity never redirects completion work back to the submitting
CPU the way it does for NVMe, SCSI, virtio-blk, loop, nbd and rnbd.
Patch 1 fixes that and adds a feature flag so servers can detect
support. Patch 2 adds a selftest for it.

With an SPDK-style polling user-space block server at queue depth 96,
rq_affinity=2 gives 7-8% higher IOPS than today's always-inline
completion by offloading a saturated server CPU; rq_affinity=0 keeps
the old behavior for anyone who wants to opt out.

Yoav Cohen (2):
  ublk: complete requests via blk_mq_complete_request() so rq_affinity
    applies
  selftests: ublk: add test for rq_affinity completion redirection

 drivers/block/ublk_drv.c                        | 72 +++++++++++++++++--------
 include/uapi/linux/ublk_cmd.h                   |  8 +++
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            |  1 +
 tools/testing/selftests/ublk/test_generic_18.sh | 42 +++++++++++++++
 5 files changed, 103 insertions(+), 21 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh

--
2.50.1 (Apple Git-155)
