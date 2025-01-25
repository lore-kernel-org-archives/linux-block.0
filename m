Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408235680;
	Sat, 25 Jan 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737811930; cv=fail; b=EYr9ss+LSvHTM88XC09Yfpvsmn/TBGdEpZm0jCyUn5jNCrwgL8HaRQb7hQzrro/X9/sjGf4Q5ZZD3p5wZvgjJu9GVS4ZmSU6ezkc3o1cRP+0l90HA5+fGOq1fJPRB+iCO9g52xbYUVxCwhG4Jcu4TmNETP9Zzs4dAI9D4ukFT9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737811930; c=relaxed/simple;
	bh=8QrtpsI0O8PdJDF35XtUzWN9NwZYhPgP13cZYnGZ5qI=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=I2Z6n7wsf7Vgt8eWmFKnHFHpkZua0ZG5kqvhl8a9bvBnXPYZcO+fDP+SM12z5QU3QLq1f4MBRmZAOAVvCiCLrW+QeUmyEhnaFhhVQymWVRzMpT1TkTJI+ho4G3jOOzumB2knJws1FMj3VGcRFQYF7eaHlIlL/aNv8MH9vO2Lc94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gj5ytX+M; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gj5ytX+M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737811928; x=1769347928;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8QrtpsI0O8PdJDF35XtUzWN9NwZYhPgP13cZYnGZ5qI=;
  b=gj5ytX+MuVpCNMwgN1XjyB1RtjFjsD+Pg58cQWAoU2Hwj2EBdT4V2q3J
   Y/JzRA0HfiYXmZPgy2mdcZsMrebLfvF+YLOWhNewxZvoVZ/+AjXo04us3
   2fQXFqZZgA8NjykfyWCdocoOkMkNJYaOn+IzcclnyZusvcHTKvIgiEZgX
   sFXssz8q8jUVFF0zO0xfyLR0c5znykAuGiYJ2GyEXNjYV0AxfboVFbvyq
   LiUq3AMGcbpOgxDqBQEVWSCMu95rXLQRf+ej2EmY5Fqc9pntFii1Fhtl4
   51/NC4a7R5i1KZKaUy84vfLSWw3cl+oQ3JLwmXoqxLWJFktpiFfwpTVbi
   A==;
X-CSE-ConnectionGUID: ItJah180RS+CAH41WwUbAg==
X-CSE-MsgGUID: 19grYd0hT6OuaxY38XJzcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11326"; a="55875866"
X-IronPort-AV: E=Sophos;i="6.13,234,1732608000"; 
   d="scan'208";a="55875866"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 05:32:08 -0800
