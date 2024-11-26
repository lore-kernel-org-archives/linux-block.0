Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0E88831
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653594; cv=fail; b=f9j1W1HbEaeUA+2BfCtabsJ4BJzwK8sgL6qI/v5JaeFUSZ+xmj2duympevAnTC2VqHqXlmgLVIAgctITAzxAWcWG2AGeo3uul/9fJOziVNVhajoakZwjUMOSy8alVS4A2ognY8WoBY5+dtreuPjHIGdnmXrNewfOLh7knix0DuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653594; c=relaxed/simple;
	bh=qD6DEvVMwX0Felrq4VLQZyXkccyE0ON/5jb2PJv+2xE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbrMctA0q3auCEhIboi+ApX48QnxcVSJweRhzKeBoZql/LKCQMxNRilgCcKJQBy9MZtgCiHYSqsQkw69K3HuM9b4eNYsTPNTGmby/YD7uADokhUvRQtsNq/z9oOPvWMo/L6+iwhwa3OXgXww7+msOVahIuvlpdSk1syFcrQJYsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Wh2mOf3F; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Wh2mOf3F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8uY4ajJurWUMoo+lDHn2wQOxMXHOZrUThegdLXHpvDIFMUZoTaExS5DV0HpuU2OjNSJdLBAVbRfA0xMxLQYAh+s8nK+cVve06KNdGYkgK/0C+SKRh/JiifMIqu2849u9Yrz+1KJzKEohgjkaoZdNoORSxgcTmK78O2avaO+fDkjctgtduQ/dnkrvwfn8uPnVUg8E7sYa2J5kKrGqB11rHDRPLhkIfUlvxSYaf8F8LINjmzD1FravASxwgSlyV6TTBiiN3wJcGD8rZ5BxSiSRhfRlpUOHsQVi9vqt0ZBpAh2tTfXe8eizBArvFNmJixs3oGsMof+C1Vw8buWSSAgJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0jB3iFC7HdxiCP7MJ8rxsJPEWyC+PI7oPlcclDFtjo=;
 b=JwAECEZklaEQ+IKOK5Vg+jyXmMZWFwbEMze4TjsqgWFxkZTblQS87Fn2b2unhrK/dS97KSTJ5LY1EvkR4t5pBUVH9xk8zmG7xOfzk2kF7/UprjSasLerVf5PPj/9iyd20ekvHB0ZXlmi9OrReIGU3KFDuIYBCgno229CxjxryVvEPhTgw52FzHGcJ4ff+ufijlsws1cu2aG1cASMcacGsDFEQZy78NnGNibbjWDtcZK4+jHXZinq8RljEkbuWRZooD9OXTglNi0IHPVeAGLfF1iInvTnU479RMrRNVlYYFwe4ecq+KC6j4RamYR1lEvniAUFUr0+pFkLDb91o785MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0jB3iFC7HdxiCP7MJ8rxsJPEWyC+PI7oPlcclDFtjo=;
 b=Wh2mOf3Fbnxurj3SxgfGPSB+aw3NVYY5mi+h/QQR5GLq8duqH66j/dSvUr/TRtj7+6FUdhj7Bhwi/GN+MV4K3sxXlgE/p9V5YRXcSVwG6AfU7lYSauBT2tSEmdrF7bBKNAsVtBYM/izf6OUh5KzrMmRlF6/o+PrIo6WmJTwsdPau6kx4C033ytdaRH6x31CGG5S+Bn2NN65fiMIscMjUujTzHGZAHYsoNoZS6GnEbMq/2rPJyuh+c2wKL39AdNtLQuuTz8JtI494JObh+BxJqCTnS5pEEtCkyqFJDlubR9FuAYdGW/iciwuqJlMW93yvxbIaZGjAmJnBl3VFJx1PVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA1PR12MB8697.namprd12.prod.outlook.com (2603:10b6:806:385::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Tue, 26 Nov
 2024 20:39:46 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:39:46 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 4/5] contrib: add remote target setup/cleanup script
