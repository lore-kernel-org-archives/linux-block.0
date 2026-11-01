Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793574962;
	b=gcJoyQcvGKDlRZoMdOHaNbfhnCSEYeIvUv5hJacvglaCT10nxKSROi4VcJFSTGQ5m0NX
	 mvl5gKdSuHfKdZvzQz7QwXje9hUH0WvPy14osqeix//RXuxYwFEAxwkUzm/svP1AUkhE7
	 XOknpUHQrjxjjoiLARkqbvDB/V6jzHmvEQAZhAMNlEkslZoMF+6+hWhmYFIdsZ+h6xDAj
	 U6KB4eMCyPF84iHA9OFkCLADMF5qyMFECNN4KrJ6FWH0FVWQSlEsybL+bn5GGrQYnZR3b
	 rHXS0Qg0tOp9uQzK4eZXqdK3g0Lw9ukWzadU/m/3YG68uYU2G/rDH4+CtiOsHrIFIaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574962;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=P71CNg6DcQA/CTmBMnkoOQtNZHGmBfL+bIKeQHrP9Yg=;
	b=2uYsVeOU45GqS85NiUfuZ/Qlu20xAaep4zUjEYZD0ptXhXd3DCReJTBBH4drivBAOpMv
	 u+xNhKC6piwKh424gO9MzE/QekklmAQjejRGRUQ8AefSokvGopvxSKOajI+u0y5wRo687
	 PpW5SDZPPApU62cF0VaOnMABWoUHKmjcW/4+d+mvx8Uum1joplDJ1Gy7sPSva2L0hWQL3
	 X9zrhql1Sa9/wySY8fH3jrPg9F5hozAdK65cN7PbAbN9DMofX26qkgrT0m/Vx3XvP3wDB
	 ejHW8nei0D92nwtaj5i4LnCqIYXTBjpsmyKzSZefQBl+5r2QU/5iM72NaG/Sh0inRfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KMykbOLf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.25
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD4606A324;
	Sun,  1 Nov 2026 23:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53AD4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=KMykbOLf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYtnlyAPxP3hfHD+XJzfWAdiVrskx9ADu6UqvlYn6LGk/dXw7lntnTBJiuLbMtZQ9khpRxwMwKyeI7sih3Xw0yjmCXAXAEYkoyyNAZPLWU1v9j/e1aZqCpvA+n3yTjJ+D1Mmn65NflBhS0K/71XOCIk2o043KhPVCwtibV++iKfOZ7zWo0Q5yKjrQM4TL2IA+swlLbOQ8kCP3m2Q3T0xehRbstt0qeLN5Dlie5h9KgQeatr7Lg77b4dWOU8UQ6fG33c3A/MnJD3kmub+9W4Yl0fixC35fxKPRJUvhrukAx/k2xp82sosfzd66pOPOK4vHtqrjxinM54F498px02LJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P71CNg6DcQA/CTmBMnkoOQtNZHGmBfL+bIKeQHrP9Yg=;
 b=geDJSmbDFmJwdF8qEOFrd9/ytuyiNRAWUOu8+GIe7U5iZYIHnqfU2M1DZiGkkne9Z0zkYrRQKGHdGzppUOsbyI/9/3osCTZct69TCzEV7C/9aezuvO2rl8WuEJAP2Dv13xEdMqbDV0rAEsE8G7yPiTq1yLeQ8hsB8fVt+lzr7U68T6QqN55Wy5rXTZJImU/iaGJca2pnvSLNkFUTqtkRvfE2cnVqf4OthE3v/mvDv8A0urx5Ot8BQelzn+R53VAqIfNNuSS/A0EbTIJCbidcT7sPq+fbm3w3JFbbOfCRdoMtlFb3nN81dAwnf37UcQYxDpQnzsNUcsR4B7QKCK+Diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P71CNg6DcQA/CTmBMnkoOQtNZHGmBfL+bIKeQHrP9Yg=;
 b=KMykbOLfJV1rWrVp8x7IRG/FTXClSDeish8eqUzZsP0yyo55aJSeSGG/g3dwL+gWJf5kcOTwVa21edJvxUjCqOXY1lBvvjRkty+E0M4PQnupyT6+e7wSdKLda+Gjr/faCmPYF3R1Z6cLpKA/IsLBwdQqkVquJMMBnhvA9CWWFOYP+EK+FW8raMcWfFrNxo8CCbjHdPDO6OkP7lF8sE/UKyUeBaAuE13Li2YBFJ9hWbg1m8edaSEz18j8prcDU9+q1Cp9kDAgA+TayGleLkd1YC1wlV+apfhkbNpnY5BJr16MvOr6S1tPlg61zAX4XnNHWYqoNvWH0UGmE49E6Z9NEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA1PR12MB5614.namprd12.prod.outlook.com (2603:10b6:806:228::7)
 by BN7PPFA42F4F89B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Sun, 1 Nov
 2026 23:15:55 +0000
