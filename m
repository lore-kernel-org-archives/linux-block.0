Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA08002A;
	Fri, 16 Aug 2024 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723781069; cv=fail; b=bjuY6L1aRc3S0s33Ojckg+5bmmzZSytR76SOo/K82BOU8WGIbV/Uyf35uXsxYalLFHuGMc5hiuNDp2MSmgDHxrmZvRi7NNCJkH/B2RmLb2TDyKKttQpQO4WaFGaG6JamhCIfdbxvF5I07/yGHAZrh1pZ9DKeE0NnZV9Y3nwJ6I8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723781069; c=relaxed/simple;
	bh=j6sZFCzFO6XtKyi219M69r2cMAbJtu3vyJ/LloARxu8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TsjIl/cfxqUGRZkYuF5znHXIdaAldbLlzLQkJgiIPsmj94kmZagb8GKGsWDc5slpp6OC+BcpRgFJiIKyjvzQDfgsGvhCn+ULngms+NTSQND+0N7N+bwYELlWba/MKgN2O3UZc7ID/luzMs5hOAShTEz/WV7K9cgKxnq0H8iT0DY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRLt5Wag; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRLt5Wag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723781066; x=1755317066;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=j6sZFCzFO6XtKyi219M69r2cMAbJtu3vyJ/LloARxu8=;
  b=LRLt5WagxNyH7yLhQYJe9T0szreIpS2sUkCo/EEGJE0ucRJ5dMkUoXqV
   s3ICtfK+eBDc/jFNEE/t39/t3BiCm9GQikxg09dYtpRcdtaP6cGYGsJNo
   hjCkqWlqF719dxI1l7L3EnSnEl9sUk83SQzASF0APRxiv/1hXjTg2Od6H
   dTlhKnZVWF022x2l9tQaxQqRj2Ct1p991YleJTtcSRtSL9JB+MSk5cy13
   ZHcl0hp9Fb3npFMRG1M0+ggBIvnU2+gQ+s8gL31Wr7O182C4VNRtHf69U
   p20SkflwAZ1uIH0dAd23xot1aKYIwuw2bsMb13av8+p67FqXFvf5/bBXx
   w==;
