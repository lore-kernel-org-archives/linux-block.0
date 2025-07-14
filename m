Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9F22F152
	for <linux-block@vger.kernel.org>; Mon, 14 Jul 2025 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532717; cv=fail; b=EPDQTkSfJtUQGrnY2OZko3KFTR5T2b2cv1wxfQPLuKCHFtpDD9wDjLZtgQNhaaurO5VSpbiSElV1IsUwtfEJMI9MpV3O0ZYDwido9+qC6fgxPJiOI2ymNdT4oWDedSEzlITvl2gycM+XuOgRowhPxDuhcVgIKLhHmXlXsxJpO5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532717; c=relaxed/simple;
	bh=QtcsLBw1CC/koJvH9JzjJ82FgnwkkUMkvtw3nHGM6XA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a64zNGgykopKKbdRA1tfcYc3CS0WJHu8djpH6wU9kRyqTlCBPo6fi1cVzq6oNpGeBK5IbfTU/OAqspAFSG+P2tgHoxRyx+X8T4LOuA74wnaJkvl3/hrqfaQSkw0S3VFXvbOPmnvx1FzbUnOOTUgg1BJcUKkAO8DgF49KqtDMmNw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fY8jqGtK; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fY8jqGtK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2q185oN98s6AYDdmv0HTScO0ECb++IJ8R4tL1M3naEd7MdnETJm7sh+LpXdPBZMqtnwke8TTHL4aPfQS6qJPkt+Xamg1/aSSr53il/X4FabisCkExi/i+EJD0Suze6ZfpW/zc7JzBFojQ2+tzxyWwwLBfDGbQ583rpCmV5Z6Vbv5E+/wTbMMwawU40TTfMcjnQWg30BPFAjmhbO1ECPGCQc/3RD5ND5z1XR0dzBuZEVxdqBoYoNIQjs6SLFvejDM6Jjx0IVK8/69qOAO+qvRyicp22QMM7jFigES+qz5SKNLKOKIZA9ArZogHrgswV9EBLsw6QQuEbSZrUSEnuRAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QtcsLBw1CC/koJvH9JzjJ82FgnwkkUMkvtw3nHGM6XA=;
 b=w+y/11lqDO6pz3zDJBPFHD9P/Hs+TEK1tRRisrQzts4xLRixohHIPTcHS8rw/6blzG+g9eAStakOO0AatR+e5Cl6xzF9Oss/lTPGaxiotrkcYeR2HbF8GFz0hpxqJYpC4xpmWyQ2UD+JHzR5Magnk/MzFPyd8vBrEVk3PZmZtjcKCIGljZKGryHV2mcdz7tSB8IqTA8tsoVYxxzBktvdUk/aloNcMYq0DtOT36EYOSydGo7Ph1GmOTaoAF0ksCId9WVEr1LgJJoI21lWjX0UtK9F2XV8xc/NknX/rO+eyuqZtvuWC7+xoLPhMbo6oAKu53QKjpQ84GL+vMKWRBxk8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QtcsLBw1CC/koJvH9JzjJ82FgnwkkUMkvtw3nHGM6XA=;
 b=fY8jqGtKHdm4Hfpl9RmAzKxk/LgFI6+pq2cxdhCXN58pG1eNbqTyBtdHsMgPqSuQ7y0If01xRl21vgXXhqQUNCvNT8Av1t8LUwOILRsIgTchG4hJix/18isz/3H0dHUa9ZgahYuUT8YVwTdZa0tKdS97yEKE1sss+qHR7ftJODOJd6X3QVGH7L2S/qnBRs+8/r8GBTzrPRAiB+wJZs+C38N4ivkU07/3Gk1EM2Lb1zfwL6paTQYpJrSgHC1gvHr9pI9Ui+zR7mun3kR+A7xhnM50XMhx7OQ/bS80umekPgEm10YIPdZsxAEy/zI5Niw553S3KUZkEg1Lw2AB1u8EFw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SJ0PR12MB8615.namprd12.prod.outlook.com (2603:10b6:a03:484::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 22:38:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 22:38:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Damien Le
 Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH v2 5/5] block: add trace messages to zone write plugging
Thread-Topic: [PATCH v2 5/5] block: add trace messages to zone write plugging
Thread-Index: AQHb9M0j7luEe0t7sE691GzSqtiJtbQyNnMA
Date: Mon, 14 Jul 2025 22:38:33 +0000
Message-ID: <cc486e39-a089-46df-a42f-7c3fb330eb98@nvidia.com>
References: <20250714143825.3575-1-johannes.thumshirn@wdc.com>
 <20250714143825.3575-6-johannes.thumshirn@wdc.com>
