Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793245578;
	b=4rOImOWpFhECy3AjZOfj5bJ1Sk/TpTjlKS14/+vQr/bFewXopN7Th2/m101RUKSM/a9T
	 7mE5LsJwLYnXu+YdaK7zi0iz9gYmH6ryObT50L1vW1eaTMSW8oYJXofrB6Q1bYHiA1jSm
	 CyR9qOAQA0PPXUs5di/2WZgKtqK2sQ1nTz7v57Cv1ZDdtcQEgNjoGPXLJMmN9cHuz9gTe
	 v5qV0zRajm+fwiqAh8872An5SmP+iqSLci5/3cyAWh4dVg6R9UHY8i4wGeR0t/Lf5T/jW
	 EmTh6c0dooUwZ0d0Lb7quON77f3lBIqPegbIUIDrsERu9PIB603+PSxpLcQilaNPKlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245578;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:DKIM-Signature:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 WDCIPOUTBOUND:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ef6nUOghrJCKUnWPhp89xP78KMG6jUkUg0ZDemQBxm0=;
	b=DuX9C6mwfu2TPqYBfzt8nmHWBjvDK5r3oN+Tvla6aguIx2rNM0aehXwA6wMSO1ghj+j4
	 dyCgM5osA0Bdnxbb6lXEQbW+F4WbBl+XI5M8aybQi0Y89g6Slsg6cI+NwFgqve/xjAa3G
	 R9JZV2umvwUDCEjumCWymUV5qlXmpfE3vI+aXnswF0/Wisu+vlS9HjfYe2s58rGgB+/mK
	 G0rytYwUWd6mqI/TDrCGz7xMPkjy+IdWR+8CM9sO3Q9xN/eM9p6O302wWdqlFnna18mt7
	 7VGR/aTT3Lk3/pOOGb9nSRw0RuiZpLCJSYWNWt5eGJ3CdegRqgtrIQbL1c/lCdWwm4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=GHLiyEAD;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="R1Fh3KK/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.154.42
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D61A606A31F
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 03:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D61A606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=GHLiyEAD;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=R1Fh3KK/
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1793245577; x=1824781577;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KpWgGqIg9DrKpnoV2kJ8qPraqP50hl91B7rLY5OIcS4=;
  b=GHLiyEADT8zspaPEu5n0F8m923f4uq1xW59KMmpnJ0DjIGk2VfPX5ood
   WvKivBsknK2IOnb809kUpnKWfbz1sNoN6JIIYxEyH/VYByN08wi2Uz/a3
   xabzBrZN02+yEP39hI2ydl9J+Ia9l6FCdc/syZYwKNA2eJKT2Ex7+b5Sq
   y+D80iAs9d8RSjmVsDWL/dyOJQT5nHhRm4h2YreWXzWFZHHIB8Hfux5TH
   WwuWK9V3UqDiB/0fpvfUX1rLGaxbufx3/wtes5kElgv0beSgE4bMl5qvJ
   Wlo5Je2llabmltD/lm26jGJJcS2ghRcksnzjcujrfgRJlGYO2ff4pRH8C
   g==;
X-CSE-ConnectionGUID: rEeTCdZtTM+yH6Ipss+f7w==
X-CSE-MsgGUID: NadhfR59SX6Nw9BtIGz0dA==
X-IronPort-AV: E=Sophos;i="6.27,183,1786982400"; 
   d="scan'208";a="155039164"
