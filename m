Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2073.outbound.protection.outlook.com [40.107.215.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597C12B95;
	Fri,  7 Jun 2024 04:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734225; cv=fail; b=i7lmpNMabq8DNhBcDVz5zJg3e84A3GWalIwXVgDyaWQutZyahMMgZLOQZ7IU57DOkPokRjFdIJKcIc6hw7mBacWir53GRyvuV/eG7RRp9X6c50VTCTjgvNvNJTIPk9z87Mi2zJweLTGmGkAUETgWsi7iyTuNicuqt2ovriTl9+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734225; c=relaxed/simple;
	bh=WJ81BvBUf9un0W610aZxzR4twVXx63aTeptokCWbtXU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Z7df+jyuiV6x2khx6N8GooID0RwvgwcpdtnjOXKajTIIzXF6Hm7KLrkn362CK4uLkAuUOJfbsEN2XIaW/nY7FEv06RnyWdwnRC4XCIv5uw5YmTLyqW6Sjkq7ofQVz2YfUU/v39w1KHX0NTPrEZo3z8v6EwrpqcyBsLt2U+D+Hqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GaTNHX87; arc=fail smtp.client-ip=40.107.215.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GaTNHX87"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6SfsRG4yC+hVMvlWq3XzGICy6JnNaoJM+Q3i1oG3C4o8XNa1RSBgZYajkrayi0qgEOxWiF6//KSI+N/KEW19lNR/5r1hVmfx6SxAm8C3y7ORl868M2lZdfYAg1KSLukBki7oT/DTvzGOZ/+Q7YbnI9Esv46VEmIk753zFMBnnz6mGYDqOfMP1OTJqI4avr18X+iRUGuuOOTdZ3mVvs7tCi5CLAVWapM2X2JIK0xZlO/TB1QbNQTp7iiI4zttPQs4U6YYyipbQv+4VPqtLY4EObzNRRPQefDdsBaitLRiKyR35hJ2Xbdm3M4yAiogfdT+zj69tpxKNg8gQJjpqarXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zl9XC9XMiHKwN93mPp7GHAgSBXFzyIWTMsT4ZD7sr0=;
 b=P4pRu5ecLocf+rl0Npt96VQhi60dYT8IxShIlesRH996Jr1pu0zIyIhNok8vpcrBG8hksIAc/RHvdeBxBNi5QL+tV0XGCvjVz8okS7KOFRqmVrr+NJMVswkYnlWo5A0stA50dQIu+7hCanRSuYWXkh69VtsJCT+NmrWvJNP4aQQRZ306UDXbHYTFkx3HvexvxCwORqVi4PElYfnf93n9a3jwofaX8n05kELVlyADCzyrOgBolaYAdZVO63W03TrE0CU/4sHoR5VkpxZfXYOwZjiMSy+vmFnrsyFp6MCoktWpj/LgK2Q87cPZjt50Ob+PzXd4dBQ0jqAtclKqlSNq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zl9XC9XMiHKwN93mPp7GHAgSBXFzyIWTMsT4ZD7sr0=;
 b=GaTNHX877qPVZmCQK5z2+MOLe++Wn6QM2oybjk2rCRJd+ErhwPBUVEC7H6ZsCNw9dt1AqSqMXL2oiS27Rbzk7cY3dRlgB0/sD56YqMmvum+Vmxe98K+HN/FWWo2N8Zdzjq1hSD3N5nuXFcvPQoHOUzahidcmP3HO2i5CKX4s7o/Wf138xnOmaVRshhVi+dGvPxfHTWNYjaBsJlAMO9osC1zzrhaAwdtXnJxliUvSl4/IgPVVGoCbhKlANyGVBr7EMRt2AH587jeeAZrYPdHpR5JHgCgGcPdYb8YmJWulPFElvLfF11yGtG2nPYHVYsKJOrCHlZF0vjZ0jts/4lp0mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by PUZPR06MB5826.apcprd06.prod.outlook.com (2603:1096:301:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 04:23:37 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 04:23:37 +0000
Message-ID: <f6c69d33-87b6-4f20-bacf-58b4ff71e6fe@vivo.com>
Date: Fri, 7 Jun 2024 12:23:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sbitmap: fix io hung due to race on
 sbitmap_word::cleared
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Jens Axboe <axboe@kernel.dk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pavel Begunkov <asml.silence@gmail.com>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240604031124.2261-1-yang.yang@vivo.com>
 <CAFj5m9KV7OJ4_KjbSkpdtfrKamoLzV6EH-mJP3=y+VvoYOzC3w@mail.gmail.com>
 <aa7246f9-f7df-3054-077e-eb21c7f423ac@huaweicloud.com>
 <35bd4fe6-5ed0-4446-8fab-f86909212e60@vivo.com> <ZmHaQCOpje/6qQPZ@fedora>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <ZmHaQCOpje/6qQPZ@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0052.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::11) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|PUZPR06MB5826:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d654536-7222-491a-62b7-08dc86a999d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEw5VS9sQWV3RkF0NFlBUnIxdmxQcTBJb3JHZEN3TnQvdzVGVjJWSkNqSk9F?=
 =?utf-8?B?ZHN4WnY1aTFJb0dQdEdMS1ducUFsS1JEYmJWNGwxVXJnLzRhZlE0OXNQQ3VX?=
 =?utf-8?B?bGlHZW81ZlZVMFpvUUM0TVArd0I2S3o4RWs3MXVaY3MrU0tudnFudVFjSkN5?=
 =?utf-8?B?SEpOQ0RpTldvdURpeTk3VkdWQjJ2bEZqeHdUMlpzcnRwTSs1aXEwbUtsSmNL?=
 =?utf-8?B?RU1UWVA3c0tUaHVBd0Roazg5ZWI0WDFGYm5QR2gxcTVaK2VScG00YWNXWEky?=
 =?utf-8?B?MTRsV2dzdGFOMUdpNWdoWnpZTExIc3JFcCtxRDB5OUVIeG1CbFpVUTRuTzZp?=
 =?utf-8?B?VzFXWjNnMkRJdFA2cGVpZ2hjSXA1VGV0Y3N4d3lSZUtueWU4NFZncktKOFhu?=
 =?utf-8?B?NUJjT2IyZ2JoNVUrWVVOcmlqbFZYQUlpVW9EWUNBbDl3OVFBUHFLa2t6YkUr?=
 =?utf-8?B?MXZaYkdGSnE5VnFWNi96QUI1cDJHT2c3TVpqMjJyTEgrM1RrWEFDNUZTek5Z?=
 =?utf-8?B?QTRObXJlQWtUeDlwb0dnOWsrTjA0RXVMTy8yN2hRVUFISlVVc3MvOFlxYmY1?=
 =?utf-8?B?WUM4SGEzQ3VrN2NLODd1ZXVxWTl6VnE3cDdXZG9PZWM0dWZqcU9aQ2ZtMWZT?=
 =?utf-8?B?QkU5Mklma0Z2WXpIYVk2OXhDb2lBMGRJdUhLb0o1RmFodUwzWWY4UTN0M2Vh?=
 =?utf-8?B?VFJOZ3NPOW04NWxPWGNjSEZiWjZ5bFlISURZQ2xLcDZTUHBmYnBXc01TTmFY?=
 =?utf-8?B?dFNyZXNKbEZxSXhrZmxOSkQvOUZNWG5kNURUVVRLcDlMTFRkZGlhTjJzMlc2?=
 =?utf-8?B?eUhXQmJhZUtGRlNqOHJxUnpPWnlTOFZ5RXVTbjAyc1ZTdmw5dytMd3FDYUgz?=
 =?utf-8?B?aDhQbUtEcmY0VjZ1SDk3MjBteFpOS21mVWRLdXBFNjNWZTE2UCtsQzRRUVU1?=
 =?utf-8?B?bTdlQlI0SUlMTWQrSmIvL3JKMzNMTTFkSHVld1NoL3JKdTgzUGxld3FyR1Zt?=
 =?utf-8?B?OXRGQlpUa1NCcW9mQ0I1U2hHU2cydnByQVVrazlLeWdLcFh2UlFJN2twTks5?=
 =?utf-8?B?bHBBVXdOMXdNeXlDN3phenB1RWU4WGt0bm85YmZhRXc3M2VmMTZYaDdXcFl2?=
 =?utf-8?B?OVU3MnpYVG11eDZZQ3VDcWxYSEdrUzg0UkdadDFMQkN4c0VvTUxVK21BcnNm?=
 =?utf-8?B?cXFENnB3TFFqRWtucDFmdGRoMWhFTThDbWpJTGdQU3crZFRLM1VPalhKbUVw?=
 =?utf-8?B?bklEM2VNWElvWmVvMHBHS3pjbFFyaERiVFV2MW1VdWtoWXZLT0FtSjhpUEF6?=
 =?utf-8?B?ZXc3UlhTV1k4SDRKdnpRbTR0SHppTjJxbHNHRUZveEpqdEN1Um0yNFBPdkhp?=
 =?utf-8?B?ZktYaTJjOU9kWlZqRndRWlZQRVdaTE41Y2NJUGhMVHRlejJyMWJGOGFldVE4?=
 =?utf-8?B?T0ltL0F5K1VibmlTczFMSmZSbUNxSkEyckpTMWF3T3lJb21yaCtuQmZlb2RM?=
 =?utf-8?B?RWV3MG1vb053cUMwVnNPbWtKeDFkeUVBaHNBOVNRVTFFcFd2RXZkR1VQeVl1?=
 =?utf-8?B?em5BaE9YSTZ2ajkrL0JUWmJqd1cyUWM4MlJBZmxCaTJOTHRoRk92R2ZJbzNC?=
 =?utf-8?B?akJiMTJMeW45QkMxVU8zSGRvZktSdjMxZFlrcXI0OTNFMENEeTFpVkVnSnht?=
 =?utf-8?Q?T81Gr0YhaVjpF4B2QeG9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qlg4UUo0azUxaHBPNnY5UHZNcjVpdy9UMDU0bXJjWitybldRTk9UMVVMTFlG?=
 =?utf-8?B?TnVrMkFEK3lBTmdVK2VnbWo2Um9hMUpINUdOQ1JmdENubkxjZGVHNEZyT1lI?=
 =?utf-8?B?SFF4bFdselRpOXV6Q0RQYTV2YW5veXdoWUFDY1FQdTkvMkJNVVBPTGlLMjcz?=
 =?utf-8?B?elJBU1FNUHpYR0l5Mm1oZHRZVVdxd2ZrQ2ZjTUlMQlJ4a1h1K0QyckVnaUI0?=
 =?utf-8?B?RFJua3F6aXo3Uzl4b0hSWFNYWmphR2NCR0tUR09NZ2djZ3ovNUJQRXlKTXJH?=
 =?utf-8?B?enlFY3hzRStBVnFoeDhPaEpIdk9QaGNmWGVPd3dUT0FiT0pEMm5XS0tQOVFW?=
 =?utf-8?B?aWJYMk1nUEcyTm13Mm53UzkzbXhwalMwMThZaitQMHJFaVZNQzRZd20xVU42?=
 =?utf-8?B?QXc0SWNkbHArbzdOdS9iTWFZVmx3SW9OU012NVVyVXVUU2xRaGQwMTMybzZF?=
 =?utf-8?B?N0xLT01IN01GQ205dTRQQ0k3OGNFaTJDNE8vRmI2QkRXeFlKS3dxWTdaTjRW?=
 =?utf-8?B?YU1GMGFYTE5PTTM1aVB5dEdwd2lBbEdiSXoxSlNGK09FNFdrbWswWmYzMXU5?=
 =?utf-8?B?bGxzSVcxZWlDTFdoajkvd2JoMUMzQnNzd1M4b1JydzRUZ2VvQzd0MCt1L1dP?=
 =?utf-8?B?cjhXQWc4dFhWeW83Zi9xK0NIakJkT2VIUUU2OENpTzU2RW9XbmEwVWFlWUM0?=
 =?utf-8?B?MHc1NGJZMGFpY1FRVHh5VVljbjl6cVpWbFlzU3hFenViQ014TUxMaHVwNStp?=
 =?utf-8?B?TUZJVlJMZ0tDWElnYUJtaEdFSVE4UnNPZVJLUGs1REtac0lsRDNJQWZSeFBH?=
 =?utf-8?B?Z2E5T3VURjlWKzVDaDhyNldMa21idmZXM0NyVDVQWmlXaVU4cFkxZzNrOE9B?=
 =?utf-8?B?ek5BQXhVakhuOWJPaVRDOXNTU1dsWGdVanZSRzYzb3QzSFZLd0RpVEN3UU5D?=
 =?utf-8?B?dWRHb2VqYjBiZVZLMTlnTkdtTm10bVFoTzAzN05uQ050eG9TWUkyeHVhSFM4?=
 =?utf-8?B?MHVqeFhGc280V3o5SXFMc3hCMzkwbmNVZnZOaTZnQ2I3eXFOTXpKaXc5akhy?=
 =?utf-8?B?dmVnbUdmQk1DckhqUk8vQUtBdGowcmNBazFmNVpoQnRqaDU0NnpqeGN6djc4?=
 =?utf-8?B?OXpOYVhkN2NqSDRLdTR6dGJ2K2xCYnZacVpZNHN2UWVEZCtMNlhOREh3UjVy?=
 =?utf-8?B?eTRtcnhOT1hraGJVanRhUUtHRTE5d21NVFlhYUtad05lUHRuazdOaVlFUnJQ?=
 =?utf-8?B?bWVxSDM0QS9mVXE0SGVtMVh6ZThJWnBjZVd6K1NtdkVyL2hZeXJHdU1YN0h2?=
 =?utf-8?B?SDlZbWhkTWZtVHBPNFh3U1crOUNtUEN2dXZNM1RickdkZTNoMjdkdzUrOExE?=
 =?utf-8?B?RU13T2F6L3QrS0JENkovZkVEMmpEeWR5WG84bzlScGkzWlpDUEtFWll0NW5F?=
 =?utf-8?B?RXd4NUYrVEJNWktiWHdKT2hSZG00UE52SERsOC83dTQ0OHVMaWZyMzJDWHFX?=
 =?utf-8?B?ZmVEL0kvcWJmN0xWbWwxQkc0dzQ0QUNPdHB6Sng1dHlWZFh4aUxhMlkyV2Jq?=
 =?utf-8?B?ZS9YNlJmbW1Dc1ord2dybk40a0VVeE04bmtTUU9XQXZVRHZ0bnloQ2RpT0ho?=
 =?utf-8?B?MXRaV2ZScTVBUzFVbVpPNDZrV1NVQXM1WVdhSWxUVWx2OTh2R3NwS0NNd0lY?=
 =?utf-8?B?YkdSUEZXZlN5YTFRTkY5a1hVZFhBM21XNlVUKy8wVzZmY2IveUJRd3pEK1gz?=
 =?utf-8?B?RExjWjJkckllT3hERFFzNEpTTWdjYmg4UTVBYlJRRHByTG5EeW5LT2hZMEN1?=
 =?utf-8?B?a0QyMWtNY0orME9MU2FuVzk2Q0hva3NIamF4cmhzWXFmTGp2cGtHQjVCa1Vi?=
 =?utf-8?B?MEpCdy8ycnBINkpoQkJ4YlNDZFF2VXNWc2Q1QkRBbXNtMHV2Ky8vYVRGUzdn?=
 =?utf-8?B?d2J6amE1M1U5dGVIdzUySWlwa1dVQ2twM3RuWjB6enVQSEQ2L24vYzZMd0lD?=
 =?utf-8?B?NThqRGgxallWRkQvVVo4Zi9UcURsTGFVZHZteVNjZWRHRHZzVjJzUFI5ZklX?=
 =?utf-8?B?VDQvanFVUEdsNStvTkpCVjVyeklBcTc2WVd1bDFISDg1MmJLeGt6KzdCL1VL?=
 =?utf-8?Q?fX45x4q9JYDQoTUoW1SRuzQWg?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d654536-7222-491a-62b7-08dc86a999d0
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 04:23:36.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2xWNvGQnRwOOqRgN1VMOKeyR7HDpRF2USEWrWNZfBb5n+LO5RryxW1zaRArvPj6GffXFA3Ks81opQfGP1eeQEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5826

On 2024/6/6 23:48, Ming Lei wrote:
> On Thu, Jun 06, 2024 at 04:55:17PM +0800, YangYang wrote:
>> On 2024/6/4 14:12, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/06/04 11:25, Ming Lei 写道:
>>>> On Tue, Jun 4, 2024 at 11:12 AM Yang Yang <yang.yang@vivo.com> wrote:
>>>>>
>>>>> Configuration for sbq:
>>>>>     depth=64, wake_batch=6, shift=6, map_nr=1
>>>>>
>>>>> 1. There are 64 requests in progress:
>>>>>     map->word = 0xFFFFFFFFFFFFFFFF
>>>>> 2. After all the 64 requests complete, and no more requests come:
>>>>>     map->word = 0xFFFFFFFFFFFFFFFF, map->cleared = 0xFFFFFFFFFFFFFFFF
>>>>> 3. Now two tasks try to allocate requests:
>>>>>     T1:                                       T2:
>>>>>     __blk_mq_get_tag                          .
>>>>>     __sbitmap_queue_get                       .
>>>>>     sbitmap_get                               .
>>>>>     sbitmap_find_bit                          .
>>>>>     sbitmap_find_bit_in_word                  .
>>>>>     __sbitmap_get_word  -> nr=-1              __blk_mq_get_tag
>>>>>     sbitmap_deferred_clear                    __sbitmap_queue_get
>>>>>     /* map->cleared=0xFFFFFFFFFFFFFFFF */     sbitmap_find_bit
>>>>>       if (!READ_ONCE(map->cleared))           sbitmap_find_bit_in_word
>>>>>         return false;                         __sbitmap_get_word -> nr=-1
>>>>>       mask = xchg(&map->cleared, 0)           sbitmap_deferred_clear
>>>>>       atomic_long_andnot()                    /* map->cleared=0 */
>>>>>                                                 if (!(map->cleared))
>>>>>                                                   return false;
>>>>>                                        /*
>>>>>                                         * map->cleared is cleared by T1
>>>>>                                         * T2 fail to acquire the tag
>>>>>                                         */
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
>>>    __sbitmap_get_word
>>>    -> read old word, return -1
>>>           t2:
>>>           sbitmap_find_bit_in_word
>>>            __sbitmap_get_word
>>>            -> read old word, return -1
>>>    sbitmap_deferred_clear
>>>    -> clear cleared and update word
>>>           sbitmap_deferred_clear
>>>           -> cleared is cleared, fail
>>>
>>> BYW, I still think it's fine to fix this problem by trying the
>>> __sbitmap_get_word() at least one more time if __sbitmap_get_word()
>>> failed.
>>
>> How about this one:
>> 1. Add extra check in sbitmap_find_bit_in_word() referenced from
>>     Yu kuai's suggestion.
>> 2. Change from atomic_long_andnot to atomic_long_fetch_andnot_release
>>
>> ---
>>   include/linux/sbitmap.h |  5 +++++
>>   lib/sbitmap.c           | 23 ++++++++++++++++++-----
>>   2 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
>> index d662cf136021..ec0b0e73c906 100644
>> --- a/include/linux/sbitmap.h
>> +++ b/include/linux/sbitmap.h
>> @@ -36,6 +36,11 @@ struct sbitmap_word {
>>       * @cleared: word holding cleared bits
>>       */
>>      unsigned long cleared ____cacheline_aligned_in_smp;
>> +
>> +   /**
>> +    * @swap_lock: Held while swapping word <-> cleared
>> +    */
>> +   spinlock_t swap_lock;
>>   } ____cacheline_aligned_in_smp;
>>
>>   /**
>> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
>> index 1e453f825c05..63dadf91e40b 100644
>> --- a/lib/sbitmap.c
>> +++ b/lib/sbitmap.c
>> @@ -63,9 +63,13 @@ static inline void update_alloc_hint_after_get(struct sbitmap *sb,
>>   static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>   {
>>      unsigned long mask;
>> +   bool ret = false;
>> +   unsigned long flags;
>>
>> -   if (!READ_ONCE(map->cleared))
>> -       return false;
>> +   spin_lock_irqsave(&map->swap_lock, flags);
>> +
>> +   if (!map->cleared)
>> +       goto out_unlock;
>>
>>      /*
>>       * First get a stable cleared mask, setting the old mask to 0.
>> @@ -75,9 +79,12 @@ static inline bool sbitmap_deferred_clear(struct sbitmap_word *map)
>>      /*
>>       * Now clear the masked bits in our free word
>>       */
>> -   atomic_long_andnot(mask, (atomic_long_t *)&map->word);
>> +   atomic_long_fetch_andnot_release(mask, (atomic_long_t *)&map->word);
>>      BUILD_BUG_ON(sizeof(atomic_long_t) != sizeof(map->word));
>> -   return true;
>> +   ret = true;
>> +out_unlock:
>> +   spin_unlock_irqrestore(&map->swap_lock, flags);
>> +   return ret;
>>   }
>>
>>   int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>> @@ -85,6 +92,7 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>>                bool alloc_hint)
>>   {
>>      unsigned int bits_per_word;
>> +   int i;
>>
>>      if (shift < 0)
>>          shift = sbitmap_calculate_shift(depth);
>> @@ -116,6 +124,9 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
>>          return -ENOMEM;
>>      }
>>
>> +   for (i = 0; i < sb->map_nr; i++)
>> +       spin_lock_init(&sb->map[i].swap_lock);
>> +
>>      return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(sbitmap_init_node);
>> @@ -175,11 +186,13 @@ static int sbitmap_find_bit_in_word(struct sbitmap_word *map,
>>      int nr;
>>
>>      do {
>> +       unsigned long cleared = READ_ONCE(map->cleared);
>> +
> 
> ->cleared is stored in standalone cacheline, the above line adds one extra l1
> load, so I still prefer to check ->word & ->cleared in sbitmap_deferred_clear().

Yes, it's very reasonable.
I have sent V3, which does the check in sbitmap_deferred_clear()
referenced from your suggestion.

+	if (!map->cleared) {
+		ret = find_first_zero_bit(&map->word, depth) >= depth ? false : true;
+		goto out_unlock;
+	}

https://lore.kernel.org/linux-block/20240606135723.2794-1-yang.yang@vivo.com/T/#u

Thanks.


