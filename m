Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193419923C
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721130599; cv=fail; b=K0nq7zNcykq7Q4cVPvgRyZCeTaVpOFWNUo7fiMv+UgMfU7oFftQeFMefEIReRdWQdn0VSFzEB1Jz7cl5HtqiTSc+G3/VM9lxeNcmQQomE8DfNQW3TzEezPetakOC5+3VqBudbVwZVQQmrIJMuKm65GhLvzglk4k5wyZb2YnK5bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721130599; c=relaxed/simple;
	bh=22pcg61KBwCJwulhMOxW10TuWJbRjI+bG+KbR65gsdA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Axohk9NNImlGiSySC5zDZdk3CqxytP354lvb3ZzHgrF42u753Akbunu2wm6sybej/1dpZXWQ6rlVJw/JvfL/N1xmXTJNUwMouPh+MEb7TKQeDRa3TXxbJsh3mrQAshH4S3NR0xkaWAn0pau5xRhFkeq8x0wYWXkG3bM00+IfgfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=YpsrkLh+; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="YpsrkLh+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H44vSS4FuWh4cBES0/X7ZBPf1ugnB2P5RrtqYGPOYwH7KIlceHqIdx8QFGO4F+AZtD6A6WLao0WXp9auWkUUsBEG50u2Pb3U4l7/JYFEdibXJ72WHv+n0PoCyabpAi+CvEz6HX172h6+tKEh81+vAvVgouDA8jGCyvfJy+uZObyK2VXOSwfiaLcPN6yD07ziHfkcIaqniP/WvpwH3x3rXvxHpdCbVOg2DL1JRUmW1P/OeferD5nMCvpsngNVMzQOMMmf9L7Y/irmiU5XC44/CgtK/rTHpObPwQt6+rxCQgEpwvfuqzLuv+sWdUZgLZLE+YAauPJ2C5JfYk/m+V6mMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0sLtRwYXSbeow5VT3oRlB9b6RC9rW1E6mkruxhFbG3A=;
 b=u3lgvc/J33pCY0zL1SeOXPXqHzaR5xG1mH/2wgazR+cDuj91/35V6LxvMLsucUuGHwRzKruQuzpQ/u/2kis4ClNUg1rMSMKGQ5ZabEeIq7YmFp+UcANAmQFoadD9vuIlTdsM+kPWtX4d9d1ymvLAOL6WshkE9ZS7hZZYnOw/Ot7HYYkbEMNduChMU75T45/bJsoWbFd0zg0vDmF4svxF5004folYUfWoWS5Bem+CwCbFYbgDg15kDqJhI3W8nQ1LxZWZWFz17Ey3ykhMVVUuf05uABUb7qAxuI5iFzONlIMoWA/1ETLlyasNkZ103LnYahB6Gp90u2kgcaZtDysecw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0sLtRwYXSbeow5VT3oRlB9b6RC9rW1E6mkruxhFbG3A=;
 b=YpsrkLh+bIiX9e5K4nsMrrPoSq6yYkLG5lV8VQvUfHTYWKRY02lcrGNUMWaZ/4NBEgXgoKfeAa3r/XFpq4Gk3LqCAgSiLxb3F258DJcyrNj7arxPWzPLAU56pWgB/f3uskZnjymnCRC4WDJh7UkKNAqdKHslN7HlCeOfbTa+EiSDi/ZvSDUpyOR7Pv19yew2kCksABmZ1YuRY306XcAkPbAP0VWrGTob01cxYK2utAL80JtWSNnrueOP8gY48VIbAszlOl5NNADWCCcdK/WAYnsGCGEsOEJYqeqlKxKHn6wqFaUI4lfpxqAmh19TfcbG0nJiooSWqYY0OyJDTn0+MA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by VI1PR04MB9812.eurprd04.prod.outlook.com (2603:10a6:800:1d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 11:49:52 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 11:49:43 +0000
Message-ID: <5fe07e68-b929-4713-9679-51b99858d7f8@volumez.com>
Date: Tue, 16 Jul 2024 14:49:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
To: Daniel Wagner <dwagner@suse.de>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
 <20240624104620.2156041-3-ofir.gal@volumez.com>
 <wgza656pr5scdqiaxi4vekoffp42jvzao5kcxy7zptdgwstyik@zfcgftuzn6pf>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <wgza656pr5scdqiaxi4vekoffp42jvzao5kcxy7zptdgwstyik@zfcgftuzn6pf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0007.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::7)
 To AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|VI1PR04MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d7c284f-cf37-4fa1-fbc7-08dca58d61bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YStMdEhXK1k1YWlZZjhnMzhjL0g2dGVpUVpjMHREWTZDMmJTRDlUbXdSZm1F?=
 =?utf-8?B?UENXN2d5Y1dNdyt5UHVVK0hyM0N4bGVxelM2OGtLRG4xRmk0c3M2OWg2UFE0?=
 =?utf-8?B?SXJnRU5wMkdjdjUvMnJHWGFabzVjaDlQNkk2L212Y0REd2NucElYaGl6L2pC?=
 =?utf-8?B?R1psTnlCSmc4eTllaHplOHAza3lEVVcrdWN3R1JvL1NQZlk3SmEzS0VlNXpX?=
 =?utf-8?B?TDN2cklUWmRlTWlKM1VNZEh5SzVuUTBuaU5HSk5NeEV0dXIwYmZ4QUliQTRR?=
 =?utf-8?B?b2FrVHR0bi8vbForSHRHOEJkdVRhdHJ3WXBYUUlnVFEvNEc3emxFaXdKMUs2?=
 =?utf-8?B?ODdBNUZCbENUb2ZPeTNNbHRjVFU2RjFpOVo2aHhlWHdlUVY5dWVBMXdWc25Q?=
 =?utf-8?B?aFdhNDU3eVIvVDErUU5LaHhnZG0vMFI1UXZUWlU5NUdxTnlYbWVoakl1TFlr?=
 =?utf-8?B?dFJYL1RWWldBaG5sbWhkRHNlbXZONmRRNUtoU05namc1SjRYUjNXNXNlWWsz?=
 =?utf-8?B?M09jTFMxTGxvK1BLWUxxSlJwd0ZxZDVMekowdlgyRFY4TDVrL3NGQ3JKQUlJ?=
 =?utf-8?B?dFVwL0pBYnVuSkpYWGVKTUxnWENlZTYzZFpqZkJpaCs3Mkt3Q3E0WUJwaThh?=
 =?utf-8?B?UW10OExuZFhGb0ZVazRlUGZTN0pobUZId0JURzFnTC94aFh2MDNiRjFhUVV2?=
 =?utf-8?B?T3JTd2NSdldmUDYxLzNyR0l6V1BCWGJXQVRGdUVWNXNCWUR4MVA2MjdicERG?=
 =?utf-8?B?eTRpZWtNengvVnNSNzZiblpDb3lUOWVWSUNGZlVkR2JlQVhtL0l0T2VCSzVu?=
 =?utf-8?B?RUgyeEZMaE96bDJGYktuYVoxTFIzNkFNZ2x0djhmYzVZdnYwTkZZM2Rpb0pG?=
 =?utf-8?B?MWNvcU1wQVJndHRlSTF1dEpLTXZaa2U0Nm5yUVVvUGRFU1o3c0twcU5aK3ZB?=
 =?utf-8?B?V3V6bUQwNzFHVWZ6VlNDYm1XWllYOUY0T3FNWHorQ3lkKzdkTXlWMzNlSEdC?=
 =?utf-8?B?MzBLOE5CdXpXSDdFQVZndVNDVDVDbkNWajI3MUlLalNlVWZpUTUzM2Q4MS9j?=
 =?utf-8?B?K09jemMzbnByd1MvcHJacjM5Z2VtQ0hLajFoTUJIcU4xcHd0V1h3RDJ3K0wx?=
 =?utf-8?B?OExlWW5wUllPZ2w3bVVOQXI5U1cwMlJGanBrSGhUcVJrdmQwZHRQWWZwZE5W?=
 =?utf-8?B?VVhPdk1JdVVOYnhuNjk3RWxQdWRRR1dWQjVXWS9ETHZ6NE4vYi9kRGhSTmgx?=
 =?utf-8?B?OW13dEJRMG8yY1ZEZ2c4Q1JZa29mRXlkQmZDcmUrK2c3RmlLY0tuM1Z1NXZU?=
 =?utf-8?B?SGczK2FkVWdjejVQZ2l4MEdHeGp0bndnaXJuY0FkVXdoT1ZUa1FScFlicEcz?=
 =?utf-8?B?MktLYUpyc1VKNW96a1RLbEdNWnhGMUVwT2lNZjJiQUllTk9mSlZnL1pQVFkr?=
 =?utf-8?B?QW5RWHZKQmk0eDJlLzYvL0xVU2dReG9mQW00YXczZWY0RERtRmRPVjVjd2lw?=
 =?utf-8?B?RjB2cGRYaUxSaTU0cS9DR2lzTGpwTjNCZm5SeS9pR3czNHNTRzVkUkZQSzRz?=
 =?utf-8?B?NzJsZ3gyR0NPUDlmSFJYY2hXUmt2cTBjQ3RteSt5bC9FUGJBT3VBWFUyWTd3?=
 =?utf-8?B?cWh2MDdwVkcyWWVEbG5kK1BaSE5tVzhoVXZSeVFZd0RrZzRTSzRvaEhrVGdQ?=
 =?utf-8?B?QnNjT0pZOG9tUmhQaDFaaHhtS1lzVnd3czMrTGhidFBtSlZYU0U0Zy9ST0F0?=
 =?utf-8?B?aHpDeEFRK2dWUmY0VTlVS29VU3FpdmhmL042dFpud0pQNkdLQUtIN0dnOUNj?=
 =?utf-8?B?Wk1KUXlrWGpUSDBzSWhEUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW9iSWlGNGgwT1l1RVFZbTlyV0l3ZnNPWHhDdmtnUzluUklwQzJWaDFKTkMz?=
 =?utf-8?B?UHorVHUwNFhqSi8xZEFkYnRzZkVneUpTY08vVjNQcmNtdmcvUDRveHc4cE1E?=
 =?utf-8?B?UzE1V3BpSW1Gamh0TjZhTnd1Z0pvZW5QVXZBR0FoeE5PSnluOTlRMGtuV2Jo?=
 =?utf-8?B?KzY5anF0bnBISDh2b2hMU0gwMjVnNmMyTURNSVBWdTlHY0Nob1FjOTJsSEZa?=
 =?utf-8?B?Q2lObWs4bWRKRGdWemdDR3JjMEZzdkc4L3VESlgyeXppY2V4VW9OWmRsSlp1?=
 =?utf-8?B?S2duMlNSWUdza005c2U0bm5LQ1lLMSt4UjNOUGgvdGpKLzc1aEpRVU5JSWJa?=
 =?utf-8?B?UEh5cGxFN3RKeFltb1JWcW1pM3g2dkMwZUNPY1RSQTlHekNEazF1ZEp2aFlm?=
 =?utf-8?B?K1R2S0FUTTIwV09sS0tMeVZPRjN4WE5EemdTbGh2U1Mzek5OSk44ajNpNHpG?=
 =?utf-8?B?N3JOTEdRYW5mdjZPNlEvaFkycjFKQ1BiYkFIcy9kNHZJZjdoK1pTaDJ6cy9R?=
 =?utf-8?B?dXVRUUtxRzgyb1Y2cnJ1Tk9LY2twaFJ5TDlTWXpoYmY3ZGxkTGFoRXNJU1Fx?=
 =?utf-8?B?MWM2NkhUTjJsajJ3RUREMkRFSC9kWk9Xem5lK0VwSlMwVDlEMFkyZkFIblc5?=
 =?utf-8?B?K0ppazJzQ05EVTE5R0ZaOXh4ZE9BaVBSbFZZQ3JjRktXZkFKMDVlMWtyTU5R?=
 =?utf-8?B?TW5HU29tREVGQkxFdVB1eEloaHNuV3gwWGVEVkN2WDFtZjNHQ24zMEdlOU1W?=
 =?utf-8?B?QTVyNWk2bzVHL0tBQWczV1l2bDBCUmQ5cEFJOE5reUV0clNWTnZUZk1rUG0z?=
 =?utf-8?B?aDZoSDJDRUZZazluK0RoQUdsSWx2Rkw2RkY5MERYd3EwUjhHUUVNMHFtQklp?=
 =?utf-8?B?NEVLcGw0QlFMbzZtMGFWbFM4S0UvSmlRdEZxNExsZlRLbVJucWJpVkdQWEFC?=
 =?utf-8?B?eXFhTXJlazRPYlFwdmlrUHZETlFxNTNHS0dJdk5xcWtsRHZEeWJEQjMySERX?=
 =?utf-8?B?azR3VTV5ZXlRdWJsWDB1MWo3MkRMQUJzT1BLd2M1dWJSNVFjV0xsVkJVK1pY?=
 =?utf-8?B?Y1hBbE13VEthMThNbkRJcDlvbElWbzJqTlZjS25yWk9wNElaM2l5TXV2KzB6?=
 =?utf-8?B?VFhmQmVsMk82ZW9Oa0pFRjU4VURMZWdDRkZid1REdW1tYVFqWCtqTTJFd3A3?=
 =?utf-8?B?OEp0bCtTOXErWUQzbGtZYVNLWlFYaTNBR0l2cVB4T3c1YkJUekVkWEkrQ2hk?=
 =?utf-8?B?SFhabmt3cG1pV3I1REx3L01RamV5OGg5K0VXeSthZGxLNFlHT3V6WTFjRTVn?=
 =?utf-8?B?dTIxSHRrRWxUTTFNWURldXE1UzRONHhNVFB3a1BNZ2t0VDJiV2ZXSk5yQ2VF?=
 =?utf-8?B?M2xJUkZud1l1SDV2YlFZZTZuRVJGYXBpTGNreURjd2R5UEVKUTdDNXAyazhw?=
 =?utf-8?B?ZWNlMW01SWJzRU5XUkg1dE55QUhUMERTWWY3RS9UN3hhWHN0NmQ3RkpjeGxF?=
 =?utf-8?B?djM3ZXRHN2p1SWpzWjg5VEFiOXBFZFdpeEgxaEg4d0pwOS8xSnN2WEQxV3h3?=
 =?utf-8?B?Y3pOcEhBdTE3VVNORnB2d1QzSmNGUnB6bzUvVXoxK084RTBRdSsvejJyYTU3?=
 =?utf-8?B?Z01TYTJ5TmNsVm5KRy8yYmNpWDBPU3VyYTAyNE5vZi9wL3diMlhwQU8xVlZs?=
 =?utf-8?B?YUdMdFJ0ZThuY2JIdTFVY3pWbDdVYTFzWVVkbVBnOFU0ZXJpeWNObjBGOGJV?=
 =?utf-8?B?UVZ1UDBZb1E3VkdyMVVBbE1LUnZ5Y0lmbmREQjNjNTFJWnplbFN0VTEwVnBi?=
 =?utf-8?B?a0FlQm9KT3FNYVhHZ3JzSmpPbVhPenB1Qm9PMlgzczYySGFCK2tpemFUZjR0?=
 =?utf-8?B?aDZ0TFBBSThwZjl0aVFNUE9sdDQ3ZHB2QUlqaDBrUVBKRDc0N3o5MzJJWWtx?=
 =?utf-8?B?aUV3anNaZi9GRklWYzZ6dWlWc1p6VkVrTEk4SWNoL1h1S2tPdzI3Z21LT00w?=
 =?utf-8?B?Z3VvVjlNL21wTmxGWmRaTkZLNUtRRndGVS9iZXVxRmF5Rm5sSGRFN0U2bmF0?=
 =?utf-8?B?cTVSNjIvU2pwODhlODdubUlpcGVBWUJxSWxqRWk4dFJoSFl2bnY0Rng0Zm5i?=
 =?utf-8?Q?hNpFb1T82KDpM4kjeyT0Qi2BW?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d7c284f-cf37-4fa1-fbc7-08dca58d61bc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 11:49:43.0241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urS/ikX9g9hHYGTaHnJAwcX01Zw3W37pR+0RibDHGCCnLJUByUzGr5IBHD5xurxaH5QrT4L9Zh2egYD9gVsRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9812



