Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7BE27EFFA
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 06:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708230; cv=fail; b=byPiFiljjRkZd96CtiqIIMHW9kJLwoZ69LipUffYoIffBEPVI3B5LBCKeXuEyOPbWohPj+AnnKuuGtmwPkvaMJhQhsUH64ObKzSfoLZhcNqNmYSFL2vr6KkNvaXIxN7ok/2QAT+i2dro/Qj0u37EYluB8KgD6XigqVxB/YACQzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708230; c=relaxed/simple;
	bh=vQtN1KVgWyE4rFuDZGCeBGMZmM4odRtAgbL9f6enscQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SOxBqxRJ6gfuk8ms3kqWCY/3fmlhCo8vi75AF0rhSY9+MManaMR+Zww6/wTkL4mIhuePUpvYxFNe4hG27s+fDBwjFHBQ5VVrxTZynnOkiTJXD7uei+EAp4ZI5P4OWgVVBmGfzOPk3PwgoMtJnVpaxKzUWIYP7T2Ch0ZzRoEpFz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Di9TqNfQ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Di9TqNfQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763708229; x=1795244229;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=vQtN1KVgWyE4rFuDZGCeBGMZmM4odRtAgbL9f6enscQ=;
  b=Di9TqNfQ+Qn00xakBJaQ0Qu8T7j3kYtjyc3EjTKQU2p/8oUCUtoMYMDv
   E3X9IahJoUQesjv3/b1cuJcDKRr+lUSI2TO5K5YNHHNhx9Kfv3eRny4Ti
   W0+hQPTNNTM/Ts/CczsyJHXXXpOHFMnDqTf2qFljBFuFxy1QTZn6O/XpM
   e7amG2NsviYM+xKXCLnsWn0b4E8WMBguN4LPuHbBUx+n8Tr3+ptOcJQ/E
   BdJtvXmyyz9Bc1dBsG/0QRglVYm4BnMSG8RdetENBbZI7zGDO4yEB3e1B
   wfXHngybryI73Wnjsd9JSX5GuN9Zh3LBS3UQsKziOfoQoJYLM/UTK3hHp
   w==;
