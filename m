Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530952E610C;
	Thu, 14 Aug 2025 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158896; cv=fail; b=nVEEr6cpVcLu97mB2C2Ujse7lsHtssyjxp0UdcyPO+7Sa7REn2fh1QOX/kXhoYUtCPK/8GfYNL9mGZdz8zxB3sAyAYECKHjfx7VNCr09RW1nIyu1a4+hcCcJI8d3toAMbha2l1QAR3dirMqkppS7sqaeDhhVfjx3PdflKvuIE/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158896; c=relaxed/simple;
	bh=k114ysABwOFFsDX4svDa1p8y85SNYnjWKaLleuVnBO0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aJGIjn/nruihQu7S0ES8cuPj1o8rdkSxT0BKlzCCcxeiUCG51M6JZlj1xLYe7AMs4mXmWIzZ8qJBTNcRF1fbgo2vdtz3o7ugSBoQWYRgtpxBrln4tQeEcP/hF6Ynbj6vESHaAhd8Mw3NK+W/xMXpItWbK4uBvLvP0QpcRifKITk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PYQ861R3; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PYQ861R3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755158894; x=1786694894;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=k114ysABwOFFsDX4svDa1p8y85SNYnjWKaLleuVnBO0=;
  b=PYQ861R34N8SuEiUjCvg+wYnb1KNXtm5qTctc1nOa2UbftNu/FCSnaE5
   zGKNTNd2W9b2+auMI+lZYoWuDEfuE4vBI4ad20nrAbS//mo4Axewq4dDe
   53BhbHy8FVUZIIZTCLKgYE8SN02FT5Jj/bpPMK2W40FoRpenF/StK2xQU
   SiuYs6IHZm5M0UqnWMNjHgMCzwygGYBonGILJ5vGCnPQw7UTvWFu35BGr
   KvfEyMpQD+zAWy50dgoATSu56eWjoSMFwmsxO5lQYhJ6Bo8I/x6xSfTHi
   3KHfv9mWtk+dj0MuOMACXUh6TQFr+sBF+zc4IuCqW88RTj15DcqdjsH1S
   g==;
X-CSE-ConnectionGUID: 12YMho9iRCK6kivcEEzAmQ==
X-CSE-MsgGUID: xwo2TLzcReywjMesSbGyPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74920339"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="74920339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 01:08:13 -0700
X-CSE-ConnectionGUID: 3JlQQ01oQkO6jm5Ex0eb/Q==
X-CSE-MsgGUID: OR+TlIobSvu2ptOp3sGnLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166195377"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 01:08:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 01:08:12 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 14 Aug 2025 01:08:12 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (40.107.93.85) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 14 Aug 2025 01:08:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGJgYFJmcezO06udXJspmYlV6GCE1QRUmr//t/uuGLvXOzDf992aSexRwSA4Ss7IH993/W+YBSFk041ktRe6xueUqDri5OemV8/2nsii3HX1cQQ9AwL6tIHYBXBpqELMptv5rWCOW5N54KireLTwq5ddZwEMWJhE2gVnvQ/xx2cd+xyiJ0ApCzo5hXbCMHRTNobyVCZq7NpqGxeSCbaLJNbYxrQG9LWt6ya6arTvaWBXiNzyOBRIDTL71bhco7whHvf3zM3auGD4m4uvbRA1dHDpM/XzAjP2JwM3RYRqX8+OLjl7n+0MwlRsK9oZrEPn6tjn/aQoYQ6daywYK8SDSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRJ47t08+bZ80Y2u2Qs+awXAJKJqnrI72XtLHXzHjdU=;
 b=tQHEkMC5mwo7iPMyZmWcJ5twd0RcbFjRvikPvniuc9uCEeIDREvZ1PFzBU7QJf7ulibSuOhFpE0AtuRlGHFfTjRInXQmvrvHoWgFdddbYg55luLjaD8/IzMZbUfoA/vYNT6tglY0uwDWGSoVC4aJ2JgAuOmsDSx5CQplaZ/dNNDvCT9hrevomA2tpnZB9031AjfX6OsH/1ozfOsIUXaMOvJylqp9l4ILsa2rMAnVC8821FHfdqKNrYQA/Vukxu1g3GhKNzs9hl6RB/RYSO0hvi0hAHnyC8P9XwWYf/CydutnkeoEv2cB7uwQpOFcy2aLeNN1yuD8XF04WzR5xKJ1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA4PR11MB9107.namprd11.prod.outlook.com (2603:10b6:208:562::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 14 Aug
 2025 08:08:10 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 08:08:10 +0000
Date: Thu, 14 Aug 2025 16:08:00 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Julian Sun <sunjunchao2870@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Julian Sun
	<sunjunchao@bytedance.com>, <linux-block@vger.kernel.org>, <axboe@kernel.dk>,
	<nilay@linux.ibm.com>, <ming.lei@redhat.com>, <stable@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v2] block: restore default wbt enablement
