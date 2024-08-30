Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098715217F;
	Fri, 30 Aug 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725001448; cv=fail; b=uy+BA2Lnfz8zYXt5k+4ILeOLwhaJOwfy/lEUmswy2xaFOsqXFBNjjwYoNxFXed2RWMVI2x9a7RZfy7RGK5xo0bFaLhmcwvZIpMR4xpqh8WyK/X3Baqg6Z3IyHZOstoAgoUSTH6+9d34mrhgmEEwB2dRIqDd9bFf2MtCWAcsURxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725001448; c=relaxed/simple;
	bh=RcWNY9Unq5n3U+lEo99qqeZSu2Vv/BXRSoX01jjaA3I=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=oY8LfPgQ2cGd3iGDD/Xl4iAltyq7Rz3GlyBZGzSkRwk9f80jyZdC5eH3qURQcq+8hptlXnX2MiXO7dm3bmiPQRpRMEj6Mr/Qv3RkNsiY+qHiCj26x8kzfa0PYVaPwJpcnbonytE5I4dBzuMKX4EvkTFQ8RvUigwOQa0OHW4WDm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XUld6Udf; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XUld6Udf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725001446; x=1756537446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RcWNY9Unq5n3U+lEo99qqeZSu2Vv/BXRSoX01jjaA3I=;
  b=XUld6UdfOKe1tEVWXkjkEN25Y+cqEW1ftwsf8mr95bI+drOOKpd7GYYv
   +ELdLOLy7ajyXyudqIp89l7goGNlcTM16ElOjqvB06qOHCGAAsH79LeLn
   wfVZPwoN6XGIBwwd2hItRIhmnwG6Nt49Ozi6G5GdEhvr+t9F/IG/arX21
   O1r5/FR7uq/CwawS9VHFuh3swvKxQseMOWHApNLhRxKDlMDKsRwlAo2K4
   7vvhXsGwt8rU7YdZzFOndkwCz/54d/hU6pZnht3DFVK1aKYObXluvCHGo
   7LS68QfYwCCD9VqmwMRxvW2MmqxESwnjkNbTX/jp2sH6bnIh7iXgLI5us
   g==;
