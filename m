Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC39374E67
	for <linux-block@vger.kernel.org>; Tue,  6 Oct 2026 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313478; cv=fail; b=IqC5/0msYnHiKiKGE0TS5NFQu+IoS58/4ewxSrt/FDAxcFQ2Z9v3w6EVYZSuH0R8l19qIGxIMPAVRiPKzemmRSKeYPiMX3+2B5muGAt4voWJha11DJP/A0MO9R07qd2kppZCi+uK2257cms44axK3VwcdadIDDg16M7CwpbfNbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313478; c=relaxed/simple;
	bh=X2Gfd5r8BjR8kLrEuBGaL3OR5u7zZpNI1zCRXaV44a4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9lqLf6iyIyLUa5XNwXJv4Oxje83EN0B+zrP8fbvPpvBwfaG/twuf+JaY5PmJqwJQ9Lup0hsPr/H5/uNG6anxUhJnCsjO32vHbTryRnb/ofOYEXVVwxsABIMgvibWe3M3l2dOJbfAGO2sLWe6Qp72glDi3sW7gGsTklR6FdMEKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PjHAa1hP; arc=fail smtp.client-ip=40.107.201.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PjHAa1hP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/oMQOk0yz3cap0r19lVlV3JFpqyx4cx6zMhjRFh50uy7DjYOSFHDEmbWJrwPaCoqZjznfItH4ojYGlciM8NcIQJw9h03fOYqb+pG4AHOkyRdzt+sZa0o377+KP9tGh6E7wSlm9LxtfqBUYEnyBKyoHafRJluqdemBHWyZ/TZGlRoSOGP8TgpKZRcB0j9cO2mvCTTz3h3NzcwRzhetqG0gom9N509iS2m9ggL8giBq24gG9LpAKxj4rLJ0tApXkeaqVzaABW0opwTFbO9PPQaf8w/9KS3jrcwODt151vMWJ8o1Sm1PExt2hTsLZ/o39gH0/+KGo0BkHfuRC073qagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbSxcscnFKTy2LiTXKcGAbVlq2R4l30T18BEeXsUWQ4=;
 b=TDE9X7PzSESIt8YQFxKnJbg27VT8l1touA/8lBJ/dn0NwJ1p2FAz7tHTjxwH9a4JlVDq71HOdPjssQ948Cmpdo09S0M4WPIp3Em8+KU4VAt4fTMN1dk9vlr4a87Ew1Hp+zBMMRpun8lPi/DpOSH9OAmB7zALH5d7IrUVKsa/jzMbj1PVkRG5knyyBR8jGLrBJ5vtyWYd95aVIaJmGonLsOsrn4v+hLQc62+o1CHL2FwkojlinwbcsfnZsVxyvgWYsZp8ljavDmZX2xkAhEX69J2to0Uq2XkLQxUO8BAhHKTD1PSmU/ehNCKwCQvBGNu+zMBGmE79Gn9+qnmh2sLMmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbSxcscnFKTy2LiTXKcGAbVlq2R4l30T18BEeXsUWQ4=;
 b=PjHAa1hPGsIh78Dw4H0Tsfl8h/x93/+ZYnsm4YEg9U2xS2P6ZClo/XH+N2RcViHz6DlyrBqZh3+LmVyP0ZoONkMs6BpJ8ERIS6N5r04Rtnm5Rsp//ZfxfNCS9hU0vNIHtfDgp5i5JI+tiaj/9KMeQyfKEvJF31jpXiQYpMatap3zkmD14TMjwnYatMMpHEKKq0KAKg9fx8t/QNVAqkDYisPb5UJEPRA0yreuwC8t33Ypo55N92tbobAEEHYCBiwnNuD/Ixoy0NGQmNJzo82kk+jaPj9g6wm3wW6WEouH9Lt5OeZkIQIoEhcV+P4/sCuDUwrcKcSWyqBgJ1Tobm/LSA==
