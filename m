Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BA125A353;
	Fri,  8 Aug 2025 08:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754642490; cv=fail; b=Qo0f8rw8Brr7uZ3ZL6zkrPB4Iy6134a1dMXSUiGkGhLoPUIynL5jbQish6XE12oVtIJvKy55Ktna+Ec0/zo2nDszjibV29INnVLNJcZa/CBwbVjLzWMCurNO15A8LRQSGh/6WI2gyI5z5giSDFMeB5P6PDtSIT2Mue0gl5uY/NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754642490; c=relaxed/simple;
	bh=cEZblLjrDaJQ7y0ebnlobyHgTvJkcDZwCTYgcwrk0Ok=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hK96ED6q0X8ZROn0ZBA5tOsX1Jl/OdVuD0mN+f0q5O11MbtUWAzGswnWDJtF4+7ODyqzIYFhkBp6zmytesLW6A6N8DiTDKr/GaLyGYBk1zQAMxKPkDzwLOAQ45QB9p/FNUX0gtQvuFrc/1XOsziHnF0DRn4x7/RQEPVBm24gWuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OA/+x/Bd; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OA/+x/Bd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754642489; x=1786178489;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=cEZblLjrDaJQ7y0ebnlobyHgTvJkcDZwCTYgcwrk0Ok=;
  b=OA/+x/BdUqc90DBUPoNZKRvjl4aHYddPKTP77/m5Z2ASlNzcyLXjz72h
   0bMbt+uu8uQqOzIMB/K3lj0blc0NZPgY8Tf1bxV8/TJia7KqxH0UOo4iH
   aM6w2pKDree2/v5jULUEqrKg0y/QAXWQ/cIS3oes9ReY4f6wcEFzAi3Y+
   NzgLgawRKRLh6DA9ryefHSNjwSISAvcXMGFAdATTH3jfpNzVCrflm5MWO
   cIcqbD2k2ivaHlHbGfeS+mCnRiiT1+LhibbaupdKDdBpP/oDsUp2g1Xae
   saE67PaYZ46Q8QBbOWk2qedzSc42eZNg9ECjla6tWzaKdXMSEM58A8MHp
   g==;
X-CSE-ConnectionGUID: G19DNLRWQGOHG8KMNstmBw==
X-CSE-MsgGUID: 7867zMKsSMS5ADkHMzdX6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="60795008"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="60795008"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 01:41:28 -0700
X-CSE-ConnectionGUID: mXitbn33QZ+krY6RXd+tHw==
X-CSE-MsgGUID: RJpNHUoSSCqAyHJgYCJHAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; 
   d="scan'208";a="169411479"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2025 01:41:28 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 01:41:27 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Fri, 8 Aug 2025 01:41:27 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.86) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 8 Aug 2025 01:41:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3mM59jnMVltXkDMPdQL5fjScnlZEqapAj+VDsJ4TK69qZksRxxKOMbj1MQYxZvPVZRTnBF0PqY0HVJpnXqZAB3pDRJ+7DN4xgtysH7C5jTx5+ZTyU3itCbcPysfjhxrb7rIACP1R6d4VYeH7DiKsrOdVLzWPuKeD1j1QYkjJ8iFKwjs0gZKO+j/4g5KUBwmfH2KvTiqMwWJOb7eOFPbXgwaTPF/fQ4J4xaUYRONFRejdVeCcK4MFy86UnM9kLancWeurmTBpcNtebTK6EAEJVsUvLj6U9F/fH3mcRqM/kmopmuK/DQezVmIfY/YhPBDmdkFOuh2B3fAsGwgUWJwow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMFRKuAP0K8BoXAm7Eanvjr6tKv7pYv1ftr+CD69oKU=;
 b=c2jI2lkXFzs5R+GYvNE4wD3RtY1W4oj3BmYBpm/LuWDj60aYJbk2K4fI/jsIDQCf3M+4Jl1i5VGAOxA40SMt12xsne23Cgvvc5rS2J/tq2bsdTc18rfEQO9mStP1ahcxop3lAiVhMVpfa22CudmY16WCc8khB/mX9JoS1PSPJGDYAIIAgbnYgzCZ+Tf107VntxSvsotuLFkQ2VauTOOZQ3+Hwowkzeo3EBFTZIgaL2H8reh2vLX9ytkYiQ5l9FhG/VZ2VtV4geYV942l3WSWLL7JV0kXbatQynk5uiPLIOUpT/eEkMpYAzghk18iwRbuuBuDeAgOMONTY99hvUz4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BN9PR11MB5324.namprd11.prod.outlook.com (2603:10b6:408:119::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Fri, 8 Aug
 2025 08:41:25 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.013; Fri, 8 Aug 2025
 08:41:25 +0000
Date: Fri, 8 Aug 2025 16:41:16 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ujwal Kundur <ujwal.kundur@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, <ming.lei@redhat.com>, <linux-kernel@vger.kernel.org>,
	Ujwal Kundur <ujwal.kundur@gmail.com>,
	<syzbot+2e9e529ac0b319316453@syzkaller.appspotmail.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH] block: prevent deadlock in del_gendisk()
