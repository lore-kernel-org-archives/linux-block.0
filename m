Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5217A5F492
	for <linux-block@vger.kernel.org>; Thu,  1 Feb 2024 14:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798771; cv=fail; b=Gnp4MRMSUCxJESg9o1um42UERMr7OMze3qEscXQb7pK6CPp35yeuX7YJLxa1zv9BjH5uDO97vaTNFrvl+j0MF/mwtQL6etmYuSXPWbCg+H43lXYHC9k08MI1FKLgGTutxiDhz01Yroj8DDWO+8oZnW1gdY+1kQGqAklflMHHUX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798771; c=relaxed/simple;
	bh=9faYzXWoXBNJ9bF3Delu6zDwXXGa++8raDise1qagIk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oMZuRtO/0CrW+Ye0z/3K7UWowkCkduGYRBEb+AsY+gsjJ7WuwV5WXlvQeVENf/gpQaFdvY57GnP8BDRGgbJyw930+f5Nh07XNvBW0wI2BvH7AL/G9cNsdY05e2VqXe8GJPjwt0A04UiT+5Dn3PtROAqk1O66A13MQVcxnhFIk4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eC4daagb; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eC4daagb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798765; x=1738334765;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9faYzXWoXBNJ9bF3Delu6zDwXXGa++8raDise1qagIk=;
  b=eC4daagbFcH65WUfjNwoS5xpjCOHfrXRvw7LEZxInycDrWIhkvrDx1DI
   Ve71Qd4OcD+uX/Raiz1WEHxj5RPuM/q+ZlKVxt8urM8Jq3tFMO6RQqUC0
   jMtKz9euDOPNuwDeov8KvEphIRwSR0uh3Drb4kN1sfaHdTzHkdpl/PBQz
   gz5m0cRQ0Q44JgWG2q4P698xqMuy5TsTtSYiRWMMMKF+M3cwOexo5Z8SW
   O3Ukqn0fpL5nMSwDoW+B5fxgP9KKI2OFXLTgPpK+6AOae9q4t0rdusqzc
   8HZD4OsmCsq0VHnk4VzB/4OyZkysaJXgkwUq2gMr7j6JQsXT07p5kO+Lo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10562458"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="time'?task'?gz'50?scan'50,208,49,50";a="10562458"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:46:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="932192457"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="time'?task'?gz'50?scan'50,208,49,50";a="932192457"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 06:46:00 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:45:59 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 06:45:59 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 06:45:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNE606KSsY+ztdXf2u9cAENxTcQMjsn+LV6UQclgVV5Cpb4JsO7B1rjcEqKB2nowW5i3onoe29Yu3oftpYJVN0pBpJi0h14b+7X2KyrYGD95H0i0cwsbBXVyK7gLhxrSePJYQg4VpYCXWxsYPPrkm2MaE+uIiePhX3uU7Je4cMA+oYoh7oHKqWTTysSsoNjUVQKX3/cp+rHmEy+KhYWTW11SXxoNFmHVca/RPQHmts642KCWXIur3YQLLyxflmHinAqALXagQCdptTymBiB2X7XW0gp230G/FoDqPZI4r3PRfoqEWewV89lHr1VwPyQCFi5L4CBwSKRiqM33R/1r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoESJWwIR+UBHuL5ZkAs496g2SqHNKbKU2R5HJN/Vss=;
 b=P9dimMM4sIwO31Ry9hfQVusKwyqit5T7EN3en1cGY1ydNUbiuOzar5Xd6EkQ1zEOXdpScecYPB06gbtnUmC6aBt5tNtZbCbqUBTKT92B+3/yf4HrkCtJJ9j5i7RlqlydfBu+DHwW2lTtEdHXGI/a+afB1vmRIn8kWYmtlSCb86gXPKgTaEJxSSqVnihq8qcTtz9LmPIoEBUx9cnRPDZumz9Pce0d14A14ADWmaafZsf8CPfmYR3himaErkQLiNXGDI/j8IZ4q9c3Y4nUgxkXmEE8qiqQRP04GRXwJ+nPPvO6sWjRHdDu2LTez1W08OVPOuU7OZEtPTULkz7b8f42Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by IA1PR11MB7756.namprd11.prod.outlook.com (2603:10b6:208:420::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 14:45:52 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::a026:574d:dab0:dc8e%3]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 14:45:51 +0000
