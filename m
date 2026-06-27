Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039642459D1
	for <linux-block@vger.kernel.org>; Sat, 27 Jun 2026 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533204; cv=fail; b=JqvTsSeA5bvDwZ7dHESqof1VFTQXg7E1Fj0+agyf+V6+0FAEG6Xhn1Im4RX9xoVTtFhfb8zDMuJx+/t9QVeZ0BGxTDcGS1BYdfL/XJ8CWB9e8cxc29uLILEZhvJjIGB3TwnwPF+mr3tLhPd7W8zlNTl0WUZQ30WnfzBU3MJlGME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533204; c=relaxed/simple;
	bh=pBwIe6v9JpjQIfgZYTdhCHhmW0kKMsG/+DIbthEkNoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i4Yh+q3lZYl1Kh1FHthyUhIGe5zyz1lJWxPFjAJTgNTCJmYSwTE4Y45gBv83C1JJIjh/Sq4oaBGiTYvNpBYL3tlg0+LoRvT67vrUGarIDIQ6jt9IZw9fiinRHtdFMt4xqYkV/umDxKUQawZ1Gfhkf2Fri8wc6dIv5UzYcDXmbUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oZVT8EnU; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a4hhgWJN; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oZVT8EnU";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a4hhgWJN"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1782533202; x=1814069202;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pBwIe6v9JpjQIfgZYTdhCHhmW0kKMsG/+DIbthEkNoI=;
  b=oZVT8EnUfIMnyFS31djayJm4ghwoW7KpaUHdbWkRLwBH+f5h0GhJ9B2U
   FxCDVMucJCOSWU1axVYBWs6Z7DxFhf1yKUSYW0o0ta7TOZi3MVY3L2ntu
   XjFeUezDyZLixdlEgvQge3pkYWa0ufl2q27DJxumeDFACv3HJA1JvqNNO
   kHJ6Hb8k+9Rio88g5FBSNkBq68030wjXS3WMZgz5y4ktNALQyRucDnePa
   qwZYtnN/Nbwl6L8mRdFbnKaAjSnW7iNISejG2cbIqVkjdT2yVQEfJYUjE
   iaIpOjr5HxUDvBlmPJk+z2aSebWpZcW0mtx9G93LKsUp/Zx/qDj1y2DuH
   g==;
X-CSE-ConnectionGUID: pxiivk1OQ+uyMqnZtN4oTw==
X-CSE-MsgGUID: uQOuIpeyQsyELyVfTLWNQA==
X-IronPort-AV: E=Sophos;i="6.24,227,1774281600"; 
   d="scan'208";a="148967157"
Received: from mail-westus3azon11010036.outbound.protection.outlook.com (HELO PH7PR06CU001.outbound.protection.outlook.com) ([52.101.201.36])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jun 2026 12:06:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVmqi4oaynG8OFfMd2fDIXB0cjUqh8y2+4Z963wu45JDbJEXn5T1OkfCa5tGtREXtSm7RTx4py76MThqdFgNaVy1MJUM4CtnycjYbgfpDPZy5gpKllnuq2YpC+UxK6tAiVEJ8GMI2gK55JHJkb4ZN9d1zNjuvr8/Gh3x4m8N7V5CicxA2WRvBuMtgs7/XAiu4Nlw0wILGYk5zrOXP0Lx13WrbnRkrZvCugMa87mAC8SyqqahNwTnWIhzKZqKOlN6YmJncXD7539UPOaqGKub5SHi1EqCyhlmew11B76W9GH0mhJRqH53ZrNrYYx/3t25pcyX4MYiI4t5b8mNm8z2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P432nPumkSCSD5Xf2RzzozY08daEGqAuQ8kzEP9TalU=;
 b=Gx9X5TJ+A5e8IS2eF1H9TSWEtud/KDGbMlydj5CPpkj2v1TYIM1rNH+ciLnIaQYRrC3scEWR5DtSSypzb6CYTTibIFB3fEEaMkv/XbHPFDHLfOLu6FGjjEg2oARtj7xh6akjan+cFaor8ApjNqSfMYHNRD2DpZqwdMiyEOVPT3cw//mv1Wp8vvNyL81OzDOHLErqA3ANTbpGNxV6ylpCjOFNni/K7QuNXhsgnCdvqbyOtTg6uC8fl2WNFc2K3QP1TdC2cMNOA8/pzdHavGkbmhdCTFvpfb0PtDrhc08JAhoKxI43E1lBYRMthaaz4ePQv37PEaJmWuULET/LQH9wvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P432nPumkSCSD5Xf2RzzozY08daEGqAuQ8kzEP9TalU=;
 b=a4hhgWJNge+fHp5Cj3Q0NZxaEHJmc93VSmncRBLCNjRTEbc+vmBXac5TWVqDs8Qz93+s5P46F+bb4GbBVwJvKSszDwqlD2H8748Nv9C+95g0whfsL3SuZyBIuvg22qarQyjXi6OLYJU8klh6FArwvTp8bmbKt5qE1CbgdWbUYVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from DS3PR04MB10053.namprd04.prod.outlook.com (2603:10b6:8:38f::5)
 by SJ2PR04MB9010.namprd04.prod.outlook.com (2603:10b6:a03:561::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 04:06:34 +0000
Received: from DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a]) by DS3PR04MB10053.namprd04.prod.outlook.com
 ([fe80::faeb:7524:f842:9f3a%7]) with mapi id 15.21.0159.012; Sat, 27 Jun 2026
 04:06:34 +0000