Message-ID: <202508081000.cb134e91-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250803134114.2707-1-ujwal.kundur@gmail.com>
X-ClientProxiedBy: SI2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:4:186::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BN9PR11MB5324:EE_
X-MS-Office365-Filtering-Correlation-Id: f472b43e-a116-47c0-7809-08ddd6575c5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Syj2Sr/Uo8tpbiXORTd3bYSZF6mNS0OCJ2ZWNUr00W1/7BIrYGmCUcm7LWuG?=
 =?us-ascii?Q?ghZ3/tNJvxcDEo0mYM7KkAOhw2njab49Hgr5vcwd/vEYqh5Jma+j+Opu0byT?=
 =?us-ascii?Q?UB8TNX8EJnYPW3o8QUlJniJrP39JXMA1xUPDmSl2cBsRvKCbUGnsIxKa64Kn?=
 =?us-ascii?Q?oXyO6WoVMdbw99s1iZ0YyG5lASnFS2ltpZ2RtclxBhFYkKaFcVBhoqCfW4y3?=
 =?us-ascii?Q?PA1gQ+jdoFhh6jBvAFreROjb4S85ANURpR1OPtOgjoQJQRiPGg/aaFYgSOYu?=
 =?us-ascii?Q?Lf+ZBQVw9VvOcP155uvLZZTLJuLlzuK63xpONBeenHUKTVe3oU/XmdYjwDMU?=
 =?us-ascii?Q?ZnJywPif7MZK/ZIksdoFxI91DFWZBkX/fMKTE6XL0EMyilwBV3T3ekFi3K1+?=
 =?us-ascii?Q?626jN6sF+guEBUIlXurIBT92qktTGtepvs+b3cE1jBHY8n3zQInh93o2jkQo?=
 =?us-ascii?Q?CS2MXU1cE8SpQKVkYL00YbFrqJRkT42jVhjePlp0gaCJZiLoyxQxgYrVK1+J?=
 =?us-ascii?Q?ZB1RBo/khyZx/e1jPzkB20uGueA+s5Rm97twKAGqFZOCIJWyKpV8ZJeBDmeR?=
 =?us-ascii?Q?+D9juyH44bnnhrPo44PQUYLfFdZGibX7YoTJF8cIYQ6AjwMMQ3qiEPjf7nYs?=
 =?us-ascii?Q?yffLONw+f0qCgz5KqUCVhw/hNq8S7ASDSevslJCF/H13kMmKVPsqU/RpPs8l?=
 =?us-ascii?Q?R5yQggR+hiOkvUheLD8V6k/Mmz9U/wIZi4/fUJP9Ow1ndWYI2KxRSRCXyyiC?=
 =?us-ascii?Q?XEHukt01N73l7bvOMtc9GbBaM73edSBap0aGk7VkvokOkUvCnM+y50yGRLIs?=
 =?us-ascii?Q?+kslMTVMHkWEtP48aMonbFdWimV1lWHmpHfsynhV/myBt5t9vK/nOwocFiA0?=
 =?us-ascii?Q?nbzZMjxgya9z2nSvRNZ5GWMy5ELZRACoRyigRlGmP0aryIJZLErpJ/XB8AhN?=
 =?us-ascii?Q?oBg1puU/e0nsh270ZNwxgLEaJ3vCEh0puh02O55jyS3722zN6YapUZ2gc/++?=
 =?us-ascii?Q?olHQpnWg+d3VG/brqKfqO45LBwJGV8EUh1yUDMBd4a9vC5KFu7jkfxomvjai?=
 =?us-ascii?Q?e069vAbwyrjcX0HPY9U9CSXzszy+1Aje8R4QMe6KenE64d7sKYxBbYnz53Lx?=
 =?us-ascii?Q?Om274y5VSJrqlSmgPKR/lLujrlKhPnNdk8Gvw+ytJ11CoQtmZClroE3ndMgW?=
 =?us-ascii?Q?/VjUwbAMYphtlxIBv9SNzZTfwSVB0Flg+SSvdl5OBCj0g2ntZHnr6kuoashA?=
 =?us-ascii?Q?iqwDaTreUpZ8FGdClWCGSWI/qVlm0wyTMdiKRs6D0OzwemmSVcDV1f7s3u4O?=
 =?us-ascii?Q?opGoiv6HPkGTegURbhrqx0G+oi43MbhvU3KOaEsHku3Z6VRQuBGlDfj5ez39?=
 =?us-ascii?Q?TfUtfHSsd4JTSIGTPBk82w9wMzZM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uqdNxQMMf6NW7l7bXklTjC3kyQApHFqs49iBsc/YtLpPbDSAAO6M/74ZCBOz?=
 =?us-ascii?Q?rvWMfc/xFaUzdfcvTzJLYvt0kXy5ON08TlmDp9clUx2NQKKWxV4jhhjl0ttu?=
 =?us-ascii?Q?G+3vrfBryM9iZMxa8D5LCjO+iMzaIyuFcW6oQC30CnfB+2OC5E1CDfFpuRuM?=
 =?us-ascii?Q?NukbsGlLan4vCzpK3gileaZfrrMo5X8vicZXlP6RqcwtX/6JpwvMwRk2P8qE?=
 =?us-ascii?Q?zcb9qmJHJEoYB/BtaQkRkGiGMYf6ydm5dZsp4aJGF+81NTfiDd5hS8VKX/Tv?=
 =?us-ascii?Q?7pEHYYtlLqi7+R+mxAETtkzJ+2jcpOTNIbE+o7lTnU15voNfpjwagn6YKy+E?=
 =?us-ascii?Q?ISOJ3E4G4ptrEKbiAlI5OyFqDzlLASJlxrnDwUnWxTC6QQE9FKnaKPm5q1SD?=
 =?us-ascii?Q?Sz+ZG33pY81Tl8durjokNu2vxNSDGagWQeohCpDyuJwyW1IxxVOnm/efabGi?=
 =?us-ascii?Q?YAxgL9Sur6hv3Cidsq0Ck/U4WHVaH2FuTU7WA3Ke6u8+CQtKp3Q7JcwotY2d?=
 =?us-ascii?Q?MsW/gRsbU7blVI0xbo8jdbN+CntR7nX6sGHfglFhMoov27UhPRNUfsvvNvGY?=
 =?us-ascii?Q?6FEYMsR/Hin5Fszv5k5W0cwtCHmKRaGtMSbn1SxYwVtYCec/uhzUkCcmqAHu?=
 =?us-ascii?Q?1lB7KoWYyNSJ1zEjMycbRTGJyylSepvq+rShylYE0N2DbcSDsPuX3mSPekFL?=
 =?us-ascii?Q?xaEKn+aIrMJuvjS6uz+UbABC3QMtFoppxsso/utL6Rud5HV+26rc0mn9XEj9?=
 =?us-ascii?Q?Y9A8Hu6ZsW/drihGoJZcjcLaMcmA+b1F9WCqQ86PyywKFls56NEtkZfe6OVb?=
 =?us-ascii?Q?IRGDD+O0z557tuYvfnIxVA4RYMiCvoBBXJXgsdGmlNJf/8X6Yfx76m6q2c3J?=
 =?us-ascii?Q?D61IxVAOOP+4N6Krsk2s+CUUAFT6VMJ0tKpRHJo3M4qbTEPn5Q6yyrjE3x4v?=
 =?us-ascii?Q?itnSY1AZi2glMfeSW4QEdmhDvRe27ESZmGILs0DPYWz0amAy7qSCY+chCdui?=
 =?us-ascii?Q?oRWFJKvoJK4d5eMf5f5FIjKOcrF665CCD8a3k65lOXqQbbDWMPgwTITc1qcI?=
 =?us-ascii?Q?RpwFKfmyUivIE+gNcv8/noDhlz37sivhkEtmsgEKJ2HPIT6FGMcgH/zOKcss?=
 =?us-ascii?Q?yXncxW9y+IyVfl9bKkEFPzTfVAzBGMFuLwo/krflJ27d4A8nV/3R24i346ok?=
 =?us-ascii?Q?reRfU06f3rjyV6gzC9WNd4wmWiHyZrjVp7tbxmHxmG7lLOTHrnkVFp9NgQYL?=
 =?us-ascii?Q?QueJqCDUDH7ufFKKVXb/UpNP7jNJygF1b+N2vdP8hhTEGNj2TqmX76/PnkOS?=
 =?us-ascii?Q?WOl+4L+3pFFEHFIa28z+/yhUKV0MBM8x9uyCglh4DGccn9Abnf5eadC9MUv+?=
 =?us-ascii?Q?/Ge8eHqSNrrIR6rOT/ou7/p7jRfQBP2rAV6awJAVTbn7SYpSWLs5hfBZmEd2?=
 =?us-ascii?Q?fgD7yJ07C2LDX4LAMFh1XnZGSEGLN3Yp8nDslP6wOl3VJcv1Iqoy5v+bUOum?=
 =?us-ascii?Q?QhIQyspBcZlTwX240LOrU8lggRtn/y6RQw2gqO5ZxJLvjng0dswvsjerslrI?=
 =?us-ascii?Q?tRq2+cdHbYO1P3vaqVPsiQeh98OAQJV0sG6fO/WXcGP6Y9DfYfS1i+g9dXUI?=
 =?us-ascii?Q?RQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f472b43e-a116-47c0-7809-08ddd6575c5c
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 08:41:25.7794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bR3FPIdg5OITUVkKGaWStZNUtOH8ZFxxtu1OZ0k3cVmn7U4mSnaQW9vnQY2icLXNewUufFRIk8gKDL2sYgDwjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5324
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:

commit: 00ff643264f9f5c300898a591fa4b83a62c43950 ("[PATCH] block: prevent deadlock in del_gendisk()")
url: https://github.com/intel-lab-lkp/linux/commits/Ujwal-Kundur/block-prevent-deadlock-in-del_gendisk/20250803-214237
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20250803134114.2707-1-ujwal.kundur@gmail.com/
patch subject: [PATCH] block: prevent deadlock in del_gendisk()

in testcase: phoronix-test-suite
version: 
with following parameters:

	test: svt-av1-2.11.1
	option_a: 2
	option_b: Bosphorus 1080p
	cpufreq_governor: performance



config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508081000.cb134e91-lkp@intel.com


[   24.331036][ T1884] BUG: kernel NULL pointer dereference, address: 00000000000000a8
[   24.339231][ T1884] #PF: supervisor write access in kernel mode
[   24.345493][ T1884] #PF: error_code(0x0002) - not-present page
[   24.351631][ T1884] PGD 0 P4D 0
[   24.355133][ T1884] Oops: Oops: 0002 [#1] SMP NOPTI
[   24.360264][ T1884] CPU: 26 UID: 0 PID: 1884 Comm: dockerd Tainted: G S                  6.16.0-04436-g00ff643264f9 #1 VOLUNTARY
[   24.372434][ T1884] Tainted: [S]=CPU_OUT_OF_SPEC
[   24.377290][ T1884] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
[ 24.388664][ T1884] RIP: 0010:down_read (arch/x86/include/asm/atomic64_64.h:79 include/linux/atomic/atomic-arch-fallback.h:2723 include/linux/atomic/atomic-long.h:163 include/linux/atomic/atomic-instrumented.h:3298 kernel/locking/rwsem.c:250 kernel/locking/rwsem.c:1245 kernel/locking/rwsem.c:1259 kernel/locking/rwsem.c:1524) 
[ 24.393632][ T1884] Code: 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 0f 1f 44 00 00 53 48 89 fb e8 ae c0 ff ff be 00 01 00 00 <f0> 48 0f c1 33 48 81 c6 00 01 00 00 78 3f 48 b8 07 00 00 00 00 00
All code
========
   0:	00 00                	add    %al,(%rax)
   2:	00 90 90 90 90 90    	add    %dl,-0x6f6f6f70(%rax)
   8:	90                   	nop
   9:	90                   	nop
   a:	90                   	nop
   b:	90                   	nop
   c:	90                   	nop
   d:	90                   	nop
   e:	90                   	nop
   f:	90                   	nop
  10:	90                   	nop
  11:	90                   	nop
  12:	90                   	nop
  13:	f3 0f 1e fa          	endbr64
  17:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  1c:	53                   	push   %rbx
  1d:	48 89 fb             	mov    %rdi,%rbx
  20:	e8 ae c0 ff ff       	call   0xffffffffffffc0d3
  25:	be 00 01 00 00       	mov    $0x100,%esi
  2a:*	f0 48 0f c1 33       	lock xadd %rsi,(%rbx)		<-- trapping instruction
  2f:	48 81 c6 00 01 00 00 	add    $0x100,%rsi
  36:	78 3f                	js     0x77
  38:	48                   	rex.W
  39:	b8 07 00 00 00       	mov    $0x7,%eax
	...

Code starting with the faulting instruction
===========================================
   0:	f0 48 0f c1 33       	lock xadd %rsi,(%rbx)
   5:	48 81 c6 00 01 00 00 	add    $0x100,%rsi
   c:	78 3f                	js     0x4d
   e:	48                   	rex.W
   f:	b8 07 00 00 00       	mov    $0x7,%eax
	...
[   24.413635][ T1884] RSP: 0018:ffffc900211f3918 EFLAGS: 00010246
[   24.419821][ T1884] RAX: 0000000000000000 RBX: 00000000000000a8 RCX: 00000000000001f0
[   24.427912][ T1884] RDX: 00000000000001ef RSI: 0000000000000100 RDI: 00000000000000a8
[   24.436003][ T1884] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   24.444092][ T1884] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000000a8
[   24.452181][ T1884] R13: ffff88c1841e87a0 R14: ffff88c08b28ad68 R15: ffff88c0ce5b2200
[   24.460273][ T1884] FS:  00007ff8a3fff6c0(0000) GS:ffff88f027468000(0000) knlGS:0000000000000000
[   24.469318][ T1884] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   24.476016][ T1884] CR2: 00000000000000a8 CR3: 000000010e760004 CR4: 00000000007726f0
[   24.484104][ T1884] PKRU: 55555554
[   24.487751][ T1884] Call Trace:
[   24.491131][ T1884]  <TASK>
[ 24.494147][ T1884] __del_gendisk (block/genhd.c:745) 
[ 24.498810][ T1884] cleanup_mapped_device (drivers/md/dm.c:2243) dm_mod 
[ 24.504959][ T1884] __dm_destroy (include/linux/list.h:373 drivers/md/dm.c:2397 drivers/md/dm.c:2730) dm_mod 
[ 24.510321][ T1884] ? __pfx_dev_remove (drivers/md/dm-ioctl.c:978) dm_mod 
[ 24.516029][ T1884] dev_remove (drivers/md/dm-ioctl.c:1029) dm_mod 
[ 24.521215][ T1884] ctl_ioctl (drivers/md/dm-ioctl.c:2101) dm_mod 
[ 24.526310][ T1884] dm_ctl_ioctl (drivers/md/dm-ioctl.c:2123) dm_mod 
[ 24.531399][ T1884] __x64_sys_ioctl (fs/ioctl.c:51 fs/ioctl.c:598 fs/ioctl.c:584 fs/ioctl.c:584) 
[ 24.536040][ T1884] ? change_protection_range (mm/mprotect.c:498 mm/mprotect.c:526) 
[ 24.541726][ T1884] do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
[ 24.546279][ T1884] ? get_page_from_freelist (mm/page_alloc.c:1083 mm/page_alloc.c:1702 mm/page_alloc.c:1712 mm/page_alloc.c:3669) 
[ 24.551869][ T1884] ? __alloc_frozen_pages_noprof (mm/page_alloc.c:4959) 
[ 24.557894][ T1884] ? mod_memcg_lruvec_state (mm/memcontrol.c:576 mm/memcontrol.c:564 mm/memcontrol.c:754) 
[ 24.563495][ T1884] ? __lruvec_stat_mod_folio (mm/memcontrol.c:800) 
[ 24.569006][ T1884] ? __folio_mod_stat (mm/rmap.c:1414) 
[ 24.573905][ T1884] ? folio_add_new_anon_rmap (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:867 include/linux/page-flags.h:888 include/linux/mm.h:992 mm/rmap.c:1609) 
[ 24.579493][ T1884] ? do_anonymous_page (mm/memory.c:5153) 
[ 24.584646][ T1884] ? __handle_mm_fault (mm/memory.c:6230) 
[ 24.589805][ T1884] ? do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94) 
[ 24.594520][ T1884] ? count_memcg_events (mm/memcontrol.c:576 mm/memcontrol.c:564 mm/memcontrol.c:848) 
[ 24.599749][ T1884] ? handle_mm_fault (include/linux/memcontrol.h:978 include/linux/memcontrol.h:985 mm/memory.c:6264 mm/memory.c:6425) 
[ 24.604635][ T1884] ? do_user_addr_fault (arch/x86/mm/fault.c:1337) 
[ 24.609863][ T1884] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548) 
[ 24.614572][ T1884] ? clear_bhb_loop (arch/x86/entry/entry_64.S:1548) 
[ 24.619279][ T1884] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
[   24.625200][ T1884] RIP: 0033:0x7ff9476c3d1b
[ 24.629648][ T1884] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1c 48 8b 44 24 18 64 48 2b 04 25 28 00 00
All code
========
   0:	00 48 89             	add    %cl,-0x77(%rax)
   3:	44 24 18             	rex.R and $0x18,%al
   6:	31 c0                	xor    %eax,%eax
   8:	48 8d 44 24 60       	lea    0x60(%rsp),%rax
   d:	c7 04 24 10 00 00 00 	movl   $0x10,(%rsp)
  14:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  19:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  1e:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  23:	b8 10 00 00 00       	mov    $0x10,%eax
  28:	0f 05                	syscall
  2a:*	89 c2                	mov    %eax,%edx		<-- trapping instruction
  2c:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
  31:	77 1c                	ja     0x4f
  33:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  38:	64                   	fs
  39:	48                   	rex.W
  3a:	2b                   	.byte 0x2b
  3b:	04 25                	add    $0x25,%al
  3d:	28 00                	sub    %al,(%rax)
	...

Code starting with the faulting instruction
===========================================
   0:	89 c2                	mov    %eax,%edx
   2:	3d 00 f0 ff ff       	cmp    $0xfffff000,%eax
   7:	77 1c                	ja     0x25
   9:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
   e:	64                   	fs
   f:	48                   	rex.W
  10:	2b                   	.byte 0x2b
  11:	04 25                	add    $0x25,%al
  13:	28 00                	sub    %al,(%rax)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250808/202508081000.cb134e91-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

