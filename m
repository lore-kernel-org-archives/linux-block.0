Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E2A16BE0A;
	Tue,  6 Aug 2024 08:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722933827; cv=fail; b=UOvVPYHp1Bc4/NL1Q1crwnrU6lbNHj1mUeEYMn7UWif2nLVHXJmiCqYk2KFGpPllKX6BlTa3/UYt8jREoxqVOgMTdz4g/YdlDDCFwqyww+I8zkuZ+GjxCEdUDsROrB/m+bbaqvuvtY7oihOjimKHHDHk4sAXd5mbeUC1jM0dtD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722933827; c=relaxed/simple;
	bh=yGp3VAhMPsMmm3y/bcgq0ltYyCX0Rck1gZtP0tCDgL4=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=XjdwGjVhCw/d/XHfwY+ZjKdOdobyOw2uSzCPn5P0hjv89zHrMxmkz2lAgGRrvzgH/7RaAgrmdSw0B+fP7lm1lzOxhlBua7SsLHXn86PGlveG1y1w19CXD6pmgDvWncT44PWNExxxYIlI7A9o06KGU1NDdo3pImFoj69vqP4SAAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qr9z60mb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qr9z60mb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722933825; x=1754469825;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=yGp3VAhMPsMmm3y/bcgq0ltYyCX0Rck1gZtP0tCDgL4=;
  b=Qr9z60mbsh37LtVlIxWG0LsZh2iMQC1Sb48rF93dVU8KfXVDllC7Xvu/
   lKzO+51V25qUfJHkcCKmTgL7Dl/f5Z30prWsHZUZ50s0guVjOHhG2YdQT
   bzpA+j+8f62qsCSSW7TOPBhEJOA2fqFy7EvBGodD7Umu93TDS91PWmFLE
   F1/WTXvGvkjrYZiOBpaux2xOMPWzNjrUNOSFiYBjg0mFnAzBufFIxPdtk
   MSpVasfOF8wsQt6N0I+TYx8Xyr+TYfKJguf/n29yFDblqUwhhCNQWZJIW
   NegothOVj8zODqyqyZbgVBSdkf+JaIBMPrUNCAaWIQQ0PviP9KG5anQtj
   g==;
