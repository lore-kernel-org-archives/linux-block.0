Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F8F13AA2D;
	Thu, 16 Jul 2026 05:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784180185; cv=fail; b=oiInJhPffAusHWtKOy6o7OfLvDxXWuh9wZ4eRt+hzh1k4jjLQYD03DJVMGlZEwbiv8wcbhMyZpQGFyhQLKVBPJFZccmw251vO7hLYipd//obu112Le4k8x9qHvt8l/JpgkJEh2SJxuKnvU8kxW03Yecf9sFdns2RrTF8VzuYDPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784180185; c=relaxed/simple;
	bh=DZ6pVGY89GtAuEQRCk7fXoFAAOK/PjJjAIVI3fELjH8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ow3Zhy+sLwSDWedncpqISVH/8EVtNeP0dmoPVkwtu20a9a/TeHTG5qy2cwKyZPXRuPcKqh5P01GJtuUuoikE8pKxzITj3ZFmgz+IRsObgu3Ix+iASnpHu9hnI6GjkZiwZUkbLJSL42HYSZddoV3u6rdRJn/RUjiDXz9QMGM4Ftc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a47Iokf6; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a47Iokf6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784180183; x=1815716183;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DZ6pVGY89GtAuEQRCk7fXoFAAOK/PjJjAIVI3fELjH8=;
  b=a47Iokf6iYwTxuYGR4pPtuNJ97jljZ5ssczQQqqlGT7B8oyFMBYan2Ay
   EyVFm2s6bkPEKiLrKY5XQ1XrxSyOBP3YTrRkgJtXYC8ZMrsvwKtOP1yQT
   cHRhQ1LzUs15lRHrfExmWHRvtbVpYBU4DxGJhQzyc5ahoOyCv5Nj5wtog
   UhH2/odPs/VyZNQYgu0sG08I1nsGFywSIzUq1mTUG/oJF8K7zYtKztTgD
   RvZl9fuKl32EkdJSdRVWhfznomMGlwgh7jviAXnsb/7k3ZDk6eEdJDQoG
   cFOl6UgH3DzisAwMxaDtcsaWDk+YtXpIdrlPH60kGhR4V8gVHV/f6cNj8
   A==;
X-CSE-ConnectionGUID: K+UVPrXgTGyZbp3gV5kUeA==
X-CSE-MsgGUID: 67ei3O7cT7eUbW3UhvweAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84791920"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="84791920"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 22:36:22 -0700
X-CSE-ConnectionGUID: AP9avCuzTuONyBSBqaI4uw==
X-CSE-MsgGUID: uKFH+jUhQxSB3ybGK5/yjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260703556"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 22:36:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 22:36:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 22:36:21 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.27) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 22:36:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdzLdRde1ahrcJC/z0NBdalthFcP/jYx130L521F90s8GszNtN3t6P/bq0LN7HtFpZBOv0vl6yAWRwiZSVsOQetvYeAQt0iyfRu1DqVA1u/slx9w0upSrNquJZGwNLb7gYPdelvmED45yMu5UMBU2VNrxINNhXgncVPUMU5zmYWI3PQBEQYdDE+reLc3NCXRCK/rHxmaWEq0whGWW1Gs9y6OfpPwdrRERWfPiSNdNL+vH9tmepIYIXU4EEQjgcZc83Yayu5bEKgZOZ1oKs6VgXatGdfnXdGyWPDMxzgLfNExMxpxxejKDrpnMZbiTOgfG2hrdo94wMve8V3BXxR1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pv1XQXhAsKZrJaBfmepqbb6cNiwHWnVZ5QoQsef4Lpk=;
 b=FNHs7Upgudq3Dx2C6sv6KDrHuOXiKWSf2hyGxPIt/nwpqwMay9JfNpMkeWHohwEqF/msP7UIAWIzPyGxIVuQbll2YSbjJm1t1btRfaaoOpIU3FGgocihniY180+qzjGh57cqdsZJAAG88CZoogF+diTRG/ltOfbe9zKWt4W4i3h73qQ/DRrDKyAx8/9EXuoopUFrnVOVc/jrxXOBJizXEuJ6JQIjwjCH4c+YdmoyVuPUjTHdq4opGzLhPmvat8wKHMmBDSFMbTRbrkz2DCrKJ+dzHr0yriUQJQFZpvLOxo9mJE1pfXys9ylzog+hGadH+3wvtjx5weRGLMP9AC53gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 by MW4PR11MB7080.namprd11.prod.outlook.com (2603:10b6:303:21a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 05:36:17 +0000
Received: from PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707]) by PH0PR11MB5832.namprd11.prod.outlook.com
 ([fe80::106e:78dd:4c96:d707%5]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 05:36:17 +0000
Date: Thu, 16 Jul 2026 13:36:09 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linux-next:master] [loop] d908729e74:
 stress-ng.umount.ops_per_sec 100.0% regression
