Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2321B580F
	for <linux-block@vger.kernel.org>; Tue,  2 Jul 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927965; cv=fail; b=IYzmAE9TRMMRHj2SS80qjsYXitb0YLVOPVg/0jcw6DTmjIQK+z6vBu4gOv0kmBHbpPYjf6EQT7qtLavQ0EzXmF3+EZcgTrIkk7PNWqhI7C0ZZSnaoDHzMl/nicVof4DKgY7v9+OA3jr8MXplwLRWmTnfk9i4wPg3RM6eIPi5y/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927965; c=relaxed/simple;
	bh=tiE1oIoPfwhCbC423zVccNq2ZWx4A4/48TouHcUKF28=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=lW+rvZPvaNFeeiFOBtHGHPHdRXGFPjS0oAufuhX4+1+EJbsPWywnWzrrJTvAM256hWNmkLiI4Q4aU21BAJUPlRLLcV0RQLo7GLO/P2oH9l7lUayGJMLnHlLAbmsSu4mTfyqs7Czk5C+Ff/TU5JYpcX4M609OGopiLixar8JtEuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iEb6dqrP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iEb6dqrP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719927964; x=1751463964;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tiE1oIoPfwhCbC423zVccNq2ZWx4A4/48TouHcUKF28=;
  b=iEb6dqrPBnEM5XZkQt4Ud18cnj8QdKa9q2TGdxRVtsjysxklOn7AoqGm
   /POUIgespJscN19k5B0hif/AzAowCvPSQIAxbSz9mWYz0iXg7rfPSjjUs
   dL81CsDMBiTSkCBnv7vSvb7EB4sdArnd7zBcD9PKIeDbhqQEnbbQWiVi2
   0d0TO0eO7/Tuyooc3JuP2X8hZncgXMVzu5iTZouvrzDcC6rLuE9zotqqf
   /E0z9FM9WzTltIDJCaXmFiiPyvh+OmzD8n2/oAma1lBJZ8gvjPwnA2Tgj
   lxntokPnT7whRdnlHVO3X4ycIK4oNGPDdi4TcCLWhz2IZedBpQFQrGpLX
   w==;
X-CSE-ConnectionGUID: qi7goRthTHKt54qI6548RQ==
X-CSE-MsgGUID: auZzRwN7SQ+yhMKn8bwXJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="12357925"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="12357925"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 06:46:03 -0700
X-CSE-ConnectionGUID: 3kFQfNYISy6USM6SslWEig==
X-CSE-MsgGUID: 2JPuZ2pUSPiSYCMvlE4fMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="45801515"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 06:46:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:46:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 06:46:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 06:46:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8qarnIV7kk6FzwasacLhMCc0OAH9NHelTagofMdjc/Ogz51S9dhZPoEUrC8sV4QeFFtCyN5yUNo+ReZDjnHbkqdUvUZVQC0Im12EPJqzjyckFFXpeHssCpwdQgtEORZy8D9iIjnp8A+IC60lJVInzIRn3UFSJTJsB3pPSq3iG7c1DBy/Llb/pe5Gyzm9FpPecLNWHXnHJQf8HShqZPiJyMBU1n6LJdS+pLyznwv2RyfHMqr53q25oMfRar5Bu+6pMtFx+86mDCYsPMtYoRQAKExkC1bMSe9Hjv7dCULVd4EcsPZQZnhSPIa8nfS/sh0c8MWRduffoGEhnX6uP5Gfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jzsGjrCR+YFcQMsznwpzC5CwolDa0d4jyxAhJ+FXS2s=;
 b=QZdDa3N1gtdO0Mo2Al3XlSFDF0TOVyho0/MVStBDllQ1PWktjbaxkhCcOrjryKegQdLQ8X+G/YPpZqxkvf4A8JZ7GNGxONk2VxVrPj9Sy2ZpcEg3SvQDOhyBz0+t1/ZuswVmgfqA8FiMbOQ4MbPmW2A26tcCMAgBioCVgVZ8dqlV3nDVdGq4lsYqnLdMzXb84bvjDpKHphDcVDNn2UxSIcO5zyDYrdZn1zqXy6+cYKI9XOfBi5ZfIYbmBjXIbYXUFZMvEvrgqFtN1qlhb300W5vppNTZnPb4hWvq5D1glbC6XbPEv/xAGL9ewo5ulHRvheYvsjYBIUqRppdgEBiNjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Tue, 2 Jul
 2024 13:45:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7719.029; Tue, 2 Jul 2024
 13:45:59 +0000
