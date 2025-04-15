Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660D29899D
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744731455; cv=fail; b=ZW8YdNx3BCmvNr1DgqcgIPFhrwOaPRuH36PpWAD58UVQM3a6GuusswqErgFtY0PZtBWPQVQ8xYCrBORTvCDmb3j9H4u2vPrpjqnFC7mwv7NzDtFFlgCxMeKDd6ONEiGAANfL+0DZnADCcetpd05M8DftN0mTavCrrVEpM8eLOgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744731455; c=relaxed/simple;
	bh=BKlf93pjr1+W/3XQbncGE1Zq3TqPRJrq7hS72f9rrtA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h8TfqqGdqa5KhPGBgo6nKmuS7Tk+xjTfSKFzPoE+NhBmf4GCOnJjasGn3YX7K49hEP2M5Vbz5Fsa1gFHMnS9sOH3soGMDNGDLwryZpwI6AnzB3bbAmD02nn41DAT5kzZ96aT0OTpl219y3Z4g3RvLqfeIzjQwunSpbE11JiOABg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BK/yefQU; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BK/yefQU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRL3CCy8vTzcW6GidyYa5KmtJWIa6I0TfxexyUB2VzcjT8KUp6IeASe+G8X3fqL2JOQy7TTaLjsKr7oVv21dMLC8VtOb59IoM2MRRamupb2dEOWy7HoyU83AXUPWOByRCV5mNN/Mlnr/7+t+dPxUnV1C0RUQBTGskg77p4Q7rZqHZzWDFE4oLX8L7tW9l5OiCFU02phNNp5kjIshKXnDsfYm1+ZRkgwngiK9h/npnK/JzBuBBcDxt5/0gGV9CgQfjacqFCsIcsqPV5km/Wp4emGHUjC0j+JttQa7u6T1tLaZjA9KSELBhcT3AVgGX//NlAxhiZ53hDEO0bGsb/3skg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKlf93pjr1+W/3XQbncGE1Zq3TqPRJrq7hS72f9rrtA=;
 b=P4o3B7eu4qufXFD3xfWxRcR1Ha3pQXil+rTXdt3nOIJsMJIlg6mr2JNoxlQ7j5Ze3dOFtGwEYrWoOiDAilQbhkkP8tFSejXZLWjCbAn5Fv5FwhWaLzNhseYaRrv3lWrBTJF05MfbXDRbrIGVZ9QMMAVc+dBKKllrO/xqAlDQvvt4i2jfWw4yzyyAsV9ZHucVcYYQwXlcHgwBq+WMGZW99RiQUFpdngoTTm0qO8tbuQOrLuZKqLaYx77NLe7BMF+73RXXufs1PIuIOZXVl08Kt4gBeTLfVcOZ56S6VZleqtpnHj3A93jrqlh4heNABBloC2ThG5WBwNAsRia8wRzNBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKlf93pjr1+W/3XQbncGE1Zq3TqPRJrq7hS72f9rrtA=;
 b=BK/yefQUMMrJiIxH4Nq29oHVBmP8pdYCBmz3FgqadouCdQHuCYI8U0oqWgLQYPyILntx6lyPiCff2iVt2eMCffckKsvVrDqUp4ODt6rwXKZn+xl/lnW79J8whhid4HgcnLA/XRhMzhPMycCuqFGI7lSMnHnoWlsWwDgDG1GsVVF2a4K4lBZMG/GpTgCRXcWweb4MKYvsSQhyI+wuFSXrXhUKn51Q9KJnhbLpSBrLYYhmbpuhcZyXvRS51mlAj/j11IPgXSSp3Tck9nEAO88q/kk/na1vwBIH5coJ9kr+VTDwWMPwRLVSPNeBBxn/hIwuKFZo/oT4EDuMvoYE81YxoA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 15:37:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8632.025; Tue, 15 Apr 2025
 15:37:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: blk-rq-qos: guard rq-qos helpers by static key
