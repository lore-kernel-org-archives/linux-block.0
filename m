Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B251CF9B;
	Sun, 29 Sep 2024 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727615857; cv=fail; b=T5Cavr0yQxD9YroadhAbjZaKniQY3LvaHTTpltV0KDWn1nmGbwTX1ZR2oBhKfY8jg5cINog8jQ5ILjWpZGrYn78FCh6qDAMEoaCbI4b6GKdvFmTtGS0AJPzXt6znEj0YoPjmECXZVLS6jW0Fqb9UGal8CAANWu9FpbD9z7IztG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727615857; c=relaxed/simple;
	bh=hMqBXU96/pRMqevqmf/aqJ5FgUsRCTWGGvR3N5KjqH0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=q9etZiHzkfi70BV/4dwKuNgZf17M6i4guMDe22PEdPN6tyy0yJCTfwLb8hNbAAZTyLInWMv36+lhOW/68Ud7l43ZNFrZE0W9HQ/sSolQZULHJ+vHGPxCKjUv1GU8kXF20Krvw48WrgiZpQB2MA6282vF7IYQ8Td9TMdpnLnHTBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ge+MfTdr; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ge+MfTdr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727615853; x=1759151853;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=hMqBXU96/pRMqevqmf/aqJ5FgUsRCTWGGvR3N5KjqH0=;
  b=Ge+MfTdr3druTIpXJ3rj8rOnY7OqhmRWUaN4vnxwBMfV4BwIOuaVxvLs
   HWfTRRlLmgJdmxaVbZ1Qv/s5Wdkdd0rhsrVLcdB4EyfRmlkz6Ko1SYWd6
   9nm93m8jZi5Sjyoy6XCcxCWDljXW8GKLklFTK16PWXRq/D+gcJACVe66e
   c50AcUtN+KpL8s7/NaoZnPIR+8yGycF0OgeEfPxDmUU+sv742+dsWbleW
   0U3VZTze6J7bUGKi1eTqRj2MIJLThEGKFH626vDKZbbTHrxUMt5F0FiA+
   q4djNxcEid4saqSCGO7c6SZw/7Ex82QT0W8ANza1o9yXCbzCJ+YE+r3sv
   Q==;
X-CSE-ConnectionGUID: Nq5kE07lTCWdlM+HeW4ilQ==
X-CSE-MsgGUID: C69nsGU3RQu/conVgs0XFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11209"; a="29589204"
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="29589204"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2024 06:17:32 -0700
X-CSE-ConnectionGUID: +hJBBr7tTSadXNrz+Jm+Gg==
X-CSE-MsgGUID: qFIRzoNyRzygutdg9pGukw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,163,1725346800"; 
   d="scan'208";a="72893922"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2024 06:17:32 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 06:17:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 29 Sep 2024 06:17:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 29 Sep 2024 06:17:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 06:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgstyaRrS95+YKg/MQ3h7l9mpV3Ry84/g5Pz8CI3nzZxLY6d9I+D25X0ynBO0bw/hmFqMbONvlZqCxaxFkqjQsQnXgyMcIa65ifb0zjOZoamSvBsiPgeXum0k4aIvV3WuK1qhG1uYFNfG5BIj9AwdevROKrFJrrLmTm3xIuQGO+K5R6JIx0XLGao33A7sCVY13V0W4el4a38lXfMv2vVr7zdYqxOrmMxeFRG7gXTAdbZZwv5JrfmFN0TSl7Ap163ZM/u0nVaubBtIox284+AS/elbUM1ha6+g8iqwduY4t4WbISpLBfWAZEfDdubyl9fLa7OMP2LbreTWdBz0OLqfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sirsD75LLdRl5/j0k9gaM+pQPtTTa/oBX2pIq74Wyok=;
 b=pBiCrIiSi9UWEK3M58vyMwVjs/GCb1jBJSjFonOUwD4nnMjG8/bfzsLII+IRFYTOHFlbZuVVTuiGmeFci5Mp53de5BfkQGz6SqLfu/r4X47NtzBzLPEkQp94cIg6NccpMzuaJWzPvp1yR8HcBgk8CCBDB51x5xgOydrAlSOerur7cfbBix8oM0VLO83wtkOuzIWYKLv9l0TAOHsnSSDDXl43nlUEbgU4BcWJJnPcRnYYDmF9aMP5UjwW3HNr2QrM1oTCf6aZjpYdVvlxVREXRuSlJpbAHPN19iYfF+MHK8iNgUNORFax5CFkYUL2gTaH/jQmBM2lEMKpR+eltqNOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS7PR11MB6152.namprd11.prod.outlook.com (2603:10b6:8:9b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.25; Sun, 29 Sep 2024 13:17:27 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8005.024; Sun, 29 Sep 2024
 13:17:26 +0000
Date: Sun, 29 Sep 2024 21:17:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Kuai <yukuai3@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  060406c61c:  stress-ng.fsize.ops_per_sec
 -35.5% regression
Message-ID: <202409291630.6349557c-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0112.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::16) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS7PR11MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2e18f6-1129-45a2-97d6-08dce0890ff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?SruMTt8gnVViu5TzZ+Gp3SF4q4XsA9vkgzltG2HYdQd/R1mENTzmka/+KD?=
 =?iso-8859-1?Q?+BCYVvqCVit+XEvOE2pW3mkbnusGYYvMtM/zBDuQxIcJN8iXEDGOW8Wg9x?=
 =?iso-8859-1?Q?Uwb6rTgvo+CzZhTm/NTwWBzwjYAPUsUt9CcC0TAq1qJ1A4PO4oKW607Jzh?=
 =?iso-8859-1?Q?kzwS8Nwcw7TN6d9RD02oiik/EzTjHCHCl3CE9Gy9Vq1Ewiu5+x2o6P9Xpe?=
 =?iso-8859-1?Q?gUzCt2OQhrT8bBsEEq0HSsHL6cEdpZUDKGeeuJv8VKaKmzZm6nWJLXiB0O?=
 =?iso-8859-1?Q?xSHnK9MvDQNC96haYAPBqwEc6IkKEkE5mJ44yM6crNLK7TtsuLQFvMNl0C?=
 =?iso-8859-1?Q?B8XPm2nvkHKtKwPk7w67QkPOlOI3UWmzLLPEeDSOOgFM5ZmnvlwFq4MBgv?=
 =?iso-8859-1?Q?f8C8UcM+f1K+2G96YA7M46jpEJi1GgtHb1MubgF5tbsegqvePDNrDVfVyO?=
 =?iso-8859-1?Q?pg9OjVzzpkbvDIaLi9Mum4PoQ80jXtP0/jyYyb/1Dra+LXsvcWLX8VesmG?=
 =?iso-8859-1?Q?sjhDFuu+y5ArQIbxjoWcPz1PNDWUwLMOYzVVyFtm1C3q+6jD35Uaxsbv90?=
 =?iso-8859-1?Q?J6YjNSD50WoHda0ebtEmxSmdEfy5mlle1Hnnx+Hk2uh2YCFjjwn0TH5Dkd?=
 =?iso-8859-1?Q?nBZK0ZCnTx6xRdPZZvUzcQewYBA0VvKiyqO0tEEMblIcU0f/nyAjANvgiM?=
 =?iso-8859-1?Q?T4WC88Yq1UQ8KgIw8KAlK+fbSw4Ik03Zw7cYNBcCQwpBG/JdC6B55wgnIV?=
 =?iso-8859-1?Q?AOY55HDqILcrehzX/azsIc3Dzi+rg4bvYGqw37xPcrp73i6GR+BdA2UFnf?=
 =?iso-8859-1?Q?WawlrLxI/OOCRV8OZCStbNsbzfMdpqa4OhDIJEaBSdQbPqbi60SswlSzn5?=
 =?iso-8859-1?Q?sgZy0uvW9Te29A16DU+wL0pY4Bs4MCGgAEPhvRFKaLhtN1gHyRzjOblMJ1?=
 =?iso-8859-1?Q?E39wm4s5FEGqSV3WBLbrIiAAcugLKQNz5JJ1suDhWGd0KgGutTuBptaESE?=
 =?iso-8859-1?Q?uZF5TvzKWu1yoSdioQ47pCGlHNKrBNdyWm33bxkko07pvtWPOVJbgiqu+v?=
 =?iso-8859-1?Q?rJTGgCPEYGWl3cv0OQon8FjLMeM9uYI7wGIV35H9csCGygNbu4eu3rKLQK?=
 =?iso-8859-1?Q?kKyK9qd3GLsghq+uLl6wkiCY9VcjeUp219NHV+JDpCNwiuec5QuyekeuUk?=
 =?iso-8859-1?Q?+/Gwut/sUMbFR8wcGBujKF4foXCX4tEq32xyY9f4RSXuCRIysFx4Ay6z8i?=
 =?iso-8859-1?Q?2LHaWqcjc3YWX/NqSnhYOVjim3u2QcyZvZGXWioOEHx+xf/2/gi4BbObFH?=
 =?iso-8859-1?Q?oUQXglc3LXeYOH8Etmiqm7GnSULdjO29n0c5plbZBq5sTTOjip0XFSDw33?=
 =?iso-8859-1?Q?CWDmrhHKbpUtJ+svB/ZAmfH98sr+y4z+t4lyaa3iDPkk7xWgJBeHE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zLCgaX6kfAjHrNMEx4aGHbpfOz1g2uurFaj/JOyjXDgWcUSfVeqhuvq6NT?=
 =?iso-8859-1?Q?vu0DwYC8Wrp9PRUBD/Lbw3HlKuMZ7fIe+r45IBQNucfUGMKebA8hdgV7t0?=
 =?iso-8859-1?Q?G575YH/0qmKia73YFlllZz1DP5Pw0KgkorHNyLO6PsHK3UUE2+L/dje/VK?=
 =?iso-8859-1?Q?mmmAVi5WGna0+Wsn2PrrgUoMxrlAiCegJBt652sy4QYgDKCBm3HdDGYv/P?=
 =?iso-8859-1?Q?+3jvtiRa/7cr3zd/a0DZ9g1cpeSa5swTYdbLZuBL+fptTuvsjDi/Lj4uCl?=
 =?iso-8859-1?Q?Q+lIsjS9YcwrvQeS5p2rCSnHxIqByZTUt8nctsZtSHXhbqAuD8VnGRC/vs?=
 =?iso-8859-1?Q?pRgNmjlEptHyUCHEm2+QFyosMTHKRYDzs9oeNuIQJoFMCfBMOZL50l2GGP?=
 =?iso-8859-1?Q?0gyF/fleVHSx9qIPx7W1jNdo/FzwAkjxyQOJPW8NS5XJZXWJfMGCUZev3v?=
 =?iso-8859-1?Q?wwhsmyNDId9qX+aI5eMv5SovzR8jvk1GXWfynOFxX4cqs6adHH2hNsCBHB?=
 =?iso-8859-1?Q?XS0AmQf9vm+lM/1kE7JmUlLLxCBEl4V897DkmfvPRQugfft/VHevcWR+ki?=
 =?iso-8859-1?Q?06XMKpW1419TE9rXvfD8h8tmNjwvREH9fsr1B0n++5/bwcY3Rb/kpiE0lT?=
 =?iso-8859-1?Q?TYECzjT0sdkRA7kJE4E4lzLHYsXhkz+jlkRCOaLm3vI5akvwJAIv1B5Y2C?=
 =?iso-8859-1?Q?koVfnkOAo+OIFDQ1DsfFf3pkogxJh3EkPsqw6UuaR/9HL2Kh7KiSQauyYD?=
 =?iso-8859-1?Q?55Ixvt70CMKyrZz4ILTY07zVJY0m7tGdUhzF8pFbB4+yV8shyMTQsP24i6?=
 =?iso-8859-1?Q?SsYUi3ii8nmvWDeh84XiVhENO2X8HNdfkmgdw1nxzIbFaSMHC8CnHQGNka?=
 =?iso-8859-1?Q?IOr/nGAdr+l2+CVqdZvvAT548hie1MW/n1oZf/PqkgEBXxewHOQvtzPIwq?=
 =?iso-8859-1?Q?Jr+IjlqnlrFrkQigLJF1VQg0TQJbWfuFSOc3raiLqUyVLQog3XA2DyjVP6?=
 =?iso-8859-1?Q?kYsA+sOsZR7kNOy+xEUOZXlHXnj0ufRfQGMGzGtnBqpaffVSqs87bVFa/l?=
 =?iso-8859-1?Q?OKYnV+vLxV5+cGhF6xXVg+D6QH9WER5FpQAy8g54RBuSUwm1L2fhA/M2A2?=
 =?iso-8859-1?Q?ouMUxlmwHRYjlMvwH0/0z5gXohw+dQprIuq7zR6s/znDXWQTKIeWJ48eP/?=
 =?iso-8859-1?Q?F3hoSGyOC7dWVZ82wv55BlUGFWUSBlM5QyTU6ojOdFJQGB7Xdt6PCXCVxQ?=
 =?iso-8859-1?Q?zS43KR+Xli+2WceFGa/CxQDJi3gzIJx2m8lMNr4l1AgSz5avPAQWSZcgAu?=
 =?iso-8859-1?Q?JRcPLhMKVpd8ndGSJpjIp3WNaPI/LL5NQF5jiTVpyFKQLWp2+jdqy/7oCR?=
 =?iso-8859-1?Q?k8dQHeEN1KstWUtK+xz6a8qyUD07dASVZF3ddsbrXVQMcDNKVsrpjQ3hUL?=
 =?iso-8859-1?Q?BPhJRwZPX0h1o7g3IjIYBWIqbwPPiyoPJ41FdFxlpNlr8J2ITZRGnl15Pw?=
 =?iso-8859-1?Q?0I4dbtumxGH0+aOU/PuFHPHNIbgxG0/jpRD49jwdF4ei9IaQHU7ypNTSE7?=
 =?iso-8859-1?Q?ZNOsUTe0SmMPui+dUJSiiTJszjpVDLWEGA3zdb8aFrV5elDLRlhIOm70rQ?=
 =?iso-8859-1?Q?luHeDQjrIVfMN8TSVeNbkKW7Cb3Tocfh/XjodGPTHTwTU9PbWGN02ylg?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2e18f6-1129-45a2-97d6-08dce0890ff9
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2024 13:17:26.9032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TG0sniMoZJzFKVlun0ucV0kQ/YtoVmonYXjvBfK6eWu+u1djVmG5fQEI/LYEUMZBqh4UZY7V9d0tpttgt1AW5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6152
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -35.5% regression of stress-ng.fsize.ops_per_sec on:


commit: 060406c61c7cb4bbd82a02d179decca9c9bb3443 ("block: add plug while submitting IO")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	nr_threads: 100%
	disk: 1HDD
	testtime: 60s
	fs: btrfs
	test: fsize
	cpufreq_governor: performance


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409291630.6349557c-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240929/202409291630.6349557c-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/fs/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-12/performance/1HDD/btrfs/x86_64-rhel-8.3/100%/debian-12-x86_64-20240206.cgz/lkp-icl-2sp8/fsize/stress-ng/60s

commit: 
  3a861560cc ("bcache: fix variable length array abuse in btree_iter")
  060406c61c ("block: add plug while submitting IO")

3a861560ccb35f2a 060406c61c7cb4bbd82a02d179d 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
   7909237 ±  6%     -59.6%    3196373 ±  4%  cpuidle..usage
     28.40 ±  3%     -22.3%      22.08 ±  5%  iostat.cpu.idle
     66.36           +14.2%      75.76        iostat.cpu.iowait
      4.54 ±  6%     -66.6%       1.52 ±  5%  iostat.cpu.system
   1022197 ±  6%     -38.5%     628431 ±  8%  numa-numastat.node0.local_node
   1046793 ±  6%     -37.0%     659240 ±  6%  numa-numastat.node0.numa_hit
   1104623 ±  9%     -25.9%     818587 ±  5%  numa-numastat.node1.local_node
   1146240 ±  8%     -25.5%     854021 ±  4%  numa-numastat.node1.numa_hit
    194.55 ± 17%     -74.9%      48.75 ± 19%  perf-c2c.DRAM.local
      3911 ± 18%     -77.7%     871.95 ± 20%  perf-c2c.DRAM.remote
      4283 ± 17%     -77.0%     985.10 ± 20%  perf-c2c.HITM.local
      2454 ± 18%     -78.7%     523.95 ± 22%  perf-c2c.HITM.remote
      6737 ± 17%     -77.6%       1509 ± 21%  perf-c2c.HITM.total
     26.36 ±  4%      -6.5       19.82 ±  5%  mpstat.cpu.all.idle%
     68.31 ±  2%      +9.7       78.01        mpstat.cpu.all.iowait%
      0.25 ±  6%      -0.1        0.11 ±  5%  mpstat.cpu.all.irq%
      0.09 ±  6%      -0.0        0.06 ±  5%  mpstat.cpu.all.soft%
      4.29 ±  5%      -2.9        1.36 ±  5%  mpstat.cpu.all.sys%
      8.59 ±  5%     -29.5%       6.06 ± 12%  mpstat.max_utilization_pct
     22077 ±  9%     -72.5%       6064 ± 17%  numa-meminfo.node0.Active(file)
      2223 ±  8%     -59.6%     899.21 ±  7%  numa-meminfo.node0.Dirty
      1649 ± 15%     -55.5%     733.54 ± 40%  numa-meminfo.node0.Inactive(file)
     21784 ± 10%     -64.0%       7832 ± 11%  numa-meminfo.node1.Active(file)
      2289 ± 10%     -48.1%       1187 ±  5%  numa-meminfo.node1.Dirty
      1613 ± 22%     -40.2%     964.38 ± 22%  numa-meminfo.node1.Inactive(file)
     28.39 ±  4%     -22.3%      22.05 ±  5%  vmstat.cpu.id
     66.40 ±  2%     +14.2%      75.80        vmstat.cpu.wa
     21851 ±  7%     -35.4%      14107 ±  5%  vmstat.io.bo
     50.14 ±  3%     +15.9%      58.11 ±  2%  vmstat.procs.b
      4.10 ± 12%     -35.9%       2.63 ± 12%  vmstat.procs.r
    213093 ±  7%     -67.6%      69078 ±  6%  vmstat.system.cs
    133482 ±  6%     -62.3%      50302 ±  5%  vmstat.system.in
    416724 ± 14%     -51.3%     202829 ± 18%  meminfo.Active
    372860 ± 15%     -49.3%     188943 ± 20%  meminfo.Active(anon)
     43864 ±  9%     -68.3%      13886 ± 11%  meminfo.Active(file)
   1795387 ±  3%     -11.7%    1585482 ±  2%  meminfo.Committed_AS
      4573 ±  9%     -55.6%       2031 ±  7%  meminfo.Dirty
      3281 ± 12%     -49.4%       1659 ± 24%  meminfo.Inactive(file)
    148391 ±  4%     -15.1%     125998 ±  4%  meminfo.Mapped
    246114 ±  2%     -11.6%     217627        meminfo.SUnreclaim
    485886 ± 13%     -42.8%     277851 ± 15%  meminfo.Shmem
    540.85 ±  7%     -34.8%     352.72 ±  4%  stress-ng.fsize.SIGXFSZ_signals_per_sec
     32494 ±  7%     -34.8%      21200 ±  4%  stress-ng.fsize.ops
    521.76 ±  7%     -35.5%     336.42 ±  5%  stress-ng.fsize.ops_per_sec
  16027284 ±  7%     -35.2%   10384417 ±  4%  stress-ng.time.file_system_outputs
     23832 ±  7%     -96.6%     810.05 ±  6%  stress-ng.time.involuntary_context_switches
     26536            -4.8%      25253        stress-ng.time.minor_page_faults
    247.35 ±  5%     -71.6%      70.20 ±  7%  stress-ng.time.percent_of_cpu_this_job_got
    154.18 ±  6%     -71.1%      44.50 ±  7%  stress-ng.time.system_time
   6257391 ±  7%     -69.4%    1916392 ±  6%  stress-ng.time.voluntary_context_switches
     11399 ±  6%     -50.0%       5694 ± 13%  sched_debug.cfs_rq:/.avg_vruntime.avg
      6820 ±  9%     -80.9%       1304 ± 35%  sched_debug.cfs_rq:/.avg_vruntime.min
     11399 ±  6%     -50.0%       5694 ± 13%  sched_debug.cfs_rq:/.min_vruntime.avg
      6820 ±  9%     -80.9%       1304 ± 35%  sched_debug.cfs_rq:/.min_vruntime.min
    109247 ±  7%     -70.7%      31959 ± 39%  sched_debug.cpu.nr_switches.avg
    125005 ±  7%     -61.4%      48232 ± 37%  sched_debug.cpu.nr_switches.max
     99101 ±  8%     -79.6%      20185 ± 42%  sched_debug.cpu.nr_switches.min
     49.78 ± 20%     -57.5%      21.18 ± 22%  sched_debug.cpu.nr_uninterruptible.max
   -180.02           -81.0%     -34.15        sched_debug.cpu.nr_uninterruptible.min
     27.21 ± 16%     -70.5%       8.04 ± 19%  sched_debug.cpu.nr_uninterruptible.stddev
      2.27           -22.0%       1.77        perf-stat.i.MPKI
  1.61e+09 ±  4%     -36.8%  1.017e+09 ±  3%  perf-stat.i.branch-instructions
  36025024 ±  3%     -15.5%   30425863 ±  3%  perf-stat.i.branch-misses
     28.01            -1.2       26.79        perf-stat.i.cache-miss-rate%
  16834441 ±  6%     -56.7%    7294543 ±  4%  perf-stat.i.cache-misses
  60441238 ±  6%     -54.4%   27534915 ±  4%  perf-stat.i.cache-references
    223470 ±  6%     -67.6%      72307 ±  6%  perf-stat.i.context-switches
      1.99           -31.0%       1.38        perf-stat.i.cpi
 1.488e+10 ±  5%     -58.0%  6.251e+09 ±  4%  perf-stat.i.cpu-cycles
      2870 ±  6%     -75.9%     691.51 ±  6%  perf-stat.i.cpu-migrations
    899.75 ±  2%      -5.7%     848.25 ±  2%  perf-stat.i.cycles-between-cache-misses
 8.223e+09 ±  4%     -36.8%  5.199e+09 ±  3%  perf-stat.i.instructions
      0.59 ±  4%     +40.0%       0.83 ±  2%  perf-stat.i.ipc
      3.48 ±  6%     -77.8%       0.77 ± 13%  perf-stat.i.metric.K/sec
      4385 ±  2%      -9.5%       3967 ±  5%  perf-stat.i.minor-faults
      4385 ±  2%      -9.5%       3967 ±  5%  perf-stat.i.page-faults
      5522 ±  9%     -72.5%       1517 ± 17%  numa-vmstat.node0.nr_active_file
    994146 ±  7%     -43.8%     558616 ±  4%  numa-vmstat.node0.nr_dirtied
    565.28 ± 10%     -58.5%     234.84 ± 13%  numa-vmstat.node0.nr_dirty
    420.09 ± 16%     -54.2%     192.41 ± 39%  numa-vmstat.node0.nr_inactive_file
    179135 ±  7%     -43.1%     101948 ±  4%  numa-vmstat.node0.nr_written
      5522 ±  9%     -72.5%       1517 ± 17%  numa-vmstat.node0.nr_zone_active_file
    420.08 ± 16%     -54.2%     192.42 ± 39%  numa-vmstat.node0.nr_zone_inactive_file
    569.36 ± 10%     -57.7%     240.72 ± 12%  numa-vmstat.node0.nr_zone_write_pending
   1046337 ±  6%     -37.0%     658879 ±  6%  numa-vmstat.node0.numa_hit
   1021741 ±  6%     -38.5%     628070 ±  8%  numa-vmstat.node0.numa_local
      5449 ± 10%     -64.0%       1959 ± 11%  numa-vmstat.node1.nr_active_file
   1010750 ±  7%     -26.7%     740803 ±  5%  numa-vmstat.node1.nr_dirtied
    577.63 ± 11%     -45.7%     313.44 ±  9%  numa-vmstat.node1.nr_dirty
    409.28 ± 23%     -38.2%     253.06 ± 22%  numa-vmstat.node1.nr_inactive_file
    181651 ±  7%     -25.9%     134558 ±  5%  numa-vmstat.node1.nr_written
      5449 ± 10%     -64.0%       1959 ± 11%  numa-vmstat.node1.nr_zone_active_file
    409.17 ± 23%     -38.2%     253.00 ± 22%  numa-vmstat.node1.nr_zone_inactive_file
    590.94 ± 10%     -41.7%     344.41 ±  8%  numa-vmstat.node1.nr_zone_write_pending
   1145362 ±  8%     -25.5%     852902 ±  4%  numa-vmstat.node1.numa_hit
   1103725 ±  9%     -25.9%     817468 ±  5%  numa-vmstat.node1.numa_local
      4.19 ±213%     -97.4%       0.11 ± 53%  perf-sched.sch_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      3.12 ± 17%     +76.6%       5.51 ± 29%  perf-sched.total_wait_and_delay.average.ms
    511395 ± 16%     -50.9%     251257 ± 22%  perf-sched.total_wait_and_delay.count.ms
      3.12 ± 17%     +76.7%       5.51 ± 29%  perf-sched.total_wait_time.average.ms
      5.05 ± 25%    +169.9%      13.62 ± 24%  perf-sched.wait_and_delay.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.88 ± 53%     -54.7%       0.40 ± 40%  perf-sched.wait_and_delay.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     75.15 ± 19%    +113.1%     160.12 ± 39%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.25 ±  9%     -37.4%       0.16 ± 16%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    485.10 ±  4%     +13.0%     548.28 ±  2%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
      3301 ± 20%     -99.6%      12.35 ± 72%  perf-sched.wait_and_delay.count.__cond_resched.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
    225.40 ± 16%     -51.6%     109.15 ± 23%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
    281992 ± 16%     -53.6%     130831 ± 24%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
    114220 ± 15%     -58.0%      48021 ± 26%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    925.35 ± 11%     -26.1%     684.05 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     40641 ± 18%     -55.5%      18088 ± 17%  perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    302.81 ± 29%    +545.4%       1954 ± 39%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      0.22 ± 29%     -61.6%       0.08 ± 61%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.btrfs_insert_replace_extent
      5.04 ± 25%    +170.2%      13.61 ± 24%  perf-sched.wait_time.avg.ms.io_schedule.folio_wait_bit_common.folio_wait_writeback.__filemap_fdatawait_range
      0.87 ± 53%     -55.0%       0.39 ± 40%  perf-sched.wait_time.avg.ms.io_schedule.rq_qos_wait.wbt_wait.__rq_qos_throttle
     75.14 ± 19%    +113.1%     160.12 ± 39%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      0.24 ±  9%     -37.9%       0.15 ± 16%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
    485.07 ±  4%     +13.0%     548.25 ±  2%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
    302.81 ± 29%    +545.4%       1954 ± 39%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
     93139 ± 15%     -49.3%      47219 ± 20%  proc-vmstat.nr_active_anon
     10958 ±  9%     -68.3%       3475 ± 11%  proc-vmstat.nr_active_file
   2004895 ±  7%     -35.2%    1299420 ±  4%  proc-vmstat.nr_dirtied
      1101 ±  7%     -52.5%     523.60 ±  5%  proc-vmstat.nr_dirty
    929837            -6.5%     869756        proc-vmstat.nr_file_pages
    221795            -2.8%     215477        proc-vmstat.nr_inactive_anon
    799.22 ± 12%     -46.6%     426.74 ± 23%  proc-vmstat.nr_inactive_file
     37391 ±  4%     -15.3%      31683 ±  4%  proc-vmstat.nr_mapped
    121488 ± 13%     -42.8%      69453 ± 15%  proc-vmstat.nr_shmem
     25543            -1.8%      25073        proc-vmstat.nr_slab_reclaimable
     61545 ±  2%     -11.6%      54414        proc-vmstat.nr_slab_unreclaimable
    360748 ±  7%     -34.4%     236480 ±  4%  proc-vmstat.nr_written
     93139 ± 15%     -49.3%      47219 ± 20%  proc-vmstat.nr_zone_active_anon
     10958 ±  9%     -68.3%       3475 ± 11%  proc-vmstat.nr_zone_active_file
    221795            -2.8%     215477        proc-vmstat.nr_zone_inactive_anon
    799.15 ± 12%     -46.6%     426.74 ± 23%  proc-vmstat.nr_zone_inactive_file
      1118 ±  7%     -50.0%     559.35 ±  6%  proc-vmstat.nr_zone_write_pending
      3704 ± 49%     -57.5%       1573 ± 43%  proc-vmstat.numa_hint_faults_local
   2195024 ±  6%     -31.0%    1515401 ±  3%  proc-vmstat.numa_hit
   2128811 ±  6%     -31.9%    1449157 ±  3%  proc-vmstat.numa_local
     30180 ± 29%     -71.9%       8476 ± 85%  proc-vmstat.numa_pages_migrated
    172120 ± 23%     -47.2%      90806 ± 43%  proc-vmstat.numa_pte_updates
    185833 ± 11%     -44.4%     103362 ± 13%  proc-vmstat.pgactivate
   2459022 ±  5%     -30.5%    1709740 ±  3%  proc-vmstat.pgalloc_normal
    347722            -6.6%     324729 ±  3%  proc-vmstat.pgfault
   2277846 ±  5%     -28.2%    1635091 ±  3%  proc-vmstat.pgfree
     30180 ± 29%     -71.9%       8476 ± 85%  proc-vmstat.pgmigrate_success
   1443662 ±  7%     -34.4%     946618 ±  4%  proc-vmstat.pgpgout
     39.49 ±  2%     -20.3       19.21 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate
     39.63 ±  2%     -20.2       19.43 ± 15%  perf-profile.calltrace.cycles-pp.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate
     28.28 ±  4%     -19.4        8.92 ± 27%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents.insert_prealloc_file_extent
     41.91 ±  2%     -19.2       22.69 ± 12%  perf-profile.calltrace.cycles-pp.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate
     41.92 ±  2%     -19.2       22.71 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
     30.70 ±  4%     -18.0       12.67 ± 18%  perf-profile.calltrace.cycles-pp.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range
     24.82 ±  8%     -17.7        7.13 ± 33%  perf-profile.calltrace.cycles-pp.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot
     32.18 ±  3%     -16.8       15.39 ± 17%  perf-profile.calltrace.cycles-pp.btrfs_insert_replace_extent.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
     66.38           -15.5       50.90 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe
     66.47           -15.4       51.07 ±  4%  perf-profile.calltrace.cycles-pp.vfs_fallocate.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     66.52           -15.4       51.15 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_fallocate.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     21.60 ±  7%     -15.3        6.30 ± 33%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
     21.46 ±  7%     -15.2        6.26 ± 34%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent
     21.45 ±  7%     -15.2        6.25 ± 34%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_insert_empty_items
     67.30           -14.7       52.63 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
     67.30           -14.7       52.64 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fallocate64
     67.62           -14.6       53.02 ±  3%  perf-profile.calltrace.cycles-pp.fallocate64
     20.21 ± 11%     -13.7        6.54 ± 31%  perf-profile.calltrace.cycles-pp.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock.btrfs_lock_root_node
     17.50 ± 12%     -13.6        3.92 ± 47%  perf-profile.calltrace.cycles-pp.osq_lock.rwsem_optimistic_spin.rwsem_down_write_slowpath.down_write.__btrfs_tree_lock
      9.08 ± 14%      -8.8        0.26 ±233%  perf-profile.calltrace.cycles-pp.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot
      8.74 ±  3%      -7.6        1.16 ± 63%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio.submit_one_bio
      7.51 ±  3%      -7.5        0.00        perf-profile.calltrace.cycles-pp.kblockd_mod_delayed_work_on.blk_mq_submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio
      7.51 ±  3%      -7.5        0.00        perf-profile.calltrace.cycles-pp.mod_delayed_work_on.kblockd_mod_delayed_work_on.blk_mq_submit_bio.submit_bio_noacct_nocheck.btrfs_submit_chunk
      7.14 ±  3%      -7.1        0.00        perf-profile.calltrace.cycles-pp.try_to_grab_pending.mod_delayed_work_on.kblockd_mod_delayed_work_on.blk_mq_submit_bio.submit_bio_noacct_nocheck
      6.47 ±  4%      -6.5        0.00        perf-profile.calltrace.cycles-pp._raw_spin_lock.try_to_grab_pending.mod_delayed_work_on.kblockd_mod_delayed_work_on.blk_mq_submit_bio
      6.23 ±  4%      -6.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.try_to_grab_pending.mod_delayed_work_on.kblockd_mod_delayed_work_on
      6.16 ± 17%      -6.1        0.03 ±435%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node
      6.44 ± 12%      -6.0        0.48 ±145%  perf-profile.calltrace.cycles-pp.down_read.__btrfs_tree_read_lock.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent
      5.87 ± 17%      -5.9        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.rwsem_down_read_slowpath.down_read.__btrfs_tree_read_lock
      6.20 ±  6%      -3.9        2.30 ± 15%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      5.53 ±  7%      -3.9        1.68 ± 20%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_drop_extents.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range
      5.52 ±  7%      -3.8        1.67 ± 20%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.btrfs_replace_file_extents.insert_prealloc_file_extent
      4.75 ±  5%      -3.2        1.50 ± 20%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_fallocate.vfs_fallocate
      4.75 ±  5%      -3.2        1.52 ± 20%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate
      5.43 ±  5%      -3.2        2.23 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      3.38 ± 13%      -2.7        0.67 ± 41%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.btrfs_replace_file_extents
      2.72 ± 12%      -2.3        0.39 ± 85%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_fallocate
      2.45 ± 12%      -1.5        0.94 ± 13%  perf-profile.calltrace.cycles-pp.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent
      2.43 ± 12%      -1.5        0.93 ± 13%  perf-profile.calltrace.cycles-pp.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents
      2.43 ± 12%      -1.5        0.93 ± 13%  perf-profile.calltrace.cycles-pp.down_write.__btrfs_tree_lock.btrfs_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent
      2.82 ± 10%      -1.5        1.35 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
      2.83 ± 10%      -1.5        1.35 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      2.85 ±  6%      -1.1        1.73 ± 12%  perf-profile.calltrace.cycles-pp.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_cont_expand.btrfs_fallocate
      2.86 ±  6%      -1.1        1.74 ± 11%  perf-profile.calltrace.cycles-pp.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate
      3.43 ±  4%      -1.0        2.40 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_get_extent.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate
      1.10 ±  3%      -0.8        0.29 ±101%  perf-profile.calltrace.cycles-pp.btrfs_unlock_up_safe.btrfs_search_slot.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      2.83 ±  4%      -0.8        2.06 ±  5%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      2.70 ±  3%      -0.8        1.95 ±  5%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      2.13 ±  6%      -0.6        1.50 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_truncate_inode_items.btrfs_truncate.btrfs_setsize.btrfs_setattr.notify_change
      2.09 ±  4%      -0.6        1.46 ±  6%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      1.66 ±  4%      -0.5        1.15 ±  6%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      2.33 ±  6%      -0.5        1.85 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_truncate.btrfs_setsize.btrfs_setattr.notify_change.do_truncate
      3.86 ±  7%      -0.5        3.38 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper.process_one_work
      1.19 ±  4%      -0.4        0.78 ±  7%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      1.14 ±  3%      -0.4        0.74 ±  8%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      1.03 ±  7%      -0.4        0.64 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_read_lock_root_node.btrfs_search_slot.btrfs_lookup_file_extent.btrfs_get_extent.btrfs_cont_expand
      1.01 ±  3%      -0.4        0.63 ± 23%  perf-profile.calltrace.cycles-pp.enqueue_entity.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending
      1.25 ±  4%      -0.3        0.98 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
      1.24 ±  4%      -0.3        0.97 ±  6%  perf-profile.calltrace.cycles-pp.tick_nohz_stop_tick.tick_nohz_idle_stop_tick.cpuidle_idle_call.do_idle.cpu_startup_entry
      0.34 ± 73%      +0.2        0.59 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_get_token_32.setup_items_for_insert.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.77 ±  9%      +0.3        1.04 ±  5%  perf-profile.calltrace.cycles-pp.start_transaction.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range.btrfs_prealloc_file_range
      0.52 ± 23%      +0.4        0.88 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_invalidate_folio.truncate_cleanup_folio.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize
      0.59 ±  5%      +0.4        0.98 ±  6%  perf-profile.calltrace.cycles-pp.truncate_cleanup_folio.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize.btrfs_setattr
      0.50 ± 23%      +0.4        0.93 ±  9%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel
      0.50 ± 23%      +0.4        0.93 ±  9%  perf-profile.calltrace.cycles-pp.rest_init.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.50 ± 23%      +0.4        0.93 ±  9%  perf-profile.calltrace.cycles-pp.start_kernel.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.50 ± 23%      +0.4        0.93 ±  9%  perf-profile.calltrace.cycles-pp.x86_64_start_kernel.common_startup_64
      0.50 ± 23%      +0.4        0.93 ±  9%  perf-profile.calltrace.cycles-pp.x86_64_start_reservations.x86_64_start_kernel.common_startup_64
      0.50 ± 23%      +0.4        0.93 ±  9%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.rest_init.start_kernel.x86_64_start_reservations
      1.02 ±  4%      +0.5        1.47 ± 28%  perf-profile.calltrace.cycles-pp.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage.extent_write_cache_pages
      1.02 ±  4%      +0.5        1.47 ± 28%  perf-profile.calltrace.cycles-pp.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage.extent_write_cache_pages.extent_writepages
      0.59 ±  4%      +0.5        1.06 ±  7%  perf-profile.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      1.05 ±  4%      +0.5        1.53 ± 27%  perf-profile.calltrace.cycles-pp.writepage_delalloc.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages
      3.88 ±  3%      +0.5        4.37 ±  2%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.52 ± 23%      +0.5        1.02 ±  7%  perf-profile.calltrace.cycles-pp.filemap_add_folio.__filemap_get_folio.btrfs_truncate_block.btrfs_cont_expand.btrfs_fallocate
      0.64 ±  4%      +0.5        1.14 ±  7%  perf-profile.calltrace.cycles-pp.__filemap_get_folio.btrfs_truncate_block.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate
      0.62 ±  3%      +0.5        1.13 ±  6%  perf-profile.calltrace.cycles-pp.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.64 ±  3%      +0.5        1.17 ±  6%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.37 ± 65%      +0.6        0.94 ±  7%  perf-profile.calltrace.cycles-pp.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.btrfs_truncate_block.btrfs_cont_expand
      0.00            +0.6        0.59 ±  8%  perf-profile.calltrace.cycles-pp.tick_nohz_handler.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt
      0.00            +0.6        0.59 ±  6%  perf-profile.calltrace.cycles-pp.btrfs_delalloc_reserve_metadata.btrfs_truncate_block.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate
      0.00            +0.6        0.60 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_delayed_update_inode.btrfs_update_inode.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate
      0.69 ±  5%      +0.6        1.28 ±  5%  perf-profile.calltrace.cycles-pp.add_delayed_ref_head.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.00            +0.6        0.61 ±  9%  perf-profile.calltrace.cycles-pp._nohz_idle_balance.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      0.32 ± 81%      +0.6        0.95 ±  7%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +0.6        0.63 ±  8%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      0.26 ±100%      +0.7        0.92 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init.start_kernel
      0.26 ±100%      +0.7        0.92 ±  7%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt
      0.00            +0.7        0.68 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_add_delayed_data_ref.btrfs_truncate_inode_items.btrfs_truncate.btrfs_setsize.btrfs_setattr
      0.00            +0.7        0.69 ±  7%  perf-profile.calltrace.cycles-pp.xas_create.xas_store.__filemap_add_folio.filemap_add_folio.__filemap_get_folio
      0.00            +0.7        0.73 ±  9%  perf-profile.calltrace.cycles-pp.arch_do_signal_or_restart.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe.fallocate64
      0.00            +0.7        0.73 ±  7%  perf-profile.calltrace.cycles-pp.xas_store.__filemap_add_folio.filemap_add_folio.__filemap_get_folio.btrfs_truncate_block
      0.00            +0.7        0.73 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_read_folio.btrfs_truncate_block.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate
      0.00            +0.7        0.75 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_del_items.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.03 ±435%      +0.7        0.77 ± 54%  perf-profile.calltrace.cycles-pp.fallback_to_cow.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc.__extent_writepage
      0.00            +0.8        0.76 ± 55%  perf-profile.calltrace.cycles-pp.cow_file_range.fallback_to_cow.run_delalloc_nocow.btrfs_run_delalloc_range.writepage_delalloc
      0.00            +0.8        0.76 ± 12%  perf-profile.calltrace.cycles-pp.ata_scsi_queuecmd.scsi_dispatch_cmd.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched
      0.02 ±435%      +0.8        0.80 ±  9%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered
      0.00            +0.8        0.79 ± 12%  perf-profile.calltrace.cycles-pp.scsi_dispatch_cmd.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      0.03 ±435%      +0.8        0.82 ±  8%  perf-profile.calltrace.cycles-pp.btrfs_setup_item_for_insert.btrfs_drop_extents.insert_reserved_file_extent.btrfs_finish_one_ordered.btrfs_work_helper
      0.00            +0.8        0.80 ±  7%  perf-profile.calltrace.cycles-pp.ahci_handle_port_intr.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.00            +0.8        0.81 ±  7%  perf-profile.calltrace.cycles-pp.btrfs_update_inode.__btrfs_prealloc_file_range.btrfs_prealloc_file_range.btrfs_fallocate.vfs_fallocate
      0.00            +0.8        0.81 ±  6%  perf-profile.calltrace.cycles-pp.xas_find.delete_from_page_cache_batch.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize
      0.00            +0.8        0.84 ± 10%  perf-profile.calltrace.cycles-pp.scsi_io_completion.blk_complete_reqs.__do_softirq.irq_exit_rcu.sysvec_call_function_single
      0.98 ±  5%      +0.9        1.86 ±  8%  perf-profile.calltrace.cycles-pp.__memmove.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_insert_empty_items
      0.00            +0.9        0.89 ±  6%  perf-profile.calltrace.cycles-pp.xas_find.find_lock_entries.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize
      0.00            +0.9        0.89 ±  9%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.rest_init
      1.00 ±  5%      +0.9        1.91 ±  8%  perf-profile.calltrace.cycles-pp.__write_extent_buffer.memcpy_extent_buffer.setup_items_for_insert.btrfs_insert_empty_items.btrfs_insert_replace_extent
      1.02 ±  5%      +0.9        1.95 ±  8%  perf-profile.calltrace.cycles-pp.memcpy_extent_buffer.setup_items_for_insert.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents
      0.00            +0.9        0.93 ±  6%  perf-profile.calltrace.cycles-pp.find_lock_entries.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize.btrfs_setattr
      0.13 ±173%      +0.9        1.07 ±  6%  perf-profile.calltrace.cycles-pp.delete_from_page_cache_batch.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize.btrfs_setattr
      0.00            +1.0        0.96 ± 10%  perf-profile.calltrace.cycles-pp.blk_complete_reqs.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single
      6.14 ±  3%      +1.0        7.13 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.00            +1.0        1.00 ±  7%  perf-profile.calltrace.cycles-pp.ahci_single_level_irq_intr.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt
      0.00            +1.0        1.00 ±  7%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
      0.00            +1.0        1.01 ± 10%  perf-profile.calltrace.cycles-pp.scsi_queue_rq.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.00            +1.0        1.02 ± 10%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_rq_list.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue
      1.10 ±  4%      +1.0        2.12 ± 26%  perf-profile.calltrace.cycles-pp.btrfs_add_delayed_data_ref.btrfs_alloc_reserved_file_extent.btrfs_insert_replace_extent.btrfs_replace_file_extents.insert_prealloc_file_extent
      1.13 ±  4%      +1.0        2.16 ± 25%  perf-profile.calltrace.cycles-pp.btrfs_alloc_reserved_file_extent.btrfs_insert_replace_extent.btrfs_replace_file_extents.insert_prealloc_file_extent.__btrfs_prealloc_file_range
      0.00            +1.0        1.04 ±  7%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      3.94 ±  3%      +1.0        4.99 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_setsize.btrfs_setattr.notify_change.do_truncate.do_ftruncate
      0.00            +1.1        1.05 ±  7%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.acpi_safe_halt
      0.00            +1.1        1.06 ±  8%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.acpi_safe_halt.acpi_idle_enter
      3.97 ±  3%      +1.1        5.04 ±  2%  perf-profile.calltrace.cycles-pp.btrfs_setattr.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate
      1.32 ±  3%      +1.1        2.39 ±  6%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      3.98 ±  3%      +1.1        5.05 ±  2%  perf-profile.calltrace.cycles-pp.notify_change.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64
      3.98 ±  3%      +1.1        5.06 ±  2%  perf-profile.calltrace.cycles-pp.do_truncate.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe
      3.99 ±  3%      +1.1        5.07 ±  2%  perf-profile.calltrace.cycles-pp.do_ftruncate.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      3.99 ±  3%      +1.1        5.07 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_ftruncate.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      3.99 ±  3%      +1.1        5.08 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.ftruncate64
      3.99 ±  3%      +1.1        5.08 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.ftruncate64
      4.00 ±  3%      +1.1        5.10 ±  2%  perf-profile.calltrace.cycles-pp.ftruncate64
      0.00            +1.1        1.13 ± 27%  perf-profile.calltrace.cycles-pp.scsi_end_request.scsi_io_completion.blk_complete_reqs.__do_softirq.irq_exit_rcu
      2.35 ±  2%      +1.3        3.64 ±  4%  perf-profile.calltrace.cycles-pp.setup_items_for_insert.btrfs_insert_empty_items.btrfs_insert_replace_extent.btrfs_replace_file_extents.insert_prealloc_file_extent
      1.61 ±  3%      +1.5        3.13 ±  5%  perf-profile.calltrace.cycles-pp.truncate_inode_pages_range.truncate_pagecache.btrfs_setsize.btrfs_setattr.notify_change
      1.61 ±  3%      +1.5        3.13 ±  5%  perf-profile.calltrace.cycles-pp.truncate_pagecache.btrfs_setsize.btrfs_setattr.notify_change.do_truncate
      0.03 ±435%      +1.6        1.65 ±  7%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.03 ±435%      +1.6        1.66 ±  7%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +1.6        1.63 ±  8%  perf-profile.calltrace.cycles-pp.__do_softirq.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      2.29 ±  4%      +1.7        3.98 ±  4%  perf-profile.calltrace.cycles-pp.btrfs_truncate_block.btrfs_cont_expand.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate
      0.00            +1.7        1.70 ±  8%  perf-profile.calltrace.cycles-pp.irq_exit_rcu.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      3.14 ±  3%      +2.7        5.88 ±  6%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      6.89 ±  3%      +2.8        9.70 ±  3%  perf-profile.calltrace.cycles-pp.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      0.00            +3.1        3.13 ± 12%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_insert_requests.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list
      0.00            +3.2        3.20 ± 11%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_insert_requests.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug
      0.00            +3.4        3.38 ± 11%  perf-profile.calltrace.cycles-pp.dd_insert_requests.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.submit_bio_noacct_nocheck
     13.83 ±  3%      +3.4       17.24 ±  2%  perf-profile.calltrace.cycles-pp.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      8.75 ±  3%      +3.4       12.18 ± 10%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio.submit_one_bio.submit_extent_page
      8.90 ±  3%      +3.6       12.46 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_submit_chunk.btrfs_submit_bio.submit_one_bio.submit_extent_page.__extent_writepage_io
      8.90 ±  3%      +3.6       12.46 ± 10%  perf-profile.calltrace.cycles-pp.btrfs_submit_bio.submit_one_bio.submit_extent_page.__extent_writepage_io.__extent_writepage
      8.90 ±  3%      +3.6       12.47 ± 10%  perf-profile.calltrace.cycles-pp.submit_one_bio.submit_extent_page.__extent_writepage_io.__extent_writepage.extent_write_cache_pages
      8.96 ±  3%      +3.6       12.59 ± 10%  perf-profile.calltrace.cycles-pp.submit_extent_page.__extent_writepage_io.__extent_writepage.extent_write_cache_pages.extent_writepages
      9.06 ±  3%      +3.7       12.77 ±  9%  perf-profile.calltrace.cycles-pp.__extent_writepage_io.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages
     10.13 ±  3%      +4.2       14.36 ±  9%  perf-profile.calltrace.cycles-pp.__extent_writepage.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc
     10.26 ±  3%      +4.3       14.58 ±  9%  perf-profile.calltrace.cycles-pp.extent_write_cache_pages.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range
     10.27 ±  3%      +4.3       14.59 ±  9%  perf-profile.calltrace.cycles-pp.extent_writepages.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range
     10.28 ±  3%      +4.3       14.62 ±  9%  perf-profile.calltrace.cycles-pp.do_writepages.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.btrfs_wait_ordered_range
     10.34 ±  3%      +4.4       14.73 ±  9%  perf-profile.calltrace.cycles-pp.filemap_fdatawrite_wbc.__filemap_fdatawrite_range.btrfs_fdatawrite_range.btrfs_wait_ordered_range.btrfs_fallocate
     10.36 ±  3%      +4.4       14.76 ±  9%  perf-profile.calltrace.cycles-pp.__filemap_fdatawrite_range.btrfs_fdatawrite_range.btrfs_wait_ordered_range.btrfs_fallocate.vfs_fallocate
     10.37 ±  3%      +4.4       14.78 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_fdatawrite_range.btrfs_wait_ordered_range.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate
     11.02 ±  3%      +4.7       15.74 ±  9%  perf-profile.calltrace.cycles-pp.btrfs_wait_ordered_range.btrfs_fallocate.vfs_fallocate.__x64_sys_fallocate.do_syscall_64
      0.00            +5.9        5.90 ±  8%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests
      0.00            +6.0        5.96 ±  8%  perf-profile.calltrace.cycles-pp._raw_spin_lock.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests
      0.00            +6.1        6.10 ±  8%  perf-profile.calltrace.cycles-pp.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue
      0.00            +7.5        7.51 ±  8%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list
      0.00            +7.5        7.55 ±  7%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list
      0.00            +7.5        7.55 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug
      0.00            +7.6        7.58 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queue.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.submit_bio_noacct_nocheck
      1.52 ±  9%      +9.3       10.78 ±  9%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
      0.00           +11.0       10.99 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_dispatch_plug_list.blk_mq_flush_plug_list.__blk_flush_plug.submit_bio_noacct_nocheck.btrfs_submit_chunk
      0.00           +11.0       10.99 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_flush_plug_list.__blk_flush_plug.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio
      0.00           +11.0       11.00 ±  7%  perf-profile.calltrace.cycles-pp.__blk_flush_plug.submit_bio_noacct_nocheck.btrfs_submit_chunk.btrfs_submit_bio.submit_one_bio
     19.95 ±  2%     +11.5       31.46 ±  4%  perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     19.99 ±  2%     +11.5       31.50 ±  4%  perf-profile.calltrace.cycles-pp.start_secondary.common_startup_64
     19.98 ±  2%     +11.5       31.49 ±  4%  perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.common_startup_64
     18.19 ±  2%     +11.5       29.72 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.common_startup_64
     20.52 ±  2%     +11.9       32.43 ±  4%  perf-profile.calltrace.cycles-pp.common_startup_64
     15.62 ±  2%     +11.9       27.54 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     15.56 ±  2%     +12.8       28.37 ±  4%  perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     46.38 ±  2%     -29.7       16.64 ± 20%  perf-profile.children.cycles-pp.btrfs_search_slot
     39.50 ±  2%     -20.3       19.21 ± 15%  perf-profile.children.cycles-pp.btrfs_replace_file_extents
     39.64 ±  2%     -20.2       19.43 ± 15%  perf-profile.children.cycles-pp.insert_prealloc_file_extent
     41.92 ±  2%     -19.2       22.71 ± 12%  perf-profile.children.cycles-pp.btrfs_prealloc_file_range
     41.91 ±  2%     -19.2       22.70 ± 12%  perf-profile.children.cycles-pp.__btrfs_prealloc_file_range
     25.29 ±  8%     -17.6        7.69 ± 30%  perf-profile.children.cycles-pp.btrfs_lock_root_node
     25.56 ±  7%     -17.5        8.05 ± 29%  perf-profile.children.cycles-pp.__btrfs_tree_lock
     30.96 ±  4%     -17.5       13.45 ± 16%  perf-profile.children.cycles-pp.btrfs_insert_empty_items
     25.59 ±  7%     -17.5        8.13 ± 28%  perf-profile.children.cycles-pp.down_write
     25.31 ±  8%     -17.4        7.89 ± 29%  perf-profile.children.cycles-pp.rwsem_down_write_slowpath
     32.18 ±  3%     -16.8       15.40 ± 17%  perf-profile.children.cycles-pp.btrfs_insert_replace_extent
     66.39           -15.5       50.91 ±  4%  perf-profile.children.cycles-pp.btrfs_fallocate
     66.47           -15.4       51.08 ±  4%  perf-profile.children.cycles-pp.vfs_fallocate
     66.52           -15.4       51.15 ±  3%  perf-profile.children.cycles-pp.__x64_sys_fallocate
     67.65           -14.6       53.08 ±  3%  perf-profile.children.cycles-pp.fallocate64
     20.76 ± 11%     -13.3        7.46 ± 27%  perf-profile.children.cycles-pp.rwsem_optimistic_spin
     17.58 ± 12%     -13.1        4.48 ± 41%  perf-profile.children.cycles-pp.osq_lock
     71.89           -12.7       59.23 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     71.90           -12.6       59.27 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     10.72 ± 15%      -9.7        1.01 ± 52%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     16.39 ±  3%      -9.7        6.70 ± 14%  perf-profile.children.cycles-pp.btrfs_lookup_file_extent
     11.17 ± 12%      -8.4        2.81 ± 19%  perf-profile.children.cycles-pp.btrfs_read_lock_root_node
     10.36 ± 12%      -8.0        2.35 ± 21%  perf-profile.children.cycles-pp.__btrfs_tree_read_lock
     10.36 ± 12%      -8.0        2.39 ± 20%  perf-profile.children.cycles-pp.down_read
      9.66 ± 13%      -7.9        1.79 ± 25%  perf-profile.children.cycles-pp.rwsem_down_read_slowpath
      8.74 ±  3%      -7.6        1.16 ± 63%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      7.51 ±  3%      -7.5        0.06 ±216%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      7.51 ±  3%      -7.5        0.06 ±216%  perf-profile.children.cycles-pp.mod_delayed_work_on
      7.14 ±  3%      -7.1        0.05 ±217%  perf-profile.children.cycles-pp.try_to_grab_pending
     18.96 ±  8%      -6.6       12.35 ±  7%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     10.06 ±  2%      -4.4        5.68 ±  5%  perf-profile.children.cycles-pp.btrfs_drop_extents
      8.96 ±  3%      -4.1        4.82 ± 10%  perf-profile.children.cycles-pp.btrfs_get_extent
      3.63 ±  2%      -1.4        2.20 ±  5%  perf-profile.children.cycles-pp.__schedule
      2.93 ±  2%      -1.4        1.54 ±  5%  perf-profile.children.cycles-pp.schedule
      2.48 ± 10%      -1.3        1.22 ± 17%  perf-profile.children.cycles-pp.btrfs_bin_search
      1.63 ±  2%      -1.1        0.51 ±  9%  perf-profile.children.cycles-pp.pick_next_task_fair
      1.76 ±  4%      -1.1        0.67 ± 12%  perf-profile.children.cycles-pp.schedule_preempt_disabled
      1.37 ±  2%      -1.0        0.33 ± 11%  perf-profile.children.cycles-pp.newidle_balance
      1.29 ±  2%      -0.9        0.44 ±  9%  perf-profile.children.cycles-pp.load_balance
      2.91 ±  3%      -0.8        2.13 ±  5%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      1.13 ±  3%      -0.8        0.35 ± 11%  perf-profile.children.cycles-pp.find_busiest_group
      1.11 ±  3%      -0.8        0.34 ± 10%  perf-profile.children.cycles-pp.update_sd_lb_stats
      1.74 ±  3%      -0.8        0.98 ± 10%  perf-profile.children.cycles-pp.rwsem_wake
      1.04 ±  3%      -0.7        0.31 ± 11%  perf-profile.children.cycles-pp.update_sg_lb_stats
      2.82 ±  3%      -0.7        2.14 ±  5%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      1.31 ±  8%      -0.7        0.65 ± 19%  perf-profile.children.cycles-pp.up_read
      2.26 ± 12%      -0.6        1.61 ± 10%  perf-profile.children.cycles-pp.read_block_for_search
      2.14 ±  6%      -0.6        1.51 ±  6%  perf-profile.children.cycles-pp.btrfs_truncate_inode_items
      1.09 ± 15%      -0.6        0.47 ± 18%  perf-profile.children.cycles-pp.btrfs_get_64
      1.18 ±  4%      -0.6        0.57 ± 12%  perf-profile.children.cycles-pp.wake_up_q
      2.18 ±  4%      -0.6        1.61 ±  6%  perf-profile.children.cycles-pp.sched_ttwu_pending
      1.30 ±  2%      -0.6        0.74 ± 12%  perf-profile.children.cycles-pp.btrfs_unlock_up_safe
      1.69 ±  3%      -0.5        1.16 ±  7%  perf-profile.children.cycles-pp.up_write
      1.28 ± 18%      -0.5        0.79 ± 13%  perf-profile.children.cycles-pp.free_extent_buffer
      2.33 ±  6%      -0.5        1.85 ±  4%  perf-profile.children.cycles-pp.btrfs_truncate
      1.81 ±  3%      -0.4        1.37 ±  5%  perf-profile.children.cycles-pp.ttwu_do_activate
      1.32 ±  3%      -0.4        0.95 ±  6%  perf-profile.children.cycles-pp.activate_task
      1.27 ±  3%      -0.4        0.91 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      1.52 ±  3%      -0.3        1.17 ±  5%  perf-profile.children.cycles-pp.try_to_wake_up
      1.13 ±  3%      -0.3        0.82 ±  7%  perf-profile.children.cycles-pp.enqueue_entity
      1.26 ±  4%      -0.3        0.98 ±  6%  perf-profile.children.cycles-pp.tick_nohz_stop_tick
      1.27 ±  4%      -0.3        0.99 ±  6%  perf-profile.children.cycles-pp.tick_nohz_idle_stop_tick
      0.65 ±  3%      -0.3        0.37 ± 10%  perf-profile.children.cycles-pp.rwsem_mark_wake
      0.41 ±  4%      -0.2        0.18 ± 15%  perf-profile.children.cycles-pp.__queue_work
      0.72 ±  4%      -0.2        0.56 ±  7%  perf-profile.children.cycles-pp.dequeue_task_fair
      0.57 ±  4%      -0.2        0.41 ±  7%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.81 ±  3%      -0.2        0.66 ±  6%  perf-profile.children.cycles-pp.update_load_avg
      0.60 ±  6%      -0.1        0.46 ±  9%  perf-profile.children.cycles-pp.tick_nohz_idle_exit
      0.53 ±  7%      -0.1        0.39 ±  9%  perf-profile.children.cycles-pp.tick_nohz_restart_sched_tick
      0.45 ±  5%      -0.1        0.31 ±  9%  perf-profile.children.cycles-pp.__get_next_timer_interrupt
      0.55 ±  6%      -0.1        0.41 ±  9%  perf-profile.children.cycles-pp.hrtimer_start_range_ns
      0.63 ±  4%      -0.1        0.49 ±  7%  perf-profile.children.cycles-pp.dequeue_entity
      0.30 ±  6%      -0.1        0.16 ± 16%  perf-profile.children.cycles-pp.push_leaf_right
      0.44 ±  4%      -0.1        0.30 ± 11%  perf-profile.children.cycles-pp.split_leaf
      0.24 ±  7%      -0.1        0.13 ± 15%  perf-profile.children.cycles-pp.__push_leaf_right
      0.43 ±  6%      -0.1        0.32 ± 11%  perf-profile.children.cycles-pp.wakeup_preempt
      0.38 ±  7%      -0.1        0.28 ± 11%  perf-profile.children.cycles-pp.resched_curr
      0.38 ±  4%      -0.1        0.29 ± 10%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.17 ±  5%      -0.1        0.08 ± 17%  perf-profile.children.cycles-pp.idle_cpu
      0.25 ±  6%      -0.1        0.17 ± 12%  perf-profile.children.cycles-pp.__smp_call_single_queue
      0.31 ±  6%      -0.1        0.24 ± 13%  perf-profile.children.cycles-pp.__hrtimer_start_range_ns
      0.26 ±  7%      -0.1        0.18 ± 13%  perf-profile.children.cycles-pp.quiet_vmstat
      0.22 ±  7%      -0.1        0.14 ± 15%  perf-profile.children.cycles-pp.call_cpuidle
      0.26 ±  7%      -0.1        0.18 ± 13%  perf-profile.children.cycles-pp.need_update
      0.34 ±  6%      -0.1        0.27 ±  8%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.23 ±  9%      -0.1        0.16 ± 13%  perf-profile.children.cycles-pp.wake_affine
      0.10 ±  8%      -0.1        0.04 ± 85%  perf-profile.children.cycles-pp.nohz_balancer_kick
      0.22 ±  9%      -0.1        0.16 ± 12%  perf-profile.children.cycles-pp.available_idle_cpu
      0.21 ±  7%      -0.1        0.16 ± 15%  perf-profile.children.cycles-pp.__update_load_avg_se
      0.15 ±  8%      -0.1        0.09 ± 19%  perf-profile.children.cycles-pp.tmigr_cpu_deactivate
      0.43 ±  5%      -0.1        0.38 ±  7%  perf-profile.children.cycles-pp.tick_nohz_get_sleep_length
      0.13 ± 11%      -0.1        0.07 ± 30%  perf-profile.children.cycles-pp.btrfs_next_old_leaf
      0.23 ±  7%      -0.1        0.18 ± 16%  perf-profile.children.cycles-pp.__enqueue_entity
      0.12 ±  8%      -0.1        0.07 ± 32%  perf-profile.children.cycles-pp.tmigr_inactive_up
      0.11 ±  9%      -0.0        0.06 ± 19%  perf-profile.children.cycles-pp.tmigr_quick_check
      0.08 ± 13%      -0.0        0.04 ± 75%  perf-profile.children.cycles-pp.tmigr_update_events
      0.14 ±  8%      -0.0        0.10 ± 19%  perf-profile.children.cycles-pp.update_cfs_group
      0.06 ± 12%      +0.0        0.09 ± 15%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.06 ± 10%      +0.0        0.09 ± 18%  perf-profile.children.cycles-pp.run_rebalance_domains
      0.05 ± 35%      +0.0        0.08 ± 17%  perf-profile.children.cycles-pp.switch_fpu_return
      0.05 ± 35%      +0.0        0.09 ± 13%  perf-profile.children.cycles-pp.btrfs_verify_level_key
      0.07 ± 11%      +0.0        0.11 ± 15%  perf-profile.children.cycles-pp.btrfs_alloc_ordered_extent
      0.07 ±  9%      +0.0        0.11 ± 13%  perf-profile.children.cycles-pp.rb_erase
      0.06 ± 14%      +0.0        0.10 ± 17%  perf-profile.children.cycles-pp.find_free_space
      0.05 ± 44%      +0.0        0.09 ± 23%  perf-profile.children.cycles-pp.shim_fallocate
      0.05 ± 43%      +0.0        0.09 ± 16%  perf-profile.children.cycles-pp.__folio_start_writeback
      0.09 ± 10%      +0.0        0.13 ± 14%  perf-profile.children.cycles-pp.tmigr_requires_handle_remote
      0.04 ± 66%      +0.0        0.08 ± 14%  perf-profile.children.cycles-pp.alloc_ordered_extent
      0.07 ± 11%      +0.0        0.11 ± 16%  perf-profile.children.cycles-pp.rseq_ip_fixup
      0.07 ± 10%      +0.0        0.12 ± 13%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.06 ± 14%      +0.0        0.10 ± 15%  perf-profile.children.cycles-pp.btrfs_put_ordered_extent
      0.06 ± 12%      +0.0        0.11 ± 19%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.05 ± 43%      +0.0        0.10 ± 17%  perf-profile.children.cycles-pp.btrfs_map_block
      0.05 ± 35%      +0.0        0.10 ± 16%  perf-profile.children.cycles-pp.can_nocow_file_extent
      0.04 ± 66%      +0.0        0.09 ± 19%  perf-profile.children.cycles-pp.btrfs_init_metadata_block_rsv
      0.06 ± 13%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.btrfs_file_extent_end
      0.08 ± 11%      +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.update_existing_head_ref
      0.05 ± 26%      +0.1        0.10 ± 20%  perf-profile.children.cycles-pp.tick_nohz_irq_exit
      0.07 ± 26%      +0.1        0.12 ± 15%  perf-profile.children.cycles-pp.fpu__clear_user_states
      0.10 ± 14%      +0.1        0.15 ± 13%  perf-profile.children.cycles-pp.btrfs_mark_extent_written
      0.04 ± 58%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.handle_internal_command
      0.04 ± 58%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.main
      0.04 ± 58%      +0.1        0.10 ± 13%  perf-profile.children.cycles-pp.run_builtin
      0.02 ±136%      +0.1        0.07 ± 23%  perf-profile.children.cycles-pp.__folio_batch_release
      0.03 ±100%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.btrfs_put_block_group
      0.05 ± 25%      +0.1        0.11 ± 12%  perf-profile.children.cycles-pp.btrfs_remove_ordered_extent
      0.06 ± 15%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.btrfs_set_range_writeback
      0.02 ±136%      +0.1        0.07 ± 16%  perf-profile.children.cycles-pp.btrfs_get_chunk_map
      0.05 ± 25%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.btrfs_csum_one_bio
      0.25 ±  7%      +0.1        0.31 ±  9%  perf-profile.children.cycles-pp.tick_irq_enter
      0.04 ± 50%      +0.1        0.10 ± 16%  perf-profile.children.cycles-pp.shuffle_freelist
      0.03 ± 90%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.arch_scale_freq_tick
      0.03 ± 73%      +0.1        0.09 ± 17%  perf-profile.children.cycles-pp.xas_load
      0.05 ± 26%      +0.1        0.11 ± 14%  perf-profile.children.cycles-pp.xas_descend
      0.00            +0.1        0.06 ± 16%  perf-profile.children.cycles-pp.filemap_get_folios_tag
      0.02 ±122%      +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.memcg_list_lru_alloc
      0.02 ±153%      +0.1        0.08 ± 18%  perf-profile.children.cycles-pp.security_file_permission
      0.06 ± 10%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.alloc_extent_map
      0.07 ± 15%      +0.1        0.14 ± 15%  perf-profile.children.cycles-pp.dequeue_signal
      0.09 ± 10%      +0.1        0.15 ± 13%  perf-profile.children.cycles-pp.btrfs_set_delalloc_extent
      0.05 ± 24%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.obj_cgroup_charge
      0.32 ±  6%      +0.1        0.38 ±  7%  perf-profile.children.cycles-pp.irq_enter_rcu
      0.09 ± 13%      +0.1        0.15 ± 14%  perf-profile.children.cycles-pp.set_extent_buffer_dirty
      0.05 ± 34%      +0.1        0.11 ± 15%  perf-profile.children.cycles-pp.allocate_slab
      0.10 ±  8%      +0.1        0.16 ± 21%  perf-profile.children.cycles-pp.btrfs_delayed_refs_rsv_release
      0.06 ± 25%      +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.__do_sys_prlimit64
      0.05 ± 44%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.ktime_get_update_offsets_now
      0.08 ±  8%      +0.1        0.14 ± 14%  perf-profile.children.cycles-pp.btrfs_alloc_block_rsv
      0.01 ±173%      +0.1        0.08 ± 18%  perf-profile.children.cycles-pp.cache_state_if_flags
      0.00            +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.sbitmap_get_shallow
      0.08 ± 13%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.cap_inode_need_killpriv
      0.07 ± 13%      +0.1        0.14 ± 17%  perf-profile.children.cycles-pp.__vfs_getxattr
      0.13 ± 10%      +0.1        0.20 ± 14%  perf-profile.children.cycles-pp.join_transaction
      0.02 ±110%      +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.try_release_extent_mapping
      0.04 ± 50%      +0.1        0.11 ± 18%  perf-profile.children.cycles-pp.__call_rcu_common
      0.02 ±136%      +0.1        0.08 ± 15%  perf-profile.children.cycles-pp.crc32c_pcl_intel_digest
      0.01 ±200%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.btrfs_lookup_ordered_extent
      0.07 ± 13%      +0.1        0.14 ± 18%  perf-profile.children.cycles-pp.save_xstate_epilog
      0.01 ±300%      +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__xa_set_mark
      0.02 ±152%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.btrfs_inode_lock
      0.16 ±  7%      +0.1        0.22 ± 12%  perf-profile.children.cycles-pp.__radix_tree_lookup
      0.07 ±  8%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.folios_put_refs
      0.00 ±435%      +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.btrfs_add_delayed_iput
      0.00            +0.1        0.07 ± 17%  perf-profile.children.cycles-pp.__blk_bios_map_sg
      0.00 ±435%      +0.1        0.07 ± 15%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.01 ±299%      +0.1        0.08 ± 18%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.11 ±  8%      +0.1        0.18 ± 13%  perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.03 ± 91%      +0.1        0.10 ± 25%  perf-profile.children.cycles-pp.btrfs_set_extent_delalloc
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.kernel_clone
      0.06 ±  9%      +0.1        0.13 ± 23%  perf-profile.children.cycles-pp.btrfs_update_delayed_refs_rsv
      0.09 ± 12%      +0.1        0.16 ± 16%  perf-profile.children.cycles-pp.security_inode_need_killpriv
      0.08 ± 12%      +0.1        0.15 ± 12%  perf-profile.children.cycles-pp.folio_account_dirtied
      0.04 ± 58%      +0.1        0.11 ± 13%  perf-profile.children.cycles-pp.release_extent_buffer
      0.00 ±435%      +0.1        0.08 ± 19%  perf-profile.children.cycles-pp.seq_read_iter
      0.09 ±  9%      +0.1        0.16 ± 13%  perf-profile.children.cycles-pp.wait_current_trans
      0.00            +0.1        0.07 ± 21%  perf-profile.children.cycles-pp.link_path_walk
      0.11 ± 11%      +0.1        0.18 ± 13%  perf-profile.children.cycles-pp.set_state_bits
      0.17 ± 12%      +0.1        0.24 ± 11%  perf-profile.children.cycles-pp.btrfs_reduce_alloc_profile
      0.06 ± 26%      +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.10 ±  9%      +0.1        0.17 ± 12%  perf-profile.children.cycles-pp.btrfs_find_space_info
      0.00            +0.1        0.08 ± 14%  perf-profile.children.cycles-pp.__blk_rq_map_sg
      0.03 ± 74%      +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.__mod_memcg_lruvec_state
      0.00            +0.1        0.08 ± 25%  perf-profile.children.cycles-pp.filemap_map_pages
      0.27 ±  6%      +0.1        0.35 ±  9%  perf-profile.children.cycles-pp.native_sched_clock
      0.00 ±435%      +0.1        0.08 ± 17%  perf-profile.children.cycles-pp.radix_tree_node_rcu_free
      0.09 ± 10%      +0.1        0.17 ± 11%  perf-profile.children.cycles-pp.inc_rlimit_get_ucounts
      0.06 ± 11%      +0.1        0.14 ± 13%  perf-profile.children.cycles-pp.local_clock_noinstr
      0.06 ± 15%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp._copy_from_user
      0.30 ±  5%      +0.1        0.38 ±  8%  perf-profile.children.cycles-pp.folio_wait_bit_common
      0.08 ± 11%      +0.1        0.16 ± 12%  perf-profile.children.cycles-pp.rcu_all_qs
      0.00            +0.1        0.08 ± 24%  perf-profile.children.cycles-pp.do_read_fault
      0.00            +0.1        0.08 ± 13%  perf-profile.children.cycles-pp.read_counters
      0.08 ± 12%      +0.1        0.16 ± 15%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.07 ± 13%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      0.11 ± 10%      +0.1        0.19 ± 14%  perf-profile.children.cycles-pp.file_remove_privs_flags
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.exit_mm
      0.18 ±  6%      +0.1        0.26 ± 10%  perf-profile.children.cycles-pp.btrfs_start_ordered_extent
      0.43 ±  6%      +0.1        0.52 ±  8%  perf-profile.children.cycles-pp.file_modified
      0.00            +0.1        0.09 ± 18%  perf-profile.children.cycles-pp.__blk_mq_alloc_driver_tag
      0.01 ±299%      +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.__x64_sys_exit_group
      0.01 ±299%      +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.do_group_exit
      0.15 ±  8%      +0.1        0.24 ± 10%  perf-profile.children.cycles-pp.scheduler_tick
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.dispatch_events
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.process_interval
      0.00            +0.1        0.09 ± 12%  perf-profile.children.cycles-pp.cmd_stat
      0.32 ±  5%      +0.1        0.41 ±  8%  perf-profile.children.cycles-pp.folio_wait_writeback
      0.00            +0.1        0.09 ± 23%  perf-profile.children.cycles-pp.setlocale
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.timekeeping_advance
      0.00            +0.1        0.09 ± 19%  perf-profile.children.cycles-pp.update_wall_time
      0.16 ±  8%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.btrfs_leaf_free_space
      0.24 ±  7%      +0.1        0.33 ± 13%  perf-profile.children.cycles-pp.rq_qos_wait
      0.10 ± 10%      +0.1        0.19 ± 16%  perf-profile.children.cycles-pp.wake_page_function
      0.11 ± 10%      +0.1        0.20 ± 13%  perf-profile.children.cycles-pp.btrfs_add_extent_mapping
      0.00 ±435%      +0.1        0.10 ± 21%  perf-profile.children.cycles-pp.do_fault
      0.07 ± 50%      +0.1        0.16 ± 19%  perf-profile.children.cycles-pp.__handle_mm_fault
      0.09 ±  7%      +0.1        0.18 ± 17%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.00            +0.1        0.09 ± 13%  perf-profile.children.cycles-pp.scsi_alloc_sgtables
      0.10 ±  8%      +0.1        0.20 ± 11%  perf-profile.children.cycles-pp.___slab_alloc
      0.01 ±239%      +0.1        0.10 ± 17%  perf-profile.children.cycles-pp.ksys_mmap_pgoff
      0.09 ±  8%      +0.1        0.18 ± 16%  perf-profile.children.cycles-pp.mod_objcg_state
      0.33 ±  7%      +0.1        0.43 ±  9%  perf-profile.children.cycles-pp.btrfs_clear_delalloc_extent
      0.06 ± 13%      +0.1        0.16 ± 14%  perf-profile.children.cycles-pp.flush_smp_call_function_queue
      0.00            +0.1        0.10 ± 23%  perf-profile.children.cycles-pp.__dd_dispatch_request
      0.11 ± 16%      +0.1        0.21 ± 11%  perf-profile.children.cycles-pp.get_signal
      0.24 ±  7%      +0.1        0.34 ± 13%  perf-profile.children.cycles-pp.wbt_wait
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.blk_mq_complete_request
      0.00            +0.1        0.10 ± 15%  perf-profile.children.cycles-pp.blk_mq_complete_request_remote
      0.07 ± 49%      +0.1        0.18 ± 19%  perf-profile.children.cycles-pp.handle_mm_fault
      0.01 ±301%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.exit_mmap
      0.01 ±239%      +0.1        0.11 ± 16%  perf-profile.children.cycles-pp.do_exit
      0.15 ±  9%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.leaf_space_used
      0.13 ± 11%      +0.1        0.23 ± 13%  perf-profile.children.cycles-pp.__btrfs_qgroup_release_data
      0.01 ±301%      +0.1        0.11 ± 17%  perf-profile.children.cycles-pp.__mmput
      0.08 ± 12%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.restore_fpregs_from_user
      0.01 ±200%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.path_openat
      0.46 ±  4%      +0.1        0.57 ±  9%  perf-profile.children.cycles-pp.update_process_times
      0.13 ±  8%      +0.1        0.24 ± 11%  perf-profile.children.cycles-pp.__update_blocked_fair
      0.10 ± 12%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.btrfs_space_info_update_bytes_may_use
      0.02 ±124%      +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.__x64_sys_openat
      0.01 ±200%      +0.1        0.12 ± 14%  perf-profile.children.cycles-pp.do_filp_open
      0.25 ±  7%      +0.1        0.36 ± 12%  perf-profile.children.cycles-pp.__rq_qos_throttle
      0.08 ± 41%      +0.1        0.19 ± 19%  perf-profile.children.cycles-pp.exc_page_fault
      0.12 ± 10%      +0.1        0.23 ± 11%  perf-profile.children.cycles-pp.__memcg_slab_pre_alloc_hook
      0.40 ±  9%      +0.1        0.51 ±  8%  perf-profile.children.cycles-pp.btrfs_inode_rsv_release
      0.12 ±  7%      +0.1        0.23 ±  9%  perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.08 ± 48%      +0.1        0.19 ± 19%  perf-profile.children.cycles-pp.do_user_addr_fault
      0.02 ±124%      +0.1        0.13 ± 15%  perf-profile.children.cycles-pp.do_sys_openat2
      0.04 ± 77%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.vfs_read
      0.12 ±  6%      +0.1        0.23 ± 10%  perf-profile.children.cycles-pp.free_extent_map
      0.21 ±  6%      +0.1        0.32 ± 10%  perf-profile.children.cycles-pp.__memcpy
      0.04 ± 69%      +0.1        0.15 ± 15%  perf-profile.children.cycles-pp.ksys_read
      0.14 ±  7%      +0.1        0.25 ± 10%  perf-profile.children.cycles-pp.rb_insert_color
      0.10 ± 10%      +0.1        0.21 ± 13%  perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      0.05 ± 48%      +0.1        0.17 ± 16%  perf-profile.children.cycles-pp.read
      0.13 ±  9%      +0.1        0.25 ± 22%  perf-profile.children.cycles-pp.folio_wake_bit
      0.06 ± 28%      +0.1        0.18 ± 17%  perf-profile.children.cycles-pp.queue_work_on
      0.01 ±201%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.mmap_region
      0.12 ±  8%      +0.1        0.24 ± 12%  perf-profile.children.cycles-pp.__folio_mark_dirty
      0.00            +0.1        0.12 ± 18%  perf-profile.children.cycles-pp.__ata_scsi_queuecmd
      0.15 ±  7%      +0.1        0.27 ± 13%  perf-profile.children.cycles-pp.set_extent_bit
      0.16 ±  9%      +0.1        0.28 ±  7%  perf-profile.children.cycles-pp.btrfs_update_root_times
      0.36 ±  4%      +0.1        0.48 ±  8%  perf-profile.children.cycles-pp.__filemap_fdatawait_range
      0.10 ± 11%      +0.1        0.23 ±  9%  perf-profile.children.cycles-pp.rq_qos_wake_function
      0.00            +0.1        0.13 ± 14%  perf-profile.children.cycles-pp.sd_setup_read_write_cmnd
      0.16 ±  6%      +0.1        0.29 ±  6%  perf-profile.children.cycles-pp.__lookup_extent_mapping
      0.36 ±  5%      +0.1        0.49 ±  7%  perf-profile.children.cycles-pp.filemap_fdatawait_range
      0.10 ±  9%      +0.1        0.23 ± 15%  perf-profile.children.cycles-pp.btrfs_get_delayed_node
      0.03 ±100%      +0.1        0.15 ± 20%  perf-profile.children.cycles-pp.bprm_execve
      0.10 ±  8%      +0.1        0.23 ± 15%  perf-profile.children.cycles-pp.btrfs_get_or_create_delayed_node
      0.01 ±175%      +0.1        0.14 ± 16%  perf-profile.children.cycles-pp.do_mmap
      0.02 ±138%      +0.1        0.15 ± 16%  perf-profile.children.cycles-pp.vm_mmap_pgoff
      0.11 ± 10%      +0.1        0.24 ±  9%  perf-profile.children.cycles-pp.free_extent_state
      0.37 ±  4%      +0.1        0.50 ±  7%  perf-profile.children.cycles-pp.native_irq_return_iret
      0.00 ±435%      +0.1        0.13 ± 18%  perf-profile.children.cycles-pp.load_elf_binary
      0.14 ±  7%      +0.1        0.27 ±  9%  perf-profile.children.cycles-pp.__sigqueue_alloc
      0.00 ±435%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.search_binary_handler
      0.15 ±  9%      +0.1        0.28 ± 11%  perf-profile.children.cycles-pp.add_extent_mapping
      0.00 ±435%      +0.1        0.14 ± 19%  perf-profile.children.cycles-pp.exec_binprm
      0.16 ±  6%      +0.1        0.30 ± 11%  perf-profile.children.cycles-pp.btrfs_lock_and_flush_ordered_range
      0.21 ±  8%      +0.1        0.35 ±  7%  perf-profile.children.cycles-pp.btrfs_dec_block_group_reservations
      0.10 ± 32%      +0.1        0.23 ± 17%  perf-profile.children.cycles-pp.asm_exc_page_fault
      0.38 ±  4%      +0.1        0.52 ±  8%  perf-profile.children.cycles-pp.io_schedule
      0.13 ±  8%      +0.1        0.27 ± 12%  perf-profile.children.cycles-pp.__memcg_slab_free_hook
      0.24 ±  7%      +0.1        0.38 ± 10%  perf-profile.children.cycles-pp.btrfs_get_32
      0.21 ±  8%      +0.1        0.35 ±  8%  perf-profile.children.cycles-pp.rb_next
      0.22 ±  6%      +0.1        0.36 ± 14%  perf-profile.children.cycles-pp.insert_delayed_ref
      0.13 ± 11%      +0.1        0.27 ± 15%  perf-profile.children.cycles-pp.blk_mq_free_request
      0.11 ± 12%      +0.1        0.25 ± 16%  perf-profile.children.cycles-pp.wbt_done
      0.11 ± 13%      +0.1        0.25 ± 16%  perf-profile.children.cycles-pp.__rq_qos_done
      0.17 ±  9%      +0.1        0.31 ± 13%  perf-profile.children.cycles-pp.filemap_dirty_folio
      0.43 ±  6%      +0.1        0.57 ±  7%  perf-profile.children.cycles-pp.find_extent_buffer_nolock
      0.09 ± 13%      +0.1        0.23 ± 16%  perf-profile.children.cycles-pp.btrfs_finish_ordered_extent
      0.13 ±  8%      +0.1        0.28 ± 11%  perf-profile.children.cycles-pp.setrlimit64
      0.18 ±  7%      +0.1        0.33 ± 11%  perf-profile.children.cycles-pp.__slab_free
      0.07 ± 18%      +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.do_execveat_common
      0.07 ± 18%      +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.__x64_sys_execve
      0.07 ± 18%      +0.1        0.22 ± 18%  perf-profile.children.cycles-pp.execve
      0.15 ±  7%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.btrfs_check_data_free_space
      0.24 ±  9%      +0.2        0.39 ±  8%  perf-profile.children.cycles-pp.block_group_cache_tree_search
      0.32 ± 10%      +0.2        0.48 ±  9%  perf-profile.children.cycles-pp.btrfs_trans_release_metadata
      0.17 ±  7%      +0.2        0.33 ± 13%  perf-profile.children.cycles-pp.get_sigframe
      0.13 ±  8%      +0.2        0.30 ± 11%  perf-profile.children.cycles-pp.__fpu_restore_sig
      0.14 ±  8%      +0.2        0.31 ± 10%  perf-profile.children.cycles-pp.fpu__restore_sig
      0.57 ±  5%      +0.2        0.74 ±  7%  perf-profile.children.cycles-pp.find_extent_buffer
      0.19 ±  5%      +0.2        0.36 ± 10%  perf-profile.children.cycles-pp.rebalance_domains
      0.24 ±  7%      +0.2        0.41 ±  8%  perf-profile.children.cycles-pp._raw_read_lock
      0.20 ±  5%      +0.2        0.37 ± 10%  perf-profile.children.cycles-pp.memset_orig
      0.54 ±  4%      +0.2        0.72 ±  7%  perf-profile.children.cycles-pp.ktime_get
      0.08 ± 12%      +0.2        0.26 ± 11%  perf-profile.children.cycles-pp.__folio_end_writeback
      0.01 ±200%      +0.2        0.19 ± 13%  perf-profile.children.cycles-pp.ata_qc_complete_multiple
      0.23 ±  9%      +0.2        0.42 ±  9%  perf-profile.children.cycles-pp.__send_signal_locked
      0.03 ± 73%      +0.2        0.22 ± 12%  perf-profile.children.cycles-pp.ahci_scr_read
      0.04 ± 58%      +0.2        0.23 ± 11%  perf-profile.children.cycles-pp.ahci_handle_port_interrupt
      0.19 ±  5%      +0.2        0.38 ±  8%  perf-profile.children.cycles-pp.__cond_resched
      0.04 ± 65%      +0.2        0.23 ± 11%  perf-profile.children.cycles-pp.sata_async_notification
      0.58 ±  3%      +0.2        0.77 ±  8%  perf-profile.children.cycles-pp.tick_nohz_handler
      0.20 ± 10%      +0.2        0.39 ± 11%  perf-profile.children.cycles-pp.x64_setup_rt_frame
      0.00            +0.2        0.20 ± 15%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      0.29 ±  6%      +0.2        0.50 ± 11%  perf-profile.children.cycles-pp.btrfs_reserve_data_bytes
      0.38 ±  6%      +0.2        0.58 ± 10%  perf-profile.children.cycles-pp.__btrfs_release_delayed_node
      0.17 ±  7%      +0.2        0.39 ±  9%  perf-profile.children.cycles-pp.restore_sigcontext
      0.61 ±  3%      +0.2        0.82 ±  7%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.21 ±  6%      +0.2        0.42 ±  9%  perf-profile.children.cycles-pp.stress_fsize_handler
      0.26 ±  7%      +0.2        0.48 ±  9%  perf-profile.children.cycles-pp.do_send_sig_info
      0.28 ±  7%      +0.2        0.50 ±  8%  perf-profile.children.cycles-pp.inode_newsize_ok
      0.29 ±  5%      +0.2        0.52 ±  8%  perf-profile.children.cycles-pp.update_blocked_averages
      0.24 ±  7%      +0.2        0.47 ±  8%  perf-profile.children.cycles-pp.alloc_extent_state
      0.00            +0.2        0.25 ± 14%  perf-profile.children.cycles-pp.sbitmap_get
      0.02 ±136%      +0.2        0.27 ± 12%  perf-profile.children.cycles-pp.sbitmap_find_bit
      1.17 ±  6%      +0.3        1.42 ± 33%  perf-profile.children.cycles-pp.find_free_extent
      0.32 ±  5%      +0.3        0.58 ±  8%  perf-profile.children.cycles-pp.btrfs_do_readpage
      0.48 ±  8%      +0.3        0.74 ±  6%  perf-profile.children.cycles-pp.__btrfs_end_transaction
      0.45 ±  9%      +0.3        0.71 ±  6%  perf-profile.children.cycles-pp.btrfs_delalloc_reserve_metadata
      0.25 ±  8%      +0.3        0.51 ±  9%  perf-profile.children.cycles-pp.btrfs_fallocate_update_isize
      0.31 ±  5%      +0.3        0.58 ±  7%  perf-profile.children.cycles-pp.btrfs_replace_extent_map_range
      0.31 ±  6%      +0.3        0.59 ±  9%  perf-profile.children.cycles-pp.memmove_extent_buffer
      0.30 ±  5%      +0.3        0.57 ±  8%  perf-profile.children.cycles-pp.__wake_up_common
      0.27 ±  7%      +0.3        0.55 ± 10%  perf-profile.children.cycles-pp.__wake_up
      0.29 ±  5%      +0.3        0.57 ±  7%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru
      0.59 ±  5%      +0.3        0.88 ±  5%  perf-profile.children.cycles-pp.clear_state_bit
      0.30 ±  5%      +0.3        0.60 ±  7%  perf-profile.children.cycles-pp.xas_alloc
      0.36 ±  6%      +0.3        0.66 ±  5%  perf-profile.children.cycles-pp.need_preemptive_reclaim
      0.29 ±  5%      +0.3        0.59 ±  9%  perf-profile.children.cycles-pp.rcu_do_batch
      0.25 ±  7%      +0.3        0.55 ±  7%  perf-profile.children.cycles-pp.__x64_sys_rt_sigreturn
      0.21 ±  7%      +0.3        0.51 ± 13%  perf-profile.children.cycles-pp.folio_end_writeback
      1.29 ±  6%      +0.3        1.60 ± 29%  perf-profile.children.cycles-pp.btrfs_reserve_extent
      0.35 ±  4%      +0.3        0.66 ±  8%  perf-profile.children.cycles-pp.lock_extent
      0.35 ±  6%      +0.3        0.66 ±  8%  perf-profile.children.cycles-pp.rcu_core
      0.32 ±  6%      +0.3        0.64 ±  9%  perf-profile.children.cycles-pp.handle_signal
      0.56 ±  5%      +0.3        0.88 ±  7%  perf-profile.children.cycles-pp.btrfs_del_items
      0.09 ± 10%      +0.3        0.41 ±  8%  perf-profile.children.cycles-pp.ahci_qc_complete
      0.40 ±  5%      +0.3        0.72 ±  7%  perf-profile.children.cycles-pp.btrfs_drop_extent_map_range
      0.43 ±  6%      +0.3        0.76 ± 55%  perf-profile.children.cycles-pp.cow_file_range
      0.42 ±  6%      +0.3        0.75 ±  7%  perf-profile.children.cycles-pp.btrfs_read_folio
      0.99 ±  8%      +0.3        1.32 ±  7%  perf-profile.children.cycles-pp.btrfs_block_rsv_release
      0.93 ± 11%      +0.3        1.27 ±  4%  perf-profile.children.cycles-pp.btrfs_reserve_metadata_bytes
      0.36 ±  6%      +0.3        0.70 ±  7%  perf-profile.children.cycles-pp.xas_create
      0.43 ±  6%      +0.3        0.77 ± 54%  perf-profile.children.cycles-pp.fallback_to_cow
      0.54 ±  4%      +0.3        0.89 ±  6%  perf-profile.children.cycles-pp.btrfs_invalidate_folio
      0.46 ±  5%      +0.4        0.82 ±  8%  perf-profile.children.cycles-pp.btrfs_setup_item_for_insert
      0.59 ±  5%      +0.4        0.98 ±  6%  perf-profile.children.cycles-pp.truncate_cleanup_folio
      0.54 ±  5%      +0.4        0.94 ± 15%  perf-profile.children.cycles-pp.btrfs_set_token_32
      0.56 ±  5%      +0.4        0.97 ±  7%  perf-profile.children.cycles-pp.btrfs_delayed_update_inode
      0.53 ±  3%      +0.4        0.93 ±  9%  perf-profile.children.cycles-pp.rest_init
      0.53 ±  3%      +0.4        0.93 ±  9%  perf-profile.children.cycles-pp.start_kernel
      0.53 ±  3%      +0.4        0.93 ±  9%  perf-profile.children.cycles-pp.x86_64_start_kernel
      0.53 ±  3%      +0.4        0.93 ±  9%  perf-profile.children.cycles-pp.x86_64_start_reservations
      0.84 ±  5%      +0.4        1.25 ± 12%  perf-profile.children.cycles-pp.btrfs_get_token_32
      0.32 ±  3%      +0.4        0.74 ±  7%  perf-profile.children.cycles-pp._nohz_idle_balance
      0.47 ±  3%      +0.4        0.89 ±  8%  perf-profile.children.cycles-pp.__set_extent_bit
      0.52 ±  4%      +0.4        0.96 ±  7%  perf-profile.children.cycles-pp.__filemap_add_folio
      0.92 ±  3%      +0.4        1.37 ±  6%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.13 ±  9%      +0.4        0.57 ±  9%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.31 ±  7%      +0.5        0.77 ± 11%  perf-profile.children.cycles-pp.end_bbio_data_write
      1.02 ±  4%      +0.5        1.47 ± 28%  perf-profile.children.cycles-pp.run_delalloc_nocow
      1.02 ±  4%      +0.5        1.48 ± 28%  perf-profile.children.cycles-pp.btrfs_run_delalloc_range
      0.46 ±  6%      +0.5        0.92 ±  8%  perf-profile.children.cycles-pp.arch_do_signal_or_restart
      0.95 ±  3%      +0.5        1.41 ±  6%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      0.46 ±  4%      +0.5        0.94 ±  7%  perf-profile.children.cycles-pp.xas_store
      0.56 ±  4%      +0.5        1.03 ±  7%  perf-profile.children.cycles-pp.filemap_add_folio
      0.36 ±  7%      +0.5        0.84 ± 10%  perf-profile.children.cycles-pp.__btrfs_bio_end_io
      0.45 ±  5%      +0.5        0.93 ±  6%  perf-profile.children.cycles-pp.find_lock_entries
      1.05 ±  4%      +0.5        1.53 ± 27%  perf-profile.children.cycles-pp.writepage_delalloc
      1.08 ±  8%      +0.5        1.57 ±  5%  perf-profile.children.cycles-pp.start_transaction
      1.17 ±  9%      +0.5        1.67 ±  3%  perf-profile.children.cycles-pp.__reserve_bytes
      0.67 ±  3%      +0.5        1.19 ±  7%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.40 ±  7%      +0.5        0.94 ± 10%  perf-profile.children.cycles-pp.blk_update_request
      0.76 ±  4%      +0.6        1.32 ±  6%  perf-profile.children.cycles-pp.btrfs_update_inode
      0.49 ±  5%      +0.6        1.07 ±  6%  perf-profile.children.cycles-pp.delete_from_page_cache_batch
      0.71 ±  4%      +0.6        1.30 ±  7%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.60 ±  3%      +0.6        1.20 ±  6%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.70 ±  4%      +0.6        1.33 ±  7%  perf-profile.children.cycles-pp.kmem_cache_free
      0.92 ±  3%      +0.7        1.59 ±  6%  perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.18 ±  7%      +0.7        0.86 ±  6%  perf-profile.children.cycles-pp.ahci_handle_port_intr
      1.06 ±  4%      +0.7        1.80 ±  4%  perf-profile.children.cycles-pp.__clear_extent_bit
      0.00            +0.8        0.76 ± 12%  perf-profile.children.cycles-pp.ata_scsi_queuecmd
      0.00            +0.8        0.79 ± 12%  perf-profile.children.cycles-pp.scsi_dispatch_cmd
      0.55 ±  6%      +0.8        1.39 ±  9%  perf-profile.children.cycles-pp.scsi_end_request
      0.23 ±  5%      +0.8        1.08 ±  6%  perf-profile.children.cycles-pp.ahci_single_level_irq_intr
      0.55 ±  6%      +0.8        1.40 ±  9%  perf-profile.children.cycles-pp.scsi_io_completion
      0.23 ±  6%      +0.8        1.08 ±  6%  perf-profile.children.cycles-pp.__handle_irq_event_percpu
      1.12 ±  4%      +0.9        1.99 ±  4%  perf-profile.children.cycles-pp.add_delayed_ref_head
      0.24 ±  5%      +0.9        1.12 ±  6%  perf-profile.children.cycles-pp.handle_irq_event
      0.25 ±  6%      +0.9        1.13 ±  7%  perf-profile.children.cycles-pp.handle_edge_irq
      0.25 ±  6%      +0.9        1.14 ±  7%  perf-profile.children.cycles-pp.__common_interrupt
      0.79 ±  4%      +0.9        1.71 ±  6%  perf-profile.children.cycles-pp.xas_find
      0.09 ±  9%      +0.9        1.02 ± 10%  perf-profile.children.cycles-pp.scsi_queue_rq
      0.58 ±  6%      +1.0        1.55 ±  9%  perf-profile.children.cycles-pp.blk_complete_reqs
      0.09 ±  9%      +1.0        1.06 ±  8%  perf-profile.children.cycles-pp.blk_mq_dispatch_rq_list
      6.15 ±  3%      +1.0        7.14 ±  2%  perf-profile.children.cycles-pp.btrfs_cont_expand
      1.71 ±  2%      +1.0        2.73 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      3.94 ±  3%      +1.0        4.99 ±  2%  perf-profile.children.cycles-pp.btrfs_setsize
      3.97 ±  3%      +1.1        5.04 ±  2%  perf-profile.children.cycles-pp.btrfs_setattr
      3.98 ±  3%      +1.1        5.05 ±  2%  perf-profile.children.cycles-pp.notify_change
      3.98 ±  3%      +1.1        5.06 ±  2%  perf-profile.children.cycles-pp.do_truncate
      3.99 ±  3%      +1.1        5.07 ±  2%  perf-profile.children.cycles-pp.do_ftruncate
      3.99 ±  3%      +1.1        5.07 ±  2%  perf-profile.children.cycles-pp.__x64_sys_ftruncate
      4.00 ±  3%      +1.1        5.10 ±  2%  perf-profile.children.cycles-pp.ftruncate64
      1.26 ±  4%      +1.2        2.41 ± 23%  perf-profile.children.cycles-pp.btrfs_alloc_reserved_file_extent
      0.53 ±  5%      +1.2        1.77 ±  6%  perf-profile.children.cycles-pp.common_interrupt
      0.53 ±  5%      +1.2        1.78 ±  6%  perf-profile.children.cycles-pp.asm_common_interrupt
      1.35 ±  5%      +1.3        2.64 ±  8%  perf-profile.children.cycles-pp.memcpy_extent_buffer
      1.80 ±  3%      +1.3        3.13 ±  6%  perf-profile.children.cycles-pp.__memmove
      1.61 ±  3%      +1.5        3.13 ±  5%  perf-profile.children.cycles-pp.truncate_inode_pages_range
      1.61 ±  3%      +1.5        3.13 ±  5%  perf-profile.children.cycles-pp.truncate_pagecache
      1.88 ±  4%      +1.5        3.42 ± 16%  perf-profile.children.cycles-pp.btrfs_add_delayed_data_ref
      1.66 ±  5%      +1.6        3.23 ±  8%  perf-profile.children.cycles-pp.__write_extent_buffer
      1.45 ±  3%      +1.8        3.26 ±  7%  perf-profile.children.cycles-pp.__do_softirq
      1.53 ±  3%      +1.8        3.34 ±  6%  perf-profile.children.cycles-pp.irq_exit_rcu
      2.66 ±  2%      +1.9        4.53 ±  6%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
      2.58 ±  4%      +2.0        4.57 ±  5%  perf-profile.children.cycles-pp.btrfs_truncate_block
      3.05 ±  3%      +2.2        5.22 ±  7%  perf-profile.children.cycles-pp.setup_items_for_insert
      0.77 ± 24%      +2.6        3.38 ± 11%  perf-profile.children.cycles-pp.dd_insert_requests
     14.26 ±  3%      +3.0       17.22 ±  2%  perf-profile.children.cycles-pp.acpi_safe_halt
     14.28 ±  3%      +3.0       17.25 ±  2%  perf-profile.children.cycles-pp.acpi_idle_enter
      8.75 ±  3%      +3.4       12.18 ± 10%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      8.90 ±  3%      +3.6       12.46 ± 10%  perf-profile.children.cycles-pp.btrfs_submit_chunk
      8.90 ±  3%      +3.6       12.46 ± 10%  perf-profile.children.cycles-pp.btrfs_submit_bio
      8.90 ±  3%      +3.6       12.47 ± 10%  perf-profile.children.cycles-pp.submit_one_bio
     11.53 ±  3%      +3.6       15.15 ±  7%  perf-profile.children.cycles-pp._raw_spin_lock
      8.96 ±  3%      +3.6       12.59 ± 10%  perf-profile.children.cycles-pp.submit_extent_page
      9.06 ±  3%      +3.7       12.77 ±  9%  perf-profile.children.cycles-pp.__extent_writepage_io
     10.13 ±  3%      +4.2       14.36 ±  9%  perf-profile.children.cycles-pp.__extent_writepage
     10.26 ±  3%      +4.3       14.58 ±  9%  perf-profile.children.cycles-pp.extent_write_cache_pages
     10.27 ±  3%      +4.3       14.60 ±  9%  perf-profile.children.cycles-pp.extent_writepages
     10.28 ±  3%      +4.3       14.62 ±  9%  perf-profile.children.cycles-pp.do_writepages
     10.35 ±  3%      +4.4       14.75 ±  9%  perf-profile.children.cycles-pp.filemap_fdatawrite_wbc
     10.37 ±  3%      +4.4       14.78 ±  9%  perf-profile.children.cycles-pp.__filemap_fdatawrite_range
     10.37 ±  3%      +4.4       14.78 ±  9%  perf-profile.children.cycles-pp.btrfs_fdatawrite_range
     11.03 ±  3%      +4.7       15.75 ±  9%  perf-profile.children.cycles-pp.btrfs_wait_ordered_range
      0.04 ± 75%      +6.1        6.11 ±  8%  perf-profile.children.cycles-pp.dd_dispatch_request
      0.17 ±  5%      +7.4        7.52 ±  8%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.17 ±  5%      +7.4        7.56 ±  7%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.17 ±  5%      +7.4        7.56 ±  7%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      0.00            +7.6        7.58 ±  7%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      1.54 ±  9%      +9.4       10.89 ±  9%  perf-profile.children.cycles-pp.poll_idle
      0.00           +11.0       10.99 ±  7%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      0.00           +11.0       11.00 ±  7%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      0.00           +11.0       11.00 ±  7%  perf-profile.children.cycles-pp.__blk_flush_plug
     19.99 ±  2%     +11.5       31.50 ±  4%  perf-profile.children.cycles-pp.start_secondary
     20.50 ±  2%     +11.9       32.41 ±  4%  perf-profile.children.cycles-pp.do_idle
     20.52 ±  2%     +11.9       32.43 ±  4%  perf-profile.children.cycles-pp.common_startup_64
     20.52 ±  2%     +11.9       32.43 ±  4%  perf-profile.children.cycles-pp.cpu_startup_entry
     18.70 ±  2%     +12.0       30.66 ±  4%  perf-profile.children.cycles-pp.cpuidle_idle_call
     16.03 ±  2%     +12.4       28.38 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter_state
     16.09 ±  2%     +12.4       28.44 ±  4%  perf-profile.children.cycles-pp.cpuidle_enter
     17.48 ± 12%     -13.0        4.45 ± 41%  perf-profile.self.cycles-pp.osq_lock
     18.94 ±  8%      -6.7       12.26 ±  7%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      2.46 ± 10%      -1.3        1.21 ± 17%  perf-profile.self.cycles-pp.btrfs_bin_search
      1.38 ± 11%      -0.8        0.53 ± 15%  perf-profile.self.cycles-pp.rwsem_down_read_slowpath
      1.08 ± 15%      -0.6        0.46 ± 19%  perf-profile.self.cycles-pp.btrfs_get_64
      1.22 ± 19%      -0.5        0.67 ± 16%  perf-profile.self.cycles-pp.free_extent_buffer
      1.13 ±  9%      -0.5        0.59 ± 16%  perf-profile.self.cycles-pp.up_read
      0.74 ±  3%      -0.5        0.24 ± 14%  perf-profile.self.cycles-pp.update_sg_lb_stats
      2.34 ±  6%      -0.4        1.94 ±  9%  perf-profile.self.cycles-pp.rwsem_spin_on_owner
      0.68 ±  7%      -0.3        0.38 ±  8%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.31 ± 13%      -0.2        0.11 ± 30%  perf-profile.self.cycles-pp.rwsem_down_write_slowpath
      0.45 ±  4%      -0.1        0.32 ± 10%  perf-profile.self.cycles-pp.rwsem_mark_wake
      0.38 ±  7%      -0.1        0.28 ± 11%  perf-profile.self.cycles-pp.resched_curr
      0.23 ±  5%      -0.1        0.13 ± 14%  perf-profile.self.cycles-pp.try_to_wake_up
      0.37 ±  4%      -0.1        0.28 ±  9%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  5%      -0.1        0.08 ± 26%  perf-profile.self.cycles-pp.idle_cpu
      0.22 ±  7%      -0.1        0.14 ± 15%  perf-profile.self.cycles-pp.call_cpuidle
      0.34 ±  6%      -0.1        0.28 ± 13%  perf-profile.self.cycles-pp.__flush_smp_call_function_queue
      0.21 ±  8%      -0.1        0.16 ± 12%  perf-profile.self.cycles-pp.available_idle_cpu
      0.23 ±  7%      -0.1        0.18 ± 16%  perf-profile.self.cycles-pp.__enqueue_entity
      0.19 ±  7%      -0.1        0.14 ± 16%  perf-profile.self.cycles-pp.__update_load_avg_se
      0.11 ±  9%      -0.0        0.06 ± 19%  perf-profile.self.cycles-pp.tmigr_quick_check
      0.26 ±  5%      -0.0        0.21 ± 11%  perf-profile.self.cycles-pp.irqentry_enter
      0.14 ±  8%      -0.0        0.09 ± 14%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.13 ±  8%      -0.0        0.09 ± 15%  perf-profile.self.cycles-pp.ttwu_queue_wakelist
      0.09 ±  5%      -0.0        0.06 ± 30%  perf-profile.self.cycles-pp.dequeue_task_fair
      0.08 ±  9%      +0.0        0.11 ± 11%  perf-profile.self.cycles-pp.btrfs_fallocate
      0.06 ± 14%      +0.0        0.10 ± 13%  perf-profile.self.cycles-pp.rb_erase
      0.04 ± 51%      +0.0        0.08 ± 15%  perf-profile.self.cycles-pp.btrfs_verify_level_key
      0.07 ± 14%      +0.0        0.12 ± 15%  perf-profile.self.cycles-pp.__update_blocked_fair
      0.04 ± 66%      +0.0        0.08 ± 15%  perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.04 ± 42%      +0.0        0.09 ± 24%  perf-profile.self.cycles-pp.stress_fsize_boundary
      0.08 ± 13%      +0.0        0.13 ± 12%  perf-profile.self.cycles-pp.need_preemptive_reclaim
      0.10 ± 11%      +0.1        0.15 ± 13%  perf-profile.self.cycles-pp.__btrfs_end_transaction
      0.04 ± 58%      +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.btrfs_reserve_data_bytes
      0.04 ± 50%      +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru
      0.02 ±111%      +0.1        0.08 ± 19%  perf-profile.self.cycles-pp.btrfs_put_block_group
      0.04 ± 59%      +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.fpu__clear_user_states
      0.03 ± 74%      +0.1        0.09 ± 19%  perf-profile.self.cycles-pp.unlock_up
      0.03 ± 90%      +0.1        0.09 ± 17%  perf-profile.self.cycles-pp.arch_scale_freq_tick
      0.07 ± 11%      +0.1        0.13 ± 20%  perf-profile.self.cycles-pp.btrfs_drop_extents
      0.03 ± 73%      +0.1        0.09 ± 14%  perf-profile.self.cycles-pp.btrfs_release_path
      0.06 ± 13%      +0.1        0.12 ± 13%  perf-profile.self.cycles-pp.rcu_all_qs
      0.08 ± 14%      +0.1        0.14 ± 18%  perf-profile.self.cycles-pp.set_extent_buffer_dirty
      0.05 ± 43%      +0.1        0.11 ± 14%  perf-profile.self.cycles-pp.xas_descend
      0.08 ±  9%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.add_extent_mapping
      0.00            +0.1        0.06 ± 15%  perf-profile.self.cycles-pp.x64_setup_rt_frame
      0.01 ±299%      +0.1        0.07 ± 22%  perf-profile.self.cycles-pp.save_xstate_epilog
      0.01 ±200%      +0.1        0.07 ± 19%  perf-profile.self.cycles-pp.cache_state_if_flags
      0.08 ± 11%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.join_transaction
      0.00            +0.1        0.06 ± 17%  perf-profile.self.cycles-pp.__folio_end_writeback
      0.04 ± 65%      +0.1        0.10 ± 16%  perf-profile.self.cycles-pp.ktime_get_update_offsets_now
      0.00 ±435%      +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.btrfs_clear_delalloc_extent
      0.07 ± 14%      +0.1        0.14 ± 13%  perf-profile.self.cycles-pp.__write_extent_buffer
      0.15 ±  8%      +0.1        0.22 ± 11%  perf-profile.self.cycles-pp.__radix_tree_lookup
      0.00            +0.1        0.07 ± 18%  perf-profile.self.cycles-pp.__blk_bios_map_sg
      0.00 ±435%      +0.1        0.07 ± 15%  perf-profile.self.cycles-pp.btrfs_add_delayed_iput
      0.06 ± 10%      +0.1        0.13 ± 12%  perf-profile.self.cycles-pp.__reserve_bytes
      0.00            +0.1        0.07 ± 17%  perf-profile.self.cycles-pp.do_syscall_64
      0.10 ± 13%      +0.1        0.17 ± 15%  perf-profile.self.cycles-pp.__btrfs_release_delayed_node
      0.02 ±136%      +0.1        0.09 ± 18%  perf-profile.self.cycles-pp.__mod_memcg_lruvec_state
      0.00 ±435%      +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.xas_store
      0.06 ± 25%      +0.1        0.13 ± 14%  perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.00 ±435%      +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.09 ±  8%      +0.1        0.17 ± 12%  perf-profile.self.cycles-pp.btrfs_find_space_info
      0.07 ± 13%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp.copy_fpstate_to_sigframe
      0.26 ±  6%      +0.1        0.34 ±  9%  perf-profile.self.cycles-pp.native_sched_clock
      0.00            +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.obj_cgroup_charge
      0.00            +0.1        0.08 ± 17%  perf-profile.self.cycles-pp.radix_tree_node_rcu_free
      0.06 ± 15%      +0.1        0.14 ± 15%  perf-profile.self.cycles-pp._copy_from_user
      0.09 ± 13%      +0.1        0.17 ± 11%  perf-profile.self.cycles-pp.__set_extent_bit
      0.09 ± 10%      +0.1        0.17 ± 11%  perf-profile.self.cycles-pp.inc_rlimit_get_ucounts
      0.08 ±  8%      +0.1        0.16 ± 17%  perf-profile.self.cycles-pp.mod_objcg_state
      0.03 ± 91%      +0.1        0.11 ± 15%  perf-profile.self.cycles-pp.release_extent_buffer
      0.13 ± 11%      +0.1        0.22 ± 12%  perf-profile.self.cycles-pp.block_group_cache_tree_search
      0.15 ±  9%      +0.1        0.24 ± 11%  perf-profile.self.cycles-pp.find_free_extent
      0.12 ±  9%      +0.1        0.21 ±  9%  perf-profile.self.cycles-pp.up_write
      0.07 ± 14%      +0.1        0.17 ± 13%  perf-profile.self.cycles-pp.restore_fpregs_from_user
      0.13 ±  6%      +0.1        0.23 ±  9%  perf-profile.self.cycles-pp.__lookup_extent_mapping
      0.15 ±  7%      +0.1        0.25 ± 14%  perf-profile.self.cycles-pp.start_transaction
      0.09 ± 12%      +0.1        0.19 ± 12%  perf-profile.self.cycles-pp.btrfs_space_info_update_bytes_may_use
      0.10 ±  9%      +0.1        0.20 ± 12%  perf-profile.self.cycles-pp.btrfs_get_extent
      0.20 ±  6%      +0.1        0.30 ± 10%  perf-profile.self.cycles-pp.__memcpy
      0.11 ±  7%      +0.1        0.21 ±  9%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.12 ±  6%      +0.1        0.22 ± 10%  perf-profile.self.cycles-pp.free_extent_map
      0.13 ±  8%      +0.1        0.24 ± 10%  perf-profile.self.cycles-pp.rb_insert_color
      0.13 ±  9%      +0.1        0.24 ± 10%  perf-profile.self.cycles-pp.__clear_extent_bit
      0.10 ±  8%      +0.1        0.22 ± 12%  perf-profile.self.cycles-pp.__cond_resched
      0.10 ± 11%      +0.1        0.23 ±  9%  perf-profile.self.cycles-pp.free_extent_state
      0.10 ±  9%      +0.1        0.22 ± 10%  perf-profile.self.cycles-pp.btrfs_get_delayed_node
      0.19 ±  8%      +0.1        0.32 ±  9%  perf-profile.self.cycles-pp.rb_next
      0.23 ±  7%      +0.1        0.36 ±  9%  perf-profile.self.cycles-pp.btrfs_get_32
      0.37 ±  4%      +0.1        0.50 ±  7%  perf-profile.self.cycles-pp.native_irq_return_iret
      0.17 ±  9%      +0.1        0.31 ±  7%  perf-profile.self.cycles-pp.btrfs_block_rsv_release
      0.15 ±  7%      +0.1        0.28 ± 17%  perf-profile.self.cycles-pp.setup_items_for_insert
      0.17 ±  6%      +0.1        0.31 ± 12%  perf-profile.self.cycles-pp.__slab_free
      0.00            +0.2        0.16 ± 14%  perf-profile.self.cycles-pp.sbitmap_find_bit
      0.24 ±  8%      +0.2        0.40 ±  8%  perf-profile.self.cycles-pp._raw_read_lock
      0.38 ±  5%      +0.2        0.54 ±  8%  perf-profile.self.cycles-pp.ktime_get
      0.19 ±  6%      +0.2        0.36 ± 10%  perf-profile.self.cycles-pp.memset_orig
      0.04 ± 51%      +0.2        0.22 ± 10%  perf-profile.self.cycles-pp.ahci_single_level_irq_intr
      0.03 ±100%      +0.2        0.21 ± 10%  perf-profile.self.cycles-pp.ahci_handle_port_intr
      0.04 ± 65%      +0.2        0.22 ± 11%  perf-profile.self.cycles-pp.ahci_qc_complete
      0.03 ± 73%      +0.2        0.22 ± 12%  perf-profile.self.cycles-pp.ahci_scr_read
      0.60 ±  5%      +0.3        0.86 ±  7%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.37 ±  5%      +0.3        0.69 ±  6%  perf-profile.self.cycles-pp.kmem_cache_free
      0.36 ±  5%      +0.3        0.70 ±  8%  perf-profile.self.cycles-pp.kmem_cache_alloc
      0.50 ±  5%      +0.4        0.87 ± 15%  perf-profile.self.cycles-pp.btrfs_set_token_32
      0.78 ±  4%      +0.4        1.15 ± 12%  perf-profile.self.cycles-pp.btrfs_get_token_32
      0.96 ±  4%      +0.7        1.67 ±  3%  perf-profile.self.cycles-pp.add_delayed_ref_head
      0.78 ±  4%      +0.9        1.69 ±  6%  perf-profile.self.cycles-pp.xas_find
      2.88 ±  3%      +1.2        4.04 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock
      1.79 ±  3%      +1.3        3.10 ±  6%  perf-profile.self.cycles-pp.__memmove
      1.51 ±  9%      +9.2       10.75 ±  9%  perf-profile.self.cycles-pp.poll_idle




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