Date: Sat, 27 Jun 2026 13:06:29 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] block/044: basic block error injection sanity
 test
Message-ID: <aj9KzVlDI29qvLWe@shinmob>
References: <20260622160808.1552568-1-hch@lst.de>
 <ajzJiWqsQc2EgR3I@shinmob>
 <20260625115422.GA18348@lst.de>
 <aj3_nKfmUFj67jX6@shinmob>
 <20260626045650.GA8752@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626045650.GA8752@lst.de>
X-ClientProxiedBy: TY6P286CA0004.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::8) To DS3PR04MB10053.namprd04.prod.outlook.com
 (2603:10b6:8:38f::5)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR04MB10053:EE_|SJ2PR04MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a666e25-f1bf-4df1-82e2-08ded4017a52
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|22082099003|18002099003|3023799007|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	NuN+BLj35/nSjW33+SfEQPdkgE5yfqc75iLrljv0dbEJuap4oOj7KLIGC8iKh3JMQXOAG2ZqfwP/v6fw0o1B0+uwxHjfbaSn/iBBNFCW35H655wmYeza/UQZFGEcJK8phDVfWPqAYF+yuQqI0DgLOM7TmUa0xvlc/mo3aSmJvIeriFTGacct9lsrzKn8gwLX9jXIcNh+RUzAstpwbc9q1bMap1DB1DC/YdGu6gZMic0YMwmTayWRSRq45Lv9+aL6Ls4YM7XReyFli4EZoT764K8RzL34D6+ABdZm+c8TBVFhjO3ojde/9FIJxA96F1QS8MAR6VKvQiBZP2xcjW6NOPRB9UxmfAq4wMizahS22t4a7MwfDy8zI0Y5TcHTsdY1neP/vIz2ULg/5dUKeFg1ieDLMrLhfzdPX5LBmwRSffCsF9KHFbLxZgrDsUEKn18fQvfExtA49cvneZSsCQq/dx5yPyhnR1s5gO1Iace5ODuOLrwdfwNIxU+OP//Sljj2ZlgfndEXDQeBH7zwA4fh0dGucuhpwYJsaGHKc8XDIoJd4qQQpavhT7eiEtImESvAiWSABNLwV2LFvPhwB6sCCARbMUNUYeXWeFS+58mnZ2OXr7pgtq8/xhIsuk3zGszVp0dhGD7TA+/RP/uk17D8IPAZ4nT/Bv3Xi7xQjJNIwmg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR04MB10053.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AmWZq5JbEPSOPFYlUv8n5o5Ax0brKRHZRN/N9Z2YO8Z3jHZrGVSfIdew4iIK?=
 =?us-ascii?Q?8Hh5q9+i2JDITvBmIkKve1lxz5eXIEBKurpDpNh73GhPBXx86J20/+YpCnZG?=
 =?us-ascii?Q?vIVzLFJNE+0ANceuUdHMVXHhMWIT9KpDT7j0Q8ftzQEX3P6pEb+RH2v9+ZMA?=
 =?us-ascii?Q?Z66npFuaHiJeEQY70mQ6D+jSA400kkN1kUFhzGlS0yyJInMAR4a38iYQcsIj?=
 =?us-ascii?Q?GNKiN8gTL/HL54FxN3HAL+y+bQie3tt0Yu/wBtxLWBUhFlQ7Hpdg61Ex1kAY?=
 =?us-ascii?Q?Epe7KGaP1upycJa1pvKgZJJRzwMjn364DXSJnqs/JHVfkZ3i7rvI72yQmPvK?=
 =?us-ascii?Q?RyY2IQJ0iEnOuG08bh1SfxwxIQitBCsn/o6IrFd8bvXaUetdoAb1kIetVm5j?=
 =?us-ascii?Q?ZJapkyQaz5IdXghlnrNVukaowfcwOxxs/NFPsmpJscJxxI+1LA2exRO1SaMX?=
 =?us-ascii?Q?d+3MTlo9AyGXPnONY15rk/WlpCaFVQppoix0RM0+5qPD0fcYLVFyLQVztAH8?=
 =?us-ascii?Q?IjIh9asRZJuUuHZOohzulIw7MPWz6Lbsj/4llDcx1TiyfAGK/puZLVCHgObq?=
 =?us-ascii?Q?TXtT1/9mLblWlKES3eNQ2Y3tbNXVejl6Exa4GVScYUyqvqyaULfKEzD+t7QE?=
 =?us-ascii?Q?BebPp7unVbHJ+FTiCHY8NzgcJyXU5SvunZZWri9Sn4yXfB929Vzj/jk6aDXq?=
 =?us-ascii?Q?NiUrhe+9slYAcFnBZO3AsUf8RiYAIIMN6wN9w6FIPLZmrhKMFU3cu1AqPE8w?=
 =?us-ascii?Q?hIRp0rIiCqJKj18myWlS/Ii6t+cwoqbX9ijH+dG2szwjl0Aa6r3I136l+5RI?=
 =?us-ascii?Q?A9qNBmviyzPYhb7MaptiHGy5KHtkv6qs4ps05lc5ssYmnJZqlPuz3Ix4RJ/K?=
 =?us-ascii?Q?prO09MDsLzYTVVQmMF386qVNDKP/GFcU7DgUR1bAYATRRSo1M50/5SNU4GAn?=
 =?us-ascii?Q?gCipetpg8M+AU5zVrOod5Xpu2u+PpX9OXPOMqK6qnwg2LE7XXIcwUYn4dapR?=
 =?us-ascii?Q?3muCunBS6VOsJ0KrvnIEoQvHZs9tdPD/pypAeVIn/QN1FquM91XQge+UfTZn?=
 =?us-ascii?Q?1Z3W5dSCuUGoOvKKmNK1JSkeeGAtk4Nv+zf0bd0XG5EYo/eDPtAAuOODgPzI?=
 =?us-ascii?Q?cihbz3meKfjtwW33b0kNpFrTUF/S0OyTf7H5ccuRExo3P+11gBUjH4pBB6xz?=
 =?us-ascii?Q?pFFu43vyN6sQfz8LVQWTRV90nS63OgjMv7KrmMMus9tpwIq8zF20nFaDt3ye?=
 =?us-ascii?Q?WinaqzlUQcWNdnm4C2eR8XV2W2hySRWEzF0V961aGESk9+hJLJTZMJHXGikc?=
 =?us-ascii?Q?cW5XH+EfQ5nLrfZO6NhKovROTwxwutUJMZB5jY1+OPlDl/cflTvc22xJ6lHp?=
 =?us-ascii?Q?xGkRj/zz1Y9zSsM2+ruODVPbfAnwXpuIZIJ0ho/DWsdaRVNXK0TO61v13L8i?=
 =?us-ascii?Q?xqnE+HCglpNkvVkyf81Vi4qTNFoSJd5HE1aUK2kT4P37tLjFaRRW91ul2ZML?=
 =?us-ascii?Q?rpgl1dTlOTpwis5ijmUz/CCRAxYPe+EseEZhC56GTJP0GxMUuAve6F56m6B8?=
 =?us-ascii?Q?xoKcC+pJuFw1IEZrq+shZw35pFEIugkemntdF1U/22QiUwdjopzZW/ANgDW5?=
 =?us-ascii?Q?G57KvBSNZSryFhulL0eFkkYSCRLlUFMoCo7OoNL7B4nBWxsEWwvP2qy5/Mca?=
 =?us-ascii?Q?MhcO7F7rWF9xayBN0U94aNnKPEIC0MQp2hpOPYqSlYq0BpSvP4yoOVCv/Opc?=
 =?us-ascii?Q?h+c26AavRrTQKTwFQpfHwjO0UPlXvn4=3D?=