Received: from mail-northcentralusazon11010028.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.28])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2026 11:46:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQHpcdZGmOQyuppC7iM5rN93+cOuTh7fPmpXBI8XzUCB3e5orbJ5+o4CQyMogjTRVE61V9jonQRRaA24Oefr5iyZoJVO2BjYcK3fgdc9F5jaUSIwh7ruIXUjUPYleQ64s+BeJ8L12jtZz0B5CqB2A2+JhjffEiEyEBdkAMPEB1Ytvg0T9C79u79saAlAUa4EV19Z0sejVkYprt83TuYLx5Tj/8gRgl2nQK2FQ6ZmzBslLzvX4ZxKh5kvqLx3itZLzyd7CftBwg8tBpatdEK6sSFglM/uRLnq8zSZH2Rl0fV4x4arPL7sIDaMU8IxyAk9ln0kNzz++NEj1sqJ3Nvlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ef6nUOghrJCKUnWPhp89xP78KMG6jUkUg0ZDemQBxm0=;
 b=byrZ6sxb6NWRVduouLibO5S/P/JnUJEqoyvqcxSZi2oxUE5PMU1Iw20zq9KXnsdKxXmB8DnX7wL6oguxSWggcsiYylGWmpbCPa/aIdpRBkKd5QKWQsuch1BK8p2QdZuPHCdInVE6i5Gkxo1ud5QgdZFIJVYoxugp75OdS27ajGzdtNgZeX6GJ8fFZVsQ/101aMZ9VTxCJT/XKvpy8uCLBTB22a210yRV37uzOp27LS9iAM7cs1Tufr5EmzBxsk5bVRGDFQ2FUpWkUKaA8IebvkPqegNwqPS6QdCSC7EuWYBMYq/tl3VvcSCX78rWlGj/JPsp0BvNLysdYpRrTWkHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ef6nUOghrJCKUnWPhp89xP78KMG6jUkUg0ZDemQBxm0=;
 b=R1Fh3KK/gk17qWYcCm0KnAFQOvFcQGNoSb7uZd8OcSOlA48sTm/DH2t7FvvXz/VQSXTON20TEy5GdYMnYKcf32JspdIS2UFuVtfTnf3uCetsalgc0gmPmIdYduhHUTHLARCy2DPGA0Z0q6KKRB5AyYDcQ/EwTZNWsKvUJ21vmh8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SA2PR04MB7563.namprd04.prod.outlook.com
 (2603:10b6:806:147::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 03:46:13 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0546.021; Thu, 29 Oct 2026
 03:46:13 +0000
Date: Thu, 29 Oct 2026 12:46:06 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC
 regression tests
Message-ID: <auLBAhlTKh0hB8W4@shinmob>
References: <20261022130927.3583166-1-parri.andrea@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-ClientProxiedBy: TYWP286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::12) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SA2PR04MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: f67fbe39-deaa-42fe-18f5-08df356f2da9
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|19092799006|261028144727099003|261021121427099003|56012099006|11063799006|261022105027099003|261026121527099003|261026140227099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	gqe/KVNcRzL8YDbJv10mew70VTMrbj1xJfLQc1K+7R233ixeFHDPIqeJmGmBN73vSDPhfYuWi4Q/Xz3D+CYsLSb5bkNtqvbNvxYT36c6Xq8dzYOnJ04VPFV0kxrdYbBK/9qo7LUdgUz2y6//bitgJQpw0MYxX8sZLo9DuqJZ1BF2u3/7X5HAAu7mAMbr/v6fWKVtSzYOSUChf6krdjo1nqa9aV8JmdqiTGfsgKkI07GETjfuC+gqbiU+LbpRSS7MxOdC2zKns/9sSlGQxi461ax45OzCMsYxbeBx1QW+jwc3E6wUYUfb7aqw4ivU6OEyPcsFkKgsn6Yf0vwISqU1gAJmJg5YEuaux+Mo61ay4GiuU+WTdSvhWCxynq3PSiYLoQUdbUbC7SPB0HTK98qG7J2YJkZeUqfnWioVoSE+WVOZMga9ppT3tyI07OKDkUCt3NaoCXBdVHAlpAVdOi5+0JFtqCy4dx0NjLDFuBTRVX3O8MKKZ0cEJ0WV/EFnNBkYd1Zt3EpZUsVdElyA3xKZUBDcLek+saNY0cozLz4x1UNhDOMeLLYvyh2MmR0lDd+W3Az5709QpGHMAq9lWi0AnCM3PQ+TGaRyHpz1HL0JMgiAMl1sfKO7kZEQq8Yn/1GKxVh0mbsCc75HxbkgWqlu459MS4RE66mhWbh/y7OWsSs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(19092799006)(261028144727099003)(261021121427099003)(56012099006)(11063799006)(261022105027099003)(261026121527099003)(261026140227099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bqv0fx8LqIgMi6DivDZ14OBe8Y946KVtPiX4rHVIDbZFDHoySgcGnk2AZyKW?=
 =?us-ascii?Q?SX1gM8755L7pZ/sQZTZfRHsl/rTvvJSPptvAJL1q+c2ftA6Gca4mZXzDmZ6m?=
 =?us-ascii?Q?gb8D6Evg0jBBO8JdK6zjJ6l6eOCi00NltxoyRXTP5Jc5AooJoM6Mfn0yv0kX?=
 =?us-ascii?Q?xTmYEcb4dNqa+faucxPE8Ykj8t+ic/oFP4OSP4+IrmT7nZ3b5xOS0TDSL9I2?=
 =?us-ascii?Q?l6d+snnm4iR+wVFl72vpn0RYiWYrHvVFeyjiek9Kif4XZAYX/JEua1e5ObZ0?=
 =?us-ascii?Q?9+GatO2o5fM3KRQqKz/p0y2Eqr1hFEPSb5GzAsAJsKJNTRb6zyD3SWU/zgbZ?=
 =?us-ascii?Q?NFNEfaQ4hxBwfOmpbZ0hCI4xIvTnC0m+7qHZYT8n0Ph9QfsnEP8CadocAiZm?=
 =?us-ascii?Q?QNcbdhZ1LPFbp/Tw6UKxmWuqDoQ/Jn3WK8wUbzrla52MH817pM7LUE96Wpyo?=
 =?us-ascii?Q?BX4auYN2lZrB6/XpWNIoE5WJVEk6TgdcCAchl26WBNZpkfvofYXRGU44W0G8?=
 =?us-ascii?Q?Z6+9n4eCaXewdQp5in0hEX4dyS50/x9Qv89rkdFYrLVsv+/OJX4PAXLKrawS?=
 =?us-ascii?Q?u5yf26XUNo3wYpCM5oahbpMcbzhWd2jQoXDnqxtcPnzTMO0yXwEzECBf1KN+?=
 =?us-ascii?Q?BjTjN0xBrNLV4nBj4Dy8BhVIqplhay2ukH49b+8L+MZozZRqM9gCThoALtRz?=
 =?us-ascii?Q?So+9Fz/O7QIxXTMJQ2m2lhfTMS6l8RoqLLlxXwW8F6OY/7+920t8tsF7ulCy?=
 =?us-ascii?Q?DLawk+EK8fxJxs6BnTouOHSMwryfY3VSo4KY8mayO+xFYnjngzuPRjzZvTzt?=
 =?us-ascii?Q?agh4dCMzDijF2scetxDQKOOBzscCZky9nu220B7Xw7ETA9Kh9I9pKBEHBpR7?=
 =?us-ascii?Q?k99l/OVT4W2L0xUxrA0gdqWEIsdJiEKmbgdFT1m+PhVGuNwPuQflM+pm2Xqr?=
 =?us-ascii?Q?TyL7IA4G1auQ4TOvNNnjv1DAwOBQ3CTu3TxIS/Yy8nENS5wB+3+Dgm0p8Tyc?=
 =?us-ascii?Q?hctReQJMB1UkUdO4mgqVzrOUCDdJLB/VcJTYdbWeV5GyEtOqsuFWWLmasOsU?=
 =?us-ascii?Q?J94yJQIR4PGCEWNgBs1SsfnKMKY2empwVDMEm011FalJMbK521dHq57fnkLq?=
 =?us-ascii?Q?tb/Nkp/ueHPM5e45pkuXfXJt4PAUqEm33k2KuAsnAHP1VhqMIfejvN0HQd9h?=
 =?us-ascii?Q?UUNbwXgem8Q0f5Cy+1yxEANa/Z93pdsVU75Ietn/Vhr/xL+O+JMHzYi16tRz?=
 =?us-ascii?Q?xQ5Kr47YAOKPqj9+o9JKOfClddJmCtaR2tQOMgfUBXrrdoSXLtAhc440Kq9y?=
 =?us-ascii?Q?SWVUlXwnC5JK5A7GvbCCtBhybRJ7XD+UKBtPHmXIF9+ui9Tg3tjB4nkBSQgo?=
 =?us-ascii?Q?l1Pb7ge0CRcLHqOx7MOU5fhwertBJW0gpH6wD8Rw4OqxbXp2mGYOmRPT9ypA?=
 =?us-ascii?Q?7D22vsWGoiKQAFoke+gfti6QNdZBk/bgNOX/WF6F7WrkC28OIyU/df9jIuhD?=
 =?us-ascii?Q?c43evtBzZ3bhLlPw4w0LmgZERoyi1czyLzx1r4QGTfzHD8feAdx0IrK9FZaD?=
 =?us-ascii?Q?FB8cGDd1lxmIb2ntM24UBPjX6cJu+5IdcYEsGrw20DvV/EXM4veqwYC2z9kf?=
 =?us-ascii?Q?KFWYMOH8UhSb0W4UzgnhXkOh6FdI49BCoYIrSgYvOxoBu5ow71p+y5/OuLaC?=
 =?us-ascii?Q?o6cSJ/k2zRzD4nTzes73faXabd40NIje5KMurh2YmboaW2FhkGIc9W3wGwf3?=
 =?us-ascii?Q?5mjnuxgbiF/14s0uEMwCoQTz5LRXdBE=3D?=
