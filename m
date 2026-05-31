Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AD73546E8
	for <linux-block@vger.kernel.org>; Sun, 31 May 2026 09:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780220757; cv=fail; b=n5KsRD3Lh0rVWSHmIKiVSPFRmDeg778+DHjFlJvTLgBahM0vFZPqKmxLhEX0Q/LcbmzSwU57YaXedPvvfETU5dLow1vdAP4/3hrzeYfqv1EIS6VsxhJqDUhGeJrLq5M9zbfv52PzXKllJX0BBBPEF5PR/T8qj1XDW0VjhnESkUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780220757; c=relaxed/simple;
	bh=Ac8F5EO+Ygryfu4lnl93DWsAOlrTWHwzITA5hoa/54Q=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pes0zrfsNk4ypsY3Y9trFzFERvqiPocAd4cuiIOoVWDw1J/s4y7mHqfCOxvQhle6+JHZk2uoMohfgjltRlvMZJVOLqXcy0VXAgZU7mA/baR82psk3ZJwCLQMBL0HQmNWQSHyEZOYq2uYj2+GtFVjJFyOZLsfUTfP1ng9d4s6K78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qoq+wp6s; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qoq+wp6s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780220755; x=1811756755;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=Ac8F5EO+Ygryfu4lnl93DWsAOlrTWHwzITA5hoa/54Q=;
  b=Qoq+wp6s85C+fN4Nr+NOdoJ8OuKVKGWFfWSscXDBr9uOXAtTZRXufDil
   0z86PVsbxfoz5mbXlpVqOfOus1sgbvraWiA1uT0KON8suDp/yH9bnspik
   wPPfIkr9yS4woJKwBZa4CvKRXVofZWg0mcRnV41pHDHiYM429ktU+dTXt
   /ZHchBK+Md3XDfPEBNeAxH93Zf43k0bdi66Auasaf4uqSH4WhBbL1qliy
   9HG/ksMcytSOILX4W+mZCgLOnagcuANbZ5Mh0c0WAlx2HfMnri1JfyB+1
   bWkOduwzH5NsFg8biaEkT8ehua8tdJWCwTqqK00UjdecbOliVgqYjyqGq
   g==;
