Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB251149C64
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653596; cv=fail; b=WgwvVui99JKGj9p4TPWdos/+8ufuak0anIotcr13mZSL3L0nkdneah9ZNS/o9drF/Obr2aKy11+BOJ4dKoBC5uta7UDiJ6KMdiuuJYhcitVd7gVhA0BJlfI+JO4gKuaE1U0KVwJhVBu6/n38VNZS5ThIG1r9AblB3LXBbPgStEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653596; c=relaxed/simple;
	bh=4CqN6YgUkGP+X+wBW7x2hGZgRk+LQ8sW5/tOwNvArkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bc9xG4nhE/cEact2xplTYKO0VMptdSUK14X7gy+odAwWz5t9MYJW0rzHnDUVVpU3lDx9sltijclquxJGIa4PODm1QQI8/xK6ZSb+kaBavw2le6UkbHAMfaQwfmFzMPn2tDTzCwmzPcyKqAYNcS/iGgG0qYc+o6iAYU6RP9o8ulg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U8JSpICu; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U8JSpICu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq4zUDzYTje2O2LG6pXCLt3vD9ekg6Dv4ha2FvTlsPl00Od4r43+DZUgpq4ru0r+vjUzYphFhTFap2evrwyQr6INpZvlsKpn2u78iMCROOdcsaDZM7f1zie+zNuTYdxXERtRJ60HnKfxV6XpkZ/YpXNVoCaEarTBPA5qvglJPfsdfHfDDtozuJ9UrwP6T6GMEaJCxaf5JLwQYa8XGsCkp7nANEAs1jVsczm22BJX5lYIh5uxdNgrtXONQ0PfiZQtTrdr6FNxMWDSlCuMihPJT/z/EvzOaUp7kZu0ZD/uz/hAU7UPP4zqQ3+VUaZ2hFqT8t0gycFoXN3GjveNdVihPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld8tVkmYkwXU/t9R/isfxzSkWT8bkKlGpQfZ0pzrYvg=;
 b=aoqAPIpi9ALvFM+mUABmlK8PrOUVFQcTW9wOM2T6E5q0SOnh9cZUUsFGpl7bmrf7XR18vUKLDJiApwbfhClyniJSLSZNoIpv8bX9E5KXaZYTCsGHr1AuPAQHE1br/3FMtPxnCiiR4Qt/zo8SqdiksKvFi9IdnWGF0OUxeTmH5UqaBeYaIVl+AS3Ou1+bqCeCTmZjXtOhA+X+ZeMDTunmE61gNmmj13fdkkEWiaAn6k4JrkDcAsnTOHnlKh7LHjygbCD1r5Nw8fBr5091f2sihaUkILkE7Yw/ku0BigwPJTi5Y8yfCrCGhyluf6XkGSmYkc1GthWQPBBL9RN3ULUc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld8tVkmYkwXU/t9R/isfxzSkWT8bkKlGpQfZ0pzrYvg=;
 b=U8JSpICuV8ccWZyipJX6/DHAN3niA5IGMtZW8ewfOWiNcMef5mpXZJsNamDKIGcGOd+IelaD7Peyb4oWvNq4/51+0P2xQ5tRNqtvWKpFYsHqeodNQ4CzunKw+b4bzfxSNZrAB0hiQXjweA2PbNIKHcBgYbS2CTk6UzhG9DEnHMW+AdvjPZqDw8Vdl5PvQWfI/y0VyUok2sKyu2/YI8Airm/wFtRzuZRmJ0WB5hAEcZLsZavb256IzctIE103bCbvuXK4OQaeLARk6ZWMPwbm3SF7IFzrbh/V2FnZ8krB5k84X84AF0pWA+O1SawroWpZ6nAkee9H9fDgjNfZKK3OoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 20:39:51 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:39:51 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 5/5] nvme/055: add test for nvme-tcp zero-copy offload
