Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795226720;
	b=BhnMN+eUadDprREBODU6/y0BW8SEi+RsFFO1K2H+CQuWovSSEUPpsl71On7OuIu7ArRg
	 RpDNq2/Or2yZHHiR7Nf7grmzrY0rw19hrc/FU5NzeeR6KoA1S25Ka/R6b0Idd+QL2/G85
	 BjVrDdJYvigK2w3jiA8N3zumTr6ZYw337C5/CknKiXVyLH2xxGf0bWtHb3VbsDx3JV/Zf
	 Q4X2684fdoHTiIQ9P64j0VSWdfyC3y1rlK6O2rBjo4+Btib73k2ghIslZbiaW6Ll7ht2B
	 IPSF1F9uUzO1DSxlXOsfHNKgjXxLLj1Adc+WOYZfluLjvt9R+le9/MawQ/gMHsid9Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795226720;
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
	bh=GRQP5y2h92GURy75K1JIJ3IsCNb45lqW6LXlnMhO4t0=;
	b=AbgWc0LiNBju5y4eRB7L3i/6T8Cc84/h3I0+C+7+l9wj9wYtVBRuScna22eEG7ia5vkw
	 0bxHwkZDA4YFaXMvghqtMq0m4A6QDbcPPjIOye85yx121jYtO9qA+JN/1E0vVZ4Uemoev
	 CLKPrQoyM5/1forAxZy0bHl2qM29DnDfsgn55AT/zKncRYxlKxgWuANK6VDaj5szAFOak
	 PVW0zMsYJqhCOMigmZ1Qurizo5AvyFP1AsUxYno+eBGuuCjZodwWc44x3VaEjhRfJvSGh
	 cQt+uV3cE/3oHtT3VVZdpqekQ8PgJ+K9150ch2dshtuzRkSrcPx//byIgP7lQk9gjYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wdc.com;
	spf=pass smtp.mailfrom=wdc.com;
	dkim=pass header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=RFT2SW5i;
	dkim=pass header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b="IgG/qAAj";
	arc=pass header.oldest-pass=0 smtp.remote-ip=216.71.153.141
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0675606A682
	for <linux-block@vger.kernel.org>; Sat, 21 Nov 2026 02:05:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0675606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=RFT2SW5i;
	dkim=pass (1024-bit key, unprotected) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-sharedspace-onmicrosoft-com header.b=IgG/qAAj
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1795226718; x=1826762718;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=n48kUBLicnOhlxLYnJycPzWBY0llfuCvys5CLul1XsI=;
  b=RFT2SW5iGCGAwu56bf8FcGLE0ijFFtKmb9uv+Z1I7ceaJaOGfZsxVUAZ
   nSaXk4VIrLQYVyCfqVA1fLF2EKRQid8LD1h+KuJjlxy31hV758pP1sSm1
   i/pH0ZqO2w5u2NTbBh2PJF1W03A1mn3oalnZAOz7EQ6TYcGTp1Bz/faDK
   THpJmpLRW1/0lUkj5sXNXSvaviLlygDqIJYmsXsj0Vr/g1KIYGBgODhh2
   MLP/aLFsc3XaePoEWfHWUQxKru0VsppL2KvBfjmPeaRs10wTnwKVajWMO
   wECpdw0rV2ucJGBc88JoK7PQwxokWu/Vg+zlhSMw6XtoZSzi+dz2tJtYa
   Q==;
X-CSE-ConnectionGUID: Yb7jaUgRQUa0IcSu1S8WxQ==
X-CSE-MsgGUID: HTGcBvpOR2K/gqKY62CFmg==
X-IronPort-AV: E=Sophos;i="6.27,224,1786982400"; 
   d="scan'208";a="161416900"