X-CSE-ConnectionGUID: 6iHQAlEgRcyzhJ0udH7Hjw==
X-CSE-MsgGUID: WM6GLBLATLi3hobdOafR/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22242284"
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="22242284"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:04:26 -0700
X-CSE-ConnectionGUID: oYEkbr59SE20z8l+ugXaQA==
X-CSE-MsgGUID: ZBo7G3q9TwudFezdb0YtWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,150,1719903600"; 
   d="scan'208";a="60121788"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Aug 2024 21:04:26 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 21:04:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 15 Aug 2024 21:04:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 21:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoahwW4kMcJV9WsLakOhhCGBcqJBxCDQIqLkFDiikaq0PgnGReQNWCNKCk3j4fKX04CC0mv9PxlO3Cotzq4WbiKL/RRr2tb6eo6/poFaBc5XuWw6krQ3x/+I10kw41TKNy/aXJI5t3m8MYzwTRayyaSsvUMkOzCFr0tqwUVaraLqNEtILcq6FTpDSlB/adPaV2BGfgWTFmXwRKEkV978nFpb3RuMuSM1jbyIsJ6kCy7pNJyN4f8NtzjdYuNdszq1aKBNcPNjVHzigN+rC8sHZxeWihZDy7mvn4kVpokx8eGWV99J+ez6gTpylzsfIwgCNue987TBYbw39n1lDbR7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkY0qbB1HtQYoGSZA9p3cid32HIn6+Jz+9VKZqIGIAU=;
 b=xDlFTx63tT9WWyjjUtYwzjz5k8vDC4QxxApIvt4lX2JG4vrvA6JCGp53IfVM24f/8YuucD4i+Mh3a7vwhQjvHOwR3SgQQyouFtB2bidkWkezIDZwO6gvGa6WetCvAV7dgCHDRcc0NcYL2ZTe6OV1nhy07Vul9RdHTjhfhpKFoV4d9qxuw7Wo5bWwxCcgZbSBnD40Cr3EZ5LBQTMVN8F8jqqDjEhHZR4V/WHs4QcVqqE1cq78pQq4Y0Y6jPhkGAdPS0WCFGdgO7OdApoQWjx/IdmsQKBAhpRjxdNklgS9rj271YtsH7N/YlJUnlB3vfD8JEEItXe313xO/7ZYYiz1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA2PR11MB5177.namprd11.prod.outlook.com (2603:10b6:806:11c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 04:04:22 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 04:04:22 +0000
Date: Fri, 16 Aug 2024 12:04:13 +0800
From: kernel test robot <oliver.sang@intel.com>
To: <824731276@qq.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, <linux-kernel@vger.kernel.org>, <baiguo@kylinos.cn>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] block:added printing when bio->bi_status fails
Message-ID: <202408161114.dfe9cc49-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <tencent_9A3345EA79C1EE9DC4464BB576C6A602A105@qq.com>
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA2PR11MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 07a7c1c6-91fd-4389-b078-08dcbda882b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qcXoVC5INSXnQuRlFp1z7bpM0T2BZwncisR/68hPQVgyhtoh0Mf9A7VBKfzL?=
 =?us-ascii?Q?N2rSgg5Vur+W0jqPfmv29b8h9PFbpkDzXjeJyVRbv6gwEB9A8khZrdRweaSj?=
 =?us-ascii?Q?cjB227slms/wCO0QG6QBng7SdO2l0RznyLrwysbHpZsP/7iKA1k4IdrWlUrq?=
 =?us-ascii?Q?hhPSdlogfnwN8pl7Y90euow22RwtRTtZ3IBAw2u3rfJAnygla5bQC/Lr330v?=
 =?us-ascii?Q?9FO/oUDT0bbf/p09Nacory6BnNIdys2zHdkwedc+ZxniD1T0WsmUN9U13217?=
 =?us-ascii?Q?7o1NYNEKX0kDIPrgkDjCLhj+T5ZoUkAHEw3DIG9EC1+KDCJjTGIC4Eq+KGWO?=
 =?us-ascii?Q?FYDTGPyn58yQdk2G5/JQIS8+jH/AZJTbZkKyEgKZh8kybwj4/cNlULCJYVoW?=
 =?us-ascii?Q?At3a/jxI0tR/2m2qTMEJ3DyL341bHwy7opOW8euqGdrQcDDE++QcSfmcI+VK?=
 =?us-ascii?Q?Ss6hfPM6knBEPp1fvyOaF7Wcah/QRF6zDSE/W12juCqTK5GSScXJtQ3Ia1T6?=
 =?us-ascii?Q?g0tBjqhLfeLFhpQ0GsM4q+bTKA0pg974LRXQh2w0wDOc64F9FBzhe93S1L50?=
 =?us-ascii?Q?k6saCkcVRglYIXggp87YKvRQkoRQWopXdPu5K1X7mMhkYq1f+0IgWwWpzSRP?=
 =?us-ascii?Q?X6SK5AuEKxJpltPFwUK4xE/nfkOiYeZlfjQDbWJBgASt2Lodu7NPeIEGnBVL?=
 =?us-ascii?Q?Lel3P7XOq9zxwPNoaQ+KNMuHu0mqayrNkPFF2FoLuRM0dXNSlYLoSnqSUNeo?=
 =?us-ascii?Q?uu2FE/bM6jVQoCtVgc6S7cay3W//ttypwb+8hicMTMQk19LLsYgF7f3Q6jVS?=
 =?us-ascii?Q?/vmYx+w75mx5lBBBA08ecaChKI6EA8Y8B1XShj5bpLejhgrhvLZw4nhI8yY+?=
 =?us-ascii?Q?k4Jz2sahvtigMOkCcdUOXkFqiW1FYzgwxMf3Uax0722XAKae1ntJioQo0RY9?=
 =?us-ascii?Q?oEJ0XT7EuNM+c2xFPKQ17sYA9UER87eAs5/Kk8dheYyr3NCuM9R58334etec?=
 =?us-ascii?Q?AFTfZrq2Q5KZzrKJb/KZL6JYXv8lh7cx1ugeh75hAe/YR7mIzvbKjVk5UXTz?=
 =?us-ascii?Q?auFwrEcXT7Nq1jE1LKAglyK20VHNP6EODvNJuqsU4ySeCg7lwGWQecJ28xV6?=
 =?us-ascii?Q?QJI6Ank3+N6claSw0Nhr7Fc90wyKc2ah14dt4VWhvhuQR4VgT70ajEq0IncI?=
 =?us-ascii?Q?hyB2TkWSz+M1hIONELoS1oWXHPOAzz/xYcgf6jXiWH7dV26YuGnSXoXaEmkZ?=
 =?us-ascii?Q?QZSWqz/eGBvfLF8L1NuTlajGxQzsQpHM6JeYImEdVeLPmqUNdo86zdYWFFEF?=
 =?us-ascii?Q?7pk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJltBkusypeeL4FV4rVYLqv0cl012Bzwb6Bup+7tKuufMcWIr3fHSPlIF3I9?=
 =?us-ascii?Q?jJktIUcO6ET5VboFiISiWj0oteLtqpptyvKUxAZVYoKLs1KgqiFM/EwphIqs?=
 =?us-ascii?Q?V/n78gFenP7Am1rcWjiSXUJkSaxmoPzRy+ch/L/H8a4nme3QhOAjAOA0/7Y+?=
 =?us-ascii?Q?vU0dZ61OBhk8bVv4DJGpspS9ZDPBA2j8Oq27dY3HvNWF1EptC2/mIxmm8uAt?=
 =?us-ascii?Q?bLpd0/lgQG9dfK6AmbYCtynHyT9t/Ex6h7V0HpoAJxvwG9cCgNeTCFEm8Fdm?=
 =?us-ascii?Q?n13jXyZ+Qanxu7wgTpKdW2BlIVyHJmx93ss9pNh4kUynca9BQD9O6WJuk+Yt?=
 =?us-ascii?Q?W/TubzoG2ZVn2SJdxn72KeyvmB9KwM1rxiVe6RtjCf5mG9qW/noR/Ma+i5gc?=
 =?us-ascii?Q?23gY6v62Ey8/RBaQWANgX1T+aTWgsrN+14HZVanD6k04FijqTdTtYvPiwVFr?=
 =?us-ascii?Q?kzTvRX0CjYrCYqf3dIsGelScon07tn8Nwjc9XvEWs7LfGM1GjPcr+A/URJMM?=
 =?us-ascii?Q?XMoTTtwvZb2IagaSeeK9SmQSvLOLh2jHcfntfJJvKNEoPp+96m0/JIcxHhBj?=
 =?us-ascii?Q?hHOrmQ3c+Tl62C0NFF0IxoEZLtvRhDHhRhWui0BqKqoDWs7W+qqWd2wJWKBx?=
 =?us-ascii?Q?4L2Y7hsMlkqokSABsvuastEQt1Myl+onUjXi6ADyPqXB/OKCDcI6cKLyuL5m?=
 =?us-ascii?Q?Wvx2SPqwiLob39RJi3yAc3Swra+Wpg4wZZOb9+i+Mcok1utug6nzqQjZU0NM?=
 =?us-ascii?Q?AFIbBL3xwRTa8du6ERrHvAD9n2BYpA8x0mfHrTSrIUt3K3LG5FqGRTsMRdtt?=
 =?us-ascii?Q?1If6LEFNOLLSuZip0RoYS3S5wg87SHfp3hckWPFSU1c9sId00HLIv8lHdmdo?=
 =?us-ascii?Q?iqVncFNChkIWUTFuyTjMqR1KgsxkHMrptXG4b6VpBogHKcTgvD6qSAtrFboC?=
 =?us-ascii?Q?UvILlhBQvd+4OKrwc/vNrLrSZITKcrID6dR7GmIpIHP/Mz68xzHnlivrgwMB?=
 =?us-ascii?Q?J8REbj5MQjjezZy9XbQHqynGUh46RZL49yokomiO+d6Nt2BILzSgncJDDCme?=
 =?us-ascii?Q?axDeIOu26uJhuH4J3BZtrLFsaKFnz6Nv9zQq96PkZ4s7qCN+sQiEfxxKZLML?=
 =?us-ascii?Q?13N+1ppmVwZXQiZBAa1tmUS2B7a96quPW3CtxG9zo/Cp7SkJx8/3SXyFQeV5?=
 =?us-ascii?Q?9yHeXM2gqE2KL7x/+G6GifNhYKY2P8MuiL2DrUp3DW7riyfiyxRG0V3TfOD8?=
 =?us-ascii?Q?kdbnduKKtxA0s9lGPbWJ3QphckIU+zMh5yiP1IZIAF0Vx9c3jMdgzLshXMSB?=
 =?us-ascii?Q?9zEN5Z/6Iyiy7RtKNVwH4ouOxF0xlRK59y2U/4t21xDGVgNa5n7I5SsYM+ld?=
 =?us-ascii?Q?eDBEqSvNuIujZHM95idAnv1Muw4nWzy+KcHoTZLb7YwVVpFSYnm4NVc664U1?=
 =?us-ascii?Q?KaJuJl3RInDCtNI9hJYRZzTpGIgA+M+HET6dWYOxz91MqjeQSl0UVfRxTapF?=
 =?us-ascii?Q?1+p2/PmXzFcNXoM0UynLMQkl7xhXT69Ev8CvmcHKXFAXo0BVxr0rArY6lUaQ?=
 =?us-ascii?Q?w5oQFiHaS5WhF0povvwA7HGIRHHSusAG/mlvph98Hzt3c90liMNup1sy6LG2?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a7c1c6-91fd-4389-b078-08dcbda882b8
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 04:04:22.8622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQXkreQN772KgQrZGMUYIj+EwxoAc48a/hG6453qkTVUtSzxwkCwsLna7les4oJvMwco1RAyO6I7uKbR90Vrrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5177
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_fs/buffer.c:#mark_buffer_dirty" on:

commit: 0824beb1d430c30731166484b8c26e37147d4dbb ("[PATCH] block:added printing when bio->bi_status fails")
url: https://github.com/intel-lab-lkp/linux/commits/824731276-qq-com/block-added-printing-when-bio-bi_status-fails/20240808-181758
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/tencent_9A3345EA79C1EE9DC4464BB576C6A602A105@qq.com/
patch subject: [PATCH] block:added printing when bio->bi_status fails

in testcase: xfstests
version: xfstests-x86_64-f5ada754-1_20240812
with following parameters:

	disk: 4HDD
	fs: udf
	test: generic-081



compiler: gcc-12
test machine: 8 threads Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (Skylake) with 28G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408161114.dfe9cc49-oliver.sang@intel.com


we do see a lot of print that:

[   68.449409][   T89] bio: bio_endio status is 10, disk[253:2]
[   68.454169][ T2095] bio: bio_endio status is 10, disk[253:3]
[   68.455863][   T89] bio: bio_endio status is 10, disk[253:2]
[   68.466598][   T89] bio: bio_endio status is 10, disk[253:2]
[   68.472314][   T89] bio: bio_endio status is 10, disk[253:2]

...

[   74.216172][   T89] bio: bio_endio status is 10, disk[253:2]
[   74.221903][   T89] bio: bio_endio status is 10, disk[253:2]
[   74.2:2]
[   74.348274][   T89] bio: bio_endio status is 10, disk[253:3]
[   74.356178][ T2096] ------------[ cut here ]------------
[   74.361531][ T2096] WARNING: CPU: 0 PID: 2096 at fs/buffer.c:1181 mark_buffer_dirty+0x1e6/0x240


