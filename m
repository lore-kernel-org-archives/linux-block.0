Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2058831
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 20:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732653555; cv=fail; b=IALAw/WYTQ4HkkweSCe/hm4MEPSxMEAUX5HqFMbg/RGTABrW0Yz7sedD1G0SgXsBtYGqPyf7HuDNJKdAveu4jcVyznonL+DeV0mk89fE2rkYuxTlop4TmpWgVcA7yqWCHGcXjH9r/vzD6tfInKlQSlYrY24+zqJtwC8ujtmECNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732653555; c=relaxed/simple;
	bh=jW7A/HdVbmuC3q5MAQHgexhwFwvWd0BU0wA5W9OjDuY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XP3bqSecXUCm3BWOcnYbZtEuzM+JI9x8RNeBClGlF1RgFbqmlE0vCrE1A3vJFDNtynTSgWbyd6w8XGmKCWjURsUdWbjjqL7A+WZxVqtmCK+CIDgOPXEd56/YNoUZQtLPnpSHvFeX7fZcKH8Egp8xG2F47GcJoavqfJXlcYVFVBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qz0mlNTF; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qz0mlNTF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0R7/FTS1JnOyRnRk0gcOQytfxce6oDi9OOwXgnwe3wHigbNBXQYNOol2sN1MYOXYquPQLydbCd/hkjkmKziKChctMgeL4GLM9s070JhNi0SsLsN+1E4TluFZrGqIAT9ZFUgk4SA+8X4Tc1BWd6pCKhow2PNIERA4Civl3vZEPbsPV9qjnqjFc9APSULz3XG6Ao4XqIXJQEgBWpkKDrMbau2SkV3m+lA1p03HoB4CCD8ji/DR1QbiTOrj3kYCh7RyNCJeacn2mcqQDWjgDLHRyQtu3mvw6RY/ZMY6pOOBEtx/ay45WV+r23cVUnyf7Yw2Sp38/OepzbDqIru5+E3ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EGGGGfbTmb5dXnXfNeyAeAM8LFJkQ4qrM7bJFzgnzg=;
 b=GEYY0bSEneweYuzH2zcBa1tN+IW8LxkTVrsmvfORllIRhuun5Z+2sMODTzmuWWl/rhsS21B0bAdC9Uf9J9c9wMNSf55Nqz2Ye7zhERGhpFU5xP2O+OdQBKfcmkOIxTB4+bJciiBbFkOf2nTzq46UPP/O6VwIJdcL8cKOvKowgVghH29njr398O1DgnBv3cKCEUWd6EH+qFKiUzed6Grk9wao269YcsUdwwWAUweiQ+mcnreURrU1uNQSXta14hxz7GtgaOYzVr2Z6EdorvVl/rUz1J/zNuMSHKE6TxjPOXCF+iGheMJLmvoI6FBo4rgs4sMHJI6pnrNTsgWpEu0Nxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EGGGGfbTmb5dXnXfNeyAeAM8LFJkQ4qrM7bJFzgnzg=;
 b=qz0mlNTFyq1Y5aL8X48Lltdesyqg3fAVVXjzZ0veRUAfxzldtHwiTkkJ1s/T1CtAXbso+JaSW3t38HuaIUMO13fMPsPEssRMBZcUkb+1KnIroK0zrdS+UZThWO8/zjSyGgCO+o+DPnO30cz6gmX2s05w0Xmc/IRgU/lKQmZn3wTvL8mL4FM8wz0Wy7EC5ccifyKQYuJA6dKMRmtl7NNQYUH49Wm9YYeMP+5XiUjAcVDReSxzO/TtD76QNCl6O498qzGDG8K3idD79KuSLE3DSdcGRzrV/+2p4kF/OSf7AActIq35aQgRjtwgAnCR9g1TpDrfhF6MOR60/gIumKjy/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Tue, 26 Nov
 2024 20:39:10 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%7]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:39:10 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: aaptel@nvidia.com,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shai Malin <smalin@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v4 0/5] Add support to run against arbitrary targets
