Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A3727470;
	Tue, 17 Dec 2024 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445266; cv=fail; b=mDn82xtOZoRFk16grjUahyd+gAYyuhSFQ67txwMC64Td7Qpf5b6SpNIHu6znlBss+HHHd2efeBTvyoy69M2+oo4ocoD3hDtxoqKUOc8hOCE5uWW7WzDDkwfWXGdm99EINdAQm5XmwVj9VNSLTuBh01S7udQNDsyOcoUITi27M7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445266; c=relaxed/simple;
	bh=zRpKGXtjLbdjF22A1aCwBXV/VkmUjJjlhxwcq4myZR8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=WYyB/B81da65IpIMI8o0+W9M9qKSIntyrQ0eGf00qy0r1seLg2GIZok2TxurhI+xtRjEyGXUUEF9b06Y+M+aFt/usQpBMrORJlD2jRiTlCXbWNg7zvuHVTGl/1sQEQeUidvaLw1AjeVxrB1tvvCyDdZRjNlUx059VmBifIdTeD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWCGAIp3; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWCGAIp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734445264; x=1765981264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zRpKGXtjLbdjF22A1aCwBXV/VkmUjJjlhxwcq4myZR8=;
  b=EWCGAIp3KXp6BoQOW9I0i5kqkS3ZstlyEDMwECcsF9KQiPNrXj25PAn4
   Gvu27+MDLnlMS8/gltkw4OagixYpDXDzBh9UG2zyOxMxp3uPYpBxoWO4y
   Ru+vvJS+XZ6EUP8Wcotj40cmLSSSlK3vee5oh+VPj0mqUHybA09olJCsV
   kKpC8pyZsJtQQzczKl8a5/w9Jet9jLJ1gBgw5tzJAGnxyLPxe5Kf/TJAM
   lqyccTKQBUUBnRSBQOOn43z0CIgO6nQawb8aMPlERlGYnQKuvgW4AKeJp
   p2YnDRBlX5ZLTJoH+jPmHLKUnoFHH3iB9lcxtjBbPVqtux/jczMv3AGmS
   g==;
