Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BC6195
	for <linux-block@vger.kernel.org>; Tue,  3 Sep 2024 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725338565; cv=fail; b=gXpexgA6sztygQkj/ARxSY66iomKYDThfJdakeYq1sy5Hmeb/ZQbUc/dp9DKyu0iTL89w60wKUYCqRWwQZT3cXMwisok9CPMnDcCtX/00T/Zg3gBdfRfoBxgrKnmRRqnKD9HmGt4+EVQikYA2eEE2XZgY+D60F1rUL1vCxjs2HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725338565; c=relaxed/simple;
	bh=LzkOUsDW/BRR6Nmg1YWuqx83wE3R2i5wIzlga9AujSU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uQptt6tTVAdSNbG4vopa6rYESD/sxrm7/TtdoQH6D2NwshK8mQrFOvynVWFvfTxX2Yp1nMXGIy0JRxWQCCQ629cZ6DCUQkBflnVma/nQ9xrLvyFGqdlh4EQYsa2ox/03HtHxvT4nyPA6TPHPWA/B5yqGt4AQIW4lLk4PRqn1eGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a85tY4ZN; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a85tY4ZN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725338564; x=1756874564;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=LzkOUsDW/BRR6Nmg1YWuqx83wE3R2i5wIzlga9AujSU=;
  b=a85tY4ZN6QZubquIPaGpRtLNudNcQIFztYI27AxbauYiiTV93jgjUF8n
   pwh9/nChrAJin46cbczorZ54IPcygqj07FVUY2BzIROGIT5msc29wME7u
   /xiZYHT/+yt/kk82q5RJNpDA2MtSfRZ+IFPvjlNMHKYORjDBoghnHgysN
   pAhWeDeupa+aCKKbbqaaAlvArzTbdQlftudra/XgNdJyOqItWQ6F4NLwh
   XBXfcjCUBRLZk58XeT8UqY78N3FyzHj1Pw8NbL4SFmzHS02a9ZosvUsEK
   s/LrE18rV/yw4ilbYb9b1nDUMovUApWkWFxxtx/dfqK3ur20RcroprOCe
   w==;