On 6/25/24 18:01, Daniel Wagner wrote:
> On Mon, Jun 24, 2024 at 01:46:18PM GMT, Ofir Gal wrote:
>> +#restrict test to nvme-tcp only
>> +nvme_trtype=tcp
>> +nvmet_blkdev_type="device"
>> +
>> +requires() {
>> +	# Require dm-stripe
>> +	_have_program dmsetup
>> +	_have_driver dm-mod
>> +
>> +	_require_nvme_trtype tcp
>> +	_have_brd
>> +}
>> +
>> +# Sets up a brd device of 1G with optimal-io-size of 256K
>> +setup_underlying_device() {
>> +	if ! _init_brd rd_size=1048576 rd_nr=1; then
>> +		return 1
>> +	fi
>> +
>> +	dmsetup create ram0_big_optio --table \
>> +		"0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
>> +}
>> +
>> +cleanup_underlying_device() {
>> +	dmsetup remove ram0_big_optio
>> +	_cleanup_brd
>> +}
>> +
>> +# Sets up a local host nvme over tcp
>> +setup_nvme_over_tcp() {
>> +	_setup_nvmet
>> +
>> +	local port
>> +	port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +	_create_nvmet_subsystem "blktests-subsystem-0" "/dev/mapper/ram0_big_optio"
>> +	_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-0"
> Use the defaults from blktests, e.g. ${def_subsysnqn}"
>
>> +
>> +	_create_nvmet_host "blktests-subsystem-0" "${def_hostnqn}"
>> +
>> +	_nvme_connect_subsys --subsysnqn "blktests-subsystem-0"
>> +
>> +	local nvmedev
>> +	nvmedev=$(_find_nvme_dev "blktests-subsystem-0")
> here too
>
>> +	echo "${nvmedev}"
>> +}
>> +
>> +cleanup_nvme_over_tcp() {
>> +	local nvmedev=$1
>> +	_nvme_disconnect_ctrl "${nvmedev}"
>> +	_nvmet_target_cleanup --subsysnqn "blktests-subsystem-0"
> same here
>
>> +}
>> +
>> +test() {
>> +	echo "Running ${TEST_NAME}"
>> +
>> +	setup_underlying_device
>> +	local nvmedev
>> +	nvmedev=$(setup_nvme_over_tcp)
>> +
>> +	# Hangs here without the fix
>> +	mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
>> +		--bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
>> +		/dev/"${nvmedev}"n1 missing
> Instead hard coding the namespace ID, this should be made a bit more
> robust by looking it up with _find_nvme_ns.
Thanks, applied comments to v3.
