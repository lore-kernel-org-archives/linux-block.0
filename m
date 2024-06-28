Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652E44369;
	Fri, 28 Jun 2024 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719553187; cv=fail; b=Oi+vryOXXWF7CA8A0YvSvabaj6S2RppKYVTZmPj8VNCFbZioSdGV+pjsxtksJGfQHY7kgBuvxIUNoycEs9d6nV0O9aEgV2I1zhMsbliFvsmC3j1Z7n+9ZiKoxKsEuE8dTnzbA5egXCCryfHFcnqZfeoBizqq6ECxxrLJF1zrrkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719553187; c=relaxed/simple;
	bh=trKeLPO3t7kCb65fZdIVXE/qY6qBJJ5j6oLRwNfeW+4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B4Ba1O47BOFJWlTsmIWxqtcUJA+tpLOAasRK0WWsgAlxpQ8JQQrho3BLIAkpY+ldbxuB3mXspKS5jlAnGlNnE+4m4xQbGx3TPyl0jrqSphAHNX+VLi8wf+MZIkRMJJXj9uZOYezUXAEW8kcjBlOn4bhQsFn5pUwnTAlSmBesFfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KJ1RFzF0; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KJ1RFzF0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719553186; x=1751089186;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=trKeLPO3t7kCb65fZdIVXE/qY6qBJJ5j6oLRwNfeW+4=;
  b=KJ1RFzF0e5sDfFz6lzJhL3MyRc79fhv8mVPpm/tXdJDM+W68PYUEcR7i
   VZo+eY1JThpE7Xj/aVDRc82kXMnHXISgbNtxu8GjBPK4QWbG8eU6LMwqr
   t1dAq+FTXNt01XNUwnFetgTMtwrp+6bWaHVN32IczCxw+LyFskqr3HRrW
   gdCBiaB60g3kc1drNoEQPJolPVaSsBgNLRM3tIE4tA7IA+lHGPef/UV8Q
   UzfRWvfO5DeHouoWqVaal5faXpcMWnNiYyJUE1PUaRjZEdAgrWKzjlIWl
   MEyqwKxDpfv8PS/8l+SvCs5yhBEhHz0vTXVYUEH6r7hYcd2Ohczd/epNQ
   g==;
