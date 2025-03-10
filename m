Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FD1D432D
	for <linux-block@vger.kernel.org>; Mon, 10 Mar 2025 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592466; cv=fail; b=RVcPVib1jVnW/ErkJ5YxRsBAQ1x+GbLcdt40LqpGOmAyrTk1LZKiLsPzK6Bx0VnBFdd+g+CIFYPgHi9XV+J5IXCG0ZfSH4BKc6X20c0OdhKIVVAyqjwgCfSGlj9bR75B1qh3kI4IYn3iYkGPYtoYs/sWa/5usomgAKADWi1QYHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592466; c=relaxed/simple;
	bh=mRxGHJ5xZLVD0zWiTLEwQVZbobHu6F3C6X+7NayxX04=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Q7Ym1FUWHDqtK0tthY/6Khwt02OhEIqZzAt3L9s6bOUBFIkrAo/qKrbH9kmgeM7GFCxviI/n7XcZrpD3iv09o/kMHYNJKgiSfPu0ZEAIBg0WDg58YF28seh80v9/VWOHHVwAvtejS6lxUo0GS5lnGfuTqT5YZBZLSQZybDfUqKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zvi7HLFG; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zvi7HLFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741592464; x=1773128464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mRxGHJ5xZLVD0zWiTLEwQVZbobHu6F3C6X+7NayxX04=;
  b=Zvi7HLFGU4TCIpABeddqoGdeNyv4+DlnQz87kY/L++H0mG4P3QjFGwPz
   o4Le+DmqlGUJgBVv7aWkdz/r10QCt/E53f0OLp56jULMgS2fGCzQkL1dt
   wrFHwy4J44WC7peBLo+dA3rsRdaaHnbRa6s/ItUsA/Qj1sbQGDHDypDkq
   6dF3BxH7LeN5DWz0zyw0zoNs5vD3glaJcI04BCHyYwpYcUVCTc+x5MldT
   Mn5EFE5OfaFTC8e4SVSDcbZ9stOOsFyNm5nR9clIH7IoXs9HpUDJEzizM
   E6BVVnL+bxUdbPoVd2lgeZS98j3C+s391rq8vPMMVpJIk/7cuSMaT4sMn
   A==;
X-CSE-ConnectionGUID: GbJl5V90Se2xSoLcdOC5mQ==
X-CSE-MsgGUID: JVdCiy16SYCDddd7PjWvdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="53211902"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="53211902"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:41:03 -0700
X-CSE-ConnectionGUID: 3tHzxmwAQLCQsHfG9IjvOQ==
X-CSE-MsgGUID: adcmhBNwTPSslvp3HI7Y/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; 
   d="scan'208";a="119867028"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 00:41:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 00:41:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 00:41:03 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 00:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaC/Kl6COWZYOGYPX9PGcaQv08fXW3a3iDXe/to+uceNEmQXiP5PJ99OlEKH7Y0n+wjsWmkJoEvUeBHpH9zvsjkmJWvNwPkkSutqAO/JnqQCaXUNv/oq/+rxCAsSAB7GOPAkBSe28uxxm8ixbAnqBRwaHz29x4oYyZFRyuKD/LDxRxequ/UQotJDXaSLB8xR+ZGutw3V7dIlyUCMXORS6mMPQSxYTBm5Lk6MnrPMnb1FVmBgZwnCxq8ZR44PJR9OCO18vSH7ALbAkh0fu7MtbYcj/L87IPAGtgSSoIOsA1cnPfkrQidFqJt/hQCugsJEgXCXhhoL/lqDtgd9Qo1IFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q72svUbTfUK9j0Vbl3mEArX3eXGhHNkuIU6PpiB4HJ0=;
 b=dEuWmZkcbMRwfYxoDF81bNst3BftcNQh7+9CPUj3pBinb1hwu49hkK5bOoWRxjkgsz64rVwuQ0mdvb20ARyXhiK8Q2oKyu/Q+XRL1I7hRBsaL6yx+5VzI0Sadwk4RRepO/qWaaYLkMvRoomhIRyMZI+tTixSZRS24QSBUZrAwGfCU9qURhE/IhCBSRRVYyf4RrB0oajarc/l3VqHW7vbSrUYRNOc0vKdoyJMtGDiSNExWZtP5c0WdC//j0XZ/EXdnRmHus0MqzXv3TCoP8NWvlF0B72BTD0rTuiB1G8KRrvS27ObLj0lC9cI6JqJ67fvwFHgZgBpIUYOT6OGDeT9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6904.namprd11.prod.outlook.com (2603:10b6:510:227::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 07:40:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 07:40:12 +0000
