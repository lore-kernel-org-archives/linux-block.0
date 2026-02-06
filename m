Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D8A30B509;
	Fri,  6 Feb 2026 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370029; cv=fail; b=dtHHdxsLxvbT2ztfg1zqCHcf3Ytn9HooFyADbrP9codIgf0CxDbkW1rseNW5By4sfkkeA9wIzlx+4/dyDUEwlhvvsPjK3xmuIpqWvCjklHzF198YyhX/ilMCt2+g1nJRq1/Pu3Oaw88ntzM0RHSVpEG+D6wHIcMLRka/8fDKeJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370029; c=relaxed/simple;
	bh=L9sAN/xseJZxCk+NnUVgHZnFPPezBWnXKI/xs4q8cjY=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GjP2qkBnRUxhymCi5mBn8QVWJZXyw230lfzMV4OK7SP2cAEo+E4Ohswwr8UtC1ZZtDP1+8LCJZyhYx/PPf3UPeZ6U4VyAEMbsRuetz5PhEZA7EqphUqcgyB83tEAMrTBdO676OjYGRtffvMR0ld2Nlk+XxYCyqnu3+ZXsI3wPXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yh4/wVul; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yh4/wVul"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770370028; x=1801906028;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=L9sAN/xseJZxCk+NnUVgHZnFPPezBWnXKI/xs4q8cjY=;
  b=Yh4/wVulV+3wMmEO5Nrkkl2FLloxHpVANvsRIExrE12L4Ae8KNK5rAcp
   CHrmHxaE70fbBvf7ufwMBo1MFeuIjLv+kdNtVIAUsmdpbnnoMh7zf/quC
   28gdB68C4C8Y/oJrW9ibH+qvFn9S4Ib8nM1Hown1z00TUaNYrshFHgqQC
   MOhCGWyjlu9G7VDhzOcKdfWA4E/gWE+NqkakVLgiuUgZKHkRfDz9/h4SX
   hCaW379kdi2PpE8+lCXCg/mFzpWpts7K6d74mj02BcLhHMTEns0kWr2VF
   ErqSbPlt/nm31A9mjiS3PAfSO5piu+5z6g/5Wh5wAic7zkfcdwkhORp2d
   A==;
X-CSE-ConnectionGUID: 5Swi9ArHTFG/PfQ7Chaxeg==
X-CSE-MsgGUID: Lccf64BqTbqsZmLrIyPZug==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82690461"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="82690461"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 01:27:07 -0800
X-CSE-ConnectionGUID: QH9eRtU9QBCJXHOq2r2zAA==
X-CSE-MsgGUID: p6OqB44ISVSBDRyg1QqgFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210900109"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 01:27:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 01:27:07 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Fri, 6 Feb 2026 01:27:07 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 6 Feb 2026 01:27:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3Csv4P4wlx6fNavIdpkwW2u0gKQWtQxfAt5Fh52HkQzGMVoS1wwWpssosHaKTBVSMBKbas1UqWiF20K+rjFVrKP9DppeadK4C6IC9tTEDKVJUUQHftWCKlkgTBC1iHTlysE1jPmmmicABL1G2anLMdFvw+FersTStHT+1e40RPzAJtPUQT2Ph41SvHQBSSqtxJNUyIzkbp0mU6KA8ercs44SIl5Y363N3iP306Kj71K9SXZoxhRSVgIcjXCzqBj1nU6q3lLFFsVNPNQ9kyipCbzkhoAsp3W7hdMRkLkmOqlN/98bMZ3XzMTsE4X/FRsY2l9LjuYrIAToQSe8UIong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h02hLO4eXBGnKbtCuUUzHDblcfVFoh76rbY+2/Dxf1I=;
 b=PNj2DcEWcSFDnMQ038vcb6K8uFcXeohA7efuAoBMYBfetgvLVRqOZegjJu25+ETqwZi2LWV15BIw7oA6f5Pm74qnB9M+T1MFELwZAQbe9QuT3Dd297OnYLMczwrFGPrzMYKKJbE0QyqwLt3bm1yGiu3iKunaI7o4Fg+2ZEDhBjfvbq/XuJFNW1vyHGFyAoL6a1ZAyyEWupH+4smdLGw2/yC27NDwShOILCH2dcVd7Cc4Ntr4LXKAgTsY35iZpIdmByTqJNgFk3ZaNJAzkgOkAOPsG9N24vmLohN5yukNLCVkRd2RsDPXcYQJydYAfUkbsRSVHqn0uTu/zFG7YjAxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.16; Fri, 6 Feb
 2026 09:27:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9587.010; Fri, 6 Feb 2026
 09:27:04 +0000
