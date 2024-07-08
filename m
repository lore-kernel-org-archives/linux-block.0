Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5954D8A9
	for <linux-block@vger.kernel.org>; Mon,  8 Jul 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720427097; cv=fail; b=T3LBzqSnG3cRkyU6eTpuBWsLe2oAlnI6T84ud7sfRtDQASmSkbJdWNDoYppEpBUeuc0hQ+tj+/ZD25yL781bAV4lpRu5J47VwjbQ6SrU1VvjlwB99FzpoTL4vTJIhv50Jr/wRJkZtTca/Oi2Oq1KuJwNyqhaIXz4O/oTRqwvzZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720427097; c=relaxed/simple;
	bh=qaw0iizA95x5ubcYGr3jOslsRjWmWn14lIU2GJ2alcg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EIJG0ScFK5oVTpDpMBnjaKB/qtPlH2QVWt29ylD4802/6WxVY+6ZsBmablVawrltY9c12Y5rvJOoOONXowR9IbDguILGHXUf19W1t+spiCIvQnYEcMPQk1RkQjshnBt3Nwy88h4ulk8gFCgu2+3wcv3vw44BMBHBzOX6nD9tOug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mZtVb6eY; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mZtVb6eY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720427095; x=1751963095;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=qaw0iizA95x5ubcYGr3jOslsRjWmWn14lIU2GJ2alcg=;
  b=mZtVb6eYftFb7r9D505IX66pGmNBFkvJAaaWfnaRY0HJ18rc+lKJeNye
   yWUB56kEhps/+u3Mln6ISDYkxhcOfXZX+DQRVZbslI0DHqGJKecAKbYYp
   vk5L+Auv2BkwBlUJJ50zNJA0NmNPDbhMQC7z1YXENAKc5GOIEyLZIVNnf
   xkWav+Sc7PaSXI/EvHGw/VmXi9TdGrBkEAG9FURj8zizx0sgockqCvvQG
   VvwoBBkOdWjqto0pqReG9uiG50QaGnQzQQ58vvrY2Zemm24V4NgBCruPj
   xvZFrE7fLrKXCH63StillDqOlf+OPz3VqqOXB7lfzxdYfHr5CMvET/9eS
   w==;
X-CSE-ConnectionGUID: w0Qyf/AMSQSicYhwwad3yg==
X-CSE-MsgGUID: aTex+b1sTVam3lQWXXMFtg==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17488460"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17488460"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 01:24:54 -0700
X-CSE-ConnectionGUID: Zu/d+KDNR9u2tDZeP88fGw==
X-CSE-MsgGUID: 0BPacxhESLmTZwnhiRsmcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="51856985"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jul 2024 01:24:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 01:24:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 01:24:53 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 01:24:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4qiF2onUHTJFLhzmMth9AfOsYb35IF/WlaF1rXndcaaZ7/z39MScXJ/odwYPiF8PmGZbPqUJuFtByGKvQWPhOsCiXm40Ef7lOzD7EtqTSSyn7ZYMKDXn+T2H8J34A3BVE16YgIdzR9F81eAYuR0M5WpetuQgPHb8Tgh/rLfD96wCxFJQ+xDkTHb58PDoOu9sntonrgmFjjTN/69BdTSvEVrISwN2P8+AzWtzRT0oxD8J6UfkmuFwVr456ZHHlPOuEC4eZ3uxRP6lLvSPCMe/5o1da28X2YqyXhV59Ms4xk/P5rQJYDDWM7CMVMcoPRhr2gJwCmTyR4lILr/vMgJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTX0LsNuVbTBwzghpxDPlHTq+9TwIwARQ1qoxdyFu7w=;
 b=jiSqxbD+EdUbf7dU11ODJT3gUGs22HDOaYWBnuPWORpN+qtkjRrR7oTtUMiup6UvJ7Btyh42H2QCLlezu54zmXnHVtepY66RbBtTSfI5inyfiAxuszmyqTNyQEKElCXSEiSVg15/gACzBZFoVXueW5JF9bT2ddJfC6aUfxmhNrmXIHqWFvwkNlBijgUOzmHswZuC1KS+CeGESfXVlBVnan9v6wAoxnFQQN+sL2HBKQ5at0sNDwdPA8xDi4QtTyINekAZK1wWTAof7CWRQKzxTUuZrB+JXvPSp1iSymRFUzr4tFE1gNUXVX40Ikqq1rCRlu+TMRTmyv2RdM7dCAX07w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 08:24:49 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 08:24:49 +0000
