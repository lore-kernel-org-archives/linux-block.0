Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DA68831
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653565; cv=fail; b=Hxpn+T1UopbT/Bc7Ic5Oe7c2C9U/lUwPxekE9EJmv4AWaEh9Og1JYLlw2+bZd2OMXMERGf+/Y2yESMnFia6TnLJ2U6BkwqYkWRfjS0PR5AOOBc9xdyKbPUfbSd5Tfso+0p3A3quyc7wnk7jQiai2wedMqiHe1vQtg+HORe5rRDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653565; c=relaxed/simple;
	bh=HkswKXsX4n/TV3/4xFI1A/Yhn7Pg4XYpt1k1vKOiInM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jZdi2SAQ928G2fnUeTiKhPuqgDpPw3NwLt27Xg05V9PxAHAZ5dkgeGKgHzjrOddKeUVmFSWuzEmgTb/lu0lXsDD/VN9aBjzmtH0TGQOIi42kZCYG4i0bewQrAUSF8Te6Sd+qQI22+NXpY3mYN5DdtmBJmLQjfjjWkfnyI5f/MFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fRduTeck; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fRduTeck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx6BTj/3LgpGgGTSDskURPykwbTv5o4E9cB3xzNqNfYL4YfPQLBATj9i8k70E8NaoasRGIYO8YNPBgbkppzHADTutqWPBtKogAjs8xEqP23ePkXTv0Er0mxlXZyiTfEjIdZZk3KrSUKks6Q7Azxkhk8eYyhyJnUvz04/yTM7NnL7i3ZGBNZMNAxqEDjSdDiJD6Zk+RhRuXZYtzmMyCO97OefDe5nxOIbeWsNJ8h3tIw9eMfAv4ZnoOYE0dUyX/SlBGcWZw1VEj74lgtuovZC7V7YprA0DLvU5ma1SKeBIQEVpcW27+RlSPMRRxBGYUwwNd5H84TYZdSJsu1pe0lnAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxKygBA0P/LeMs5Z6lamze6bcYNcPYtoc6VfKYwVbg0=;
 b=hcqubHDQTNgR3RsQ2ByroDWm2GXjUyNibVEYC9PE7HxDfwdmxbuU6iEjLj9O+7vwnwR/2bP2TrYqd/fXPhYo6rE7AMrjU9Y9OSx7UfaB0/22ktIBgkx5ToQTp9ulUe+Jj9rK80nAGONOiV5j5tBiwF3HIY7W5iF8TSu1eaK8VcCs3RGZdrXKjA2zP6I9iESsDHPFw/8xAR4+C0WE+8TwspQMjolVebglFM3FC6+qFAuxxvyAnphEL+k2IHPGUSUpQ1eBSzBHe57utQ+NOVVAbk9Xe+UupP6VPjcINQByCMFki2LUf2J5y6CadpegE08e6qo+z0kPmIo8SBIMqexHbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxKygBA0P/LeMs5Z6lamze6bcYNcPYtoc6VfKYwVbg0=;
 b=fRduTeck32wje+63V+QZBy3iCk/qArv5jl2kPNRlNynV/VgdzQSyJHhROZuEGNS/eqsaWyUif1PLHEi1hUWdjlUgH+aziBiB5idqILTjaaJWP4mF17JgtWEbFuneUI+xykvcxGQ+cqsg2IpSeAmLbQ9sCoIK1KJkHEMRCIgKRHgFCwv0RSuvjmuSEZTQMngWumUY1o2TwYsC/OYD+c7Ng/dmW3eJH4nB9oRBDmQ9vxbgqQw7ulZ1XwiR3hOqdHkuVUmpFixVrZgBS62YuwuEUG7ZUYAPdhaIDS4Yg0FUX+0Fu8HEeww5KFt+VxXt6qRFM4Jv/J8oYuXDIZi+bfvIsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 20:39:20 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:39:20 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 1/5] nvme/rc: introduce remote target support