Date: Fri, 6 Feb 2026 17:26:54 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Kuai <yukuai@fnnas.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Nilay Shroff
	<nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke
	<hare@suse.de>, <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
	<linux-kernel@vger.kernel.org>, <yukuai@fnnas.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v9 8/8] blk-mq-debugfs: warn about possible deadlock
Message-ID: <202602061756.96736e8f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260202080523.3947504-9-yukuai@fnnas.com>
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a20500-600e-48a8-9ae8-08de6561e3d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cKAYAJ47z3qrg3jBZ5vjjuZXdwmLUyeeI494fy9JNUoXiecjg8kOrzZs9urz?=
 =?us-ascii?Q?Qw8VLJjW95f8Hu771lzJfB6SHaQ4X24l8eUI3ViO1VUb+8GYd3J3iAnaNLie?=
 =?us-ascii?Q?ltqTmd8zewgyc040qB/UjddO0Ou9JRcEpTHxd37MfFGtivtNjyg1Q9Y2rt6z?=
 =?us-ascii?Q?FKLhQ/ynGOnkCr9yUze9U2H5rY1Qh/BHVtLjadJBtSuZjrvPiGiDAq+GZf/J?=
 =?us-ascii?Q?WLSJRa0iU/U/ETEVeUjhyTD7d1g6QjZsbN4334XZ96MXphWNr9+2xpjGbFfA?=
 =?us-ascii?Q?yYTXZuDmQeu6QV8x0M4zYrGZeO1gVB9uC0zcD21OQrQQApfZteP75wU0c9O1?=
 =?us-ascii?Q?CpS6sOvRtd5JLD4wSKAXML54Pm7S6clDWK+fhpPWJyoxbmaUjSZIzqveaDMM?=
 =?us-ascii?Q?4wNNotetevErXA852FB9LtKunH8NUjlld+HB4v3tR5OweFGffkIby/l/MUHo?=
 =?us-ascii?Q?AEfGLNL9d6HGjw6doB5GxdxLuXpOeL1FO4vP60Zt7MEoBGyLXCm4De1YVvQj?=
 =?us-ascii?Q?du/nO1qhQCEFOuqYKP/S3NP0Zk9Z+jPaTkKNBu+LVc2gK7OfSLNPYQ4/ecDk?=
 =?us-ascii?Q?T4wie+yCsUXqFeq9A9b5DybXa01rl3OUxmeOVXbmUMJIIPlSFaA3ImZzZvlo?=
 =?us-ascii?Q?D8oFMimyifWYy/VNM9tXMuZQLVpN6AEHCNGgut8PAa/nkZbaOQ674aGfo7l7?=
 =?us-ascii?Q?ba2+4pHWM7fSFjHZ/y/hJXi9KPIAF6okknjsLUfqr/DAjWPT+yf4qHXlm+sa?=
 =?us-ascii?Q?YpOxFT6BNDtkiG5a1DNwB4y0g3LPDtHZM8i0KVwg2MpRBQ2yRNxI8YKwGTJ9?=
 =?us-ascii?Q?tFthWg71yBu1HpYr70k9q6yRlKVktXYX+i3UQm3FVh2bjJTMnJuUZOH4a+Yg?=
 =?us-ascii?Q?zzmMEwZptabJRVcNZqGMTRLCjVrG97tKmRN6/8FGiq24bU+tdc1Q2EmqKCT0?=
 =?us-ascii?Q?NSG2pKP/iTEYki6FxiBGuffrN77mIeM2JooagHHFcjUui9TV30Ys8Li5QqaM?=
 =?us-ascii?Q?S8h05ruD2LD/GAp24lwdIwNGqL6FlK9qaMR1NEBirIAFgX0Sj2tJsFvH5s8Q?=
 =?us-ascii?Q?TXMSY+ErpEgLRZuLEDx9+Y7u4JuiQseFHYIbYR1FA/+XhB/k43Njs0fAcsvq?=
 =?us-ascii?Q?FuyCc4io15ElSkOpzSGoRnn+kZjTZHB7CXzEtpx6ccXrh9dZhLFkR5IXoTHs?=
 =?us-ascii?Q?qrQEjlTya+DQh0oh5pDjNJXXUiHNRPwLM3NqdtLbgUtP2s8eQMzsRS7eTRQ3?=
 =?us-ascii?Q?RYB6iubOE3mZSX3t5WTbxMOF8g75E7JxUYIK2xA+tgb8pJlreiT0Tz0m/OMC?=
 =?us-ascii?Q?ziZd6xNw+AB2NKp9YRGBXsT5HiOhd214Vpil280ubSk3RG/SkPj4LAPxf/LC?=
 =?us-ascii?Q?ZfKyEzP0vVJBFbCkPjjLjLopouShjXvOCETZNuUV6ht9Lbu/pdKiUSRXikf1?=
 =?us-ascii?Q?e52C/QPaitlfZLYD4/PXsjyBr2fs2e2ZgoNLp4rNyHNyYNFWSACIbHRsHYLG?=
 =?us-ascii?Q?zyXECwGpbcVj/mHlA1Hkzf8roRoZxhPhRstJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BRQi1J1bBUqx8lRBoVKKK3LzKQ6UW0gKaSv5eUiWOsNnYvIrgZBX73pDztl3?=
 =?us-ascii?Q?t303JaNIlfxZXk7uZAIUsBiF7r5roeZ5eAr6YN1oJ16F8mtnyfIXxD4NfZ+I?=
 =?us-ascii?Q?/1Gz7L/prMq2mObMvT1hRCh6F3O/eAwcZcLNd4TPoK/e+IA/iwbl89/Tn/4L?=
 =?us-ascii?Q?mdaem1s0cMGplIkBsAILIUEKYOkT3WT6rfM6vkltVm8opCBl45bE933cdN3Q?=
 =?us-ascii?Q?1NoHZmUkYF0615lkewGbhWMZdRnYqdAbbVlAqvo53CbCo0gMPJeiO/M61/2G?=
 =?us-ascii?Q?Owi8p60JAI412hHxV5hse4OOX7nOsMKgeURlDgOSY11iCUIh7JTObTthXxqc?=
 =?us-ascii?Q?fPXEiQoTxS4XgPXlE/gdAipyaIZS2W6YcgWCUi7wULHufYbsHIpEPSpQaPbP?=
 =?us-ascii?Q?UXjsEKSHFH/v9m2XG2QYIQ4shDiDaMIa4C8CfBjx5kQP1+Y6cRijSt5XyQ2Y?=
 =?us-ascii?Q?1IZb8o+poXUN0FK92/aO6tU8EPKA4l13qhA7/uHoBajlOOHUHfF9nQ9hUYRD?=
 =?us-ascii?Q?OWVl1S8kx+hwgNi74Ipmwb2oN+AnEe2wTCmyGQrYZ3qLS0z+U7AzdTaxHGgX?=
 =?us-ascii?Q?TyQ7kPStriZUDRO6kuizIO+qZQi9gH6/DjArTod+vr/1Mi5AyBTLIdyusiAh?=
 =?us-ascii?Q?o5gGHfTkwl9QijrIcLif5ZIRpauHg8jivAoaJmT/hihciR9rpLBj++s3Rq/T?=
 =?us-ascii?Q?7Fb8NKnmpyHtTprn25YKMFpKE8sNvietdNrU6YeysiqqEm3PmXJgnm9/eHYY?=
 =?us-ascii?Q?AAvbFgda96kU3tMpS8vXQzyxcGJrw5q4xQBj2YMZRUw376ZuW0aGYZ2PO/by?=
 =?us-ascii?Q?cTP1dpz8xotiIJCSqY2ggSYTqvGrotyNZh1WhMvZ7HKlonaKGIq8GluQXXlR?=
 =?us-ascii?Q?aoCzxcP2S7J+ViUdr6wxB0pqcFw7gKVXIpjiBldHiR6P7Q4ZgiIYeQBZIXjh?=
 =?us-ascii?Q?0fJG3NisfGP32ufphBjP9LB+q3D3jrQQOJ3ppW4fJL4w0BXoidwRv5omhk9D?=
 =?us-ascii?Q?a/yv/23GHpNWnmcOdx9ZwAG0PlEmZ93yoPZOiN/bp0qi9IfNrIzgLRTo9x5A?=
 =?us-ascii?Q?ScbnibCQ9u3TwmpMPhMrok1cS2t4uCzP5BNybb/pQGoiodQNvyx/EPpA1m46?=
 =?us-ascii?Q?QJSobhYAY/RIpBGw881WmNdv5xKoVi8ok2LvqS0UTFyUDuPTYJHNbUUGGi8k?=
 =?us-ascii?Q?tPoalndssLGj3XAJpTL/NYmQYethI3sFdBZYr3tg1itYgv7J57fu/+Xn65Gg?=
 =?us-ascii?Q?5KgCiS+VjE8y4dTTxCvRH6NJNW2TZJ3w0k7Av0sjoloCy+/d/elxDX0zU/KU?=
 =?us-ascii?Q?DAt5HYB/8c0c0ESQi9mKwZdel5fnBBebVwnLiqvl3r0OBhqEhQWIyceG/f0+?=
 =?us-ascii?Q?V06GpTVDKB+Ll62jXRKfYaThyTZ15XfVhyKZcY2suNFQ3OH1OOoALfpcXENQ?=
 =?us-ascii?Q?esr6Y17cQIPN8thWx4O3cP6tzHr34bNnO4M0/HwmntYL+ghQ5559qWO66P6b?=
 =?us-ascii?Q?MgRpHmho4G8QVG4yoNHHP3xDS+hZyVddkClUrILf9AOnDe1VUch/sL9bjDLJ?=
 =?us-ascii?Q?2lwv3QxMonQHQc/qidrm2XWaiX5JVt4saE3hXJuCvsvDU5NE3v/SfsRsAbH7?=
 =?us-ascii?Q?T/A5bysYgaA/PNX8dcB1qWS1poVjW0o/wrX+rVID+CIIyD8QMTvbGADaV0Um?=
 =?us-ascii?Q?pvkjiWQip8r8PUTO4OhWhBLXGLA7MKIVdfDuHmPXYacD7huujZPU8HxGoRLP?=
 =?us-ascii?Q?2vFGm+IzYg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a20500-600e-48a8-9ae8-08de6561e3d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 09:27:04.3674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTVJwuHnMn2SL4sQxek6Ym4rTF68wSwKKWyl3FzwmLUvp1SvbaFDTPr8oSc0tk4GYX9HpPC5LhLCjFcTDg8Gng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7458
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.nvme/040.fail" on:

commit: a228828b6a29e3787c2d4f30b966b4e723436491 ("[PATCH v9 8/8] blk-mq-debugfs: warn about possible deadlock")
url: https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-wbt-factor-out-a-helper-wbt_set_lat/20260202-161435
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-next
patch link: https://lore.kernel.org/all/20260202080523.3947504-9-yukuai@fnnas.com/
patch subject: [PATCH v9 8/8] blk-mq-debugfs: warn about possible deadlock

in testcase: blktests
version: blktests-x86_64-5885dee-1_20260203
with following parameters:

	disk: 1SSD
	test: nvme-040
	nvme_trtype: rdma
	use_siw: true


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602061756.96736e8f-lkp@intel.com


2026-02-04 16:08:35 cd /lkp/benchmarks/blktests
2026-02-04 16:08:35 mkdir -p /mnt/nvme-040
2026-02-04 16:08:35 mount /dev/nvme0n1p1 /mnt/nvme-040
2026-02-04 16:08:35 echo nvme/040
2026-02-04 16:08:35 ./check -o /mnt/nvme-040 nvme/040
nvme/040 (tr=rdma) (test nvme fabrics controller reset/disconnect operation during I/O)
    runtime  8.568s  ...
nvme/040 (tr=rdma) (test nvme fabrics controller reset/disconnect operation during I/O) [failed]
    runtime  8.568s  ...  8.988s
    something found in dmesg:
    [  161.504240] [   T3651] run blktests nvme/040 at 2026-02-04 16:08:36
    [  161.567237] [   T4057] loop0: detected capacity change from 0 to 2097152
    [  161.581589] [   T4062] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
    [  161.598986] [   T4067] iwpm_register_pid: Unable to send a nlmsg (client = 2)
    [  161.608814] [   T4067] nvmet_rdma: enabling port 0 (192.168.3.121:4420)
    [  161.658405] [   T1863] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
    [  161.686065] [   T4074] nvme nvme2: creating 128 I/O queues.
    [  162.191928] [   T4074] nvme nvme2: mapped 128/0/0 default/read/poll queues.
    [  162.263779] [   T4074] nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr 192.168.3.121:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
    [  162.358452] [   T4108] block nvme0n1: No UUID available providing old NGUID
    ...
    (See '/mnt/nvme-040/nodev_tr_rdma/nvme/040.dmesg' for the entire message)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260206/202602061756.96736e8f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

