Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCF6F2F8;
	Mon, 29 Jul 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238162; cv=fail; b=pySRvN6fHwHaC6RQWQ/FzkomwSMfTTCUBVMDHktPMNDj5f9nGYxM8Nus5Fh4xFoei3Ib7OJTFW8tYI0Ch0dxFiyGdhcuaZ8c8MylJhxUW36BKvdMu+9thtJetskastTGcB/oAAu4Uu+a57Po6Ey/9vW3svMalKxCu3IVLyNlJ24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238162; c=relaxed/simple;
	bh=6eDlUcpJOdjHuA9J4prt12HfOBF8yIrfuyK63yAi1D8=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=pro/uaSTqWPuE9haKobkXuFn5QaD3/PbkW+DVVUDJySBhg6h4x3BSNV5vmgxmVJpd8LAaxPxgUMowCETTT+jUi9v0Wp9b8JvSGBZjrDY3oaUwmEg/psg49i4mVPFNRIjpecPJY2uZ7tSvkXkMqo91RnjzqtGbW6Ldm2S4tqqc6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F9oQler4; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F9oQler4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722238159; x=1753774159;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=6eDlUcpJOdjHuA9J4prt12HfOBF8yIrfuyK63yAi1D8=;
  b=F9oQler4AK4NDb5nyonChUrOq3cFwA6l0Zy6tqOnddnMwP8HWKZoJRVW
   zFFT5GAptjZaK0p3EQOqD9UiUAOioGOqhEGvZrHqBeRzFMYmtd1NXbpB7
   85DanBTBXZwaUw/4anZA+v2+m/tE24oXCVQ/0PLzs5mNDEcKUDSv3G4P3
   aHkAY31nwrQrCP6GJfNyCmEIb9mLe/lKHfbSArqy0BTow1DMaXqmRWgEv
   NpZatSk1xd5tIGMDQRb8/Cflc+NFiInok+F3K3KG8kyYKFAMi9KusCDhc
   4Uy42HY3vnWDX4Hy1rpq9+Lkekw8BqMYdJcJe5fiFPpN2P2Uy3AGQ+ROq
   A==;
