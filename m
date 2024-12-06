Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890912066DE
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733493105; cv=fail; b=Zcza97Zeo9K5Z29efDhGGc4/qfS+cK3QODFKJqXTbNrfWpOzhvq1JdGnXTHFCh6veOUOAkRpnlNhwjWzGXvtQw/cwb32VQZlVHp1bRuxxpJ10EaZ152yQzqg+/uuWj2p6uPJjyycdYgHd4AogfQqzdo7A4HFoQlpiGm2XFGVmEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733493105; c=relaxed/simple;
	bh=yQyRmeFCaupNPKDoGf8+0Q/nLihYn7oD/OVrnVj+5cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eFXHAV258r9uUyZc61FEb/mpA0Q2/L9MM2d7adkvbWrrA1F6yqAwhfZCbDh4Yeo3Ul0D2delfqT2Myi8zRdgvk2hYIw+sdmFO2t7ocwYVXYBsdGsz+o7YwAD+JD2eFBKyiWTGtorHytQobhOoAM2JlMGyKeBmWNHh/0oqO/pEb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WQ0jxyxv; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WQ0jxyxv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywz6QOL2+aeesoKyWqs24La5W33gAcZSQD690G6DsKMR+hYc3FkkYa6D1ruz3Ox8tixqWEWDoyEfdg9waakcexTi2rSdhGpngMlQlxX5eFGalI5Peoy1UiY8qtsEObXes0401Unf4hugIAJWIrUkIDfPXImAkOYpI0jm4SA9RQVV6U7UQ/JvMHTyw+yDEqbM+NtI8zdJ9Td9qYjJWGB2FmQk9VPYsC90wH2pDlEp5O3/TAGPyXN5AWWgTcS0ubmuE9RAuc1V9uAzxj6nstpTEUI1Z9b0F4705640cGIcrhQVpUm6q0008fMLH2R/iYeJVWKwzQL2k21y5SaoXAGfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF4cy/WoDM4NJ6o5D5oq+/atSv8wsoG7AgCJTpOGGyc=;
 b=qmxYDyKYdwahlOfOxPPFpn27CTgfQl2dw+9FZHEz8lrZefudrdhlIi+xiYf1VWP9Azmz5WwZIn+GdrWf8i3FPin8ffuSSzA63mawoMcZLTjgMbjL52IxPbs6dJpjQ2lXZLmuGBFGuNmecV3jNj+CcAf5Lfq33rDci5IR2IHIrYSxr3a0j4EcUzNvjG9EujR5PcHzZt87OfuKEgqUUWiOQJBq+yQ8xXrThOuniQ8Bx8WCSd2mCDgf0fALHbDl4AlB4qGkJdUa2Bg+od0xl4gMFZ/94HRNHXnieSVqcNvBI64MoRTuFjgLGuwpSFMhv7GlnFRH9GUknvKw1KT1E0jMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF4cy/WoDM4NJ6o5D5oq+/atSv8wsoG7AgCJTpOGGyc=;
 b=WQ0jxyxvwlwb0sH8NE6a/SUGLnmVJjWVbHjlmuAArMAbg38zSCsL8dr/xQU7fj9oug8At9oy11Rc+EQd3hW8wcbHeHIe0a73Tg543kQl5HQ8yzHtvRT4/B+VJ/dn8b9eeEg4+14Oo4U/VeoKdDL5VJZYNzDTqiDjC9/KWNNWSa5uI5bARJObikiXyNnq3bvdM6Xgpnfzcp+EnRPGB2v2r/QF+7z8vQuMXDd3dzulrPWON2IcwY1AM3hEentnDKWcusIVTQu7R8py2UKzV0csEXGmWjfoSptp360RjJ3hYFlJ22r9Qg+EIOEXjgGBrMUzjJS2av8XmmMsm3mzhooLvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by BY5PR12MB4209.namprd12.prod.outlook.com (2603:10b6:a03:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 6 Dec
 2024 13:51:40 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 13:51:40 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v5 1/5] nvme/rc: introduce remote target support