then see below WARNING


[   72.605562][ T2097] ------------[ cut here ]------------
[ 72.610907][ T2097] WARNING: CPU: 7 PID: 2097 at fs/buffer.c:1181 mark_buffer_dirty (fs/buffer.c:1181 (discriminator 1)) 
[   72.619661][ T2097] Modules linked in: dm_snapshot dm_bufio udf crc_itu_t cdrom btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp sd_mod ipmi_devintf sg ipmi_msghandler kvm_intel i915 kvm crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel sha512_ssse3 drm_buddy ahci intel_gtt rapl mei_wdt drm_display_helper libahci intel_cstate wmi_bmof ttm mei_me i2c_i801 intel_uncore libata drm_kms_helper i2c_smbus mei intel_pch_thermal video wmi acpi_pad binfmt_misc loop fuse drm dm_mod ip_tables
[   72.671579][ T2097] CPU: 7 UID: 0 PID: 2097 Comm: xfs_io Not tainted 6.11.0-rc1-00021-g0824beb1d430 #1
[   72.680936][ T2097] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.2.8 01/26/2016
[ 72.689071][ T2097] RIP: 0010:mark_buffer_dirty (fs/buffer.c:1181 (discriminator 1)) 
[ 72.694676][ T2097] Code: 58 c6 ff 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 60 48 8b 7d 00 5b be 04 00 00 00 5d e9 3a fc fc ff <0f> 0b e9 34 fe ff ff 48 89 df e8 5b 23 e5 ff e9 54 fe ff ff 48 89
All code
========
   0:	58                   	pop    %rax
   1:	c6                   	(bad)  
   2:	ff 48 89             	decl   -0x77(%rax)
   5:	ea                   	(bad)  
   6:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
   d:	fc ff df 
  10:	48 c1 ea 03          	shr    $0x3,%rdx
  14:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  18:	75 60                	jne    0x7a
  1a:	48 8b 7d 00          	mov    0x0(%rbp),%rdi
  1e:	5b                   	pop    %rbx
  1f:	be 04 00 00 00       	mov    $0x4,%esi
  24:	5d                   	pop    %rbp
  25:	e9 3a fc fc ff       	jmpq   0xfffffffffffcfc64
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	e9 34 fe ff ff       	jmpq   0xfffffffffffffe65
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 5b 23 e5 ff       	callq  0xffffffffffe52394
  39:	e9 54 fe ff ff       	jmpq   0xfffffffffffffe92
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	e9 34 fe ff ff       	jmpq   0xfffffffffffffe3b
   7:	48 89 df             	mov    %rbx,%rdi
   a:	e8 5b 23 e5 ff       	callq  0xffffffffffe5236a
   f:	e9 54 fe ff ff       	jmpq   0xfffffffffffffe68
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
[   72.714238][ T2097] RSP: 0018:ffffc900033df8a0 EFLAGS: 00010246
[   72.720206][ T2097] RAX: 0000000000000001 RBX: ffff888120d219d8 RCX: ffffffff81c2b878
[   72.728093][ T2097] RDX: ffffed10241a433c RSI: 0000000000000008 RDI: ffff888120d219d8
[   72.735965][ T2097] RBP: ffff888120d219d8 R08: 0000000000000000 R09: ffffed10241a433b
[   72.743867][ T2097] R10: ffff888120d219df R11: 0000000000000008 R12: ffffed10241a4340
[   72.751752][ T2097] R13: 0000000000000004 R14: ffff8887472e8000 R15: 0000000000000948
[   72.759638][ T2097] FS:  0000000000000000(0000) GS:ffff888634180000(0000) knlGS:0000000000000000
[   72.768470][ T2097] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   72.774945][ T2097] CR2: 000055d09397fc48 CR3: 000000075685c004 CR4: 00000000003706f0
[   72.782843][ T2097] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   72.790713][ T2097] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   72.798583][ T2097] Call Trace:
[   72.801752][ T2097]  <TASK>
[ 72.804567][ T2097] ? __warn (kernel/panic.c:735) 
[ 72.808515][ T2097] ? mark_buffer_dirty (fs/buffer.c:1181 (discriminator 1)) 
[ 72.813514][ T2097] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 72.817908][ T2097] ? handle_bug (arch/x86/kernel/traps.c:239) 
[ 72.822125][ T2097] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
[ 72.826692][ T2097] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
[ 72.831612][ T2097] ? mark_buffer_dirty (arch/x86/include/asm/bitops.h:213 arch/x86/include/asm/bitops.h:245 include/asm-generic/bitops/instrumented-non-atomic.h:154 include/linux/buffer_head.h:171 fs/buffer.c:1181) 
[ 72.836529][ T2097] ? mark_buffer_dirty (fs/buffer.c:1181 (discriminator 1)) 
[ 72.841536][ T2097] udf_bitmap_free_blocks (fs/udf/balloc.c:164) udf
[ 72.847326][ T2097] udf_free_blocks (fs/udf/balloc.c:662) udf
[ 72.852530][ T2097] udf_discard_prealloc (fs/udf/truncate.c:147) udf
[ 72.858161][ T2097] ? __pfx_udf_discard_prealloc (fs/udf/truncate.c:118) udf
[ 72.864303][ T2097] ? __pfx_down_write (kernel/locking/rwsem.c:1577) 
[ 72.869051][ T2097] ? __pfx_locks_remove_file (fs/locks.c:2687) 
[ 72.874412][ T2097] udf_release_file (fs/udf/file.c:185 fs/udf/file.c:174) udf
[ 72.879584][ T2097] ? security_file_release (security/security.c:2754 (discriminator 11)) 
[ 72.884757][ T2097] __fput (fs/file_table.c:422) 
[ 72.888638][ T2097] task_work_run (kernel/task_work.c:222 (discriminator 1)) 
[ 72.893108][ T2097] ? __pfx_task_work_run (kernel/task_work.c:190) 
[ 72.898101][ T2097] do_exit (kernel/exit.c:883) 
[ 72.902048][ T2097] ? __pfx_do_exit (kernel/exit.c:821) 
[ 72.906518][ T2097] ? _raw_spin_lock_irq (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:120 kernel/locking/spinlock.c:170) 
[ 72.911423][ T2097] do_group_exit (kernel/exit.c:1012) 
[ 72.915818][ T2097] get_signal (include/linux/signal.h:78 kernel/signal.c:2751) 
[ 72.920215][ T2097] ? finish_task_switch+0x495/0x750 
[ 72.925907][ T2097] ? __switch_to (arch/x86/include/asm/bitops.h:55 include/asm-generic/bitops/instrumented-atomic.h:29 include/linux/thread_info.h:89 include/linux/sched.h:1945 arch/x86/include/asm/fpu/sched.h:68 arch/x86/kernel/process_64.c:674) 
[ 72.930377][ T2097] ? __pfx_get_signal (kernel/signal.c:2682) 
[ 72.935108][ T2097] ? __schedule (kernel/sched/core.c:6399) 
[ 72.939576][ T2097] arch_do_signal_or_restart (arch/x86/kernel/signal.c:310) 
[ 72.945005][ T2097] ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/signal.c:307) 
[ 72.951046][ T2097] syscall_exit_to_user_mode (kernel/entry/common.c:111 include/linux/entry-common.h:328 kernel/entry/common.c:207 kernel/entry/common.c:218) 
[ 72.956561][ T2097] do_syscall_64 (arch/x86/entry/common.c:102) 
[ 72.960942][ T2097] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   72.966720][ T2097] RIP: 0033:0x7f896a5efd32
[ 72.971012][ T2097] Code: Unable to access opcode bytes at 0x7f896a5efd08.