Date: Tue, 26 Nov 2024 22:38:51 +0200
Message-Id: <20241126203857.27210-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0206.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::15) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ffa773-b4b6-4d9d-f80f-08dd0e5a618c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QX2WF+ENiXrx4LGTLHKFvt4IZR5pdTQsu/Qtd6U3jvxGYSIeNzrTjGml7F+D?=
 =?us-ascii?Q?0cEx/iVKvt3UJbVF1CcK9RGzoEvYYR3wdQzipokyGnUHU4qM6Yl+bMXvZhPm?=
 =?us-ascii?Q?oMHqJnvaBWLq5loEo+ylBqmTPOopIFYvuwDqwLKoIO/EZhqC+qfRrfGndOL0?=
 =?us-ascii?Q?IjmjmVL4gJ+BWWMTOFRdEjkCjJQdCLMrX4DmnP/nQHdmxQ2umONuekerh/G0?=
 =?us-ascii?Q?LEQPrfUEuiD6CrUu2QBYIROJwweW2nmnWM3C6zVSIBZA1YNYfBvOJr0Bb80C?=
 =?us-ascii?Q?XA43MzgV95RL2bvpdtNi3ZkRQGnwGqrY85XhJ9ykVnSETb5FIfWt2oG+kmLz?=
 =?us-ascii?Q?smuf/bPaJBnh78ozJk/BRtCb5lOvZ/q/B1KRuV8K4cX4NnejTJLUZfH7E3eo?=
 =?us-ascii?Q?AL4e3fmW3jh0uKg/AobQend9U0dqkvpcHH1lYtzjKAIzo/u8/1Joj2y8q+hJ?=
 =?us-ascii?Q?VloSkNm32tVhhAnjordZKPWXbdO1X6bZYsZtkeYXqBUoHU94Rxtqkj77FGIY?=
 =?us-ascii?Q?k4FCT5d6MnaDRieSquR2JJJNKzTr4yUs6yk98YiiKaEfWtBkpuiY0VLTViDg?=
 =?us-ascii?Q?JhdV4nfGtv2rDWDhNqqj/v4eAlKqbYtacaR0sCIu9f0tf54iGbKRh1CTLIqP?=
 =?us-ascii?Q?YtBilusE/4KePFXBg9XTLAJd+SVjg5IpijRfucOozWuEllhzl0hBuCziRGNf?=
 =?us-ascii?Q?7FyN0kY8pCVphcDI93gyeegAM5ayEj7mx4Fq+4tt6Oyv5N8rGaKjv9D1EJQj?=
 =?us-ascii?Q?WIHp0STYE7Z0Gbfg/hlrQah6MIGDSuBhU53qnpgmsdqrQXL1bCAfZLbB/iF+?=
 =?us-ascii?Q?bVbwhypwHLOGoxd9JOX5aAVSxIK6CDqlWgqC6xP+fH+i7miIuHqXYtyyqCBE?=
 =?us-ascii?Q?N0ld7YAPGh2CNU+XP33LSB6ogsoLugarWposL2ya5DvOtqo+DLYMkb/UArU0?=
 =?us-ascii?Q?nCZeYwG8o2JQ7hWpLn14uXdnNW+ZLFGEZWrc+YWSK43MMp/qvdVLeq3/PKQ1?=
 =?us-ascii?Q?NdQOtzUTqYL1guUjZYU4uacbR577PupnjOJf8sFi25qFJenN28yZyun8rC2w?=
 =?us-ascii?Q?Y3WEoksA+U9Uzxdx5bXwz+EpdANY+9OoV4/KVij4g1bEZZg/ljMEPUeIMpwN?=
 =?us-ascii?Q?fmVRlziorpqLzh8cPBFHbToH38NPHC7Tkl0yEmcAERRhJeVEnkyjPXxY0dUt?=
 =?us-ascii?Q?d/HgAKxIVwGOB2r3EWRFVyWWvCTMys1MjWIgwnuMyoqMArlzK6ftSaRWTycq?=
 =?us-ascii?Q?jFX8+abOgj2SM00JnjMrKDDp9GB+QrWxosDMSwy4/9eEUfTxSnKE0qaCqLSe?=
 =?us-ascii?Q?/efNrgQuXrdUz56XUsC2kRC2LVljQNDo//DcfCaVoYZKfdyLZIb6NFncrPQf?=
 =?us-ascii?Q?zS01Xrs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KmZcPTXF0dVQAusZSW7t4/pP/J1mBgJlFCfxrVACmJsQJCNQrZd4nSRIt3JP?=
 =?us-ascii?Q?7NWie+P3Ck+zyCbWIkq0DppkudZzNYqzxGfaNnskjpLSAOQaeoqjnZj0C+Do?=
 =?us-ascii?Q?NvG94Y8emskJWLa1oRjd1+HoZxui1xZ+JGjeG4mgINsGYmfRDd5M0M/k394Q?=
 =?us-ascii?Q?bVDO5rlyydpRBwftiNC/oQpoioL8gz0b2zL623OxqwGhGP+49PwRyAdJi7Tx?=
 =?us-ascii?Q?fxM7qd0g4TgMHxkdxwH/nUynQtot69ic2gJC27a6atTSp/gNsvz7aq3SDBIC?=
 =?us-ascii?Q?xehHIa9p7SF06tvaAprBW4Pwww9kSIcy+c2HavJuQuVYiExJvarD5eRlrO2h?=
 =?us-ascii?Q?muVVu+KT1ssOk3Yltx2I3f1IJFCjJYHGvdiE3Ojhplab3OLu3SlGIFjLYrn5?=
 =?us-ascii?Q?Q8SDAlIBvTvPMsV8AnQeT+41kEtZg0Bk7yFoXa0id8fp9n8S8mqxJH0V1b7S?=
 =?us-ascii?Q?27ddhcRkLUBmd0tYu5Erc9X6lVj143huAo/GdBrrxuGW+uMDdxmCVrFtFmZ3?=
 =?us-ascii?Q?9g+0e6TYqE5+Zx8MdvQYuehCiTWA4n6ORSzawaZUVngqGn4ZuIUE9GTQqljC?=
 =?us-ascii?Q?MdWxZWfrfZmo5Ziho2212YYV3v0PnmwBJ6uIT89Or57zqzeWIMQilnK98OLK?=
 =?us-ascii?Q?RnIZ5/EPNS85MeEI60TasQfh7OmnL3sUkIAS/tWZDY5xx6BwntFwNDSwzsRx?=
 =?us-ascii?Q?9LiRYM8Y8ztZ4JuCHKi6szkC0+9Yr8Cdv+XwtUT/QuHJf8GzRnLnK7PilgT8?=
 =?us-ascii?Q?RAeYTkm8cD0UAFbC/l6It19ixczrUgw2A923EN7afjMDE14Z6agawEcsdYmV?=
 =?us-ascii?Q?8vG4n53UxU7TuKGAGw6xZV1wxqUlGRMv6SGbuh/6w72Fg6QKLd9FY3ckGRPF?=
 =?us-ascii?Q?pylwPkf7/rycY1gn3mJRo/5syYpkrqSkf38YMOz5OaBz1w6WxLaCsQ9HdEMY?=
 =?us-ascii?Q?ViVisb4BPXjcsczrN/M1ZkkX9XAMDCeYPtL05+I9iWnb+7/tMJWPj8jIuY6Z?=
 =?us-ascii?Q?wVovpVh+Ox2UCRB3wcZiLREN5Oms4P+tv17QTArvi6KvqVykSweOqHd8zkmT?=
 =?us-ascii?Q?uKjfJ8Sj/pTXXC8qk0MGiHP0Gj/LDHOMO8QMM/ZOYgg2PXLPWm5PKZig9g9f?=
 =?us-ascii?Q?0OxiL2Ib88VjtEkJuT/JMKXgT6as5kJISvnxGWNfbJPoxoETorbBO6NMPW8d?=
 =?us-ascii?Q?fxGoK0zKrlzR4W47RHyyp9SxoYQuG2jhxa2F+DttIBF6BQGUTXC1IoMS4kdS?=
 =?us-ascii?Q?nzG0eK5Z+L0fAPdLvyXI3EL6rhT1wGoUIBf3H9JvIpYwqVOdNtvDxBLcAi/B?=
 =?us-ascii?Q?N/f2Uv7ua0wh8JyGwbMsGYiWzBh0vI37UJMn103iodX6QAD1WgEbEz6PCW2j?=
 =?us-ascii?Q?dKHWnSVxn1MyP38MvBFQf69wgxDxr/f904DkCjYLNt7CCW9lyzOBYkDv7IFx?=
 =?us-ascii?Q?hX3QUOFvW/9u6jaXPQxdtupOWAsurI5oggQ64/F0z5yOl63c1s0ZXno/S3we?=
 =?us-ascii?Q?VjmwbUOJOZ3gw7Gs6NA23s+8bsennLCu6wi+a/92RQiQt7jfFPM4Kru4JAit?=
 =?us-ascii?Q?AByjPX/dcFkDbea4cjhLqQIFWXn6a8Y/W5r7hKdb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ffa773-b4b6-4d9d-f80f-08dd0e5a618c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 20:39:10.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJVtyIydGkN+qEWp64F4tbkuD6aB1BuF2JwU+sI4ZNazTRdpRY4TIV78LkgG9zSRC6LrrZv4B1VP2sYmY2EQ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