Date: Fri,  6 Dec 2024 15:51:16 +0200
Message-Id: <20241206135120.5141-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206135120.5141-1-aaptel@nvidia.com>
References: <20241206135120.5141-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|BY5PR12MB4209:EE_
X-MS-Office365-Filtering-Correlation-Id: 24b8a6b3-3503-475e-078a-08dd15fd1c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v2gza2QOLJuLhVfQdp50mMcIvb4OtXVaY4/MI2IW/lj6L9jRjyZ9Y8H6UGH6?=
 =?us-ascii?Q?lSkDl5uBUqDJVWbVyXsD54jpXRxObq/kjkXKvLja0ZR7ojqt2t9Yv5Y7/agh?=
 =?us-ascii?Q?AqRKWntskAa2WLBuR7/ieAv7Mw8rtd7Hymakrd1Jx8ShuxoSLOprXaJWucMR?=
 =?us-ascii?Q?QMDvQuJrs5tPGkM18cpV/cki7jZ0wzjo7Bq6YT8FIN6cw7h3hsEPssbW7xxx?=
 =?us-ascii?Q?pHmsZ3y+bGhdu2DGkfsIjSsizN1TU1/SEIOTApH6HwhZB/jU3Vta2CdJCLBx?=
 =?us-ascii?Q?AcD994bSPr65dnqRT071+j3cWtki/H3E6WD/34fGn69zcm0e7AG7wN8m626d?=
 =?us-ascii?Q?K3LstL//jjGbJSz+Zh4+z7wo1alArTVrFWoD/CslAoOxT+Ud1TECtPWHWU4j?=
 =?us-ascii?Q?0Kn2fnP0eTJjjrN+JSduDEGohlWpZ3shCyXJRc+0kFS6DfgFMc1qGaZON9eA?=
 =?us-ascii?Q?Lkzz1k0txwtNMtQv5v9EpAJEjMVYCI1Qy0i2o82U0b9yGx2n5O2vudjyQ3H4?=
 =?us-ascii?Q?EZ/PBURlBFKR72CJVmeL6kYxcPHg3m+s6n/pD3uePRQWME5yPxqNbp8OYf02?=
 =?us-ascii?Q?j+uAz1KygrAcw4kXq1lY89+MRu4+UBIaII5QL43t2Gpt8C4fmNz/TZ91JMBg?=
 =?us-ascii?Q?yMWfqM7Sir/mZ8y2g84Yt3Ti2RBY6ot1YsSfgG5DBhFGNLwkHh7kHiGQEFQ9?=
 =?us-ascii?Q?FvMDW/Do+C84Z4jWvQmWvMg8Bnct+BF67/5+dfBHlY8lEARKbKcdcv7yG7vN?=
 =?us-ascii?Q?cxKcKyv3s7qaRFOA6tZH3eiIRqYlLU0BASwIla1quWnOrtzhMNIkTBMYOoH4?=
 =?us-ascii?Q?ygIBx+Rgt10wcHXB1nPjI3YLQDlKQbzTxj4IGWBS5Wh6W9CCPSOZkjG098qn?=
 =?us-ascii?Q?5PrERK2/gZe/1b9QmZ/zeAy4jgb5UUSS445mbz8o+/TIDqmpZ0r/DXGCrYlE?=
 =?us-ascii?Q?gh16b9wWw/cTVOhzK5HMS/3Wac+FEXcALHaH1K/vtG4gA6rJL+mKjpsRjSPx?=
 =?us-ascii?Q?Y0dEyGbwa9SlrUHCEOubtQbrxxk8TFSXuF2VqtXaK82r2cyeBZ+TkJA7ygoV?=
 =?us-ascii?Q?7vMru1ogRA5ZOAI27lIuoFsbQva2JB5m74OPVXk9pjf29HDzu15wDxDWffen?=
 =?us-ascii?Q?jpXoFuCsi8jaJ24DnVjD+9wHP98KrOS0m0UKNAoyX52ukScRQ73XIfE1txoA?=
 =?us-ascii?Q?c0Vxn3DcD96F10LAjWJYWAOOr88Od6uEuMJlAdJ8UuGHEp6fGXCVKa2Wxsw6?=
 =?us-ascii?Q?IWQeOjBJL3mbOXqk7TS2TndyAGK5FqL6sj+8x2xK0G3Hjgd7gzgZSevveBx5?=
 =?us-ascii?Q?VNo5mv1uq8Oo0u3rHqYXWXknJjFUKeBhqZK9Pc6Axl1n9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0b+3sOM8VZU6/podwONYEy81drmukYEn6Yb9khL061ZbfiniB9iEgnjwgdtu?=
 =?us-ascii?Q?DPCkLByVag24B9pyIc9Nu5vObU0xUb0zLhkM76PeexRoN8TGsuv9aCn1/rtL?=
 =?us-ascii?Q?TAyefJr8WaYs1PikCCcgmpqVYoFAnhONRUekZdlSkpquLYIVCwBUoAncOMU/?=
 =?us-ascii?Q?WK41P23KKgFgRQrnhySeXxxz2ZnXnQ0Wma6iDizNlCVvilGEUfLtHCryUGKa?=
 =?us-ascii?Q?D1q8IcRZ55w06NLq+UToaqj2GBkOMlC3xpZZ0U0vmFcQnGZ4f9ZnKtRWI2ys?=
 =?us-ascii?Q?apejLfBwtSSRd4tfqV08psVjRjg6e0yIeo/TY7abAuOrqtc7JOC1pEM8djzZ?=
 =?us-ascii?Q?9J1hI4bkxdozL+JA1uoIH9X/NVbuCG8Oc495XEUGYEVlTY1bqowt2LqmFM/v?=
 =?us-ascii?Q?FGUR7aJX2bl4jmg2s2ZoiTSEEmTz2cYuL1f60l7USdqEQUTi/9Pvm32byqkt?=
 =?us-ascii?Q?0OfmW0DUCIxee7/jHEX8JcU3PvtARcvbLxVyg7TdB+G+juchCjrPpy+QNvzk?=
 =?us-ascii?Q?GeLvpWckSD5pdSGanynTu4fArDz/CnF9upP7NvMbRJOgBMl9BHRD98ktzftI?=
 =?us-ascii?Q?rJJtAXtSM2/y7NruwZjnYps1AxlYdjkuEbBtCZTeqk2CN9P+ITmMSn6CpXQp?=
 =?us-ascii?Q?dI1fgCgvdmDmy1eOG2HEi+RLBYkiBB+Ys/quNExa8aVL6T38n/Lw7Xwci4xo?=
 =?us-ascii?Q?VWhMx4RF+wrmXYO1YaSKdXZrJint7X9QKoz5kYiFEYC/qjLri0WEAhwam3e5?=
 =?us-ascii?Q?2VaNT7lawtV+JX6r3jxVL27oijtLHtMw3SUmLxG80AuczR//6ohw0ehUtAsx?=
 =?us-ascii?Q?lJl4YcrfkhaJ7M5jQ6E2dqp97bimQD2qDEUgJaHTXkShEqZ/3dg34emHE5yo?=
 =?us-ascii?Q?tXMW8P4+zgm7cA0USMgk7T5jVrBtox4OQ6nyuAWULAMEXrHjQJpSSLO6FhEq?=
 =?us-ascii?Q?JLxgFU0UGVVrmiUFsJPE5LL4u+p0O5WPji4rd1rWNFkVHXh2MX4lfw7q2zGD?=
 =?us-ascii?Q?U/J+aUzXmrwZGBsLGkj7L47bf+c7X08o1fAsmFEA4bPUjCFzUUJffpTQ+yAS?=
 =?us-ascii?Q?sjr0S0kCW+DDPG3JDosSQ1MhXRIOV8bvcs9IsgZxAEVgMOt3tDkXmxHWLxJW?=
 =?us-ascii?Q?qJMRyyB/tmDxEhS6uto8NFL7o6g99J43BoHf8ezLq1xGOcexm0ULcaWzv6rd?=
 =?us-ascii?Q?wME3o1Q2SvNkLSwhNHuBQO76hMIDRZjjpBZgbr1Wg7HmmuJDPiVwEmZVZytz?=
 =?us-ascii?Q?hsy7b+6VZ/ciYJfbEKqqNLZj5GlRhDtup7+prfrAwahFwT14oRKo99ehiOfI?=
 =?us-ascii?Q?KvRCAfB3AA8jrx1umVgHLmWjEqbeVZIPjnlF50XFN2beJGrXXPOmybwauUyt?=
 =?us-ascii?Q?mp6gc3OyQcxFI+RvcF+lBcepkm1Q24if8KBi4TEh2Jn241664XBvE6bP90wI?=
 =?us-ascii?Q?C7eL3dcPTsNLtsIfgHKpaehnAOD9c1fBtCeQCzCN7mXYD3WoQlq5/caaiCvY?=
 =?us-ascii?Q?l4/SBnPWgreTK4VA9xoi8z405yTizm+PZvv/z5lPUqf9WU9+xQFyUmdJJkYr?=
 =?us-ascii?Q?O7+NA50Vl4ST+jIyfeOqtU4SF+Hur+aW7SDZ2PLc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b8a6b3-3503-475e-078a-08dd15fd1c28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 13:51:40.2649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qp+Y16QmIBRUvrFtw5e+hSDsJMII8jS3Hd0TftnNQu5vLb+piRMi/ZVELmYcBkh8OYWsLhcjUUYAOhQct+mz+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4209

