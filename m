Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9177F1607A4
	for <linux-block@vger.kernel.org>; Thu,  9 Jul 2026 03:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783567359; cv=fail; b=Gy0LSdxp/XGcuxMtAzH1M4pSE9ZZxKSe5n55Jk7Ra8MA0Bcy6utP56uMTqhMCz3h346ES6XtPxBfneC4JvEcf6OkXawBJka99S0FbSaKsFtRSNgA5tidr8DDAH4bNIRa20VT/kmZ48bCY/8OjuPOiOB6iX5XoAYQeV5XCG3EywA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783567359; c=relaxed/simple;
	bh=8o9ds4WP1scDK34rP0FgZ5aH0hJH9gFpbIWlLvwYrU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KWuWEkNoO1LWZLmjn8Xmv5ylBLXfbxm+n55ldb/mJ59NO1OX4DPeLU2X81MY0Fq+QOIqPi95qndGKJju2JN56HvT7JPYsV08sC2GXtSE2DufiNOlEgSx+kGQmMVlxzsDdP8oWolcbQb5l7rkzpf/qDFuLib3sMvcXaLpKjjYmYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pxroWB0q; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=pSQnT9fS; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pxroWB0q";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pSQnT9fS"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1783567360; x=1815103360;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=8o9ds4WP1scDK34rP0FgZ5aH0hJH9gFpbIWlLvwYrU4=;
  b=pxroWB0q2VpsrTpECqaq9YoWeY0xJfpHnqVGN5Xkfk/mbYcpzyaynarT
   GBxB6SAnjLlap8T1z12TV7mdRhk0SU1+WMGB1sTpjrfHjr+0fTyPQFus9
   HwL49GTK9l3Pc+BVcnwy4biwSf13xNDRewV+MWhTRVLWKvzXNbYqoUcAk
   FO/Udb8YNMHPjhz2ubiiWlTqVe46tFpoLTYKLHrgsP2Xo3qqD9JMfpTKZ
   CDmgrr/rjw+xJRhJJBgAR6za3sDTNbe0RiReWSMsiC0teHaFtw8KzkF/k
   hpvsVDULLCbZseWgY7A1y/LsaDfRr4tqwxKZXlDwtwLfK5nJL6xrOqMbI
   g==;
X-CSE-ConnectionGUID: baBJ+YS5Q5OcUJNnyvAe/Q==
X-CSE-MsgGUID: UFq5dpYJTBG8msghcEjELg==
X-IronPort-AV: E=Sophos;i="6.25,154,1779120000"; 
   d="scan'208";a="150370762"