Message-ID: <alhtyV7wdura5Q9m@xsang-OptiPlex-9020>
References: <202607151655.9d74999d-lkp@intel.com>
 <564105ec-acee-4178-be9f-077f783c1122@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <564105ec-acee-4178-be9f-077f783c1122@I-love.SAKURA.ne.jp>
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PH0PR11MB5832.namprd11.prod.outlook.com
 (2603:10b6:510:141::7)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5832:EE_|MW4PR11MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6e7a71-cff9-4236-4f69-08dee2fc28b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +X2Mco40xe/W51tqVL4D2Kuqd+TogfrEdY4MBFjKGY5J850wg75MO8mTcFDpT+Qhi10w+QLfnhJ8+vKmNagh7/jI3GNu2zJ+Yv+Y3JdeK0D9BcvCnh8vPGfBgRp4VajAfrHYUWmVt9wRUJ1M+xl/iVOocsUVV1tQqWdynnXaPTW1/SGK5ls5NIcV+oPbTzvjeUEYvcjRIe4vs5m1xB/n2tFK1T10u/KAaollSl+KxSBRIgyOYI8lrllqw3lbix0X/R/0mb9whcmiUzhMQ/VWi03RqdNI8NULjz26FbNfZBZirkUz9Tzbw6Mgq8eBHZm8I/UEmNucIPwPJevOodf6KVo4msziTprsAJbGz5jiALZoF7j9Ly49Gqaastw+QPmeG0oQAe1fc+EBiUwpXgIeBh+wLU08ZDGV6Uyg82tcWYaxRo94P498yCHLHphzojeBp/l5DVBu6XByjURILAKVnXPM658j30Hb2pNJJyK+7qLFxWcVAKJ8WQqFH8fbWke1nc/A8oFyptYX4BqR2qEEsmk6dYw6UDIvkhDrP1uOsAfHVPkpLMX88Uk9OUGsjX7Mc3M+R59SS2qhwJ+Vw8s0LIn2CY8CU1/75/PYuJIKXHhWwpUXXMqbyRXIZSn0hqxEYV9Xf/Wx7h+kCx3dQd1ueP4ex2BVvFRRqR2e5lS2cu8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5832.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tmn7B2A085iqJcnYaGWMXJYIRyfwOOpK3o+QpWuG3co/cwP655fH3CdUhWeb?=
 =?us-ascii?Q?9QcSQZrex8sSzKedqqGd7API2atzTBVfL6blIb0rUGSOfsSfVS8BhLCtJU60?=
 =?us-ascii?Q?zi8DHvF2eFec6ZeMiqS4uWgPpXeFTqMXmI6ePRn4x6VZgBc9yMt94N3bw6BM?=
 =?us-ascii?Q?zb7+6umRq+Ru/TLj5qxG+Zvi0Kmh1ppH9CiuUWSlKWk3FYwh7LLgqc2InZH4?=
 =?us-ascii?Q?+wJV/28DR6Ab3H+wPAkkE1ByAhVZBFKdGDq5fJJq+fugVsmwlNbkBSAF8Ms7?=
 =?us-ascii?Q?BMqlaX1yFB90aHBmKgF7Pdf0nCRPDtSc2GdIKSB1vCwaX2exMkocsrSwBDAi?=
 =?us-ascii?Q?CBziGndvsNyjUzwUSUX3Reym0MLMAVEnrmV+Bx0B3j3QTuE+m6yHuGjhqjiM?=
 =?us-ascii?Q?fSFNceuXyMba9EMjwGyvlG3LFnXeAnTORz1Mdhlq4fYwb0mlDXOIELebSyAx?=
 =?us-ascii?Q?bXjms2/DQ5BqPqNcxH6++F5Eebb+cdV05NVTYmp4koCoI8YM4F3YFoQhDYYV?=
 =?us-ascii?Q?gE+NuCmOvVqb5y90QiM5O7ho4TdBR4hDnxi1vUSBVUdfdks6fkWMHqI9aH0k?=
 =?us-ascii?Q?0yWcZ589vpcqOhE+br0B99bXaqNVUT7TcA/zhmdTrZu730om/XRQFAYzTQ/L?=
 =?us-ascii?Q?1NXbRefqs9oiQoKqx83R+OwvZwk8KhCmT/d+57GCcrsqyGHTZa6EGrPuwDds?=
 =?us-ascii?Q?0kwnpgnaGnw2AeYGkzXgfsq2VBAd+bsv9qGZmNz1/8EwuUMtCw0xS/WEglqs?=
 =?us-ascii?Q?Qg/vEUseik4f50cKTXX4z6vOrFEjKplMwuReTiHg0DZ1nki16/jVHBt0kFy0?=
 =?us-ascii?Q?+AB1a57C7tl6kopLtz8fQ8jxEDM10+c90uqOddN5Qyj+h3g474Mm/xHGNVvP?=
 =?us-ascii?Q?zM0fd7ANcWFWHycJ1H1/9VzoG3FJuZy16o0f+P+H2ztJ2jqasUf35Io36m4L?=
 =?us-ascii?Q?Kk5PjGKe8Qumm83k6gdGk9rdyXpiScvdUZOCOC1TGhngwGNpYk2AGNZO2Jvx?=
 =?us-ascii?Q?ue3pOadlq8RSQAzqRAeCTNfiUUJ6Gw6teAzUD1vWUzRlENodPyIAzA4H9ylE?=
 =?us-ascii?Q?Vji1BmrBoy7buuITX8IH09XQrL9uf546OkMSJRmKQ4BC9H1+Ed1SQlpqFndQ?=
 =?us-ascii?Q?aHRUJ8WsmeC75mmdNZ84yweNJ0ouU6EGxkFaf5s7gCX1vCxTr1a9ES8rRqZG?=
 =?us-ascii?Q?Tlo3DKtjPetkRpunTVTbps/rkOQKILSVDA9MimuXupuSepHVboIiQc9uZNpg?=
 =?us-ascii?Q?jWkyN/UM7usoyM6GMiYB7MacVe37a4XIc/GaiI4CzyIErRUXBXF41mMwSD/z?=
 =?us-ascii?Q?nAEfosbu8RAQERIJj1dTlkZ4XCV2RyFC7GJts2k5bXe4JM6jW9psBbYSVKWi?=
 =?us-ascii?Q?zfO8Gga7XYT+F5hW+/fAa5mnrF5+IMqc22bHQNDXtTdtqOYrWjgMM5jfbsDA?=
 =?us-ascii?Q?p/+pS7Do9HFhybYnI1Czm0w2txZmaPx14+LOyW+zIaVsKGmHhdMSr8JWy81d?=
 =?us-ascii?Q?5WdUf7T24aMinuN/AfzK5p7Z//ahmjG8/9yLhj0KdmaCH+JM1EmlNCsMNDoG?=
 =?us-ascii?Q?k9WiseR8eiL5DUnZ87aPXMRdvdr+ZyBauQd//tgvX7umfznY9/WNSaPQHt4+?=
 =?us-ascii?Q?A53meNcDQUg7kQQ1axG+uvUl2Cws+BBhKpDEBxjTOuZ2cp9+n1jzBBK4TJIS?=
 =?us-ascii?Q?ImGFZ/P9uEGgbi6TSj9PLTVlCU9c7XNHRRKzfBnnSO/zL6thTFyviLz+qS7f?=
 =?us-ascii?Q?c9i3Y9/Vkw=3D=3D?=