Received: from SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6]) by SA1PR12MB5614.namprd12.prod.outlook.com
 ([fe80::1a0c:e9e8:f3a5:d9d6%6]) with mapi id 15.21.0569.009; Sun, 1 Nov 2026
 23:15:55 +0000
Message-ID: <2007d168-1b40-431b-8e17-3b3020b6368b@nvidia.com>
Date: Sun, 1 Nov 2026 15:15:53 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: bindings: derive Zeroable for bindgen's opaque
 array wrappers
To: Sasha Levin <sashal@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Josef Bacik <josef@toxicpanda.com>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <27b58e47-723b-4d67-a1f0-ccb8b0ae66a9@kernel.dk>
 <20261031152846.746656-1-sashal@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20261031152846.746656-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::13) To SA1PR12MB5614.namprd12.prod.outlook.com
 (2603:10b6:806:228::7)
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
X-MS-TrafficTypeDiagnostic: SA1PR12MB5614:EE_|BN7PPFA42F4F89B:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c0d226-5aa3-409d-086f-08df386e1482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|10070799003|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Y8YMra+evX8XqBiSzs7ba0TVWr2uRhJD+N3QGPxFmTMEdwNUA3CgWas+N2jAw9XYvEF2gr4FhanB0LprIb7wBjIwJSsbw63WI4aUiwSISWTfszBhyzw3ANpNdGv6o3vu6O48rgk3j/6MLNuSMPDmGS7AWdNMt3Jb3hz/esj2FRdubJxZ4YoSn5Yef1SOSspnkS5shUEfuJajlfop8QR7jnuwav4HV60vjAiWrpCifgIbnB3/IvN9ssWt1YW2EoOiFEaYDtN/GIqQeAnomCAStJnEGQgdM0PapOCuhT1FQAGa88NA3/M+9Cn5wA7yMHsat5HJdtuyfauc3px4r5kXQlp+smkvkkG0RHD2Tdnfwaf89kC6rmwNE0Nda9qjKRxJGRN//FAushQAO/kasKZHioTdhPP1kMEoZrlFSub2YEKDucOekbFj1h85DoVaQsAtrNkSW2UOb1Ye+7NxornbfwzAl02Lo5vUwrEqkrd/dNEhIv8kCUIGiYKwqPAn2AckF8TEprXBd+G6W9WLoWGYV/rqvpQKLtHWr57dh5DU3pHvilBAQwqpEfJ5fwjevwH5I5KU32DxLi4Lsp+mDot+qjTUKd0GugzzI2nTiYZF00/utfRPUALfdQdH8bImk/yi/i/5VgjsEADLKd9M4Acq38A9AMtKTqjVxrAAbv0fZ4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB5614.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(10070799003)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhWaGlYWHhGRkN1QkZncTJhSGdvTnFnYmFFM014Yy8xWlFYR2Nub1NEcWVn?=
 =?utf-8?B?WUwrVEVRYnZaczhaTDdJQzNRaUxQbG5PS2RWbHUrMWtmYUlUNTArclhmU2RC?=
 =?utf-8?B?TkJzdm1uTTlGS3dZYTY5bXFMeHZ0Ti80RjFobTVwcFZ4SHFURW9McTY4b0tK?=
 =?utf-8?B?NkZsQjM1R3FIbmpZeHNJOFZIL2Z4cjBnd2kwVnpYWUlLckR1K2tNWHJ1REVV?=
 =?utf-8?B?NFpDa1pSaFBWVnFIOXNqOU10ZjVZaUV6bHhPb0RHaTVEME9IWTlZZmVra3ox?=
 =?utf-8?B?b2JySjNvbTNEOEVoTWp0S0d0c1VjQXBkbTR6R1BlK0J0UVhpV0ZPY0dBeTJR?=
 =?utf-8?B?M3cvamtmSFZIYy9xSytSSVdWZDRhUUVIaWZkS09oaUpVaUY0ekx3eXdremVw?=
 =?utf-8?B?bUFxNGJOS2hTN2dlMDE5TklRd0dyaEpTZ2FvcmpTMElQZkh2NGR4N21mTENr?=
 =?utf-8?B?amt1VXZ5OHZuU0k1cjliMTAvR0pFUUNoeVdmYjFyRHhSQTg5U1pBZXJUZm9y?=
 =?utf-8?B?d0p2WCtBQkV4VHc1Tk5ZOXpJUnhzN1BITTV3bEdQYjJrbmFIZkFVVDNvV2Yz?=
 =?utf-8?B?Um1HTm5sLzlrRWJMaUwzUmx6SGdoQS9Wc3p6Q0M2c2VhS1d6alNxWm02Um0w?=
 =?utf-8?B?OFF3VFdqckdiT1B1T3VIOU15Q1VLOUFHbDhLK1FNTzkzUk1RL3c4Z0RIVHBE?=
 =?utf-8?B?Vmk2N2RxWFRSVHo3MW9SNi8vSVJlWWxSOHNYZnZiWVhxcjZ3RmhjQnFnYUtT?=
 =?utf-8?B?R3BwK0x6VDhrS1dIbjdJQUtxa012Y0ZCUjBNNS8xR0VBczRFaC9NdzBnQ2lk?=
 =?utf-8?B?NWEwY2h6V2VWTGVzZGdQL0t1ZUFEd3pSODRJeStleEhOSVkrWlpQV3A0K3lM?=
 =?utf-8?B?dmROdGpHS2pBN0cwc25QWnVKeXdmUlJFcVJ3YVpmbitvTjVDYklDZVJvcUk1?=
 =?utf-8?B?MWRrdUNZZGsxempDWEN3emc3WmVWOURPbkZGeXNyRHFVYnA2dG03OU5yYlls?=
 =?utf-8?B?cGJlcS9STzdhRkdoNWZicDlOUjBxNWRuOFduSlhubzNZWW5sNlI1ZmsrYW5w?=
 =?utf-8?B?TUZ4dGduK1VoTzNvQmxQMllVYUZoR0VsWmF1SGpFek01dnJJV2dRRnVCKy9u?=
 =?utf-8?B?aFgrY1dDRitVZHFBOFpYTU9Ha2pVcFdOem9UZEhUMU5Ddyt1T3FzUXBjK1lP?=
 =?utf-8?B?akxNUWFobEZmc1NvaUttb0oyR3A0dWhXaXh0ZG5WTldjMmRzd3lGbERkN3o5?=
 =?utf-8?B?dm9NN2p3NEJXZDFkNG5yZjV4M2JBK2lUWUU0Q3pVOUN4WWlUYlhtUjdORXNv?=
 =?utf-8?B?MUR2RU9xRURtWlI1UndRYU5DWXFDalVqcFU0YTlBbjRyQ0w1azBsbkFiS3RI?=
 =?utf-8?B?WVljRUI0bXp1Q1Y3SlZSWExBRllSL1k5LzdhQ0swekt1M2wwRlVNeVRRclU5?=
 =?utf-8?B?ejB3ejl5SkZSV1hFZ1J6QVNqeVlsM1o0SFA3bm5Nc0prOVJlL3ZQenMyMENB?=
 =?utf-8?B?S1BTQnk0akhrSW9MaFdpM2FYYlp3WmFacjlIUnVpNFBaY0Q2TmVjankzeSt3?=
 =?utf-8?B?a1R0SWhVTUFha2lydWJrcCtCanhMdFEreDg0UDhGRnZJbjFRM2VReVBhT3Ur?=
 =?utf-8?B?QUlVbUJZQXlCeUZSdjdDU2sxV3E1RkxjR0J3VGtMQWRyd3RmelBpOFMzU0Jt?=
 =?utf-8?B?blNETHhJSFhtQ1prQnl3YW5HRDRtQ3Y3UVI3RWJCQ3FHVUoxakt6Zlo4b2Vm?=
 =?utf-8?B?bmMyUVBHMHp6dlhzN3VoV2J3MDgxMDlVZ1V0OEozMnJEMVpVY3JoR2FuVFp0?=
 =?utf-8?B?NHViOXcyRUhuUTQxMUVSNktzYjU4RGNCVlgxV3JGbkI0TlphTWxxbGYwajJ3?=
 =?utf-8?B?KzFzdkFkcFlkV0hhSlJ0YnArRVhRWFo5NS9uRlNyeFJPbU52SVZvUmhLeEVt?=
 =?utf-8?B?SExncjhSWVBjWWZlanlFOE1PclZhTXVQZzM5dXNpaVhkYUhzN1JKaURhaHFS?=
 =?utf-8?B?eEVsai9kamYrdEEwZStIS0xwMmh0QUV2UnJSaDk0c2dUcXViMU1yOUxRT0hG?=
 =?utf-8?B?K2NXcW1mY2lMTVpybTBmSFhNNGpMMEFwcFNDRzEreStXQVNhS2JVNEh2YW1t?=
 =?utf-8?B?dDJ5aEZnc1RpRlZpREhRSmVhTHRtWU84OHdYVzN0cC9hNUtab2o4Qll3THZB?=
 =?utf-8?B?QlZHd2lsRytxNWpvWld1MFY2bGZUQ1pkRWZpWE9iaFUvUTdLdjBjamJUbzdx?=
 =?utf-8?B?dVl5ZlVlalRIejBUNVFvcXJEbEEzcVBxUThEVFBadDU4Vm5xa1FwRmEreXli?=
 =?utf-8?B?UlBXNjQwUFJBNzRRVmNYK0VVR3lPczBFeVVTL0RpYTZyVytNQ0pJK1JFYWd5?=
 =?utf-8?Q?d/ScJyULBgercZuM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c0d226-5aa3-409d-086f-08df386e1482
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB5614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2026 23:15:55.2440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ouHTT9gYdQ94MvMl1COjeug3JMQLOMm0maT5F/fqjHzMfJddHnnJCfvdJyD/FpDnufTvvWd8jWGdW5BvwgzP0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFA42F4F89B