X-Exchange-RoutingPolicyChecked:
	XYCXZGP1WMj0oBUvJ2P7JQjsrkyQ05Tsdagn3TTmXzBssgZ0nVsK9nhhlm/RvNip+ajeD78ZN798/5sRHQDYew+LFiZnWibvR806X7oi+nyd0oZcbBO1GQ+2572v9EYNuLpKhLE9EDLeExTMhspnhLsGSRkdcwprzOcdyQhR5hrwSxXn+JRM34KMedo53aD8URRiOYYWFON1kVxgSPRDMPhhT6aszu0IK5FjsUqRpfT6injeh+dE3xIaDg6NUjnzviNgghdcUPwedqHHPOndd7vJsT/C5NTQcoFtsUGCY8aBF8icPeeriyqFhJbULeCjJSpoyL6oNyCJ8ynxdFuRzg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8/e3399V0o8FyL5LjhmglV3oi0crY0xkGVJiMsVlS09WiWsT4q4M6omIZGCumnKElU+PJrnj8wWTHXhEuGU8o9liBxsdhQaGskXFHZXvtWyvKkD9he681/SVdhnPa1zW/ZWmUc47FMhnBGc5dHuO6q4flX1quOuWoqMFgvpfdAt0SybGvxZURmglnccutMVDYWzDa1PdyuCrhhO6clRnAa1X4M2guWkIybbrrPtUxHr+rGrUNj0Il1tL7cAL5cnCk2caI0/fVu4uwkPiF+rd63DzteBfRjjMbYZXftJ3pkwiagThVss5fwTVMqCBXHvVIuyOPJ8yXwAF2oEhptqdJnXFiO1nvbrNbHb0wTJarwrL0dE7J8HeFaWmzOjIh533OFpLw5kIEGVm8lnBrvE9IF+T5k0XdT0f9tsB6vgEBqOq/N/ycmkffsLIaHoPqNf52d8smlqW78SXy7B0bxoCi0d0Krw7XvVjyEv9iXFiWZOtr11yzXhR+J2X9Pkhk3TYyWcl7HPA8UtwUn/ti75JhKvtm+ad/bplJM8rfOkDI21PthAD3EjiVpDobUxq7kEH1AseaJAmFGejy6BIbxkl1uBBbab0xOTYwP8lWLIEmCV8OQRCjk8DzXoCRMOpaHRS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a666e25-f1bf-4df1-82e2-08ded4017a52
