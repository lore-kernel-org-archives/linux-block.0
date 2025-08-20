Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1B421507C;
	Wed, 20 Aug 2025 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755665742; cv=fail; b=RqODHgbsOZBF2QUkSBYlvU/BNURi+KCu/7cY7sl85ErjUWaLIHMOohOAEZgGqi0qhdiBsD9X1Fl+TM5CxDEpSI8cR/BrwffQ9glia1Nm71jDyLKnD+iw723271w7cuMGOxPjSgf8wjWmjL4LrMtPcFhuQ6snQ4Mu6pCwSTAUQuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755665742; c=relaxed/simple;
	bh=GFb6ZATjkcHIccNsvDiTX26Pt2V/079VtMGiuVsEiO8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AvU959/TcJAKGyabO/sIla/PIqcST4Hee7fUcoUEIduAc+RwdIbSMNwPEAlXoT3QmrY8uI3MX/HdqyLCoKu0DGV/SGJ9jilMd877UEgRl57wpXMogQRSn4TNln24jFkVIy1Jh34ZJOqQ5BXHd/vZSNI78bkbRBkZR+FgI4hH8/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYCjACWX; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYCjACWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755665740; x=1787201740;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=GFb6ZATjkcHIccNsvDiTX26Pt2V/079VtMGiuVsEiO8=;
  b=RYCjACWXnD2e7ozQporQiFTJPvwv9UoGlNtdUtaX5vzviwwacPgFHGUA
   H6Y1qzcAv/nl1RRd2KJ5qe9JPMS5RERQpOMXsBgT4f9f6FZHBZKsxV27F
   vKlGghmfBsmESuW+PjbjOpxI2/h9RXlZp89ibnu/3SKFMpB7I5om3ozrF
   DTxHcmbRK1ilcH7DQyOCwrtycidmvIOvXiVMYuJIJ9zLlUePO/nXoIzXU
   siNFlQfcR7TIRycjbB/ByY5mzaXLhcFdrZP0p5zY4DPams7PClpSlfz4H
   uQFJj5O+85i9GfaMUCMhdkfOyI/zga7H+ryFhJ+oXkefwJuvl3ti8mfWG
   A==;
