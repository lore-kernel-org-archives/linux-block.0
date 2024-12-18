Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCBE189F37;
	Wed, 18 Dec 2024 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734511535; cv=fail; b=EUcKLYuxO1BCKDfa7etTSDoRxD0kRz5e5obmCkH6vREyeZl56tfqymsxa4BSLzSlcCCy/Xtrq5VklZ/S60iazmYTUxqqPN0cJGpYWEG5rWQyLvKaTrjb/6q1E+3rDwSd5PkX/eBf4n5ts7XVjiurPBHDgm98QcoI8eGLHXNFmVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734511535; c=relaxed/simple;
	bh=Y9XGjVSa8ShY6Nj70uDCffiJsbMMkcv5U7Hr0BdIR98=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TpvlSQhAvSshvf4L7FR6IDcuqGfNEAxYb5NZCzdRCethyTQ3zBqwUGqKyj1XUA3Jcna45qZh4kIvAvK4O6MZP7Iwz/FT1iNFdA5dqXvd+DiZfdyd9edj0mmsNTw/SWa8pZFxiqChqEKzXQfG5wSWbIZlRps8W1WI5aumguYvxRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRYPFh6V; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRYPFh6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734511533; x=1766047533;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y9XGjVSa8ShY6Nj70uDCffiJsbMMkcv5U7Hr0BdIR98=;
  b=LRYPFh6VUe8lU++nCMax3F6Wm0DgL7vt0Frer4Nnv+FTR+TWrdurKg5j
   K/+L3EW+zrba3iOmUilF1dtHXb7yvDMdp8uXE13VcsCaS7FKmAUofYS0r
   J1xzp1vRGpixMKa4DMphL4ePb8QnG5LINKlq44dwLE84IR+gz0uuPPG5/
   6CVxd+y16BNcEEhtcrPIjKzrmbHeiph9DRnn8BG6JC7hgwZESCl6O20DS
   66yWeeRklJN5IQHprym+83NMdFCdjPnbOY8anfxlGDqR63YGBnqaPQpHQ
   yYCkKhBLA65qXKqTwWJzKFhxxAVqRyn3Z0WelQJZHWbugypJr1mopuZSw
   g==;
