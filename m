Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116D1F4C8E
	for <linux-block@vger.kernel.org>; Tue, 30 Dec 2025 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767074666; cv=fail; b=EE0cfWcPEl4bDJFFB9GAMQJYWNW+q9yqQXAx2VCcnrR9Kb8/bvqCJ5+ZeHZcQqO8ajGUAMM+txKoO9s2ctXj9yCgaz18mTXAEyvKBes7BNs7ReNgbTaZXHZDHp5d6Bx6z0N27aEfec97waO2f0nuQvck2ygGz7Y/c0Wzr3btxGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767074666; c=relaxed/simple;
	bh=/k7HdTrkAzCYm7d7r/T4H7RHr9mg+EuaWy+z5ELJzls=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RNY7B3XyolIkp8BRH/P4B/vC11q2r2QOYh45D989fNmP7GsgKpYl3FdozOKVA4AVRlkbM2v/6VxD6y0fqiOuLKoTdm5cG2cAnBbiLc2fmrLsSFf6An/JS7tIMqZ7kXbdZYpQw8Bo63U+a9s+K79RGLSNH12VZHD6MCcP8AthDpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f9qRbqTj; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f9qRbqTj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767074665; x=1798610665;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=/k7HdTrkAzCYm7d7r/T4H7RHr9mg+EuaWy+z5ELJzls=;
  b=f9qRbqTjwj62sDs0OMgkTBCIyRNFUwrMz4Qd3gQVmVhBVlurCNSnUOo7
   pJ93Iwe/m7e5AxOwydH/sfIyXSu/ANQl2ikW15RopEn/dtw4xInVGZxY1
   kwF2pXAWxHUqYO3DnUp+CfZlIditLMMBPWzM7qcsIxcRYJ+wLtniErYbU
   qSmXuXjD6ysDbzASATldCN3Ao5C0IpYJID5QVZVs2r3/vPk1j6qi6jYhT
   cihwwiP88bA0Ja11r4zm9Fp/UTcLAqQCwAaqRlZC52N32DtnS2Kc3YOo7
   xkaD5UX588QJroPocrAroI00HD7z6jziqMJ32DoYIOpkWcGLTBEJZAew4
   Q==;
