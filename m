Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023125.outbound.protection.outlook.com [52.101.67.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3235633E1
	for <linux-block@vger.kernel.org>; Sun, 21 Jul 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721545675; cv=fail; b=DG83HRVvM2fxtBoCnAvQS6Y9PKzwlROI1/q4QQNDfT4T1J28sHjX+rwawdv73aZUujNc3pHKWeBtScpMscTQnCYPe3EUvyrA2QuUPr7NI8kw0gc2un/rqTEIhpmErFp7rQfOYsRwxsn8j4wfYt299G9Wd1+YDbyIByjmRMtcdTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721545675; c=relaxed/simple;
	bh=9QCov7bfAu1agJLcto4tQecnRqA6PwINSIopOyG7tQo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hck1fXB5S3lzfYrU0mm+eqDUuhrkf2OttQqAcasPViZU6TJyvZni/H10UOylkJHiGSETZmR/aVvajuggYOkInm0kdGZ519qLtkjc7RJTPVtZ10LMrhMW+WRX7P7JEY9GNJjfw6R5ZoTdoZWa0jg9JFQmUY5mq+rRErEyIp1zOY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com; spf=pass smtp.mailfrom=volumez.com; dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b=XvJ+w7jJ; arc=fail smtp.client-ip=52.101.67.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=volumez.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=volumez.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=storingio.onmicrosoft.com header.i=@storingio.onmicrosoft.com header.b="XvJ+w7jJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCLEuPk1aTv9FX5/Ckr1VJbtz5LlYdx659YisZ3fIdyQIHdY0UmHUJ0l1x7urlI8Th4VT5Kq7V7LK4brDC683MJv6LyhqklSmvFpjrZ/RZCuOOEe164DZ24LllTGfJt7+DKlvWykLXSYzFUbX5lf+rwYguJmpNafCAZg6gbbtGOgziVt66qo7Pepmsv8vAfN+RdK+AiN2NiPVCE2tbdJzrIEoILjRf0gYdg5m4qfJONqgTOdDeFR39BU2ai34MSHpCdx4PtglfSIHcXfue5TBHkyeLYdRM+aPTYItbQ/dKKLh9DBdGOm5uYHDjZIa8s6w+NIT5LTZAPdWaKsOdTA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QCov7bfAu1agJLcto4tQecnRqA6PwINSIopOyG7tQo=;
 b=cljJl+DOlm/eSbksN1+vwOCC7xl2hReJs5Yj7LGroJRgbcTXBHIluE/bscMQa9ZKaE3VVKRGZXcLWmsSlUBRCcul9aHA39/g1gE+zdN9il34/+kaUrMzOG59Z/fYuz/mt9S13Use7Eow/xbGy5qcZasInqoaEYn9i01qxLg7QvQbuQy+gIuHPsiYeQfRYOqxnBUL6pTLtiHG3seqmDzesVeQjKrYito978+lg/Ra+wJVzo5p9XLKGkmcj2sRihdYy6iifd7U5BG6AXvFK5C2EA72r3wVPNGJ46FPW5hwtLlkgJi/8Jj3CTWJ+6/iA9OLLZWnMNCmhbNWeJxD/hHG2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QCov7bfAu1agJLcto4tQecnRqA6PwINSIopOyG7tQo=;
 b=XvJ+w7jJedPjTNTpXgAp6J//T/d32vdskxh20fgOy4Dt9bc9iE7LH2bg7Fe2qsx6O0HI6QWK2NJz+UyyUUfIqs5EcnW7nmIZWZbFKe4YYCEL4UDCX/vH4sRFsH5gGHRoJLvUAG9oNTzyMsjIeyIvtu0HgK7m+uNrFbe7S0ve+LR9n2l5+2zXqISLSC24hZJVkGNtjySvukS84L24iDQmQKLz4bzP95uTqThVc4C+Ox23/Ex54HulEnsbsZy57E8ExgUr+84wZsw2cBP8mX2Xz4gLn/Cqn2L85qHXWzpRfpyYl0LziGPY1aoknCeSz3AdYMTvgJKulkwrVC4/+zW8LQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by GV1PR04MB10396.eurprd04.prod.outlook.com (2603:10a6:150:1c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Sun, 21 Jul
 2024 07:07:48 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Sun, 21 Jul 2024
 07:07:47 +0000
Message-ID: <0cac8961-9aef-43e0-b04f-b523506b24a5@volumez.com>
Date: Sun, 21 Jul 2024 10:07:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
To: Yu Kuai <yukuai1@huaweicloud.com>, shinichiro.kawasaki@wdc.com
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 dwagner@suse.de, chaitanyak@nvidia.com, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
 <4e7a4961-233e-04f8-776d-0886e1640db8@huaweicloud.com>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <4e7a4961-233e-04f8-776d-0886e1640db8@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|GV1PR04MB10396:EE_
X-MS-Office365-Filtering-Correlation-Id: 5572d10d-a807-41a3-f2f1-08dca953d347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QU9adXJSemhuN1NXbWMyby9VMld2enhnL2o0bGQyVVUwdXUxSmVmdnNpa0ow?=
 =?utf-8?B?aHVSd21id21FWnRYRVJwRkUxOHJ0WDFkUEp6UHVkZ2NabnA2RWJGT3NVU0xV?=
 =?utf-8?B?eURFVDMxaEg4TElMK3lXcjdJR2xZMG5NSFk3a0hUSHZta0x6NVhUb0YzeHJG?=
 =?utf-8?B?VkFkeTJnTkIyb2dLUkk0eHN6YVFOUU8wWEtPL053MVdXNVlvWEFrWExpckFX?=
 =?utf-8?B?ZHh6Q0JnbFBPa2hIbkEvRTBRNy9FWDlCRkJEOTgvVmM1eStOR1NjYXBkYnFJ?=
 =?utf-8?B?T014VklMVDM4Tk5xVTg3QldjTFRSQ2dySlhVSE9oYlc3dEU5NEN0eThtakJH?=
 =?utf-8?B?RGtJMTlnaVo2OWNKT1lXeFBNK2V4SlRtcjlFUmtuclloVkN2OWdJeW9LcEY4?=
 =?utf-8?B?alBwNXdJQ2pxUjZCSndhTG1lRjBiNEd2SlYvSFVadFdoWkN2bXBnZW5CSlVm?=
 =?utf-8?B?TSsyZk1LSVpoa3h0SndXcHZjMFpicWJnaXRjaWdUSEVQRHNzYXZMdmozbERh?=
 =?utf-8?B?NmMwc2M3YTQrUUdET09PR3RGZUNwQnpoVHRWVWhSV01ocjF3WEJodzVNTUNl?=
 =?utf-8?B?VDNMTWxNZEQyejFWdzBydURiUjVHSjF6ejlFWks0QzZnME1hbytkUm1yWjdZ?=
 =?utf-8?B?c3dTekhZRUJpa1QyUHZ4WmJDeE8wZVp1RS94QzcxK3hlZFZ5MTcvWnNHQUQy?=
 =?utf-8?B?UjBZYnpDcWV5TnFEOW02T0pDTHBGU0c2WlVrSVBvZnZFUjFuMFBldXZzbS9X?=
 =?utf-8?B?ZmhTcHBzSGZJelNMWFVVV1pJT1VONlZSTzgxQlFka3gzckxKRVh6aWdkNUlB?=
 =?utf-8?B?NlcwU04zVXRpTFRQVUl1K3BwYjI0U0tHNmpCRGd1enRlc1ZyNkFGL2RRVEQ4?=
 =?utf-8?B?aDlTWW1kQ0pmdyttRGwzbHc5Z0hOZ1BMbXJuNElXc0d3NGUrYTc4RTlOOGU3?=
 =?utf-8?B?UGlFYzlFZ0hQVXlRY252aGZDbWtJdXZPUVgrZy83QU8wZ3J2YlJ5UGVpd3pU?=
 =?utf-8?B?UXppMzRGR0pRK3M5TlpBaW16MFl4VHZFNDg2ZnptMzVIY1VLcDB1Nk82T0lD?=
 =?utf-8?B?VmM0MVN2WlV2RlFqcnJ2eWY4eGhSRWpMcXRBNXBxRWgxSjRqcmFabzhET2E2?=
 =?utf-8?B?Tzk2UUZyV2NsdTFyZ0p3aTlpbnlXdWVUZ201TXZJa2hZV2tuekRNOWNialkr?=
 =?utf-8?B?dVgxTEgxRlpKYWVTLzRNTHJwOHo5QnNCTGtOVFBBMXlJUU5Vcmc4R2xST2Fa?=
 =?utf-8?B?K3o2L2dyTnpGcTRPektMb1VIZ3lNelF5Tm4vZnVmN2dLTC9kc3B4WlNDZXVD?=
 =?utf-8?B?TlhGNWJ5eUJ0U2xoU2doeHdHU1pENmNIbzNZdnYxdDA1Q3p5V3IrRktyQlVy?=
 =?utf-8?B?dit0MFFoNTlUdTJBNklHZ3dkZ2JMZThjMU5iNmpYUmNibVZiVDVpTWl0OTBU?=
 =?utf-8?B?bDNNeCswZVpQUHY2NFRGUXRzN2txK1dsc2VkMzQwNitPVjN3MWpsRFFpek5z?=
 =?utf-8?B?c2I4QTgrMkZqenVCRU8vSFYvN09TS2U4WDNLajc0NnBjMGRYVVl2eDhiT3Rh?=
 =?utf-8?B?NVRTZzY0ZThJMExHbzhtUHRmQzNhelpSeVNid050OUhDRVBxVXA2OHUyT1d1?=
 =?utf-8?B?NTU5U1pmU2lTdGJlZ3M5elBPeGlTd3JZckU0cXptV1QveG1BZTV2UFEwMGU2?=
 =?utf-8?B?UWZEUkdvRUJBaXQ2T1krRTdITWNVdnMwYzJzV0dSOUpkRDZKZVdEcTVLMXJB?=
 =?utf-8?B?OTZSUUdTNXhiS2hSU3dwRWcwaUtmTFM0aVhVZkNRZFFuQ3Y4ZHBBL1VMMUM1?=
 =?utf-8?B?bWVEMVRyQnE2VXZPODdaUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnA2SVRrcDgySVBvTVlIbUVDVlRhdWZIRjZBSUdvcTlkUWREZzNZb0JPZ3Z2?=
 =?utf-8?B?VWlscmpyakRUcEtPVzF4a1AxYllzZmpCV01LNEw5dnhhUk9xWlNTVFNkbjRU?=
 =?utf-8?B?VEJ5UDFKMjA0WjhXQWcycDFDM0hVbDZSMWFlVXhEckxyOFdXWkZBRGxpd1Ay?=
 =?utf-8?B?dE9vaFFGaVg4WVNyVWZGRnBvRlprbWdNUjA1dmx0THY2S1ViMkxqN0REd0V2?=
 =?utf-8?B?YjJWMWpqZ01UVnN6N2cxZ2t1V205Ulk5Z01IQWxoa0xLRVltc2ZOK3lMQmhT?=
 =?utf-8?B?RlpZWWI4emJvYTZ6UVNjczNYUTRsM3VQMVo4dWJucm1jZi9uNDlZZFpmdk5w?=
 =?utf-8?B?Q3g3NENsWDdhcW13eDQ1bEtSaHR5YWVmZjlzVFZUWHRlbnlrUTZnempWamJ6?=
 =?utf-8?B?UzdmT09RT09PQUtlMlp1SVJwZGUrUEJGeHZWMVZqeWZKRGsxa3BHcjI5TVB6?=
 =?utf-8?B?bkZIMUZreXNNYW5QMXlVVitGbHJTaVRqMlN4YWs2UFdxYVJMMExzeVVyZ2FC?=
 =?utf-8?B?aUVSMGQzSGtrOEtYaW9YSkpkbHBUR2x5ZkZyY3o5RGRTZ1VvWWpPZ0M4ZG9z?=
 =?utf-8?B?OE1VMzBLZGlVVVh6bjNXOUo1eEdPY2F0UFM3UGw1dEZTdXRpcFcxaXA5T3hn?=
 =?utf-8?B?NGdZZ0t1eW1vbVEvdGp3RCtpejRrL3J6Sjg4SHBxenJScDJTeDhLeFdHaE1v?=
 =?utf-8?B?clVMWmRBdEx5bkczS2R2WlFZVnJadzRuQllxOTE0SU5qN0FuQ3N6bnU0a2hQ?=
 =?utf-8?B?dmUrTXBlSThhaWVEWFRKck8rZWpJdzR1SFVZZU9BR251Y0hVd1NlWElpMDdo?=
 =?utf-8?B?SWwvSHRKRUtqQno3bVNrVkFBWkVVaVFBbEdzN2lCdjk4SkdnSE5sV3Q4TXBP?=
 =?utf-8?B?NHV2a2llREZlMVVFNDhyMHpaL3l4V3IySzU1ZitpbG1mUzhjR3BJYUExTkFO?=
 =?utf-8?B?aGFEeS9XbkdIb1paeHRvU25ZV25kN1I4TE1iM2xNQ3FHQVZXbDN3MW5TQVg5?=
 =?utf-8?B?dDJWZkZqNkZIV3NWb05uNWovNzNWMlZqMVVFL1BpRVN2bGlsVEZoRWQ0WWJz?=
 =?utf-8?B?WmYxU0xBZERpU09MR0k5NGlCam1QOWgzV2djMk5kTUhLSHhHSmo2QjRWUFM3?=
 =?utf-8?B?bjJ3VlBRN1BRbWY1L2VUa2dOam5vTEFObk1icGZoNGpmaWdJMWh2RWhGZ0Ji?=
 =?utf-8?B?T0pUV2plSU5mMUhkVFZFNU9sMy9iZHNRcjlQd2VoWmd2N2lrUy8wdW9XVkJE?=
 =?utf-8?B?U1V2VkNkSjFNazcwaTZ5L1I3ckJsRDZLTmdYb0RaVWh6cm5jQW5pbTg3SFM2?=
 =?utf-8?B?bkkxN3FxTmlMenhJUzVUc0lJdWw0aWdRQ3VNMDBGY0JHa2dhNVRKRDVxT3E4?=
 =?utf-8?B?c1doSUdMVnRHTCs4bUJoeW4vZHBmSG04ai82L255T2JvcVhjR2MzSTN0Vmxo?=
 =?utf-8?B?Sk5ycldFQStJTTdnanJuM29MVVdHK3EvQjRrNWRCMm5uWFBNVEZRZzJSd0l1?=
 =?utf-8?B?dzZuaWxsVEtQSDI2aUdOYys3c01TMXFoRStWSE1FNVJhbzJwcWNFV1g0N245?=
 =?utf-8?B?eHVQZ0ZzRFJqcUNYWkFTMi9oMGcxNlhNOVNSU0lSVGxsRFBSdWpPQUNSS2ZD?=
 =?utf-8?B?ZElvWGVWTEJlTU5CN1JPbEJYeVFYUHdUdXBHWndSVkppaDRLY2NHZnM0a0lO?=
 =?utf-8?B?aEQ5a2k0UlBQcTRHbytWaWlwZk53dHRZR25RS0h3bUYwbGFhZGJlZWdZQThq?=
 =?utf-8?B?eitkemZmRHdSV2N3UG42Z0FER3hkd3NrYlZiK0VCNjVTTnFtTk5BMXVQKzFq?=
 =?utf-8?B?U1VWOTBSL1htMHU5UUorVGZlZkVOQ0VZUDEwOTFsejh4a2o4b0NTOWhqdEFB?=
 =?utf-8?B?SHBKcHliL0FNUTFVZFBJbkxuSTBUZzA3ODRub25FUm95d0tWZGMweVVaYWg3?=
 =?utf-8?B?RWdPWHF6YTlqYW56d01vRlRSY0pucnhmQkVUUjhXTXV3dU5HMUtqK09WcmxT?=
 =?utf-8?B?ckxwNDU5YnZ4ellLcDJ3elhEMEZZVFFkQ2UvaExOQk8vZElYb09qZDQ3eThS?=
 =?utf-8?B?b291Vm9HZTQ2YkdRL05IUTZwb2s4eDdQOGVTdWh1cnNhTlVIV1BvaGs4bDZ4?=
 =?utf-8?Q?N5LwTDhQCaaTLpRuiZcnFXTfm?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5572d10d-a807-41a3-f2f1-08dca953d347
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 07:07:47.5164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6lA5ixmEFz7YdmjasMpSzcjRbkvw+CRcxttWcQfndZlJ9Zy2M6/6AbFMHpSAd4gmveg6rabkl/RVNjXTBaNqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10396


On 7/19/24 06:28, Yu Kuai wrote:
> Hi,
>
> 在 2024/07/16 19:50, Ofir Gal 写道:
>> A bug in md-bitmap has been discovered by setting up a md raid on top of
>> nvme-tcp devices that has optimal io size larger than the allocated
>> bitmap.
>>
>> The following test reproduce the bug by setting up a md-raid on top of
>> nvme-tcp device over ram device that sets the optimal io size by using
>> dm-stripe.
>>
>> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
>> ---
>>   common/brd       | 28 ++++++++++++++++
>>   tests/md/001     | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/md/001.out |  3 ++
>>   tests/md/rc      | 12 +++++++
>>   4 files changed, 128 insertions(+)
>>   create mode 100644 common/brd
>>   create mode 100755 tests/md/001
>>   create mode 100644 tests/md/001.out
>>   create mode 100644 tests/md/rc
>>
>> diff --git a/common/brd b/common/brd
>> new file mode 100644
>> index 0000000..31e964f
>> --- /dev/null
>> +++ b/common/brd
>> @@ -0,0 +1,28 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Ofir Gal
>> +#
>> +# brd helper functions
>> +
>> +. common/shellcheck
>> +
>> +_have_brd() {
>> +    _have_module brd
>> +}
>> +
>> +_init_brd() {
>> +    # _have_brd loads brd, we need to wait a bit for brd to be not in use in
>> +    # order to reload it
>> +    sleep 0.2
>> +
>> +    if ! modprobe -r brd || ! modprobe brd "$@" ; then
>> +        echo "failed to reload brd with args: $*"
>> +        return 1
>> +    fi
>> +
>> +    return 0
>> +}
>> +
>> +_cleanup_brd() {
>> +    modprobe -r brd
>> +}
>> diff --git a/tests/md/001 b/tests/md/001
>> new file mode 100755
>> index 0000000..e9578e8
>> --- /dev/null
>> +++ b/tests/md/001
>> @@ -0,0 +1,85 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Ofir Gal
>> +#
>> +# The bug is "visible" only when the underlying device of the raid is a network
>> +# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the network device.
>> +#
>> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
>> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
>> +
>> +. tests/md/rc
>> +. common/brd
>> +. common/nvme
>> +
>> +DESCRIPTION="Raid with bitmap on tcp nvmet with opt-io-size over bitmap size"
>> +QUICK=1
>> +
>> +#restrict test to nvme-tcp only
>> +nvme_trtype=tcp
>> +nvmet_blkdev_type="device"
>> +
>> +requires() {
>> +    # Require dm-stripe
>> +    _have_program dmsetup
>> +    _have_driver dm-mod
>> +
>> +    _require_nvme_trtype tcp
>> +    _have_brd
>> +}
>> +
>> +# Sets up a brd device of 1G with optimal-io-size of 256K
>> +setup_underlying_device() {
>> +    if ! _init_brd rd_size=1048576 rd_nr=1; then
>> +        return 1
>> +    fi
>> +
>> +    dmsetup create ram0_big_optio --table \
>> +        "0 $(blockdev --getsz /dev/ram0) striped 1 512 /dev/ram0 0"
>> +}
>> +
>> +cleanup_underlying_device() {
>> +    dmsetup remove ram0_big_optio
>> +    _cleanup_brd
>> +}
>
> This is okay for now, however, it'll will be greate to add a common
> helper in rc, so that other test can reuse this in fulture.
>> +
>> +# Sets up a local host nvme over tcp
>> +setup_nvme_over_tcp() {
>> +    _setup_nvmet
>> +
>> +    local port
>> +    port="$(_create_nvmet_port "${nvme_trtype}")"
>> +
>> +    _create_nvmet_subsystem "${def_subsysnqn}" "/dev/mapper/ram0_big_optio" "${def_subsys_uuid}"
>> +    _add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
>> +
>> +    _create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
>> +
>> +    _nvme_connect_subsys
>> +}
>> +
>> +cleanup_nvme_over_tcp() {
>> +    _nvme_disconnect_subsys
>> +    _nvmet_target_cleanup --subsysnqn "${def_subsysnqn}"
>> +}
>> +
>> +test() {
>> +    echo "Running ${TEST_NAME}"
>> +
>> +    setup_underlying_device
>> +    setup_nvme_over_tcp
>> +
>> +    local ns
>> +    ns=$(_find_nvme_ns "${def_subsys_uuid}")
>> +
>> +    # Hangs here without the fix
>> +    mdadm --quiet --create /dev/md/blktests_md --level=1 --bitmap=internal \
>> +        --bitmap-chunk=1024K --assume-clean --run --raid-devices=2 \
>> +        /dev/"${ns}" missing
>
> Perhaps add raid1 to requires()?
Applied to v4

>> +
>> +    mdadm --quiet --stop /dev/md/blktests_md
>> +    cleanup_nvme_over_tcp
>> +    cleanup_underlying_device
>> +
>> +    echo "Test complete"
>> +}
>> diff --git a/tests/md/001.out b/tests/md/001.out
>> new file mode 100644
>> index 0000000..23071ec
>> --- /dev/null
>> +++ b/tests/md/001.out
>> @@ -0,0 +1,3 @@
>> +Running md/001
>> +disconnected 1 controller(s)
>> +Test complete
>> diff --git a/tests/md/rc b/tests/md/rc
>> new file mode 100644
>> index 0000000..d492579
>> --- /dev/null
>> +++ b/tests/md/rc
>> @@ -0,0 +1,12 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Ofir Gal
>> +#
>> +# Tests for md raid
>> +
>> +. common/rc
>> +
>> +group_requires() {
>> +    _have_root
>> +    _have_program mdadm
>> +}
>
> And md-mod here.
Applied to v4.

>
> It's nice to start adding md tests here.
>
> Thanks,
> Kuai
>>
>

