Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413912BE81
	for <linux-block@vger.kernel.org>; Wed, 31 Jan 2024 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706715752; cv=fail; b=DsOoQ+40Y+a4IZfnmKroaUejfa6e1hfXtLCZeklth9hmQR199t/h/Z8mwh9nDFrShWR4B+TZV15VkpV2QAejkI8EC3v/V/HnL07u09BMtjutkyQ/wg1rQQJmuKcefBd7fSFEgbyauI+24lwEmCkwWTcFJmeonBIDQEO24MFdcN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706715752; c=relaxed/simple;
	bh=f99peBhT0NYU7HnmKNj/lTIX8Yd7tylTUcigdYb4yqM=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ID5Y5ef3T9wBccnbdhHM6z0169drPSemcmSJoTkfFAiXlFf2ob+bq7PhTecGQP6IKEf69JGDAaCxb1MrIqwtE8f6zyoozkPGrb+2dxqCbkZ86ctvJYAXKyNO1Uh5BTn+J+2vZ3HIo93pnDi94t9J0uVVCPPHZk/Js9b/Grhwz7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LghU3hg3; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LghU3hg3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706715748; x=1738251748;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=f99peBhT0NYU7HnmKNj/lTIX8Yd7tylTUcigdYb4yqM=;
  b=LghU3hg3WmRletiIrstacLF9wUOphgj3RJMAlYOXwhXc+oQAxAgoNrKF
   dk16mL1IOVSTKNmasEvzpJbSiZIJAyIu4COclbK0LQ9h4EXVHrxEjZuud
   OPRM9HMX7G/4B0QUTS0YlMbelZr/J4jEIh3abAzr+p5hwadWPXvnP4Q6I
   wFvytLqon1sXgDYCG9eiLkt2sHABIJgDQ0m/007WnLHZpVlJch2xc4fC8
   zbBd8YlrHzPhDy/olYfOfug5quM2Y8d6j5TeG+PvzxTxmWXX3ZXgA+d5a
   YcNybjKr/gj6bPIC1Rx0poXvMzR5w+NjCOwIUdtCwinrLHs7l6Nr6Y75O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="394067099"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="394067099"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 07:42:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822603179"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="822603179"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 07:42:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 07:42:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 07:42:25 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 07:42:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH3TCrvhFJ35ny/XR6Xv/wiA/oSTQSNo8rUWod1KGSt/7f27ansGH8WO7WJhKcENyIy9sPFcBKJviMgfB25JN8Rm+H5MZ1ilaRyWfvebj5EEyc/UObte15WnCF3zT/hER0aC9a9yL4SO0HIARA3BJ5pve9GvOfBg7QBK+wXLzzM3TJc7VNqrLX7XpCaMw/ex+uVibPJ33BDNIRtJf3U1pW0c9WAGuhzj6lzAD4Q9Jq8Kv0eQ8vCRgOXV/TQT/3ptqIWN46240/x4AGw9ZUgZckFZKvzZXcMWhneB0J+qZrhH85e86EcwVak/OkHOe9hRWN62bJYKQrg92GNTmR5vvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gdzMfmOFQJe4JUy0FSWGOIseJ5fGpbt4JiT51xRKSFU=;
 b=SMbki4DLCg++CYe6FTPUzObAKVgG/Yka/ActdPudsuxqoY6XBl1JLESBQkuiYs3WGyus4yeSqzHrpHeAq4/Uyi5+fEkZoIDndRkJnXmGg+LgwOCNWt1uYPK28nkcMCDuuB9P1Be8Vjl3AB2u18MDv8U6mxNZ/BdcP+QR0V3Qcq+18GeSn14L6+eortzFzpfiofzhHJmH/lhHovGh+4nnfabte0c1HiUWnxHXSqwsKaIR4XU6k2hnvmYUKCVR6LyfF8QJt3c0CYEccmdWVkuKGfD0L6aZdh82dcA7A/Ypd4M2wCGkhwOBal7GcAGd0VJr6EG3zXbdjBlDxavEb98L/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL1PR11MB5317.namprd11.prod.outlook.com (2603:10b6:208:309::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.36; Wed, 31 Jan
 2024 15:42:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 15:42:21 +0000
Date: Wed, 31 Jan 2024 23:42:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Jens Axboe <axboe@kernel.dk>, Oleksandr Natalenko
	<oleksandr@natalenko.name>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	<linux-block@vger.kernel.org>, <ying.huang@intel.com>, <feng.tang@intel.com>,
	<fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linux-next:master] [block/mq]  574e7779cf:  fio.write_iops -72.9%
 regression
Message-ID: <202401312320.a335db14-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL1PR11MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5e89f5-98d9-431c-3f08-08dc22733633
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SU+x4rgAnIVAoQEhVCLiJQ51AkAxgdU2BqIpzEsIqgNxmITkeh/5lKo65ZM/dH/ii5DJFE2rdb2FSwDE82XctccH7/gHWhu9ajHyoEuShAVq8efryoVpRA82R/QU2pxoTqsedNrU01PxDb40WM+FWIUff3ypjnfuYUGCCO3899cx7hgUwMmLWGzmbFbRaft+T2gTaiZI1W9GPCX+nZV173kjkn8Mzs7vEM61wopUmh9pauxCvOA5I+L6iXlnqxSpk4I+XvIUOG31CMPUtK82JIu7gP75zLhbZxdO8//jzOW3YO5fH1qsjCjmvu0xZyLIbuWewBl4OVWSrpoeqGFt0YkJpsPvTQYeKg1LRCaFFfpWlNV53kgj39dHcvYuRj+84W7gzg7RDinAG4BL4I1aPt7vRH+8Vz2F6qXvtjvv+B34L0UalqPSN3BWkfUFNaQrEIR9rujO84vlg31wMbyMlyCayf6HofI7ZpfgXLSnUFvNZaUSTuFOutf97dHEEy1DcIqkdZG37VhUIeGR943LDSX/zj5OFneBszZcsOqFkXkH9S3ShVNs4lh80JbGwYcM3mpK/xurzaMVTVYN878fPVGW+jFyNmerWicvI8cim+VT5nivs+O9Cyz3f5+0KyAp+Kvo9ifUCFdIt4rRbsYKxE8pcaLyujen1jllfX1Sltw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230473577357003)(230373577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(41300700001)(83380400001)(36756003)(86362001)(82960400001)(6512007)(107886003)(26005)(38100700002)(1076003)(2616005)(6506007)(6486002)(30864003)(478600001)(2906002)(966005)(6916009)(316002)(6666004)(66476007)(66946007)(66556008)(54906003)(8676002)(8936002)(4326008)(5660300002)(559001)(579004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Cq8jprTLVXH0fb/GlBDzWYz6/6DVJQRxtHKQ1n8TTC7pUvbsIV8r4kal8T?=
 =?iso-8859-1?Q?ePg6x510oEt2KS5/gfVTNjoyWTvBnlLwt/LJrRsoPkTx2BzC3RWk3v8hYk?=
 =?iso-8859-1?Q?QRZjX6+HLJJkMh9t0vIbqAQofBsOkYeHUViLlpDJVZC53IkDIUAEmV7frj?=
 =?iso-8859-1?Q?3ikspZiTCI2hSCiy678LSiZIyIa9hVRJK8u6k6t90SXa9INa1UPp/3rixC?=
 =?iso-8859-1?Q?Adx1W8y3dFbAjA1VUXrwBViChRrnZXi1szh3asKhHZ51ejop6jMv0hCooh?=
 =?iso-8859-1?Q?E/mTLo/1FFPuhor03AB7n7cYwd4yYTt/V9CGcrhWMsf1lAQv5vBCHhMQNQ?=
 =?iso-8859-1?Q?ygNDshTHLZ3Hbcj47SKfdTIfAQuAX6me7lUnRjRDMuGfX7/TfRmu0B2HWT?=
 =?iso-8859-1?Q?o5j6CN3SeXWvDktVtyvToFr5qYAe2fNKeEe2iYMhUi7yn36eY/eJebgXAG?=
 =?iso-8859-1?Q?HcltLpyb3KJpdmdMycS0Ykz+0Tb4R0+14U6wHRJGF1vU/e07Oihea3x5xz?=
 =?iso-8859-1?Q?55urS8vI2g6HRXJMR/jnWICmrei7gJwcsvzZmIbpDuf/rLcuwLUPTCXLa6?=
 =?iso-8859-1?Q?AuIq56hg4vMe4mdH6cG11ztwm/OhEFMO4Q+VhlVPJYyjxNoHoK+bAle/K6?=
 =?iso-8859-1?Q?cV/dDxfeHkKS5vPGrsKK3aaF9ef9R5W+iDhX6idwS3Py2KtJ7nMWSfpmLl?=
 =?iso-8859-1?Q?f9QpvE3WWJlmdkNgiQsTr3i9QK3khqla24nZ73BW1TunZkyE8533bSLS27?=
 =?iso-8859-1?Q?6oaFv1X4Il0YIq1KXeAa9Qfe0xfbRxxX6NuAUWge4sF5AO7XbOvkJXjnPt?=
 =?iso-8859-1?Q?/pVOJtpiAYeb2Zw/orJ+oiwa9UJI6FsR/g1P2kpN0tam1ye34IFR3y4Wbj?=
 =?iso-8859-1?Q?dKXA+SCWhrubEabS+PJ7Ece7xr7mcmFgU1W9yGM8H39ks8W1lzjyBma9Dc?=
 =?iso-8859-1?Q?ED2kSp6INcnYIktvTnztXolbUDVa6AcKzO36bv7/tjAht5tqV9BM9dYY4p?=
 =?iso-8859-1?Q?Co2iouX8AOgf3kBmPNm4J1SVgZ34exoC8+R76Ua1BN++L8lEYsFBFyzphV?=
 =?iso-8859-1?Q?NiSpDHXjZIlJ7ZvoslEcxJ1PEjxdAa4VAR69BhfRwf7e+mA2MPsS3i2jsb?=
 =?iso-8859-1?Q?E3g0gnCKJC8ZTcT3owY1idg/yZJtZejnXUiRmNxipxawm0etE8vlviEZV5?=
 =?iso-8859-1?Q?KlfnmcXQFK7+qfN1zYJKZgDtG/t2qs/qRBdmkC4orssHgykEGaKhPdm31n?=
 =?iso-8859-1?Q?H4aQFRTOg+RppV0dlgzRTIXsI0RHy2trG0wUtf6rnGy6unT7FcWsCEvxcX?=
 =?iso-8859-1?Q?WOqt4ivFMw7ZZFeiYzD5hW7CzWF9rtedYd3RuB5lCpz4GdQf/o4B26ectv?=
 =?iso-8859-1?Q?YoZ6G4COvh/SgAXRx69ts3EjXGHwLOftOn63UjLxA/uNljS0Pe8uD3j38F?=
 =?iso-8859-1?Q?5zOAx3+OvmDly6/i/EegZ3fX5dKVHxf2VsX2Izuv83UlXEb6QomoDmxOzq?=
 =?iso-8859-1?Q?WAAko5LDHllZhw9+JzKD/91zXDT3BOxw29iSZ1tvgSIBMyvcmTSz5EGc8N?=
 =?iso-8859-1?Q?IwaMK8k1s2yrlopCbprcF9+tYt7GNHzy5wx0VBCQBLFEg0JylWp8+nTJi0?=
 =?iso-8859-1?Q?WPq3I4NBjc6+9dxTLSJB7qaBvLS64dTuSBUtEENYYiepctT27DIbrL3g?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5e89f5-98d9-431c-3f08-08dc22733633
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 15:42:20.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QieqqRBa/3mooPOC3g22RMks4ReKE2ppqxZPwH4B832TJatJWJwwE90/vM9NMLA2XzICr1g33YrXJCf8nyxPBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5317
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -72.9% regression of fio.write_iops on:


commit: 574e7779cf583171acb5bf6365047bb0941b387c ("block/mq-deadline: use separate insertion lists")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

testcase: fio-basic
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
parameters:

	runtime: 300s
	disk: 1HDD
	fs: xfs
	nr_task: 100%
	test_size: 128G
	rw: write
	bs: 4k
	ioengine: io_uring
	direct: direct
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202401312320.a335db14-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240131/202401312320.a335db14-oliver.sang@intel.com

=========================================================================================
bs/compiler/cpufreq_governor/direct/disk/fs/ioengine/kconfig/nr_task/rootfs/runtime/rw/tbox_group/test_size/testcase:
  4k/gcc-12/performance/direct/1HDD/xfs/io_uring/x86_64-rhel-8.3/100%/debian-11.1-x86_64-20220510.cgz/300s/write/lkp-icl-2sp9/128G/fio-basic

commit: 
  8f764b91fd ("block/mq-deadline: skip expensive merge lookups if contended")
  574e7779cf ("block/mq-deadline: use separate insertion lists")

8f764b91fdf29659 574e7779cf583171acb5bf63650 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     10031           -68.5%       3157 ±  7%  uptime.idle
     38.88           -93.1%       2.67 ±  4%  iostat.cpu.idle
     60.16           +60.2%      96.39        iostat.cpu.iowait
   2128969 ± 58%     -86.2%     293345 ±114%  numa-vmstat.node0.nr_foll_pin_acquired
   2127446 ± 58%     -86.2%     293180 ±114%  numa-vmstat.node0.nr_foll_pin_released
    169.33 ± 11%     +41.4%     239.50 ±  9%  perf-c2c.DRAM.remote
     98.67 ± 14%     +45.1%     143.17 ± 12%  perf-c2c.HITM.remote
     96520 ±  3%     +50.1%     144877 ±  2%  meminfo.Active
     96358 ±  3%     +50.3%     144805 ±  2%  meminfo.Active(anon)
    116390 ±  3%     +42.2%     165520 ±  2%  meminfo.Shmem
     38.49           -36.5        2.03 ±  6%  mpstat.cpu.all.idle%
     60.56           +36.5       97.03        mpstat.cpu.all.iowait%
      0.19            -0.0        0.16        mpstat.cpu.all.sys%
      0.16 ±  3%      -8.5%       0.14 ±  3%  turbostat.IPC
     75414 ±  5%    +278.1%     285115        turbostat.POLL
      0.01            +0.1        0.07        turbostat.POLL%
     38.89           -93.1%       2.70 ±  4%  vmstat.cpu.id
     60.14           +60.2%      96.37        vmstat.cpu.wa
     92653           -72.9%      25112        vmstat.io.bo
     63.11          +340.1%     277.79        vmstat.procs.b
     18314           +54.0%      28195        vmstat.system.cs
     72218            +5.8%      76405        vmstat.system.in
    584892 ± 15%    +885.8%    5766120 ±123%  sched_debug.cfs_rq:/.load.max
    950.75 ± 10%     +47.6%       1403 ± 20%  sched_debug.cfs_rq:/.load_avg.max
    203.10 ± 15%     +32.3%     268.69 ± 14%  sched_debug.cfs_rq:/.load_avg.stddev
     46333           +51.0%      69954        sched_debug.cpu.nr_switches.avg
     29986 ±  9%     +84.3%      55251        sched_debug.cpu.nr_switches.min
      0.00 ± 35%    +1e+05%       3.64 ±  9%  sched_debug.cpu.nr_uninterruptible.avg
     23.03 ± 27%    +187.8%      66.28 ±  8%  sched_debug.cpu.nr_uninterruptible.max
    -18.67          +207.7%     -57.44        sched_debug.cpu.nr_uninterruptible.min
      7.23 ±  5%    +258.7%      25.92 ± 10%  sched_debug.cpu.nr_uninterruptible.stddev
     24079 ±  3%     +50.3%      36201 ±  2%  proc-vmstat.nr_active_anon
    754201            +1.6%     766356        proc-vmstat.nr_file_pages
   3467173           -72.7%     946413        proc-vmstat.nr_foll_pin_acquired
   3464673           -72.7%     945922        proc-vmstat.nr_foll_pin_released
     11862            +1.6%      12051        proc-vmstat.nr_mapped
     29088 ±  3%     +42.2%      41375 ±  2%  proc-vmstat.nr_shmem
     24079 ±  3%     +50.3%      36201 ±  2%  proc-vmstat.nr_zone_active_anon
   1051599            -4.5%    1004608        proc-vmstat.numa_hit
    984923            -4.8%     937714        proc-vmstat.numa_local
     71376 ± 10%     +27.2%      90810 ±  8%  proc-vmstat.numa_pte_updates
     38600 ±  2%     +37.7%      53153        proc-vmstat.pgactivate
   1308586            -6.9%    1218899        proc-vmstat.pgalloc_normal
    856034            +2.4%     876179        proc-vmstat.pgfault
   1224361            -7.3%    1135057        proc-vmstat.pgfree
  28164246           -72.9%    7638316        proc-vmstat.pgpgout
      0.12 ± 28%      +0.8        0.92 ±  9%  fio.latency_1000ms%
     17.72 ±  3%     -10.3        7.39 ±  4%  fio.latency_100ms%
      0.05 ± 16%      +0.2        0.23 ±  5%  fio.latency_10ms%
     19.15 ±  6%     -19.0        0.19 ±  6%  fio.latency_20ms%
     23.99 ±  3%      +7.5       31.50        fio.latency_250ms%
      0.01            +0.0        0.03 ±  7%  fio.latency_4ms%
      5.84 ±  3%     +36.8       42.63        fio.latency_500ms%
     32.66 ±  6%     -29.9        2.73 ±  4%  fio.latency_50ms%
      0.42 ± 16%     +13.9       14.27        fio.latency_750ms%
  56330658           -72.9%   15275141        fio.time.file_system_outputs
      3139 ±  3%     -62.4%       1182 ±  2%  fio.time.involuntary_context_switches
      8.17 ±  4%     -14.3%       7.00        fio.time.percent_of_cpu_this_job_got
   1902903           +24.6%    2371272        fio.time.voluntary_context_switches
   7041332           -72.9%    1909392        fio.workload
     91.62           -72.9%      24.85        fio.write_bw_MBps
 2.045e+08          +166.0%  5.439e+08        fio.write_clat_90%_us
 3.055e+08 ±  2%     +99.1%  6.082e+08        fio.write_clat_95%_us
 4.264e+08 ±  3%     +76.4%  7.522e+08        fio.write_clat_99%_us
  87286745          +257.4%   3.12e+08        fio.write_clat_mean_us
  99184810 ±  3%     +75.3%  1.739e+08        fio.write_clat_stddev
     23454           -72.9%       6361        fio.write_iops
      1727        +5.7e+05%    9845156        fio.write_slat_mean_us
      7460 ± 39%  +4.9e+05%   36525171        fio.write_slat_stddev
      1.66           +22.5%       2.04        perf-stat.i.MPKI
      0.97            +0.1        1.09        perf-stat.i.branch-miss-rate%
   2609625            +7.1%    2794459 ±  4%  perf-stat.i.branch-misses
     16.66            -0.6       16.05        perf-stat.i.cache-miss-rate%
   1901031           +11.6%    2120745        perf-stat.i.cache-misses
  11266152           +16.9%   13166895        perf-stat.i.cache-references
     18410           +54.3%      28416        perf-stat.i.context-switches
      2.10 ±  2%     +10.4%       2.32        perf-stat.i.cpi
 2.299e+09 ±  2%      +5.1%  2.416e+09        perf-stat.i.cpu-cycles
    901.94 ±  2%     -34.2%     593.78        perf-stat.i.cpu-migrations
      1315 ±  2%     -12.7%       1148        perf-stat.i.cycles-between-cache-misses
      0.04 ±  5%      +0.0        0.04 ±  4%  perf-stat.i.dTLB-load-miss-rate%
    111249 ±  5%     +18.1%     131362 ±  4%  perf-stat.i.dTLB-load-misses
 3.359e+08            -6.7%  3.134e+08        perf-stat.i.dTLB-loads
     48568           -14.5%      41547 ±  2%  perf-stat.i.dTLB-store-misses
 1.737e+08           -11.7%  1.534e+08        perf-stat.i.dTLB-stores
 1.215e+09            -5.6%  1.147e+09        perf-stat.i.instructions
      0.49 ±  2%     -10.2%       0.44        perf-stat.i.ipc
      0.04 ±  2%      +5.1%       0.04        perf-stat.i.metric.GHz
    191.35           +17.5%     224.82        perf-stat.i.metric.K/sec
     11.77            -7.1%      10.94        perf-stat.i.metric.M/sec
      2459            +2.4%       2518        perf-stat.i.minor-faults
     90.60            +3.0       93.58        perf-stat.i.node-load-miss-rate%
    452504           +31.3%     594058        perf-stat.i.node-load-misses
     51347 ±  3%      -9.0%      46745        perf-stat.i.node-loads
    209653 ±  3%     +17.1%     245593 ±  3%  perf-stat.i.node-store-misses
    293009 ±  2%     +23.4%     361448        perf-stat.i.node-stores
      2459            +2.4%       2519        perf-stat.i.page-faults
      1.56           +18.2%       1.85        perf-stat.overall.MPKI
      1.07            +0.1        1.20 ±  2%  perf-stat.overall.branch-miss-rate%
     16.87            -0.8       16.11        perf-stat.overall.cache-miss-rate%
      1.89 ±  2%     +11.3%       2.11        perf-stat.overall.cpi
      1209            -5.8%       1139        perf-stat.overall.cycles-between-cache-misses
      0.03 ±  5%      +0.0        0.04 ±  3%  perf-stat.overall.dTLB-load-miss-rate%
      0.53 ±  2%     -10.2%       0.47        perf-stat.overall.ipc
     89.81            +2.9       92.70        perf-stat.overall.node-load-miss-rate%
     51848          +248.4%     180654        perf-stat.overall.path-length
   2602422            +7.1%    2786733 ±  4%  perf-stat.ps.branch-misses
   1894822           +11.6%    2113909        perf-stat.ps.cache-misses
  11229305           +16.9%   13124260        perf-stat.ps.cache-references
     18349           +54.4%      28323        perf-stat.ps.context-switches
 2.291e+09 ±  2%      +5.1%  2.408e+09        perf-stat.ps.cpu-cycles
    898.94 ±  2%     -34.2%     591.81        perf-stat.ps.cpu-migrations
    110886 ±  5%     +18.1%     130940 ±  4%  perf-stat.ps.dTLB-load-misses
 3.349e+08            -6.7%  3.124e+08        perf-stat.ps.dTLB-loads
     48409           -14.4%      41414 ±  2%  perf-stat.ps.dTLB-store-misses
 1.732e+08           -11.7%  1.529e+08        perf-stat.ps.dTLB-stores
 1.211e+09            -5.6%  1.144e+09        perf-stat.ps.instructions
      2451            +2.4%       2511        perf-stat.ps.minor-faults
    451006           +31.3%     592114        perf-stat.ps.node-load-misses
     51197 ±  3%      -9.0%      46611        perf-stat.ps.node-loads
    208958 ±  3%     +17.1%     244787 ±  3%  perf-stat.ps.node-store-misses
    292047 ±  2%     +23.4%     360278        perf-stat.ps.node-stores
      2451            +2.4%       2511        perf-stat.ps.page-faults
 3.651e+11            -5.5%   3.45e+11 ±  2%  perf-stat.total.instructions
      0.00 ± 43%    +368.2%       0.02 ± 75%  perf-sched.sch_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      0.01           -14.3%       0.01        perf-sched.sch_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_ilock_for_iomap
      0.01 ± 42%     -35.1%       0.00        perf-sched.sch_delay.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
      0.01           -33.3%       0.01        perf-sched.sch_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.01 ± 19%     -27.8%       0.00 ± 10%  perf-sched.sch_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      0.00 ±223%   +1912.5%       0.03 ± 94%  perf-sched.sch_delay.max.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
      0.00 ±  9%    +126.1%       0.01 ± 38%  perf-sched.sch_delay.max.ms.__cond_resched.task_work_run.io_run_task_work.io_cqring_wait.__do_sys_io_uring_enter
     56.45 ±  3%     -32.6%      38.05        perf-sched.total_wait_and_delay.average.ms
     41251 ±  4%     +99.0%      82087        perf-sched.total_wait_and_delay.count.ms
     56.44 ±  3%     -32.6%      38.04        perf-sched.total_wait_time.average.ms
     10.80 ±  2%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
    376.03 ± 48%     -94.4%      21.05 ±223%  perf-sched.wait_and_delay.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
    433.85 ± 59%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
    815.52 ± 92%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
    486.10 ± 48%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
    240.19 ± 23%    -100.0%       0.00        perf-sched.wait_and_delay.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      2.32 ± 10%     +22.5%       2.84 ±  5%  perf-sched.wait_and_delay.avg.ms.do_task_dead.do_exit.io_wq_worker.ret_from_fork.ret_from_fork_asm
     58.50 ±  6%     -80.3%      11.54 ±  6%  perf-sched.wait_and_delay.avg.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
    434.72 ± 12%     -49.8%     218.09 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     48.19 ±  5%     -71.8%      13.60 ±141%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_ilock_for_iomap
     37.76 ±  8%     -83.0%       6.43 ±223%  perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
     36.84 ±  5%     +27.8%      47.07 ±  4%  perf-sched.wait_and_delay.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
    620.47 ±  3%     -10.9%     552.59 ±  3%  perf-sched.wait_and_delay.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     64.08 ±  4%     -72.5%      17.65 ±  2%  perf-sched.wait_and_delay.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    384.00          -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
     18.00 ± 29%     -99.1%       0.17 ±223%  perf-sched.wait_and_delay.count.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
      2.50 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.down_write.xfs_ilock.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
      5.00 ± 65%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
      4.00 ± 38%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
     45.17 ± 13%    -100.0%       0.00        perf-sched.wait_and_delay.count.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      5281 ±  5%     -62.8%       1967 ± 12%  perf-sched.wait_and_delay.count.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
     33.33 ± 13%    +110.5%      70.17 ±  3%  perf-sched.wait_and_delay.count.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
      4684 ±  6%     -98.2%      82.17 ±141%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_ilock_for_iomap
    420.83 ±  8%     -99.1%       3.67 ±223%  perf-sched.wait_and_delay.count.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
     11733 ±  5%     -20.3%       9354 ±  4%  perf-sched.wait_and_delay.count.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
    622.67 ±  4%     -18.7%     506.17 ±  5%  perf-sched.wait_and_delay.count.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     11804 ±  4%    +203.5%      35824        perf-sched.wait_and_delay.count.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      1000          -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.__wait_for_common.affine_move_task.__set_cpus_allowed_ptr.__sched_setaffinity
      2061 ± 50%     -99.0%      21.05 ±223%  perf-sched.wait_and_delay.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
    782.25 ± 68%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.down_write.xfs_ilock.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
      1601 ± 51%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
      1092 ± 35%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
      2843 ± 29%    -100.0%       0.00        perf-sched.wait_and_delay.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    511.01           -25.1%     382.56 ±  9%  perf-sched.wait_and_delay.max.ms.do_task_dead.do_exit.io_wq_worker.ret_from_fork.ret_from_fork_asm
    511.46 ± 23%     -38.4%     315.16 ±  3%  perf-sched.wait_and_delay.max.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1060 ± 58%     -92.6%      78.42 ±223%  perf-sched.wait_and_delay.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
      1165 ± 15%     +74.8%       2037 ± 17%  perf-sched.wait_and_delay.max.ms.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
      3997 ±  9%     -38.1%       2474 ± 34%  perf-sched.wait_and_delay.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
    376.03 ± 48%     -92.9%      26.88 ±169%  perf-sched.wait_time.avg.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
    433.84 ± 59%     -99.9%       0.43 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.down_write.xfs_ilock.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
    815.52 ± 92%    -100.0%       0.06 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
    486.09 ± 48%    -100.0%       0.04 ±223%  perf-sched.wait_time.avg.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
    240.19 ± 23%     -95.8%      10.16 ± 78%  perf-sched.wait_time.avg.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
      2.32 ± 10%     +22.5%       2.84 ±  5%  perf-sched.wait_time.avg.ms.do_task_dead.do_exit.io_wq_worker.ret_from_fork.ret_from_fork_asm
     58.50 ±  6%     -80.3%      11.53 ±  6%  perf-sched.wait_time.avg.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
    434.72 ± 12%     -49.8%     218.09 ±  4%  perf-sched.wait_time.avg.ms.schedule_hrtimeout_range_clock.do_poll.constprop.0.do_sys_poll
     48.18 ±  5%     -35.6%      31.03 ± 23%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.xfs_ilock_for_iomap
     37.74 ±  8%     -33.5%      25.11 ± 36%  perf-sched.wait_time.avg.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
     36.83 ±  5%     +27.8%      47.07 ±  4%  perf-sched.wait_time.avg.ms.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
    620.47 ±  3%     -10.9%     552.58 ±  3%  perf-sched.wait_time.avg.ms.smpboot_thread_fn.kthread.ret_from_fork.ret_from_fork_asm
     64.07 ±  4%     -72.5%      17.64 ±  2%  perf-sched.wait_time.avg.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      2061 ± 50%     -98.7%      26.88 ±169%  perf-sched.wait_time.max.ms.__cond_resched.down_read.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten
    782.24 ± 68%     -99.9%       0.43 ±223%  perf-sched.wait_time.max.ms.__cond_resched.down_write.xfs_ilock.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
     28.38 ±223%    +539.6%     181.50 ± 73%  perf-sched.wait_time.max.ms.__cond_resched.io_assign_current_work.io_worker_handle_work.io_wq_worker.ret_from_fork
      1601 ± 51%    -100.0%       0.06 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xfs_trans_alloc.xfs_trans_alloc_inode.xfs_iomap_write_unwritten
      1092 ± 35%    -100.0%       0.04 ±223%  perf-sched.wait_time.max.ms.__cond_resched.kmem_cache_alloc.xlog_ticket_alloc.xfs_log_reserve.xfs_trans_reserve
      2842 ± 29%     -99.0%      27.95 ± 81%  perf-sched.wait_time.max.ms.__cond_resched.process_one_work.worker_thread.kthread.ret_from_fork
    511.01           -25.1%     382.56 ±  9%  perf-sched.wait_time.max.ms.do_task_dead.do_exit.io_wq_worker.ret_from_fork.ret_from_fork_asm
    511.46 ± 23%     -38.4%     315.16 ±  3%  perf-sched.wait_time.max.ms.io_cqring_wait.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1060 ± 58%     -82.5%     185.64 ± 77%  perf-sched.wait_time.max.ms.schedule_preempt_disabled.rwsem_down_write_slowpath.down_write.xfs_ilock
      1165 ± 15%     +74.8%       2037 ± 17%  perf-sched.wait_time.max.ms.schedule_timeout.io_wq_worker.ret_from_fork.ret_from_fork_asm
      3997 ±  9%     -38.1%       2474 ± 34%  perf-sched.wait_time.max.ms.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      6.92 ± 10%      -3.5        3.42 ±  8%  perf-profile.calltrace.cycles-pp.fio_ioring_commit
      6.68 ± 11%      -3.4        3.31 ±  8%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      6.41 ± 11%      -3.2        3.21 ±  8%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      6.34 ± 12%      -3.2        3.18 ±  8%  perf-profile.calltrace.cycles-pp.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      4.54 ±  6%      -2.8        1.72 ± 17%  perf-profile.calltrace.cycles-pp.iomap_dio_complete_work.process_one_work.worker_thread.kthread.ret_from_fork
      4.51 ±  6%      -2.8        1.71 ± 17%  perf-profile.calltrace.cycles-pp.iomap_dio_complete.iomap_dio_complete_work.process_one_work.worker_thread.kthread
      4.73 ± 12%      -2.6        2.08 ±  9%  perf-profile.calltrace.cycles-pp.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe.fio_ioring_commit
      4.20 ±  6%      -2.6        1.61 ± 18%  perf-profile.calltrace.cycles-pp.xfs_dio_write_end_io.iomap_dio_complete.iomap_dio_complete_work.process_one_work.worker_thread
      4.16 ±  6%      -2.6        1.57 ± 18%  perf-profile.calltrace.cycles-pp.xfs_iomap_write_unwritten.xfs_dio_write_end_io.iomap_dio_complete.iomap_dio_complete_work.process_one_work
      5.32 ±  7%      -2.5        2.80 ± 11%  perf-profile.calltrace.cycles-pp.do_exit.io_wq_worker.ret_from_fork.ret_from_fork_asm
      4.17 ± 15%      -2.5        1.72 ± 10%  perf-profile.calltrace.cycles-pp.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.05 ± 15%      -2.4        1.64 ± 11%  perf-profile.calltrace.cycles-pp.io_write.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter.do_syscall_64
      6.65 ±  7%      -2.4        4.28 ±  8%  perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      3.84 ± 16%      -2.3        1.56 ± 10%  perf-profile.calltrace.cycles-pp.xfs_file_write_iter.io_write.io_issue_sqe.io_submit_sqes.__do_sys_io_uring_enter
      4.30 ± 10%      -2.3        2.03 ± 18%  perf-profile.calltrace.cycles-pp.exit_notify.do_exit.io_wq_worker.ret_from_fork.ret_from_fork_asm
      3.74 ± 16%      -2.2        1.52 ± 10%  perf-profile.calltrace.cycles-pp.xfs_file_dio_write_aligned.xfs_file_write_iter.io_write.io_issue_sqe.io_submit_sqes
      2.58 ±  8%      -1.2        1.35 ± 12%  perf-profile.calltrace.cycles-pp.release_task.exit_notify.do_exit.io_wq_worker.ret_from_fork
      1.68 ± 18%      -1.2        0.50 ± 81%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.exit_notify.do_exit.io_wq_worker
      1.71 ± 18%      -1.1        0.60 ± 58%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.exit_notify.do_exit.io_wq_worker.ret_from_fork
      1.98 ± 10%      -1.0        0.96 ± 20%  perf-profile.calltrace.cycles-pp.queued_write_lock_slowpath.release_task.exit_notify.do_exit.io_wq_worker
      1.92 ± 11%      -1.0        0.93 ± 20%  perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath.queued_write_lock_slowpath.release_task.exit_notify.do_exit
      1.36 ± 11%      -0.7        0.67 ±  6%  perf-profile.calltrace.cycles-pp.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_dio_write_end_io.iomap_dio_complete.iomap_dio_complete_work
      1.42 ±  5%      -0.6        0.82 ±  4%  perf-profile.calltrace.cycles-pp.blk_update_request.scsi_end_request.scsi_io_completion.complete_cmd_fusion.megasas_isr_fusion
      1.04 ± 11%      -0.5        0.56 ±  5%  perf-profile.calltrace.cycles-pp.xlog_cil_commit.__xfs_trans_commit.xfs_iomap_write_unwritten.xfs_dio_write_end_io.iomap_dio_complete
      0.96 ± 10%      -0.3        0.68 ±  6%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_end_io.blk_update_request.scsi_end_request.scsi_io_completion.complete_cmd_fusion
      0.74 ±  7%      +0.2        0.93 ± 10%  perf-profile.calltrace.cycles-pp.__schedule.schedule_idle.do_idle.cpu_startup_entry.start_secondary
      0.76 ±  7%      +0.2        0.97 ± 10%  perf-profile.calltrace.cycles-pp.schedule_idle.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
      0.82 ±  7%      +0.3        1.14 ± 11%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.schedule_timeout
      0.87 ±  6%      +0.3        1.19 ± 11%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.schedule_timeout.io_wq_worker
      1.76 ±  3%      +0.6        2.32 ±  3%  perf-profile.calltrace.cycles-pp.scsi_end_request.scsi_io_completion.complete_cmd_fusion.megasas_isr_fusion.__handle_irq_event_percpu
      1.76 ±  3%      +0.6        2.32 ±  3%  perf-profile.calltrace.cycles-pp.scsi_io_completion.complete_cmd_fusion.megasas_isr_fusion.__handle_irq_event_percpu.handle_irq_event
      0.00            +0.6        0.57 ±  7%  perf-profile.calltrace.cycles-pp.enqueue_task_fair.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue
      0.00            +0.6        0.60 ±  7%  perf-profile.calltrace.cycles-pp.activate_task.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single
      0.00            +0.6        0.63 ± 10%  perf-profile.calltrace.cycles-pp.__blk_mq_free_request.scsi_end_request.scsi_io_completion.complete_cmd_fusion.megasas_isr_fusion
      0.00            +0.7        0.69 ±  9%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queues.scsi_end_request.scsi_io_completion.complete_cmd_fusion.megasas_isr_fusion
      0.09 ±223%      +0.7        0.82 ±  8%  perf-profile.calltrace.cycles-pp.ttwu_do_activate.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single
      0.39 ± 71%      +0.7        1.13 ±  7%  perf-profile.calltrace.cycles-pp.sched_ttwu_pending.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single
      0.00            +0.8        0.77 ± 12%  perf-profile.calltrace.cycles-pp.xfs_vn_update_time.kiocb_modified.xfs_file_write_checks.xfs_file_dio_write_aligned.xfs_file_write_iter
      0.00            +0.8        0.80 ± 13%  perf-profile.calltrace.cycles-pp.dd_dispatch_request.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn
      0.00            +0.8        0.81 ± 11%  perf-profile.calltrace.cycles-pp.kiocb_modified.xfs_file_write_checks.xfs_file_dio_write_aligned.xfs_file_write_iter.io_write
      0.58 ± 46%      +0.8        1.39 ±  9%  perf-profile.calltrace.cycles-pp.__flush_smp_call_function_queue.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt
      0.00            +0.8        0.82 ± 20%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_get_tag
      0.00            +0.8        0.83 ± 20%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_get_tag.__blk_mq_alloc_requests
      0.00            +0.8        0.83 ± 20%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_hw_queue.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
      0.60 ± 46%      +0.8        1.44 ±  9%  perf-profile.calltrace.cycles-pp.__sysvec_call_function_single.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter
      0.00            +0.8        0.84 ± 10%  perf-profile.calltrace.cycles-pp.xfs_file_write_checks.xfs_file_dio_write_aligned.xfs_file_write_iter.io_write.io_issue_sqe
      0.73 ±  6%      +0.9        1.60 ±  9%  perf-profile.calltrace.cycles-pp.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread
      0.73 ±  6%      +0.9        1.60 ±  9%  perf-profile.calltrace.cycles-pp.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work.worker_thread.kthread
      0.73 ±  6%      +0.9        1.60 ±  9%  perf-profile.calltrace.cycles-pp.__blk_mq_do_dispatch_sched.__blk_mq_sched_dispatch_requests.blk_mq_sched_dispatch_requests.blk_mq_run_work_fn.process_one_work
      0.73 ±  6%      +0.9        1.60 ±  9%  perf-profile.calltrace.cycles-pp.blk_mq_run_work_fn.process_one_work.worker_thread.kthread.ret_from_fork
      1.99 ±  3%      +0.9        2.87 ±  2%  perf-profile.calltrace.cycles-pp.complete_cmd_fusion.megasas_isr_fusion.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq
      0.79 ± 17%      +0.9        1.69 ±  8%  perf-profile.calltrace.cycles-pp.sysvec_call_function_single.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      0.00            +0.9        0.90 ± 18%  perf-profile.calltrace.cycles-pp.blk_mq_run_hw_queue.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.submit_bio_noacct_nocheck
      2.01 ±  3%      +0.9        2.91 ±  2%  perf-profile.calltrace.cycles-pp.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt
      2.00 ±  3%      +0.9        2.90 ±  2%  perf-profile.calltrace.cycles-pp.megasas_isr_fusion.__handle_irq_event_percpu.handle_irq_event.handle_edge_irq.__common_interrupt
      2.03 ±  3%      +0.9        2.95 ±  2%  perf-profile.calltrace.cycles-pp.handle_irq_event.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt
      2.05 ±  3%      +0.9        2.98 ±  3%  perf-profile.calltrace.cycles-pp.handle_edge_irq.__common_interrupt.common_interrupt.asm_common_interrupt.acpi_safe_halt
      2.06 ±  3%      +0.9        3.00 ±  3%  perf-profile.calltrace.cycles-pp.__common_interrupt.common_interrupt.asm_common_interrupt.acpi_safe_halt.acpi_idle_enter
      0.00            +1.0        0.97 ±  6%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.io_schedule
      0.00            +1.0        0.98 ±  6%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.io_schedule.blk_mq_get_tag
      2.09 ±  3%      +1.0        3.10 ±  2%  perf-profile.calltrace.cycles-pp.common_interrupt.asm_common_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state
      2.10 ±  4%      +1.0        3.12 ±  2%  perf-profile.calltrace.cycles-pp.asm_common_interrupt.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.00            +1.5        1.52 ± 13%  perf-profile.calltrace.cycles-pp.__schedule.schedule.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests
      0.00            +1.6        1.61 ± 12%  perf-profile.calltrace.cycles-pp.schedule.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio
      0.00            +1.7        1.68 ± 12%  perf-profile.calltrace.cycles-pp.io_schedule.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.submit_bio_noacct_nocheck
      0.50 ± 47%      +1.7        2.23 ±  8%  perf-profile.calltrace.cycles-pp.__schedule.schedule.worker_thread.kthread.ret_from_fork
      0.50 ± 47%      +1.7        2.25 ±  7%  perf-profile.calltrace.cycles-pp.schedule.worker_thread.kthread.ret_from_fork.ret_from_fork_asm
      0.17 ±141%      +1.8        1.94 ±  7%  perf-profile.calltrace.cycles-pp.pick_next_task_fair.__schedule.schedule.worker_thread.kthread
      0.08 ±223%      +1.8        1.88 ±  7%  perf-profile.calltrace.cycles-pp.newidle_balance.pick_next_task_fair.__schedule.schedule.worker_thread
      0.00            +2.0        2.00 ±  5%  perf-profile.calltrace.cycles-pp.__irqentry_text_start.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      0.61 ±  9%      +2.2        2.80 ±  6%  perf-profile.calltrace.cycles-pp.update_sg_lb_stats.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance
      0.66 ±  9%      +2.4        3.07 ±  6%  perf-profile.calltrace.cycles-pp.update_sd_lb_stats.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair
      0.67 ±  8%      +2.4        3.12 ±  6%  perf-profile.calltrace.cycles-pp.find_busiest_group.load_balance.newidle_balance.pick_next_task_fair.__schedule
      0.70 ±  7%      +2.6        3.30 ±  7%  perf-profile.calltrace.cycles-pp.load_balance.newidle_balance.pick_next_task_fair.__schedule.schedule
      2.47 ±  6%      +2.9        5.34 ±  6%  perf-profile.calltrace.cycles-pp.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_write_aligned.xfs_file_write_iter
      3.37 ± 11%      +3.3        6.66 ±  8%  perf-profile.calltrace.cycles-pp.asm_sysvec_call_function_single.acpi_safe_halt.acpi_idle_enter.cpuidle_enter_state.cpuidle_enter
      1.27 ± 10%      +3.5        4.82 ±  6%  perf-profile.calltrace.cycles-pp.submit_bio_noacct_nocheck.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw.xfs_file_dio_write_aligned
      1.02 ± 31%      +3.8        4.78 ±  6%  perf-profile.calltrace.cycles-pp.blk_mq_submit_bio.submit_bio_noacct_nocheck.iomap_dio_bio_iter.__iomap_dio_rw.iomap_dio_rw
      0.00            +4.0        4.04 ±  7%  perf-profile.calltrace.cycles-pp.blk_mq_get_tag.__blk_mq_alloc_requests.blk_mq_submit_bio.submit_bio_noacct_nocheck.iomap_dio_bio_iter
      0.00            +4.2        4.15 ±  7%  perf-profile.calltrace.cycles-pp.__blk_mq_alloc_requests.blk_mq_submit_bio.submit_bio_noacct_nocheck.iomap_dio_bio_iter.__iomap_dio_rw
      0.86 ± 10%      +5.1        5.97 ±  3%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     63.38 ±  2%      +5.7       69.08        perf-profile.calltrace.cycles-pp.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary
     66.58 ±  2%      +5.8       72.38        perf-profile.calltrace.cycles-pp.cpuidle_idle_call.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     63.90 ±  2%      +5.9       69.85        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     68.18 ±  2%      +5.9       74.13        perf-profile.calltrace.cycles-pp.start_secondary.secondary_startup_64_no_verify
     68.18 ±  2%      +5.9       74.12        perf-profile.calltrace.cycles-pp.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     68.04 ±  2%      +6.0       74.00        perf-profile.calltrace.cycles-pp.do_idle.cpu_startup_entry.start_secondary.secondary_startup_64_no_verify
     69.10 ±  2%      +6.3       75.35        perf-profile.calltrace.cycles-pp.secondary_startup_64_no_verify
      9.01 ±  7%      -4.0        5.00 ±  5%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      8.73 ±  7%      -3.8        4.88 ±  5%  perf-profile.children.cycles-pp.do_syscall_64
      6.94 ±  9%      -3.7        3.26 ±  7%  perf-profile.children.cycles-pp.__do_sys_io_uring_enter
      6.96 ± 10%      -3.5        3.44 ±  7%  perf-profile.children.cycles-pp.fio_ioring_commit
      6.32 ± 28%      -3.4        2.90 ± 16%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      4.56 ±  6%      -2.8        1.72 ± 17%  perf-profile.children.cycles-pp.iomap_dio_complete
      4.55 ±  6%      -2.8        1.72 ± 17%  perf-profile.children.cycles-pp.iomap_dio_complete_work
      4.74 ± 12%      -2.7        2.09 ±  9%  perf-profile.children.cycles-pp.io_submit_sqes
      4.17 ±  6%      -2.6        1.57 ± 18%  perf-profile.children.cycles-pp.xfs_iomap_write_unwritten
      4.21 ±  6%      -2.6        1.61 ± 18%  perf-profile.children.cycles-pp.xfs_dio_write_end_io
      5.50 ±  7%      -2.5        2.95 ± 10%  perf-profile.children.cycles-pp.do_exit
      6.66 ±  7%      -2.4        4.28 ±  8%  perf-profile.children.cycles-pp.process_one_work
      4.30 ± 10%      -2.3        2.04 ± 18%  perf-profile.children.cycles-pp.exit_notify
      3.69 ± 13%      -2.1        1.64 ± 25%  perf-profile.children.cycles-pp.queued_write_lock_slowpath
      1.64 ± 19%      -1.3        0.32 ± 16%  perf-profile.children.cycles-pp.iomap_iter
      1.53 ± 21%      -1.3        0.27 ± 14%  perf-profile.children.cycles-pp.xfs_direct_write_iomap_begin
      2.59 ±  8%      -1.2        1.35 ± 12%  perf-profile.children.cycles-pp.release_task
      1.48 ±121%      -1.1        0.34 ± 19%  perf-profile.children.cycles-pp.dd_insert_requests
      1.89 ± 94%      -1.1        0.82 ±  9%  perf-profile.children.cycles-pp.blk_finish_plug
      1.88 ± 94%      -1.1        0.82 ±  9%  perf-profile.children.cycles-pp.__blk_flush_plug
      1.85 ± 96%      -1.0        0.81 ±  9%  perf-profile.children.cycles-pp.blk_mq_flush_plug_list
      1.84 ± 97%      -1.0        0.80 ±  9%  perf-profile.children.cycles-pp.blk_mq_dispatch_plug_list
      1.46 ±  3%      -1.0        0.43 ± 39%  perf-profile.children.cycles-pp.xfs_trans_alloc_inode
      0.95 ± 11%      -0.9        0.10 ± 25%  perf-profile.children.cycles-pp.xfs_ilock_for_iomap
      0.83 ±  9%      -0.7        0.14 ± 18%  perf-profile.children.cycles-pp.down_read
      0.81 ±  5%      -0.6        0.20 ±107%  perf-profile.children.cycles-pp.xfs_ilock
      0.78 ±  5%      -0.6        0.18 ±117%  perf-profile.children.cycles-pp.down_write
      0.69 ± 24%      -0.6        0.10 ± 37%  perf-profile.children.cycles-pp.fio_ioring_getevents
      1.44 ±  6%      -0.6        0.86 ±  3%  perf-profile.children.cycles-pp.blk_update_request
      1.51 ± 13%      -0.5        0.97 ± 21%  perf-profile.children.cycles-pp.io_cqring_wait
      0.67 ±  8%      -0.5        0.15 ± 15%  perf-profile.children.cycles-pp.xfs_iunlock
      0.76 ±  9%      -0.5        0.25 ± 22%  perf-profile.children.cycles-pp.bio_iov_iter_get_pages
      0.75 ±  8%      -0.5        0.25 ± 22%  perf-profile.children.cycles-pp.__bio_iov_iter_get_pages
      0.64 ± 24%      -0.5        0.14 ± 14%  perf-profile.children.cycles-pp.__io_run_local_work
      0.69 ±  8%      -0.5        0.23 ± 25%  perf-profile.children.cycles-pp.iov_iter_extract_pages
      0.67 ±  9%      -0.5        0.22 ± 25%  perf-profile.children.cycles-pp.pin_user_pages_fast
      0.66 ±  9%      -0.4        0.22 ± 25%  perf-profile.children.cycles-pp.internal_get_user_pages_fast
      0.44 ± 16%      -0.4        0.04 ± 73%  perf-profile.children.cycles-pp.up_write
      0.84 ± 13%      -0.4        0.45 ± 33%  perf-profile.children.cycles-pp.xfs_bmapi_write
      1.52 ± 10%      -0.4        1.15 ±  6%  perf-profile.children.cycles-pp.__xfs_trans_commit
      0.55 ± 11%      -0.3        0.20 ± 26%  perf-profile.children.cycles-pp.lockless_pages_from_mm
      0.78 ± 14%      -0.3        0.45 ±  9%  perf-profile.children.cycles-pp.dd_bio_merge
      0.64 ± 19%      -0.3        0.34 ±  8%  perf-profile.children.cycles-pp.blk_mq_sched_try_merge
      0.46 ± 15%      -0.3        0.17 ± 23%  perf-profile.children.cycles-pp.gup_pgd_range
      0.98 ± 10%      -0.3        0.72 ±  5%  perf-profile.children.cycles-pp.iomap_dio_bio_end_io
      0.51 ± 24%      -0.3        0.24 ± 14%  perf-profile.children.cycles-pp.kmem_cache_free
      0.40 ± 16%      -0.3        0.14 ± 24%  perf-profile.children.cycles-pp.__slab_free
      0.38 ± 16%      -0.2        0.14 ± 23%  perf-profile.children.cycles-pp.gup_pte_range
      0.32 ± 75%      -0.2        0.10 ± 25%  perf-profile.children.cycles-pp.xfs_bmapi_read
      0.60 ±  9%      -0.2        0.39 ± 21%  perf-profile.children.cycles-pp.xfs_trans_alloc
      0.38 ± 15%      -0.2        0.17 ± 15%  perf-profile.children.cycles-pp.xfs_bmapi_convert_unwritten
      0.27 ± 31%      -0.2        0.06 ± 52%  perf-profile.children.cycles-pp.xfs_ilock_iocb_for_write
      0.31 ± 18%      -0.2        0.11 ± 27%  perf-profile.children.cycles-pp.try_grab_folio
      0.24 ± 19%      -0.2        0.05 ± 54%  perf-profile.children.cycles-pp.fio_gettime
      0.34 ± 16%      -0.2        0.15 ±  6%  perf-profile.children.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.25 ± 12%      -0.2        0.06 ± 59%  perf-profile.children.cycles-pp.__io_req_task_work_add
      0.27 ±  8%      -0.2        0.09 ± 12%  perf-profile.children.cycles-pp.__bio_release_pages
      0.48 ± 11%      -0.2        0.31 ± 20%  perf-profile.children.cycles-pp.xfs_trans_reserve
      0.20 ± 14%      -0.2        0.03 ±100%  perf-profile.children.cycles-pp.xfs_ilock_nowait
      0.31 ± 15%      -0.2        0.16 ± 23%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.24 ± 15%      -0.2        0.09 ± 24%  perf-profile.children.cycles-pp.kfree
      0.35 ± 44%      -0.2        0.20 ± 20%  perf-profile.children.cycles-pp.llist_reverse_order
      0.24 ± 11%      -0.1        0.09 ± 23%  perf-profile.children.cycles-pp.xlog_ticket_alloc
      0.17 ± 76%      -0.1        0.02 ± 99%  perf-profile.children.cycles-pp.io_req_rw_complete
      0.42 ±  9%      -0.1        0.27 ± 22%  perf-profile.children.cycles-pp.xfs_log_reserve
      0.23 ± 10%      -0.1        0.09 ± 29%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.17 ± 23%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.down_read_trylock
      0.47 ± 19%      -0.1        0.33 ± 20%  perf-profile.children.cycles-pp.io_queue_iowq
      0.16 ± 30%      -0.1        0.04 ± 75%  perf-profile.children.cycles-pp.get_io_u
      0.22 ± 11%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.up_read
      0.16 ± 33%      -0.1        0.05 ± 76%  perf-profile.children.cycles-pp.xfs_trans_run_precommits
      0.16 ±  8%      -0.1        0.05 ± 71%  perf-profile.children.cycles-pp.__cond_resched
      0.15 ± 26%      -0.1        0.04 ± 72%  perf-profile.children.cycles-pp.__io_submit_flush_completions
      0.27 ± 18%      -0.1        0.16 ±  5%  perf-profile.children.cycles-pp.__blk_bios_map_sg
      0.12 ± 26%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.io_free_batch_list
      0.20 ± 22%      -0.1        0.10 ± 14%  perf-profile.children.cycles-pp.xfs_trans_ijoin
      0.12 ± 33%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.xfs_bmbt_to_iomap
      0.27 ± 17%      -0.1        0.18 ± 10%  perf-profile.children.cycles-pp.__blk_rq_map_sg
      0.18 ± 16%      -0.1        0.09 ± 42%  perf-profile.children.cycles-pp.memset_orig
      0.32 ± 17%      -0.1        0.24 ± 15%  perf-profile.children.cycles-pp.scsi_alloc_sgtables
      0.21 ± 15%      -0.1        0.13 ± 17%  perf-profile.children.cycles-pp.asm_sysvec_reschedule_ipi
      0.10 ± 27%      -0.1        0.03 ±102%  perf-profile.children.cycles-pp.mempool_alloc
      0.33 ± 16%      -0.1        0.26 ± 13%  perf-profile.children.cycles-pp.sd_setup_read_write_cmnd
      0.09 ± 17%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.get_random_u32
      0.18 ± 18%      -0.1        0.12 ± 28%  perf-profile.children.cycles-pp.run_timer_softirq
      0.12 ± 13%      -0.1        0.06 ± 48%  perf-profile.children.cycles-pp.xfs_iext_get_extent
      0.10 ± 29%      -0.1        0.04 ± 73%  perf-profile.children.cycles-pp.bio_associate_blkg
      0.01 ±223%      +0.1        0.06 ± 15%  perf-profile.children.cycles-pp.xfs_ag_block_count
      0.12 ± 30%      +0.1        0.18 ± 13%  perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.00            +0.1        0.06 ± 13%  perf-profile.children.cycles-pp.finish_wait
      0.03 ±141%      +0.1        0.08 ± 38%  perf-profile.children.cycles-pp.__enqueue_entity
      0.12 ± 13%      +0.1        0.19 ± 12%  perf-profile.children.cycles-pp.set_next_entity
      0.00            +0.1        0.07 ± 20%  perf-profile.children.cycles-pp.try_to_grab_pending
      0.12 ± 23%      +0.1        0.20 ± 30%  perf-profile.children.cycles-pp.wakeup_preempt
      0.02 ±142%      +0.1        0.10 ± 40%  perf-profile.children.cycles-pp.megasas_build_ldio_fusion
      0.16 ± 30%      +0.1        0.25 ± 18%  perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.12 ± 32%      +0.1        0.22 ± 12%  perf-profile.children.cycles-pp.llist_add_batch
      0.11 ±  9%      +0.1        0.22 ± 21%  perf-profile.children.cycles-pp.rb_erase
      0.13 ± 18%      +0.1        0.24 ± 23%  perf-profile.children.cycles-pp.elv_attempt_insert_merge
      0.17 ± 15%      +0.1        0.28 ± 15%  perf-profile.children.cycles-pp.scsi_dispatch_cmd
      0.08 ± 58%      +0.1        0.19 ± 13%  perf-profile.children.cycles-pp.raw_spin_rq_lock_nested
      0.07 ± 20%      +0.1        0.19 ± 19%  perf-profile.children.cycles-pp.xas_load
      0.00            +0.1        0.12 ± 26%  perf-profile.children.cycles-pp.sbitmap_finish_wait
      0.00            +0.1        0.13 ± 16%  perf-profile.children.cycles-pp.elv_rb_del
      0.56 ±  9%      +0.1        0.69 ±  7%  perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.28 ± 13%      +0.1        0.41 ±  6%  perf-profile.children.cycles-pp.queue_work_on
      0.00            +0.1        0.14 ± 28%  perf-profile.children.cycles-pp.sbitmap_queue_get_shallow
      0.06 ± 50%      +0.1        0.20 ± 20%  perf-profile.children.cycles-pp.kblockd_mod_delayed_work_on
      0.06 ± 50%      +0.1        0.20 ± 20%  perf-profile.children.cycles-pp.mod_delayed_work_on
      0.11 ± 14%      +0.2        0.27 ± 11%  perf-profile.children.cycles-pp.xas_find
      0.02 ±142%      +0.2        0.18 ± 21%  perf-profile.children.cycles-pp.dd_has_work
      0.24 ± 20%      +0.2        0.40 ± 15%  perf-profile.children.cycles-pp.ttwu_queue_wakelist
      0.10 ± 24%      +0.2        0.27 ± 13%  perf-profile.children.cycles-pp._find_next_zero_bit
      0.09 ± 25%      +0.2        0.26 ± 14%  perf-profile.children.cycles-pp.elv_rqhash_find
      0.37 ± 14%      +0.2        0.54 ± 14%  perf-profile.children.cycles-pp.idle_cpu
      0.22 ± 11%      +0.2        0.40 ±  9%  perf-profile.children.cycles-pp._find_next_and_bit
      0.55 ± 10%      +0.2        0.75 ± 11%  perf-profile.children.cycles-pp.update_load_avg
      0.00            +0.2        0.21 ± 19%  perf-profile.children.cycles-pp.prepare_to_wait_exclusive
      0.10 ± 20%      +0.2        0.31 ± 15%  perf-profile.children.cycles-pp.__dd_dispatch_request
      0.66 ±  9%      +0.2        0.88 ±  9%  perf-profile.children.cycles-pp.update_rq_clock
      0.01 ±223%      +0.2        0.24 ± 27%  perf-profile.children.cycles-pp.__sbitmap_weight
      0.01 ±223%      +0.2        0.25 ± 25%  perf-profile.children.cycles-pp.sbitmap_weight
      0.07 ± 28%      +0.3        0.32 ± 15%  perf-profile.children.cycles-pp.sbitmap_get_shallow
      0.47 ± 21%      +0.3        0.72 ± 12%  perf-profile.children.cycles-pp.enqueue_entity
      0.28 ± 10%      +0.3        0.54 ±  4%  perf-profile.children.cycles-pp.__queue_work
      0.77 ±  7%      +0.3        1.04 ±  8%  perf-profile.children.cycles-pp.schedule_idle
      1.04 ±  5%      +0.3        1.32 ±  7%  perf-profile.children.cycles-pp.try_to_wake_up
      0.22 ± 14%      +0.3        0.50 ±  6%  perf-profile.children.cycles-pp.kick_pool
      0.12 ± 27%      +0.3        0.40 ± 12%  perf-profile.children.cycles-pp.xa_find_after
      0.25 ± 10%      +0.3        0.53 ±  9%  perf-profile.children.cycles-pp.cpu_util
      0.55 ± 12%      +0.3        0.88 ±  9%  perf-profile.children.cycles-pp.xfs_file_write_checks
      0.60 ± 17%      +0.3        0.94 ±  6%  perf-profile.children.cycles-pp.activate_task
      0.56 ± 17%      +0.4        0.92 ±  6%  perf-profile.children.cycles-pp.enqueue_task_fair
      0.42 ± 14%      +0.4        0.82 ± 10%  perf-profile.children.cycles-pp.kiocb_modified
      0.00            +0.4        0.41 ± 18%  perf-profile.children.cycles-pp.__dd_do_insert
      0.31 ± 13%      +0.5        0.77 ± 12%  perf-profile.children.cycles-pp.xfs_vn_update_time
      0.00            +0.5        0.48 ±  7%  perf-profile.children.cycles-pp.autoremove_wake_function
      0.23 ± 11%      +0.5        0.72 ±  8%  perf-profile.children.cycles-pp.blk_mq_run_hw_queues
      0.65 ± 16%      +0.5        1.16 ±  6%  perf-profile.children.cycles-pp.ttwu_do_activate
      0.65 ± 18%      +0.5        1.18 ±  8%  perf-profile.children.cycles-pp.sched_ttwu_pending
      0.18 ± 10%      +0.6        0.74 ±  3%  perf-profile.children.cycles-pp.sbitmap_find_bit
      0.00            +0.6        0.56 ±  9%  perf-profile.children.cycles-pp.__wake_up_common
      0.00            +0.6        0.56 ±  9%  perf-profile.children.cycles-pp.__wake_up
      0.00            +0.6        0.58 ± 12%  perf-profile.children.cycles-pp.sbitmap_queue_wake_up
      1.80 ±  4%      +0.6        2.40 ±  2%  perf-profile.children.cycles-pp.scsi_end_request
      1.80 ±  4%      +0.6        2.41 ±  2%  perf-profile.children.cycles-pp.scsi_io_completion
      0.41 ±  6%      +0.6        1.02 ±  6%  perf-profile.children.cycles-pp.__irqentry_text_start
      0.02 ±145%      +0.6        0.64 ± 11%  perf-profile.children.cycles-pp.sbitmap_queue_clear
      0.16 ± 22%      +0.6        0.80 ± 19%  perf-profile.children.cycles-pp.sbitmap_get
      0.10 ± 25%      +0.6        0.74 ± 11%  perf-profile.children.cycles-pp.__blk_mq_free_request
      0.82 ± 17%      +0.7        1.47 ±  9%  perf-profile.children.cycles-pp.__flush_smp_call_function_queue
      0.83 ± 16%      +0.7        1.49 ±  8%  perf-profile.children.cycles-pp.__sysvec_call_function_single
      0.17 ± 36%      +0.8        0.94 ± 11%  perf-profile.children.cycles-pp.dd_dispatch_request
      0.95 ± 15%      +0.8        1.73 ±  7%  perf-profile.children.cycles-pp.sysvec_call_function_single
      0.73 ±  6%      +0.9        1.61 ±  9%  perf-profile.children.cycles-pp.blk_mq_run_work_fn
      2.04 ±  4%      +0.9        2.98        perf-profile.children.cycles-pp.complete_cmd_fusion
      2.05 ±  3%      +1.0        3.01        perf-profile.children.cycles-pp.megasas_isr_fusion
      2.06 ±  4%      +1.0        3.02        perf-profile.children.cycles-pp.__handle_irq_event_percpu
      2.08 ±  3%      +1.0        3.05        perf-profile.children.cycles-pp.handle_irq_event
      2.10 ±  3%      +1.0        3.09 ±  2%  perf-profile.children.cycles-pp.handle_edge_irq
      2.11 ±  3%      +1.0        3.10 ±  2%  perf-profile.children.cycles-pp.__common_interrupt
      2.14 ±  4%      +1.1        3.21        perf-profile.children.cycles-pp.common_interrupt
      0.20 ± 28%      +1.1        1.28 ± 12%  perf-profile.children.cycles-pp.scsi_mq_get_budget
      2.14 ±  4%      +1.1        3.24        perf-profile.children.cycles-pp.asm_common_interrupt
      0.29 ± 32%      +1.3        1.58 ±  9%  perf-profile.children.cycles-pp.blk_mq_run_hw_queue
      1.85 ±  6%      +1.8        3.66 ±  5%  perf-profile.children.cycles-pp.update_sg_lb_stats
      2.12 ±  4%      +1.8        3.97 ±  5%  perf-profile.children.cycles-pp.update_sd_lb_stats
      2.18 ±  4%      +1.9        4.03 ±  5%  perf-profile.children.cycles-pp.find_busiest_group
      2.79 ±  4%      +1.9        4.73 ±  6%  perf-profile.children.cycles-pp.load_balance
      2.33 ± 12%      +2.0        4.30 ±  7%  perf-profile.children.cycles-pp.asm_sysvec_call_function_single
      0.00            +2.0        2.01 ± 12%  perf-profile.children.cycles-pp.io_schedule
      0.98 ± 12%      +2.0        3.00 ±  7%  perf-profile.children.cycles-pp.__blk_mq_do_dispatch_sched
      0.98 ± 13%      +2.0        3.01 ±  7%  perf-profile.children.cycles-pp.__blk_mq_sched_dispatch_requests
      0.98 ± 13%      +2.0        3.02 ±  7%  perf-profile.children.cycles-pp.blk_mq_sched_dispatch_requests
      2.09 ±  5%      +2.3        4.43 ±  6%  perf-profile.children.cycles-pp.newidle_balance
      2.26 ±  4%      +2.5        4.75 ±  5%  perf-profile.children.cycles-pp.pick_next_task_fair
      2.48 ±  6%      +2.9        5.34 ±  6%  perf-profile.children.cycles-pp.iomap_dio_bio_iter
      2.90 ±  7%      +2.9        5.81 ±  5%  perf-profile.children.cycles-pp.schedule
      3.83 ±  5%      +3.1        6.90 ±  4%  perf-profile.children.cycles-pp.__schedule
      1.27 ± 10%      +3.6        4.82 ±  6%  perf-profile.children.cycles-pp.submit_bio_noacct_nocheck
      1.18 ±  9%      +3.6        4.78 ±  6%  perf-profile.children.cycles-pp.blk_mq_submit_bio
      0.09 ± 17%      +3.9        4.04 ±  7%  perf-profile.children.cycles-pp.blk_mq_get_tag
      0.15 ± 15%      +4.0        4.15 ±  7%  perf-profile.children.cycles-pp.__blk_mq_alloc_requests
      0.88 ± 10%      +5.3        6.14 ±  3%  perf-profile.children.cycles-pp.poll_idle
     64.25 ±  2%      +5.9       70.18        perf-profile.children.cycles-pp.cpuidle_enter
     68.18 ±  2%      +5.9       74.13        perf-profile.children.cycles-pp.start_secondary
     63.95 ±  2%      +6.0       69.91        perf-profile.children.cycles-pp.cpuidle_enter_state
     67.55 ±  2%      +6.0       73.59        perf-profile.children.cycles-pp.cpuidle_idle_call
     69.08 ±  2%      +6.3       75.34        perf-profile.children.cycles-pp.do_idle
     69.10 ±  2%      +6.3       75.35        perf-profile.children.cycles-pp.cpu_startup_entry
     69.10 ±  2%      +6.3       75.35        perf-profile.children.cycles-pp.secondary_startup_64_no_verify
      6.32 ± 28%      -3.4        2.89 ± 16%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.46 ± 16%      -0.3        0.12 ± 16%  perf-profile.self.cycles-pp.__iomap_dio_rw
      0.39 ± 18%      -0.3        0.14 ± 25%  perf-profile.self.cycles-pp.__slab_free
      0.45 ± 20%      -0.2        0.23 ± 13%  perf-profile.self.cycles-pp.iomap_dio_bio_end_io
      0.23 ± 20%      -0.2        0.04 ± 77%  perf-profile.self.cycles-pp.fio_gettime
      0.29 ± 19%      -0.2        0.10 ± 27%  perf-profile.self.cycles-pp.try_grab_folio
      0.29 ± 40%      -0.2        0.11 ± 30%  perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.26 ± 11%      -0.2        0.09 ± 51%  perf-profile.self.cycles-pp.try_to_wake_up
      0.16 ± 24%      -0.1        0.02 ± 99%  perf-profile.self.cycles-pp.down_read_trylock
      0.22 ±  9%      -0.1        0.11 ± 10%  perf-profile.self.cycles-pp.up_read
      0.18 ± 23%      -0.1        0.08 ± 19%  perf-profile.self.cycles-pp.kmem_cache_free
      0.14 ± 30%      -0.1        0.04 ± 77%  perf-profile.self.cycles-pp.get_io_u
      0.26 ± 18%      -0.1        0.16 ±  5%  perf-profile.self.cycles-pp.__blk_bios_map_sg
      0.14 ± 20%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.blk_mq_submit_bio
      0.14 ± 20%      -0.1        0.05 ± 86%  perf-profile.self.cycles-pp.__io_req_task_work_add
      0.14 ± 18%      -0.1        0.05 ± 48%  perf-profile.self.cycles-pp.__bio_release_pages
      0.29 ± 13%      -0.1        0.20 ± 20%  perf-profile.self.cycles-pp.llist_reverse_order
      0.17 ± 19%      -0.1        0.09 ± 41%  perf-profile.self.cycles-pp.memset_orig
      0.13 ± 31%      -0.1        0.06 ± 51%  perf-profile.self.cycles-pp.xfs_inode_to_log_dinode
      0.12 ± 14%      -0.1        0.05 ± 47%  perf-profile.self.cycles-pp.xfs_bmap_add_extent_unwritten_real
      0.11 ± 23%      -0.1        0.05 ± 73%  perf-profile.self.cycles-pp.inode_maybe_inc_iversion
      0.14 ± 12%      -0.1        0.08 ± 14%  perf-profile.self.cycles-pp.xfs_file_write_iter
      0.14 ± 23%      -0.1        0.09 ± 22%  perf-profile.self.cycles-pp.fget
      0.10 ± 13%      -0.0        0.06 ± 46%  perf-profile.self.cycles-pp.xfs_iext_get_extent
      0.03 ±102%      +0.1        0.09 ± 21%  perf-profile.self.cycles-pp.pick_next_task_fair
      0.02 ±141%      +0.1        0.08 ± 38%  perf-profile.self.cycles-pp.__enqueue_entity
      0.10 ± 21%      +0.1        0.16 ± 24%  perf-profile.self.cycles-pp.irqentry_enter
      0.01 ±223%      +0.1        0.08 ± 37%  perf-profile.self.cycles-pp.xas_load
      0.00            +0.1        0.08 ± 18%  perf-profile.self.cycles-pp.__blk_mq_free_request
      0.01 ±223%      +0.1        0.09 ± 22%  perf-profile.self.cycles-pp.dd_dispatch_request
      0.20 ± 21%      +0.1        0.28 ± 16%  perf-profile.self.cycles-pp.update_load_avg
      0.00            +0.1        0.08 ± 25%  perf-profile.self.cycles-pp.ttwu_do_activate
      0.16 ± 31%      +0.1        0.24 ± 20%  perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.08 ± 27%      +0.1        0.17 ± 23%  perf-profile.self.cycles-pp.__dd_dispatch_request
      0.09 ± 21%      +0.1        0.19 ± 25%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.10 ± 14%      +0.1        0.20 ± 23%  perf-profile.self.cycles-pp.rb_erase
      0.12 ± 32%      +0.1        0.22 ± 12%  perf-profile.self.cycles-pp.llist_add_batch
      0.00            +0.1        0.11 ± 31%  perf-profile.self.cycles-pp.prepare_to_wait_exclusive
      0.54 ± 12%      +0.1        0.67 ±  6%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.00            +0.1        0.14 ± 27%  perf-profile.self.cycles-pp.sbitmap_queue_get_shallow
      0.01 ±223%      +0.1        0.15 ± 22%  perf-profile.self.cycles-pp.xa_find_after
      0.73 ± 11%      +0.1        0.87 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      0.02 ±142%      +0.2        0.17 ± 22%  perf-profile.self.cycles-pp.dd_has_work
      0.36 ± 13%      +0.2        0.52 ± 12%  perf-profile.self.cycles-pp.idle_cpu
      0.10 ± 25%      +0.2        0.26 ± 15%  perf-profile.self.cycles-pp._find_next_zero_bit
      0.86 ±  5%      +0.2        1.02 ± 12%  perf-profile.self.cycles-pp.menu_select
      0.09 ± 27%      +0.2        0.26 ± 14%  perf-profile.self.cycles-pp.elv_rqhash_find
      0.20 ± 12%      +0.2        0.37 ± 14%  perf-profile.self.cycles-pp._find_next_and_bit
      0.08 ± 53%      +0.2        0.26 ± 19%  perf-profile.self.cycles-pp.complete_cmd_fusion
      0.00            +0.2        0.19 ± 26%  perf-profile.self.cycles-pp.__sbitmap_weight
      0.24 ± 11%      +0.2        0.48 ± 12%  perf-profile.self.cycles-pp.__schedule
      0.21 ±  7%      +0.2        0.46 ± 11%  perf-profile.self.cycles-pp.cpu_util
      0.01 ±223%      +0.3        0.28 ± 15%  perf-profile.self.cycles-pp.scsi_mq_get_budget
      0.03 ±101%      +0.3        0.30 ± 21%  perf-profile.self.cycles-pp.sbitmap_get
      0.08 ± 24%      +0.4        0.48 ±  5%  perf-profile.self.cycles-pp.sbitmap_find_bit
      1.37 ±  8%      +1.2        2.58 ±  8%  perf-profile.self.cycles-pp.update_sg_lb_stats
      0.82 ± 12%      +5.0        5.84 ±  3%  perf-profile.self.cycles-pp.poll_idle




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

