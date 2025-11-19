Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09BC2F49E3;
	Wed, 19 Nov 2025 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763535369; cv=fail; b=b6qwfMPAftzFVBkTEWo7YxsnPGd8iEu+cFw3dpK+I0HpMtnml1LuS/3IWssHZw2uBf3Cz/zyXfL2Q+PwGivNQa12iYJt1bVZbmicf6sXUX17DuG0nqmvorfd8THBHaS/Gm/PoLymVuwr07aRkbMwm9u8c04fHKsydRO5HNZ0KkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763535369; c=relaxed/simple;
	bh=vi0OzgQNO3tz9vQuUvY1v+HJzBAimGLv1iSXgEROtbs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T2mXh+a0IGY012MSMGbiPPrNw31OZXN3TXiQRtXTjMCGtZM07yLiNWh6aan+g/uaEQ5BB8vFrn7TLyL14GjHkjLz0860bnLL8r0djeppuPvDVqm2UwfCkpLmw3Tf5UKvIkheC6IT68QyPTRDprt2vxv8g+ckZyorgWe+MRUGlCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7q5i1Ne; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7q5i1Ne"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763535367; x=1795071367;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=vi0OzgQNO3tz9vQuUvY1v+HJzBAimGLv1iSXgEROtbs=;
  b=K7q5i1NehlX6+3xPImAGs2GOEUtiJgXdyzHTYse8a4RrtApaZJSTRI/E
   8y1SEJgPtAlIpKQdv4ugol4wqyPsygF0w83Vi9QoWC7hdtsEL+RMmiD1n
   EH43cf2HmUPnq0CuvWyXsU7xcfg/BI/DBqFuvE25i0hMWxfyE7YLPurfO
   EsgKg85C2rQkkOGzZoC6Sx20TK2MOPkDyESa7ZGqbX/QfZ6kyNVqrDlWK
   3znsAqFVN78J5ENGQKfOPe1fS2eExBACF3sAI6ctiKbwDbIIkY9sLbIUl
   4PHWUrUve3FwMGLZYV5HShKXEdW4tZ/42j9Xs8GKJUsV9xuUxEDwp94bt
   A==;