X-Exchange-RoutingPolicyChecked: Wz0CMqtwHh+2n4onj5cClsaBijbdinvFam1Vf5gVM3q8faneMZs8td6T2OG1Oh0ehWDVXe28olJ1wCROGs8qgYn5rkkMeA5FWQmZ5VoFSn74mj5XntxSWNGdAZ7zaSWxEY62MkMMPfNqI1zZG3EDGdgLQ5LDhHKUFtWR5YGlhS7aPaNm9jFT1TOTmiKA4Yly03KfQSjsV5QvY2hsHDawkwP9aNMXkibYrWfLSCZHDUyZh6kn2XNqpeBzsyg9MHeXTxItnXz+iSXI3Hd4QdjvXaUcQySsSVyKbVQl96bqQpnn1Hk9HfGlPYpsf7157vyBOEOzrDcycOdFgtQxD2tMwQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6e7a71-cff9-4236-4f69-08dee2fc28b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5832.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 05:36:17.8051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBWkXr2t29knmEv+JZm1ntOsNbhdwvx9P/E19EnZ5EcUv1elHvkCMkQAQ0HQdhHjYqGQ1n6JKRujAmRmbQKAyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7080
X-OriginatorOrg: intel.com

hi, Tetsuo Handa,

On Wed, Jul 15, 2026 at 11:25:38PM +0900, Tetsuo Handa wrote:
> On 2026/07/15 22:55, kernel test robot wrote:
> > 
> > hi, Tetsuo Handa,
> > 
> > this report is just FYI.
> > we understand d908729e74 is an experimental patch, and it seems there are lots
> > of print while running stress-ng.umount tests (one dmesg is attached)
> > 
> > [   59.370110][T10457] do_umount: task=stress-ng-umoun[10457] propagate_mount_busy()!=0
> > [   59.394831][T10476] do_umount: task=stress-ng-umoun[10476] propagate_mount_busy()!=0
> > [   59.404989][T10477] do_umount: task=stress-ng-umoun[10477] propagate_mount_busy()!=0
> > [   59.414578][T10473] do_umount: task=stress-ng-umoun[10473] propagate_mount_busy()!=0
> > [   59.423911][T10460] do_umount: task=stress-ng-umoun[10460] propagate_mount_busy()!=0
> > 
> > ....
> > 
> > 
> > so the very slow performance is expected?
> 
> Since printk() is a slow operation, stressing umount() operation that fail with -EBUSY
> can cause significantly slow performance. Can you try without fs/namespace.c changes?
> 

I saw v5 patch which removes fs/namespace.c changes.
we won't do manual tests upon it. instead, our bot would automatically bisect
and report if new version has any performance impacts. thanks