Message-ID: <202508140947.5235b2c7-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250812154257.57540-1-sunjunchao@bytedance.com>
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA4PR11MB9107:EE_
X-MS-Office365-Filtering-Correlation-Id: 07635e1a-3a48-4eaf-1ff4-08dddb09b553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J3aZXnXmyp4irdoBIrzQCxy71yuzomwhKKJaQM1MKMkHjh31SMaQ4Qt29w/3?=
 =?us-ascii?Q?9aJg5LLXGAbBpWFemjy/8VGT4UYsstKVZ+uUWlk9ZueZEpQlJSIIGsEHEGC1?=
 =?us-ascii?Q?wbx+79H9j//JZF/H/tFqqZJiCXN1x0hC3rX9OKO6+ZOtZ2wsfxPtEL9CQ0Zv?=
 =?us-ascii?Q?hec4Q6gD1DT6qiEIuJtJX0uLLbK/vv4PD24qSC981gGxdHumM0C7ieIsMjAw?=
 =?us-ascii?Q?JqtswEG75rhz/lhcQ2YjsZ4iOgFOFBgAcDRiTPOu4TNYJ8YRAor37tkeUUNt?=
 =?us-ascii?Q?idpxMozFukrg0DvNE9HiY7RbISREq/RZ9n4WWnlu/bm68CjRgfEK9y4rcR+w?=
 =?us-ascii?Q?W73X9pnIi4ucAhlOmUZthLLTGGkdGQMFu/SIhe1cHLr1KodtTNtQ9Z+qZOd9?=
 =?us-ascii?Q?0Vh5OF2AocM7l4tthKP5dt9Z4RWgrUmpPffMv9tc7VjV8O7xSTQK0v+Oc07R?=
 =?us-ascii?Q?ucC+bUpU6hIGTmXh4iPqpT8aTMFbNQK+uwShV4ma9hLquuzj1ZLh1eVlFY0L?=
 =?us-ascii?Q?A1l64jTBaW3HMsBRRK4TdNnFCJuyJaWwjKgcJ7RB337+VAaLJNOxn29aOgIw?=
 =?us-ascii?Q?lBIG2s44cYUBfoO7uxXIsDbaa/9xzk7+B/A+iXj/2a8R5xyxlmZ8a0r6OZjR?=
 =?us-ascii?Q?r95tch9jOKyG3X1K6xIFmMcsM3DzMRtnKKWA2YtTTubAxlxzl3U76KG0MKnr?=
 =?us-ascii?Q?TR4kuULQpIV7fdFLcuClcUIgoD3IODfETPJzCu+h9bzdbhUGlYsgWdlmwXo/?=
 =?us-ascii?Q?U5xKa6NuXLxKuhMM5EPdW0ekAEnpFbp9oOzAiC6X9e1IY/bHIX8++LHlZifp?=
 =?us-ascii?Q?FDjRbrMZ4v/livYyCRkCOKj/0hE2sTw3vFN9fRzuzAisA9ilBZQdAddaq8qx?=
 =?us-ascii?Q?LXk7+UbCQt65zVTOUcNRd2HAUxyrSTLvsVA8UGmiWaN7WkCyMQhjoWI3cNxI?=
 =?us-ascii?Q?9b98vXfAi/+Hnj9ot21KYm9FCaZt693w+MRcpiaCT5nyMQ9m2/pyG2hojeF6?=
 =?us-ascii?Q?FvzjYAUgbODQovBu3F15CyesyTNcmuEBlFSWfm31MMM2a9Krp6GIi9SywDlQ?=
 =?us-ascii?Q?DjT6bBqzVrPGvnWkTiQPoRomScxkciuJQdmSLZxv5wMluHxHHNbpg34ScW1R?=
 =?us-ascii?Q?6TTfNIZuYutaTKv26IgGgHuOGWuLrQb6KGGaC2AGjrk/Hok9/z93l2/jRFon?=
 =?us-ascii?Q?QCGWnAlsGr3bbe6B9kUeXHsUcPguVKM1IwnPlTRcigSCBAR6+tzHvHDppDgp?=
 =?us-ascii?Q?qdkE3Yq+oxh2na5xKA2jmVaJQjStqa+CynBCu4JrWyc/jf/BQUHOC1Mr9l4U?=
 =?us-ascii?Q?Cc3ZmVj/rloXqufF0UQGh5GQEa6XhPBHP8Wa80D3+6AFYUja4IPj/dAbvfM3?=
 =?us-ascii?Q?VhmVnlKb0PY9yQKErW2TC4vbzgaH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yszdgdsiTgS4ptISxQnGpXi5EW7QUyaN0N3IgwNXdbjQIvp1rHDitTeQLkcL?=
 =?us-ascii?Q?h7Znc8DlIUZjjxouBFRmGu/zpkX4cdZrTHErxlPwD0slgWef/dq5S4HkLGin?=
 =?us-ascii?Q?Ciek/NYxS5fbugE+CcE1J0H9Hh/aYh2QN7liKTwMjYENWci6Yv7893TzHi0O?=
 =?us-ascii?Q?XTrkV7YayaLvt7yk22KnyLNk8e39sY5dS0gX5KVszvW7ORrQ8VEY3vJzlp21?=
 =?us-ascii?Q?nqu7IdqwlSq36u40+aeg4FXN5cjQJ/a1PWr3bKi59U8gU7xu0MzACYpUa1Pi?=
 =?us-ascii?Q?kON3EaVjb2Fakt0oYqWN5jKdF3epOaKmR/mLTr8hsEDYey6VilI4YlX+H34m?=
 =?us-ascii?Q?hD0LmAOrDkEDbnEBuMXR8P52L73tCmnx7IVES0fiofWO2DhzhxBTZ/lGUyqJ?=
 =?us-ascii?Q?hYI9dKAss/tRo1NkUOsT4U98BtpHrUHenCpoP0Gbuzw+s4qHjtnv9vfVWlEk?=
 =?us-ascii?Q?5rrn4y/48mLr30vNH2WayXsVzg5+SoogJxUAFvIAW0Ry3erncj8qXwXOG0X0?=
 =?us-ascii?Q?V+tazgGA3GANhlQmDCxZKd4aVAbZrfLGU32FeizChkOqw4NDYk2655g7NAV+?=
 =?us-ascii?Q?WBtoN4oBPpI+k5x30W75H6uPBCCPAwueKymImJ9KaunRMP+eTTcrPWcQeX73?=
 =?us-ascii?Q?s2ceeypIYdSB+EDYd6hlE93a0VBI3gZyx9xyGiAd6Ug8U7VW9LA0CwH5hdT5?=
 =?us-ascii?Q?JfXiPVPgbEIUW8pOo82YFtI/wOi4+lyehVPLLvId2P8ZNt13hsddorv81z9E?=
 =?us-ascii?Q?ck9K3XuDhXkNTFc4lMjsmkCFmctgaIXYHTVQOGJroJqk0Yv4ljsP/jzFu+13?=
 =?us-ascii?Q?9qdwkunF+OmW0cE94uHy1mHtf6tmfxbFfF9qO1MeT5Uz900V6zNCxs2gIa2y?=
 =?us-ascii?Q?gdHIa8gdg6H3NHlsPD5NTmF1a/ldk7NkDjvSAceOC0lkfNBF0qX3qoOPgNL9?=
 =?us-ascii?Q?VviIdIyWhyYSbXX2Y4ygX8E34VCeiXABJ47LGpkpkvEVOGa8PifkR5Tbu7if?=
 =?us-ascii?Q?7eoGdKRMQRaMN+nB/O2fI3jr9oQ7M9Ar7jpB92KBdJj46dNfY7AdiQKk+PPg?=
 =?us-ascii?Q?2lAOXWQylMT3JfJmuBf2UX8KSMY2xlUidUavYgReMVpSYYvKMO5sFYtCnkUi?=
 =?us-ascii?Q?occ+J8ttrJM1YS9m7Ew17t/fLm1A/K2fmIkcQesE2WLZASbqSTXdsxFBiP4L?=
 =?us-ascii?Q?it9izl4/oHVEhEL+xnuySFnK6Yd4v++3xCJ7u3WY8+yC/Dnciv55eoTOxkir?=
 =?us-ascii?Q?u8Do5yswJG97pUdzzuoZ0tJsFA0ebcvqBk1FKWfqTvTTSXD3spgK1qVzsWMf?=
 =?us-ascii?Q?IlFt+Dvm6mH8Na+IXGAW6YheNffPDkok1jLm+x4hZdXlEeGlqLLa3iPxsQBj?=
 =?us-ascii?Q?yjsirkGk5E74hEB5Rc5j2xkd/ttDfnjntbn/Xgyi/UKmvWmWKglsePjDbE3W?=
 =?us-ascii?Q?yBfKB+bCyfOjATwyVEx9/aqwxOMD3xxOGf/qGTGWEBEdP0A5FxDDO6WqNkie?=
 =?us-ascii?Q?7Zy5uiKnhP0L8pWzKJkZdpwCjW9MypQQoMHIlRD4WlaDAgUwaigwfrUdtv73?=
 =?us-ascii?Q?KycwvustNWpJoXG9FPFi/NLKwtfG91g8bS2wpG59WOe4mEWsVpFfeLzEZKwU?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07635e1a-3a48-4eaf-1ff4-08dddb09b553
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 08:08:10.1795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/ESDpqpwhpQINd7nOjrJ+C1dxpSsS9Wt90Z0V0ZyDaQuVdEFV6TmbjTyXanQNNf72HviZGh2YfzXlY7nHlWzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9107
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 555859c514d9b8ca62ca2f1553bf6291ceee1e3a ("[PATCH v2] block: restore default wbt enablement")
url: https://github.com/intel-lab-lkp/linux/commits/Julian-Sun/block-restore-default-wbt-enablement/20250812-234518
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20250812154257.57540-1-sunjunchao@bytedance.com/
patch subject: [PATCH v2] block: restore default wbt enablement