Date: Tue, 2 Jul 2024 21:45:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, <linux-block@vger.kernel.org>, <ltp@lists.linux.it>,
	<oliver.sang@intel.com>
Subject: [linux-next:master] [loop]  18048c1af7: ltp.ioctl_loop06.fail
Message-ID: <202407022125.e7ba93db-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0016.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::20) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM6PR11MB4691:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5823eb-871d-41e2-764a-08dc9a9d4e50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AK5zkjMtU+v4Cex6FAngL2vR0VoGAN/6v7qudbAzerU4tsV+ZLClBLkMfovR?=
 =?us-ascii?Q?U70Q9Yj9vrpNGTZ0FYey+sgXBKlX1TkC/w/R6E/PTO5e10o8S0YJkp8dT9Aq?=
 =?us-ascii?Q?LUJubo0ZDStxk8HVOlaXauBZehyGabH8wHFuCzi/qEEI3DyCcJzcznSsaD4Z?=
 =?us-ascii?Q?GRGnvjntSlei+SClxQXugpRhsps6m0Y58pPX+5LK6f64XoltAEXOaF+o+bXA?=
 =?us-ascii?Q?1rC1VmcKlPDru167Vn9prNBCrrJWFA4+E2Hjr65Uyi1n/fbd4nXx2Bt2N4U7?=
 =?us-ascii?Q?oDFRy3wFCKHbYv7DztNgn6pgTaXtSV+uf8PUhjBGQLaMgYXC+rcxcAi9wxis?=
 =?us-ascii?Q?WQ+zHRpnJW8nQs3+6MMbm8m7RKBx7X+ibRRroJmOVQe0GUK/4VqLOQCacsR9?=
 =?us-ascii?Q?QUhUN6zbtoxe2tKjdtam65MCW2tSSQcr1LTpB+q/yyFqBwQUG4WKP8tqJipU?=
 =?us-ascii?Q?P3XBlyzxLfb5inEJ8rQxXIhoGX1mwm3qpvUIVnqtwrdXezRvi9bQCWmHcoaE?=
 =?us-ascii?Q?GA+q6BzebAf4d244Bx9enZIrM1UANkG9qU3oDWgVgCXHmfHsMAG+0L7XoajA?=
 =?us-ascii?Q?JLkZTNOYeLbQgz8L1wqM95DqvzRCNZV81M4n6eJ8PgilJwTLvKvSt1Q50r4P?=
 =?us-ascii?Q?gWCGgEIZSlI9/GnOc/xw2em6Ilmd8dvaM0nsTOOqt9Fj9CDMZ9YIpf/wpsMO?=
 =?us-ascii?Q?eyLCIMiHaBXHPfzKbUHE/455G1cjhNZMt9QD2Snxxro0WMNSP3lFFo3tWLs+?=
 =?us-ascii?Q?zjO0kCWKHe2slzm8OfywaIA7RDXvmew+cbxZq+viPmVsvecbxYw/JWVoOFWy?=
 =?us-ascii?Q?iB8b7X82TiQ/RgNtsZk619OWnuobDYNaZIseCY4zIc6EHoswG6Eftt5tFli6?=
 =?us-ascii?Q?39Z/oWlCjJy4bsO99fJojhHNTMdX2LOU/CHdfxyXTpwraUheEQclqeUqYVHt?=
 =?us-ascii?Q?jNIJPtT4kvS5hv+1ZgfeAt+1tJoNu3SsXPOKlXzQJXAbvuZ+2G5GqOfPhC3G?=
 =?us-ascii?Q?WkLzrWmX535LyJGMeUXO+BGZXVtN+vot133JvkamlEZgAN5TFq/FlD1o57yN?=
 =?us-ascii?Q?iSXWUeunneHgofp0iOe/dXn/zqTcV/Cc8/fpHUFvNJLe0g92dAgbNFbP0DUv?=
 =?us-ascii?Q?n7YE5yDGwACzisUpizrOgGd5kdvLoDB8Hz7A91HMzA9+wCt+AlBCc4hcYXMw?=
 =?us-ascii?Q?T6LGcC2OcF+hJqoPViYkYX1y5wGqw+wGcIKnrRpECwZT5MLA+6LxuaxV1e5v?=
 =?us-ascii?Q?+wNJNeKN1Cb/tEDjVqEwPEQHIZymgjATTPyLLveK6d4SXgSIGc/i4/gEG7kn?=
 =?us-ascii?Q?XOZCM7rvGjPqEGNZHyqSrBkD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8TJVmYyfRdpU0MLXabW7PVjtjjLr7GrvHrXtYzaVhLpc10GL/8I+tFlxQpJs?=
 =?us-ascii?Q?QUWAh1kBQV3E6cFrrxorGEkcfn66mPIN2n5ayP1HleLXys9lMlc83gNKKHTs?=
 =?us-ascii?Q?CvL7GI46ZiUyk5EF764RVpe0qiSl2iyY2XeqlmcfBh3QMeBg1Ei4BkAVnSVB?=
 =?us-ascii?Q?r9XGXVHhqFi1LGY6slfCTOHuJkqPT7/idqhsmZImdSSjsw6U1YR4pqSGG/t8?=
 =?us-ascii?Q?ort3lsXnXGsmOInuebmgoUs2mDtKFb+PJAgeRXtq3ETGj15MbcU8xCD7qTRd?=
 =?us-ascii?Q?rnQeyfCNCtvclDazuwZdUDGEAq2L0J18DpUw0wjv1+CGril+VD+jWJFIAqel?=
 =?us-ascii?Q?Kzt56u+LQOy8RpodE7NtRxIntIh2X9TQz/5kJgVcg+qPn8LvzEOq/+HpYVBa?=
 =?us-ascii?Q?o5shez1boVxAlkJpGD6ZzebQGYMvIX9YNMpAzhR5KLfM3OEYMw9QC1vm2NqE?=
 =?us-ascii?Q?PYvOgtahEVqgxSwHjxZXtsOn+yivj4wNObID59kz77zXFim0EpmQV7SD1ccb?=
 =?us-ascii?Q?vwQrac8KLD9Iz4L1Ow/iljphMVBTI9/vW37a05yx9m44UgrvNth1enN8Fgtt?=
 =?us-ascii?Q?qOxJ4nWuAP24k3sRUveuPx5nQHB/jXnc67eyU8VN3DnKjx8SoYabbbLUpC6O?=
 =?us-ascii?Q?PX5O/zgwlnq/wYsmRt9CKCj8d3yIfelKbwPrkuVJ34TKw55sXevFve85SJlG?=
 =?us-ascii?Q?dL0yJ2fSuJ66aMhiHwOhlKM5VielJZRSaxH5NDrq/kq6PKN20KLRMUq42bFO?=
 =?us-ascii?Q?xIoVHBC1esT/oszIuoOPd7hHI/r5MHohpFXXbbEMdHDDn+sxVY5LqEWIbhUX?=
 =?us-ascii?Q?Cm73NwcomzOQKpVR3OqhtTqJoihUOb3MunRWGDLB4JbUrQSY5aCNVVHzuayY?=
 =?us-ascii?Q?99XnKx+Mi+wXeE1mU33ej9+toG7R1ZnuPtHxSu7Ve5thN8rqSNOBOdy/3fk6?=
 =?us-ascii?Q?BrmZCzPMtznzBilx7mCBTMm0rXneoOHL6XzuzS2m35IxK3mW0ouIiQd0kRix?=
 =?us-ascii?Q?HYnl0W+D7x0w2+mbDYcRK+XqODhRQz9r72d+sptwUkgf0ZlH/Q/AJhBTuD8O?=
 =?us-ascii?Q?MYdIv82TfCILy0EJ2sDqdDq+L/xz/pXe9pDiCsy2b8veIoWlrFBHR7hRMy1T?=
 =?us-ascii?Q?VvsMfNfeHUAHmGdLxt8P3nn3jHrJv86quUNNmufzHA4Oyovi+OjZ9ZRHM4UN?=
 =?us-ascii?Q?1Gz8hqYsGylbKuIXPVf4w67M8y6TB+JbU9bOZNsyvGMrAVk0bbr5TdKQ4kP7?=
 =?us-ascii?Q?/hMCq8Eun4TsvsNdhAqPy5SNTNEolKUtSGmZ6+imbQSYn3Joq4xBKvQHCvah?=
 =?us-ascii?Q?Cvt3VjDCLrhOqX+kuOfNTSe+5FYzpzzptnIJvt+UM5GPUnw1/jznD3j3IWwp?=
 =?us-ascii?Q?aYoG4wdYz5ImOQza/WZNqVE3M1PubORJY3AeX7tcLyn6U0YgifnllWWa9hXl?=
 =?us-ascii?Q?rI9CSPxijMLpU3j+SH6eFuV1/bPB2hceeC9/27mybqU+S1xfXJ4uiLHwCWSu?=
 =?us-ascii?Q?rTHwPhQVNEGKhlZY++FMuj+aWimnuXdqNdO0Gh3FpELztI3LM+ihbsWWAtz6?=
 =?us-ascii?Q?Dv+meU3wie1Xn/fcU7pAGe3yjcoTTX4KMYu0CnqhltOb2VlN0q/3AobDwTdE?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5823eb-871d-41e2-764a-08dc9a9d4e50
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:45:59.5085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PYKj9X3hxGmk2k5xzDclZ7GY3P8ca9dRbT9AmDShXCcNsuxI2b+hgIgFwE31uX0XoHT7KLn///0RowkxHy2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "ltp.ioctl_loop06.fail" on:

commit: 18048c1af7836b8e31739d9eaefebc2bf76261f7 ("loop: Fix a race between loop detach and loop open")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 1eb586a9782cde8e5091b9de74603e0a8386b09e]

in testcase: ltp
version: ltp-x86_64-14c1f76-1_20240629
with following parameters:

	disk: 1HDD
	fs: btrfs
	test: syscalls-01/ioctl_loop06



compiler: gcc-13
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202407022125.e7ba93db-oliver.sang@intel.com



Running tests.......
<<<test_start>>>
tag=ioctl_loop06 stime=1719779316
cmdline="ioctl_loop06"
contacts=""
analysis=exit
<<<test_output>>>
tst_test.c:1734: TINFO: LTP version: 20240524-67-g072f359ac
tst_test.c:1618: TINFO: Timeout per run is 0h 02m 30s
tst_device.c:96: TINFO: Found free device 0 '/dev/loop0'
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg < 512
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg != power_of_2
ioctl_loop06.c:65: TPASS: Set block size failed as expected: EINVAL (22)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size < 512
ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUSY (16)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUSY (16)
ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size != power_of_2
ioctl_loop06.c:67: TFAIL: Set block size failed expected EINVAL got: EBUSY (16)

Summary:
passed   3
failed   3
broken   0
skipped  0
warnings 0
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=0 cstime=23
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-67-g072f359ac

       ###############################################################

            Done executing testcases.
            LTP Version:  20240524-67-g072f359ac
       ###############################################################




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240702/202407022125.e7ba93db-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

