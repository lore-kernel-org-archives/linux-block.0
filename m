Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020114.outbound.protection.outlook.com [52.101.69.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B72F197A91
	for <linux-block@vger.kernel.org>; Tue, 16 Jul 2024 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721121807; cv=fail; b=MY0Dx/IaJfj8L+13LMNBN0tKLtNic8zkC62TtHI7WrKHJgRvm9znRRdXXjOv0MSkKg0JbIUIc/3R0l93LFGxIuY3KGtc4bs6C9Mhap0bYl4gHMB1+THxHQ1Vco+qyRH0Bx3oJEQ8bOVL3RPbwI9FzpEuxwN6YRX6xq6go8HNEPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721121807; c=relaxed/simple;
	bh=glQuJapnEauddMWhlRAVO+ivNkfD4M4E5zQEGufMqLg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u3S/0IRt0lhPE3ITfMX2wwFCpFJu6YGLIRAIshCCtukD0DRj0LwBVyDcCCCjkq76b8l1l/1i58YUmc130EtCtG791K47GBVaIXdjH1KY9VRUDPfOpq9Wp+QreI7oqY6YM/CHMW/A7wiqsjJiZtXXqL1CFiC5bL6HSmpgGdGJWbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=G9KHXbxS; arc=fail smtp.client-ip=52.101.69.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="G9KHXbxS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQGO8rsVtL2p6fqcdZWeY+vQMKoPRB6B4WcHBUCJTwgOKoJkz5P2E6yD06MW6AYdG8IexXEo4ZOtkIcYGOfoLNH0XLvFrbSB5mTxoELP1zeg4kSUrkl9DG1HGawk2eOyqRsnWkToFYQWDcKFtfto2ipZbiCGFQm4iZc2rq+B4RhBOovV/8xQ4D3yBBXIp+oFoW8GvG0Md2X+EtXSh4nHeFwFGjSO9zS1fbpvIiLLvGovJgIidCiD18gO1N1IhRZ3asfh58HJhlzZUSmSS8rLBH10k8x5Z0pGi8ZPuvokMmT0JmyKRAbYFudFIBmeLDNxmlszYmP4To+xGXL4tWtXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glQuJapnEauddMWhlRAVO+ivNkfD4M4E5zQEGufMqLg=;
 b=TN/L5e8n2GZ6veZcJKpQLsrUEu6KYalKA+UCEzllj5674qwfkEKP8HtEEbY1ZvJ2UK9vNPcHn2wEQJXr35cR59Sq3U8sg/6B9M4dfVOdaUslyHa7yxq7b3NqF4+ywj/xIa+JssnULnk/e2TwtVTCIDGjzho93VdR+EmJB0qa1ZPd538Z6dmGeYmHj1M3tTDdjk8VF1iNRw1wBSMoSLwu5CWbaU5xlpeddBg7uVAjJLfW8n9SEeOTuTQ8UwNGjtl/J73V12RkfYtrB6azJegotc64u4Obte50N7cBLcglI3tUNqAN5TuvqBdZOOHqsfMpXv+3DkGJmlyduZoRqckmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glQuJapnEauddMWhlRAVO+ivNkfD4M4E5zQEGufMqLg=;
 b=G9KHXbxS7pbrNhw37zHYHYE24KYCiAjfhLijjnCt7kx7VlI02pDvehqDbXfh6hIqfl3VenWlZdg5M2/3k2NJ2Q9Y0HxMEZCtYIi7J7wWbMx0PQD3W4AjOaXgA6kJVj1DNoYp7YcKtr9zLvESXkIjrtPFwmH2nzhaR6/5tp6bo6BKxnI6b4+qkTCsWRelpyc3vhbeg20cfthQFLB+//VO9wesqdnftbncoUqtx+qnj9k+h2g6ZI/BsPGsI1Akq6IcYcWCkBIrKf9hoi49DRg2SRilgZt2SGpsvYyCWxbOw9SedBpGj0Z6AwmPDDC4kFnXfWD7xb4ocqj1kgvuX8/w2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Tue, 16 Jul
 2024 09:23:19 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 09:23:19 +0000
Message-ID: <52ac9125-d5a3-4e5c-8708-875c845a05c2@volumez.com>
Date: Tue, 16 Jul 2024 12:23:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 1/2] nvme: move helper functions to
 common/nvme
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
References: <20240624104620.2156041-1-ofir.gal@volumez.com>
 <20240624104620.2156041-2-ofir.gal@volumez.com>
 <g5ob2s5hhobdr3nwbv6bdt5yg7ca4jff6g4w5nrkaqac3ozu4s@lhre6wr43bub>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <g5ob2s5hhobdr3nwbv6bdt5yg7ca4jff6g4w5nrkaqac3ozu4s@lhre6wr43bub>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::12) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|AM9PR04MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c968da1-4a91-401a-f1de-08dca578ee34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWE5SE1SbC83VmZ1Y2VmYS9oaCtWQ2FHcGIwQVlQWk41K0dOV1ZUV1FuN0RG?=
 =?utf-8?B?ZmdzNzBoSWs0eTVxaWVIbXRIQklaUTZuZ3ZoUUUwMno4YWIzNkdMNndYaGtk?=
 =?utf-8?B?NndwOGdWeUJCeFRXU0JvNm9JOFlobGdyZlRqd3hPUml0SmxMV3g3a2w0WU9l?=
 =?utf-8?B?UEUyUjRFRmlqQ1gwUHd2MVpOc0NKd0FuN1ZDTFpWa3ltcXU3UEtTMSs1eEow?=
 =?utf-8?B?RzgzK3RtcUhoa0FMQkx0TjVsWXNCZmdKaFVKOHZhTXBNSlRZRVNmM2RzZThm?=
 =?utf-8?B?bG9Fd1VGOGh1bGkrMnROQWxKT3hRamFtSlR2dWJGQkFwRTc0VjRBbzlWcUxy?=
 =?utf-8?B?VE5MT1llMTJFSjBvNDFUN1FEVEdYaFB2djBrRW1rVHNYbktwRW5iVGdOODNT?=
 =?utf-8?B?dDU1cDI2YUlNYzRUb2kwM2J3UGRyU1pVU0VkZ0gzYTNGYkZWN3VOUTFMTVRn?=
 =?utf-8?B?V3R5WkRXMmRvRHd2d3B2Yi95K2pVY0FVd0o3NUtCL1o5Y3lrMmliR0V4TmVE?=
 =?utf-8?B?aDMrb3BrQThFQkQrTFZMTGhKeHQ4clNoMThIYXh4bVROaTh5OW1rRVVvOWp6?=
 =?utf-8?B?SlN4SkRZaklVdUtqSElrbzljS0VGdWtUbTh6WUxLcGo5NGZ2TFNmRDQ3REdB?=
 =?utf-8?B?aXkrZXVxS3I1SGpVL1h0VmFPbVc4U1ZJbVY3NVFvZTNRV3NqVzliSk1teDYr?=
 =?utf-8?B?S2NhekMzMXFmdWFDWjZ4VEpRVlZWNGlOcHpqWUVtYVZMRHNWbnkrWE1BZ0xI?=
 =?utf-8?B?WThRaEdHWWdsczR2eDg0cXZmSlhpelpHVy9tcVRzekRZTXE2MjB4LzF4dEZB?=
 =?utf-8?B?YnNMK2tDMDNTU0FmdEJGbHY1bHJHZzYvMVlwNUw5bGhLcFdOYW11VHpYbVFO?=
 =?utf-8?B?MGM4SnREK0FlQ3hydTBuOUdGNnFLczUrRW5TMkdnUWVRV2g3SG5ZclpyQVdC?=
 =?utf-8?B?ZllQOEQrK2tmRUQwSnV1cGY1WEIxSFErSndxeDZrNjlqN29BREk4dzJtaUVB?=
 =?utf-8?B?eXdvMHQ3Q3ZENG8wcytwSEIwSnVrTjAzaHpnUzN6U2R2WWVuaEE1eGxRRzNI?=
 =?utf-8?B?bXVidFVweGpTSXJRSVNtbHY1M1ZoMk9MS1ZmMnR1UjFMY29DTWJPZXhZTllQ?=
 =?utf-8?B?TjNkUFNQRktqL2xETmVacUxuOFUxV2RqK082QjMrdElHQ3NwZTJjMkJzWVdD?=
 =?utf-8?B?REg3Z0l3Y05VcVJ5cnJKZ0dWRDZtNU0zM0hqRHZmTzJyeXp5RTRFU1RXamdR?=
 =?utf-8?B?Yk9XNTNuMjJzK3dIWEJLSHlFUU1tdUx6ekRRUm9XWkF2US9hUU83T1JkV2Ew?=
 =?utf-8?B?TWwzMThFN016WXRVZGZWN0tya0dwYzcrSGVTRlJaUWgzODhCRWdpeTFZZVhv?=
 =?utf-8?B?ZWNvRjd0YmhyQy9wZFNkOThzKzRQZ1JzL2kxNm1PU3c2T3FabEJMS0lLa1pU?=
 =?utf-8?B?SURPLzMyejc1TExjOGlzYXhaWnV1cGZ4VndmVS9BaW40WFJlcWpKV3dadDdn?=
 =?utf-8?B?VzBhVmxoNm9HaDhHT0FkenR0cDBJdXlkWGs4ZlBjbVZBVFplWUNRN1E0Zkps?=
 =?utf-8?B?eEdIblliS1hTMWp4bWdjaVZUY2dBTGVnMmhwa3BUd0E2N2wxajZkeXcrM1Jx?=
 =?utf-8?B?R3ZTRjNMQTRxaXpZbys1ZGU5RXUvelMyYmlnb29tSXBmTmpQSHJCbkc0eGVV?=
 =?utf-8?B?MisvMWI3MitWb3VORmNVOEVoVTV5VkE3Y3FnUTNtRUhmTDZITjZwVFZwY3o0?=
 =?utf-8?B?Q3VObUxyMGcrWDBpdElnbkh2TnEwYlFwREovMHNCc2xLOEpsT0ZUeHdncnFR?=
 =?utf-8?B?RXV1eHFCRzZDT3VzbXFzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWpZQVhIa2FoRjZtNHRvWklvSHBtaHBZdmpQaEZ3cEh0MWJsWUJsL0tlSjhJ?=
 =?utf-8?B?akFmUklPOFNPRFhRZjlEbFNYRCtBdGxObFFNTjhuQU4vL0pHckFmbWN1KzVs?=
 =?utf-8?B?UkVOQkhGU04xc3U0SDBSeURiUkVGQklwVnFNRzNtL0FxWFhGNmdISXM0ejJv?=
 =?utf-8?B?eFVaOGcxT3JzUTNHemhyMFdQc0FkRU9QVDA0Z0gwVzVNYkhtd21mTEE1OENY?=
 =?utf-8?B?WGZ6MFFacHNwaTUzOS9LWXo2UUlMVTZvYnBLZ3BkVEVocnp1WTFGNXdFUkFC?=
 =?utf-8?B?Q1ZCVjVCSVNOWEZPNWJaS1gwc2Y3U01pVzVjOWRVdFpTdW5pN0NiSHJZa1F5?=
 =?utf-8?B?T0F6Smtvc2xTYld4dGw1aFBJdG9ITFh4Y0xNc0kxUWJyYmJQUVd5bi9pYzdk?=
 =?utf-8?B?bU5tRWdBanRndjdDRzBBK1pDYXpJOThMUTlRTEV1VzJSdG1mSTZQZUJTQ3lr?=
 =?utf-8?B?OHhzd0NFdHozYXB0TUhteitQR2pZRWhRSWZvamZNTzVMait1cWZBbGxFaWox?=
 =?utf-8?B?YmpIL0x2SjZ4UFIrTE53UE5XcTZCTnNjNEtUTVFFRDMyakRlVmlIMHJPRjZ0?=
 =?utf-8?B?c0hCUkRxRXhCLzRac1owWndOVkxpT0ExT0E0UXRUU2NBdEZ4cFE1VGg0dExw?=
 =?utf-8?B?MlluSitzTXBnYUJmbnNzOE1xeFF0ZjRjbUh3UG9qaHhaK1lYaWp1WC96bjZT?=
 =?utf-8?B?Qi9hcGVtT0RLcTJWUzZLMThFaDgraTltcWY2REFxM1V4WTBscmhXTUJ4K2Y4?=
 =?utf-8?B?Tjc4bUNPNkc5M2tHa0Q0RmxCS01Bd2hlUGgxd1I0cGswY2llbjlnOCtKdkxu?=
 =?utf-8?B?L25vU3pFUTV1TjdSZjU4cjlOZU5hUWFWYUxJb1VXalY3bEJnM0o4bm5xYmx5?=
 =?utf-8?B?aFlSYVFxbTJCanVOdTZEdittKzd6VjU4eWRqbXBCeFQrWUM3MTdtcktEVVdP?=
 =?utf-8?B?SlNtbFNXWXlwVU4wenpCR04zbU5IMGdIM2xqdEtVcFkzL1Q5cEU1U294RWcr?=
 =?utf-8?B?NFNmQytKVnZGWHFPb1k0ZjRWeUUvZ2k0UHJ3U0hsRDFBSXZ1R2JuUmEwM0ZO?=
 =?utf-8?B?RnlMN3dFdk9OZFFSNi85M242MEMrcmZCeWdVaUdmQm5DcU1TOTB5YzZOaUY1?=
 =?utf-8?B?eDdMWnVVY0VDRVZWODdJWnZ6OGxuOUMxZmZrQXFRRUQwY2VWT0RvUkY0eEd6?=
 =?utf-8?B?dXRhUFd4T1kyNFo4SVliSElVNEtwRVFQeTYrWEYvRVgwL2tSOW40dUVVKzVr?=
 =?utf-8?B?Wjh6clYwOVJRWkMzLzNrKzJCY0taRnM5Y0QyYVpyUWhiN2EwYkV4dkpBdk1N?=
 =?utf-8?B?dmRJNklWNi9UTHRPeFhKVHRGVjFhUTRCWVZzdWZ5MHZIWkRxWHhiUkdMc2E1?=
 =?utf-8?B?cjNtZTUySWNNU3VCQjRWa2Z2cEFRS0l5TEVMN0lMcDVySXhTQzZuUytZVXl5?=
 =?utf-8?B?Y3RrQ0hKaUxOWHI1dVZtY2xxVXpDVVprc3NTL3FNd3I1SW1va2JQQjhtZHMw?=
 =?utf-8?B?NVgzc2RwdzdVSUVwVjJFbXF6REpuTklCZWt0c2dCbXltYUNjZXNEb09tQlFa?=
 =?utf-8?B?a0pEUmdVc2hIQTNObkNiSjRGOGVDcjNlelI4Tjk5aVpjTExLcFhFRHlwUUZG?=
 =?utf-8?B?UmFUdzA4WEJwVHIwZmJzNXlOdEtQbUoyWGJiL2VWWTFTeGpUd2ZpODV2RUlw?=
 =?utf-8?B?dGlaS29SOWIwS2luc08rd1hucFNlN0hxT3JSa3ZIdm9uYTVoNUIvV1RHR2ts?=
 =?utf-8?B?Qkl5M25BOEd6cnZWeFJYNnFiNWRmQXZiWDBVZEpZRkVsdTZpakE4SGlsNWxu?=
 =?utf-8?B?dkNLR1NlcU5oK1k1QXVDRlc0S0hVZmRlbmw3czZiTjJrVkU3T1ZJdzUyVFk2?=
 =?utf-8?B?YllYbXEvOHNUWWlXalFOVUxCRmxRYUlncGZZOFNteEUrakFuU3I5M1RnOWJk?=
 =?utf-8?B?b3ErVWd6Sll5dERrVDkySEdSbXg3MDBySGNKNVdSVG5hNEpMbm5iWFF5d1Mx?=
 =?utf-8?B?ZCtVYktFd05yOWV1MnB0Q2dCaXpkN3U3UGZwOHIrYmNhZWxvMUthMXA5K3BZ?=
 =?utf-8?B?Rk81cEhTVmdsQ3pncFdLa3VrV04xSXM3a0oyY2taNVBQZThqNWtqcHNROWtj?=
 =?utf-8?Q?cYklGB+6Faq/9Cb8YdjxI3Kkq?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c968da1-4a91-401a-f1de-08dca578ee34
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 09:23:19.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amZ1phrGyPtXyg3UNMZuayK2fJyLP4B7tml5HmA9VPspBzuCI9mZa9ldFmUsly0/5CMMyaFqaE3pQ2EGoS5RZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8505



