Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7D5471CF3
	for <linux-block@vger.kernel.org>; Fri, 21 Aug 2026 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309546; cv=fail; b=PI6PUfpqM4QrNoXwvujOLKgQx7PUhxVQlVpWbRLexO/SF9Xl1YKW+Pi19Z1FVhjuOE84OH+HC4KdLxZYzE+A3pGGo4aQSTvebXL93/WMxyYq8FqrGhNVH8FRA0L6HjInpMxay8XC/EkzAQ+6UdlclS2h5UZtjvecJd4GJtEjbf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309546; c=relaxed/simple;
	bh=wwg9/YC9NkUCiuY+jHP8xM7L9+iiykHLponvbrp4yHI=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AANbtd2zuSf6XDkStBEsOYRVW5gpVJthePfdMmzvpQP9XVw6nCcu8LL4eIIsv/q3us1XEby/37zeAe0UVgt/bJd4jeQJMzn2mmuQnDztPU/dW46VZREOf4busNkVTmyKS8dqWErqVazNZZ33MMFlrXC3P4k07T48NlLogFNQFUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b4ut7UZk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tf9ARuLV; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b4ut7UZk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tf9ARuLV"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1787309543; x=1818845543;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=wwg9/YC9NkUCiuY+jHP8xM7L9+iiykHLponvbrp4yHI=;
  b=b4ut7UZkL/wCeewtDvrYQxZerOuCJeUPO/nQRe6zTZ8kybnXva5y74ZK
   7LZtqW4NyInNUPWNuCnpAafRExCmtP2Ma1+u0sbWxUhcl7Dbk/zO9FgJw
   bMFCv8+S0XQZRqalAjOzmVNEPjXy5HyMy7BBoXiGK1+usNywo2WDlW3tA
   E77V90kVOzEuCKGPMPduxBMqNmgKIj5URKfUe5UxNlFAa6Gax5aO3ngCE
   UwkvfxHZxZoH0ChVdd9038WGB/3aCX6Igg8j+2iKgritHXKFc5tGc1xYB
   /CpNl53lFLrEKBvY9epIuZu/nef10iwwpIp1giB2pEEOscBP7biuYu/3j
   Q==;
X-CSE-ConnectionGUID: PiUiG9oWSPuwAL9MxyUFpg==
X-CSE-MsgGUID: xsmdZKOgTbC9e6i+aeS7bw==
X-IronPort-AV: E=Sophos;i="6.25,235,1779120000"; 
   d="scan'208";a="153759605"
