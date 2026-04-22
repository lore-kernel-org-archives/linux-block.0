Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95B3ED13B;
	Wed, 22 Apr 2026 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867703; cv=fail; b=r5H0JTBecRb0vAlaHuKSzDDO3uZFYzuadY2dR+08LvMJZ/oQNYPts0Eg5jzLzU3HaYcVSjjQgzBCxojcEmf6vGsf15QAen5EwiG1ZaIB/pOKvIDF2DKMK9bypXq72NM7S5SANV/mw9p+oLOORbPkUwTUWAi0cJpoTsrPlJXOcoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867703; c=relaxed/simple;
	bh=mS5HCRxn9SdHMI0VLQx6nQ6Otsqf3/2IxkgUFN6EVDM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=BcJXiE+RRQ/pqLL56nA6OKOH5AYckVQ2VHd1Qh00xTJd3bqHQGs2kQxAivSGWSohGOHa03exohlWNnkWZkw7ZtLV2x0Y7lZ7yt6e5TwIeasPjLMFgINSh/J/PKLPfBV7vKfWB89lrNihRUFEpGKtjLaGOVrFrjNSh50BCNd1OT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8Hkqa2K; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8Hkqa2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776867701; x=1808403701;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mS5HCRxn9SdHMI0VLQx6nQ6Otsqf3/2IxkgUFN6EVDM=;
  b=Z8Hkqa2KnpYKOgxVVcfjXmIO+inYZmhzfXqeKJ4Xq9NG36YCvODDJSSp
   ng/MvcwsNzax2OZwML/LZBSknNJW5K8n+KiuMgV9bHlTFlZ29MO8c9tIy
   X/5gpCnZ10QwMMutS1lhiWvnYP4fZZ9ceDRfoUPnC51tufITxVwN1v0qf
   LlCUKtD3lORPYtyzJ+NdxCksJhd/aFwhiyI0SXo2GHark4UiBzaN4RMLE
   8VfLCelpAuB5H9eDyEM8mhdAH74aiCevDGVvhaPz1vgZZ1DpmiixJ87ze
   n+s41SS1wQEhun/+1nTL4MuMcafMSM3OSWRvJ+BsWPIYtlEDElrYeRmke
   A==;
X-CSE-ConnectionGUID: xu6GUaCtSiG/8WwOoEkjSg==
X-CSE-MsgGUID: QPXBSt2sQh+I2WqZy1iXvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="95235042"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="95235042"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 07:21:40 -0700
X-CSE-ConnectionGUID: 6Q+oKJXhTjqLKkkhBKSumw==
X-CSE-MsgGUID: PWA1VsDkR2Ka3F+np0fxyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="227785906"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 07:21:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 07:21:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 22 Apr 2026 07:21:39 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 22 Apr 2026 07:21:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6hceUhsz1aXhDy6ukMiHEMFVchX8a1FvPvXDL8+fIkYBrOZnrEXXUZUYo/pA6wnLC1u9krgmCE90pJmd/xnql5h0XkCH5hZU+SVx0lAkGqUKaGGNZ2EeK+zJtzbJCedYv+IWHTvrsDMblMu5zx18uZZ//8ie5xqWHC667me9R4RJcgU8j+QKXy6lDc9I8+qEsis2S9ecF9YjR1+3Z6osXI8zKRKC1lWtwaDZG4ceZjS8D60K6/Ds1oW0hWd8RfFH/IAWYXvBXW16CI2SdR5X7ggg0Jo+LRIAHmH+cQcnlxHYpFlqYVhZLr5nJfV4hMXGsK/6vY9aQldVGFiUKm0YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbBAuJrIc1629az7c3VICQLVQGeCnliUDVFgVzUuNNQ=;
 b=eerFHWRD/3OWOxudEgSmPsdfPt7XlgBn8tI9Wk40GL8oxYrIgrIUTjqaSZmp9yzZz/nQkr0uMmlIR4GQ2F2/DPernvVM96m6BGLG2q/qODjr9CIDnpEsyD6XhZ0sxU9SYmtXzuvD3J7O9ACMgNYvYV3xorz/nDvyjTLVs/5f/FGBPMV3TEbc8efwa5p3gK99qeD8i2+g7UL/svMoob8JHM5T3q7wL0otpMTHVS0TsBcdME0yUuTBY5Mc6hUHE5rJZfDsMBTTsDtKf+FyXmTCJEeSYGODdiR7PEPvVVKZ4eKHnB1vMu9dm+2B50m6fBBNhkcrLv9i9NRzUiYgfHWrLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 14:21:37 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9846.011; Wed, 22 Apr 2026
 14:21:36 +0000