X-CSE-ConnectionGUID: RwfgI1ECRcKqwYNJHKhuAw==
X-CSE-MsgGUID: 3AX4ENxlQ+qNGDdOeGKC9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="13293873"
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="13293873"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2024 00:04:05 -0700
X-CSE-ConnectionGUID: muJ/EO/iR0K/VQ6Gek02BQ==
X-CSE-MsgGUID: /SEzLKXXRRaJkmUDOuOksg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="94551823"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Aug 2024 00:04:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 30 Aug 2024 00:04:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 30 Aug 2024 00:04:04 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 30 Aug 2024 00:04:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJJpVYhmZe+hc3madnio7vko41ZbR+f73i6Sz3QmZozBRFUL1K9X+EtUKUrCItSUhBERv0qfT6wcUMa9M4Gv1Cyx4YIq2MoQ71RhF47684jdN2FM0vADSxqrKXX073+K0GHV6nj435Pmyj4f23qNvCryvmiQ0WQ8lKgrLwhqmsubfFF945LfZbN/TzITXGatqopIGvxtb8k8SQLEc8OqePIX4oeGAeWMingn23Miuc5PETZOz6KtUtmnpmCsHnbvI9gWlxkYvKTAqgQ5CI7nK8hm1fiGroSONpGnlDZ0oCbtDJIbss6WoJtdXlJnu4sJ5ejADgIxLROGXZTb2/yK9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=60aFE3LGLCtstaa1o+F+Pk9uDJ5xEHc6u3gYjRHZe/U=;
 b=watCAIxN3TUDrv+LI4P+89VNyyWkns6E7EYeWNMlUUNcPlnV82mKTqME8tqbwW5csCx33BOa1wZliiZdKmL1vJDC78qP6spVpoELfeVDa2WtE4whjUfSR5UCdeM2kGh4XiDQoohAb4SF/kXof+axURN1MvbPaSrtIUGbz6cnicMRjkG7BBdqBFA89a3nzMz0SZfN2w+B0uOG6RRKV5Azt+fo37LZNx1KN2LBpd1lstTFIG7NvLXguhJQzsws10z2hrYnbKWc/9MgO4Air+45utuIFSEFDPR5hQpN9kh9pHQS6ok0ffPA0qjUcUlKi8e7O3d9UIRd3Mt0l63FFuS+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BL3PR11MB6339.namprd11.prod.outlook.com (2603:10b6:208:3b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 07:04:02 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 07:04:01 +0000
Date: Fri, 30 Aug 2024 15:03:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: John Garry <john.g.garry@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  64b582ca88: xfstests.generic.351.fail
Message-ID: <202408301415.8923e617-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0027.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::14)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BL3PR11MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 74cc00aa-5e00-47da-e7f2-08dcc8c1ed53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KxQ+V9ud6whscfpkK+b4s7pMgBwFA/mT0Ms/XSZuaYfs2EWEwVpwaMXMYOiP?=
 =?us-ascii?Q?MyZqJ5I+V+/t5QyNQR4s4v42Zrdx95IPVsPSHPDizqGSNGfaZAIKrq7BsgOK?=
 =?us-ascii?Q?UWxeOAC/dE8xm7TEAZWf51xa+6OkYL+nVf6rVf/Mu8BDPyXfsYXi1vKgqLtI?=
 =?us-ascii?Q?uHgfqR5i7+1+rA5gAqPUsys1FaZic5moi1QIF1A5rfi2TSd8swbEXuzDsdfb?=
 =?us-ascii?Q?LYIS96KqrYBLYN6gFYOBuK0z81V/55R8LtVmskjPhuETMIcUsVZs3E1m0SYF?=
 =?us-ascii?Q?rI5PFHgBx3Mhl5yIBDR+FoZ4Ub4MLZW2Iz4Ff+ewazmuSh+8kM58ER0QrsRU?=
 =?us-ascii?Q?tbbwZ/quwRkrNtoe0J/t9Aex0bn8pXkPKb/7i0XI/0kuZPfk39QQAompInQn?=
 =?us-ascii?Q?KTFzbQmfqt/bQ0DpPU0p1kYV7Ys0zFMRarTEgVb+gj2Yfbf0z22eKFUOd8II?=
 =?us-ascii?Q?lrpxOCK2yteGut027WayU3VNLSKFvbQ1ONZ31pKaIYpI9B6fv5s9GUqGvzYK?=
 =?us-ascii?Q?ouiUlb/RBjegtNVExJ6M2Wfd6ginuHzcJoUaXvQTliS4fLkvlI62u6hY1UlG?=
 =?us-ascii?Q?gruaII9uN8q7fGt/VHGfBdtos8jBlH7vxM0g/0S8OBwK9/CJsa+SSlTENGzt?=
 =?us-ascii?Q?1zqB8SJIiaq20k5nLgqLr3sxNGoIRu0kyMlWAuts+DBqCy9S6dFNtlGX9NQo?=
 =?us-ascii?Q?Vsj0gTQ9TU+4ZF919DDtGCmKNEG14dY+xs7HUf9nE8mdds2FxU1Va1g3OB10?=
 =?us-ascii?Q?0eIzaJzEZEh6RSwks6k3RDV8kFKUs4bhnIyFLDPpdhW+TxZ3dJCPI5Sz4jS+?=
 =?us-ascii?Q?m1boX3QT1rl3bbMIvUKcP6tiQil3bya4IUGEZqCt2ZwUFJ5GnS195dNjr/Z9?=
 =?us-ascii?Q?4MEdiYRNaA8NbUe/1MTalhq6xru0YcLhMmlr10V2H3oEJ3DK4jUKhfaZSMko?=
 =?us-ascii?Q?dZTp08Y2xncWiU5EQtnZhxj1bKKHHDzOw9obeUygggN9c5xTVZnqOvnQ0AY6?=
 =?us-ascii?Q?VpNiivQSSvDIwKGQgLIEN4zvkb41KdChilFw7xL5nTBII3fhv6XUlrJKf4EJ?=
 =?us-ascii?Q?CkD9dT7dsXIFbFM6EyL00rQ7V7+yncTM4C/BPWcns7yu9fZMkEVU10bvfpxJ?=
 =?us-ascii?Q?Yo18T9i5po3NydE4MVlv/+JRNW+jAi25zBnFm+TK7mU/ZEwFgMov+AJC24Kc?=
 =?us-ascii?Q?bvweIlgXHfPGfD+a0Gmjk6YVFGbXXEbaS6J42/7vlF7idE0JLYWy9XeD3HQi?=
 =?us-ascii?Q?KSPsme/9dP31+CXlM3p8yIutuRAzBVo+uGXNU6q4PE6r7FgnVkWbIFj9H1Lq?=
 =?us-ascii?Q?aknnY8gNpQTMkAAeoi3f7u+L?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TsRAIMEI1Mk9MgQ+J1f37aKGNtxGfwYapVzgqCrZMfvqWkKGsgFVzrlxhZL0?=
 =?us-ascii?Q?cKbUMDEF3ImKkVAJhX2QMxM/67+RDTG9tJ8Scw8K8VrSPyZd4ZJNvfA7wAbv?=
 =?us-ascii?Q?BL4mp+cP6F6MP3vff70ImOzl8W4+L+45twt3iEBOHSqDr1spOar8B+Bg1OOD?=
 =?us-ascii?Q?Bi7sG2ieSWmC7OLGwtOILJYabL0dbL2hofU+j1CJAXYTaR82svDUelV5zjmB?=
 =?us-ascii?Q?KdNqKawbtIdC4Ct/nhfzh2VAUMUqWvYSZLud4IzylJMpkQqk4MQdrX8m9ANr?=
 =?us-ascii?Q?zEmtzHOrd39gg/o6fynfGKxlhIjq5h67bmG76iu+Xc20xhp+lknWtm6xBBkV?=
 =?us-ascii?Q?Z2RbwTR5/xHpopfouxQKB8prG05O5KPkG6zu3E+sOJKhO7A0Fpw6R7nzpIgL?=
 =?us-ascii?Q?ieYlULlS9NujzBU/UmCoFdMFQ/xxU1/2gTGVuGtgMng8/8oTC/WznivHx4mZ?=
 =?us-ascii?Q?ztM3w8gwP347atHXAKM/6/FwlMGh83TA4nTqrJS1Z6lawP3fA1Srcf4c0EWT?=
 =?us-ascii?Q?TPV8ElOuztvWsRc/18ctuy9txU8jfxXqRuGCvLPpM55hFJTHvrKz5gbEIERR?=
 =?us-ascii?Q?aBi2ZLll0TnTS6AjtkV1+fCa5yNQ1UcRi3MtLnAil+RkAGyHE7aZqxbdBc3V?=
 =?us-ascii?Q?NyeHSlP5girAiuREq9Eao0KbIaEAUQqGpIUbW/ypxT4iLrfQGVa6NxLo6yls?=
 =?us-ascii?Q?j7GnTs+bVwP/hPvGAG0QDgjV0riSSskoFHStD5k5Zcz8/A5HIRB4hNxQ4E0V?=
 =?us-ascii?Q?UEMDaGdKyI+63xwaj2eC/0idxIWecUn4g5D9M+9yWUq9sRR9++SX4WMKUZHM?=
 =?us-ascii?Q?dHTtidOrXuZ7UUUo1WDxAAaio4zyrRLW+yN2qhLS0NnEzSbLSrt2gMb72JJw?=
 =?us-ascii?Q?ooMf/4v8hvJ2yzsIwzGG71wFNj0+/R4AMlysd/IXj6HB27l4BmUGgIR1NCZm?=
 =?us-ascii?Q?vncnk02SGAA9p7t5XvI46ZBKBdZB8dDW916OvGfNeuUyu5lBtGUtbfyidSY1?=
 =?us-ascii?Q?O/Qys0zySd6i51y0nuqBhVSlI4tS5h3UH7ps+7qltnCRQMyH1L1iDx4B31m3?=
 =?us-ascii?Q?LJETI3dN3IU70PKmhygQIQWyUQXHInDgUf7TOlCijWICVAMdoShKNNSUgNd2?=
 =?us-ascii?Q?9lYdaCrkJXvXUV+5mTloFs+aGYhShOtq1rF6OVH8WSuNZ1y0frjpH49wj1b2?=
 =?us-ascii?Q?MDSYWeOuBLFS6ZUpzDiPMPvyaQ6FMAQTm87ooKoS6x15E7vVG2+sqQtZT6Bv?=
 =?us-ascii?Q?oAYM9c+Iz3KHb9siJ3VySjdVhXJp4leDKB4oztUE0N253Ex2PLkl9bFHKcP7?=
 =?us-ascii?Q?R3saYCPUaVnl/59q9eoevPAA7GSzYdXUzDHrJy7tXiVPxrV0MdIGuHyQIhho?=
 =?us-ascii?Q?gRzuPCDpyCfYZxlL3B3tYjxqJ7bVmTir9pt+8Td0Oy3uKGYnxWNQ3C2vhbgk?=
 =?us-ascii?Q?9UdK/d4wXqHe24pmbAo+mDll4Ic8ARBIZimkn7CI27ScHsFF4kye4eRdi78H?=
 =?us-ascii?Q?2MuQkuWwzaavr8Pn1WhCcBItzj87jeWYgr/qDGwRFKbPiNi2VH7ThGDBLxZl?=
 =?us-ascii?Q?Kf5SHfamc3i3dG23Lkm46eGbUbkO9COD1ybWlck75JWDeuvJi5FZmTp0GGur?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74cc00aa-5e00-47da-e7f2-08dcc8c1ed53
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 07:04:01.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7D2tazoE3YnX+ruabt8efSdq8wUEufNUrtL2m6+JPAWOUnoNMSNjuG70SV+hNuiOBiUB9pEhhGVR7y07neo8jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6339
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "xfstests.generic.351.fail" on:

commit: 64b582ca88ca11400467b282d5fa3b870ded1c11 ("block: Read max write zeroes once for __blkdev_issue_write_zeroes()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      d5d547aa7b51467b15d9caa86b116f8c2507c72a]
[test failed on linux-next/master b18bbfc14a38b5234e09c2adcf713e38063a7e6e]

in testcase: xfstests
version: xfstests-x86_64-d9423fec-1_20240826
with following parameters:

	disk: 4HDD
	fs: f2fs
	test: generic-351



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408301415.8923e617-oliver.sang@intel.com

2024-08-29 11:48:35 export TEST_DIR=/fs/sda1
2024-08-29 11:48:35 export TEST_DEV=/dev/sda1
2024-08-29 11:48:35 export FSTYP=f2fs
2024-08-29 11:48:35 export SCRATCH_MNT=/fs/scratch
2024-08-29 11:48:35 mkdir /fs/scratch -p
2024-08-29 11:48:35 export SCRATCH_DEV=/dev/sda4
2024-08-29 11:48:35 export MKFS_OPTIONS="-f"
2024-08-29 11:48:35 echo generic/351
2024-08-29 11:48:35 ./check generic/351
FSTYP         -- f2fs
PLATFORM      -- Linux/x86_64 lkp-skl-d02 6.10.0-12052-g64b582ca88ca #1 SMP PREEMPT_DYNAMIC Wed Aug 28 21:41:11 CST 2024
MKFS_OPTIONS  -- -f /dev/sda4
MOUNT_OPTIONS -- -o acl,user_xattr /dev/sda4 /fs/scratch

generic/351       - output mismatch (see /lkp/benchmarks/xfstests/results//generic/351.out.bad)
    --- tests/generic/351.out	2024-08-26 19:09:50.000000000 +0000
    +++ /lkp/benchmarks/xfstests/results//generic/351.out.bad	2024-08-29 11:49:27.839575963 +0000
    @@ -25,7 +25,7 @@
     Destroy device
     Create w/o unmap or writesame and format
     Zero punch, no fallback available
    -fallocate: Operation not supported
    +fallocate: Remote I/O error
     Zero range, write fallback
     Check contents
    ...
    (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/351.out /lkp/benchmarks/xfstests/results//generic/351.out.bad'  to see the entire diff)
Ran: generic/351
Failures: generic/351
Failed 1 of 1 tests




The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240830/202408301415.8923e617-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

