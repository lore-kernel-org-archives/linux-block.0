Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364A037B003;
	Wed, 15 Jul 2026 06:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095379; cv=fail; b=SDM+R/RVD6lxcnZrGFM0MgBvYLdzp6cCsSGoHt4zoW1Z/DBUiscuXZTxPsySAOSotPv9+fRxBH33gJM40CA7KW6GeKQGApMZX5WAYl6awEvJiepveJ7ziO3BgRHt8COZIhI4m2slQy9OyfiMOJB0StpPjdEOvTHeRkVk91Iuglo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095379; c=relaxed/simple;
	bh=mXyoBSUr1/qBCFqOIUmD6zGK7yLTNTzBvN5us2Stoqg=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Yq24f/ShskF4KzRfhRQQ/cIeytRE/De8dlVNI7Lqx0QLZ1D7E/4SI9cg4hoDEVS6AKHLh6plSX+roccW3ak0PzxFyztDBo/9YG6FclgUV5GqAXJmYbcXPJcQMGTcVtnGhFLOjyuM6/MaD0zHGUi9FbI8AqOCggxQ0oXiKuwaXec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jbVPf1I/; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jbVPf1I/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784095376; x=1815631376;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mXyoBSUr1/qBCFqOIUmD6zGK7yLTNTzBvN5us2Stoqg=;
  b=jbVPf1I/Q2f2W61ydLWFPoy+SHqxGoOJYdcw56uHqsrtuWQ6Dkg/Iq5k
   2qcGpS7kL/n3qJge6AHQiT1rVOAnMfP05ZBoR2UYXaJk4MtisjDdOmfCW
   JnPFferF/zUKICYdPrePpyoVUpyeYCd7HvntpTMToaWWEEQTCKxjmdWTa
   nU/NjvyDsXT50PiLnK8u0f2lSd8KOzGXDdT3w0jaxNx/TSglSv0rXnbu8
   MxhES+Dmp7XOi0gETM0PsP3WkMr/SW/v6VduPunbbKlwwmSQINEiwEKjA
   3f6eiq6gtekbK7J3xq3XdWyOToT6xVp00kjkwL06P2YU7d/LTSopcAp/C
   w==;