Received: from mail-northcentralusazon11010063.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.63])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Aug 2026 18:52:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZWoVOKfBtc3UIR7kj38KalBjJsmWoGQ89GEzhgV44KwD3S8O1WntoVgqOVTgg10YbsKCFbqFTTguWUJC1XeWGYMEy8LNEzTo/RvWzKK0RvxSQU94AR585anmjDy+Joad/YUJRvwCYEKwT5ELjDbKJ31eQyTZ7oJY0MW19/yVsCpBqoC6PFsHedfmi6Sy+FB5Z/PLYYXtrFEP/oYj5h0LAJuRnKl0u1pPQTFklZwa78kn9VmugRu5l9cm+m86QjpnE3mf7+FnVR9jkdlECAcXUH3lWLwpB+Mrkyxd1ZXgH3YxaDzFEm527vs6NI6zHVZ7y8rgAgIqwxrE2wFl8chYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVtmqyZ7IhHP+qXx1kn4HEqyuRte8r1W0OCVnZcTnTs=;
 b=ZQ0FP3HiD7EW7uvAbQgFiUNxCuo4WPLJznn6/vW0N9oYyIFtRz8e2s4bR0Wh3MofmfUINPKwucaNzPtdRDw2UzLT+qA4lIICl+FA9VTHvX/QXzSAEiioZ7SwbQzSt2I2lSG0jeLCdDmwjJlwOMFNC5MWO6IiDUD6uyK+e2t7RVEoHeX6pjPa+QVI+9v99JqF+5f7sgNfMSQHF+eC2Pkj/76NF9q9YdkNeTR6vLaBMqAApDZI3fzpIlaruKOsG5sYf2LzTwYhVJdg7veULpyBdU/35To5M0KuG3PAv6BQh8ZcUSkmYBRLOliEMSqffEJlrStIeOvne3CI3hpi3As5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVtmqyZ7IhHP+qXx1kn4HEqyuRte8r1W0OCVnZcTnTs=;
 b=tf9ARuLVx8goL+LVpe/eGyE3putEI2ji+i0H5/V/0+QXlI25mTpeHllLxjjI3NtKxA0uPa102iT5YhicZSxqZQORRacU4750xE+PDLbeEevFS0NHq/+vL6sxIxZbQO2IeW/pEnm++vwo2NVhxiA9k1/MOfNAp0NuPvKn/NJ7BFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA0PR04MB7417.namprd04.prod.outlook.com
 (2603:10b6:806:ee::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 10:52:14 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 10:52:13 +0000
Date: Fri, 21 Aug 2026 19:52:07 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, Ming Lei <tom.leiming@gmail.com>, 
	Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Li Zhijian <lizhijian@fujitsu.com>, Akinobu Mita <akinobu.mita@gmail.com>, 
	John Pittman <jpittman@redhat.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
Message-ID: <aogtVw9T8D91mTdw@shinhome>
References: <akyeX0hlcrnOC0nT@shinmob>
 <ama1svBbdVfyEKz1@shinmob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ama1svBbdVfyEKz1@shinmob>
X-ClientProxiedBy: TYCP301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::18) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA0PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: f4d801eb-5a35-498c-ce62-08deff72424e
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|23010399003|366016|22082099003|921020|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	AK85eNwidcdHINTBfOCx/gRAL6UD4AyhwL83OKu/FyQ7hZ2JsqbjjMH93jWqXudAapTmW4MlgPI4lzSOAvUhoRCh/vfc/meo7UNjTcncWuaW4Rhlq8gpsN2syrrk8ycR3DqTOCmTtBwv6LPvF19tsZuRpH2FyD2b+SfWWhxuX1JD9RG8KqyAOZ6Ms3Cb6fkM35d52opPMJc/Ls4aN+yaf8Bk0GcxU4Uz3VWEAN9d1tuCSROG/UCRxYyVVna/qgDqQdBQUVxONb0VF0+PeZQqmreonNLT9w3pYSX/RBOPRSiAEqF+LuUjWYUaCPMUk0V4XDd8yBsvqnZwgmSf/4UZ8+8e828eMrVdbPtu9nZH9HdQf5rl2+2wPP6mEmZoWu27yDXSQ97KZv+F9BH0t2MWvAW8UVKOng/OwNjnSaPnn1kHFaaDbtKOFCivqhc4tTDXZi/BECJT3/h0lpC0nPkW4ZewpJth7FX0mkjDg+121G0cZB/BpwyoL6XHYaI9TjWjPAO+t9nSvy5J4cmk3LYEtM1U0bW+Rek7elQmpTmflyyhpVouLkHeQ20JMoz8HxpxwWqke+R9aZh5Yn5XZy6nXfum0btbeXHraVeBASxpjT/3JlkABGdU19eXseL77snDtEv9DZ/95XJo07UySfClOKsAKunvnk9Gl3kh11gebuHLer705xz3cUhiU8ljY48l0nSwHBauGYQepvhljU97mw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(23010399003)(366016)(22082099003)(921020)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hGuV8LBq5CQxAIME1PymdGR9MYX3VTe49SoTH6gE1n7ndZOLtxNVE0DrnTkP?=
 =?us-ascii?Q?GT6hconnNCyvbuYF3A0BHE0jY0sfO6t6Q8erJyO4/EIvlrgiom0PEYCZFjvr?=
 =?us-ascii?Q?pms168NWJpexQW3g0BK0pWKSwHmiDIA6nC6gvhl+fSq2/ev6CITEQgp+fUKp?=
 =?us-ascii?Q?Zb3gOEEPPm+ppI/lbmxvEhToOQdnAJZS5dnjWFKemv3RG2V7kLFmKcM10oVO?=
 =?us-ascii?Q?Ws0xkK9Wk3xF/NTGJibnNbTeJeEL+rbIogfRnbu4WWTqFTSYlql3yPgDNuvY?=
 =?us-ascii?Q?AsR9989q8L0y3vDSW2xd4x6iISOEwJZGa1hMBD/hn6CKf52pUK6NOFPuxaxx?=
 =?us-ascii?Q?ylhyAxHceHEMXzQ6hsJ96fx1TlijxvZfILOlHp5pHMDKM4pzyshSTEWsFHwA?=
 =?us-ascii?Q?hvSgp/4BcfBnkMBFYbLFLlVQ+KWFABennslZ5ylRw1luMdIBLldpvv7g1COQ?=
 =?us-ascii?Q?gteDXlnbQx5IOF93kRh5CaHSYvlXR5H9SfekBMMd+FOrCOps+ImqTFdjMA2I?=
 =?us-ascii?Q?C3cxCrTHNnHHQsmdpf2gQhizZwAf5iLKsjaxODBK8Pv3ygRqnX5T1nMMJT7/?=
 =?us-ascii?Q?xqI7Mhuc3+IGFHehlP0qp7AfUAZQczl80yU3adDzHqF1DDI3LPrWsmaaC08D?=
 =?us-ascii?Q?Mh20cuFNfRCmnxoDo0g6gpnjkByJIPC9H288IV8T4LmFqpwMF72vLNuwSTSL?=
 =?us-ascii?Q?eGwJGYVioWtxkc93tv4/TYqcBaGjz9laAxYpOE1uJdkWQWtlog2pevBekCrB?=
 =?us-ascii?Q?fIpjOW7afEi/wpqivekQN4Xjo+0/hrhM2KmsK2hUOVWxEf8gqofmHCtUwMVf?=
 =?us-ascii?Q?M++Uc7B84MPtOSmYsA1BDkKganZVHG4x8FEMxGFDOFAid9cp2zyCenV/YgTa?=
 =?us-ascii?Q?jMYzgNHJPNKUxHzj6dpGcywbZ+9q/WFY0nOawGGPVfK2RI38PO4WPOGanLRZ?=
 =?us-ascii?Q?kBRTtHtS9MouakTl9iqOc7RUGLkptCnPaJLER0ZLR2vZmd7p/04pp77OLKfc?=
 =?us-ascii?Q?cusHrNYwAjlqjg0ReU0UEq53z2/NMNHgTRjpgvJSGy6np/8Qac3k/TSS9RMl?=
 =?us-ascii?Q?uXYBdQC1akam7VkZXdbfOmBqdWuZdGFK6k5Ab5HrJygkfX8MLLjlrtbUeRlu?=
 =?us-ascii?Q?GCm9Ibu6laSldp8PrjXghkXwLAbJmbMBOc3N7g+EoEOT4GC6sPhX3Mn21ktV?=
 =?us-ascii?Q?8IEINDwZKw0ZrhaZY4WG4F3jUaRJBUYYngAidMa7UrfoaRazWDnIIX42Trv2?=
 =?us-ascii?Q?YH4kZq8EkK8knfmXYXKHg6xmjgF34RX8WY3KhxulNGXZ1taVdjwRLuDdCh/Q?=
 =?us-ascii?Q?V5y+XmaDSyXE9PIIdZwUmsmpKhAc4LbYnSngsFMQ4/r86N98P8tqTczSeyrF?=
 =?us-ascii?Q?MRwsR0SeD+NX+t+EQpoWMkylyGd2bIai8fxoXkwG5loATo7eTPR271JieesG?=
 =?us-ascii?Q?3K3Ihh6a3pnaC2w7yZrpi5rynxenRJKCFfiNzNtPCdnJEg49C7L+B5ANpT2w?=
 =?us-ascii?Q?A1/sqQmjFMV8dnIeFXRkssa4grE8iFvFhRYNpgs6/tZC+WHDzWiW89DhUxtL?=
 =?us-ascii?Q?96RJfh8N5gyCabnrpG4tLCqYE9qDI8MKJr+e7Us2Bqx4JzM3apj9HZvpiRnk?=
 =?us-ascii?Q?FvACxFUsa/MaXFdxHh6iPK3WYJHduZeNgDTGWW3aO/l2Gylj5Ma64eUyootH?=
 =?us-ascii?Q?DxB409Y8T2FpuZeyxmo0sguWKR8cGrZoecGBjVquePe9AfB8VONn0IVO+IW7?=
 =?us-ascii?Q?mc6Fq2oOnN3gREVYLr19gP45YQnpHQk=3D?=
