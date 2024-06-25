Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DB416C840;
	Tue, 25 Jun 2024 14:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719326986; cv=fail; b=nSiexuBBTeJV4ZaxPe2RupZrd4m9ZrL81qpmCqTKySxc9cI20Qh726v5zQAiNWm5XKzyFIVH10PvYOms9wCdkGxbvCmeOQiRmmPYysvEcHSM10rREvSbsEsW5FD2G+PMSRmObJQ/Isw/EUcSrRWgUSojls2Ok38jsH2BmZR/byU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719326986; c=relaxed/simple;
	bh=h1NqgAYntq11GoV+rN06DIY7mWcEyu+LpTuzQ4nIprg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=PJvH6R/w/LTHaJPt3DjldsyBjehfx4hNMl9tY3wOJb/e+nsD9JQ/2L+Jg0tKTIZt/KcZxO6tUZh0lPYI56P6rbv+VwED0AQcdgp7UcTmq4+soZs14Ol60ICCkHESnDZ18/CzA/lJbCGCT8AMlunQi1k/MNn7geXS65ldFJ7imc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DOGUub2M; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DOGUub2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719326985; x=1750862985;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=h1NqgAYntq11GoV+rN06DIY7mWcEyu+LpTuzQ4nIprg=;
  b=DOGUub2M+bMBfMj07bS0Jj3D6JheoeqEex38Mcy7TYf/QyXnQZH8bKTC
   BrSs2HsbqQXDGC0WnMstJiQg42BdH2uOrR/yVgDyVwDhKdJ8eExidDK9z
   +HdIT8cCrzSXF6lSQxary2YHOTUjvgGN5z7f7SoYbf/l6Hn5bT8MqZJka
   6rHDhbGAcSdX4wGEWaAXvWEPSpFGaYDF8j9bAd5UJ4Ab3kQUthoMtbRh/
   cB+YxgpbxsAfm2OnXPli4ARIkfxeiFfWc3z6jj+BkCxRuMXQaoVRjdEER
   iBPEefq5/1BmPzKQsF3PETKCLeU2e2rYxamN0LUkGCQVdYQypv6F/H9cN
   g==;
X-CSE-ConnectionGUID: JGeyU0FzSnyIkoLe9d8nAA==
X-CSE-MsgGUID: 9fW596/+TPS2sJ4b3CJgcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16104361"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16104361"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 07:49:44 -0700
X-CSE-ConnectionGUID: oOFZ4YuYQYyuTfFdYpVY9g==
X-CSE-MsgGUID: FY3OTUiASNexcsIyxxMWWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="44331009"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 07:49:44 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:49:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 07:49:43 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 07:49:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 07:49:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Okfc9rzlxPagTU2/3KV81HJ15HP13VftZ2Y9WbGPHMLpRMojLeXArRHOBTUYtoDCtye+pwNRAxMX54woxh+vQF4wAb9TcC/v66PqqXt7QpyPYP9b7FB7vCHMj+55QguaEYqooVcSTgrm8LaY8olSXuoGZSQRu2zTagxRJK1fLYopWkD04Q8gwtT1/14jJ7oa2/RNKT/UrJR+hpdh8XdpRBVab7GWSUehIbbA+um4YxA69JDsvl1qUBysNsd/lOqvpsrsYaaNrhIVxgtLzv+miH8CbAYtIXBcGfbzPvR38cE5OigH9U6TKRTulaZVfgRLeadhaap9Iyx/66ONxH7CnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzGp8efdW/Y0Y9jPjSAVO+yMawHBLEgicf2w+HdhmNA=;
 b=lKdduRpnN1b/E2y1ueGDltMx8JoHg+ClrcssDtpsdwVfrMV076ozoFCsHWTK+zUUYi0J36NYGXiI/0sE+wK954kYB+pw/V3nmdkZDvKegD+qs6co4RrMaqsBhdEjzTcO1m8wWcYe+SVAt6dRZWjQbQYwG+q4oM4JWX1X9/zjv/tBpOdN9uWY7Q9DPwBZ/+5KsO4qQt1gpcXIeGbYrLnbCZYgz7hBQBbO6PxSWBHG5n27mtogckMkLXuzPcrXRU/sfumhNHqL9e8N+LPxn/d9hPIkNOQfiSLR5//zYNgp1g3o36twPAS0QeHPsjJE30I93fPvDDz2ajw3CS8kK4p+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Tue, 25 Jun
 2024 14:49:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:49:40 +0000
