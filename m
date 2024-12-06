Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F320764E
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493121; cv=fail; b=uMSZH/x9GstFqK4Qr+8tBhIXlT4va2Oo8QrDVfYxH24K5wc+iY4B5XgtMdIPXAKY3X4XRNS4eCwZ0SswwMLuk3urNOHPUMW0F1eiKC+mB4X2X818fhL8CLxXWjyg2yzRnvnvmXnyNyEBoNGlLt2YDsGjDZC/W/Kmug4U4Amq77M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493121; c=relaxed/simple;
	bh=qD6DEvVMwX0Felrq4VLQZyXkccyE0ON/5jb2PJv+2xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/6JK1F7yZ+sysc9xTFVAKXPzUFglujLX5PcpTzVHOrZ/kGqfAVKyTHs32wLrAmdooZKtCTIQzW+umRlM7U8VkbdUvuRxew/06SIbtR+Q9zdUJpEIE1qMfkSJziAJgAygJ/Saj9sNN3nEaen7P165tI8xU5tsaCsPlPYoMXp9Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oUZdiBgf; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oUZdiBgf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ty4ovDEi+aCg/aiWenlO/zsvclqSezw4RT3LU5Dmw1n12wCcfAWo/ZRjwGPUMfjRABnOjz+rBOKgSxAhT89crE/BBR0XaFv+foiNG1Ljn8oPBAmbJXvwE1JeD8mLQv+lrbrI2X1F/A21r27Ws7t3lxUH+PJnCmV+JWH/l6rKrX/+xpf/LHS8Ja+quYkdsZ4knx/HtFg+sLNQR2evnfF/ql6qDFNz+z84/z+300ItQnH5BDSTydggy7HxPJyR2LZAYPIjl1TmmKOIDcoszf41MeMkujAFomQ4qf6/skWP5iY6Dp1+WRVuD/1vHZEqAZhrNegpV09mh/fRL2qSSR4ioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0jB3iFC7HdxiCP7MJ8rxsJPEWyC+PI7oPlcclDFtjo=;
 b=IMdQSzheWKeSCBNZ1sm7I6NyAHRRGzbssPsdtnozMSge1O10z3lHjc8OHD45e4QWXR7yCYl1S70NXbBofCy/qrmSs+UmQWnjNLqlDAOgtMLdNRSjKWTQfNiaVV04pprjVEDpj+6jNKoxwQNNbxVfTXyhR4JbNsydRPSHG5UNJhsXGT+X+LfPC+FDQQqCqNrraOTsuztt/Bqk50yyW+oIScpM/TiPzB/nKbnPuntlNTTECQWxe6YwKnNdm0enq/2aBAiSXvftWACjXBANKncIVoVfv1uVa2o1z+SG/GX3Fr64fMz+POasntnn1JwF7yGE4KkN0YzHx7FNat+pinKtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0jB3iFC7HdxiCP7MJ8rxsJPEWyC+PI7oPlcclDFtjo=;
 b=oUZdiBgfWeddJ+M2Ajp9tPkZC7pdRF7Wfs2TA6TdzrF8I51wnJPSIe/jX41Qki6SHG4FfYL4C0XoUaO7Ri/uAyEHdeDhjFq0/6hb6T72qqdLgzME62WhWVk13stmaXrmYtOve0qhfbq/u06AZOH6WNd8tbmZgSk7jafxM33Cmfq4J5VrC1RkjiDP49wMgn59n45hD0af3wpeU+9P6OVLTpNyP4WuFK5AzFpOZBIkHjDpU3zh+SC4fvRUXfLiscfkA6h3SsFgTVIqaFUm9Pe1macJG34K8ZM8AfTtzJ9ZgRyDpXJl1pjO+4IF0uKNx7RKHKCRpJqmyGrjjMigDR2GKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 13:51:56 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:51:56 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 4/5] contrib: add remote target setup/cleanup script