Date: Tue, 26 Nov 2024 22:38:56 +0200
Message-Id: <20241126203857.27210-6-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126203857.27210-1-aaptel@nvidia.com>
References: <20241126203857.27210-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0176.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::11) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a87ed56-7e41-4ea7-7c56-08dd0e5a79f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S3LL3nCQ5tppi3vUv3DLkYGoXC0Ub2o5Vrs0ffrOZ8gEM4yairTrL73CBm3O?=
 =?us-ascii?Q?CmV1Fx32SpO7i9YxG6TAGHp4nJ+fm0xNzcPEXrDKlwYyTLe8wiuQN4vRDZzY?=
 =?us-ascii?Q?BrxF5wwzj+gOi88Tmg8ljrm8bMuwWnBM1yQSjHFS5D8zMajl8uAwBY/8RApA?=
 =?us-ascii?Q?oVGzcP2x+9JRRr1OTyau4oH+gjLamN5/4crfsDMXYoTL0/V9HNLcViMdhMyt?=
 =?us-ascii?Q?3D6YKcTgZvBAjFBrVrdsuEuhwKy/cwDcWGvMg+8acmPhqXMILB4AgYkEsDex?=
 =?us-ascii?Q?pdog3+qX/fgA9j5TsKpBJSltAL9j2ovvbWPMM1qS9ClEcDkX9hS0AekfvC0d?=
 =?us-ascii?Q?F9iXDCh+Q7amr87oKZjTQiceiv0w6/Mh1hXoQOVgGRb14CmY51//vAqct6/B?=
 =?us-ascii?Q?rGZ4vCHqGwoZoyREhCry4Bpf7HcBMbDIkpJ2joO26SGyDnzkxabklMf48lQB?=
 =?us-ascii?Q?vxpDAElUoXnPOAZKA+IOBiBiqPZ5jvVG02dfCIimsjJ1TMNlXdZiy585TjSv?=
 =?us-ascii?Q?NMnrZkI9KSbFVS/cglWaqUDLG5RuQZWtiTNDJVuBLMuWPcaud0kZPsIahXqp?=
 =?us-ascii?Q?jMhqAz5rHFq/YjOfjMGAmnCqTre6/QUDEK9sYtKRA8YTty7VUEqUD2Lzchzg?=
 =?us-ascii?Q?jU402zpvCxzUkRo/ghGZrHTqC2Scr2SByO6VDZtuVXyd6NPMH5pX2j6fF9Wq?=
 =?us-ascii?Q?RuIXX+ClYUkq+7JN2YbfttlkN7rZdEFFaKxCPWc1QgmeF2xc3+iJ4543/grP?=
 =?us-ascii?Q?kgadMOnKLymqcgVDbGsr0uL///osAkiQBDoMtkz/qQb00FAXqAwzyeZLoYsd?=
 =?us-ascii?Q?Mh+4zmWmC16NTWlWUDs5FmOhXVVnIyQf+LIkDyLPnCbbacR9KvT3OKnG9zOU?=
 =?us-ascii?Q?y7e3V2tUIfK8eXJZ28GYBMbCB7o47bOKM4ASPvgOvLhjXqoytLQiHmPY2cmn?=
 =?us-ascii?Q?dzMt+E8WvzUzriJoxH+rExo7fjKhFbBnktEgrP06fqhh8Z+8qEeQSQ4Txmhu?=
 =?us-ascii?Q?z5cigbAUgWegLjTQGZ12TrU8wBA1A9w/rI7NanqKlxaxJSAqPzKMqIc4uTwZ?=
 =?us-ascii?Q?LBU4Jm71AEb3L8oKJznL9UiBOdQwwDkdYtIZ3GdEMYzPpa/pB9Q3BIHsD0yo?=
 =?us-ascii?Q?A8K+KTh/q8ftJTNIGu6i/bbsugEd9hvp3GTeDWN5NniPAESrgrOKQxCDRv67?=
 =?us-ascii?Q?CRJ3WCGxmi64tI5MtquXIvCfOZcq0G2qoQSbdJqzWCafI/DSqzHfq0MfHMuK?=
 =?us-ascii?Q?1LUdye2sIcaw6M2jlk6WXlo+GXbPo2EjhXorISMy0cnu2dJy6O6GfcmMWZMH?=
 =?us-ascii?Q?o1AedJRDKBVsqlmxE2wBlhlwRYu+nOKz8LTK0tthnYZZDg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xuuj3bSurMexHS1lnEhnYDx1VO6QPFTpGgx6IUz4sHZXICRDGXdjn5RvhHit?=
 =?us-ascii?Q?oP4WEIQPJ2zn17A83HbjG3532GDytsiBh6qPvHhNxxqcSpeFHCweQe7w9dAv?=
 =?us-ascii?Q?QsDKsp0xMXsQGfXCAYWYDGZJOfkEISrqUDc1pYLkxdICwFJPvrZGYHoRYUAL?=
 =?us-ascii?Q?E31R6jTDm0V4V8x+b78Uug5ZN2Ba2pjFHbn7JKQTw9nvJyMQWO6m2XCHTXkT?=
 =?us-ascii?Q?U39xm86kuGhRoS8xLsJmGfs1l5GW7pSokB2xKtbx72qPHfqttr3uvMmIEfqm?=
 =?us-ascii?Q?Ydxu2F6CPNBz4JmXWs+Wb9qq/ziILs9r+FnjqZhfvIsmtdUvgltrdFbEc0MN?=
 =?us-ascii?Q?j4ZMx34fwAlXh4Dz2KHFEjDfpR3YAuIqzvRFjQvZ/qYcj7E4aRkbay+SPd0u?=
 =?us-ascii?Q?7F6+7hSi3oIzemCeoEXVSYtTvAT6DA5lkZZzAXxeoD7v4bab31DelzWjKJrv?=
 =?us-ascii?Q?sk5iBrz/x2Y5BO3EJb6pQlTgQoSbGUScow5gxivbPFapMuNLhgCg/8+GaqM1?=
 =?us-ascii?Q?wQ4i34OVPuwuPRPjBotctABFWagmG3fy7Ddte+I6V66f6Iklln1kdjFN1C4+?=
 =?us-ascii?Q?qaIxChEuI+x9WCwYL9IugE3H8wY6ZRp+77NwEQMWKYMNpG7JbzrALvBKQUzf?=
 =?us-ascii?Q?d1I4NrvGeGG/6wxYGbR7vRtXlsC+6HF8GE+CDoYFIjsU0cObNFLmperHVlbK?=
 =?us-ascii?Q?hhCXRkO51bPn6rTpE+HY8ZLDq5B7Hj4kQINH4Dq11Ab/oBCx+gBp4PeGsmmf?=
 =?us-ascii?Q?t0J6BpjCOPHGvP93AjVMlKIjzUKW3yrdzKuhfQxjJfNLL3ZpQXSDropKvuKJ?=
 =?us-ascii?Q?KuPqGkh0LbXnk2AsyuiUgsENhHeiccwv4zCSj3q7eRWZ9y6U1ZnN1TncUb9n?=
 =?us-ascii?Q?TkXJ1XfIlRqWPEhxHrQpFcahg6kS64z9WB8iVwmRyt+q1yrrheNPd8o5RZOI?=
 =?us-ascii?Q?2aIacNL8t4tfi1K8iPFPjMVQIG21GZir0s1DDN4q5JSPz4dEAP7XrqBcZd/d?=
 =?us-ascii?Q?9QytiAbaSYVTj8/h8Qc8Gs3RiYpIbLN/drQYpX8ixDodCSB3C4bBYNGJdUKC?=
 =?us-ascii?Q?G4BRy7SDg3HfVBWCISOu6cg8O5OxLwLb1kUR7JhU2B4+Qa8XuyUd6TzzI3PH?=
 =?us-ascii?Q?1xQAcPlBj9P+TSHo3Oq1A8XW8eooMWn1DijaWV6Gl/V8GMUliy8AvE23i5ay?=
 =?us-ascii?Q?I2Q77jyGVBEdbOA91T3jrBl4advoHDoX2A5C/Uw0eDEQ3M8wNfOjI0QM8MgU?=
 =?us-ascii?Q?a9dX0g3lJ7siNHO5Bby1B0QbMRZ4u+3aUiZvTQy1wgihA3vZpxZQgKFM+Dzv?=
 =?us-ascii?Q?Ig/PPR8t3DSQeL7u0142AgLvB2L0xP5XvhNSapeAloldWQoctWUgBd7rhhx2?=
 =?us-ascii?Q?UUPYGE6KpjDd4xLaOziHS8zAdpd3QIH+H+L1gQOYSkiqVpz0LN5rKxIQCD0E?=
 =?us-ascii?Q?4FV6iCtSebchvRYbQq2wJAuZnnfIdiyOhbU/jnQctsiZ/trgJVeGLoQ4Z95c?=
 =?us-ascii?Q?XfoDqm/emG5bIUVhoawGqSn2P/cWTsMfKo/+5GfMMfX/aVkBj6fsdwX/+6pQ?=
 =?us-ascii?Q?6cX79Apf0jfCREhO4lZfQNCx+cGn/AtkcZLLWp1Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a87ed56-7e41-4ea7-7c56-08dd0e5a79f7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:39:51.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDQVF9dlVsWK93DQmZMbqGyOQ1ho/crROzaShtAG9FF19i3lVHltm56X8hcLOWzv150qsHm5l5K+n+DvP1ibhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697