X-CSE-ConnectionGUID: zFb2/OqFS16w2OwIPxRM2Q==
X-CSE-MsgGUID: KktAIWNSS4aZgqtCSkaz1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108449732"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2025 05:32:08 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sat, 25 Jan 2025 05:32:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sat, 25 Jan 2025 05:32:07 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sat, 25 Jan 2025 05:32:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMAKmE1TWlFDOt61+UNt05zBEA7eoFb9xg/QYA5YsOqlJ0uO1GK+OwhjOV6lS/uta59FojjAhQztmC0fGchdGrsepqI6us24OLe+TwI53xTvWn87Uuk7RI3ThYtpaQvDdQ5P4MAlnRi6mYPdLAZmbhUkih7FbTjE0Mvj+0RA0bJq9fOfQ7ancM+yEDwpfDFzZAWiqJXmBx0bBDDCqzyqXSkH4wK1jC9AGuzR34l0ttRkrlM+adoe4dnmJ9qsAI3iKR4bjmTY5EMzecAO98ITx1MBk7ikkSTbC9lcDZdFQHumPwjHtE8bw6JWrwAKwiCzaAarsSSOYwqPnalhDk8H6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVHFS8q3sROcAnKkbLMN+4WiB9Yk8H1r1QFcoed9gxM=;
 b=tJwJ1S7WhRWefU6wSZ12X6hPR94xXEJUcPKdVF7Zfbf+ajpQvpJnQnxbZ9OwHtwt02gNz5ShXES7aZciZ3oNDjFMfGMwf6LO0ZGrDGeVLiRdgvUfyto5PyGRHSMQAFm902BA6xR6/kQKc48rOyV3nVC/fIKT9zRRK18gGIWoOy476USUHBbnkVy+UI8q9+am1fvh0bzf2JRBd7U+JxnmEM1YK64Lx5yLr/fLZh0VDL/s74gOWWghYox5yK4YUW8bAd5rxZzqbac5NBDIPdQvTrNPnDZRX91VKNDL4kkglXK7Xul+nI7E1ML6LNm1LAgVN473gfW2hCE6qD+TUxIZnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB8551.namprd11.prod.outlook.com (2603:10b6:510:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Sat, 25 Jan
 2025 13:31:24 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 13:31:24 +0000
Date: Sat, 25 Jan 2025 21:31:14 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linus:master] [loop]  ae074d07a0: ltp.ioctl_loop01.fail
Message-ID: <202501252047.54df4ae2-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: a674d923-3a52-4cb5-38d8-08dd3d44902d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V5c+X64hxk3MEffI6OAPNIh4u+BunfOekrKCmH9gbCcFm1F9iOYO1WgObx3d?=
 =?us-ascii?Q?w+ZqrWee5wZyLVojDx2eokvx5uiVrKp1Ot303o9rs1A9a8PCNtTVa4HMfTAL?=
 =?us-ascii?Q?HP9tvSPV1To4ACulvaDY8BBlJ8MmFDEh2nNSCw2dN/FONsQ5kgUTYM6zIfgm?=
 =?us-ascii?Q?uaZ1IGRBhjLrfwtbNHVry2rETkC92h64bLAgO/b7IDjB1gIIULlu0RFxTfzq?=
 =?us-ascii?Q?vlgSKdFBytJP/fKQrno/eoPtSYDpw3ZpR2p162OzOTAc4w/Od7ZxUS51yDXC?=
 =?us-ascii?Q?rHEMGKUC9lHJE5AvVlEiXVFETWN5tx8EpRXajC3oqfFaZzZuHZzF/v1vkOOB?=
 =?us-ascii?Q?/DjMDgrvJm2YfsxlVW8VHVI2bdYSQ63luMghz1xFtdVdS5BckxcGRt/M5dmi?=
 =?us-ascii?Q?3GyBlyNyhAnD2wM00O+n/HTk1Fuxu2vmRWG7Yax+DCLyC72kQEWi7fC8xrSV?=
 =?us-ascii?Q?2z8vWt3zZQEjPJ1uSlDlKbGV+He7uQvweMESsfJ3wo5rkZ1LWjz5p/PwZEn2?=
 =?us-ascii?Q?GWQvoHPgo3+W/9712KZcbVGOYApypHkbNmrYByO+CrPDgoJ3hqkiRgRI27+b?=
 =?us-ascii?Q?I+wDaBhxpA5MLftBuNikPmzCSBmkmTmU0q4OW1Tl1nTBbyEQXSC02FISSpaZ?=
 =?us-ascii?Q?yIrex7p008AdOfsIv9ZWw5Cc1uPzTbxgPeeIQjOq3bpB/6ib9/rFZ0bbmsT6?=
 =?us-ascii?Q?yRRVRPWYH5oAEDoT7Z5WUSrpu1gDsGJpbnthMzShHdjhkKozRgOn7EJGFVhJ?=
 =?us-ascii?Q?Xxp2CHhLB+SR6d419vxW7yTPImqPit1r2RRGn2qAH2NX5unoBeKqW37PjruN?=
 =?us-ascii?Q?lTVHM8kX+An9mwAavtfZhczBhqrPZXgYoupLYDzRf3YSQF1t5m1/Sr/qF+rr?=
 =?us-ascii?Q?w9bCR7oX9Z5ta3CDNAimjmiI/Q4Xyy+EHLVVAaBETS6GLPyhyRqOqxFV1lDy?=
 =?us-ascii?Q?GqCqyJWTu48j+kb3IcIMdGHgoidtvLwnWz4u1mJqK9CV/dzXFJzbLRATyGOJ?=
 =?us-ascii?Q?8Hdr7rFC3ZYSNh7G4x8/rOAjygBKHwsf5OZCg4raVs3Hx5PEXFNDSE9sfg2t?=
 =?us-ascii?Q?C3jeYV/48wHUdSQPWTea9h5SiI15cZZcqiylv2KRpt+FJlbzbgEeoJ5q83Wq?=
 =?us-ascii?Q?7s9w/20c4kYxY9x/DaZvK/7MhTNXqd+d0V+Sr9eNR3mO63R7lfGjvqLMqjXp?=
 =?us-ascii?Q?1eLe95ith9QvaBLdNvqr0zBpXlFS2Cg+FUJFxuJRBCNJxex+jIsIddnsspdJ?=
 =?us-ascii?Q?AfFc5mZvDS5L+jw3oGKZDXISK22Jp22/L7j1KApnzR1dg5LWuvqSG8m/KCGB?=
 =?us-ascii?Q?Xp6U8K/0s6wJdZ6Uu1lOmjLUqIXsIA21Z2B4E5uRv+0j3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RE9YGvZVP/aogoUmg5KWX/uNOVKGwc6oQiRY9catB1nGmAShQebom4rDTcqp?=
 =?us-ascii?Q?FFKL9KQqQ9avCF4rUJPxWPHld815/XF/yUfOcc2LT6eO0ZahLScAVeCpFO1v?=
 =?us-ascii?Q?5Z9hsBV78oHWkOU9Mj+6ejzLy3b4ZrynUUUe0qL0SYGJ3FzL1IvHhYA79Ym3?=
 =?us-ascii?Q?RS7du0QqCZuvJEHLQFgR5Omsyy2rAr0grQkHCX/Ga624laTHt5/Vr+43lu1v?=
 =?us-ascii?Q?+GPKZsDR6+Bg7rtu5oEBhcBmb2qlcI9+5BMae+qQYGS5XT3FcBuQongKM2s5?=
 =?us-ascii?Q?LEijuEdtRHZwDWYAl3/ehHiZIrHuidTnb7aisG7iTwqYBH0/KCwPM6Cf2Q5o?=
 =?us-ascii?Q?/hSfN75FVUVxvXPYHl+5XgyWwGNKbhJMUJJ1fBtT9/Qul43mOEGg7jtgBm67?=
 =?us-ascii?Q?+h7J3sQfQrG/qPEbW9v8khuyyEg8ZWftt1TBpdV7tpuc0vqBm/Wh4jBV+Zt/?=
 =?us-ascii?Q?KTf1oH6Dyi45QTu4hklSZqlIZx2c7pJUBBKLmICy4JUXyE1TGAOo1A+FLAJT?=
 =?us-ascii?Q?xMunvuEoryMEhPTR+IFh7exbFGCp333+YLv2T6+AAGJHc1e+NtP6XWuqOCZu?=
 =?us-ascii?Q?HmdzjrrJREihwS90dis6xIUUHnLkqY+UeTNz/8xg6T2LXi7UbYFJp0U6ReZi?=
 =?us-ascii?Q?0HSFmI1yEfkEhhqjnJdIOwoLqxduXJU7AfRFwrKjO4q+ThA+OA/ToHcwmoUF?=
 =?us-ascii?Q?/A/MrXqoKzU2SSCCVVRXOAKYpG7I4bhsAg2h+Y3Huo4hzKUwr0zTXXJ8ne+Y?=
 =?us-ascii?Q?kkFXZhXSDDPdCicDY+MfSsTOQxF7XF5cwNc0NyAg19GHANtqLgdmXndlDu+9?=
 =?us-ascii?Q?cidbtB+6rorx2OO4szZx7Le87NvVsEpU1CbJJkqTFkYu0Z0QLk6CtqS8nAZR?=
 =?us-ascii?Q?+QcyHjkrEYtaWmBQC1gQq0DsocxeeJkQh2LuRK2Sof1FQ/I3/a0RiNj6L0qR?=
 =?us-ascii?Q?cCj1B7sKTBBSukyimFOhgi4h813zTiqDPDU5qq2HRD6iEb1dSjsC5oRRuI3S?=
 =?us-ascii?Q?J40hXLCKq1wV9EKoRVjBYcqD18unbJ01CxbG8NOaLw7C5w5uOXtS3Xr2/TgH?=
 =?us-ascii?Q?oNmBYyNAP/FP7owE6GG2RY7e6bfLforS1XR/49ZwThhMYtAxZ1VvKWwU7D99?=
 =?us-ascii?Q?3yt57t1s4hz6yOCphQYyuuh0KT/qT1WKV3uLWZbU+T5CD69qdpCjGGAXK53C?=
 =?us-ascii?Q?O3sIZMzjirzYXlNzWNZABNpgJ247upZAm/qQzzs6GQb+zeWc6dmZHEaqeIeV?=
 =?us-ascii?Q?vYmSXrMWxApSQFsSy1VO/4alxv2JTiQp5oi/7YPmJtrXb9M2lrgfin/mqcJN?=
 =?us-ascii?Q?4AWgF71gP28RAbMnRvMhxAeRkxo+GpdejrV6YsPNaqAqEcYEgda1FQw1Dict?=
 =?us-ascii?Q?ZKutx0ISJuKHXuGF5mL90z5sqC4ZIxGWseOTAjvhYGsaR09NoDhRFalJJC6O?=
 =?us-ascii?Q?Rf2eloJNTckw/5ANzGYozwU4RUjPkVHKlD2eKEpyYLwzgHYf3+4m6OEqMh8h?=
 =?us-ascii?Q?5TyCcki1zhOAlVtk6FG58SCkZ2CQ1azSs6PbvoCtoC7alKf0h11fKyur8mBW?=
 =?us-ascii?Q?HYNt8Hh/xYkbmiups+Kcu56ZGtLq62n3GlOBlw+brbiOEllk+AuJ5YEgkKDE?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a674d923-3a52-4cb5-38d8-08dd3d44902d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 13:31:24.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRsMah+FKz9LgU6kwZPt5mCiBPTGGg7w+llGISlSjt9LAc6ePWaXr+IgX8Wlgg+oMPYjtnJxTngu/dqqhUjGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8551
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.ioctl_loop01.fail" on:

commit: ae074d07a0e5c05769f1a9a2faa260c36d69465e ("loop: move updating lo_flags out of loop_set_status_from_info")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      d0d106a2bd21499901299160744e5fe9f4c83ddb]
[test failed on linux-next/master 853d1f41ba73e78d22e7075d9a95670aab187eba]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20250118
with following parameters:

	disk: 1HDD
	fs: f2fs
	test: syscalls-02/ioctl_loop01



config: x86_64-rhel-9.4-ltp
compiler: gcc-12
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake-E) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202501252047.54df4ae2-lkp@intel.com


<<<test_start>>>
tag=ioctl_loop01 stime=1737653109
cmdline="ioctl_loop01"
contacts=""
analysis=exit
<<<test_output>>>
tst_tmpdir.c:316: TINFO: Using /fs/sda2/tmpdir/ltp-OFRIRZBJcX/LTP_ioc76XFGO as tmpdir (f2fs filesystem)
tst_test.c:1900: TINFO: LTP version: 20240930-220-g02d5e99df
tst_test.c:1904: TINFO: Tested kernel: 6.13.0-rc4-00053-gae074d07a0e5 #1 SMP PREEMPT_DYNAMIC Fri Jan 24 00:58:06 CST 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
tst_test.c:1722: TINFO: Overall timeout per run is 0h 10m 00s
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
tst_buffers.c:57: TINFO: Test is using guarded buffers
ioctl_loop01.c:86: TPASS: /sys/block/loop0/loop/partscan = 0
ioctl_loop01.c:87: TPASS: /sys/block/loop0/loop/autoclear = 0
ioctl_loop01.c:88: TPASS: /sys/block/loop0/loop/backing_file = '/fs/sda2/tmpdir/ltp-OFRIRZBJcX/LTP_ioc76XFGO/test.img'
ioctl_loop01.c:58: TPASS: get expected lo_flag 12
ioctl_loop01.c:60: TPASS: /sys/block/loop0/loop/partscan = 1
ioctl_loop01.c:61: TPASS: /sys/block/loop0/loop/autoclear = 1
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
ioctl_loop01.c:70: TPASS: access /dev/loop0p1 succeeds
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
ioctl_loop01.c:76: TPASS: access /sys/block/loop0/loop0p1 succeeds
ioctl_loop01.c:92: TINFO: Test flag can be clear
ioctl_loop01.c:58: TPASS: get expected lo_flag 0
ioctl_loop01.c:60: TFAIL: /sys/block/loop0/loop/partscan != 1 got 0
ioctl_loop01.c:61: TPASS: /sys/block/loop0/loop/autoclear = 0
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
ioctl_loop01.c:70: TPASS: access /dev/loop0p1 succeeds
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:667: TINFO: CONFIG_KASAN kernel option detected which might slow the execution
ioctl_loop01.c:76: TPASS: access /sys/block/loop0/loop0p1 succeeds

HINT: You _MAY_ be missing kernel fixes:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10c70d95c0f2
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6ac92fb5cdff

Summary:
passed   12
failed   1
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=8
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240930-220-g02d5e99df

       ###############################################################

            Done executing testcases.
            LTP Version:  20240930-220-g02d5e99df
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250125/202501252047.54df4ae2-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