Date: Fri,  6 Dec 2024 15:51:19 +0200
Message-Id: <20241206135120.5141-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206135120.5141-1-aaptel@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0423.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::7) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 91ca9066-0a79-4faa-49df-08dd15fd25b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OszKlb53I69Q28AEU9c8P6CwlcXOt22Z5VDAGKJHoP4+GMNl6kMFd1C4rb7o?=
 =?us-ascii?Q?MOK1lAEu5JXFY8LGCwGZwps4spcWDqk4fPC5YL8qqY1dtMy/BRxCcpd9pcQB?=
 =?us-ascii?Q?wCm3NScNk5tSk1iE91ckeTQ1pb0S8tX7xjR6Rr8i4xj0AjLCF25y3uB1ARXt?=
 =?us-ascii?Q?qbSaGMC1jNOHpwJzmQVOfgSuW9xONTcMpm54rXC0OBPi3hrTSWBDeI2HPUko?=
 =?us-ascii?Q?crVLgpkAJtPbzFtFmrvc2dSoOJKPTKUg2XaTLyEgy+ynoWFZgxIsCzpXcBnF?=
 =?us-ascii?Q?w0UVD1cGzx2jEnHjWdYz7msUMKZInr6QoGDO65yFzWQw6npaHw+pFEiqQd/T?=
 =?us-ascii?Q?cpb9Pj2r960cAP177xld6lq/XXy7uNWCeJJ3mOl54ko5QxKXgPDWHTNExNHa?=
 =?us-ascii?Q?iGxqhv/4gle18YMD5vYtpCwEPz/nrrWvkEEMkFGD+tmNZ1wyP77u0Z4Jsu3P?=
 =?us-ascii?Q?8CIDgoSfWM42oVqVTW456vwcurgYhLpI/SgplvAIrjWS75v+MkwSfbPapmX9?=
 =?us-ascii?Q?8T2m6trP68g20Nt41ZcnrU4Z2bZdujOxT/lURR5WHQsrvG+J68ZaSvdZZoEF?=
 =?us-ascii?Q?nqqJUFSPzfQcQyNj4cIx6VolEyNPUEJ3UmTaNHIgkwbnknvVoPOBw5+g2Gud?=
 =?us-ascii?Q?7y5L1Wm9Vr97UYmDkj6dFtB3s50TnSikayik+nthBHNIth9ZG8TZqRIZvwgK?=
 =?us-ascii?Q?H2c04B8KrvZDZVOrdvzMdHM10RbrBeNcXHnCA0wV8n6B/AxhPZNqR8I5SEsw?=
 =?us-ascii?Q?bJQKo/U1JAxL5u13ZF6aLYMLX/hk997wdj5gRNzghjImc6hOI4SWQn7zAgnZ?=
 =?us-ascii?Q?YWAT05P8rKaqXWuomebCm4bQqi9g5fvZW65bg5n+Ah+8E7hYUd7aFZE20Ts4?=
 =?us-ascii?Q?Bv3cEUy0ilWgZYhsOEUyUwTVhDEUH1gxlbkhI8SynUdoEoETxv9CoSgluwFA?=
 =?us-ascii?Q?dI7qbO+TuScJfyuQ5D25pdNI79fQ8wqrqK8lMEcgowNXnZ/nSL6N0nh5rPTs?=
 =?us-ascii?Q?z9wjlwHK6cyd3Z4Uoz8V/fFFFFvuh9Fv0UT8q3esh4oDchB3Y33Sws3p3b/2?=
 =?us-ascii?Q?PGaLAyMrg3K21xCbifHFM/9GJoKTghThJGAQh/JX5Z17G7xsSy3vfVdjPIs/?=
 =?us-ascii?Q?C+ZqbOCsDpX10Uu6u5WMXqjDVdnVLH3zmqXnDQ3fISaEttSccWNwkYKyJdzP?=
 =?us-ascii?Q?Kzn18fCvzFv9p/EyMkK23oVoy0AJMXCSBo+Em54CU9fznxAklEXW2jfwSzZe?=
 =?us-ascii?Q?Jd8YgmzHMJcOxRoIF/QiDcxGG3ZxOzbj4FVkgtKjKcjqQOYT12a70M93LJEj?=
 =?us-ascii?Q?DEGsdOsOVU4cBWEgAgZtdc1DhYCU3O7nrWomL9bDfJYw+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QAHznqaMzkwJB+rKvm+Vc62dL5YjOZzTnowy/DuEpuolhzTO2rvIDyHwkn63?=
 =?us-ascii?Q?UJMKSrgk3X+knb7xpT/NfF2pK80imyzQw+9y1kul27pLXv7x0m1OQTCjLuKm?=
 =?us-ascii?Q?uwginbO8xXKd+WW59e0hTK/06mqMc4YhVDhNL0FqYgU6zQMdFZVfnxNN5ejO?=
 =?us-ascii?Q?TdXN3zQLjSJgLpPFoJ5YCWVzsO81nSplcE6KXq/+QbDP3NUc6KvZBr1Ewjyr?=
 =?us-ascii?Q?atxWHJxxYEo8Tnc1VbgjQ+DIbNIn2NRgWrKfRX8JczY1wxd0xMXWhCJkHkf5?=
 =?us-ascii?Q?0wIr9GzCACwtz2Y74SCPxnuZVn6Yfwmjn2VEtGBco8VkyL5UfPmlpJeJsd8i?=
 =?us-ascii?Q?w0XY00lxVmJWoOcjkOKKA4B68JiOhRbDqKQiK47lPRoBERWSaswxCUyyTUPs?=
 =?us-ascii?Q?qh5FgOVkCQGU9OhmdaLtsXr/sgRD/jwM3Y560mTcNl2ObfgaGL+9weaR0vCK?=
 =?us-ascii?Q?UkiWkDRht4FJA33x3Sdb+9/P4MDCw4UOfgaZADoVHF7s7hvIPNm/ibzzE2By?=
 =?us-ascii?Q?gYjWDnzBWTNsesw9md7eRPDn7MyPwGR9e5BN4lYwRAZ/OYhrCngxCXIaQMFq?=
 =?us-ascii?Q?afc2/uvKu3mmhm9cvGti9lI0LujvzlkHpb8wlEJJK+jU/X3YraFMGQMy/hRr?=
 =?us-ascii?Q?0a1zTzPODIHcVE9q3bMtXOzYPgI01jZ0DPhCxkfwuW9EryeqK0EiJ2o1c9zD?=
 =?us-ascii?Q?vD3V8GnZ1hqkrBEcJLULdBx3EhRAOKInnn6f+iZxkTJcbfYIusw8+o5VOdYK?=
 =?us-ascii?Q?dv5kvVbsUaVUl6ymMy03zf78IWLIlL8pNn7uB7IpRbAaQRqhRVNMR9XrckE/?=
 =?us-ascii?Q?4rn34xb8r9AKPUwV2IH1m8OIgeuy/5FlCi3K1sc89qEJ1RTvGrYdr33FSzfb?=
 =?us-ascii?Q?4iAnJ8xi84ZJq0Rt+lmTdozCwQRGps8dcLe4gMdtTyvUSdE8HKxiFNcmgGjX?=
 =?us-ascii?Q?e6mZlvpyPodF7Icc/HyTgmQKPGbySCN6UPfCX/XHcz02JdWWL/PD3oE2SIjn?=
 =?us-ascii?Q?mHr17gcaUODa/KGLCnvT5ej5fyUnXnQ6oQ5tutmi3ncmSPFsxwH6NVb6+wuL?=
 =?us-ascii?Q?DiSJQe5lTaw4bdxv0P3Wd5BDaovoSYoiqzJINsXnEUIAJtDVn+TYdvhuYrLU?=
 =?us-ascii?Q?c4HKb728Ubet94v6GQQmLFfkSlaLpi5yKVmHgB9bYTjLaqYknNnLACVNbbXI?=
 =?us-ascii?Q?SvOqHhkppBoq1PE+t+ct276xjC6iE4KHfl7sCwcw6iThFNzasZjXtl9Hxvs7?=
 =?us-ascii?Q?Fgjjw3xV2MJ9YRiwSFqV+XtFDbPGZFWkBkbRqFqcsTd/c2ihnZpQqAnJCrL6?=
 =?us-ascii?Q?ZGdt3dTqyCtlUGRWcDO4zs/Rrj3oAl1T5Yd9VJThmxbjytdD/yrdJLqrR7yh?=
 =?us-ascii?Q?oPBgpjwSLmiV6VuzdCwhhO/KApMkMWi88G1FMxuao9Ubm8oeCDhHX+8LvkN8?=
 =?us-ascii?Q?iAbLz7WIkZ/wogZD0oNxV/HLggzk4BqH8RmS+xDxh1vnQGsT8Y20wgMdptvy?=
 =?us-ascii?Q?9X1WLKx0v5lvJUhLjtNkADsWj4BfEM44SpZWj9AZ26y1nlhf4lAOfEudaw4L?=
 =?us-ascii?Q?TpbvK8lUmWQmbUfKMpMTQdqKYuLypE+1lDUtIk6u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91ca9066-0a79-4faa-49df-08dd15fd25b5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:51:56.1208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lySVD6USenz9tJk/c74Jdwd/53MLp7it0+rkMAAj0em+7CbWtQr60if19rKvLGNYaAK3j2iR9xAv/+yK2B9TBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