X-CSE-ConnectionGUID: 8kwuxb7oTvm1aqYzRoukxQ==
X-CSE-MsgGUID: +K3aeQ8iSASaE8fGNYUUuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11147"; a="20102938"
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="20102938"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 00:29:19 -0700
X-CSE-ConnectionGUID: HsHhkXF3QiKAb843vk2WNQ==
X-CSE-MsgGUID: v+4eJbVdTGmxroue9vPaQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,245,1716274800"; 
   d="scan'208";a="91353518"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 00:29:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 00:29:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 00:29:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 00:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4zDEve3Lq1W1cENVT0xXh82grbDUJZAV26Bzh6wGldjsI+IMxQeAfK6rNrwowMhk/saB5zHew4JSJ8wTxdZEK4M8CcHrB/ZHYO9srL2cfQsLJ0z9srG8tv2yOoQfIPEjUM3K3ffC7ftY2u2JYsepOEH5utLXyeZyLxn5zZIhgoULt0IIS2d0muJClqlOVtFoCOpOj/L4KWrM1NsOScrEGbIgvZny8AsmRoDcfM/YyanFqHw1tICuV68WKpEissvc+XpBeiqOwbu3aQLpFUKYDelxdypJ7fizIdIqkQ0/7r4opT6jfS9kzaTrtfRx35/DD9gSfRTX3P5h6lWrVugcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uooW/7xYKAvazcQ5FJ3d+swYFKT10oiJMhdp0zaYqtc=;
 b=avnyAac6rb+jh0nUgdUo7J/EMgncLGQhVHYYGxgM4i65mAKHnTpmSWO3kI3fhJdkBbDOGlKvB3MIiRi9MigRujZdwZZBMxuNUiIuzNaGAGZ3Jr3QsP+1VfFLxZKxa16KX1Qg6JCVslJDI/CRN4HdLENv+X1lJBAwWjhk6bW3BeeEHcJ55payWzRPPYzunumUx/JRizBd105SR9CdI/kCRY4Padlo8KcOETuM5C3hydjaJeY+b6UdK5kh3HxwUqbFITa3km6iwmRbnQqcV/OzPPv8k0QHTc9C2/tbZKjKlhc3cShMmZhiPO1Ucg1eMoaSLrMNPg1EzTPh9HIPAfxMhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA0PR11MB4589.namprd11.prod.outlook.com (2603:10b6:806:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 07:29:16 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 07:29:16 +0000
Date: Mon, 29 Jul 2024 15:29:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Gulam Mohamed <gulam.mohamed@oracle.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	<linux-block@vger.kernel.org>, <ltp@lists.linux.it>, <oliver.sang@intel.com>
Subject: [linus:master] [loop]  18048c1af7: ltp.ioctl_loop06.fail
Message-ID: <202407291554.5c76ba13-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA0PR11MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8d7e29-8d70-4c12-4151-08dcafa026ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/DOVh4ZrOFJgwvysKTtB75wYRqHjk0KiZD2qL3w5s/gQDkM5xrPkTrBwB4iV?=
 =?us-ascii?Q?G1a6P/U0gWSG7Ldk/4TmeYSst/jnKGMu1s2c+uudPSJy68+uFE4q2nfRBTwy?=
 =?us-ascii?Q?0X+OpGaC7/EtdySK05sPxNcxZuolAU0P4t3kLITU7zYAx7UrrPFNvquphUhT?=
 =?us-ascii?Q?JOr6mNkSdE0NaZP4Gd/ujLVokShr4FqPaN1bYZmdUfJPkjy9MPIM+kTidUC3?=
 =?us-ascii?Q?njj+9HePvd0kZS5AyieSnzueCrxM7j0bfHwOeT0gTDVSrCYANVS+rUDVBb4e?=
 =?us-ascii?Q?5ZstrX9DZbDljkyLguneExvbC1/+VPb4ZvkY9MqSd9JkTjb9GLMn7LCHqUCl?=
 =?us-ascii?Q?VkRAPBtOzJuFrzVDdbulHG7qOVH2KTa9NLQsK22j3Rejvq266ky4FhrWKggM?=
 =?us-ascii?Q?KvzdpX4J4WyTjCN8dzY6DPfvaOCNDGibJdP3hQQ3x9N/3S9J539JqfcHzuUQ?=
 =?us-ascii?Q?zpeL7m/w9xN0v83Yf4c/IoWJKUEuVbHi61PFjHe01mTI/OWeYM5e6GcLpXnS?=
 =?us-ascii?Q?Z2LvrtYWi3diBXEHuAj/M+tWemBGzUsFYRzGYS1SSIX9M9LBSy/pYkNYSZdp?=
 =?us-ascii?Q?DFmWovuwv7i9IhBUGr5mw6Huzr9+kdVGUFvUEVYbrL8PwjGy0LJ/Ts9r/Ran?=
 =?us-ascii?Q?cT2F/fvbdivKJRR/hykTnA6b2A1pxjYpd3tfWGCFCkeEICG8xfIgU+tn3x7t?=
 =?us-ascii?Q?+EKts66vB1iRHzUTN4L5qZgebhUHB0MN4oErQ6xYrrDr0dj9k63fwyZiTgkm?=
 =?us-ascii?Q?AOWUoItEP2JI5ZIFN5MoB5wNVPpoSwEWv1FDZxNEBiqN3T5i6EmrSLUfA66B?=
 =?us-ascii?Q?uLM0QO8Lwt7wQ0PpULIo10HG0bcftuGXH7vGF6fKgCD7onRZuFTBgaXaz1yI?=
 =?us-ascii?Q?pzd+gGBdXVt+dlgWbHkuvIQ8QTz2xuXhD2TV9OlWg3RWxCP2EaqVPWN8E0eJ?=
 =?us-ascii?Q?OE4ZJQv9F9JRUUw4FTdnD2EZGirPCag1f7z6HfyGDKeIw3CZuS3Sd1X2F1cM?=
 =?us-ascii?Q?BRXN5m5SI1/LZ+lWmIS/vLvRlcYI/OSWc5oaOe6Bp4f9SB8tLCjruOedzwoo?=
 =?us-ascii?Q?ePCg97XuYbKrR/8jdUuw+vAGqffzx3oTcWbokyz/lQUZm1sLVoDycfgcogmj?=
 =?us-ascii?Q?gdCoiGvMD10ammun9ykTfKQsSMa/nZWalD8WsTx9bsNSDJ15831NY3i23ZWb?=
 =?us-ascii?Q?4/Jn64A13ANlh3GDNdhPgUS77UPnAQbmF3PuoPbHH3ifN0JICAbeQMwvPUMz?=
 =?us-ascii?Q?4MGKyrc1Qd9NkSnuUtEzPnNgg0lUeWjDQKkbX2fNYzZjb655w0n2I/q8a/Ji?=
 =?us-ascii?Q?40GZJZSx5S3rIUEN52XlZlxf?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/DsNanaUjhgZP7GE7x6A+Ml3lTLuBrgY96iwr9o4HRGZa3sJDAWwqaagXQjX?=
 =?us-ascii?Q?b5FpRCf/Y5mQmReW+BXg351KL5kq72F/jaUJNj0MRq1poqBcJyQF+yq/uds5?=
 =?us-ascii?Q?shZ2kenHT2fWFwpyO09HDMtggjTN2KXnjKl6cBqzJmWMlbIJdCpsjTwsF9Al?=
 =?us-ascii?Q?wqYMqPtaqdSvpjHi4CpR7p7Q1ji1fDRj73TYkceIndzSfi7qi9EOuZ281MBw?=
 =?us-ascii?Q?H3R0zaQGsq+aABVzFLz6eZQDaPAscFZplOiaHX3ilaVOL4nZqVNzsIcfb+BO?=
 =?us-ascii?Q?4fB/RC/HukfTqk+KvLVm3VIbSl9bfHMkedrAo+AAEngLSSAcv6flfZOjO3BG?=
 =?us-ascii?Q?TQdN2/WQJDyidUrcp+gVL3na1rzgWdxRwVPVLPGpeEuQPS2uNBOFY35FJDpf?=
 =?us-ascii?Q?qeZxBooKJdZ2+Pafnz1KL/EgHkLZWL7CSC9eDAwKkYMo3B4ECChZxlb2DmUU?=
 =?us-ascii?Q?ydr8hq/sY3hKXobuJb+rSMtshg7WfZDQ50k/8FHPjfl9PPFinv0MDcyMnFJK?=
 =?us-ascii?Q?HD9dNzWULUpFdPI56YK1rB3rA/Eie9h39V7vTscldks5UgvG2gj7Vn1HkKGj?=
 =?us-ascii?Q?9InMCQ6/JTd8ZgL7NMZhu0FIVc9N4zYCnnmo3zPBPx204PdF26PTEh5o57sR?=
 =?us-ascii?Q?KF9pFmVYgHtGM4dVfHlMfxlYh3hilTIofB+GjtGRL8ZPOI/+3Mfi4uhRE+IZ?=
 =?us-ascii?Q?XTLopobeMwSwZk3or5jWAttqAe8O6raS6jee0Z+AQ0pHx45+oGYJUSoN1YmX?=
 =?us-ascii?Q?8Tcw7aUxasZ0TnU35JTwAj19eGxQozyx3F5BNdFUYJXXCApkYjR9CpWjm0Q3?=
 =?us-ascii?Q?3XDQL3qtwjTIpUJYR1Xv9KtdMXq5JgHqlGb0pMqWPvLmLVNcFU0/fl3nj4Z/?=
 =?us-ascii?Q?PHPeqX4xuZz5mktDCN3gU3ytnVgU8YlkjZ978dSCJYdikt5Xj64h5OXCNrGs?=
 =?us-ascii?Q?7Qbs/TxTQXqVC0p8K7R+Z5en5tdLhmssEfREI3mWVL/h8LJh70uwsG0ADD5e?=
 =?us-ascii?Q?s6t/SO/1P1r+0ltyfSfc0z+sBrWvxy6yXPDL03Pu6IRVwy5H4XpXXYGJ6XKB?=
 =?us-ascii?Q?2QdDAogTv4xponS1z2/qnsTKEukzjB6vGtYNxV6Hij2oPusgkxGF362K5fN/?=
 =?us-ascii?Q?nXyPrnZ9o60/sP2jnzabITJOOFb+/260QhBIifDtKoKpjZ8x0M3IPvc+J91K?=
 =?us-ascii?Q?H2gQXpe1H8IMY4dTWMbHjIwPaJ2xDjZStSn3zPNnSJU2dKjRYBsst8Pzv85f?=
 =?us-ascii?Q?4A5yIpFaWAvaoNZjGit2qU7jQf3FJtHbGfKkQPGYJRaPxv//ylgnE/P1Vx+K?=
 =?us-ascii?Q?hkFrvpHQusBiLX1de+nirmyqZ6xaiAyzE8rj6HVS4DZXV9+LzGWGzBo3fZcq?=
 =?us-ascii?Q?bU9iRKJeWd6UUU7n5Weo2mf3kmvnGa3yNg5ZffXO8+VgzrUJ3Vh0IwRWbH6W?=
 =?us-ascii?Q?8gW+2tiWa+x4nK5VYafwylsrUcJyvyLwIwKPmzeFeW2xkLkqVbYcwZlzo1Pb?=
 =?us-ascii?Q?cUVotj5ijNRGwCMbVpZb0v3PgSlV3xqL5RT95IqZL+IJvD81Kce4Y8E1o3yH?=
 =?us-ascii?Q?bYCnBhxY6FsXJxqfet7Ihi+RTDUDuJ16EGu/lumgWKivHuzvpyu7gqyt6AV1?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8d7e29-8d70-4c12-4151-08dcafa026ef
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 07:29:16.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XTIbkMJkPzHQB8DmzQZCdcLTVcKVbm4Pm16+sd3MmSOq7CPbfcnAPSEit/dE5hM6oMr8sNzV2Q85EJKzIMBfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4589
X-OriginatorOrg: intel.com



Hello,

we've reported this issue in
https://lore.kernel.org/all/202407022125.e7ba93db-oliver.sang@intel.com/

now we noticed it's merged into mainline. but the issue still exists in our
tests.

below details FYI.



kernel test robot noticed "ltp.ioctl_loop06.fail" on:

commit: 18048c1af7836b8e31739d9eaefebc2bf76261f7 ("loop: Fix a race between loop detach and loop open")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      3a7e02c040b130b5545e4b115aada7bacd80a2b6]
[test failed on linux-next/master 668d33c9ff922c4590c58754ab064aaf53c387dd]

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
| Closes: https://lore.kernel.org/oe-lkp/202407291554.5c76ba13-oliver.sang@intel.com



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
https://download.01.org/0day-ci/archive/20240729/202407291554.5c76ba13-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