X-CSE-ConnectionGUID: nvnFLUsIQqm6/AaHHONJaQ==
X-CSE-MsgGUID: pzE48PRoSVeTYTv3/sphww==
X-IronPort-AV: E=McAfee;i="6800,10657,11802"; a="80977070"
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="80977070"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 02:45:55 -0700
X-CSE-ConnectionGUID: nieOpBTOSDWr63UMyIV+ZA==
X-CSE-MsgGUID: GAXKKbkqQky7A/mi1iiM9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,179,1774335600"; 
   d="scan'208";a="273578955"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 02:45:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 02:45:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 31 May 2026 02:45:53 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.47) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 31 May 2026 02:45:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihHObIooUtxWB1VHh3sfWh3fTEGOWOKw8QGlea1FISZSJHALh42TU7k0mu8WhGsLRAmHV1FfoKxb76lN9r1SgHHgSWlULKEYqg4iAEsimYkGOdx4Jdwc6hJ+G2S5lb1jL+WOJA5cl1qSSIXyJsW3Z5kkj7SGpLgU4cF19IWc5wCjupnTVdcFbJsHCDe8W055y2ndRSuDU92IkEOkL3t4SGmyPCNGLVUUsG7lin1Py5zyD9gbVxO4JOIX+iTUMU9nFY66we2/hYK3woeE3ufRKft6OlvpweUAFkE88DdU3E9hAD1zrpYhVQFhPYB8KFD5czKsiWVLqIp7NwpmAkNU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMH4c3xmez7L+lnaSQdkGveBO3uSSlYlROnZ5fqqkwM=;
 b=M9lzQ8Xv0414+HsMxFpc3WxFKhH22x3irE3+g+D23et1/VHvoYz9Y4ajGzt8Y2nkQkyT+v0NRfFZTj8CeQueCmZQC+Wj2yoJ9ifrHvViMkBuiLes9USlbk8PAEBLeSbH7Sj8Ug4H3wSNvnnNuyCDJvhYN1LPrncRmiBGJF/foZSkIMltPpq9EpsTcdQouvK3CZswLoOtefCoqu3jRgXml+PlF9J5+7rWrz4aRNiKrgqfNXO71fOOjgFDm8tAGetwtHp7IZwQu+ZkO5wZFtzhYepIvfO1rrup9xNMjz8Mk/4EDAHryJtav2vmhph/LhaCfROz3VVHV3kgeItRkJ6W5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by SJ0PR11MB4799.namprd11.prod.outlook.com (2603:10b6:a03:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Sun, 31 May
 2026 09:45:49 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0071.015; Sun, 31 May 2026
 09:45:49 +0000
Date: Sun, 31 May 2026 17:45:42 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yao Sang <sangyao@kylinos.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Yao Sang <sangyao@kylinos.cn>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] block: stack zoned resource limits
Message-ID: <202605311745.77820afc-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260520091237.392802-1-sangyao@kylinos.cn>
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|SJ0PR11MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 42705945-60b2-4fe4-5039-08debef96543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: v0US0653E7b3EgGAmcdTWjTVAUWlgOtVfRGJVyQL0FhXROENtmp0D1aHpf0G78/nRPgtY3k8GropYjlbBkHFNMa6XmWrHhzhVr0LTSG0DUEuf3vG9SmLI6W0O41pZ9n0nlxWqqXOk21l8x/XC46bLpEWU2wKsOEMbSLiSdxUeTRsSBxSP0bgvbopHCaKDZkqfzqhICpClUmihZN3eICoqyunc5hzR/atD9KdjMi6Z9wU7qrXdx8Et6MAfmfOAgKkenjVJMaHl/N4CaysdoMqKU4ImKIre5vAHQIbc5J36ZF4tBP1d5trjkxOQkKiu7tDI0xUvhrmqy3Vreg/k5nduzIOfzSpfhhxCkaj3uOheC/tIvpGRpf0FlON+AnjBz3aE54UNa7pZN1itLjbanVvBuRneMqGNsnzHTxMNGxtrq39xJEUQIirThvkq72lT2GBJlBMyzomj0q3oU0KDqiB4QEMHghRWJaaUFpWv17fhuMaBNTNtg7UyOfpsnBShQvhnVNIrgHbpg2Twr9RcC7lSbI6OoqMsNW90H2QVpd4ub5ic4j2NgkU+XQSd9NQbHeCsgLRGx9xg8nuLe2ysAHlRl+kDW5ELCaTpDQtWC/ejd5R2kT4dDhRniFoeztu7N+V1KgtFnOkjvktFv0CwmSxLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+9A0Lfz2KEFi4LY9WVPZ7aeH1GQwidJ9+uIBUvb88bxipsyBqRtFyzCkisaZ?=
 =?us-ascii?Q?p+h8mILZ7hRVUkz4By8HzqEouFsq9H6CeeVE8c9ZvmqiAgVyy+DvtsI8Mzqi?=
 =?us-ascii?Q?ZF7KRqetveJSNRold8ETglkDK1LS7hs6zdpanH/EFfMmWnstPBupT/lfDtB7?=
 =?us-ascii?Q?SdSEYiD89bc930SBXXbisNyRbvKZ7YC+DEswRLGMQhk7V+D/HUyMY39Xo2QC?=
 =?us-ascii?Q?Q072kFQaYE8xk79YwtcM2J74VXyVnoG/bPE1RgJQ1IVcd9tSow1jWq3D+N/D?=
 =?us-ascii?Q?DVAj5l6IJqtoSX1WFwmuKYLiGbk2UIGMo1dZ7ZBJblBeXHZPAMu1igwExbB8?=
 =?us-ascii?Q?vbSm7O8IHCifhgR8PkHEYVdnFKZeFQihnilhjdANNDfojBtICTjbpdLy9Oql?=
 =?us-ascii?Q?6txq/bmFD+fatNGExzS/w96edu0N4volVfDdFKSY/yB+3u9gaBgDC3/IgqT5?=
 =?us-ascii?Q?6VkZ6MXH4Iawhrl2728yxqiZxOLuGCAGhgqedjOLWw7qmnLbO9Owa4erqrTr?=
 =?us-ascii?Q?jsJHzUNG3aOoS7srGgbyeyKg1fZfl61eSbWWGkxscntC8S3GBDhBhvn/h6qu?=
 =?us-ascii?Q?GAH5Dp6O1p5EdiCh3BLhaipiNP5EJBUgEYJuM93aoQ/Ane3ojRuBFLLaRpNL?=
 =?us-ascii?Q?5wto1x9McmHgcJETvkgMWCVuVqmW4GQ+DouTUtZ1HbUFETJ5FAAfHJ+hVBX7?=
 =?us-ascii?Q?mTPUd8MXEXCrhjaZP/yAYv9ZsOK8nrhgYK2TKzfdiqQZy+kX71t6CRxkTAp9?=
 =?us-ascii?Q?a+4amLMJzNhAQpBiD7WV/YuPm1eYq7MptZ7SqKBE0NN//SKHk3W1JSH1JWO9?=
 =?us-ascii?Q?ovXg2XXZLeibekf0A7fJJQFBd30ji2KydyPMuCkcaIQZez1SzMCUfPEJERRD?=
 =?us-ascii?Q?di6thOwNxmi+/Beoy1ObVr3bmqQe2wDl07VT0xgTVhc+Hgad/b5Q8xoXiQd+?=
 =?us-ascii?Q?WyIqBTVR47PazM5HOaxeTzGh2omCPEjtnE6KcUntqmQhDXH5pQ/HTsKmPyOX?=
 =?us-ascii?Q?CNf4jRAZVD8FQJvHSueyy1U622hihy1MmP8nAvdx0oK/A/9lKifzZQSry6Hj?=
 =?us-ascii?Q?3tDeXnbCROYgkemHBmtdM1HMeDb8UokEtjB+ytYqbguek9w5dF/J1C73udYt?=
 =?us-ascii?Q?Tu62ibKo72q8iLy6TaRTjb3/CU6BywhIjuaWUXAjq96QqQ3oYC58TTx8jq9j?=
 =?us-ascii?Q?sbhktfQFoU0SsI9f1D49pWdwbLj5G2tFvBphH86BgUefCRWeOEpsDB6L1prQ?=
 =?us-ascii?Q?zOjFnrPU9/KXae8EwGMCg9Nl+PAToEpZQujgUovI1gCKpyafmmhADV6U6Aqt?=
 =?us-ascii?Q?ZhW9iQGhE93pV3gAwQyfxKlVtoOnO3RJC990NPyRXgTOhR+jFcJBtnWQsWkh?=
 =?us-ascii?Q?RF7I48D+3VhFTIDKyiaopDIOsqz8eR0Ga5uvjMf3Xls1TZx2gyGXo3k10RkM?=
 =?us-ascii?Q?cjmjm/MGr/U+EI3B87UZD0ZP3PffMizPiUjIt06JTbPu2XUL17vIlos3nEyu?=
 =?us-ascii?Q?vSc+RKYwynPPn5JPzebG1a6RXRn4/qMHwtyjNRwU6CQTVibm1EiG/dKrBSrN?=
 =?us-ascii?Q?szpFSLWCgVn+gz2M3FASDH1en7HqlweE5vihyDzPgbe9b0x0eYNl36YKzvC5?=
 =?us-ascii?Q?854IFRl+UWq6K8eSXFgBRfanRSXqeXEU0LYY3oKV4g2I1og+gGBVQQyueRgg?=
 =?us-ascii?Q?3o5BA8FXiwndTUQpbYSFZy6/8eh+tORBelCPmHEVmwqxgGMv2+35NE+/08RJ?=
 =?us-ascii?Q?NRgePOcdeg=3D=3D?=
