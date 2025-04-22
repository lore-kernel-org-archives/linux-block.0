Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF839256C6C;
	Tue, 22 Apr 2025 08:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311731; cv=fail; b=TMKwLaL3SEKsrC+mZzwAmIU9vT+b+Jg4xkoRTs/wszZcqdMDOaBWxcGVOHpNE1lJTDsCQW9RqOrourIV3bfTbt04PJLQk+e+3zCPf7fvsJQzsDo7eXDeTuSCdoTB9tymJev33wmlSbWUxbaNgJ1HAm5XrLUeDDf9sv1ppuSeVms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311731; c=relaxed/simple;
	bh=knOYJtBBPdKFkoRY1ccFnRrr9LmrM4fYj04ZbQZ/j68=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eHpz48XZfCXhj+DNBJiFU7Oi4HTp6L8dHj5RBP0Zzxe5X02cga9NekwmORUwKbWD026oPLZMBLK1jpcNG/MnAH4xvXdNdsG+XkNqhbyPyDsh4ySkln70OjA8eCRGPpugsYoOTw70cyiXkVyb2aprelaN3QgtSTBkiDQViN//wpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fI5GXk3R; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fI5GXk3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745311730; x=1776847730;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=knOYJtBBPdKFkoRY1ccFnRrr9LmrM4fYj04ZbQZ/j68=;
  b=fI5GXk3RKEQWLdywn0ut/eDRJPHVZmK+gUKzXOsILuaw6Q66NtOvnnwS
   I2NdGJhg9RIpSae1vBhse9gH+gzZhsZmY0xNZ1GFJOMSXrFimIDlyvru1
   dR3HmVvPG3cZwckJ6D1ZS1jkPWJuXdMGrsV6ByP1sItpiC7H9vzxESpUb
   H/Efaxsz3mhNtx1mvKA+W0TPtAj1IiJZHITKLMXs8hPJEOnQiopC50UeF
   Dl8kzPC2Qo/JRwmL9m11hUM9gknlDYuV6j5JIXTx0b2vQXwaHlauJv6SS
   fTNs1P90S9aMieIL2N+4gpwS46t+vAa+HXDtI9Gzk3nbrR0Hw43YUU7kW
   A==;