Received: from mail-westcentralusazon11010008.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.198.8])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2026 10:05:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZrZnbG8DiYXgs+eOWPYm1QVhy5hk8duQNMouJ+IQDTYqyO2g6YOIkPsEqycqe39IR+AFRCx7H7Ra6oqDPkDaByoJkHUjnKFFH5rJ4ZaCe/RqLnUn1bOkdeETl2VabhfjgcSWEXftmxP2d7W/8li5s/3z64ZyKquQYeqkf/RFCm/UCorWooD89NyoeYsFZ06cgZQ1dKG4IJDpkGV8Xu15x+IxOTah6hCVD4to1EbDa6HF2aRkm2Xj9TNsguvNGBmKuxXm65Qv+LUKccS9W24J+/rU/RauKuIjHSeegm4XoapTiPc//ti6jfSK2hqsdQBfuPI2uo+ktkSAEaaUSTVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRQP5y2h92GURy75K1JIJ3IsCNb45lqW6LXlnMhO4t0=;
 b=kUhlB/ttX9eZ3640W5JpydOp4rkxiM5dX5ULhrW7j6J3+XuZ6r+UTXRXLbW4/D5ZPyUJ0wKfstiiUCfxOmEvKG8ywLsU8mmPv38eQdwJ7LGF5Vj4e3keO54namgJudv1j9vVKXRYdtsPZV9LM3/qySngpfcOtRqiDYE11qn24qL9Y+1u69woIElAoeT9Muslh8YWY3komG29HW3bO5QABfoNTqYdDRz4WZ3mIljMp5ZSoi2vJ+B3GqAYo7I518j0GygfDo1D54c2euyweN7nPY8eQV+B963AWdH0Gx1oy7oJRqQdDWPaR1J92L7q2llxOVSPtx8DMKalKHZn4g0xAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRQP5y2h92GURy75K1JIJ3IsCNb45lqW6LXlnMhO4t0=;
 b=IgG/qAAjvUEnKeJ2af/CoGOlASbJ50GfS8JIQOnaZ8Qo8YV+1IYlMSAkovziwY7RYhGikiqytP9LOb3USF6+SwxloWdy1l95YZC1ugwUbIoP+R+0Tqiad/QghDaDAzc1TPaWTidqgyFJrE/7oujbFwBO+SqjjJt/sngGDE8hUgg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ2PR04MB8962.namprd04.prod.outlook.com
 (2603:10b6:a03:55f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sat, 21 Nov
 2026 02:05:09 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%5]) with mapi id 15.21.0639.011; Sat, 21 Nov 2026
 02:05:09 +0000
Date: Sat, 21 Nov 2026 11:05:03 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ankit Gupta <ankit6791@gmail.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] nvme/080: test write zeroes larger than 65536
 logical blocks