in testcase: boot

config: i386-randconfig-012-20250813
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508140947.5235b2c7-lkp@intel.com


[    1.575968][    T1] WARNING: possible circular locking dependency detected
[    1.575968][    T1] 6.17.0-rc1-00012-g555859c514d9 #1 Tainted: G                T
[    1.575968][    T1] ------------------------------------------------------
[    1.575968][    T1] swapper/0/1 is trying to acquire lock:
[ 1.575968][ T1] 420f00b4 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_slow_inc (kernel/jump_label.c:191) 
[    1.575968][    T1]
[    1.575968][    T1] but task is already holding lock:
[ 1.575968][ T1] 46342678 (&q->q_usage_counter(io)#9){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave (block/blk-mq.c:206) 
[    1.575968][    T1]
[    1.575968][    T1] which lock already depends on the new lock.
[    1.575968][    T1]
[    1.575968][    T1] the existing dependency chain (in reverse order) is:
[    1.575968][    T1]
[    1.575968][    T1] -> #2 (&q->q_usage_counter(io)#9){++++}-{0:0}:
[    1.575968][    T1]
[    1.575968][    T1] -> #1 (fs_reclaim){+.+.}-{0:0}:
[    1.575968][    T1]
[    1.575968][    T1] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[    1.575968][    T1]
[    1.575968][    T1] other info that might help us debug this:
[    1.575968][    T1]
[    1.575968][    T1] Chain exists of:
[    1.575968][    T1]   cpu_hotplug_lock --> fs_reclaim --> &q->q_usage_counter(io)#9
[    1.575968][    T1]
[    1.575968][    T1]  Possible unsafe locking scenario:
[    1.575968][    T1]
[    1.575968][    T1]        CPU0                    CPU1
[    1.575968][    T1]        ----                    ----
[    1.575968][    T1]   lock(&q->q_usage_counter(io)#9);
[    1.575968][    T1]                                lock(fs_reclaim);
[    1.575968][    T1]                                lock(&q->q_usage_counter(io)#9);
[    1.575968][    T1]   rlock(cpu_hotplug_lock);
[    1.575968][    T1]
[    1.575968][    T1]  *** DEADLOCK ***
[    1.575968][    T1]
[    1.575968][    T1] 5 locks held by swapper/0/1:
[ 1.575968][ T1] #0: 43d11208 (&set->update_nr_hwq_lock){.+.+}-{4:4}, at: add_disk_fwnode (block/genhd.c:597) 
[ 1.575968][ T1] #1: 463429c8 (&q->sysfs_lock){+.+.}-{4:4}, at: blk_register_queue (block/blk-sysfs.c:889) 
[ 1.575968][ T1] #2: 463427e0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: wbt_init (block/blk-wbt.c:925) 
[ 1.575968][ T1] #3: 46342678 (&q->q_usage_counter(io)#9){++++}-{0:0}, at: blk_mq_freeze_queue_nomemsave (block/blk-mq.c:206) 
[ 1.575968][ T1] #4: 46342694 (&q->q_usage_counter(queue)){+.+.}-{0:0}, at: blk_mq_freeze_queue_nomemsave (block/blk-mq.c:206) 
[    1.575968][    T1]
[    1.575968][    T1] stack backtrace:
[    1.575968][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G                T   6.17.0-rc1-00012-g555859c514d9 #1 PREEMPT(none)
[    1.575968][    T1] Tainted: [T]=RANDSTRUCT
[    1.575968][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    1.575968][    T1] Call Trace:
[ 1.575968][ T1] ? dump_stack_lvl (lib/dump_stack.c:123) 
[ 1.575968][ T1] ? dump_stack (lib/dump_stack.c:130) 
[ 1.575968][ T1] ? print_circular_bug (kernel/locking/lockdep.c:2045) 
[ 1.575968][ T1] ? check_noncircular (kernel/locking/lockdep.c:2175) 
[ 1.575968][ T1] ? check_prev_add (kernel/locking/lockdep.c:3166) 
[ 1.575968][ T1] ? validate_chain (kernel/locking/lockdep.c:3285 kernel/locking/lockdep.c:3908) 
[ 1.575968][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5237) 
[ 1.575968][ T1] ? lock_acquire (kernel/locking/lockdep.c:470 kernel/locking/lockdep.c:5870 kernel/locking/lockdep.c:5825) 
[ 1.575968][ T1] ? static_key_slow_inc (kernel/jump_label.c:191) 
[ 1.575968][ T1] ? cpus_read_lock (arch/x86/include/asm/preempt.h:80 include/linux/percpu-rwsem.h:55 include/linux/percpu-rwsem.h:77 kernel/cpu.c:491) 
[ 1.575968][ T1] ? static_key_slow_inc (kernel/jump_label.c:191) 
[ 1.575968][ T1] ? rq_qos_add (include/linux/blk-mq.h:940 block/blk-rq-qos.c:351) 
[ 1.575968][ T1] ? wbt_init (block/blk-wbt.c:925) 
[ 1.575968][ T1] ? wbt_enable_default (block/blk-wbt.c:728) 
[ 1.575968][ T1] ? blk_register_queue (block/blk-sysfs.c:910) 
[ 1.575968][ T1] ? __add_disk (block/genhd.c:528) 
[ 1.575968][ T1] ? add_disk_fwnode (block/genhd.c:597) 
[ 1.575968][ T1] ? device_add_disk (block/genhd.c:628) 
[ 1.575968][ T1] ? loop_add (drivers/block/loop.c:2078 (discriminator 3)) 
[ 1.575968][ T1] ? __lock_acquire (kernel/locking/lockdep.c:5237) 
[ 1.575968][ T1] ? loop_init (drivers/block/loop.c:2268 (discriminator 3)) 
[ 1.575968][ T1] ? max_loop_setup (drivers/block/loop.c:2228) 
[ 1.575968][ T1] ? do_one_initcall (init/main.c:1269) 
[ 1.575968][ T1] ? do_initcalls (init/main.c:1330 init/main.c:1347) 
[ 1.575968][ T1] ? kernel_init_freeable (init/main.c:1583) 
[ 1.575968][ T1] ? rest_init (init/main.c:1461) 
[ 1.575968][ T1] ? kernel_init (init/main.c:1471) 
[ 1.575968][ T1] ? ret_from_fork (arch/x86/kernel/process.c:154) 
[ 1.575968][ T1] ? rest_init (init/main.c:1461) 
[ 1.575968][ T1] ? ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 1.575968][ T1] ? entry_INT80_32 (arch/x86/entry/entry_32.S:945) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250814/202508140947.5235b2c7-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