X-CSE-ConnectionGUID: 1tqUJsHwRgK9D0g4tX6zQg==
X-CSE-MsgGUID: BK/LNJMET+abyaJ2PMoe9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46977946"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46977946"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 01:48:49 -0700
X-CSE-ConnectionGUID: fZUjDOdjQrGF01bzq9bYZg==
X-CSE-MsgGUID: EEVfV6zBTdWzr+OSPdt5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="136931173"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 01:48:47 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 22 Apr 2025 01:48:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 22 Apr 2025 01:48:45 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 22 Apr 2025 01:48:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BIAhSKV9B59AIoIuWPzGYSlnQeVjdavwEBCpf56wpXO56juwJ3Zfon0H2OC5oc8ccMoM3eD8ncp2UUzRfFcRYK22aABARkQHDNpuSWqtj4aIfnPFg1fLuPL1BR8hoIp4/i8Wmfip57QU3Uqga6bgcgKerNO8CIgjhCv+D1BaSb+VkV1hF0/fXWJ3wf/aQYmmcmO8/1x9C7IRY0qYhcxKldK+aVRIeiqBemIrRagHqC5dLwAkhLBSHzL+wXhlJAwSDTG54cmLSGD5jxvq3o/Hdw63vR2fPnK91K4XR9sQcS21rG5d3HWymQMmAlCckMzQkW+ODbx18RW2Uh5tJkh/Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXx32Dp9ODN6fnPfyat4fH+WUU///SPb/wHvY7zVgvM=;
 b=lR8TrbbCCG4LE3ECXVfMVsIlxmiBQY553JZdvvG9z4bMUcKSmAnPpVCia9dEu1wLG78koA/yAYr/N808V1lOi1jU6vXxgE3I/B4m0+HSlXhFvD0O1SB0RDBbL3Y55eX0p10PopW8uNYHE01je8KhsVhWj5+07/W2oESDi8yXUPUp5rCmxOZ2W1igRRGG/DWJ0xBZIIosvah856x58LLeAZdlJ1hgSJOG2WywgfBjRuqzUW+xmer2Un8YnRPtz2ldP3dsTQDZEbfhbkKSh9J1vA0a/DIZWGFUQcsbqKhEhr2shEwgs30PxnoKG83IFluj3BO9Xd4glXAewzlJgUfSuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH8PR11MB6927.namprd11.prod.outlook.com (2603:10b6:510:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Tue, 22 Apr
 2025 08:48:34 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 08:48:34 +0000
Date: Tue, 22 Apr 2025 16:48:25 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Christoph Hellwig <hch@lst.de>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [block]  30f1e72414: blktests.nvme/019.device.fail
Message-ID: <202504221628.32af97d8-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KU0P306CA0032.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:29::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH8PR11MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: de6e4652-c1ad-4921-e769-08dd817a774b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mgvFX3V3L3zU6tfDy31ntoe0sPssQX1XkyI8uySwdDKqLq7H4yqj+toZk3Vr?=
 =?us-ascii?Q?LMmLj4dIdUPrkr0wKQBXZ7C6Li4r+H/hLo53ETMB2hY5F35BoDnSgwU7BBFm?=
 =?us-ascii?Q?NsiipaXlMAQMw/ir8KICXcSxme6nZkZZldxmXif+v0oq8vFADAHYwjrwdA8F?=
 =?us-ascii?Q?+14DCRDnSwrX4giy6oxvByqjLmt+0GvSOC6+EvYPMxqi6kat/rnnLL/9Pr+C?=
 =?us-ascii?Q?nEgPh4hY1t+prjRQEDqnnjSjYb3znffZDbupPh0gNkXScRn6kGhA1lsjCNiN?=
 =?us-ascii?Q?rJWu5KF2h9vNIcHRV9RhOUeKdc/fXSQcfkjWJYJOYCRIWk0wJ32DlwF7tAqT?=
 =?us-ascii?Q?PfC9LORtMUiXPhnujJQcHzfUhgyjiKW27lrg2YRhR9cClNiCIKhShEdp2Wi9?=
 =?us-ascii?Q?FZ9Ybunxm7XfKZiWmgNz26eac96byqgkNKR+KiVIBtGETcAPWyq9+S0Dnvj8?=
 =?us-ascii?Q?8ri3/UdmX7i5BoCH9SctxJIvVoe6IBHYDQ8lr7NqetbGulgn4rIhjMKdLkj4?=
 =?us-ascii?Q?GgzSKDeDCdFGXJNqGjMpOVUwKpa+w3q76yzAMGpvGQb9RMBhzZt5O5EDWtHQ?=
 =?us-ascii?Q?kJ1JhrnGokTFgCEM2bHBRTGYghLQl3dBsR7ogB5InGGLb0BPYrQEdtwBh74l?=
 =?us-ascii?Q?PIqX8VUyz469YLt3DLa3kh73OvMys+qwWxmW6MgUD/r5XqdDs+CwAomjdfI6?=
 =?us-ascii?Q?sXZOKLr3rKptDZcWfuflAUzs0CHKcWFnkGI8U5Z7yauDgmZVXLf487PDewbK?=
 =?us-ascii?Q?7rABmGQwlJRzi/C2AedYtb0dCCuDcnFa2FkhAxVG/01GpnpcEawrYTwcQB9t?=
 =?us-ascii?Q?3J3NX+G4u8s2ve0kEvEY34Sj8ADhhnqFm7haNCfkaKvUZ5xEXWdmFeTdsdO9?=
 =?us-ascii?Q?F9tnL/HoHTRjR3ep8mxsHYwWjpGDxDilyMHwjMW4XuR2ah4/6pTLjBgMQfgD?=
 =?us-ascii?Q?BbTamMcxWYwXRtEmGAD7cvtRJFhrz/zPmpfrE5ku27hMKxksu6lfjM1ihRTW?=
 =?us-ascii?Q?nEGc73TWtDveXhnaPq1uDD/HWZ0sBhlRU1yA3eDhRIcp3xBix/7le8hkDl55?=
 =?us-ascii?Q?cc1u8kUl+JCK6C39YeFCxTowImXAg9IAXsPQ/FzB3Wi6tNflBE54m2aevKIO?=
 =?us-ascii?Q?cY6oEY+Y6ehvE4f6vIx0MD2aXYRCEa5oVImwxTbRq216NgJKhsidShwW3+Pk?=
 =?us-ascii?Q?wwx/oGLgaIgOiy/jNiGI6SwaPfFe5L1UGNq3jNw9wjGpOr05VYS3kysGIxax?=
 =?us-ascii?Q?NvUSlfLblKfah/q/GBZwudLwuWrodB+aJR2rVsFHSmhT7p6+nC5Jv/t5oW/V?=
 =?us-ascii?Q?SYBCuK6ewW5pNRMIUwC7WiUW8kd+Hkyi/B2zBj7vKgDknq984hrLbNfIriKB?=
 =?us-ascii?Q?8/F3X65Ph0hYVmW1b40MdhShHx7Z?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fNVj1Nlusf7HMQv1TIPBOSpgW+ogcakLiVVyEjlMvnNxHeDIJCIQkq6hl8zK?=
 =?us-ascii?Q?g2ghxWBMbY243LAojh3TXZDwH8BwWQz+xZVa+fTbhfkeN78XUiWjGNG3F12B?=
 =?us-ascii?Q?bcu3yIOp+V4HoeLLCoZXWnmfR+ts7++lQ8GtNr0Blw8DIDZNN6ei2syHtq1J?=
 =?us-ascii?Q?wi4CgSd7RlbMUiEQamHg/aImbhtLlHlkEHdEJGNRV/sF4aUd1PbrBdiCJchE?=
 =?us-ascii?Q?siR61M2p1lklctj/rNvey2d5Fn36G/GK7dN1L5m5TzX4vBOacj4Yhzog6Iaa?=
 =?us-ascii?Q?G6X5yYTi+9zd51zOEm/tCFPEsG3V+zAjs6h6Ovx09ESg92INC/YfYOp+uqwo?=
 =?us-ascii?Q?0mZ4iFwxRI5HsOvpc/Yrg1J17Lw3WTJZJfRlPzKYYp++XizWSeACVkI5MU1F?=
 =?us-ascii?Q?04Tljcht1MiO/udDOVJsaR5K4t10ziYPfE1w2+bBWnd5eZFVzz/zLV9a/1Ub?=
 =?us-ascii?Q?Z1qsSxKnB/JV24+rqbT/jJp4OhaAVr86EmY7Q6RtcgkUyYtWseRILUPxdz+p?=
 =?us-ascii?Q?Im/B6iLmQM0QunwzLIsUeZWxlDeKVHXiZvtxKv4eKstuNWr/49NsCX2n0yHr?=
 =?us-ascii?Q?2ryg9gBlZ8bMiO6EuiR/okcKbEUqmLcsb8dDZiicdwB1SwQv7TsdnPTMUOKw?=
 =?us-ascii?Q?rTqlmejMax+WJJbySnwrW3zkUhgDFn2ShFEW1KIVVt5CzMCWWsCi1pd4eLCu?=
 =?us-ascii?Q?jru2C+EENAdjHbTXiOoZwUqxy2RVvOvCD9EuA5T8yqM8rkoQnBI3bYkiKOCl?=
 =?us-ascii?Q?mJEttkWU328u3TPyqUIil/0nRjJJb0CuNm05dSJTKBAWn0CnxqKA7iiy2/Su?=
 =?us-ascii?Q?MusmjyTM7nQTUTN3B01GnA/VrWZCvKRwxCILvWRfbPeTQVERQXcEi4NUvuc3?=
 =?us-ascii?Q?b92OZjifmpgzyWLbVGvb8q5b+xFvWLV4dv3xY0p42eoQrVHglQQRZVEJuJ2D?=
 =?us-ascii?Q?0j1N1ZEiQj29XAJllQOox8CM571LrLbCmWU1BnpOZZjg4dDGYLEdUIrVHllT?=
 =?us-ascii?Q?Wwfas7/M8vMthPcHneNg50+aOtHcM5NHVW5Mpp+mZhYE/UkUrUeSkr2wYbKS?=
 =?us-ascii?Q?KaucEQ/VSHVNwdqdGP89xFr8bkFSJaGsMX9ljwqPsxOo4nocX//5Ha49nVKx?=
 =?us-ascii?Q?QFevE2kQM8ciR7PywbtJjAngtKyLYUl4WfA9pbJSgq6HDAfuAaLZTHAYgx8G?=
 =?us-ascii?Q?3nAWt/MBO9SXpmtxMMI5jqvxH7yn7efg+7vH3g7xhY9sOUYsDpajii8L4dxc?=
 =?us-ascii?Q?XBVslj9S+ruQ49r4EoQYNwVMA9xmVjmZmTA1SVAYOYfyLt5TuJznBEhVc1iI?=
 =?us-ascii?Q?IFIL3KphZeGjVP5DezsyogHFubqbcQEbUzrOpLrl5X2CXnM+GcKgVJz4gbe7?=
 =?us-ascii?Q?YEBQFAyhAUktpvWi07Nh6Sg1geMYJY0wBZx5fCC3sxWn7U6RhEwT9/ClnOUP?=
 =?us-ascii?Q?G0qRCrcJPyyerspSs+zku2PxrNLBy95issX7wg5YHoqlZjOqXwouqCbPKR4Z?=
 =?us-ascii?Q?aoZ0lbX6BZAG6UaaTIXZ7Hp8ArIq3caO9qwtGSnsbJUAbhSichw8XzOaPIrq?=
 =?us-ascii?Q?sFXvkFEkLJybfpmofwKFjzOTT9x9SNjTY6WYL3lmMXvtIZx4LMjeL4ZFY8UT?=
 =?us-ascii?Q?zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de6e4652-c1ad-4921-e769-08dd817a774b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:48:34.5206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3+ynQjNCzIQssxThlu9GadMrgTirrAwRAiUQC5BVQriYGcQ4vALprvHC8FhKnkYX6S8oZub7GqWuL6MHo4UVGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6927
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.nvme/019.device.fail" on:

commit: 30f1e724142242a453f92d90b33e030014900bf0 ("block: move discard checks into the ioctl handler")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      8560697b23dc2f405cb463af2b17256a9888129d]
[test failed on linux-next/master bc8aa6cdadcc00862f2b5720e5de2e17f696a081]

in testcase: blktests
version: blktests-x86_64-236edfd-1_20250318
with following parameters:

	disk: 1SSD
	test: nvme-group-00
	nvme_trtype: rdma


config: x86_64-rhel-9.4-func
compiler: gcc-12
test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.10GHz (Ice Lake) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202504221628.32af97d8-lkp@intel.com


nvme/019 (tr=rdma bd=device) (test NVMe DSM Discard command)
nvme/019 (tr=rdma bd=device) (test NVMe DSM Discard command) [failed]
    runtime    ...  0.920s
    --- tests/nvme/019.out	2025-03-18 16:49:58.000000000 +0000
    +++ /mnt/nvme-group-00/nodev_tr_rdma_bd_device/nvme/019.out.bad	2024-08-25 17:37:26.300999900 +0000
    @@ -1,4 +1,4 @@
     Running nvme/019
    -NVMe DSM: success
    +NVMe status: Command Size Limit Exceeded(0x6183)
     disconnected 1 controller(s)
     Test complete



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250422/202504221628.32af97d8-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

