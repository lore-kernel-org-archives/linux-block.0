Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FE221735
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592674; cv=fail; b=X0WuCMntPJBCUvcCpHfqg8Yo/niw2+Xbw5ZToz8txU81BwYQ2EQ+WMcYbuW7m2K9g5g71aPsPSAYYcEiKOu/Xi5V3LveFVgy4XNNienxQ1uhzGPLYADv9YczmKk5UeNAcD3Uo1w7MejVkg8zJVQPH2VTb+af45WhxJo2lcocZxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592674; c=relaxed/simple;
	bh=LJuJq9R5dvpSO8EGtz19V1qmlHaOt5UXdJzJ/k8p69E=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=FNsa000VzbMw70tyrGSYH23ClxCXGUqga5aRFZfAzWvyKaHDjQhZpbAbl0LDDU9nQKB7vrK3sstIttTsS5552nXCho6KqEb96rlQ0PjhQOxF0apK3kK/eRbx3YsmBzp2bqQZb5bqNZauiCP3iMvkpVP3/s4muIBc87Rf4m0TXa4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=II7YAZBg; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="II7YAZBg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741592672; x=1773128672;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=LJuJq9R5dvpSO8EGtz19V1qmlHaOt5UXdJzJ/k8p69E=;
  b=II7YAZBgTff1aqwIjfshyTd4DX+8sv61p1PZgNd5k2c9xfdCZyzXZOz+
   eD2TZoVRw78aYmaOsrVcqbhNE23DlU9SS6cqCjinSmnS1KsYdwndhjuPA
   MnjnYQUEBfx/asnb8ha7EwI7kdn3Y0plW5Np6W8rPxlv9cuI3N39TZK75
   KAGB1C+n3z83QP+cWRgwKgLuSUUcrgABg6CVktHuSHo0ATJbDV22lY2mY
   iQa+M+7RsoMXy25uVNeGoybJr2EmfgEz+Zo/OdYaFfp2HxAFYlmQpAL4V
   YM6xy1emIsxggRvDyaA/46pU9tx1cktPgiytQPoDvM6l4Do3RnMGxdqh/
   Q==;
X-CSE-ConnectionGUID: IT4/9kq4SRGcsWR8ssYerw==
X-CSE-MsgGUID: /wNP83siTjm5sM9cY6TjKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="46357947"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="46357947"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:44:31 -0700
X-CSE-ConnectionGUID: fd4girBlQJGtB4z3toypEQ==
X-CSE-MsgGUID: hFrGYMVgQxeYq32OtHewjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="124833979"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 00:44:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 00:44:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 00:44:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 00:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2RpFKF5aJRVpEILOOiLYYMb6oTawqWLBoUVB1VxRHeLwimngIF7iZgz0/gVClz38zxxU7xNJldCGLjihJJ8dRZrdKkH8CxvLFUtMzCzpVMK4qReAllSrcrHv3gPPd03JRUa8u+gT4pOmGfv0pIWWp8nDAL0oBlEicOuT/bqkaS7s0p+43e0H5DwmA3nxFeRwvgMXKXHoaRcVOOVhm+o6LWTIOYnBSayVze884OpgOc+pgAgC9TLZNYuWnKvxfPDH5IjO4vQ9pKAQfTiV+kYOuFee05KhfuhXr4bJcyNKtU1VnXhtuJxnqbWNNgM2IikNM7/KlZgf5xDy896Tl97fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyGNLmER56811MaeG0qHLv5CsMoQchuMGggYOPXJSKg=;
 b=FxsDxvtBSX4dNdGrTP13jfFjKVTJy2WeaAVbxa27waASNpcnEqFd0+TD3WAy6JkrDWEUrSU0WE9VaolcRZOvtLTpUq8OcXYc3t9nh5n6aif369N6AJz7v8KHOa8Eth5CWPA+u7JJjpER3ISaulq7sb5fjNrsa/Q0tl0Tam7RO2NgTBdW/XGfkQ4Xtw77JCNnkaO3d+ZSyYjSPKptAl9vqw1pOMkhpYLNoQ29kt/rEUIssUixZKANY+aAL1NdCUDhKF6Agd7t+4ILLoJOMouG1kLE9E3kuPAxZ+jIl6InAuh1fFePNUnKZRoihdhTSq1yEvNW5vguaPcuvN4D0cF8Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:44:00 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:44:00 +0000
