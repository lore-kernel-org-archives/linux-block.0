Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9371C9DC6;
	Wed,  4 Jun 2025 15:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049284; cv=fail; b=DDmB5RsKTKoWnGx8jmxZPMy662mIfG8rDVA2Hls0SwKPnsaDov80whhC7/6+dSL9ETthI8b/jpTFgj9aGoQ3MkDiZ3H5hbkR4E99QUON8mIb0eCJHS1lOPfn2FLIeQS+krYuw69NbvTkt5tNvJINrv2KfNhzCJWTgRUGX2IslmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049284; c=relaxed/simple;
	bh=BnGM7O2mDgZe7eibWw6+ib/LLVaAaG9KjpwjMxYmxfQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=J8/9bo5ZI/ohGyoaa+PpJDXI3jTQBcEXUgOEu4YF9G5NpY/WZQYKOr9W4QAmnlra6/PHHbA3jmuoqWm+yro820Cy0akM92UJ4xbJQmd8uLzRj4yPsbuIsCL/svjoc/73VMdKnPOIl90idYaeXvZHClolbsl6efIprDSL2aVUbak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Br4rIxIb; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Br4rIxIb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749049282; x=1780585282;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=BnGM7O2mDgZe7eibWw6+ib/LLVaAaG9KjpwjMxYmxfQ=;
  b=Br4rIxIbq8kmO1kMAUfnc16RBGfRu9lj+Y8hPNhboSBQtGdQn4zQn7IJ
   ePoCsaj1AfcUSJy0r4Ux0YalDqU3cLLCokU3WRWjvTHabF6LdM3tNdX+h
   MW0M8BqYDB0uo5d4KGFCGWrpkC2Bv0BVg78elSJoTrTCSYFlOU7Y85/5K
   Wp2ZilbDZW3yK0WpnrGwbhyfrwBt4DO2f27gFCrsEHwSHY3Fdk6muExuY
   F0OEz+cEPTyedTt//iFmxAbcwCtmJhqwTp8TZpcJZW8TFXiz/En+mhQxd
   EUjc+2gBkDRJz3vv2huvtXXbfXGM6OfZNBww0wrBbDZC2gvwC7rhhJCDY
   A==;
X-CSE-ConnectionGUID: /kgbz7+vQ6yLoBrEKszbUg==
X-CSE-MsgGUID: 6pyGPN4RRVu3B3rM0qm2Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="54926644"
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="54926644"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:01:20 -0700
X-CSE-ConnectionGUID: YuWcqe9nQYSvLVUZl/J4wA==
X-CSE-MsgGUID: EunLOQjMTHmYAsJ/xXjRzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,209,1744095600"; 
   d="scan'208";a="150494670"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 08:01:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 08:01:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 08:01:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.84) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 08:01:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6MA7yN3PIil+MAKr6Cud3xhiRtBQU+W9GN0NdpDqJb8xmOK7AKdtozhmewlqN5pBTN3FDZEiWyQAo7/4d1auIxOoQOzDVIfl+NEz/ZPjikvExtC0YXiT3wCmxF+DYfbt0dTz27oZiHsEUayJ/lTNWmVOslTijB8dwIo8IUoKDdn9fRr1BGmQqW0+vFiSKAklNcndhc7CUA2epTOy8JtTgmnRlV2qP1+s5qck0M3G9UYaphooCUq1YqbRH7TIQHrBHAWUIyYjol36ioV79lpctCh7XloF/xJbX/2xSrb1UT4Gmusk89rUzhR6CjT7Uu6PvYgfqQCZRrfxeBhz2oTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUG1SHW0sDWSBFevBiiAxwIRZuevkjC7carZR3WYg0o=;
 b=UY6DcrybKs2+vrZlCpfsNPLjerow3YEsEP8zVHhPsrK73AEsiT7mlW7vpF9d+AO3DOfb+ocL9362ZYIAPwgpdaIe12VBVTsC3s30RH6P36pGzLBUjt0TB9jtSZrHorYp4gWyDwZRMvdqz/xGMnhofP6BKBeyrwr1KsEXAaRfK1NYUb8apX2wcEl88Vo3y85wfzIyGc49wGYxPBCsYl9GxecCWnlCVKRoWpVzN1Fz9We5cmKLaBBR8pgvkt5Ba1rp4FJ4AYDBcqS7xBvobZA660+SHVIFEaJFcZHZg9mlyWGCeinYf/bNiCq+K/pTJ0jwUuJ67Bz0yLUGJqmNYcUjMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Wed, 4 Jun
 2025 15:01:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 15:01:09 +0000
