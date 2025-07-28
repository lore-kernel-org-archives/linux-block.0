Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C8A2561A7
	for <linux-block@vger.kernel.org>; Mon, 28 Jul 2025 17:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753725505; cv=fail; b=De4/Tnk+4iw37REyMzFNKewZl3feh+HtBbbwaYycUsCoz6klJpocsj5j+jsB0GFKO/w5yVl6xf3kjt95ifuMPcWfky+Mwou9MF9ZWzNIeBJY0wmuThBTIrYJFzGBH/PlGDLqjQTbDL62Alp9VyPQazvc/P9+x4w2HY9sFfvJbO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753725505; c=relaxed/simple;
	bh=tDO+mb4NlTPolk/zQ2XlMs3nSdDpfDO68H3Kmdk6MHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSp/J5qs9lgSfhEDc0JIkS42PSfpTclybSpiGUeU7cT0VRxvcZJVpTHCGRaWjLMKNju1lAMLg1JRCb9tkGwpKOQAztsK5D24xmObpbyU7v+Hc7gLmSqN4v0e9AxMHCB/ny1zqnUCvVxe5nJTVP9QiaHL9rPxvjyN3wmC/vkNXm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JEHwr0dq; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JEHwr0dq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usPxObwZWTF6MjnAkGGfHBU7SSEWkzj6KPY7FVsXx25CdiQlns7vpqPOJrQkU7zVdXNMl9AkpEMVdOP1OcxL4OFfAzp7BwnB4qx7Pb78mtiaCZiyHkVXHe71qjTokwNUdNe9Ue+srutXXWncaLXxhngbA//2HMWa6ggKTzF67qwLEFRehPEoxJ8E5xP85AELTrvQ02fqrAxG36EoqnA4QJlGStVWs9t1cQXeu8oDcPaAwtlMHleYfPwBtemsjye6QPUuwdsAd6e3WxAxx9lbspOhoW/ObW2DllK8ARgl+0amLY5Hfaw0Fs2LPcyfq4WGMWPVldwsxHWADgUliG3x5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDO+mb4NlTPolk/zQ2XlMs3nSdDpfDO68H3Kmdk6MHo=;
 b=HFoO94qQgXApdZpq7ywwsDhwVUgOIQ7nEOK4pZnJv2d2JNaTgWOrVe3ce1+kkDAxUVcNMmJLCX2ROiWHFdlzxIWKCywCB9+O7NZJHLC8T0BmKjC3yuEyPpK/RHnGR1hSqU3n9Ix4mBu78d4fiCwMFCDBZwATzBLBCZRDjQxmXkVBDa4kNgC9zVC0LEXMBp21Fl23jxF8xneLxiOe5XusMFXEEc5lm+1xtjPoCWiT9J44YhkGF/kViQJE67AkUgGbkmqWHbrYoNJoZE8IIhI18qQA2fKr+TG970qHv49iPbKkBEMoX7B3YRKwGQmXiqAOEAfowtgSOqDEjqpvXLGHCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDO+mb4NlTPolk/zQ2XlMs3nSdDpfDO68H3Kmdk6MHo=;
 b=JEHwr0dqZEKSa52ClRiuPA/XdLBI0o80l7xSxGIHgDLhJwkrBRNfIDd6Otgx3ht+HHP1TiqOECxcON8Mox29bVbNITMGufRCdLFP/p+UagudPZUId4TDgzcaccV0pF3Lx/QdBf9M2rkrwjs5JldJKKaxIBCJKxJM1hrm6+2pVBqDMwIsCTzdCkE1zziGza/gdKYV99Fi2w0NKKiRBmsq0/5hJHoR1RUuuuBNkv9bHLMuY3DA4cvnncClTtZ6cucIhGrMVcwIOL7aKuHkl8MR33mSmw+7dsCgWUyFb6MkM2veJ8tF0ykxowrQDcILYWFY7kYluxeWuWQsJZfF04YUAw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 17:58:20 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 17:58:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/5] Remove several superfluous sector casts