Message-ID: <awD6iLYWPuEgEi1C@shinmob>
References: <20261117052741.25471-1-ankit6791@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117052741.25471-1-ankit6791@gmail.com>
X-ClientProxiedBy: TY6P301CA0025.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::7) To SA1PR04MB10065.namprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ2PR04MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: deebc49f-7e4e-4d61-f114-08df4773ded6
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|19092799006|261028144727099003|11063799006|10067099003|56012099006|261026140227099003|261022105027099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sg0IhNSIoJTj38GmViMV2BOBeegPIhmSZD4Y5teSleNZcbicH/3yVq2u/aECvf7rNZXy3Zp2w+AdoF6yT5qeljO8kXGxWXkKWJoz2iMZRR46KyCCDVkS3GsUUCLI8kMQsP0YK3YVple62KAvptfKZ7ufKJVB9rG/zoAVtNAM/oE18lSCVILnlK2LOkmVvfwK1w2a7xBpAlPvDo+zMtoaG0f+KVTMTE/N2oYo3KwF4eMsMpb1cSViH9gf1rDuOkoTXj6DcOKue70H0yQvVk70dTMrJ8SmrJq1PlPTMp6VhofYMoKtaONClWYQvxu2o43hDIZG3XsUuKF50hqVqynIj2vK+6D3o0Y2Xs4tYRdY31v1LWmaHu+/uIPbEGVMzqwDY6YcCLJIxz3WBudMhcvmoU7EdbJu43fRveswu1To1vTo1PQnILmFy6BDQIVPwgt73fwXCtlDovp5iZ/Cz2iFb42jHvu+4oDZJo//pokPPUvGdfZZ3fGkWQve+rGzVxuMmJI7x/HGTub4HaPgo7unXorJuGQr2h9+X8oadl1RZf55e7ZIbbFakvB2tpGl0/WMIjyeOlFuls9Uwxwxiile+tg0X0LTiR8ioAAlhy3Ujf0dWMoks51waknebjpjLQDz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(19092799006)(261028144727099003)(11063799006)(10067099003)(56012099006)(261026140227099003)(261022105027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALdBtAtlhVxU59NTk4Mf7sWKo65HwX4wqORp+/c+0jAaSDQmpt7VzOZLghoA?=
 =?us-ascii?Q?DOtg9Mbshju0BnQV8REKnPDpygLJT8THNn/NTGU+kwwOAeEWL2QVL5ONF62o?=
 =?us-ascii?Q?jXZuTg00XM5HyyX7Cbn3BokyA7TS79mu7/v8pGNUPQSVINz00cOcMer21xcP?=
 =?us-ascii?Q?gqQ0N+DGJMIWoZL+nernIubNUyT0lwAA5NQsFhYePuO4BNFcXUbkIJ9BuiN8?=
 =?us-ascii?Q?VysTc75RzjMLXOsxxn8ddIRZ+aBO4V+Yx1GN5tBWiqoz8o1XEpYlxvDPe7Pe?=
 =?us-ascii?Q?hateqSHS9w8Hu5uI51LIamREyqxcWmGLqynQ43+AUGO5u4sYhEilofPf9qF4?=
 =?us-ascii?Q?ppcRoJjLRh9REyqcF4Kc2Ti+O+SK9e9l7liSMIYwtVl2HjCQIb+apo6Ujp8O?=
 =?us-ascii?Q?F42w1ish5gJBihcQb95K0BaRSFl8XwB2gjGuht/v1N3VQqyuBPFkMg/tv8iF?=
 =?us-ascii?Q?pcDzazofJRJT3hxKLKuHGEdS92FHC//h/oG7F4pFimPVtyRUz4Et8nlO9Xns?=
 =?us-ascii?Q?9slDnJQgBeQskR5aDl6Y29TVxY0ncluzCR1L+FQ2fzWFUuQ52eYK+VIMb5bb?=
 =?us-ascii?Q?7pyMj1PuIaXmK5ATBEvHHAty9G+hLqyZVj43zF4ebptp1CDix3xVxtbRMgK3?=
 =?us-ascii?Q?taA7WVEmziyWDAGnaCv6CdX6ieybhqtFI8hR+I4dvY6BSHm8fNO0+9Xa2kNY?=
 =?us-ascii?Q?QoD+rWEB0u+1Ukg81+wFJajG3NpTdu9dh/aOYv7WeTLejzPvLjmO32WlgmBw?=
 =?us-ascii?Q?TcIgKVm4ZB2CIzr1AZKbQDqT8vwvz8FhUC3tl7IhyHSVwATjTjtL0UXqhalX?=
 =?us-ascii?Q?rH3vWNvU2NaVfKNb9CMX2M4JJrR/NttCiKH00E7RUdhT/cCjZSvAIZDuae8S?=
 =?us-ascii?Q?pyl3BS31zGjHL/rsgiASlnsWZ2l/mqo0kQYuXIGbrmrh296XkjT5rtZ9HcpE?=
 =?us-ascii?Q?SaTKih8zXQcTeM01lBeoFnhkIyPMHjG89u6urqTvt/OhFyAfffHlyBbcqOwk?=
 =?us-ascii?Q?eqHf4JHmgRTBKxN5KLw6Jt8A9MrY4m9YD0IV9Ioz6cPRaWNn07XUJjqW6Tx+?=
 =?us-ascii?Q?Na3YHgSNndmtZV29bRXcOA66MC7jmuYEsm13FKDnjZ03g3Ix/tzBJtcBjV86?=
 =?us-ascii?Q?Tho4EwgJEAW1RCDDQH94n6m1mD+nI/o+8KJMF1OQWEZVU9IfLDDJ7wjO72g/?=
 =?us-ascii?Q?sowFI/HceloVwakdbM1JR+bMddZi/PHgPS/j6AwTmoCHfE0G0U4iUs3fA3yS?=
 =?us-ascii?Q?+LFT0e652S95xKGSOxcgJJr/kZ5pA/CEeaUosMU0pTHurJyev/KdAmPYtRYi?=
 =?us-ascii?Q?rUcr8zvHIhzndrL32Y+GMW5BslqaNP1BjUnbWjKBAM0qfsanO8u5TAsg1CLm?=
 =?us-ascii?Q?GBngmnqvyj2wkaEtlMif2r9CP3ZQHJysedTw9jsWst/IKM1fHfsKHnvefB2C?=
 =?us-ascii?Q?iDOK9lFx6fDnLl/Bz88HPxR2krKGEwEQIAqZ4cHFExSnEoJhY+rCje12Bg3t?=
 =?us-ascii?Q?QFHdPDnwWDiDR3n3vZBiOhta3OsSWkOtISCaGWPwSqfHFFccqymtkplrxm7P?=
 =?us-ascii?Q?/P6IEJSzGMOZfPWvuZ+AJWZaqn7FM3gKVh33xb4J0DmzBczzy4MJAyTp3t7x?=
 =?us-ascii?Q?tlsYC8vfIxjaF8fs78OkBB4P3616OP6ASvoNLoOCj7H1FkLY6tNlUM3TupuT?=
 =?us-ascii?Q?ncZZGr13DaOUDmWdU474aojluxCPbF+7TFzJePAknezTdj+TZ56wvwFOm73u?=
 =?us-ascii?Q?hCA4fj1f2ixEGiwXjftnTyfSj04ZSw8=3D?=
