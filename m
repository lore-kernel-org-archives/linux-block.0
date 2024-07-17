Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2078.outbound.protection.outlook.com [40.107.255.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBC22EED;
	Wed, 17 Jul 2024 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721211323; cv=fail; b=NRxyjhEhf5dTkphE/krmwDoLcparhMTHtlX/HdY/zdv6KsfbZYwuy4cXr5l8ObeUukynHCPhiRJYc6t1VAMfpZIM7ORSveXzAYu1JE0GRombSogGq1KjbIqEz6j5jF0LbWqBoBmwFVCPUyHZWDy890wkIdfuDk3GPyKdKHmAQSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721211323; c=relaxed/simple;
	bh=8/ar0FOkT67tv5IPwZ4Femy0i/gFeqovu4nBu2V/Qlk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MT0A+A0OX8O5iOLTmT5qhnU//eD4I320MeaVx4Y5nfMr92aOTdMTIBkkXXuOPecLvH6Fpp1JTJDt5B1DDNjXENIodHck/J7CD2hQ/w8A+ESC81bYL68LfOO/NhlCo2mkZblg4azehb9yI/tAXBUjIOdo9rR2JVlddh72MU3KGgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cb8oG3JV; arc=fail smtp.client-ip=40.107.255.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cb8oG3JV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MILGgbPzPY4dRgOR9tfGmLGiKBK+u5BO0R1Gbe6jCOl1NhhQZp7oNMp1lIsA+nUogGIPkzpSUMKEA9gpkpIaBVtsi+FNDQDqpwOsuVD+tmM9lYiOOia2sNUhKSPeqomYHJ/TPWQQ1ydg2pG06iRAu/v5I0bY4AjntV7GjEZq2jrh6cHuZXtk1hpX/rQ0PWyWHr1CTGroSXlCOSDnj1Rq/na7awTbpQnVk6QRGRJ8ODrwZ9JCmvQEf04T8PSLO7WcbQ99mkqE2yS54DfEiqeIdwrM/xJOVU9mX9GZTlXBGUM1hlaeA2HoKRu2OgcWU1Jmc99QWQ+nIFU8Nd+tpSUP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBzUsVKEYDY93QPvItnx/u67ojiKw1tUGtRnzWeu2YY=;
 b=PeSW5hQg6LzkVvOlxUvW5XNPgK3kbKXV1OVp4tcoo2x2gJMUzMjzQGkFPhOm2YsMsFFv2StxtfeBKPjzgjyU90YN0JqemHjkM7cnVzZXqZ8o+zFbyU/NTpSjhzp1VN7AnJbT70EX1mQzmqVo6kd9Q3wRZXmgW8zbF9Ag8eV05gQm+1x6vQjOEzIjsiweiKlFkuXe3eBRn6oWqMX/2o/NYa27WnQk74R17GcEoPG1dHEBFOO4mjKNiPD+sjxSPcVsXmrkyo/qgTVi/AaYbyyJYC4pGWXBpAr2VfSID6rKgahGjl7O0JSXQ+7Tw8rQreh3LVORoImdn+Z3Gz880fXWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBzUsVKEYDY93QPvItnx/u67ojiKw1tUGtRnzWeu2YY=;
 b=cb8oG3JVu7IJ3cWCQoqT4Ou6Ulr6rS8lNoScEmMZCcm9QGmpjXh/9pELKFCxi+NroUx25eVe9DZLZ1b9vbQ55oBl0CjR3/D/jJOcj5l5jd50QskvaZgKcg5pSGA1PbYz+hCZVFIBRhAVWngv4nPRtk4H4q6TW6Ba/2k62AwOkZukPpBbvq4H3AqxBpcDBUvJeQcYPSaTyoTc/1dFipPljuQdT0cISclZbU/AeQH2yV79EsGLlVEGY4iIix+9MSdI8JoyB4kkIoVwsQjb4Y1fGcT41AvUgpX2VmRMxIhRYOIZBNSvnnmW7H2JIpCoZseAFBPEnFBj0VBUwF1HeRkdiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com (2603:1096:820:146::12)
 by SEZPR06MB6643.apcprd06.prod.outlook.com (2603:1096:101:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Wed, 17 Jul
 2024 10:15:15 +0000
Received: from KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e]) by KL1PR06MB7401.apcprd06.prod.outlook.com
 ([fe80::f4f:43c4:25e5:394e%4]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 10:15:13 +0000
Message-ID: <51411297-f579-4229-a72c-c5bd5f27df34@vivo.com>
Date: Wed, 17 Jul 2024 18:15:08 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fix deadlock between sd_remove & sd_release
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
References: <20240716083801.809763-1-yang.yang@vivo.com>
 <1859a975-8c53-140c-f5b5-898ad5e7f653@huaweicloud.com>
 <451c8746-5260-4be6-b78d-54305c94ef73@vivo.com>
 <a81cdd5b-d6ad-2a4f-0f6d-40e9db6233cd@huaweicloud.com>
From: YangYang <yang.yang@vivo.com>
In-Reply-To: <a81cdd5b-d6ad-2a4f-0f6d-40e9db6233cd@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To KL1PR06MB7401.apcprd06.prod.outlook.com
 (2603:1096:820:146::12)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB7401:EE_|SEZPR06MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d800cc5-81ef-4aee-112f-08dca64958d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGFUVUlYTFphbFAwYjBoWkdmOTdqMGZiOURaYWJ5cG8zUGthTEdvaEx1aVpr?=
 =?utf-8?B?RERabGQ4WGhZYm00Nm5WTTNRcm0wYWFHM0lDUFgrNU0zWFpuREw1MDZQWW9a?=
 =?utf-8?B?M2Z4ZFlCMUdxZzJEMklPZ1FWRjZaQTZPYS9zZ3FCdXhDT05DZlhHR3RNWEVH?=
 =?utf-8?B?MWJ5QlJOSWxZSDA4azM2U21WMDBSd0FmYUQ0eTFUMW9JdGF5eDEyYWtzZHpO?=
 =?utf-8?B?OTl3NTF5LzJQZ1ZyMEs2eUgwdkZnNXlINXFVNDdnOG9XcDczOXRESmxPVU9j?=
 =?utf-8?B?UGhNQThXKzVBa2gvemZyc1V3d2lwUklET2w0ODRtUnJZaXQzY2wwUThra2Rh?=
 =?utf-8?B?bE1iSGRvWlNxU1R6MFRpS2NCQ1ZlWEsyZ2hyOUVmVzRQV3ZmTU1EZUFSUHRk?=
 =?utf-8?B?TENoVEk4U2FWZkRtSzZuQng2dmtPam5iQyszZU1SVVFhRXF6SGROVzc1VUFM?=
 =?utf-8?B?RkVtKzhGbUtNeWRnbW1wMTJGaUxoNG40dlQrd2NEYnZVVXE3cTZLcGVTRm9k?=
 =?utf-8?B?QksrdDhSQ2RCcEpKSDR5Unc1YTk0RlpsRkcvSUxBL3BSK1ZvM1F5N2M0ZnlM?=
 =?utf-8?B?TG1ub0doanhKekx6WU55QTZib3lsWVZKRi9IZ3JYMGErQ3dXSGZNWVNSSGs4?=
 =?utf-8?B?Z0ZQMy9WUGc2N2I0U295L0lrbEdiRktqVnhlbjJtZEpyMmRXSWJxalFES1A5?=
 =?utf-8?B?WjJEeGdyNCsxcEZ1aVRSTlBiSk1YOCtZUG91NUlKK0xrNm82QVZxeTRBd0pl?=
 =?utf-8?B?QVBHVHdHK2gzUE9pVjQ0b3A0M3d2d3F6NEZnWXQ2YmhMOEJRUktTZ0NSWlFa?=
 =?utf-8?B?d0cxTWZmSXViN3ZjeXRNc0N4T3AyWlNzRW4wdTJKZ2YzMnJ0WnNXOUhRQUFU?=
 =?utf-8?B?dnpqamxSM1dqemlvQ1FMcHA1Mkwrc1diZGJiMWhUNGVwUUJDSkhnbU5sNTFv?=
 =?utf-8?B?QngyaWsvZEhyTG1hb1dtcVhGZGZueWNiYkorY2NKak5XbHN1NWM1Y3RWS3VN?=
 =?utf-8?B?dndiR0RsdzdsWkx2N2YrTW45Si9ybzMyZUwyNUN6azNUZVlWWjBYQmZLeTla?=
 =?utf-8?B?eGFSLzV2WG5NZ3daRkN2QXRrbS9KYzVxK3BGMWE0MEV6b1dQeDJQdUF1TXNB?=
 =?utf-8?B?Q0Z0ZytRZlplaWVnY0l4eUlGRG9iRXhPa2xwN2VYa1ZybmVIb2pqb2wzczNz?=
 =?utf-8?B?YnBMdEUxTXBoVG5BZE1PbjYrSmt3cFRTWmk1M1ZZL0dLUHQzNmFYMncxcHJy?=
 =?utf-8?B?QnNyMFNFdWo4V2kxemtKRjFqK2Z1cG0wdGQ4cGNMYjU4R3pHc21USjJIQlBN?=
 =?utf-8?B?bmY2QTUvTzcrSVpZejRrY1djVVY2WTdsZ05qb2pNaXZsNDBYZ3JQdkRKSkQx?=
 =?utf-8?B?clVtVjl5RUdnSWtGU3pVRUxiWStQM3prRU9ORElZa3pCSFdYVFI4VExOVUJI?=
 =?utf-8?B?OFVYbllpMXZJc2xGUlkyaGpPQ0ZLbGlLRUUrZGgvUWVFLzNYT3Z2c0MyVDhW?=
 =?utf-8?B?QlYxTnBvMVpRRVJkVnhQL3E1K0lhZER1cUNHYmlEWXBKRmFMbnpKQkV2SkVm?=
 =?utf-8?B?bmw3K2RzYkNsMm45OVJESnJmVzNOeVp2ajNMeXFiTHlEeGlhNjNycVhDYUQv?=
 =?utf-8?B?dG5CUUFPdndYNzB4dDd1cXBCOWdueUxmUjRDN1JuUU5ySFlEc3cvT2I5WFRO?=
 =?utf-8?B?SWlZd3JpSjJNbU5laXdWYlNkZmZieTlaeTU5ZVZsT0E2eG44eUxidDVzQVR3?=
 =?utf-8?B?bDlTSS9ISG5wN0dldWJhdjlQaTZSalRueWlQcVluUmo5d1c3RHJ6dStKSUxj?=
 =?utf-8?B?QnV4Ni9Oczk0WVZQbVErQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB7401.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2lxck9vcWg0UXNOQnl3NUJtbzh3V1V0NnNteGcySnlLYjBxT2hXcVc3YjR4?=
 =?utf-8?B?VzM5dmJreGgxRUhGMGREMHQvaEh0dGlRMHpFWE0wWFQ2L2RkMm5xNlhMNVVH?=
 =?utf-8?B?b05yWkk1WFRnRmIwVGNENWtJTFpyQk1zUmJMd2lxdWhBbXRXMHdPL2FKU21N?=
 =?utf-8?B?K3g0QzdpSmZRTUliS3ZYa0F0dERhK3lINFNhSmNJWnphOFdQZEY3Mm5hWUpP?=
 =?utf-8?B?SWFvQzIxU2hGSG5nOGZXdGEralphc1R0SDBTenFFVUxHS05XUDZMVGk0T3lM?=
 =?utf-8?B?QVJYSkVOV2JGRlIrYnBwejBSTm1uNGdXNDFoOWxXY0FKUEZMYzFwcU9wa2NP?=
 =?utf-8?B?WXhOZXJzcUNCMlFGcDZrang5NVo5dlhsOXA5eW1hYWZtclA2Zk5QMTR1WVhw?=
 =?utf-8?B?Njh3YmlpcUdZRGZURkJmVzV4YWZGdG5GWG8ycWJ6MitaYnM0SStXdGd0Um5l?=
 =?utf-8?B?eGZNS0RGd0FGUmQxS21RWUU2UzBKbzZtODZER3o1UUxHd0pPemNGVWczQ1dQ?=
 =?utf-8?B?VkorNzdWby9wMncvcnhXcHNxTTM3ZS9mS25rYnlWT0M4NWZsQWgrV1B1SDd5?=
 =?utf-8?B?eG1UcXVkZ1JzTXV4OEZNSi9VNk5TNjZxNzl5SXhRQUZiM1FIR3U0SHZ0ajJt?=
 =?utf-8?B?Vzdadm81Q2RpV2lJcXM3U1lIR3VSTGdkRHFaaCtxVUU5ZWlMSlZndGFsaHM4?=
 =?utf-8?B?QmNJcEU3SGRBUXg4UVNaRVpZN0N2NlNESzI2b2JUazVuMEpabEpRRkg3NWI2?=
 =?utf-8?B?TVBrZzN1SVBMbTZzaHBBditHUzB3NTl1WlNmMFVZMCt2U2hBMnZreXhmdjFw?=
 =?utf-8?B?dkc1dkdoRFdhd0VkQmg2K3J6dVhFOTBtUUMzSUhYUDZIUDc3Um1LZllvaTZl?=
 =?utf-8?B?QjdlZHNwVDBIY3BJejJ3M3dUQUNUTG1FVTQwdTBBSEpmL2krU01HL0M1Slpo?=
 =?utf-8?B?a2lCQmNQK0JjSFg1NEZPcEtlcnJuNWJTTXg3MFZaRHo1bnRmT3l4dXZHQkIy?=
 =?utf-8?B?NWttSkgvaFp5blM1bVNZbk5VS1pDSk9ES1N2a0FzdjZwSW44U21HVXNSV1JS?=
 =?utf-8?B?UHBhRHNSWmlKbWlDVDNBR084WUJ0T2hKYkFIWnhjT3JMMWFINHcxQ1UzV0hL?=
 =?utf-8?B?enpPV291ZWFwOXQ1WHgvVStUQVRuTGN5UElsZGQvTU5RWmdZQisrVDBNenhQ?=
 =?utf-8?B?NXRkMHFlcVFiTVBnSU1OYysyUUNYR3YvUEVzTFQrYkV2UzA0NzQxazJnUkVw?=
 =?utf-8?B?U1JBRS92QlhDeXhURFZkc0I3SjFWMENRdHhLd2Mza3FHRGZOczdlU2hHcUFr?=
 =?utf-8?B?bXhhVFMvampEWE03QlZOeEJUUUN1WUlqa2dLK3pFOE9VczFUNlBKQlpURnJk?=
 =?utf-8?B?RTNySlFUcERZVEJsTVVxblpUUEUzclNaWDNSUW1CSWZvVUNHQU9pOGltdWFL?=
 =?utf-8?B?aStkL3hkdHdNVjVXblFNMXNUZmVqcWx1bnV3MDRlazQ2WUVud3MvME8zM3Nq?=
 =?utf-8?B?MEo5SitFKzFFeFBOc3JZMjV1N2krVUp0bDV5Z1lUZzg5ZzVabmJPZ3doME02?=
 =?utf-8?B?QU0waTV1LzNkNGpQNHI2Vi9aRDh1YmxmQXBnMEdaN3kvVnVnbUt0ckQ0RG5y?=
 =?utf-8?B?RGhwOEppeG1tc0Y3K1ZkQlpLU000eW9hVDJqc0ZLU2xPejQ5VTRqVjYzNktX?=
 =?utf-8?B?R1E4RCtFWVI3VzVha2lpNEhYd05VQnpMWGd5bFBvTEZSU0ZXc0JVaDdIc2tt?=
 =?utf-8?B?MWJJaXlWQWxhZTVPelNBeVZTMmVWUGR3OXd5QVEyTGxjcytTd1kycEc0KzQ2?=
 =?utf-8?B?Q2lmTTkzOXExRzVLVVFrdGtobHEybkczekxtckdwTFRoemg2U2J0YmVrRm4w?=
 =?utf-8?B?cjdIK09YKzhYY2FmR09XeTB6bCtXTDljVy9rL0ZkbnlzWEcxWW1wdmhtVy9W?=
 =?utf-8?B?Q2NTRFk1R0V2MC9qOW5pRitScGpjR0ROOTlhbTZLaUVnMVkvWk5ZTWVHODFW?=
 =?utf-8?B?U05oekxyd3I2UDZJd3ZDYlQxcmgzdjlXeHZyVXRINGFDREl6Q2RCdnAzRHpy?=
 =?utf-8?B?bWNtVmF1eUZBYUpLOFRRODVmTGpkbktJaEozejhlbUlJdnRraHJqOG0xTTVY?=
 =?utf-8?Q?E1RIMraFwDc3OM1ni1hjgY8+s?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d800cc5-81ef-4aee-112f-08dca64958d4
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB7401.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:15:13.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vBVqNAbdmlKdOeGfe0+vG3i2MGautktVCafFq5eTXrf3l/c3BwPcdhmTuVgHAd8Wmz1XThDOL5N7Spanyql8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6643

On 2024/7/17 11:53, Yu Kuai wrote:
> Hi,
> 
> 在 2024/07/16 17:30, YangYang 写道:
>> On 2024/7/16 17:15, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2024/07/16 16:38, Yang Yang 写道:
>>>> Our test report the following hung task:
>>>>
>>>> [ 2538.459400] INFO: task "kworker/0:0":7 blocked for more than 188 seconds.
>>>> [ 2538.459427] Call trace:
>>>> [ 2538.459430]  __switch_to+0x174/0x338
>>>> [ 2538.459436]  __schedule+0x628/0x9c4
>>>> [ 2538.459442]  schedule+0x7c/0xe8
>>>> [ 2538.459447]  schedule_preempt_disabled+0x24/0x40
>>>> [ 2538.459453]  __mutex_lock+0x3ec/0xf04
>>>> [ 2538.459456]  __mutex_lock_slowpath+0x14/0x24
>>>> [ 2538.459459]  mutex_lock+0x30/0xd8
>>>> [ 2538.459462]  del_gendisk+0xdc/0x350
>>>> [ 2538.459466]  sd_remove+0x30/0x60
>>>> [ 2538.459470]  device_release_driver_internal+0x1c4/0x2c4
>>>> [ 2538.459474]  device_release_driver+0x18/0x28
>>>> [ 2538.459478]  bus_remove_device+0x15c/0x174
>>>> [ 2538.459483]  device_del+0x1d0/0x358
>>>> [ 2538.459488]  __scsi_remove_device+0xa8/0x198
>>>> [ 2538.459493]  scsi_forget_host+0x50/0x70
>>>> [ 2538.459497]  scsi_remove_host+0x80/0x180
>>>> [ 2538.459502]  usb_stor_disconnect+0x68/0xf4
>>>> [ 2538.459506]  usb_unbind_interface+0xd4/0x280
>>>> [ 2538.459510]  device_release_driver_internal+0x1c4/0x2c4
>>>> [ 2538.459514]  device_release_driver+0x18/0x28
>>>> [ 2538.459518]  bus_remove_device+0x15c/0x174
>>>> [ 2538.459523]  device_del+0x1d0/0x358
>>>> [ 2538.459528]  usb_disable_device+0x84/0x194
>>>> [ 2538.459532]  usb_disconnect+0xec/0x300
>>>> [ 2538.459537]  hub_event+0xb80/0x1870
>>>> [ 2538.459541]  process_scheduled_works+0x248/0x4dc
>>>> [ 2538.459545]  worker_thread+0x244/0x334
>>>> [ 2538.459549]  kthread+0x114/0x1bc
>>>>
>>>> [ 2538.461001] INFO: task "fsck.":15415 blocked for more than 188 seconds.
>>>> [ 2538.461014] Call trace:
>>>> [ 2538.461016]  __switch_to+0x174/0x338
>>>> [ 2538.461021]  __schedule+0x628/0x9c4
>>>> [ 2538.461025]  schedule+0x7c/0xe8
>>>> [ 2538.461030]  blk_queue_enter+0xc4/0x160
>>>> [ 2538.461034]  blk_mq_alloc_request+0x120/0x1d4
>>>> [ 2538.461037]  scsi_execute_cmd+0x7c/0x23c
>>>> [ 2538.461040]  ioctl_internal_command+0x5c/0x164
>>>> [ 2538.461046]  scsi_set_medium_removal+0x5c/0xb0
>>>> [ 2538.461051]  sd_release+0x50/0x94
>>>> [ 2538.461054]  blkdev_put+0x190/0x28c
>>>> [ 2538.461058]  blkdev_release+0x28/0x40
>>>> [ 2538.461063]  __fput+0xf8/0x2a8
>>>> [ 2538.461066]  __fput_sync+0x28/0x5c
>>>> [ 2538.461070]  __arm64_sys_close+0x84/0xe8
>>>> [ 2538.461073]  invoke_syscall+0x58/0x114
>>>> [ 2538.461078]  el0_svc_common+0xac/0xe0
>>>> [ 2538.461082]  do_el0_svc+0x1c/0x28
>>>> [ 2538.461087]  el0_svc+0x38/0x68
>>>> [ 2538.461090]  el0t_64_sync_handler+0x68/0xbc
>>>> [ 2538.461093]  el0t_64_sync+0x1a8/0x1ac
>>>>
>>>>    T1:                T2:
>>>>    sd_remove
>>>>    del_gendisk
>>>>    __blk_mark_disk_dead
>>>>    blk_freeze_queue_start
>>>>    ++q->mq_freeze_depth
>>>>                    bdev_release
>>>>                   mutex_lock(&disk->open_mutex)
>>>>                    sd_release
>>>>                   scsi_execute_cmd
>>>>                   blk_queue_enter
>>>>                   wait_event(!q->mq_freeze_depth)
>>>
>>> This looks wrong, there is a condition blk_queue_dying() in
>>> blk_queue_enter().
>>
>>   584 static void __blk_mark_disk_dead(struct gendisk *disk)
>>   585 {
>>   ......
>>   591
>>   592     if (test_bit(GD_OWNS_QUEUE, &disk->state))
>>   593         blk_queue_flag_set(QUEUE_FLAG_DYING, disk->queue);
>>
>> SCSI does not set GD_OWNS_QUEUE, so QUEUE_FLAG_DYING is not set in
>> this scenario.
> 
> Yes, you're right. Please explain this in commit message as well.

Got it.

>>
>> Thanks.
>>
>>>
>>> Thanks,
>>> Kuai
>>>
>>>>    mutex_lock(&disk->open_mutex)
>>>>
>>>> This is a classic ABBA deadlock. To fix the deadlock, make sure we don't
>>>> try to acquire disk->open_mutex after freezing the queue.
>>>>
>>>> Signed-off-by: Yang Yang <yang.yang@vivo.com>
>>>> ---
>>>>   block/genhd.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/genhd.c b/block/genhd.c
>>>> index 8f1f3c6b4d67..c5fca3e893a0 100644
>>>> --- a/block/genhd.c
>>>> +++ b/block/genhd.c
>>>> @@ -663,12 +663,12 @@ void del_gendisk(struct gendisk *disk)
>>>>        */
>>>>       if (!test_bit(GD_DEAD, &disk->state))
>>>>           blk_report_disk_dead(disk, false);
>>>> -    __blk_mark_disk_dead(disk);
>>>>       /*
>>>>        * Drop all partitions now that the disk is marked dead.
>>>>        */
>>>>       mutex_lock(&disk->open_mutex);
>>>> +    __blk_mark_disk_dead(disk);
>>>>       xa_for_each_start(&disk->part_tbl, idx, part, 1)
>>>>           drop_partition(part);
>>>>       mutex_unlock(&disk->open_mutex);
> 
> Take a look at del_gendisk(), between freeze and unfreeze queue, I
> notice that there is also device_del() here, which means it will wait
> for all sysfs readers/writers to be done, so related sysfs api can't
> issue IO to trigger blk_queue_enter(). And this behaviour does't look
> reasonable, we never forbit this.
> 
> Then take a look at scsi sysfs api, I notice that scsi_rescan_device()
> can be called and issue IO. Hence other than the 'open_mutex', same
> deadlock still exist:
> 
> t1:            t2
> store_state_field
>   scsi_rescan_device
>    scsi_attach_vpd
>     scsi_get_vpd_buf
>      scsi_vpd_inquiry
>       scsi_execute_cmd
>              del_gendisk
>               bdev_unhash
>               blk_freeze_queue_start
>        blk_queue_enter
>               device_del
>                kobject_del
>                 sysfs_remove_dir
> 
> I didn't test this, just by code review, and I could be wrong. And
> I don't check all the procedures between freeze and unfreeze yet.

These sysfs nodes are in different directories, the scsi node located
at /sys/bus/scsi/devices/0:0:0:0 and the gendisk node located at
/sys/block/sda. Would it be necessary to wait for the completion of
the scsi sysfs nodes' read/write operations before removing the
gendisk sysfs node?

Thanks.

