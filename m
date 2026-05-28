Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814D233923
	for <linux-block@vger.kernel.org>; Thu, 28 May 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951947; cv=fail; b=F68V8jeHxNn5kng7m4zkIYukj8xSojK5YUWxW3EhPaa9PzjuB5fl+AvjVJTe4RCSLoSFuXNf8l9v7YD9xK7ItUZSl7k3LybwcU9CIPd44S9HCi9P3AMlMtJc3Zdxfno8hVbi3K0nJcfQ7GbIVMzdNoLq9w1iWqbLnARbDhiKiU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951947; c=relaxed/simple;
	bh=3zPH2aa6L6E5etcDeAu4unTSggETDilBz2IdelRG0J8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=uqqUYxAiDkuBgtY363da1IuQDbR42SNIaFCKL62Sv0qjZaMdv9mtgJutbQWweauCFtmJc2LmWVOb3uuGODWNwFchxZjm3xWMUBdc0scDem0SwhhHdRsdz2E+H6qhLUsBuF4Fte595xfY1CpP2Sl1mSgts1cOzeY5fOufoDtV/mE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UD7QLP05; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UD7QLP05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779951945; x=1811487945;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3zPH2aa6L6E5etcDeAu4unTSggETDilBz2IdelRG0J8=;
  b=UD7QLP05uMO+AovryyqjqjJdtRFUeAn51349cG4PrVOro84FHBgUXXQj
   nGglEvpRkIjJAv70ddXwLgK8l52NRVr1YAGQZDhcTONyorQKB4bVo9o6e
   yv9th6TS7CqLr0eqaV0LvMivEU2rfQlwSItfLTE2al2pqGAg6o28Z6tGK
   TF+wd/wyOEXfv5wnpwnJ+8VW9H46Yxjd2pITv9IHTN+bLxXqKIsKSDKp0
   QonHg93nB9/zViKb8XPCNZI43jHfvFHE7ghLJuZ2rAsxmIoOCyUI10tQ1
   oihTeRmFGetsn0DfIO4fOC39Jlryu7Mcvj/i1P4FXEo97QSnzEha/bdL4
   g==;
