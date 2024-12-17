Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B62190468;
	Tue, 17 Dec 2024 06:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734418537; cv=fail; b=kLGn3fFiZ5jP+75x5qAEIGGKIi7a6bvoEhkESZ1IRC8yCXrf9yHPZ8UKFIm9IMFyWWzPFh47VARoqx5dsF9PPzT7Ie862b/NZ4IleX+10LNc4WQWqBWKTI1LLXd4SGgqYQrdg2b+Xq9s/Br8OaXDK9fNT0vARHa/clJJrN3H7AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734418537; c=relaxed/simple;
	bh=PryhpxT+ib4u6RECdbtBO13UW5Y+yDekoJtYO/FBkBs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OIEGjpdq5l96LjDC2x/oSR6zjcRV1gBVhhd2h4t/ysZxVLCFKu1FP7tFWz3vBksMQ8k9HhcsDQYX15nu+mWwmpfHhzHxPOrhGZUr08W5aVR7THgFHiwdDNoNhYPnidKneUp3nDwCET/bOqh9heaznCEm7nZLElWtFIjGClnGWTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NTNnpFkO; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NTNnpFkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734418536; x=1765954536;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=PryhpxT+ib4u6RECdbtBO13UW5Y+yDekoJtYO/FBkBs=;
  b=NTNnpFkO5D8SaII9BlGa6BSnD/uMlL1sDUWGqau7fWC8m3I96CQxJACY
   Eakc1xmOEgm5/hqJKCihTs3c08GsnVnGgxVa1jbd92l2v0bdKhgAAq1j6
   jRA6Qwl3ku8e4ku2O0/IjM7VGzmkEnXvvDIzRusKxFvYQbuJbWQn0rc/u
   AH9ZJoBPAGr1aplVwqPRCcnNbEBHWQNIiZYGUWvCtFUMJhHy0yYTbdD+q
   p+QiXPK8lUYfzqYA6ONcINKtCr4mjy3r9NZYAiGD4FtrL2xKnpQ2vFDgP
   +CROST49TdRLOb3d8MAvxwbG+cTVN8UTFo0/ZTbvTFE23O76fYS89yuD0
   w==;