X-Exchange-RoutingPolicyChecked:
	nPgSE/X9s/Q7XucOwnDKNjtnHFZXJJ53VnjKd5D7pZI2ai3C3jz/WkEITHmMMP92bY6V9fQCprpFdjAU2CVZdrFAjjagiJQQDFqjB34823p2vqBItO94m6AFzYvq8Lf2wIpNfPHYR4yTb6xDHZ6nxz1JyUpY6E2f3MHPLLIK5M4FLX2Oy8bAinICipvtf0Lnh+1iI+qNIgaHJJ0NV9pcdnX80PptXEId90LCjhTINh375c3mbNoIC97vFlgUZHSFrMfdSUme2YpM7/MqXNMvVg0dKL7MhIUHohcxYVnqWzoCCWE0nLheLjkQcaIwwUkuD33Pgrplc5tYdJAKPCsGpg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	u+G5NcaaE4L/xnld2fYVM4GbVg7udYqkWQE4tGLWZg/8iOeuJaJNr+f6eOikYBihD8RdNt4VdvPY4fa29dcOO8kAHGfwIF1rBxdPMW3inVhvhcs89mJA1mos2mwsHIsjf7QkZ8YNr6s+iQ+XoCgQBTgfZ9falg3BxqJ5qc9tykVIbDWGqp/q+zcy3yPv5+wkpccn9abOx55ILsNcK6RUHs5mL8t4R4fIxraeFLoL+PbfJkPFYWyFOs9qKmu60zlU3+rrqOYG9xyjpPNRBXQXH/zvWhQZLsqgQD2ooCU/t7Smh3XTPTOTQBkZMDsbUpAMlfblh7U5oJ463yxUShdH08ETxxc472eoSDbnGnoh4my2fxZdskkFkrgVAbCR8xW9xBoGfZ9wyYmL1Azdnk0JSd4r1a9zow4Brub8OwT9VKJtEtm+9bbRpeeaQ5bDxi1UOb/AE3lcEQoc8eJeLnKjfb1BeGrpUONsb1GGnu6QJwmCJbRDndrhqoMFxo3RD8ckIqdQvsNz93PCwxPY+mqfV2NSkU5PM2F70rFZqdmDV6gv1l9dDGRAQ6/wfvwTjHqpco4hKfxmvMshnVDiW/mUkGCNf7GxVK4aGLZH0TyjvMi1KL6OCh88pFpEsr7eCXTw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67fbe39-deaa-42fe-18f5-08df356f2da9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 03:46:13.4435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NGlz3YAvqDlrLiD3pQLOBGgeKtHjTaVp/mxARAmwHi36ONaEhZih3mLcTcOyWfdZ+Sc0SNLUJD0oFC6XK4cXwqZIsRbSmQNkZzhTshgdP/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7563

On Oct 22, 2026 / 15:09, Andrea Parri wrote:
> Add regression tests for three nvmet bugs fixed by the kernel series [1]:
> 
>   nvme/072  "nvmet-fc: only send read data for successful commands"
>   nvme/073  "nvmet: zns: don't leak stale memory in zone management receive"
>   nvme/074  "nvmet: zns: reject a NUMD whose byte count wraps"
> 
> The nvme/073 fix is already applied to nvme-7.4; the other two are still
> under review.
...

Thanks. I applied this series. I confirmed nvme/072 and nvme/074 cause failures
with the kernel at the block/for-next branch. Hope that they get fixed soon.
