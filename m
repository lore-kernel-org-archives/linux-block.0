Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5175433A702
	for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774175035; cv=fail; b=qYtrpSquaTDrdWLBXCbk7Q4cbPt+fwZFu+MzzzzaCpDlWXkYJYMfc2piUSSkVzdtzKy6h5aJX29miI96bvL+iD3cC69bxPeRSmlUeQmwqOYuHUryr3eC6/HVrI7VFc3RFHc/x7MY57Ztf9JohVUsyY9omJ2j/vCki8avqLlEWN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774175035; c=relaxed/simple;
	bh=mVjwD4XaZzYSHvttfBxl9cUqDv2ZjgqcnGfZFAlRDfg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=SNHV4Frq75n/TCn8DpHOP3ImH8skUWWFpCEy77GDLWV5x95umadi7hsaX5Z7RAdGp1G1nHipulIx833phVIQaBx6RQXPmivyGlj+cbdtHIfkldFSbzJ7OEQES/nwesQnvAeh5H0fPqhq9AFElKnxBlrbwaxf4RBDMNHHV0p+9pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X27Z8rZL; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X27Z8rZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774175035; x=1805711035;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mVjwD4XaZzYSHvttfBxl9cUqDv2ZjgqcnGfZFAlRDfg=;
  b=X27Z8rZLtdzZJGgeTV9IdB05FOO6+uUnYYEBGOBQrR033KhmfjmQ0HUD
   IZth6LbZ8ywVFQD6n6h0sVU7VmWK79s/p3tv+2mz83NsdlFcByUQQP2wl
   PVzWdPe4bNczYS4wm2eOiAzUFs7tIDZWP2ywSLXa+MZBRbsbwtAdlYEQ1
   dsA9wQA7gzYyjOKBx+H7DMTYzlu8L7x0d/eyoz6ijTkgRfYq2qxA+R2wk
   ZnWiykdT9umVn//d08NHF5jBrRHMmEJdu8+gCpJacMN/vypHldb8EzDfH
   UuHVLTb63QsDRfLC9DyqD+zYM4gr0DSiVh4zrxvYLhn+IHuu7CBqWcLiC
   w==;
X-CSE-ConnectionGUID: lqtXafSoQW+Hs8+zg3mAug==
X-CSE-MsgGUID: yVzfDzE9SsyWzkZFK3yRiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="86676817"
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="86676817"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 03:23:54 -0700
X-CSE-ConnectionGUID: Ia5xV61yT5iSmVqpOMommQ==
X-CSE-MsgGUID: Spr+0M2uSD+HO+DvatQzUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,135,1770624000"; 
   d="scan'208";a="247641963"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 03:23:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 03:23:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 22 Mar 2026 03:23:53 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.3) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 22 Mar 2026 03:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIZjz1kGGzei9RWfPbD2f6xlUBt9izM6lwCouo/MUb4/SpVwDNya3LwyDQ9aYlL01pYJyNdBOS3QlzSlHuYPpSkEktuunt7aiVfO9UExt9w5W2vHj4dNwdAN6wksc4FTVhIKA3wRZThv2l+8aZhgyiDbpv4hMGuCd/O89IFCd8erqM2lA4wqY70KiUQraVCIWGvCLlD9MqSy6zQZvD9Hs0Ueeefjv8+/MDHNfc0HBlLd8VykCtj3JkG/GtGKxnsnHyK2OKl1QA+R8e8Xwrgv7C4be21285Y3oH85lwN1px7nwAiE7UKOeddbN/0RXV7ft6Yo1FClC2FI8uu5nmUhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYm1vFRYobOwbbQnQGovm8iAQSDgisxV47onhAt0ZdY=;
 b=ZCdZqs7UY73xG31l0GG8cPNo1yZ0izLCYLTrjiVQXXbkLywk+zgFFrwWMQhOFMakKBkPOc8gab9clJOJeB4clhmyysF/RRloO9Be3yuQicm4m4tmgYMF2maIX8ZsrElpYyDsJaWk69A0vZSH3VqHzEp8rLG9FFz/0V56QpC5WIRVV+sqcfNZXftW/5g8Fc/TrEzGSXRhDB//dHYRj1DDxXFLKZfS6jD+fPv+Td4xX1t9qzUBjNqhOakqoxaAndBrPSAx7lsuthUnYHUFjYXrE7OHO7KmqqLcx2ki1B4OEShY/N39yGIFw8MN+8oo5xce9YZ227N3AYm0THKVTxqYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by DS7PR11MB6040.namprd11.prod.outlook.com (2603:10b6:8:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.15; Sun, 22 Mar 2026 10:23:50 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%3]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 10:23:50 +0000