Date: Wed, 22 Apr 2026 22:21:28 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  b520c4eef8: blktests.scsi/002.fail
Message-ID: <202604222222.8ddedd9b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CY5PR11MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: fab85403-30e3-46da-f343-08dea07a762c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: SYLDIe4mXARLz4bs2VSMQpLgLFyULTpD7E+4wSLDl5IVa4d4c85QpOcMODd9Bo+1X3JaPiT5+f7bU2ygC+SG7FX/Wg2j+oMDpYpDzZ1NlBUP4dkH1gux73QpAOzLxybHFIOa8XqXYfBLkj3ca6xnJsnwcgKX1oRH7t1cZZsG3PX4PZbTVfwi3Zsmj1TI6NnB6VgtgV5LlkFwPtOgiswR+4DhnQodrqhm8C4e0npM8IUAmHzcuGZ9a+07sQ/iZGwRvco8f9S4itfAa0hRUAeYVbiaVp4gCkZm5I++wf/VtGuKQjU5H/6iDDfZBRtKFEF8q2ZbpYwW4GIrhA/7HKbdKcQfOjWwyQA5Wmzcsf1UU/3ziqWJ20lQJUWGLRFCVzxcqUBDkpQKE8g8A1Ynu8reH6vDFdrQAKSlY6emi1klgKUR9xkesOLHCKHrBhB+U6VSVtYr4s0DF9vw+0U2kyd0OhRyBtw9Phyl0TEInXO4B6u4ecKskq3xNPZla96j5pf+06kcoDDIB0q1yQ+rXaYA0ZRiE7eF2NXmsvFxVrss41qaSWLhUagSpTevHESM3g/WXBGsf8WMrFkMWJBs+JVYtg50KIwpe1PzHfB4R3ECBV06CnzMdBEJBGyuqibSCePDju9YHQAedVk8z1+Bd0vDykNlL/4JipgHBidy4Y2y8yGK+BBe6ZUf6rcMokIA1YL7fCdB/Zm8b1DnQaTLcBGGYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jz7voxSy1RLV3a4SpNBrm7DVEes0QQXbNzziE6wE6z9GyrdYX481jVMwPUxx?=
 =?us-ascii?Q?nuvkyIIRPOFbG29MHoVZATFLb8AiJFlPPOkiSKbLfmP1iTBj4U9RtSweDLmh?=
 =?us-ascii?Q?irgSOAheIAeZdK74DTGapyT/yI9KKHaco0imGEvqsbY6YhhYFebzQeYSlKXc?=
 =?us-ascii?Q?axUEOO55yyAQOBp8ZMHmdmmn0u1Z2jZMNkzKGzF2XZ8J03tJibsZaZx8svkG?=
 =?us-ascii?Q?rIluyyavJNQfshQPuTq95hSq1E/qJCPS1ruIT9Ix89pz4lNtlaoHKhAG2Jw5?=
 =?us-ascii?Q?LviIT5x0maxw3oxD1ArNbiJg6uMasFJGvzCeUIfMiZsDRFQa5Y9iv9WZIHPm?=
 =?us-ascii?Q?p8M6fBFd5ivicLdJYSqCvj0kOSQ6MSw6tZOmidI8ubc3zRImlxQuU3a7RLt5?=
 =?us-ascii?Q?31SQ+0EAEG1X2cQSwOboze95wYkg3y1i6IATzq//O6j5S67QLbCg3RYo017S?=
 =?us-ascii?Q?w8vp3k0b5/JUxgqtYB6OLeRAcSV6R05xuYGwxUDsj9K2gd4Ef5GWPiJDpLkG?=
 =?us-ascii?Q?4XraZ2eC3eT0M6K3i143mDylylLRYUkbRiLSeETBNawA1Kns2qciF9V8OIxv?=
 =?us-ascii?Q?DpA05nnsfxmPukqjzf4Ii82PtOu0bjDyKABGTeTYVeBJyMKZ2J+gPCqCiLoa?=
 =?us-ascii?Q?Tj/QIL412ESOrP4O6ywsc/OtyhDkX4v66dAtfMA3DYAJUuB6RcwRiFWcQxUa?=
 =?us-ascii?Q?PoDb9povBKeqnJiPlVH1Ikgt8jQk/0xploILk6Wa0JHieCv9NIijdZc9cn/V?=
 =?us-ascii?Q?mPsCkLYWEMR3LRsKVQ7B3Jq3peZ0KRDhCcZx5go6j4Rzs0jiFM/guDB6Kfjy?=
 =?us-ascii?Q?346LmVjUZrUhdzeP2+JGUibvAgqGlYHfEpcJZFM9+ByxL1j8/sbVzgj/fKdr?=
 =?us-ascii?Q?eey2gdYWLJs6noc27+9W5eFiSo7Ck8rsciSAI4zfVXDeUk8oE57NyxwVdUmO?=
 =?us-ascii?Q?OiYNPKs8KqHYXbel0lY9LVObnUuZ6r1A0XFrMiah6/GpcCMwnBdrjA8hzaS0?=
 =?us-ascii?Q?hbytb2cvcBAYdkWs3MP/GHn0kcIw/7KGTdZTGyoJb/976jV3VgwfBsm+qBNL?=
 =?us-ascii?Q?+vit5FRqLumZOYu2/Z9Ubiqhn6yoT85djcl61HcTyQbKjxilVYkOmiNxL7l6?=
 =?us-ascii?Q?8zhhjfngJ4U8YrPvSvCdPBX1X6u+nAG9m40FDLNiBaWLPNI4EF4O2DzRCIKG?=
 =?us-ascii?Q?aU0rE6mDKatBZS00wcjA67ZFlV0ngna0HGASeZqdLYTPjDI508ahaeOqy2vu?=
 =?us-ascii?Q?K6sLQJfPIeqZmROyCWa6Jz6SJEvx8G1xgQEg0YPBAtsIYO8UMft8V2kpLRUr?=
 =?us-ascii?Q?lCX8FgxqYUnnRrH7lGXsQfA7YLgUqcWkfDIKdLLk0Bg3ZATPXTjfptkyAtfp?=
 =?us-ascii?Q?57bKGv9EPhvuNZqqcRpUQ5QwK9DeAky5tESNlCsmxr3nI/nK92GC9GeaWyEr?=
 =?us-ascii?Q?Ext5m28PpqRSV3SnEs8xXQEbFx4202GfPhMjGss+B8QIa3i2cP9czeDSsjy2?=
 =?us-ascii?Q?i/Xbb8PcHc/r+tQj0LQRds+mZfXu+o4u5ZjPgMmOSqqyl5cvJqxXfVioc3Tk?=
 =?us-ascii?Q?EDFy7NWvtdnsEkxEZGap5bO7nVSAPZFrvzifUa2Lm2ZJgQrFnYViENyS+qXt?=
 =?us-ascii?Q?fYuEOiSVfofNCio21ZOVMocvdNyXlNkk/Zaqeacp7BPbx3/9h/f1LdIItMSG?=
 =?us-ascii?Q?WWPL5KMCmdymQadJXxu/SZqy5eymZWfM0cx8qb1MNwMpGj2eSn8BoNdLsgM1?=
 =?us-ascii?Q?Z8U/kqsIsA=3D=3D?=