X-CSE-ConnectionGUID: r5kdjKmHToSVGk0z4bIVFw==
X-CSE-MsgGUID: FO5aF6A+RDuFWbetkkv/9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="24700048"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="24700048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 01:43:44 -0700
X-CSE-ConnectionGUID: kHFgtqCfQEyfjCODmW1kFA==
X-CSE-MsgGUID: POtyIkofRk+sKpol49kE/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="79701092"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Aug 2024 01:43:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:43:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 6 Aug 2024 01:43:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 6 Aug 2024 01:43:42 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 6 Aug 2024 01:43:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJt+48KIGL9zgZcRKPKSU5u8ioDLejw+U/0dm1U6T04/KJMARKsBUni0T7RNJ/JkVaGnnUdks+zLpRwWT/P34YPkN9r0H2q9I7gLCoL3UL8arlnmKbQRQoJ+QMK9UnRARFqumHP1BAdxsuGEjbNnQaScFi3QlCDmfhdXQ/Fl45aH97XwT7U0t7q+g0NQ748jcGuAL+b4pRqiNma0Bd6s0PWqEc32/aLBgRq1Dcj2Zy73YisiGAXfrB6BssLWIcydY3Fcp/cgZscDQd6aOZZy+Mn7FXuQgYRqkX4Ye73cX3ZzZYI8Zgr93rdKve2denkkGmPnF/S4KXVho0vkY5zXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUCmKm8fDxSIBZfD6P5IK4yWgnz6zeHXyzTifmcloi4=;
 b=nZyVhS9y2XCsz2E6ElpV94FVUiGTmKZTNzuP0Y0XoEQ/pc1sn7tvurGmSS4vvls0Cvqn6+sYv3cWKklgteHMyPshWzJ7l8mxc/YskQh/e1H/+yDEiHrn3IGT58+iQu32x61TsQZb2B/SDmWBYyytuHGJa2Buy+bGPDMPNzSnTs+dE4OLaAznnvQJsw14gkgzKWQcxmb8tqKaNNMk1UYD3RGAHlXQfUOKkT/4z/GwM5rgtyJMQYStLH5/J/it8aX8FOOPffUdZSdCicEq78Ylu0EXKTIEKFVSPQw/zcyOUoI/B5vg4rk/sriC5yj5DcPwU5uq5M9MhJnBUVl/vla12w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB8593.namprd11.prod.outlook.com (2603:10b6:806:3ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Tue, 6 Aug
 2024 08:43:39 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 08:43:38 +0000
Date: Tue, 6 Aug 2024 16:43:27 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Baokun Li <libaokun1@huawei.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig
	<hch@lst.de>, <linux-block@vger.kernel.org>, <ying.huang@intel.com>,
	<feng.tang@intel.com>, <fengwei.yin@intel.com>, <oliver.sang@intel.com>
Subject: [linus:master] [blk]  4e63aeb5d0:  swapin.throughput -76.7%
 regression
Message-ID: <202408061623.ed5cd480-oliver.sang@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 02446d6b-b742-4886-0b6e-08dcb5f3ddc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?iv54h80158iriMeCPqdTm1+wq+Gi5QQEMKFlZbBTFX7CgRGsPW5G3uqphk?=
 =?iso-8859-1?Q?dN2PLpNmfi/v02NbZdl49kLa8aVXjtuKOTmXeEmFAggcEILki4wwgJSJuZ?=
 =?iso-8859-1?Q?wbR0oQN9Ea9qgVeQOLMWK+L82Koudc2HRRSdJV0TbdUkg2yw/WWLAf1JTV?=
 =?iso-8859-1?Q?WPx4zVrEEWFDL+R6LUnIhK880+1rfzY9wyVCHqYOX/DqahZMKhOLAXU8YH?=
 =?iso-8859-1?Q?XiJ9DVGld81DBrHHTnwtRd8KuLh5i+6MLsuvjpeHnsuL/gFh/CCWirX/SG?=
 =?iso-8859-1?Q?eVjG+zNpxd8VKjPXQMg+nieN93OLb7s326qZ7JerOFCjfmtWdlKWfprBHu?=
 =?iso-8859-1?Q?7XxKFMuO72G3CY8Z3UIxVw3MHlMZY5ZRfFFxGCmBy42Mep2XkdHA6W90I+?=
 =?iso-8859-1?Q?l4Xg19ga50RaBScJaA5NuYgbyA4hMmGErLMFRSqgUER2sUM/7SaroAgzLL?=
 =?iso-8859-1?Q?iRapBlo2Xv6YHp812pha0X5Jkrmw1Fg4G4SrktyeSSaWJoEL9gTiC3wCWe?=
 =?iso-8859-1?Q?DtkvvRRkBZgifr5CO7jUFlWRnJoIeUr9hLqO7m7pdOU5jUgMeRc+13S8i0?=
 =?iso-8859-1?Q?JBWfSU2zyhmg9LwqF/9w3+x3Dof4Yo47Q/0OKN/FKWbFkdjmn3Npq/9Lzx?=
 =?iso-8859-1?Q?iFFyHPbMYfDP2vjRDrGYPjafcOiQg0IceD5rTguRWdM1zShC9X2JbV8xVK?=
 =?iso-8859-1?Q?Ew4ziJFdMjrEY2cKvQMP7DhWxzhOH6nbenKGy7OBIWA0pfSo2fzV2Ujtax?=
 =?iso-8859-1?Q?hV/0WUQzpPVQQ2fHEOiQcFWP2co8SYAbPJhzfUo3nX95m12qCn0Izw+w8c?=
 =?iso-8859-1?Q?WtwPzrGwCkj0Z7i17o/nHUhJ8prXqHEc1OYH6oFiv7kEwR85vADUn+jkoq?=
 =?iso-8859-1?Q?Mdqj9sG0ve0k+X381P5BxPek8reTu+ChvJIcxoK2o5CDrMuC00DIy1ah9D?=
 =?iso-8859-1?Q?qmlq/+DYGTUl4BQyEIghuJWCayxUITNnanDwJr/96daOncmwzvnzX3cZ6A?=
 =?iso-8859-1?Q?1DRqNZNp+IHzBGO9qIAP3TuEIjzEa9g+ByeRM5Bjbd4dGJgX/+YCuPgQPH?=
 =?iso-8859-1?Q?WQlro40vP8mllBNCuICamHVObunYti+VfkRydzvyCtxcOz70QJR9sumski?=
 =?iso-8859-1?Q?XSNpV6+dYfiTsTNj21ONKAadxa1VKJZkR6JKWNLURmRx7iO1ksr2j05tV0?=
 =?iso-8859-1?Q?Ho09wT8jEv4oJ45fzQIiwL6HPNBr+3b/z9LM72SvQBUmpLXUG+ISkrDxCb?=
 =?iso-8859-1?Q?kqZ3oPPtji+H21euptr1mWlZ+aEdmegZ/ZTDmrWBgo+F/bYin44ib+bnrz?=
 =?iso-8859-1?Q?0exalJ8tONuGswb40gQl29UYCLwO04fStKdo2h6LK3ukFLlUs+jaCSjU4W?=
 =?iso-8859-1?Q?SHpei6NHnx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9WSdWqvRK29jiHetjeF205Kl7Wx6gzltOYJSRJ2PUQ+MqnshFpxtPIAZPW?=
 =?iso-8859-1?Q?wWihfqbYek45pTPCk81w05VTbyNCeD6wNZciNzDBUvYD2jxZ0wkUVP8r/w?=
 =?iso-8859-1?Q?nhlhpX5RvAr39MzbmpV+nCbmsDz1/qNRwv8qmB9uB45sLRwg239YWokIMH?=
 =?iso-8859-1?Q?8iy8GBo86eJLJQa2ASVc9q2ZMUjG703bUO8EllToswo87MNAfuNAnd9WoX?=
 =?iso-8859-1?Q?vsp+7U6mnjySIWp674Qo2b8Vp4sEVEt40DUPJU7iz5NmriXAT2yugRL3l0?=
 =?iso-8859-1?Q?LaBy2JDBM9RtoRkyc9RIsVj+tZBs3Mz7JIeArNuvSgeTedC5QYjqtfyEgZ?=
 =?iso-8859-1?Q?LFvgfPHgOhAS9cy1rRb7MgMqU3JgFzdeoaywZNUPRZo/imPjdXrMkFYGwe?=
 =?iso-8859-1?Q?3nC5LtPK5KAEkQWzUrX/cGKvTTzPVDRisjuasE6kykchZWjDpZfPwcQrB5?=
 =?iso-8859-1?Q?fWdI9KZC532fkkYu+9LLMG80sZMSFV/S/gZkrIVjLIpI9yqxV1K7/NzrsC?=
 =?iso-8859-1?Q?J2lqpL4CJ4vHB0xlEBfzTQU/9+u7vlEZ5KqVtfyTKrqMnBzvA/Hs5strqG?=
 =?iso-8859-1?Q?wJSu9h5Un+5uVEBnH0f8Zmpbd222jDRQA7pVzwQRYuY8SU4w3QNeznFSza?=
 =?iso-8859-1?Q?KwvXxmtXmAcNhgjiavIc69qNPySvglMLPrs4szYOOUo0bw6y6Ah9PlNbiM?=
 =?iso-8859-1?Q?ETm0cJ0PpFTZU4jxbGdiHgyXDOIz4jHu0CwjZ4mqdHBWgieZZTZyOqq0QB?=
 =?iso-8859-1?Q?FZZiufzX+aDaMTRciRQ6G+KOz1ty4mNr2vAufgPZ4fm1fpzAlu6rr0exmB?=
 =?iso-8859-1?Q?XDZ5iltF75bkZQfhlstSK0yLKuwmCHHqI05qlHimXXWY1R3/9zUpIYH+b6?=
 =?iso-8859-1?Q?Fbrml110HPAS4c18wo5iaIdZuQJVn7l8Ju59xGqlKWarBi+uW5Cw+4odGO?=
 =?iso-8859-1?Q?B3xLmpJ6O+Xissr7XjujXBTgSg/BU1ujNcoKAX8RQmTE8llYPYPS4DAH9C?=
 =?iso-8859-1?Q?q4KroT7iITL0zxfBieg68hasw/Luu2oIWbkKE2wANCfJrLto5qO3i7lgfH?=
 =?iso-8859-1?Q?/6KYOnGN/M9a1X7pQQNcX+8ApcvgfLIEmWeaNW+/l9JbxKRaWZTiBcbBzi?=
 =?iso-8859-1?Q?L1H7wOUl11akB6Vq0FywvouXhY85qaRMVvJe7V/UEJrJ+HhHGuyLJ0Bp1K?=
 =?iso-8859-1?Q?fdywWBQFEA9ax6D2SdUeKw2C9MwbOwvfRh886LwzpxhILbqzSpv/CLoWl3?=
 =?iso-8859-1?Q?j7h7g2QX7f4HKB7z/z3vmQjHh4+I1mSyBp5aiSNA4fsRgRBcrThBEz3vaf?=
 =?iso-8859-1?Q?6dtUVBbxozpmoM92S0zZdzw/LTa7dkpuaZv88qf9PRcJheh8U7KNF3iQl8?=
 =?iso-8859-1?Q?zdyVDFU//BDQ3kjShEdcs9DdEESZvxSAgDXtYSShfycNj+KtQItrp2/nj7?=
 =?iso-8859-1?Q?NoK0Q1V7eHdIVOEG1pKOjrG0WkWCic6xy9gDGS7XFHtYxq/z7Pk5SFrlAo?=
 =?iso-8859-1?Q?/6TrXzOX8rARvMfDMe4rPd4G4ebmJ/ywc43QTDfM5eZsALtTcnvZ6ryW9k?=
 =?iso-8859-1?Q?c1Bq07F1TMPJAn8D1sFhGymhSTpeGGBDX1JbZDvQhWk0VCdTN3tVdH9wjV?=
 =?iso-8859-1?Q?p0ZwTRiepTteFEBFJRaHStVOBevgmNAzbCS3xBZgpF6KD1D/SzkVGX2w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02446d6b-b742-4886-0b6e-08dcb5f3ddc4
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:43:38.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PkzxiKCsB7Y9gqe82xr46vwsp4UoyT6/fTnTo+eDhOamg2G6n/9XnwdV0tevniIg6yfNl1ETt1MsdedAmb/ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8593
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a -76.7% regression of swapin.throughput on:


commit: 4e63aeb5d0101ddada36a2f64f048e2f9d2202fc ("blk-wbt: don't throttle swap writes in direct reclaim")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: swapin
test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
parameters:

	disk: 1HDD
	size: 8G
	nr_task: 72
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202408061623.ed5cd480-oliver.sang@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240806/202408061623.ed5cd480-oliver.sang@intel.com

=========================================================================================
compiler/cpufreq_governor/disk/kconfig/nr_task/rootfs/size/tbox_group/testcase:
  gcc-13/performance/1HDD/x86_64-rhel-8.3/72/debian-12-x86_64-20240206.cgz/8G/lkp-ivb-d05/swapin

commit: 
  62e35f9422 ("block: pass a gendisk to the queue_sysfs_entry methods")
  4e63aeb5d0 ("blk-wbt: don't throttle swap writes in direct reclaim")

62e35f942231e372 4e63aeb5d0101ddada36a2f64f0 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     37.67 ± 16%     -33.2%      25.17 ± 16%  perf-c2c.DRAM.local
 2.199e+09 ±  2%    +349.5%  9.885e+09 ±  2%  cpuidle..time
   1161765 ±  2%    +239.9%    3949045        cpuidle..usage
    883.44 ±  2%    +236.9%       2976 ±  2%  uptime.boot
    342.97 ± 12%     +78.4%     611.96 ± 10%  uptime.idle
      1.78 ± 22%     +51.1%       2.69 ± 17%  iostat.cpu.idle
      1.24           -34.8%       0.81        iostat.cpu.system
      0.75 ± 28%     -56.6%       0.33 ± 24%  iostat.cpu.user
      1.67 ± 23%      +1.0        2.67 ± 17%  mpstat.cpu.all.idle%
      0.10            -0.0        0.07        mpstat.cpu.all.irq%
      0.13            -0.0        0.10        mpstat.cpu.all.soft%
      0.99            -0.4        0.63        mpstat.cpu.all.sys%
      0.73 ± 29%      -0.4        0.32 ± 23%  mpstat.cpu.all.usr%
     15149 ±  2%     -77.1%       3464 ±  2%  vmstat.io.bi
     15149 ±  2%     -77.1%       3464 ±  2%  vmstat.swap.si
     61.63 ± 48%     -84.4%       9.62 ± 13%  vmstat.swap.so
      3452 ±  3%     -19.3%       2785 ±  2%  vmstat.system.cs
      1125           -28.0%     810.72        vmstat.system.in
      0.01          +265.2%       0.05 ±148%  swapin.free_time
    219.17 ±  2%     -75.9%      52.83 ±  2%  swapin.median
     15933 ±  2%     -76.7%       3719        swapin.throughput
    559.70 ±  2%    +347.3%       2503 ±  2%  swapin.time.elapsed_time
    559.70 ±  2%    +347.3%       2503 ±  2%  swapin.time.elapsed_time.max
     21134 ±  2%    +344.0%      93842 ±  2%  swapin.time.minor_page_faults
    855.50 ±  2%    +345.4%       3810 ±  2%  swapin.time.voluntary_context_switches
   2880939           -31.1%    1986005 ±  2%  meminfo.AnonPages
   2880149           -31.6%    1968934 ±  2%  meminfo.Inactive
   2880064           -31.6%    1968836 ±  2%  meminfo.Inactive(anon)
   1528640 ±  2%     +58.5%    2422892 ±  2%  meminfo.MemAvailable
   1617064 ±  2%     +55.3%    2510929 ±  2%  meminfo.MemFree
   6398383           -14.0%    5504518        meminfo.Memused
      1778 ±  5%     +40.3%       2496        meminfo.Mlocked
     21239           +92.5%      40893        meminfo.Shmem
   2858658           -32.0%    1944940 ±  3%  meminfo.SwapCached
   6653579           -10.1%    5979866        meminfo.max_used_kB
    720078           -31.0%     496920 ±  3%  proc-vmstat.nr_anon_pages
     37335 ±  3%     +59.2%      59449 ±  2%  proc-vmstat.nr_dirty_background_threshold
     74761 ±  3%     +59.2%     119044 ±  2%  proc-vmstat.nr_dirty_threshold
   1486119           -15.0%    1263128        proc-vmstat.nr_file_pages
    404617 ±  2%     +55.1%     627376 ±  2%  proc-vmstat.nr_free_pages
    719902           -31.6%     492619 ±  3%  proc-vmstat.nr_inactive_anon
      4300            -1.9%       4218        proc-vmstat.nr_kernel_stack
    444.90 ±  5%     +40.3%     624.00        proc-vmstat.nr_mlock
      5758            -2.6%       5606        proc-vmstat.nr_page_table_pages
      5311           +92.5%      10226        proc-vmstat.nr_shmem
    714496           -31.9%     486593 ±  3%  proc-vmstat.nr_swapcached
   4241975            +1.4%    4299627        proc-vmstat.nr_vmscan_write
    719897           -31.6%     492617 ±  3%  proc-vmstat.nr_zone_inactive_anon
   2628992           +62.5%    4273104        proc-vmstat.numa_hit
   2628620           +62.6%    4273103        proc-vmstat.numa_local
   1691631           +47.9%    2502009 ±  2%  proc-vmstat.pgalloc_dma32
    943544 ±  2%     +92.1%    1812431 ±  5%  proc-vmstat.pgalloc_normal
   2787176           +81.3%    5053889        proc-vmstat.pgfault
   2779533           +60.4%    4458571        proc-vmstat.pgfree
    324958 ±  2%    +253.3%    1148089        proc-vmstat.pgmajfault
   8530651            +1.7%    8678226        proc-vmstat.pgpgin
     37125 ±  3%    +326.5%     158341 ±  2%  proc-vmstat.pgreuse
   1814515 ±  2%     -13.4%    1571241 ±  2%  proc-vmstat.pgscan_anon
   1774160 ±  3%     -34.5%    1162742 ± 31%  proc-vmstat.pgscan_kswapd
    723131 ±  4%     -28.7%     515908 ±  7%  proc-vmstat.pgsteal_anon
    712601 ±  5%     -29.7%     501201 ±  7%  proc-vmstat.pgsteal_kswapd
   2132662            +1.7%    2169556        proc-vmstat.pswpin
    851208           -79.8%     172337 ± 15%  proc-vmstat.swap_ra
    829952           -81.5%     153244 ± 15%  proc-vmstat.swap_ra_hit
    347.67 ±  5%    +440.7%       1879 ±  5%  proc-vmstat.thp_scan_exceed_none_pte
   1020086           -25.6%     758810 ±  4%  proc-vmstat.workingset_refault_anon
      1.94 ±  2%     +55.0%       3.00 ±  5%  perf-stat.i.MPKI
  51688339 ± 13%     -55.6%   22933796 ± 12%  perf-stat.i.branch-instructions
      1.80 ± 15%      +1.3        3.14 ±  4%  perf-stat.i.branch-miss-rate%
     13.16 ±  4%      -1.4       11.73 ±  3%  perf-stat.i.cache-miss-rate%
    353322 ±  4%     -32.5%     238490 ±  3%  perf-stat.i.cache-misses
   2541034           -21.6%    1992435        perf-stat.i.cache-references
      3455 ±  3%     -19.4%       2784        perf-stat.i.context-switches
      1.32 ±  2%     +37.0%       1.80        perf-stat.i.cpi
  2.58e+08 ± 10%     -39.8%  1.555e+08 ±  5%  perf-stat.i.cpu-cycles
    238.14 ±  5%     -33.7%     157.99 ±  2%  perf-stat.i.cpu-migrations
    743.19 ±  4%     -13.5%     642.84 ±  4%  perf-stat.i.cycles-between-cache-misses
 2.222e+08 ± 16%     -53.3%  1.037e+08 ± 13%  perf-stat.i.instructions
      0.78 ±  3%     -26.4%       0.57 ±  2%  perf-stat.i.ipc
    579.21 ±  3%     -20.7%     459.18        perf-stat.i.major-faults
      2.11 ±  6%     -93.9%       0.13 ±  8%  perf-stat.i.metric.K/sec
      4326           -64.7%       1525        perf-stat.i.minor-faults
      4905           -59.5%       1984        perf-stat.i.page-faults
      1.62 ± 13%     +43.9%       2.34 ± 13%  perf-stat.overall.MPKI
     13.91 ±  4%      -1.9       11.97 ±  3%  perf-stat.overall.cache-miss-rate%
      1.17 ±  6%     +29.0%       1.51 ±  6%  perf-stat.overall.cpi
    729.25 ±  7%     -10.5%     652.74 ±  6%  perf-stat.overall.cycles-between-cache-misses
      0.86 ±  6%     -22.4%       0.66 ±  7%  perf-stat.overall.ipc
     14931 ± 18%    +107.7%      31011 ± 14%  perf-stat.overall.path-length
  51645182 ± 13%     -55.6%   22933160 ± 12%  perf-stat.ps.branch-instructions
    353037 ±  4%     -32.5%     238456 ±  3%  perf-stat.ps.cache-misses
   2538977           -21.5%    1992125        perf-stat.ps.cache-references
      3452 ±  3%     -19.4%       2784        perf-stat.ps.context-switches
 2.578e+08 ± 10%     -39.7%  1.555e+08 ±  5%  perf-stat.ps.cpu-cycles
    237.94 ±  5%     -33.6%     157.97 ±  2%  perf-stat.ps.cpu-migrations
  2.22e+08 ± 16%     -53.3%  1.037e+08 ± 13%  perf-stat.ps.instructions
    578.74 ±  3%     -20.7%     459.10        perf-stat.ps.major-faults
      4323           -64.7%       1525        perf-stat.ps.minor-faults
      4901           -59.5%       1984        perf-stat.ps.page-faults
 1.253e+11 ± 18%    +107.7%  2.601e+11 ± 14%  perf-stat.total.instructions
     68218 ±  3%     +37.2%      93582 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.avg
     78607 ±  8%     +34.2%     105510 ±  4%  sched_debug.cfs_rq:/.avg_vruntime.max
     59706 ±  5%     +38.4%      82650 ±  6%  sched_debug.cfs_rq:/.avg_vruntime.min
      0.13 ± 35%     -73.3%       0.04 ± 33%  sched_debug.cfs_rq:/.h_nr_running.min
     11999 ± 38%     -70.3%       3560 ± 56%  sched_debug.cfs_rq:/.load.min
     39.45 ± 19%     -70.5%      11.63 ± 17%  sched_debug.cfs_rq:/.load_avg.min
     68218 ±  3%     +37.2%      93582 ±  4%  sched_debug.cfs_rq:/.min_vruntime.avg
     78607 ±  8%     +34.2%     105510 ±  4%  sched_debug.cfs_rq:/.min_vruntime.max
     59706 ±  5%     +38.4%      82650 ±  6%  sched_debug.cfs_rq:/.min_vruntime.min
      0.10           -76.3%       0.02 ±  2%  sched_debug.cfs_rq:/.nr_running.min
    494.13 ±  4%     -52.1%     236.73 ±  3%  sched_debug.cfs_rq:/.runnable_avg.avg
    998.37 ±  8%     -34.7%     652.14 ±  2%  sched_debug.cfs_rq:/.runnable_avg.max
    155.27 ± 23%     -73.7%      40.77 ± 10%  sched_debug.cfs_rq:/.runnable_avg.min
    345.16 ±  9%     -24.8%     259.65 ±  2%  sched_debug.cfs_rq:/.runnable_avg.stddev
    238.35 ±  6%     -25.7%     177.08 ±  3%  sched_debug.cfs_rq:/.util_avg.avg
     70.27 ± 17%     -72.0%      19.64 ±  8%  sched_debug.cfs_rq:/.util_avg.min
     31.05 ± 32%     -58.8%      12.79 ± 26%  sched_debug.cfs_rq:/.util_est.avg
     89.32 ± 25%     -53.9%      41.18 ± 21%  sched_debug.cfs_rq:/.util_est.max
     37.08 ± 24%     -53.9%      17.11 ± 21%  sched_debug.cfs_rq:/.util_est.stddev
    591881 ±  4%    +188.2%    1705638 ±  2%  sched_debug.cpu.clock.avg
    591882 ±  4%    +188.2%    1705639 ±  2%  sched_debug.cpu.clock.max
    591880 ±  4%    +188.2%    1705637 ±  2%  sched_debug.cpu.clock.min
    589383 ±  4%    +188.2%    1698815 ±  2%  sched_debug.cpu.clock_task.avg
    591380 ±  4%    +188.3%    1704722 ±  2%  sched_debug.cpu.clock_task.max
    583661 ±  4%    +188.1%    1681432 ±  2%  sched_debug.cpu.clock_task.min
      3304 ±  6%    +203.7%      10037 ±  3%  sched_debug.cpu.clock_task.stddev
      1734 ±  3%    +180.2%       4859 ±  2%  sched_debug.cpu.curr->pid.avg
      5305          +237.1%      17887        sched_debug.cpu.curr->pid.max
    147.10 ±  9%     -76.4%      34.66 ±  8%  sched_debug.cpu.curr->pid.min
      2183 ±  2%    +248.4%       7607 ±  2%  sched_debug.cpu.curr->pid.stddev
      0.78 ± 17%     -32.5%       0.53 ± 13%  sched_debug.cpu.nr_running.avg
      0.13 ± 35%     -73.3%       0.04 ± 33%  sched_debug.cpu.nr_running.min
    638632 ± 10%    +297.2%    2536958 ±  2%  sched_debug.cpu.nr_switches.avg
    749434 ±  9%    +275.4%    2813022 ±  2%  sched_debug.cpu.nr_switches.max
    531885 ±  7%    +337.0%    2324213 ±  2%  sched_debug.cpu.nr_switches.min
     84329 ± 16%    +128.8%     192974 ± 10%  sched_debug.cpu.nr_switches.stddev
      2676 ± 46%   +4587.5%     125453 ±  4%  sched_debug.cpu.nr_uninterruptible.max
     -5338         +5614.3%    -305037        sched_debug.cpu.nr_uninterruptible.min
      3263 ± 37%   +5362.1%     178254 ±  6%  sched_debug.cpu.nr_uninterruptible.stddev
    591871 ±  4%    +188.2%    1705638 ±  2%  sched_debug.cpu_clk
    591845 ±  4%    +188.2%    1705612 ±  2%  sched_debug.ktime
    591879 ±  4%    +188.2%    1705645 ±  2%  sched_debug.sched_clk
     10.04 ±  8%      -4.0        6.04 ±  9%  perf-profile.calltrace.cycles-pp.do_access
      7.69 ±  6%      -2.3        5.37 ±  9%  perf-profile.calltrace.cycles-pp.asm_exc_page_fault.do_access
      7.08 ±  6%      -2.0        5.08 ± 10%  perf-profile.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      7.12 ±  5%      -2.0        5.13 ± 10%  perf-profile.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.do_access
      6.74 ±  5%      -1.9        4.82 ± 10%  perf-profile.calltrace.cycles-pp.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.do_access
      2.12 ± 12%      -1.8        0.30 ±100%  perf-profile.calltrace.cycles-pp.do_rw_once
      6.30 ±  4%      -1.8        4.52 ± 12%  perf-profile.calltrace.cycles-pp.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault
      6.98 ±  5%      -1.8        5.23 ±  8%  perf-profile.calltrace.cycles-pp.__handle_mm_fault.handle_mm_fault.do_user_addr_fault.exc_page_fault.asm_exc_page_fault
      4.39 ±  2%      -1.2        3.22 ± 14%  perf-profile.calltrace.cycles-pp.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault.do_user_addr_fault
      4.37 ±  2%      -1.2        3.20 ± 14%  perf-profile.calltrace.cycles-pp.swap_cluster_readahead.swapin_readahead.do_swap_page.__handle_mm_fault.handle_mm_fault
      1.43 ± 14%      -0.9        0.50 ± 77%  perf-profile.calltrace.cycles-pp.__read_swap_cache_async.swap_cluster_readahead.swapin_readahead.do_swap_page.__handle_mm_fault
      0.51 ± 46%      +0.2        0.74 ± 11%  perf-profile.calltrace.cycles-pp.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve.do_syscall_64
      0.51 ± 46%      +0.2        0.74 ± 11%  perf-profile.calltrace.cycles-pp.search_binary_handler.exec_binprm.bprm_execve.do_execveat_common.__x64_sys_execve
      1.05 ± 46%      +0.6        1.65 ± 10%  perf-profile.calltrace.cycles-pp.handle_softirqs.irq_exit_rcu.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state
      3.61 ± 11%      +0.8        4.44 ± 10%  perf-profile.calltrace.cycles-pp.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter
      2.61 ± 18%      +0.9        3.54 ± 11%  perf-profile.calltrace.cycles-pp.__hrtimer_run_queues.hrtimer_interrupt.__sysvec_apic_timer_interrupt.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt
      5.55 ±  7%      +1.5        7.02 ±  7%  perf-profile.calltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
      5.89 ±  8%      +1.6        7.48 ±  7%  perf-profile.calltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     74.99            +3.9       78.93        perf-profile.calltrace.cycles-pp.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle.cpu_startup_entry
     22.85 ±  5%      +4.2       27.05 ±  4%  perf-profile.calltrace.cycles-pp.poll_idle.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call.do_idle
     79.51            +4.6       84.08        perf-profile.calltrace.cycles-pp.common_startup_64
     10.34 ±  6%      -4.2        6.15 ±  9%  perf-profile.children.cycles-pp.do_access
      8.68 ±  5%      -2.0        6.72 ±  4%  perf-profile.children.cycles-pp.asm_exc_page_fault
      2.46 ± 14%      -1.9        0.52 ± 35%  perf-profile.children.cycles-pp.do_rw_once
      6.43 ±  4%      -1.9        4.54 ± 11%  perf-profile.children.cycles-pp.do_swap_page
      8.02 ±  5%      -1.7        6.27 ±  5%  perf-profile.children.cycles-pp.do_user_addr_fault
      7.36 ±  4%      -1.7        5.64 ±  7%  perf-profile.children.cycles-pp.__handle_mm_fault
      7.60 ±  4%      -1.7        5.88 ±  5%  perf-profile.children.cycles-pp.handle_mm_fault
      8.06 ±  5%      -1.7        6.38 ±  5%  perf-profile.children.cycles-pp.exc_page_fault
      4.43 ±  2%      -1.2        3.23 ± 13%  perf-profile.children.cycles-pp.swapin_readahead
      4.41 ±  2%      -1.2        3.21 ± 13%  perf-profile.children.cycles-pp.swap_cluster_readahead
      1.46 ± 13%      -0.8        0.64 ± 37%  perf-profile.children.cycles-pp.__read_swap_cache_async
      0.67 ± 15%      -0.3        0.38 ± 27%  perf-profile.children.cycles-pp.__irqentry_text_end
      0.51 ±  7%      -0.3        0.23 ± 51%  perf-profile.children.cycles-pp.__filemap_get_folio
      0.49 ±  9%      -0.3        0.24 ± 50%  perf-profile.children.cycles-pp.filemap_get_entry
      0.41 ± 22%      -0.2        0.17 ± 50%  perf-profile.children.cycles-pp.add_to_swap_cache
      0.43 ± 13%      -0.2        0.20 ± 49%  perf-profile.children.cycles-pp.swap_cache_get_folio
      0.30 ± 22%      -0.2        0.11 ± 77%  perf-profile.children.cycles-pp.bio_alloc_bioset
      0.28 ± 35%      -0.2        0.11 ± 52%  perf-profile.children.cycles-pp.error_entry
      0.20 ± 24%      -0.2        0.03 ±108%  perf-profile.children.cycles-pp.workingset_refault
      0.18 ± 24%      -0.1        0.04 ±125%  perf-profile.children.cycles-pp.lru_add_drain
      0.18 ± 24%      -0.1        0.04 ±125%  perf-profile.children.cycles-pp.lru_add_drain_cpu
      0.20 ± 29%      -0.1        0.08 ± 88%  perf-profile.children.cycles-pp.__lruvec_stat_mod_folio
      0.17 ± 20%      -0.1        0.04 ± 79%  perf-profile.children.cycles-pp.mempool_alloc_noprof
      0.14 ± 46%      -0.1        0.04 ±125%  perf-profile.children.cycles-pp.folio_add_anon_rmap_ptes
      0.17 ± 16%      -0.1        0.09 ± 35%  perf-profile.children.cycles-pp.folio_batch_move_lru
      0.04 ±100%      +0.1        0.15 ± 40%  perf-profile.children.cycles-pp.perf_event_task_tick
      0.18 ± 30%      +0.1        0.32 ± 48%  perf-profile.children.cycles-pp.update_irq_load_avg
      0.13 ± 53%      +0.2        0.28 ± 27%  perf-profile.children.cycles-pp.do_anonymous_page
      0.18 ± 54%      +0.2        0.34 ± 31%  perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.56 ± 21%      +0.2        0.74 ± 11%  perf-profile.children.cycles-pp.exec_binprm
      0.56 ± 21%      +0.2        0.74 ± 11%  perf-profile.children.cycles-pp.search_binary_handler
      0.56 ± 19%      +0.2        0.80 ± 23%  perf-profile.children.cycles-pp.perf_mux_hrtimer_handler
      0.53 ± 36%      +0.3        0.81 ± 15%  perf-profile.children.cycles-pp.sched_balance_domains
      0.52 ± 23%      +0.3        0.85 ± 16%  perf-profile.children.cycles-pp.sched_balance_softirq
      0.55 ± 24%      +0.4        0.92 ± 14%  perf-profile.children.cycles-pp.sched_balance_update_blocked_averages
      1.95 ±  7%      +0.4        2.34 ±  8%  perf-profile.children.cycles-pp.menu_select
      1.29 ± 15%      +0.5        1.83 ± 15%  perf-profile.children.cycles-pp.update_process_times
      2.93 ± 14%      +0.8        3.78 ±  8%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      3.83 ± 12%      +0.9        4.68 ±  7%  perf-profile.children.cycles-pp.hrtimer_interrupt
      3.88 ± 11%      +0.9        4.74 ±  7%  perf-profile.children.cycles-pp.__sysvec_apic_timer_interrupt
      5.97 ±  8%      +1.6        7.53 ±  5%  perf-profile.children.cycles-pp.sysvec_apic_timer_interrupt
      6.33 ±  9%      +1.7        8.04 ±  4%  perf-profile.children.cycles-pp.asm_sysvec_apic_timer_interrupt
     75.35            +4.0       79.39        perf-profile.children.cycles-pp.cpuidle_enter_state
     75.42            +4.0       79.46        perf-profile.children.cycles-pp.cpuidle_enter
     23.02 ±  5%      +4.2       27.26 ±  4%  perf-profile.children.cycles-pp.poll_idle
     77.78            +4.5       82.27        perf-profile.children.cycles-pp.cpuidle_idle_call
     79.51            +4.6       84.08        perf-profile.children.cycles-pp.common_startup_64
     79.51            +4.6       84.08        perf-profile.children.cycles-pp.cpu_startup_entry
     79.50            +4.6       84.06        perf-profile.children.cycles-pp.do_idle
      2.38 ± 15%      -1.9        0.44 ± 42%  perf-profile.self.cycles-pp.do_rw_once
      1.60 ± 12%      -1.1        0.45 ± 19%  perf-profile.self.cycles-pp.do_access
      0.67 ± 15%      -0.3        0.38 ± 27%  perf-profile.self.cycles-pp.__irqentry_text_end
      0.28 ± 38%      -0.2        0.10 ± 49%  perf-profile.self.cycles-pp.error_entry
      0.01 ±223%      +0.1        0.08 ± 24%  perf-profile.self.cycles-pp.__cond_resched
      0.02 ±141%      +0.1        0.10 ± 70%  perf-profile.self.cycles-pp.call_cpuidle
      0.02 ±223%      +0.1        0.11 ± 45%  perf-profile.self.cycles-pp.tmigr_quick_check
      0.06 ± 76%      +0.1        0.15 ± 47%  perf-profile.self.cycles-pp.local_clock_noinstr
      0.00            +0.1        0.10 ± 40%  perf-profile.self.cycles-pp.perf_event_task_tick
      0.18 ± 30%      +0.1        0.32 ± 48%  perf-profile.self.cycles-pp.update_irq_load_avg
      0.04 ±104%      +0.1        0.18 ± 33%  perf-profile.self.cycles-pp.sched_balance_rq
      0.17 ± 54%      +0.2        0.34 ± 30%  perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
     22.34 ±  5%      +4.1       26.40 ±  4%  perf-profile.self.cycles-pp.poll_idle




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

