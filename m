Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C3D29CB45;
	Fri, 15 Aug 2025 03:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755228370; cv=fail; b=QTkyJgcr3kh0lxLUCZF+4cogg3D0svAiADIda3fd7LU+BENzRoOKy6F3usAUL38np+BI1SmVDQ87zTrr2H1h6Ho8kkyEE3rsT7iDyZAOa6zO6+PLZYUVp5lRN8trMHsS3UMrqLgPayh8arXJ0c8FZKhCfnPRpjXBIXtqjKCK1mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755228370; c=relaxed/simple;
	bh=5IQDxhtJjbb6N+AQSxZsfmB1DBsrQ7QTaBNck7gEAsM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m9GKZsyLH+aUXAn+NC81vpmnV55GTpbvlMb596BoDDLw9vMlGbVQYLz7ru6QXfKXWqFq6EalBMWoeC+wSNxh56ouXupdLXvlJ3omz0Io9rVavcqjGdNQOdA+9e8RuE19wxWf1BPq50+gYCbMkHL8sRidiSzKPzzLHkYjfyf8cuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwTTY4rt; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwTTY4rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755228366; x=1786764366;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=5IQDxhtJjbb6N+AQSxZsfmB1DBsrQ7QTaBNck7gEAsM=;
  b=XwTTY4rt0TmQPwEWOMOiihIuoHIJk0Dfc20oUjQu0VePed1+iTkAPU4Q
   83cxM49+lViPFhLIQxjA1G0gOqTRPpp5wzL2IueRFp6AQjrpr9WuKkPs1
   JTSFHDaCCBXUqidWGlptMlTx9x3n0MY88cyju3Dz8QDseDiwOJ1g42CcW
   7CtnkdVM+0s2qn6LuwU9GkeIyA2zNqO1qKpQnWVAeSDbU/bMnM/qlwR18
   6TNKJgydd7jnzN8ysvucYx/xKvuzHrVgorkaRrhsLdofoa9K3UtGU6z7a
   XeObSyT2hoICfWiz1G7Y2SU7WvYI7EW89DbxByVuxpNg9JRho5Eunkuky
   A==;
X-CSE-ConnectionGUID: dCNfA6gOT1+ZxC4Jk957QQ==
X-CSE-MsgGUID: gBJ9ndRDQligsYQ9XyQgqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="56579847"
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="56579847"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:26:05 -0700
X-CSE-ConnectionGUID: zka69shMQvKgjhhAIdqSeQ==
X-CSE-MsgGUID: LNVu+k+9TROl2Q9TqyQIAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,290,1747724400"; 
   d="scan'208";a="171383877"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 20:26:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 20:26:04 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 20:26:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.80)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 20:26:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hYM98IQ9POhfHnhIf5o2Qa6k1pKQ5ixR6b3qzwiUIZVCDLWoGyKKfb1wudzAHu88alp6Je+gdizZPuO+cbOykCt+1So7mLB5MbLHnpX6t7cz8XO5H3htWPuM3gPrrcNaHGaD53uhn3XoXpBuolEVe8Lgyu/FDTDSyIbMHGqPvO3w2G60D8AhQFdKdnUBl/mFyuY/kdoRWcWA4nx+jUQViTjgy+Z1Ffz5zG8hrDRM4HzSIeJ7zXNOVEKEr69I6cc5oSntJ1yE+qbuQAgmikBECXINBx1urvGbD2EvbHn1o9DFbqWC0689dpIfyShB0zZAX95CVIn7IhSFjfGKGtZ/Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJFqTWZHsiimDxNvEX/zkIM1EpuvoOKLstkhD1HDJVg=;
 b=MB7yqWcUwhB86UpHaFXnrEqCpaasIpjy5MwDMacgJmbqdYY4wa9Dyv6Ko3Kp6B+VqvtHvUZtLXYzRCBFg0VnSczzsRSE/hqh8BZAaEwRWCA5VdbSmFH5DJ0r7oQYi5WvR0zz08ngoZriQWKw9dhCFOectK0l9L2m/Njvl3K0sbEqGoDNK6SEL7hghnYOYxc+CIvEgfpeyO6xDkiBYBmfh07UEP3eA7eaO310D7uoQOBJyQ5g7s0iZN6GOK50MhzW9JMxwdmv0KporJfsDoAALTCTbn6PclBsVxSQ0eua/TGv4emjG+tS2wpRy++Ra/NmUluRQsLyqHZdwmf2H9/ZXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH3PPFE60A892D7.namprd11.prod.outlook.com (2603:10b6:518:1::d59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 03:26:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 03:26:02 +0000
Date: Fri, 15 Aug 2025 11:25:53 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rajeev Mishra <rajeevm@hpe.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, <linux-kernel@vger.kernel.org>, Rajeev Mishra
	<rajeevm@hpe.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH 1/1] loop: sync filesystem cache before getting file size
 in get_size()