X-Exchange-RoutingPolicyChecked:
	jaWlTRTwz0D6zU+hXZ+AdL8nPsPoZLgq/6+5/5X+YreHu/bZrLYg+Vz2jtTaIFuAwVegN8jhKm34ZJ/FPBjFbN5tHCLnD8Tkcwnq4qzSZSc1KJkQGrJfRfZ44LLcUPCsYANqOFos2GFofPlhf4yItQmklYc3p5+bCj14DCSPyOy4sFBRm9tvc2ukaMgmdN72jl1EloRFynHgHOvy3TutQqICd60AjXzeqV82QdJaLcdH2th1DGTFZtr3Bn7FqkVIu2dlDkqHNhrtb9uIbwDlXmBE1wM+1GCSgRjik0o8ei5pxTPqHP8YPnH4gNuvuCxnh/twFzeM2h824HzJaZNygQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R4ZdUq0yUoxAv6N6r/mqI+Z8+wk4HOqJkorba3Bcf//HoSLyXtPIDP45hB54TGAWV3pwzkkRlFkHZEvznXeUv4kYs/yOu73An4eq3jK/5cdRzuArMPk4qo33Je61GZMQ3GkfX4dGGCzPQ3lB5k37Sxr9HVt9iXpIOdffsKZ4BbH0b0OqXyBRECXl/4cZw0jPPCK7bbTBrhUQ9fc4T+5ND6wcvHCRUq3ZiP+UB6AKTLShcegCAUftfiYgZnu3y+yfvbr1G8prm9K43rrdGLgLAxcBJRRvOuMAR1285JMvubDiifJQnMrxRlbQKE6UHI65tVQE8zyao+kl5terfo5lLzJqOSRyVrI/Sr2M5RmXz+4ze+sdwUlvI1UdEV+zsLJOoS2w63Ucnq8wj84+ZY8Rh59PFh03Gc4gA30GLMCTLgfoM4i1/YEfeBSJB9CtAT8zpQY2P9HRQFQxS1BGcrhnRAj3LY9n3Lt/2muJI/vRdkaGoWUOW87+8oQGKV+wbZesi5xl9omxY5RvXaGWhXAovdhOM80RuSOTrlRiki+7WWfx3aOxVe6rCEKjZY3EhxKN67UGFV9xmiH5qr+AVVZZJaur8SBpaN5z2F5T/2Sh/4ZQR3awI7ZNGDx2unrm1lsr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d801eb-5a35-498c-ce62-08deff72424e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 10:52:13.9192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/ivW//2AIqHkDBmG5ZAayTZdzuWCHTf4JgYlMqbM4QHBncINV2jZYI+e2+c15QFQjEED8MbJTQ7sDAmic6zM1uT7FpnC60BsdTsf3t9sJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7417

On Jul 27, 2026 / 13:10, Shin'ichiro Kawasaki wrote:
[...]
> Bart, Ming and Keith,
> 
>   May I ask you to create and post a patch to change the license of the files
>   you authored from GPL-2.0 to GPL-3.0+?
> 
>   - Bart: block/029,030,031
>     Contributors: Christoph Hellwig <hch@lst.de>
> 		  Li Zhijian <lizhijian@fujitsu.com>
> 		  Akinobu Mita <akinobu.mita@gmail.com>
> 		  Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>   - Ming: block/040
>   - Keith: block/042,043, src/dio-offsets.c
>     Contributors: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 		  John Pittman <jpittman@redhat.com>
> 		  Bart Van Assche <bvanassche@acm.org>
> 
>   If you are too busy, please let me know. I can create the patch on your
>   behalf, but since this is a license change, it's better if you author it
>   yourselves.

I rethought and decided to take my liberty to create the patches for the
relicensing on behalf of the authors. I will send out the patches soon.

Authors, and contributors,

May I ask your responses to the patches with you Acked-by tags?
Thanks in advance.
