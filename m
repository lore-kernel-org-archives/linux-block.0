Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE61AA7A6;
	Fri, 13 Feb 2026 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770950345; cv=fail; b=JPl5yNnCLjJFVy6jtzA17njM9g0SMCcbpqXqIMPIHqvDPBbgREpTzhL4agqjjRvZzhMSFjHRtxzsoMoVajnlD9W1RbgDH213YLAdbp+O3M64wjYA+NMMXC3xMFB5Pi5QkPzmyn7LlRNzHTeMX2v+XKD3MTA4doXUFPnu8wO3YEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770950345; c=relaxed/simple;
	bh=T8KK69MOtLpM0Pba/crjwR6DUeeX0oejMnHucqYfi1o=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=Go8/3Usb/MeojLWNGBssd2/D1PBnYVYRgqBiWp/hB+i1jKqJBhRxDsXMe8Tzan1WCLNTEHz/nA2V8xxBi3NifeB+G9dPT/jCOIPZILQchRtczFyo5azVPLquL17GHaFm+elHX0A0oclDs7o0jVDKFQUcEik69EAHtMv5fg/gX6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fD2qTOd/; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fD2qTOd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770950345; x=1802486345;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T8KK69MOtLpM0Pba/crjwR6DUeeX0oejMnHucqYfi1o=;
  b=fD2qTOd/xt9xn7P7s6peDkVqepS+yOnk04ro/ZvDISRpTe1vNFaY0gRX
   ITmci6COClrDlRgDYh696cY/zIorONCSfV+eI88DTWVTR0cnWSFXSa6HX
   eV9Jf71sExvNnz39NUqI8rNvD7tJIcBfZBcW7jSJwBOnfb6bLpu3FzNfY
   EsmlNQfGSsmtcxWUq1nKmr6pEgyDvLvxqUZoGJ/bkN4Qo4yj17MOqBtwU
   c6g3DDuzfUETg4WWGYXNOTUWYpBqNLpNEov8fHf1Psm+HM+/rVhgUr6CZ
   aeWuiMCPHYPxJHqA2xtt3iYrTfDp57SHldx9On2pqJnicakCFMtVWfFuw
   w==;
X-CSE-ConnectionGUID: h1QxmKhiR+imAwPhNcWimw==
X-CSE-MsgGUID: y6GNtc9zR4CZa2yCm8cJGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89722130"
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="89722130"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 18:39:04 -0800
X-CSE-ConnectionGUID: QbrV7a/0RrGGLoJaIuXirQ==
X-CSE-MsgGUID: ssMCKdTbQCSpAynVHl0ZpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,287,1763452800"; 
   d="scan'208";a="211538974"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2026 18:39:04 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 18:39:03 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Thu, 12 Feb 2026 18:39:03 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Thu, 12 Feb 2026 18:39:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6dyc4AbcKZ7yboUvO88d5to2p4BG9vLC9CaD7N2G2JXHDj9ILwMZonXJldjr4UrOG9ESW+7v+fSHfmA2vSzMdK7PL8EWKaCq356bvaMArvxxopEzTlHN/WVyLYewGrNBhkwaCek65EzBhYgsRSlh/fYdOp9QH6zBFkF17EbxkBrgucfDY2PG0mx3pYrssPMvmteyHI54ab4EZlIoX5NpNk+7LqJ1oUxwTDegOex0Ghw+ecw8DBWJFF0tNYBcGr9ZGmk8PKxvZ/eOJ8umQ37bxXMY/wZle5jhyReyWzSy+LAPZKOPeQRVa08Wa1ez5IrB7O00SOzKfhV4J29h0tlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LuQODAl/D/98EW/SyN08pkPUCoJpraAkCb/NRcwJHC8=;
 b=BhmULe7Tuy2Ul8YwAcNsxC1QkV8Dx7WzB6xq6fgIR9QYHjCKqQk7fcz2DOA1kYUeeMBzK9SgyDv9XK4a4ZhfA8+7fcHVcH5sJ3DypESrB7ut7ptHUjZIRdUbAV4pIncyb7n/8sXkXE1vf5tp4o3kxKWBsWcaegD8ij59KCBOWscvp1zbPKXkvdHa7R4Lwz32B3dMu86Kt5NMJxCSJXOMZpVB+y29Vz2CqctBTkO+V1yaUdk1JIzKApta6kdLNW+o5hoP5qt28Z8h2wWcCxq4viZY7omEiW8iPaUltFu/W3hml1Sb4q7Spala0Zeg0ug4UVgF3P4eZlQngNdxdjHXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Fri, 13 Feb
 2026 02:38:55 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::e4de:b1d:5557:7257%5]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 02:38:55 +0000