Message-ID: <202508150425.33b5498e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250807232522.192898-1-rajeevm@hpe.com>
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH3PPFE60A892D7:EE_
X-MS-Office365-Filtering-Correlation-Id: e2a6f6f7-d061-4cbc-666f-08dddbab75ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ipAw/ybPdcEh/f3XlK1EhKokVQescc+xlpA8sUXcND37ptf5RAldiBm+sy4J?=
 =?us-ascii?Q?+OnK5CQpveI936HM7pXjitpznQa5Ey2qNA+Wmg0CwZJ3IU1puC4bVWwl0zjU?=
 =?us-ascii?Q?Yr23hgeaSe2nwoJEFVwDrUbLiGIonNrqcGP+rEczMdeguujKkPESZhbgrSbi?=
 =?us-ascii?Q?6/wuQdPeTWPmQzrmGUGmuGInspEoCTw+12tE31ehWNl5WaB8IjiMWXz0IcAX?=
 =?us-ascii?Q?+UFfLm+lDk5APh6rN/wk/ENlq+C6zBbM928krFvgIhGvWhLaE6aZw04SLGwu?=
 =?us-ascii?Q?kCIqBLQ6XnZgWVvRTgrS4lQl8M9X9aRIflwW1ViFfWDh8U535KduU3W9vKQ0?=
 =?us-ascii?Q?3Lnk9qOAC5w0YlKKEfzaMYES8QUi4Xj6rLPLynphH4lnkOFlL5KLT1gR5E0s?=
 =?us-ascii?Q?m6EBjW4xKkk6/S5Es5qExbGcclbiYrjisHBeUyx+404uz4vnj14r0ikN3XvO?=
 =?us-ascii?Q?PazU6mm1tIT/JRDwxoIPx+tP42Q0u5uiJ/buKIOYxd2fcdBZCbwLWYqpkTkO?=
 =?us-ascii?Q?1AFEl9q9IY+0QCNLtf2nKyVj1FYclWBJLAA4H0TKpOFEL5Ig8o5Ai8VNSvEw?=
 =?us-ascii?Q?4W1Z80wOxnSHfR17FocSnFD0oU23FFe0pke0VwifudqOfPOypY4DGgyJ3W/u?=
 =?us-ascii?Q?e6wmBwJigtbqBFOfndEbEvzDt4Pmh3SLIOisBudadl4LrJSRM8sx10XjzLX0?=
 =?us-ascii?Q?3Lww0/iKrJ3n5l2Z9bsT8KUbiCX1bllWGdbdwLeEVqKDESpeia00TrJVa2gV?=
 =?us-ascii?Q?KeifcEaYkZO+x7BPI3+GNNWYueq8RZOQcNcpTOOY2Z2OByjCb6d9tqpL88go?=
 =?us-ascii?Q?dW5y8OOZ2Y27yUfSUHs8Lv3IhtOGq1QR3LIvtBLvAhgioJhhCCk4ksLDFtYQ?=
 =?us-ascii?Q?dP3oeFpN+/P2qu0Jb5QIbnUSlKxwczfcRpFc/TT4B7eemoMhJyJYP5TXx+ny?=
 =?us-ascii?Q?z0JXo6zg8sCoN4MXsJ2XJpJgplg1gMxWdUc4tKoGbQGuHN8ll5tjPHmcQZqq?=
 =?us-ascii?Q?bvIVg+Skj3smZNJbz8U5mw67Hjrr0ZbozxCIEHqxGk7cev+L62zhtz/m+M3G?=
 =?us-ascii?Q?MYtqDUADhxdO7pbMx62oTlqnQvlZfEBy8lwpimA8KRjOeJ5Ae3iRcdDM2KpJ?=
 =?us-ascii?Q?zC8I+7c+UtrLjlKqJfrUcNSM1r37ErxchAx6WZgvaFEo4pDIoDVkQUzgoGSS?=
 =?us-ascii?Q?Sf+130vkCxJVKgjHCDxnU0jeYZ2oDG6DA2HL1BxCkWl2/uXkGdN58fFLgWdJ?=
 =?us-ascii?Q?FvFzsT6hxIzq3rZL9PgrUF+TXG8zusZXZb0uMFF9S52nGWnDUSx2Su5+jwPT?=
 =?us-ascii?Q?h0i00o4lWuJaWTdmIWRj6vFWvwMLbv+HMiwpWJASe8V6MFVUhAzMGeuIFjDK?=
 =?us-ascii?Q?4T6kleoamEB3NfxBq+bNMSVNjUDp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IURph8C1Cte/Qj9rBj65ixXO4EnlCQ+A0oQ3VLWwbFh/APRDfJ8GcvAOLd9K?=
 =?us-ascii?Q?hNtkrFLDxNgVJ6FamfiJbs2rW8Cc+r+JPh+YZyaTylzGiaUKqUUzHK1E5pSU?=
 =?us-ascii?Q?yd1DYthAdQLN6XwmDFVYo0rnuewkJlGWUrJHxbNiyzl9VI8iXXYYn2I3TqPO?=
 =?us-ascii?Q?BRnWUbVtnVSaK/pRaLjfVx5kIwCDJjIQ1Um6PHo7SsSApqZpiLXw5y//Q4Rz?=
 =?us-ascii?Q?sECYIIa8P0PXKKP/r60mKu6XPpSYw7m+eDxbO3byJb8yJHW/EXUZ2xiyJgem?=
 =?us-ascii?Q?+DKLaZII6/8kYpN0fgBpZiz2oCflhGNAIUgn17N3RBR9RS6BVsZpGeF6kaSA?=
 =?us-ascii?Q?VKzjDMqd85PvCGa7n+c0JMCb+wrib5Z467fVnmsq+9VYI9Aj4YLG9pHJi5OF?=
 =?us-ascii?Q?IT1txGNWVrRgfoNEkNga38ICCjgDZqStFhukSEUcUOpRaX1uEEu0I+fxVzTK?=
 =?us-ascii?Q?SZRzbCxJMl44lR7qGz4BhSt8l/IQ1ByLfBWdfMJMytQJyaXTZoCuNpUkEEVp?=
 =?us-ascii?Q?V25YwACGjj0Tn1oK9jDYA4/9vJPgj6bOIIHBh8TyCzyP5YUN/ISIszqz3Bld?=
 =?us-ascii?Q?IM2ng3Q9BRekjdGc7gmxtc6PHPLJmpu2QE87a5ykCfHQ9ul45gPZPAzT5i7/?=
 =?us-ascii?Q?hp/tNN+GWbd4x1DDh31nA//6sFNBBw9qCoQVAzCEJ/F4lv4BKn7yQ7/3FHCI?=
 =?us-ascii?Q?qqoRJCPy0lB4ayun/XCDaRaCw8GnFP5+SAAmdTGfuG8OSUD7tBAONGANYgms?=
 =?us-ascii?Q?KpYWSyk1p0oIt4p7qI1zFiieZOjTUfB2OjSATNaIbf/eB22AYYdZCN+oVO4R?=
 =?us-ascii?Q?6i9mlp6fks8CnbMBADJUH2wJXfBXI+B4QhHjtctslTh7rG5WWb0bptDewn3e?=
 =?us-ascii?Q?gjODWEfziyamYoWHVHU+paEYdXHw4kWX0jIy6mBohZgHaxkpxcIt0vwojAY8?=
 =?us-ascii?Q?dkKhAwFVeAEU6JuPDH+mWukB779CUZ2q7AW94mApuW4I7/qEXDquydFIgsGA?=
 =?us-ascii?Q?6zeuxxi0o2KHStE9W6LnTvy/qd+SfKMzHi0MYr25BogiKXiY0YFwKimiv2fi?=
 =?us-ascii?Q?8w+yf+MRIefI0rWldlJk/QZjt1tj1VhMRA0vsooVyzBE7I5/OfqZF0bsB1Bj?=
 =?us-ascii?Q?nbFpU5ShIBdBYj8iVW3FBs9VuCX/InAAnaWXwowzq9axSA8dZ5zOtSszRuEi?=
 =?us-ascii?Q?e620NFLv8WE93e9XcYGjFxvHXGR8bUuoOmbz0nFAPtXEB08tGnxgvjZEdpZ1?=
 =?us-ascii?Q?8uuYSjnU8ZewtvoLEWZunvN42R60/APngJ6J/5f08Vb+kFrZUCk4ZBSOZXv+?=
 =?us-ascii?Q?ophD44K8AhRgBOOcqDeRfJIop99v/r4keTd44xvL6QgMG+2bVzeBcr/Di19m?=
 =?us-ascii?Q?KByEn4LjA0ukVehNPl0jQBbl63+0SbO7wWuAsZ7a5WFAlHwvJYtxcYzEyIZx?=
 =?us-ascii?Q?5vcGzKjir+2s2MZ+MtjrcrgSzxo4cYDBTz7zA1haG0pzxifw5BzrmKooJON4?=
 =?us-ascii?Q?2nLhyuR6uNf1urKeU/BSbnpcXWpVqnmk8RxsdQuJPs2SJsjDbcxIiptU4Mvp?=
 =?us-ascii?Q?kN4+dUrKMZ46n8xfDZacYnEuWvCeMn+pLYuEOARHnw2E8+dtzm373Egr1ii1?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a6f6f7-d061-4cbc-666f-08dddbab75ee
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 03:26:02.2122
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOeQX8b3ZgXivgmv96+YtMkTUSC/aLo33gzEBukV5Mqrc8TPIdScQJrCNerfET6kBJ05+KbHepdzeGdo+Km+GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE60A892D7
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.loop/004.fail" on:

commit: 081158bd768a2a4b4fc6108abc3d4ee51bfdbf6e ("[PATCH 1/1] loop: sync filesystem cache before getting file size in get_size()")
url: https://github.com/intel-lab-lkp/linux/commits/Rajeev-Mishra/loop-sync-filesystem-cache-before-getting-file-size-in-get_size/20250808-073617
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20250807232522.192898-1-rajeevm@hpe.com/
patch subject: [PATCH 1/1] loop: sync filesystem cache before getting file size in get_size()

in testcase: blktests
version: blktests-x86_64-a08678c-1_20250813
with following parameters:

	test: loop-004



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508150425.33b5498e-lkp@intel.com

2025-08-14 08:21:17 echo loop/004
2025-08-14 08:21:17 ./check loop/004
loop/004 (combine loop direct I/O mode and a custom block size)
loop/004 (combine loop direct I/O mode and a custom block size) [failed]
    runtime    ...  0.668s
    --- tests/loop/004.out	2025-08-13 07:46:30.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/loop/004.out.bad	2025-08-14 08:21:18.595234684 +0000
    @@ -1,4 +1,5 @@
     Running loop/004
     1
    -769bd186841c10e5b1106b55986206c0e87fc05a7f565fdee01b5abcaff6ae78  -
    +pwrite: No space left on device
    +e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855  -
     Test complete



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250815/202508150425.33b5498e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