On 6/26/24 14:18, Shinichiro Kawasaki wrote:
> On Jun 24, 2024 / 13:46, Ofir Gal wrote:
>> Move functions from tests/nvme/rc to common/nvme to be able to reuse
>> them in other tests groups.
>>
>> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
>> ---
>> I have moved the function that are nessecary for the regression test I
>> add. Let me know if we want to move more or all the functions to
>> common/nvme.
>>
>> shellcheck detects 2 new warnings:
>> common/nvme:35:10: warning: nvme_trtype is referenced but not assigned. [SC2154]
>> common/nvme:234:11: warning: nvme_adrfam is referenced but not assigned. [SC2154]
>>
>> I have tried to figure out why but I couldn't figure out what is
>> different than the upstream version. How can I fix them?
>
> Hi Ofir, thanks for this work. Please find two comments in line below. One of
> them suggests a fix for the shellcheck warnings.
>
Applied to v3

>>
>>
>>  common/nvme   | 595 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>  tests/nvme/rc | 591 +------------------------------------------------
>>  2 files changed, 596 insertions(+), 590 deletions(-)
>>  create mode 100644 common/nvme
>>
>> diff --git a/common/nvme b/common/nvme
>> new file mode 100644
>> index 0000000..1800263
>> --- /dev/null
>> +++ b/common/nvme
>> @@ -0,0 +1,595 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +#
>> +# nvme helper functions.
>> +
>> +. common/shellcheck
>> +
>> +def_traddr="127.0.0.1"
>> +def_adrfam="ipv4"
>> +def_trsvcid="4420"
>> +def_remote_wwnn="0x10001100aa000001"
>> +def_remote_wwpn="0x20001100aa000001"
>> +def_local_wwnn="0x10001100aa000002"
>> +def_local_wwpn="0x20001100aa000002"
>> +def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>> +def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>> +export def_subsysnqn="blktests-subsystem-1"
>> +export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>> +_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
>> +_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
>> +_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
>> +nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
>> +NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
>> +NVMET_CFS="/sys/kernel/config/nvmet/"
>
> As for the shellcheck warnings, I suggestto add two lines below here to suppress
> them.
>
> nvme_trtype=${nvme_trtype:-}
> nvme_adrfam=${nvme_adrfam:-}
>
Thanks, applied to v3