X-CSE-ConnectionGUID: Rhrp9ktYTpiFVkOPym11wA==
X-CSE-MsgGUID: kCxnhJRUSbC+cEyt9iwKjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11656"; a="80119477"
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="80119477"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 22:04:24 -0800
X-CSE-ConnectionGUID: SgPwUD2eTh2cYgL7+Mq8UA==
X-CSE-MsgGUID: e9i+bpBOQD64xezUzTP/rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,188,1763452800"; 
   d="scan'208";a="201405683"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2025 22:04:24 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 22:04:23 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 29 Dec 2025 22:04:23 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 29 Dec 2025 22:04:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqiesHjMXUVec880VihG8io4pks5afRrirVF86M/iKoGabREMI7V8J4BuMEHnjuy4FEfGJg0bzKlrzvdJNoK6wUYf+y8JtWrLlIw+oy7jOHL0MWG/yau5Mo3Ppv6TW+UvmjKsPhi7DL6dlpyLt3WOFUwUOMziSSCD0xYqlHq5dPdr4t6ZY+4HzQlxJLi36gfydTAE1aN14ii03JE7/U3kG/Mak+Ha8zDXxb2yjJOccp7yEZRbaF50/Qj5kVuFwFYvExWOCJaVOdLp7sxaZ1rqxBi9pX8X5RwQiLXUY1t01dfaBp/1QnW04Gw2AUVLzfaHWJgPCQtgKd/g2EB60V3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0+Apy7TnfYW4ZeGtuBuvqZsA4sDfOSvbQIaM/Y4IXQ=;
 b=y2MrjhOxavHeTH8vmjS1iADfROV7Oz+x1kFUMXg7uHXiviR/sPN0n7e0Zdb0K2dtmmgUXYqE2MwYrqTDfKRcD3QdjlN74BDOsiZgYiUr6E+fBqUY9QNw1xy4UGr/8AghFoNk1fSdbDb4Fz9a4sRl3xI8muDce6ZOkWl8pc6TvGhBNJmqt2OLh9FHVdJWcl7zPonpqLIHlDJRFwIzJO/dfMMtq4cF9QYW2yVsrxvdYuTunujvD5Kg2tTw71UKlKvw/70DSBz84hLQxaiFGPmwr1s+H2tL2yIc1ycI66Xx+2wbdQjUBh7HLK2uu7casbrmXBYJ8ZVeHTg5HNSe9GLNMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by LV8PR11MB8584.namprd11.prod.outlook.com (2603:10b6:408:1f0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.13; Tue, 30 Dec
 2025 06:04:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 06:04:21 +0000
Date: Tue, 30 Dec 2025 14:04:10 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Kuai <yukuai@fnnas.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, <tj@kernel.org>, <nilay@linux.ibm.com>,
	<ming.lei@redhat.com>, <yukuai@fnnas.com>, <oliver.sang@intel.com>
Subject: Re: [PATCH v6 07/13] blk-mq-debugfs: warn about possible deadlock
Message-ID: <202512301342.35385eee-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20251225103248.1303397-8-yukuai@fnnas.com>
X-ClientProxiedBy: KUZPR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:d10:31::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|LV8PR11MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: d785fea0-b422-4f3f-d88e-08de476946b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ujkwD6al9sLJHsfbFspAHuIA84zgMCWuFa8y3pUpZGQO84mf4LF8jB6YPhBE?=
 =?us-ascii?Q?QcC8ll0hBfvyGiCnKaTSazRboTtvOJNPiPbhttEE2ooeESGI0wzjZH8F7fml?=
 =?us-ascii?Q?9bU8bSqdLnNBzzveoNbwLP4AefU/UacbLELkI2/50WwzC2hlHqm4qni8hnWn?=
 =?us-ascii?Q?A7vWqmD8q+vLn3TWiy/eJ4hd3CvfIO1L7+nDJ74PjAgSgvDgyTXFuM+mEbnM?=
 =?us-ascii?Q?gTmJV2ma1ygavo4lvkmFBJ1/lwsqot36mZjKRLbLXYC/YFAejjKEi/iaBLB+?=
 =?us-ascii?Q?jkQTVpEvakSZKXJojXsC6epjrk6wkQCgnx+ec6O+Tckg2ZgRZdcCFfno7fMx?=
 =?us-ascii?Q?9rVfLfQcTksxxIWAjkIP3cypqUyFJ/pHu2toakm4TiCSFJjdZjPGpzUCuDSD?=
 =?us-ascii?Q?Io6S87SKuvR+dHzYAMJZxxD7hzJdoqQ1OpPAKyuviqK2nh+Rot3sMsAx3Zfm?=
 =?us-ascii?Q?0DMygHN8G3zEJjxrxUyMhc3Kf7WMVrHqCQwnMRsO8Pmzq9mRGMqswwxwyGBb?=
 =?us-ascii?Q?V7XolMQZusjsy7v124qldHiPUvudXYlsMOpmDcTQzbI4hqUkabFhjz6ZLeKM?=
 =?us-ascii?Q?OUM10C5J36ab7/XOSfbcfIsBZEF6XLec9QctlTl3G8VFgvDKpDWffdQXg4nV?=
 =?us-ascii?Q?M1a4LmJBM7quxHNgZIwUJ+30zFFCa85taHFi2gK0IndI96K1ueuuUDBHvJJa?=
 =?us-ascii?Q?K6PazB3xSghvMD1zbUcXkgElyyhxn8wztVFErjRIGClrHMDftZR46R0HVv4s?=
 =?us-ascii?Q?BGQCImr1nIDYLyff2AKaEYpGPLywmrWhK/3avg+redSfm8mj8JqE5qQzh8QL?=
 =?us-ascii?Q?CD6toJ3Q3NT+7qPwVis1rl3nwJY1UkUSDqt5VNgW+/VqV8+ALfgItUoaSU0D?=
 =?us-ascii?Q?BqhU3+N63ipasUQVMvbkInUxRXWQWoJR5FdPOvxVzckBb6J5h2AI2M5lMShw?=
 =?us-ascii?Q?ESAHa5F9a4iqIYfHG3AbltmcbqoDBVZImlm0Ccc3Uzrw5Km7S/hN7LPTO4HX?=
 =?us-ascii?Q?W+YNvcpc7EM8UUArIN5BIWIOfZqTzG6jF89sScn8atGC63AQd3QbrxaDv+v4?=
 =?us-ascii?Q?2yK+hjE0ioYedxOkmXJTwtceEbpkUEUCnpNA4jbeDk92muKZWTw27zmK/l8e?=
 =?us-ascii?Q?9onaa0SiNkQeOMKtMQnvYwe3TflZSSPzwgcQSK62iGi1Db0WLL7YPiyY3V5f?=
 =?us-ascii?Q?jRg1nL523V9WRzCIS4g6kDd712Y72sw9ejqMTYS1yOX3yULY4Yl/hvrFFoNK?=
 =?us-ascii?Q?4sejrXRA4alk9wTg90JTbCLvV4Foa58gCeCX1JEfyr6Npyjp2kJCgAiLJNV3?=
 =?us-ascii?Q?R600cLMzK45jscxVzOGTBIrPf+CgdcumH4hMTH9OsdMwGXxqN9OmVHCeyZ0G?=
 =?us-ascii?Q?kh+ZYst7vU7u5wftF1elFaagMkMyNVFFTMigTO10Sp85lU6GoU6I1aX9+Flt?=
 =?us-ascii?Q?4ZlTIlLY4Ls/orl4wObq/CnylFPaRZ89m3bA6EaScKpHInQixhNk2A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/5SMUvHqh48o27fJtY06JXrgQmsDz0Evamn8M7oCHejV74ngMItIz4MgpZmh?=
 =?us-ascii?Q?SO+ibOsuI/iZBtOQfsgRsOcuUymddiu/nWv5bWncgMwwlbyGMAUX+hJqVq1A?=
 =?us-ascii?Q?u8M627FYnEO7wrJAni9dL04yQ5kvEVZK7WmeZ37hiq0Njt9Yn5VECWkxwgaZ?=
 =?us-ascii?Q?tpZDXBY/N7BoLvg6ZMiV7EuTh/t1QAP72nl7bgAnaoAh9XahjexrgN08m44Q?=
 =?us-ascii?Q?BJUozoYhQzR98BhCCKgllMJ6oSQuUIDJYgvuvz61hiDC6kvWuT4d4WDN6rp0?=
 =?us-ascii?Q?Ztb/O+X1LN10WjAIk9APsBoAveWdH9u1p4DHGtN1KmxY1eL1GEn4TSyRbPF/?=
 =?us-ascii?Q?bDlbMoqRYXRR01OcoHoTUzQqCuzN65ZMeB70WJps8YiJeP52weFGt52AaR2a?=
 =?us-ascii?Q?7nTZ4bQ5IGs+tR+OLSs3qN4Wt1eVaULjUYS+7iAxUMHpwgPIRgbesCc47A7q?=
 =?us-ascii?Q?/fa+pyHkXj39qeum25TdvWnkFPrJnRV74mPyfqT9v6gqSChZyke9Eu4ujEMY?=
 =?us-ascii?Q?CLDVJYTF6ePtmqYeFbKLMyilHR3VkBWElr/p1QhhSp9T+Ufl3IKyioX49akZ?=
 =?us-ascii?Q?p1zAKs+wLs3bqpENeQEhHlFX/OYWo8l8cO1FdV3b8NCaEzdSxJB52bWfR0+C?=
 =?us-ascii?Q?q+739uSx8YF3y8MCU0FD4XXrmSYS98O/O7sl7E31GdYjh72D0oJMlFqWKFmX?=
 =?us-ascii?Q?LVzvHFoy420Tye58Qn1Mlr6vj3+cpp2X8/mIhh9C+2cwJyyHILQ/KvX8BBlN?=
 =?us-ascii?Q?7SgW16WS3ca8plMDYjfm3o7K+QtefapAugn/0vCWEnn+267k43/QH91Rlng0?=
 =?us-ascii?Q?7Y/pgsVbe/ai2bNDxeawWB33jCU0HHF6kh8Dh+Nz+OdVwd7WUWjfFUbXpzgG?=
 =?us-ascii?Q?9wQu8tu9jLOI9Z+NUaWsOrqvh5/u11PEhdlC1z/ByJNdCrwRcL68+RkSH9Yl?=
 =?us-ascii?Q?2UcVq0GFiYCfKAKDpFWNP0k/nRHjND+bKCQGoXUWUuS2enbU6mm/zqWBG548?=
 =?us-ascii?Q?fQ3RfNBdx0P4BbKZqhkWXjirzGZ2uPzLIVJAV7TOdWVdiRPBIsKp5bcNVMqc?=
 =?us-ascii?Q?CHRj0S0XEXMfowwfCthhUkAjaLRWr9gHQmOLMrTvYuRUZflNrXxSwElRxDQk?=
 =?us-ascii?Q?quEy24kllTpv7dHvVtCbJ/SRE7DmPYhqxdy9LZhNPZeXyFszqk+x/6ILKGKk?=
 =?us-ascii?Q?UqFUwqNGJSx6cfeKeW+5gXmWOOzsaDN4IenhLPykFsbqalh/87kHZf5GZUxd?=
 =?us-ascii?Q?dEWoobVku9hkmi/r0CBDWvTy+BIQbvnHCLPo7GpoT5xK62jYs9uKoTekJdAR?=
 =?us-ascii?Q?J9CcGq4VBt/rTH/wYRdQ+gaaPWTIdORqSv3ujpWyNNdKjJJ/rpNa8mleRKY+?=
 =?us-ascii?Q?ullCcCCkFrQ0+a52bPmpCvFuO/dSEkBm2jErqKvGE7UVOJvOY81Yo3uGnyzV?=
 =?us-ascii?Q?CWBYhyT73DvbgzaxfQRJqpvqgZ9QrQPygaoJv8/4WUOxmWaHLD0sfbTXchU5?=
 =?us-ascii?Q?+9GDzTH4kGW3ITP5D9z2QporqPnj2Adz3kI04xGV37neiiHvkKVezS7OBG6a?=
 =?us-ascii?Q?WKGeIB8FzKC8/jPW2JFcPRtDRa2xWgOq1wesdU8teR51nnW+RonvGlg2xbOP?=
 =?us-ascii?Q?uHe6KMwYVawj5gQ3DQIi09glx9ngFn7YGNcNdCEfsEdhmV3qQoSKMnhQ2wgj?=
 =?us-ascii?Q?gMhdr6PfQauJAFTOq11DGNBvtfr96MW2CpCRdXqa1C2vWqvzVy6SFAEBtmVa?=
 =?us-ascii?Q?s5ihzS60YQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d785fea0-b422-4f3f-d88e-08de476946b1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 06:04:21.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gC8oPvXKO58U80cYD92oiMEVHIKpW3pneKRbwY/porQRRXaW0PPqKegE9NxKoL+G+vvchnqpz8ytTO2vgBqdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8584
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "RIP:debugfs_create_files" on:

commit: 492a1c791dd61f6b2abfc86a4a85acf5db1d0e32 ("[PATCH v6 07/13] blk-mq-=
debugfs: warn about possible deadlock")
url: https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/blk-wbt-factor-=
out-a-helper-wbt_set_lat/20251225-183443
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-next
patch link: https://lore.kernel.org/all/20251225103248.1303397-8-yukuai@fnn=
as.com/
patch subject: [PATCH v6 07/13] blk-mq-debugfs: warn about possible deadloc=
k

in testcase: blktests
version: blktests-x86_64-b1b99d1-1_20251223
with following parameters:

	disk: 1SSD
	test: nvme-005
	nvme_trtype: rdma



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphi=
re Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202512301342.35385eee-lkp@intel.co=
m


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251230/202512301342.35385eee-lkp@=
intel.com


[  162.300625][ T1400] nvme nvme2: creating 128 I/O queues.
[  162.876161][ T1400] nvme nvme2: mapped 128/0/0 default/read/poll queues.
[  162.901778][ T1400] ------------[ cut here ]------------
[  162.908519][ T1400] WARNING: block/blk-mq-debugfs.c:620 at debugfs_creat=
e_files+0xb8/0xe0, CPU#72: kworker/u898:10/1400
[  162.922316][ T1400] Modules linked in: siw ib_uverbs nvmet_rdma nvmet nv=
me_auth hkdf nvme_rdma nvme_fabrics rdma_cm iw_cm ib_cm ib_core loop f2fs b=
infmt_misc intel_rapl_msr intel_rapl_common intel_uncore_frequency intel_un=
core_frequency_common intel_ifs i10nm_edac skx_edac_common nfit libnvdimm x=
86_pkg_temp_thermal intel_powerclamp coretemp btrfs blake2b libblake2b xor =
zstd_compress kvm_intel raid6_pq kvm irqbypass dax_hmem ghash_clmulni_intel=
 ast rapl cxl_acpi snd_pcm pmt_telemetry drm_client_lib spi_nor nvme iaa_cr=
ypto qat_4xxx intel_cstate cxl_port mei_me snd_timer pmt_discovery drm_shme=
m_helper pmt_class intel_sdsi mtd snd intel_qat ipmi_ssif intel_th_gth isst=
_if_mmio isst_if_mbox_pci i40e cxl_core idxd soundcore intel_th_pci i2c_i80=
1 spi_intel_pci crc8 libie intel_uncore nvme_core einj intel_vsec cdc_ether=
 acpi_power_meter mei drm_kms_helper pcspkr i2c_ismt intel_th wmi spi_intel=
 isst_if_common libie_adminq i2c_smbus idxd_bus authenc ipmi_si acpi_ipmi i=
pmi_devintf ipmi_msghandler acpi_pad pinctrl_emmitsburg pfr_telemetry
[  162.922410][ T1400]  pfr_update drm fuse nfnetlink
[  163.034763][ T1400] CPU: 72 UID: 0 PID: 1400 Comm: kworker/u898:10 Taint=
ed: G S                  6.19.0-rc1-00238-g492a1c791dd6 #1 PREEMPT(voluntar=
y)=20
[  163.050931][ T1400] Tainted: [S]=3DCPU_OUT_OF_SPEC
[  163.056656][ T1400] Hardware name: Intel Corporation EAGLESTREAM/EAGLEST=
REAM, BIOS SE5C7411.86B.8118.D04.2206151341 06/15/2022
[  163.070319][ T1400] Workqueue: nvme-reset-wq nvme_rdma_reset_ctrl_work [=
nvme_rdma]
[  163.079319][ T1400] RIP: 0010:debugfs_create_files+0xb8/0xe0
[  163.086849][ T1400] Code: 89 ef e8 1b 1f d0 ff 48 89 d8 48 c1 e8 03 42 8=
0 3c 20 00 75 23 48 8b 2b 48 85 ed 75 b2 5b 5d 41 5c 41 5d 41 5e c3 cc cc c=
c cc <0f> 0b e9 5f ff ff ff e8 9c a6 66 ff eb af 48 89 df e8 d2 a6 66 ff
[  163.109632][ T1400] RSP: 0018:ffa00000136c78c0 EFLAGS: 00010202
[  163.116916][ T1400] RAX: 0000000000000007 RBX: ffffffff845523a0 RCX: fff=
fffff845523a0
[  163.126203][ T1400] RDX: ff110022742fcc00 RSI: ff110020dbcfa400 RDI: 000=
0000000000001
[  163.135503][ T1400] RBP: ffa00000136c7958 R08: 0000000000000001 R09: fff=
3fc00026d8f05
[  163.144962][ T1400] R10: ffa00000136c782f R11: 00000000ffffffff R12: ff1=
10022742fcc00
[  163.154244][ T1400] R13: ff110020dbcfa400 R14: ff110022742fcc00 R15: ff1=
10022742fccfe
[  163.163587][ T1400] FS:  0000000000000000(0000) GS:ff11003fd9cf5000(0000=
) knlGS:0000000000000000
[  163.173957][ T1400] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  163.181790][ T1400] CR2: 00005577f0a48e88 CR3: 000000405ca70004 CR4: 000=
0000000f73ef0
[  163.191083][ T1400] PKRU: 55555554
[  163.195396][ T1400] Call Trace:
[  163.199405][ T1400]  <TASK>
[  163.203027][ T1400]  blk_mq_debugfs_register_hctx+0x17a/0x440
[  163.210760][ T1400]  ? kobject_add+0x116/0x180
[  163.216245][ T1400]  ? __pfx_blk_mq_debugfs_register_hctx+0x10/0x10
[  163.224443][ T1400]  ? __pfx_mutex_unlock+0x10/0x10
[  163.230393][ T1400]  ? blk_mq_register_hctx+0x1ea/0x420
[  163.236887][ T1400]  blk_mq_debugfs_register_hctxs+0xe6/0x160
[  163.243816][ T1400]  __blk_mq_update_nr_hw_queues+0x544/0xab0
[  163.250866][ T1400]  ? __pfx___blk_mq_update_nr_hw_queues+0x10/0x10
[  163.258381][ T1400]  ? mutex_lock+0x91/0xf0
[  163.263590][ T1400]  ? __pfx_mutex_lock+0x10/0x10
[  163.269330][ T1400]  ? blk_mq_run_hw_queues+0xe1/0x400
[  163.275597][ T1400]  blk_mq_update_nr_hw_queues+0x35/0x50
[  163.282091][ T1400]  nvme_rdma_configure_io_queues.cold+0x3ff/0x72f [nvm=
e_rdma]
[  163.290878][ T1400]  ? __pfx_nvme_rdma_configure_io_queues+0x10/0x10 [nv=
me_rdma]
[  163.299714][ T1400]  ? nvme_rdma_configure_admin_queue+0x3d4/0x750 [nvme=
_rdma]
[  163.308274][ T1400]  nvme_rdma_setup_ctrl+0x252/0x4e0 [nvme_rdma]
[  163.315608][ T1400]  ? nvme_change_ctrl_state+0x1a1/0x2e0 [nvme_core]
[  163.323275][ T1400]  nvme_rdma_reset_ctrl_work+0xa7/0x170 [nvme_rdma]
[  163.330935][ T1400]  process_one_work+0x668/0xec0
[  163.336719][ T1400]  worker_thread+0x629/0x10a0
[  163.342203][ T1400]  ? __pfx_worker_thread+0x10/0x10
[  163.348169][ T1400]  kthread+0x39b/0x750
[  163.352977][ T1400]  ? __pfx_kthread+0x10/0x10
[  163.358344][ T1400]  ? __pfx__raw_spin_lock_irq+0x10/0x10
[  163.364774][ T1400]  ? __pfx_kthread+0x10/0x10
[  163.370133][ T1400]  ? __pfx_kthread+0x10/0x10
[  163.375530][ T1400]  ret_from_fork+0x2aa/0x490
[  163.380889][ T1400]  ? __pfx_ret_from_fork+0x10/0x10
[  163.386821][ T1400]  ? switch_fpu+0x13/0x1a0
[  163.391971][ T1400]  ? __switch_to+0x4cd/0xe70
[  163.397293][ T1400]  ? __pfx_kthread+0x10/0x10
[  163.402712][ T1400]  ret_from_fork_asm+0x1a/0x30
[  163.408231][ T1400]  </TASK>
[  163.411794][ T1400] ---[ end trace 0000000000000000 ]---
[  163.447563][ T3933] nvme nvme2: Removing ctrl: NQN "blktests-subsystem-1=
"
[  163.471043][ T3458] block nvme2n1: no available path - failing I/O
[  163.479008][ T3458] block nvme2n1: no available path - failing I/O
[  163.487171][ T3458] Buffer I/O error on dev nvme2n1, logical block 26214=
2, async page read
[  164.210460][ T3990] SoftiWARP detached

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

