Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2061.outbound.protection.outlook.com [40.107.255.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DBA17C213;
	Tue, 11 Jun 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718110460; cv=fail; b=M43708CkbxZB4gWCAz7YHWO5THPaI4reXNL7djdi7U6af0oUfTulFwXABAzghZ3fe6T2DJXRhy5tXBX7It3A22/l0YXF12RKA2lShGuutd+W5lKiLsXkg+9EB2lpuzo5TI4GgBW8IRmj66qC61TcZ/tM9v/v6HpedVWllmUlikk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718110460; c=relaxed/simple;
	bh=MT0aLWZWZMK4Q3fTv2oJ3dE783tdPeLB0CZuCEScoss=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hr2wYOLjBlqZd0JPeaOw+7g+3Exclwqnqm40wkfIZtgA5wUq+EOE7GArU5t4nm+mkNouBpLJ6eSqw6jqg6ax9UWna3jnKhtZsam3Iq5QLcp55bjUOUY7FDslBTt3sksMI50sSE8n8+MDNk843Msvafe5CzZzGQNkchLaFzGuMTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=DDHWSBmd; arc=fail smtp.client-ip=40.107.255.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="DDHWSBmd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+d9B/CNZczRDnIKFQe1W4obPNMeoM2ZMzAlfpE+HOKXYoqAF/mr4gIHjXVBDqFlc9sJlNONdu7OrgL/h+e8wbBUwnAs9cSCYEqe/bkoFDnYZT4TV6+rgFuYvJ6lgkrFY4P0ZTrH3jrDby2Tp1bWbYcQktoFQpdaCPsDoM28FluyiTEMiZ/upMr7PCbGrIZ6ycPWA2FoYMThb8fA1PSrB4C277NRjlVHyMfOHIhvx1ZtEVLgWfQABBV3v/9Q+MbRXiZbj05qCPT4YYVLkdYx2NaVdriF2vPHp59bGcXtL6XwT2WBixteZ26xuolyvNPqYWHnjJKFiS1DXSw9gta0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84UITnNBTwdQBkTBVMzIVDlbKmO3MeP48m1K8C/hLqw=;
 b=BnEA+dXUGDyCQcLKMX2t/XzrEM+2eNmDfHdiCEjm/D1gzhE3wPWv7pInbb0taF1w9VE+01pmJHGyASOIu1vD45V+SNTttEysKD+OD6CY+OUtic33kvto8ZQiaMjSi23p3jdnFnW/mWcaJiZEiVX422kNQBh/sccf7k3WygtyDWfAUdWrL9ab4PbzoI97UoQx45ql1df9J7FTT+XPHpj2YEHEX7dKej+/PfBpJSLXmGJ++t3eu6wsxtbt2y3JEMjFV1nBVjGnqzapIRf+YL7V+pcZiCHPmqX7T1EwV3vBVrjrN/f2Nn7Joo5TkPFbqo5G/b8c5RtgZ2H6Oq1Yx2xCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84UITnNBTwdQBkTBVMzIVDlbKmO3MeP48m1K8C/hLqw=;
 b=DDHWSBmdRRIi0UxoUNUTxswtdDKs54KeqGePcP4Q8Atp8CFcQ5/+jJxWmruvKeopfQWIc9KwYHNFALBFaw160C5nJCzv5nviW+rqjtEmxaW8bVgqXNN+rUW3VuqJ2/B/Ke6oiVblg15kurvrgvOM3to87w8XV2k/+G2bQeEUGY28h1aRLBcYOUyEHVxaIAnjAzjylzB5ldasFRI18F4UsA8OXhLNUde+tUIvopnAN/rCV8xxV9/3NAqJGV5EKPsZCPTvmjWGRLca/3Sr77docO8XBqQKMpIwuuxkp8OqS/LvtZ2Er+1menSwt3afu5gg/cbbiJSWl70jHiLvMlN8tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB6816.apcprd06.prod.outlook.com (2603:1096:101:191::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 12:53:53 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 12:53:49 +0000
Message-ID: <c28e9a07-c538-4f85-9eec-dc9d00679499@vivo.com>
Date: Tue, 11 Jun 2024 20:53:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 "yukuai (C)" <yukuai3@huawei.com>, Yu Kuai <yukuai1@huaweicloud.com>,
 Ming Lei <ming.lei@redhat.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <e1cdf579-007b-415f-9e4d-3fadd6f97b36@vivo.com>
 <cf8bb1db-b601-4f54-bafc-d6c58f6ce946@gmail.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <cf8bb1db-b601-4f54-bafc-d6c58f6ce946@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ea955ab-6560-4f28-ed0f-08dc8a1589ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzZuUFdDa201b3lSRm9OZnM3aXgzN3IvK1RjYUZPZ1JsS21TK2dOZzllenBW?=
 =?utf-8?B?K201MVVCSk9JcjF4ZkJuR2pWb2xWQTZ3b3lVM1Rub1ZkMU5QTmc2SGk5YlNk?=
 =?utf-8?B?bVU4c2dCVFlBMlYxL09hM3B3TnhmNnJWdXBFaVpIbHlvSnRmaFQwQ01VeDJa?=
 =?utf-8?B?ajhrQW45NThwejgrT3lvOHB5QTVMWXJDd2R1M3hlTkRhSnVJeHpwWHJiQ01h?=
 =?utf-8?B?MUtsMVFnWFVvdWl1RkxUN1ZUcnh1eDJ1MGZoa2VHYzVUdnpNME9ZTSt6WnZP?=
 =?utf-8?B?MkMzL21MQlJ5NVJHVzVxaWk3MVFFRG5nUUY3amgxaFc5WWpFeFBXN3FzeGF3?=
 =?utf-8?B?NDhZUkFmdS85Y1hBdWNZRHlRQXUyTWk3S1VOd0I4WGEwNGdTM01acUZNUGVN?=
 =?utf-8?B?MmJ4MTBCQnNaVit4R2dUcGJja01NZ2pNNEZLMmJSUHJVUFhvUWtBSzN4Y3Rk?=
 =?utf-8?B?RHhhN3A0dUlNZFRHUHJNbTVNNHVZMFJJTTBFTGd4NFc4aWd2VmJJQ0ZqSElG?=
 =?utf-8?B?RmxHVDR6REpjdHpaN1YwMXNaeXlYVDJsQ3lyWDFnV04wSlcrTzdwRFFkNjBK?=
 =?utf-8?B?Rm9YUzN6U2xlRFV6eW05RUIveUJvdThHdnhDYjJUSTBBbExpUFlnSm5ONVp2?=
 =?utf-8?B?VFkrTElMVlhWdXB2cjJOR2czcVovdmx1NFR1TEo3dkhBUkRacy9SNzEwWm9F?=
 =?utf-8?B?YU5hOGVEM1hTQThGTWtxT01PYkg4TnAyaXVCWlJzZG81U0dTVUEzVGhEYXhP?=
 =?utf-8?B?S0RHTVJVQ0hMY1d3NGp6TTBxLzIwMjB0ZzdiclJVeE9TTDNEcG9haDB0UmNj?=
 =?utf-8?B?cCtOQTFCVjloNlE0VzFYVWJiaFRhR2xvcVNVbWs1Q0MrbWE1Yk1oVUpzNFBW?=
 =?utf-8?B?UDhBU3JjMmN6YVpUck9FT3J1T2dWaHRPN25OZE5NYnlCd0FlQ2RrWDJFUFQ0?=
 =?utf-8?B?c1puYm9UT1NtL0dYL1MyTTYxS20wcEJtMURCbUs5bC9RSzg4Nkp3dHVzNzU1?=
 =?utf-8?B?MkpYS2pEdWxHU3p3MXRnK1lWVEdDdE0ySEdBOWNOSXRXRVNoK1cyY0V0VmtZ?=
 =?utf-8?B?VVYzZERwU2U1V09zSHVEd2tUTDgvTDg3aTh6QTRsOHkzZjJ6TGp5WlRoUUx2?=
 =?utf-8?B?eWg0VHpkWlNOTlNhVWxSeWZWOStWSjVZd2xIQXhxSm1PTXpYbzhOTnhqdnpJ?=
 =?utf-8?B?UnhzQXU1WW1aOGZRNDJ3TW56anVMdEJQSEVGdTJTMkRheG91cXRpdHNkanlX?=
 =?utf-8?B?WDVzWGdHUlMyRlJ2YTJhZTdBQ3JBV3JIa0lua2ZHUVdvbzlGK0NDcEkzVHZC?=
 =?utf-8?B?MWJaVVZvV05GT3hxV0RndytxKzhHSWZEL0RQVStjQnB5dW10QW1ZWXhxamRs?=
 =?utf-8?B?SHZmUC9VM3BkbVcvVUlib3oxVENpM3BpYmRPZmV6czJiNzFraW5OelRQam5v?=
 =?utf-8?B?OURkSnJVV0M1QW10VDdQejg1MzFHN1p5ODFhcW1TNVVrNjRSenNBaHVaNldP?=
 =?utf-8?B?OUUwQzNKU1JLNHFtc1F0WGRvWEtxejRKL2RYbUVna3RibEIvT3VBc0kyM0lF?=
 =?utf-8?B?b1hRbTMxbkQwKzljV0QyMWZUbkc5dXRSaGNGeGFGR09BU3Q1eDMwaG95ZDVQ?=
 =?utf-8?B?T3pDNUJyWnorejdicEZITzVGUllCQ29hUG1CNWVyRTFFT3Zxa3V1eHhNSTdp?=
 =?utf-8?B?Uy9rOWxOaU5VT2RZUWZLWXpUdDIxSWR3TCtIM3VjSXo4TlRaeStDb1RRR25k?=
 =?utf-8?Q?Mgdm36q/i8fA+JTw/yl5oEJbWsrMLhUDpjhtCxb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZmbWtPeHI2dkVRUlBMWkJhc0J4WWU4UlQzUURWTzE5SEd1MXJwd1ZVMHVW?=
 =?utf-8?B?dFUrcDd5SlVRUEJjUVJmNm5zckVZNkxhVk1vTUtWN2RCOEFibENkZnpTWWNt?=
 =?utf-8?B?VzBmendnVVEyYUpER2dQdEVqcnlWSnFzQWwxdXdoV015NG43eTd2UU1JV0xD?=
 =?utf-8?B?QmF6end0VGtTY0NlVzlmRnpYU3d2Vm93aS9yK25ZZU91OUVzM3ozemw4NlZK?=
 =?utf-8?B?WVNXeEJyZEU0dC9IVTkwWUNmZmFudzhKakdyaU9JV0lxSkJEOUJ0Uk1XWjFl?=
 =?utf-8?B?NEpvelpRRkhsRjVKMDljS3hJSHA3VnhoSll2M3lZall3dTMrWDJqV1R2Rlp6?=
 =?utf-8?B?UnM3QXRZcm9JYjVJM3FNVjY5NGRscnhqaWx4V1EwMFVkTTlPenpFTUgvV2dj?=
 =?utf-8?B?cmE1dlAyVE5FUHZycm5lUzEyY3RuWjZHc2FWc1BCc3NYdnF4amp6N3l3MlY3?=
 =?utf-8?B?blJESVh2S3U3QnE2UjgrSDRIMWlTanhpR1pLbkhOY1prbitqNzZmVzY0QlE3?=
 =?utf-8?B?bnJiZGlQeVdlTmU2TlMyU1dlTnl1cndWekIySHkzdFlySE9XT0RIeVJEOUJ3?=
 =?utf-8?B?TGM2WXg5eWZXQ1pLQ05wNS9rOXkzNnZKY1cwMXhxTFlEM3Q1VUJZcU5iSDJX?=
 =?utf-8?B?aEcvK3hLays3WHpyeHdybjA1WnQ0aDVDdUxBSnFtQ1kwUlhadmV2d0Q4ZHVB?=
 =?utf-8?B?alZidFRSM05sU2xnOS9aelRBZHowK0E5TUE5Rks5UVV3eGZVSmZTRXZQczND?=
 =?utf-8?B?MzNKc1VoU0pLd3hUcldETjZta01pd3Zpd0dVZ0tkb0Q4SWZja3dHeVR0Y3Uv?=
 =?utf-8?B?a0t4S0FZeFpvSUc0dmRpVnFrbnRCck9aYmhhekVUVXJYV2Q3R2haVG5HS1Bm?=
 =?utf-8?B?WGRMc2VQd0tzZEFBRjJOWmRQVnNPTmhtRk9mejd4M0dmRnFTWDhNN2YwQW9J?=
 =?utf-8?B?L3VENVdxdlk3YURDVWpRSkRocjhkNFYzYWsvYmx6SHRpalAwSVRlM3I4ZnY3?=
 =?utf-8?B?K2dzeVRxTVV1T0plbnUwQktIT0Z6YzVKMzg1cGxaVlY2ZndqRTJtRGlQdjlv?=
 =?utf-8?B?NFVrSm5KZEdFeTRyNVVuZjV1Zlo1aS9zTVNkdnZTRFpUbVZ2NUlhZE15WEt6?=
 =?utf-8?B?VkRGSlJLaHNyb2pHa0VKaHFabFVibTVJKzZjaXV2V0UyYzdRcEdCWlo1RlV0?=
 =?utf-8?B?ZVJMOTE2ZU1kdGhQYnlOc0NyQ1ZwZGRzQ2dSN2xnMmpZaDE0b3VVQk9mRHBW?=
 =?utf-8?B?cUZ0NWVINmQxMXF1VHhRZStOZkNFTXQvUTBWemlNVWttM1NxZE9nWW9yelBi?=
 =?utf-8?B?eGtzUjJLeFFFRzNZNDR1aUMxYkh3emJGVWtuYlQreGthS1FqSnhvcHc3aVUw?=
 =?utf-8?B?RW1BMmR2dmZzTjNYTW8zblRvcnZGNFNuaUZaZEErSk1GeG1yYzFQZ0RPZGtv?=
 =?utf-8?B?QW5aQS9xalpHTEY1SmU5aHFXc0hEaEtVbVF5Q2hOWGpkMDZhMVZybXhUMWJF?=
 =?utf-8?B?SWk0OTJZbzVOVHF1V1ZtV05oL244N2s0TTZ1VXVpQnFIdXhRandnK2h6U0dj?=
 =?utf-8?B?ckpsdkFCVzRkNm1DNkhsMTRSYTJKWUdPYWQwY1AxVXNybUJKMlcrdGlsWWJP?=
 =?utf-8?B?cHpOeDBreHg5WlNYVW8rKzMyaEdOQ0F6SjZ6UEpianpnQ094ckZYUmpVL3Jw?=
 =?utf-8?B?SlNkQjFKaENveUxQZHBPcWxLTzlGQmhYUUM1dmJNMUNESHl1TUJ5OGlSVFVx?=
 =?utf-8?B?cmlYK0g1YnVaeUZxTmMxSzZjUVpOZzBrY2xJMHdjeHhOaWhxelRkWVVlenh0?=
 =?utf-8?B?NGpaNitWYnZFZjlDOWFHMy9jVXdFQzNtbGdYamJuVEI1T2JLb2VrZy93MVlT?=
 =?utf-8?B?bHZqWkhLalE0SXYyVDliMXBjenNrRktYVnhLa1JMbFNmclRFTVBJdHI0Ui9n?=
 =?utf-8?B?ZEdJRDZRTDMvc2NkTzIyNlhYN1Boa3FKRkNBWWsrL3VFS0NFM0I4dGR5b25L?=
 =?utf-8?B?YVVHbFdTT2syWEx1L3ZiczE5QWxCWmtnZURUZlB4OFFzZFZxR1pFSFE4VW01?=
 =?utf-8?B?dS8vTmJ1Y0Z4ZGo0Tzk2OGZHOW1CSit3QnROWEFYTkttOTF4MmNpbGp0cWEz?=
 =?utf-8?Q?VpbZZAOLmjLii7URph2EoQRVn?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea955ab-6560-4f28-ed0f-08dc8a1589ec
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 12:53:49.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jm8xgtdKRO0EqEkW7kQng/nsbbKiRxVaNVmBexHP49PrpQu2suEyf2mTieiUVcJctiL0ek5kduZ8bS/J5HY2JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6816

On 2024/6/7 20:59, Pavel Begunkov wrote:
> On 6/4/24 08:03, YangYang wrote:
>> On 2024/6/4 14:12, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/06/04 11:25, Ming Lei 写道:
>>>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>>>
>>>>> Configuration for sbq:
>>>>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>>>>
>>>>> 1. There are 64 requests in progress:
>>>>>    map->word = 0xFFFFFFFFFFFFFFFF
>>>>> 2. After all the 64 requests complete, and no more requests come:
>>>>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>>>> 3. Now two tasks try to allocate requests:
>>>>>    T1:                                       T2:
>>>>>    __blk_mq_get_tag                          .
>>>>>    __sbitmap_queue_get                       .
>>>>>    sbitmap_get                               .
>>>>>    sbitmap_find_bit                          .
>>>>>    sbitmap_find_bit_in_word                  .
>>>>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>>>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>>>        return false;                         __sbitmap_get_word -> nr=-1
>>>>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>>>      atomic_long_andnot()                    /* map->cleared=0 */
>>>>>                                                if (!(map->cleared))
>>>>>                                                  return false;
>>>>>                                       /*
>>>>>                                        * map->cleared is cleared by T1
>>>>>                                        * T2 fail to acquire the tag
>>>>>                                        */
>>>>>
>>>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>>>> will wait here indefinitely.
>>>>>
>>>>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>>>>> remove swap_lock"), which causes this issue.
>>>>
>>>> I'd suggest to add the following words in commit log:
>>>>
>>>> Check on ->cleared and update on both ->cleared and ->word need to be
>>>> done atomically, and using spinlock could be the simplest solution.
>>>>
>>>> Otherwise, the patch looks fine for me.
>>>
>>> Maybe I'm noob, but I'm confused how can this fix the problem, looks
>>> like the race condition doesn't change.
>>>
>>> In sbitmap_find_bit_in_word:
>>>
>>> 1) __sbitmap_get_word read word;
>>> 2) sbitmap_deferred_clear clear cleared;
>>> 3) sbitmap_deferred_clear update word;
>>>
>>> 2) and 3) are done atomically while 1) can still concurrent with 3):
>>>
>>> t1:
>>> sbitmap_find_bit_in_word
>>>   __sbitmap_get_word
>>>   -> read old word, return -1 >          t2:
>>>          sbitmap_find_bit_in_word
>>>           __sbitmap_get_word
>>>           -> read old word, return -1
>>>   sbitmap_deferred_clear
>>>   -> clear cleared and update word
>>>          sbitmap_deferred_clear
>>>          -> cleared is cleared, fail
>>
>> Yes, you are right, this patch cannot fix this issue.
> 
> One other alternative is to kill ->cleared. It's not
> immediately clear how important it is. Do we have any
> numbers?

Sorry, I can't get it. Are you suggesting to remove ->cleared from
struct sbitmap_word entirely?

Thanks.

> 
>>> BYW, I still think it's fine to fix this problem by trying the
>>> __sbitmap_get_word() at least one more time if __sbitmap_get_word()
>>> failed.
>>
>> Err, after trying one more time __sbitmap_get_word() may still fail.
> 

