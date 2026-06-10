Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6E7081E;
	Wed, 10 Jun 2026 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060284; cv=fail; b=URFHHWK3bQxYx/W88/0M9VBVlrjFgLyF8dV/TCj6kXv6YKB4RhODC8xW4cLEqbOyftbntsIvcmSt1A2Yk7uc41X5SSex+bclhrxV045NMs3H4+E+d+nl9+VJvf/WDxNDvDIUR4gUsBcEFzruPqykNBNU99PkJjX4VemfDN88Sfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060284; c=relaxed/simple;
	bh=UTX2qRx+uL7gVWnO11pE+djzWsfcI6zBQTKiLEa9VCA=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Z2xxI4Wsour3YHar0NDxsiYB5KgE8DqgFUSIYvTtVS/H/TOMHQ5OI6/btMv850U2xlZcVOeX4RGKm3yA+0v6fxpC+Z45h4fbmDWDvKvWuDsDREea2byJfzmNSM9xBEwZVU2bxVJfjHNeCGcs5EnLpRiQl6/9c58W/DHmnkhiE+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Os0KDhmU; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Os0KDhmU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781060282; x=1812596282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UTX2qRx+uL7gVWnO11pE+djzWsfcI6zBQTKiLEa9VCA=;
  b=Os0KDhmUN5fl1hXJsQx+2byqJJfFbzSHp/xRyWn+NZlq3IfKl8pfNDh+
   CQPt9wtdKgUPSp1kzTbj/3GWRKvThZJxypM1bMF6x/LBB/HC3gVqw/icy
   3SxqjtwsEUgzh61y9WedUCZhFv/9AImo6yp6tcUxOgGoSIV0DNmZIe6AC
   rg2KA41xPDvTM+iXYVxWVq/+3/Iwiefl9VfsCNWjVRaMYT7qt2DjNgUle
   j2QjSJoL6z2inENjRJeQDSMafXiDZmaHnKGMwxjWXoOlzEsYzsshuWynU
   p/2KKTRvmK9KiW+c5j/20kfF8QUprKqjjEBP5vHXUlShqj7whVAXBghjG
   g==;
X-CSE-ConnectionGUID: oc3xZc9MSm+XzYZXBWEQPg==
X-CSE-MsgGUID: LvojQOyMSR6OGvn5ZDsZuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="82036720"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82036720"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 19:58:02 -0700
X-CSE-ConnectionGUID: Msv/6mYJSZ6U0dtaxvfXkQ==
X-CSE-MsgGUID: n+1iUlmBSp697h8uayhWhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269715646"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 19:58:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 19:58:00 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 19:58:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 19:58:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XBZ/NJStDh16YikwpxBXgGbOAkmAWR3MNUcbnv3/MiVwu+Go5Ro+zyS2heyMvTjiO9AEQIpr1vnTg6H73n3PljkxugOVJgWbEPpCZmLG+AAJtvDPf52vmYgq8P58dHarxBiHXz8D251CWKtOB3N7kjCPLtTmPVqYv+t8CvyRllB16g+4v3huVwjgmTotfJPf021BDnET1LpyxHzda7oqR0NQLABSqXnu6kum+q3jrgHpKzuke7g42w8j1S7fhb/DbmACYy0+9hVtCmPefASK7xv1MlaKdcpNdn0UEVjA0dCTp2Z2OhDN8s4aDY3nJmgFnwcb2Rj1+HiyQlZAsLMLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKuGuT1WuMb8BlMftbiht4hpuNIeh3yxdObuGftdXTU=;
 b=DOjRNfrwtqeQhlOHnGSeSikxyv1NvpFavYT6C0w47ug7tAT+jHbEJxhP2BtxOJekUIx/v55I+UZq74Rt3qcEoiURwwmYKD9nWDqgispj4kY586xwfZrTV+SItzDQ9XfSiZPu3EoO+xf3qGIlMbytVKt60trw9uwWUKQlOCA73eyivMMHPj8YpZQmYRhio9BjsFCN9TwWQqM1TxXdlEtMr3/GnCZpmhdTbCRHjEbL9PbAKiW5U2PHG31eRylmQyaOrOOWsetBJV9VI7GUvvA1oj32hh6G6w0eMUkOX6OxgCFqdNNynem4XzLBhD2Qs6PHffVrcWk1YSbSDEVQc4ulBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 02:57:52 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 02:57:52 +0000
Date: Wed, 10 Jun 2026 10:57:44 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Li Chen <chenl311@chinatelecom.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>, "Bart Van
 Assche" <bvanassche@acm.org>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  3179a5f7f8: blktests.loop/010.fail