X-Exchange-RoutingPolicyChecked:
	JSXG4glP0egWc7mNyGsBcAGRkqKajds3AeYjo2WiXNvncTUEkb6QRo+MgIqBaTKXVBUjjFC+NJbuHuzubx0CP9hnqZ/FO6UKqtB3BqVDppvY+iOvztaU5ttiJvCpPd6b1frRfbmSGHsA16AASl/VIOUwHJTVLeANYv31D42jR5cXjhn2ZJM3BN1s6HPWHdDPhu/dl8vXjMjJ7YyAVE7FQHRuwXMFekmdnZfGznz3hMSWlZ6Uir8Q1+1OljyQCEKbduWmE8WcHiUWsKtAsrA8qB1nl5BWSSy+rhvM7B5/ExKqX+vPBK2Pmcez0RFSMhQrSvbZUmAVYc+SP5Cu5YXTtg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	W7q1j3JBdmYaTZTQl5vnavg9rV0NRDb0cTW/l7qvO6fxrr8tfQiKSR4iTJCEPuIUT3MCziDHVEDoaOdzdH9BY6sYzHx8S/VbMTwRaTQQLVS1punbIU8Q2phlltopg6A5+jXhEY4f5cgF3b/86BRr0uaWnNIxI0fz55BVydwbP01NOZ5Wh7N7Ryi9ibBfw5SX6lI29mk9bZwLzyjm3+e1H5B5TKcaPW9DAa9HM3Tnhwsf7hLoCdGPwWqQSnAbzD7RTPAGV7IIeRaIa/Za0RRZynltoFJ0p3Mq7ZUbcGd9647Z2vzZsbrl8xoJP+TAJ/7gHu8qOpjMV7Bymv4J1dsq+O8M1Qwpyuc/gtUkFRVkK9nBAV8xs8ZW1FrQAooWb//AAK29C/IhdW0SrZ92fDMKPYmLc90UGIjOmNKjJ3AFmuIrqzMYWq/DcE1t131NDMY8rcfeiX1Q1w9F7r/STHWPgwWmg5VoJtkBmlnSXPb9SCdLbOGd9FfJPmLoTexyrkv80XZyHtAtXLVFMsU42KcyxOi5bXzL/V6guJQj52A9orcKxzRKyYElBNzRapDz8hd73IAYXfdC4ErcYUfV+RAF74VAYBg1isNI6nJumxhQGAG+nQrn0O+c32Li5a2N9man
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deebc49f-7e4e-4d61-f114-08df4773ded6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2026 02:05:09.6420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gf3JKkFgB1mfFLQsZV8M3VEdSmZ5uhS5m1dJ1QRetxalcHWJZ7CVSILs4p55KHr+1Xht0Bx93IuGIWn7u9Sme3vPLKxoWNv+Vem2hZJzdVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8962

On Nov 16, 2026 / 21:26, Ankit Gupta wrote:
> The NVMe Write Zeroes command encodes the number of logical blocks in a
> zero-based 16-bit field. When the controller reports neither MDTS nor
> WZSL, as nvmet-tcp does by default, the host advertised an unbounded
> write zeroes limit, truncated the block count when building the command
> and completed the request successfully after zeroing only a prefix.
> 
> Add a regression test for the kernel patch "nvme: limit Write Zeroes to
> 65536 logical blocks" [1]. Fill 65536 logical blocks plus 1 MiB with a
> non-zero pattern, zero that range with blkdiscard -z and check that the
> whole range reads back as zeroes. The length scales with the logical
> block size, so the test covers both 512-byte and 4096-byte namespaces.
> 
> [1] https://lore.kernel.org/linux-nvme/20261117011230.10288-1-ankit6791@gmail.com/
> 
> Signed-off-by: Ankit Gupta <ankit6791@gmail.com>