Date: Mon, 10 Mar 2025 15:43:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Hannes Reinecke <hare@suse.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, John Garry <john.g.garry@oracle.com>,
	<linux-block@vger.kernel.org>, <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linux-next:master] [block/bdev]  3c20917120:
 BUG:sleeping_function_called_from_invalid_context_at_mm/util.c
Message-ID: <202503101536.27099c77-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:195::13) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 43175f2b-c04d-4f4f-7a86-08dd5fa7528d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/a0c1GfHsFtmKyA7ujDpNXLZexA44PqZdOEgVTXNp3Sdo2O6kIcoNcjo0xY?=
 =?us-ascii?Q?tIQ8McB/QEYQrss9e7gaEg/YdJ5twCYkiYEMIFEnAAlVRPpUcRkT2FghY/lx?=
 =?us-ascii?Q?DfdKHUbBX0XQ4FCdFOmuvklOt7ZAY4nOc9UJBHek+lvwXyZoG+BTFUUkrvC2?=
 =?us-ascii?Q?6koUcdaJzGuUBZhG/fJBx39ndIAeLENCP4DMvPTTWcheuVvbIxPl5LmoqWLU?=
 =?us-ascii?Q?Pw6QyPOWq1UFKBHLPrYjIokORPYQPyVFCQKCaHLyBSSHKNWiNzfvS130P16U?=
 =?us-ascii?Q?OpRZEf/IVKauzHdGVFCgf/m/iZQr5OXxSoWozZ39Ot3Cs7PmmTIG3MK2LQkF?=
 =?us-ascii?Q?5aRrF5gyy2V8V8VPTkLfr4NYLVJgED+s49lWf8beqprEyb6UYOS8WyDYc7cR?=
 =?us-ascii?Q?el4MgTj9Macg7QozymynBeoHDfgYPOocdEB1GvV0b8+5pchvazyGkj41Okqv?=
 =?us-ascii?Q?JQOX6hqD3E0d/RMR6FUmG7tntpMyPGVhNn8pH7deO/EHPbytNKiahRwFbB4B?=
 =?us-ascii?Q?z65YrFvv5qS1hh3cpzs0OBxAXqnGExnCs29TtTpKhzr1CP7WVG1fy8KhyLRO?=
 =?us-ascii?Q?TrV4o21ndEAI7GcEb9Ra3VC4wIlJlU4z/gKaXRG7WaDbqhAhBVQcsSSuS02Y?=
 =?us-ascii?Q?cv7vmDlc/WISB9Ew2CcQyMpbEFTFwO+SUjNAo2X/OpD92FBJeRHY1tQs/+bN?=
 =?us-ascii?Q?55lRq4pSbF7UCA8lS0Ak/wp+G8KWDfNEzNegGsMoY2rmX0GZKLrdEWEOYESi?=
 =?us-ascii?Q?0yiLKMt8hn+RewNx/aswurmAbsB/uSXKptovn+t4mz0L801rWfsme0TgEcWu?=
 =?us-ascii?Q?gug4O7M0Lk7nH+KNqYzoWD40viL/nwxPBHwX5jf2SIVGqR8C6/wWtmF0D3L9?=
 =?us-ascii?Q?YgDmhXs757vt+WAQGjvuhtrMDlPBT8dciLxgcuKxKrxNz6XL82yQfg+6jvek?=
 =?us-ascii?Q?RG7dDiePKUmZsgilVs4WQ9m+IVOghD6mudHhpN51b4wuCbT8ak/ev6jr0RPk?=
 =?us-ascii?Q?n+C+pMbKIifZJgkirm8ukJ3gylNuCOo/v6F5tNDLYqS/NBMmz7q2geTA9n2f?=
 =?us-ascii?Q?SLs6jvNdEdPBQAieLzx+eSXk6YX6Z+QvFuy9PyrNOn9us4Cxqam/Vi6QcHx1?=
 =?us-ascii?Q?HlWgOxZ5HOhJowSCPhsk7QlXk7GfQPuGR9tRIUo5KsXk/PDrC+3hvvlQRVza?=
 =?us-ascii?Q?RbWvnpde/MoPacQ/kk+X3juNd8EwEU7Ys3eqsVgjlpY7zUGfgaODlHBHshof?=
 =?us-ascii?Q?jb3omrJVWY+8pXEZZUj7o8+cJ9J2xuMSbwWcTOZqBXKEVs7PAMNKWnyxxfoJ?=
 =?us-ascii?Q?5IoVf+LcWHVnILKvSb5OSEo7M9xTWD9WDQt/P8flcMGSFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tLKrZt7oZLIgq0ZN7obX+ypxuh+B8yrIPJC3eX1LwUyIeaAKn2QdVeNigdQv?=
 =?us-ascii?Q?m9n+UGzJAciLpRA//pEk7tm+hNr7t70zBGgWCbZ5WHm17XbaV3X3vPgENWZa?=
 =?us-ascii?Q?A+XhcjrQft5Qf1uzJONWy+W3jrrKqB6Z1W/Q3vt0PYe3JsaEuZkvNKXLCvSa?=
 =?us-ascii?Q?F8xadl6CjKugq+EsALfvjHaC85C/4xjk482nrCfMVVhmydoqnMBq7CMvod+/?=
 =?us-ascii?Q?7LzJuGyDXcB9dLda89gqIRGyB6CacQl6jQvb/FAoEC6t0m6Dr+Z5XFyGS3yi?=
 =?us-ascii?Q?Bvhs4CxgPstHMUAjfdNTQEZ4oILYsOI33xhOA1Dfu8DnmMJxvS3q5pRjXklE?=
 =?us-ascii?Q?riSod68eVMw67PeCefUUs60esnNNKIk0bgTZ2hEXqZq869Rqq4BGLP/GRLf4?=
 =?us-ascii?Q?XYJGUrLdUM87cm3Zem2d/kmcq7SyNaumbJb+jthdt/IFg2lIvuhNHwi9jbId?=
 =?us-ascii?Q?UPBBJGYQ06T2DujYEJDwcCXbyqJcMB+r1oqSVSa4M4TKGZAtgfh6EhZoqR5b?=
 =?us-ascii?Q?a7h05XL/vVgk89PaQOaaJJM7H/DNu1apu6ouNR0Jd4o5gbWmDzwDgxXuDfMe?=
 =?us-ascii?Q?YkAClqaKI34S4Oj88vOd8fFT6HZ8GVQ26j+smJYTzrOds1CNnkGJ/vb9z/14?=
 =?us-ascii?Q?4GC5RXNPKazlFQI0mXj4lOUb1rWCU/NQRSR4W3s5wBAvUkAMvnMw8+sGWSng?=
 =?us-ascii?Q?Ws6fkhvcNoD4puFUmjvDfSpdSmc+z8b0WLKtoy1Gvd0crnckrxCUKp+8WrD1?=
 =?us-ascii?Q?brXRS09rA7lcTgUtfnTTEAxmplb775kWlVqvaFIyg0jND1kZslbJVCG13/dG?=
 =?us-ascii?Q?FnZwGqQxE6RxEOXBLXgaWmed5HeWhS2ml9MxfoyZGz9XK8S7Ir8w15qRzDpK?=
 =?us-ascii?Q?Q+xV6kLqYuIR7AgimuYVbQudt8u8JCPqwPy+SiQ/DQgjDWrJW/l4LHqx14GK?=
 =?us-ascii?Q?ir8sa0sFUk56UI5lWag/Evq+J7uy42ISCo9rm41+hS/GwdNtPvaVVBfpAQSK?=
 =?us-ascii?Q?Ypn/WneuaPQJ6GJRebwDIPFvASpqQzC5reyjdqguNaUaMCtKwco2CMlVOba0?=
 =?us-ascii?Q?rC01Cu2d2MOfVtXbwbtcCDB9zlmrlklS+0y7nYDH9GWsWwWe+nm2m0WdPTab?=
 =?us-ascii?Q?ov7ls10TftRpRsT2cu+SQMN1EbI5zKYGeGKBlzQ60/eOBuJ22jth81kiZHkl?=
 =?us-ascii?Q?LZW7vzsmOnS1V8ZiJBc72cPFWYLMNkZYaChdPSxCEpuGaSo+qpnEnHsGdXfc?=
 =?us-ascii?Q?IMwqh3TqsTW6jkHPT2dCCjLtZkcdb+BP19xWAOqGACdGuuvXynoWTTt21Ih9?=
 =?us-ascii?Q?i9GIGAWIP5EXXfHzeBYjsHzIT1s2+yC3QqvkKwQ7xwHUlwxOjXev6YmAb4eR?=
 =?us-ascii?Q?uA5IMjnGwoHdqKP8/4eTMvIMtFK8am/SkGVSphA1tlclJritDcYYN5VIEKZ3?=
 =?us-ascii?Q?enMo/bnfVlM7NiF8qO2okI7X9bnPpoHwaVqQXd7eqgc0vf+KWfxCWUmAZXcg?=
 =?us-ascii?Q?1/amLPKkTUsMxisaRCWPRseLQlEoDTj2r5/cAXmO3YZi4/pecQ0US+/JJdZk?=
 =?us-ascii?Q?samAwbWWkoRrRaKI1QRQ+4xaoDZuaAhHV8QnqxoW/JIk4p+9p5Q5CneoGB1R?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43175f2b-c04d-4f4f-7a86-08dd5fa7528d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:44:00.6593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdUWa3+ajcJsc1i5+DvnOZSnfQVwbWytBaYExYCqDh+CJhI9KvZzr4zMzjXxgFR/UjgnnMJmniZnYChPsWwpcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:sleeping_function_called_from_invalid_context_at_mm/util.c" on:

commit: 3c20917120ce61f2a123ca0810293872f4c6b5a4 ("block/bdev: enable large folio support for large logical block sizes")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: ltp
version: ltp-x86_64-0f9d817a3-1_20250222
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-04/close_range01



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503101536.27099c77-lkp@intel.com


[  218.427851][   T51] BUG: sleeping function called from invalid context at mm/util.c:901
[  218.435981][   T51] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 51, name: kcompactd0
[  218.444773][   T51] preempt_count: 1, expected: 0
[  218.449601][   T51] RCU nest depth: 0, expected: 0
[  218.454476][   T51] CPU: 2 UID: 0 PID: 51 Comm: kcompactd0 Tainted: G S                 6.14.0-rc1-00006-g3c20917120ce #1
[  218.454486][   T51] Tainted: [S]=CPU_OUT_OF_SPEC
[  218.454488][   T51] Hardware name: Hewlett-Packard HP Pro 3340 MT/17A1, BIOS 8.07 01/24/2013
[  218.454492][   T51] Call Trace:
[  218.454495][   T51]  <TASK>
[ 218.454498][ T51] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1)) 
[ 218.454508][ T51] __might_resched (kernel/sched/core.c:8767) 
[ 218.454517][ T51] folio_mc_copy (include/linux/sched.h:2072 mm/util.c:901) 
[ 218.454525][ T51] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 218.454532][ T51] __migrate_folio+0x11a/0x2d0 
[ 218.454541][ T51] __buffer_migrate_folio (mm/migrate.c:945 mm/migrate.c:876) 
[ 218.454548][ T51] move_to_new_folio (mm/migrate.c:1080) 
[ 218.454555][ T51] migrate_folio_move (mm/migrate.c:1360) 
[ 218.454562][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454572][ T51] ? __pfx_migrate_folio_move (mm/migrate.c:1349) 
[ 218.454578][ T51] ? compaction_alloc_noprof (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:829 include/linux/page-flags.h:850 mm/internal.h:711 mm/compaction.c:1878) 
[ 218.454587][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
[ 218.454594][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454601][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454607][ T51] ? migrate_folio_unmap (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/mm.h:1257 include/linux/mm.h:1273 mm/migrate.c:1324) 
[ 218.454614][ T51] migrate_pages_batch (mm/migrate.c:1721 mm/migrate.c:1959) 
[ 218.454621][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454631][ T51] ? __pfx_migrate_pages_batch (mm/migrate.c:1779) 
[ 218.454638][ T51] ? cgroup_rstat_updated (kernel/cgroup/rstat.c:45 kernel/cgroup/rstat.c:101) 
[ 218.454648][ T51] migrate_pages_sync (mm/migrate.c:1992) 
[ 218.454656][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
[ 218.454662][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454669][ T51] ? lru_gen_del_folio (include/linux/list.h:215 include/linux/list.h:229 include/linux/mm_inline.h:300) 
[ 218.454677][ T51] ? __pfx_migrate_pages_sync (mm/migrate.c:1982) 
[ 218.454683][ T51] ? set_pfnblock_flags_mask (mm/page_alloc.c:415 (discriminator 14)) 
[ 218.454691][ T51] ? __pfx_lru_gen_del_folio (include/linux/mm_inline.h:284) 
[ 218.454699][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
[ 218.454705][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454713][ T51] migrate_pages (mm/migrate.c:2098) 
[ 218.454720][ T51] ? __pfx_compaction_alloc (mm/compaction.c:1882) 
[ 218.454726][ T51] ? __pfx_compaction_free (mm/compaction.c:1892) 
[ 218.454733][ T51] ? __pfx_buffer_migrate_folio_norefs (mm/migrate.c:936) 
[ 218.454740][ T51] ? __pfx_migrate_pages (mm/migrate.c:2057) 
[ 218.454748][ T51] ? isolate_migratepages (mm/compaction.c:2167) 
[ 218.454757][ T51] compact_zone (mm/compaction.c:2667) 
[ 218.454767][ T51] ? __pfx_compact_zone (mm/compaction.c:2529) 
[ 218.454774][ T51] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 218.454780][ T51] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
[ 218.454788][ T51] compact_node (mm/compaction.c:2934) 
[ 218.454795][ T51] ? __pfx_compact_node (mm/compaction.c:2910) 
[ 218.454807][ T51] ? __pfx_extfrag_for_order (mm/vmstat.c:1138) 
[ 218.454814][ T51] ? __pfx_mutex_unlock (kernel/locking/mutex.c:518) 
[ 218.454822][ T51] ? finish_wait (include/linux/list.h:215 include/linux/list.h:287 kernel/sched/wait.c:376) 
[ 218.454831][ T51] kcompactd (mm/compaction.c:2235 mm/compaction.c:3227) 
[ 218.454839][ T51] ? __pfx_kcompactd (mm/compaction.c:3179) 
[ 218.454846][ T51] ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:111 kernel/locking/spinlock.c:162) 
[ 218.454852][ T51] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
[ 218.454858][ T51] ? __pfx_autoremove_wake_function (kernel/sched/wait.c:383) 
[ 218.454867][ T51] ? __kthread_parkme (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/kthread.c:291) 
[ 218.454874][ T51] ? __pfx_kcompactd (mm/compaction.c:3179) 
[ 218.454880][ T51] kthread (kernel/kthread.c:464) 
[ 218.454887][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
[ 218.454895][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
[ 218.454902][ T51] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 218.454910][ T51] ? __pfx_kthread (kernel/kthread.c:413) 
[ 218.454915][ T51] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
[  218.454924][   T51]  </TASK>


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503101536.27099c77-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