Date: Fri, 13 Feb 2026 10:38:48 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yu Kuai <yukuai@fnnas.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Nilay Shroff <nilay@linux.ibm.com>, Ming Lei
	<ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
	<linux-block@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [blk]  65d466b629: blktests.nvme/022.device.fail
Message-ID: <202602131044.6e7fc152-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: s-nail v14.9.25
X-ClientProxiedBy: TP0P295CA0017.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH7PR11MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: fc728137-73b3-4c90-2f58-08de6aa90864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+uhBGlhiykxkAx9gNOe/0C8XcoRhhpJnMr6g+sr9rd8ln6IfdvcMaJsCAdRD?=
 =?us-ascii?Q?EwHYUIVtkiGZFaWG6DhXnTIO9H4yvmGqQ4oT4S0KtAmt9MIkpfsUAP2sZmCt?=
 =?us-ascii?Q?8NpDm5esVsVLGOU3hxLK7fqa2WS6AKTeQYpNRoOJycrErKKXmYZ8aUctaVgf?=
 =?us-ascii?Q?MlUyapGB1XrpuxKqmzrNkEtBKINSf8ma6lHz1+g+lPueYJ87AojQ9PZLhKqc?=
 =?us-ascii?Q?6YxQnxxxKEEP4avkiSqpNXpCurRiG9kLJNscKxtUTLQyIWxK6/x0lVvWaP2p?=
 =?us-ascii?Q?mS2iAnfUCliuzmXTUjtnG5E90HrhRoHUI/JRMvICBZlhwMeULQ9RFuT1kd+p?=
 =?us-ascii?Q?VRrritGmAN16bIhUn6u0w976B50eo5PVXzUfNwHPRmMV3iED5Z4T2oqA3AGa?=
 =?us-ascii?Q?gZ67EpskHH//8S1qJK9aHMGdYu74baqzCnsnVKqfHwO3v80lzCsDVbNamP5+?=
 =?us-ascii?Q?tULK+BvcGEpxeNy4T4w9dF9Gy0ljcCKgzVQVZM2Z9MaEUXdd2nt0UgmmkH8R?=
 =?us-ascii?Q?k2lyo82XJnH+FE9cVb9lUJE8Xonx0xy7M7CxSjyUDBKvhyLsDBDghZZoig/L?=
 =?us-ascii?Q?Zm81vviYXvY23m1Yi5SF5GyL83gTvlRXLtt4e7Sz+WZwwtluP01zu9HUDYUI?=
 =?us-ascii?Q?i3kHbZmw9DO0HXER0PK0Ktpy/TVfP5opnFRxlZe/stg2kGXt+TwLzEQmqi3p?=
 =?us-ascii?Q?QHmE1ZZa1xhxL6Iz87QorxG2bkxa6HsPQ125UcWRRhF3cAKH17qP7b6wVZm0?=
 =?us-ascii?Q?JkjhalzQQDuzCyXgx2+wysNKXw6v+6ymd4HXGx1KhlkDWmR3mok0tnhNPHXU?=
 =?us-ascii?Q?ESVT+Slh5sMC90TonPZMK1NmEuCkkAYqhSpyLodtKFA9aC6VYYcyGizCOGXM?=
 =?us-ascii?Q?uA4e8BahX0DFeLgw1yfHfQTtNYH0q+zsNayV3IudzMX3xfyqxvaIKoR/lA3y?=
 =?us-ascii?Q?HcQfc5BCvlo47Ea2xJLRb7psT/rnXvLmiNKEd2mSaoctLZTgNg8drbs0Bj05?=
 =?us-ascii?Q?WGcfiODWmcGLXRG2PmO2DcfT2NfhnxEtyO67NRaU80uJg0h8L36GrEtcfEeZ?=
 =?us-ascii?Q?HIRlI1YoOJ3SFPC1Vr6mPEP76KhVb8+38FGtXOgCycFE6I3CR0PHn1VhaS6+?=
 =?us-ascii?Q?6RNheI4Kx1wLwG1G68frIhY856offec5xbuMNSMqALstTBkJAX+UhR1lThVc?=
 =?us-ascii?Q?guOkt0XuqHklpRp+0uAwOKmETnWMwQkZmdkgjdX7x5VwJOhzeWTSicePjMA6?=
 =?us-ascii?Q?HdheOKmnxJI4KdJ4bKz5PYNItZBlS9pzFcBtRzLGJDW0rd/3jwHjjlrnshNP?=
 =?us-ascii?Q?fwSzo3B9GhrOj1SliCVI1QUaASqZpH5zuV5wZoym+SFKFEzcYwpzxn4hTnO0?=
 =?us-ascii?Q?cp1ndRz5/aotFum9nCgoZ8It2s/xTYmHX4mIV59eX/MyBObJil0C5zLP23Kc?=
 =?us-ascii?Q?Yi4TOa9QgAZzao4jLP9p003BRXGdgFFNkn8VF7yVN8e8N4+mjKCrQ/3QPJQo?=
 =?us-ascii?Q?8oA86TqrGRG4xzCOCqv0GdgjEr53EVz6GaEo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WghUVdMltOv3Hdy8d02YuiMhC04OD2l4CGHyy98/ZzaHrRHq/TecwA0V6H45?=
 =?us-ascii?Q?QITKC8qbBwnIAIJ/hdX1YOCWcoib5i7MQZofkaawXyIUcUkzR2Hh/aeUudO1?=
 =?us-ascii?Q?gmkw08BtbyfZvEcksJT8XfYoHaMxIbBTq6Urz5cjStok9raZeUqBKgzqva2J?=
 =?us-ascii?Q?i0x27KEAtsUw9S8BLrNHo1wgJtKqrFs6A7LLTi5t0n3BO81NNsq8yXoNyyyv?=
 =?us-ascii?Q?KX9tUJ+4WmsNPZAXcAeqsvZxuUBYoKIzTg4QI0c4UC8ngf54Kxo0ON0KZano?=
 =?us-ascii?Q?reDHLDcqwcg0+bEjd0UrF4QNY7k6+IxxUcxamdc+fR/s5lhPPlXqMdm/v34b?=
 =?us-ascii?Q?Z5cvYar71xydZzkvR+yT4MmQkPkjcGS6JnWOwcF7yP4PIeUdafeMaWGPqZkx?=
 =?us-ascii?Q?gDyBCZOg6WTvO5hzoMASK6rx+a13zQFIRVwRCWCGIGjC5Iiz/RolRXywx1uz?=
 =?us-ascii?Q?7EnNysRWkkWoA/oGxv5pR0/bzoeAC7WmW+ZIC9ws1rMjf4ZUGALzQS+NVaUe?=
 =?us-ascii?Q?oLGIv4q9NBe5TuUnjHIVgPZMUgNyH/RX9Jzs/T1R3OTu/SCAVxH7ET3zqbaf?=
 =?us-ascii?Q?SFqddVNmXkxgKmEFeY5O3Nt9GovvuRC6BIK/CSap/L/fEztke3sJhNRyo8Ja?=
 =?us-ascii?Q?tcc3Ybo6YTODZxokmJGsBt/LcHPxnA2VZQjSF3OyQZHNtO9Nieqpr16eLSaR?=
 =?us-ascii?Q?1tNNvyr3AGbj2+YlKkSTZyAIUxY1mTuC7foqfBAL+o09L6X1qbeEKo55fjt/?=
 =?us-ascii?Q?/DyFkUoUW5C/xFOkdLNDY79rhEoXfIsPlo8V3YxszcHhvZFFxXWRZ2Di96EM?=
 =?us-ascii?Q?k+cc7UJTEJiHG7dmfpb3V5lzK9ixZ5LcMfaq2lWE16nni3fO0Fml6nuKol9P?=
 =?us-ascii?Q?aE/JAY3Cg0ApdQYftOlFjO0PHDL7RVhAqPcL/witFkRxe89kMb1k2bE2pbC7?=
 =?us-ascii?Q?oa/R7qiRvpcXPi0SdvReT3YRyFsLbkY8iNGI8pb34hoH08sCsMqdyPomGQOA?=
 =?us-ascii?Q?iJaVpO7/YOQiGYrQt9oC8DbnN0/dXGxLBwz+5b3deou990o/HjuHlaE3tZ6C?=
 =?us-ascii?Q?u50jIVBeShWrwR9cvwPVfoLqvwF4VwgJt2aWsuXd+UB9VkPz9Ar50u0W50Sg?=
 =?us-ascii?Q?5GzSGid/4nmZxFg2Au+RD+r6ZZJk1KSpJAXeaAxtMmt01495XM+I2hERaC7U?=
 =?us-ascii?Q?8YnDNPcqrdqMF5/4vQR4FIuDe0ZuW4DFbXOlFjgAiozp7LsbBRG5OEzMHKnE?=
 =?us-ascii?Q?moRrlOJpD8gd6nVs4cz1S65A7wM9wfGw8hmxVEmJC6wDUa/yi8AU4d4MJ+CW?=
 =?us-ascii?Q?RoKI1yOymWUupYY47DnC6ZGMlU9ECZaUDj5mvLeE8UHGDd2BVPVaMNsl2VgI?=
 =?us-ascii?Q?J2qUWUk9u0FWVGv7dlDAk1TeCgFwGbaiJoXDhQhD2sENqCT/Buw8ihrxu1R7?=
 =?us-ascii?Q?A11nGrtKyIecqbofekgzEHQheB2HYNH1a/DaeuyququNAP8mVCfbFckXKwTI?=
 =?us-ascii?Q?K24MFG7kv2/PGm4vyIo+00zAu0IbEngD/j+pvFfCfE6EnQCxmquLEw33AfI7?=
 =?us-ascii?Q?/WBLe7rTN+2zcafvRlHhOpyD4VdU84SEqWx6lD5sJT0Lc0wNERfl7anwVS4f?=
 =?us-ascii?Q?6HXvo2A30ZsUn+bT4bH1FW+El2iuXZnWZzUIHeNr+4H5ngYJ8ZNqZ4wtywo3?=
 =?us-ascii?Q?rHny8oBMcUPkNF/QGca2FRf7u4kVdwO/bIvinrXxDEXxULgZySve57YHZfUL?=
 =?us-ascii?Q?hYrRg1us9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc728137-73b3-4c90-2f58-08de6aa90864
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 02:38:55.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr/DcUEkbPOscXjvtIOYKBASxLDVAHDG63L1EhpOUM3hQ8m+jJKnEbSTPzgyvz5CL7KtnmsMivO1lHP5bAvvIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "blktests.nvme/022.device.fail" on:

commit: 65d466b6298470ce21ab21ebfdb51309d515737d ("blk-mq-debugfs: warn about possible deadlock")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      37a93dd5c49b5fda807fd204edf2547c3493319c]
[test failed on linux-next/master af98e93c5c39e6d0b87b42f0a32dd3066f795718]

in testcase: blktests
version: blktests-x86_64-a94b770-1_20260205
with following parameters:

	disk: 1SSD
	test: nvme-group-01
	nvme_trtype: rdma



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480+ (Sapphire Rapids) with 256G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202602131044.6e7fc152-lkp@intel.com


nvme/022 (tr=rdma bd=device) (test NVMe reset command)      
nvme/022 (tr=rdma bd=device) (test NVMe reset command)       [failed]
    runtime    ...  2.750s
    something found in dmesg:
    [  166.159293] [   T4405] run blktests nvme/022 at 2026-02-12 07:46:06
    [  166.210905] [   T4580] loop0: detected capacity change from 0 to 2097152
    [  166.225648] [   T4584] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
    [  166.242028] [   T4589] nvmet_rdma: enabling port 0 (192.168.3.121:4420)
    [  166.290336] [   T4189] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
    [  166.317649] [   T4596] nvme nvme2: creating 128 I/O queues.
    [  166.802940] [   T4596] nvme nvme2: mapped 128/0/0 default/read/poll queues.
    [  166.878331] [   T4596] nvme nvme2: new ctrl: NQN "blktests-subsystem-1", addr 192.168.3.121:4420, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
    [  166.971637] [   T4632] nvme nvme2: resetting controller
    [  167.242104] [   T1026] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
    ...
    (See '/mnt/nvme-group-01/nodev_tr_rdma_bd_device/nvme/022.dmesg' for the entire message)



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260213/202602131044.6e7fc152-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