X-CSE-ConnectionGUID: bTYvzwAFT828YuP7EtprFQ==
X-CSE-MsgGUID: VYMq/gl8Rh+0r7tS9jquvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57993486"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57993486"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 21:55:40 -0700
X-CSE-ConnectionGUID: oVzhvx46Q1uqSyJ7yHlc5A==
X-CSE-MsgGUID: 4J2Er8kZRYuP9dZVgywwAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172273082"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 21:55:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 21:55:39 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 19 Aug 2025 21:55:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.72)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 19 Aug 2025 21:55:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SPT/yZWPGYeO3H1G8w+mfksx3uaswfYadglLsjuFwT1ZoOs/ioXK74AwtCdLAuTuLT6IcTi5mrBdrThDWLShjM43ieMO/AtmLWFES8uTlQn5y+qzlHg3OCkvepUKfTP2CgJ2NhKq1VNjFbY8vw1idMy5vNfuwd4baMNynYbIoVM+gZRFnexj1sp4xClwsn1iE/6qSq2LRP/9RX9TZ9+pbMORAkEBIvyKm49roNnheZCPaLi4kTeoHrlnBzQa1q4FamkObm0FFcs+qVFCo5zaRTw8wnPFBbHwq4/3Iyx9+Hn37Fvdez74Jj2JBm4ETQbHYHqD99jM+hRuj8kqd75VrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzwSXPyA0VeqUiy+1iL53DYOQ0HHxGDVpdRDS6tgFas=;
 b=PhSywSxiI4ebEPs24+jZhPZT+FfcTfGaPHIHKV/dRLXkLC+Ymv3+9Cz627jsVCakj42URoJ+/NPpxHpxp5M4mp+h1kzFrdFchRttsJScoXXtvNPJc7ogySTLgSZTIVL9zPVJ1mhrLwZywebu7iCQPUWb9E7QHeIDwWyG2A9g5c8wDi7IWg3iIQ69FSy8Jp6/uKOhjtMhUiw1poROgjYmc1cYOGIwaU070dcjc8gtYcYZEGoHhUpIaVFU5hs/SosEwsnlbqTM9AcyfHT4+d9RsYfwd4MOgFJaGnojmJDXSSaBEvsjN0TEREq56REAVcwaMGf9m/k7UPDId9qnob4NDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6118.namprd11.prod.outlook.com (2603:10b6:8:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 04:55:31 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 04:55:31 +0000
Date: Wed, 20 Aug 2025 12:55:22 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Rajeev Mishra <rajeevm@hpe.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, <yukuai1@huaweicloud.com>, <linux-kernel@vger.kernel.org>,
	Rajeev Mishra <rajeevm@hpe.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size
Message-ID: <202508200409.b2459c02-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250814191004.60340-2-rajeevm@hpe.com>
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6118:EE_
X-MS-Office365-Filtering-Correlation-Id: 692c2017-45e7-4bd8-7196-08dddfa5ca26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R7FTkT0qZafxWFwvviAHM+Y0gT1rx8zlB8SB3JYpRzSiWqSWqDPOAnWpYtC3?=
 =?us-ascii?Q?kiiXP+O752RLgEUOsW+H3ATBD1uewGD7UjxCEf4iB52F4rB5FmNA7C9RT0ox?=
 =?us-ascii?Q?kk1pTntVgIjfL4E40Snlg6oplrZJ3evARKodlmQdLy/owRTxibXN1tJdeT8d?=
 =?us-ascii?Q?/ZbmZMJIUAy3UYCvgVQ1QZ33tf7g1/nW/OB6aIEJKhOxCLOOMphcd8jM9ZOf?=
 =?us-ascii?Q?l5D0JtD7cEEDWosKMg5uaA/xb4MVCJ1N4xOrhEuThzpeoAhT3i+5dOXdTRtA?=
 =?us-ascii?Q?PWuShj6nQiKa9Ne5f/p+/OQVEmTm2k11MUb27MIgDpS29pQpihJTqXrjPOje?=
 =?us-ascii?Q?uYzzm87vSLDTuFZY6AotQvybuD5/GMKcZlCB84QvJ+u6va09v/yMNetPv5LU?=
 =?us-ascii?Q?8+ZX8xJylSZyuoYqdlSYxQ0Sw9hNwkQsNiTEph+BsnKzzeKTTqBmo8Hr8ve9?=
 =?us-ascii?Q?1tBGrfNkNxaPdmMe2Z6b8WV2lA2nbPYfOjP8kyeT/sKL87baJ5FZtIgpwSjQ?=
 =?us-ascii?Q?MzBu0ho3WmTgjtwcpxj5s79oiEapo4dvtzQzRQ8oBDwxm2+tTszb5paCnIY1?=
 =?us-ascii?Q?kaf/1ZWb47YLAtk1RUNe3aafGrrpTRIdlg8HnlvmdAlG9r7rIarqEbr13cqV?=
 =?us-ascii?Q?eAtcvaoLQH1YSzo27Ccb1Z89DFc7hsJyuf+yVYFEf/5nUF7WspfynljBiMSp?=
 =?us-ascii?Q?5xyi3+rQ5EQKraUpcA7Tm+C5KeM7fG11MLAbOP3n9eWS5zFORtMZ5sUSoa+u?=
 =?us-ascii?Q?vjzm5NQK3obrL6j4jTaTj7DUbgiYXAQskW/6be/x0RnhOQoVHgd0clIgNSYU?=
 =?us-ascii?Q?Ihdh5Mg96iD0oNgwPX59l56JPfEzIrL2ftoSNDV6opewJI54MQK8Hi0Xm1hj?=
 =?us-ascii?Q?nbs8FwCav6mtzDkMSnC2vSGZAkwfxus9j4GMzXavl9zKVNSeBxpuhmq1prZk?=
 =?us-ascii?Q?2bmxRXFzNswlJc4RZv5XlLaXlQ+TFSIYVmbTexA3sTYWRnWiuYtEkLJ8b0nq?=
 =?us-ascii?Q?9qfxiIut2qKg88/Ksy9T+qPfIT7U26DpRekMptvGZx0+KVYMzUJnchT94r3d?=
 =?us-ascii?Q?/FrYvJzg96nQ0cvs2bHE3BJts2bm6PHvH4HImNt3XPi9YwDbePbNz/MSKj5p?=
 =?us-ascii?Q?fssDl5YHmZoWQLRtA2A7huiZY82Jx8KCNa88fUmMz85od590vVK8+bLfOpat?=
 =?us-ascii?Q?3UTaG1R1IuyUMWy3azArpBeKqWtsPe7HAGc1ayI236WJuOp2iP3RIEmoU1qv?=
 =?us-ascii?Q?aSYwrAoRXIylre3x7ve8u1eOvi12UHkS5+QcbQqYnl2e0jzXE4UsP34Do4Md?=
 =?us-ascii?Q?atE3BBeEJfVGLsrTB2tyb/TrB4BwjnriB27gwsmWX8oG6RvmBf/4CBKrqSxq?=
 =?us-ascii?Q?hhDPhWbEu5KnF1NAdFMLTCWPgr+7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q6Nhx7F7/aKwfBvQ/w19FZgrvbMGVaGKkYKs4yJLZjaN/jeY9YAvL50rPPaT?=
 =?us-ascii?Q?gQwfh7ACg7/15CdL2jWEzeTEENoJyb20UKYWwHVJnLfFXOMFHz2svMAvxWku?=
 =?us-ascii?Q?zvuVB4Ts6tMs3qxUEQtxJRvng7LpyRKfOp5Mz0rtBW0ei7BvWYB+FKbbWhsi?=
 =?us-ascii?Q?EH0nVjI4z5m7TINJhWTWuY51Zrmrwt/CpEjrl117gbbZKJRXP2M2jNwiZIRU?=
 =?us-ascii?Q?pUfoSFJIQA8/CbrEbBvGwbodH1QcrYvQxAOm8LrijrOjVHqK7uaClEoHEf1Z?=
 =?us-ascii?Q?E3fQ5aM7bZ+m1QJpN35PYaWEyisP80ehVwyEixHIospARk+3Ds7yUBZVmie5?=
 =?us-ascii?Q?6wde/l5mGQ6wimLTSNowh/HdT07HPHitYFf2oWzY5hI4SZDLwrW8JAs0Fl1G?=
 =?us-ascii?Q?9layU/+LX6CJdbKEn3OZcI7TPucd5iVPUylsTBAdjLJPFY6m4U89A7rvpmY/?=
 =?us-ascii?Q?L0+yQlCH6LwQe8+At9LP9qpcNa3MKpgkO8ofkQLZ2YHKbak1NUzdvloXiTwq?=
 =?us-ascii?Q?fn9NtMzfLp4jU4WsI99mFttqsI7hYogol+4y/TjAFGuKX5C9LeBo3TUQPoSW?=
 =?us-ascii?Q?Lyza9vvAFHAVb7wK1b/jHNNDoAzPVxMhln55J73FXc3YitACRPwOuBZSIYZp?=
 =?us-ascii?Q?hn+5nIkkIshs6pxy6dRI4WrhZJnkxdCX1tyxBbrE3MfnuJ0BfVcvTEjadAhG?=
 =?us-ascii?Q?+oerpxCKw1uJi1yBTUIa9vuMT+55fX3jFr1fTdwgNCtsmjDcubmJ3z+t25YY?=
 =?us-ascii?Q?uqY4PnH1Cpnx6A7Rgu/nDuhnxOK2baknnJ7OjPaRhqzeVUMxIx405QocA14A?=
 =?us-ascii?Q?3lHJK5AAOeu/k4ZcMVFBXCSwMS2WWt4a9PHaQqd+MAkLp71nBNOoq+XbjsI3?=
 =?us-ascii?Q?S08YRjiElFicEwTVTk3krFySdAOBoqQMn4j1LVEXf0GOSregHMUb4T9jLZ8G?=
 =?us-ascii?Q?VMJNaifREPstysK9lP90yFbu1tuYZlylXZNElYLNfmNCraL6SmGgvq1WE5N3?=
 =?us-ascii?Q?GMNvSU7zAGmRRkZMcmZe+xiy8ZFxfO/LXX5Li42ewXUdV3gyurAqbkHZl886?=
 =?us-ascii?Q?/9SjW6JSpYxHQcNDiBQYplQl9939EbIpmPXbQqQ9aOaWVXXCqcV3ruDhhrYf?=
 =?us-ascii?Q?Z9vsSgQYjzJYFUhT+wgCgDD4OQFWPN2thsBqN+201XDzGxf8dJuAB2a9R6kD?=
 =?us-ascii?Q?33o6nDiQTN4mnDbnnaOUcNQGtGHx8WhnzPH9SDOk25EKd/uGT+CKUcZTVN+z?=
 =?us-ascii?Q?vkhwyiBDgPpCLzRk/o1eDXRUxgCxjdH3G+DHxDdCRtTSHuYxRvJCittky8RI?=
 =?us-ascii?Q?Cor5gGLtQsD9DKkqcK3fTsziAQvtUX+bge3IUiDY7HqGdQ9/Cq6LBwV5DPEG?=
 =?us-ascii?Q?Q+zTJ9PlNB3K3G0ssHMvoVV5QcWv7+6MAtSTJP5wP+9MKKi2YcLY9arLzGAS?=
 =?us-ascii?Q?gqR5FOYSgqOGYEm/cvoF2xg0e9lnY0fkv35+Zb/sdJP5JxitQH2XB9j+22Nu?=
 =?us-ascii?Q?Xe6OIjZiaQDjygOv2XssxWo0cGSbCx/QnUPQnJqj6QHCsczifpdtiOzW2CwJ?=
 =?us-ascii?Q?hqBvRUT4IAIqFlWOlA9b+T1bF+AN7j/5+ToGEoabCc9K9FajCrCAPfCiUlxJ?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 692c2017-45e7-4bd8-7196-08dddfa5ca26
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 04:55:31.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uScq6Smq2n6KXPF2U3HsVZeaadh0vOMrSXLoVvRzeaUSnnbZ61T3JjYXzUoeME4xIN9fR4S6VffJEEpXSBn8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6118
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.563.fail" on:

commit: fb455b8a6ac932603a8c0dbb787f8330b0924834 ("[PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size")
url: https://github.com/intel-lab-lkp/linux/commits/Rajeev-Mishra/loop-use-vfs_getattr_nosec-for-accurate-file-size/20250815-031401
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20250814191004.60340-2-rajeevm@hpe.com/
patch subject: [PATCH v4 2/2] loop: use vfs_getattr_nosec for accurate file size

in testcase: xfstests
version: xfstests-x86_64-e1e4a0ea-1_20250714
with following parameters:

	disk: 4HDD
	fs: ext4
	test: generic-563



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508200409.b2459c02-lkp@intel.com

2025-08-17 21:02:18 export TEST_DIR=/fs/sda1
2025-08-17 21:02:18 export TEST_DEV=/dev/sda1
2025-08-17 21:02:18 export FSTYP=ext4
2025-08-17 21:02:18 export SCRATCH_MNT=/fs/scratch
2025-08-17 21:02:18 mkdir /fs/scratch -p
2025-08-17 21:02:18 export SCRATCH_DEV=/dev/sda4
2025-08-17 21:02:18 echo generic/563
2025-08-17 21:02:18 ./check -E tests/exclude/ext4 generic/563
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 lkp-skl-d03 6.17.0-rc1-00020-gfb455b8a6ac9 #1 SMP PREEMPT_DYNAMIC Mon Aug 18 03:05:49 CST 2025
MKFS_OPTIONS  -- -F /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/563       [failed, exit status 1]- output mismatch (see /lkp/benchmarks/xfstests/results//generic/563.out.bad)
    --- tests/generic/563.out	2025-07-14 17:48:52.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/563.out.bad	2025-08-17 21:02:31.367411171 +0000
    @@ -1,14 +1 @@
     QA output created by 563
    -read/write
    -read is in range
    -write is in range
    -write -> read/write
    -read is in range
    -write is in range
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/563.out /lkp/benchmarks/xfstests/results//generic/563.out.bad'  to see the entire diff)
Ran: generic/563
Failures: generic/563
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250820/202508200409.b2459c02-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