Date: Sun, 22 Mar 2026 18:23:43 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [axboe:for-7.1/block] [block]  b520c4eef8: blktests.scsi/002.fail
Message-ID: <202603221746.420c4675-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|DS7PR11MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 699fba16-3a49-4098-7bfa-08de87fd1c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: wUxzHhm+Ht4vs5Ej8aB58uS9mMfRHdtsaLI+DWaalrhF1Rdxv0cFENsLywvnm9Lvi58NzmQT37wW7FErJiIxwwUioed4F7Pyvabql4dnyANykWqJfMe2918bG6x1bgbSeUcVCbvhdPB5oh2GSIwdRiPdaWb3CVHuJyxBAghxW/F8Ms0Y1bxGHpa+G2wXHQOoahHgscxAJfrilvTyY+LY8H55mskVi9lbBh5dKrNlZ5CWZ+9qEFTMJpn5CMeiD5GGSByQGdOuWUXGZXcEjn0XIq67UFtL4ELyl56kJ9ipD53EKANGjRh3hli7PwONIBaLIEi9ULGF1E5bsPsOwVwF9BVsfhp/Dntz3qCnytHGjCZBpUjEA3Gi6DGsBDE1eaB9Bq5UrPg46NVG/mFjeTY5+xAp+MQMQCxSlTrviyI2X/KMBijC0pXLYBn9XwCv1JHmeohW00UXBxFCes7kSuHGg6hc5Vxo01E1UmdeW2GFd5atW2G2z8t5zJXV7n1aAyEEbPExO49pPEU7V9ZoLO7n4xph/hhsxlttqy9Xy1rB8CnqTvhMu/Iiu1lswTeZcTbf+s7b+I9bl3474kJKA35puKCqnCKCY5wdqmu0dFUUUKk2DlAs6PhN8NcTnzpssjfZ+E/h+iRm/3wEqNQE6K6zNDo5jHc7xu2psQ6trvpQq0kxgrAVpgBNwPWtnNoN3TUN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0kiObXmhhBjhT4xUsT/GUuMQTgTx1PiX+iO8ZGIKdVW2LBDE4JVCiDqVmvd?=
 =?us-ascii?Q?uqafW0pNgXjp09/4Z+l17t7RUKQxSTH/qQ/jAlsJOyzFbrB+Ecjjn0H5Hz63?=
 =?us-ascii?Q?9KnirD13bY3vqN2wKRMptiOZIL2KyI8k/4ZTK5s7Dbmr6cww4pQaLvg06S9B?=
 =?us-ascii?Q?7g7ERCxMKdeVPOAZXNmgDwZCrSfFrRc+rIZ0QJHqJoG8nf4EtGbnjQAzOVcw?=
 =?us-ascii?Q?8KI4ogRSnpVSkTyhYjp9htZSPw/Euz545o1dfPkuKYAhmm4rbhKqSqq31hcv?=
 =?us-ascii?Q?Hvj6oDH5607h6/004VDJVX6DXGNfgKHZs/v71ivPbB5JZgM462OY/1dUpdb9?=
 =?us-ascii?Q?DrJTx8AX4813FTgD2eGsIHxGXAFQufaYU8Th/h9qFXBSBdvzgkPo4P1Vc/5k?=
 =?us-ascii?Q?NzCAQfRPBAzy0PPkHPaFWUB8Oh+usjomWRuUS3EK5F/uDmlUSmhJejfHEzhg?=
 =?us-ascii?Q?KDSMRYn3z253YZnGW2yD6Pxk3W82+armWilab5hbTSlx+3JuSMoQQW69YT/j?=
 =?us-ascii?Q?fB997/QODxplh2/cFBDLR8jKnVNPPjbzrG2z0nssfx9rJDdV/bKYQyUCo6hw?=
 =?us-ascii?Q?K+qpONXysokjmgKyRuwd6rHQf6Wqk/58G8BEiJ4amdCI4PjxFjO1XoiSKAQ7?=
 =?us-ascii?Q?ELJYlIEUIj9qxUZG4O3zfloyrCQhrUyo4g7PuAmjjYFzf1F+B2AtcRAFx+Zy?=
 =?us-ascii?Q?q+TMiGT4gwsw1li/ayjopmVl+FXTQ0MZ2+Mz/uJQIp22DrwKY04yvAuoELne?=
 =?us-ascii?Q?gceieCn1KUMQq+//bc9HuQq3XFJ/aHgJTiWBtYZG8oeGoORm8hlIT0Hyw9jn?=
 =?us-ascii?Q?r+LbQvXmnA3I2GUuLfsJWMBj853MtHTI+uGnRl54A7k0xA+I+K3J1UBZ785h?=
 =?us-ascii?Q?laCLsi8Z0I1s5wpU8xktn7xVvBk+SHcM8qZEX5FS3ddDL+vKWM87jaJnfIbR?=
 =?us-ascii?Q?06L1CVt7OuPdB31eZREoq66WvaPrY2pEjX5fkEUSupW3wqEQ6ul7H2hYNqmY?=
 =?us-ascii?Q?CggCaj2LBkYijWIuqmPjIMsVW/a+7xlmPCW6U/effVxbLRW/ECV97DTMvTtw?=
 =?us-ascii?Q?n20MkCdLNaqWAu2X7A1fCguqxqHDKXaisUuQAX+He9ZbDAVTtj5epCf5SajG?=
 =?us-ascii?Q?lrpBYxHLXWzDz7Zw2VOlxM5kx9LwQW8mMUxqJX12+21Nksc1N6Kcvu+JaAx4?=
 =?us-ascii?Q?yrG99qXWPenXaqMZOrll4R+89lBVO3vHaD9I4ykmlbovtXCxSUB8x/3IaxYT?=
 =?us-ascii?Q?CJlj/jOgzNoxFDFmY5/tgp2EwF2dhwxnwpeyZgLiL9Yui/DUaD1O3oMnYx0A?=
 =?us-ascii?Q?J6nF5j+DznrHzf4PZokDM1sjSDvKqT0bZfQDHTC3gKQ3ioh9Ol66pDILwO08?=
 =?us-ascii?Q?I3VGQ/uT7UW4+D+aanVGpz+wfZhYweJrSaRFV2be3s9XeA2ECAIAUUG6DxWx?=
 =?us-ascii?Q?XR22P9eUj2ekLtBo+okNfr1yGxKRqwHb1b/iPaG8Ynfm+CWxaDsqTDJc3bNr?=
 =?us-ascii?Q?rcLii9QBaZ36YWHbAg9xG7bt7YOnVnnaWc3Y/YkboPLs8m+kXGNeQvTjVNWU?=
 =?us-ascii?Q?yfznNfUiU9dMr5DJLCB1OaGVQx9JS7hkz8xZ2Nf/alQUoZzE2mMSmLbRVhnP?=
 =?us-ascii?Q?XKJ86JvGfEqDwKuthrruiBnQW0KRp/EgSYtTtQUvd86ojkM+1x+gVydupQ0K?=
 =?us-ascii?Q?yuKaOh9omK9ObVySaz6IhPGUKk7R8TkVQYNa9tGgDKnxz9AvVxjwc0o04A+m?=
 =?us-ascii?Q?RamRIbsVkA=3D=3D?=
