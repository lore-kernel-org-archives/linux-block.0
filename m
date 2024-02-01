Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCBB5F46C
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706796240; cv=fail; b=M6ES5E5Y1sUyOAcbeKRroh7x/d/xLVVO/tY8j+sdiP0zxOQyl/Ps1EhbEesZQmkUsQtgI2c5n+gHBzfZevnfcipBXwXfPiQz+RfFDbhIm/pk1tM5j3Obo6TyiqOX2yfaAJDNOHnEpjJg2Y1tEO2eHZDWFxT623Ll5IgDsPHxRvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706796240; c=relaxed/simple;
	bh=/2shhSJUzB1nMpadDQDgypLjGa3Y97QYaEUNpzNFqDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RqKNK6k0iv5HGovMZd0Ro3WK86MprnHhZ16aZ1adimidnlRa5a0DIps/rv1lypMwtXyHCEEqHiWQgJBtRbuKWJyQTajxKj5Thyk2RycJiCAcn+ZgwnHxgEFPei2qDf6s+1gl8nBKS3nkcywlJb0gvQ9CctI/lR+f6+VyJlfGucY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OofZEkxc; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OofZEkxc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706796238; x=1738332238;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=/2shhSJUzB1nMpadDQDgypLjGa3Y97QYaEUNpzNFqDs=;
  b=OofZEkxc1VgK8Vq7Th+DEV2MO54P3xjBeIHFjWzCqvW8FZWeJ38wkT/a
   lNTH3/rybJL2ZjK+eCJiA/RW6yMr3ZxPt5Z/zqGuKC1C95DVJLrypVZwl
   lGDbRh2vEzE1YHlUkQR5JnSd0abSpxRDSWRflS2/ZROeONvUH6/Pc5v1p
   FDZCPDen2CZtAWnQq9cTLZxq6+tHOiTEP7Mt0qwkvUIHfQPh3do9GnGjJ
   JKmnc/iGxEI7qvZAkf6ZRAxjRkoJ9cMUho9XBc8kRG/Y5AldCiDPF8HAS
   VS8d9O2RTjz7QHcRX64NW6ZoDtA+OIZ93iQcrcmp6vxAB6STpm6rnOSXP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2835340"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="task'?scan'208,49,50?gz'208,49,50,50?time'208,49,50,50";a="2835340"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:03:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="879111539"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="task'?scan'208,49,50?gz'208,49,50,50?time'208,49,50,50";a="879111539"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 06:03:55 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:03:55 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:03:54 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 06:03:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 06:03:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxHO/7MnR2+wXcaJDOgNIf5KFORQLy1pSJ+xKC5GZTKCi53eGwyNp9Cr1FuTNTaE/0mDbnUkUJAnw1dIESlf3NvR57EeZXEp6UT37N8uBGY/bdXEDer9/3kIUSr3j57rUQmdxA80lHLDE6Qv6Hu41fkI0RWYhB2h+wS6x2mr9uKriH3IDdMbx/4Rz5WQQ1Ysyt5citCrl6GeOLaLW5SnV+nbagMeUnnw7yEIEaMZJROQ5BZD52ABIdOHNcCspq3cvl2VbuRaIqUTxIGwGH5S8CwXRd7wuwDlkp4qPEbVuduMpYGmpm1z17PDsbE0HlRJutKrJ3cZB9AHbi3ty/4pXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3M9wNNEfFEl2qMnUrQ310B2bI7CdsK8fqZkH0yzV38=;
 b=Jc41N/iMsVGY7qPg26IuDMsRb3jixN62QZl2z+EQoaNjcbFFExCMh7eUFImETeE13cq2hCqArDnXGVmNaX/YwU7eXdNSfMRr2UkkIg4o438hUtObxFcwez96ZQCKz44peRKS+L61XWF/4AOFIsMyVDeW4Df4n4G5MsSksj1kBd8ENeFmVkkP3Tb3W0G71NTk8vhYfQOO1RtV25f0OLgpufKe1IlPO518y2+7Ob9hXEjsQJzAbcCIt/XBIyS17dcWC3kIHIj38hp8lzz3DF7TcuRdde/ZJmRarFIZQ4NZG9HH1Scq7ps03yrXMe///PoQhvFjQ8rlMgQuQeCjRtY1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8595.namprd11.prod.outlook.com (2603:10b6:806:3a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 14:03:51 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 14:03:50 +0000
Date: Thu, 1 Feb 2024 22:03:41 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Bart Van Assche <bvanassche@acm.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>, Oleksandr
 Natalenko <oleksandr@natalenko.name>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, <linux-block@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [block/mq] 574e7779cf: fio.write_iops -72.9%
 regression
Message-ID: <ZbukvbmE3K8y+JdJ@xsang-OptiPlex-9020>
References: <202401312320.a335db14-oliver.sang@intel.com>
 <da4c78c1-a9d4-4a57-9765-2e6c35fa1062@acm.org>
 <9d2f99d8-ecd2-413e-b910-18e05239a2b8@kernel.dk>
 <ZbtFqxCMkItFr6/5@xsang-OptiPlex-9020>
 <d15a1759-1abf-47aa-8766-88c531023164@kernel.dk>
