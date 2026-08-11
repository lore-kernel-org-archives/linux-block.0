Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7893D3603F8
	for <linux-block@vger.kernel.org>; Tue, 11 Aug 2026 11:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448914; cv=fail; b=bYMsg03TK/GxGyMJPycARx68nS038Gvy4CVTR11aq9Xe3vGFKq2o9NKvMWL0Fc5I5XcjMMyIHpQwMVPXXWg9dEr0E2xgTQ9tO/y2AMlemU3WxOPwLp6tG1+bWH6wUupVc/dZHtPQScgrxRq5H+yskH4AxioXTdQRbdsENgKTWdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448914; c=relaxed/simple;
	bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oRsFmlKZkzWCLsX0kfvsF0me9lDkC9KlnjPOUEMRSK9vUrUqsQZnAMl8MeFb3wzj8dsM0cmq6kgeP52glcmzcG+f4gHM2D+AvkwLyQd2LKDOOKoHNClYimzoQnndHeVKFitJAgvMB65CBFvBMrBnvY7q1MdhBehDUdL4zB4lstc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=r7x/ohxw; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=njWUdini; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r7x/ohxw";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="njWUdini"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1786448913; x=1817984913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
  b=r7x/ohxwdiDfWGHA5hQ0teOau6YuJDlaUayedqNAduRPU6u3LW/w+MKp
   wD1GYV+ZTVs6I/Zh9LozNEyQH5BrhiGn5cBDMUQcJQ5XeMGx/L9t/k2Sc
   e1hfE9pebXN0JY58+44Y9HEwzAKhPejppfHUXD1msv2IP21AA+kLQjhAF
   G8VmBfirO8aZmAkssqmT4VtJVFFypx+yIhw1vV1QsHQ6wnXuxw/hqMHgG
   3Fw/GoiXYyq4gl/pquhNL7AHrXufCWyWLGbewUr7AyOPB2WDB+hDOp0CJ
   skvwvv/J0qIjo93aMULt7HJFSt+0mUQXTuh71zn0tsKqTw+WZWMkbUcGA
   A==;
X-CSE-ConnectionGUID: MIsXM4VDRciFm/LMOks+og==
X-CSE-MsgGUID: 5RTVZKcCQ6aF3XRxhMYaxQ==
X-IronPort-AV: E=Sophos;i="6.25,217,1779120000"; 
   d="scan'208";a="151965890"