Date: Mon, 8 Jul 2024 16:24:36 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Kundan Kumar <kundan.kumar@samsung.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<ltp@lists.linux.it>, <axboe@kernel.dk>, <hch@lst.de>, <willy@infradead.org>,
	<kbusch@kernel.org>, <joshi.k@samsung.com>, <mcgrof@kernel.org>,
	<anuj20.g@samsung.com>, <nj.shetty@samsung.com>, <c.gameti@samsung.com>,
	<gost.dev@samsung.com>, Kundan Kumar <kundan.kumar@samsung.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH v7 3/4] block: introduce folio awareness and add a bigger
 size from folio
Message-ID: <202407081641.6a640f9e-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240704070357.1993-4-kundan.kumar@samsung.com>
X-ClientProxiedBy: SI2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:4:195::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CO1PR11MB5009:EE_
X-MS-Office365-Filtering-Correlation-Id: 8218af96-78b0-4f9d-1a19-08dc9f276efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R0i4AjU2d19/bmCagweUMOKeG5u1BlHCEf5w8beLaR83nK7fup4VG5W7dbt3?=
 =?us-ascii?Q?xxglTQbmFF5KCBifHtup6ckbJQUs700BoWxcOMnQ9Vz2OdDxY6Jc/4Mq2f5Y?=
 =?us-ascii?Q?4GVlH03lpQMSzYvmvpUsaV5cvhYT+vjlArVN3BysUmeejREBzS2tUhXw8zce?=
 =?us-ascii?Q?1FC8/Hn6EpoxLiDb2BJ0htqYICljtduanw2ojajUUT+nvVn3uit59QvKwfvh?=
 =?us-ascii?Q?rJCps8703czD59euW6ZAmGubEEZQojrCvgM+ZNTCt2EzOsTCokmo/Q+LvqGR?=
 =?us-ascii?Q?jyXqlU5hzxSrkzai0uNKA+DcQPGegw0M62fuEF29JVLb3Dv/Ge0PgjWECWq5?=
 =?us-ascii?Q?GnVJf9S8Hjz0xfLRiIkuFdtSwPa2ZBwmmRI19e9KbnwPAbeqfOj3w/C0Dedr?=
 =?us-ascii?Q?0cfjfAXvUjbmWhNHaqhOxiwc+ocV4wkiP+zLIewr4OV+fzsNib8ASGHuGX8k?=
 =?us-ascii?Q?olaQwR0Q0ggGWyFdkmXSHUdaY4oZp9s1Dwm9xc2+Z8mR7gJaxHZM1lDHtbsC?=
 =?us-ascii?Q?9yvldtLBaAN6f0NEjwjKnKK0wRF6BvnL4LmpoiXPgZ8qx+yhLrn4w7FCFm7g?=
 =?us-ascii?Q?GPLtLOFPdWp5++ZgNQePvwPed5+VTjYG2ZvfFI06w65WtpHOg5O0rauYd8Ne?=
 =?us-ascii?Q?ScDFDI7TU4x1Slp9jikXqpNoL2XJ1YoSqKEbcBY3gUTjxLGOx75omzsepK3P?=
 =?us-ascii?Q?olUKQLQZB4F26hbKJRFqKjmNkZATGEyJAAisthteJe2UgoE5ZdAkQWXGcJrp?=
 =?us-ascii?Q?+9a7BjmaX+myA1KW65wGa3iPjUvnHBLap6yblicXkuZj78tlRk7m9fL12csH?=
 =?us-ascii?Q?vPlB4ocwRj3fFO8qO2EKHsbhOkpFlKqs7mHrTPLafgLPpfPWs73FLhvN9cme?=
 =?us-ascii?Q?CUKJqZPJhmnYlmL4ua67/QPAac8IAhcFfFs+bUYBH10RyhSUB2svDj++85VB?=
 =?us-ascii?Q?I3GJHXSw5yE1p6xNNYl7jfGW/zhb0uPrgagudB66BfA4MZM/SsSiT2zQbUa7?=
 =?us-ascii?Q?bztAzpRGOfk7WV7AiL7g5b0sj5Mzq6SPMZQIEAxvZd/VDIAkZgM8Mg1y6mRv?=
 =?us-ascii?Q?Frg0rV5+gWBQcMATxiH7OPWSdMzKHE8Qc3Ao49oNRH9oCUg+t1VKRKnA/0cG?=
 =?us-ascii?Q?RBBQyOBmZeEHxYwe3TK9VetwYE/PiqnBfv/Oli3I1oi4Nh73evuEkB/DCKRe?=
 =?us-ascii?Q?Puz8gTe33hiG7fI3kqM7TeW2Mcpi1FJdDvDRgwqSt1+ycBeLQVPZRfQH+L+7?=
 =?us-ascii?Q?n8m0Hf0aBfT1QG5hSmaVLv8feFvH1r+UnoYo6fOYUAbMusPhlD/E9N59/blS?=
 =?us-ascii?Q?4gI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F8b2vp2ix8XeZBj29geRU4qvqAdmDV1K502T593kt06uj3pG8gzuYJ4CLmB/?=
 =?us-ascii?Q?ztamCbOKZnplwv6Ug4jhgM46NYB/Z4aLA3SoFjzE+OBVq+odsZ00fnIvWGvr?=
 =?us-ascii?Q?AVRhjnhIUMi+g18hFBGAzsyMTAsYwRoM0jNuOKtiuFzvCdMxNh8NcyqNZxWn?=
 =?us-ascii?Q?fCPAVMUBnpX/l6Qw63jbWyF0WPr0pjQoogIN+pD3waMyonZ2hnTE8JDaZYCq?=
 =?us-ascii?Q?Qbk8+E4UKzX98WlI1EoUpWYDZH8HSyUMAs/cgYy3sMnK8mxc7sVQr2FJu36I?=
 =?us-ascii?Q?SpYexMlnod6FfkceexiYhLEkgzoX5gcu7VvG1KfCrGqT1J6MtTzOVQW8Q2B4?=
 =?us-ascii?Q?fGx0xsdUNsdKaS92kPYaisXoUbo5FuAopk8/XEj4Up9bqUGW+g06sTqcm+Xy?=
 =?us-ascii?Q?/QUnJ6qDLuLr1xg5d8aMHaHNVbupBPVey5tkEB6FuKRP0/4REdhHUrch5TWn?=
 =?us-ascii?Q?tR98yhBXLYoktE0tkMOZ7wci5Abq7DfE1VtGh/QMv+rpizL6q2Y6ptpMuEQI?=
 =?us-ascii?Q?sPUaDVX4G/YuvweChL2Xm6iX0qP8xWHpEovHCawkkwkrp6Vrs1QNBh2z2oPZ?=
 =?us-ascii?Q?qN9/gXm2yQ1Vb0a3W6cqu4b7aNhORbuzqfL8E1JBBp3qhWOM1yxL1RIh2k/5?=
 =?us-ascii?Q?vg7wUWFISDEafoZY3nZXTPp2Ea4I3gkMtE1w1sj0rtVI1bizRp/Y3fo+3gfF?=
 =?us-ascii?Q?efIowcpzo1vG57sm32uLZcjmGyu1Q1Vc5E7YqSLpKdSOqd+MG2jo2ppye7a/?=
 =?us-ascii?Q?26K0N2ZfvsujwSxnndm53y2UWL/Q+UBec26KcH98mybd+xpc8rILuz56QrN9?=
 =?us-ascii?Q?6FsOmhVpYfD0J4DMH4Ft5Q8wSPTr//PCPOeajdsWwg5CD/SnOus3BeSGQfbq?=
 =?us-ascii?Q?zmB6MZsvVm9VEm4DApgLUeXIp/frxSOvhsbQneY8EbgCnP9VzDPcrJXWyUUI?=
 =?us-ascii?Q?YfI/ypYSlHUgCvc1g6H91mFHzzy4UEGeyBQyF2ZLsU31YMWcKg0Ck6udikza?=
 =?us-ascii?Q?FXZ2T00OuybBQVM347Mc5vgoosbHuuGmXVSEtGGFxfcLoTiXEC5TkRtFin8Q?=
 =?us-ascii?Q?2TGIB2URiItlzE5CvJEL6pq8cFx+VezyAH7+RLsKQ5+UWq1YzBf61O0mk5S8?=
 =?us-ascii?Q?MEqjnZtIITYZhpOuW9pBp3Hscjv8dhOQJp77tToML3c+pKamF5F07fHdKj3y?=
 =?us-ascii?Q?Xm6r8o9jfmaNTW3G3dgXYFcj6YDClsCHkDhlic1vuxydWlAK0bffzXWIFQ53?=
 =?us-ascii?Q?m/Bb8WfHMjRbpfDW2vYg/I3P9Mu6jUPz/G+lmosJojGc7ZPJlhVeyjpirktH?=
 =?us-ascii?Q?D4w7kl/eymO08WeIeN9UPfiT5DNF6IDGqmz0snIqV9sRUcoO7OlXS55eLz3M?=
 =?us-ascii?Q?MZKEG/5kxW191abZQx6oq24kOAE/UWAfB12xehIW60C33fY67XqCcwjR1Of7?=
 =?us-ascii?Q?qyepIXpnD+CTFwjNagJ0TnFbZy0JPRYKhiUj9d7A1KLoYfhtu+wCAHXtqABS?=
 =?us-ascii?Q?KfbAd+VhuCP/X5AiaQsVN6x/zLvygzEjeBNPbiYDk0kxXKObcWyv8DHiQ/Fe?=
 =?us-ascii?Q?bsEPBnFfSjmf0RZ0dBVfR7qTyahyVQop2PmqPIivUOHdBrekVaIXFv5sJIQk?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8218af96-78b0-4f9d-1a19-08dc9f276efd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:24:49.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo5QyYw6vq5zqHCBBi1XhGekwPz9xzUISIbChn2J/ODoZ+xy64/nmZXBU0jOWEIlyZvGEj8vbYiG7iUEgYpx0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5009
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_mm/gup.c:#try_grab_page" on:

commit: 69b40318d4fdb6a9ac6bb833618e4cd954db4946 ("[PATCH v7 3/4] block: introduce folio awareness and add a bigger size from folio")
url: https://github.com/intel-lab-lkp/linux/commits/Kundan-Kumar/block-Added-folio-lized-version-of-bvec_try_merge_hw_page/20240705-055633
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20240704070357.1993-4-kundan.kumar@samsung.com/
patch subject: [PATCH v7 3/4] block: introduce folio awareness and add a bigger size from folio

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240706
with following parameters:

	disk: 1HDD
	fs: ext4
	test: ltp-aiodio.part2-00



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 128G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407081641.6a640f9e-oliver.sang@intel.com


kern  :warn  : [  327.605962] ------------[ cut here ]------------
kern :warn : [  327.606706] WARNING: CPU: 1 PID: 5867 at mm/gup.c:229 try_grab_page (mm/gup.c:229 (discriminator 1)) 
kern  :warn  : [  327.607701] Modules linked in: intel_rapl_msr intel_rapl_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 rapl btrfs blake2b_generic xor zstd_compress raid6_pq libcrc32c crc32c_intel sd_mod sg intel_cstate ahci mei_me nvme libahci ipmi_devintf ipmi_msghandler intel_uncore intel_wmi_thunderbolt wmi_bmof mxm_wmi wdat_wdt libata nvme_core i2c_i801 ioatdma mei i2c_smbus dca wmi binfmt_misc drm fuse loop dm_mod ip_tables
kern  :warn  : [  327.613419] CPU: 1 PID: 5867 Comm: dio_sparse Not tainted 6.10.0-rc6-00246-g69b40318d4fd #1
kern  :warn  : [  327.614547] Hardware name: Gigabyte Technology Co., Ltd. X299 UD4 Pro/X299 UD4 Pro-CF, BIOS F8a 04/27/2021
kern :warn : [  327.615788] RIP: 0010:try_grab_page (mm/gup.c:229 (discriminator 1)) 
kern :warn : [ 327.616621] Code: 40 f6 c5 01 0f 84 1a fe ff ff 48 83 ed 01 e9 14 fe ff ff be 04 00 00 00 4c 89 e7 e8 bd 68 14 00 f0 41 ff 04 24 e9 67 ff ff ff <0f> 0b b8 f4 ff ff ff 5b 5d 41 5c 41 5d c3 cc cc cc cc e8 9c 68 14
All code
========
   0:	40 f6 c5 01          	test   $0x1,%bpl
   4:	0f 84 1a fe ff ff    	je     0xfffffffffffffe24
   a:	48 83 ed 01          	sub    $0x1,%rbp
   e:	e9 14 fe ff ff       	jmp    0xfffffffffffffe27
  13:	be 04 00 00 00       	mov    $0x4,%esi
  18:	4c 89 e7             	mov    %r12,%rdi
  1b:	e8 bd 68 14 00       	call   0x1468dd
  20:	f0 41 ff 04 24       	lock incl (%r12)
  25:	e9 67 ff ff ff       	jmp    0xffffffffffffff91
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
  31:	5b                   	pop    %rbx
  32:	5d                   	pop    %rbp
  33:	41 5c                	pop    %r12
  35:	41 5d                	pop    %r13
  37:	c3                   	ret
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	cc                   	int3
  3c:	e8                   	.byte 0xe8
  3d:	9c                   	pushf
  3e:	68                   	.byte 0x68
  3f:	14                   	.byte 0x14

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	b8 f4 ff ff ff       	mov    $0xfffffff4,%eax
   7:	5b                   	pop    %rbx
   8:	5d                   	pop    %rbp
   9:	41 5c                	pop    %r12
   b:	41 5d                	pop    %r13
   d:	c3                   	ret
   e:	cc                   	int3
   f:	cc                   	int3
  10:	cc                   	int3
  11:	cc                   	int3
  12:	e8                   	.byte 0xe8
  13:	9c                   	pushf
  14:	68                   	.byte 0x68
  15:	14                   	.byte 0x14