Received: from mail-eastusazon11011001.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.1])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Jul 2026 11:22:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3YOyGW6xgt9pr5+IkFosXK0sSBAqipNesW65+cYCttXaoLgsS/T5LR0bqisfIzZe05cY1E8Zd58Q8rzWT3xlRe+BLV/tKuJFnc5kMTP5xrNJ8UKmt8Tw4GPejomE8Z6fYV/elMmY38L+taYPaSX3Q2EJwiixqmjiAzWd02A4LIYsapa00+QhOTKw9dQ9OI2axq8ZBCV8Ft0MZaIoja/OO2xm8XBytVHwyD1pp99iciD0E1fFaVi5rxVkPoJt+oRcidZ8to/oglvUeji2sFF+tVZJDrPh0nhpg3WLW2d3B51nyaZnsWimxqJMPnOJfa+KUpN5IbFU4LAmugWGV6iXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smaKjvGtVH9BdLMRlgk4lUNMyYyl6Fhnw5AkQQ0/nxE=;
 b=N4JOi3XOuBsQBy9XAPu3+KSBxTEL7yatcbNy2jpruMVXu7/5z4shDnqeQ7XyEc0+AC/gbCZ9u0vLgRGcYOHnuHeNiAjT+588Di65ajQsXFycDCl9RJ+7LyKHpKNDIw2noZdQK/3bDcP+hYoT+C4gStobiR+v45+n4pko7MmtJFgCvGC10CBDhgOMnuiJuHhJbhd65u97xHBXbwiv1gf0VEEGfMZY0cD7iVCM8Yg84yUa9hYrqp/ky2Uzv9DBgibI0OFZrbwjOaLhZXX69BlmnON39GesccAaBNEXMsYLBUwRirem6CP55xUWskcrlIaVmwzy4Lagi5Z/LPDCUmdV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smaKjvGtVH9BdLMRlgk4lUNMyYyl6Fhnw5AkQQ0/nxE=;
 b=pSQnT9fSDYqepJcfHquGZZWRDbasUdCnNHGO7SrjLRfPEFVXZokBfRv6JcGJIkt1isxHev23/Uak6Ib6xsmgb02gC9/e5izrWBh9XmcWn/OuCnbyylFcktsM010tBy49+Ze12rWlD6LmVi455LfhZskyYQpUu3HexKfcN2CSV+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by PH0PR04MB7239.namprd04.prod.outlook.com
 (2603:10b6:510:16::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 03:22:29 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 03:22:29 +0000
Date: Thu, 9 Jul 2026 12:22:23 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvme/039: drain udev events before passthru
 error injection
Message-ID: <ak8TufOGNYahqRs2@shinmob>
References: <20260630101936.2371-1-mateusz.nowicki@posteo.net>
 <e3bce895-51e5-424e-8e86-8f5f295a9ae1@oracle.com>
 <befb1709-62d1-4a76-b9a1-26b57886a95e@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <befb1709-62d1-4a76-b9a1-26b57886a95e@oracle.com>
X-ClientProxiedBy: TYCP286CA0175.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::14) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|PH0PR04MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5f1071-bbc0-40ff-0c25-08dedd694e51
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	84QfzbIQDK2/DVxeJAK5v7tUwQrzgxyEKRvc0hpxqkpNFC4pLDuXxQLc7PjwmkyGhqGs8hSbrZAzKUAGS67LevTF1V+eX33HjwI5yb7NxnwRhBisLgxDWVnRLkww617U0szzoyhmPcfJv67DsRfjDJvHNr1mXAb6chYO5nSbepzQt9luv8+sRcBHYU/r6A9NkxpwbikFjNwaYnVcFRLFqNf6IVM2siTqM+O9AM6HSVuqYZc0KizARpe6gXZsIj6nW7K+p7DA5he9J4ax9aPWpo1fWNDvUmw07lZwifje0vOUDbC5JK6dCvO8Vq4IuDRk6NgO1iREdpZXWx/ygUV8Ws0vT+Erw6wcqJvs08bWD5Ij/+/PoNvjdc96eBw5p4b3fvBZ4HHfLIjZqZYGnV/EIOPUFpebgpQA+0Y4GXXi4eKKnyywqUg+oYLvyV22dhlF5hEtkreaqcwg+Ha40/OA24xuS/1+8ZjNCjypLVOfAmyxpNaYTAC0rEylG+jOvGGHE1ZK462sAFRyzrYpHoFbRu15OZQgooOyErVMOzk/9lg+F9kSDnyz0aH+AWh7z6d9O/m+U+G/3MiQxsYqNeEXyAGIBxW+PH+CLhfHlRTPYBpEgze+CvixZhRbdvTbcVxiblZYSYyy35swBpaY0vP/aoSYZuQxxrAAnA7qs80LxCc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0tjN4PMMufgjby2p9YImfH2loGpUzScx/miPBxp5JKQLvjaCfVlYNhZOvIIh?=
 =?us-ascii?Q?HvSGSNWcIf5yWltgbFYITK+fmY1EsbJJe2lMmjiDKl+ZzeVZOf2rvfq+JDZK?=
 =?us-ascii?Q?YD7VdkICqwWN8gLggi9zuXqAVQ7F6HUI8jZc3sl850dBzLBYiK7n66qWVBCE?=
 =?us-ascii?Q?f3JWGJVSZ+ZvK9IVmkof0cTXd1XA7l3M6Xje6pebhM8j7VECJ1wQlPJSnmTq?=
 =?us-ascii?Q?UIN4ZfU2K6ldocWAD3dbAQ43OKSjOmxC0t0b6ZWQdOzjGd0EyCRwfuSGM8mg?=
 =?us-ascii?Q?3Rt3EHycoDe3aDG3qpTeTdJ+TqKSuSOl38ZXet89o6tuZEJF/wL83XUtd8BT?=
 =?us-ascii?Q?aUJMJkph9Z2NRKsMkr5BEUsmLgwrbskqujOqdfbdYXYLE1tZ0gaHIQGEo5ka?=
 =?us-ascii?Q?AApFGR3X41uW8fjpGFbOwBrUxPrD7u7LlAHhuahDZmRo3VXzl81SV/g6/Hb+?=
 =?us-ascii?Q?jJUMvk50Liduu9ncmry05WGTwNC95bYWre9Pm5R82I+b8hV6VF30INfO4AhE?=
 =?us-ascii?Q?tQieOMs2l4zQe0wOHENYJh7229BxxsiYqPZEf26apa+m1wdyY3fJSFihuyiP?=
 =?us-ascii?Q?LH+Evz+hGmhzMupHiFVryCo2JiV8191Gutpj/Rqalfk/o5nUQCcsrVfyLYwt?=
 =?us-ascii?Q?uwWDq0ggdORQhT2/V+asjUvyuImXp+HjN1f28OkWSYN5emAbrgk0kHO87iNB?=
 =?us-ascii?Q?1UUtNZFKpw3Zu8OEZyqfVLasKTa22RfrWs+wpzMT3h4N4B1DKRjyPv3bwp6g?=
 =?us-ascii?Q?11RZ7ZzcQH2dY3mmohN/SPD3AQgS7XMAL8eumrnbQV9amSOtOFfDiCxX3y6B?=
 =?us-ascii?Q?ejfwUTz0UqRh4//jsXyh/lLWFfOMZcmMhp7nGENGiaPWc7Jm3QZ01DxOGP/v?=
 =?us-ascii?Q?N38QoIUUIXPNs1UilI+GRC+8JPPnlBrbzNVXm0LZLDN5G1v2e8FNVoN3f32Q?=
 =?us-ascii?Q?QvUbReTQUiQzUYtNTlSez9tI64FlwnGhRIHMxgg3EGwpz6yxJu9b54M4oZMG?=
 =?us-ascii?Q?OG0mGOoX1k5BXW3AKcYgfG6Zix4gpyWDTuZbTXFlKuO3husjz/32KEwr/hGB?=
 =?us-ascii?Q?93mnnGOYvibEuvGCK/M+9AL0FZuUZeGhrackOYZ+k1ICP2/aH5iZat4PADti?=
 =?us-ascii?Q?e1Wos/9jL/mAFd4skLCqUdKc8l4huU487rT208cCBvw2W5tw2FM1JP5BDTsk?=
 =?us-ascii?Q?xY+PDm2owP855kjXsno5vVeoYf7FPy5QmYmB1mhsDqZnurSdnagLGaLVA4Gr?=
 =?us-ascii?Q?vP0V183vc1WKuIDgSOQ4nDSFUAxwbnHivpYD6wZbBBW2bx/0/PZ6QlQr7FCo?=
 =?us-ascii?Q?BXJHPPaWPHuHTUn17NcoazGsWG2aOPzR61gJyBwBc/fMV+z4tgc71dnYSduQ?=
 =?us-ascii?Q?Z//XualtKx2DE7OdTkpbl7Pax41xFswLN3pihTpSG5W16UikDBg3th+46y57?=
 =?us-ascii?Q?KMgFftMbW2UzEaBKpeFdDE3KnSIQnUwFsSH5+WAO5H7H/FNGZeWIfPAa21ft?=
 =?us-ascii?Q?g1JOk1nHOEP6aadl4pMSMp+zBBhqng9wQ4axaWWaUxV5BboKBxy9CRUybZ75?=
 =?us-ascii?Q?pxbl0nemRjp/q45ve8mk1LbeegSmaUwQ0aDaD+IdhtNCMDqJmk1v/aT0XR3E?=
 =?us-ascii?Q?I7I+igcg5tT27jS1euIxSkiOYIu7cFs765Fq+bI8u3q/Y1Bvo6LORRgtvCh1?=
 =?us-ascii?Q?vNmIISx2bM/6WF76trLIGPlnhwGT9SsLWjW3aj5IgErT01fyHzzVjJfHZqj8?=
 =?us-ascii?Q?+JCiPBieDuWI5zoZ0/LQWmUFEMMBxjk=3D?=