Date: Tue, 25 Jun 2024 22:49:29 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Kuai <yukuai3@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  060406c61c:
 sysbench-fileio.write_operations/s -1.7% regression
Message-ID: <202406252157.348c160f-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 8110afe1-8e5d-48d1-3b45-08dc95260a9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|1800799021|376011;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?DWQifq05F4rdFtCTtMlLYf3lS/vk0zYLcZETqRordWzM3Cpgv9vDvYYHjI?=
 =?iso-8859-1?Q?2aIO9YPQErfqFo0H4lFKwhDwl3e365mbUVANCsewYPycbrR1Dbuy8MqCSv?=
 =?iso-8859-1?Q?IhtPc1x5j40VEZlG/LAHWWBY2R1AbT4wYQPydq5qtLAAeEsIx3R0HvdcH9?=
 =?iso-8859-1?Q?xOgPcAZEADBPaaQyJ82jPacRreeyiU5RjfQaPknpjp+MlSirpvgSMHLu09?=
 =?iso-8859-1?Q?Ol7SIn6/Cz+Ar8A3FX+M+YlPxu8kuRh8v3gKvO9hUBlrYyQOemaLt4ddRo?=
 =?iso-8859-1?Q?RWkG3lBMtCpk5x6tIgbkj7kuJPrOgIppbFjZbPjB4MQ8dfM4VtlcmEZ1Qs?=
 =?iso-8859-1?Q?MluwCrrQ1oaQGVvJ964cT+l083iu7xGSP/jxL2aZifzJ0cYLhK6/9K43gq?=
 =?iso-8859-1?Q?gUtQs58GXo2KmfDScMXy/AkXL9yUX/nWiicN82Aphro56raAJUd2psJwjy?=
 =?iso-8859-1?Q?I4oFjjfzp9A3uEBiJj1y1kyyG4F6uxYgS5/FlAV8dUgZqDgVWZsJXCHiz4?=
 =?iso-8859-1?Q?Hu5u77Ne9BpB/V5owYHZ3RpNcn3zoLarRaLkXxiCjL2U63C7qWbvaywaMJ?=
 =?iso-8859-1?Q?tMGKzdsQNxA5u18Q2I76pvQ+zt90L3V3ezv9n/vvP1TDdq3oqUDkpfUstk?=
 =?iso-8859-1?Q?MiCKSDpem02ncXKaf6QEC/76sX7KZGcyMYHe/3TLT4eHBcNu0JFpo13xKy?=
 =?iso-8859-1?Q?DDEsU26V2PpRPcYSTNFz3m+mZ/CarPdX7X1MIAx+rJfwwtcoPjyA7bXhlL?=
 =?iso-8859-1?Q?yFAALaF0cTNhp/fcUq+/qy1ysli9WtvEwZBgoStx+Rn2IwmhbWjwbeuFEV?=
 =?iso-8859-1?Q?43nQdDZnWAHjlMSTt3YOWG6YG7nMYlEivdao5zolWXUT8bxHqEKyVoMfaR?=
 =?iso-8859-1?Q?SX4Qm6dzrA9kro1tL++8vzReB5FZVTZUyg4ZadcXJEVd+zzTDyRlDnM6Za?=
 =?iso-8859-1?Q?bJbwosxY8mYtz9/98A+62PQKCsYZnSuLjnUFEfzhff0x/lVyDYOk950kGl?=
 =?iso-8859-1?Q?Et4qAUlqCKxn27JCYdDhOoDxDEc2GNgY6hzzX9My/twsJ8hgjV1lPM0xRQ?=
 =?iso-8859-1?Q?2gOMJf0yAdvt9Zm7NzCWkkoHPsYWxOO+PtqB0C0cDUApF9Cl0ZYCNT6k/d?=
 =?iso-8859-1?Q?TQcAsoflL3zvNqhbwUxzlm/+2eh/pFuNqhcUg/u7lRyvjXH58rHH2oRPV0?=
 =?iso-8859-1?Q?pjRcdVln8yDnQv64EdH536BlseLW+1LGyHi7HuK2k+ShVPo/eR0GBZOMH9?=
 =?iso-8859-1?Q?ooD2XQa2V0kBiSL7kzovPL4+pJKh04cR9lUOL2qY2jRqmrIplvjl9wtHyh?=
 =?iso-8859-1?Q?Ud3nmhUWSBb2OYacs6ti9i2LuQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ThdYDokrRWn/93kAM4tr+Iautesuhsk9+YPEZZMAZ2BCiRL7Bl49KsT2EI?=
 =?iso-8859-1?Q?yxPKMWl4DtaK7zP2JCZbEKSFT4aToAtARvvj98iHJirmhtdEKULiJDGTxa?=
 =?iso-8859-1?Q?po++Vv3bggG2eymzneXvXwPwLUlDy16iVGkiFTQ8h0afGt11ygnpFfy8ZT?=
 =?iso-8859-1?Q?v15dLRa0fcPjtjHlvnUjVtAR3lPcEPxptChcPZcjUzdPy/c9TNFf0dDkr8?=
 =?iso-8859-1?Q?MnZODcp9BEs+H2Cm1aFZnua8gL+0LN6vSwjCQtWbnLXX54cqQySXKUmqrs?=
 =?iso-8859-1?Q?gA+eCtx/mlxkCtRT36CFilYP29ZOcySA6zdSiYnvseWS2oTvs2Tb2Vd1Kl?=
 =?iso-8859-1?Q?VEvIjAWKKBWgda1QrggKKDelzrois56X4lqSLvN4Q9g4GkTRdkfPQtYnlN?=
 =?iso-8859-1?Q?+CndYxyp6/lWcrj1maPBYzb7d5tvekAr8eolVUe7PugSC+O3UWXds37JRW?=
 =?iso-8859-1?Q?84mtx5mYtFS/7JpEZR4Lq21l+aY1lYXgemw/ITt1FbV+S7jpM+FEpOowhQ?=
 =?iso-8859-1?Q?zupL6KFTeohGlnJXQlnJCKiD3AsBqyV5nOs+OWRuJqf15aeWwq/EHpXiFE?=
 =?iso-8859-1?Q?w4Oiulol7O98Zb4g8CmUNJ0a4ssO6QZQND8nSxmcgLOT3VvXl3Q27HG5K/?=
 =?iso-8859-1?Q?hK9aZKOZxR8NGTQmU8nQk/EJ1G73hf6Qktze4qE9DiIYkBJg21QBfAjt7x?=
 =?iso-8859-1?Q?tZATpNtpm04u/36NXqcBDV505hl7e8pExj+FGfCd7kuob3pHCebJaDnOqg?=
 =?iso-8859-1?Q?+/qJdub9e3h5KHk990TxpK7OOBzYKsQwbKQr1ul7T4fHyE8T1/9EsTZ+Lu?=
 =?iso-8859-1?Q?9UlaG8hdN9HWXIzdVejVv5/9kF1ow16hyAq4PzviawNI58TdxQeDqg0Zhz?=
 =?iso-8859-1?Q?iXxagW27JN9RBPRySCDxOS2H7mgGoXQk7UvWTJYbjsiVwRCnTTD7h/TkZ/?=
 =?iso-8859-1?Q?fd0imTsWZDHiH39AbPfmhm3iZB799SkK8wEpOIfUKJ4qsh3ZI3P9Lv8V2O?=
 =?iso-8859-1?Q?pWYH1cvRkFHhH7VY9KPbrjg/ybP0NDskhndE/eEzBZo2K5SNlyCaqJ2wHX?=
 =?iso-8859-1?Q?Qv7fffjYyR5vaQcz23R8Ml9OARXONbohQg6hElh3qe6e/gAfJesX83UgB8?=
 =?iso-8859-1?Q?FPMOVq2y9iIuTS3nt9XdanZSoV5//BhN0Kc3rYEz08cF6tnD72cM+U+bR8?=
 =?iso-8859-1?Q?I9Y62YHN3f2NVxsX6d76hgRvVtMQxWm8UVMDr9fs2wnMo10XSh9Tb6MNYm?=
 =?iso-8859-1?Q?l9M2Z/oGVy6iBuJJhq8Vrb1b7kiedgP2N75Vs2AIhXVN36i++qVcCLRVga?=
 =?iso-8859-1?Q?ocULp3HGSxEZ0Ut8gnUhFJmd0a9jMcWins6N58POziiDHrWrLIN0wQ4XUR?=
 =?iso-8859-1?Q?ZaXB/+nqwU5LWElExixhV65mYJG9EjlK7Nv4USK8OtgJKtGS+sQ6w8pA6h?=
 =?iso-8859-1?Q?fgleKXQUd9WTYz6P1KIkWMp7c33dpeK92ehykF2pK9+5RXiNyL5TVczzeF?=
 =?iso-8859-1?Q?NwgXbUaB0FN15+sbjw4CVf99bJzZ0gyRLEwma1dH2AyAJWy+kyAn5YKljI?=
 =?iso-8859-1?Q?kzRzJKtA+si65BMHbPhM43nNHEmuNn2nUYjTkPlsFIWZZ3221H1CQpUhX3?=
 =?iso-8859-1?Q?xpg57baul52nWBvb2RxxZZ5ra7Dn04OdM9mA6s2Ho7yNtSXg5ZsrU+ig?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8110afe1-8e5d-48d1-3b45-08dc95260a9d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 14:49:40.2616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UWQxjUAIT52nx2vJ4MDQLvA/MycwZz2eWQKbDgn91xzyeB5RZrggC1LfvxB3F8SaD8AI7+LAnKx/ccWQbNwRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6779
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -1.7% regression of sysbench-fileio.write_operations/s on:


commit: 060406c61c7cb4bbd82a02d179decca9c9bb3443 ("block: add plug while submitting IO")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: sysbench-fileio
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
parameters:

	period: 600s
	nr_threads: 100%
	disk: 1HDD
	fs: xfs
	size: 64G
	filenum: 1024f
	rwmode: rndwr
	iomode: sync
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406252157.348c160f-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240625/202406252157.348c160f-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/filenum/fs/iomode/kconfig/nr_threads/period/rootfs/rwmode/size/tbox_group/testcase:
  gcc-13/performance/1HDD/1024f/xfs/sync/x86_64-rhel-8.3/100%/600s/debian-12-x86_64-20240206.cgz/rndwr/64G/lkp-icl-2sp6/sysbench-fileio

commit: 
  3a861560cc ("bcache: fix variable length array abuse in btree_iter")
  060406c61c ("block: add plug while submitting IO")

3a861560ccb35f2a 060406c61c7cb4bbd82a02d179d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     24.53 ±  5%      -3.0       21.49 ±  3%  mpstat.cpu.all.idle%
     52604 ± 70%     +99.5%     104921 ± 10%  numa-numastat.node1.other_node
     24267 ±  4%     -10.3%      21772 ±  3%  uptime.idle
      8218            -1.6%       8084        vmstat.system.cs
     24.75 ±  5%     -12.3%      21.72 ±  3%  iostat.cpu.idle
     75.08            +4.0%      78.12        iostat.cpu.iowait
    132522 ± 11%     +23.4%     163559 ±  6%  numa-meminfo.node0.Inactive(file)
    237987 ±  6%     -15.5%     201059 ±  5%  numa-meminfo.node1.Inactive(file)
     22.53 ± 11%      -6.3       16.22 ± 25%  perf-profile.children.cycles-pp.native_flush_tlb_one_user
      0.58 ± 29%      +0.5        1.05 ± 28%  perf-profile.children.cycles-pp.set_pte_vaddr_p4d
     22.53 ± 11%      -6.3       16.22 ± 25%  perf-profile.self.cycles-pp.native_flush_tlb_one_user
      0.58 ± 29%      +0.5        1.05 ± 28%  perf-profile.self.cycles-pp.set_pte_vaddr_p4d
      0.03 ±  6%     +13.9%       0.03 ±  4%  sched_debug.cfs_rq:/.h_nr_running.avg
      0.03 ±  6%     +13.9%       0.03 ±  4%  sched_debug.cfs_rq:/.nr_running.avg
   -226.99           +41.3%    -320.83        sched_debug.cpu.nr_uninterruptible.min
     25.90 ± 20%     +40.7%      36.44 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
    194997            -1.7%     191663        proc-vmstat.nr_dirtied
     92615            -1.6%      91119        proc-vmstat.nr_inactive_file
    194997            -1.7%     191663        proc-vmstat.nr_written
     92615            -1.6%      91119        proc-vmstat.nr_zone_inactive_file
    952833            -1.7%     936954        proc-vmstat.pgpgout
      1035            -1.4%       1020        sysbench-fileio.fsync_operations/s
    140.12            +1.7%     142.56        sysbench-fileio.latency_avg_ms
   1559978            -1.7%    1533306        sysbench-fileio.time.file_system_outputs
      1497 ±  3%     -51.2%     730.50 ± 10%  sysbench-fileio.time.involuntary_context_switches
   1871907            -1.5%    1843314        sysbench-fileio.time.voluntary_context_switches
      1.31            -1.7%       1.29        sysbench-fileio.write_bytes_MB/s
      1.25            -1.7%       1.23        sysbench-fileio.write_bytes_MiB/s
     80.13            -1.7%      78.74        sysbench-fileio.write_operations/s
     71858 ±  7%     +18.7%      85272 ±  3%  numa-vmstat.node0.nr_dirtied
     33121 ± 11%     +23.4%      40882 ±  6%  numa-vmstat.node0.nr_inactive_file
     71858 ±  7%     +18.7%      85272 ±  3%  numa-vmstat.node0.nr_written
     33121 ± 11%     +23.4%      40882 ±  6%  numa-vmstat.node0.nr_zone_inactive_file
    123139 ±  4%     -13.6%     106391 ±  2%  numa-vmstat.node1.nr_dirtied
     59483 ±  6%     -15.5%      50254 ±  5%  numa-vmstat.node1.nr_inactive_file
    123139 ±  4%     -13.6%     106391 ±  2%  numa-vmstat.node1.nr_written
     59483 ±  6%     -15.5%      50254 ±  5%  numa-vmstat.node1.nr_zone_inactive_file
     52604 ± 70%     +99.5%     104921 ± 10%  numa-vmstat.node1.numa_other
      2.55            +4.8%       2.68        perf-stat.i.MPKI
  92991408 ±  2%      -3.7%   89545806 ±  2%  perf-stat.i.branch-instructions
      6.14            +0.3        6.41        perf-stat.i.branch-miss-rate%
  18893060            -3.6%   18215592        perf-stat.i.cache-references
      1.83            +4.9%       1.92        perf-stat.i.cpi
 6.848e+08            -2.5%  6.675e+08 ±  2%  perf-stat.i.cpu-cycles
    214.11 ±  2%      -7.2%     198.60        perf-stat.i.cpu-migrations
 4.678e+08 ±  2%      -3.9%  4.495e+08 ±  2%  perf-stat.i.instructions
      0.58            -4.3%       0.56        perf-stat.i.ipc
  92993821 ±  2%      -3.7%   89564915 ±  2%  perf-stat.ps.branch-instructions
  18876617            -3.6%   18201664        perf-stat.ps.cache-references
 6.863e+08            -2.5%  6.692e+08 ±  2%  perf-stat.ps.cpu-cycles
    213.74 ±  2%      -7.2%     198.25        perf-stat.ps.cpu-migrations
 4.678e+08 ±  2%      -3.9%  4.497e+08 ±  2%  perf-stat.ps.instructions
 3.003e+11 ±  2%      -3.9%  2.887e+11 ±  2%  perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

