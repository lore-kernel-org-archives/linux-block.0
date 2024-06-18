Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2129.outbound.protection.outlook.com [40.107.7.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D515B1E4
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 07:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696716; cv=fail; b=l3rXRiIKa3WxXw1Dfz4M/gQRB4OiyTrIDvW3sukS4GLLbSFUcwRA7T6KatjhpUkyt4onuBzZQ8kwQ2pEiniSRnHD5qSQBt73cvtohlvpScSeWkU6kMVax0mSWPJXp10WLpWAdgQN52QQJFOQlUqeZ5NMRZvnhxjIcXPWc1yVfcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696716; c=relaxed/simple;
	bh=S71zbiWu2+VyZp/yIX3Z38xwQuoFwK8HjYgKcvvfx+Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qbLPMB6asl5oakggNMa6W2TjywzpC6hXoFWdrNpUPgEy1q2kiPNukZy8Az81EAavog2TyTt7wppzMSKcV9XbmdjPlXl1GQ15XFYI62EMch+EWz28sD9iMaopoOsp/8ANHTF5/OratKR3zNcY5QbvQZU9Mm9MFgqzt8hetPlhQkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=EQHu7Adb; arc=fail smtp.client-ip=40.107.7.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="EQHu7Adb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQ+iW1zB5zHi8VDoefcz1bPNkVFpc2r6B9m3Pw46Tw9xR+oBhLogBdG4Eq6snQrSZrMELp2WuPZXhClbI/xgDct7pD6cthkD2hHP77Ejh1Qd0RVkahG49JoxsvLGIjP1zmjFZ5+WExnMRUjaYNrX2UZbU1CW4JRiQh9VsehiFcZ8EyZeRMbZW8evmJ5dl4w3RxiKhkPCXVuQCPhatNpW1GMMbEbAIzYkjIk2LkTYMhxZiYvFjdBS6jCDjERwxDjS2BO85rPEDUhOqQpmVrZDN967D4fQY8JMAqOBwY0n9Zv48eM5WMytQKHOijKPV8LgRAac9080g4/oS/JddQJtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S71zbiWu2+VyZp/yIX3Z38xwQuoFwK8HjYgKcvvfx+Y=;
 b=Z3PVJ2VZxy0xvx1M9QnZhYgRVyKCAuWQxZ0bX3YSF/KwpcOoIJkTnY36UKwr6oWxGO/jaPB/dVjgADBQma0vDW5oHWtUny7jM47dTrLPvvd6bU9JqnhQrhPBF8/MePdWwEi2R9B8XtDLLMjjfBcUpucVp9Z8gGsAV6fGWrHSkzsx4eBFJKNmwVAHOH9fRs6vGzHNf+/aJ5Z7K/mBYaaZAGDKw9lr89ZaNWtih4/By/Tevwr5mTfTdvoJTLLm1oh49aLrbtiQa1CjaZchnQwizVtVPJXezyF1Jsw0w8+VHXnuecSkkfxFStkZlvsvI/6X5KU6MhFb12mh0wNFm+K6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S71zbiWu2+VyZp/yIX3Z38xwQuoFwK8HjYgKcvvfx+Y=;
 b=EQHu7Adb3qNhQqLky0JnrbQj6Vc/NIt0YGwDJQjCS4DDr+mRnAccRrLq0wlAsvTxE5uzJF6TXom0F7hWUwu9jarhGZiWOM/bO8ZVFBK3satqArqPJUy0eJoofbcFTU76fQC/Oz3nLbKJDzMgvVwVQF+SL5B6lPchioDGdmei10eNxE8BqNwFyByxv5GmcodF7tprXs9HE74i7yQomTi4NmqQSZNfIy56n/gSKss8gLCESoz9Gw+SlVGGHUGjsKJ+4jaoDEo89DThORwKXBezDeGCETvGCGYF1JYZBuaTQcHUh3Wl5sdnJ8jb6OOnoKKDKvER0T5Xomj7LvBTzUj/TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
 by PA4PR04MB8045.eurprd04.prod.outlook.com (2603:10a6:102:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 07:45:10 +0000
Received: from AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb]) by AM0PR04MB5107.eurprd04.prod.outlook.com
 ([fe80::de53:c058:7ef:21fb%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 07:45:10 +0000
Message-ID: <8c121c1a-a100-4cda-98fe-393c593e2f9c@volumez.com>
Date: Tue, 18 Jun 2024 10:45:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
 <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
 <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To AM0PR04MB5107.eurprd04.prod.outlook.com (2603:10a6:208:cb::11)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5107:EE_|PA4PR04MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: e6592f32-9ec7-44ce-99b9-08dc8f6a949e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVRRMjJnNk9md0R4bnIvazF6eXNvd1pYejBBWm45UUNXSiszQlVVdVBnVi90?=
 =?utf-8?B?VkNWcHJsdmNOWjBtaERKODlWUGpZSDcvaGFib3F2MFFtTiszY1ZpVnBxUzdZ?=
 =?utf-8?B?Wmd3MHNvdzZyZTVLTEtXbDRXbVAwRnhYMjlQRGVpUjRsMGxXVDlodzAzdHlG?=
 =?utf-8?B?V21PTGdZck1ZN2Y0T3JhV1dFMm15YWV1c2ZPS01GOHVSaWVEV2p0YjlYcUR6?=
 =?utf-8?B?OFgzZnhwT3BDYmRkdnBMdmFUZFpsYTNrK2czQkZ3amRMMWl0d013M2JyVmk1?=
 =?utf-8?B?aFlkeGFxL1QvMWNpdXR4Z2FGdnhqcG9HMWVOY0lNQ3lFa1VyU3BNZ09VaUxa?=
 =?utf-8?B?ZTZ5ZXc5cWNmdzlEdjBSSi9HUndpR25nakRNNzNFd2R4cUh5MjZWTmRMS05y?=
 =?utf-8?B?S1gzaXRGQXlZb1hTVzdVakdFbzBNbUJhdG45akFHUzZBQUQvNGp1TlNkS3Va?=
 =?utf-8?B?V1BNUWFrdnBacVIvaEt6MEl3eTdvc0FFZm4vZTFTbytyeW9JZUNRL29Nd2pQ?=
 =?utf-8?B?TTFXQjBBdHpmZ1htMEV4OVp5bElmeUNHTmhxT1BZUmp6T25pOXg2ZzgzajNM?=
 =?utf-8?B?SVdjWk5FWjN6NWpzODZXcFRjYXJnOFhaNDNMVkU5bCtYUFBIYTh6MnlQZmNW?=
 =?utf-8?B?TnJkQlFIY2pkb29MRWhYWGxBNFlic0MxWFVhaElOZnZvOXNCWHJSQWpxdDkr?=
 =?utf-8?B?QmNjdW1zOXpCNEd5VkdZNEZYZ0lORE40aElBdFpuVERsdW1NejhCVVdLWFlP?=
 =?utf-8?B?RDcwTUVLaWVncHZzRytoclFoU28rcWNCQU8yMnJ2czRkMzZCUjU0YnpPS24x?=
 =?utf-8?B?ckg2KytZZDlleXVFekEwRkYrNFM5ZkJVNFp2OWdPV09CSFlqOUlpeGhubk45?=
 =?utf-8?B?V1J0SUxIejV5a0pLNU0yTURMU3RNS0c5ajlhQklNTm9hMlE5WDZyZGU2RTRN?=
 =?utf-8?B?djVZSkJWOUhYaHNpR1FvdGRFcFJVUnhrb2hFeXk1ektELzd5M25NcFhkMUtN?=
 =?utf-8?B?aTVabC9DS01hNVM0QjE5L2V2aHVIRW11RFlYRXZLeVZOaXNyWDRQUm9UZlJh?=
 =?utf-8?B?bHdJb3Vtam1lbUVNdWFWNk41RFhRWkR2WEVFbU9xcCs5b3V2c1NwUklyYTlH?=
 =?utf-8?B?ajV2MTMwa1NLeE1aTVk2MFh2TU9Mbk9mNC9IVjVuR2kyQWJYc3B3SUFucjlh?=
 =?utf-8?B?REdFREdPM3B3ZmNHbkhSMHVXSEZtNW1QMlp5Z2tmWm9mSTNyZVRWNGJXdEw2?=
 =?utf-8?B?cWdYSThiVDVpYStuZXdNYm9mMDlFdGI3TlhuZ1hjWEJSVzdFdDRzS0ZKYitq?=
 =?utf-8?B?aG1mUmEyVEhwMkE1dDVudSsvK1lpb1dHcjFtTFMvY2IydVFWU0JldW1hMHlU?=
 =?utf-8?B?NHExVzZEMHBLN1NGWG9lOE51NjZBYlA3R3NVaE9USTNhbm1hUzhLVjd3cWVn?=
 =?utf-8?B?ejA2S0VvcjZ6TnlPTjdpRDRrV1dQRXFtTnpQc21tNm8rVms2WHM1Sk93WHVp?=
 =?utf-8?B?ZGhVazl2KzFDMFQvaXJhS3A1c1lvQWFHSlFablJRZUwzTkx1bS81bmtqNjdk?=
 =?utf-8?B?RGJMdGN5bEQyMjFtd0QvZVF5ck5kTG8ralBISE9kRXR3K3Y1VUUxWERmcFFo?=
 =?utf-8?B?ZTlSMmhwWitHbmJzclJEZ1Q2dm1kREd1YjdMZkZrWS8vY1BqVkc3UHNkZXp6?=
 =?utf-8?B?cXJ0NTFBQ1lJU0VGeTdJaUpVU25taFZOdjAyVURuZ0JMVkt3M3hwTFY4VVFF?=
 =?utf-8?Q?ynJTlcD9NLPrU0qG0GNkw7+N6NVEbamn+mHZy0/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB5107.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlRXNDhpSXdETllmb2pFNDREanBwd0R0VGsxOVlBaWNYdVNKYW1Db2hQQU11?=
 =?utf-8?B?WWx0OFhyekhiSEZYYVNiTENGT2ZRZWd6c1VOQkV3QytNQ1k1eEVkVW1LN3pT?=
 =?utf-8?B?RGhKcHcrOHRJWGc1L2ttT080RFZ3WnJ2Ync0SWU1eWpPYXA1Y0ExL09FVVdW?=
 =?utf-8?B?eGlOTUU5cFo5bUhhdFV3TW1YNXA5VXVNWG9OVnlFRmt2UW80Z0hILzdGNXpR?=
 =?utf-8?B?WjBKZUdrQytMdDNmVm1rYjBleEpuTXRrelJwZnAxcEZVdUcvSnFpYkI0OWRh?=
 =?utf-8?B?YWNjS3dWUnI4dFRYemsyenhuRVZMUU4wMzBVSUdxbEdNYVFRdU81clEwTjNE?=
 =?utf-8?B?MlVXYzR3QzhPOFRSV1JZb0lnM2JqVFQwZGp6QTF4MVdlczRjcFdFRnhvZUlt?=
 =?utf-8?B?Vi8rcG9tRXFhUU42dHNJeFNDd3Z0NHNnd3UwamNrNVNHbDl6R25MdnpDZmg0?=
 =?utf-8?B?MW83N2RhTEZRMXpzaTlXVWxhQk1mN0FZanM0aXp0TWtWT08rdklhQzZUaDFr?=
 =?utf-8?B?TGF3ZWNMT2ZFTEFYMStLSTV0T0FXZWQ5MldGRkMrRVZmRGdIWU81c3djWkJN?=
 =?utf-8?B?Z2Y1czd4aGdwb3F1d1RPdm9uN25HUVZJalE0YkEzc090RjdRTW5wV1o4a0N6?=
 =?utf-8?B?RFdRb0g0cktoZXc2aElDa0FwUU40aFhQRkt0LzV1V0dpeXEzbHV5c3JNY2p1?=
 =?utf-8?B?Yi81V1BOTEJWZkU5NXhwMjhvbGlRd0xPOUNFU015QXlOcTlQUUVQb1JtcWJV?=
 =?utf-8?B?REk1YjBET1M5NndPYnJncDhMS2wwVHZsd043dnNoT1F5Zm1nQ2xjU2xBRnBs?=
 =?utf-8?B?MmJXNFpLU0NIU1hSejduUGluN1dTTnJpS1lNY1I5S2VHZ3FKbnJvcGlxb0t2?=
 =?utf-8?B?UTh1K0tkOU5pcFVZcTBCWllENzVmcFdCakFDNW1XRlpjeXIxZnZKTk00SEpM?=
 =?utf-8?B?Z1JGRXZGempwWXJGc25lWmlxdmF0Nk14UE95bzZXS0Vta29iakRDS2crdzc5?=
 =?utf-8?B?cGVNcDRrY3l4ZVkrcjlIbnFud1RYT0FxUlRSVjhHSEdNRWN5dGhRNU5SaVJu?=
 =?utf-8?B?QWtNVGNMdHlXT2ZNV0R4Y0lYZkQ1eWdkZkgxeXY2eXVIOTNLK2JXZWg3RVNi?=
 =?utf-8?B?MWMwNXQyZ3Y0c1FhUzE1M1k1QVlJSzA0cXpCN1dxZkJMUXEyZjk3aHBTZThn?=
 =?utf-8?B?UlBkOW1oS3NYeThhYVdpTlora0lUWENZdzhhN09XK3hiTml4YjVQT3RuWXUv?=
 =?utf-8?B?T2tjelVLN29Qb01aa3UwZmtucjZTOFI0dzcySmJRWFRIdU0vMGhsQXZNbGI2?=
 =?utf-8?B?dU0rSHp6MzJTdGMvQUlBZnJlNUZHODRDYkZhZUpuQTdicHhzbGZoTlBVMERy?=
 =?utf-8?B?a1VyOWoza1djYmNPeHJMQ1ZSQnJZaDNzWFJhR0RiU0RtVlBPRXJDSHE5ejEw?=
 =?utf-8?B?Rm5RMGdXM3dYaFZGMCtVZUY1eng1dTJDb2gwQ2xRakRsdDgwK2M1YllqSlgv?=
 =?utf-8?B?UHY3c0NaYjlnaWJsVXNIUjJKeTh4bWpzb0lUVG5TZjBYOEtaUDhUckMvaWNq?=
 =?utf-8?B?OWp6OEU4Z3FzS001SFA2QWNNR3lrd0l5MUM2NE41V2NDTUlZYnhwWmNqQnZU?=
 =?utf-8?B?UThvU3dMKzFQYzFGUG1JTXkvYWFWZHZ2b2RIZ2pORC9LL0I3MGVRcFBiUTNt?=
 =?utf-8?B?RDgyTzgya1QvUFN4aTUzdEQxUms4M3loL1hqSkFuWE94SUFVeEp2Tm9qZnVy?=
 =?utf-8?B?eHpkbmVqUmZlNFowVHM1cmdrU1JTeUk0K3pFc1QwU2hWcHlxT1ZqY1QvYVI2?=
 =?utf-8?B?TTRvK1lvN1Y2MVRRRWtKeUxQWERDamRZZVlVcElScHZHOG13NDlZWFloVzQz?=
 =?utf-8?B?SE96Vm4vY2RQbk11aHpDRFZadFhjV2JSMEo4UVJydGhwZk9qbXIrSFVqVVlD?=
 =?utf-8?B?RkNGNmZWYTlSMzhNK2g2WHIzNjY3UGhCc1U2SVpqalFRQlJYUndONnlHcUZZ?=
 =?utf-8?B?OFp2Z0VBbzY3YVFSak4ycEhhSXZDL0JGeWFZNHRtZHpCZjJJNVYxM1pibVV4?=
 =?utf-8?B?dVpNVkVFRHQwTExWOFZ6NEErN29UTTNVZ1pvMy9ad2Z6ZXcvaWhnQUk2QTdM?=
 =?utf-8?Q?wGE6S1nYXpsLA6GTG/VnkRpGW?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6592f32-9ec7-44ce-99b9-08dc8f6a949e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5107.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 07:45:10.4213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q0zS+uYQeaLj0sWkjbyEtuYvCAYtFWCfobgAmPgYKeFgY4kc2SVZQiUk87lx94Z8vqJ9YFoeXeveNL9MHhp0CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8045



On 18/06/2024 4:24, Shinichiro Kawasaki wrote:
> CC+: linux-nvme, Daniel, Chaitanya,
>
> On Jun 17, 2024 / 19:05, Ofir Gal wrote:
> [...]
>>>> diff --git a/tests/md/001 b/tests/md/001
>>>> new file mode 100755
>>>> index 0000000..d5fb755
>>>> --- /dev/null
>>>> +++ b/tests/md/001
>>>> @@ -0,0 +1,80 @@
>>>> +#!/bin/bash
>>>> +# SPDX-License-Identifier: GPL-3.0+
>>>> +# Copyright (C) 2024 Ofir Gal
>>>> +#
>>>> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
>>>> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
>>>> +
>>>> +. tests/md/rc
>>>> +. tests/nvme/rc
>>> I want to avoid cross references acoss test groups. So far, all test groups do
>>> not have any cross reference to keep them independent. How about to add this
>>> test case to the nvme test group?
>> I don't mind to add it to the nvme test group, just to clarify the test
>> checks a bug in md. The bug is "visible" only when the underlying device
>> of the raid is a network block device that utilize MSG_SPLICE_PAGES.
> Good to know this background. I suggest to add the last sentence above to the
> test case script header comment.
Will do.
>> nvme-tcp is used as the network device, I'm not sure it's related to
>> the nvme test group. What do you think?
> I see... The bug is in md sub-system, then it's the better to have the new test
> case in the new md test group. To avoid the cross reference, the nvmet related
> helper functions should move from tests/nvme/rc to common/nvmet, so that this
> test/md/001 can refer them. This will be another separated, preparation patch.
Ok, should it be a patch set or two completely separated patches?
>>>> +. common/brd
>>>> +
>>>> +DESCRIPTION="Create a raid with bitmap on top of nvme device with
>>>> +optimal-io-size over bitmap size"
>>> This descrption is printed as blktests runs. All other blktests have single line
>>> description then the two lines description looks strange. Can we make it shorter
>>> to fit in one line?
>> Yes, does "Raid with bitmap on nvme device with opt-io-size over bitmap
>> size" sounds good?
> The word "tcp" sounds important. And the word "nvmet" sounds better than "nvme".
> So how about: "Raid with bitmap on tcp nvmet with opt-io-size over bitmap size"?
Sounds good to me.