Date: Thu, 1 Feb 2024 22:45:42 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Bart Van Assche <bvanassche@acm.org>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Linux Memory Management List <linux-mm@kvack.org>,
	"Oleksandr Natalenko" <oleksandr@natalenko.name>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, <linux-block@vger.kernel.org>,
	<ying.huang@intel.com>, <feng.tang@intel.com>, <fengwei.yin@intel.com>,
	<oliver.sang@intel.com>
Subject: Re: [linux-next:master] [block/mq] 574e7779cf: fio.write_iops -72.9%
 regression
Message-ID: <Zbuulhixmu7rEheP@xsang-OptiPlex-9020>
References: <202401312320.a335db14-oliver.sang@intel.com>
 <da4c78c1-a9d4-4a57-9765-2e6c35fa1062@acm.org>
 <9d2f99d8-ecd2-413e-b910-18e05239a2b8@kernel.dk>
 <ZbtFqxCMkItFr6/5@xsang-OptiPlex-9020>
 <d15a1759-1abf-47aa-8766-88c531023164@kernel.dk>
 <ZbukvbmE3K8y+JdJ@xsang-OptiPlex-9020>
 <cf5236e6-a79b-455a-9afe-b5dbf27d33e9@kernel.dk>
Content-Type: multipart/mixed; boundary="GApH+OYcZNxoTc9G"
Content-Disposition: inline
In-Reply-To: <cf5236e6-a79b-455a-9afe-b5dbf27d33e9@kernel.dk>
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|IA1PR11MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 37e97ce2-26e0-4f2f-39ba-08dc23347c72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RdHkpTJBydPdIqzeRU94ZXTUDLhtt/FJqXHfMfRWHG8S5Kq2wkXCEohnWYrrHhtA0o0as4l64hRCd2RudmSeejelmvbJDbC3Y+lsfRBFAGpMrolVttgt3yuwh04iOu49cAm2pGVJc7bH0+VZWAGIAvS5xyZalNPekMt+K52qBHOpp7DqEeo+cL6cLQAXzi2DHufDUf3eNRNsUkzYrunJ1VGkoMsjxEq5jOxbvCzEVUOJQeyZ489tYvZYWTaUdP/7U5WF3zLXfwT1T6cd29cMTK830qVdY8+4Xd/lZC+pTmG2CoXy2qp225ABZTCtxI4P4o++ZNpd7tQ3CjZnQewCWHsxHgpbY+6tKAdLa5zWfff4vhmY1/0RIGFd/Hd4t4DMwWeltqDgNEq/bMJJRcXpssAFI8mamzqtPayhhJpeWazE3BAf9d1aL6borsOv6g5Y4Pab9S86MWLmMf1Ff6tPgB7qWZyzfJu5wg20Qec7IcDC38+cmWI3wi19d7roaONCbJJYgZby1MaTV444JOo+xSY4QIvYvy/TK/Hxiu6PzE0j5sxqBqtQmM/7ZnS8N4Qv2ZaiV6dsInXXAqzr4TRIIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(39860400002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(33716001)(26005)(107886003)(54906003)(44144004)(6486002)(66476007)(6916009)(316002)(38100700002)(41300700001)(53546011)(6506007)(478600001)(6512007)(83380400001)(82960400001)(6666004)(66556008)(9686003)(966005)(66946007)(8936002)(2906002)(235185007)(86362001)(4326008)(8676002)(44832011)(5660300002)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sH6rzEXoUi5KKx2li0wHsrK8NfwomV+ytpthiPS822ABk9/PXP4tBmwRep0J?=
 =?us-ascii?Q?QtkxyZ7nmxhw26+Z7O9vIJg75m/8JVu8rU6J0HD/dSXTwvXgTZydIt03Vczf?=
 =?us-ascii?Q?fI2T5Pj/Bfn3PEpt8CXlRy8QFTquND3xGC7JHOC0E059MOGMt0Yrq4zDvDrm?=
 =?us-ascii?Q?6rt4P8HDmq6mXDGQm5ZpbqRrgwbUf7O6fJrHatTb65DR8wVkV5zs8UFwIjS3?=
 =?us-ascii?Q?EYC3puLOl7cBJYpe5N3vC9+MQP4CqH/eJmFJFYuHaJM2m5f0DDO7jKdQfQQL?=
 =?us-ascii?Q?AMlDVG+mPT9grlT2fBF/GoOFR15e6xA3wPNx9ZHG5MIgvMsF8KC5pGCygfjz?=
 =?us-ascii?Q?TAAu+OLFlNN88WPc7VnQaKJtYj1C3dUdfpAn8XnqFpeeHeKWjwhKcPi1ZxrN?=
 =?us-ascii?Q?IOMqx73U7gL4yeDnCPmnvmjSyaB93JoFWofNYqgxFK+EnTgTylKoQcK8C7rT?=
 =?us-ascii?Q?bpWOwz3eevz7fiOTCc+vHrUqvWshTL61CVKMQEP2dqxUaVJyMrgXfP2TezsC?=
 =?us-ascii?Q?EGj5icz0OrkGsTHXRxvMhXUhAI2oOtvon1rWMFMgi01TEnTAf+PD3sUNLgR5?=
 =?us-ascii?Q?HXbPR0HGwr6QCeXfJeBljs0sSSK+S+ORdYxwru/reVMb3nnWBD1hZMZvGCYa?=
 =?us-ascii?Q?zEWpMIxxaYU/xdG2eQInvJ0kzk87tpPtYGDW4PGZ0KeCpYgiOvh7mgvD0BGp?=
 =?us-ascii?Q?Um0DZ4AQU1Jk+VlZ10KgrnwTFVkMjmtaQQgKILYXQsnhBh9dxZwGZyGJKBot?=
 =?us-ascii?Q?0/BMOSWMYKBKHIlrVs6waYyqO4CtW1HyMXz5Afnss5yTstkOMpxH8lao4fzQ?=
 =?us-ascii?Q?QW39TB2GzsNs2iY+KEqR/5O/B5mEE6rbI4cv5FjpMkO1NUKANwMMHZRN12WS?=
 =?us-ascii?Q?HkRa8zd0UWE9aZN3aALM/40LkzYLakyof4EDsvVEatODW9pDsQ/Jk5HJaSMi?=
 =?us-ascii?Q?lZ42/hCIJ98vmSv0fhlNUSSrh3Z4qyarLZ6wGDJz6WP6skBsSWc77j/WWt0+?=
 =?us-ascii?Q?fqTEr8GCJpFnwcB3W9+/dlD/b/blq8CDa+cq2ymvpZnYoimzWHYaJqs4F0tX?=
 =?us-ascii?Q?clMZ08SclcnR86VQA4nuNx17H9D8zzStyFjz9mgAdmFzmDROkcMAATeDu/hz?=
 =?us-ascii?Q?/jdXSVqPpZ70yncvTVgASG6SDH+CRZ0LCtywmbg3eIPg71Lx56xbwGOzl14l?=
 =?us-ascii?Q?K17gtyuFfuNzQq85bjTOH2Novcqgh3XcArg8OZLXvPZTGY8SsDLeODGB1qRy?=
 =?us-ascii?Q?Pq25wltX/AOAx1IcP2T+mYHA96anezpLjmWelkh9gdDRK3TZq5GvV48Mb0I4?=
 =?us-ascii?Q?t5MmRcOaVtx6sb4CHwNk4q7JWj+FkV/rOC/2HJrHZElnGQMyxk3gHLs7+lMz?=
 =?us-ascii?Q?KH/f5k5eaz/Qhj2uIFT8JUfFe6nVZ5QuOjtcdfMw195hHpfplhlboWHTQP77?=
 =?us-ascii?Q?Xd2RBKKSjh3Ui+zsA6bY2QqRK99kiPewWkrMlo78c8gXjN7fzMlsLrNdNaII?=
 =?us-ascii?Q?8Qk6+SZ8i6lQm5qMqg+ignAg+hdhmhU380zq+o4mvCrLemkhQU74HJHICKp0?=
 =?us-ascii?Q?spY46xw0Kn/mD3N3QC1OhEwaKnOko+LnsyhYJV+8Vbt8+ZppYgeBB7mWf7u6?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e97ce2-26e0-4f2f-39ba-08dc23347c72
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:45:51.4696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTFEtCpY0h3dald3ohG4VwgyPxLRIL3CLvXf8bp1MQTm6UF/2FjRDoO4xDohLkBHSUBTbGn4vYxwu47Live8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7756
X-OriginatorOrg: intel.com

--GApH+OYcZNxoTc9G
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

hi, Jens Axboe,

On Thu, Feb 01, 2024 at 07:30:53AM -0700, Jens Axboe wrote:
> On 2/1/24 7:03 AM, Oliver Sang wrote:
> > hi, Jens Axboe,
> > 
> > On Thu, Feb 01, 2024 at 06:40:07AM -0700, Jens Axboe wrote:
> >> On 2/1/24 12:18 AM, Oliver Sang wrote:
> >>> hi, Jens Axboe,
> >>>
> >>> On Wed, Jan 31, 2024 at 11:42:46AM -0700, Jens Axboe wrote:
> >>>> On 1/31/24 11:17 AM, Bart Van Assche wrote:
> >>>>> On 1/31/24 07:42, kernel test robot wrote:
> >>>>>> kernel test robot noticed a -72.9% regression of fio.write_iops on:
> >>>>>>
> >>>>>>
> >>>>>> commit: 574e7779cf583171acb5bf6365047bb0941b387c ("block/mq-deadline: use separate insertion lists")
> >>>>>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> >>>>>>
> >>>>>> testcase: fio-basic
> >>>>>> test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory
> >>>>>> parameters:
> >>>>>>
> >>>>>>     runtime: 300s
> >>>>>>     disk: 1HDD
> >>>>>>     fs: xfs
> >>>>>>     nr_task: 100%
> >>>>>>     test_size: 128G
> >>>>>>     rw: write
> >>>>>>     bs: 4k
> >>>>>>     ioengine: io_uring
> >>>>>>     direct: direct
> >>>>>>     cpufreq_governor: performance
> >>>>>
> >>>>> The actual test is available in this file:
> >>>>> https://download.01.org/0day-ci/archive/20240131/202401312320.a335db14-oliver.sang@intel.com/repro-script
> >>>>>
> >>>>> I haven't found anything in that file for disabling merging. Merging
> >>>>> requests decreases IOPS. Does this perhaps mean that this test is
> >>>>> broken?
> >>>>
> >>>> It's hard to know as nothing in this email or links include the actual
> >>>> output of the job...
> >>>
> >>> I attached a dmesg and 2 outputs while running tests on 574e7779cf.
> >>> not sure if they are helpful?
> >>
> >> Both fio outputs is all I need, but I only see one of them attached?
> > 
> > while we running fio, there are below logs captured:
> > fio
> > fio.output
> > fio.task
> > fio.time
> > 
> > I tar them in fio.tar.gz as attached.
> > you can get them by 'tar xzvf fio.tar.gz'
> 
> Right, but I need BOTH outputs - one from before the commit and the one
> on the commit. The report is a regression, hence there must be both a
> good and a bad run output... This looks like just the same output again,
> I can't really do much with just one output.

oh, didn't get you... sorry.
attached fio-8f764b91fd.tar.gz is from one parent run.

> 
> -- 
> Jens Axboe
> 

--GApH+OYcZNxoTc9G
Content-Type: application/gzip
Content-Disposition: attachment; filename="fio-8f764b91fd.tar.gz"
Content-Transfer-Encoding: base64

H4sIAJWtu2UAA+1a62/jxhH3V/OvIAQUuQPO8r6Xa0AFiiAFEqDNAWn65XAQKGkt8yySCh+W3cb/
e2eXIsWnkl5r3wXYAQyZM7O789j57YO8jdKLlyYEJASzv4hh80swItUzEKfsAjPOBRGCUHSBMBJc
XPjoxS0DKvMizHz/4nA4XG3CIpzS293vX8Oc1yaCCLtC+Ioin+Abqm6o8PX6LvW/+bDdpatw99Fb
5Qt270WpTrZRohdRuiyzKNkCZ6P3xd2CEi+P/qUXBDPJAipY4CXZ8jba6XyBPfvbE2+iTK8LEGZl
UkSxXlCEvCh5CHcRpECbVuFul67N//s0jx5hrGW/E9PxMtfZQ7TWy+JprxdZWiabLF1FiZeFySaN
l5soL7JoVRZRmiwqnrcFtf0y0/s0K4wb+0zDU7hZIM/7UIT5/RJ99LLD4pBFhT6ammZPi+vb/Drf
rLCXlPGnFIIi2Df+r/5tlPpXV2lZ7Mvi6jbN4rBYfMrTxL/yvnRufw+B+fPK+Jcb43z9Y04laupf
ItDDhBDp6v816N+e78/MHH7QWQ5VMvNv7PMVnVM6e2ekpkIhSPHeyLCEVHKMpOjKlnHeFQeSNBq2
03+U2v8hTPwKaRgzSGPQpxqkAhs/3ZtStV0Zy0Cwsg8zdm/1gFEDkWXXYHQSWkyyMkpqroEOyzrB
Ry1KMgtQVoprZo1ZE20qTOg2OSJZNTBCjT0NqPVGqPHNsi3GnVxYnhl7gHpW74R8jT1DAKw0Lb/W
qrHPitAMmM82GwbfDO+DVasyUbGT8OhkhZTHjkwCDaxGtifUMHWWpVmPVYQ9xi7c59o2pAi/a401
nA2VawdrgMXnZvwmLQDVVlzDdVvjiNxWLtjsKHhuxqxD0RoMsrF6KqoJgt51+PejgtVhvMHqMOxi
X2nNKyBsiVqzqc0u0iLcLaN00Hl+B4vZmAAmxX60wS4slv3IAj+Okp6qYYaPI0wdJuPWm+6LzUY/
TIr/biUN57ll2PprNexrtQvm29AGyx0YYbjhdjsx50yTSRONdNJAI8xhDdiNlck+H7Ov4g8trPjT
Zlj5uWAdNVrWDKq8Ao7pMicKUUwVpySYKngSUI5UtcKdYtCIlZCCEYI7YitgTIkRCCBUEDZHUnLR
HrMFA9RsmtrjdbBAokBKRl8QEShiY1McFiimUBCMznQswSlKEO3JT/kLGCNzJhDGYjjfj059DkwQ
yB2iYwZjrDiTsEdhoyYHQgQ8oHguYGTFJ8xWVCiulJgTySmdNr0j2OtsrSGfO923GoT4OJGrsMEu
ilHyrqvCOypCMUlQTwWjtk5AsEIo6OmQtg7kBgss+v3Qjo4QsJ3rJgh0WFuHcoWpJP2xeFsH5glB
aqAj2jpQN5Ri3ndddvxCioM9qq8UdJQoEYwFgvWUVNd7QiXHom+SaoeaKMzh0DKwW6m2/0pQgYcB
ACV+CkAAu10ZDDICSqpRgpkTUEllP9xGiddKCgecEz6qpJoQYKYIVUSJltLzZ6xt4BnlYrqYJOZq
spgk5xyMAr/p+WIicwVzXo2se+dw4LT6YdGpxNYKSBiXuAfVx2UQo/MLoeKwAYfAM9HvuwYwKedg
HGR1cjmkUslWfDpLIkMBG4gqqwVmvfWntTLCvA3EXAWB4IOuT5GF+p8zRoWkA52eeYM1Eg4NsdsJ
u53wmGFfq11uJ/zf7oTzp2Tdq/LJwvqqsj7wBI71yxZUwO7AXDk22Dgr82y53pfHATBs8YJWFPKW
TAC2Nng5WxeP1f6GwlLWcOPw023HQRMGy5GnBay+i1ru9IPe9cKMq9FwP2dkgs8m+MEEH4sJAbUj
mI0CbB/bW5HZnxeCtRMwiHHtT16u4qjoOYQmJiGbXGaDiRa16QMBJROCrt2f49I6NVUyOBWedcpu
thScAv8fPg3y9Pk+QaHqZP00KNbZVPimRsJT7pMpAZ8SYDTZ12QbPtlGnhsH/a7glH+w4ODJ4PQl
crJNKzj4bHDiqeD0e2STIx0FjAcYD4KDgzkczuAAM4gOHLwlnBLbB8A6PNDIABZRw/gQPqdwkA3U
MEB8LhQK8GiAKMZUqPEABRR3bndIK3aMMdkpyJbw/Kxr3k2cDveNrAizrS66q0ot614dDNG0UTxE
ySY9nBZLs1B+NFqzTZTfL0vowgh71/rNnX6+WZ0u9M1l+GAjUF2e1WzKkWBBt0WswY/RRieJkIQS
yroNi2h9P9quEVAEh/GgvcImy19KXR4vyCjCwekcNqudBZyWghDJTxHxnv8Q72Zfg8z7X/Mq5yXH
MFP13PcfUE+n7z+IuDDXge797+uQ+8rjN7/y8IC+dJpejGz9Q3JecozfqH9zc9z7/gPqn7j6fw26
/DaNYygZf6WhTHwzFTbm7Tm4a//ybH29z9JtFsb5NUyWayjmmXf5M5SkVfbf5HqdJpv8rdlsUeFd
/vSUFzoeCAmeq8C7fF9tZfz01v/2/c9+cRflvnnVv00LWKr/5F1+V30O4L85ADj4a8CH+7fHzu5u
4vgmz/00882vGfEG9kKceZd/edBZuNV+fhdm0LjQj4VvoMR/U91NvjU7okarTI56JuFn9GBqrO/P
yO1lyYj8b+FjFJexnwEmboy3uR6YgznmgKlNX+d0bZefwO03mf6ljAwu+99f//jW35uWt2G5K/JK
K0oqrfUujGKjFvq3kDrdU8VEBqD+z3QH0BxmTz5kqYrZISrWd9qoKMSVUfo+eTijRjHDkPMDJM1a
8FfAaz+vpkCU7MtiyK4+NwM+h2rHikH6foIsg9uxznMwM4cYJIVt1xeAZzp6MFPUCKNtEu5yf6N3
wMuO3Pc2czaAdfwYUjAxv3uMCpPSorQ2fenKc+TIkSNHjhw5cuTIkSNHjhw5cuTIkSNHjhw5cuTI
kSNHjhw5cuTIkaP/jf4Dtv+SSwBQAAA=

--GApH+OYcZNxoTc9G--