>> +
>> +# TMPDIR can not be referred out of test() or test_device() context. Instead of
>> +# global variable def_flie_path, use this getter function.
>> +_nvme_def_file_path() {
>> +    echo "${TMPDIR}/img"
>> +}
>> +
>> +_require_nvme_trtype() {
>> +    local trtype
>> +    for trtype in "$@"; do
>> +        if [[ "${nvme_trtype}" == "$trtype" ]]; then
>> +            return 0
>> +        fi
>> +    done
>> +    SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
>> +    return 1
>> +}
>> +
>> +_require_nvme_trtype_is_loop() {
>> +    if ! _require_nvme_trtype loop; then
>> +        return 1
>> +    fi
>> +    return 0
>> +}
>> +
>> +_require_nvme_trtype_is_fabrics() {
>> +    if ! _require_nvme_trtype loop fc rdma tcp; then
>> +        return 1
>> +    fi
>> +    return 0
>> +}
>> +
>> +_nvme_fcloop_add_rport() {
>> +    local local_wwnn="$1"
>> +    local local_wwpn="$2"
>> +    local remote_wwnn="$3"
>> +    local remote_wwpn="$4"
>> +    local loopctl=/sys/class/fcloop/ctl
>> +
>> +    echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn},lpwwnn=${local_wwnn},lpwwpn=${local_wwpn},roles=0x60" > ${loopctl}/add_remote_port
>> +}
>> +
>> +_nvme_fcloop_add_lport() {
>> +    local wwnn="$1"
>> +    local wwpn="$2"
>> +    local loopctl=/sys/class/fcloop/ctl
>> +
>> +    echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_local_port
>> +}
>> +
>> +_nvme_fcloop_add_tport() {
>> +    local wwnn="$1"
>> +    local wwpn="$2"
>> +    local loopctl=/sys/class/fcloop/ctl
>> +
>> +    echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
>> +}
>> +
>> +_setup_fcloop() {
>> +    local local_wwnn="${1:-$def_local_wwnn}"
>> +    local local_wwpn="${2:-$def_local_wwpn}"
>> +    local remote_wwnn="${3:-$def_remote_wwnn}"
>> +    local remote_wwpn="${4:-$def_remote_wwpn}"
>> +
>> +    _nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
>> +    _nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
>> +    _nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
>> +                       "${remote_wwnn}" "${remote_wwpn}"
>> +}
>> +
>> +_nvme_fcloop_del_rport() {
>> +    local local_wwnn="$1"
>> +    local local_wwpn="$2"
>> +    local remote_wwnn="$3"
>> +    local remote_wwpn="$4"
>> +    local loopctl=/sys/class/fcloop/ctl
>> +
>> +    if [[ ! -f "${loopctl}/del_remote_port" ]]; then
>> +        return
>> +    fi
>> +    echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > "${loopctl}/del_remote_port"
>> +}
>> +
>> +_nvme_fcloop_del_lport() {
>> +    local wwnn="$1"
>> +    local wwpn="$2"
>> +    local loopctl=/sys/class/fcloop/ctl
>> +
>> +    if [[ ! -f "${loopctl}/del_local_port" ]]; then
>> +        return
>> +    fi
>> +    echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_local_port"
>> +}
>> +
>> +_nvme_fcloop_del_tport() {
>> +    local wwnn="$1"
>> +    local wwpn="$2"
>> +    local loopctl=/sys/class/fcloop/ctl
>> +
>> +    if [[ ! -f "${loopctl}/del_target_port" ]]; then
>> +        return
>> +    fi
>> +    echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_target_port"
>> +}
>> +
>> +_cleanup_fcloop() {
>> +    local local_wwnn="${1:-$def_local_wwnn}"
>> +    local local_wwpn="${2:-$def_local_wwpn}"
>> +    local remote_wwnn="${3:-$def_remote_wwnn}"
>> +    local remote_wwpn="${4:-$def_remote_wwpn}"
>> +
>> +    _nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
>> +    _nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>> +    _nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>> +                   "${remote_wwnn}" "${remote_wwpn}"
>> +}
>> +
>> +_cleanup_blkdev() {
>> +    local blkdev
>> +    local dev
>> +
>> +    blkdev="$(losetup -l | awk '$6 == "'"$(_nvme_def_file_path)"'" { print $1 }')"
>> +    for dev in ${blkdev}; do
>> +        losetup -d "${dev}"
>> +    done
>> +    rm -f "$(_nvme_def_file_path)"
>> +}
>> +
>> +_cleanup_nvmet() {
>> +    local dev
>> +    local port
>> +    local subsys
>> +    local transport
>> +    local name
>> +
>> +    if [[ ! -d "${NVMET_CFS}" ]]; then
>> +        return 0
>> +    fi
>> +
>> +    # Don't let successive Ctrl-Cs interrupt the cleanup processes
>> +    trap '' SIGINT
>> +
>> +    shopt -s nullglob
>> +
>> +    for dev in /sys/class/nvme/nvme*; do
>> +        dev="$(basename "$dev")"
>> +        transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
>> +        if [[ "$transport" == "${nvme_trtype}" ]]; then
>> +            # if udev auto connect is enabled for FC we get false positives
>> +            if [[ "$transport" != "fc" ]]; then
>> +                echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>> +            fi
>> +            _nvme_disconnect_ctrl "${dev}" 2>/dev/null
>> +        fi
>> +    done
>> +
>> +    for port in "${NVMET_CFS}"/ports/*; do
>> +        name=$(basename "${port}")
>> +        echo "WARNING: Test did not clean up port: ${name}"
>> +        rm -f "${port}"/subsystems/*
>> +        rmdir "${port}"
>> +    done
>> +
>> +    for subsys in "${NVMET_CFS}"/subsystems/*; do
>> +        name=$(basename "${subsys}")
>> +        echo "WARNING: Test did not clean up subsystem: ${name}"
>> +        for ns in "${subsys}"/namespaces/*; do
>> +            rmdir "${ns}"
>> +        done
>> +        rmdir "${subsys}"
>> +    done
>> +
>> +    for host in "${NVMET_CFS}"/hosts/*; do
>> +        name=$(basename "${host}")
>> +        echo "WARNING: Test did not clean up host: ${name}"
>> +        rmdir "${host}"
>> +    done
>> +
>> +    shopt -u nullglob
>> +    trap SIGINT
>> +
>> +    if [[ "${nvme_trtype}" == "fc" ]]; then
>> +        _cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
>> +                "${def_remote_wwnn}" "${def_remote_wwpn}"
>> +        modprobe -rq nvme-fcloop 2>/dev/null
>> +    fi
>> +    modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
>> +    if [[ "${nvme_trtype}" != "loop" ]]; then
>> +        modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
>> +    fi
>> +    modprobe -rq nvmet 2>/dev/null
>> +    if [[ "${nvme_trtype}" == "rdma" ]]; then
>> +        stop_soft_rdma
>> +    fi
>> +
>> +    _cleanup_blkdev
>> +}
>> +
>> +_setup_nvmet() {
>> +    _register_test_cleanup _cleanup_nvmet
>> +    modprobe -q nvmet
>> +    if [[ "${nvme_trtype}" != "loop" ]]; then
>> +        modprobe -q nvmet-"${nvme_trtype}"
>> +    fi
>> +    modprobe -q nvme-"${nvme_trtype}"
>> +    if [[ "${nvme_trtype}" == "rdma" ]]; then
>> +        start_soft_rdma
>> +        for i in $(rdma_network_interfaces)
>> +        do
>> +            if [[ "${nvme_adrfam}" == "ipv6" ]]; then
>> +                ipv6_addr=$(get_ipv6_ll_addr "$i")
>> +                if [[ -n "${ipv6_addr}" ]]; then
>> +                    def_traddr=${ipv6_addr}
>> +                fi
>> +            else
>> +                ipv4_addr=$(get_ipv4_addr "$i")
>> +                if [[ -n "${ipv4_addr}" ]]; then
>> +                    def_traddr=${ipv4_addr}
>> +                fi
>> +            fi
>> +        done
>> +    fi
>> +    if [[ "${nvme_trtype}" = "fc" ]]; then
>> +        modprobe -q nvme-fcloop
>> +        _setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
>> +                  "${def_remote_wwnn}" "${def_remote_wwpn}"
>> +
>> +        def_traddr=$(printf "nn-%s:pn-%s" \
>> +                    "${def_remote_wwnn}" \
>> +                    "${def_remote_wwpn}")
>> +        def_host_traddr=$(printf "nn-%s:pn-%s" \
>> +                     "${def_local_wwnn}" \
>> +                     "${def_local_wwpn}")
>> +    fi
>> +}
>> +
>> +_nvme_disconnect_ctrl() {
>> +    local ctrl="$1"
>> +
>> +    nvme disconnect --device "${ctrl}"
>> +}
>> +
>> +_nvme_connect_subsys() {
>> +    local subsysnqn="$def_subsysnqn"
>> +    local hostnqn="$def_hostnqn"
>> +    local hostid="$def_hostid"
>> +    local hostkey=""
>> +    local ctrlkey=""
>> +    local nr_io_queues=""
>> +    local nr_write_queues=""
>> +    local nr_poll_queues=""
>> +    local keep_alive_tmo=""
>> +    local reconnect_delay=""
>> +    local ctrl_loss_tmo=""
>> +    local no_wait=false
>> +    local i
>> +
>> +    while [[ $# -gt 0 ]]; do
>> +        case $1 in
>> +            --subsysnqn)
>> +                subsysnqn="$2"
>> +                shift 2
>> +                ;;
>> +            --hostnqn)
>> +                hostnqn="$2"
>> +                shift 2
>> +                ;;
>> +            --hostid)
>> +                hostid="$2"
>> +                shift 2
>> +                ;;
>> +            --dhchap-secret)
>> +                hostkey="$2"
>> +                shift 2
>> +                ;;
>> +            --dhchap-ctrl-secret)
>> +                ctrlkey="$2"
>> +                shift 2
>> +                ;;
>> +            --nr-io-queues)
>> +                nr_io_queues="$2"
>> +                shift 2
>> +                ;;
>> +            --nr-write-queues)
>> +                nr_write_queues="$2"
>> +                shift 2
>> +                ;;
>> +            --nr-poll-queues)
>> +                nr_poll_queues="$2"
>> +                shift 2
>> +                ;;
>> +            --keep-alive-tmo)
>> +                keep_alive_tmo="$2"
>> +                shift 2
>> +                ;;
>> +            --reconnect-delay)
>> +                reconnect_delay="$2"
>> +                shift 2
>> +                ;;
>> +            --ctrl-loss-tmo)
>> +                ctrl_loss_tmo="$2"
>> +                shift 2
>> +                ;;
>> +            --no-wait)
>> +                no_wait=true
>> +                shift 1
>> +                ;;
>> +            *)
>> +                echo "WARNING: unknown argument: $1"
>> +                shift
>> +                ;;
>> +        esac
>> +    done
>> +
>> +    ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
>> +    if [[ "${nvme_trtype}" == "fc" ]] ; then
>> +        ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
>> +    elif [[ "${nvme_trtype}" != "loop" ]]; then
>> +        ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
>> +    fi
>> +    ARGS+=(--hostnqn="${hostnqn}")
>> +    ARGS+=(--hostid="${hostid}")
>> +    if [[ -n "${hostkey}" ]]; then
>> +        ARGS+=(--dhchap-secret="${hostkey}")
>> +    fi
>> +    if [[ -n "${ctrlkey}" ]]; then
>> +        ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
>> +    fi
>> +    if [[ -n "${nr_io_queues}" ]]; then
>> +        ARGS+=(--nr-io-queues="${nr_io_queues}")
>> +    fi
>> +    if [[ -n "${nr_write_queues}" ]]; then
>> +        ARGS+=(--nr-write-queues="${nr_write_queues}")
>> +    fi
>> +    if [[ -n "${nr_poll_queues}" ]]; then
>> +        ARGS+=(--nr-poll-queues="${nr_poll_queues}")
>> +    fi
>> +    if [[ -n "${keep_alive_tmo}" ]]; then
>> +        ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
>> +    fi
>> +    if [[ -n "${reconnect_delay}" ]]; then
>> +        ARGS+=(--reconnect-delay="${reconnect_delay}")
>> +    fi
>> +    if [[ -n "${ctrl_loss_tmo}" ]]; then
>> +        ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
>> +    fi
>> +
>> +    nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:"
>> +
>> +    # Wait until device file and uuid/wwid sysfs attributes get ready for
>> +    # all namespaces.
>> +    if [[ ${no_wait} = false ]]; then
>> +        udevadm settle
>> +        for ((i = 0; i < 10; i++)); do
>> +            _nvme_ns_ready "${subsysnqn}" && return
>> +            sleep .1
>> +        done
>> +    fi
>> +}
>> +
>> +_nvme_ns_ready() {
>> +    local subsysnqn="${1}"
>> +    local ns_path ns_id dev
>> +    local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
>> +
>> +    dev=$(_find_nvme_dev "$subsysnqn")
>> +    for ns_path in "${cfs_path}/namespaces/"*; do
>> +        ns_id=${ns_path##*/}
>> +        if [[ ! -b /dev/${dev}n${ns_id} ||
>> +               ! -e /sys/block/${dev}n${ns_id}/uuid ||
>> +               ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
>> +            return 1
>> +        fi
>> +    done
>> +    return 0
>> +}
>> +
>> +_create_nvmet_port() {
>> +    local trtype="$1"
>> +    local traddr="${2:-$def_traddr}"
>> +    local adrfam="${3:-$def_adrfam}"
>> +    local trsvcid="${4:-$def_trsvcid}"
>> +
>> +    local port
>> +    for ((port = 0; ; port++)); do
>> +        if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
>> +            break
>> +        fi
>> +    done
>> +
>> +    mkdir "${NVMET_CFS}/ports/${port}"
>> +    echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
>> +    echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
>> +    echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
>> +    if [[ "${adrfam}" != "fc" ]]; then
>> +        echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
>> +    fi
>> +
>> +    echo "${port}"
>> +}
>> +
>> +_remove_nvmet_port() {
>> +    local port="$1"
>> +    rmdir "${NVMET_CFS}/ports/${port}"
>> +}
>> +
>> +_create_nvmet_ns() {
>> +    local nvmet_subsystem="$1"
>> +    local nsid="$2"
>> +    local blkdev="$3"
>> +    local uuid="00000000-0000-0000-0000-000000000000"
>> +    local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +    local ns_path="${subsys_path}/namespaces/${nsid}"
>> +
>> +    if [[ $# -eq 4 ]]; then
>> +        uuid="$4"
>> +    fi
>> +
>> +    mkdir "${ns_path}"
>> +    printf "%s" "${blkdev}" > "${ns_path}/device_path"
>> +    printf "%s" "${uuid}" > "${ns_path}/device_uuid"
>> +    printf 1 > "${ns_path}/enable"
>> +}
>> +
>> +_create_nvmet_subsystem() {
>> +    local nvmet_subsystem="$1"
>> +    local blkdev="$2"
>> +    local uuid=$3
>> +    local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +
>> +    mkdir -p "${cfs_path}"
>> +    echo 0 > "${cfs_path}/attr_allow_any_host"
>> +    _create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
>> +}
>> +
>> +_add_nvmet_allow_hosts() {
>> +    local nvmet_subsystem="$1"
>> +    local nvmet_hostnqn="$2"
>> +    local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +    local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
>> +
>> +    ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
>> +}
>> +
>> +_create_nvmet_host() {
>> +    local nvmet_subsystem="$1"
>> +    local nvmet_hostnqn="$2"
>> +    local nvmet_hostkey="$3"
>> +    local nvmet_ctrlkey="$4"
>> +    local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
>> +
>> +    if [[ -d "${host_path}" ]]; then
>> +        echo "FAIL target setup failed. stale host configuration found"
>> +        return 1;
>> +    fi
>> +
>> +    mkdir "${host_path}"
>> +    _add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
>> +    if [[ "${nvmet_hostkey}" ]] ; then
>> +        echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
>> +    fi
>> +    if [[ "${nvmet_ctrlkey}" ]] ; then
>> +        echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
>> +    fi
>> +}
>> +
>> +_remove_nvmet_ns() {
>> +    local nvmet_subsystem="$1"
>> +    local nsid=$2
>> +    local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +    local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
>> +
>> +    echo 0 > "${nvmet_ns_path}/enable"
>> +    rmdir "${nvmet_ns_path}"
>> +}
>> +
>> +_remove_nvmet_subsystem() {
>> +    local nvmet_subsystem="$1"
>> +    local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> +
>> +    _remove_nvmet_ns "${nvmet_subsystem}" "1"
>> +    rm -f "${subsys_path}"/allowed_hosts/*
>> +    rmdir "${subsys_path}"
>> +}
>> +
>> +_remove_nvmet_host() {
>> +    local nvmet_host="$1"
>> +    local host_path="${NVMET_CFS}/hosts/${nvmet_host}"
>> +
>> +    rmdir "${host_path}"
>> +}
>> +
>> +_add_nvmet_subsys_to_port() {
>> +    local port="$1"
>> +    local nvmet_subsystem="$2"
>> +
>> +    ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
>> +        "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
>> +}
>> +
>> +_remove_nvmet_subsystem_from_port() {
>> +    local port="$1"
>> +    local nvmet_subsystem="$2"
>> +
>> +    rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
>> +}
>> +
>> +_get_nvmet_ports() {
>> +    local nvmet_subsystem="$1"
>> +    local -n nvmet_ports="$2"
>> +    local cfs_path="${NVMET_CFS}/ports"
>> +    local sarg
>> +
>> +    sarg="s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
>> +
>> +    for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
>> +        nvmet_ports+=("$(echo "${path}" | sed -n -s "${sarg}")")
>> +    done
>> +}
>> +
>> +_find_nvme_dev() {
>> +    local subsys=$1
>> +    local subsysnqn
>> +    local dev
>> +    for dev in /sys/class/nvme/nvme*; do
>> +        [ -e "$dev" ] || continue
>> +        dev="$(basename "$dev")"
>> +        subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
>> +        if [[ "$subsysnqn" == "$subsys" ]]; then
>> +            echo "$dev"
>> +        fi
>> +    done
>> +}
>> +
>> +_nvmet_target_cleanup() {
>> +    local ports
>> +    local port
>> +    local blkdev
>> +    local subsysnqn="${def_subsysnqn}"
>> +    local blkdev_type=""
>> +
>> +    while [[ $# -gt 0 ]]; do
>> +        case $1 in
>> +            --blkdev)
>> +                blkdev_type="$2"
>> +                shift 2
>> +                ;;
>> +            --subsysnqn)
>> +                subsysnqn="$2"
>> +                shift 2
>> +                ;;
>> +            *)
>> +                echo "WARNING: unknown argument: $1"
>> +                shift
>> +                ;;
>> +        esac
>> +    done
>> +
>> +    _get_nvmet_ports "${subsysnqn}" ports
>> +
>> +    for port in "${ports[@]}"; do
>> +        _remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
>> +        _remove_nvmet_port "${port}"
>> +    done
>> +    _remove_nvmet_subsystem "${subsysnqn}"
>> +    _remove_nvmet_host "${def_hostnqn}"
>> +
>> +    if [[ "${blkdev_type}" == "device" ]]; then
>> +        _cleanup_blkdev
>> +    fi
>> +}
>> diff --git a/tests/nvme/rc b/tests/nvme/rc
>> index c1ddf41..3462f2e 100644
>> --- a/tests/nvme/rc
>> +++ b/tests/nvme/rc
>> @@ -5,25 +5,9 @@
>>  # Test specific to NVMe devices
>>  
>>  . common/rc
>> +. common/nvme
>>  . common/multipath-over-rdma
>>  
>> -def_traddr="127.0.0.1"
>> -def_adrfam="ipv4"
>> -def_trsvcid="4420"
>> -def_remote_wwnn="0x10001100aa000001"
>> -def_remote_wwpn="0x20001100aa000001"
>> -def_local_wwnn="0x10001100aa000002"
>> -def_local_wwpn="0x20001100aa000002"
>> -def_hostid="0f01fb42-9f7f-4856-b0b3-51e60b8de349"
>> -def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:${def_hostid}"
>> -export def_subsysnqn="blktests-subsystem-1"
>> -export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
>> -_check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
>> -_check_conflict_and_set_default NVME_IMG_SIZE nvme_img_size 1G
>> -_check_conflict_and_set_default NVME_NUM_ITER nvme_num_iter 1000
>> -nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
>> -NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
>> -
>>  _NVMET_TRTYPES_is_valid() {
>>      local type
>>  
>> @@ -70,12 +54,6 @@ _set_nvmet_blkdev_type() {
>>      COND_DESC="bd=${nvmet_blkdev_type}"
>>  }
>>  
>> -# TMPDIR can not be referred out of test() or test_device() context. Instead of
>> -# global variable def_flie_path, use this getter function.
>> -_nvme_def_file_path() {
>> -    echo "${TMPDIR}/img"
>> -}
>> -
>>  _nvme_requires() {
>>      _have_program nvme
>>      _require_nvme_test_img_size 4m
>> @@ -144,8 +122,6 @@ group_device_requires() {
>>      _require_test_dev_is_nvme
>>  }
>>  
>> -NVMET_CFS="/sys/kernel/config/nvmet/"
>> -
>>  _require_test_dev_is_nvme() {
>>      if ! readlink -f "$TEST_DEV_SYSFS/device" | grep -q nvme; then
>>          SKIP_REASONS+=("$TEST_DEV is not a NVMe device")
>> @@ -168,31 +144,6 @@ _require_nvme_test_img_size() {
>>      return 0
>>  }
>>  
>> -_require_nvme_trtype() {
>> -    local trtype
>> -    for trtype in "$@"; do
>> -        if [[ "${nvme_trtype}" == "$trtype" ]]; then
>> -            return 0
>> -        fi
>> -    done
>> -    SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
>> -    return 1
>> -}
>> -
>> -_require_nvme_trtype_is_loop() {
>> -    if ! _require_nvme_trtype loop; then
>> -        return 1
>> -    fi
>> -    return 0
>> -}
>> -
>> -_require_nvme_trtype_is_fabrics() {
>> -    if ! _require_nvme_trtype loop fc rdma tcp; then
>> -        return 1
>> -    fi
>> -    return 0
>> -}
>> -
>>  _require_nvme_cli_auth() {
>>      if ! nvme gen-dhchap-key --nqn nvmf-test-subsys > /dev/null 2>&1 ; then
>>          SKIP_REASONS+=("nvme gen-dhchap-key command missing")
>> @@ -235,216 +186,6 @@ _nvme_calc_rand_io_size() {
>>      echo "${io_size_kb}k"
>>  }
>>  
>> -_nvme_fcloop_add_rport() {
>> -    local local_wwnn="$1"
>> -    local local_wwpn="$2"
>> -    local remote_wwnn="$3"
>> -    local remote_wwpn="$4"
>> -    local loopctl=/sys/class/fcloop/ctl
>> -
>> -    echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn},lpwwnn=${local_wwnn},lpwwpn=${local_wwpn},roles=0x60" > ${loopctl}/add_remote_port
>> -}
>> -
>> -_nvme_fcloop_add_lport() {
>> -    local wwnn="$1"
>> -    local wwpn="$2"
>> -    local loopctl=/sys/class/fcloop/ctl
>> -
>> -    echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_local_port
>> -}
>> -
>> -_nvme_fcloop_add_tport() {
>> -    local wwnn="$1"
>> -    local wwpn="$2"
>> -    local loopctl=/sys/class/fcloop/ctl
>> -
>> -    echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
>> -}
>> -
>> -_setup_fcloop() {
>> -    local local_wwnn="${1:-$def_local_wwnn}"
>> -    local local_wwpn="${2:-$def_local_wwpn}"
>> -    local remote_wwnn="${3:-$def_remote_wwnn}"
>> -    local remote_wwpn="${4:-$def_remote_wwpn}"
>> -
>> -    _nvme_fcloop_add_tport "${remote_wwnn}" "${remote_wwpn}"
>> -    _nvme_fcloop_add_lport "${local_wwnn}" "${local_wwpn}"
>> -    _nvme_fcloop_add_rport "${local_wwnn}" "${local_wwpn}" \
>> -                       "${remote_wwnn}" "${remote_wwpn}"
>> -}
>> -
>> -_nvme_fcloop_del_rport() {
>> -    local local_wwnn="$1"
>> -    local local_wwpn="$2"
>> -    local remote_wwnn="$3"
>> -    local remote_wwpn="$4"
>> -    local loopctl=/sys/class/fcloop/ctl
>> -
>> -    if [[ ! -f "${loopctl}/del_remote_port" ]]; then
>> -        return
>> -    fi
>> -    echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > "${loopctl}/del_remote_port"
>> -}
>> -
>> -_nvme_fcloop_del_lport() {
>> -    local wwnn="$1"
>> -    local wwpn="$2"
>> -    local loopctl=/sys/class/fcloop/ctl
>> -
>> -    if [[ ! -f "${loopctl}/del_local_port" ]]; then
>> -        return
>> -    fi
>> -    echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_local_port"
>> -}
>> -
>> -_nvme_fcloop_del_tport() {
>> -    local wwnn="$1"
>> -    local wwpn="$2"
>> -    local loopctl=/sys/class/fcloop/ctl
>> -
>> -    if [[ ! -f "${loopctl}/del_target_port" ]]; then
>> -        return
>> -    fi
>> -    echo "wwnn=${wwnn},wwpn=${wwpn}" > "${loopctl}/del_target_port"
>> -}
>> -
>> -_cleanup_fcloop() {
>> -    local local_wwnn="${1:-$def_local_wwnn}"
>> -    local local_wwpn="${2:-$def_local_wwpn}"
>> -    local remote_wwnn="${3:-$def_remote_wwnn}"
>> -    local remote_wwpn="${4:-$def_remote_wwpn}"
>> -
>> -    _nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
>> -    _nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>> -    _nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>> -                   "${remote_wwnn}" "${remote_wwpn}"
>> -}
>> -
>> -_cleanup_blkdev() {
>> -    local blkdev
>> -    local dev
>> -
>> -    blkdev="$(losetup -l | awk '$6 == "'"$(_nvme_def_file_path)"'" { print $1 }')"
>> -    for dev in ${blkdev}; do
>> -        losetup -d "${dev}"
>> -    done
>> -    rm -f "$(_nvme_def_file_path)"
>> -}
>> -
>> -_cleanup_nvmet() {
>> -    local dev
>> -    local port
>> -    local subsys
>> -    local transport
>> -    local name
>> -
>> -    if [[ ! -d "${NVMET_CFS}" ]]; then
>> -        return 0
>> -    fi
>> -
>> -    # Don't let successive Ctrl-Cs interrupt the cleanup processes
>> -    trap '' SIGINT
>> -
>> -    shopt -s nullglob
>> -
>> -    for dev in /sys/class/nvme/nvme*; do
>> -        dev="$(basename "$dev")"
>> -        transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
>> -        if [[ "$transport" == "${nvme_trtype}" ]]; then
>> -            # if udev auto connect is enabled for FC we get false positives
>> -            if [[ "$transport" != "fc" ]]; then
>> -                echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
>> -            fi
>> -            _nvme_disconnect_ctrl "${dev}" 2>/dev/null
>> -        fi
>> -    done
>> -
>> -    for port in "${NVMET_CFS}"/ports/*; do
>> -        name=$(basename "${port}")
>> -        echo "WARNING: Test did not clean up port: ${name}"
>> -        rm -f "${port}"/subsystems/*
>> -        rmdir "${port}"
>> -    done
>> -
>> -    for subsys in "${NVMET_CFS}"/subsystems/*; do
>> -        name=$(basename "${subsys}")
>> -        echo "WARNING: Test did not clean up subsystem: ${name}"
>> -        for ns in "${subsys}"/namespaces/*; do
>> -            rmdir "${ns}"
>> -        done
>> -        rmdir "${subsys}"
>> -    done
>> -
>> -    for host in "${NVMET_CFS}"/hosts/*; do
>> -        name=$(basename "${host}")
>> -        echo "WARNING: Test did not clean up host: ${name}"
>> -        rmdir "${host}"
>> -    done
>> -
>> -    shopt -u nullglob
>> -    trap SIGINT
>> -
>> -    if [[ "${nvme_trtype}" == "fc" ]]; then
>> -        _cleanup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
>> -                "${def_remote_wwnn}" "${def_remote_wwpn}"
>> -        modprobe -rq nvme-fcloop 2>/dev/null
>> -    fi
>> -    modprobe -rq nvme-"${nvme_trtype}" 2>/dev/null
>> -    if [[ "${nvme_trtype}" != "loop" ]]; then
>> -        modprobe -rq nvmet-"${nvme_trtype}" 2>/dev/null
>> -    fi
>> -    modprobe -rq nvmet 2>/dev/null
>> -    if [[ "${nvme_trtype}" == "rdma" ]]; then
>> -        stop_soft_rdma
>> -    fi
>> -
>> -    _cleanup_blkdev
>> -}
>> -
>> -_setup_nvmet() {
>> -    _register_test_cleanup _cleanup_nvmet
>> -    modprobe -q nvmet
>> -    if [[ "${nvme_trtype}" != "loop" ]]; then
>> -        modprobe -q nvmet-"${nvme_trtype}"
>> -    fi
>> -    modprobe -q nvme-"${nvme_trtype}"
>> -    if [[ "${nvme_trtype}" == "rdma" ]]; then
>> -        start_soft_rdma
>> -        for i in $(rdma_network_interfaces)
>> -        do
>> -            if [[ "${nvme_adrfam}" == "ipv6" ]]; then
>> -                ipv6_addr=$(get_ipv6_ll_addr "$i")
>> -                if [[ -n "${ipv6_addr}" ]]; then
>> -                    def_traddr=${ipv6_addr}
>> -                fi
>> -            else
>> -                ipv4_addr=$(get_ipv4_addr "$i")
>> -                if [[ -n "${ipv4_addr}" ]]; then
>> -                    def_traddr=${ipv4_addr}
>> -                fi
>> -            fi
>> -        done
>> -    fi
>> -    if [[ "${nvme_trtype}" = "fc" ]]; then
>> -        modprobe -q nvme-fcloop
>> -        _setup_fcloop "${def_local_wwnn}" "${def_local_wwpn}" \
>> -                  "${def_remote_wwnn}" "${def_remote_wwpn}"
>> -
>> -        def_traddr=$(printf "nn-%s:pn-%s" \
>> -                    "${def_remote_wwnn}" \
>> -                    "${def_remote_wwpn}")
>> -        def_host_traddr=$(printf "nn-%s:pn-%s" \
>> -                     "${def_local_wwnn}" \
>> -                     "${def_local_wwpn}")
>> -    fi
>> -}
>> -
>> -_nvme_disconnect_ctrl() {
>> -    local ctrl="$1"
>> -
>> -    nvme disconnect --device "${ctrl}"
>> -}
>> -
>>  _nvme_disconnect_subsys() {
>>      local subsysnqn="$def_subsysnqn"
>>  
>> @@ -465,141 +206,6 @@ _nvme_disconnect_subsys() {
>>          grep -o "disconnected.*"
>>  }
>>  
>> -_nvme_connect_subsys() {
>> -    local subsysnqn="$def_subsysnqn"
>> -    local hostnqn="$def_hostnqn"
>
> It looks weird that _nvme_connect_subsys() is moved to common/nvme, but
> _nvme_disconnect_subsys() stays in tests/nvme/rc. I think it's the better to
> move _nvme_disconnect_subsys() also. Currently, md/001 does not use
> _nvme_disconnect_subsys(). Isn't it the better to call it in
> cleanup_nvme_over_tcp()?
>
I agree, I would move _nvme_disconnect_subsys() in v3.
cleanup_nvme_over_tcp() use _nvme_disconnect_ctrl() to disconnect the
controller by the controller name rather the subsys name. I can change
it to _nvme_disconnect_subsys() if it's more appropriate.

>> -    local hostid="$def_hostid"
>> -    local hostkey=""
>> -    local ctrlkey=""
>> -    local nr_io_queues=""
>> -    local nr_write_queues=""
>> -    local nr_poll_queues=""
>> -    local keep_alive_tmo=""
>> -    local reconnect_delay=""
>> -    local ctrl_loss_tmo=""
>> -    local no_wait=false
>> -    local i
>> -
>> -    while [[ $# -gt 0 ]]; do
>> -        case $1 in
>> -            --subsysnqn)
>> -                subsysnqn="$2"
>> -                shift 2
>> -                ;;
>> -            --hostnqn)
>> -                hostnqn="$2"
>> -                shift 2
>> -                ;;
>> -            --hostid)
>> -                hostid="$2"
>> -                shift 2
>> -                ;;
>> -            --dhchap-secret)
>> -                hostkey="$2"
>> -                shift 2
>> -                ;;
>> -            --dhchap-ctrl-secret)
>> -                ctrlkey="$2"
>> -                shift 2
>> -                ;;
>> -            --nr-io-queues)
>> -                nr_io_queues="$2"
>> -                shift 2
>> -                ;;
>> -            --nr-write-queues)
>> -                nr_write_queues="$2"
>> -                shift 2
>> -                ;;
>> -            --nr-poll-queues)
>> -                nr_poll_queues="$2"
>> -                shift 2
>> -                ;;
>> -            --keep-alive-tmo)
>> -                keep_alive_tmo="$2"
>> -                shift 2
>> -                ;;
>> -            --reconnect-delay)
>> -                reconnect_delay="$2"
>> -                shift 2
>> -                ;;
>> -            --ctrl-loss-tmo)
>> -                ctrl_loss_tmo="$2"
>> -                shift 2
>> -                ;;
>> -            --no-wait)
>> -                no_wait=true
>> -                shift 1
>> -                ;;
>> -            *)
>> -                echo "WARNING: unknown argument: $1"
>> -                shift
>> -                ;;
>> -        esac
>> -    done
>> -
>> -    ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
>> -    if [[ "${nvme_trtype}" == "fc" ]] ; then
>> -        ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
>> -    elif [[ "${nvme_trtype}" != "loop" ]]; then
>> -        ARGS+=(--traddr "${def_traddr}" --trsvcid "${def_trsvcid}")
>> -    fi
>> -    ARGS+=(--hostnqn="${hostnqn}")
>> -    ARGS+=(--hostid="${hostid}")
>> -    if [[ -n "${hostkey}" ]]; then
>> -        ARGS+=(--dhchap-secret="${hostkey}")
>> -    fi
>> -    if [[ -n "${ctrlkey}" ]]; then
>> -        ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
>> -    fi
>> -    if [[ -n "${nr_io_queues}" ]]; then
>> -        ARGS+=(--nr-io-queues="${nr_io_queues}")
>> -    fi
>> -    if [[ -n "${nr_write_queues}" ]]; then
>> -        ARGS+=(--nr-write-queues="${nr_write_queues}")
>> -    fi
>> -    if [[ -n "${nr_poll_queues}" ]]; then
>> -        ARGS+=(--nr-poll-queues="${nr_poll_queues}")
>> -    fi
>> -    if [[ -n "${keep_alive_tmo}" ]]; then
>> -        ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
>> -    fi
>> -    if [[ -n "${reconnect_delay}" ]]; then
>> -        ARGS+=(--reconnect-delay="${reconnect_delay}")
>> -    fi
>> -    if [[ -n "${ctrl_loss_tmo}" ]]; then
>> -        ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
>> -    fi
>> -
>> -    nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:"
>> -
>> -    # Wait until device file and uuid/wwid sysfs attributes get ready for
>> -    # all namespaces.
>> -    if [[ ${no_wait} = false ]]; then
>> -        udevadm settle
>> -        for ((i = 0; i < 10; i++)); do
>> -            _nvme_ns_ready "${subsysnqn}" && return
>> -            sleep .1
>> -        done
>> -    fi
>> -}
>> -
>> -_nvme_ns_ready() {
>> -    local subsysnqn="${1}"
>> -    local ns_path ns_id dev
>> -    local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
>> -
>> -    dev=$(_find_nvme_dev "$subsysnqn")
>> -    for ns_path in "${cfs_path}/namespaces/"*; do
>> -        ns_id=${ns_path##*/}
>> -        if [[ ! -b /dev/${dev}n${ns_id} ||
>> -               ! -e /sys/block/${dev}n${ns_id}/uuid ||
>> -               ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
>> -            return 1
>> -        fi
>> -    done
>> -    return 0
>> -}
>> -
>>  _nvme_discover() {
>>      local trtype="$1"
>>      local traddr="${2:-$def_traddr}"
>> @@ -617,73 +223,6 @@ _nvme_discover() {
>>      nvme discover "${ARGS[@]}"
>>  }
>>  
>> -_create_nvmet_port() {
>> -    local trtype="$1"
>> -    local traddr="${2:-$def_traddr}"
>> -    local adrfam="${3:-$def_adrfam}"
>> -    local trsvcid="${4:-$def_trsvcid}"
>> -
>> -    local port
>> -    for ((port = 0; ; port++)); do
>> -        if [[ ! -e "${NVMET_CFS}/ports/${port}" ]]; then
>> -            break
>> -        fi
>> -    done
>> -
>> -    mkdir "${NVMET_CFS}/ports/${port}"
>> -    echo "${trtype}" > "${NVMET_CFS}/ports/${port}/addr_trtype"
>> -    echo "${traddr}" > "${NVMET_CFS}/ports/${port}/addr_traddr"
>> -    echo "${adrfam}" > "${NVMET_CFS}/ports/${port}/addr_adrfam"
>> -    if [[ "${adrfam}" != "fc" ]]; then
>> -        echo "${trsvcid}" > "${NVMET_CFS}/ports/${port}/addr_trsvcid"
>> -    fi
>> -
>> -    echo "${port}"
>> -}
>> -
>> -_remove_nvmet_port() {
>> -    local port="$1"
>> -    rmdir "${NVMET_CFS}/ports/${port}"
>> -}
>> -
>> -_create_nvmet_ns() {
>> -    local nvmet_subsystem="$1"
>> -    local nsid="$2"
>> -    local blkdev="$3"
>> -    local uuid="00000000-0000-0000-0000-000000000000"
>> -    local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> -    local ns_path="${subsys_path}/namespaces/${nsid}"
>> -
>> -    if [[ $# -eq 4 ]]; then
>> -        uuid="$4"
>> -    fi
>> -
>> -    mkdir "${ns_path}"
>> -    printf "%s" "${blkdev}" > "${ns_path}/device_path"
>> -    printf "%s" "${uuid}" > "${ns_path}/device_uuid"
>> -    printf 1 > "${ns_path}/enable"
>> -}
>> -
>> -_create_nvmet_subsystem() {
>> -    local nvmet_subsystem="$1"
>> -    local blkdev="$2"
>> -    local uuid=$3
>> -    local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> -
>> -    mkdir -p "${cfs_path}"
>> -    echo 0 > "${cfs_path}/attr_allow_any_host"
>> -    _create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
>> -}
>> -
>> -_add_nvmet_allow_hosts() {
>> -    local nvmet_subsystem="$1"
>> -    local nvmet_hostnqn="$2"
>> -    local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> -    local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
>> -
>> -    ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
>> -}
>> -
>>  _remove_nvmet_allow_hosts() {
>>      local nvmet_subsystem="$1"
>>      local nvmet_hostnqn="$2"
>> @@ -692,54 +231,6 @@ _remove_nvmet_allow_hosts() {
>>      rm "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
>>  }
>>  
>> -_create_nvmet_host() {
>> -    local nvmet_subsystem="$1"
>> -    local nvmet_hostnqn="$2"
>> -    local nvmet_hostkey="$3"
>> -    local nvmet_ctrlkey="$4"
>> -    local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
>> -
>> -    if [[ -d "${host_path}" ]]; then
>> -        echo "FAIL target setup failed. stale host configuration found"
>> -        return 1;
>> -    fi
>> -
>> -    mkdir "${host_path}"
>> -    _add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
>> -    if [[ "${nvmet_hostkey}" ]] ; then
>> -        echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
>> -    fi
>> -    if [[ "${nvmet_ctrlkey}" ]] ; then
>> -        echo "${nvmet_ctrlkey}" > "${host_path}/dhchap_ctrl_key"
>> -    fi
>> -}
>> -
>> -_remove_nvmet_ns() {
>> -    local nvmet_subsystem="$1"
>> -    local nsid=$2
>> -    local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> -    local nvmet_ns_path="${subsys_path}/namespaces/${nsid}"
>> -
>> -    echo 0 > "${nvmet_ns_path}/enable"
>> -    rmdir "${nvmet_ns_path}"
>> -}
>> -
>> -_remove_nvmet_subsystem() {
>> -    local nvmet_subsystem="$1"
>> -    local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> -
>> -    _remove_nvmet_ns "${nvmet_subsystem}" "1"
>> -    rm -f "${subsys_path}"/allowed_hosts/*
>> -    rmdir "${subsys_path}"
>> -}
>> -
>> -_remove_nvmet_host() {
>> -    local nvmet_host="$1"
>> -    local host_path="${NVMET_CFS}/hosts/${nvmet_host}"
>> -
>> -    rmdir "${host_path}"
>> -}
>> -
>>  _create_nvmet_passthru() {
>>      local nvmet_subsystem="$1"
>>      local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
>> @@ -765,34 +256,6 @@ _remove_nvmet_passhtru() {
>>      rmdir "${subsys_path}"
>>  }
>>  
>> -_add_nvmet_subsys_to_port() {
>> -    local port="$1"
>> -    local nvmet_subsystem="$2"
>> -
>> -    ln -s "${NVMET_CFS}/subsystems/${nvmet_subsystem}" \
>> -        "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
>> -}
>> -
>> -_remove_nvmet_subsystem_from_port() {
>> -    local port="$1"
>> -    local nvmet_subsystem="$2"
>> -
>> -    rm "${NVMET_CFS}/ports/${port}/subsystems/${nvmet_subsystem}"
>> -}
>> -
>> -_get_nvmet_ports() {
>> -    local nvmet_subsystem="$1"
>> -    local -n nvmet_ports="$2"
>> -    local cfs_path="${NVMET_CFS}/ports"
>> -    local sarg
>> -
>> -    sarg="s;^${cfs_path}/\([0-9]\+\)/subsystems/${nvmet_subsystem}$;\1;p"
>> -
>> -    for path in "${cfs_path}/"*"/subsystems/${nvmet_subsystem}"; do
>> -        nvmet_ports+=("$(echo "${path}" | sed -n -s "${sarg}")")
>> -    done
>> -}
>> -
>>  _set_nvmet_hostkey() {
>>      local nvmet_hostnqn="$1"
>>      local nvmet_hostkey="$2"
>> @@ -829,20 +292,6 @@ _set_nvmet_dhgroup() {
>>           "${cfs_path}/dhchap_dhgroup"
>>  }
>>  
>> -_find_nvme_dev() {
>> -    local subsys=$1
>> -    local subsysnqn
>> -    local dev
>> -    for dev in /sys/class/nvme/nvme*; do
>> -        [ -e "$dev" ] || continue
>> -        dev="$(basename "$dev")"
>> -        subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
>> -        if [[ "$subsysnqn" == "$subsys" ]]; then
>> -            echo "$dev"
>> -        fi
>> -    done
>> -}
>> -
>>  _find_nvme_ns() {
>>      local subsys_uuid=$1
>>      local uuid
>> @@ -924,44 +373,6 @@ _nvmet_target_setup() {
>>              "${hostkey}" "${ctrlkey}"
>>  }
>>  
>> -_nvmet_target_cleanup() {
>> -    local ports
>> -    local port
>> -    local blkdev
>> -    local subsysnqn="${def_subsysnqn}"
>> -    local blkdev_type=""
>> -
>> -    while [[ $# -gt 0 ]]; do
>> -        case $1 in
>> -            --blkdev)
>> -                blkdev_type="$2"
>> -                shift 2
>> -                ;;
>> -            --subsysnqn)
>> -                subsysnqn="$2"
>> -                shift 2
>> -                ;;
>> -            *)
>> -                echo "WARNING: unknown argument: $1"
>> -                shift
>> -                ;;
>> -        esac
>> -    done
>> -
>> -    _get_nvmet_ports "${subsysnqn}" ports
>> -
>> -    for port in "${ports[@]}"; do
>> -        _remove_nvmet_subsystem_from_port "${port}" "${subsysnqn}"
>> -        _remove_nvmet_port "${port}"
>> -    done
>> -    _remove_nvmet_subsystem "${subsysnqn}"
>> -    _remove_nvmet_host "${def_hostnqn}"
>> -
>> -    if [[ "${blkdev_type}" == "device" ]]; then
>> -        _cleanup_blkdev
>> -    fi
>> -}
>> -
>>  _nvmet_passthru_target_setup() {
>>      local subsysnqn="$def_subsysnqn"
>>      local port
>> --
>> 2.45.1