From: Daniel Wagner <dwagner@suse.de>

Use nvmetcli to setup/cleanup a remote soft target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 contrib/nvme_target_control.py | 190 +++++++++++++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 ++++++++++++
 2 files changed, 261 insertions(+)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2

diff --git a/contrib/nvme_target_control.py b/contrib/nvme_target_control.py
new file mode 100755
index 0000000..db77fe3
--- /dev/null
+++ b/contrib/nvme_target_control.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-3.0+
+
+# blktests calls this script to setup/teardown remote targets. blktests passes
+# all relevant information via the command line, e.g. --hostnqn.
+#
+# This script uses nvmetcli to setup the remote target (it depends on the REST
+# API feature [1]). There is not technical need for nvmetcli to use but it makes
+# it simple to setup a remote Linux box. If you want to setup someting else
+# you should to replace this part.
+#
+# There are couple of global configuration options which need to be set.
+# Add ~/.config/blktests/nvme_target_control.toml file with something like:
+#
+# [main]
+# skip_setup_cleanup=false
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# [host]
+# blkdev_type='device'
+# trtype='tcp'
+# hostnqn='nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+# hostid='0f01fb42-9f7f-4856-b0b3-51e60b8de349'
+# host_traddr='192.168.154.187'
+#
+# [subsys_0]
+# traddr='192.168.19.189'
+# trsvid='4420'
+# subsysnqn='blktests-subsystem-1'
+# subsys_uuid='91fdba0d-f87b-4c25-b80f-db7be1418b9e'
+#
+# This expects nvmetcli with the restapi service running on target.
+#
+# Alternatively, you can skip the the target setup/cleanup completely
+# (skip_setup_cleanup) and run against a previously configured target.
+#
+# [main]
+# skip_setup_cleanup=true
+# nvmetcli='/usr/bin/nvmetcli'
+# remote='http://nvmet.local:5000'
+#
+# [host]
+# blkdev_type='device'
+# trtype='tcp'
+# hostnqn='nqn.2014-08.org.nvmexpress:uuid:1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
+# hostid='1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
+# host_traddr='10.161.16.48'
+#
+# [subsys_0]
+# traddr='10.162.198.45'
+# trsvid='4420'
+# subsysnqn='nqn.1988-11.com.dell:powerstore:00:f03028e73ef7D032D81E'
+# subsys_uuid='3a5c104c-ee41-38a1-8ccf-0968003d54e7'
+# blkdev='/dev/nullb0'
+#
+# nvmetcli uses JSON configuration, thus this script creates a JSON configuration
+# using a jinja2 template. After this step we simple have to set the blktests
+# variable correctly and start blktests.
+#
+#   NVME_TARGET_CONTROL=~/blktests/contrib/nvme_target_control.py ./check nvme
+#
+# [1] https://github.com/hreinecke/nvmetcli/tree/restapi
+
+import os
+
+# workaround for python<3.11
+TOML_OPEN_MODE="rb"
+try:
+    import tomllib
+except ModuleNotFoundError:
+    import pip._vendor.tomli as tomllib
+    TOML_OPEN_MODE="r"
+
+import argparse
+import subprocess
+from jinja2 import Environment, FileSystemLoader
+
+
+XDG_CONFIG_HOME = os.environ.get("XDG_CONFIG_HOME")
+if not XDG_CONFIG_HOME:
+    XDG_CONFIG_HOME = os.environ.get('HOME') + '/.config'
+
+
+with open(f'{XDG_CONFIG_HOME}/blktests/nvme_target_control.toml', TOML_OPEN_MODE) as f:
+    config = tomllib.load(f)
+    nvmetcli = config['main']['nvmetcli']
+    remote = config['main']['remote']
+
+
+def gen_conf(conf):
+    basepath = os.path.dirname(__file__)
+    environment = Environment(loader=FileSystemLoader(basepath))
+    template = environment.get_template('nvmet-subsys.jinja2')
+    filename = f'{conf["subsysnqn"]}.json'
+    content = template.render(conf)
+    with open(filename, mode='w', encoding='utf-8') as outfile:
+        outfile.write(content)
+
+
+def target_setup(args):
+    if config['main']['skip_setup_cleanup']:
+        return
+
+    conf = {
+        'subsysnqn': args.subsysnqn,
+        'subsys_uuid': args.subsys_uuid,
+        'hostnqn': args.hostnqn,
+        'allowed_hosts': args.hostnqn,
+        'ctrlkey': args.ctrlkey,
+        'hostkey': args.hostkey,
+        'blkdev': config['subsys_0']['blkdev'],
+    }
+
+    gen_conf(conf)
+
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'restore', args.subsysnqn + '.json'])
+
+
+def target_cleanup(args):
+    if config['main']['skip_setup_cleanup']:
+        return
+
+    subprocess.call(['python3', nvmetcli, '--remote=' + remote,
+                     'clear', args.subsysnqn + '.json'])
+
+
+def target_config(args):
+	if args.show_blkdev_type:
+		print(config['host']['blkdev_type'])
+	elif args.show_trtype:
+		print(config['host']['trtype'])
+	elif args.show_hostnqn:
+		print(config['host']['hostnqn'])
+	elif args.show_hostid:
+		print(config['host']['hostid'])
+	elif args.show_host_traddr:
+		print(config['host']['host_traddr'])
+	elif args.show_traddr:
+		print(config['subsys_0']['traddr'])
+	elif args.show_trsvid:
+		print(config['subsys_0']['trsvid'])
+	elif args.show_subsysnqn:
+		print(config['subsys_0']['subsysnqn'])
+	elif args.show_subsys_uuid:
+		print(config['subsys_0']['subsys_uuid'])
+
+
+def build_parser():
+    parser = argparse.ArgumentParser()
+    sub = parser.add_subparsers(required=True)
+
+    setup = sub.add_parser('setup')
+    setup.add_argument('--subsysnqn', required=True)
+    setup.add_argument('--subsys-uuid', required=True)
+    setup.add_argument('--hostnqn', required=True)
+    setup.add_argument('--ctrlkey', default='')
+    setup.add_argument('--hostkey', default='')
+    setup.set_defaults(func=target_setup)
+
+    cleanup = sub.add_parser('cleanup')
+    cleanup.add_argument('--subsysnqn', required=True)
+    cleanup.set_defaults(func=target_cleanup)
+
+    config = sub.add_parser('config')
+    config.add_argument('--show-blkdev-type', action='store_true')
+    config.add_argument('--show-trtype', action='store_true')
+    config.add_argument('--show-hostnqn', action='store_true')
+    config.add_argument('--show-hostid', action='store_true')
+    config.add_argument('--show-host-traddr', action='store_true')
+    config.add_argument('--show-traddr', action='store_true')
+    config.add_argument('--show-trsvid', action='store_true')
+    config.add_argument('--show-subsys-uuid', action='store_true')
+    config.add_argument('--show-subsysnqn', action='store_true')
+    config.set_defaults(func=target_config)
+
+    return parser
+
+
+def main():
+    import sys
+
+    parser = build_parser()
+    args = parser.parse_args()
+    args.func(args)
+
+
+if __name__ == '__main__':
+    main()
diff --git a/contrib/nvmet-subsys.jinja2 b/contrib/nvmet-subsys.jinja2
new file mode 100644
index 0000000..a446fbd
--- /dev/null
+++ b/contrib/nvmet-subsys.jinja2
@@ -0,0 +1,71 @@
+{
+  "hosts": [
+    {
+      "nqn": "{{ hostnqn }}"
+    }
+  ],
+  "ports": [
+    {
+      "addr": {
+        "adrfam": "ipv4",
+        "traddr": "0.0.0.0",
+        "treq": "not specified",
+        "trsvcid": "4420",
+        "trtype": "tcp",
+        "tsas": "none"
+      },
+      "ana_groups": [
+        {
+          "ana": {
+            "state": "optimized"
+          },
+          "grpid": 1
+        }
+      ],
+      "param": {
+        "inline_data_size": "16384",
+        "pi_enable": "0"
+      },
+      "portid": 0,
+      "referrals": [],
+      "subsystems": [
+        "{{ subsysnqn }}"
+      ]
+    }
+  ],
+  "subsystems": [
+    {
+      "allowed_hosts": [
+        "{{ allowed_hosts }}"
+      ],
+      "attr": {
+        "allow_any_host": "0",
+        "cntlid_max": "65519",
+        "cntlid_min": "1",
+        "firmware": "yada",
+        "ieee_oui": "0x000000",
+        "model": "Linux",
+        "pi_enable": "0",
+        "qid_max": "128",
+        "serial": "0c74361069d9db6c65ef",
+        "version": "1.3"
+      },
+      "namespaces": [
+        {
+          "ana": {
+            "grpid": "1"
+          },
+          "ana_grpid": 1,
+          "device": {
+            "nguid": "00000000-0000-0000-0000-000000000000",
+            "path": "{{ blkdev }}",
+            "uuid": "{{ subsys_uuid }}"
+          },
+          "enable": 1,
+          "nsid": 1
+        }
+      ],
+      "nqn": "{{ subsysnqn }}"
+    }
+  ]
+}
-- 
2.34.1