Received: from mail-westus3azon11012035.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.35])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Aug 2026 19:48:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fdxdkrHoS3zPxOiJQ49sxlIdUBUVFG74p9GcCCleKNerOobCzNzYXVSZGAt99llFupuxg4+oni3herpG8Bq2/zKNfMZUkc9gW3TkWEf8sYavRKHkFCkSjEv1e4StFvcDdZMhrPMjDeZ//MeLnpFn4X0+qW4aq3OOP1fItv5JgCyMYR41fkWAuxkKI1/esoJC8cfBFEVCZEr5BlwXb9YGAaTyEdd6LIrqWnMKISnkDY9F7y+zs1hFObT2ySaR4SGWFONTJ/9YbWiTM1Lmt1RgmwQnBzdjlXhNFQIf6exSqePMl5/l4NeY5YnXyM8AGjOyFBl/Ksm3IlkVAHhRmf356w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
 b=mVKtvbVcJm/YAL3mdk3nvrnQEor4peSwyDGe4wSW2BK/E9kNvkf/6QjCenb4hsP16sJmmH+drrYT53sUTdCQ//ytsOOKiHZhLxlHTbmpZNNzffCkDHCB/CC+4oXao0CrB8F1yc1uK9sTQ8/0h56jBID1QDGHTyiirb48qO0xk5PuY19eAqtFs5OJWnr76WP0rVryy/K05Udrid4BicMESKRd+B38q83aYC+e6renX9wDnIKmIeUpKRsGl9pyObPKIM3Snn3xz8LqaSwB4ts8mdsMo59b6TKy6yHH6nMaRRE7cj9eRo/s2fJwAWv9pXHZRm2FihYoWdHyQDo9YcRPQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1UF7RGtB1Pbog0NUMV8tDJBLwjc+mTRVhKiphrplxs=;
 b=njWUdiniSUA61XlTVYeyeC78Y5zDfaDLFx9lC/cMAiAPxyF2bbs4XgFV6FpyWrXznApyT5UJTSXS3OkYPcmKVYvqjSQG5uYwWK4OlqZbnwcTiEa6T00S8DlH7Uvv64X6S2IEN5M0EOBVco25WLJfloDitFhHSvhOujSZUiIfJOs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by DM8PR04MB8200.namprd04.prod.outlook.com (2603:10b6:8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.12; Tue, 11 Aug 2026 11:48:31 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 11:48:31 +0000
Date: Tue, 11 Aug 2026 13:48:26 +0200
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 03/13] block: refactor disk_update_zone_resources()
Message-ID: <ansL8WirkccNKHrp@mayhem.fritz.box>
References: <20260811105852.1245357-1-dlemoal@kernel.org>
 <20260811105852.1245357-4-dlemoal@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811105852.1245357-4-dlemoal@kernel.org>
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|DM8PR04MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c358ee1-2723-4fea-b8a1-08def79e7728
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|19092799006|376014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	YgLDhGjruiW8H3i+t0eraFkfaj9SIkzysxFgNMrekGtUcYRlrUHfS7uJ+B3B0VK/Un1Vy5DfM3deDDD7YeYie4VP3VwNR263GYfcS3XYp0HTGEz+y3ZyyIbCgFl7eG81JYmUs81lwCgPytvF1dXoljVeeYgPhzf0P8d2megSaA56R3Icjlg50MmbhDrF77m/ay8QtZrvi2VEV0yBPNiCAkwXAXCk7ekfYNhOGiczA46ZU4RLLKA0NGQsRImyK2yc5bdl1BIl6bvjLnF0O5Hg6YCPJlR+pgXAnXP0ft/bRpKdhgUZpSpl/Fqj3ARF6jvJ1mOEcbpx+WFTItqqCVQu7PVAS4x6275ZAPvfmxD3iyPWAxl32OVp6+OxmK87FpnuNQlus4vJr/KlRyEKfJyZsnL5bsXVBmv2KWuHWkiJ1dz36uDAF1qygCT1T2QLcQ6qcv1c9kp4tpo+uGj12MeCP3QDW9XOkQH8yRX93ktQTuD5XIbCHJbjEUZBTIBZvok4TgxKJuMfdxNdJmxnkv5tBYLvrl9UzKz17o5rtnyVSQacvso2W/Ugsd0E2P5FwmUHJ0eSj1x7byof/TtHVTLClqDK5QOcdoAd/KgOY/BDwEPDSlM+4ksFtk+mfGxiAqAgfgBxzM5VZCsZACcHGcPtavGHf/g05LDTfoPoe4WymHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR04MB9447.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qfbh4hzAYCOo0C6YqtHrpJUkTMKAyiySW/CRNB9sLpWhtLylAU4iA/W7kv4t?=
 =?us-ascii?Q?oMOCOhlwai+iBunmQJHtPm9uNu+2xAXO6GHHCZczHdZKhdDZgzQJJXo0WG3f?=
 =?us-ascii?Q?IAr8IyCKpKKf7xBahw4nRhl65VVQS+wUcpIXnC6D0q9FWcSDsUMfKZcVtDSz?=
 =?us-ascii?Q?y6BvhSzK9tvulbBNTPQrrKYXUtgCvHD4HLyGh0Xuawgb6sNyFRy0enQJc1tN?=
 =?us-ascii?Q?05qyZa71jG8xWgO9fnVxBsVYp47Rqrpy/AG2t9bmgfN7bj3bCnPt/UPBrS3p?=
 =?us-ascii?Q?75Tm3BXUOWoUe7o8GfSnsD0l5CWXr2+asO2r2QTpOlS7e8hYl/tlpebM0gxD?=
 =?us-ascii?Q?YZbCoKXVUs1WGfBWQfeTJyAl6S9sPEwoSWeSxCJZ5OUIJaHD0qBcELVECGOK?=
 =?us-ascii?Q?5akleoGtXYM4gUxqamksH0r2M8hqvQjtc33Ktwx0HsZNqKzJ7fUlemYI4rlS?=
 =?us-ascii?Q?0ww6WnNkJ3+iXFLthyzioQseQ36DX2WW1kUisRpOJ/4IrYSjVnEY8G4+vPMS?=
 =?us-ascii?Q?yVgta/e8v3CqMyfgdERWspHd2n6yl1Xa+FyZ0CHiM01Eb1hKt6Yu6RaghvIi?=
 =?us-ascii?Q?oFcMhb/mWruNl8zJec2xlVWr3HWmdoBplQ/cbKdV6rIiNVsuBScNuFTi6Uls?=
 =?us-ascii?Q?Ov99iFJ4jrCjHCht/edILCOTKjhCZqd0yrbVlQtlbSlcVlpAwyrtsCovBTTA?=
 =?us-ascii?Q?h4ZrGMvi8eP6ESKqxTXLcEFD051pSLRXDA5asU4FOC/ppNWcFdvYexceZp6y?=
 =?us-ascii?Q?pLM2TVAmE1s1izGNceW1ulk3wKOfQX3oFTisKDHInHHMneHgrQ7Ght6kDSv8?=
 =?us-ascii?Q?b59VSpPqweJ/xBGVqX0eNngCZc2Licxi/0v7zBPw1cKRLgRmh63vX5c6qx3o?=
 =?us-ascii?Q?5WxBU4tVkMKQvcjech2+PY0sspjOgHBpPl5hXRFNAnilI+F5IJUX/L8C9eUF?=
 =?us-ascii?Q?P05lA8vLqUGPyb/3Y5Lk8VGGWWGMjbzNeq3Amy9bs8pfVjxhge6hMeBqoUbY?=
 =?us-ascii?Q?x+2VrOIrHwunKkJnFMOaqFuTazyKfv5gHccZyxSOi5dOrjbjq1VPJrKakOtd?=
 =?us-ascii?Q?zgD7DEax6/Mp+gK/BPTbx3XOWZ3WIDzirn7s2Cps22R9+inC6+Qe/l+ejwBY?=
 =?us-ascii?Q?9a27Z2pZCixsZ2Zjtt+Qldh12ZeJ9dOAQJABy0nkAnFNtNRm506fai+pYDqO?=
 =?us-ascii?Q?eMbsbyW1HH1KwvWKG5mbm3ifsLn8VmyyBFdF/cqR6ZZv7my6u/IDx8CvIimY?=
 =?us-ascii?Q?HKJC7Nk5CVDi3Vs6FhJHKDAseqJXFuAsZ9Me28sfVAj4Fk5NI3lAYX/DLNOD?=
 =?us-ascii?Q?4Hy9197776+dtn5yZ8hmchVi+Mmq2RAyGuYbV6aFB/nr71e9t3cEwye5OF0Y?=
 =?us-ascii?Q?vVZrcvpVck+C6kQW9z5FYL4zolRuq/w5jWBbXbI0RSMib+jd++pb5EWPwqve?=
 =?us-ascii?Q?VKZqTh3MtFb1+N6Eiq7pyFGkz08fNpdX9GIC92trqwiIKqR7uSORA3t5xoUX?=
 =?us-ascii?Q?eC5kujRbqP6dwRxtbuqJ9ckBagPOkOT1eF7sqqzTzT4JZF/HsBEH0EMz4Gcz?=
 =?us-ascii?Q?gnpflAtpTjSZQ+nhYZ1LU5Zv44ouhRgqmxlm1xR48VvTG71W1ibVyuOj5i0s?=
 =?us-ascii?Q?rtrYiZQQQGBKqU3EwhaBDZy0bcRs4N1/GGf3BWQFZZNl849nnbdtzy0m4reF?=
 =?us-ascii?Q?oQhKwMKmIp5X6+lFn3SkLQIm3hAHSwReH2pLPOCmldMsYIi+IBMRvESH09ZR?=
 =?us-ascii?Q?SiREE3fq+AkbyzPwE8ytsTtdxJScDDDtzS8VrdEXoVKW0tNx/P5oLacIkItf?=