Date: Tue, 26 Nov 2024 22:38:52 +0200
Message-Id: <20241126203857.27210-2-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126203857.27210-1-aaptel@nvidia.com>
References: <20241126203857.27210-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0193.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d254c41-873a-476d-f851-08dd0e5a6797
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y20xE3Qwe7D4pFO0OoyWLY2ccCrreDyNpTksZGgClSZG3mGaTmqt25RQwXy0?=
 =?us-ascii?Q?R2bMa9PnJPJbmJOI5WE855LMW7fotG00BxyQApjnnFD9JSxUbFgyc2KJl4Lp?=
 =?us-ascii?Q?byaUr5FE05vr0wp2aV6MjEZuaQcFEymjHwaBChTwuKyMAWe3JGcqJ3qJxiqM?=
 =?us-ascii?Q?I7zs3oKc/73Q2MOC+/ER8k/53FVly1iypbmAA3Tqr0DbZyci3M/4XG5XOOSy?=
 =?us-ascii?Q?OoRIjKqXKuttamNP534itbCWjuUSiEMbBYTLAuArHLUb+NFHJ2xpPg6I4IPl?=
 =?us-ascii?Q?iJl9krX6cA4J8hRwIt6hIZThsrjf2Ne2pzGJAoBP8TTymyOMQPV9wH4Hvs8E?=
 =?us-ascii?Q?w1sdux4p0H8tiQiqwgapClyXzlFYiMNa3cqYpphCCq21C808SLRDfu2sPXVo?=
 =?us-ascii?Q?1F1nCR1p+jhO4JfdOnxQROKFvBfmzGLIJ6MYJzP9ne3eI4GjYf6CB5k+hEKL?=
 =?us-ascii?Q?S8PW+NVGDi2CiSZ4vZG4BPrSywOD1Fyqmb+dIqpvY0dTwY7d2STo2sM8lqw/?=
 =?us-ascii?Q?Vx6tNpLoPR9ULInhbFfUf3hZ4BEUXLAWHrBUoL2YwMqjObwdg8yC7I9pDY2s?=
 =?us-ascii?Q?SeA2wCfFVq2D4OTQJ+rRn0xCJKEmW8dfKNYiYUEpoPvWJrNRFHVsGmF6d4/C?=
 =?us-ascii?Q?60g2c3uD4yEM7HOkB1UutVRa/T3jLtZUMHXOIgdaa7eI9QlY0eYPS3Kxl2U+?=
 =?us-ascii?Q?4etPs0g9U6ZCObTFzeAns/h66TcY7ZwvgY4jydlno34vnVNofPxzYU5flUNq?=
 =?us-ascii?Q?Ut2uQscXf6+McSPhve78zBe/wyWG3vyszH8s4Ea2wN7/NU1ZhNyoDo4n4JgZ?=
 =?us-ascii?Q?6D1r1oS4SxxuJU8mgpNx5WmuYSPMSZC2f2/Pl+9ucfvZ4t01oYz7h0NF6b44?=
 =?us-ascii?Q?2lwlImN5bv3MSn9XduikiD4ZsSnGS2Ug7XpgBrHpQV0xwDpWPScmdJUu2uxq?=
 =?us-ascii?Q?eeyNQElyO13DZRUCoyxvhc5/kyvEq0AxtsVfRkpHmNan3BDmEs2MV/4iOwOS?=
 =?us-ascii?Q?610qJj4YDFlsyFdI/Js19XMfmboTtMhEfgOyHajveBpbcXpQJKDackqRpeGr?=
 =?us-ascii?Q?zhGvjge1IIvWgGvNmVnCg/EmZnS9uc3vWgUCtW3PsFFvL6tkLCliKodlqyYU?=
 =?us-ascii?Q?b/5wXCzO54vw53L50p5pypR0vc4W57Wq4mv4lVFfm9odasCb5lOFhkO1t1xO?=
 =?us-ascii?Q?AUW9kqvTcq3cjIQmXF5ZW/jDpitzJuuGqBFaEBPPp65xk/vmvRsh1fUwHiy9?=
 =?us-ascii?Q?tJx2XvfV+BDgcqnOCiEVcBPuWC3XKPUK2Cux8RVH8rYjuDuTRe6tynU0ydHH?=
 =?us-ascii?Q?sGjRlZrlsyB4uFVRaqynKkUasiwJhw4GvCHNkjfDc8e28w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KgqF5Mum5JhkJ+aIOYHtSKXOaK6jCByIbEpkr1i+++yLHiQDRMeqzT08IdYN?=
 =?us-ascii?Q?L7gxvAy9nTSaXbTFLeKDYTSlsy8m91oUcD/ky6xk+qyhlq/oDoUJatMmEoAv?=
 =?us-ascii?Q?Zyx83pVNtWRFlFQdRQcVzLyPp7MScXctAombhUwrFSswfmmRucwS0c/RElcW?=
 =?us-ascii?Q?XUiDJX8sCjA4Xp+VB3D7GxcTGYUtasb7po1cY4eF5WmDTvsVBy0SOr3aa/uh?=
 =?us-ascii?Q?aMiAAK1sV9Or/gwZ6LhGfw7/54eWWnbQ23hvAG+u2Pzhlt40ptlGV5baPLx/?=
 =?us-ascii?Q?UzFmwuP9W6swnuBUqLDZ+17duAPuYJJI5U5QmQjDwM3+YGyke+reyl8rN/3Z?=
 =?us-ascii?Q?I0Tv2/5GuN7XkCmYmGWGWtKNSKWCPpVIZXCjagefZ4TLVcaga12kBMIGcq/X?=
 =?us-ascii?Q?eMyxQISj16wxnmUuPiwdHuNE5Xq6O2L918SGsUWhp7roMFN7A+nABPw+/O4j?=
 =?us-ascii?Q?QGqn72U3SjOtVAHUgBI6oy0Y6m7dzO1PWrNQH7k41UiyI6d9FSB/If77JL8L?=
 =?us-ascii?Q?MUjw+vpo4UQVwl3+Qc4sNzldmQrjt6kaUHd6nEdLyDomZJMgJXyEIqyXQMrH?=
 =?us-ascii?Q?/gX4BcqY/G7NQ43ZIGPw8nYOMuqhMiGnhCaxkq7ym8xiHf1DJPU7p1m3yjPZ?=
 =?us-ascii?Q?iuifaBDz4DzP1cMqfdC62FRNPC1ZpphlDq5MyZbfRQT30ma8lelWGz76mIeZ?=
 =?us-ascii?Q?5t96Mk+pYSfe1ERM/7KqDcrmWo+GUzD5wF6RYtBKJAS2bBb9URElsqgTRYen?=
 =?us-ascii?Q?viX6Ig1tH1Di1m40ApEZDP449VG719mkJ40UX4qacbCsI9nbtteAIN0rOlKh?=
 =?us-ascii?Q?O7zflxHMySWWCSOB9QVlnq4ZsYHLCNeBIRqn/VhzZnx3/ZuLxXx0gx2d8c+p?=
 =?us-ascii?Q?1kKe1R+Zaxcn3e82E3bIkkT7qDiIqVB3pklElZ6tLduLhUCeFhNQZBEM3r4E?=
 =?us-ascii?Q?F5hpgJQdHANqRGheQo31Lt2TT49oy3lRmS758DAunbw1k2OE8V7+tmK8dj1Z?=
 =?us-ascii?Q?E7+nr5MzfU4AGgNJkcDNTNFFAix4ep2w9ovgfTzy1gV6mkxW3ukURu65nqiG?=
 =?us-ascii?Q?dcUWgnYyfZpGpUI86cELpYIJJo7F5ScuJUZUtybfOa2o9L5OcSSMTJkPr8/N?=
 =?us-ascii?Q?kC/pYheLkkHQ9TfJpL1NrsY+tjXJobgS0+O9IbNW3h3hh2YN5zzaEbYibYwK?=
 =?us-ascii?Q?iFgRCd/f9duObee0y6CexDyULhVAzFjk4t2ZmWxmVl2I8syGfIg6pryGpG9y?=
 =?us-ascii?Q?Px6RllSXBTQyGAJZhQ82Fc46whoxZ1eIgD7LX2wSlFKf4uaRnc2CL+OI1tKh?=
 =?us-ascii?Q?buybUbgUulXnMuSlw27BPnnhEGXKg4nBsjd3slRNCzpw3EyAMaq2qfvgaAwe?=
 =?us-ascii?Q?cj8pGAt2RAzb9ovWs5Oe1uS30LVQrlNwiOoxOLZYMdD7sC22XMGlWercD4G7?=
 =?us-ascii?Q?MdiUkN3JoBxbkVr2eKazIWhdxigpmPi9Zxn+tTgc3xlEYfJe1JVq/TaSJJJc?=
 =?us-ascii?Q?HssWdPUUoO7uSZ99NxrgN7Xu1jpZWo8/nZJMxhpMjDkdxSzw8ZBwqAaPcdrc?=
 =?us-ascii?Q?iQe4GFsJYd2wXdcx5TygG0Mv/zhdeg4045stWt8f?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d254c41-873a-476d-f851-08dd0e5a6797
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:39:20.7510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sRoBOFUr2ATCsW9NLyFLRAVQoV+P7h1w9wwZtbQrxeVue5Ovd+6Jd7knl7Pd6xeQKQHpfW/F0iGlZ3Y1vS9IHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

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
 Documentation/running-tests.md | 33 ++++++++++++++++
 check                          |  4 ++
 common/nvme                    | 71 ++++++++++++++++++++++++++++++----
 tests/nvme/rc                  | 14 +++++++
 4 files changed, 114 insertions(+), 8 deletions(-)

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
index fd472fe..f99af5a 100644
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
@@ -208,6 +213,18 @@ _cleanup_nvmet() {
 
 _setup_nvmet() {
 	_register_test_cleanup _cleanup_nvmet
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		def_hostnqn="$(${nvme_target_control} config --show-hostnqn)"
+		def_hostid="$(${nvme_target_control} config --show-hostid)"
+		def_host_traddr="$(${nvme_target_control} config --show-host-traddr)"
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
@@ -320,17 +337,23 @@ _nvme_connect_subsys() {
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
@@ -762,11 +785,13 @@ _find_nvme_ns() {
 _nvmet_target_setup() {
 	local blkdev_type="${nvmet_blkdev_type}"
 	local blkdev
+	local ARGS=()
 	local ctrlkey=""
 	local hostkey=""
 	local subsysnqn="${def_subsysnqn}"
 	local subsys_uuid
 	local port
+	local resv_enable=""
 	local -a ARGS
 
 	while [[ $# -gt 0 ]]; do
@@ -811,6 +836,29 @@ _nvmet_target_setup() {
 		fi
 	fi
 
+	if [[ -n "${hostkey}" ]]; then
+		ARGS+=(--hostkey "${hostkey}")
+	fi
+	if [[ -n "${ctrlkey}" ]]; then
+		ARGS+=(--ctrkey "${ctrlkey}")
+	fi
+
+	if [[ -n "${nvme_target_control}" ]]; then
+		eval "${nvme_target_control}" setup \
+			--subsysnqn "${subsysnqn}" \
+			--subsys-uuid "${subsys_uuid:-$def_subsys_uuid}" \
+			--hostnqn "${def_hostnqn}" \
+			"${ARGS[@]}" &> /dev/null
+		return
+	fi
+
+	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path)"
+	if [[ "${blkdev_type}" == "device" ]]; then
+		blkdev="$(losetup -f --show "$(_nvme_def_file_path)")"
+	else
+		blkdev="$(_nvme_def_file_path)"
+	fi
+
 	ARGS=(--subsysnqn "${subsysnqn}")
 	if [[ -n "${blkdev}" ]]; then
 		ARGS+=(--blkdev "${blkdev}")
@@ -853,6 +901,13 @@ _nvmet_target_cleanup() {
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