Content-Type: multipart/mixed; boundary="j/JWyE4s/jnbj74X"
Content-Disposition: inline
In-Reply-To: <d15a1759-1abf-47aa-8766-88c531023164@kernel.dk>
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8595:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f5389c-e4bd-4dde-222d-08dc232e9e03
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fpe4qnPAhayjOHLeSufj2izioJLG9X3piGmL7YG6EMXN5bTiO0kNxCo7y3SIyzY+0rRxBevFYqbk6vYUHbzdBq0cYknKANlB0YzgUtoM8FiyossabjENrFUh1Dp2mTKKChlacqtpjuRKVFxFgqDZkpTf8Yt8pDqbFXEAHHdueHxBmSC1Nt1m4hbgd2pg2KwzsfmvirsH5rWxmyJL0RvXuC+3anxnnCk5/kePbRv7mDFUnf9s3V4I9RTsPaI5tti4r8cMmACDRDoWu4dfMkP07uiXabiOmvBguhLYVzjPuzu1XgpXtZxDL/O6uJV4yvJ0fMCgQqfZvr4O8OMme6cbnZFTUnkXkVwJ70PJ7pytcqqH91PhZ/uHLw1qarr04ZK9C3Z3XEqAv4RoiMqd9Khe8zgVoWjcwYB1FEVLtfA/6LuTBw/MML3ENFM6/VoF7V57mY9805kLDK2xiFXaoqETjzF2PU3mfUBZqFUlE+kWFlSycbdcEnUMM/QwMqGhidRFj1F+ysSyKv9vNCOIEqW+Uzax1oOlIRjAyf70X1vx0+1fbotp6DrYlnQhU7XheNy9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(66476007)(66556008)(5660300002)(2906002)(235185007)(44832011)(8936002)(316002)(6916009)(54906003)(66946007)(8676002)(4326008)(966005)(478600001)(82960400001)(38100700002)(86362001)(6486002)(41300700001)(9686003)(53546011)(6666004)(6506007)(44144004)(26005)(83380400001)(107886003)(33716001)(6512007)(67856001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TNvWjRSrd8OI2tus2FdLfaKzkGbGL1/JU7D8BaDBeEYiGJvQTufgzfMBior2?=
 =?us-ascii?Q?MMkolbccVv1E3dqF36DfqJ9YLx5t7+ENe+ru2DEg2S7ksFWzW+TX+pOlqAc/?=
 =?us-ascii?Q?lWR8vcj++3RWssiZYs5DJKDWG3fXGY8cJ4wZoXCP7xrgTv5sVyYPKegA1Pgw?=
 =?us-ascii?Q?OqFj5Iy/Q6Md6J2S2SlWj4TBYK8wC3/gsRINNn1tBrK3GaPRDwdHN+kWRRho?=
 =?us-ascii?Q?Z4ZhGC0ZC0StZwarBEhvp1LT02JZveYHhziEIcPbfE/UnSZREDNdBS8piuOL?=
 =?us-ascii?Q?x49FMZ88Hjawp+4Su0iPxEGy0XYQdubD/ounHNgiyb63CwEuP394m3DOooac?=
 =?us-ascii?Q?hBU9IHo7p8LAhHA4p+TkDKQTjRBhO2Gz5O44w2p63pUSNQX+bRX8PSr77T5m?=
 =?us-ascii?Q?o6P5FqNMPmnjtqw4rZb2dWnCZcejWvmmWCw+CejbceDHSg8eLl7PV8MCIAUz?=
 =?us-ascii?Q?BllziSPqHHCfQrsSzzYOpVBtdWRD3+isqoA8c1cbyanN6iXwfcOfvtUns7S9?=
 =?us-ascii?Q?CWQKeON+8/Dpk4/1NRlxNnACbIk7CAwLSMIMazHIDvb0hQmkNRlZk1edlYic?=
 =?us-ascii?Q?xSbyHU3VQb0mHQAF6H5vJQf2lEAv+kUee0LpfPIQWs/njnHtaNzrV4IrvZxs?=
 =?us-ascii?Q?Cpakjaj0UEWllOkDdtp5VeKPNuScLJvgHkoGzAVih2DEyOy+C0ty2QbIAGRj?=
 =?us-ascii?Q?q5jM+SIAT/uVDBjIxAj2tYtXB0i930u3kRjFQoUiaEYy7zhP7ewoV2we90G0?=
 =?us-ascii?Q?lij1PBeFac8ekGRiF86pkJ470wMrWmEsO9JgID5yHff6/d5YSkTjfd6u99Q4?=
 =?us-ascii?Q?ihDaEPSp3o391o/XJPAHLYaAJYHsybGh1cSE5tLTHydMKbqIBZE3dku9Zc+3?=
 =?us-ascii?Q?VcJ0lErSgEU+KS3Db6C0OfZclHPfZ67UQqwZzhMTNN/8aqt8lvtFoH+neEoJ?=
 =?us-ascii?Q?C6v64qu4yUDRRNSh/wlbt/WAS0uyRMnJln6GfBJpp/1BgK2Bg109Tv+3Gkib?=
 =?us-ascii?Q?kFYuDm/HzRDOEYzKLfQFAuldCZ4BnUzAUzZwXO+3ZmmAGfFwtQoOsmQZMl1f?=
 =?us-ascii?Q?FLnppj5+qDVSJN1FOHaefVftU//vq0q+DHQYyjWENEq9FwlXlr3qaNpIWRUV?=
 =?us-ascii?Q?uTPj2ZGbn13IloBjCU/THgqe9sreN3ohbqMZB7EA4g+7DY4aUqmVWY18x1U6?=
 =?us-ascii?Q?kzIAialR474cK+o6w9yP+5zJcO0t4xMyNfPloYUA/QoryH9sqqPLyf0iucUS?=
 =?us-ascii?Q?nqodbCtmgzDbilAAkPEpr+IZEDx1qiRXPY/b/BzWFvrrUndtE8yDyXUvyuOi?=
 =?us-ascii?Q?hwECYBRJx3MSUzySPlo+8K7qHAflNmOMTInHzJ5pZ7iPzr7iH1bYQwRCPfiO?=
 =?us-ascii?Q?UCYmWlMT0WvjV48HAwUH6yzqtqmp9yKVFOBwCe4MMrh95yyFe9TyddJUMmbX?=
 =?us-ascii?Q?UuoY7f3Hoaa4HXMvDkmNvAsuyPHrmm2W0EQ/viWzX7BM4WowgPnAtv3r3K37?=
 =?us-ascii?Q?LqabsIkokQiX6TlNSU7O9Fg/GYmkerzsglvLpzs0nlto0mZ9pTA9BH6uE6ew?=
 =?us-ascii?Q?F5QLq5jhBSnwLa2XCoTG5+JLua6B671g99fJujpn5ffhCiCmU3x2Vzk/7RF9?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f5389c-e4bd-4dde-222d-08dc232e9e03
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:03:50.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E8c13yPRAUo75aSMIrv6LbZ20hdTRPCfX4Ans4zIhAQSlC7vnvKvybHtbRr7VRYUqTEOnt0QmuVNUJsrgmIK/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8595
X-OriginatorOrg: intel.com

--j/JWyE4s/jnbj74X
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Jens Axboe,

On Thu, Feb 01, 2024 at 06:40:07AM -0700, Jens Axboe wrote:
> On 2/1/24 12:18 AM, Oliver Sang wrote:
> > hi, Jens Axboe,
> > 
> > On Wed, Jan 31, 2024 at 11:42:46AM -0700, Jens Axboe wrote:
> >> On 1/31/24 11:17 AM, Bart Van Assche wrote:
> >>> On 1/31/24 07:42, kernel test robot wrote:
> >>>> kernel test robot noticed a -72.9% regression of fio.write_iops on:
> >>>>
> >>>>
> >>>> commit: 574e7779cf583171acb5bf6365047bb0941b387c ("block/mq-deadline: use separate insertion lists")
> >>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >>>>
> >>>> testcase: fio-basic
> >>>> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> >>>> parameters:
> >>>>
> >>>>     runtime: 300s
> >>>>     disk: 1HDD
> >>>>     fs: xfs
> >>>>     nr_task: 100%
> >>>>     test_size: 128G
> >>>>     rw: write
> >>>>     bs: 4k
> >>>>     ioengine: io_uring
> >>>>     direct: direct
> >>>>     cpufreq_governor: performance
> >>>
> >>> The actual test is available in this file:
> >>> https://download.01.org/0day-ci/archive/20240131/202401312320.a335db14-oliver.sang@intel.com/repro-script
> >>>
> >>> I haven't found anything in that file for disabling merging. Merging
> >>> requests decreases IOPS. Does this perhaps mean that this test is
> >>> broken?
> >>
> >> It's hard to know as nothing in this email or links include the actual
> >> output of the job...
> > 
> > I attached a dmesg and 2 outputs while running tests on 574e7779cf.
> > not sure if they are helpful?
> 
> Both fio outputs is all I need, but I only see one of them attached?

while we running fio, there are below logs captured:
fio
fio.output
fio.task
fio.time

I tar them in fio.tar.gz as attached.
you can get them by 'tar xzvf fio.tar.gz'


> 
> >> But if it's fio IOPS, then those are application side and don't
> >> necessarily correlate to drive IOPS due to merging. Eg for fio iops,
> >> if it does 4k sequential and we merge to 128k, then the fio perceived
> >> iops will be 32 times larger than the device side.
> >>
> >> I'll take a look, but seems like there might be something there. By
> >> inserting into the other list, the request is also not available for
> >> merging. And the test in question does single IOs at the time.
> > 
> > if you have any debug patch want us to run, please just let us know.
> > it will be our great pleasure!
> 
> Thanks, might take you up on that, probably won't have time for this
> until next week however.
> 
> -- 
> Jens Axboe
> 

--j/JWyE4s/jnbj74X
Content-Type: application/gzip
Content-Disposition: attachment; filename="fio.tar.gz"
Content-Transfer-Encoding: base64

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

--j/JWyE4s/jnbj74X--