X-CSE-ConnectionGUID: MK3/UScvRTanhWHtSqz3Ew==
X-CSE-MsgGUID: tA5481MYTUisVq0LRfTyWg==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="37716372"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="37716372"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 06:21:02 -0800
X-CSE-ConnectionGUID: Qhoj8RwrQgCuv4tkEaKK6Q==
X-CSE-MsgGUID: migX1B05QJqd8Ps6GGkohw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134886036"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Dec 2024 06:21:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 17 Dec 2024 06:21:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 17 Dec 2024 06:21:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 17 Dec 2024 06:21:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEUxebomOqKhIT5jJpdNNKGC0+SCzsNvajI1mNFiN5DtMbS0HM/HzYT4Yx4OUWQfHLLMeaTRcojWzx5Tjh7p2XqUiARRo6NGpbFk/DTTl6BuLAOEKFD95gK7bev4hVc6I2e4GRrDx8f8eR0JHCRY4cl4Ba0G2MmJizDirxR7vMjvZnHCbA9pW2V3YWYGs+gj60f7sOjhcaV17mqOuYZJAK6dDiu4KqCmUB/EdjdYX6GCy0/nP5hm0UE/+IEgXAP/pFdlPrQOXF5ahu0HOgXizSq0Lio2y1f7h6XYewo3Pzshi1g64vrOLwbtdbLcbTBLHki0poFFeUJcP9QeK2mCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzhVGxY7ERXLeJ7iNT5wjyGM3b55IaR6ZW5MpF8YfuU=;
 b=jllv0eCzQLSbRt8zQtcT91jQeZ+wNsx0GqEcDdmOQ5S4WScCBDJu6xtOXui8mVttNqhXOLmoRm9fGESfk3IQpQTCpBd91DcKlgdJHWHGV58Q3KjceKm9yOvd3IfNr6dWuiu+5kN9sbEUaLvsngkCWCD4CO0HIFOIoTBCuJbICNJNGB4WXXuFLxD6+ZyiUR1NLdLGk4BCz1HycKKeTBSZ6+ajTTH/b8BE+p+BmU01VSN+VDvVFGR6c9Oeb65kVzpnPwnWUxM+xOKPw4sFYHi13q49+Rz/zN8UdlOvOT24Fluvd9pSxn3yyzj7TyM+x5i25StcjtOIW34BwHHF3W20QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7479.namprd11.prod.outlook.com (2603:10b6:510:27f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Tue, 17 Dec
 2024 14:20:58 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:20:58 +0000
Date: Tue, 17 Dec 2024 22:20:47 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Ming Lei <ming.lei@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, Luck Tony <tony.luck@intel.com>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [blk]  22465bbac5:
 BUG:KASAN:slab-use-after-free_in__cpuhp_state_add_instance_cpuslocked
Message-ID: <202412172217.b906db7c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc423a9-2bf5-4917-7aec-08dd1ea606df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x7Fq4VYk1vIqLxCHM5D96POVQl+CBA3ibvUUAASJ99KjJFOm5HjMCxJ4I8hW?=
 =?us-ascii?Q?wPGx2xcPg/euTekabmgrqH6iE85gXfYGjAIca7/mbTZR5QBtBGU39OSCnb9D?=
 =?us-ascii?Q?pIy+bj3Z1fuIOhxCH/tEo3HYo5GYf4W0L6DUwh7MbJRDL8IMs0DOPvcSUY4Z?=
 =?us-ascii?Q?EDd1R4GtRw4SpfYFScEGygdcGV4mXOVM5JUodVWCDGwj42kCCkQ/03yBj6nR?=
 =?us-ascii?Q?Q6vixdug18q5r675AW030cLzWGQ0Rw47vR8xgq+ezlnZZwPcYotfHAlsuRjN?=
 =?us-ascii?Q?9cH1C9K8jFYtmHzU1BlM48c421hkJd/0IoTZeYNG9l6CAeB4XVdWJVkbxjD5?=
 =?us-ascii?Q?yCgT2EsGqjA4s6Mu64f/otwqPHkKSgUInMLv+VGk/Xd9gmpjtlBQMgvY92LF?=
 =?us-ascii?Q?pl5883t3Q3T3AwWJau2SQfGye64ZScxFJ2/Xg8jglY+St8CELp81a7pyk+sb?=
 =?us-ascii?Q?QNtreHRCf1GAhwIrKDDeE/MiTSFTm/h50KJ5StvbKQOmdbpOZNUjlIryxmRo?=
 =?us-ascii?Q?c4iaOszbRKsklABzSY14+E+Dp/FZXazgqoHiyPpKqv8lq1n2T+k9qMTeNNnK?=
 =?us-ascii?Q?I3GjzXZiWiKswAGjQEIzrvI9d4otZKlBoYrtNS122w1HaQqd+R5e/Ckf52u+?=
 =?us-ascii?Q?WM66JCfiXlRBCikXtPTIiLRPCmRvb0hhZYkzOj+QSh5u3nkgCaAtfc8SjbUF?=
 =?us-ascii?Q?Doyb5VPsNZtSDmtF8wsbipci1wm1ax4gqaTJ8vdVnt8Glq7l3z+xOAT21omp?=
 =?us-ascii?Q?9EDLgfFUJgxZOSUNz+7MyKDqTfcXUw3/Qx44Fd1EsYyoYydc+1ghQOyv8yLR?=
 =?us-ascii?Q?vcz+dtaGt6lFDGGsPnOjlDoDUUnT3XL5mlP5NmfYkeHY6295P4FNLAgF9KEZ?=
 =?us-ascii?Q?mxmVoQGsq0dhCi1zLGxQDd90d1TxWBsAFBudpiJOp7WwBBza2FXcria5+c1L?=
 =?us-ascii?Q?pnh096QMAITmUTIwZVmHadopHaLdT3V0zb3SgtUbWxpYc0PELsVrvsoeALvo?=
 =?us-ascii?Q?J9Zcqffc/qF4FNZuIalVBjOHRciPXEkQII2I1r+0LAGSyXZhg09E0sS4kqdG?=
 =?us-ascii?Q?8shqJuwpJP0Y4K339qILxVPyfi43YJlxBuLq0qnu0+jKjakIk/IO7lCPhZ2M?=
 =?us-ascii?Q?I+QvFjkDcoGsI1FKXPILoDdy8bjwtpmK7YfKWz2NW+hGODILgfHnZN+TcYzu?=
 =?us-ascii?Q?Mt91y85savvW99rDq2LApG8LCHEtNzjhTINkz2EwyQLER1zCRH6Y1qmb1/sE?=
 =?us-ascii?Q?Uq32cu44z5WO8MZzrHUlCHP4gtSKP8fCScclhCLR+l0M6fGsqGW7AW4B2eLB?=
 =?us-ascii?Q?Ikq7HGdQuiycemQPV8bTsD7SbE1/IwQvKVFZz9x7Ldl+3A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0s1GF4czDNYM0yWr51XMX4Uoe7I8Jbn6NxRB2A6w3ZnPAFZXaq7ixLoAEE/I?=
 =?us-ascii?Q?uW7KgNKAMupJ6atrkTmArCihIQT62BC2c5aH3ROCOXHo+xAtHladubWYOD/t?=
 =?us-ascii?Q?jx/jOSLtxWYTNbWBWeqiCQgrvQzLsrJbnSSqAqgLUw0yJuCq1PkN33cMzGJ0?=
 =?us-ascii?Q?rNgiKMqLT5WhbsS0ARCR+1SPsfpJGcCUFtVS4kO4RRbpkzPnM9zPgnuJkdwG?=
 =?us-ascii?Q?UidrEJonCTluzr0S+1dcyl+xgK1F9T72JyD3/Is/4cVDMFhkXNs9C5U0SIbK?=
 =?us-ascii?Q?VZie696nHc4oKXatSrtxSM+H1GCBTQ5/RHQQ231InuPxd6kktcox71htNZ+2?=
 =?us-ascii?Q?ZoEOrw+ygsouz1H/AQSyh76a1jZws+ovwfiDlpXRAb1HZQzFLGP4VCJn8d6P?=
 =?us-ascii?Q?yIeNWL2ym+RKedmKA9VM/cMU6A/Q/ETWL8UXYncAqVjOSrFrhpfqnQwgF0hY?=
 =?us-ascii?Q?zdTSQYAAFT4wwbcB7qHUB5HPpLqx+HVaEitFOi1pry7sDYF2l6uWaetidspJ?=
 =?us-ascii?Q?1rSUVfh9NVSascatyorZM8GTr4sFW3156kglhvZUtWEyGi/FEjHE5YP3h4pQ?=
 =?us-ascii?Q?c+bBv/q5/aXhNYalEtq2/2HtHJIHAAVnhZXvlxnTj30jojDQpScnNvJ2Ndb2?=
 =?us-ascii?Q?e5x7OF/qrECp/pYfmUY4naH9wBT2MJ5ZlH+qn2TQyU7Spk6OYiPP6A7Vp3Zl?=
 =?us-ascii?Q?ZiDqVW7anhhCzbUcYxggw6RpAvwph0SY7MDYGu1mCEH0AUCMHSg9IzNtKPPk?=
 =?us-ascii?Q?93EYM5pY+q8UvX5Sb+5u9GipmeotnyznmPYqOCae5U1koU/iX+RzyWWI7LcI?=
 =?us-ascii?Q?+3fgPLWIcm9bY+R9cTksEh36yLkn+gxc+Mv20wpZq1gypTiiTOIMRrB6ev4x?=
 =?us-ascii?Q?NXyOVjaJ9r33ALEKlqPlXRUyEz3noSee5lGvKqRoth1RH6s2CguEgAwVUEwb?=
 =?us-ascii?Q?yqgjYJfTRZCZMpE51zCFqLtwwoLXWNRlELO1vxKEgxTMrbdrjnEfzEahyudS?=
 =?us-ascii?Q?nifLzVQDbRquTWdQ6kWI+KnPNL6vNBAJWuEcjYpivt99TA9qfxGTqVWaYMGc?=
 =?us-ascii?Q?wQgMVOsMlzwa9GXqheM203cEvpIxK1xg0gn+N7Lsfi+ZwU8ZMgbkK5eXDq9X?=
 =?us-ascii?Q?RUbRE+ZBNqHiVRsUMJpZ9Iw2ZZxGQauxpyMZQXL7FT/2QitQrLta/IvskibH?=
 =?us-ascii?Q?A5TuqVBSjvLwdKnvatu6qWfhiq5D8BNO6sRDA3t7En7PQTewLCJ060K0LpqP?=
 =?us-ascii?Q?dAgUWn7pbivX4ZAJSt33MS69vESAtVwjE+KNVFmH3ApgCZnO4wp55Z1bORGF?=
 =?us-ascii?Q?Up8ZFsJOELhKv4YqRgDV20JdDSrMeY2CqXMkuCm7xUYqWa8fuCRCUT+311m/?=
 =?us-ascii?Q?xcVHgbs22ukXB0N77dNpkNUclAst5G0sv2x366GxSvZanO98K5GUoinDwRHb?=
 =?us-ascii?Q?ffPrYr2DvI3Kpuyv7b8DZ8MxgbgvLZJxRBSIXgE2HdDmSzhpLuoPF1NE0Qua?=
 =?us-ascii?Q?Ee64Rg28KProsklMbLwS+5tfI+V0KS7hIzVkIP0ixwdljRO7GK0Jr5G05yW4?=
 =?us-ascii?Q?QzPdo5BFugEPhl6HwI3QB1ECf9G422NnKQa2glJXnhYUH4/V2WbO5dFFwU7b?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc423a9-2bf5-4917-7aec-08dd1ea606df
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:20:58.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeFCqW2wNh9yX3EoyqaFxqBJAZE3ofwAD/71zh5qOb0wWuFHQJqi6IzAsu1YGTjt5Xi6VzAcrRyModT/krOVow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7479
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__cpuhp_state_add_instance_cpuslocked" on:

commit: 22465bbac53c821319089016f268a2437de9b00a ("blk-mq: move cpuhp callback registering out of q->sysfs_lock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      231825b2e1ff6ba799c5eaf396d3ab2354e37c6b]
[test failed on linux-next/master 3e42dc9229c5950e84b1ed705f94ed75ed208228]

in testcase: blktests
version: blktests-x86_64-3617edd-1_20241105
with following parameters:

	disk: 1SSD
	test: block-group-01



config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412172217.b906db7c-lkp@intel.com


[ 232.596698][ T3545] BUG: KASAN: slab-use-after-free in __cpuhp_state_add_instance_cpuslocked (include/linux/list.h:1026 kernel/cpu.c:2446)
[  232.606144][ T3545] Write of size 8 at addr ffff88880ca5d968 by task check/3545
[  232.613424][ T3545]
[  232.615602][ T3545] CPU: 3 UID: 0 PID: 3545 Comm: check Not tainted 6.13.0-rc1-00018-g22465bbac53c #1
[  232.624789][ T3545] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[  232.632859][ T3545] Call Trace:
[  232.635994][ T3545]  <TASK>
[ 232.638783][ T3545] dump_stack_lvl (lib/dump_stack.c:123 (discriminator 1))
[ 232.643131][ T3545] print_address_description+0x2c/0x3a0
[ 232.649563][ T3545] ? __cpuhp_state_add_instance_cpuslocked (include/linux/list.h:1026 kernel/cpu.c:2446)
[ 232.656244][ T3545] print_report (mm/kasan/report.c:490)
[ 232.660497][ T3545] ? kasan_addr_to_slab (mm/kasan/common.c:37)
[ 232.665273][ T3545] ? __cpuhp_state_add_instance_cpuslocked (include/linux/list.h:1026 kernel/cpu.c:2446)
[ 232.671947][ T3545] kasan_report (mm/kasan/report.c:604)
[ 232.676118][ T3545] ? __cpuhp_state_add_instance_cpuslocked (include/linux/list.h:1026 kernel/cpu.c:2446)
[ 232.682795][ T3545] __cpuhp_state_add_instance_cpuslocked (include/linux/list.h:1026 kernel/cpu.c:2446)
[ 232.689297][ T3545] ? __pfx_mutex_lock (kernel/locking/mutex.c:257)
[ 232.693984][ T3545] __cpuhp_state_add_instance (kernel/cpu.c:2458)
[ 232.699364][ T3545] blk_mq_realloc_hw_ctxs (include/linux/cpuhotplug.h:402 block/blk-mq.c:3774 block/blk-mq.c:3826 block/blk-mq.c:4497)
[ 232.704571][ T3545] ? kfree (mm/slub.c:4598 mm/slub.c:4746)
[ 232.708393][ T3545] ? __pfx_blk_mq_realloc_hw_ctxs (block/blk-mq.c:4453)
[ 232.714117][ T3545] ? null_map_queues (drivers/block/null_blk/main.c:1502 (discriminator 2)) null_blk
[ 232.719852][ T3545] __blk_mq_update_nr_hw_queues (block/blk-mq.c:5021)
[ 232.725578][ T3545] ? __mark_inode_dirty (fs/fs-writeback.c:2619)
[ 232.730610][ T3545] ? __pfx_rmqueue+0x10/0x10
[ 232.736092][ T3545] ? kasan_unpoison (mm/kasan/shadow.c:156 mm/kasan/shadow.c:182)
[ 232.740605][ T3545] ? __kasan_unpoison_pages (mm/kasan/common.c:136)
[ 232.745810][ T3545] ? post_alloc_hook (mm/page_alloc.c:1539)
[ 232.750497][ T3545] ? arch_stack_walk (arch/x86/kernel/stacktrace.c:24)
[ 232.755098][ T3545] ? __pfx___blk_mq_update_nr_hw_queues (block/blk-mq.c:4980)
[ 232.761344][ T3545] ? mutex_lock (arch/x86/include/asm/atomic64_64.h:101 include/linux/atomic/atomic-arch-fallback.h:4296 include/linux/atomic/atomic-long.h:1482 include/linux/atomic/atomic-instrumented.h:4458 kernel/locking/mutex.c:146 kernel/locking/mutex.c:260)
[ 232.765512][ T3545] ? __pfx_mutex_lock (kernel/locking/mutex.c:257)
[ 232.770200][ T3545] blk_mq_update_nr_hw_queues (block/blk-mq.c:5064)
[ 232.775580][ T3545] nullb_update_nr_hw_queues (drivers/block/null_blk/main.c:406) null_blk
[ 232.782002][ T3545] nullb_device_submit_queues_store (drivers/block/null_blk/main.c:424 (discriminator 3) drivers/block/null_blk/main.c:443 (discriminator 3)) null_blk
[ 232.788944][ T3545] ? __pfx_nullb_device_submit_queues_store (drivers/block/null_blk/main.c:443) null_blk
[ 232.796490][ T3545] ? kmem_cache_free (mm/slub.c:2303 mm/slub.c:4598 mm/slub.c:4700)
[ 232.801262][ T3545] ? syscall_exit_to_user_mode (include/linux/resume_user_mode.h:50 kernel/entry/common.c:114 include/linux/entry-common.h:329 kernel/entry/common.c:207 kernel/entry/common.c:218)
[ 232.806900][ T3545] configfs_write_iter (fs/configfs/file.c:207 fs/configfs/file.c:229)
[ 232.811845][ T3545] ? __pfx_configfs_write_iter (fs/configfs/file.c:221)
[ 232.817311][ T3545] vfs_write (fs/read_write.c:586 fs/read_write.c:679)
[ 232.821393][ T3545] ? get_close_on_exec (fs/file.c:1222)
[ 232.826167][ T3545] ? __pfx_vfs_write (fs/read_write.c:660)
[ 232.830767][ T3545] ? folio_xchg_last_cpupid (mm/mmzone.c:109 (discriminator 14))
[ 232.836061][ T3545] ? __pfx_ptep_set_access_flags (arch/x86/mm/pgtable.c:505)
[ 232.841697][ T3545] ? __pfx_pte_mkwrite (arch/x86/mm/pgtable.c:903)
[ 232.846472][ T3545] ? fdget_pos (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/file_ref.h:171 fs/file.c:1181 fs/file.c:1189)
[ 232.850726][ T3545] ? do_wp_page (include/linux/vmstat.h:75 mm/memory.c:3277 mm/memory.c:3745)
[ 232.855156][ T3545] ksys_write (fs/read_write.c:731)
[ 232.859238][ T3545] ? __pfx_ksys_write (fs/read_write.c:721)
[ 232.863927][ T3545] ? __pfx_handle_pte_fault (mm/memory.c:5758)
[ 232.869141][ T3545] ? __pfx_expand_files (fs/file.c:270)
[ 232.874007][ T3545] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 232.878357][ T3545] ? __handle_mm_fault (mm/memory.c:5944)
[ 232.883396][ T3545] ? __pfx___handle_mm_fault (mm/memory.c:5853)
[ 232.888702][ T3545] ? __count_memcg_events (mm/memcontrol.c:583 mm/memcontrol.c:857)
[ 232.893913][ T3545] ? handle_mm_fault (mm/memory.c:5986 mm/memory.c:6138)
[ 232.898699][ T3545] ? do_user_addr_fault (include/linux/rcupdate.h:882 include/linux/mm.h:741 arch/x86/mm/fault.c:1340)
[ 232.903736][ T3545] ? exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:92 arch/x86/mm/fault.c:1489 arch/x86/mm/fault.c:1539)
[ 232.908250][ T3545] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  232.913976][ T3545] RIP: 0033:0x7ffb9ce86240
[ 232.918232][ T3545] Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
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
[  232.937637][ T3545] RSP: 002b:00007fffc21695e8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
[  232.945886][ T3545] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007ffb9ce86240
[  232.953684][ T3545] RDX: 0000000000000002 RSI: 000055dbf9920c00 RDI: 0000000000000001
[  232.961480][ T3545] RBP: 000055dbf9920c00 R08: 0000000000000007 R09: 0000000000000073
[  232.969279][ T3545] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
[  232.977076][ T3545] R13: 00007ffb9cf61760 R14: 0000000000000002 R15: 00007ffb9cf5c9e0
[  232.984876][ T3545]  </TASK>
[  232.987746][ T3545]
[  232.989925][ T3545] Allocated by task 3545:
[ 232.994092][ T3545] kasan_save_stack (mm/kasan/common.c:48)
[ 232.998604][ T3545] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
[ 233.003120][ T3545] __kasan_kmalloc (mm/kasan/common.c:377 mm/kasan/common.c:394)
[ 233.007546][ T3545] blk_mq_alloc_hctx (include/linux/slab.h:924 block/blk-mq.c:3937)
[ 233.012233][ T3545] blk_mq_alloc_and_init_hctx (block/blk-mq.c:4436)
[ 233.017782][ T3545] blk_mq_realloc_hw_ctxs (block/blk-mq.c:4469)
[ 233.022989][ T3545] blk_mq_init_allocated_queue (block/blk-mq.c:4524)
[ 233.028714][ T3545] blk_mq_alloc_queue (block/blk-mq.c:4345)
[ 233.033573][ T3545] __blk_mq_alloc_disk (block/blk-mq.c:4388)
[ 233.038347][ T3545] null_add_dev (drivers/block/null_blk/main.c:1941) null_blk
[ 233.043731][ T3545] nullb_device_power_store (include/linux/instrumented.h:82 include/asm-generic/bitops/instrumented-atomic.h:41 drivers/block/null_blk/main.c:496) null_blk
[ 233.050064][ T3545] configfs_write_iter (fs/configfs/file.c:207 fs/configfs/file.c:229)
[ 233.055010][ T3545] vfs_write (fs/read_write.c:586 fs/read_write.c:679)
[ 233.059092][ T3545] ksys_write (fs/read_write.c:731)
[ 233.063172][ T3545] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 233.067513][ T3545] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  233.073237][ T3545]
[  233.075414][ T3545] Freed by task 3545:
[ 233.079234][ T3545] kasan_save_stack (mm/kasan/common.c:48)
[ 233.083750][ T3545] kasan_save_track (arch/x86/include/asm/current.h:49 mm/kasan/common.c:60 mm/kasan/common.c:69)
[ 233.088261][ T3545] kasan_save_free_info (mm/kasan/generic.c:585)
[ 233.093122][ T3545] __kasan_slab_free (mm/kasan/common.c:271)
[ 233.097721][ T3545] kfree (mm/slub.c:4598 mm/slub.c:4746)
[ 233.101370][ T3545] kobject_cleanup (lib/kobject.c:689)
[ 233.105979][ T3545] blk_mq_alloc_and_init_hctx (block/blk-mq.c:4446)
[ 233.111539][ T3545] blk_mq_realloc_hw_ctxs (block/blk-mq.c:4469)
[ 233.116754][ T3545] __blk_mq_update_nr_hw_queues (block/blk-mq.c:5021)
[ 233.122486][ T3545] blk_mq_update_nr_hw_queues (block/blk-mq.c:5064)
[ 233.127876][ T3545] nullb_update_nr_hw_queues (drivers/block/null_blk/main.c:406) null_blk
[ 233.134304][ T3545] nullb_device_submit_queues_store (drivers/block/null_blk/main.c:424 (discriminator 3) drivers/block/null_blk/main.c:443 (discriminator 3)) null_blk
[ 233.141245][ T3545] configfs_write_iter (fs/configfs/file.c:207 fs/configfs/file.c:229)
[ 233.146194][ T3545] vfs_write (fs/read_write.c:586 fs/read_write.c:679)
[ 233.150274][ T3545] ksys_write (fs/read_write.c:731)
[ 233.154355][ T3545] do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
[ 233.158708][ T3545] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[  233.164431][ T3545]
[  233.166607][ T3545] The buggy address belongs to the object at ffff88880ca5d800
[  233.166607][ T3545]  which belongs to the cache kmalloc-512 of size 512
[  233.180477][ T3545] The buggy address is located 360 bytes inside of
[  233.180477][ T3545]  freed 512-byte region [ffff88880ca5d800, ffff88880ca5da00)
[  233.194071][ T3545]
[  233.196248][ T3545] The buggy address belongs to the physical page:
[  233.202492][ T3545] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x80ca5c
[  233.211156][ T3545] head: order:2 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  233.219471][ T3545] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[  233.227097][ T3545] page_type: f5(slab)
[  233.230921][ T3545] raw: 0017ffffc0000040 ffff88810c842c80 ffffea001ffdb900 dead000000000002
[  233.239324][ T3545] raw: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000
[  233.247742][ T3545] head: 0017ffffc0000040 ffff88810c842c80 ffffea001ffdb900 dead000000000002
[  233.256233][ T3545] head: 0000000000000000 0000000000100010 00000001f5000000 0000000000000000


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241217/202412172217.b906db7c-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