From: Daniel Wagner <dwagner@suse.de>

Most of the NVMEeoF tests are exercising the host code of the nvme
subsystem. There is no real reason not to run these against an arbitrary
target. We just have to skip the soft target setup and make it possible
to setup a remote target.

Because all tests use now the common setup/cleanup helpers we just need
to intercept this call and forward it to an external component.

As we already have various nvme variables to setup the target which we
should allow to overwrite. Also introduce a NVME_TARGET_CONTROL variable
which points to a script which gets executed whenever a targets needs to
be created/destroyed.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 Documentation/running-tests.md | 33 ++++++++++++++++++
 check                          |  4 +++
 common/nvme                    | 62 +++++++++++++++++++++++++++++-----
 tests/nvme/rc                  | 14 ++++++++
 4 files changed, 105 insertions(+), 8 deletions(-)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 968702e..fe4f729 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -120,6 +120,9 @@ The NVMe tests can be additionally parameterized via environment variables.
 - NVME_NUM_ITER: 1000 (default)
   The number of iterations a test should do. This parameter had an old name
   'nvme_num_iter'. The old name is still usable, but not recommended.
+- NVME_TARGET_CONTROL: When defined, the generic target setup/cleanup code will
+  be skipped and this script gets called. This makes it possible to run
+  the fabric nvme tests against a real target.
 
 ### Running nvme-rdma and SRP tests
 