In-Reply-To: <20250714143825.3575-6-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SJ0PR12MB8615:EE_
x-ms-office365-filtering-correlation-id: e8bc028a-81f0-48eb-3755-08ddc3272a09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STNTWVRLSUM4cEEzaHhqWjdOWkVZcGNQUU1WR2xBQzNhcGJvd3ovZzBHeHRN?=
 =?utf-8?B?TUpjZGlrUDdndWExeEhJRVRqd2xiTTJUMTR2RU1ocEp3TG9KTkRPSjZQbXZx?=
 =?utf-8?B?TGNBT0JtdnI3bUpzV2Radk1hOExDbjkxNGJLNHRRN2JPdlRWVDlKMUdCamZZ?=
 =?utf-8?B?UTI0N2JaZkdRNFRwRzcySnRsMGYyUFV1b1ZsRWhPa1liVGVPaHMyajltbDRW?=
 =?utf-8?B?Tyt1UzhUQ3BvY2xKU2g1eGxvQTV1VG9SNS9TbDhlc0xvU2MvRVJFZ3FMVDRm?=
 =?utf-8?B?OHpjR2ZvMng1T2U3alFIYlphUXlNdVY0U09xTG1naFBaazFsRDJ6Mit3VHVo?=
 =?utf-8?B?MUdqeDc2a3ErL1N6dlliVlBaRnJGZ1cveitqTUxoTXR3SzJndGhRR3I1b1hR?=
 =?utf-8?B?YTJqRmsvWFZaRjRTbFJpdUFlcFVvaGRFL0NCWDVNcTllY1NqckVLU1hDV0lZ?=
 =?utf-8?B?WTRJVGREWnBUSzcwR0llQ3JOdXRUZ2ZMUVdFMXAwTmNSN2EwMVJrOUVSWDQr?=
 =?utf-8?B?RmErYzBVTEsxT2tRRVYrSlZ0N0UwbGpXdjZIc3d4VVBrUDZPbVdEYnYzSXFm?=
 =?utf-8?B?RDNLREFKb2RIRGhvTnhlWFp4ZWdEcGM2TGhBWmZTQmZSTmNjQ05YQ0pnMUZq?=
 =?utf-8?B?Uko5NzRYUWFLWUVJTFJnZ2xsdU9DczRQL3BMUUJZT1NMcFZmdHQybDJtOVpG?=
 =?utf-8?B?M0psdzRlMkV3ZllyaVpFZkdWbXkzNXFrNldoRDdMdlhQWFgraThmcjdTNk5o?=
 =?utf-8?B?enpDdnNVL3paZDdKR2JCaEJrOXErMHk1Z0gxR2JJS09Kb2g5eDNjT1NQNFdw?=
 =?utf-8?B?c0N1TUlyKzdBcXJNZVkzQndLK3VwTUI3bDNDWGtKZ2VLRVFvcnpxRjR3MVlY?=
 =?utf-8?B?bXp5NTIyMm1XZHBOVlB6c3ZkZFp1dWsvQTJJbGd1WVdhOEtrMVZmTmlXYm9D?=
 =?utf-8?B?TWlQUmFNWlBLM2RkejQwaXFnd2tiNWVHSkJuN1MyQzkxRE9pUWQ3RXZVb3hz?=
 =?utf-8?B?VWd4UUpLUlhwUzJQd3M1cUhoQmk4cHFrNG9NLy9xeXByN2pOcHNTZTNSUUhi?=
 =?utf-8?B?cHE5U2h2VWFZb1lVNWFvL2lLTXR0U0M4VTBXZ2cvTUR0ZDVoQXliQTdDMmw4?=
 =?utf-8?B?WWpxOTY0Y0xYV2VaNWljRTVwWkZTV1V3T1N6dmh3TEZkc242SVhRekQzMStZ?=
 =?utf-8?B?Q01tc1huR2VLL0FRVGxrTXhlalNHSDVUSGtMemllaHZvN3FrdFgvV2lhOTE3?=
 =?utf-8?B?VGY3NnBldTcxbHQ0T0RvbTU3QnJqK2NQQ3prMVJsaXZkbWJHNi9ZOTVNY0E2?=
 =?utf-8?B?R0FTSjVEQVpkZzNEeGw0ZDVxb2dzLzBWa0l1YmNRTS9GS0JBODdtc3hWUTl1?=
 =?utf-8?B?VmhycDVJbjNYVExsazRLbWdOVlVGK0RxaXcvK0RQRDJOTjJRMjNtZ3Z4SkpT?=
 =?utf-8?B?SDJoSzdPMlNDeUpPeDdQUjlzVTgzcyswVU82T2xTKzE1RW1XTlBRTlhTeEVq?=
 =?utf-8?B?WWpHZ1p3Wms5MTFrMHg1WnBaNFpUWHNFME03cWRkcmM3eXp1ajVhZFRtYWxy?=
 =?utf-8?B?RjB5VGZyZEQ3elJScmVDN1ZPN0NzZXVqZCs4M0pEc21IZDlmRWU4eTlISm9K?=
 =?utf-8?B?dEdKVUpNd3dMWUh1REZ3N0Q5Y2tzTkcyaTIzSnZobjFFdWwxcEpnREtxY29E?=
 =?utf-8?B?cjFTeDVYZTlRSzZrSlloVzRaZWhybGlWa2wrMDQwNHdBc25yUFhRM1JNV2N3?=
 =?utf-8?B?b0gzMmE2VW1XbzdSa1ViQW05UFYxNU5FbnA3c2JPZUFhckZsOUJvRHZBRGRi?=
 =?utf-8?B?TDNwbEFpR0xWSmNQM2RvVGlwWG9jQ1FGaHU5eERqejNBSzk2bWt0U1N6bWZK?=
 =?utf-8?B?eWhPNGRaVjQyWkVIbitZeitaZXdycHhZU0Q2U0pETzM4UTBiZzNhaGJXRWxx?=
 =?utf-8?B?WTcya2JaejhIcXRFT2ExODBaZEM0bzFNRUE3RW1ZWlRXZFZZRTY4ZjE2dnJn?=
 =?utf-8?B?M2ZzMTg3SWd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eUkzeG82M1g0VFBXbGR3Qkw1SnNIWCs3bTI5UlZNN2wxMHY1TDhMbWx2SkYz?=
 =?utf-8?B?YVoyNjM0R284WWJ3SmxnZytaYkJmaXdBc2IyS3NKbTI3aEx3MW9PNWdPS3B4?=
 =?utf-8?B?Ykw4WnEyc3h1QVl4bkRRdTEvRUZqVTVwMDQ4UERCTTl5S3JNTzdndisxdmlN?=
 =?utf-8?B?a2dQbXBmTDcxL3QwVFptcC9nSy9qMEsrazlrd1NQRlJlVUJneGxkMExjQmxD?=
 =?utf-8?B?MngwSXFXSlR3SnNPTEZSWkoyMFpOaUtucll3cGduTENlcnlyb3k2UFBGUk54?=
 =?utf-8?B?R3g3MXVmRTB0QVo1TjhqZGxsTjAyeGNoUmFRNHl5cS9xY3MwUlpIM1IxbjJx?=
 =?utf-8?B?TFlhakNhSnhRYmdsTTZKS0tlbTVVdUhIQm13SGZWQVpMbXZPYld4SC9oYytQ?=
 =?utf-8?B?ZnV1eXNOL0MwQThHU09zc3VFTWIzWElyN3pJa0hpVWRVdXAyR2ZnRzRKV2VJ?=
 =?utf-8?B?MHBjMHFxcDBFZHdsTW16ZHU2Sjg0bG9WcWZzYkw0UWZWdmJYTlpRc1o0WGt1?=
 =?utf-8?B?RjJ4VnA3TWFaS2JuaUpxaUhHMWRzWkpXQW43MldmUHEwSWFsUTNLRXFmZ2dH?=
 =?utf-8?B?VUlHZklvSHRNQjVEL29VdndxQ1hhSFd1Ylp3dEhxR3ZES0s5Q0NaREthSnV1?=
 =?utf-8?B?YzJ3eFA2N2lJcUprZjJsZHYxM3VLc1JMRUZmT0FYSUthVldmdlpKUjBDcWt2?=
 =?utf-8?B?OEhKRkd2UlFJWWhZZnoxYmc1ejlQemcvWDI5VVFXVURjQU5JWlNPb0d6ZkMz?=
 =?utf-8?B?WFp6a0dIOXh3QkoyMGhLZ2RkTCtUVHJpWnowZGlLaFR4MlE3WUZDSFFhUERm?=
 =?utf-8?B?ZzYxU3UwS1FFeFFiU1lUZXNSZ1A4ZjBTSytualcwd3R5ZHU5ZmlNdFVBWm0r?=
 =?utf-8?B?aUd5VTd0YnZxcDdFSDNvZXNBVjl3d0JkUnh0ZDAxOUpCOWp3eFJYSzh2NG41?=
 =?utf-8?B?SWFyeEErQjdvRWVZWjN3NFNOVTZ5RVNDQUpVU2prREpVb1kzQldBRlRqelZG?=
 =?utf-8?B?RktCc0tCUURndVZWOTYvOGVIR241eDBKckZGTmlVSFZyaGd6VHF1WHhoWUlX?=
 =?utf-8?B?MitNTkN0UmpHUnlEMzMrY2NZdGpVeTRZZzNDdFhmOVd1OElkeW05dDVHcFNv?=
 =?utf-8?B?ZE9XMmlDeDNBaEpNWWx1SCtSNmZ4bFVZcEZLc3FhVjlKTGU2bmFpN2dlWjIz?=
 =?utf-8?B?ekVwTXllOGc2YldWc2J0ZG90SVNySmhNWklyRWpXR2EvS1VBajdrZGZGSVJJ?=
 =?utf-8?B?WEgwa3Y3blBrc1VCZXU1b2I4enlqbzVNRkZlaDJiWm96UHB2SDlBSXh4NVpx?=
 =?utf-8?B?Y0tmNjViUi9vMmIyQi9tMWNic1owRUhhcmdpTWRBQXlDTDl3MmJLbWU2ZTlz?=
 =?utf-8?B?VzZheGpTcVNDcnlnMjhmdDIwWlBvU0M0cy92Q0QvN0wxaXAzekR6dHl6aUMx?=
 =?utf-8?B?ZUlsWkZKVXJuYXRoeUF2S1NKRFpaVjR6YWVpd1k0aVpiQ0tYdkxlVXhSd3R0?=
 =?utf-8?B?K295TXh2UjJ1WVFlbVNDVDdXeG84bWRFeU96REc4V2N1ZldlZUhwd011RjRI?=
 =?utf-8?B?ekFlb0dWSWVrQVdHK3FsK2ZLSVZ2TVM1eWtpT255a2FkcmIwYTNBTStRK0tj?=
 =?utf-8?B?MnM2THZqRlR2NHlDRG8zbmovZlpEQ1Q4MjBIeFAxelNCQUFxdFVWYTQ2RHpw?=
 =?utf-8?B?THpwZjlsU3REWDVGcFJHdUtuZXpsUE5DOFpWUjdCeTNzUUVtWWlqYnRSL3Vp?=
 =?utf-8?B?RVk2bk1yeGNtOTBSZzZucDYrV2dySUt0bmh1bjVHazBmVDRNcEhKSEVlS0lu?=
 =?utf-8?B?RGJRSFZMZ2NaUTl2SUJ2SnpQRVdMa2xYUVBRU1lLekRIV1lJVnc2ZU40VnpI?=
 =?utf-8?B?UktUL293MXJ6dkQ4Qlh6ZldoTWFkY0xlUElXaHhoNEtaWVdIckJJa3VFN2xh?=
 =?utf-8?B?RUxZcWFncUNBNnZ0UVV5bjFTTHl3TlR5d2o1VEFLNXlnMUZIM09kK1pOcjZL?=
 =?utf-8?B?VGdEeGJTRmJleXhBeFBkTmJpdjNOaFVhS0tWUUVHcTZLQ0xnUXJtaDYvRHBO?=
 =?utf-8?B?MUxuR3V6ZjNXSUkxTWVqOU14a2F1NFEySVo1VlVKYjk1Z2NGdHJ4R0Z6bXU1?=
 =?utf-8?B?Y1Z5V3FVTnAwbFdxYkdUUm51Q3NNTGlBQk05QWV6dHJOM0hlMDdyOE9kNTdr?=
 =?utf-8?Q?aUjlZJcCkuAiXr8KkTeE1JNRbEdUlJSl/Sjvcp+ZNw3Q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6A2BC94DA9E9543869E6802A6FBD073@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8bc028a-81f0-48eb-3755-08ddc3272a09
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 22:38:33.2636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cJx9z6ZndSa9RbWwv0U5bKEnsbxsXIgVPhfI7qt8puXNxmaNShcDkB0Mttj7I2RyiWsa9jP+YN65nn27vrWERg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8615

T24gNy8xNC8yNSAwNzozOCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBBZGQgdHJhY2Vw
b2ludHMgdG8gem9uZSB3cml0ZSBwbHVnZ2luZyBwbHVnIGFuZCB1bnBsdWcgZXZlbnRzLg0KPg0K
PiAgICBrd29ya2VyL3U5OjMtMTYyICBbMDAwXSBkLi4xLiAyMjMxLjkzOTI3NzogZGlza196b25l
X3dwbHVnX2FkZF9iaW86IDgsMCB6b25lIDEyLCBCSU8gNjI5MTQ1NiArIDE0DQo+ICAgIGt3b3Jr
ZXIvMDoxSC01OSAgIFswMDBdIGQuLjEuIDIyMzEuOTM5ODg0OiBibGtfem9uZV93cGx1Z19iaW86
IDgsMCB6b25lIDI0LCBCSU8gMTI3NzUxNjggKyA0DQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFu
bmVzIFRodW1zaGlybjxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