X-CSE-ConnectionGUID: A3SakeEQQgyTZWcXm2vm+w==
X-CSE-MsgGUID: 3Sn1eFJbSUyuq40FRRWN1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65603182"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="65603182"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 22:56:06 -0800
X-CSE-ConnectionGUID: hUAU/DB4Q0eIWm8WzvAW3g==
X-CSE-MsgGUID: CdrQCVTNSjWHB2juNUK46A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; 
   d="scan'208";a="190998428"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 22:56:06 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 22:56:05 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 22:56:05 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.37)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 22:56:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xo9E4wI8yR+o7scf+782+lEZkwKFdGkL93L7Ppjb1qBxbj1h++P3AHrCVxMWZemBQNCHfwptrMS3QWieBq3nExzoc9sWLQTk0u1Dw9G6NXOnbGQnQ8JcoAwWxPOv8l7b0D9e6gFMKwZaEHJBl6i8cvodCO5ex25/3f8+N14q+fzPoszlTGFJdjlbKfOfKEQP4V4w6MaCTyeYknsijeqdaZpM8YMC5zFelRYxd8rp4I9guWYeebdh0u/eYW0oWjPC6wNL1aokooOzUrYkX85ja471nvrE/wi12sZpK4POEQGuHaEgZvNGIyVgYrYtbOyvBRwBQpywYeHF3uoPeqMzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBhQ3KMbnlblpkCi360pr9neEJyAokqUQOwlw4KkQgk=;
 b=DkqxmIgIIecuLv6DaITU+MeWGertd8qb0yQ0kHYcGJeax/PHVS5/nELxq/MIUzvOGay3Y2rdWfg4gAebZFsuwjCuJ3lmdbrDYgnWQhAe+eOpX7dWzlc+49QfVn8hInsZ9hhhL8zZeZoawOzvQMoivamI2/Iu13Sk8xWmsDyNp2BU2vCDkaxqVJnHPiSwyMK83X2HD5/Z+LQACO6s6xWKD46xlnlA5r3B8TvhGHmsvhF4QhOqV9xg94idp3y/RKNArI1P4JsWynI/A++f9y41LRjp5LILAQ6L9HL4JytZ0OAY6od1MxjPGK6vRsXiqnQv2r06VYC14kR65BCWR/0ByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB8178.namprd11.prod.outlook.com (2603:10b6:8:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Wed, 19 Nov
 2025 06:56:03 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 06:56:03 +0000
Date: Wed, 19 Nov 2025 14:55:52 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Kuai <yukuai@fnnas.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-block@vger.kernel.org>,
	<axboe@kernel.dk>, <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
	<nilay@linux.ibm.com>, <ming.lei@redhat.com>, <yukuai@fnnas.com>,
	<oliver.sang@intel.com>
Subject: Re: [PATCH RESEND 2/5] blk-wbt: fix incorrect lock order for
 rq_qos_mutex and freeze queue
Message-ID: <202511191340.643afc3a-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251116041024.120500-3-yukuai@fnnas.com>
X-ClientProxiedBy: KUZPR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:34::19) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 0135e918-5d25-4836-128b-08de2738b470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AfMWjldoQ74+4eZQCGePd8i13bh6b882n9HmI7Nd9WZnaAGsSl/3GL8LcPW+?=
 =?us-ascii?Q?WA/ZCdAmwwsfhr9xbY1WkcqvWOgBwjbredurZ506gD1PRZaZpCZ2cFCUQIvN?=
 =?us-ascii?Q?31qH6EoHVx8UhBgMAj51h6pD7l33SWkepsYC1hB9bLcwNvTTM+WcFo/sJkZE?=
 =?us-ascii?Q?py7GeQtG+AsVS4sm/PFikwzyZLTFjLBmDVD4Zv25O8ma2EairPbXol7PvHI8?=
 =?us-ascii?Q?S+ndYMlOcFh+xYrVwXoG6IGGhwgOjjatDomC3Bb/RqsHZQA02/hoH/xhrm6a?=
 =?us-ascii?Q?jjbSavRxPZHorW4Y0XEAoOfNpLrRz+nSjrt32/fRHrHwitwn76B+Be0KtTjF?=
 =?us-ascii?Q?95nfXsJyzRUtCEdr0XcEnl9dR73IoeP7fv7wEPcjqxsBYCS3Q1KXPP2vv+0a?=
 =?us-ascii?Q?ENarFa9RGSVWCgzIGzl6M9fiddErHhyWhHBh+5etPBLBl+wiYuG1H/lL1bDY?=
 =?us-ascii?Q?3wSe+xxq+3/gUVe9iFVtSxqJ+/jEeMZ6qJGV7irBKFXL3eKGL8txFlI1I3+C?=
 =?us-ascii?Q?RmGTJEUx4PQjITVVYXVMHhx4exjxNYYn0fnS3cprYf7eL5K4uKLLUlXh3omm?=
 =?us-ascii?Q?27XzTc5EJVBHAwACuHeOeE1HZLUWgELbl6yqz8T5bBTXBqd4qORQ9rfvhMMM?=
 =?us-ascii?Q?t6nOajAYkuJGlbdn7vM1cLU3E2PufWkvmHNzss9av13fGVOY7lt1mMXhJoyl?=
 =?us-ascii?Q?we8MTgEFYIWvgcVj60psD8/QxYT8et6qpiBX2uwSzx9TNR4o4lhAjYW1dUaZ?=
 =?us-ascii?Q?MydT5YqBid7O1B8lkGGbUPyP/XfMPYbNQb1IwBUI5YFrgs/1qquStGF3Q0Gl?=
 =?us-ascii?Q?ZYoEfmSuymqF7TbOk/H/tNl/9hnrIyxM/r9Q70xdpp5KHfKpY1TdSW68MfqD?=
 =?us-ascii?Q?dtRuhM/SoADWaJ0EbemHiLy2DZSxan9wI4P8LNaRiBE89kRrHVV3dVXtDRXU?=
 =?us-ascii?Q?X65iAuM+UfMXlpIG5ngx5+yFmc0VFGRQGQf+FXUQrY+ZspjsAekP2Mv2z7bh?=
 =?us-ascii?Q?d2Vs2Fbh0eJ3orU97l7zAhq5auvXxyrwo7pPnXt3TA8ccKdeQw0/wUN4iIiu?=
 =?us-ascii?Q?V/j9Mkp5lCHJ6fcwo4k4MmDJtQ8g0fRTp3n74lhvQJ4NzjlY6X4iBX0RQIpq?=
 =?us-ascii?Q?n4rZ+sfkLkKpxskczyxcxsa0vsdCx0doipVeXjgmDJ6pDCqLKs0crffmdeZz?=
 =?us-ascii?Q?WfnybV9Qlkxu9GOzOJLY28NU1DgAblDHLx+SdbbbfhTRvaHgecMQznzH7r3g?=
 =?us-ascii?Q?XrzatabSZ+vgDZqfMJrSk7Q3qYbmZrbm9poONbcX9WOwp9ZqzHgHQc/9NdMC?=
 =?us-ascii?Q?UHvqujNzG60tDvZpFEylOHjb2YIHAQ1agFe91vI2bziVdXQOs5rID3rhIrmd?=
 =?us-ascii?Q?QUCQSNA00/7eCF5uPWiM+V6tIoio/3zYSXnR1d79gu+PZkmjhFhCq3TX+M0r?=
 =?us-ascii?Q?CMnfZdaFYwQnKC7pqoMoQcHQ8wemG+8S59H0U7YxBruxmyCXpxNN0Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eyr4bq/9HA+Xl+7cvNjzW2wWqmmmiHbPzmrz+9PCnFd6rjUJ+RXrTuzMgExb?=
 =?us-ascii?Q?VXRnDmpFOrE5vxzPvAhEou1f2b7b5ilyKTOjUq79wyLXqBwvSljTVMt2/1R8?=
 =?us-ascii?Q?TgJE1pqfdI2XuXKYvg4HuRrUGeX5dCx6RYYX1gMJ80P3ugOBJrLhEZz0oNg6?=
 =?us-ascii?Q?iZjdJJEgdmzemX+dlk5mJ2MMOISwXPurLxP0ufehnYtGPf+CR82LKGWJuW58?=
 =?us-ascii?Q?EDH2qUVa9EWc5VQ6WQR6ekxOSpFLRmWS0yojwiw+kE8AA+c0HfSV86i16/eN?=
 =?us-ascii?Q?OIOPO8LKAqUTta9gTslLuEfuybKdAWOPKnB381BNSyGAu54XmUut6bSjd6ne?=
 =?us-ascii?Q?wsy34dBhGxAk21i0soyE8ifR3X0G+LTa4dhay+SjzyOhCwsbIIsintx5cn2z?=
 =?us-ascii?Q?lajgyGgtZb0PVceY6ilIRMvjCpwqkbpb4gsvJhEL0gh95TZQ8PqPx9ZE4uTj?=
 =?us-ascii?Q?0LbCrNLSMDa5XUJ/iHg1LZ2sZ4mdbVCaZsIqDpBrWFA7DlYgjZS2JwC6OKtB?=
 =?us-ascii?Q?+jA02/cpkvzSHMyw0BJRnArDbb3Bitawm/xSGwbEKhA2LAJLxqQsquoVFJUl?=
 =?us-ascii?Q?aA+Kl+QJlM6XPBOQrIv9zHlf6c+nlvteL9F3KYETiVhch9y3WQbQh6AphEeJ?=
 =?us-ascii?Q?m9JPIzvYDWO5ve68lY+Hq5RRjqVy8AolEDQx48r3nqeIDxXUVEX+I18he91W?=
 =?us-ascii?Q?jOKPTZDKsNu4J4JQAjgm3uJuIuq32om+nekkeSJbmPHv9UHynVz3mm8Zqnxl?=
 =?us-ascii?Q?EVENPpFE9cNiIWydgaiFT2S0kVnLhbIhNkICvhDxinFdqg2HJ2A+TIcLYwLx?=
 =?us-ascii?Q?/8rghkYLAAKqAt1evVVEuzKvHBJg2tjS70N32MSN0H3CwQANfIRiaiKBo3kj?=
 =?us-ascii?Q?LAW2srvbH0zTpXLHB+1vhhS72G9Z47ag+djhKMk/VP5zi3StI4GMvteVGeH4?=
 =?us-ascii?Q?u/DwK2nWeWy71tIkd70Hh4/C5uEGvUp346L2/Zi16uc86xsneUBUgv2ODUou?=
 =?us-ascii?Q?6/Y4TWXjqFsRhkQ5JSQ8SqaQ2r0n7mofVFRqn+fpl9sc6GPU/9VvpkJpXT3j?=
 =?us-ascii?Q?DCfHYHbCIiw45exURmPCdRcJf0cGXPIJ0024AIbnrZwlPY7F9BgABhR12ZT9?=
 =?us-ascii?Q?qTOOyUTW7MkhGG4MzT4psdu+22dA0MZluE+6gAYq+gAaNB6gGdM9e7H0G/4Z?=
 =?us-ascii?Q?OhbQEMi6P1RxhgBrr8aaGTnTydUKQ/0LYx69LlFaFjGlb9geyQOt6U41HlJu?=
 =?us-ascii?Q?0LrhsaEu0qhSKvTWfqsHHDAEtt1HIX0fqG/5YCA1NI8ZB6D+x8osu88zcCiU?=
 =?us-ascii?Q?6TuYYXns35cuATg4H6Ynf9uzVdjOtWBQNW97rjnsAzkE3eYq1Oz3abewgOL3?=
 =?us-ascii?Q?xLe6UofR8l7J5kRlieFvO/szAteFXjuZKD4DFX5U+V1SYpVbcSFEbvA5QTEi?=
 =?us-ascii?Q?mhMrg7CzjFyVnmdk78Jp3udY40qI5RmMEERf5Z3B5y0ScctV+gTF+4oXWeG6?=
 =?us-ascii?Q?lPnZ+cyqo1kR6E0j61W06hM/u+6vvJ6gVo8ZUiqr10drFZStfI8JOWVbXKvG?=
 =?us-ascii?Q?k2oSH7wk5mtULEblCu0BfHWoZJa0vNL5C9MR3nrF2epuKeSFQZgYGJkqJocb?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0135e918-5d25-4836-128b-08de2738b470
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 06:56:03.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gR9OPltKXYdRHNtXFhgZUA9BmS/VXLkFQ1/GW+1LPHOGSpHaz+BFq3V11AuaG8FOOQY05S79YIuCdbwgyTjtaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8178
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:possible_circular_locking_dependency_detected" on:

commit: 9b76049c7ab17a3352a58ee216f444769e216c5c ("[PATCH RESEND 2/5] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue")
url: https://github.com/intel-lab-lkp/linux/commits/Yu-Kuai/block-blk-rq-qos-add-a-new-helper-rq_qos_add_freezed/20251116-121353
base: https://git.kernel.org/cgit/linux/kernel/git/axboe/linux.git for-next
patch link: https://lore.kernel.org/all/20251116041024.120500-3-yukuai@fnnas.com/
patch subject: [PATCH RESEND 2/5] blk-wbt: fix incorrect lock order for rq_qos_mutex and freeze queue

in testcase: boot

config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 32G

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202511191340.643afc3a-lkp@intel.com


[   36.217408][  T108] WARNING: possible circular locking dependency detected
[   36.218277][  T108] 6.18.0-rc5-00238-g9b76049c7ab1 #1 Not tainted
[   36.219067][  T108] ------------------------------------------------------
[   36.219956][  T108] udevd/108 is trying to acquire lock:
[   36.220622][  T108] ffff88813b4b6a40 (&q->debugfs_mutex){+.+.}-{4:4}, at: rq_qos_add_freezed (block/blk-rq-qos.c:345)
[   36.221938][  T108]
[   36.221938][  T108] but task is already holding lock:
[   36.222851][  T108] ffff88813b4b63e0 (&q->rq_qos_mutex){+.+.}-{4:4}, at: wbt_init (block/blk-wbt.c:929)
[   36.223964][  T108]
[   36.223964][  T108] which lock already depends on the new lock.
[   36.223964][  T108]
[   36.225282][  T108]
[   36.225282][  T108] the existing dependency chain (in reverse order) is:
[   36.226380][  T108]
[   36.226380][  T108] -> #4 (&q->rq_qos_mutex){+.+.}-{4:4}:
[   36.228833][  T108]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
[   36.230959][  T108]        lock_acquire (include/linux/preempt.h:471 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   36.233086][  T108]        __mutex_lock (arch/x86/include/asm/jump_label.h:36 include/trace/events/lock.h:95 kernel/locking/mutex.c:600 kernel/locking/mutex.c:760)
[   36.234852][  T108]        wbt_init (block/blk-wbt.c:929)
[   36.236509][  T108]        wbt_enable_default (include/linux/blk-mq.h:960 block/blk-wbt.c:731)
[   36.238663][  T108]        blk_register_queue (block/blk-sysfs.c:948)
[   36.240650][  T108]        __add_disk (block/genhd.c:528)
[   36.242626][  T108]        add_disk_fwnode (block/genhd.c:598)
[   36.244660][  T108] sr_probe (drivers/scsi/sr.c:703) sr_mod
[   36.246799][  T108]        really_probe (drivers/base/dd.c:581 drivers/base/dd.c:659)
[   36.248845][  T108]        __driver_probe_device (drivers/base/dd.c:801)
[   36.250799][  T108]        driver_probe_device (drivers/base/dd.c:831)
[   36.252778][  T108]        __driver_attach (drivers/base/dd.c:1218)
[   36.254752][  T108]        bus_for_each_dev (drivers/base/bus.c:369)
[   36.256776][  T108]        bus_add_driver (drivers/base/bus.c:678)
[   36.258650][  T108]        driver_register (drivers/base/driver.c:249)
[   36.261124][  T108] init_sr (drivers/scsi/sr.c:152) sr_mod
[   36.262938][  T108]        do_one_initcall (init/main.c:1283)
[   36.264802][  T108]        do_init_module (kernel/module/main.c:3039)
[   36.266560][  T108]        load_module (kernel/module/main.c:3509)
[   36.268367][  T108]        init_module_from_file (kernel/module/main.c:3701)
[   36.270150][  T108]        idempotent_init_module (kernel/module/main.c:3713)
[   36.272050][  T108]        __x64_sys_finit_module (include/linux/file.h:62 (discriminator 1) include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3736 (discriminator 1) kernel/module/main.c:3723 (discriminator 1) kernel/module/main.c:3723 (discriminator 1))
[   36.273921][  T108]        do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[   36.275672][  T108]        entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   36.277584][  T108]
[   36.277584][  T108] -> #3 (&q->q_usage_counter(io)){++++}-{0:0}:
[   36.280765][  T108]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
[   36.282560][  T108]        lock_acquire (include/linux/preempt.h:471 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   36.284435][  T108]        blk_alloc_queue (block/blk-core.c:462 (discriminator 1))
[   36.286153][  T108]        blk_mq_alloc_queue (block/blk-mq.c:4405)
[   36.287937][  T108]        scsi_alloc_sdev (drivers/scsi/scsi_scan.c:339)
[   36.289536][  T108]        scsi_probe_and_add_lun (drivers/scsi/scsi_scan.c:1211)
[   36.291280][  T108]        __scsi_add_device (drivers/scsi/scsi_scan.c:1625)
[   36.292952][  T108] ata_scsi_scan_host (drivers/ata/libata-scsi.c:4577 (discriminator 1)) libata
[   36.295269][  T108]        async_run_entry_fn (arch/x86/include/asm/jump_label.h:36 kernel/async.c:131)
[   36.297162][  T108]        process_one_work (arch/x86/include/asm/jump_label.h:36 include/trace/events/workqueue.h:110 kernel/workqueue.c:3268)
[   36.299000][  T108]        worker_thread (kernel/workqueue.c:3340 (discriminator 2) kernel/workqueue.c:3427 (discriminator 2))
[   36.300695][  T108]        kthread (kernel/kthread.c:463)
[   36.302155][  T108]        ret_from_fork (arch/x86/kernel/process.c:164)
[   36.303743][  T108]        ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
[   36.305346][  T108]
[   36.305346][  T108] -> #2 (fs_reclaim){+.+.}-{0:0}:
[   36.307985][  T108]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
[   36.309621][  T108]        lock_acquire (include/linux/preempt.h:471 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   36.311256][  T108]        fs_reclaim_acquire (mm/page_alloc.c:4270 mm/page_alloc.c:4283)
[   36.312913][  T108]        kmem_cache_alloc_lru_noprof (include/linux/sched/mm.h:319 mm/slub.c:4925 mm/slub.c:5260 mm/slub.c:5303)
[   36.314550][  T108]        __d_alloc (fs/dcache.c:1692)
[   36.316022][  T108]        d_alloc_parallel (fs/dcache.c:2549)
[   36.317503][  T108]        __lookup_slow (fs/namei.c:1801)
[   36.319003][  T108]        simple_start_creating (fs/libfs.c:2304 (discriminator 1))
[   36.320529][  T108]        debugfs_start_creating+0x4f/0xe0
[   36.322219][  T108]        debugfs_create_dir (fs/debugfs/inode.c:374 (discriminator 1) fs/debugfs/inode.c:581 (discriminator 1))
[   36.323776][  T108]        pinctrl_init (drivers/pinctrl/core.c:2028 (discriminator 1) drivers/pinctrl/core.c:2420 (discriminator 1))
[   36.325323][  T108]        do_one_initcall (init/main.c:1283)
[   36.326866][  T108]        do_initcalls (init/main.c:1344 (discriminator 3) init/main.c:1361 (discriminator 3))
[   36.328322][  T108]        kernel_init_freeable (init/main.c:1597)
[   36.329944][  T108]        kernel_init (init/main.c:1485)
[   36.331399][  T108]        ret_from_fork (arch/x86/kernel/process.c:164)
[   36.332850][  T108]        ret_from_fork_asm (arch/x86/entry/entry_64.S:255)
[   36.334399][  T108]
[   36.334399][  T108] -> #1 (&sb->s_type->i_mutex_key#3){+.+.}-{4:4}:
[   36.337887][  T108]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
[   36.339409][  T108]        lock_acquire (include/linux/preempt.h:471 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   36.341061][  T108]        down_write (arch/x86/include/asm/preempt.h:80 (discriminator 10) kernel/locking/rwsem.c:1315 (discriminator 10) kernel/locking/rwsem.c:1326 (discriminator 10) kernel/locking/rwsem.c:1591 (discriminator 10))
[   36.342598][  T108]        simple_start_creating (fs/libfs.c:2299)
[   36.344192][  T108]        debugfs_start_creating+0x4f/0xe0
[   36.345959][  T108]        debugfs_create_dir (fs/debugfs/inode.c:374 (discriminator 1) fs/debugfs/inode.c:581 (discriminator 1))
[   36.347535][  T108]        blk_register_queue (block/blk-sysfs.c:928 (discriminator 1))
[   36.349145][  T108]        __add_disk (block/genhd.c:528)
[   36.350605][  T108]        add_disk_fwnode (block/genhd.c:598)
[   36.352129][  T108] sr_probe (drivers/scsi/sr.c:703) sr_mod
[   36.353727][  T108]        really_probe (drivers/base/dd.c:581 drivers/base/dd.c:659)
[   36.355225][  T108]        __driver_probe_device (drivers/base/dd.c:801)
[   36.356818][  T108]        driver_probe_device (drivers/base/dd.c:831)
[   36.358406][  T108]        __driver_attach (drivers/base/dd.c:1218)
[   36.359984][  T108]        bus_for_each_dev (drivers/base/bus.c:369)
[   36.361462][  T108]        bus_add_driver (drivers/base/bus.c:678)
[   36.362950][  T108]        driver_register (drivers/base/driver.c:249)
[   36.364384][  T108] init_sr (drivers/scsi/sr.c:152) sr_mod
[   36.365900][  T108]        do_one_initcall (init/main.c:1283)
[   36.367417][  T108]        do_init_module (kernel/module/main.c:3039)
[   36.368926][  T108]        load_module (kernel/module/main.c:3509)
[   36.370434][  T108]        init_module_from_file (kernel/module/main.c:3701)
[   36.372090][  T108]        idempotent_init_module (kernel/module/main.c:3713)
[   36.373729][  T108]        __x64_sys_finit_module (include/linux/file.h:62 (discriminator 1) include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3736 (discriminator 1) kernel/module/main.c:3723 (discriminator 1) kernel/module/main.c:3723 (discriminator 1))
[   36.375279][  T108]        do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[   36.376796][  T108]        entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   36.378301][  T108]
[   36.378301][  T108] -> #0 (&q->debugfs_mutex){+.+.}-{4:4}:
[   36.381043][  T108]        check_prev_add (kernel/locking/lockdep.c:3166 (discriminator 2))
[   36.382551][  T108]        validate_chain (kernel/locking/lockdep.c:3285 kernel/locking/lockdep.c:3908)
[   36.384101][  T108]        __lock_acquire (kernel/locking/lockdep.c:5237 (discriminator 1))
[   36.385608][  T108]        lock_acquire (include/linux/preempt.h:471 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) include/trace/events/lock.h:24 (discriminator 2) kernel/locking/lockdep.c:5831 (discriminator 2))
[   36.387119][  T108]        __mutex_lock (arch/x86/include/asm/jump_label.h:36 include/trace/events/lock.h:95 kernel/locking/mutex.c:600 kernel/locking/mutex.c:760)
[   36.388585][  T108]        rq_qos_add_freezed (block/blk-rq-qos.c:345)
[   36.390240][  T108]        wbt_init (block/blk-wbt.c:930)
[   36.391782][  T108]        wbt_enable_default (include/linux/blk-mq.h:960 block/blk-wbt.c:731)
[   36.393333][  T108]        blk_register_queue (block/blk-sysfs.c:948)
[   36.394867][  T108]        __add_disk (block/genhd.c:528)
[   36.396410][  T108]        add_disk_fwnode (block/genhd.c:598)
[   36.398009][  T108] sr_probe (drivers/scsi/sr.c:703) sr_mod
[   36.399514][  T108]        really_probe (drivers/base/dd.c:581 drivers/base/dd.c:659)
[   36.401035][  T108]        __driver_probe_device (drivers/base/dd.c:801)
[   36.402511][  T108]        driver_probe_device (drivers/base/dd.c:831)
[   36.403990][  T108]        __driver_attach (drivers/base/dd.c:1218)
[   36.405471][  T108]        bus_for_each_dev (drivers/base/bus.c:369)
[   36.407062][  T108]        bus_add_driver (drivers/base/bus.c:678)
[   36.408549][  T108]        driver_register (drivers/base/driver.c:249)
[   36.410081][  T108] init_sr (drivers/scsi/sr.c:152) sr_mod
[   36.411625][  T108]        do_one_initcall (init/main.c:1283)
[   36.413166][  T108]        do_init_module (kernel/module/main.c:3039)
[   36.414682][  T108]        load_module (kernel/module/main.c:3509)
[   36.416196][  T108]        init_module_from_file (kernel/module/main.c:3701)
[   36.417822][  T108]        idempotent_init_module (kernel/module/main.c:3713)
[   36.419453][  T108]        __x64_sys_finit_module (include/linux/file.h:62 (discriminator 1) include/linux/file.h:83 (discriminator 1) kernel/module/main.c:3736 (discriminator 1) kernel/module/main.c:3723 (discriminator 1) kernel/module/main.c:3723 (discriminator 1))
[   36.421144][  T108]        do_syscall_64 (arch/x86/entry/syscall_64.c:63 (discriminator 1) arch/x86/entry/syscall_64.c:94 (discriminator 1))
[   36.422741][  T108]        entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
[   36.424468][  T108]
[   36.424468][  T108] other info that might help us debug this:
[   36.424468][  T108]
[   36.428405][  T108] Chain exists of:
[   36.428405][  T108]   &q->debugfs_mutex --> &q->q_usage_counter(io) --> &q->rq_qos_mutex
[   36.428405][  T108]
[   36.432967][  T108]  Possible unsafe locking scenario:
[   36.432967][  T108]
[   36.435485][  T108]        CPU0                    CPU1
[   36.437074][  T108]        ----                    ----
[   36.438592][  T108]   lock(&q->rq_qos_mutex);
[   36.440094][  T108]                                lock(&q->q_usage_counter(io));
[   36.441920][  T108]                                lock(&q->rq_qos_mutex);
[   36.443715][  T108]   lock(&q->debugfs_mutex);
[   36.445174][  T108]
[   36.445174][  T108]  *** DEADLOCK ***
[   36.445174][  T108]
[   36.448803][  T108] 6 locks held by udevd/108:


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251119/202511191340.643afc3a-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

