Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2059.outbound.protection.outlook.com [40.107.117.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD731156646;
	Thu,  6 Jun 2024 08:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664126; cv=fail; b=GTU0XjkEcNvyvPPTtjPQudLHNyNj5fABTZd+NkDAQq+qqP9/Jkw8j4dplBebXMLkowLS0I+FTc7z+XgDIq3sdYze6AdjsXkxXaNqr3Mp788uhuzUS9mxqvLdrV69GWyj7GRcCVY14O+qwYZnmEpZfnXxQ+7BIuoom5R5b63uJBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664126; c=relaxed/simple;
	bh=J2alaeWQ9eHZ6xb7v0Hy+exAguvjT14s78CcH3g0NSE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B9aLxqSY07EBYudUmKKBQ7SZbm/0Avyh5/8d6zm6M+pWMaHcJqgLm/gEW1SmJhXce/LuMTp3hMk5kDvdjQCNQe0KiPbrafF8Cp2/oTCcXiS8aakS8hgazCELZg5ikVYPPBV22XivMDGDi/zuX5+qWY19Y+D2Hp1AkJr2slK62VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OAez0Yln; arc=fail smtp.client-ip=40.107.117.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OAez0Yln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv0roeVJGNfal+5kzBuFoebzw2WDFWhAJASDezklvUSWVWEFsjrXoHol6DZKAuu8hNGknT+EEzy3yyMOoAxNvDqQS/IzM+A7+N5sQXIdh+BoeIrD7D04JfyACSaHbgJL++e5WkcQaHrZMdP4UhKJGMMhHbjNDbNpOUPsb2F7T741vEf+58QR63svxjdW2Ai0XZ43ysqUOfzbA4EJCOwbS+aw2s12N+ZzXZR7muS9ZyPAzwHIwtDdbMD8FvAhEFEHak18KXKo38vOmfuGe2fGEm1JT3Ubbo4rz5mdEPV5pZpVaulIOwv2hcULHKmid558UCbi/knCK9KCDH9nSiKs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5IAYnsyNZeMPjpIVZ2Nk+7W1nkJaq0ftVQyfYu4rvk=;
 b=miHv8kOSgf7uTHBeRto6+jvMe2QgVaVo8PCERBdpEMRYruvLXFGybjHABj4d0ott/SmW2EpYpEtk73msaX3w+hXqSlljDiKPIKN/og0zhw4pChEtVBABtLz5mAbzGaj5dxsb6wlx3/BASv1woQVZbZSFnjMwTSgDP0doYaNel9hcCADJrxY3BLFZEucr9v4l6zzazfwsu5ldi1gSV84EGaF0P8AS1hxxGERk9/h2KG+GiQaRgcPkDCqXkaypsF3Eq2FqbHiO/ZEkBvo7OO1nzuo0p2EcEi9l8YyYjVZiBuZMQb8mXNDPqJ4WRPrVc9aL4sWZuilMcrvVxp3cDp/ENw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5IAYnsyNZeMPjpIVZ2Nk+7W1nkJaq0ftVQyfYu4rvk=;
 b=OAez0YlnYl/YpUh2B7jLxKu+QZ+36N1emZufSIj3zHGJMpGxjNzq6UUdLY/ZtB1dTOGZbMfP6YYU0BykOtI7nTz6XHEAkYXQyU1NbON53MDQSrHMR0fngCx9IQEQ1dO0KieFOlroODZ6cbo45GoklnN3yYyXW92+qqUNYI/HguACiTqWjGupOAkMZojlDSImrP/68puKPRdYyDSQB2+L8mViHQxeWk7PaTxF/0AZYsoaHCo0h0VecdPHEGCNNtjBIsuLCGlaR+1P3+7eT/VlqdqRY5yYdXktsFn9B80J5MqsPN8FxkWx037YpxyBzA8GqfbpZ+JgY3NjI0h73pGXAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by TYZPR06MB6699.apcprd06.prod.outlook.com (2603:1096:400:45b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 08:55:20 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 08:55:20 +0000
Message-ID: <35bd4fe6-5ed0-4446-8fab-f86909212e60@vivo.com>
Date: Thu, 6 Jun 2024 16:55:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|TYZPR06MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 5835f2ca-cd68-433d-f617-08dc8606652f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2JlamJvWmprYkFlc01DQXdhT09RTFh0WEN0SC8rbW1IRFYyUWFka0IyMkxC?=
 =?utf-8?B?M291WGxjWTMxdmVCL3ErNUJnZllwTDY1RWpYVUdrMDdyQTFXQTNGRGNEdmln?=
 =?utf-8?B?dVB6QnU4WTU2eWlnbzIrNXpHYStoSDk5VzZvcExwbWFoQkZtclFKQzdMeUhu?=
 =?utf-8?B?RW1lbVU4UzY4RjdzcndWbUlSRjhLMHNZSU5EYkxJS285MndYZzM1UitFT1JU?=
 =?utf-8?B?NW9qSmNLbVN0cmZoM3krMUUzMmhEdzhLSm5VL0R1YWJsd1FUZ1Q4b1VwR3RJ?=
 =?utf-8?B?OVFwcVpJQWtzc2ZkNkF3RSs5azExTmE0akx5cGNTRE5YUUF1M2RYYnYwd09R?=
 =?utf-8?B?KzV2V0hSK0RVOXkwYitHNTZuS21XZmhoNGJ4TkNvMmFJT1hDUWVhTCtoNHN0?=
 =?utf-8?B?RE9pQWdOaE9JVGszOFZuUnZOa1NTeXJLbnRiMXBYcXgrNTNQYWM4MUZtNFBT?=
 =?utf-8?B?bjc2VTZoMjcwbi9QYy8vclhBcEtlRDliVFhNVzhHdFZFcmxMaXptOWsvYTcx?=
 =?utf-8?B?RmFxOVNIMnY5SkE1Qk4zSkJGaWRtWnBzdFhYVnA0WXlMaW5HRS9xZHFMVk1S?=
 =?utf-8?B?UlV2L1lZK0NXSjBTZjJRdmZVRHV1MElLYjU4SkpCTVhCZnJkZWF4ZlptWHR3?=
 =?utf-8?B?VUtheE43NGg3M3VlWThnZ0c5NjFUSnE3Q05nSER3eGpEY1lodFlqaXYvaTVm?=
 =?utf-8?B?c0c4RWczdWcybHBOWUIvOHkzZkJhUTkxelhPbFp5QWcyYVF6M3daV0k5bFR6?=
 =?utf-8?B?Z01nUk11V1dTeE8rM1VpeEN4ZGVQZnMwQ1RaOGFmMC9FSTJpU0Jxdy8yOE1k?=
 =?utf-8?B?RWxOWDFKWGFHSkx1cWNQeGJTT1Q0TFFidmRpbTYrVnhXTXUxRUZtNHFUbThU?=
 =?utf-8?B?UXFYVkdaWmhVM005N2NhaHVGOUZXYmE2cWFXa1FFZ1FZRStNK1VXVHBzc0Qv?=
 =?utf-8?B?amtRYmh5aDNpMjk2czRnYkNMamh4bHltMFpGU1dQNEkwSzFSdG1mNzIzUDZF?=
 =?utf-8?B?MU1OdkR6R0V2anRyMnJRaENicTB2TFBHdncwT3N6eTJaM1pCMFh3Q0ZKNk81?=
 =?utf-8?B?U2RxKytEeFc5L2ZlRFJBNzJ3RTlkTGk5WXlKck45QlFCUUttOGhOM0NNZGpn?=
 =?utf-8?B?endCcDlUQnRuSXNoeFQzQjFTRVYyY2s2cWRqS1lERS8yL2NYL0ZDbEY0KzVI?=
 =?utf-8?B?aUVJeDZzUFdiaTdhWUlqdUVkcG5tWTEvUUt6WFdRQlZ3WUkvSUFNMHJlS3NN?=
 =?utf-8?B?QUtaZTlVSEY4cXhiS2dlS08yb0hDdlhhS1dCZGtRc3c5dHB1UzFPNHdNdHp6?=
 =?utf-8?B?ektHUmhabStlQXpsMEFHd3V2N0kydjhSMlFXUmpmSTF2VWZYNXJBdzdUVnZZ?=
 =?utf-8?B?SmhjMGFOOWRhdEFuU092UVU5dXU5elhLeUhaU09HQWt6bnhWa3JLdFB3aGFh?=
 =?utf-8?B?ZXExakE4dlp0b1BWaHJYRmE1OXVFNGZRVUptcEY0VEtTS1BJQi9NWm1PN3kr?=
 =?utf-8?B?d0RoemF2UHcyMzlZUjBIME1TWHI5aXhHS3VKaHdKcUI0cHZyalhJOEJiZHFK?=
 =?utf-8?B?VllGKzhUdlNnUlZvZnFTVjhUd0RYNjh4VW8zVmRNSjhEaCtLenlkWHZLZVZ2?=
 =?utf-8?B?RGdQWkZlL0NhaWQ4SVQ3bW9tc1ljaGtSVDRjY25KUElNSDloNy9qbU9GbmVH?=
 =?utf-8?B?M2R2MzVmTXBtaE5TYmRXTUZweHFTYkNpdzhKK3NyQ1ZlNlNaNFBidVMxb0Ex?=
 =?utf-8?Q?H8fBm3bzHguKTK+r6reRbmqyHZTshFDeLQ592XF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3RPbnFDN2VScEk0SW5EYk9zQU0zbFkvVXFERmtPaWl4TVBJYUZTSlFJY05P?=
 =?utf-8?B?WnhvWWtTNzNjRFl6SDUxb3ZDZXAvVHNmbXlrSHNabzRSdWFpa3EzbS9HRVRU?=
 =?utf-8?B?dTRoUis3Sk5ndlRGdkl4SXpxVHVJb0s3VFBkYWM4VHVwRFBKSitmRldtU08y?=
 =?utf-8?B?V3NHbDVvc04vekx4SDlsR0crT0YwZEFmY1FreWhYNGNTd01lSWZ2NHFyNnNB?=
 =?utf-8?B?TUF6OWNJQ1ZWYk1sUlhnYS9ua0lwam4rV2RtVEQ1V2dlc2t0OGtVMXl2V3ZM?=
 =?utf-8?B?OWxhYTJ1QVdJUjhEV3ZHMzR4ZUpkQ3RudXBVUFZyMW1TSCs5S3V6WVRDRHRl?=
 =?utf-8?B?Vi9RRHljSWlBMDJ6NU5mdW9QT3RrQjFmUGo1Vy9tVzBLMTBwdmtXaWlwNnVM?=
 =?utf-8?B?cEhWRlFwQy94T0tVd2krb3d6VjBPZG53c0xibEpmM2JXYzFlY2tocTkyamFZ?=
 =?utf-8?B?cm1LS3dpeWd3c3liLzUxbGtrMEpkLzZlWUJKT3UzQ01sVzZqT1JHblExZ3FK?=
 =?utf-8?B?a1dQR3JiNW4vM3NYcFE5S3VJSGUzelZLWTR5N2pXK0JUZzZWVVJJSVdua3l3?=
 =?utf-8?B?SDljdUh1OEQ5RkI3THF3a0pUSG5Ed05jSFkvWXNnOUFDK2FGcE9UUEZNMExC?=
 =?utf-8?B?Q2V4aUNlbGowUFVSQVdMblpBcXhFM1E4VzVVS3haajVxNjdjYUsydWNMaTVD?=
 =?utf-8?B?WkdDR0FvSUJvMlp6Z1I3VlNnQlk5VWtPemUxZUxHQkpRZHgvM0gwYjVpWTl6?=
 =?utf-8?B?eTJScUcza1NBRFQ5c3YralVjS0dxdXNoNTJRUWhEVEVzWVhBZDZ6NHRBOG9u?=
 =?utf-8?B?UDI3dlFaQmlQdzhpN2F3Tk9RTzF1Lzg4Wk52cDRoZWVlUFMwTEhuYkpGWXY0?=
 =?utf-8?B?YmF0YUd6ZTF5ZkdIMDUvNDRrM0RodnVld1E0NnlPTStmSCtmaU5FODBUR3dD?=
 =?utf-8?B?MS9VM25ndTZKc3krOFhnVEdYVEsza1BoUjFKTjFPaEIzV1g3cVNWSHdzQlB0?=
 =?utf-8?B?TGRjdjZEMFhHNHovcklkcFpGeFBDSzZnb2xRdkFzNFY3Y2sxS0FjQWd0STR4?=
 =?utf-8?B?NlIxOFZhTWF6V3lFTXJhRHZPalMyai8zZlJ6V0ZrNy9MSWRaaGpLMDlGTlpY?=
 =?utf-8?B?ZlZMWkNESHhGWEVPc0hzcGoxTW50L0FOYVdRYzZqbDkyd05URlQxM2N0UGhG?=
 =?utf-8?B?b21HVS8rb1creXhLQTUwdlZlbDFUU25rTzN2U2JXb3I3S0JWRHh5a2VNaXFH?=
 =?utf-8?B?elZCNU83aFdnYlIveVBxb2lzZGdGZjFyR1VOMWFYRTBKWUt2cFVLaWpIa2Zh?=
 =?utf-8?B?UHRRWTQ1TEU4Umc5dlpocThjSVVPcWNka1Q4UWtRK1pmMWcrbkFPOVZiZUxx?=
 =?utf-8?B?OTBCVlFOZGdBOE02bkZkbWhzd3BOQUhDVGdLZ0ZjbVhSdCtDeG0wOGpMaWRC?=
 =?utf-8?B?RGxseVBuVms3RmJKUy9ld3NyNC9jR2d6S1NGekxnK3pRSkpjTDlBQUl6Qncr?=
 =?utf-8?B?d3FJV0dsbVV6bXJzUXk3aUFDdVBSVmxFNXM2ZVNIWW9sL0lBTGdXT3JtQVZ3?=
 =?utf-8?B?T2Qvb1RuRjNPNnFUKytHYjJ5aXNaTnNBVVlWTWVpaTBXcUZKWUE4TExoV29s?=
 =?utf-8?B?K0hOemdiZUZZSUtZN0htc0RrUXU5MXJyaW9UVytLZjNCRThaSTg4UGhaMWhU?=
 =?utf-8?B?ZlJrbGxFMForT2UxZTFoM3FzemdkRkd4Z2wxM2tQRWJxblFoMmdKb0RGN01m?=
 =?utf-8?B?b29MN3h0Q2ZGNi9ubTdrd05COGNKeWk3VzVndW9jSGxCdHN1OGd6VjBrQ2VC?=
 =?utf-8?B?WGl2cWlCSm5kQXoxdWlsQnRRMENhejIrMDI4TElYT251WVgrZm8xdUZCd2cz?=
 =?utf-8?B?V3ZsTFRrck4xalg4WjFCUy95TUxEZ1EraWpDQzBUdkZNMW4wK2M3L0NzVzdF?=
 =?utf-8?B?QkpHbGVZRmpSYVJoK2N6ZGxNWVV5YTFVTnp1dWFESTVFRkpXaVY2NjVQMDkw?=
 =?utf-8?B?M3dSdGVZc05KdEJMTFFPUFI0N3F2Q2xWOEFQMmRwVm5RSFR5ckhRWGM2akxI?=
 =?utf-8?B?N3hMSVRJRm82M1YzQzNiQ0NubWxYYk9EbVJQZS9GSmVXc0Ird0VhTVUxM21u?=
 =?utf-8?Q?EDNi/k0DwCilZm+2Oe22wwOWG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5835f2ca-cd68-433d-f617-08dc8606652f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 08:55:20.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ql3Pr+JC6sEnnke4pXpvk5psTzeQCU+L6Ei22UAoLjXd4nCJ7tiU8Pwg5FhWM1B6mWIzW5geZONG8KTnAvsVhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6699

On 2024/6/4 14:12, Yu Kuai wrote:
> Hi,
> 
> 在 2024/06/04 11:25, Ming Lei 写道:
>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>
>>> Configuration for sbq:
>>>    depth=64, wake_batch=6, shift=6, map_nr=1
>>>
>>> 1. There are 64 requests in progress:
>>>    map->word = 0xFFFFFFFFFFFFFFFF
>>> 2. After all the 64 requests complete, and no more requests come:
>>>    map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>> 3. Now two tasks try to allocate requests:
>>>    T1:                                       T2:
>>>    __blk_mq_get_tag                          .
>>>    __sbitmap_queue_get                       .
>>>    sbitmap_get                               .
>>>    sbitmap_find_bit                          .
>>>    sbitmap_find_bit_in_word                  .
>>>    __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>    sbitmap_deferred_clear                    __sbitmap_queue_get
>>>    /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>      if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>        return false;                         __sbitmap_get_word -> nr=-1
>>>      mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>      atomic_long_andnot()                    /* map->cleared=0 */
>>>                                                if (!(map->cleared))
>>>                                                  return false;
>>>                                       /*
>>>                                        * map->cleared is cleared by T1
>>>                                        * T2 fail to acquire the tag
>>>                                        */
>>>
>>> 4. T2 is the sole tag waiter. When T1 puts the tag, T2 cannot be woken
>>> up due to the wake_batch being set at 6. If no more requests come, T1
>>> will wait here indefinitely.
>>>
>>> To fix this issue, simply revert commit 661d4f55a794 ("sbitmap:
>>> remove swap_lock"), which causes this issue.
>>
>> I'd suggest to add the following words in commit log:
>>
>> Check on ->cleared and update on both ->cleared and ->word need to be
>> done atomically, and using spinlock could be the simplest solution.
>>
>> Otherwise, the patch looks fine for me.
> 
> Maybe I'm noob, but I'm confused how can this fix the problem, looks
> like the race condition doesn't change.
> 
> In sbitmap_find_bit_in_word:
> 
> 1) __sbitmap_get_word read word;
> 2) sbitmap_deferred_clear clear cleared;
> 3) sbitmap_deferred_clear update word;
> 
> 2) and 3) are done atomically while 1) can still concurrent with 3):
> 
> t1:
> sbitmap_find_bit_in_word
>   __sbitmap_get_word
>   -> read old word, return -1
>          t2:
>          sbitmap_find_bit_in_word
>           __sbitmap_get_word
>           -> read old word, return -1
>   sbitmap_deferred_clear
>   -> clear cleared and update word
>          sbitmap_deferred_clear
>          -> cleared is cleared, fail
> 
> BYW, I still think it's fine to fix this problem by trying the
> __sbitmap_get_word() at least one more time if __sbitmap_get_word()
> failed.