Message-ID: <202606100416.99599c18-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 37962431-3345-4436-96d8-08dec69c107f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|3023799007|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: vf50v/76CeD4YkJWIiJdp8s1+4bxuSIwgewvuf/7ZlFyjG+cr6+Z4h8MGZnSWMv0+bY0SvV5DqaERsb59ja0m0wW0tIJT1bO7ADap77B0ui2sqOmnHbNVZFtc9yBJqH2mC4MIGjw+3LDkBW4NJNevRVfClTu6PjT3UTKUcmAsBdQT3fn3RxX7vhl9ur6XWmM5H3EzL2DB2b0YOG51yZBlc2CYiWFVl6GgGm9036IfAm2tGNhlHHF1f2K9wxoMVV6ijkieCQftmuOoZ15DNO5K2mXKiNUa3LkAScR298ZGgS4g4G2AMNNJIOBHBuSxFrUBf+U6mX/TNL5fR/yZtZFEJekVscaWdbFHEUSOlIS8WSWkVy/3j6+G2Do5yrxkXv5uCeKF8hGC1aygErLbbQyNnmZfp3zq9PXyZGpGhnh2n0uQpMrq/B0aAVzql5p3vNm4dURY740fqggNG/hUZvXcWrItGCNDkups9lNXcan/SzI6k1LslBJj3//zYfTIpsqKm3NpKyEGzSj0d0CrrB47M5XEu648qAVJbF2DCaTQuesr7DVfzPNngYWBZNfmU7BYa3CiUlvvMMTeQpBMb39/F3TBeVkuhYPyUzktrjljzWACIbWcsVibr2AqrTiNFjU+3JTCWlBv/3MC/U3QB1iBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(3023799007)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uSOOBsVL0HOKIBp0a5hXF8MXma0D5wjkeK+JAo1sKKtCEHsmNOFVgAkheJ6A?=
 =?us-ascii?Q?rkXoEqbnBdexNesvwTM1VPvpWoqPwt12KJ+OVyzvzE8+1KJqBj438z97tAoz?=
 =?us-ascii?Q?2pAp+RYI6nrYrtJBbUZ1+Tjf6c0fuQCsSYMBkObbhv4u9GWtxpHkNmKJcCtr?=
 =?us-ascii?Q?00oUbnKMbzp0TKqcmdN1m+/Gy2isj1EmjHWm7ql4UbHWVeDU3GynTwbEjI8x?=
 =?us-ascii?Q?cfp/MCJicSJCGSy9+UF5wgJ4f2xaF2fSAw2+vvNWPfLVfjl3EzFG2cLNV5nC?=
 =?us-ascii?Q?5uo28xWh38rgM2MKvtlv8RPo2jya1iItMn9HzBkwZ9R9PEvQFAH360590UGv?=
 =?us-ascii?Q?9l/hCi3d9glWAmdjxo0XF/FrKunL/LKdhuxYtbpGtoTrOsrT2b2IJczP++vb?=
 =?us-ascii?Q?YtHKbwE+Hgc6vJiBUI3oLDlu+2gL4+oi/+txusGWHpCe17e4OR6CW5cpbUGo?=
 =?us-ascii?Q?9LoFuZ6k55VEmgWO8LIK0GT1bQJoJg8TReW0LSxBlBxiJfT9LATYMXGBewih?=
 =?us-ascii?Q?/kOmvKVXBS08OaVdGW7j26S3aGPouId2TUhG+8Ueg4JJCSdd6GfBs/FAS8Oz?=
 =?us-ascii?Q?WwLNka8W8wURyyA9zN6wxiY8SDnkxUBTJdv5MQUO2Jda/t576WEhfTPecrlw?=
 =?us-ascii?Q?MnVtbYMEtM3znkvDb2zxZNES6HyR+JHXuuqOgoRCa3dPVOPil6zDpzvacgP9?=
 =?us-ascii?Q?5Iq3mLKbH49T1DFhvB1cTDBZS9TYtVCilDXCLws3d3wmjljc1aIVPpQm4eEv?=
 =?us-ascii?Q?54FTn4k+Kvo88hxsFaK32o+L/rgyjMr1l1eIWWJR2fJBp8KxJunntu1/LLP3?=
 =?us-ascii?Q?KR3aPm+AeHlUnmQKUxD9OwGx6IwV6hz5p8r4xYKz0KFKDX88J3oC/zg8W/fh?=
 =?us-ascii?Q?A2zaprrXfBtgZdLS2440CWOidxfK+lPZ9sKdehSnXit8OiUQj+kwSDAsY6Kd?=
 =?us-ascii?Q?JnnKDg7z02FXrzrBWrc2B+8+zp/WhpX6YrXBfkk/L+YYODbHVMU5gNKaJ5yz?=
 =?us-ascii?Q?uIfSdZmKS78XQYz1mR/I2pQ7tPqs5AZODBpPby2iS9zEChA9KG1H5FLYAikM?=
 =?us-ascii?Q?ZaQHmFSVpmSyDphne5NjP4C7ozr1GWfC3s2E6WAZ9fEScdXY2Srj5w7m5NWD?=
 =?us-ascii?Q?rObEGIl/nTs7paJEMXO/yLxozGPEk22rvTQ2U0+3TeeT6Av0tmcyNOUOusUi?=
 =?us-ascii?Q?onQfm9It2FiIE6QkCdzK8jhR8fJehj8WiqG4vbUhgdkq5OMtVYYQZUz0gUHo?=
 =?us-ascii?Q?Fp6Q2aBmWiHKXu8rSUqwvw1YyaoDl5TvUT0zCRNRldOocIjO2gWngRGZ2dlW?=
 =?us-ascii?Q?zyg6irP1y9slSuy4AKhI9B9gVLlaPFcQuFo0bUerChAhT9H50mUNvD9I7zZW?=
 =?us-ascii?Q?YMV2jJTtenyk2sy4QNyunL1pDMkWkomVA+2CuolFVUQE3FifiqEKjoHHBPbv?=
 =?us-ascii?Q?dxp1T9t7p9hDZhVRlWm67LkvJbCe9BxDRe7eDvPy/7ucP1SK7hM+TwIUu1Hq?=
 =?us-ascii?Q?egoBNhxEPKPE4kW0HrRolt9QxBs2aop2A3xOexC5lwlXKqQugCC4fGuXw45y?=
 =?us-ascii?Q?amp0dfN4dX40GaUICRzCKv1PE0hoJQoN3Zn/ANpmIxYRUwP+dxw4Wa06J/o3?=
 =?us-ascii?Q?GKnNL413lrpBUoujymfVJvbzyNj4fVhdCwidD/GeeklIw7oJP8+ZT+59jD8t?=
 =?us-ascii?Q?hkz5YO6FV+c8JBHa/nG1x/0U6T54dmgpsO5cZV/cs6h3CtemjHFjMXCuKcSZ?=
 =?us-ascii?Q?GbubpSTa8w=3D=3D?=