X-CSE-ConnectionGUID: gJ8iDmcGS1eaow/lqCu4/A==
X-CSE-MsgGUID: YbCsOOojQKS2M/Vbz88tJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16602318"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16602318"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 22:39:45 -0700
X-CSE-ConnectionGUID: CYWx2q5kQTKYULuaDUOx0w==
X-CSE-MsgGUID: zaAOGpx7Tl+egLNMm0Ociw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45263985"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 22:39:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 22:39:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 22:39:45 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 22:39:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cESV9wH+1uzxSpXXAgYklsOZOuhA49MaF2wE4rSEZ46qaSgisSk7NRDy5HrGoSZnQ7zp8K77YdsZofUDSTNpIu4te0cMG5HGrZCq4Q5/YZAXsGa+z7RyMbUIf+0bauHF7jbnIsNejU6ZdFjzeZS9eyw4mt1+ZeSy+2pA0Mx+SQ6dcenfsBIC89PJ/WrSWezI88fBKDWI1x3l+IfGlkBUDslWghvE5Lmh1ubqZS4pUJ7rdrBGKVwxF4mQAwyqPuQXW3hBiFAZYeAvrA1GvGKCymtbunSsCmFyK8/VV9DNlNUg/x7Dm6JyGK6FAVmgjlRHbUHEEfcLzeprpCw0H+mV3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R46z/GPcRkh+dII0m7k8soedT0OLTNN+A6/Cg3wo0Rw=;
 b=JPK8284umsiyegYTsSClKz+ljX9eyyPdZOPopF9EurWyKar1pviTMtXWOwnpYf+umcrbwpxLTFIiClrn131hBvnIYa6SPtpSajpTmjZU6Zd/Ul51eUd3VHkIfI/HTFf2TxPTXyvO3ne6XEqE8+CIhu2QFUCSjaUkp74GM7fFOEZta9UxjZKrHF04Omi+BDQlOWBiY9kr5Zg/c2Os9bKbEhZ+ddBi/zW9prOBaVCCRkfdjXqZzFfLhFT3hVvUgHEYfleyzS3z41FekjGllJ6Lwm/YAqPzHgfGyq+CjNinZceGuYgnkOqSHWGLmh1H6ILSqX2pWBNrLOglhOeSA4sbZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6805.namprd11.prod.outlook.com (2603:10b6:806:24c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 05:39:36 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 05:39:36 +0000
Date: Fri, 28 Jun 2024 13:39:26 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<ltp@lists.linux.it>, <linux-kernel@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <hch@lst.de>, <axboe@kernel.dk>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Message-ID: <202406281350.b7298127-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240618164042.343777-1-gulam.mohamed@oracle.com>
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 789c3517-f366-44a0-0823-08dc9734b23a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/K2yf83XApbjluLoMwsS5hs3owzsH6QbzA4KRpKDoaNgEe39hD0DfYUruLZL?=
 =?us-ascii?Q?1zpjId67Q6MJ2PZ7JZpA+RKQOW2n+/23mL2SCbfNkGFp/NIOsdziLbKpZs+F?=
 =?us-ascii?Q?8j5sq45lkr6OXqwDI5dyP3WBrFe3HzpKznzJyrDE/jzuVYJFq+8iSd/+xvxc?=
 =?us-ascii?Q?9akzlNfYioPLjaY20Jgd3K8wWI4HZ8Y3UMROJal5eLJAtKpa+bDGKuw8+Bvu?=
 =?us-ascii?Q?OZ4JPSpNNUa8sQjStuj+00rkACLB/pMfehzy2qXJT5ithGogYqHCyKpVKZPd?=
 =?us-ascii?Q?rtsLi/lGo4j32FdhowdSTQHPU2gDuoEUjchRIG9DFBnTu7UCudQMTgob4LgV?=
 =?us-ascii?Q?1qdPDmVYWW12p/CPFb+Mw2/189QdG6SK0aLo6ahUYiAbgoCkDxANEc3YlciV?=
 =?us-ascii?Q?+GuZC4S5O5y9RyGfBozkc3+A+5NonFYZBYxeuHc8pE/vEhWm4CyHyB2qyaBP?=
 =?us-ascii?Q?YOHwBorVkkwxfkblFTYifs0l8lIYUMt0p8GP+ctxUEYqF3/o8VZWwpLk7npk?=
 =?us-ascii?Q?JxpgQT/tsAuS3GbEv4F+uxZtqdPtu4k5I07Pq6zL3weCQsav9gyAFbPfI5yJ?=
 =?us-ascii?Q?1TakPUwBSJ6LXxfyNCUQFhKG0ZwZ4mQkSaM590b9VYxu5PPneHWW1wn/b9+2?=
 =?us-ascii?Q?nwTM1HwzjO4Bc3jKURUnx8RJqh/hO0nM1MagONF/xbWCZcN3l9OSEkW3YnJc?=
 =?us-ascii?Q?/pc1Z0kBeNAGe+OkK2nVxQCz1V+seWQS27uttb2M8q2ot25TKDJxy8iame8T?=
 =?us-ascii?Q?51tME3ORcPJ2e6BbWi9nf5Y9g2kLYkexKT85C31AqkF0yHkcic6tKpmK752y?=
 =?us-ascii?Q?UZjnI+HlmXSu2Qxxv2yts0Wh2kA+MdDTe3AzjR93114r5RYXGtjIGcHb6osm?=
 =?us-ascii?Q?tXgBZYzjQ1u6yd7pibN6vQ4kdaStrLwSLqPinLarxGCDenBAUWmntp9WkT3O?=
 =?us-ascii?Q?IBBh33ujIKHo0I2C80QhxRuwilpNxd2I16NOzvfqAdysJXgVyOyqu5APzLoc?=
 =?us-ascii?Q?7OSichON9sr7LyvGUk0hvXqm2PgNTbTWMbBo6LLPnTdbCf0Qo8q2pVqmuVo8?=
 =?us-ascii?Q?XnefU9VEIfs1OeKeJxQPTV8i52PJW5dV/fESpyZMl/DBujtr0nAptpU0gSpz?=
 =?us-ascii?Q?INjKQqOx8lA91nbMVzjZENEoyi8c8wZ/CVqQJoJLy9W6oo7J2BPQIidDlIay?=
 =?us-ascii?Q?da9d93yHR4ARmrrxU7mkDdqCYEboUQH+W+VV8LeNAExUH1SYb8rB8jSGAPA3?=
 =?us-ascii?Q?iObBmcVLZUoCurwq+EaqKXQWAAH74EPSGxv8eTy2f7asyH8bPLzZ65kYnZmJ?=
 =?us-ascii?Q?z24m99mv2iSuHDC9HlARZJvF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WJrnUxH8KmU2sGTFXxLhGORtvBR8HSWpfHauYZzu8VhWukC8c23RPUtLYAj8?=
 =?us-ascii?Q?7ClnDnucDrBl/OJPluPMCatLjuSEStyuUdTFF/fuc1QXQTC5ECok9EsTggYh?=
 =?us-ascii?Q?sliBz6u6A30D8/7volfujonj0pJ5nptQ+YJkpYp8cccjtiE2tRbYr8dQiLtn?=
 =?us-ascii?Q?N09+b7esZZ7o+EhdHIIMrUBUYtnTIGt3Ma1S6RxTMokI8W3diWAP+z651eMg?=
 =?us-ascii?Q?EeeE5k2ydomoLRK2c9OK8jnC93hsVIw9tOSnsbcvppKiw3eb3yUz7a/0o4xj?=
 =?us-ascii?Q?9qV340lVzT2g/Kq6IGsGLVz5HcZe+ol15LOnlta92jexpwN12khLWsZfVzdB?=
 =?us-ascii?Q?dMcZMgXx2/O7q5ff1wl8T81GUk0H/ryny28KpF8z8k5fQmHVyWJA/RePPks/?=
 =?us-ascii?Q?Kk9qXAB3Gp9iE5FmLQW//FgSxHzA4dBM5Q3Ns9qa6P6sK78bMMMo6l9JODm8?=
 =?us-ascii?Q?kWEQ7RWqayCkBwq6zYmxWkc5PW5MZ+fMMxWNm+1ayljfGCRkbSq1QBlCY6y/?=
 =?us-ascii?Q?kYD8H6Ec4l0fzngtrm2SZ13QC/ML+j+nm0JDsSe0ovZwgTlBO12kYWNMupYc?=
 =?us-ascii?Q?LZnVax4ULxBrOqTWfwoemPMx5/gqzy6V3Kc6TyXFddBTYqquR+GG7YBCVVKK?=
 =?us-ascii?Q?xyvt1TV9ANZ7X9Fs/8w8hHIYmB61b2At1UV1Rt+FEZfUdmk9ybKXtOyXEHHI?=
 =?us-ascii?Q?2NIQ661Lj4j+cetMfK99f7WYVN1l58C+Csu1gvknT6MNWiKm19KyzpBgmyRs?=
 =?us-ascii?Q?aAzT5qMf5U4JUpqQmH3dr8Dhm/LIxdYog60t4f/EecBVKTVSyJ1C2Tnbx88K?=
 =?us-ascii?Q?LMx/YB/8Dyia0SokY7dvFTobGWqdpEz0h9BDqvB7swNs9AfDCS294A1fi8ox?=
 =?us-ascii?Q?fjW+j/ItjNwTYCTNsXAlOMK0UWMdAw8udd0+RhFGjp15jIoTh4E/Wkdqrky4?=
 =?us-ascii?Q?6kA+p3wyWPsieeAe+QY+cY5BFsXsE1mx/MdcPdHSymiqDsRTjt9BViLztWzA?=
 =?us-ascii?Q?wVMbOjtx6nlcnwYZZx69u9CWzQ0jAasmKRQd7vil+xp2N5Jcqkp/LvFopL20?=
 =?us-ascii?Q?zbOzpUG7Y6xomihPpjP7WrbV7JZq76Zi44kcY6lcJk5cOTzIMJKdAIGBmNyN?=
 =?us-ascii?Q?3mx+VBOplRHApHrHyEexURKlsl9PSIYLiWgzHZVdIchFbR+HH5W3Wa6KSmcM?=
 =?us-ascii?Q?yuG1wM9QLL7yYMxQUZ0ukES3V+7hny2dUSRYXAdXjSZwgoguO+a0BrbSFarO?=
 =?us-ascii?Q?JO3SkDkkX9pVIT2nTbyGCZ2ksnVMmhoY73enAs6sQiklEtojdUiIYy6On9EN?=
 =?us-ascii?Q?1zuJ9lZTVHPO85zAx6fqE3wVqZxRcaunwdZW1sAEjplKhRQL8Ktm0SQ6aS9X?=
 =?us-ascii?Q?mVmfDM6zFUDxj2N7J8qWCXAYM3ikjO6wdkX5hjfpPI9hEWDzSFH8FOMkHwRB?=
 =?us-ascii?Q?UpYdqy5mVf2RQ7/cueCmOPXRtOkWi5uxOocyzByRg0XD08nPawvn+iC0C7fg?=
 =?us-ascii?Q?SMfGX+PknOrId0zGGZA/e5GivKSR5JrBm2JLFR91SG0EJaCUOQkSPQgxFHOe?=
 =?us-ascii?Q?TGvr84lsEGiQcQ0kTLquFZRwsosG6bSUm2Nhjj3HJo94UtQ+Iq6K4EFiBkYu?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 789c3517-f366-44a0-0823-08dc9734b23a
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 05:39:36.7285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4YuEoqh6sYS0C6zva6QTCARBEl07BBjeYGkuuknR6tg76IITddTAqZfOePE04X8lbkhwNPJZUjZmsv04iGGuXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6805
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.ioctl_loop06.fail" on:

commit: a167a9996e22ae0d108307fbc66b811d821ffbe7 ("[PATCH V6 for-6.11/block] loop: Fix a race between loop detach and loop open")
url: https://github.com/intel-lab-lkp/linux/commits/Gulam-Mohamed/loop-Fix-a-race-between-loop-detach-and-loop-open/20240619-004334
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20240618164042.343777-1-gulam.mohamed@oracle.com/
patch subject: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach and loop open

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240615
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-01/ioctl_loop06



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406281350.b7298127-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=ioctl_loop06 stime=1719063458
cmdline="ioctl_loop06"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1734: TINFO: LTP version: 20240524-41-g248223546
tst_test.c:1618: TINFO: Timeout per run is 0h 02m 30s
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg != power_of_2
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size < 512
ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUSY (16)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUSY (16)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size != power_of_2
ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUSY (16)

Summary:
passed   3
failed   3
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=3
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-41-g248223546

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-41-g248223546
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240628/202406281350.b7298127-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