X-CSE-ConnectionGUID: xqeJmUFaS3KaUzIuBsl2pw==
X-CSE-MsgGUID: PLeYMMvOQE60F51S84EQdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11289"; a="35130004"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35130004"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 00:45:26 -0800
X-CSE-ConnectionGUID: ACDrRiRkQg2o+KTjcF4rEA==
X-CSE-MsgGUID: 8vL3EJipTxC58SjAsGkT+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121059851"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Dec 2024 00:45:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 18 Dec 2024 00:45:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 18 Dec 2024 00:45:24 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 18 Dec 2024 00:45:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss9azRzuyZEdA6fRK90DlC4m0W1lvTt4/ZX4Xv8BDJNAqteCFfP0KNtW0QGxplv3E6gGAIOlJjoqN7XcM+g2u/K9vYCQj6tRMjfWgD2Y9Cb0+v6tEnfc9b4mhEDHvkOJNZ+xLk6xgR4tZo1juhcXNogVwyglvrX8InKstUjOIQcLWfPNaqTfpedX4ZttiVrRtp0qVlQdjgd69poyN3hwJ80NKxctqmTzZNdiPM6JyzZc1BEfhio2K4kZ7M8ERaDxmaVCWfXx9kjXTrY4urqwHKudIqqAUPifWgHhLSArwV0ZCzxuUfyADC9Yu3I+q5RWBy1nCE6hHTLKvs9L5l82JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+8js3i9qB3kvKLJGL8aTnrr8ciUTSlT7misRj/sCvg=;
 b=NskkuOQhjo34F4UrPGXbdkBwMjKNusipVC87sgdsZt1EjWXiITLphz1d+HQLWXnLoOkA6msqiIemFjKwg7fxZdC8ERDc5F1iYmpQheHhQWOk6o0ORumgutkny4zSlwJHZJWex0ZxwRiyhJRQ2Ivdpa1/5HfpwvLQjChZw4cgB4AKnDtdCr5zW08cuanJwDYsm3DDixLLCeau+swZ4H6MDjUZjGXmLdhHCMYS9YQXqHYSlzzOd2wYiKqjPKxYst4jfka6P+I9ehIJBSE++Wgxb170+A2zJTulHdI9WF8kgf/N3xBdGnxiB552anZG+aCnq0GLtkzAzHiadNHFPcwFXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by SA1PR11MB6567.namprd11.prod.outlook.com (2603:10b6:806:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Wed, 18 Dec
 2024 08:45:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 08:45:21 +0000
Date: Wed, 18 Dec 2024 16:45:11 +0800
From: Oliver Sang <oliver.sang@intel.com>
To: Ming Lei <ming.lei@redhat.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	Babu Moger <babu.moger@amd.com>, Luck Tony <tony.luck@intel.com>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [linus:master] [blk]  22465bbac5:
 BUG:KASAN:slab-use-after-free_in__cpuhp_state_add_instance_cpuslocked
Message-ID: <Z2KLl/lYpQsTPNpB@xsang-OptiPlex-9020>
References: <202412172217.b906db7c-lkp@intel.com>
 <Z2Is2Ee8Me8qRPR-@fedora>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z2Is2Ee8Me8qRPR-@fedora>
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|SA1PR11MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: f53f396e-2186-4a3b-c0ca-08dd1f404ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j+MpZmc0yp/ehVjT0nvx9Sev+ptMX5stNgKKNrmul8ymYALjcEBP6RSRThRE?=
 =?us-ascii?Q?IZqE6Kxc2L44bkroA9w442mlEDY2DBVbFGWAlNKQ9XG75C5CFo8co1OiRj9s?=
 =?us-ascii?Q?gpXTBns9vrNkigTKLG8mobBfuvgFJ05NW8SQWYKmQGFa6/i/qeUV1V/fNApf?=
 =?us-ascii?Q?FMPHwZAR05fyAMSmXbWi0R8NgNt3iDx1qCqXEILp2X696FUvO1lR2QvnLXrv?=
 =?us-ascii?Q?qzOsaoEjTp5MQF0feOOr+6NYFoywZ1KI6iU7tN/ob5rTc5An1xyhHN7p4P4z?=
 =?us-ascii?Q?pAbFIBNRRkcdwcGngIMMtX4usD/c8xvzEA8QKfW6qYildj8maUXOqpUj7njr?=
 =?us-ascii?Q?cf8ZX+UfIg+ONVyZe3ygnR27mGf2t5ehTKUoKrdsJRBmt64iaAkEncPL4lO9?=
 =?us-ascii?Q?V9DTAv1jwyZ6aiscQut1lOv1SH7dBRGsksNRlTicyRdWuu6gPlI0M0TGVKdq?=
 =?us-ascii?Q?SOa9GiuotbwkY34B94D9XJaDmQgDc2QJUd3VHM2Ua2SH9kSQhqszequCHzzS?=
 =?us-ascii?Q?20w5vTGgyUgjyGaBuC0XjgHChL4ti9/+WkPSbAhDiyoMtUlmDNY/B6FzO9Pa?=
 =?us-ascii?Q?iyIuiThTJHk+5g8lx2Jpn8th8TMPoj9y9pho9b+5AM10B7NSGqA84ymL83sq?=
 =?us-ascii?Q?UNCJye0Ujnmiuk5tKOFeAPZDIJ8cSFkfNyIV8QAA1XhcN0SJu9j/CA+uo1WH?=
 =?us-ascii?Q?9sHMBH/ludSoErGLVxM4KhH4b1C8FcNR+iZN/AjJR5odKy6rrtugFPlbkWCU?=
 =?us-ascii?Q?SAmsFWHozFP+Yl9iktt6ZuDL7yg7Mljnjc0LK8VChHh1OnLvN4tzeARvyL74?=
 =?us-ascii?Q?0CdggxANSX91w8NrUohzDgS+UhTTPe4RyUdzbHBMUIuwAIqNC7dr1lESLHHT?=
 =?us-ascii?Q?KuZdCvxnsVrCdMnJTmpTUQYl/dtnlsoqdzDtUQqUNK1ktakDRnD/TgHBPJ1+?=
 =?us-ascii?Q?7zvUEwmI043R7sbPDE67ghsvhl0hrMPTItbaNR4puZ0X78hkhOHA/CD/ZqTE?=
 =?us-ascii?Q?gW8YKypA1TYG06ecgIjO1XFsPlsigpV1HOmg96CSsODgdu/MhGxofzhc6k84?=
 =?us-ascii?Q?39SUfaF1hXLz0HBAfPQ//Q0bz4HDgv2Sus8JZ9mI4jIgxR2AQqOJIzH1Lc4W?=
 =?us-ascii?Q?1l9C+PYaNN2wcmwwi9cEUlaTBzqqcGZV3+6MQi58crRB3yY3P7R4fuGy/tNM?=
 =?us-ascii?Q?TRj3sOhbkr1MnN+e5uzQakLb71oKzhtT/YGSt0H7G9xSkFkZBDvVyuhmQdnW?=
 =?us-ascii?Q?v2pRTs2QIzRNJkIR/7OwaTTPO2q/Tb5KfBnvBc2Jj7zXVINLpGf9CMfFqJuE?=
 =?us-ascii?Q?26O6Kw1gTFUkq37ecjPP8/KPaHUHdUFYyNqbHIjOlIfP3vKL/zii0+8cmnBN?=
 =?us-ascii?Q?k5GfqBggpejjO381CIRykCjIYTmQI347ob+wsuoUNAKDJj0kgA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ut/EuTmQrojh8pILqmMtvrhiXRvMbnwvyirLXZy1hwZyutOstHCRfW6kmwuz?=
 =?us-ascii?Q?R5jf6XuH2FIsnkw7QGLP4SxPSYKrNTH4I/Kqo7jO++ZO0zW/he6qkvZDSqqt?=
 =?us-ascii?Q?x6PqROgVpN7rXunju8BySCzK9a1dTd4u6M4hATdYQBiHnpdmkS0exYUUmbml?=
 =?us-ascii?Q?ZFVnkcG+Khgyc1bHXC2zeZeW9/1R80KS6yWO+IqmIJptaM+JkLbmJm3N7XQR?=
 =?us-ascii?Q?DwuptvuYFsMGYgGja+YmsiksmqCEK8kvT/G3tk+m/NznEQHno26YHWHFYflr?=
 =?us-ascii?Q?EF37w6/a+CmhUJTPwxiRPvLtCG8IWMsFYRyisKc3eUSGxIt0VTT+AY7PXoSY?=
 =?us-ascii?Q?MDIifbkIU0V+Vwvc7BaMq68INkYun2YUrGs3cEFSMiOHldQoQsiQgR9sCCvz?=
 =?us-ascii?Q?meMmYsaUa6/2Ktsso8OV1IAd+LJ9F8sxdDnH6wsqrHvLR8KwFCPebY7lNBhP?=
 =?us-ascii?Q?g4UJJBXVZPlvVSaL5gF5p7zBNdvkzjF/tVsmub+1YqO5SdCS2oM6JW8uUIMb?=
 =?us-ascii?Q?b+alGkxwR6rjHG41U88QYO3YRh4+AchmWi9BYIG95Ic3M1hgfhimlwR3jBm+?=
 =?us-ascii?Q?lyan8MT4BfxVvBXhQ3jviz50cmbKh5mZfBr18NuUwFwdqZC+ArKXsTD2HRXB?=
 =?us-ascii?Q?YY4qFccamNTxhqDhvDHO1ndARrX+KbqGN4Bp9q8yDdoHSf7yXYAtC/jJOoXF?=
 =?us-ascii?Q?+zHEFqRfoIj3DxyywIWl4ykSJ8IPoLgsWLPDec5oCh4FVGAI4ndVruHUyl1D?=
 =?us-ascii?Q?NgrDnPpGT85ujLkOO4gTj9UjxvgqxeXMXfLXMd2nvheF5FvuoMCKs4pE/MwW?=
 =?us-ascii?Q?mifsbku9C+ryY3dtYjpawj//iDNrAJ7iT8l6IKuo1DI10IIv52mi5ACAmgxq?=
 =?us-ascii?Q?OSygPjxHyvGrCZUobBvmr+dHjh++681drDd6jZEPdJO6o9LWLhSHaofago+N?=
 =?us-ascii?Q?LgSX699zOD+fz/eXmMkmNhtW52ATzhJ4JbgnUlTbZWAm/SnugSaIguwWbt+B?=
 =?us-ascii?Q?0snr4aZMokObGaT7aCLfvndQanpsXcaZX1+rdV2KoRRB+eEgCI2PH07ET7RE?=
 =?us-ascii?Q?MXK6U406U5T4GEhYrawMbeeqHhfBiCQ8bvUWNNGhM0/OJx1Pxoov3mqa//Yf?=
 =?us-ascii?Q?3z7vV4BhxfSAlkvdCKgmmSPnXy5INeZJTCrqFlhaDAkARBcRrC5gDrU40EV6?=
 =?us-ascii?Q?mjgt0lhYyXFeIAJg22Mpc3M13wjocYiq1H+3Nqk6j93ZjVT1Djkuy4mmAW4t?=
 =?us-ascii?Q?zyRP2bp+DCu1qTvsZYbGNdwmp5k2ms3BuqI1U2pjuu9eq9gk1C+hpw9g8MA0?=
 =?us-ascii?Q?heeR9zLWQfm4GpEpmnm/CpJvCZ+YUeGDk8FPS+sf1hNH1Cq+yXMjxiXboEJ9?=
 =?us-ascii?Q?CsxuessMboi/EhADhlHd7OFAbhdJzxGPzZ4nn8LrFNdsPSDJTXzCJtU/0ppa?=
 =?us-ascii?Q?tk2em48gnf/K6v77ZLF6PpaI6r3j6RwlCyjocdkb7qB0ZXktV7igbHjcpXfh?=
 =?us-ascii?Q?v1Wt2hHPv9dB9bb/GwCjaNu0SMVmb6izrtWL1cJvL+kf34rwsR1u6wh9VZ0J?=
 =?us-ascii?Q?YbNwUi0VNmh6RhpGrok9bIiMFZJ8QIXzntYE/l7UZRnSkr8bDlaso7TXis+S?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f53f396e-2186-4a3b-c0ca-08dd1f404ea0
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 08:45:21.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qUpW+gZkEWNYmCaGRnCKP/ZCN0Vw4xEdR80Ij2JmqIPhPbs+d1aorknm0cwr5t1TCQbDWp/8BhQD+CdWpjH6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6567
X-OriginatorOrg: intel.com

hi, Ming,

On Wed, Dec 18, 2024 at 10:00:56AM +0800, Ming Lei wrote:
> On Tue, Dec 17, 2024 at 10:20:47PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed "BUG:KASAN:slab-use-after-free_in__cpuhp_state_add_instance_cpuslocked" on:
> > 
> > commit: 22465bbac53c821319089016f268a2437de9b00a ("blk-mq: move cpuhp callback registering out of q->sysfs_lock")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > 
> > [test failed on linus/master      231825b2e1ff6ba799c5eaf396d3ab2354e37c6b]
> > [test failed on linux-next/master 3e42dc9229c5950e84b1ed705f94ed75ed208228]
> > 
> > in testcase: blktests
> > version: blktests-x86_64-3617edd-1_20241105
> > with following parameters:
> > 
> > 	disk: 1SSD
> > 	test: block-group-01
> > 
> > 
> > 
> > config: x86_64-rhel-9.4-func
> > compiler: gcc-12
> > test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> > 
> > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > 
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > | Closes: https://lore.kernel.org/oe-lkp/202412172217.b906db7c-lkp@intel.com
> > 
> > 
> > [ 232.596698][ T3545] BUG: KASAN: slab-use-after-free in __cpuhp_state_add_instance_cpuslocked (include/linux/list.h:1026 kernel/cpu.c:2446)
> 
> Hello,
> 
> Thanks for the report!
> 
> Unfortunately I can't reproduce it in my test VM by running
> 'blktests block/030' with:
> 
> - two numa nodes
> - enable CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION
> 
> 
> But just figured out that one freed hctx still may stay in cpuhp cb list, can
> you test the following patch?

yes, your patch fixed the issue we reported, and 'blktests block/030' can pass
now. thanks!

Tested-by: kernel test robot <oliver.sang@intel.com>

BTW, the config built with the patch is same as for 22465bbac5 when we made
original report, so still with CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION.

> 
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 92e8ddf34575..f655b34efffe 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4421,7 +4421,8 @@ static struct blk_mq_hw_ctx *blk_mq_alloc_and_init_hctx(
>  	/* reuse dead hctx first */
>  	spin_lock(&q->unused_hctx_lock);
>  	list_for_each_entry(tmp, &q->unused_hctx_list, hctx_list) {
> -		if (tmp->numa_node == node) {
> +		if (tmp->numa_node == node &&
> +				hlist_unhashed(&tmp->cpuhp_online)) {
>  			hctx = tmp;
>  			break;
>  		}
> 
> 
> thanks,
> Ming
> 