@@ -167,3 +170,33 @@ if ! findmnt -t configfs /sys/kernel/config > /dev/null; then
 	mount -t configfs configfs /sys/kernel/config
 fi
 ```
+### NVME_TARGET_CONTROL
+
+When NVME_TARGET_CONTROL is set, blktests will call the script which the
+environment variable points to, to fetch the configuration values to be used for
+the runs, e.g subsysnqn or hostnqn. This allows the blktest to be run against
+external configured/setup targets.
+
+The blktests expects that the script interface implements following
+commands:
+
+config:
+  --show-blkdev-type
+  --show-trtype
+  --show-hostnqn
+  --show-hostid
+  --show-host-traddr
+  --show-traddr
+  --show-trsvid
+  --show-subsys-uuid
+  --show-subsysnqn
+
+setup:
+  --subsysnqn SUBSYSNQN
+  --subsys-uuid SUBSYS_UUID
+  --hostnqn HOSTNQN
+  --ctrlkey CTRLKEY
+  --hostkey HOSTKEY
+
+cleanup:
+  --subsysnqn SUBSYSNQN
diff --git a/check b/check
index 7f43a31..dad5e70 100755
--- a/check
+++ b/check
@@ -603,6 +603,10 @@ _run_group() {
 	# shellcheck disable=SC1090
 	. "tests/${group}/rc"
 
+	if declare -fF group_setup >/dev/null; then
+		group_setup
+	fi
+
 	if declare -fF group_requires >/dev/null; then
 		group_requires
 		if [[ -v SKIP_REASONS ]]; then
diff --git a/common/nvme b/common/nvme
index fd472fe..887da4d 100644
--- a/common/nvme
+++ b/common/nvme
@@ -22,6 +22,7 @@ _check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
 _check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
 NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
+nvme_target_control="${NVME_TARGET_CONTROL:-}"
 NVMET_CFS="/sys/kernel/config/nvmet/"
 nvme_trtype=${nvme_trtype:-}
 nvme_adrfam=${nvme_adrfam:-}
@@ -157,6 +158,10 @@ _cleanup_nvmet() {
 		fi
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		return
+	fi
+
 	for port in "${NVMET_CFS}"/ports/*; do
 		name=$(basename "${port}")
 		echo "WARNING: Test did not clean up port: ${name}"
@@ -208,6 +213,17 @@ _cleanup_nvmet() {
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		def_hostnqn="$(${nvme_target_control} config --show-hostnqn)"
+		def_hostid="$(${nvme_target_control} config --show-hostid)"
+		def_traddr="$(${nvme_target_control} config --show-traddr)"
+		def_trsvcid="$(${nvme_target_control} config --show-trsvid)"
+		def_subsys_uuid="$(${nvme_target_control} config --show-subsys-uuid)"
+		def_subsysnqn="$(${nvme_target_control} config --show-subsysnqn)"
+		return
+	fi
+
 	modprobe -q nvmet
 	if [[ "${nvme_trtype}" != "loop" ]]; then
 		modprobe -q nvmet-"${nvme_trtype}"
@@ -320,17 +336,23 @@ _nvme_connect_subsys() {
 		esac
 	done
 
-	if [[ -z "${port}" ]]; then
-		local ports
-
-		_get_nvmet_ports "${subsysnqn}" ports
-		port="${ports[0]##*/}"
+	if [[ -n "${nvme_target_control}" && -z "${port}" ]]; then
+		ARGS+=(--transport "$(${nvme_target_control} config --show-trtype)")
+		ARGS+=(--traddr "${def_traddr}")
+		ARGS+=(--trsvcid "${def_trsvcid}")
+	else
 		if [[ -z "${port}" ]]; then
-			echo "WARNING: no port found"
-			return 1
+			local ports
+
+			_get_nvmet_ports "${subsysnqn}" ports
+			port="${ports[0]##*/}"
+			if [[ -z "${port}" ]]; then
+				echo "WARNING: no port found"
+				return 1
+			fi
 		fi
+		_get_nvmet_port_params "${port}" ARGS
 	fi
-	_get_nvmet_port_params "${port}" ARGS
 	ARGS+=(--nqn "${subsysnqn}")
 	ARGS+=(--hostnqn="${hostnqn}")
 	ARGS+=(--hostid="${hostid}")
@@ -767,6 +789,7 @@ _nvmet_target_setup() {
 	local subsysnqn="${def_subsysnqn}"
 	local subsys_uuid
 	local port
+	local resv_enable=""
 	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
@@ -811,6 +834,22 @@ _nvmet_target_setup() {
 		fi
 	fi
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		if [[ -n "${hostkey}" ]]; then
+			ARGS+=(--hostkey "${hostkey}")
+		fi
+		if [[ -n "${ctrlkey}" ]]; then
+			ARGS+=(--ctrkey "${ctrlkey}")
+		fi
+
+		"${nvme_target_control}" setup \
+					 --subsysnqn "${subsysnqn}" \
+					 --subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
+					 --hostnqn "${def_hostnqn}" \
+					 "${ARGS[@]}" &> /dev/null
+		return
+	fi
+
 	ARGS=(--subsysnqn "${subsysnqn}")
 	if [[ -n "${blkdev}" ]]; then
 		ARGS+=(--blkdev "${blkdev}")
@@ -853,6 +892,13 @@ _nvmet_target_cleanup() {
 		esac
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" cleanup \
+			--subsysnqn "${subsysnqn}" \
+			> /dev/null
+		return
+	fi
+
 	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d63afd1..9ad9a52 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -113,6 +113,13 @@ _nvme_requires() {
 	return 0
 }
 
+group_setup() {
+	if [[ -n "${nvme_target_control}" ]]; then
+		NVMET_TRTYPES="$(${nvme_target_control} config --show-trtype)"
+		NVMET_BLKDEV_TYPES="$(${nvme_target_control} config --show-blkdev-type)"
+	fi
+}
+
 group_requires() {
 	_have_root
 	_NVMET_TRTYPES_is_valid
@@ -392,6 +399,13 @@ _nvmet_passthru_target_cleanup() {
 		esac
 	done
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" cleanup \
+			--subsysnqn "${subsysnqn}" \
+			> /dev/null
+		return
+	fi
+
 	_get_nvmet_ports "${subsysnqn}" ports
 
 	for port in "${ports[@]}"; do
-- 
2.34.1