Thread-Topic: [PATCH] block: blk-rq-qos: guard rq-qos helpers by static key
Thread-Index: AQHbrhYJDlQstUghjkCqZiHCg7FpQbOk3GwA
Date: Tue, 15 Apr 2025 15:37:30 +0000
Message-ID: <8f68fe7a-c8c1-438a-a9d5-7dbadd1f0872@nvidia.com>
References: <ee26d050-dd58-4672-93c2-d5b3fa63bbae@kernel.dk>
In-Reply-To: <ee26d050-dd58-4672-93c2-d5b3fa63bbae@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MN0PR12MB5954:EE_
x-ms-office365-filtering-correlation-id: fc7a9fb8-0e59-4d5f-7b6f-08dd7c336f3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?M244cDJnNUoyc1ZjcG9MaUNGcUhlbjI3bW5OcjJ1eUpHWXFEQzBVcUdmRFlJ?=
 =?utf-8?B?dzQ5ZS9qSUpmYk5OMWdXRnhWTlJLZm9FQUVlLzZ1UmU2WWhPN1VhVXoyUXdt?=
 =?utf-8?B?d2FHNG1UMk4rSFdxbDgvOFpJeTFVUEVBazA3TDVxNFZqbit5SzliZ3E1ZkRW?=
 =?utf-8?B?NjNqZ2lGNFI2NnIyZWJSY1l4aXlabEZteVBabmVucC9XYlVjUzBvVjI0RE9B?=
 =?utf-8?B?S0pXd2tBMXc5MmNPOWlYcHpyaWM0N1QzMmpsR256L1A4UXk4eHJ5WWtaVExj?=
 =?utf-8?B?dldKWVFVRmlxdDMreHRBRnBkS0ZleU1Kd0NXZHhYUGxHOUV2YTNHdlBiaXEw?=
 =?utf-8?B?Z1h5UmRodm14Sk1Gang0OGhvRVlhK0QwVERKNVFWRG01NWNJOWhJUUNqZ0Nz?=
 =?utf-8?B?MEpnZVVIVkExc2VTbXVGT2pEcmdPQVpDaDVaemJZVDVBUjdzTFptS00xZmdl?=
 =?utf-8?B?Z05mZStEamduV09ycy9vUC9rUlNGeTlaWGFkTWFxMlNHREhRcEdoVlhNUWNk?=
 =?utf-8?B?bW4rcnhmT0JFeVVYQWZJNVFBd3Z3ZjdTQ21CTlAybEZGWWdGcE9HV2dtc3JR?=
 =?utf-8?B?NldKU0VRREM5em9SUDNnVVlRRGtFc1kxSzZuREt4TWRXVlNIazJQTldrNStF?=
 =?utf-8?B?ZVlLVmIxLzhXQUh2ZjhPNStGVlVpb2V1a0pTQjRvM0hYL1ovdFIzcGl5OGow?=
 =?utf-8?B?NjZiN21JNzkzU3hjZEN0TGtRb0x4a2hZWGVqZVlUQW1MNnhOT3JvQmJIMFYr?=
 =?utf-8?B?Zzlob1ZwUHB1VytjTnR3b2EzOURxMXB2dDlLRGVEeFRpZkJBck9WL201Vmth?=
 =?utf-8?B?a3NkOTUrU2dvZjR0djdSL3p3ck52RGdCWjEzcHQyemVMc1NGaVlqUHRUQmla?=
 =?utf-8?B?UGxYbXFvcnNtSjZLdDRhd2ZXbzAyYTdYT05uOUhSSjRXMllWUU8wS2U1L1BR?=
 =?utf-8?B?ZG9yck5mV3VBVHEwQ0dKQkNFdzBxb0JjWHRDcGpFQ05lVSttdXRWM1lvKzJs?=
 =?utf-8?B?My92dVV4R0VJYXVLdHU1QnBEWGxiREl5UkhpTUg3My9rbGo5RkUzK2Z4VEZX?=
 =?utf-8?B?TVVuVWxwNjAvNGN3cm12cFBreUlNT3Jjb1hzZDZkbUE0QzBwcDdhVnRSZlBR?=
 =?utf-8?B?Z2VEOHI2ZFNIYkFpSGdYTUFiK0hBMlRwbUdLZUxXMzJwTzRxU2R2QThLM3Rm?=
 =?utf-8?B?S1E2d3YyT3l5N21XQVl1R3BqYnVyM29jZCtucGhMMitMRVZsczMrMFBHRmFE?=
 =?utf-8?B?T1BsUmQ1U0FOc2JwU0lmd2FWNXlWTHZYcmo5d0o2Y2NsdDhINWNBbHJlajB3?=
 =?utf-8?B?N1dNWXlPMDZrMVRIRHZMY0R6UVdHZlp0RUJaRXpJUnk4NHFQQ2podGhkbVBR?=
 =?utf-8?B?TElSQ0FGd2ptWHJ0dmRTSktYeHVOWjJ5QVNsakFJSGt5bVFwOWU4bkxESHZz?=
 =?utf-8?B?WkxXS3pCWk9EVCs5UmdTWHhoRGI1VVNZRStiekVhYUNKTnozeExrdkNxbDBy?=
 =?utf-8?B?eUFSdjI0THhRWWhUSmVLTUJpTTRGTHRMcnNBVGY3RjJkbFJhY1ZGRHlYaFg0?=
 =?utf-8?B?RzU0VjR5aHltdGVmSGJxKzJpbDBRMmxDMnkvQmFYVmx0b1VscEhEa1FuVHhF?=
 =?utf-8?B?dlFWSFZzWm44Y1orZndhOE9Md091RGNMekx6SFJGVkcwK0xhMnYwWlZuUEdi?=
 =?utf-8?B?NWJMT3kyZkNmQk40NXV1Nm0reGpvTVZnZXl2bXZkL2FUaGRyWjRTNVYzdEtM?=
 =?utf-8?B?ZDVLK25oaExNNDU2ZGlPaDZibzA3bmVTajNiVlVCYkE4bWhxbGw5aUM3OCtv?=
 =?utf-8?B?Y3NXSW9jWm5OcDAreE5obGxaVzNGZ3V2eTVEMlpiWCswL0FaeHE3aFJmQWxJ?=
 =?utf-8?B?OCswSzhIN1lmNGdWbEthY3JINU5DVTJZYlNya2FZUS96T1BCQml1UVhzTW1K?=
 =?utf-8?B?MmgvTDJuR0pkckRsb2hJbXcxQ3libGFTTUFNNjd2SjR1SlJJNTNGWURCVFN6?=
 =?utf-8?B?TGUrN3gzWGtBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTl6Smt0TXhEOEd2MmJpVXpweFJFTkczdjcybTZucWp2Qlh0RytDcnlva0gw?=
 =?utf-8?B?dkMwNEYxRmhyRVRIMnpOV1ZESEtkczJTS2FXdUEyK1J5c05vV1BQTXk1S2tJ?=
 =?utf-8?B?NEpCdGlsdjgyRWg1MGxJUmJwS21QQWxzNmc5V3Uwcms4YmI1K3V3ZGdJcFAr?=
 =?utf-8?B?LzdKUXB1d01sSFd6c0VJRTFHZTlta2xNMHd2S1FyNGFnN21lVVdyanVZWXRo?=
 =?utf-8?B?SVpMQWRremFCU1Z0bDFhc2p3UFpEOGViSHNWMXU5MkRwU0QvY3p3R3BFb1hK?=
 =?utf-8?B?QSsxSGtxQngzRzYzRjQvMTBvZElibm1CZWp3MjJsdmdKNmQrMCtCbHluMHQw?=
 =?utf-8?B?Mlh0QTIvSXFjZGVxdjRVeW5lUklhckM1ZzRvMWQxc0dEZ1RlaVIyQUZsZjFS?=
 =?utf-8?B?VFFxbHcxbmZJN0IwUFRjMUZyRFg5U0VZeWtISEN3NzV5cUkrZHg5MUdOQ0x0?=
 =?utf-8?B?a1N6RHU3NHpNKzVhL2JocUFDSTYyMUtWMWNGT0pUUzJtanZuZXJaOTUwWXRo?=
 =?utf-8?B?ZDEvTTlKaUNEUUkreTlYdnZUQlRBYUlFaExXM1YzenhDY3hOblAxUjB1NGRp?=
 =?utf-8?B?SllIVUJYVWxrbDFRVS94bThCL1d1bUhTNHNOZDlEMnptVGpMNWtUZGlyd3Vq?=
 =?utf-8?B?eHRjUjNrNTBneWpQYkhNTUxNY1p2TiswSUtocUdhcmhsaHoxeTRFY0psdGY4?=
 =?utf-8?B?d24yeXFvS2grTS8vd2dyUUsxeDEvYXZUd2Z0V3Q1OENlVFU4ZmErQkp4bEZq?=
 =?utf-8?B?aGFKa1ZxNlJWYkUzVERQNFdHZFlKM3p6ZzBhWkszS1dEUzhKMW5YZE5aOUpj?=
 =?utf-8?B?VWZQbnh6SmprNllESnNiZW1KZ3dQVFZiM1JpR1ZScjFIYjlnSTY0anJFWTcx?=
 =?utf-8?B?aitqTHhtQXlmcnRNQ2RVMXpZWVhZdGp2WHlycmUraHpYVnFHTnZjVkZyZTdj?=
 =?utf-8?B?WFI1ZG5lRmVSOFZsS2haRk1CUzk1eVg3cFVkWXkwcnoxU0dJakZBR3JYMUd3?=
 =?utf-8?B?ZHFpWkExZGVWa3NtSWRVTnJjYmtHQkxsUDQ0b2tIR3p3MnVWVVZaSk9uaHk1?=
 =?utf-8?B?T0x2amV5cFZGYnNTbC9DK0Y5L1JwY2tWRkU2SzM4ZUtHaXNaUlRJQTF2cnFr?=
 =?utf-8?B?dW5HeG9QNnM5UjRyaUthR1JVbGJGNUpBcVM2K0NYSTdBZUU1dytOVjhtWmVi?=
 =?utf-8?B?aGNSZVBjQk5UalB3b1NYTW8ydEcvZXo5QldUcjBRNFMwOWZKVUovRGhqWjBu?=
 =?utf-8?B?K1NLM29ZaVF4VFhQakphVzgwY0VuK0M2RUZjVzBQZnU5UTN3VURQZlltUUUz?=
 =?utf-8?B?bGRFYjgvVjZhbEV1aGdhbkhnQmplOWx3dkxOSjhlaWxuUDlNc1I4ZWx3RDZX?=
 =?utf-8?B?bWhwdDZJV2ZrN1BXaWkzNFErL1hOZExHQnZ6NjlCVlhWU0FHVDcxejZ4ZEFL?=
 =?utf-8?B?RzNMa1NnZ2pOQlBmSGlTVmNvWjF0YnNlakttUXpuTzNKTWw4L1M0T1AwOTBL?=
 =?utf-8?B?eWxwR244cDE0N2N2L2d0aGl4eHZwYVRFaVNKdGtDdFJvdHNzNndpbFdIQmlm?=
 =?utf-8?B?Y1Z6VHZtS1UrQyt6NWxRYWp6WEJ0aERUVzBoQ25CTk1HVFZjZEZQTU51dVlV?=
 =?utf-8?B?eW02eXBzTUN5cWExSzIvNldpZnd3V25vS09MTUZFWjN3ZHZlYmI5VTBiWVFZ?=
 =?utf-8?B?ZEFiZTR4cDJwZ3JzTTVYaEF4T04vUGM0NVYrMkVnVnl0Qzh0eHJTYklWK1gx?=
 =?utf-8?B?M09WdFRyQklicVBibmNBL09ZTm56K3kyQW1RU3ZSRExBRVZ0SUlUdURqUnJR?=
 =?utf-8?B?WSs0WTgvZ0VvZFovV0RRd0lnT2F1cEVsZDBNTUtnVnJuN3FONVYzRWVibFFT?=
 =?utf-8?B?clRRcUdaYk5saG9SQmxFcm9KelFqN1ZXOW5ya2FORVA1K3pUMUFHZkoreC9N?=
 =?utf-8?B?SEgvN0lsa0hXLyt1Z1UzZ3JoQndVakhlbWVXMU5vM2dEMGR3bGNLbTE1blRv?=
 =?utf-8?B?T2d1blRqeWZhcmJUK0tyMS92ck9Gd3lyM3oyVmNyWG1tYmFHOGo1ejR5b3Z3?=
 =?utf-8?B?STQ0c2xGVnJJYWVDaGhaWFdwRFdnWGdvbnp1bUFyaDVDTURKRWZib2FpTE5z?=
 =?utf-8?B?VXpwK2RKTVNBVWpxMkVTMDMrWjFUREJXQk1EYkIrUGFFTU5tbDRPdmxXMlAz?=
 =?utf-8?Q?UGCAFu6YNA747XAP6lnOEvxFDEG/3kl6NbB7GhD/lB8o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <27DA1C81C23E3D43AA8B4854381664DD@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fc7a9fb8-0e59-4d5f-7b6f-08dd7c336f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 15:37:30.7602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i4SOs/PfHAZaB5Lr9nCAvMivgJ/I+jdYVSOw3tGWA/98YUB2eaKkTbdB8IzUQ2dPnLpSWfBcqe5vlgUU9vZuwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

T24gNC8xNS8yNSAwNzo1MiwgSmVucyBBeGJvZSB3cm90ZToNCj4gRXZlbiBpZiBibGstcnEtcW9z
IGlzbid0IHVzZWQgb3IgY29uZmlndXJlZCwgZGlwcGluZyBpbnRvIHRoZSBxdWV1ZSB0bw0KPiBm
ZXRjaCAtPnJxX3FvcyBpcyBhIG5vdGljZWFibGUgc2xvd2Rvd24gYW5kIHZpc2libGUgaW4gcHJv
ZmlsZXMuIEFkZCBhbg0KPiB1bmxpa2VseSBzdGF0aWMga2V5IGFyb3VuZCBibGstcnEtcW9zLCB0
byBhdm9pZCBmZXRjaGluZyB0aGlzIGNhY2hlbGluZQ0KPiBpZiBibGstaW9sYXRlbmN5IG9yIGJs
ay13YnQgaXNuJ3QgY29uZmlndXJlZCBvciB1c2VkLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBKZW5z
IEF4Ym9lPGF4Ym9lQGtlcm5lbC5kaz4NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENo
YWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