X-Exchange-RoutingPolicyChecked:
	rYWXCciarrbl7cclOZ74xLqcvFpa6VPww3JtbN6hTUyaNJv8NCcMUxlpDuQpewR6rgcBOwJHsSBso9ttqGRpL33lG0ZScKUa3WrAk01eDc26vxb9qHD5Qbgn+UHWqSV377UJXR5ob3KkkQf2+dqO5HDqGLkLJDgq2uBowgr2z6pF1j0EsZQwd2Cndtf1QJMVvqotWv+7HlmDdGghZiQt0CKYXvoTPMUY88GiWEFyR99WUHUK5o5BYCO2vLY8uLbOn41eBagSICdfYp+dF/kApgoi6G4EIVEA1HnC46rMpbzITdwGtmzK9WH33fbsv+y/WpjHYS4ucj2otL0A65A9zw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kP+QUbQd7qykbCAX7KwcyxSg8DKvUoNdYr3uNdBA6mQPaVXTL7cgpxMjouHWiIDWVVmRU/myUQU2BYN+sH4YhdlViAqjHfNyiRJ77T64rEhVFuom+FzaHT7N+7fEReCKBCZ0IGlSTfzPoj6G7cndt/s5U2Ow58HpETtP/9+LYzqBsAuH8WlbBQ6dHUoxNDxkF7XBqfmV+GzKf9rnyNGDFHHsiF1SB6qaCWe34noSMcpbIvCeYQX67FZfO9/g/6dusp+3UgZwQR4S4naSpYMKPUFKABaqOJJLeasXIafvzTFhpwDpnYT3nngs6xLz72ASZSnJdM/xmZa3dW7j6onw8ZXbr2Zuw4t1w0vZj6Psm0bk6MO1AcBhVjgvTSO7ZE137oTcJ9Y9RhV/VqI4x9Z0qbfsXRTdl6DS/epCMdGt4Egn0K6rdIp9FKrtd4i1j26i3XMeJtkMuDz3Agb0idLq0blzOSYu7SOd7vBmwTv08e8xhFRRITAlumBvVNHrqpZ8InzxhmznFLvE6szYJ+EsJsEwEw5fQIabNIp6ppg1zoToACPlxYfHLKiyr4BlG73X7Vs9zr1xcgwkgLM8WaKoZsCXNz0fgYkvdZWk8zzgSBmH37pTkbHrNuGpgX05MrqK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5f1071-bbc0-40ff-0c25-08dedd694e51
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 03:22:28.9376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2tYel2TfFkCp2Ek5uN+xdKrCTDKoCcv4UY6G7KzXDzrTI8utYDkOi0CwKkfus/D1PRpuaxhtbkdC/QHt1XIkX9bszXFHowTtVT+Rv8YqXBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7239

On Jul 08, 2026 / 11:23, John Garry wrote:
> On 30/06/2026 12:29, John Garry wrote:
> > + linux-nvme
> 
> Hi Shin'ichiro,
> 
> Can you kindly picking up this change, below?

Hi Mateusz, John, I have applied the patch. Thanks!