X-CSE-ConnectionGUID: 9deaxNtMTU+ax/l3Wgxp6Q==
X-CSE-MsgGUID: JH0yy8A4QMatTY8GT4XBfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="88446593"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="88446593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 22:57:08 -0800
X-CSE-ConnectionGUID: rqy78MPhStqq0Suu6AL3XQ==
X-CSE-MsgGUID: /anDsFzyR8u67e0NKO0uYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="191861344"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 22:57:08 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 22:57:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 22:57:07 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.67) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 22:57:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZmdkst8Srp35ePsxGYIeE6sJ2DYgDYYc7gf619VtBpskdFwnKta/Q9hyIJiVRqp1hdvgh4iPbW9iutdvGLJ9iuffSseIQ17cxYBOTefcDPmUM/Q6vxFsqiQwYWd+lEdMH4GRUEgVFTPhRoNrB+/uZVfh6wD90TfObnLUGiiJRUdyCyqKMePI43OaXPXQVuXwVObomzsWm156u80f530eZ2LxgFv488emYayBrhGMjUliUre9Z230SM97j0wX9RlnI674erPzG5jTHOfCs76cnWXNpv2S9IwvJorBVUytzqfJAEzVtLWBA46fiL0Fy+QEC6f4xNxm53Q2733Im+D0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YGFZDYjzxD3wen1Lw+J+GvroOZ2XqSEmdcgGqQPOy7Q=;
 b=Wx/IsOsvS2DrJ6YBaYKbEzjeq1hlQHsOqSqV9AfRFWWASvrSRG5yVBUZm6vg5aIO9j5shZQ4AFRxFL72SxFTS2ru8tvWnhkETQTSp8kWnUXTtreeQBW4LnVa35PR3wIWL2Z6XxnMHRzR/knn89qSHRd4ajj6311jtePmYh0c5+t075ajigeLt4QjJKcrVKYDowMMUOnG4TixDVH8Y+wMY55C/h/pqRoy7mkWhxg9/lnYRXVNSlzqryhXRLdpmiBtQS+J1dG282WQQ3DQ0N1MsUj5U1bEjp5005T0RVQvwjAXJ8xT9uiU/JQaStkbZIJg290nG40X6m11cbFP8zP/Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB7053.namprd11.prod.outlook.com (2603:10b6:303:221::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 06:57:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 06:57:04 +0000
Date: Fri, 21 Nov 2025 14:56:55 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Li Chen <chenl311@chinatelecom.cn>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Chaitanya Kulkarni <kch@nvidia.com>, Bart Van Assche <bvanassche@acm.org>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [block]  3179a5f7f8:  stress-ng.loop.ops_per_sec
 225.6% improvement
Message-ID: <202511211458.ef9f7202-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KUZPR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:26::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB7053:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e23484-262e-4a62-61d9-08de28cb2d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?k21Zjk47fEPqdNQApIYakokSRHNY7OoVJZKgrAz3wjFSesoxGmUBVN38+0?=
 =?iso-8859-1?Q?cPBsobXkaCZRql8tjrT9LldH9Qmm2pIreb32ifPWUURQgow3Z6Ho4UJJ2b?=
 =?iso-8859-1?Q?Jck85tmW9I4/MDAm3yDgM6Qx7iJMqG+JTI2aXF1Md9YhN/N96OdwUn6dwB?=
 =?iso-8859-1?Q?Gum94a5BrYKbcBIMXZAdj1PtysffTLWZE5GecSo9h88dy6qMFiMqDdhz7s?=
 =?iso-8859-1?Q?o0lZSpGHZELKtt40O5ozOyv/q4fW83E2luOjZtThn18fjaOggIQOvr64oq?=
 =?iso-8859-1?Q?5V+WqOPhCpmpGDLUlVPwvOZ8gQRv+K5KmcmLOGRh7zHLbt9V3sr50YKSZ1?=
 =?iso-8859-1?Q?TE9+/DRPzko1VSZ/xXwQcpnuMJ+tK+v/POth3BagPLJTt+jJVS+fvZf+e8?=
 =?iso-8859-1?Q?962JLDyKQ0Zh30RfUJL1W5yfjCH5J/ZM2MdAAU5xcxTWnfNcRmhGtIzoyu?=
 =?iso-8859-1?Q?2SOwxKDKJEqydpeNOmcqGkdxXeIoxkL528VPGCLbydab/9FGHNyd09Z7gh?=
 =?iso-8859-1?Q?uc9zYA1Y4wWV7kUitDFPe6HVePxSLyeawgSUYxKv0ZaSX/JMyr4tQSXTGp?=
 =?iso-8859-1?Q?BRGp5l7tmiqJMg5ESL3qw4mjMPlF3IEG9h80S8T9H6uXe4PCk5SnydizSK?=
 =?iso-8859-1?Q?ZfzYppkUjHY4yYem9KhjVXrFTg4Wk0dTwS7eqoR2U94fah80w6vEYJHtcA?=
 =?iso-8859-1?Q?7/E3/03p984Ow3SOdw0VWBUZIqsndtWjY5Ipn5lYO8JIcjEUI+7deNjcbp?=
 =?iso-8859-1?Q?W9jxwTzmeA/eufU7kCD4rXV/26Gdjp/16Wsu/K9RQtixooix0WOBUvfK42?=
 =?iso-8859-1?Q?1/VgIyczMYJa062hGaqFBoX4doaWMfbXwcCmUDNEHQiJ/zVzuj7Kk2i2Ic?=
 =?iso-8859-1?Q?WJvYrMbLPbBFvI1EqcQNGqOaiYWKPa5VDyB5xD1rFBqYprr1A+QlERwyJ/?=
 =?iso-8859-1?Q?hdGGl2S3fmMFzVPXKGRDhpq6xxAmMv51geZkTeYIKF/En+y7AFIv7azxdV?=
 =?iso-8859-1?Q?xpl4Abt9J2s3hDLdwUqUoiW7DyB6lPUcWCs1fcgTDT4S8mvgNeYTpQF8pB?=
 =?iso-8859-1?Q?7j8BwpJ0LJk4VI3DegQAK4/Zs+ifdyvNQ268P3u1JU4X2s4zCKCMhwRj/2?=
 =?iso-8859-1?Q?BU36H3joUZsbXTBlCxej4j86oA7Zm4KM/II38p1tphqn7UfNxe06hc17pk?=
 =?iso-8859-1?Q?Morv65lsQiPDqNscm038mPy8arCJ3m43t2Fq+rmVotT26Iz09eJBQIZtNc?=
 =?iso-8859-1?Q?W7NiM9LwwpZvE1nRxmhCr859ixm1VArnlCOWpY0ESuoJOdszyZywAtywmU?=
 =?iso-8859-1?Q?UVD1n/lGXS0QPzeFgmlloIfLsBxRke9WbndatHHAxo9LJRPybrtw7qHt9H?=
 =?iso-8859-1?Q?+BHh+XooJk4R/b8h3FdvsWxsDnSsl80Cc99KK6XBXRDwY70G/Npc8wQf9x?=
 =?iso-8859-1?Q?YEpHr75lSZMHcEJSpXspiJUcMxWIKPTM+NOs5v4uaOEpxXZKvbGK4lb4AY?=
 =?iso-8859-1?Q?iqwp65cYrZhB5MBS6DHlj5ZoqSwCgH+GZk/AA3LG47Gg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QWqps6D4nrjGcwoK93eGPHB7jDRlfdhVqOSwDd1KkGPr8iJiL0AV3jtejn?=
 =?iso-8859-1?Q?iTKwNp0d58pfIlEXFy03aTt5MERQ6ZdzKC5pyMZlgoSndjcpgjgx721iec?=
 =?iso-8859-1?Q?3SXE7u/0nvUZjT1AarcNDJ1LzOcBHYyQpMEXImGiCCuagr2iYtUqalJS9E?=
 =?iso-8859-1?Q?R9/sZc+rmu0eVMfcFxsObuqNJsyvQ9mtYqJeV6zVn771VmSKTyvHVWC28h?=
 =?iso-8859-1?Q?KEsFtfi/aiRZNtKmASRB/pHM9VVFoKjYqtjxPLgkEb9ngtdBbJZIivOiT9?=
 =?iso-8859-1?Q?6tKVtdTNz6EdPnnjfD49Akg80b8Y639qz2HZGlYXFd5jNNAiKDYYIl/nW+?=
 =?iso-8859-1?Q?oeelx+U5wsO4QgR1SX9W4QzUIfEYAg5z2XjQQCnGmf6skAvLRrSViFHtll?=
 =?iso-8859-1?Q?Y/crrrVhu5DPXPV90zU8NWKipt+fqhYbP4i4S7Zo7O21W8MC0CmOF8VULw?=
 =?iso-8859-1?Q?TF7GPuGbKLuO85RnWcz5G38UIoc5rFoQShBkOVbsH9G8JWNKDenP89I2zi?=
 =?iso-8859-1?Q?IPGpReTiPiei8jhKMTACBmfjyLAQXmS+AEbD/sI9L02NCD7P2+Up8Tm0ab?=
 =?iso-8859-1?Q?awagDs2/TvRvwljY6xJTqpZPYltXH/BpOB6tMbBp8IvubCOkEGswr5YhSP?=
 =?iso-8859-1?Q?IH86NDqSN1Jfxi33XdlLEutX9Eey8X4/py5sPwwu3SDptsUdogGpZXWhRL?=
 =?iso-8859-1?Q?Z0c6mP4lPP7vpMU1b7YDCOChCcTz4txmlr9fKvB45Mu5u2fLsCNPBxD0F2?=
 =?iso-8859-1?Q?a6cflkTSBSh+Ccn1Cm4XitJJYuia5XRPXMtbU+IMqfXPOFJse0yo21Qgk8?=
 =?iso-8859-1?Q?xMsRyDyfax2pjNulGLdZ1PbhRjbVVrBQzJoboitXP3mUs4zYEnlSxjD0iu?=
 =?iso-8859-1?Q?wKhDM6yjKQ9kGO+mxL+NCAOi9XerFZsJm9hrmryTMCZBmwAO/IZYz1CY8p?=
 =?iso-8859-1?Q?imnwVRnlQZK9kYhS7xd951+6U3iPG82LROsbMlRqquZGH7K4Eotb6rLV7e?=
 =?iso-8859-1?Q?wEVCipPghHq0p33FAzG/3GavphL0mpuQTM0Itfd70wx1VJZ6HATqmJA+Yx?=
 =?iso-8859-1?Q?09dHe7JAPsLwhwp43Nqo6/exE5x2af5uLGrHULAFPWzJw0DzoBqZMToD0s?=
 =?iso-8859-1?Q?rNwHNbBXqOGfM8UhdOm8vnowCDRiJh5mwSGcZP9qcfRo1lyqmiXkA+3xaS?=
 =?iso-8859-1?Q?iYUpLK0H/pnj1c+3KSMd12q4w+Nawh52FzXp0LaVJUAAElI8GQWlN3NGdR?=
 =?iso-8859-1?Q?hPHDa17mxZnPiDoO76IynC8zh0yS8Yei9VEUlabzJhnkI3eYEhfOlOf+LN?=
 =?iso-8859-1?Q?P9hwgBH3QFn0s3ufHTwTeKzJLjcQeVNTE7zrEqiLw7P+45308wUw99RWH3?=
 =?iso-8859-1?Q?SGg1km0mvgOV7EjApBITYCaViSkRmbj4L1uiq5hh08QnwFFSDDbZkRM7VT?=
 =?iso-8859-1?Q?kZb9S3G7lUAnQPhWJ/Z6msxAeuHLmc0VuVcNcdOHqaQLVwt9yMLT4u5uQw?=
 =?iso-8859-1?Q?hOM3W9TjLcZbGSzWCF/xa/52xVw84WGq1H6EcDF/2iuU23jW0fO0o0PlSa?=
 =?iso-8859-1?Q?KeAr8BjtnpWeZNwuBllLz8YXYlINKWeycuFxQFZ9pBEEjUnL6VxCGfDgN7?=
 =?iso-8859-1?Q?oijEdVaKh2Mfms9VRmFlCKcvMNFWsojJEF1tkvPQim9kTgk1LX3iHLdw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e23484-262e-4a62-61d9-08de28cb2d7b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 06:57:04.0735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uiZ6RoGzJrmr6Dg/v7ubNotzE3h6KLeVqGb4QXK4tpOL5J6IRoq0Uwh5mwybUEgYfQ54bM2FZAUE6P+roksa8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7053
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 225.6% improvement of stress-ng.loop.ops_per_sec on:


commit: 3179a5f7f86bcc3acd5d6fb2a29f891ef5615852 ("block: rate-limit capacity change info log")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master


testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: loop
	cpufreq_governor: performance



Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251121/202511211458.ef9f7202-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-icl-2sp7/loop/stress-ng/60s

commit: 
  ade260ca85 ("Documentation: admin-guide: blockdev: update zloop parameters")
  3179a5f7f8 ("block: rate-limit capacity change info log")

ade260ca858627b2 3179a5f7f86bcc3acd5d6fb2a29 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      6815           -11.6%       6023        uptime.idle
 3.679e+09           -21.3%  2.894e+09        cpuidle..time
   5053153           +85.8%    9390705        cpuidle..usage
   1843799 ±  4%    +347.6%    8253228 ±  2%  numa-numastat.node0.local_node
   1880282 ±  3%    +340.2%    8276931 ±  2%  numa-numastat.node0.numa_hit
   1907306 ±  3%    +307.6%    7774259 ±  2%  numa-numastat.node1.local_node
   1940797 ±  2%    +303.4%    7829989 ±  2%  numa-numastat.node1.numa_hit
      3409 ± 60%    +212.8%      10664 ± 28%  perf-c2c.DRAM.local
      2854 ± 79%    +170.8%       7729 ± 14%  perf-c2c.DRAM.remote
      2489 ± 53%    +185.3%       7102 ± 15%  perf-c2c.HITM.local
      1054 ± 61%    +219.9%       3371 ± 17%  perf-c2c.HITM.remote
      3543 ± 55%    +195.6%      10474 ± 15%  perf-c2c.HITM.total
     91.82           -17.7       74.07        mpstat.cpu.all.idle%
      0.31 ±  7%      +0.1        0.45 ±  3%  mpstat.cpu.all.irq%
      0.19 ±  2%      +0.5        0.65        mpstat.cpu.all.soft%
      3.63 ±  4%     +12.8       16.48        mpstat.cpu.all.sys%
      3.30 ±  2%      +3.8        7.06        mpstat.cpu.all.usr%
     20.32 ± 10%     +57.7%      32.06 ±  3%  mpstat.max_utilization_pct
      2092 ± 28%    +203.2%       6346 ± 18%  numa-meminfo.node0.Dirty
     29255 ±  8%     +15.5%      33793 ±  3%  numa-meminfo.node0.Inactive
     29255 ±  8%     +15.5%      33793 ±  3%  numa-meminfo.node0.Inactive(file)
     49790 ± 48%    +545.3%     321289 ± 12%  numa-meminfo.node0.Shmem
      2021 ± 29%    +197.7%       6019 ± 20%  numa-meminfo.node1.Dirty
     60987 ± 61%    +164.0%     161033 ± 27%  numa-meminfo.node1.Mapped
    150941 ± 30%    +173.8%     413310 ± 12%  numa-meminfo.node1.Shmem
      5593 ±  2%    +219.7%      17883        stress-ng.loop.ops
     91.38          +225.6%     297.51        stress-ng.loop.ops_per_sec
  14001676          +372.7%   66186417        stress-ng.time.file_system_inputs
  14605558          +369.4%   68565222        stress-ng.time.file_system_outputs
     15155 ±  2%    +370.7%      71341        stress-ng.time.involuntary_context_switches
    128020          +334.9%     556806        stress-ng.time.minor_page_faults
    162.33 ±  4%    +212.6%     507.50        stress-ng.time.percent_of_cpu_this_job_got
     99.38 ±  4%    +204.9%     303.06        stress-ng.time.system_time
    856635 ±  4%    +293.1%    3367479        stress-ng.time.voluntary_context_switches
      0.07 ± 28%     -78.8%       0.01 ± 11%  perf-sched.sch_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      1477 ± 20%     -80.6%     286.82 ± 88%  perf-sched.sch_delay.max.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
      0.07 ± 28%     -78.8%       0.01 ± 11%  perf-sched.total_sch_delay.average.ms
      1477 ± 20%     -80.6%     286.82 ± 88%  perf-sched.total_sch_delay.max.ms
      7.95 ± 14%     -73.5%       2.11 ±  2%  perf-sched.total_wait_and_delay.average.ms
    249384 ± 17%    +304.3%    1008252 ±  2%  perf-sched.total_wait_and_delay.count.ms
      7.88 ± 14%     -73.4%       2.09 ±  2%  perf-sched.total_wait_time.average.ms
      7.95 ± 14%     -73.5%       2.11 ±  2%  perf-sched.wait_and_delay.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    249384 ± 17%    +304.3%    1008252 ±  2%  perf-sched.wait_and_delay.count.[unknown].[unknown].[unknown].[unknown].[unknown]
      7.88 ± 14%     -73.4%       2.09 ±  2%  perf-sched.wait_time.avg.ms.[unknown].[unknown].[unknown].[unknown].[unknown]
    889964 ±  3%     +61.7%    1438659        meminfo.Active
    888600 ±  3%     +61.8%    1437484        meminfo.Active(anon)
   4009560           +13.5%    4551679        meminfo.Cached
   1750503 ±  2%     +32.1%    2313144        meminfo.Committed_AS
      3905 ± 28%    +221.6%      12559 ± 24%  meminfo.Dirty
     57102 ±  5%     +12.8%      64430 ±  3%  meminfo.Inactive
     57102 ±  5%     +12.8%      64430 ±  3%  meminfo.Inactive(file)
    122475 ±  2%     +13.4%     138912        meminfo.KReclaimable
    118852 ±  6%    +142.6%     288329 ±  3%  meminfo.Mapped
   6466538           +12.1%    7246865        meminfo.Memused
    122475 ±  2%     +13.4%     138912        meminfo.SReclaimable
    200885 ± 15%    +266.0%     735252        meminfo.Shmem
    315909           +10.4%     348749        meminfo.Slab
    293.33 ±  2%    +189.5%     849.33        turbostat.Avg_MHz
      9.65 ±  2%     +17.9       27.50        turbostat.Busy%
      3045            +1.7%       3096        turbostat.Bzy_MHz
      0.48 ±  3%      +1.5        1.98 ±  2%  turbostat.C1%
      6.84           +21.3       28.10        turbostat.C1E%
     83.38           -40.4       42.94        turbostat.C6%
     80.98           -35.2%      52.49        turbostat.CPU%c1
      1.85 ±  6%     +45.1%       2.69 ± 14%  turbostat.CPU%c6
      0.61           +10.9%       0.68        turbostat.IPC
   5413781 ±  4%     +55.3%    8409958        turbostat.IRQ
    456397 ± 20%    +125.4%    1028647 ±  4%  turbostat.NMI
     61.83 ±  3%      +8.9%      67.33 ±  2%  turbostat.PkgTmp
    153.64           +22.8%     188.66        turbostat.PkgWatt
     14.32           +12.8%      16.15        turbostat.RAMWatt
    931539 ±  3%    +382.8%    4497147 ±  2%  numa-vmstat.node0.nr_dirtied
    552.18 ± 26%    +167.8%       1478 ±  9%  numa-vmstat.node0.nr_dirty
      7350 ±  7%     +15.0%       8453 ±  5%  numa-vmstat.node0.nr_inactive_file
     12438 ± 48%    +546.8%      80450 ± 12%  numa-vmstat.node0.nr_shmem
    929996 ±  3%    +382.8%    4489616 ±  2%  numa-vmstat.node0.nr_written
      7352 ±  7%     +15.0%       8451 ±  5%  numa-vmstat.node0.nr_zone_inactive_file
    235.69 ± 27%    +173.8%     645.41 ±  8%  numa-vmstat.node0.nr_zone_write_pending
   1880195 ±  3%    +340.2%    8277267 ±  2%  numa-vmstat.node0.numa_hit
   1843713 ±  4%    +347.7%    8253564 ±  2%  numa-vmstat.node0.numa_local
    894153 ±  3%    +355.6%    4073475 ±  2%  numa-vmstat.node1.nr_dirtied
    534.65 ± 25%    +164.1%       1412 ± 10%  numa-vmstat.node1.nr_dirty
     15403 ± 61%    +163.6%      40598 ± 27%  numa-vmstat.node1.nr_mapped
     37638 ± 30%    +174.9%     103456 ± 12%  numa-vmstat.node1.nr_shmem
    892583 ±  3%    +355.6%    4066446 ±  2%  numa-vmstat.node1.nr_written
    197.36 ± 25%    +222.6%     636.75 ± 17%  numa-vmstat.node1.nr_zone_write_pending
   1940005 ±  2%    +303.6%    7829857 ±  2%  numa-vmstat.node1.numa_hit
   1906514 ±  3%    +307.8%    7774127 ±  2%  numa-vmstat.node1.numa_local
    222198 ±  3%     +61.7%     359280        proc-vmstat.nr_active_anon
    172929            +2.1%     176502        proc-vmstat.nr_anon_pages
   1825693          +369.4%    8570496        proc-vmstat.nr_dirtied
      1063 ± 27%    +184.4%       3024 ± 17%  proc-vmstat.nr_dirty
   1016709           +13.4%    1152795        proc-vmstat.nr_file_pages
     14436 ±  6%     +14.7%      16552 ±  4%  proc-vmstat.nr_inactive_file
     30007 ±  6%    +141.4%      72439 ±  3%  proc-vmstat.nr_mapped
     50207 ± 16%    +265.9%     183714        proc-vmstat.nr_shmem
     30625 ±  2%     +13.2%      34677        proc-vmstat.nr_slab_reclaimable
     48354            +8.5%      52458        proc-vmstat.nr_slab_unreclaimable
   1822579          +369.4%    8555845        proc-vmstat.nr_written
    222198 ±  3%     +61.7%     359280        proc-vmstat.nr_zone_active_anon
     14436 ±  6%     +14.7%      16552 ±  4%  proc-vmstat.nr_zone_inactive_file
    407.28 ± 29%    +212.5%       1272 ± 17%  proc-vmstat.nr_zone_write_pending
   3823893 ±  2%    +321.3%   16109059        proc-vmstat.numa_hit
   3753920 ±  2%    +327.0%   16029626        proc-vmstat.numa_local
     69973           +13.4%      79321        proc-vmstat.numa_other
   5675784          +334.1%   24637404        proc-vmstat.pgalloc_normal
   1793025 ±  2%    +291.4%    7018035 ±  2%  proc-vmstat.pgfault
   5524391          +339.2%   24262818        proc-vmstat.pgfree
    269.33 ±  8%    +403.0%       1354 ±  3%  proc-vmstat.pgmajfault
   7717613          +371.4%   36384158        proc-vmstat.pgpgin
  14575400          +369.6%   68446414        proc-vmstat.pgpgout
    227612 ±  4%    +371.1%    1072325 ±  5%  proc-vmstat.pgreuse
    198024          +306.6%     805258        proc-vmstat.unevictable_pgs_culled
     17285 ± 43%    +367.4%      80792        sched_debug.cfs_rq:/.avg_vruntime.avg
     85714 ± 33%    +124.8%     192709 ± 11%  sched_debug.cfs_rq:/.avg_vruntime.max
      7611 ± 69%    +745.7%      64365 ±  2%  sched_debug.cfs_rq:/.avg_vruntime.min
     14880 ± 26%     +49.1%      22182 ±  9%  sched_debug.cfs_rq:/.avg_vruntime.stddev
      0.17 ± 12%    +106.0%       0.36 ± 28%  sched_debug.cfs_rq:/.h_nr_queued.avg
      0.39 ±  4%     +24.8%       0.48 ±  6%  sched_debug.cfs_rq:/.h_nr_queued.stddev
      0.17 ± 12%    +104.5%       0.35 ± 28%  sched_debug.cfs_rq:/.h_nr_runnable.avg
      0.38 ±  3%     +23.8%       0.48 ±  5%  sched_debug.cfs_rq:/.h_nr_runnable.stddev
      7326 ±189%     -88.9%     812.50 ± 19%  sched_debug.cfs_rq:/.load_avg.max
      1328 ±176%     -86.2%     183.41 ± 17%  sched_debug.cfs_rq:/.load_avg.stddev
     17285 ± 43%    +367.4%      80792        sched_debug.cfs_rq:/.min_vruntime.avg
     85714 ± 33%    +124.8%     192709 ± 11%  sched_debug.cfs_rq:/.min_vruntime.max
      7611 ± 69%    +745.7%      64365 ±  2%  sched_debug.cfs_rq:/.min_vruntime.min
     14880 ± 26%     +49.1%      22182 ±  9%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.17 ± 12%    +108.2%       0.36 ± 28%  sched_debug.cfs_rq:/.nr_queued.avg
      0.39 ±  4%     +26.3%       0.49 ±  6%  sched_debug.cfs_rq:/.nr_queued.stddev
     30.11 ± 25%    +115.4%      64.84 ± 30%  sched_debug.cfs_rq:/.util_est.avg
   1221148 ± 25%     -39.9%     733630 ± 12%  sched_debug.cpu.avg_idle.avg
    811.42 ± 11%    +280.4%       3086 ± 33%  sched_debug.cpu.curr->pid.avg
      7770 ± 18%     +95.7%      15210        sched_debug.cpu.curr->pid.max
      2073 ±  5%    +147.2%       5124 ± 18%  sched_debug.cpu.curr->pid.stddev
    266390 ± 17%     +34.3%     357661 ±  3%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.17 ± 10%    +105.4%       0.35 ± 29%  sched_debug.cpu.nr_running.avg
      0.41 ±  3%     +16.9%       0.47 ±  5%  sched_debug.cpu.nr_running.stddev
     22385 ± 62%    +494.1%     132999        sched_debug.cpu.nr_switches.avg
     39219 ± 37%    +367.7%     183438 ±  3%  sched_debug.cpu.nr_switches.max
     12118 ± 71%    +530.8%      76438 ± 11%  sched_debug.cpu.nr_switches.min
      4550 ± 22%    +232.5%      15128 ±  5%  sched_debug.cpu.nr_switches.stddev
     51.00 ± 48%    +431.5%     271.08 ± 11%  sched_debug.cpu.nr_uninterruptible.max
    -53.25          +188.1%    -153.42        sched_debug.cpu.nr_uninterruptible.min
     14.06 ± 40%    +259.7%      50.56 ±  8%  sched_debug.cpu.nr_uninterruptible.stddev
      1.84 ±  2%     +14.1%       2.10        perf-stat.i.MPKI
 3.078e+09 ±  4%    +175.8%  8.488e+09        perf-stat.i.branch-instructions
      2.83 ±  6%      -1.4        1.41 ±  2%  perf-stat.i.branch-miss-rate%
  82605640 ±  4%     +46.8%  1.212e+08        perf-stat.i.branch-misses
     37.32            -1.4       35.91        perf-stat.i.cache-miss-rate%
  26611318 ±  4%    +194.8%   78450122        perf-stat.i.cache-misses
  69487762 ±  3%    +215.3%  2.191e+08        perf-stat.i.cache-references
     78925 ±  4%    +255.2%     280351        perf-stat.i.context-switches
      1.72           -12.8%       1.50        perf-stat.i.cpi
 7.328e+10 ±  2%     -12.6%  6.404e+10        perf-stat.i.cpu-clock
 2.361e+10 ±  4%    +137.4%  5.603e+10        perf-stat.i.cpu-cycles
      2398 ±  6%    +348.0%      10743 ±  2%  perf-stat.i.cpu-migrations
      1026 ±  4%     -29.5%     723.26        perf-stat.i.cycles-between-cache-misses
 1.413e+10 ±  4%    +165.2%  3.747e+10        perf-stat.i.instructions
      0.59           +13.1%       0.67        perf-stat.i.ipc
      1.31 ± 15%    +264.2%       4.77 ±  4%  perf-stat.i.major-faults
      1.03 ± 14%    +636.1%       7.60 ±  2%  perf-stat.i.metric.K/sec
     31840 ±  4%    +229.5%     104918 ±  2%  perf-stat.i.minor-faults
     31911 ±  4%    +229.7%     105198 ±  2%  perf-stat.i.page-faults
 7.328e+10 ±  2%     -12.6%  6.404e+10        perf-stat.i.task-clock
      1.20 ± 70%     +73.6%       2.09        perf-stat.overall.MPKI
      0.40 ± 70%     +68.6%       0.67        perf-stat.overall.ipc
 1.655e+09 ± 70%    +402.6%  8.316e+09        perf-stat.ps.branch-instructions
  46440825 ± 70%    +155.9%  1.188e+08        perf-stat.ps.branch-misses
  13717157 ± 70%    +459.9%   76804429        perf-stat.ps.cache-misses
  36811876 ± 70%    +482.9%  2.146e+08        perf-stat.ps.cache-references
     41963 ± 70%    +554.2%     274527        perf-stat.ps.context-switches
 1.276e+10 ± 70%    +330.4%  5.493e+10        perf-stat.ps.cpu-cycles
      1258 ± 71%    +736.4%      10528 ±  2%  perf-stat.ps.cpu-migrations
 7.588e+09 ± 70%    +383.9%  3.672e+10        perf-stat.ps.instructions
      0.64 ± 71%    +633.4%       4.67 ±  4%  perf-stat.ps.major-faults
     16670 ± 70%    +516.2%     102729 ±  2%  perf-stat.ps.minor-faults
     16708 ± 70%    +516.5%     103002 ±  2%  perf-stat.ps.page-faults
 4.726e+11 ± 70%    +375.9%  2.249e+12        perf-stat.total.instructions




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