X-Exchange-RoutingPolicyChecked: LAXQ+8EsBBNqoA/rXyaCXQQoKSNsmZXNfN7EONJw1K2ypjNJHsfcRXKpq6X6cuxb65+ewATBIv7S++eMTdPQvX6rxUTOMVCrcqMdDK5Q6BbYog0jOT+nsGqOkFccVEEHKIMmhU2w+w/piDc7qVSPibP72smZN+Sod7PUSKC7au6D0Cr6ZQok8M+pbF+bcrchYeD0DS+bdtGyesa9+UDROFe8PpSF4OasNpheSpL/VeLxGql7eFW/S3AODi/guwGdvq0fq+Mh6iStEvaszTNUelO6Qz2PjxUkTRdLi6Qdc/F7deYwOrVtl8dbJ7sRhBlDivnrrRl0hT3VwwghsYHCEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42705945-60b2-4fe4-5039-08debef96543
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2026 09:45:48.9840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RfEsUXvihdvqqiJHoLjEG+9XU0Tujwg3CjLRMQLc5RKyVlvO01Fkl4aXZLIqcCEKB0g/rmTmqjykrlI/g7UFVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4799
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.zbd/011.fail" on:

commit: c17db973b5faf59694eda2e4ea164b29b69c8973 ("[PATCH] block: stack zoned resource limits")
url: https://github.com/intel-lab-lkp/linux/commits/Yao-Sang/block-stack-zoned-resource-limits/20260520-174028
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-next
patch link: https://lore.kernel.org/all/20260520091237.392802-1-sangyao@kylinos.cn/
patch subject: [PATCH] block: stack zoned resource limits