X-CSE-ConnectionGUID: ZOzgTeujTXO+RkX4dJJZOA==
X-CSE-MsgGUID: aVGCfZabQ+2noMphIXiIlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92264360"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="92264360"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 00:05:44 -0700
X-CSE-ConnectionGUID: xJX8a+DfTAGu9Lz5B727dA==
X-CSE-MsgGUID: zvXvX1SFTaaTkzQxpMKwiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="242626844"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 00:05:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 00:05:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 00:05:43 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 00:05:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjrpIRgnlNL9+gA7EJ/UGpWguUTb0rTOGWSnniy3oyEdH0XuEhKnSTsPUHERyyz+w82QMrM/DdaLEj0u9kOo0rBVtmK6zUElA4wjn8MYiTAUCTTXWpkDreQxQNwZz75Qa/FwSapXDEwWi/dlTHxI4vTMxkSoCvenvVTGXB+/ji4SA66HOe48ul91FOzIe6VmStvryDXQZQI9gm0qxbtg2uhi/jqIDgA46DxwvjkuR0WlTA6eMmAtOKygmCofOi2u+5bVK99xXduczzFvfN2V6iLPNzlbG7iyo6C2IEtgqtMYnRFUC/0WEhIK/iZMEYnfgqLSPGK/tYuTwzO9GWC7dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ41ByX5xxniM10j6YFzAgWoNIYLxCmTgqGFwrXX/Xo=;
 b=g1WiYkf6qSIP0Q1bptwR8WU86xWbR3JLZkw2DNc0IlN8vxjeN2XkgCvtJTl5/l88iVTZgBbdjz6gA+G4Q+M8ePo50+7wI7xzIpSxzwYRjiBhGZd9SYV11R2fN15MT/bz9XkC54M3ByYVPGq0LZasD8DO0Xve00G0nzIxAj1YrUDcjsBk7eDdFUBaQVRwC1X0AtY0rAb/tcRL5mWQuKxQsqCKwMvC9ieuXhwd57Jlj+EUC+HuV3q9uGpN11mq7fhr7zK45fQO5sAAx32c2y7kgGs/iw0AeRMEapATN1oQ5z/2IOnShWyFTFPhtacttL2uXDPGO2euBCFNiHvYWYBnuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DM4PR11MB6381.namprd11.prod.outlook.com (2603:10b6:8:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 07:05:40 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.21.0048.019; Thu, 28 May 2026
 07:05:40 +0000
Date: Thu, 28 May 2026 15:05:33 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [block]  73cf422c6a: EIP:look_up_lock_class
Message-ID: <202605281444.29e7f79b-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DM4PR11MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 370e2434-c770-475f-a884-08debc878687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: U4l8ZZvjtKUD2v3hzQg7s7LITHYBH8EBEqZ2o3Rcrce3jw1BTnHNYgMOM5JDE7Xn7i5IuSRFXfTIBe0FkFUY83+TmMi5xSvc6oppD2yzdk+mxVnHYd8mN3jtdKx45Cm8CjrmvT4MYNkLbwGVL6AxpxdFEj1gFWfSJzVWKIX5ueeoXMzNcH3EnZhQaGzsmOmYMD/AZoQFo4uZEYNodN8ogtUNTDKaHTjfTzJqLkoHFLF8elMGbpHHqFok6xrL7oTTJOk7csLl8w8Kl1PQ9SGTtJLGJYc40dxvhEMqjS9tXBCOuJh3kkNOP9s/xeWvFM+nQ6uyi61Oc9/KAbg6MQ4wOtgGVPZfIgwnW03HQ5f0AJdp5VnONBNdp/5G9eLl84d6+77tvO2ma5QTp8Qiavp55JM+Ld+BMtKwoutNgad4D7R4oIlH/94Bs8qULFOr5XYGTB3EJojSvcyvTdfSCBeZa2jXVsmdUxAjfduI6Cdf2YAjE/LQgmFVH2fSOqaDgXorF+YW5flsdNQLgDDI1BEbow/Z5n+vBl5B0wEWX4cf1uASpc9o4+b5SRhFo7L9YmlzPgDJSIVQXIzy2RTmev5QcN0Ib5Pkc8+HKgP/b6/sllHH6viAY3NL8wE3J8a5NalaJbAdsMrfUiLBZmgcUROIBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BIBJRZiGDFcAo1JNvLUOxLIEZx+gYnVI1uXXhCTxAiVQQDpA2JDVL85PZSvN?=
 =?us-ascii?Q?JhdlqdiHdb+mtA1Ip9u6BjqhjU9MuZpgQEzrcPCvSrLIIavHyqQMMncFAnHL?=
 =?us-ascii?Q?M09N7FWebm4JS9PYtuA7Nsj/xR4ZxLqM05JeQ/sDX69XwejEspmcrmPM/Xeq?=
 =?us-ascii?Q?n6lc5gDE6NyYpvicmh3Sxdd2OXiszGylJcASGYlM5oXnKs9MkXLCy+5noDUa?=
 =?us-ascii?Q?jJfUCcYi+HJEhR5nlhB7DwMcJN20kPta2kvtw1aYTFPqtP4oH8uTUJsZIUmB?=
 =?us-ascii?Q?vC1vIWiv4cZlSGiDzQGPJEPsi3RJ28EWAox09qPWiNkMdbID1+NzUXEQWEHe?=
 =?us-ascii?Q?CnayvTUe+y/zMMF3AfKkZGOyk0m3MRUgevK9sSEqYDYDmMuWSONLTp1Fm+fL?=
 =?us-ascii?Q?dWT05vRvPc9BuP8rezwqVBTwmFjoK3sTYpCsui4LN/LEFfuZusYWenfr0rvj?=
 =?us-ascii?Q?uShF60FsEkHB9zkKdRUSvHrPd8lz662/+QE8mLd5uZE2C8eEpYVdU4Z0sjga?=
 =?us-ascii?Q?GCTbVqrxq1obGVwP1PtTjcGK5sLbZuzGkZ02xFYhlvQcCrKZa2BJGMeIFW2U?=
 =?us-ascii?Q?6Hce2U5goFMU4kW4dKUfvSr694V04jozHXrPxwRHeWxCnCkBdeYDOWnIslX3?=
 =?us-ascii?Q?Sbpx6yw9w1H0ebP5kt28PxfLjsS6k3KiT677WmrDvxKNOoIFXnp90u6Rgxx1?=
 =?us-ascii?Q?vy+9vZqTTTtpI80qCp9gzzp9Ez4jRhEK6X1UWRdbWp9qB8duAz6AiMfiWwwQ?=
 =?us-ascii?Q?9ec9Pn6+xPjTk3C9KIAVIWNUc/UVlcMaTKiKfUAUNBXXYBqgYj6scq9M5W5m?=
 =?us-ascii?Q?wvHetmz2VeTAYgwGBKfrLGYYtWeXbudVa2ibwQ0wEFM14lZY3jmZR1DeA4CU?=
 =?us-ascii?Q?PS144mgIQAg2MGNOwG5qHgX1aYuAHI4vZd5Y5VReZJHQ1kUEoSi2MPZYOSWB?=
 =?us-ascii?Q?A5PHOAclFI75pppYmUPcBGRcQuFQKaVijBNenFVRFc2iOCtqPD1qMk5/JCwU?=
 =?us-ascii?Q?9unBK4cVkGrMdTshMnuAsiLGMBmqTAYwdsNoNICHSJX8DKvtAwQ9tAx3tO4P?=
 =?us-ascii?Q?W/Gti0i7lw4ocgFhzFJroIZb1rRdMqxfGIxGKjQCmzmBUYwDSFLl6qF16JrF?=
 =?us-ascii?Q?CpubMVjqljn+CBSsWo0ADwXXpLkOeVPc2DV2F7WhyTNvRsEXBnvm4jnyHvWH?=
 =?us-ascii?Q?j0ilkpVfV5tCDL/1nj5xfE0DBBiu7fgq54NdYzJ/TiSFJJ3YtkSZYtWYRAM2?=
 =?us-ascii?Q?0VUObjkMI99f4ww0UDr7NPit+/txqYcZntOYoAxQRYd5zYlIXhsrtPE85o5s?=
 =?us-ascii?Q?7B6XA/mR4fU04jd2ObcgWIyU4F1t8xsZ/SFfXUQlKJLuAzqz50XeohJ28UQa?=
 =?us-ascii?Q?ekVRZbR7veQIXH9C7Gwk8w5QRniahsIhfLx5uxZwvNKW44c0ibsIZqGZ726b?=
 =?us-ascii?Q?MBPRDyE9sQUi8vk3FQu8pWeWDKfEyzY6kzDDygSQUTOIiL9eQi+DtsrfDSHM?=
 =?us-ascii?Q?NXmJJnqFr2iK0ItAgasK9uXJ/NCsZIGfpPSCAZ+d4WsIYZI7sDN3ZbCUA/On?=
 =?us-ascii?Q?p+hkv+k/GrLXdz04JLud0+mXXIQBzg9p3+kiswyHqI1QLpDUDWb9A/K4iSZ5?=
 =?us-ascii?Q?jePQNiek+pNZZ1sps+0eO8FUepUiGllSbL55Ixabbu0PmFC29X3Xic2RhstX?=
 =?us-ascii?Q?SwA9UvRuiPvrZnzyIGtP7vOnpMkJ8RJFGA25mHIUgHWjBWUCkAI87bQZNbCs?=
 =?us-ascii?Q?HYZkE4NbUw=3D=3D?=
X-Exchange-RoutingPolicyChecked: igeFos2mZYjrepcocDoc/RwB822xmVc5h2NN5oqZK2PMF5V7Ov9Tj4Cx+ocMSFAziq2eqembpKB030Cyx5p6flXl7rtc5XbEsVYnpStmrunUf0QYULueNWFTHA3dsD/7B24X1S8XCnsmX9uuuNQsLMtJdzr2ipvELYnNUk+yshDe9MuqSV6B7D7hGQZPnj2MLOs6nCTcWPyRCqjXTR7eNArPEOCbvDHo2ANvDSCPCqL3E9zog6h6Vfs3W75BMzoxPrWV3YjUV6ZEy5pLYO2Ho3tF7PsBTOhSP+cv2jrlxwe8eooUIIiNKrTKJVB9csDNceubOMWHNfMvJegzaJzdpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 370e2434-c770-475f-a884-08debc878687
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:05:39.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5X0I4TJH7es9bfYMCKwlBWSdTP/uBGzkapCX6uQzGYEBBinjq8B9NCQoqoCf666Aw9DRDt/PbKKB2gWFH1z5Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "EIP:look_up_lock_class" on:

commit: 73cf422c6afb067b7e5d395dae8c44e076a00ebb ("block: assign caller-specific lockdep class to disk->open_mutex")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master e7d700e14934e68f86338c5610cf2ae76798b663]