On 10/31/26 8:28 AM, Sasha Levin wrote:
> bindgen 0.73 emits the blob of some opaque types, such as ones aligned
> to more than 4 bytes, as a `__BindgenOpaqueArray` or
> `__BindgenOpaqueArray<align>` newtype instead of a plain array. The
> newtype only derives `PartialEq`, `Eq`, `Copy`, `Clone`, `Debug` and
> `Hash`, and the `MaybeZeroable` custom derive does not reach it, so a
> struct that embeds such an opaque type is no longer `Zeroable`.
> 
> `spinlock` is opaque (see rust/bindgen_parameters), and with lockdep its
> blob becomes a `__BindgenOpaqueArray8<[u8; 72]>`. Commit 71ec3c7d6db8
> ("blk-mq: quiesce a queue that joins a quiesced tag set") added a
> `spinlock_t` to `struct blk_mq_tag_set`, so an allmodconfig build with
> bindgen 0.73 now fails:
> 
>    error[E0277]: the trait bound `bindings::__BindgenOpaqueArray8<[u8; 72]>: pin_init::Zeroable` is not satisfied
>      --> rust/kernel/block/mq/tag_set.rs:41:49
> 
> Which wrappers exist depends on the bindgen version and on the opaque
> types of the configuration, so they cannot be covered by unconditional
> impls in rust/bindings/lib.rs like `__BindgenBitfieldUnit` is. Derive
> `Zeroable` for each wrapper in the generated bindings instead. The
> pattern allows for the spacing of bindgen's output when rustfmt is not
> available.
> 
> Fixes: 71ec3c7d6db8 ("blk-mq: quiesce a queue that joins a quiesced tag set")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This fixed my local build of the Nova driver in drm-rust-next, too. Nice!