X-MS-Exchange-CrossTenant-AuthSource: DS3PR04MB10053.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2026 04:06:34.6282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0hrBnzpelnzZgjHdjt3o7CbvZhWMmGgj0qCkJQAPyDHu8RJ8qGXmCqi+YHUULApc9X6BHURsDQ4ny5hqaifBMSY9GsB2rLKfAfLt+7VC1co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB9010

On Jun 26, 2026 / 06:56, Christoph Hellwig wrote:
> On Fri, Jun 26, 2026 at 01:31:06PM +0900, Shin'ichiro Kawasaki wrote:
> > > > Nit: Majority of the blktests test cases have GPL-3.0+. If you do not mind,
> > > > I suggest GPL-3.0+.
> > > 
> > > Well a mix of licenses is obviously bad, although I hate the GPL 3 with
> > > passion.
> > 
> > I see, I respoect author's choice.
> 
> Well, if the common bits are GPLv3+ we can't actually legally combine
> them with test that have a pure GPLv2 license.  So I need at least
> GPL-2.0+.

I see... I read back GPLv2 and v3. My understanding is that:

 - GPL v3 adds additional restrictions on top of v2, such as section 6
   "Installation information" or section 3 "Legal Rights from Antci-
   Circumvention Law".
 - The v3 additions conflict with the GPL v2 section6, that says:
   "You may not impose any further restrictions on the recepients'
    excercise of the rights granted here in."

> 
> And we need to as a few authors to also fix this up for:
> 
> block/029
> block/030
> block/031
> block/040
> block/042
> block/043
> block/044

Thanks. I will list up original authors and contributors of the test cases,
and then bring up license fix up discussion.