Date: Wed, 4 Jun 2025 23:01:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [loop]  e7bc0010ce:  stress-ng.loop.ops_per_sec 5.3%
 improvement
Message-ID: <202506042201.1d6ccec5-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: fce7f94c-2152-4c00-d9c8-08dda378a3a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?2aCYdj+Kz8UAECoUusycoxoVGmByhy0EgXRlqjCaHCu1JzLlftbQEHvWsG?=
 =?iso-8859-1?Q?Oma8mXz1kKjOCIOUhguz0o63jL2Re0s9x6RLXHBQW8ubjwBc06e3+yZVsQ?=
 =?iso-8859-1?Q?MN0slDPI0bPHzHH7JEuIbTMaWk/4og585CHM7hUJ1vCgtzn9PHnoMq4aoI?=
 =?iso-8859-1?Q?G5GQtqCtFga9naNcXZDYhKCD/xvhF4JqCDPy+CwwIrPufNpQM9Tc8qMqE2?=
 =?iso-8859-1?Q?v4AVJoBqhc1IRox7hi7HwNQRwj0i6hEa0ls/gqlECOJeO6k+wCiBEM4/hk?=
 =?iso-8859-1?Q?3al/tEAmhkFt8gZtQKu9TvrZ3bpuWzLyQnN8TnbaDAuuEFvLVBujWzdpUA?=
 =?iso-8859-1?Q?aUrvID73/zE3WV4kM7i6vS5i2bDYKakOuUtIJaUkuSitd+qrE7xuy19OeG?=
 =?iso-8859-1?Q?Mtfp2kuOpYCVcL+K5dK54aV4dm01zvJquEYlh8DjDw4A7xgaUE6rAKKFjT?=
 =?iso-8859-1?Q?wyPk5C6xtVB+UA2vq71HfmVXUNZMQCPISINHIqRRFZZ5Lh5mbnp5zm+LDE?=
 =?iso-8859-1?Q?2EoGBZcUgrrwnTDS6H8qndwIjuPi2xopU5Zcvj9NkXM90w1E28fjUqPVUJ?=
 =?iso-8859-1?Q?NWMefi+GNr/1HDD/nGdFsm6lpcNe1RuqbR3EQ+IuOgGLjiFVy56++fSiYh?=
 =?iso-8859-1?Q?Cl0N607U3e3Xuzr0IBesffCehQc3xr9+q0pHc8MdK0LIrKV1+o7XEdHrWD?=
 =?iso-8859-1?Q?PuicTvCtxzbXNppkEOepBFEsMVleubHJ4ZwHfizDCGCVarLGpPHCC0K/DP?=
 =?iso-8859-1?Q?MN4tcPNGEo/R5ImOP1AMV2hsZIZ1Vo8jD0Nvab+jVxfHJo+41rVcVs6HDI?=
 =?iso-8859-1?Q?NGMTKxZiDjEZ0SoIDhdITI90al3LD8AYyxuePOl+KYIPxl0bODUvf6CkHi?=
 =?iso-8859-1?Q?kHKOOlpCSFNa9Z5HHiWg/LWFutIjHiPKQ7DvgIhceAWDtZlQJOLqbnvvO1?=
 =?iso-8859-1?Q?jcWjJF9rtvu+NSVLFl4UiDeMd5ZbTEnpFTQkQQOGR+ZqlrhqlgGfmIIMPb?=
 =?iso-8859-1?Q?vmsGBmzOLkCF8UmY+oug+IT0+W8zdV8hWrSIwZpG8gYQQreu8OOX2FXan0?=
 =?iso-8859-1?Q?bJy2B03br5BHdToWk6bY7ick0b6I/0Sx4nMu26W8mdS5PZTffCwscToYxu?=
 =?iso-8859-1?Q?DrS2IpeOCTa5KD60E9ifFGpxePbTj3ahBfgZ6Q4OOej8a6lFot9ZRxanuE?=
 =?iso-8859-1?Q?WTnMCgTtYJrVX5x1hFhf3DmwdtKYJKPkJw+0hA+aads/LAn5pYFXw0zUky?=
 =?iso-8859-1?Q?gkhPqstsF58wV94kuhPPKbQxxskzivBrRleSS7+1hhh502wYpK1ycYFaHZ?=
 =?iso-8859-1?Q?79ZZYRlCdUj4+7taJQbSNddDhu0tokiIGYaaNfaKXNdPAWSkiyKli+mSVl?=
 =?iso-8859-1?Q?VLI6A1+CsUB+xuk0Hk8bxyQ40e8T75dVFpQAAoDK7oyYrWBEbEyxjywtTn?=
 =?iso-8859-1?Q?siCemCqdpuWRWwKe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?VjgBdTkkHsZoEByLufqVtzkS32pMUWhipHOaP5OgzLg4m21MXKJ+3mrK83?=
 =?iso-8859-1?Q?DYJnae4ENcLX1IjGTW6GXFCPjUAuqAApj7n0rci5jJTvmnk5KJmjukhwnN?=
 =?iso-8859-1?Q?N8eCq0LdfiSCdp2skZ6IISwR1DI7tAfHjiFEDO56mxXaS0dVgyX/MJFUNd?=
 =?iso-8859-1?Q?RUHhXkdQQwxy0rfQUFDgtdguWp0JH0NpHf9kzK+BX8M6B6muBQkr6xO3rk?=
 =?iso-8859-1?Q?L0+X0Whgjux3nbGC4D8wg3qqs66BLcS1c0Zz+s3p14SiLxWA+rnIx8fLyJ?=
 =?iso-8859-1?Q?nDimPE5MHsvvEpphZSQIrKanhceQaAKH9CHp/lz28Vj6ixWnMDQJpHXJhU?=
 =?iso-8859-1?Q?hRAFSTJ9wGV6tt4+A0L4lw9TgOJwDZTkio9+8h/B70aQiqsNTJUaFkfQVt?=
 =?iso-8859-1?Q?UEfb1Wzf3kEHDXeamQiyMMT4bWqiNxKhdV9S2gqlQdnCijW4Zedbyd5XG/?=
 =?iso-8859-1?Q?Ed9omNpAAofTfuOHWR3BZwNXWn2pBIu1N3wNDT4aQhv+UrTbY+4g3VVxGj?=
 =?iso-8859-1?Q?73nrDFSIy5Fu/cQXNmr6Ra7bKZW6rhWAUAandPdohkFETscnJJmNvTjhGA?=
 =?iso-8859-1?Q?323HXufRNCcn9vVipAnUQho4kVJ0C++gB0xn5tW4xvZ7RkTehYubccVqos?=
 =?iso-8859-1?Q?ViP8w1Q1NDp/c/x8y/+e0K6B1GfkDMEDp0xHsfVFrq2fgX0I5L7ACasiF5?=
 =?iso-8859-1?Q?sv/KRhu5i28p5jLdn8sQFmJzIMqWdrIqGm5XEC/M70Drd80sx/b5wrtxur?=
 =?iso-8859-1?Q?sQTslBBgISDtNY2aRacRaOKOBySumJwZ66/fTHe88rLEIzWWU01XsMSUiW?=
 =?iso-8859-1?Q?n9Yv8tFGQop4APXy9d4PON8FMdJ+Hz4Thk5l/UmVUcoQIzP8tT4X65+JnU?=
 =?iso-8859-1?Q?5iqmOtenRoW+5aizZiz+Zs+nSRYAYQwlN5shZ5Mwmc45GHBYnd4NyYoX7V?=
 =?iso-8859-1?Q?KAMDEz4C6X1AruAup27JUv9kUi1JDt1Vq3EISYzwBfivWw/8nN4fpBcsTB?=
 =?iso-8859-1?Q?HU7lUJTTCcrD/k0LdvrPa4M6FrnSioJynz2z0KMLPhTd+oFEndHXqQzgr2?=
 =?iso-8859-1?Q?ii7gQlQ5ZYCjsKj0+L8IMz06i60gCu6d75zKEgJp7Pmy/67lNGGQVm6w7n?=
 =?iso-8859-1?Q?BvbHv4r+e93SyHE76hoMmYc/5rczSL8WRZNe0rbHl7ITKxi0oqTy+OakTu?=
 =?iso-8859-1?Q?sAuEeHm8tlUaQ1JHEFg5YhWF2DGC3stJC4hJ6dAc9Z3uxWrwqTo2mr/LbC?=
 =?iso-8859-1?Q?Jsl+/2wTux4JYIYCDM77uNCYSHU1OhXShwVJp4/QoFwjPrh8yC4rHh6yRE?=
 =?iso-8859-1?Q?yjOhtWlAiTRskz3KpWTeqcu0g9Gi4SjsmSKY87tJDATIaIfB1WyQs1F/EK?=
 =?iso-8859-1?Q?bdIzRUQrBMkcboe2SQcaaLnlKU1//yVa+ExJBBaEygZVHiYlCYUc5VGo1y?=
 =?iso-8859-1?Q?baRLdLyncA+cMF6E4SJX7Owgae9vhwx5rWsA8I6mj6PDRa8B8NOUZbnenA?=
 =?iso-8859-1?Q?fuFAA7lm7hMDCh+D9qxEJi4BBGw5b6Qe94zOMricJ2DLiuisvU5GH7In7/?=
 =?iso-8859-1?Q?lQNUSKOfhpVaxx2UM02TvwR1Sj49Erkles9hc/pPv5G+6M/3ZfwqK4IKVG?=
 =?iso-8859-1?Q?Sf8SSLW4zjmARj4Ypmt8S0PVJsL5MIAVDPwmC59XFTh05sAoqs40ub4Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fce7f94c-2152-4c00-d9c8-08dda378a3a9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 15:01:09.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDK223SI50UKQSnsDs/eMt+PNjrRoB7bPhnCuOkCTxisPy9lIJXah1jFADGRx9kTzZ/9J9B2Tpgb1Cl6Gf9JZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 5.3% improvement of stress-ng.loop.ops_per_sec on:


commit: e7bc0010ceb403d025100698586c8e760921d471 ("loop: properly send KOBJ_CHANGED uevent for disk device")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: loop
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250604/202506042201.1d6ccec5-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp7/loop/stress-ng/60s

commit: 
  1fdb8188c3 ("loop: aio inherit the ioprio of original request")
  e7bc0010ce ("loop: properly send KOBJ_CHANGED uevent for disk device")

1fdb8188c3d50545 e7bc0010ceb403d025100698586 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.13 ±  6%      +0.1        0.19 ±  4%  mpstat.cpu.all.iowait%
      2.94 ±  2%      +0.8        3.69 ±  3%  mpstat.cpu.all.sys%
     32546           +30.4%      42443        vmstat.system.cs
     74083            +4.6%      77510        vmstat.system.in
      7889 ±118%    +373.6%      37367 ± 45%  numa-meminfo.node0.AnonHugePages
     21065 ±128%    +220.9%      67589 ± 32%  numa-meminfo.node0.Shmem
     11373 ±  3%     +21.7%      13841 ±  3%  numa-meminfo.node1.Active(file)
     22923 ±  5%     +16.8%      26769 ±  4%  meminfo.Active(file)
    448.71 ±  8%    +106.3%     925.77 ±  9%  meminfo.Inactive
    448.71 ±  8%    +106.3%     925.77 ±  9%  meminfo.Inactive(file)
    165282 ±  5%     +23.3%     203822 ±  2%  meminfo.Shmem
    549441 ±  5%     +18.0%     648129        numa-numastat.node0.local_node
    591390 ±  2%     +16.7%     690232 ±  2%  numa-numastat.node0.numa_hit
    614834 ±  5%     +14.1%     701232 ±  2%  numa-numastat.node1.local_node
    642698 ±  3%     +13.4%     729095 ±  2%  numa-numastat.node1.numa_hit
      6173 ± 64%     +72.8%      10667 ±  8%  sched_debug.cfs_rq:/.avg_vruntime.min
      6173 ± 64%     +72.8%      10667 ±  8%  sched_debug.cfs_rq:/.min_vruntime.min
     12139 ± 61%     +83.0%      22217        sched_debug.cpu.nr_switches.avg
     22304 ± 45%     +55.3%      34647 ±  6%  sched_debug.cpu.nr_switches.max
      7497 ± 68%    +100.9%      15063 ±  9%  sched_debug.cpu.nr_switches.min
    -77.83           +69.3%    -131.75        sched_debug.cpu.nr_uninterruptible.min
     15.60 ± 44%     +58.1%      24.65 ±  7%  sched_debug.cpu.nr_uninterruptible.stddev
      5562            +4.7%       5825        stress-ng.loop.ops
     91.71            +5.3%      96.60        stress-ng.loop.ops_per_sec
      6139 ±  2%      +8.7%       6671 ±  2%  stress-ng.time.involuntary_context_switches
    210787            +2.4%     215791        stress-ng.time.minor_page_faults
    167.83 ±  2%     +20.1%     201.50 ±  4%  stress-ng.time.percent_of_cpu_this_job_got
    102.43 ±  2%     +19.1%     122.04 ±  4%  stress-ng.time.system_time
    349026 ±  2%     +50.0%     523587        stress-ng.time.voluntary_context_switches
      2815 ±  6%     +20.4%       3390 ±  7%  numa-vmstat.node0.nr_active_file
      5302 ±129%    +219.5%      16943 ± 32%  numa-vmstat.node0.nr_shmem
      2814 ±  6%     +20.5%       3391 ±  7%  numa-vmstat.node0.nr_zone_active_file
    591173 ±  2%     +16.7%     689866 ±  2%  numa-vmstat.node0.numa_hit
    549224 ±  5%     +17.9%     647763        numa-vmstat.node0.numa_local
      2816 ±  2%     +26.8%       3569 ±  4%  numa-vmstat.node1.nr_active_file
     38.54 ± 63%    +213.0%     120.63 ± 23%  numa-vmstat.node1.nr_inactive_file
      2815 ±  2%     +26.9%       3571 ±  4%  numa-vmstat.node1.nr_zone_active_file
     38.54 ± 63%    +213.1%     120.67 ± 23%  numa-vmstat.node1.nr_zone_inactive_file
    641841 ±  3%     +13.6%     729026 ±  2%  numa-vmstat.node1.numa_hit
    613978 ±  5%     +14.2%     701163 ±  2%  numa-vmstat.node1.numa_local
    222483 ±  2%      +3.8%     230998        proc-vmstat.nr_active_anon
      5703 ±  4%     +22.3%       6976 ±  6%  proc-vmstat.nr_active_file
    966262            +1.1%     976967        proc-vmstat.nr_file_pages
    110.67 ±  6%    +105.8%     227.81 ±  9%  proc-vmstat.nr_inactive_file
     41661            +2.2%      42580        proc-vmstat.nr_mapped
     41337 ±  5%     +23.4%      50991 ±  2%  proc-vmstat.nr_shmem
     30961            +2.2%      31647        proc-vmstat.nr_slab_reclaimable
     46186            +2.4%      47285        proc-vmstat.nr_slab_unreclaimable
    222483 ±  2%      +3.8%     230998        proc-vmstat.nr_zone_active_anon
      5703 ±  4%     +22.3%       6976 ±  6%  proc-vmstat.nr_zone_active_file
    110.67 ±  6%    +105.8%     227.81 ±  9%  proc-vmstat.nr_zone_inactive_file
   1234795           +15.0%    1420254        proc-vmstat.numa_hit
   1164983           +15.9%    1350288        proc-vmstat.numa_local
   3262158            +4.5%    3407812        proc-vmstat.pgalloc_normal
   3097627            +3.9%    3219201        proc-vmstat.pgfree
      3787            +8.7%       4118        proc-vmstat.pgmajfault
     75121           +17.7%      88386        proc-vmstat.unevictable_pgs_culled
 2.333e+09 ±  2%      +8.1%  2.522e+09        perf-stat.i.branch-instructions
      1.88 ±  2%      -0.1        1.76        perf-stat.i.branch-miss-rate%
  47022551            +6.9%   50273881        perf-stat.i.cache-references
     35100           +29.6%      45490        perf-stat.i.context-switches
      1.63            +2.6%       1.67        perf-stat.i.cpi
 1.764e+10 ±  2%     +10.2%  1.944e+10        perf-stat.i.cpu-cycles
      1372 ±  2%     +22.2%       1676 ±  2%  perf-stat.i.cpu-migrations
 1.093e+10 ±  2%      +7.1%  1.171e+10        perf-stat.i.instructions
      0.01 ±142%    +888.9%       0.08 ± 33%  perf-stat.i.metric.K/sec
      1.94 ±  2%      -0.1        1.81        perf-stat.overall.branch-miss-rate%
      1.62            +2.7%       1.66        perf-stat.overall.cpi
 2.186e+09            +9.8%  2.401e+09        perf-stat.ps.branch-instructions
  43719263            +8.4%   47392135        perf-stat.ps.cache-references
     33090           +30.8%      43266        perf-stat.ps.context-switches
 1.651e+10           +11.8%  1.846e+10        perf-stat.ps.cpu-cycles
      1292 ±  2%     +23.7%       1598 ±  3%  perf-stat.ps.cpu-migrations
 1.022e+10            +8.9%  1.113e+10        perf-stat.ps.instructions
 6.273e+11            +8.8%  6.824e+11        perf-stat.total.instructions
      5.40 ± 28%     -48.0%       2.81 ± 31%  perf-sched.sch_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.01 ± 11%     +37.9%       0.02 ± 10%  perf-sched.sch_delay.avg.ms.__cond_resched.mutex_lock.blk_mq_unfreeze_queue_nomemrestore.loop_set_block_size.lo_simple_ioctl
      0.09 ± 48%     -73.0%       0.02 ± 69%  perf-sched.sch_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
      0.49 ± 12%     -25.7%       0.37 ±  9%  perf-sched.sch_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.05 ± 42%  +1.2e+05%      60.77 ±207%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.__synchronize_srcu.part.0
    998.14 ± 47%     -54.0%     458.71 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.04 ± 71%   +1978.2%       0.84 ±179%  perf-sched.sch_delay.max.ms.__cond_resched.dput.simple_recursive_removal.debugfs_remove.blk_unregister_queue
      0.02 ± 69%    +138.1%       0.04 ± 44%  perf-sched.sch_delay.max.ms.__cond_resched.mutex_lock.sync_bdevs.ksys_sync.__x64_sys_sync
      0.05 ± 27%     +72.4%       0.09 ± 49%  perf-sched.sch_delay.max.ms.blk_mq_freeze_queue_wait.loop_set_status.lo_ioctl.blkdev_ioctl
      0.00 ±107%   +2770.0%       0.10 ±148%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.open_last_lookups
     18.75 ± 12%     -29.8%      13.16 ±  3%  perf-sched.total_wait_and_delay.average.ms
     95102 ± 15%     +53.4%     145892 ±  4%  perf-sched.total_wait_and_delay.count.ms
     18.59 ± 12%     -29.8%      13.06 ±  3%  perf-sched.total_wait_time.average.ms
      9.20 ± 11%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.devtmpfs_work_loop.devtmpfsd.kthread.ret_from_fork
      3.44 ± 20%     -60.5%       1.36 ± 23%  perf-sched.wait_and_delay.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
     18.29 ± 85%    +145.1%      44.83 ± 40%  perf-sched.wait_and_delay.avg.ms.exp_funnel_lock.synchronize_rcu_expedited.bdi_unregister.del_gendisk
      1.83 ± 30%     +62.1%       2.97 ± 19%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      8.92 ± 21%     -42.3%       5.15 ±  5%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    467.37 ± 24%     -41.3%     274.21 ± 14%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
     97.15 ± 37%     -66.7%      32.36 ± 23%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__lru_add_drain_all
      2.79 ± 17%     +92.6%       5.37 ± 23%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.kernfs_find_and_get_ns
     60.00 ± 10%     -46.0%      32.38 ± 28%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
     54.09 ± 11%     -20.3%      43.09 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      6658 ± 12%     +25.6%       8362 ±  4%  perf-sched.wait_and_delay.count.__cond_resched.loop_process_work.process_one_work.worker_thread.kthread
    539.83 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.devtmpfs_work_loop.devtmpfsd.kthread.ret_from_fork
     15267 ± 29%    +141.0%      36792 ± 18%  perf-sched.wait_and_delay.count.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      4141 ± 12%     +67.7%       6944 ±  5%  perf-sched.wait_and_delay.count.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
     10673 ± 14%     +70.0%      18140 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
     29.17 ± 17%     +88.6%      55.00 ±  9%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
    104.50 ± 16%    +119.0%     228.83 ± 12%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.__lru_add_drain_all
     29.33 ± 18%     -73.3%       7.83 ± 34%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.bdev_release
    607.50 ± 48%     +49.9%     910.67 ±  5%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.lo_open
    125.33 ± 42%    +373.4%     593.33 ± 17%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.__mutex_lock.constprop.0.sync_bdevs
      7635 ± 14%     +68.4%      12861 ± 12%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.kernfs_dop_revalidate
    775.50 ± 19%     +40.1%       1086 ±  8%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.kernfs_find_and_get_ns
    866.50 ± 15%     +48.2%       1284 ± 12%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.kernfs_iop_lookup
      1961 ± 17%     +29.7%       2544 ±  6%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.kernfs_remove
      2905 ± 22%     +52.3%       4425 ±  6%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.kernfs_remove_by_name_ns
    229.00 ± 11%     -43.4%     129.50 ± 19%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
    877.50 ± 14%     +24.1%       1089 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.__wait_for_common.__synchronize_srcu.part.0
     10423 ± 13%     +29.2%      13464 ±  4%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     10975 ± 12%     +20.2%      13195 ±  4%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1238 ± 24%     -29.2%     876.43 ± 13%  perf-sched.wait_and_delay.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1350 ± 30%     -39.9%     811.58 ± 18%  perf-sched.wait_and_delay.max.ms.blk_mq_freeze_queue_wait.loop_set_status.loop_set_status_old.blkdev_ioctl
      1281 ± 34%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.devtmpfs_work_loop.devtmpfsd.kthread.ret_from_fork
      1349 ± 30%     -40.6%     801.82 ± 20%  perf-sched.wait_and_delay.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    896.11 ± 53%     -61.3%     347.06 ± 43%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__lru_add_drain_all
      1324 ± 31%     -60.0%     529.55 ± 32%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      1345 ± 30%     -42.5%     773.93 ± 23%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.devtmpfs_submit_req.devtmpfs_create_node
      1329 ± 31%     -52.1%     637.20 ± 29%  perf-sched.wait_and_delay.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp
      0.00 ±147%   +4468.8%       0.12 ±130%  perf-sched.wait_time.avg.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kvasprintf.kobject_set_name_vargs.kobject_add
      0.07 ±  2%     -33.3%       0.05 ± 21%  perf-sched.wait_time.avg.ms.__cond_resched.__wait_for_common.submit_bio_wait.blkdev_issue_flush.blkdev_fsync
      0.05 ±101%  +78602.4%      37.91 ±184%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc_noprof.__kernfs_new_node.kernfs_new_node.__kernfs_create_file
     11.08 ±102%     -99.7%       0.03 ±108%  perf-sched.wait_time.avg.ms.__cond_resched.lo_read_simple.loop_process_work.process_one_work.worker_thread
      0.02 ± 33%     -73.9%       0.01 ±142%  perf-sched.wait_time.avg.ms.__cond_resched.mutex_lock.bd_abort_claiming.loop_configure.lo_ioctl
      3.41 ± 21%     -60.4%       1.35 ± 23%  perf-sched.wait_time.avg.ms.do_nanosleep.hrtimer_nanosleep.common_nsleep.__x64_sys_clock_nanosleep
      1.83 ± 30%     +61.4%       2.95 ± 20%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.filemap_update_page.filemap_get_pages
      8.86 ± 21%     -42.3%       5.12 ±  5%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.ep_poll.do_epoll_wait.__x64_sys_epoll_wait
    467.29 ± 24%     -41.3%     274.19 ± 14%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.poll_schedule_timeout.constprop.0.do_poll
     96.08 ± 38%     -66.6%      32.11 ± 24%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__lru_add_drain_all
      0.07 ± 42%    +494.5%       0.41 ±104%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_pm_qos_constraints_destroy
      2.38 ±103%   +1749.5%      44.04 ± 42%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.lo_simple_ioctl
      2.73 ± 16%     +96.2%       5.36 ± 23%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.kernfs_find_and_get_ns
      3.18 ± 75%    +171.8%       8.65 ± 24%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.kernfs_iop_permission
     59.89 ± 10%     -46.1%      32.26 ± 29%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      0.04 ± 25%     +72.9%       0.07 ± 27%  perf-sched.wait_time.avg.ms.schedule_timeout.__wait_for_common.devtmpfs_submit_req.devtmpfs_delete_node
      3.13 ± 22%    +116.4%       6.77 ± 59%  perf-sched.wait_time.avg.ms.schedule_timeout.synchronize_rcu_expedited_wait_once.synchronize_rcu_expedited_wait.rcu_exp_wait_wake
     53.60 ± 11%     -20.3%      42.72 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      0.00 ±150%   +7429.4%       0.21 ±109%  perf-sched.wait_time.max.ms.__cond_resched.__kmalloc_node_track_caller_noprof.kvasprintf.kobject_set_name_vargs.kobject_add
    236.96 ±105%     -99.7%       0.59 ±182%  perf-sched.wait_time.max.ms.__cond_resched.lo_read_simple.loop_process_work.process_one_work.worker_thread
      0.16 ± 71%     -96.4%       0.01 ±142%  perf-sched.wait_time.max.ms.__cond_resched.mutex_lock.bd_abort_claiming.loop_configure.lo_ioctl
      1238 ± 24%     -29.2%     876.42 ± 13%  perf-sched.wait_time.max.ms.__cond_resched.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      1350 ± 30%     -39.9%     811.55 ± 18%  perf-sched.wait_time.max.ms.blk_mq_freeze_queue_wait.loop_set_status.loop_set_status_old.blkdev_ioctl
    872.85 ±  8%     -26.5%     641.54 ± 20%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.do_group_exit.__x64_sys_exit_group.x64_sys_call
      1349 ± 30%     -40.6%     801.76 ± 20%  perf-sched.wait_time.max.ms.io_schedule.folio_wait_bit_common.filemap_fault.__do_fault
    894.57 ± 53%     -61.2%     347.04 ± 43%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.__lru_add_drain_all
      4.21 ±101%   +1975.4%      87.43 ±134%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.dev_pm_qos_constraints_destroy
      7.31 ±114%   +7928.3%     586.82 ± 40%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.lo_simple_ioctl
      1324 ± 31%     -60.0%     529.52 ± 32%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.__flush_work.__lru_add_drain_all
      1345 ± 30%     -42.5%     773.91 ± 23%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.devtmpfs_submit_req.devtmpfs_create_node
      1329 ± 31%     -52.5%     630.99 ± 28%  perf-sched.wait_time.max.ms.schedule_timeout.__wait_for_common.wait_for_completion_state.__wait_rcu_gp




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