How about this one:
1. Add extra check in sbitmap_find_bit_in_word() referenced from
    Yu kuai's suggestion.
2. Change from atomic_long_andnot to atomic_long_fetch_andnot_release

---
  include/linux/sbitmap.h |  5 +++++
  lib/sbitmap.c           | 23 ++++++++++++++++++-----
  2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index d662cf136021..ec0b0e73c906 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -36,6 +36,11 @@ struct sbitmap_word {
      * @cleared: word holding cleared bits
      */
     unsigned long cleared ____cacheline_aligned_in_smp;
+
+   /**
+    * @swap_lock: Held while swapping word <-> cleared
+    */
+   spinlock_t swap_lock;
  } ____cacheline_aligned_in_smp;

  /**
diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index 1e453f825c05..63dadf91e40b 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -63,9 +63,13 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
  static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
  {
     unsigned long mask;
+   bool ret = false;
+   unsigned long flags;

-   if (!READ_ONCE(map->cleared))
-       return false;
+   spin_lock_irqsave(&map->swap_lock, flags);
+
+   if (!map->cleared)
+       goto out_unlock;

     /*
      * First get a stable cleared mask, setting the old mask to 0.
@@ -75,9 +79,12 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
     /*
      * Now clear the masked bits in our free word
      */
-   atomic_long_andnot(mask, (atomic_long_t *)&map->word);
+   atomic_long_fetch_andnot_release(mask, (atomic_long_t *)&map->word);
     BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
-   return true;
+   ret = true;
+out_unlock:
+   spin_unlock_irqrestore(&map->swap_lock, flags);
+   return ret;
  }

  int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
@@ -85,6 +92,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
               bool alloc_hint)
  {
     unsigned int bits_per_word;
+   int i;

     if (shift < 0)
         shift = sbitmap_calculate_shift(depth);
@@ -116,6 +124,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
         return -ENOMEM;
     }

+   for (i = 0; i < sb->map_nr; i++)
+       spin_lock_init(&sb->map[i].swap_lock);
+
     return 0;
  }
  EXPORT_SYMBOL_GPL(sbitmap_init_node);
@@ -175,11 +186,13 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
     int nr;

     do {
+       unsigned long cleared = READ_ONCE(map->cleared);
+
         nr = __sbitmap_get_word(&map->word, depth,
                     alloc_hint, wrap);
         if (nr != -1)
             break;
-       if (!sbitmap_deferred_clear(map))
+       if (!sbitmap_deferred_clear(map) && !cleared)
             break;
     } while (1);

-- 
2.34.1

> 
> Thanks,
> Kuai
> 
>>
>> Thanks,
>>
>>
>> .
>>
> 