X-CSE-ConnectionGUID: HMtAFFFOTtq9/Az2Eqjzvg==
X-CSE-MsgGUID: u4IE/+04ToaKssTmFTk7FA==
X-IronPort-AV: E=McAfee;i="6700,10204,11183"; a="23430512"
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="23430512"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2024 21:42:43 -0700
X-CSE-ConnectionGUID: jVgsY2TkQ5e6PlbMDclr9Q==
X-CSE-MsgGUID: 7Y3sRr4tQvmA4HKsDgGS5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,197,1719903600"; 
   d="scan'208";a="65505593"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Sep 2024 21:42:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Sep 2024 21:42:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Sep 2024 21:42:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 21:42:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jfcoy80bFxCtmCi8I9mheeJYJ3vi2q4/IaQmT2ACpF96dhziD0F7+JVyqd1+aJ9cKL++TSfq4ma6L997bR6A8KlmTm0XzIZqljkgxApWRiXe7Mc/gCdnzWOydknGUOO17QF4CP7euahgeliNadNQTyeoW++vuBYRPFZwqGtpG+c4lHL+3qxTZRD7Tvs//a0oNnLQOHWsBWWmJrCKGcse+KKWdwAtT8cPRNHwRsp1O43Adtva3os1NUsSgrYXvFBB+KvGqnAIhtVX+Dg5jH2cVzXnswmMXi+J0N2EkpSAqrqPppUM7aC2MdTaGtCAGtFYViNUswm3nSGFc4ERtJnxQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWhAYQXMD8gYL8/RwPgh2xh8F11k8znJjR9kInJgePE=;
 b=xyzf7xBl0YCqaeEyqJbD9G/qwpl0bU/k7PjVvca0dJhJI9SlwrG2V78MZvrc/5vIUKch9zQ5QPkNnpUeEnaNUh886DUhV6NgyqKoar/J+DbFdE2vrc8wciNitK75G32LSXdgyYF5UkegrhgRvVOHDn11c4TNd60Kh7AiKaKMfIfjlnTBfAR/x/kNxgdxVSjU9OIbv3ENQklPzQtjF2Zw+xrj0LBXNmg7BIRY4rYbq1bj20jjABf8p/oq+LBXB2lnm1Yd3uDs+ANfLUXTQAeoZVlUbESx/DOyRDTvPX2vvLeqtc3g8bwEfPELt4sBQGXH88TW9v2aQwjq096SRloFHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6529.namprd11.prod.outlook.com (2603:10b6:208:38c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Tue, 3 Sep
 2024 04:42:40 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.020; Tue, 3 Sep 2024
 04:42:40 +0000
Date: Tue, 3 Sep 2024 12:42:31 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Keith Busch <kbusch@meta.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] blk-mq: set the nr_integrity_segments from bio
Message-ID: <202409031022.47173965-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830185345.3696027-1-kbusch@meta.com>
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aef9da-d720-4e6a-6f7b-08dccbd2d798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BxmzjFf+sSC4V549tt4IxAQxGXQtiVA10o0Q6jsdE3yuJJI5vW2hNmjhGs3f?=
 =?us-ascii?Q?iKq3SogebZ3KnUARO3HAwakmGNuTvRm3woAGW7/lYo4yR9N/LpTBKsiTXoEe?=
 =?us-ascii?Q?zI3r7juQf1q6hYT47//Ouw9h/AlVHtNKN5/e2Ap8Wflb0kbpUQG4xGeMA8Zs?=
 =?us-ascii?Q?2Pacdwb1idg/HHpP+Pt316QJJhQsAQBw//LBbqcuj508sMp3AlIwutZ3/69h?=
 =?us-ascii?Q?8zNhy4YXdFzjdiixSP8JwVSLLmv0R6BODDM9HbJeSQ/wtn79l4QUHsOJhwxt?=
 =?us-ascii?Q?Q0hlypWtPzn2NkNDwTKEb6u3xPvL7CS9BSar0TJzOlZZlEUg24lBcWJo2he4?=
 =?us-ascii?Q?jKM2nZXX+1yNM1pRqvVGFQ8HD2Pa3TgBB56ARV+njCm6RTlbFKqmPkkfYSFV?=
 =?us-ascii?Q?1DcbyYyTkL0TOR4PRjP7la1NW/QV+4m6k3AZPgtBtZcuHQwMYVrYPPLbZGmO?=
 =?us-ascii?Q?fwLIMLZljyGaaaoiNBaunes7kNgV+yl6H32Kt7fP4Nhi2/C20GwFf3QZfcBj?=
 =?us-ascii?Q?F9TYcXacNa86ct2yw9iIUaxOhj+r6G+25vgJYCaB9oFyczxAKYLFbaU/eU6m?=
 =?us-ascii?Q?WuPvCD94D8zFZVrjLGe7Rl69L4gNwCpq5moQ7xEeBq6TgHFeJoa1ruuutU9u?=
 =?us-ascii?Q?xIibWmgAMorNfnWXBmGPakn0ofbGkc+Yko/CZYCsaRC6jDgujkFUeuN8Bhak?=
 =?us-ascii?Q?AurJ8EDKbKn2beaoVrOBotHDLEUBUrOn/o0V5NQJsRba9xierjFjFIRyU7Rm?=
 =?us-ascii?Q?5YeYG+YpkLvJuyJGsRYKT/WZJ/VxWKofO7uwi/1P2R+hyIKJaL6m6FVtjqiC?=
 =?us-ascii?Q?GlHfPkFZAat9YY6k36ZIwuDD2AhTm6CVMlkjvWrkKmRnRRBROFG2M9Pf7/QD?=
 =?us-ascii?Q?tUJ6bVpoCkNRpHn7AgSkk02dhe5Sg78cO0cwk0IW+SPOiDTFGqQznSc+rF6W?=
 =?us-ascii?Q?tET/2lAnj4MqzwdTKzUqq9DLFae8nuU6sbvicD3dRpKt2PBdnbKKqnRYx6a6?=
 =?us-ascii?Q?ZiyfpmlUWJQ4onWi39TuzhO0MFUkxIClXyB0SznGa0vjeWABXK6UTnwNBucU?=
 =?us-ascii?Q?aqtgjCm+YLvA4Ay6PRCPYdou8QRC99zsWAcTvymUojra1xxXLeRd7oMusivb?=
 =?us-ascii?Q?yCDspoXHnKP9DcrBfz51X88kzF88Uk7Rkrnic9bQIvdnHzsWJ+pAWsFT2Tc5?=
 =?us-ascii?Q?E+QsxYUhtnKFmyal49U33Nth30vjwYLs/N4ia+WMpz0x/Ab/8KHvc3vSjEKY?=
 =?us-ascii?Q?fQ3+LSGB8oLqRZZh5betOfQmZ600W1qbayONmpyyZ4+GWcVrMRV1nUc1/VK0?=
 =?us-ascii?Q?Sks=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J8rRfGpkQabjhzENjn2O8BI9SdsTlvCWgyjmG3nWghfWb9xTYA8RKfKaZkwl?=
 =?us-ascii?Q?+DqMLNOm81XLilgpEcJn9BtXBOCyfMmZrvoloNwf3gac9W0epUg/ztAALoms?=
 =?us-ascii?Q?GdpQITxmromQGCVpV+hvir4ZYVlXQXDw5jXVuo4yK6n3GeIUqVsQ2Yq7xZfn?=
 =?us-ascii?Q?lB1cCol3W1UzrWASI+xjxPdiBm3VfHbArr20CnWUlUVGr37DV1HZ9j79/87w?=
 =?us-ascii?Q?8tRMhzWK4xehg8aLqclWT9VoETP2Ci+JjoCDJfZozGOhsJ9JlCE38MMLD/wY?=
 =?us-ascii?Q?LcpJziAZ4QAve/UM0AyBI/zP4PhsuiTjWoxPjo4w0/9lHmpZnsJQyo740MxZ?=
 =?us-ascii?Q?AaywxiMSJmcENqXCRDlmt7/o0ziUxvl1PCvEiVmt6JKl2u6ur5wRUidkQtR1?=
 =?us-ascii?Q?ZqfWWyAHhxuo5NADCaBGQM0AIYUtZySUOOw7XmEZt5nj4JJbqdkrUbOMbvYr?=
 =?us-ascii?Q?FSc1hEuAYn63i+XKTdPn+0CdpfqeiQsdSN+CUQxxMcIWMUAkPpxdf81r7HWL?=
 =?us-ascii?Q?twXzteHWuARCgoHzmUCl7vA1jY3KL0qfar2IMDot68MwptOc2aGbwVXDS/W1?=
 =?us-ascii?Q?/atui8jeLoeT5gWB4E8BRB90LNaRfos42Z2EVUyLfyHVR4kknXvOu5XqBgBX?=
 =?us-ascii?Q?8I8bs6fwjx3afQ1J/QvEaxEfN7euAyu4zWbLuxVE6w3eMiZPppbF5yzo7svL?=
 =?us-ascii?Q?9o2avC5XZePOTsx7H/OSaoufPOvrGAGZaJAyqYrt5uUNr0ZEzNjTEFCeeqyy?=
 =?us-ascii?Q?k43f6EHs2tp7GC7YnUH/rs3+bkT2W2AVcrMH/mKfls/Vg1zuhOJ2SbddXApA?=
 =?us-ascii?Q?8NKbfO7X8StlMmS4LCSSc+o5R7FhHAHhBlm9vdWHvEHvnu09PjhFF/YGyjbn?=
 =?us-ascii?Q?ZSiAbO7IAYlJ38ZmlvOaIrg1aipNuA++lV9mkr3luI4duZX3bsZaH6cm0Bp5?=
 =?us-ascii?Q?dsRUArzqn0AWgIxXeVr4DU+phna4/soMI2dK+cnLGsrM4r2z1PIryyRYReBU?=
 =?us-ascii?Q?pip5haO97l9LKVDFqfpqb7KIq0JRjwJioutI5hItJp7kV547HUmWBKNYETRo?=
 =?us-ascii?Q?UWfrLlV/Lt7AMi72crTxecmNizaef11Aqo8gA8PTRyWdHzjxHqCdY+EYz4y6?=
 =?us-ascii?Q?OSc5dU7PKrbs756cXUwitEpmEwGp66UXCtUBAVshzlmwnQlu28zPoDHSdgTn?=
 =?us-ascii?Q?zLijIGvwxmWnW2rPRTLkNGiRySW91SGHmRHjVDjw+RVo81FIoMdAHp+yaYh2?=
 =?us-ascii?Q?fD8Fpn/rd4RNcuKXt60Cgo8OQcVg9ZbonZo7L3w0Tfwv7H6RNCjCF3dopUDi?=
 =?us-ascii?Q?YVfP7XcB3RUx0X2FOJPoCjovaihtXm4cbcRVElqKWCCmqbGaxYweNPjPz9ht?=
 =?us-ascii?Q?IyrBaDeu90SHjxkyz9AmSObfo9xXz5izhkgc39/gO2CYSCGeNRrVNWEGAk1V?=
 =?us-ascii?Q?rAYhwnmIk5qgmCqcEiTQEySgf5j++/OIxAgPbigOtRmauS9rH1BZuOpUl3dI?=
 =?us-ascii?Q?CCGaDO35/pfdwOqy2QVNOJ3z19UGn514PJ33cDJPBLaTaCTSVo8tuBjm+GTr?=
 =?us-ascii?Q?nmGwiDzks1SjEWbjOlb4OCyeT5uUaMgHS4UnOFrMDnx2KC14DZCUhrfbu8M2?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aef9da-d720-4e6a-6f7b-08dccbd2d798
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 04:42:40.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ObdgjNMULjBjXSOUcFy30rkFCXQf0CZx6uNMl8198mxfBEddEnqoclkp2kDzwFcL0PS72qojApKVpWyQaXUeVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6529
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_KASAN_PTI" on:

commit: d39ca28939760f793e6f4029f4269caef0885771 ("[PATCH] blk-mq: set the nr_integrity_segments from bio")
url: https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/blk-mq-set-the-nr_integrity_segments-from-bio/20240831-025504
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-next
patch link: https://lore.kernel.org/all/20240830185345.3696027-1-kbusch@meta.com/
patch subject: [PATCH] blk-mq: set the nr_integrity_segments from bio

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------------------------------------------+------------+------------+
|                                                                                          | 81c0619ef2 | d39ca28939 |
+------------------------------------------------------------------------------------------+------------+------------+
| boot_successes                                                                           | 24         | 0          |
| boot_failures                                                                            | 0          | 24         |
| Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]PREEMPT_KASAN_PTI | 0          | 24         |
| KASAN:null-ptr-deref_in_range[#-#]                                                       | 0          | 24         |
| RIP:blk_rq_count_integrity_sg                                                            | 0          | 24         |
| Kernel_panic-not_syncing:Fatal_exception                                                 | 0          | 24         |
+------------------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202409031022.47173965-lkp@intel.com


[   13.866675][   T10] Floppy drive(s): fd0 is 2.88M AMI BIOS
[   13.883660][   T10] FDC 0 is a S82078B
[   13.915762][    T1] brd: module loaded
[   13.934459][    T1] loop: module loaded
[   13.975366][    T1] zram: Added device: zram0
[   13.980204][    T1] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT KASAN PTI
[   13.980294][    T1] KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
[   13.980294][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper Not tainted 6.11.0-rc5-00104-gd39ca2893976 #1
[   13.980294][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 13.980294][ T1] RIP: 0010:blk_rq_count_integrity_sg (kbuild/src/consumer/block/blk-integrity.c:35 (discriminator 9)) 
[ 13.980294][ T1] Code: 24 10 41 89 fb 48 8d 79 60 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 b5 03 00 00 4c 8b 61 60 49 8d 7c 24 10 48 89 fa 48 c1 ea 03 <0f> b6 14 02 84 d2 74 09 80 fa 03 0f 8e cf 04 00 00 45 8b 74 24 10
All code
========
   0:	24 10                	and    $0x10,%al
   2:	41 89 fb             	mov    %edi,%r11d
   5:	48 8d 79 60          	lea    0x60(%rcx),%rdi
   9:	48 89 fa             	mov    %rdi,%rdx
   c:	48 c1 ea 03          	shr    $0x3,%rdx
  10:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  14:	0f 85 b5 03 00 00    	jne    0x3cf
  1a:	4c 8b 61 60          	mov    0x60(%rcx),%r12
  1e:	49 8d 7c 24 10       	lea    0x10(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
  2a:*	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx		<-- trapping instruction
  2e:	84 d2                	test   %dl,%dl
  30:	74 09                	je     0x3b
  32:	80 fa 03             	cmp    $0x3,%dl
  35:	0f 8e cf 04 00 00    	jle    0x50a
  3b:	45 8b 74 24 10       	mov    0x10(%r12),%r14d

Code starting with the faulting instruction
===========================================
   0:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx
   4:	84 d2                	test   %dl,%dl
   6:	74 09                	je     0x11
   8:	80 fa 03             	cmp    $0x3,%dl
   b:	0f 8e cf 04 00 00    	jle    0x4e0
  11:	45 8b 74 24 10       	mov    0x10(%r12),%r14d
[   13.980294][    T1] RSP: 0000:ffffc9000001f048 EFLAGS: 00010202
[   13.980294][    T1] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88813c415200
[   13.980294][    T1] RDX: 0000000000000002 RSI: ffffed1027ae1c3e RDI: 0000000000000010
[   13.980294][    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[   13.980294][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   13.980294][    T1] R13: 0000000000000000 R14: ffff88813d70e0e0 R15: 0000000000000000
[   13.980294][    T1] FS:  0000000000000000(0000) GS:ffffffff87797000(0000) knlGS:0000000000000000
[   13.980294][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.980294][    T1] CR2: ffff88843ffff000 CR3: 000000000776c000 CR4: 00000000000406f0
[   13.980294][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   13.980294][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   13.980294][    T1] Call Trace:
[   13.980294][    T1]  <TASK>
[ 13.980294][ T1] ? die_addr (kbuild/src/consumer/arch/x86/kernel/dumpstack.c:421 kbuild/src/consumer/arch/x86/kernel/dumpstack.c:460) 
[ 13.980294][ T1] ? exc_general_protection (kbuild/src/consumer/arch/x86/kernel/traps.c:702 kbuild/src/consumer/arch/x86/kernel/traps.c:644) 
[ 13.980294][ T1] ? asm_exc_general_protection (kbuild/src/consumer/arch/x86/include/asm/idtentry.h:617) 
[ 13.980294][ T1] ? blk_rq_count_integrity_sg (kbuild/src/consumer/block/blk-integrity.c:35 (discriminator 9)) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240903/202409031022.47173965-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