Code starting with the faulting instruction
===========================================
[   72.977922][ T2097] RSP: 002b:00007f896a1ffdb0 EFLAGS: 00000293 ORIG_RAX: 0000000000000022
[   72.986232][ T2097] RAX: fffffffffffffdfe RBX: 00007f896a2006c0 RCX: 00007f896a5efd32
[   72.994101][ T2097] RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000000
[   73.001969][ T2097] RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffdb5bc88c7
[   73.009844][ T2097] R10: 00007f896a535f80 R11: 0000000000000293 R12: ffffffffffffff80
[   73.017712][ T2097] R13: 0000000000000002 R14: 00007ffdb5bc87d0 R15: 00007f8969a00000
[   73.025582][ T2097]  </TASK>
[   73.028478][ T2097] ---[ end trace 0000000000000000 ]---
[   73.034147][   T66] bio: bio_endio status is 10, disk[253:3]
[   73.034167][ T2097] bio: bio_endio status is 10, disk[253:3]
[   73.039846][   T66] Buffer I/O error on dev dm-3, logical block 259, lost async page write
[   73.045565][ T2097] Buffer I/O error on dev dm-3, logical block 128, lost async page write
[   73.053894][   T66] bio: bio_endio status is 10, disk[253:3]
[   73.067887][   T66] Buffer I/O error on dev dm-3, logical block 387, lost async page write
[   73.076268][   T66] bio: bio_endio status is 10, disk[253:3]
[   73.081976][   T66] Buffer I/O error on dev dm-3, logical block 388, lost async page write
[   73.180045][ T2097] bio: bio_endio status is 10, disk[253:3]
[   73.185743][ T2097] Buffer I/O error on dev dm-3, logical block 128, lost sync page write



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240816/202408161114.dfe9cc49-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