in testcase: trinity
version: 
with following parameters:

	runtime: 300s
	group: group-01
	nr_groups: 5



config: i386-randconfig-007-20260527
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202605281444.29e7f79b-lkp@intel.com



[   15.148854][  T192] ------------[ cut here ]------------
[   15.150937][  T192] Looking for class "&cd->lock" with key sr_probe.__key, but found a different class "&disk->open_mutex" with the same key
[   15.154899][  T192] WARNING: kernel/locking/lockdep.c:944 at look_up_lock_class+0xfe/0x140, CPU#0: udevd/192
[   15.157990][  T192] Modules linked in:
[   15.159228][  T192] CPU: 0 UID: 0 PID: 192 Comm: udevd Not tainted 7.1.0-rc5-00007-g73cf422c6afb #1 PREEMPT(lazy)  9df36ae0f1aead0a85dee313de9d5bfe012b6acd
[   15.163724][  T192] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   15.166935][  T192] EIP: look_up_lock_class (locking/lockdep.c:941)
[   15.168594][  T192] Code: f8 64 fd 83 c4 08 0f 0b eb cd 80 3d e5 95 8f 45 00 75 8f c6 05 e5 95 8f 45 01 51 52 50 68 c7 4b f8 44 e8 c5 f8 64 fd 83 c4 10 <0f> 0b e9 71 ff ff ff b8 90 88 25 45 89 f2 e8 af 10 35 fe 83 3d 18
All code
========
   0:	f8                   	clc
   1:	64 fd                	fs std
   3:	83 c4 08             	add    $0x8,%esp
   6:	0f 0b                	ud2
   8:	eb cd                	jmp    0xffffffffffffffd7
   a:	80 3d e5 95 8f 45 00 	cmpb   $0x0,0x458f95e5(%rip)        # 0x458f95f6
  11:	75 8f                	jne    0xffffffffffffffa2
  13:	c6 05 e5 95 8f 45 01 	movb   $0x1,0x458f95e5(%rip)        # 0x458f95ff
  1a:	51                   	push   %rcx
  1b:	52                   	push   %rdx
  1c:	50                   	push   %rax
  1d:	68 c7 4b f8 44       	push   $0x44f84bc7
  22:	e8 c5 f8 64 fd       	call   0xfffffffffd64f8ec
  27:	83 c4 10             	add    $0x10,%esp
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	e9 71 ff ff ff       	jmp    0xffffffffffffffa2
  31:	b8 90 88 25 45       	mov    $0x45258890,%eax
  36:	89 f2                	mov    %esi,%edx
  38:	e8 af 10 35 fe       	call   0xfffffffffe3510ec
  3d:	83                   	.byte 0x83
  3e:	3d                   	.byte 0x3d
  3f:	18                   	.byte 0x18

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	e9 71 ff ff ff       	jmp    0xffffffffffffff78
   7:	b8 90 88 25 45       	mov    $0x45258890,%eax
   c:	89 f2                	mov    %esi,%edx
   e:	e8 af 10 35 fe       	call   0xfffffffffe3510c2
  13:	83                   	.byte 0x83
  14:	3d                   	.byte 0x3d
  15:	18                   	.byte 0x18