This commit adds a new test for the kernel ULP DDP (Direct Data
Placement) feature with NVMe-TCP.

Configuration of DDP is per NIC and is done through a script in the
kernel source. For this reason we add 2 new config vars:
- KERNELSRC: path to the running kernel sources
- NVME_IFACE: name of the network interface to configure the offload on

Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Signed-off-by: Shai Malin smalin@nvidia.com
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |   9 ++
 README.md                      |   1 +
 common/rc                      |   8 +
 tests/nvme/055                 | 285 +++++++++++++++++++++++++++++++++
 tests/nvme/055.out             |  44 +++++
 tests/nvme/rc                  |   8 +
 6 files changed, 355 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index fe4f729..a42fc91 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -124,6 +124,15 @@ The NVMe tests can be additionally parameterized via environment variables.
   be skipped and this script gets called. This makes it possible to run
   the fabric nvme tests against a real target.
 
+#### NVMe-TCP zero-copy offload
+
+The NVMe-TCP ZC offload tests use a couple more variables.
+
+- KERNELSRC: Path to running kernel sources.
+  Needed for the script to configure the offload.
+- NVME_IFACE: Name of the interface the offload should be enabled on.
+  This should be the same interface the NVMe connection is made with.
+
 ### Running nvme-rdma and SRP tests
 
 These tests will use the siw (soft-iWARP) driver by default. The rdma_rxe