I see Danilo already on Cc, but just wanted to respond here, so that he knows
it is affecting that branch.

thanks,
-- 
John Hubbard

> ---
> Jens, Linus: the block pull brought this in. 71ec3c7d6db8 puts the first
> spinlock_t into a struct that the Rust code zero-initializes, and since
> then a Rust allmodconfig build of mainline fails with bindgen 0.73.
> Sadly the commit wasn't in linux-next before the pull request went out,
> so the build breakage wasn't caught there.
> 
> Build tested x86_64 and arm64 allmodconfig with bindgen 0.73.2, and the
> Rust code with bindgen 0.72.1 (no change to the generated bindings) and
> 0.73.0, with and without formatted bindgen output.
> 
>   rust/Makefile | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 0ac9ab28cc2b5..0165626decbe7 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -514,13 +514,20 @@ endif
>   bindgen_c_flags_final = $(bindgen_c_flags_lto) -fno-builtin -D__BINDGEN__
>   
>   # `--rust-target` points to our minimum supported Rust version.
> +#
> +# `bindgen` 0.73 emits the blob of some opaque types as a
> +# `__BindgenOpaqueArray[<align>]` newtype, which the custom derives do not
> +# reach. Derive `Zeroable` for those wrappers, so that a struct embedding such
> +# an opaque type (e.g. `spinlock_t` with lockdep) is still `Zeroable`. The
> +# pattern also matches the unformatted output used when `rustfmt` is missing.
>   quiet_cmd_bindgen = BINDGEN $@
>         cmd_bindgen = \
>   	$(BINDGEN) $< $(bindgen_target_flags) --rust-target 1.85 \
>   		--use-core --with-derive-default --ctypes-prefix ffi --no-layout-tests \
>   		--no-debug '.*' --enable-function-attribute-detection \
>   		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
> -		$(bindgen_target_cflags) $(bindgen_target_extra)
> +		$(bindgen_target_cflags) $(bindgen_target_extra); \
> +	sed -Ei 's/pub struct __BindgenOpaqueArray[0-9]* *< *T *> *\( *pub T *\) *;/$(pound)[derive(pin_init::Zeroable)] &/g' $@
>   
>   $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
>       $(shell grep -Ev '^#|^$$' $(src)/bindgen_parameters)
> 
> base-commit: 36aad21d50d1af3f6954bb0c988257a908202477


