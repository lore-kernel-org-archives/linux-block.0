Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520627D3E2;
	Wed, 24 Jul 2024 08:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808959; cv=fail; b=uO2xdy4hM+ZexyIPo6qjrooQnMkOVO+KN/mVHCflUJI6O7sq7hWIFplrJ32+8nD5cjdSxlWtRa1zlgnDUTIm6/yqtQS2jvsh4AFCIAbGFx6iFACSS+QkzvITea8rEhQI0ZYbFEWdl+jRSwitO3U7yhitmM+7zG5uk3OybepwjGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808959; c=relaxed/simple;
	bh=YJeqgby12SfSZUYf9ezFGkPwAuSiB0tTySMIQA27Tqc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bxmNalw0pwtj2748LmUSM3RUNYdplA95rShROtSLwDzIi3o0lrzwbJKL/zUkeYBctVViEfOvGMTQ1fY7+xQ0X0FaHQBre6n1rpE3LCc5CC1gSSJzNrkWEM0IHzqCC3ewG+8lQAktP4mGztPCcNmn/AzKqhWGQmh2hx736jt+r2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=acSKWvEt; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="acSKWvEt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721808958; x=1753344958;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YJeqgby12SfSZUYf9ezFGkPwAuSiB0tTySMIQA27Tqc=;
  b=acSKWvEtNdczoWgMhARyQE27rH2jS0CDkWZYy7Wo5/I3aeQVeikpRLEO
   UBxxteNLMDS7Mz9NdXYxEwgeeWHIvMQ7JmqXgF/Eat2muWro6P0bYH6Zv
   kElHPHnUugyxWhOvWOaI3I4uodikNOfNZFVG6kwnSRK4vm0P3BSAEwcK+
   zJ10mfmUXK97CCwRNEq0Fc4oGdETs6+YeK10uh8Ibbo+IsFdp4BbQrMHZ
   X4Lffs4KdU1Oi+AGt0VDbajkzXTRPHKvwrHuGQjG1np15gPfBK8B1RqGN
   /zU9AOw66hKjme2spgCfRfY7RaU0lkm1E3pAje/BZErTGFowrd35Gon4b
   A==;