X-Exchange-RoutingPolicyChecked: VdK+2bovO9LrJ4zqUa02E7/7ifGUfG368rK3uvP1hsEA6NzxWRQ3fseGTUcOhDekoxWmYllvKbj7MMS6NhtUMm4zXyuJkFZOjlvcWfw1er3H1FBHkdpOuPIK+1aofK4FzQrMSu8ZWueUROT2aq1clKpLALyVIFTLeyIHsNoNmmVtm2AEagtfAcrTs0TI06MlG5hs90r0c/hOMGseLiGPys14mOSoEu3xAUuBPa5CJvg+ce4U3lLHn8LCp+svfeFlM/GnVyiGrrVvMbooXfu7zPlUDmbhqcu3YylXTw46QKb0IatdwxaCDmvmysAXI0d7GOBcj9i9c+985tyJzVLSvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 699fba16-3a49-4098-7bfa-08de87fd1c1c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 10:23:50.2420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qd4MYBMBeqo6KN6pvHKLHFgbBxFXqscU8uhC9paYXmtOmwHeWUWwO1xLApDKgvxCI9IcKvPSHxkVEAJT8SlLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6040
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.scsi/002.fail" on:

commit: b520c4eef83dd406591431f936de0908c3ed7fb9 ("block: split bio_alloc_bioset more clearly into a fast and slowpath")
https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-7.1/block


in testcase: blktests
version: blktests-x86_64-7baa454-1_20260320
with following parameters:

	disk: 1HDD
	test: scsi-002



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202603221746.420c4675-lkp@intel.com


2026-03-20 09:39:22 cd /lkp/benchmarks/blktests
2026-03-20 09:39:22 echo scsi/002
2026-03-20 09:39:22 ./check scsi/002
scsi/002 => sda1 (perform a SG_DXFER_FROM_DEV from the /dev/sg read-write interface)
scsi/002 => sda1 (perform a SG_DXFER_FROM_DEV from the /dev/sg read-write interface) [failed]
    runtime    ...  0.014s
    --- tests/scsi/002.out	2026-03-20 06:55:12.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/sda1/scsi/002.out.bad	2026-03-20 09:39:22.869794284 +0000
    @@ -1,3 +1,4 @@
     Running scsi/002
    -PASS
    +write: Cannot allocate memory
    +FAIL
     Test complete



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260322/202603221746.420c4675-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