This series is based off Daniel's patches. It is rebased to work on
current blktests. It is also available on github:

    https://github.com/aaptel/blktests.git branch remote-target-v4

The last patch adds a test making explicit use of the remote target
support by testing the new nvme-tcp offloading.

I've added a 'blkdev' setting under [subsys_0] in the control script
config to specify the backing block device on the target, instead of
hardcoding '/dev/vdc'.

changes:
v4:
  - added nvme test 055 for nvme-tcp offload
  - added 'blkdev' setting under [subsys_0] in the control script config
  - added workaround for older python versions
v3:
  - added support for previous configured target
  - renamed nvme_nvme_target to	_require_kernel_nvme_target
  - use shorter redirect operator
  - https://lore.kernel.org/all/20240627091016.12752-1-dwagner@suse.de/
v2:
  - many of the preperation patches have been merged, drop them
  - added a python script which implements the blktests API
  - add some documentation how to use it
  - changed the casing of the environment variables to upper case
  - https://lore.kernel.org/all/20240612110444.4507-1-dwagner@suse.de/
v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240318093856.22307-1-dwagner@suse.de/

Aurelien Aptel (2):
  common/nvme: add digest options to __nvme_connect_subsys()
  nvme/055: add test for nvme-tcp zero-copy offload

Daniel Wagner (3):
  nvme/rc: introduce remote target support
  nvme/030: only run against kernel soft target
  contrib: add remote target setup/cleanup script

 Documentation/running-tests.md |  42 +++++
 README.md                      |   1 +
 check                          |   4 +
 common/nvme                    |  87 +++++++++-
 common/rc                      |   8 +
 contrib/nvme_target_control.py | 190 ++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 ++++++++
 tests/nvme/030                 |   1 +
 tests/nvme/055                 | 285 +++++++++++++++++++++++++++++++++
 tests/nvme/055.out             |  44 +++++
 tests/nvme/rc                  |  30 ++++
 11 files changed, 755 insertions(+), 8 deletions(-)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

-- 
2.34.1