Date: Tue, 26 Nov 2024 22:38:55 +0200
Message-Id: <20241126203857.27210-5-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126203857.27210-1-aaptel@nvidia.com>
References: <20241126203857.27210-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA1PR12MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b149d7f-5f7b-46c2-a1b3-08dd0e5a76cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGqdSzuBcY4dHZYMJUHhm7+VMGMNTPvUxjCqfO0fdj3VJIHpImGMIfINYJMd?=
 =?us-ascii?Q?xQcsS8FKMU9kQh/g5hDkV3ZZBOU+y2FD65uwduwRI6HC3EgZgeuw1DD6B2Rx?=
 =?us-ascii?Q?ILzLJBbvxsV8/kMSQpq3Al+QHTCtKQ83vzazTvlq8b2ozdK4QL3v+QOKI+Z0?=
 =?us-ascii?Q?RKDSxchVkfzeqtIgnAmH+v7qWHhgxKmdjJWMYh8Fd7mULa5v3I5e7w/xI0Gn?=
 =?us-ascii?Q?tzeUQOExoPO84RbmOc6N6mYf/RgNhTTH4f/tdoTNqEqk9WeF1m8x/rcfK2+z?=
 =?us-ascii?Q?Uadc6F5NuVWif8w7dQVlUjn9W6krDifwH3NrpAfbbJTGVBUSopLc6HKLn2w1?=
 =?us-ascii?Q?ylxJPsyCWVqtbmDS5U1E74BIcek0OtOBNR1mJOYE3wbU4lokzFjQAYYQw0Ra?=
 =?us-ascii?Q?InyYNhbzBnpol0UxmAZJ9xvO1YmC8bsOsr3Ueo7xPmL9uawkcG8n2EyqQNpi?=
 =?us-ascii?Q?J+ilpGfdizb9rt0mM3T69dAECwh2S2D3BQGF/urDgTfBoKsmnGe7YHtIAYGL?=
 =?us-ascii?Q?6H21vmPilE1STaMFypG+NRf7dm8hZH078Aey7yPIHqRtP1PdAJL699vxdCwI?=
 =?us-ascii?Q?b/x2O25qnF8undKTGuaWtnpS23+iLrw+r0nR1U/NvzNdGXZx9u0MBOnNkvGO?=
 =?us-ascii?Q?LKdtnQw2VSkmaNLRNSZnZCrsAesi44/pPEmGYJ/tTzv8r41NFw0v/gx+MFpV?=
 =?us-ascii?Q?kRB6Wc8JeTfm9+QPpVzFOm5RjZ4xiNsx6CrsfH4IW4GksrwdXsh0seTqVJGE?=
 =?us-ascii?Q?g2rKmr/Y7ALPTe+FZXKPJcLXXhYZ9B33q6OKusWH02I9abXaNYS7CLSQcFxx?=
 =?us-ascii?Q?b+AHUeC9KEpOtfLkmIbBydNvaNyu7psHpf6Mi+abGr0rZwjnxRFYlrlsZAE3?=
 =?us-ascii?Q?0edXXmXJT+pVQeTJ5sLtUOCOd/4scQ8657u0CW3GfmZrlSjU7IUPe6yZM0qO?=
 =?us-ascii?Q?V6/83LWT6Nn+r5wJ6gCD5mmtozX7KL0Ge+Spkc+tnbcNxk9iUSAl3RG7TEVb?=
 =?us-ascii?Q?JUeApfaxjxL4bGCIg2NGqoPr/cVnuNcmir8cuHWXtxl1dcOuVet2JH603qu+?=
 =?us-ascii?Q?grAOe/u34fCFIQCRlSZG8Ic+K3yDU/BErIx/u6RehJ7hpRu1LS1d4HuJSjSu?=
 =?us-ascii?Q?+5mDUZIeEGIOWqOgAcRyj/kRtI8KpkZFhqkoKJUk3VQxGaKCXbjo6jjhaLHY?=
 =?us-ascii?Q?j7ndkEDTvwXGD/lsOTYPDehV1bpw4kFHBQ95VKBDHnlAyJ8XRAtbsFWQeV0C?=
 =?us-ascii?Q?D81WLTLVnVqbXE57ePClnn9fHqlKdSBx4AVrq71dbHcB/ZlG44UHR1/OxITS?=
 =?us-ascii?Q?bdLCBzlg0M419M0QNHA0miIlKBEIw+HUy13KnuW4Dt1OyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W5mS+pJMcP6vd0TbDaeJgkrJoUczgZ9ryOZhjD4z4UZ5Xf/ObB5+evs7piS1?=
 =?us-ascii?Q?JUFmHIWUCOpVix/hQtXAh8tQexJ1vdJVz/gv0RP0xR+7MXLlRU7vIihYaVKr?=
 =?us-ascii?Q?lbZeOFrdszTi0p6fOLLoBInhhLT20RgFgNU0sZyFUSImPwD6NZxM5/Wzp7fh?=
 =?us-ascii?Q?shrXk/y3QScXnZi23QoxWU2ZoBLLww6ToYLkMNdXiIkP8inswLKF7AOxTihd?=
 =?us-ascii?Q?1ww+zTf9gNI4A5+ee2YlkEeM5/5trMlXztFupLxeYHJVmOFRxVgAGOlp433N?=
 =?us-ascii?Q?B/JAqTtH8fyqf/zeKmZwjjkQTHqYteSXt7gps2lYYUcvsfwYtaxklReemJ/B?=
 =?us-ascii?Q?Yerb6KzvVF5YxUZJVMVi9qyVW2Pevdn0RflgyjzDTfwBruistZhOm61LPC4B?=
 =?us-ascii?Q?+3j/XU7gkv7CSG8355pGWkKoirjBetdlHY/gzgH7UUa2JGP1wGR3RI+UB2z7?=
 =?us-ascii?Q?vDAC69EVfnUJLegsfDhrobGrVh0ar1rRtSnZoZmo4EWE2oR4zSQGD3qUkHmO?=
 =?us-ascii?Q?gqsYvXTufuTeRP1fgdTiOVGMTizCpCQdP6w3dP7iVqbGdOUSkgt23myWfmWs?=
 =?us-ascii?Q?FEr13LxKZFnfB/6wh0z+8baeTOBuiOOwNB1lUYUwd2bdb0FztNZ3pa4ADn9b?=
 =?us-ascii?Q?LbJPAmfloUpdUCRw87ljHWmZl6t1qIO/iOXasNwVzJMe1IoH4tT0Ag+Hbu2Y?=
 =?us-ascii?Q?82J5kuJU40WA1yHZ2r38zRt0lZRuZ8FtbCnFRyiXed+ufOW5gnPI+pf6w3cT?=
 =?us-ascii?Q?4j0IywwOxjrz2Zi0/Tq6ZemrYb5fvrxUlx0LkB2rBzg2hXXp2kHr61TSyCEZ?=
 =?us-ascii?Q?W0VtFdDB6u/LGz9SOU+F2M4UEnudR5ICDC32pKSRP9aRbkwzdBhLiciFxCY2?=
 =?us-ascii?Q?UE1d6b/SdcwwDejmGwfMdEWjqGsu9q2S220VKErp9se2xFJNXg7ZZlqJudGz?=
 =?us-ascii?Q?U9C8YAtOpOKYgaWfYB7nHD+lg1sfV0LSTiSUJRuu9+d/owSd52CezQxYNxWE?=
 =?us-ascii?Q?5brt3hhcSV9J1+ixv+gIj1J25pjfVF42AuTo0hm4a6AkaQfj3JsJrKB5v2yR?=
 =?us-ascii?Q?9exPa6RAwgkuhnnZgnZZ8gVjx4CZmvEHBlvOi3UGUxh3J/S0KU9f94phBFFj?=
 =?us-ascii?Q?7t4N3bBCMapWky18vrOgvK2NSwofVPaFex5BBUWjzlKorzof+rr6r8+rpZOu?=
 =?us-ascii?Q?81vaYQlw6V0JqqM+2PCcT3J7bTTzcHAvPnUBkeLx9OSHgCGlMvp1Kur79oFI?=
 =?us-ascii?Q?MueK5eJpNq19FrOoaqLZGyaL/alEPaVBOCks9wBICsHgIMJhrGci/Ou5gamD?=
 =?us-ascii?Q?LLQnSkcf+zEY/y1wBQYxC0ArlP/T3M8cmIDnAZKeWMIlRjgr0RsqoW3N3Pi5?=
 =?us-ascii?Q?ZGpGwgqrylwSU2YuRahYS29A1GqMc8++5MjuMnf16q9CgjJEIjUbTXGhpPhY?=
 =?us-ascii?Q?o9xlB1Buhss9v3faiX34Rmz+YoVpxfZDF79BzDCp2eYj63dgGIdxPnUR8w/U?=
 =?us-ascii?Q?Koyk0WDtptZHjtWl9opKlrZIndvxeuzDEJYgApe+cBPAS6paZmRzzVnN7PCt?=
 =?us-ascii?Q?OSW0zrMg97gjVr4CYQsovOrZRLzD8taOg4dFc8Ji?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b149d7f-5f7b-46c2-a1b3-08dd0e5a76cb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:39:46.1436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bgCjLoxdFrCgGEwpgcz4vh81vwiMAlir9BoVH2SOIPuJZmFBxUCLtaCLG5LHJ3anISV+uvBW5J0x1bTvnm6gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8697

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