[   15.174645][  T192] EAX: 00000000 EBX: 465c09fc ECX: 00000000 EDX: 00000000
[   15.176847][  T192] ESI: 45f5dacc EDI: bf79d6b0 EBP: 494d1ae0 ESP: 494d1ad4
[   15.179052][  T192] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00010006
[   15.181672][  T192] CR0: 80050033 CR2: 3f831928 CR3: 7e675000 CR4: 000406d0
[   15.183858][  T192] Call Trace:
[   15.184927][  T192]  ? register_lock_class (locking/lockdep.c:1296)
[   15.186594][  T192]  ? __lock_acquire (locking/lockdep.c:5114)
[   15.188124][  T192]  ? blk_mq_free_request (blk-mq.c:830)
[   15.189788][  T192]  ? scsi_test_unit_ready (scsi/scsi_lib.c:2489)
[   15.191460][  T192]  ? sr_revalidate_disk (scsi/sr.c:484)
[   15.193069][  T192]  ? lock_acquire (locking/lockdep.c:5870)
[   15.194534][  T192]  ? sr_block_open (scsi/sr.c:511)
[   15.195998][  T192]  ? __mutex_lock_common (locking/mutex.c:646)
[   15.197692][  T192]  ? sr_block_open (scsi/sr.c:511)
[   15.199148][  T192]  ? disk_check_media_change (linux/spinlock.h:402 disk-events.c:259 disk-events.c:276)
[   15.201094][  T192]  ? lockdep_hardirqs_on_prepare (locking/lockdep.c:4327 locking/lockdep.c:4412)
[   15.202969][  T192]  ? mutex_lock_nested (locking/mutex.c:820 locking/mutex.c:873)
[   15.204515][  T192]  ? sr_block_open (scsi/sr.c:511)
[   15.205963][  T192]  ? sr_block_open (scsi/sr.c:511)
[   15.207402][  T192]  ? blkdev_get_whole (bdev.c:738)
[   15.208937][  T192]  ? bdev_open (bdev.c:965)
[   15.210863][  T192]  ? blkdev_open (fops.c:697)
[   15.212973][  T192]  ? blkdev_write_iter (fops.c:809)
[   15.215448][  T192]  ? do_dentry_open (open.c:947)
[   15.217726][  T192]  ? inode_permission (namei.c:656)
[   15.220026][  T192]  ? vfs_open (open.c:1079)
[   15.222005][  T192]  ? path_openat (namei.c:4699)
[   15.224177][  T192]  ? do_file_open (namei.c:4887)
[   15.226381][  T192]  ? do_sys_openat2 (open.c:1364)
[   15.228648][  T192]  ? __ia32_sys_openat (open.c:1370 open.c:1386 open.c:1381 open.c:1381)
[   15.231073][  T192]  ? ia32_sys_call (kbuild/obj/consumer/i386-randconfig-007-20260527/./arch/x86/include/generated/asm/syscalls_32.h:296)
[   15.233322][  T192]  ? do_int80_syscall_32 (x86/entry/syscall_32.c:83)
[   15.235698][  T192]  ? _copy_to_user (x86/include/asm/uaccess_32.h:20 linux/uaccess.h:206 usercopy.c:26)
[   15.237840][  T192]  ? do_int80_syscall_32 (linux/entry-common.h:317)
[   15.240356][  T192]  ? rcu_is_watching (rcu/tree.c:753)
[   15.242605][  T192]  ? do_int80_syscall_32 (linux/randomize_kstack.h:57)
[   15.245000][  T192]  ? entry_INT80_32 (x86/entry/entry_32.S:940)
[   15.247150][  T192]  ? exc_page_fault (x86/mm/fault.c:1530)
[   15.249320][  T192]  ? entry_INT80_32 (x86/entry/entry_32.S:940)
[   15.251034][  T192] irq event stamp: 4795
[   15.252378][  T192] hardirqs last  enabled at (4795): _raw_spin_unlock_irqrestore (linux/spinlock_api_smp.h:178 locking/spinlock.c:198)
[   15.255395][  T192] hardirqs last disabled at (4794): _raw_spin_lock_irqsave (linux/spinlock_api_smp.h:130 locking/spinlock.c:166)
[   15.258260][  T192] softirqs last  enabled at (4654): local_bh_enable (linux/bottom_half.h:32)
[   15.260941][  T192] softirqs last disabled at (4652): local_bh_disable (linux/bottom_half.h:19)
[   15.263626][  T192] ---[ end trace 0000000000000000 ]---
[   15.265332][  T192]
[   15.266134][  T192] ============================================


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260528/202605281444.29e7f79b-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