X-CSE-ConnectionGUID: HS6H/B3iQyGmmcIcmzgsKg==
X-CSE-MsgGUID: Nd5wOX3PSMKPQVTK+LywSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19280741"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19280741"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 01:15:31 -0700
X-CSE-ConnectionGUID: 4mbCvxDiSCCXbxiWpufRFw==
X-CSE-MsgGUID: rzeE+iPrSuubvYBhYOrThQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="53279655"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jul 2024 01:15:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 01:15:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 24 Jul 2024 01:15:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 24 Jul 2024 01:15:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 24 Jul 2024 01:15:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLLY282Ohw6n3oos3zIpnLrxroLJq5HUe3G/4+08iZcbGYEDpkg/5+3K6L/tQvi7bGI0bP0bbuo3OOxf9GGZldsDvKAHiE4dgRb7yRtRAZOj31QYuwb3Zp1ruOVRbd3z3xunq0xnsyetcHJSWqAZyhwB1gvY09489HQsFJILtGyieSuj9/ceagmwkCGc7edeHlrke/Zq+gbfqq6i6YDDiaYhiiG+dYCtY8QlV45bnEPWVFxlI4a2J3E18MXbHwZvsoMRGqPcVfBASu3OYo4curxpbLVE1ZIxkJ5d/XotjDk48vtT1XgzjsTx46HbxbaJnnNPhJZafnga0gn1ZVWQzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p75LFyiQuhD+0BAYO62xxARw2oE0VFPPZai3NRxuYdk=;
 b=jvZcVMAnY26YxFiWhW+cqpEc8PytTAoAN2hsqqBSsBXwMc+zsIT+z1AGEkAWnCXb4/wxA+zLxd860nQLY37p9ogOmQ+p1TgFwiGu1HoZlIaXeO52uMl0NuBVdRLYu+b0ySMq+H6rtDo1JkegAR9/eh15uN5xQoOY8Tdr2BZRrAAUyB5UONThZRVpoiEfqhE7dc9ZVy7qsEl8u3qBzW0hWDBEGoXxgW7cY0HynE2OaBkjJNfyX/f5oA5GKZKEQgJwEcGnSd5PtIzQBVEb3Eoye2psILR4+A8yriauEAlkC31JToqYdjiObTYR5MdEvIHrGy8kzyLp4zcF7kfoEYoFPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CY8PR11MB7874.namprd11.prod.outlook.com (2603:10b6:930:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 24 Jul
 2024 08:15:26 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7762.027; Wed, 24 Jul 2024
 08:15:26 +0000
Date: Wed, 24 Jul 2024 16:15:15 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yang Yang <yang.yang@vivo.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Bart Van Assche
	<bvanassche@acm.org>, <linux-kernel@vger.kernel.org>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [bvanassche:block-for-next] [sbitmap]  e992c326a3:
 BUG:workqueue_lockup-pool
Message-ID: <202407241556.b0171c94-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KL1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:820:c::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CY8PR11MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: eff6041e-8535-4e36-05a6-08dcabb8c589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xe9EpUgeJ3OTDwuZnaKc4hHqh1KqJXDTTG/2QkuKdFCBpITIhA2579lTn2iy?=
 =?us-ascii?Q?aWvzO2ArQEvjizW8we4210TL0Woh1K0Qu5aMvxsqvqdSQEvgXRXA1uROk+PB?=
 =?us-ascii?Q?oy/gxx2klhV3NKWWAkIus+5SHhn433LJuTYgAQAo5T/u7D0vtZs5mJ/39fJG?=
 =?us-ascii?Q?LRexNkpq6sEseqnLfXzq6+1h/yoY46BzviBX17mdrux2i/4UOichiP/DwTbB?=
 =?us-ascii?Q?mRLVpb82oj3v8MgHvWQFY1kTZ1V09lRBkWmUSjvjU2oaSnh9nLGeyB8DWrqP?=
 =?us-ascii?Q?AyuLHYpgeU4zvuhLHm+upIMZC5sIuTmMEuiaDXO8WS3ktgAilBKsMH/B7m2O?=
 =?us-ascii?Q?8bpv/abrBDSwXc88n75FoSe2ReFR+GZ6G/6la/9AksSrcvCOaYXHTdgoOGx/?=
 =?us-ascii?Q?25y30yl0LI02/pRzLXnBGi4n+hDkZswc1nrJStFCsdFbD7Ou0olv8R420mt7?=
 =?us-ascii?Q?AiZjNXW9cXVNfh62POlJv/PZBMyUufxUIt/59UuwX79PzEyzzI192Hx/88jj?=
 =?us-ascii?Q?1yEoFqz4U9GXCRwsSNHJYcbvbuwEmFGBsq/WDRVksIrMWZhEEH0ft5JIkobm?=
 =?us-ascii?Q?51AjghbC8uVwAMY7vqEojnGZiHgmRT2bAIj4NIOnikfYm35TZNBWwm7B0N/B?=
 =?us-ascii?Q?gusx9PR+nnqFGEzBYNILgNkVaRygATrncbZCe2qnZoMt3VZuusIjB0FDrbBz?=
 =?us-ascii?Q?ympELN4Hd3WlhWFDQGIcOQqzkdy+vDUzMykL7pUxdRAnfIW7JGPLVf1BNXoY?=
 =?us-ascii?Q?hC4ejzr7iDW3NcCKdeE3GVOf6FM7TaVKQdiypKS6K69Fn7Bfg9xrqz5+HhUx?=
 =?us-ascii?Q?LkxQDJSBdZr5SN63FpR1Yv5lmvh32wecWRfOPLdAgSCqQAtfYroeCJtdmFrs?=
 =?us-ascii?Q?fVDk9qstuCTvTRdnOXvgB8mJajlKx14Au1L9BGF6CTBJiF3zdow8oFK3kdwG?=
 =?us-ascii?Q?n6XFVNb3lvY38RMIDedHn8m4b1dlXFNQM+057l/6ePqy/w3Psl4mJrbiXHES?=
 =?us-ascii?Q?w46rncfncMff5Rno1t3i3eSDMg+IlkF6mALf2O8s47HFZSX6tqtZKt7a2tBW?=
 =?us-ascii?Q?Y3J3kFkDFrA5tZxFJpu/+3z2F4A4PhPKG01kDWj2ZgkNEXkI6gej24zTF5Ad?=
 =?us-ascii?Q?nP0qyhWUZVEWf8OICEfylsD7irhT4ft0Nbz8e1A0rfsQQgkP0qfqvsVg0Vev?=
 =?us-ascii?Q?t/5BihFxSy9aZbO+MAxPDm+M6bpbNX54BlG0RyJQP3inSUgkvHJTo/WPuBdM?=
 =?us-ascii?Q?pxNUbcGNoGQ7omYCplxAv4uld7NEwRb/A/Ffckt3RZcd4BJa27Ke6/jScYKo?=
 =?us-ascii?Q?6sOKPq1JtP9NzFPY/vfucLcu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DGRhI+Om3CK5CuDMNVYTl1y3cCwI4z4iu54zHzHshze7YWXUsjG8TdO8jIpG?=
 =?us-ascii?Q?g430GYKcwhfjUeQ/g5+fjL1k0GWXd/Z5085EwgrMqxhhVY/VxeXTkCJDBL5G?=
 =?us-ascii?Q?I7An4mO8pluhaAfhaAOVqCydh6AvPQQTJ6ealIb+WdezUgvrx3sDN1LZ9JaX?=
 =?us-ascii?Q?TGdTDvFMTK/ou529nt2jzPjXQpR2LVD4yuWAWwgjRpkEkYFVKoReEot26QvD?=
 =?us-ascii?Q?oPSmLVrlGCv8d3rcAe/yDx0EOqnRAB/Mx5GBJdlbENbrbckp5ONDVkTjkeOJ?=
 =?us-ascii?Q?L9b/UE+PbIExi30A85J5bviZFGWf8yFV9CdfbpzqPxNVZ6wwvIs4cZkCXwa0?=
 =?us-ascii?Q?34Ed8TpvEpKaIctyRZ3BKcPCoOgOZUS5pA28JU+kPJDMOb8XJXPcz2bqEYwu?=
 =?us-ascii?Q?/ujsBH11PVV4v7cb91k/jlYoFNKPNRfh5flO0RtXCYLkG+AU34u0daftIgr2?=
 =?us-ascii?Q?l2p5VbBKXVSIQw4LVsgJQ482pWAW9hCan55Ytn0zVB8mzkB+QLCEnGod2pkm?=
 =?us-ascii?Q?LG1jGIycpOQydmZRuycaOMtj4FSHH2JCgmZAsQWpM7uHYYecNWKAa6WlHWPP?=
 =?us-ascii?Q?IU7RuuCpWOiGVh0zjvNVlN4iw7LN20aQ2Sra6veobdEvpglCE8lbPCx2nUD6?=
 =?us-ascii?Q?SjXWubblDXUoiRzTU7xAtGsJFbZLACGBra6NlXkl8DqYbkWJq+vONKZz3Uql?=
 =?us-ascii?Q?fA0bUZDfPGP8LpDAiOdyvl4OpaFnCyJZtu372QtBGxNLIaWC/RJpyLvkuGuT?=
 =?us-ascii?Q?90iMe9PPPhgTDx670ynJUHB50B5zOopVQowox4AsKqHW75CtiY6HgYwkN+P7?=
 =?us-ascii?Q?84SXY4R+07mUzLvPJow5MRBSSkKgi0aGtjzo5ziRyzkOIsTC+h+iqUos9W0X?=
 =?us-ascii?Q?qvo6bB9hPlB0XvNnF8s9BVIRYaS3Uni38QCd2G7epcRdPCh4Z0DIjx2WO4hs?=
 =?us-ascii?Q?53YPYFefkNV0H7jSsnQSSu3yziAvq5pPmY4KpuzIdp6A5ktsAHvivoXfDteV?=
 =?us-ascii?Q?09SuxPl+pBD/ivc8qnWct3l1lhpFCqFFcTsQxpnBPOMbGucmBe05/zyGesqh?=
 =?us-ascii?Q?NRWJOJrSx4n5mAxm3jJVLdRFNwrYd7O9EOPWe/xzMopAPzqf8MDL5QPiA4Bq?=
 =?us-ascii?Q?PTYStjzM7Sy+a00YGetPGDMr36nQdcuWIKl9W45BaQFtVUAp6AEpWTZtJrcp?=
 =?us-ascii?Q?ZHLBKDweH+j6wcNWb+ZHchcQyv2/guELw/3nP45oaOvLrInA4zq5yut7Ek/k?=
 =?us-ascii?Q?d4oowr7WGeohg26NiOcPVG2leZwXGDAq6T7UjpRXggB1zX/EFd1CdUCSyxU/?=
 =?us-ascii?Q?jsuyKHuU9mDYUHIQ+A5EFW4R3bC12ZmauEXUaL3vTJ4WorWwH+ysrWOuo8cz?=
 =?us-ascii?Q?UyzoU27xtPsAWGIqjkwIc0hPq7zimbnyuMDu4jeynvs4JVdWNjWgxuz7lIdW?=
 =?us-ascii?Q?v/4iV96jx2rEwZypuZoxxnmyezsV2rIggSJWApX7LUeSgJDzfsthbF3vTG69?=
 =?us-ascii?Q?O1KhKR6itnyIb7A2OYMB1/13Ny/0qxGdJ0FVMJ5VACR+sRgOh5VfyFQOMnQr?=
 =?us-ascii?Q?hLATlPigjhAH9K8CUz4a98fwHpzPQpYATyE/B/uwAPO69lWQXuCmBU5aAe6z?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eff6041e-8535-4e36-05a6-08dcabb8c589
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:15:25.9479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArI4PYlP7ux5rL6hGKuGMOo6i2sZvm/9Z/LxtEks1rrr9mF2ELrT+YAnhXFHbTQoUfgnQfUIbwObse1xbjl8Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7874
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:workqueue_lockup-pool" on:

commit: e992c326a36a35afe13a4c16094e2a76a90ed5eb ("sbitmap: fix io hung due to race on sbitmap_word::cleared")
https://github.com/bvanassche/linux block-for-next

in testcase: boot

compiler: clang-18
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+---------------------------------------------+------------+------------+
|                                             | b0c61a9e6a | e992c326a3 |
+---------------------------------------------+------------+------------+
| BUG:workqueue_lockup-pool                   | 0          | 10         |
+---------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407241556.b0171c94-lkp@intel.com


[   64.765231][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 43s!
[   64.766333][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 43s!
[   64.767306][    C0] Showing busy workqueues and worker pools:
[   64.767861][    C0] workqueue events: flags=0x0
[   64.768319][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=2 refcnt=3
[   64.768335][    C0]     pending: e1000_watchdog, kfree_rcu_monitor
[   64.768392][    C0] workqueue events_power_efficient: flags=0x80
[   64.770225][    C0]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   64.770228][    C0]     pending: do_cache_clean
[   64.770249][    C0] workqueue events_freezable_pwr_efficient: flags=0x84
[   64.771967][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   64.771976][    C0]     in-flight: 26:disk_events_workfn
[   64.772005][    C0] workqueue mm_percpu_wq: flags=0x8
[   64.773657][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   64.773660][    C0]     pending: vmstat_update
[   64.773697][    C0] workqueue kblockd: flags=0x18
[   64.775275][    C0]   pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=2 refcnt=3
[   64.775278][    C0]     in-flight: 27:blk_mq_timeout_work
[   64.775293][    C0]     pending: blk_mq_timeout_work
[   64.775376][    C0] pool 6: cpus=1 node=0 flags=0x0 nice=0 hung=43s workers=3 idle: 40 1001
[   64.775391][    C0] pool 7: cpus=1 node=0 flags=0x0 nice=-20 hung=43s workers=2 idle: 859
[   64.775400][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[   64.779459][    C0] pool 7:
[   64.779465][    C0] task:kworker/1:0H    state:R  running task     stack:0     pid:27    tgid:27    ppid:2      flags:0x00004000
[   64.779480][    C0] Workqueue: kblockd blk_mq_timeout_work
[   64.779493][    C0] Call Trace:
[   64.779504][    C0]  <TASK>
[ 64.779541][ C0] __schedule (kernel/sched/core.c:5411) 
[ 64.779563][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543) 
[ 64.779571][ C0] schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6823 kernel/sched/core.c:6837) 
[ 64.779573][ C0] schedule_timeout (kernel/time/timer.c:?) 
[ 64.779580][ C0] ? get_page_from_freelist (mm/page_alloc.c:3431) 
[ 64.779588][ C0] __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
[ 64.779591][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543) 
[ 64.779593][ C0] wait_for_completion_state (kernel/sched/completion.c:266) 
[ 64.779595][ C0] __wait_rcu_gp (kernel/rcu/update.c:435) 
[ 64.779607][ C0] synchronize_rcu_normal (kernel/rcu/tree.c:3935) 
[ 64.779614][ C0] ? __pfx_call_rcu_hurry (include/linux/rcupdate.h:113) 
[ 64.779617][ C0] ? rcu_blocking_is_gp (include/linux/kernel.h:? kernel/rcu/tree.c:3894) 
[ 64.779618][ C0] ? synchronize_rcu (kernel/rcu/tree.c:3985) 
[ 64.779620][ C0] blk_mq_timeout_work (block/blk-mq.c:?) 
[ 64.779629][ C0] process_scheduled_works (kernel/workqueue.c:3253) 
[ 64.779647][ C0] worker_thread (include/linux/list.h:373 kernel/workqueue.c:947 kernel/workqueue.c:3410) 
[ 64.779652][ C0] ? __pfx_worker_thread (kernel/workqueue.c:3356) 
[ 64.779655][ C0] kthread (kernel/kthread.c:391) 
[ 64.779668][ C0] ? __pfx_kthread (kernel/kthread.c:342) 
[ 64.779671][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 64.779688][ C0] ? __pfx_kthread (kernel/kthread.c:342) 
[ 64.779691][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   64.779704][    C0]  </TASK>
[   95.485253][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 74s!
[   95.486737][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=-20 stuck for 73s!
[   95.487606][    C0] Showing busy workqueues and worker pools:
[   95.488179][    C0] workqueue events: flags=0x0
[   95.488650][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=2 refcnt=3
[   95.488679][    C0]     pending: e1000_watchdog, kfree_rcu_monitor
[   95.488820][    C0] workqueue events_power_efficient: flags=0x80
[   95.490632][    C0]   pwq 2: cpus=0 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   95.490635][    C0]     pending: do_cache_clean
[   95.490669][    C0] workqueue events_freezable_pwr_efficient: flags=0x84
[   95.492426][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   95.492429][    C0]     in-flight: 26:disk_events_workfn
[   95.492527][    C0] workqueue mm_percpu_wq: flags=0x8
[   95.494193][    C0]   pwq 6: cpus=1 node=0 flags=0x0 nice=0 active=1 refcnt=2
[   95.494196][    C0]     pending: vmstat_update
[   95.494265][    C0] workqueue kblockd: flags=0x18
[   95.495840][    C0]   pwq 7: cpus=1 node=0 flags=0x0 nice=-20 active=2 refcnt=3
[   95.495843][    C0]     in-flight: 27:blk_mq_timeout_work
[   95.495858][    C0]     pending: blk_mq_timeout_work
[   95.495950][    C0] pool 6: cpus=1 node=0 flags=0x0 nice=0 hung=74s workers=3 idle: 40 1001
[   95.495977][    C0] pool 7: cpus=1 node=0 flags=0x0 nice=-20 hung=73s workers=2 idle: 859
[   95.495983][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[   95.500089][    C0] pool 7:
[   95.500106][    C0] task:kworker/1:0H    state:R  running task     stack:0     pid:27    tgid:27    ppid:2      flags:0x00004000
[   95.500132][    C0] Workqueue: kblockd blk_mq_timeout_work
[   95.500169][    C0] Call Trace:
[   95.500195][    C0]  <TASK>
[ 95.500259][ C0] __schedule (kernel/sched/core.c:5411) 
[ 95.500304][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543) 
[ 95.500320][ C0] schedule (arch/x86/include/asm/preempt.h:84 kernel/sched/core.c:6823 kernel/sched/core.c:6837) 
[ 95.500322][ C0] schedule_timeout (kernel/time/timer.c:?) 
[ 95.500341][ C0] ? get_page_from_freelist (mm/page_alloc.c:3431) 
[ 95.500363][ C0] __wait_for_common (kernel/sched/completion.c:95 kernel/sched/completion.c:116) 
[ 95.500365][ C0] ? __pfx_schedule_timeout (kernel/time/timer.c:2543) 
[ 95.500367][ C0] wait_for_completion_state (kernel/sched/completion.c:266) 
[ 95.500369][ C0] __wait_rcu_gp (kernel/rcu/update.c:435) 
[ 95.500399][ C0] synchronize_rcu_normal (kernel/rcu/tree.c:3935) 
[ 95.500420][ C0] ? __pfx_call_rcu_hurry (include/linux/rcupdate.h:113) 
[ 95.500432][ C0] ? rcu_blocking_is_gp (include/linux/kernel.h:? kernel/rcu/tree.c:3894) 
[ 95.500434][ C0] ? synchronize_rcu (kernel/rcu/tree.c:3985) 
[ 95.500435][ C0] blk_mq_timeout_work (block/blk-mq.c:?) 
[ 95.500464][ C0] process_scheduled_works (kernel/workqueue.c:3253) 
[ 95.500516][ C0] worker_thread (include/linux/list.h:373 kernel/workqueue.c:947 kernel/workqueue.c:3410) 
[ 95.500527][ C0] ? __pfx_worker_thread (kernel/workqueue.c:3356) 
[ 95.500530][ C0] kthread (kernel/kthread.c:391) 
[ 95.500585][ C0] ? __pfx_kthread (kernel/kthread.c:342) 
[ 95.500589][ C0] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 95.500636][ C0] ? __pfx_kthread (kernel/kthread.c:342) 
[ 95.500640][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[   95.500679][    C0]  </TASK>
[  120.705227][    C1] rcu: INFO: rcu_preempt self-detected stall on CPU
[  120.706866][    C1] rcu: 	1-....: (25000 ticks this GP) idle=71dc/1/0x4000000000000000 softirq=2935/2935 fqs=12477
[  120.712272][    C1] rcu: 	(t=25002 jiffies g=2261 q=805 ncpus=2)
[  120.713520][    C1] CPU: 1 PID: 1601 Comm: (udev-worker) Not tainted 6.10.0-rc6-00303-ge992c326a36a #1
[  120.715344][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 120.717321][ C1] RIP: 0010:_raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:152) 
[ 120.718629][ C1] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 c6 07 00 0f ba e6 09 73 01 fb 65 ff 0d ce bc 10 7e <74> 06 c3 cc cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc cc 0f 1f 00
All code
========
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	f3 0f 1e fa          	endbr64
  14:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  19:	c6 07 00             	movb   $0x0,(%rdi)
  1c:	0f ba e6 09          	bt     $0x9,%esi
  20:	73 01                	jae    0x23
  22:	fb                   	sti
  23:	65 ff 0d ce bc 10 7e 	decl   %gs:0x7e10bcce(%rip)        # 0x7e10bcf8
  2a:*	74 06                	je     0x32		<-- trapping instruction
  2c:	c3                   	ret
  2d:	cc                   	int3
  2e:	cc                   	int3
  2f:	cc                   	int3
  30:	cc                   	int3
  31:	cc                   	int3
  32:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  37:	c3                   	ret
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	cc                   	int3
  3c:	cc                   	int3
  3d:	0f 1f 00             	nopl   (%rax)

Code starting with the faulting instruction
===========================================
   0:	74 06                	je     0x8
   2:	c3                   	ret
   3:	cc                   	int3
   4:	cc                   	int3
   5:	cc                   	int3
   6:	cc                   	int3
   7:	cc                   	int3
   8:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
   d:	c3                   	ret
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	cc                   	int3
  13:	0f 1f 00             	nopl   (%rax)
[  120.722091][    C1] RSP: 0018:ffffc9000027fa60 EFLAGS: 00000247
[  120.723180][    C1] RAX: 0000000000000286 RBX: ffff8881335dc4c8 RCX: 0000000000000000
[  120.724696][    C1] RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffff8881335dc4c8
[  120.726162][    C1] RBP: ffff8881335dc480 R08: 0000000000000001 R09: ffffffffffffffff
[  120.727782][    C1] R10: 0000000000000000 R11: ffffffff817cf120 R12: 0000000000000000
[  120.729356][    C1] R13: 0000000000000001 R14: 0000000000000000 R15: fffffffffffffffe
[  120.730936][    C1] FS:  00007f213215b8c0(0000) GS:ffff88842fd00000(0000) knlGS:0000000000000000
[  120.732680][    C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  120.733960][    C1] CR2: 000055c76ff83708 CR3: 00000001482fe000 CR4: 00000000000406f0
[  120.735559][    C1] Call Trace:
[  120.736328][    C1]  <IRQ>
[ 120.737025][ C1] ? rcu_dump_cpu_stacks (include/linux/cpumask.h:231 kernel/rcu/tree_stall.h:374) 
[ 120.738036][ C1] ? print_cpu_stall (kernel/rcu/tree_stall.h:702) 
[ 120.739012][ C1] ? rcu_sched_clock_irq (kernel/rcu/tree_stall.h:?) 
[ 120.740040][ C1] ? update_process_times (arch/x86/include/asm/preempt.h:26 kernel/time/timer.c:2487) 
[ 120.741048][ C1] ? tick_nohz_handler (kernel/time/tick-sched.c:187 kernel/time/tick-sched.c:306) 
[ 120.742044][ C1] ? __pfx_tick_nohz_handler (kernel/time/tick-sched.c:285) 
[ 120.743092][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1689) 
[ 120.744101][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1818) 
[  120.745084][    C1



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240724/202407241556.b0171c94-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