X-MS-Exchange-AntiSpam-MessageData-1: vJV1lECmmPMqhhGr4b08llFtqyZvlcYC74E=
X-Exchange-RoutingPolicyChecked:
	pyHS1KhA9GrwjTv75kKJOXCBauf0VAyGBQZQGz+XH3bxYm7UYQtUnf0iSKCyuf81GFpbheVybXE0+JJ/7LQaRPT/YTIVo/REmCZv8cL+nJWKTLdwngLBGvkf+uPcQFIgDyK5fI/IlX5/vOweH9rUBduZG8lkNkcTjMrI1tXcAv16P0X6IpaWuMpZR55iQnKzotrs6HE1rnN9t0/1pOFYk0bOpWwO3k19V7IZXxA3Jrd8woz9hjKRNO6YZASNPuoclC2paEJnpqWKr1qt7Nd/67udsZgAY5eYJUfLwej3PTzZgb9l1uqxv3oYixpGnqkrBKmWht8eec3UHdND3sXwuA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FMUoDssyk0Pm6sswFMFh1grutE7jtTkW7qBFUvE8Da5B8gEcxkyU4wScdyOP9EkuqThkxbbRnXQA2QpdYL8QVBnl8vvAn9xazdmZVXz3DzWNS8rCZLmPqGVPgEazVIe907EKXSpKaehQwIcrIFe7wWtB2gRU8cxkZ3oEe+8ZjMwmr30yytbDAljJ0g8WCdW7X/2NLYjmuV+QHrP1j+jim3rSMzy7f8GzjH1k2xQjg/zm4bmriKkh63/H/IbjJz7xoVBL3W349u43UDbBovXGm0+APISxSVEuVRb5rF30wy4kLAIoiOQSPpElvx/5iIo3pggW1VMZfolBZFFIW/EBMdDnTl9idtPRLcZSaoG3LhWybnUSvEyD5r+fOAg/jYoqm6XCRzQVbil2ph1xYSwEsWnopKlginFBmNJMJG4DDxi7yYUKdyLDtERsPOO21z1SZcoWgM9Yv/gEKmAikCcFwMj009ArpTukvQePLzDhP0kDKIJtIBpORm4erEhc98SCDqGcKGuaX7glo1v1ApHa8D5AK1erFBjKXFIgFoN8xgEsLKiImhsKq1bPbRnQrOMX77c+WF2rollKey0Uu4NSdQY7ihhgSuOP5BxepMdDl8RA+DEcFkOzqt9dFFLIO1cW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c358ee1-2723-4fea-b8a1-08def79e7728
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:48:30.9976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYb5dRxk6hpeSLvVEhoj9S346w4x9vK0cJjp04KFg8BEE/Yd2Bn7Og58oySFQk8FUKMLOYeXDa+LSWEYKFibJW9AVpcsRDs5SLiWFZ6WC7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8200

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