diff --git a/README.md b/README.md
index 55227d9..5073510 100644
--- a/README.md
+++ b/README.md
@@ -30,6 +30,7 @@ Some tests require the following:
 - nbd-client and nbd-server (Debian) or nbd (Fedora, openSUSE, Arch Linux)
 - dmsetup (Debian) or device-mapper (Fedora, openSUSE, Arch Linux)
 - rublk (`cargo install --version=^0.1 rublk`) for ublk test
+- python3, ethtool, iproute2 for nvme-tcp zero-copy offload test
 
 Build blktests with `make`. Optionally, install it to a known location with
 `make install` (`/usr/local/blktests` by default, but this can be changed by
diff --git a/common/rc b/common/rc
index b2e68b2..0c8b51f 100644
--- a/common/rc
+++ b/common/rc
@@ -148,6 +148,14 @@ _have_loop() {
 	_have_driver loop && _have_program losetup
 }
 
+_have_kernel_source() {
+	if [ -z "${KERNELSRC}" ]; then
+		SKIP_REASONS+=("KERNELSRC not set")
+		return 1
+	fi
+	return 0
+}
+
 _have_blktrace() {
 	# CONFIG_BLK_DEV_IO_TRACE might still be disabled, but this is easier
 	# to check. We can fix it if someone complains.
diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..7e76126
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,285 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Aurelien Aptel <aaptel@nvidia.com>
+#
+# zero-copy offload
+
+. tests/nvme/rc
+
+DESCRIPTION="enable zero copy offload and run rw traffic"
+TIMED=1
+
+iface_idx=""
+
+# these vars get updated after each call to connect_run_disconnect()
+nb_packets=0
+nb_bytes=0
+nb_offload_packets=0
+nb_offload_bytes=0
+offload_bytes_ratio=0
+offload_packets_ratio=0
+
+requires() {
+	_nvme_requires
+	_require_remote_nvme_target
+	_require_nvme_trtype tcp
+	_have_kernel_option ULP_DDP
+	# require nvme-tcp as a module to be able to change the ddp_offload param
+	_have_module nvme_tcp && _have_module_param nvme_tcp ddp_offload
+	_have_fio
+	_have_program ip
+	_have_program ethtool
+	_have_kernel_source && have_netlink_cli && _have_program python3
+	have_iface
+}
+
+have_netlink_cli() {
+	local cli
+	cli="${KERNELSRC}/tools/net/ynl/cli.py"
+
+	if ! [ -f "$cli" ]; then
+		SKIP_REASONS+=("Kernel sources do not have tools/net/ynl/cli.py")
+		return 1
+	fi
+
+	if ! "$cli" -h &> /dev/null; then
+		SKIP_REASONS+=("Cannot run the kernel tools/net/ynl/cli.py")
+		return 1;
+	fi
+
+	if ! [ -f "${KERNELSRC}/Documentation/netlink/specs/ulp_ddp.yaml" ]; then
+		SKIP_REASONS+=("Kernel sources do not have the ULP DDP netlink specs")
+		return 1
+	fi
+}
+
+have_iface() {
+	if [ -z "${NVME_IFACE}" ]; then
+		SKIP_REASONS+=("NVME_IFACE not set")
+		return 1
+	fi
+	return 0
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+netlink_cli() {
+	"${KERNELSRC}/tools/net/ynl/cli.py" \
+		--spec "${KERNELSRC}/Documentation/netlink/specs/ulp_ddp.yaml" \
+		"$@"
+}
+
+eth_stat() {
+	ethtool -S "${NVME_IFACE}" | awk "/ $1:/ { print \$2 }"
+}
+
+ddp_stat() {
+	netlink_cli --do stats-get --json "{\"ifindex\": $iface_idx}" \
+		| awk -F: "/'$1'/{print \$2;}" | tr -d '{},'
+}
+
+ddp_caps() {
+	local out
+	out="$(netlink_cli --do caps-get --json "{\"ifindex\": $iface_idx}")"
+	echo "$out" | tr '{},' '\n' | tr -d ' '| awk -F: "/$1/ { print \$2 }"
+}
+
+configure_ddp() {
+	local mod_param
+	local cap
+
+	mod_param=$1
+	cap=$2
+
+	echo "=== configured with ddp_offload=$mod_param and caps=$cap ==="
+
+	# set ddp_offload module param
+	modprobe -q -r nvme-tcp
+	modprobe -q nvme-tcp ddp_offload=$mod_param
+
+	# set capabilities
+	netlink_cli --do caps-set --json "{\"ifindex\": $iface_idx, \"wanted\": $cap, \"wanted_mask\": 3}" >> "$FULL" 2>&1
+}
+
+connect_run_disconnect() {
+	local io_size
+	local nvme_dev
+	local nb_drop
+	local drop_ratio
+	local nb_resync
+	local resync_ratio
+
+	# offload stat counters
+	local start_sk_add
+	local start_sk_add_fail
+	local start_sk_del
+	local start_setup
+	local start_setup_fail
+	local start_teardown
+	local start_off_bytes
+	local start_eth_bytes
+	local start_off_packets
+	local start_eth_packets
+	local end_sk_add
+	local end_sk_add_fail
+	local end_sk_del
+	local end_setup
+	local end_setup_fail
+	local end_teardown
+	local end_drop
+	local end_resync
+	local end_off_bytes
+	local end_eth_bytes
+	local end_off_packets
+	local end_eth_packets
+
+	io_size=$1
+
+	start_sk_add=$(ddp_stat rx-nvme-tcp-sk-add)
+	start_sk_add_fail=$(ddp_stat rx-nvme-tcp-sk-add-fail)
+	start_sk_del=$(ddp_stat rx-nvme-tcp-sk-del)
+	start_setup=$(ddp_stat rx-nvme-tcp-setup)
+	start_setup_fail=$(ddp_stat rx-nvme-tcp-setup-fail)
+	start_teardown=$(ddp_stat rx-nvme-tcp-teardown)
+	start_drop=$(ddp_stat rx-nvme-tcp-drop)
+	start_resync=$(ddp_stat rx-nvme-tcp-resync)
+	start_off_packets=$(ddp_stat rx-nvme-tcp-packets)
+	start_off_bytes=$(ddp_stat rx-nvme-tcp-bytes)
+	start_eth_packets=$(eth_stat rx_packets)
+	start_eth_bytes=$(eth_stat rx_bytes)
+	_nvme_connect_subsys --hdr-digest --data-digest --nr-io-queues 8
+
+	nvme_dev="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
+
+	local common_args=(
+		--blocksize_range=$io_size
+		--rw=randrw
+		--numjobs=8
+		--iodepth=128
+		--name=randrw
+		--ioengine=libaio
+		--time_based
+		--runtime="$TIMEOUT"
+		--direct=1
+		--invalidate=1
+		--randrepeat=1
+		--norandommap
+		--filename="$nvme_dev"
+	)
+
+	echo "IO size: $io_size"
+
+	_run_fio "${common_args[@]}"
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
+
+	end_sk_add=$(ddp_stat rx-nvme-tcp-sk-add)
+	end_sk_add_fail=$(ddp_stat rx-nvme-tcp-sk-add-fail)
+	end_sk_del=$(ddp_stat rx-nvme-tcp-sk-del)
+	end_setup=$(ddp_stat rx-nvme-tcp-setup)
+	end_setup_fail=$(ddp_stat rx-nvme-tcp-setup-fail)
+	end_teardown=$(ddp_stat rx-nvme-tcp-teardown)
+	end_drop=$(ddp_stat rx-nvme-tcp-drop)
+	end_resync=$(ddp_stat rx-nvme-tcp-resync)
+	end_off_packets=$(ddp_stat rx-nvme-tcp-packets)
+	end_eth_packets=$(eth_stat rx_packets)
+	end_off_bytes=$(ddp_stat rx-nvme-tcp-bytes)
+	end_eth_bytes=$(eth_stat rx_bytes)
+
+	echo "Offloaded sockets: $((end_sk_add - start_sk_add))"
+	echo "Failed sockets:    $((end_sk_add_fail - start_sk_add_fail))"
+	echo "Unoffloaded sockets:   $((end_sk_del - start_sk_del))"
+	echo "Offload packet leaked: $((end_setup - end_teardown))"
+	echo "Failed packet setup:   $((end_setup_fail - start_setup_fail))"
+
+	# global var results
+	nb_drop=$(( end_drop - start_drop ))
+	nb_resync=$(( end_resync - start_resync ))
+	nb_packets=$(( end_eth_packets - start_eth_packets ))
+	nb_offload_packets=$(( end_off_packets - start_off_packets ))
+	nb_bytes=$(( end_eth_bytes - start_eth_bytes ))
+	nb_offload_bytes=$(( end_off_bytes - start_off_bytes ))
+
+	offload_packets_ratio=0
+	offload_bytes_ratio=0
+
+	# sanity check and avoid div by zero in ratio calculation
+	if [[ nb_bytes -eq 0 || nb_packets -eq 0 ]]; then
+		echo "No traffic: $nb_bytes bytes, $nb_packets packets"
+		return
+	fi
+
+	offload_packets_ratio=$(( nb_offload_packets*100/nb_packets ))
+	offload_bytes_ratio=$(( nb_offload_bytes*100/nb_bytes ))
+
+	drop_ratio=$(( nb_drop*100/nb_packets ))
+	resync_ratio=$(( nb_resync*100/nb_packets ))
+	[[ drop_ratio -gt 5 ]] && echo "High drop ratio: $drop_ratio %"
+	[[ resync_ratio -gt 5 ]] && echo "High resync ratio: $resync_ratio %"
+}
+
+test() {
+	local starting_ddp_config
+
+	: "${TIMEOUT:=30}"
+
+	echo "Running ${TEST_NAME}"
+
+	# get iface index
+	iface_idx=$(ip address | awk -F: "/${NVME_IFACE}/ { print \$1; exit; }")
+
+	# check hw supports ddp
+	if [[ $(( $(ddp_caps hw) & 3)) -ne 3 ]]; then
+		SKIP_REASONS+=("${NVME_IFACE} does not support nvme-tcp ddp offload")
+		return
+	fi
+
+	_setup_nvmet
+	_nvmet_target_setup
+
+	if [ "$(cat "/sys/module/nvme_tcp/parameters/ddp_offload")" = Y ]; then
+		starting_ddp_config="1 $(ddp_caps active)"
+	else
+		starting_ddp_config="0 $(ddp_caps active)"
+	fi
+
+	# if any of the offload knobs are disabled, no offload should occur
+	# and offloaded packets & bytes should be zero
+
+	configure_ddp 0 0
+	connect_run_disconnect 32k-1M
+	echo "Offloaded packets: $nb_offload_packets"
+	echo "Offloaded bytes: $nb_offload_bytes"
+
+	configure_ddp 0 3
+	connect_run_disconnect 32k-1M
+	echo "Offloaded packets: $nb_offload_packets"
+	echo "Offloaded bytes: $nb_offload_bytes"
+
+	configure_ddp 1 0
+	connect_run_disconnect 32k-1M
+	echo "Offloaded packets: $nb_offload_packets"
+	echo "Offloaded bytes: $nb_offload_bytes"
+
+	# if everything is enabled, the offload should happen for large IOs only
+	configure_ddp 1 3
+
+	connect_run_disconnect 32k-1M
+	[[ nb_offload_packets -lt 100 ]] && echo "Low offloaded packets: $nb_offload_packets"
+	[[ nb_offload_bytes -lt 32768 ]] && echo "Low offloaded bytes: $nb_offload_bytes"
+	[[ offload_bytes_ratio -lt 90 ]] && echo "Low offloaded bytes ratio: $offload_bytes_ratio %"
+	[[ offload_packets_ratio -lt 95 ]] && echo "Low offloaded packets ratio: $offload_packets_ratio %"
+
+	# small IO should be under the offload threshold, ratio should be zero
+	connect_run_disconnect 4k-16k
+	echo "Offload bytes ratio: $offload_bytes_ratio %"
+	echo "Offload packets ratio: $offload_packets_ratio %"
+
+	_nvmet_target_cleanup
+
+	# restore starting config
+	configure_ddp $starting_ddp_config > /dev/null
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/055.out b/tests/nvme/055.out
new file mode 100644
index 0000000..06706a6
--- /dev/null
+++ b/tests/nvme/055.out
@@ -0,0 +1,44 @@
+Running nvme/055
+=== configured with ddp_offload=0 and caps=0 ===
+IO size: 32k-1M
+Offloaded sockets: 0
+Failed sockets:    0
+Unoffloaded sockets:   0
+Offload packet leaked: 0
+Failed packet setup:   0
+Offloaded packets: 0
+Offloaded bytes: 0
+=== configured with ddp_offload=0 and caps=3 ===
+IO size: 32k-1M
+Offloaded sockets: 0
+Failed sockets:    0
+Unoffloaded sockets:   0
+Offload packet leaked: 0
+Failed packet setup:   0
+Offloaded packets: 0
+Offloaded bytes: 0
+=== configured with ddp_offload=1 and caps=0 ===
+IO size: 32k-1M
+Offloaded sockets: 0
+Failed sockets:    0
+Unoffloaded sockets:   0
+Offload packet leaked: 0
+Failed packet setup:   0
+Offloaded packets: 0
+Offloaded bytes: 0
+=== configured with ddp_offload=1 and caps=3 ===
+IO size: 32k-1M
+Offloaded sockets: 8
+Failed sockets:    0
+Unoffloaded sockets:   8
+Offload packet leaked: 0
+Failed packet setup:   0
+IO size: 4k-16k
+Offloaded sockets: 8
+Failed sockets:    0
+Unoffloaded sockets:   8
+Offload packet leaked: 0
+Failed packet setup:   0
+Offload bytes ratio: 0 %
+Offload packets ratio: 0 %
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d1a4c01..4a43e43 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -199,6 +199,14 @@ _require_kernel_nvme_target() {
 	return 0
 }
 
+_require_remote_nvme_target() {
+	if [ -z "${nvme_target_control}" ]; then
+		SKIP_REASONS+=("Remote target required but NVME_TARGET_CONTROL is not set")
+		return 1
+	fi
+	return 0
+}
+
 _test_dev_nvme_ctrl() {
 	echo "/dev/char/$(cat "${TEST_DEV_SYSFS}/device/dev")"
 }
-- 
2.34.1