in testcase: blktests
version: blktests-x86_64-9131687-1_20260529
with following parameters:

	test: zbd-011


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605311745.77820afc-lkp@intel.com


2026-05-29 09:25:41 cd /lkp/benchmarks/blktests
Defaulting to policy_version 2 because kernel supports it.
Customizing passphrase hashing difficulty for this system...
Created global config file at "/etc/fscrypt.conf".
Allow users other than root to create fscrypt metadata on the root filesystem?
(See https://github.com/google/fscrypt#setting-up-fscrypt-on-a-filesystem) [y/N] Metadata directories created at "/.fscrypt", writable by root only.
2026-05-29 09:25:47 echo zbd/011
2026-05-29 09:25:47 ./check zbd/011
zbd/011 (DM zone resource limits stacking)                  
zbd/011 (DM zone resource limits stacking)                   [failed]
    runtime    ...  6.852s
    --- tests/zbd/011.out	2026-05-29 06:56:18.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/zbd/011.out.bad	2026-05-29 09:25:54.319411071 +0000
    @@ -1,2 +1,13 @@
     Running zbd/011
    +Invalid max active zones limit: 64 should be 0
    +Test 9 failed: Map 32 CNV zones of the 1st nullb and all SWR zones of the 2nd nullb
    +Invalid max active zones limit: 64 should be 0
    +Test 11 failed: Map 32 SWR zones of the 1st nullb and all SWR zones of the 2nd nullb
    +Invalid max open zones limit: 48 should be 64
    +Test 12 failed: Map 128 SWR zones of the 1st nullb and 16 SWR zones of the 2nd nullb
    ...
    (Run 'diff -u tests/zbd/011.out /lkp/benchmarks/blktests/results/nodev/zbd/011.out.bad' to see the entire diff)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260531/202605311745.77820afc-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

