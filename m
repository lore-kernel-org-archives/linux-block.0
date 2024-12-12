Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DF2E414;
	Thu, 12 Dec 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734011569; cv=fail; b=anDppO1Om6nMXRDZkqE0GZ0y5j1tNwNfjAJfk2Yup6H9z621k4FFhXtRd5Vt46KwHldxpIU5Yu0/uoV9XB5Ls8Cgtf5h1YvUNjCJQ5lAPK4ppIxPDTa5GPC7lNdZ9q1+74qXE++QkLhpeodrKjrM0HmddgnesFY1D/BmXPqlumM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734011569; c=relaxed/simple;
	bh=I1O0GQF58OaXcTKwFbs2uKu5fVlwEPYqTGZ7ossz0S0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pktQBUOCzreUTuuq3tMeygMy8jazFqCAw/OLDR/tyubiueQYy5YWIm70hrNiczaenPGGYk5MIgpvBb3OsMc3nzvlPSgBRAe+ZTUpHUw51J8nrZfhKnpyFFiK5YJLbjueUfLQPOb6mDzc+NLvDCX3y9vR/8ilnObMa+z/HwFTQQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KIrtgLI5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KIrtgLI5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734011565; x=1765547565;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=I1O0GQF58OaXcTKwFbs2uKu5fVlwEPYqTGZ7ossz0S0=;
  b=KIrtgLI5H6WWC/Q9wKX+Qj85QUar+v5H4GrxO2g5TFaegW3McgRqceiH
   44x7sbAu5VHBGuchhcLy4Gg9mAh6qz+OhF+oXe9oJMLIhjogA7I9NKUIN
   DnowFtoXrl1j4AUsITlpSoj/GwBG01mBLwxDzcbq/85IYDjtyGLjh0URh
   GeXrdR20b9dUNnVs+P7UIfIHhDuAFHpAky/Gl+SQ2EKIG5STZTmmEqGqR
   m0ixDz4qqic+GMP9Lrj8NZouamEpVf3lXhxKJtQu4QOdGR3gck7AkPX9H
   UmNr5YYIv6MbFxoQdAF3XG1Wa/q+2576DRfcDPo6VQyP0KMRlvqvWoTfZ
   w==;
X-CSE-ConnectionGUID: nxF/76lxR5Opc3l+QH7JlQ==
X-CSE-MsgGUID: 8SG5oOosRwiqRVnePKUvsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34567828"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="34567828"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 05:52:44 -0800
X-CSE-ConnectionGUID: TLC4TgLfTwqciJFZvbVDyA==
X-CSE-MsgGUID: xwzxgoBvTkynpDgT8a5IMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="127037917"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 05:52:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 05:52:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 05:52:42 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 05:52:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSz4vfWlAfA1wZxJHeBbJO3UKxUfBvAxGi/C50QLY1fArUVZCIbIRFE+HusAVdjRU8yEJeOXO4EpU/biSJkWjGmlkiYYaEjoEOTHjfCDF3KIr+XO0vi8GWSpfmrgFeLnT7KK1QZMLoYV0V+7g+Av2LwO/I2jgNNdlZ6p5hsG0r/3xj24sKArYjPrADetWAo91vEkHjRNgVzeBissNJKuun4c4Su2QiQZ6nqveWcLljD+Ho6HB/h6iIFGAhn04WhP7D7DQR6HhAkU+LCtY2LUTtBRaqle0w8DaF7EmVNPXjcGxvhcBr6RKypKG2J0ZHfwxpHhp5Rw5ztSZHZV9xe1Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGL2lGpMSobeKqXt3fPrY/RkMHy0y9S6gr8w0dX0v5g=;
 b=F786bPhU6Ehnt9JJzhfEMgQScD0QnZ9xUI2yEeaGDHuf8g0o/eioTQEV/cUIuwJJm0lYqPIL0cXesaKvtjc7eecz4sKqXhEk/6hk4vYD/X0OXj3NdygYGgZALcM/7QiUl5QWzix9gkLfeK6NpdvlhDNspaeVAjodcfpyUTy5eEOpXNnjAvEcwxfhd6PXJmJhf2H8MaExFDFkD34J3amGU3DLv3gYqOUXbfq4pKBGpKY0rI7MKiXJbJl2I9PrRzpTkQ3XlJTx93+ID49XX1bV51/AiaczqzdVQSaMAB3uYQhivgp21f8CDcEw2RledjD7fKWUK6/gmFzrywHn0PiOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Thu, 12 Dec
 2024 13:51:56 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 13:51:56 +0000
Date: Thu, 12 Dec 2024 21:51:45 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-nvme@lists.infradead.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  e70c301fae:  stress-ng.aiol.ops_per_sec
 49.6% regression
Message-ID: <202412122112.ca47bcec-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: d4027193-528e-49cd-caa3-08dd1ab42420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?5F4r8Fj5/i8k05g9SttvbjFQkH50fqwHqDTte/0gXREr64XWD13eW5A+FB?=
 =?iso-8859-1?Q?UoxQwEAy3A4tlpk9i87dBwI+KbRNM/kK0NApCB187dAK+N0aKzN5IrsErq?=
 =?iso-8859-1?Q?o2RWpfSGaNuQH72I9trM/ilUt+1Xg6gJqwg930NQ/t/A6qwOan2i1cFbB9?=
 =?iso-8859-1?Q?yNLOZIRlkGteRtbGXU+++0lap77fu5V6NLPIZMKar01bmQKnIaZ5DAooWh?=
 =?iso-8859-1?Q?elADL7I0yk9Kh49VdvhZ8rSsGwIxvmrBpX7jDZK7SzMsnNdIXwX+gi+IJg?=
 =?iso-8859-1?Q?My/IfQNWVrEjZEuoxAJZPQXabOEJgGlvrg4bu2lOmnKe51FiY5pAg9z5Gj?=
 =?iso-8859-1?Q?BH4nV44soIuu39P7AT4hVsH0ChXSJvVJHk2yRdnELvq2lGc1OL7uZbIsYA?=
 =?iso-8859-1?Q?PFoHy0b2fMpDPXc0nb6PQ3LQ8r0V7n/2bEDOFgG9M/xLK8+rFyqOUdGV8o?=
 =?iso-8859-1?Q?6QUOXkTd4gCx76qsCKTSfaoZtiklb1R09xkAhSvM5N+er9ClRUP5RcSkPe?=
 =?iso-8859-1?Q?vQneCBS0JJjTi2NZCku5i3hb3MNEFCjefRDqSpahougSNEWxHHIQsUkVup?=
 =?iso-8859-1?Q?/dogv3tfeDq1R/Bw1ikqMLfsB4G7aozCjJAoVpS5ZZqTG1qoFjxCArHG3n?=
 =?iso-8859-1?Q?ooqQrZAWgAbzRz01wkqZ7cLWjuxP/O2ne7FQboHAIkBJDbR57bJdyRKPkq?=
 =?iso-8859-1?Q?HD6lvOdFZc+L4XzJZMme1seZg+J75d+cFjtE6Zvvx5S8i3OzJM28z544MA?=
 =?iso-8859-1?Q?kpKeMuuLPBlm+pmOLq2kqosICNvTmhm029edbvC+BiJn4ts0NzZrT5/B2j?=
 =?iso-8859-1?Q?sUfoMxb5Y6niutMbO6wcjJRUCZQh/nQISjBgwL5vvdawSOAzUFNaKUM8Ew?=
 =?iso-8859-1?Q?fy9QLFb2zp22XFRxf66x+u8ngeXOk8/mNw8ZAB9VRY4lK4ITYPjkIyWMC7?=
 =?iso-8859-1?Q?+OsBI1dtrJyPuvPGwdJUsCfktBxYn7qkLi145AnkXOd7hfzjfnlMQN3amL?=
 =?iso-8859-1?Q?aY7oShGY+T5Dwm+WyxMDn8weeQbptKsbRHJVqVQNt9n2eeNF1u53E/Wdx1?=
 =?iso-8859-1?Q?Nj1X4NKxejJWVRCgCvZJ0x6qTtTfqdLSat8B3jNMIEGy0GM6hcM+7lly3x?=
 =?iso-8859-1?Q?I2Pt3BTvzf0rQp6hhJQEiU3VttIg5ovJvATLdPRolTa5TrDvuyeqcXY4MB?=
 =?iso-8859-1?Q?af4TyUKO9tMkuu9NoWOxC/9QMQGuCs/dsZVGVZuc514Z1bbp98pRyZvEru?=
 =?iso-8859-1?Q?X2FGJ1UuSNOPpOHbQVi5PcvAkohBMFKka7Jfg6NMdYA/153DsB/+MbZ3so?=
 =?iso-8859-1?Q?q+w6LqqM3NFxFQiNj+vurU4oIN2BHCYSqIYUSeSkVbLm0G1rzR7DGFmmrJ?=
 =?iso-8859-1?Q?RarCB83b7y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ufLE8rG1AIqV2TCElrW4p7WAWf8r3Fud4ZnvzVrhsVfyWw95A4bRxROaXH?=
 =?iso-8859-1?Q?mg7sB7BMfPQyMsYyoXZmje8h3i6X9W82EyY2+ReOissy0Tm5ni77vRLF2E?=
 =?iso-8859-1?Q?Q3ssZ+tpLQbXEZeBZ9BJEb9HmvW3otJRgAIbrdpFpA6pF4EwMi2S4DGEVF?=
 =?iso-8859-1?Q?nOSnWvl4sWC/UMG4PYqMISrHlW9mIdNz/Ks7RlHCgaqPUU7joUWx33+lDZ?=
 =?iso-8859-1?Q?WNHSclEIvhEmmtDw8fqw5CEADKcvtgc6kXmwvF4hTAU0zGG6qN0o343PsC?=
 =?iso-8859-1?Q?GKvU96DOtqTgodQmlx3ojuaWZQ9ec+pRzBrn1pDL+R8AllCjLju3bp5i28?=
 =?iso-8859-1?Q?FFxILfZPqvzg9HuV1luFE5wmp9tTgF8YI7HEhuiRHxPyOhFWHdsUkC4Gan?=
 =?iso-8859-1?Q?tulyghukWdb2yH9Oy1agIfYqbqA6Le11Rb+w12RX0s5l10M1uwwA/0Uqgi?=
 =?iso-8859-1?Q?RVdmsllVz0WgNmnCohBuNvgcnYY+Y6qEqnoiB+z5Q8SWBiG3JhpAM32OLr?=
 =?iso-8859-1?Q?bNks8p5T4bjtemSeeblPV/mRrzhIwTvw1Xhi8yaeDZMVFqurJZeySUOEJ9?=
 =?iso-8859-1?Q?Z8sqhICqP5tXUJOzXLPS6nmfQjeUby7en4YIN5qi0HKX5TFjeIuY3IaMaB?=
 =?iso-8859-1?Q?8qYHXTOY0Z+enGzdi9+hj+7yCykSWR/PhnaeIq5Jml101e6lCwgEb0H43n?=
 =?iso-8859-1?Q?Gakoi/NdSA6y3dHoVLwq3MIyAHCK6sl7Nic96Ugik/IoCVZN69xSWdZyq0?=
 =?iso-8859-1?Q?1sOvXpnL7yqr1iHX14y8O/fQcWeM5c5bGh08ag9VM/Jw3Bi7fmvRZ2i5EZ?=
 =?iso-8859-1?Q?SmavS2n5yEteXCOkrMB+5hwJzIDSHgYJKNMfh5xV+5oxawyMtSAsw8IWoo?=
 =?iso-8859-1?Q?zTkebQUtLZasL9jFoO9oJqbBzn4Gmuy5QbyYsHSEt5+IcDf1RrJy101Cnf?=
 =?iso-8859-1?Q?8AD4UD77md7SIOMb1e9bxUQsmY4NJbQfEsiOY402bOsdmPZyKIF2pKhvvf?=
 =?iso-8859-1?Q?LX/4xCIalyJxM5f8IW1fagliZim99g3Cn1h5cW4ApTfWyOO+rPMu+BrqHm?=
 =?iso-8859-1?Q?9MI5Dh5BwAIvmKH7mpkl4Jr/5cJe2Hw5i8Qh897PU2TJlIY0cqbf9uXt0E?=
 =?iso-8859-1?Q?zTNggxIBIzSycLZqTBZ3eLi347F8f+9ruPCD8xQIek8qBJk++fvP65n2B6?=
 =?iso-8859-1?Q?TQKVssSYks8VQBHhzmqPhjb5TDONWs0i5cV9RD5K3xi/t6RUJT1OxxaRYC?=
 =?iso-8859-1?Q?TIg6X9bbHQTHTHsgJqTTSUEpAPdadiZJuV5FlsBUoiBWxaeE15ClPvPvir?=
 =?iso-8859-1?Q?k2cdGbdVlf75YSQl7eAGY5r3cZVxfvVgulXNg3p/nULmHiufFimdL6WGGh?=
 =?iso-8859-1?Q?wPmA5mCT3F9NRFD5HwkWsr/kp40AHcPMcg+tK3sCjZ+P+WA+qOYefVUtp5?=
 =?iso-8859-1?Q?imcbDW8/33XLxawNVDgJC65ZSOLYptnqg2TtDmJC7DpLqK114yDKjuCa9B?=
 =?iso-8859-1?Q?I7naCj17U9cJ+/vcY52QQH1fvklwd5SxqlXzx1AVAFmXK+qoE6xfHhJ5Ba?=
 =?iso-8859-1?Q?6fY4gXhyq5w3TA25obNeEVK1PhAUeGbgAjRKpp11MSZriMqrVQ1Z6bogmu?=
 =?iso-8859-1?Q?7fnOrGTBU8hxnyd1Kke1LB5IOaOWVXE2+DKJEe/F3wnnFL05K+vjYpDA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d4027193-528e-49cd-caa3-08dd1ab42420
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 13:51:56.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4QKCKkgeojlroa7nJQ5NBCV3wd8FkTp6rWSGo31k903dSFaL9Yel8PO5u/1ONxT415PIOFw1OSbcoL3nFGpNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 49.6% regression of stress-ng.aiol.ops_per_sec on:


commit: e70c301faece15b618e54b613b1fd6ece3dd05b4 ("block: don't reorder requests in blk_add_rq_to_plug")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      fac04efc5c793dccbd07e2d59af9f90b7fc0dca4]
[test failed on linux-next/master d1486dca38afd08ca279ae94eb3a397f10737824]

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: aiol
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412122112.ca47bcec-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241212/202412122112.ca47bcec-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-9.4/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/aiol/stress-ng/60s

commit: 
  a3396b9999 ("block: add a rq_list type")
  e70c301fae ("block: don't reorder requests in blk_add_rq_to_plug")

a3396b99990d8b4e e70c301faece15b618e54b613b1 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      7255 ± 16%     -58.9%       2980 ± 43%  meminfo.Dirty
      0.46 ±  6%      -0.2        0.27 ± 41%  mpstat.cpu.all.sys%
      4098 ± 19%     -61.6%       1572 ± 45%  numa-meminfo.node0.Dirty
     15179 ±  9%     -39.9%       9129 ± 29%  numa-meminfo.node0.Inactive
     15179 ±  9%     -39.9%       9129 ± 29%  numa-meminfo.node0.Inactive(file)
      3156 ± 16%     -55.4%       1407 ± 45%  numa-meminfo.node1.Dirty
     23.83 ± 29%     -48.0%      12.40 ± 46%  perf-c2c.DRAM.local
    202.67 ± 17%     -41.7%     118.20 ± 49%  perf-c2c.DRAM.remote
    622.33 ± 26%     -69.1%     192.60 ± 58%  perf-c2c.HITM.local
    122.50 ± 15%     -41.2%      72.00 ± 53%  perf-c2c.HITM.remote
     15194           -56.2%       6657 ± 43%  vmstat.io.bi
     16790           -56.3%       7342 ± 43%  vmstat.io.bo
     22019 ±  3%     -24.5%      16634 ± 40%  vmstat.system.cs
     15532 ±  3%     -24.5%      11724 ± 37%  vmstat.system.in
     12019           -50.4%       5962 ±  8%  stress-ng.aiol.ops
    194.98           -49.6%      98.31 ±  8%  stress-ng.aiol.ops_per_sec
   2073172           -49.6%    1044401 ±  8%  stress-ng.time.file_system_inputs
   2084970           -49.4%    1055513 ±  8%  stress-ng.time.file_system_outputs
      1922 ±  7%     -24.8%       1445 ± 13%  stress-ng.time.involuntary_context_switches
 3.095e+08 ± 44%    +181.6%  8.717e+08 ± 22%  sched_debug.cfs_rq:/.avg_vruntime.avg
 6.608e+08 ± 44%    +179.8%  1.849e+09 ± 25%  sched_debug.cfs_rq:/.avg_vruntime.max
 1.772e+08 ± 45%    +148.3%    4.4e+08 ± 23%  sched_debug.cfs_rq:/.avg_vruntime.stddev
 3.095e+08 ± 44%    +181.6%  8.717e+08 ± 22%  sched_debug.cfs_rq:/.min_vruntime.avg
 6.608e+08 ± 44%    +179.8%  1.849e+09 ± 25%  sched_debug.cfs_rq:/.min_vruntime.max
 1.772e+08 ± 45%    +148.3%    4.4e+08 ± 23%  sched_debug.cfs_rq:/.min_vruntime.stddev
     53105 ± 31%     +42.2%      75514 ± 20%  sched_debug.cpu.nr_switches.max
      6432 ± 23%     +41.5%       9102 ± 24%  sched_debug.cpu.nr_switches.stddev
      1.18 ±  6%     +14.6%       1.35 ±  7%  perf-stat.i.MPKI
   2264970 ±  4%     -21.6%    1774741 ± 42%  perf-stat.i.cache-misses
  14367937 ±  4%     -25.8%   10657347 ± 39%  perf-stat.i.cache-references
     22898 ±  2%     -24.7%      17251 ± 40%  perf-stat.i.context-switches
    264.46           -23.7%     201.77 ± 29%  perf-stat.i.cpu-migrations
   2229725 ±  4%     -21.6%    1748143 ± 42%  perf-stat.ps.cache-misses
  14196908 ±  4%     -25.8%   10534892 ± 39%  perf-stat.ps.cache-references
     22505 ±  2%     -24.5%      16988 ± 40%  perf-stat.ps.context-switches
    259.81           -23.5%     198.87 ± 28%  perf-stat.ps.cpu-migrations
     19273 ±  6%     -50.4%       9553 ± 16%  proc-vmstat.nr_dirtied
      1811 ± 16%     -58.8%     747.04 ± 43%  proc-vmstat.nr_dirty
    287118 ± 11%     -46.1%     154669 ± 21%  proc-vmstat.nr_foll_pin_acquired
    286762 ± 11%     -46.1%     154498 ± 21%  proc-vmstat.nr_foll_pin_released
     47285            -3.1%      45797        proc-vmstat.nr_slab_unreclaimable
     12135 ± 12%     -48.4%       6257 ± 24%  proc-vmstat.nr_written
      1843 ± 16%     -59.1%     754.35 ± 43%  proc-vmstat.nr_zone_write_pending
   1038012           -49.5%     523912 ±  8%  proc-vmstat.pgpgin
   1140714           -49.4%     577696 ±  7%  proc-vmstat.pgpgout
     10960 ± 15%     -55.4%       4891 ± 24%  numa-vmstat.node0.nr_dirtied
      1024 ± 19%     -61.2%     397.79 ± 44%  numa-vmstat.node0.nr_dirty
      3802 ±  9%     -39.6%       2295 ± 29%  numa-vmstat.node0.nr_inactive_file
      6553 ± 14%     -53.4%       3052 ± 28%  numa-vmstat.node0.nr_written
      3802 ±  9%     -39.6%       2295 ± 29%  numa-vmstat.node0.nr_zone_inactive_file
      1040 ± 18%     -61.4%     401.60 ± 44%  numa-vmstat.node0.nr_zone_write_pending
      8307 ± 23%     -43.8%       4668 ± 13%  numa-vmstat.node1.nr_dirtied
    789.47 ± 17%     -55.0%     355.05 ± 44%  numa-vmstat.node1.nr_dirty
    152867 ± 25%     -48.3%      79072 ± 32%  numa-vmstat.node1.nr_foll_pin_acquired
    152678 ± 25%     -48.3%      78987 ± 32%  numa-vmstat.node1.nr_foll_pin_released
      5610 ± 20%     -42.9%       3204 ± 21%  numa-vmstat.node1.nr_written
    802.63 ± 17%     -55.2%     359.41 ± 44%  numa-vmstat.node1.nr_zone_write_pending
      0.01 ± 13%     -68.2%       0.00 ±123%  perf-sched.sch_delay.avg.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.alloc_ordered_extent
      0.05 ± 28%     -40.2%       0.03 ± 48%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.00           +60.0%       0.00 ± 33%  perf-sched.sch_delay.avg.ms.read_events.do_io_getevents.__x64_sys_io_getevents.do_syscall_64
      0.00 ± 16%     -76.0%       0.00 ±126%  perf-sched.sch_delay.avg.ms.wait_extent_bit.__lock_extent.lock_extent_direct.btrfs_dio_iomap_begin
      0.01 ± 31%     -72.3%       0.00 ±123%  perf-sched.sch_delay.max.ms.__cond_resched.kmem_cache_alloc_noprof.alloc_extent_state.__clear_extent_bit.alloc_ordered_extent
      0.01 ± 10%     -62.0%       0.00 ± 86%  perf-sched.sch_delay.max.ms.btrfs_start_ordered_extent.lock_extent_direct.btrfs_dio_iomap_begin.iomap_iter
      2.74 ± 27%    +119.7%       6.01 ±  7%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
     21.25 ± 19%     -26.6%      15.59 ± 12%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1673 ± 32%     -65.0%     585.60 ± 16%  perf-sched.wait_and_delay.count.read_events.do_io_getevents.__x64_sys_io_getevents.do_syscall_64
      1525 ± 34%     -66.4%     513.00 ± 14%  perf-sched.wait_and_delay.count.read_events.do_io_getevents.__x64_sys_io_pgetevents.do_syscall_64
     16361 ± 35%     -70.0%       4902 ± 14%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      4150 ± 36%     -77.8%     919.40 ± 11%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      1875 ± 46%     -49.2%     952.68 ± 28%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
    793.53 ± 29%     -79.1%     165.96 ± 40%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      0.74 ±200%   +1271.2%      10.09 ±112%  perf-sched.wait_time.avg.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.iomap_dio_bio_iter.__iomap_dio_rw
      2.73 ± 27%    +119.8%       6.01 ±  7%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
     12.42 ± 84%     -98.5%       0.18 ±141%  perf-sched.wait_time.avg.ms.wait_extent_bit.__lock_extent.lock_extent_direct.btrfs_dio_iomap_begin
     21.24 ± 19%     -26.6%      15.59 ± 12%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1.41 ±211%    +748.9%      11.93 ± 98%  perf-sched.wait_time.max.ms.__cond_resched.mempool_alloc_noprof.bio_alloc_bioset.iomap_dio_bio_iter.__iomap_dio_rw
    301.54 ±120%     -91.8%      24.72 ±143%  perf-sched.wait_time.max.ms.btrfs_start_ordered_extent.lock_extent_direct.btrfs_dio_iomap_begin.iomap_iter
      1875 ± 46%     -49.2%     952.68 ± 28%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
    793.52 ± 29%     -79.1%     165.95 ± 40%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
     55.91 ± 53%     -87.3%       7.09 ±163%  perf-sched.wait_time.max.ms.wait_extent_bit.__lock_extent.lock_extent_direct.btrfs_dio_iomap_begin
     42.68 ±  7%     -19.6       23.04 ± 12%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     46.80 ±  7%     -17.8       29.00 ± 11%  perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
     34.30 ±  7%     -17.1       17.20 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread.kthread
     34.36 ±  7%     -17.1       17.31 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_work_helper.process_one_work.worker_thread.kthread.ret_from_fork
     47.97 ±  6%     -16.9       31.09 ± 10%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork.ret_from_fork_asm
     47.97 ±  6%     -16.9       31.09 ± 10%  perf-profile.calltrace.cycles-pp.ret_from_fork.ret_from_fork_asm
     47.97 ±  6%     -16.9       31.09 ± 10%  perf-profile.calltrace.cycles-pp.ret_from_fork_asm
     28.65 ±  9%     -15.7       12.91 ± 13%  perf-profile.calltrace.cycles-pp.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work.worker_thread
     26.61 ± 11%     -15.3       11.30 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
     21.54 ± 13%     -13.7        7.83 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
     21.56 ± 13%     -13.7        7.85 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
     16.80 ± 10%     -10.8        6.01 ± 16%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot
     16.60 ± 10%     -10.7        5.93 ± 16%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node
     16.50 ± 12%     -10.6        5.88 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
     16.44 ± 12%     -10.6        5.83 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents
     16.43 ± 12%     -10.6        5.83 ± 16%  perf-profile.calltrace.cycles-pp.down_write.btrfs_tree_lock_nested.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent
     12.05 ± 14%      -7.8        4.23 ± 18%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      5.57 ±  6%      -3.6        1.97 ± 27%  perf-profile.calltrace.cycles-pp.rwsem_spin_on_owner.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested
      2.03 ± 17%      -1.6        0.45 ± 86%  perf-profile.calltrace.cycles-pp.down_write.btrfs_tree_lock_nested.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents
      2.04 ± 18%      -1.6        0.46 ± 86%  perf-profile.calltrace.cycles-pp.btrfs_tree_lock_nested.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      1.98 ± 17%      -1.5        0.44 ± 86%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_search_slot.btrfs_lookup_file_extent
      2.06 ± 15%      -1.5        0.53 ± 55%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.btrfs_tree_lock_nested.btrfs_search_slot
      3.00 ± 12%      -1.1        1.90 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      2.92 ± 12%      -1.1        1.83 ± 18%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
      3.04 ± 36%      -1.0        2.02 ± 14%  perf-profile.calltrace.cycles-pp.iomap_iter.__iomap_dio_rw.btrfs_direct_write.btrfs_do_write_iter.aio_write
      2.96 ± 36%      -1.0        1.96 ± 14%  perf-profile.calltrace.cycles-pp.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw.btrfs_direct_write.btrfs_do_write_iter
      1.36 ±  8%      -0.9        0.43 ± 84%  perf-profile.calltrace.cycles-pp.btrfs_tree_read_lock_nested.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents
      1.36 ±  8%      -0.9        0.43 ± 84%  perf-profile.calltrace.cycles-pp.down_read.btrfs_tree_read_lock_nested.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent
      1.47 ± 11%      -0.9        0.58 ± 54%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      2.37 ± 44%      -0.9        1.51 ± 16%  perf-profile.calltrace.cycles-pp.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw.btrfs_direct_write
      1.27 ±  9%      -0.9        0.42 ± 84%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested.btrfs_read_lock_root_node.btrfs_search_slot
      1.34 ±  9%      -0.7        0.66 ± 54%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.process_one_work.worker_thread.kthread.ret_from_fork
      1.22 ±  9%      -0.6        0.60 ± 53%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.process_one_work.worker_thread.kthread
      0.92 ± 10%      -0.6        0.35 ± 85%  perf-profile.calltrace.cycles-pp.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested.btrfs_read_lock_root_node
      0.90 ± 10%      -0.5        0.35 ± 85%  perf-profile.calltrace.cycles-pp.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.btrfs_tree_read_lock_nested
      0.89 ± 10%      -0.5        0.35 ± 84%  perf-profile.calltrace.cycles-pp.__schedule.schedule.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read
      1.49 ±  9%      -0.3        1.17 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_new_extent_direct.btrfs_get_blocks_direct_write.btrfs_dio_iomap_begin.iomap_iter.__iomap_dio_rw
      1.14 ± 12%      -0.3        0.83 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_del_items.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.65 ± 16%      -0.3        0.35 ± 82%  perf-profile.calltrace.cycles-pp.add_delayed_ref.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      1.18 ± 16%      -0.2        0.95 ± 14%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent
      1.16 ± 16%      -0.2        0.93 ± 15%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents
      0.87 ±  8%      +0.3        1.15 ±  6%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.92 ±  7%      +0.3        1.22 ±  6%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      0.48 ± 45%      +0.3        0.78 ± 12%  perf-profile.calltrace.cycles-pp.tick_nohz_restart_sched_tick.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary
      0.56 ± 45%      +0.3        0.88 ± 14%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_exit.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.11 ± 14%      +0.4        1.47 ± 14%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.13 ± 14%      +0.4        1.49 ± 14%  perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      1.18 ± 13%      +0.4        1.56 ± 14%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      1.34 ±  2%      +0.4        1.72 ± 10%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      0.86 ± 10%      +0.4        1.26 ±  7%  perf-profile.calltrace.cycles-pp.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.37            +0.4        1.78 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.39 ± 70%      +0.4        0.81 ± 20%  perf-profile.calltrace.cycles-pp.dequeue_entities.dequeue_task_fair.__schedule.schedule.worker_thread
      0.41 ± 70%      +0.4        0.83 ± 18%  perf-profile.calltrace.cycles-pp.dequeue_task_fair.__schedule.schedule.worker_thread.kthread
      1.41            +0.4        1.85 ± 11%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      1.41            +0.4        1.85 ± 11%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      1.41            +0.4        1.85 ± 11%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      1.41            +0.4        1.85 ± 11%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      1.41            +0.4        1.85 ± 11%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      1.41            +0.4        1.85 ± 11%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      0.18 ±142%      +0.5        0.67 ± 14%  perf-profile.calltrace.cycles-pp.refresh_cpu_vm_stats.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle
      1.50 ± 15%      +0.5        2.04 ± 13%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.17 ± 18%      +0.6        1.72 ±  7%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.16 ± 19%      +0.6        1.73 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.94 ± 19%      +0.6        1.51 ± 18%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      1.31 ± 18%      +0.6        1.88 ± 17%  perf-profile.calltrace.cycles-pp.blk_complete_reqs.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      0.98 ± 21%      +0.6        1.57 ± 16%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry
      0.18 ±141%      +0.6        0.76 ± 14%  perf-profile.calltrace.cycles-pp.ahci_qc_complete.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event
      0.19 ±141%      +0.6        0.79 ± 19%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.40 ± 72%      +0.6        1.00 ± 22%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.00            +0.6        0.63 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_get_sleep_length.menu_select.cpuidle_idle_call.do_idle.cpu_startup_entry
      1.86 ± 13%      +0.6        2.50 ± 14%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.09 ±223%      +0.7        0.75 ± 42%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queue.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio
      1.94 ± 13%      +0.7        2.60 ± 15%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_do_entry
      0.20 ±141%      +0.7        0.89 ± 24%  perf-profile.calltrace.cycles-pp.x64_sys_call.do_syscall_64.entry_SYSCALL_64_after_hwframe
      2.40 ± 11%      +0.7        3.10 ±  9%  perf-profile.calltrace.cycles-pp.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_do_entry
      2.40 ± 12%      +0.7        3.10 ± 16%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_direct_write.btrfs_do_write_iter.aio_write
      2.35 ± 11%      +0.7        3.06 ±  9%  perf-profile.calltrace.cycles-pp.handle_softirqs.__irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.92 ± 22%      +0.7        1.63 ±  9%  perf-profile.calltrace.cycles-pp.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      1.36 ± 14%      +0.8        2.13 ± 16%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread.kthread
      1.36 ± 14%      +0.8        2.13 ± 16%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread
      1.36 ± 14%      +0.8        2.14 ± 16%  perf-profile.calltrace.cycles-pp.blk_mq_run_work_fn.process_one_work.worker_thread.kthread.ret_from_fork
      1.26 ± 14%      +0.8        2.04 ± 17%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work
      1.97 ± 13%      +0.8        2.75 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_submit_bbio.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_direct_write.btrfs_do_write_iter
      1.96 ± 13%      +0.8        2.75 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bbio.iomap_dio_bio_iter.__iomap_dio_rw.btrfs_direct_write
      0.22 ±147%      +0.8        1.03 ± 23%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.16 ± 23%      +0.9        2.01 ±  8%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__sysvec_posted_msi_notification.sysvec_posted_msi_notification
      1.15 ± 23%      +0.9        2.01 ±  8%  perf-profile.calltrace.cycles-pp.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__sysvec_posted_msi_notification
      1.19 ± 23%      +0.9        2.05 ±  8%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification
      0.24 ±143%      +0.9        1.10 ± 30%  perf-profile.calltrace.cycles-pp.load_elf_binary.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common
      0.24 ±146%      +0.9        1.11 ± 23%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      1.20 ± 23%      +0.9        2.08 ±  8%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.acpi_safe_halt
      0.25 ±142%      +0.9        1.13 ± 29%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      0.25 ±142%      +0.9        1.14 ± 29%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.21 ±142%      +0.9        1.12 ± 26%  perf-profile.calltrace.cycles-pp.vfs_read.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.22 ±143%      +0.9        1.13 ± 27%  perf-profile.calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.26 ±142%      +0.9        1.17 ± 28%  perf-profile.calltrace.cycles-pp.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.26 ± 23%      +0.9        2.17 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_posted_msi_notification.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_do_entry
      0.23 ±144%      +0.9        1.16 ± 27%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
      0.23 ±144%      +0.9        1.16 ± 27%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
      0.24 ±143%      +1.0        1.19 ± 27%  perf-profile.calltrace.cycles-pp.read
      0.30 ±145%      +1.0        1.26 ± 22%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      0.91 ± 50%      +1.0        1.88 ± 15%  perf-profile.calltrace.cycles-pp.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio
      0.30 ±145%      +1.0        1.27 ± 22%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault
      2.93 ± 11%      +1.0        3.96 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_posted_msi_notification.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      0.41 ±110%      +1.1        1.49 ± 23%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault
      0.55 ± 84%      +1.1        1.70 ± 24%  perf-profile.calltrace.cycles-pp.do_execveat_common.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.55 ± 84%      +1.2        1.71 ± 25%  perf-profile.calltrace.cycles-pp.__x64_sys_execve.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.55 ± 84%      +1.2        1.71 ± 25%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.execve
      0.55 ± 84%      +1.2        1.71 ± 25%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.execve
      0.55 ± 84%      +1.2        1.71 ± 25%  perf-profile.calltrace.cycles-pp.execve
      1.57 ± 15%      +1.2        2.81 ±  9%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle
      1.70 ± 28%      +1.3        2.98 ± 20%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      0.28 ±143%      +1.3        1.59 ± 26%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_secondary.common_startup_64
      1.22 ± 38%      +1.3        2.54 ± 24%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.22 ± 39%      +1.3        2.55 ± 24%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
      1.70 ± 15%      +1.4        3.11 ± 10%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair
      1.73 ± 15%      +1.4        3.15 ± 10%  perf-profile.calltrace.cycles-pp.sched_balance_find_src_group.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task
      2.42 ± 15%      +1.4        3.85 ± 14%  perf-profile.calltrace.cycles-pp.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck
      2.44 ± 15%      +1.4        3.87 ± 15%  perf-profile.calltrace.cycles-pp.__blk_mq_alloc_requests.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk
      4.95 ± 12%      +1.4        6.39 ± 11%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter
      1.87 ± 13%      +1.4        3.32 ±  9%  perf-profile.calltrace.cycles-pp.sched_balance_rq.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule
      3.01 ± 14%      +1.5        4.52 ± 15%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.__submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bbio
      3.01 ± 14%      +1.5        4.53 ± 14%  perf-profile.calltrace.cycles-pp.__submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bbio.iomap_dio_bio_iter
      3.03 ± 14%      +1.5        4.56 ± 14%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bbio.iomap_dio_bio_iter.__iomap_dio_rw
      2.27 ± 18%      +1.6        3.88 ± 13%  perf-profile.calltrace.cycles-pp.sched_balance_newidle.pick_next_task_fair.__pick_next_task.__schedule.schedule
      2.28 ± 14%      +1.6        3.89 ±  9%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__pick_next_task.__schedule.schedule.worker_thread
      2.29 ± 14%      +1.6        3.94 ±  9%  perf-profile.calltrace.cycles-pp.__pick_next_task.__schedule.schedule.worker_thread.kthread
      4.16 ± 17%      +2.0        6.18 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_posted_msi_notification.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
      3.15 ± 15%      +2.0        5.19 ± 10%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      3.18 ± 15%      +2.1        5.26 ± 10%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      5.16 ± 29%      +3.9        9.07 ± 18%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state
     10.86 ±  6%      +4.4       15.29 ±  2%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
     17.83 ±  5%      +6.5       24.37 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_do_entry.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
     17.86 ±  5%      +6.6       24.45 ±  3%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     26.94 ±  7%      +8.4       35.33 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     28.20 ±  7%      +8.8       36.95 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     29.33 ±  6%      +9.4       38.71 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     31.92 ±  6%     +11.1       42.99 ±  3%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     31.91 ±  6%     +11.1       42.98 ±  3%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     31.87 ±  6%     +11.1       42.95 ±  3%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     33.33 ±  6%     +11.5       44.84 ±  4%  perf-profile.calltrace.cycles-pp.common_startup_64
     42.69 ±  7%     -19.6       23.05 ± 12%  perf-profile.children.cycles-pp.process_one_work
     46.80 ±  7%     -17.8       29.00 ± 11%  perf-profile.children.cycles-pp.worker_thread
     34.31 ±  7%     -17.1       17.20 ± 10%  perf-profile.children.cycles-pp.btrfs_finish_one_ordered
     34.36 ±  7%     -17.1       17.31 ± 10%  perf-profile.children.cycles-pp.btrfs_work_helper
     47.97 ±  6%     -16.9       31.09 ± 10%  perf-profile.children.cycles-pp.kthread
     48.01 ±  6%     -16.9       31.14 ± 10%  perf-profile.children.cycles-pp.ret_from_fork_asm
     47.99 ±  6%     -16.9       31.13 ± 10%  perf-profile.children.cycles-pp.ret_from_fork
     28.66 ±  9%     -15.7       12.92 ± 13%  perf-profile.children.cycles-pp.insert_reserved_file_extent
     26.62 ± 11%     -15.3       11.30 ± 15%  perf-profile.children.cycles-pp.btrfs_drop_extents
     25.06 ± 10%     -15.0       10.09 ± 14%  perf-profile.children.cycles-pp.btrfs_search_slot
     21.58 ± 13%     -13.7        7.86 ± 16%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
     19.91 ±  9%     -12.4        7.51 ± 15%  perf-profile.children.cycles-pp.btrfs_tree_lock_nested
     19.93 ±  9%     -12.3        7.59 ± 15%  perf-profile.children.cycles-pp.down_write
     19.67 ±  9%     -12.2        7.44 ± 15%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     19.51 ±  9%     -12.1        7.38 ± 15%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     17.47 ± 10%     -10.9        6.58 ± 15%  perf-profile.children.cycles-pp.btrfs_lock_root_node
     12.78 ± 12%      -8.0        4.73 ± 17%  perf-profile.children.cycles-pp.osq_lock
      5.96 ±  4%      -3.5        2.42 ± 19%  perf-profile.children.cycles-pp.rwsem_spin_on_owner
      3.54 ±  9%      -1.3        2.19 ± 17%  perf-profile.children.cycles-pp.setup_items_for_insert
      2.89 ± 29%      -1.2        1.69 ± 21%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      3.60 ± 31%      -1.1        2.49 ± 12%  perf-profile.children.cycles-pp.iomap_iter
      3.50 ± 31%      -1.1        2.40 ± 12%  perf-profile.children.cycles-pp.btrfs_dio_iomap_begin
      3.00 ± 12%      -1.1        1.90 ± 17%  perf-profile.children.cycles-pp.btrfs_setup_item_for_insert
      1.84 ± 12%      -0.9        0.92 ± 22%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
      2.38 ± 44%      -0.9        1.51 ± 16%  perf-profile.children.cycles-pp.btrfs_get_blocks_direct_write
      1.73 ± 10%      -0.9        0.87 ± 24%  perf-profile.children.cycles-pp.down_read
      1.64 ± 10%      -0.9        0.78 ± 27%  perf-profile.children.cycles-pp.btrfs_tree_read_lock_nested
      2.66 ±  9%      -0.9        1.80 ± 17%  perf-profile.children.cycles-pp.__memmove
      1.78 ± 14%      -0.8        0.95 ± 28%  perf-profile.children.cycles-pp.btrfs_del_items
      2.13 ± 23%      -0.8        1.32 ± 30%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
      1.44 ± 11%      -0.8        0.69 ± 27%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      1.76 ±  6%      -0.6        1.12 ± 23%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      2.53 ± 14%      -0.6        1.91 ± 15%  perf-profile.children.cycles-pp.__write_extent_buffer
      1.18 ±  8%      -0.5        0.64 ± 16%  perf-profile.children.cycles-pp.btrfs_get_token_32
      1.09 ± 12%      -0.5        0.58 ± 31%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      0.90 ± 12%      -0.5        0.39 ± 27%  perf-profile.children.cycles-pp.up_write
      1.13 ±  6%      -0.4        0.69 ± 24%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.68 ± 11%      -0.4        0.26 ± 40%  perf-profile.children.cycles-pp.rwsem_wake
      1.88 ± 13%      -0.4        1.46 ± 19%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      0.88 ± 13%      -0.4        0.48 ±  9%  perf-profile.children.cycles-pp.btrfs_bin_search
      1.03 ±  8%      -0.4        0.63 ± 22%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.69 ± 28%      -0.4        0.29 ± 13%  perf-profile.children.cycles-pp.btrfs_release_path
      1.52 ±  5%      -0.4        1.14 ± 20%  perf-profile.children.cycles-pp.btrfs_lookup_csum
      0.98 ±  9%      -0.4        0.62 ± 13%  perf-profile.children.cycles-pp.read_block_for_search
      1.49 ±  9%      -0.3        1.17 ± 13%  perf-profile.children.cycles-pp.btrfs_new_extent_direct
      0.67 ± 15%      -0.3        0.37 ± 30%  perf-profile.children.cycles-pp.do_io_getevents
      0.61 ±  7%      -0.3        0.33 ± 38%  perf-profile.children.cycles-pp.aio_complete_rw
      0.88 ±  6%      -0.3        0.62 ± 18%  perf-profile.children.cycles-pp.btrfs_dio_end_io
      0.63 ± 13%      -0.3        0.36 ± 30%  perf-profile.children.cycles-pp.read_events
      0.54 ±  9%      -0.2        0.30 ± 39%  perf-profile.children.cycles-pp.aio_complete
      0.47 ± 35%      -0.2        0.22 ± 58%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      0.44 ± 16%      -0.2        0.20 ± 42%  perf-profile.children.cycles-pp.pwq_dec_nr_in_flight
      0.37 ±  6%      -0.2        0.15 ± 40%  perf-profile.children.cycles-pp.wake_up_q
      0.65 ±  9%      -0.2        0.46 ± 20%  perf-profile.children.cycles-pp.__set_extent_bit
      0.61 ± 12%      -0.2        0.42 ± 17%  perf-profile.children.cycles-pp.find_extent_buffer
      0.59 ±  9%      -0.2        0.41 ± 17%  perf-profile.children.cycles-pp.aio_linux_fill_buffer
      0.35 ± 18%      -0.2        0.18 ± 24%  perf-profile.children.cycles-pp.__x64_sys_io_pgetevents
      0.43 ± 12%      -0.2        0.27 ± 47%  perf-profile.children.cycles-pp.clear_state_bit
      0.90 ±  9%      -0.2        0.74 ± 14%  perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      0.25 ± 40%      -0.2        0.09 ± 45%  perf-profile.children.cycles-pp.aio_read_events
      0.36 ± 24%      -0.2        0.20 ± 36%  perf-profile.children.cycles-pp.btrfs_get_32
      0.24 ± 37%      -0.2        0.08 ± 46%  perf-profile.children.cycles-pp.aio_read_events_ring
      0.62 ± 10%      -0.2        0.47 ± 19%  perf-profile.children.cycles-pp.__lock_extent
      0.24 ± 18%      -0.2        0.09 ± 19%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.47 ± 12%      -0.1        0.32 ± 26%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.20 ± 25%      -0.1        0.05 ± 87%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      0.25 ± 25%      -0.1        0.12 ± 41%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.21 ± 28%      -0.1        0.08 ± 74%  perf-profile.children.cycles-pp.node_activate_pending_pwq
      0.24 ± 24%      -0.1        0.11 ± 25%  perf-profile.children.cycles-pp.leaf_space_used
      0.16 ± 33%      -0.1        0.04 ± 93%  perf-profile.children.cycles-pp.__pwq_activate_work
      0.35 ± 18%      -0.1        0.25 ± 19%  perf-profile.children.cycles-pp.btrfs_alloc_ordered_extent
      0.22 ± 17%      -0.1        0.13 ± 42%  perf-profile.children.cycles-pp.___slab_alloc
      0.18 ± 22%      -0.1        0.11 ± 36%  perf-profile.children.cycles-pp.split_leaf
      0.11 ± 11%      -0.1        0.04 ± 88%  perf-profile.children.cycles-pp.available_idle_cpu
      0.10 ± 38%      -0.1        0.04 ± 85%  perf-profile.children.cycles-pp.btrfs_cow_block
      0.10 ± 38%      -0.1        0.04 ± 85%  perf-profile.children.cycles-pp.btrfs_force_cow_block
      0.37 ± 11%      -0.1        0.31 ± 14%  perf-profile.children.cycles-pp.btrfs_data_csum_ok
      0.37 ± 11%      -0.1        0.31 ± 14%  perf-profile.children.cycles-pp.btrfs_check_sector_csum
      0.19 ±  9%      -0.1        0.13 ± 22%  perf-profile.children.cycles-pp.btrfs_put_ordered_extent
      0.10 ± 18%      -0.0        0.05 ± 56%  perf-profile.children.cycles-pp.join_transaction
      0.09 ± 27%      -0.0        0.05 ± 56%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.08 ± 27%      +0.0        0.13 ± 34%  perf-profile.children.cycles-pp.tmigr_update_events
      0.08 ± 26%      +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.memchr_inv
      0.02 ±141%      +0.1        0.07 ± 27%  perf-profile.children.cycles-pp.simple_lookup
      0.01 ±223%      +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.__check_object_size
      0.01 ±223%      +0.1        0.06 ± 21%  perf-profile.children.cycles-pp.perf_evlist__poll_thread
      0.17 ± 16%      +0.1        0.22 ±  9%  perf-profile.children.cycles-pp.set_next_entity
      0.01 ±223%      +0.1        0.07 ± 29%  perf-profile.children.cycles-pp.blk_account_io_done
      0.00            +0.1        0.06 ± 23%  perf-profile.children.cycles-pp.__pte_alloc
      0.02 ±144%      +0.1        0.08 ± 11%  perf-profile.children.cycles-pp.task_work_run
      0.04 ± 75%      +0.1        0.11 ± 35%  perf-profile.children.cycles-pp.fold_vm_numa_events
      0.06 ± 55%      +0.1        0.12 ± 21%  perf-profile.children.cycles-pp.update_io_ticks
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.__d_add
      0.00            +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.strnlen
      0.02 ±141%      +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.vmstat_start
      0.06 ± 81%      +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.dup_mmap
      0.16 ± 19%      +0.1        0.23 ±  5%  perf-profile.children.cycles-pp.set_next_task_fair
      0.06 ± 54%      +0.1        0.14 ± 29%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.04 ± 72%      +0.1        0.12 ± 25%  perf-profile.children.cycles-pp.wait4
      0.01 ±223%      +0.1        0.10 ± 35%  perf-profile.children.cycles-pp.__rmqueue_pcplist
      0.08 ± 56%      +0.1        0.16 ± 16%  perf-profile.children.cycles-pp.free_pages_and_swap_cache
      0.00            +0.1        0.09 ± 26%  perf-profile.children.cycles-pp.__call_rcu_common
      0.02 ±144%      +0.1        0.11 ± 36%  perf-profile.children.cycles-pp.vma_complete
      0.02 ±223%      +0.1        0.10 ± 32%  perf-profile.children.cycles-pp.getname_flags
      0.08 ± 56%      +0.1        0.16 ± 16%  perf-profile.children.cycles-pp.__tlb_batch_free_encoded_pages
      0.23 ± 15%      +0.1        0.32 ± 19%  perf-profile.children.cycles-pp.llist_reverse_order
      0.06 ± 73%      +0.1        0.15 ± 22%  perf-profile.children.cycles-pp.__blk_mq_end_request
      0.00            +0.1        0.09 ± 62%  perf-profile.children.cycles-pp.mas_next_slot
      0.02 ±223%      +0.1        0.11 ± 43%  perf-profile.children.cycles-pp.__dentry_kill
      0.01 ±223%      +0.1        0.11 ± 29%  perf-profile.children.cycles-pp.vms_complete_munmap_vmas
      0.04 ± 71%      +0.1        0.13 ± 37%  perf-profile.children.cycles-pp.mod_objcg_state
      0.08 ± 32%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.exec_mmap
      0.04 ±112%      +0.1        0.14 ± 36%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.05 ± 46%      +0.1        0.15 ± 18%  perf-profile.children.cycles-pp.proc_reg_read_iter
      0.03 ±141%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.elv_rqhash_find
      0.01 ±223%      +0.1        0.11 ± 37%  perf-profile.children.cycles-pp.fstatat64
      0.01 ±223%      +0.1        0.11 ± 32%  perf-profile.children.cycles-pp.mas_find
      0.13 ± 37%      +0.1        0.24 ± 18%  perf-profile.children.cycles-pp.__split_vma
      0.07 ± 54%      +0.1        0.18 ± 27%  perf-profile.children.cycles-pp.folios_put_refs
      0.08 ± 32%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.blk_mq_complete_request
      0.08 ± 32%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
      0.02 ±149%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.do_vmi_align_munmap
      0.02 ±149%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.do_vmi_munmap
      0.12 ± 37%      +0.1        0.23 ± 28%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.01 ±223%      +0.1        0.12 ± 34%  perf-profile.children.cycles-pp.strnlen_user
      0.04 ±115%      +0.1        0.15 ± 44%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.10 ± 43%      +0.1        0.21 ± 15%  perf-profile.children.cycles-pp.vms_gather_munmap_vmas
      0.01 ±223%      +0.1        0.13 ± 27%  perf-profile.children.cycles-pp.vms_clear_ptes
      0.49 ± 11%      +0.1        0.60 ± 17%  perf-profile.children.cycles-pp.dl_server_stop
      0.05 ± 71%      +0.1        0.17 ± 29%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.02 ±149%      +0.1        0.14 ± 22%  perf-profile.children.cycles-pp.__vm_munmap
      0.08 ± 56%      +0.1        0.20 ± 44%  perf-profile.children.cycles-pp.__pte_offset_map_lock
      0.03 ±155%      +0.1        0.15 ± 41%  perf-profile.children.cycles-pp.relocate_vma_down
      0.12 ± 59%      +0.1        0.24 ± 35%  perf-profile.children.cycles-pp.perf_event_mmap_event
      0.24 ± 29%      +0.1        0.36 ± 19%  perf-profile.children.cycles-pp.irqentry_enter
      0.01 ±223%      +0.1        0.13 ± 63%  perf-profile.children.cycles-pp.__vmalloc_node_range_noprof
      0.16 ± 23%      +0.1        0.28 ± 16%  perf-profile.children.cycles-pp.__tmigr_cpu_activate
      0.12 ± 57%      +0.1        0.25 ± 37%  perf-profile.children.cycles-pp.perf_event_mmap
      0.04 ±105%      +0.1        0.17 ± 39%  perf-profile.children.cycles-pp._IO_fwrite
      0.01 ±223%      +0.1        0.14 ± 68%  perf-profile.children.cycles-pp.alloc_thread_stack_node
      0.06 ± 54%      +0.1        0.19 ± 24%  perf-profile.children.cycles-pp.i2c_outb
      0.09 ± 62%      +0.1        0.22 ± 29%  perf-profile.children.cycles-pp.tlb_finish_mmu
      0.12 ± 33%      +0.1        0.25 ± 31%  perf-profile.children.cycles-pp.update_other_load_avgs
      0.10 ± 36%      +0.1        0.24 ± 43%  perf-profile.children.cycles-pp.begin_new_exec
      0.23 ± 20%      +0.1        0.37 ± 11%  perf-profile.children.cycles-pp.sched_tick
      0.11 ± 40%      +0.1        0.25 ± 23%  perf-profile.children.cycles-pp.timekeeping_advance
      0.11 ± 40%      +0.1        0.25 ± 23%  perf-profile.children.cycles-pp.update_wall_time
      0.10 ± 25%      +0.1        0.24 ± 25%  perf-profile.children.cycles-pp.wp_page_copy
      0.02 ±141%      +0.1        0.17 ± 45%  perf-profile.children.cycles-pp.elv_attempt_insert_merge
      0.33 ± 19%      +0.1        0.47 ± 12%  perf-profile.children.cycles-pp.sched_clock_cpu
      0.04 ±156%      +0.1        0.18 ± 34%  perf-profile.children.cycles-pp.setup_arg_pages
      0.13 ± 60%      +0.1        0.28 ± 32%  perf-profile.children.cycles-pp.next_uptodate_folio
      0.06 ± 82%      +0.1        0.21 ± 46%  perf-profile.children.cycles-pp.pipe_write
      0.12 ± 40%      +0.2        0.28 ± 28%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.29 ± 15%      +0.2        0.44 ± 22%  perf-profile.children.cycles-pp.finish_task_switch
      0.24 ± 21%      +0.2        0.39 ± 18%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.19 ± 18%      +0.2        0.35 ± 25%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.__i2c_transfer
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.ast_vga_connector_helper_detect_ctx
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.bit_xfer
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.drm_connector_helper_detect_from_ddc
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.drm_do_probe_ddc_edid
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.drm_helper_probe_detect_ctx
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.drm_probe_ddc
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.i2c_transfer
      0.07 ± 54%      +0.2        0.23 ± 23%  perf-profile.children.cycles-pp.output_poll_execute
      0.32 ± 12%      +0.2        0.48 ± 12%  perf-profile.children.cycles-pp.read_tsc
      0.56 ± 12%      +0.2        0.72 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.06 ± 54%      +0.2        0.23 ± 24%  perf-profile.children.cycles-pp.try_address
      0.10 ± 35%      +0.2        0.27 ± 36%  perf-profile.children.cycles-pp.seq_read
      0.11 ± 44%      +0.2        0.28 ± 26%  perf-profile.children.cycles-pp.rcu_do_batch
      0.17 ± 43%      +0.2        0.34 ± 13%  perf-profile.children.cycles-pp.__dd_dispatch_request
      0.05 ± 84%      +0.2        0.23 ± 42%  perf-profile.children.cycles-pp.copy_strings
      0.13 ± 50%      +0.2        0.31 ± 37%  perf-profile.children.cycles-pp.__lookup_slow
      0.13 ± 25%      +0.2        0.31 ± 26%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.53 ± 10%      +0.2        0.71 ± 13%  perf-profile.children.cycles-pp.refresh_cpu_vm_stats
      0.14 ± 59%      +0.2        0.32 ± 31%  perf-profile.children.cycles-pp.__do_sys_clone
      0.11 ± 50%      +0.2        0.29 ± 46%  perf-profile.children.cycles-pp.write
      0.17 ± 60%      +0.2        0.35 ± 28%  perf-profile.children.cycles-pp._Fork
      0.25 ± 22%      +0.2        0.43 ± 11%  perf-profile.children.cycles-pp._find_next_and_bit
      0.32 ± 12%      +0.2        0.50 ±  5%  perf-profile.children.cycles-pp.tick_nohz_next_event
      0.19 ± 43%      +0.2        0.37 ± 16%  perf-profile.children.cycles-pp.dd_dispatch_request
      0.18 ± 44%      +0.2        0.36 ± 22%  perf-profile.children.cycles-pp.rcu_core
      0.65 ± 14%      +0.2        0.84 ± 17%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.43 ± 23%      +0.2        0.62 ± 24%  perf-profile.children.cycles-pp.tick_irq_enter
      0.05 ± 82%      +0.2        0.24 ± 45%  perf-profile.children.cycles-pp.sync_regs
      0.24 ± 22%      +0.2        0.45 ± 23%  perf-profile.children.cycles-pp.cpu_util
      0.32 ± 15%      +0.2        0.52 ± 19%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.41 ± 13%      +0.2        0.62 ±  7%  perf-profile.children.cycles-pp.lapic_next_deadline
      0.21 ± 49%      +0.2        0.42 ± 26%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.16 ± 50%      +0.2        0.38 ± 21%  perf-profile.children.cycles-pp.__open64_nocancel
      0.11 ± 29%      +0.2        0.32 ± 22%  perf-profile.children.cycles-pp.pipe_read
      0.08 ± 73%      +0.2        0.31 ± 26%  perf-profile.children.cycles-pp.copy_mc_enhanced_fast_string
      0.29 ± 14%      +0.2        0.51 ± 21%  perf-profile.children.cycles-pp.sata_async_notification
      0.42 ± 13%      +0.2        0.64 ± 18%  perf-profile.children.cycles-pp.update_process_times
      0.28 ± 14%      +0.2        0.51 ± 20%  perf-profile.children.cycles-pp.ahci_scr_read
      0.29 ± 14%      +0.2        0.52 ± 21%  perf-profile.children.cycles-pp.ahci_handle_port_interrupt
      0.77 ± 10%      +0.2        1.00 ± 15%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.16 ± 38%      +0.2        0.40 ± 37%  perf-profile.children.cycles-pp.copy_process
      0.55 ± 18%      +0.2        0.80 ± 13%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.06 ± 75%      +0.3        0.32 ± 25%  perf-profile.children.cycles-pp.__collapse_huge_page_copy
      0.41 ± 13%      +0.3        0.67 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.43 ± 20%      +0.3        0.69 ± 10%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.20 ± 44%      +0.3        0.46 ± 32%  perf-profile.children.cycles-pp.walk_component
      0.64 ± 19%      +0.3        0.90 ± 14%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.08 ± 78%      +0.3        0.35 ± 25%  perf-profile.children.cycles-pp.collapse_huge_page
      0.71 ±  7%      +0.3        0.98 ± 13%  perf-profile.children.cycles-pp.ktime_get
      0.37 ±  5%      +0.3        0.65 ± 24%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.19 ± 57%      +0.3        0.47 ± 30%  perf-profile.children.cycles-pp.elf_load
      0.08 ± 78%      +0.3        0.36 ± 22%  perf-profile.children.cycles-pp.hpage_collapse_scan_pmd
      0.08 ± 78%      +0.3        0.36 ± 22%  perf-profile.children.cycles-pp.khugepaged_scan_mm_slot
      0.22 ± 45%      +0.3        0.51 ± 36%  perf-profile.children.cycles-pp.kernel_clone
      0.08 ± 80%      +0.3        0.37 ± 23%  perf-profile.children.cycles-pp.khugepaged
      0.42 ± 14%      +0.3        0.71 ± 11%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.83 ± 12%      +0.3        1.12 ±  9%  perf-profile.children.cycles-pp.enqueue_dl_entity
      0.52 ± 10%      +0.3        0.82 ±  9%  perf-profile.children.cycles-pp.start_dl_timer
      0.83 ± 12%      +0.3        1.15 ±  9%  perf-profile.children.cycles-pp.dl_server_start
      0.74 ±  2%      +0.3        1.06 ±  6%  perf-profile.children.cycles-pp.clockevents_program_event
      0.94 ±  8%      +0.3        1.26 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      0.51 ± 14%      +0.3        0.83 ±  9%  perf-profile.children.cycles-pp.update_rq_clock
      0.58 ± 13%      +0.3        0.91 ± 17%  perf-profile.children.cycles-pp.enqueue_entity
      0.49 ±  9%      +0.3        0.83 ± 24%  perf-profile.children.cycles-pp.idle_cpu
      0.63 ± 13%      +0.3        0.97 ± 14%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.77 ± 19%      +0.4        1.13 ± 20%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      0.27 ± 56%      +0.4        0.64 ± 30%  perf-profile.children.cycles-pp.filemap_map_pages
      0.34 ± 54%      +0.4        0.71 ± 23%  perf-profile.children.cycles-pp.setlocale
      0.59 ± 21%      +0.4        0.96 ± 28%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.59 ± 21%      +0.4        0.96 ± 28%  perf-profile.children.cycles-pp.__blk_flush_plug
      0.58 ± 21%      +0.4        0.96 ± 28%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.35 ± 43%      +0.4        0.73 ± 32%  perf-profile.children.cycles-pp.handle_internal_command
      0.35 ± 43%      +0.4        0.73 ± 32%  perf-profile.children.cycles-pp.main
      0.35 ± 43%      +0.4        0.73 ± 32%  perf-profile.children.cycles-pp.run_builtin
      0.48 ± 22%      +0.4        0.87 ± 16%  perf-profile.children.cycles-pp.ahci_qc_complete
      0.30 ± 35%      +0.4        0.68 ± 28%  perf-profile.children.cycles-pp.exit_mm
      0.36 ± 44%      +0.4        0.74 ± 26%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.28 ± 45%      +0.4        0.67 ± 31%  perf-profile.children.cycles-pp.link_path_walk
      0.31 ± 35%      +0.4        0.70 ± 29%  perf-profile.children.cycles-pp.seq_read_iter
      0.89 ± 11%      +0.4        1.29 ±  6%  perf-profile.children.cycles-pp.menu_select
      0.30 ± 57%      +0.4        0.71 ± 30%  perf-profile.children.cycles-pp.do_read_fault
      1.20 ± 10%      +0.4        1.63 ± 10%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      1.41            +0.4        1.85 ± 11%  perf-profile.children.cycles-pp.rest_init
      1.41            +0.4        1.85 ± 11%  perf-profile.children.cycles-pp.start_kernel
      1.41            +0.4        1.85 ± 11%  perf-profile.children.cycles-pp.x86_64_start_kernel
      1.41            +0.4        1.85 ± 11%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.68 ± 19%      +0.4        1.12 ± 14%  perf-profile.children.cycles-pp.mod_delayed_work_on
      0.36 ± 35%      +0.5        0.81 ± 28%  perf-profile.children.cycles-pp.exit_mmap
      0.37 ± 34%      +0.5        0.82 ± 28%  perf-profile.children.cycles-pp.__mmput
      0.68 ± 19%      +0.5        1.14 ± 14%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      0.44 ± 41%      +0.5        0.92 ± 25%  perf-profile.children.cycles-pp.mmap_region
      0.35 ± 53%      +0.5        0.84 ± 33%  perf-profile.children.cycles-pp.do_pte_missing
      0.72 ± 13%      +0.5        1.22 ± 17%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      1.68 ± 13%      +0.5        2.18 ± 11%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.40 ± 29%      +0.5        0.91 ± 25%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.40 ± 29%      +0.5        0.91 ± 25%  perf-profile.children.cycles-pp.do_group_exit
      0.40 ± 29%      +0.5        0.91 ± 25%  perf-profile.children.cycles-pp.do_exit
      0.36 ± 43%      +0.5        0.87 ± 33%  perf-profile.children.cycles-pp.path_openat
      0.37 ± 45%      +0.5        0.88 ± 31%  perf-profile.children.cycles-pp.do_filp_open
      1.11 ±  9%      +0.5        1.63 ± 12%  perf-profile.children.cycles-pp.kick_pool
      1.46 ±  9%      +0.5        1.99 ± 11%  perf-profile.children.cycles-pp.__queue_work
      0.43 ± 30%      +0.5        0.96 ± 26%  perf-profile.children.cycles-pp.x64_sys_call
      0.88 ±  5%      +0.5        1.43 ± 21%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      0.50 ± 42%      +0.5        1.05 ± 26%  perf-profile.children.cycles-pp.do_mmap
      1.18 ± 19%      +0.6        1.74 ±  6%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.18 ± 19%      +0.6        1.75 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.43 ± 47%      +0.6        0.99 ± 32%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.43 ± 47%      +0.6        0.99 ± 32%  perf-profile.children.cycles-pp.do_sys_openat2
      2.10 ±  6%      +0.6        2.67 ± 10%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.50 ± 42%      +0.6        1.08 ± 27%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      2.10 ± 11%      +0.6        2.70 ± 11%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.18 ± 16%      +0.6        1.78 ± 16%  perf-profile.children.cycles-pp.hrtimer_interrupt
      3.08 ±  9%      +0.6        3.69 ± 13%  perf-profile.children.cycles-pp.blk_complete_reqs
      1.23 ± 18%      +0.6        1.85 ± 14%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.87 ± 10%      +0.6        1.50 ± 12%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      2.06 ± 14%      +0.6        2.71 ± 14%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.44 ± 44%      +0.7        1.10 ± 30%  perf-profile.children.cycles-pp.load_elf_binary
      0.46 ± 45%      +0.7        1.13 ± 29%  perf-profile.children.cycles-pp.search_binary_handler
      0.46 ± 45%      +0.7        1.15 ± 29%  perf-profile.children.cycles-pp.exec_binprm
      0.50 ± 43%      +0.7        1.22 ± 30%  perf-profile.children.cycles-pp.bprm_execve
      0.53 ± 31%      +0.7        1.26 ± 25%  perf-profile.children.cycles-pp.vfs_read
      0.55 ± 32%      +0.8        1.31 ± 26%  perf-profile.children.cycles-pp.ksys_read
      1.12 ± 17%      +0.8        1.89 ± 15%  perf-profile.children.cycles-pp.io_schedule
      1.36 ± 14%      +0.8        2.14 ± 16%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
      1.81 ± 10%      +0.8        2.59 ± 10%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.06 ± 16%      +0.8        1.84 ±  6%  perf-profile.children.cycles-pp.ahci_handle_port_intr
      1.75 ±  9%      +0.8        2.54 ±  8%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.61 ± 31%      +0.8        1.41 ± 27%  perf-profile.children.cycles-pp.read
      1.78 ±  8%      +0.8        2.61 ±  7%  perf-profile.children.cycles-pp.enqueue_task
      1.35 ± 17%      +0.9        2.28 ±  7%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      1.35 ± 17%      +0.9        2.28 ±  7%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      0.65 ± 50%      +0.9        1.59 ± 22%  perf-profile.children.cycles-pp.__handle_mm_fault
      1.40 ± 17%      +1.0        2.35 ±  6%  perf-profile.children.cycles-pp.handle_irq_event
      1.40 ± 17%      +1.0        2.38 ±  6%  perf-profile.children.cycles-pp.handle_edge_irq
      0.70 ± 50%      +1.0        1.70 ± 24%  perf-profile.children.cycles-pp.handle_mm_fault
      1.48 ± 17%      +1.0        2.49 ±  7%  perf-profile.children.cycles-pp.__sysvec_posted_msi_notification
      0.68 ± 46%      +1.0        1.71 ± 25%  perf-profile.children.cycles-pp.execve
      0.69 ± 45%      +1.0        1.71 ± 25%  perf-profile.children.cycles-pp.do_execveat_common
      0.69 ± 45%      +1.0        1.72 ± 25%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.76 ± 49%      +1.0        1.80 ± 24%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.76 ± 50%      +1.1        1.81 ± 24%  perf-profile.children.cycles-pp.exc_page_fault
      2.08 ± 15%      +1.1        3.19 ± 15%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      2.07 ± 15%      +1.1        3.19 ± 15%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      1.92 ± 16%      +1.1        3.06 ± 17%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      3.22 ±  9%      +1.2        4.38 ±  6%  perf-profile.children.cycles-pp.sysvec_posted_msi_notification
      4.80 ±  4%      +1.2        6.01        perf-profile.children.cycles-pp.__irq_exit_rcu
      4.62 ± 12%      +1.2        5.84 ± 12%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      4.64 ± 12%      +1.2        5.85 ± 12%  perf-profile.children.cycles-pp.btrfs_submit_bbio
      4.74 ±  4%      +1.2        5.96 ±  2%  perf-profile.children.cycles-pp.handle_softirqs
      1.56 ± 19%      +1.3        2.82 ± 17%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.87 ± 48%      +1.3        2.14 ± 24%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.10 ± 23%      +1.4        3.46 ± 20%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      2.43 ± 15%      +1.4        3.85 ± 14%  perf-profile.children.cycles-pp.blk_mq_get_tag
      2.44 ± 15%      +1.4        3.87 ± 15%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      5.08 ± 12%      +1.4        6.51 ± 11%  perf-profile.children.cycles-pp.sysvec_call_function_single
      2.49 ± 10%      +1.5        3.97 ±  9%  perf-profile.children.cycles-pp.update_sg_lb_stats
      3.01 ± 14%      +1.5        4.52 ± 15%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      3.01 ± 14%      +1.5        4.53 ± 15%  perf-profile.children.cycles-pp.__submit_bio
      3.03 ± 14%      +1.5        4.56 ± 14%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      2.70 ±  9%      +1.6        4.25 ±  9%  perf-profile.children.cycles-pp.update_sd_lb_stats
      3.10 ± 11%      +1.6        4.65 ± 10%  perf-profile.children.cycles-pp.sched_balance_newidle
      2.73 ±  9%      +1.6        4.31 ±  9%  perf-profile.children.cycles-pp.sched_balance_find_src_group
      3.90 ± 10%      +1.6        5.52 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_posted_msi_notification
      3.49 ± 13%      +1.6        5.13 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      3.04 ±  7%      +1.7        4.70 ±  8%  perf-profile.children.cycles-pp.sched_balance_rq
      3.64 ± 11%      +1.7        5.36 ±  8%  perf-profile.children.cycles-pp.__pick_next_task
      5.29 ± 11%      +2.1        7.37 ±  9%  perf-profile.children.cycles-pp.schedule
      6.14 ± 10%      +2.4        8.54 ±  8%  perf-profile.children.cycles-pp.__schedule
      3.91 ± 25%      +2.8        6.70 ± 18%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     14.58 ±  8%      +3.8       18.37 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
     14.59 ±  8%      +3.8       18.43 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     17.81 ±  5%      +6.6       24.37 ±  3%  perf-profile.children.cycles-pp.acpi_safe_halt
     17.83 ±  5%      +6.6       24.39 ±  3%  perf-profile.children.cycles-pp.acpi_idle_do_entry
     17.86 ±  5%      +6.6       24.45 ±  3%  perf-profile.children.cycles-pp.acpi_idle_enter
     28.21 ±  7%      +8.8       36.97 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     28.28 ±  7%      +8.8       37.07 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     30.72 ±  6%      +9.8       40.49 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
     31.92 ±  6%     +11.1       42.99 ±  3%  perf-profile.children.cycles-pp.start_secondary
     33.33 ±  6%     +11.5       44.84 ±  4%  perf-profile.children.cycles-pp.common_startup_64
     33.33 ±  6%     +11.5       44.84 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     33.32 ±  6%     +11.5       44.83 ±  4%  perf-profile.children.cycles-pp.do_idle
     12.73 ± 12%      -8.0        4.72 ± 17%  perf-profile.self.cycles-pp.osq_lock
      5.83 ±  4%      -3.5        2.36 ± 19%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      2.87 ± 29%      -1.2        1.68 ± 21%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.65 ±  9%      -0.9        1.80 ± 17%  perf-profile.self.cycles-pp.__memmove
      1.06 ± 10%      -0.5        0.55 ± 19%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.71 ± 24%      -0.5        0.26 ± 12%  perf-profile.self.cycles-pp.rwsem_optimistic_spin
      1.03 ±  6%      -0.4        0.62 ± 24%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.87 ± 13%      -0.4        0.48 ±  9%  perf-profile.self.cycles-pp.btrfs_bin_search
      0.38 ±  9%      -0.2        0.14 ± 32%  perf-profile.self.cycles-pp.btrfs_search_slot
      0.58 ±  9%      -0.2        0.40 ± 15%  perf-profile.self.cycles-pp.aio_linux_fill_buffer
      0.24 ± 14%      -0.2        0.08 ± 59%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      0.34 ± 25%      -0.1        0.19 ± 36%  perf-profile.self.cycles-pp.btrfs_get_32
      0.28 ± 24%      -0.1        0.15 ± 37%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.21 ± 18%      -0.1        0.08 ± 31%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.18 ± 30%      -0.1        0.05 ± 87%  perf-profile.self.cycles-pp.set_extent_buffer_dirty
      0.24 ± 19%      -0.1        0.12 ± 44%  perf-profile.self.cycles-pp.pwq_dec_nr_in_flight
      0.22 ± 30%      -0.1        0.11 ± 47%  perf-profile.self.cycles-pp.aio_complete
      0.23 ±  9%      -0.1        0.12 ± 29%  perf-profile.self.cycles-pp.down_write
      0.25 ± 12%      -0.1        0.16 ± 36%  perf-profile.self.cycles-pp.__set_extent_bit
      0.22 ± 25%      -0.1        0.13 ± 29%  perf-profile.self.cycles-pp.up_write
      0.15 ± 32%      -0.1        0.06 ± 68%  perf-profile.self.cycles-pp.btrfs_del_items
      0.20 ± 22%      -0.1        0.12 ± 28%  perf-profile.self.cycles-pp.rb_next
      0.15 ± 13%      -0.1        0.07 ± 12%  perf-profile.self.cycles-pp.__write_extent_buffer
      0.13 ± 18%      -0.1        0.07 ± 55%  perf-profile.self.cycles-pp.___slab_alloc
      0.15 ± 22%      -0.1        0.08 ± 47%  perf-profile.self.cycles-pp.kick_pool
      0.10 ± 15%      -0.1        0.04 ± 88%  perf-profile.self.cycles-pp.available_idle_cpu
      0.01 ±223%      +0.1        0.06 ± 18%  perf-profile.self.cycles-pp.folios_put_refs
      0.11 ± 20%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.prepare_task_switch
      0.04 ± 73%      +0.1        0.10 ± 35%  perf-profile.self.cycles-pp.get_cpu_device
      0.08 ± 17%      +0.1        0.14 ± 16%  perf-profile.self.cycles-pp.kfree
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.strnlen
      0.06 ± 51%      +0.1        0.13 ± 20%  perf-profile.self.cycles-pp.__enqueue_entity
      0.18 ± 12%      +0.1        0.25 ± 20%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.04 ±104%      +0.1        0.11 ± 19%  perf-profile.self.cycles-pp.update_io_ticks
      0.03 ±155%      +0.1        0.11 ± 36%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.08 ± 58%  perf-profile.self.cycles-pp.mas_next_slot
      0.23 ± 15%      +0.1        0.32 ± 19%  perf-profile.self.cycles-pp.llist_reverse_order
      0.02 ±141%      +0.1        0.11 ± 42%  perf-profile.self.cycles-pp.mod_objcg_state
      0.09 ± 30%      +0.1        0.18 ± 25%  perf-profile.self.cycles-pp.__tmigr_cpu_activate
      0.07 ± 53%      +0.1        0.16 ± 22%  perf-profile.self.cycles-pp.sbitmap_get
      0.03 ±141%      +0.1        0.13 ± 27%  perf-profile.self.cycles-pp.elv_rqhash_find
      0.01 ±223%      +0.1        0.12 ± 36%  perf-profile.self.cycles-pp.strnlen_user
      0.14 ± 18%      +0.1        0.24 ± 35%  perf-profile.self.cycles-pp.enqueue_entity
      0.33 ± 14%      +0.1        0.45 ±  9%  perf-profile.self.cycles-pp.__schedule
      0.13 ± 53%      +0.1        0.25 ± 18%  perf-profile.self.cycles-pp.__dd_dispatch_request
      0.03 ±141%      +0.1        0.16 ± 47%  perf-profile.self.cycles-pp._IO_fwrite
      0.17 ± 23%      +0.1        0.30 ± 23%  perf-profile.self.cycles-pp.cpu_util
      0.32 ± 19%      +0.1        0.46 ± 14%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.29 ± 28%      +0.2        0.44 ± 12%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
      0.30 ± 12%      +0.2        0.46 ± 16%  perf-profile.self.cycles-pp.read_tsc
      0.22 ± 21%      +0.2        0.38 ± 17%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.21 ± 19%      +0.2        0.37 ± 12%  perf-profile.self.cycles-pp._find_next_and_bit
      0.05 ± 80%      +0.2        0.21 ± 45%  perf-profile.self.cycles-pp._nohz_idle_balance
      0.28 ± 20%      +0.2        0.45 ± 15%  perf-profile.self.cycles-pp.ahci_handle_port_intr
      0.20 ± 15%      +0.2        0.38 ± 29%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.12 ± 25%      +0.2        0.29 ± 27%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.05 ± 82%      +0.2        0.24 ± 45%  perf-profile.self.cycles-pp.sync_regs
      0.41 ± 13%      +0.2        0.61 ±  8%  perf-profile.self.cycles-pp.lapic_next_deadline
      0.08 ± 73%      +0.2        0.31 ± 26%  perf-profile.self.cycles-pp.copy_mc_enhanced_fast_string
      0.28 ± 14%      +0.2        0.51 ± 20%  perf-profile.self.cycles-pp.ahci_scr_read
      0.30 ± 26%      +0.2        0.52 ± 12%  perf-profile.self.cycles-pp.ahci_qc_complete
      0.38 ± 14%      +0.3        0.66 ± 13%  perf-profile.self.cycles-pp.update_rq_clock
      0.37 ±  5%      +0.3        0.65 ± 24%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.47 ± 11%      +0.3        0.80 ± 25%  perf-profile.self.cycles-pp.idle_cpu
      2.60            +0.6        3.17 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      1.85 ±  7%      +0.6        2.46 ± 12%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.82 ±  9%      +1.0        2.78 ±  9%  perf-profile.self.cycles-pp.update_sg_lb_stats
      7.56 ±  6%      +2.6       10.11 ±  5%  perf-profile.self.cycles-pp.acpi_safe_halt




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