Thread-Topic: [PATCH 0/5] Remove several superfluous sector casts
Thread-Index: AQHb9aj50nhOg7ngcUO16bkPRcD8zLRH5xMA
Date: Mon, 28 Jul 2025 17:58:18 +0000
Message-ID: <2dd981d3-ea79-4d06-9b3c-ca671904e46c@nvidia.com>
References: <20250715165249.1024639-1-bvanassche@acm.org>
In-Reply-To: <20250715165249.1024639-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB9079:EE_
x-ms-office365-filtering-correlation-id: 5af16e44-ac7f-4a85-bc5b-08ddce005589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SmlaTXpUWmpLWXR5OEtZbm8weEZ4WUlDVVhtNjRRT1ByMDlLY0YwMk5tUkpI?=
 =?utf-8?B?SXp0QVdHdUE5T0ZUYVN0Vmd2WkUzZEM4WFNWalNVNU84eXZVcWFmOFgrOUZL?=
 =?utf-8?B?TTJBZ0I0Z0tKN21oS083VVFTUnE5cEtZaWwyZVhMdDVJOUdhaU00WTVHcnpv?=
 =?utf-8?B?c0FoT0FpWEMwNmliYTJZREtCNGNoU09MTWkzZUJSTEQ2T1F1aUMvSHVMUHp2?=
 =?utf-8?B?VU93U1lXTEhObXpZSWI5WGl3djcrcmROS2ovelduay9BV2s0VlFrM2haT0w4?=
 =?utf-8?B?VnlpRVE3TEI3c0ttZStVb1BnbFpFZFJnNXlKS25oUHord3Rjd0phYVlLTWJ1?=
 =?utf-8?B?cWhRK0l5bkxUR1FrOTBzYnRaVGU5STJVVEpRZDlhejZWYTdhUk1Jdm5EQlF4?=
 =?utf-8?B?aXh0SnN2MEdmck56ZmlKKzJ0a3IyVmRqNDFHaHdqOC9yMGdodkg0dEI0T0lm?=
 =?utf-8?B?cjU1UUoyUnZTUVBMY0Z0R0dDTzVCLzlKS2E4RlhxWXhpbE54aWJwQ3kyamJX?=
 =?utf-8?B?UE93dU0wU2dKTnM1VmZlVzZSMVdNSk0rcy9ENCtZYklKYXNWckt2ZUhyT3RW?=
 =?utf-8?B?aElSMVVCQUd6YSt5Y0VHaFlUQzZleFYxcnZld1phYkJ3VDJxcUZ0d3N6WEw5?=
 =?utf-8?B?STkzN0VxT0pPeEVIQWV1cUNHbTRBcGNpUDRkUEtGTVIxeWVyS3BlZ204T1pr?=
 =?utf-8?B?dDYzTHBXWXhMa3lPY1R2MmptLzFITlIxaTlCZVRlajVKNUZyNGhEQUhoOUgx?=
 =?utf-8?B?NjJ5WlpIL3BTcXY4Q2ZEUWRxc0N2R2lKdlc4VG16YWU1MGdFRElqS3R4ZW5X?=
 =?utf-8?B?WXNlYnk2ZUVvVGcyb2xKdndCY1NQQ05UQU9Hby9MbHpwK0VyMWhYaFdVRHRS?=
 =?utf-8?B?MGlwb3lJQ2FOS0JnWmQ2TFRSSnhpV3ZzSTBrVXk2a2E0UXBqbHBxVkE2clF5?=
 =?utf-8?B?bnBtQzN2YXhIdUNyZXFHSUxlMUs2Y2toQmx0bGJYckdWd1hzc3Z0d1VhZy9L?=
 =?utf-8?B?WUVuZ09pQlluYWRUcGx4cjhEVzM2aFRrc0xuOXFZQlZIZkRwYUU2dTEvQ2J6?=
 =?utf-8?B?WDZwZFNEQ2trYlRycVBCZG0zYzhWT3NvdUs3NjNPbWpsQWJHblVkVFVvU003?=
 =?utf-8?B?YUQ2cE9CZmpKazRXaWZ5MTdQTnpHMEIwNHZ1VzgvdncycWljSCtsaHFWbk5I?=
 =?utf-8?B?QzNFUG1Pb2JyNDU3NTlzdC9uNDc3Zk5YcnlZSldqRXZsWHVTdUhyemdMa1dt?=
 =?utf-8?B?cHMzbmhiZDY4TlF2ZTRJZGZHeUtSMjd0aEVzaUdKSHlodjlNQVRzcThHVjB2?=
 =?utf-8?B?YTZxRlhKR3FuaG13SEZIZWQ1VjlJSGR3OXhsaVpqRUZWaXdDNW1QSFBnamNm?=
 =?utf-8?B?dDkyRHk1UnlkbzBKbGh4SmpMczNZVkM1ZWd4REtkUUVpUGNuRGdsU1BzUzdQ?=
 =?utf-8?B?djlrU0VxalRiVlRoTWNHK3IvSVFPYit3a1NlanZlbXhVQWpHQk5hUkNVaTFk?=
 =?utf-8?B?K1BaTFcyQkF1bkJNSmtQdXFyVG9kaDNvcjREbC9WeFZXT3dJT0pwNkJKOUVp?=
 =?utf-8?B?K09uajNjR0QzanBDNWM3MnNPWDJsNnZoUG42NlN0YzdqK3h3QkVwOUVWaXVy?=
 =?utf-8?B?aUJsS1JNMnh3aWRrVjk0YlNIYTJ3dXdMM1NDOUJhN25OU0hOd3RtOGNKeFFQ?=
 =?utf-8?B?VnIrT1JaWkJscDMwQnI4Q0dLb1RpdTlGS1pDcWE2SEgxK2JjQU9zNU5aUHBL?=
 =?utf-8?B?T2VYelpJcGhOZG84S2wwQVlqczdMc3YyaXBXVmxhOHJCRkpKSjA5amdVZnZ0?=
 =?utf-8?B?Q2cxaFBUb0ZoK1UvSUYyMDNKMGphZmV3RFZsQW95bUZRVzJOYVZ0QTYvandN?=
 =?utf-8?B?bTlFeUlHRVkrWitYc1BDWVBHcnRCMDVJOU5CbDFIcFNHaVVRdHRXSnJLNFFJ?=
 =?utf-8?B?dERCeEJwbFpRNXJqeG4zR1NvZHZSQ2F0cm8rTWtMSHVkUFFvbVUyd2tNRGJ6?=
 =?utf-8?B?TzQyczVVSWRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VW5ZSm1iKzNPa0hZbGtTbUxkbWozV3N2SjBvREFnNVdpYTc2c0ltZTEwOHcx?=
 =?utf-8?B?Y3NES1JHYVVCZk9hNU1mL1JvK1dkMDZwRVoydFlXeVJBbG54TzdUdlpZa0Y4?=
 =?utf-8?B?VDFJNVZDUmdHZnRoNFlKeVVOcTliMmI5ZWsxL3hFL0ZsQTc3QnlOMG5lbHZi?=
 =?utf-8?B?U3IyemsyaHhiME5mNHhmR0ZaVFJIK0ZhenVxYm9XcDdpc3I2b1NFdStWQnpv?=
 =?utf-8?B?RzA5VkNITEkrRDFjV0lETjYzN3BLclJkOUFQV3B2bHdKQnZRd0x5YXJKT2dO?=
 =?utf-8?B?UnhrVDlUOGxPZ0VsWTVYYjhSeFZMNXpid2ZFNEdhcmlIZHVxTHZOWitNejQ4?=
 =?utf-8?B?NFREUWMzakZsMjlyazQ3NDl2U2ZzekZ3aG5FV2JBMU9ZbjU4RmxNa2RKZG1M?=
 =?utf-8?B?V0lEQmZab3EyeEx6djExY2VzenB1MnliYU1DMUUvOGZwOC9UK24xZlBGSGxW?=
 =?utf-8?B?K0JNK0dHb1VqclNkWU11enNKMldLdzRKZVFoUm9URWJURTRscy9EejIyV1dH?=
 =?utf-8?B?Yzh4Mm1IMVprdUNTb2dmby9DTm1vZGpmYkpUZDc3TmxIbHlxQnFRQU12NVlC?=
 =?utf-8?B?YmVoUGQ4TjJnR1p0TTcwSEdJWEloZ3NrL0NUbDV1MFh0bkU3TjBtRGRJVWJp?=
 =?utf-8?B?S3E0REFUNHF1dmZmMlJBVnlvUEF1SkhnMGhkQVUvc1l4NUM1c3dML2xBOVVU?=
 =?utf-8?B?djJoaFZTdk9EQmFIVlpzTTV3c0h3UmlSMVdraFVLWFJiZ1h1d3llS0JVa0FD?=
 =?utf-8?B?R3RmdFdtbEI1QnRzMHY2T0UzcmRPN3I1bFdPNTNwTjh5M2U0VUdNWGtoRlNi?=
 =?utf-8?B?QUh1MFRJM0cvNGN4VmtRZnpNRGh3RDdVVFZrdk44T0VYWVR1SW9BNFhFNHlh?=
 =?utf-8?B?S3Z4R1YzRGh6cXd4dUpDN0d0VE9GaEFFbzh0VTcxcFRwR3lCVEFJTkpRazFu?=
 =?utf-8?B?Y0k2M2JNcDlzVFdjWlBaOHlWSEx2TWIxWmhiQTI5RXcrKzRGUnJ6bjh3Um9Z?=
 =?utf-8?B?QkVodisvU2hBcWFlZ1BBMEFEanJHS2JBK1d3VUl5aVBkTkVpc1FCeUl5Q1Ay?=
 =?utf-8?B?bkRrMWlEUTBIR2VsTFhzcXRvZW9SeFRBMGRzbENFMFdsYnJaR2hEc3ZaZ1dI?=
 =?utf-8?B?QzEwK2l0Z2tJbkcwcWtkVGJxQkgrSzdYZEd6UllvUUk2YkwxdGdZS3lkRDhk?=
 =?utf-8?B?NklnbnV0dkhheGZiQzNiS2ZlQjU3T21DdFllTnRiVUtubWxUOXBLRGhmbFRU?=
 =?utf-8?B?TTNBUjhXSjJUY3luQUNOVDZsd2NLSDhwTFRpY2N1bjdLT05XcFROd29qY0E5?=
 =?utf-8?B?b1pySEtSY0llWEVZNmMvbFpsYko1K29Rb3czb2xCalVjeHhDSlM1VFB6K0w5?=
 =?utf-8?B?dVZFbDA1M0RxeDlmTC9lQlFJazVEeXhnTG52ZlpSZmo5RjVFWTh6VFhDbXZH?=
 =?utf-8?B?WlBiVVo1c2REaDVhbngyTjloWmJoTXBGMzcveXM2VjhaQThyOWE2WmhFOTNk?=
 =?utf-8?B?ODRqNEp4T2lQandtWnRHdzdHaXljWDRDKzh4V1RaWXZnWVFwbytXb25HTE5Q?=
 =?utf-8?B?R3N0RTF3YXM0TGU2K2dCbFZoNVdScHkvaHF6cmVEVnRMUmpxNllDQzlUWjg1?=
 =?utf-8?B?eisvZllvUEMvelhoY1VoY1pZTWMxRE42aXNaa1FNb0F4L1NYRXQyaVdiVE03?=
 =?utf-8?B?VjZ2OTd4UnMxWkZFNHNzVFlSNGtuRkkwN3dob2dIc3dBaURCZXNycE1VSzZl?=
 =?utf-8?B?c2FnWW9lTElOSkZHQXhWR2VQSFo0Qk5EVEw1aUNBYWU1c2hsU0lqeDQwYjUr?=
 =?utf-8?B?TElpc08zd3dYN2Z2NDRFSmU0ZkhVZ3NrekRYallONWRzWHVDQURoVGVicFVh?=
 =?utf-8?B?RUR6RDE4T0tPVWVwdUZOclZXdHY5Ri9WbVM3bXVVZHNmR1ljN1V6MkpXMmM4?=
 =?utf-8?B?dmhIR3BHZVJIM3Y0c2RiajdsSmd3UFc1TkhQd1UybW5MVFdNcXZUZEQrMmtS?=
 =?utf-8?B?bElTVEovZ3hrYURoRm8xdGVLU3VoSGdiNDd6cDlvT3hRa2xSaU51L3UyVjBY?=
 =?utf-8?B?dUFlQzAyUXV3QnlQTG9MenZXSjU1ZzcyYmpFdElPUUhJRnZ1R3RFVGtINEhW?=
 =?utf-8?Q?R/E1MBGumDysG/uJd1Nzt3RA1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5CF66FAE4C137D4380C2E82A40709642@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af16e44-ac7f-4a85-bc5b-08ddce005589
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 17:58:18.6460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4SnA5im73sdStwd5kweQmKJ8t0L1BhZxI3x3zqIE4XS6PoWm2H4V5RvK1K0w2JO2RKPQtmITm7aW2MZvFVZj8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

T24gNy8xNS8yNSAwOTo1MiwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0KPiBIaSBKZW5zLA0KPg0K
PiBUaGlzIHBhdGNoIHNlcmllcyBmaXhlcyBvbmUgYmNhY2hlIGJ1ZyBhbmQgcmVtb3ZlcyBzdXBl
cmZsdW91cyBjYXN0cyBvZiBzZWN0b3INCj4gbnVtYmVycyAvIG9mZnNldHMuIFBsZWFzZSBjb25z
aWRlciB0aGlzIHBhdGNoIHNlcmllcyBmb3IgdGhlIG5leHQgbWVyZ2Ugd2luZG93Lg0KPg0KPiBU
aGFua3MsDQo+DQo+IEJhcnQuDQoNCkZvciB0aGUgd2hvbGUgc2VyaWVzLCBsb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