X-Exchange-RoutingPolicyChecked: dCeZbJBl+czxPcJWlIGj/FjSIsPHdD80pDFnq5LOv42Oh4ZdQgrQG2nmCug1axtRA50Si8Ilr284I7mpvFH22hqtirxRB74qJe1u5x6BeCWpk6Jcc1EtjRiSe5f/EcO/HC17ARdaIBGNafgA1luE6kt4LJpREG7bzRov4APxVInfwZG3wMzBPrG59U5SLQfD2n1AaJwJChRMP0cUusC+KOtya9/HvqrEFqCKWk73ENnusZATEmEInqSQEpkbryxM4S5rEjLQAySzo444gn7Md+C/0KXdyRwK+YfUxHqoYBF2ZAmUWJ6MOBs2yTYY3ALS1wzccReENYwGpvuQvKerGA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 37962431-3345-4436-96d8-08dec69c107f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 02:57:52.8470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yFcessoYtDx13w363qTEPGY6wRLu3f6e0mVWf90uW2ymnJqLvY/pIIMRpAv0b1VNxCCq+miaQPafb54H3MX6+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.loop/010.fail" on:

commit: 3179a5f7f86bcc3acd5d6fb2a29f891ef5615852 ("block: rate-limit capacity change info log")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      c10130c234c81f4a7a143edbf413080235f8d8ce]
[test failed on linux-next/master 6e845bcb78c95af935094040bd4edc3c2b6dd784]

in testcase: blktests
version: blktests-x86_64-9131687-1_20260529
with following parameters:

	test: loop-010



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202606100416.99599c18-lkp@intel.com


2026-06-05 21:40:15 echo loop/010
2026-06-05 21:40:15 ./check loop/010
loop/010 (check stale loop partition)                       
loop/010 (check stale loop partition)                        [failed]
    runtime    ...  92.093s
    something found in dmesg:
    [   59.348633] [   T1202] run blktests loop/010 at 2026-06-05 21:40:15
    [   59.382173] [   T1223] loop0: detected capacity change from 0 to 2097152
    [   59.382922] [   T1005]  loop0:
    [   59.385325] [   T1223]  loop0:
    [   59.417927] [    T274]  loop0: p1
    [   59.793846] [   T1267] loop0: detected capacity change from 0 to 2097152
    [   59.794835] [   T1268]  loop0: p1
    [   59.796265] [   T1267]  loop0: p1
    [   59.802753] [   T1272] loop0: detected capacity change from 0 to 2097152
    [   59.803800] [   T1272]  loop0: p1
    ...
    (See '/lkp/benchmarks/blktests/results/nodev/loop/010.dmesg' for the entire message)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260610/202606100416.99599c18-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