Received: from DM6PR04CA0025.namprd04.prod.outlook.com (2603:10b6:5:334::30)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Tue, 6 Oct
 2026 19:04:29 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:5:334:cafe::a0) by DM6PR04CA0025.outlook.office365.com
 (2603:10b6:5:334::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 19:04:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 19:04:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:04:04 -0700
Received: from yoav-mlt.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 12:04:01 -0700
From: Yoav Cohen <yoav@nvidia.com>
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <csander@purestorage.com>
CC: <jholzman@nvidia.com>, <omril@nvidia.com>, Yoav Cohen <yoav@nvidia.com>
Subject: [PATCH v2 0/2] ublk: honor rq_affinity on request completion
Date: Tue, 6 Oct 2026 22:03:46 +0300
Message-ID: <20261006190348.85094-1-yoav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: 6341682c-cfb5-4280-d582-08df23dca5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	NOYYZRVx1OozOP8MEyNtTdumAXHKjFS9CDpDu3A6Ln/577/iwa5Efv8A4JrNBMa+zdamxmiquiPRWI8Oq8kBfHqSgXWSDgf35qQpbCObZfiegcJBhqS4g1QyE0+DC8hmEDyXxVAM2lPOABRkNarxZ4lxTyCHMJBHb/x8I7QHgnsEudrQrLJ3niixxRoTgQTu7LHrdeIUelyRLlY6G9FyVQArPfUPfRRVppq3+tjwEmogN62uULOE7Yjx/xqLsT6BP1JGZBRcExcDzMqgrD9FWabErGzaJ6RqusQP67oI8p1NsALFnmCmnXTcisxPbg+OlaCgn2Gy9/xfzFT/1QFMQtez/KeZ2zWwSVcCu1WN8TOmdFMJP6eT6HknPJb1SVMeMoa7NLdJCZfC40bVIfK8yIJwnmTY2bDjs+qJBESZfdTiPvsxryJUUUCWYRcXBEcD84FkZLgw0ZusyiM2fOQywt6gWqhg5SLU9n83LAGt+QxSAoPKuw2ymeXWpQ4QGrYT9jj0u/qxlaXBVH6ZQAd6y3b1QANQFCN8RQf3O+znLOoxpVPxAiaU29unjNQkDXXC86PP8f3aGhV7zusgd5feEK6YshwcKnK/Wuwy6labD8bpx3j9JVJdjsmRijx2O8sd6BbpPZxYmichS6MFSC3pUWOxm0pkOz5FoKTuF6juj5NlhQdQqFnR/U9D2OGXI8it
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0hVirAU32Eu0ek6sF1zGJhYi520o6HIxLjSKL34tKIVh6mW9tRRogfP1ppWiRnAazBaTP+1WxPA/uk+rY8gNwProwyXlFXWTbiDytpU3cC8EJB5I09nu6m34XZMUrTF0nyTY454vk8vkZnUMp4my7l7ykCz1L52H2ISr94s7NDv13iH27XLjqx52UFekfVFlHE0wzQ5OA+mVRsmbQLkIWsVPo9Ur1Zh9lft2nsAT4oROEDGK7xCh8WpMyRDXrvcZTVobVRdOGNm0uV/mtu/gTRqKuXeIGRyZed1b9y5Vq9dRE5UlTDZGKcIcIcIgjPdk7IG8fD1YfDH7ziAWGwBvcOMb8BLs0VHgDw25oDT3ShMH9XwEq6eC2OFQbR8jxeAL/RGIAEtnvBtEAwemWQD12JEkvtYTJ21xW166Z+KmZV65WHj2qNpRX5ysQhQF3/C6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 19:04:28.9959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6341682c-cfb5-4280-d582-08df23dca5cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794

ublk ends successfully completed requests inline on the server thread,
so rq_affinity never redirects completion work back to the submitting
CPU the way it does for NVMe, SCSI, virtio-blk, loop, nbd and rnbd.
Patch 1 fixes that and adds a feature flag so servers can detect
support. Patch 2 adds a selftest for it.

v2, addressing Ming Lei's review of v1:
- v1 only redirected the classic-copy-mode successful-read completion;
  every write, flush/discard, error, and zero-copy/user-copy/
  auto-buf-reg/shmem-zc I/O still completed inline as before, so
  rq_affinity had no effect for most traffic. ublk_end_rq() now
  re-derives which completion path __ublk_complete_rq() took from
  @req/@io state, so every outcome goes through
  blk_mq_complete_request_remote().
- v1 ran the new completion path unconditionally on any patched
  kernel. v2 adds UBLK_F_SUPPORT_RQ_AFFINITY, which a server must
  request at ADD_DEV time; without it, behavior is unchanged.

With an SPDK-style polling user-space block server at queue depth 96,
rq_affinity=2 gives 7-8% higher IOPS than today's always-inline
completion by offloading a saturated server CPU; rq_affinity=0 keeps
the old behavior for anyone who wants to opt out.

Yoav Cohen (2):
  ublk: honor rq_affinity on request completion
  selftests: ublk: add rq_affinity test

 drivers/block/ublk_drv.c                      | 98 ++++++++++++++-----
 include/uapi/linux/ublk_cmd.h                 |  8 ++
 tools/testing/selftests/ublk/Makefile         |  1 +
 tools/testing/selftests/ublk/kublk.c          |  6 +-
 .../testing/selftests/ublk/test_generic_18.sh | 42 ++++++++
 5 files changed, 132 insertions(+), 23 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_generic_18.sh

-- 
2.50.1 (Apple Git-155)