X-CSE-ConnectionGUID: AtTaMPCCSTKdU2lWVSJ7SQ==
X-CSE-MsgGUID: MuMm+8l3RG+xGtd+7DjOrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84684927"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84684927"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:02:55 -0700
X-CSE-ConnectionGUID: 0sU/eTuTS2qFM8I/9vm5IQ==
X-CSE-MsgGUID: R6Q9Nz0ITLin1G9v6XT/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="294285464"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:02:54 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 23:02:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 23:02:54 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 23:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgjhIQ9Rs6XnIdjZqhetkvmovQCmu5g5d7hVB+43eCftnC2xlH2dnjMhL9tj0jtJDNpcyuDv5lH5bWFALvxj3ecua69NHTZAsBTl13TajQ7WH+f+ZPWL0tRPYLlGJk/MszOjuQ9Ub5+qOMySlXdgizFq5z7dnwbUBlkufXdVT25BNubuhfnTYysMEjgi2MP5izHQmWfwBid/LnbgK43qmBcRLbY1qJHMLB0msraHYENhEzfTLKP6TwwrJafr4CVhcz75brJJRZo2objgZ1qmZhKUH8Kge1JaO4dHbRnssYp7Mxq8aHJYcEaZr1eWCQzi9ij4VY4viix8CqmmZtLsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Eyql7sEvzrC72RbZu5ALVU8SIu+NzfYpf+5xYoAKkc=;
 b=eMkC4zuXtG3yniLaclXMH17bRY87vWby7hBVU4fdxnaU+X778DCvSNuKKGtMOUdJFF4vM6jhA7IaV4jpOFpt2u3593s4MAtVHJG9vC34CAEFzJFPVjLoZ0ZDX0qH3VZjKPWjJmHqH9M5XQ0swKBXvntNt4IdllqOntMIx/isTw1jF3/zthcjTn6GlPEmnZxbgpK0NmEeI3ZFyuRaBxfo0OZXalwI06P9/k0XIHSr42TKBh0V+sxm7Ot2JraR4I6qKuH3z2JipquNj2Q7ZH/GeODB5OA58G7cAEFR7at66BfePM1iDobACp7+8ABYW8A1yw0hhDQ9fbx1vID+IvRPrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by CY8PR11MB6985.namprd11.prod.outlook.com (2603:10b6:930:57::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 06:02:48 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 06:02:48 +0000
Date: Wed, 15 Jul 2026 14:02:40 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Daan De Meyer <daan@amutable.com>, "Christian
 Brauner" <brauner@kernel.org>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [loop]  267ec4d722: blktests.loop/009.fail
Message-ID: <202607150754.b660f5b9-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|CY8PR11MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: d219c5d0-ffbf-4259-9574-08dee236b223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|11063799006|3023799007|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: W40Ya6NLY8u0aQ8gn1tqseX0zWuhw2BL8v62sxc8Hw0SK2js2z0PSg+6NioZjxU4tVPZ3FB4s5ErKE8965sfh6d0VmTk9CISgZ2SJg1XDiBxPLOHRwnMPOdwQj/WRwLmKeiAphv1MfbdK6hwBvr0Ax8Feu0byBwiQnfXrHi81kqKdGOuzgX88z4ULbHwZLORbDeASeVi+M2CCLg0CzfM+d48+5fk9HZf7hrpcQvBXr+ANzBsr6BLIjUgliakhVruEXqQkXrhSp/7PNsJH2yI1DVuDQYSIAWTJphR8XC3xTtKrwjGu6y5gbNRWcsOZW/nPVw+yT4TQ35DXfXyoZGLYMTWNxQ69mPZQgf8H/EKZSGR/z1MDFw4d0MubAU6meWhn4j0ER0X4xI4qGYH4+b0+6udVAbFXQ8tow3uPe56g58fukyyKc+1AAsbZnma6EPlRa6QFSO35Z7TEds2cN1qpJG0PbA9lzje3b9Ky3R/YrgNK8TtmbgCZ5f/Gy+r5zTPH2lnFfES/8YKYJIjJrEwG1xDJpvjJDmngfJxxvJl1lpxCrAtb9gAxR9ga8pcwMKLLKWykmFiiRBedj9AvVUMEg3yQQwLnHgs48XX7Akohnjy93HJcVPCR4r0MMX+Fk4p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(11063799006)(3023799007)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YFw7B8vBRzzqRsUrDjXZAuMIAHZYc2qmpgAIEQ66FzE9clTZ8rQQpVA1ncJh?=
 =?us-ascii?Q?V8tjeOSswUlacYrSsU9i00KEX8qr35+P3fitAdxZJfxRyZXg2MiJ5eODmAhM?=
 =?us-ascii?Q?pWjkFZaTBjrrc7ROy9RjOpnZ8DcBJ0grAqABctCPBB9/pOP2GAW2sChasWlB?=
 =?us-ascii?Q?y1fQYdZH1oX+Ztqy4yW34eGbpsGSQwKy+cPcoyy8mVTHG469xlFWR1jTHWpQ?=
 =?us-ascii?Q?4FsVZcN1JCuGhWvkg665a76X2J94YetGFjGGTwS37eBaBbppUMeTLlSqajkK?=
 =?us-ascii?Q?YSziSb3wrprMGGUPOv7vRJrJ1OZ+QAqhpHY9P7VuzAu2qNtF2SI8/v1DLGcA?=
 =?us-ascii?Q?ex1pjEZ+qk52Qw/QAhgsIB8dFXLcUF+22ShFJY1kNOrOHsrwcgrUDMw40Maw?=
 =?us-ascii?Q?RMqQT1dk5zU1X7jhAMbYGG/wOeHOGUXNQnx2f19LsGq+YR2Hq/Hw61t3kJ1L?=
 =?us-ascii?Q?iMDu/rFZt/kece4rKjkz6o4Zb2wb4xtf1PQB4YjMh+XlpMrHMgRLiyrjoINZ?=
 =?us-ascii?Q?ZsFPY8GQcRRpBnXPrca2ityhqqki3tlPQhfqjZ0TMzur9YfgLjk4/TnKbt8O?=
 =?us-ascii?Q?r14OD6z4krXY3b2pSf2JKfMyDs4q/QJ4XbyNqZlYQkxV7IkXKOMI7/sGzfgj?=
 =?us-ascii?Q?tQ2A9OW7QZScYz6wa8jGUvTzJKBPxB9PSjeUU0o1SKqlegnwZKGe44VrQe4r?=
 =?us-ascii?Q?DLXLP6Tk8a0tphOiHBvTU4VnyCtoF24SIL/bHoTA7mr3DvYsWSN0ejxpcJWr?=
 =?us-ascii?Q?DswnsJ0RfKpuaKvb0cR2CR1vFzTZRq6UZIVVZYUin2WLX2e3c9naucFDShro?=
 =?us-ascii?Q?1aHA7E83KZbRT71oCf0xGBt4r7UXooQe2K/EWdpeY/BRxwaMKFgYkIClRK78?=
 =?us-ascii?Q?e185ipeOoy5Rwk2clpm3G/A6676WluZJavNDtsbx0zbMBc5F+bMRreN7hmgU?=
 =?us-ascii?Q?oCoN0Yl/BKM2+zyUmARJ8hAO1JgJoPT1xdBrs59vuQOxfUsMKzRZbuAUDyap?=
 =?us-ascii?Q?enjPFq+z+zDvpd/QePSd6unQd4FBnVVac5Fs0AJpBHAhIzAnGJirpdRJ913a?=
 =?us-ascii?Q?SlrvPpK/nZYtmRhCfGRWLkllUM0B9yO4783JGC70f9cG/85EWagSCaHJVaJh?=
 =?us-ascii?Q?vSOnO/Jm+pyTDBLGT5HHPsIGvpRj4/dhPonxOsSBDYTQNZQ37B+zJhiP5lgz?=
 =?us-ascii?Q?hl91pA7PR5+ezl6JZKBzjiCe7IwM0yCo4wkHk/wA84I0UZD3pJdXA9SRzaRW?=
 =?us-ascii?Q?06eyGwJe1Rk/1nIW9fkXHKlfR9yYlI/a9dyBA8MSko+42ajA6iWu9E8DcVk4?=
 =?us-ascii?Q?6hbLkYpZfVahCE1d4NcSb54x0MKpI/X8wyiLRvhvdFeG6vpIeQFA54e/elUd?=
 =?us-ascii?Q?paiIQgobmN/GUvqOmc+t4WSy01mdjK7snPYtayArWTDIBQSqwwqU18SmNwM2?=
 =?us-ascii?Q?9HOb2nhJu7OetUjqLWCQjPBxeJKxk/WbJnXLOebqvhzuUMhlI3bT19tIfwDP?=
 =?us-ascii?Q?xH5HA8fQkH1HL8KUKM3ZxLefRcVvv9Absz7V1FfiE9CvqJr1AWdNkiB9xzzV?=
 =?us-ascii?Q?Tm5sgGSEzCgjUrD7ScOStOGZ1VspQ7BHsoisdAMbTt0QhCUBDkCFCvtbB7xq?=
 =?us-ascii?Q?22GTny8BJe9gGC968HIJaD+QPfekRWc1iTsTe1D/NNxOA2ZCTqDUPzW9JKVz?=
 =?us-ascii?Q?IhqaWbg2AlEX0rWUjGyBimwPmtCTGd/+xNd+ANUwErXjFF3pytW66foIqEo3?=
 =?us-ascii?Q?HgDwqoGOsg=3D=3D?=
X-Exchange-RoutingPolicyChecked: hW8O2AMAaewl3W1922R3q6cOy1X7Jrvv9GA5i9vkSYCoyqlh7v4WRpdYpbCZueviG2ixFcsegnKp4ZLKxFHWTnb1B5PgbLVFdj4r6Kj0brq+9ZV806IIKRFTdgLW7OL+lRGudDz/0T0AbH4zvB4oYtEFZ4Q6bCb/WnV/JZaKSfqpTMgZSOeAyYea0d8TE0JWQyX0c2Y+fzYIAmwObrTxpkIZcW9XfmoeQl+4Qr8+Rvfh8DV9+sBjUH3/AHaNlW+ETC/Gg71bbgBXQdS54bRrELAELD8XWGRW7+mAfiTMS3DfTnRYjhGWU9/S1YJS0GxGZ9jjL2Z0XeD2N9nc7fbTLA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d219c5d0-ffbf-4259-9574-08dee236b223
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 06:02:48.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DFX0JdEONmMhNfQQ04pyQF9RA83uBXCcvdavmVSJC9AaV942OpgpA+wmcQl5Fbnp/PIVnUXAYwGD8kkJZxcyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6985
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.loop/009.fail" on:

commit: 267ec4d7223a783f029a980f41b93c39b17996da ("loop: fix partition scan race between udev and loop_reread_partitions()")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      4a50a141f05a8d1737661b19ee22ff8455b94409]
[test failed on linux-next/master 4f441960e691d37c880d2cc004de06bb5b6bd5e4]

in testcase: blktests
version: blktests-x86_64-5a62429-1_20260623
with following parameters:

	test: loop-group-00


config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202607150754.b660f5b9-lkp@intel.com


2026-07-09 09:47:14 cd /lkp/benchmarks/blktests
2026-07-09 09:47:14 sed "s:^:loop/:" /lkp/benchmarks/blktests/tests/loop-group-00
2026-07-09 09:47:14 ./check loop/001 loop/002 loop/003 loop/004 loop/005 loop/006 loop/007 loop/008 loop/009 loop/010 loop/011 loop/012

...

loop/009 (check that LOOP_CONFIGURE sends uevents for partitions)
loop/009 (check that LOOP_CONFIGURE sends uevents for partitions) [failed]
    runtime    ...  5.282s
    --- tests/loop/009.out	2026-06-23 22:48:31.000000000 +0000
    +++ /lkp/benchmarks/blktests/results/nodev/loop/009.out.bad	2026-07-09 09:47:52.182882083 +0000
    @@ -1,3 +1,2 @@
     Running loop/009
    -KERNEL add      /devices/virtual/block/loop_/loop_p1 (block)
     Test complete

...


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260715/202607150754.b660f5b9-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