Date: Mon, 10 Mar 2025 15:40:03 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Christian Brauner
	<brauner@kernel.org>, Hannes Reinecke <hare@suse.de>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, <linux-block@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linux-next:master] [block/bdev]  47dd675323: ltp.ioctl_loop06.fail
Message-ID: <202503101538.84c33cd4-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0185.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c8ed7cf-6af3-4a85-7133-08dd5fa6cac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oHsqO0IGV3nlCmtiY5lvGzwao7vwdJz59htcVTZQhDJORlwhQVE3I2hltua7?=
 =?us-ascii?Q?xNqR5yASzgrawtNNfn6iEKDuUDu2BG1N52y21dwrjhB4C4NZwgrzLFkl2L6f?=
 =?us-ascii?Q?8/IOEkag8bT+XBUy89ah9vK2E+qTgywkLif0tV4gwYs6daY7Ao6eRvv01yfJ?=
 =?us-ascii?Q?dgQdfgsQuMxMInZcN4IZlMRTl7sI6+bRLKS0E6fUR/KgJ80sIsRPI5p+HtG6?=
 =?us-ascii?Q?BabT+ysKyl/ak1n9bqUXcLaRGTxj9nEFQdpg/wvcCq1JM3ppQh1SsXZEYpj2?=
 =?us-ascii?Q?72sQbje80jCw2Godap0E2RBHCHs9oQkhhon6WhJsoHyTOr/cAP8NXYXR821M?=
 =?us-ascii?Q?8gHjfT6XBiWelOZOHcCULY3IdflyBge0YzkWZW8kbLi7GCQ4QO5K2Vuk8XUf?=
 =?us-ascii?Q?M9i1iDV39eqXoWp8FwYVOtEyNs7Ha7N2nFPcVv/SPrljN1NF4bGSvWAaFVWH?=
 =?us-ascii?Q?4xAjOKUKwbBpTIcDipiwYcXdc2YBcxGQxUMxWXrPbQCmX7ROe08ytPMqeZBf?=
 =?us-ascii?Q?sL6XO+v7Va7xdroG+z7+sqQmbFs1wAJDM8faDQbbv2xAPF1jDQkWB6adR8CE?=
 =?us-ascii?Q?SOdQxjMkqfKvvps1phqK5SokmWrlT0xEfLROQQ4ysg+jTKwQIMZRxuao7alV?=
 =?us-ascii?Q?TJjjBsQMtyebNLa0rhsiraPBVdyW3TztJ2/bLwkymUtTuJqoZoLehGeL8vh7?=
 =?us-ascii?Q?mIOX89dlSF5kzvbUSDjrbOE5O3IVk4TC7l9Wdfbu5RG1fH93pGjTz5Xxuu2Z?=
 =?us-ascii?Q?JPiS+udBJny83bKcCHOy54wrbiY8BonZHc+mfMaJF+JcX/JEhis5m9VgHXmj?=
 =?us-ascii?Q?T++PZ5RRSX3WX3msHu6TSoShk9E6SDuyMV6U7Ti8ZG8kYi6QQKJDkfEqecoN?=
 =?us-ascii?Q?QCdMZjat/LxhJTjBDOwSvYHCocrR/NWQKonGWgm0ZiJV84tcEZaK/J5xXUWr?=
 =?us-ascii?Q?is5Wg6zuojZ9m9z9ed3kEtHPcJ2fq8Bjklx/NCVj0W73aC6tjU+TD04TOrRJ?=
 =?us-ascii?Q?8G+mZddykCxA6bRTPDAlOMHKbUphOoH/10azHPlGioHMnvctZS1gKzE6LK7l?=
 =?us-ascii?Q?9Kx1zl9eHph0NXnLVBEs7AYB6MSbDhdG7jdn6Prlyf3okIkWG/T2PXw9lhtg?=
 =?us-ascii?Q?O6L4NcUc1x38XWxRsDVWzgFdBRLKvLgoQByXFn8p6yR9YRXk2lPXMNBbhd7P?=
 =?us-ascii?Q?RPUTpizOVmIllhwgO0lzXUcABnczP5Pz1lkfIYJxLRBWkTitCrbRbIkANn2R?=
 =?us-ascii?Q?CxWLUIarEzLoLO5Tl+0feNuoiAdqSVy1PwvsrqrjTypPadx3AFXREsnHlJzc?=
 =?us-ascii?Q?ufzXMK3G+MbuKuFVRiahUmCTjD7vQWSwQQAwBSi9ak4DQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Soejc22ZezezOq1IArkiuJPx4CikPfvFBo7NNRZCQkC2FjmTTW4wm+woBBLO?=
 =?us-ascii?Q?tW1hXkpHC9z9ntsxdqeOvE61y26jyviZEgvwvg2yiyqBvUlhA7+LLIQDabDw?=
 =?us-ascii?Q?PqyVX37oEzLEKSvUbmSMQA7OsH2zxyJ9khdQwFkMEgRFIt6ePPFkDZgLLvBW?=
 =?us-ascii?Q?mepH9uUTGe8YerAKK0ScAMCTHqXtJgISrCssFQFSvUKZ0db6GQVDGnjU05/3?=
 =?us-ascii?Q?tx0oJLGrfL4VvZ2mneBVpW0mbv6Rqg16+gripK0curowgQL30L+r9pfdjQna?=
 =?us-ascii?Q?cNvp3T2eXCv3OiAv14H/CH/IM1r31iruZTK/vRzOG/1mZxuEnZfUXtXig8Xy?=
 =?us-ascii?Q?NLBRw0JeJOpQaRFPmvDhu+bBzVIhQfAofTTWIHRpnCkuspktTSKi1RZctOYx?=
 =?us-ascii?Q?44JO8Z3InSugfC13OcbI0jZwfcVMRQH7jsjiWZ7y/4Vypc/ftu2ukq2MELxs?=
 =?us-ascii?Q?r9NgGuTqo/WKpJqNbT8d5mljc/cBgU6v0Ziiu00qOZdCj7zoc/ZwcXGDI1lP?=
 =?us-ascii?Q?T5t7pAOluiZSfIZagFvsWdctExe1G9KkbbtjZuH/lGhKVK41hOXnNeFfd/KO?=
 =?us-ascii?Q?vToX55cp3Sck1t4D5xgpAAnuiYQsjfJs7Voa2gg1G0ggej8GTviwx5cTzoOQ?=
 =?us-ascii?Q?7jXuYseHYd+bjwHOMiiejaxzfP1B/vRd2tNNBsOXf8nujIn0hnd3lb+3hTae?=
 =?us-ascii?Q?3KbUwkVU2TXzB22DmFivOB9LCWHxwaC2TgF6jUbimV7A2DP25TSYST3CJuzz?=
 =?us-ascii?Q?Lzini5jO18et+vpMRydV7Uy4LIlLAsIwW/mcf8EqF6BPygjshJTNSCzcjQjo?=
 =?us-ascii?Q?NKm+zN2wKAHmuHdq/0jOzRko3jpOkSq8I4YzLSYNJmIWyyReHaX3c3xQXsnp?=
 =?us-ascii?Q?PZKqx/1ExgAZfeMTv+0gN0kDGlF7BJs1SzQwgf8pLG6c8Eecx2oZM3TTjIne?=
 =?us-ascii?Q?Fw6RCa90P/Zev4ad040a4VWj+0U8m0zZ+QWeVXUeUHASMj8Psujc5JTRrYAT?=
 =?us-ascii?Q?MQh+cwaBdkGqDB5W/bwaDeqLx2fSgbDOtTPI3TB+z3Jgxn9HGRz7Hz8zpDGj?=
 =?us-ascii?Q?HZQK2mkNJSeoOzL6ur0yoVBT1r/226lxta4sB/vhIQcRl/Apd2sZqFWduXX6?=
 =?us-ascii?Q?bC+SvTvqINPQPPelxsSXxsAdIRiPUXO8J06JuJZi7hZkJLFwiJ1CV94JSCR/?=
 =?us-ascii?Q?FnmPPyLhJ3L1SSbc9w8n3rQAzboLcFqhK41TZ9n/pYzu91lMarG4TWADkWfi?=
 =?us-ascii?Q?lt0OkgKFLyhKczou01Ymo9p0KPW5btUiMHpx5M7lG0QtWRkiiS7OzNy22slE?=
 =?us-ascii?Q?oOky5MRRo03OAzf47/PHNgUSQnweAJhklhEuN0Op+lAbfOQEVbDpye8sYRJO?=
 =?us-ascii?Q?K77530Y6Zsx7Dp56A3LvWanKuhFxn8LWbUbf34NehQbCdlXLeT4jjTUhJqdw?=
 =?us-ascii?Q?0jDsEvn8giXkaTQ154wupsZHRW9VuOCM4KpzMxm860Kz8F0eqyO6xKbrREcT?=
 =?us-ascii?Q?vaBRMxSOHPdq8syTKoQ02aSPXsXfZqqT4QE/YHWsSYSJs8ttOJRMYmvu3UaW?=
 =?us-ascii?Q?T+F5YuJ5UU1XKwtnV7CRAnfPgGnchHk29dbcYZUTfYrx2nhcPZxnyCXEMcfG?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c8ed7cf-6af3-4a85-7133-08dd5fa6cac8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 07:40:12.8627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EtyOZ+HmfuwvtX9p0x+MFfljBi0hj2jFbXN+e6Z9gEeYOtiRrUkIVD+EYhxM8n7pjBwxMLguY3xOrHM/K3nFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6904
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.ioctl_loop06.fail" on:

commit: 47dd67532303803a87f43195e088b3b4bcf0454d ("block/bdev: lift block size restrictions to 64k")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

in testcase: ltp
version: ltp-x86_64-0f9d817a3-1_20250222
with following parameters:

	disk: 1HDD
	fs: xfs
	test: syscalls-01/ioctl_loop06



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202503101538.84c33cd4-lkp@intel.com


Running tests.......
<<<test_start>>>
tag=ioctl_loop06 stime=1741322388
cmdline="ioctl_loop06"
contacts=""
analysis=exit
<<<test_output>>>
tst_tmpdir.c:316: TINFO: Using /fs/sda2/tmpdir/ltp-f5uEC1THVm/LTP_iocbBycpj as tmpdir (xfs filesystem)
tst_test.c:1900: TINFO: LTP version: 20250130-118-g0f9d817a3
tst_test.c:1904: TINFO: Tested kernel: 6.14.0-rc1-00007-g47dd67532303 #1 SMP PREEMPT_DYNAMIC Fri Mar  7 11:25:50 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 10m 00s
tst_device.c:97: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg != power_of_2
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size < 512
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size != power_of_2
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)

Summary:
passed   4
failed   2
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=6
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20250130-118-g0f9d817a3

       ###############################################################

            Done executing testcases.
            LTP Version:  20250130-118-g0f9d817a3
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250310/202503101538.84c33cd4-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