X-CSE-ConnectionGUID: 25kFnw4lRSSm9iZYhBnR1A==
X-CSE-MsgGUID: 6JOPioUETji01RpIBQXgBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="52241875"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="52241875"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 22:55:36 -0800
X-CSE-ConnectionGUID: norhqYNYSAiqncu6bkqObQ==
X-CSE-MsgGUID: 4KcHlNyMQue2zJq+YE4z9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="102532481"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 22:55:36 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 22:55:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 22:55:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 22:55:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrX+fibtvRhIdijtlEgc33viaVmVZuw0/AvZLI9sEYxwuaJqELqgQEk4YfhJG5PcLRwPd2+jtcxAYUEVEXHy8XEi6egNgxJSi+jImAR1vBHiNgxKtsRX2abta4sKh3qjAtE2jAxuJ7aGknFbPWqsvOo73q7gGephhrvsaEXwEiBpl+7tthVK8DDdynZLrApfuLSNQuMYutikfIf8j+vl5zmpqZVLeZIld8MmM9+eavaogKZ2Jf+5SvIB2Vj18Sgy/3mDQLfdXOm0Y0MRYnDOfeR0ir0OEoavbN0cgt5v1Vzw9JHkAtuPiZIZi5wJ5xblhFLqVCugbY2coolgdh8cFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu7ZlT9E1xolEmEUmqpnPxnXD0/gp7+pOb+u9LDcGcQ=;
 b=XNLdwpbBHidZBV9drU1+BPAvoaIPnboOIKdAM8UQ/K+3hc/QZAjyvCsMoDxBk9lcxojufoCTZaqiFCLW1ZnVqw3AeYsbGYLhfJZbtHZ/nQcG971v7F/VtaPvgme2GM0/oO6pPWLtE4RR/hXCgAZ1YUHm9puS0Py2vz2SHvdT+BGBo7hPe95lN/fVAapMA2aKRWS7juuYUxeylo8EaHILwxAE8Z7leCriKABOdzvpiRgY5A7CuphJKiD5SVPgJbeXvS8wiml0sSlNrfloowu8dlPUotOtLia7VOsyzFbuhWMdcHlxR/bW81W/4illB0KDvAukRdAsNKq6EtGO6fSZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7849.namprd11.prod.outlook.com (2603:10b6:8:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 06:55:33 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:55:32 +0000
Date: Tue, 17 Dec 2024 14:55:23 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>,
	<oliver.sang@intel.com>
Subject: Re: [linus:master] [block]  e70c301fae: stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <Z2EgW8/WNfzZ28mn@xsang-OptiPlex-9020>
References: <202412122112.ca47bcec-lkp@intel.com>
 <20241213143224.GA16111@lst.de>
 <20241217045527.GA16091@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241217045527.GA16091@lst.de>
X-ClientProxiedBy: SI2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:4:186::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 209bea4d-e0a2-46c2-559c-08dd1e67ccc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nER/Xmcp/9gpytAbdy8973hKTBngGgV+Whia0cXUMIP+7lQ3yUasp6Fsa6H7?=
 =?us-ascii?Q?XFJ6LwqRI0/wDLRi+MIMFrLYlhBlykC8msvj47X/nTXgzlx2JF8qfUmMpZj1?=
 =?us-ascii?Q?5/hLSNdzDmUitGHwVpkSe7Hk/4GriF39qd1OufDYFit5vx857FaHno6mi1/0?=
 =?us-ascii?Q?EZSLIhu1GPO/euKkmjQmN1MwIcbdnZjWqXnBBHMgf6ihzTo1xUgq7ZbeGGVC?=
 =?us-ascii?Q?j3eLUGzpUgjVH2/lVAzdwE9x2oeu5WLBLiIIQs9+GpD9oGSgnvBb03Cr6fLD?=
 =?us-ascii?Q?dM96RtxBZnGoR5V7ULjooftgHlMfuxGocRnpxCBTAjZ1x4PFGZWpIoP0wkZm?=
 =?us-ascii?Q?YNinCG+XXr4GkgtUNhPrMxwCF6TuKaAjO1VS7t0cZAbuNTCqMD7/i+864m4D?=
 =?us-ascii?Q?DOw82EQRz021Nq9ckce1daaUwT7eoaV5zZ7H+Q039jaKh4KY7bhKBrEUM8dI?=
 =?us-ascii?Q?OovxuNzZtnQBKinqV6sIxdNT6YPNM2MpdnjHsPdFM+vb0EHyxaAAqRoIJs7s?=
 =?us-ascii?Q?vfl8JY0kdhYlHnDGxrUNBvCAdCdMApKh1qy2OU5ar9D+7OS80EA9VRgdUfEF?=
 =?us-ascii?Q?TRuKCcDyiNv7kedktUkFUvAmYC68oB6ZmP45JJF0qo4PSkJmLHBSF5bd75wX?=
 =?us-ascii?Q?w3hOlaA2HESf+tW687D7wawU77RFakXiGLMhFsG9j5pi9qSMTBUQtCq2+HaJ?=
 =?us-ascii?Q?wLoZIgM2i0SOfveKIQ+FZL7nT+G/cY6DC4d9Us7PD6r70Ugm2EfO3Dnfkqxc?=
 =?us-ascii?Q?6xTqUlEoAaoA4QyPGcDZE3tgabG193qFt4S4pY/LTJJEYEdgL6JbYMXDjbH4?=
 =?us-ascii?Q?BdrUo/OGMWelRPhex8rzd+w+/NGIkOns1RSIc2H6bhvyS2w+M8Ub4jSQvEOq?=
 =?us-ascii?Q?sgxOkSaoyRZiafbNd7IMoNb1ggBrivSLUJ06HjKUoS5Go+RmvXSeH3mcCTWQ?=
 =?us-ascii?Q?GhlEH+yr/AX5L82g0phVoWiirGwK9Ak8dHzdQ/rEngZYEPnfmUHWCPZabCMl?=
 =?us-ascii?Q?MBTROxqQXSNJh4tIuR0xJiW0yEToyIWVHphGLygz4x8jt0LdoamPFtX0snbx?=
 =?us-ascii?Q?C0F/WlkNgPTtbAWlPpgMAvGp8mzTTFV88HvpgA18rxZouqonESQyrOtvkpXe?=
 =?us-ascii?Q?COXtSe47TDNeTaU81VIoXnYf3kgfCzujZDECJ5HRo/zEDSrI/bdiD/X9Y+JJ?=
 =?us-ascii?Q?t84RbF2Mzi6UzVrM0iWyPzc40LnPx3KP9TUaO4EfZUO2PZTICaZ0KNgh7xv+?=
 =?us-ascii?Q?cEpUBvEx2JOkBVuetI4knRTt3uAqqC+gGXvf1GDtePiWg82S0KCP/UcAOH6v?=
 =?us-ascii?Q?savdSGIGRwVjrG1WFLxDOv2ra51yP+MRIgHuYL/UvX4OD/1zbO8RA81r0MlB?=
 =?us-ascii?Q?pnEQ9JI/U3yzMY+an07uwt8v6uTi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nUJR8/XjnSKPEI8DAk8T35ZFIgpXB9cSPxO4RnZS78g220uaWjWnNRYaz8WJ?=
 =?us-ascii?Q?oJZEYGmZ5J/rBHiV6Vcp2UDwYFlLBz1I0n4UxT0HUgTYWAkjJxEMTG5tiE6/?=
 =?us-ascii?Q?TktRT+7gOvJ/K/Lb9PWFcVN7VcF30cjO9Skt2a+RphNKYrgMKIOtWEIeYfNW?=
 =?us-ascii?Q?WTHoYxSmAiJ/Ytd47nFBy8s7fkDmzHBHH/GVpp1Eo7cNHeLOjLVsvCnVeu+E?=
 =?us-ascii?Q?Y6Xq+pr9fiYjqdVc7RJYtqIyjFC0KkfDMBnrgClMBWKGZkoN8QvQx8ZSW96G?=
 =?us-ascii?Q?5grGnXvvmWofdRvL96mIryI3IpmtSC/P1353mu3KX7GsGhUYp1CAFScp8jwZ?=
 =?us-ascii?Q?eFw+GTbVxer6SaeEFmRfqwI/U+JZLnIxk7+VlDbkoBIFRy93vVhhHi2oVD/P?=
 =?us-ascii?Q?lXmMcou7CqgURqi+OmBcF4u8D/gYpIyzrmb1tadQsuiIY8ak5KAbVkUQC+NZ?=
 =?us-ascii?Q?T6De+oNGlxZMv+jSusOGKh0CpmOZWHMIehLM2W6CIOLzA0DJBBDVng6QS4bD?=
 =?us-ascii?Q?2vq9pQCvVwFw68KjWnXrlSEokl/yNbpG5wTvMNrlaa7eQ9AiQLdyQ604HITW?=
 =?us-ascii?Q?JwrHULnHKk091xBQxX/0bGQSAhtn2qg0RnQVRuDf70dxtmeZHL6MULlOYIze?=
 =?us-ascii?Q?++p/0wwqy+HaD+MsSnSHxzi2PyDOHmXLpMj8ZBlrpylSBCY+O2LH6Tn7ZN+i?=
 =?us-ascii?Q?E3HvTHLDfZob+55D5wDSdo4A8kh4BgMdIhMFBKAqPshJj3ZXTIg54s/PzHob?=
 =?us-ascii?Q?zl30L+If2AnP5gtOqwDuQwaFghCQzuIEohROkaC5ui1+xkBxC2qAQsurm30r?=
 =?us-ascii?Q?S57o3XBMJMpkeyE6uePmRnsApP58rAUUOARL4mvSOR9zHqAzEnrOGXDZbbrg?=
 =?us-ascii?Q?kQ7bMcoY8t1EJ/aeYKc2NKhwnhkas8InU7kz1VPZBC9a/dG4wGleeP78kQQX?=
 =?us-ascii?Q?ai2LW/jq9/AgAkafngtOuSXNhVAVayp+OAQ1Bm2BqR6lHW3T4tBxPsq8428s?=
 =?us-ascii?Q?EvQd2hlB9K/ZUpiGoVda8s97ZYyev7gSoFuYzmj1X8Jh/Rpcu0p/5taCEqjh?=
 =?us-ascii?Q?ZQ/NM+Eb5NTLgMj7mcciHfQEDtc22tJlzoL4v0MMGHOrzz9DXHHQoJYvmeBI?=
 =?us-ascii?Q?n4kG4XtiR6kY51UsRkEckDkulOAAcWQHIN/8VTrNibxKrY9jc8oeToCu96gC?=
 =?us-ascii?Q?wRMydHxHVLH7cLU+3wdwfCnswTAQB/s+OMbgrg/V5gkMUBTPesyLu4ZIC7GQ?=
 =?us-ascii?Q?wUeWiRw86iakJ1KNTbBl6BmqkGbwiBRKGRgWdLwlDEtkKoDHg+tvtDmTz06B?=
 =?us-ascii?Q?1A+Kows2XQOjx4/fuu2ak5qsTrCYk7k2v7ZG4YYUwdiezB5XO7ufYAxRqtEv?=
 =?us-ascii?Q?F1AIr6UQoM3E03fK+8a2E4k7avB/5jSViTrzMxC6y5QKtkQpTkNJl66kbWAE?=
 =?us-ascii?Q?TodJ6MWgP5f52GkOb5pVtnWSGy3WGgABinbwv2fx0Mg+KCUMkEyTCqQjMTen?=
 =?us-ascii?Q?rmGaDZhSrIohtPGafS8TcU367otgX5s+kBBJS9s4AR1VYSQbROAo+rLtM5gs?=
 =?us-ascii?Q?XEtLHrP7wMbdygsy/RkGjt7C7HFql0GYBGiven28?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 209bea4d-e0a2-46c2-559c-08dd1e67ccc6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 06:55:32.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XQXu6Q9THJbBiap0EB75An4T/dkrCYeyWBI9H58NDvZWKnbSFlKk0kZ2vK134xkS9AY4fHCCqpG8/RGG6vn9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7849
X-OriginatorOrg: intel.com

hi, Christoph Hellwig,

On Tue, Dec 17, 2024 at 05:55:28AM +0100, Christoph Hellwig wrote:
> On Fri, Dec 13, 2024 at 03:32:24PM +0100, Christoph Hellwig wrote:
> > On Thu, Dec 12, 2024 at 09:51:45PM +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a 49.6% regression of stress-ng.aiol.ops_per_sec on:
> > 
> > This sounds like there is some other I/O path that still reorders,
> > which got messed up.  What storage driver is this using?  The repro
> > material talks about an ata disk, but I'm still curious if it's ahci
> > or some other driver, or a SAS HBA?
> 
> Do you have the information on what hardware is used for this test?
> 

sorry for late.

from below information, it seems an 'ahci' to me. but since I have limited
knowledge about storage driver, maybe I'm wrong. if you want more information,
please let us know. thanks a lot!

the sata hdd for this test is as below:

lrwxrwxrwx 1 root root  9 Dec 17 06:30 ata-WDC_WD20SPZX-22UA7T0_WD-WX82EA06CSLM -> ../../sdb
lrwxrwxrwx 1 root root 10 Dec 17 06:30 ata-WDC_WD20SPZX-22UA7T0_WD-WX82EA06CSLM-part1 -> ../../sdb1

# lsblk -d -o name,rota,tran
NAME    ROTA TRAN
...
sdb        1 sata


# lspci -v | grep -i ahci
00:11.5 SATA controller: Intel Corporation C620 Series Chipset Family SSATA Controller [AHCI mode] (rev 0a) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation C620 Series Chipset Family SSATA Controller [AHCI mode]
        Kernel driver in use: ahci
        Kernel modules: ahci
00:17.0 SATA controller: Intel Corporation C620 Series Chipset Family SATA Controller [AHCI mode] (rev 0a) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation C620 Series Chipset Family SATA Controller [AHCI mode]
        Kernel driver in use: ahci
        Kernel modules: ahci


# dmesg | grep -i ahci
[   33.238726] ahci 0000:00:11.5: version 3.0
[   33.245238] ahci 0000:00:11.5: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
[   33.262304] ahci 0000:00:11.5: 4/4 ports implemented (port mask 0x3c)
[   33.274836] ahci 0000:00:11.5: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst
[   33.332546] scsi host1: ahci
[   33.336259] scsi host2: ahci
[   33.438264] scsi host3: ahci
[   33.447554] scsi host4: ahci
[   33.454807] scsi host5: ahci
[   33.458574] scsi host6: ahci
[   33.462425] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
[   33.462429] ahci 0000:00:17.0: 8/8 ports implemented (port mask 0xff)
[   33.462430] ahci 0000:00:17.0: flags: 64bit ncq sntf pm led clo only pio slum part ems deso sadm sds apst
[   33.514739] scsi host7: ahci
[   33.524035] scsi host8: ahci
[   33.531515] scsi host9: ahci
[   33.542149] scsi host10: ahci
[   33.546126] scsi host11: ahci
[   33.549890] scsi host12: ahci
[   33.553719] scsi host13: ahci
[   33.557556] scsi host14: ahci