X-Exchange-RoutingPolicyChecked: t1d4jdLC+HefvmK0lb/YsJK+Zgs13JlNLVwijRKwV2H8s9UCggmCU3u5Yv6MPclFO6rxvV9jT+4QZBw4GTFSIRGrbGAD7tAkDDd5KyY7Lu1qlrZ/Fb7mnigELrHkuzUvpt8jBupsBNjuRkipWnwje2yChRVvVvvspFpZH/yRjDqoPz5PbSG7iVapXgajxHwCyapiiQXM8/sJViIV5DLMEu4HE5IWpMwAX2/1pYD6aKtHMa15L9B79rlQci3+a2xCO9YcF01b/WlGhN7S7/2cht012dwFzfaRzN4rS8J5Qaj5ioQxLlFTCUMHAIueQDq6KsOtNeiPEO1DAV8bwNOunA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fab85403-30e3-46da-f343-08dea07a762c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 14:21:36.7826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3Yy+k0XXp5xV/k/O7Gwr16Q4FrJIFECE/DahdINiSCcfUJ20S5ZXAhc0N52ZmRckB8Bv1uwpSoIxOdG4XtiGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com


Hello,

kernel test robot noticed "blktests.scsi/002.fail" on:

commit: b520c4eef83dd406591431f936de0908c3ed7fb9 ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c1f49dea2b8f335813d3b348fd39117fb8efb428]
[test failed on linux-next/master c7275b05bc428c7373d97aa2da02d3a7fa6b9f66]
[test failed on fix commit        67807fbaf12719fca46a622d759484652b79c7c3]

in testcase: blktests
version: blktests-x86_64-1d68a36-1_20260417
with following parameters:

	disk: 1HDD
	test: scsi-002


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202604222222.8ddedd9b-lkp@intel.com


2026-04-21 09:29:51 cd /lkp/benchmarks/blktests
2026-04-21 09:29:51 echo scsi/002
2026-04-21 09:29:51 ./check scsi/002
scsi/002 => sda1 (perform a SG_DXFER_FROM_DEV from the /dev/sg read-write interface)
scsi/002 => sda1 (perform a SG_DXFER_FROM_DEV from the /dev/sg read-write interface) [failed]
    runtime    ...  0.016s
    --- tests/scsi/002.out	2026-04-17 08:24:43.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/sda1/scsi/002.out.bad	2026-04-21 09:29:51.412382400 +0000
    @@ -1,3 +1,4 @@
     Running scsi/002
    -PASS
    +write: Cannot allocate memory
    +FAIL
     Test complete



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260422/202604222222.8ddedd9b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