kern  :warn  : [  327.619059] RSP: 0018:ffffc9000d61f2f8 EFLAGS: 00010246
kern  :warn  : [  327.619993] RAX: 0000000000000000 RBX: ffffea000bc10000 RCX: ffffffff8194dcbb
kern  :warn  : [  327.621085] RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffea000bc10034
kern  :warn  : [  327.622179] RBP: ffffea000bc10000 R08: 0000000000000000 R09: fffff94001782006
kern  :warn  : [  327.623273] R10: ffffea000bc10037 R11: 00007fd4b2aa6fff R12: ffffea000bc10034
kern  :warn  : [  327.624366] R13: 0000000000290000 R14: ffff8881267fec40 R15: 0000000000000000
kern  :warn  : [  327.625460] FS:  00007fd4b2929740(0000) GS:ffff889f8ae80000(0000) knlGS:0000000000000000
kern  :warn  : [  327.626636] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kern  :warn  : [  327.627622] CR2: 00007f517b030000 CR3: 0000002081e22001 CR4: 00000000003706f0
kern  :warn  : [  327.628727] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kern  :warn  : [  327.629832] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kern  :warn  : [  327.631001] Call Trace:
kern  :warn  : [  327.631743]  <TASK>
kern :warn : [  327.632445] ? __warn (kernel/panic.c:693) 
kern :warn : [  327.633243] ? try_grab_page (mm/gup.c:229 (discriminator 1)) 
kern :warn : [  327.634128] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
kern :warn : [  327.634985] ? handle_bug (arch/x86/kernel/traps.c:239 (discriminator 1)) 
kern :warn : [  327.635835] ? exc_invalid_op (arch/x86/kernel/traps.c:260 (discriminator 1)) 
kern :warn : [  327.636695] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:621) 
kern :warn : [  327.637587] ? try_grab_page (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/page_ref.h:67 include/linux/page_ref.h:89 mm/gup.c:229) 
kern :warn : [  327.638509] ? try_grab_page (mm/gup.c:229 (discriminator 1)) 
kern :warn : [  327.639418] ? try_grab_page (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/atomic/atomic-instrumented.h:33 include/linux/page_ref.h:67 include/linux/page_ref.h:89 mm/gup.c:229) 
kern :warn : [  327.640285] follow_huge_pmd (mm/gup.c:809) 
kern :warn : [  327.641162] follow_pmd_mask+0x3f8/0x7e0 
kern :warn : [  327.642090] ? __pfx_follow_pmd_mask+0x10/0x10 
kern :warn : [  327.643125] ? find_vma (mm/mmap.c:1944) 
kern :warn : [  327.643948] ? __pfx_find_vma (mm/mmap.c:1944) 
kern :warn : [  327.644804] follow_page_mask (mm/gup.c:1116 mm/gup.c:1162) 
kern :warn : [  327.645674] __get_user_pages (mm/gup.c:1588 (discriminator 1)) 
kern :warn : [  327.646601] ? __pfx___get_user_pages (mm/gup.c:1522) 
kern :warn : [  327.647533] ? down_read_killable (arch/x86/include/asm/atomic64_64.h:20 include/linux/atomic/atomic-arch-fallback.h:2629 include/linux/atomic/atomic-long.h:79 include/linux/atomic/atomic-instrumented.h:3224 kernel/locking/rwsem.c:176 kernel/locking/rwsem.c:181 kernel/locking/rwsem.c:249 kernel/locking/rwsem.c:241 kernel/locking/rwsem.c:1249 kernel/locking/rwsem.c:1273 kernel/locking/rwsem.c:1551) 
kern :warn : [  327.648428] ? __pfx_down_read_killable (kernel/locking/rwsem.c:1547) 
kern :warn : [  327.649345] __gup_longterm_locked (mm/gup.c:1859 mm/gup.c:2556) 
kern :warn : [  327.650237] gup_fast_fallback (mm/gup.c:3476) 
kern :warn : [  327.651111] ? __pfx__raw_spin_lock_irqsave (kernel/locking/spinlock.c:161) 
kern :warn : [  327.652030] ? __pfx_gup_fast_fallback (mm/gup.c:3439) 
kern :warn : [  327.652890] ? __link_object (include/linux/rculist.h:79 (discriminator 1) include/linux/rculist.h:128 (discriminator 1) mm/kmemleak.c:728 (discriminator 1)) 
kern :warn : [  327.653674] iov_iter_extract_pages (lib/iov_iter.c:1584 (discriminator 1) lib/iov_iter.c:1646 (discriminator 1)) 
kern :warn : [  327.654501] __bio_iov_iter_get_pages (block/bio.c:1353) 
kern :warn : [  327.655382] ? __pfx___bio_iov_iter_get_pages (block/bio.c:1324) 
kern :warn : [  327.656273] ? bio_init (arch/x86/include/asm/atomic.h:28 include/linux/atomic/atomic-arch-fallback.h:503 include/linux/atomic/atomic-instrumented.h:68 block/bio.c:279) 
kern :warn : [  327.656980] ? bio_alloc_bioset (block/bio.c:578) 
kern :warn : [  327.657721] bio_iov_iter_get_pages (block/bio.c:1446 (discriminator 3)) 
kern :warn : [  327.658474] iomap_dio_bio_iter (fs/iomap/direct-io.c:388) 
kern :warn : [  327.659248] __iomap_dio_rw (fs/iomap/direct-io.c:501 fs/iomap/direct-io.c:660) 
kern :warn : [  327.659982] ? __pfx___iomap_dio_rw (fs/iomap/direct-io.c:544) 
kern :warn : [  327.660729] ? __pfx_ext4_dio_write_checks (fs/ext4/file.c:424) 
kern :warn : [  327.661518] ? __pfx_ext4_dio_write_end_io (fs/ext4/file.c:376) 
kern :warn : [  327.662299] ? iomap_dio_complete (fs/iomap/direct-io.c:133) 
kern :warn : [  327.663052] iomap_dio_rw (fs/iomap/direct-io.c:749) 
kern :warn : [  327.663723] ext4_dio_write_iter (fs/ext4/file.c:577) 
kern :warn : [  327.664439] ? __pfx_ext4_dio_write_iter (fs/ext4/file.c:499) 
kern :warn : [  327.665185] ? folio_unlock (arch/x86/include/asm/bitops.h:101 include/asm-generic/bitops/instrumented-lock.h:80 include/linux/page-flags.h:762 mm/filemap.c:1508) 
kern :warn : [  327.665838] ? do_wp_page (include/linux/vmstat.h:71 (discriminator 1) mm/memory.c:3193 (discriminator 1) mm/memory.c:3663 (discriminator 1)) 
kern :warn : [  327.666494] ? __pfx___might_resched (kernel/sched/core.c:10151) 
kern :warn : [  327.667254] vfs_write (fs/read_write.c:497 fs/read_write.c:590) 
kern :warn : [  327.667915] ? __pfx___might_resched (kernel/sched/core.c:10151) 
kern :warn : [  327.668657] ? __pfx_vfs_write (fs/read_write.c:571) 
kern :warn : [  327.669342] ? __pfx___might_resched (kernel/sched/core.c:10151) 
kern :warn : [  327.670062] ? __pfx_put_timespec64 (kernel/time/time.c:904) 
kern :warn : [  327.670774] ksys_write (fs/read_write.c:643) 
kern :warn : [  327.671409] ? __pfx_ksys_write (fs/read_write.c:633) 
kern :warn : [  327.672129] ? __pfx___x64_sys_clock_gettime (kernel/time/posix-timers.c:1132) 
kern :warn : [  327.672939] ? fpregs_restore_userregs (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:79) 
kern :warn : [  327.673697] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
kern :warn : [  327.674363] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
kern  :warn  : [  327.675145] RIP: 0033:0x7fd4b2a24240
kern :warn : [ 327.675803] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	rex add %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240708/202407081641.6a640f9e-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