Ankit, thank you for the patch. Overall, it looks good to me. I also did a trial
run, and the new test case fails with the kernel v7.4-rc3, and the test case
passes with the kernel fix patch. Good.

I made minor nit comments in line below. They are not critical. If you are okay
with it, I can make the changes when I apply this patch. Or feel free to respin
the patch. Please let me know your preference.

...

> diff --git a/tests/nvme/080 b/tests/nvme/080
> new file mode 100755
> index 0000000..bbd3031
> --- /dev/null
> +++ b/tests/nvme/080
> @@ -0,0 +1,90 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Ankit Gupta
> +#
> +# Test that a Write Zeroes request larger than a single NVMe Write Zeroes
> +# command can describe zeroes the whole requested range. The command encodes
> +# the number of logical blocks in a zero-based 16-bit field, so one command
> +# covers at most 65536 logical blocks. When the controller reports neither
> +# MDTS nor WZSL, as nvmet-tcp does by default, the host used to advertise an
> +# unbounded write zeroes limit, truncate the block count when building the
> +# command and complete the request successfully after zeroing only a prefix.
> +#
> +# Regression test for the patch "nvme: limit Write Zeroes to 65536 logical
> +# blocks".
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test write zeroes larger than 65536 logical blocks"
> +QUICK=1
> +
> +requires() {
> +	_nvme_requires
> +	_have_loop
> +	_have_program blkdiscard

Nit: blkdiscard is a part of util-linux, util-linux is the fundamental
     requirement to run blktests as noted in README.md. Then I think it is
     fine to drop the line above.

> +	_require_nvme_trtype_is_fabrics
> +}
> +
> +set_conditions() {
> +	_set_combined_conditions _set_nvme_trtype _set_nvmet_blkdev_type "$@"
> +}
> +
> +test_write_zeroes() {
> +	local ns dev bs size len_mb
> +
> +	if ! ns=$(_find_nvme_ns "${def_subsys_uuid}"); then
> +		echo "FAIL: failed to find the namespace"
> +		return 1
> +	fi
> +	dev="/dev/${ns}"
> +
> +	if ! bs=$(blockdev --getss "${dev}") ||
> +			! size=$(blockdev --getsize64 "${dev}"); then
> +		echo "FAIL: failed to get the namespace block size and capacity"
> +		return 1
> +	fi
> +
> +	# 65536 logical blocks plus 1 MiB: 33 MiB with 512-byte logical blocks
> +	# and 257 MiB with 4096-byte logical blocks.
> +	len_mb=$((bs * 65536 / 1024 / 1024 + 1))
> +	if ((len_mb * 1024 * 1024 > size)); then
> +		SKIP_REASONS+=("namespace is smaller than ${len_mb} MiB")
> +		return 1
> +	fi
> +
> +	# Fill the range with non-zero data so that stale data is detectable.
> +	if ! head -c "${len_mb}M" /dev/zero | tr '\0' '\377' |

Nit: it is recommended to use the long option --bytes= instead of the short
     option -c here.

> +			dd of="${dev}" bs=1M iflag=fullblock oflag=direct \
> +			status=none; then
> +		echo "FAIL: failed to fill ${len_mb} MiB with a pattern"
> +	fi
> +
> +	if ! blkdiscard -z -o 0 -l "${len_mb}M" "${dev}"; then

Nit: same here, with long options, the line above can be,

        if ! blkdiscard --zeroout --offset 0 --length "${len_mb}M" "$dev"; then


> +		echo "FAIL: blkdiscard -z failed"
> +	fi
> +
> +	if ! dd if="${dev}" bs=1M count="${len_mb}" iflag=direct status=none |
> +			cmp -s -n "$((len_mb * 1024 * 1024))" - /dev/zero; then

Nit: same here:

                        cmp --silent --bytes "$((len_mb * 1024 * 1024))" \
                            - /dev/zero; then
