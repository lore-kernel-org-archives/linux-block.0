Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203701F0E25
	for <linux-block@vger.kernel.org>; Sat,  8 Nov 2025 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762567780; cv=fail; b=GSDMHU3nH4thBTZ0DV9UwpM615AYgU7sRyf/OM7TP4Urg1lgvs/ukFTTSqeR9jjIRKfJV/6NAW1P5H71DExwzpNFCGVB2a3WL+klwr2s1ssDF6HFTXHRa7kNhfu5rDM6pNZzp0yKtRDqH3kiieBvkOCKVHfvD9QGl/8qeO9aa3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762567780; c=relaxed/simple;
	bh=V+zcT9qRXr1Tf+wxWQaC+qXCL31sAUDMwtd7fSFCuI4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I3K8iS9hOjNsjGOc84y4LmpI4q9aDcV7z+/JD7GBgjY9g2KMhm5Sa3am4+moYDTrYdSl+qui5aFi3ENAmxwkbhmO7FxdT8+5j7+LvGpqQLZL/uhLETdHECOnr9DzSuU0lthT2dh4tTqRQ/KeWU+CmhJa2Vwzu7QsYas70tWeMpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E9vK8KiR; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E9vK8KiR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3amP3pve4wJqtSpe3EzcAy5hhO6rKUI36Ngukn1gj7lBacJaNBMosnU8YNXHoT14EdF/wNpzF6awb2ZLO1pUagi49n8SEomlK4RNZGND/spS3py38eT5f3YqgtXn85s/F82OUW0zJG2k6TqtB4vy4VQcVZFzxZguUaX5Fvo6misYlQohQt8JMS5QCj9F8aVTQCHyJusCNXUst6Kseem3a4qBjojCZnQVOYxxAgUGA9jbLqCnzqlBzdE0sZamr8R4wf/DoHoIHAQ0Hj0fuzTzdaYf5fLwSxSTWdsoSLqsuKMc0UUyTStXfQgBtsN+AysTWDU5UpJYPIIlUMOIaNaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+zcT9qRXr1Tf+wxWQaC+qXCL31sAUDMwtd7fSFCuI4=;
 b=cE2vI+rfULLlmZVYnBi01zGNJtOaqgEFdNgSFSaIXcKjhesHsQCI9zONtWGiRt4H7XQlA2I4Lc14iTRpXmVjCU+5Gja/IhyIYO5c+A2iQBvNxCb58lXXXVPkGD3L+/MN8L4Aq6Co1mGRREnib+JYkZQA/HYCXTknbu7UDfwixrEo/6VzBU7fv9Fd6VbCAlaJQ6KD8ArhoVYsKAjRg9x69owLn1FBEBfX4Jlj9WxgdkBTVCEIVIV29BkhWaCU55Oe0KfPJKflYr6WLvR/x3uPgdPxedjNwDAM+oQrRVnaEF01ILQizEHhXdNCV/YDeP3+h84SacOp5V9sX7GDTq0wNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+zcT9qRXr1Tf+wxWQaC+qXCL31sAUDMwtd7fSFCuI4=;
 b=E9vK8KiRxrIhFYr85/X3YeB2yzy5AXg5oK4wT32I91mqeAiBJ+MLhTw/TBHaCAahHXWrAGHXHtSOjVjzHfcyMdnTSFwB6QadOOb6YVEUhYfIjGkPPRmbJfJbcK/QSJCqsYI2S4jbX3Kf9DuDV17ZTUSNaGIs8Pe1p3w/+fQp88MLzYdhKv9UDsQpxgGsA1Wja/LmexR28OZW2RVVaQvTNTptoMLgjZklP6aAG7WAqsS/w+2Uf6TaQrMT2mTzlOarx6pRrYB2FkFBBZGRNQbvuRcUsghONl5PQx/UKepK7B/kgBfl8NHVmMR30X85RDsyQSBY53H78CVqAbaeiFuDCQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 02:09:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.007; Sat, 8 Nov 2025
 02:09:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hch@lst.de" <hch@lst.de>,
	"shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] io_uring user metadata offset test
Thread-Topic: [PATCH blktests] io_uring user metadata offset test
Thread-Index: AQHcUDzy/ODWzWGg+0qDQ1lOwDgeJbToCPcA
Date: Sat, 8 Nov 2025 02:09:33 +0000
Message-ID: <5d630378-6653-4b2b-b3ec-946bf2671849@nvidia.com>
References: <20251107231836.1280881-1-kbusch@meta.com>
In-Reply-To: <20251107231836.1280881-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB6281:EE_
x-ms-office365-filtering-correlation-id: d3466303-3566-4a5d-bf3c-08de1e6bdbd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?T3J5Rmt5VEVBUmtTMk5UZHFZUUxkeWcrL0dpNWJ1MDVrZ3dKSzZBSHU4STd0?=
 =?utf-8?B?eGx5d2dDREdaVXlGR1JEdElOWTlGYjB2cXVTSUJkYzZIdUFuWS95U3FlVndi?=
 =?utf-8?B?UmpsdDVnZ1JtVGRlaEJOcDAwVE0vZzVBdS9RdW1DTVRieE9TekR3UU5uMGVt?=
 =?utf-8?B?b1lVQ05wb3dKMHJON1ErNHZONUlEbG91OERkcmN2MkZnTnRmNXpXRWp1S0Z0?=
 =?utf-8?B?RWJMTStVM0RUeXcrNGF1cTljbG9UTmR0MDI0T1BNUzlra2tmWmUzcGFpbTdm?=
 =?utf-8?B?a0JpSUlIUjNYbURqdlZGL2pxa2V1RkVxc3ZtLzhyTXJ4QUZHbFo5ckJHdTZG?=
 =?utf-8?B?VEsxY0VleWdWWlhZVUk0dkRrTUdHMWpnc2cvanVMZVB0TlJaLy9sMUlyR1lO?=
 =?utf-8?B?NjRkL2lWQ3hEWUJMMU5ybFcxczQ0V0VEaHhySFUvOWF4OGR5NjB6T2xYN1V3?=
 =?utf-8?B?NlNLN1Q5dXJsb2FnN0w4Z05Ubm1ld0lZaE9zQ2lRTmRZZzdFbTBkclorWnh5?=
 =?utf-8?B?M2xUS0IwVHBOQ1hUa3RnL3J2c0dHdEJleDJQZTR5Q0YzK3B5SEpaSFlpbHVP?=
 =?utf-8?B?RVBqRFZmL0xaVlBmMFBHaFpEWjB4cGpMVUxNQkVYU3NlVzYvRFhsMkszdFBa?=
 =?utf-8?B?emNBREVRK3FHUmxraWl2ejQ1RnVRdTZEN1JFYTFtczNwN3A5b0JUQTlsVCtv?=
 =?utf-8?B?c0l2ajVsZHVqZnhReiszb2NZWnhWNmc5dS9mRGt2UEd4M0JBRjUxNVBaaks1?=
 =?utf-8?B?U2hMekwydFNNdE43YTR4OXFxS0t1SjJTaG1UNVd1K1o4amlOc0tBcnUzcFFz?=
 =?utf-8?B?RUpBQVBqajZBalhmbTVidHhWaXBaeWkzNDUwa0xxbE13L1dzY3BUV3hBS2lv?=
 =?utf-8?B?SzU4NldTcllaWGZlOTQvL24zRjIzeEpaUWkyQUVrUXRMRGlBZGNyZS9SN1dh?=
 =?utf-8?B?bWhraHhuQlk1U2lLWXB6S1lyenkydnl0MVhjb0JJeVpSL0M2c3l5YkVtL3B3?=
 =?utf-8?B?TXphRzBFcGg1czh5THk1YjFyUTJ0RmNQcGczVWVwSEZQaDRvdGFvdFVpV1JJ?=
 =?utf-8?B?RmVWSXppZ0ZBVW52MExZS3RjbDcxWHE2MG5EbzZJVS85M0UwVCtTaFpkOXp6?=
 =?utf-8?B?ck9YNk1TRjVoMlRmeWFmTGw2SGlaV1c5ejI3TWI5UGx4Y3l5OEQwWG5wV2N6?=
 =?utf-8?B?R283ZWp4ejYwaG14UTAvSklmUWFvZUd6Q0U4L3pzdkh0dkZ0cVl6MHY1elF1?=
 =?utf-8?B?K09SSmMxZE5rZFJMa2U5MnhUNjI4WGJ3NE5BTnc1MnZiNVAyQklCOU56QTM3?=
 =?utf-8?B?N3ZEcXVyckFneTM1dGlHNGRYZS9mY0xjNEd1VGVacHg0OEN4cDRYNGExdkVL?=
 =?utf-8?B?YU42Q0JMYk9OMmlMRVJkYkVMVmZoN3pVM2xITGNRZEplaDllbUdKU2NJYUVO?=
 =?utf-8?B?Wk5DOFBvejN3dTFCVGNNMjdVTDNIM2NMY3FRUGVPV2NaYUJabU1aTm5SdStu?=
 =?utf-8?B?eDJjNU5pak1nbXV5MFdaRWUyVkxDTEVBSGZLdVo1VklYZVkxSTJvVVI4WnI5?=
 =?utf-8?B?NkkxYjltdEthTmRFNDZScFFFWDRzRjQ3UWoydkVBKzB5eERiODcyT09pRDZr?=
 =?utf-8?B?ZWpWdDFTYlE5Qi9WVlJnZ0ZNU25DbTZYQ3p5THhXVFY3QWJDenZZQXViSHR0?=
 =?utf-8?B?b1RwbGhLMElMTlZxUFFWUzFud1FKTldpaXpGTk1tSDlxT1kzdFM0TndZSHl3?=
 =?utf-8?B?Q2RFTVNNS3FCWXdEblNCc1JEYkpwaHZmYkQ5Tm42RENHeUREeW9oSVBVRWJz?=
 =?utf-8?B?VTN1Nkg0a3hjRk96NzZtNEExKzYwdExIVFlIcllhWTd6MW9kT0ZKdmp2WHJW?=
 =?utf-8?B?NXE4U2JhdUF4LzIvWHpKZFg1Y0x3MHNTck9lRTNwYTlLN2oyNFdmeEFkOGlY?=
 =?utf-8?B?eXpFeS9KSEVIbU5tRjIvRUZucm4vSC82WlFxT3RKeGhmU2RVZTRqcVFaUFNP?=
 =?utf-8?B?SjAySnR6TUxwWVl6VTJnN1ZmQmYwMlJ3NjZtTHBCWkg4NWhsVmtKZ0hlNVpV?=
 =?utf-8?Q?bb6mpM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?di96Tlg2Ymh0MkFBWDJNdnA2Y3ZjUGZGOGc2ak9rY2MyTzIrdVpkWTNSNUlV?=
 =?utf-8?B?Szc3T1QvUEVKOTYydVB2UnIvMWtiZWgxc3ZmSjF5dytSakt6S1M5K1pObnZJ?=
 =?utf-8?B?OVBHWkhLY0I1SkEyaFM5cEkwelZxemhUaTFmblVQSEVVR2ZnM203ZUVFcEdE?=
 =?utf-8?B?TWxwTnBURWxJRnpHZ1Z6S0FLTzUrdm8yYjVPNHJQUy96bWtTamwzYktDL1Fy?=
 =?utf-8?B?M1plSU5JQVMvd0tFRkx5UDFoV1lFZHpHMEVKUG5YNlRFKytmNUVQb3NPR2pV?=
 =?utf-8?B?cWhDc2l3SkJ0bmR1UUdHeHU2cFRYcGtQOTVmelRyZXJOZEIraUVRbnBLZW5r?=
 =?utf-8?B?T1ZaVWZpVUQ5dCtxdDVhOEpWYWdtYmhoS0xmdkFMNnhsWEVBN2pxbHl4WE5V?=
 =?utf-8?B?SldpV3NWaDFOc0JYWExhNFJJaENTT3BXbGRMRnlYN1NydlFvSC9UWGVoeHhn?=
 =?utf-8?B?K3o1ZndEZHFGMm9sNmozR1c0MzlpS3d4bVFFc296VXZ1bVkzbkprMi9mZ0F3?=
 =?utf-8?B?QzJZVk1mYytTVjJzRjlaeFJVbkVwQU1ZTy9IMDZqVUV4bFpLRDhieXpIV2ly?=
 =?utf-8?B?ZnkwRENUQmpmdzNBYXk0dTBaMCtybzFldXdGNkxTZWlneUxUcEdyd0VKQWJ3?=
 =?utf-8?B?KzdxOXN4ZGJkYnh4bWhWaFBDaStpRisvYUI4VVZUNTRUTGhoWTdRSFhsV3Ay?=
 =?utf-8?B?dUdyUGJDYTdCNWRCV0VXRVU0Vk9JOVU1MlBvVnRvY1B0YnRhYjEvVlg1TWQv?=
 =?utf-8?B?SkNUZmliWnQ2dkMzK3FFdmZTbDRwZUlYc21GTG5oTFBhckNjK0lOWmlWSm53?=
 =?utf-8?B?ME1odkdQamJld1ZNSWVFbGV6azYwMnJBZ3M5WXBaUDFCVmsxaWlXQ0xnQ2RT?=
 =?utf-8?B?NmhSYlZzZDJGcUF5Z05YaGlTZExMTVZYelF5NmYxcTZMY2JUdGNXZURxRVdU?=
 =?utf-8?B?dWxmQm9zWStpd0lud3I4ZXZEcGdJMzlKbjhEQUFzc0NGSnBjaHR4RVpMNks2?=
 =?utf-8?B?bTRPc3VwWituNFRuSEQ1b2RWUmdBVTBWK0kzK0FWN29vQUZ6Z1NhTCtwanUz?=
 =?utf-8?B?akNScE1jbkVTKy91Vi92cmpVcmdrZkxlakE5K3hiRU5MWldUT0RHTi92d21C?=
 =?utf-8?B?TElPNVR0cmZaaFFxVFFqWllhY3VZa0hYYjlFV2ZENytQdnFFenNHWG9xaGNt?=
 =?utf-8?B?L1FmUWljbkJrb1Y2a0YydmFOZFIwaFQzNDhtcGNOQVFYUUdwdEdhZWU1Z0Ew?=
 =?utf-8?B?OHRvSCtFRyt0NGFHUkNvZzNzL09seDdrMmtVM051akhSSWFFT1E1VXo1dklt?=
 =?utf-8?B?LzB3ekJrdlZUWU9meTlRcGd1ZlU3UWZTaFAxRG1laEdQQW5YaGdxZjI2WG1w?=
 =?utf-8?B?amhYQ01oSGVGSVIrMEJvbStWYUgxRHB3UEI5VlVBN3BZTHNZN05TbktkWXU1?=
 =?utf-8?B?SStzaXorL2tYYkZLRk5TbkMxbnptUmw1ZUNYakx6OGZxUzJYUXlCUFYwaVJo?=
 =?utf-8?B?SWlzb1RXbWVxQk8vSXFIU3hqdXdXMkFRUFRrMnI1TlFUeElHZ0haOWc2V3Z0?=
 =?utf-8?B?U0NEd3JldWtXWHlEcDd5dUpLSWdYSU1hc3VvTUhvWkZqSXRIdG1tQklEejhq?=
 =?utf-8?B?L2ozNHRRNlAyMGwrVkkwVUFaMVpwYnFLbzc0SUcwWDRpczZFdHdUYlVzYlJQ?=
 =?utf-8?B?dTRsK2tuNFRWcXdZT0NNQkg2ZnpMZko3RmRuUnhVeVFOTSs4S0UwYzV4MEo2?=
 =?utf-8?B?WDFScUh1SkNhRlVFWENMcHVOU0FOQTBmRlRVOWFqeXhVZkdGcmwvOHVOaFN2?=
 =?utf-8?B?V3BpdUtPMGRqc1pSbEJ3c1RLR2xCclV5U0ZZR3U4MmpvcUdGNml3a0JWamFu?=
 =?utf-8?B?bDVUanVkL3orTGIwTy80NmgvQUNQTjBTL1o0a2NFNE4wUnM1MjBINEZDeVBo?=
 =?utf-8?B?OFFVakduc2UwQ2tiSHVZTUNja3RHaGdaSndmdCtvRDBzOWg2MVdIVXkrRC9l?=
 =?utf-8?B?b0pDMTM0QUJoSjE1NTBpYVhBZ3h1bzBmNVpUdTE4RVlLT1FHTnNsTHB4M3pP?=
 =?utf-8?B?djdIM2d2OGpMcDFPbDBiZUxZQmtBWlBIYU1EQjM5VzRCczZDalJrOFNCNVRS?=
 =?utf-8?B?VzJiMUlCQVBzVEo5T1VlYnhFK2gvb0ZoZGZ1SFpUOXBQRnhmRU5nSmMzS2xF?=
 =?utf-8?Q?VbmpiWbX48jAFolXWhNXpQOojfY/mOKxXiSr4b98jUEP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE29E47F1A41B745A089F275D8B9563E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3466303-3566-4a5d-bf3c-08de1e6bdbd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 02:09:33.1003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vs1v6wV4SJcIO8oUqW9QwmiYwIMGvKDyNGDz6YiDUNRWvd+UKYTnjNHOiru07JIle312Ez1nYp49ISFJo/RjmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

T24gMTEvNy8yNSAxNToxOCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IGRpZmYgLS1naXQgYS90ZXN0
cy9ibG9jay8wNDMgYi90ZXN0cy9ibG9jay8wNDMNCj4gbmV3IGZpbGUgbW9kZSAxMDA3NTUNCj4g
aW5kZXggMDAwMDAwMC4uMGU2YTZjYg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL3Rlc3RzL2Js
b2NrLzA0Mw0KPiBAQCAtMCwwICsxLDI3IEBADQo+ICsjIS9iaW4vYmFzaA0KPiArDQo+ICsuIHRl
c3RzL2Jsb2NrL3JjDQo+ICsNCj4gK0RFU0NSSVBUSU9OPSJUZXN0IHVzZXJzcGFjZSBtZXRhZGF0
YW9mZnNldHMiDQoNCm5pdDotIERFU0NSSVBUSU9OPSJUZXN0IHVzZXJzcGFjZSBtZXRhZGF0YSBv
ZmZzZXRzIiA/IE9SDQoNCiJ2ZXJpZnkgaW9fdXJpbmcgUEkgbWV0YWRhdGEgaW50ZWdyaXR5IGFj
cm9zcyBidWZmZXIgb2Zmc2V0cyIgPw0KDQoNCj4gK1FVSUNLPTENCj4gKw0KPiArZGV2aWNlX3Jl
cXVpcmVzKCkgew0KPiArCV90ZXN0X2Rldl9oYXNfbWV0YWRhdGENCj4gKwlfdGVzdF9kZXZfZGlz
YWJsZXNfZXh0ZW5kZWRfbGJhDQo+ICt9DQo+ICsNCj4gK3JlcXVpcmVzKCkgew0KPiArCV9oYXZl
X2tlcm5lbF9vcHRpb24gSU9fVVJJTkcNCg0KdGhpcyByZXF1aXJlcyBhIHNwZWNpZmljIGtlcm5l
bCB2ZXJzaW9uIG9yIGhpZ2hlciBmb3INCklPX1VSSU5HIHRvIGhhdmUgdGhpcyBtZXRhZGF0YSBz
dXBwb3J0ID8gT1IgYW55IHZlcnNpb24NCm9mIGtlcm5lbCB3b3VsZCB3b3JrID8NCg0KPiArCV9o
YXZlX2tlcm5lbF9vcHRpb24gQkxLX0RFVl9JTlRFR1JJVFkNCg0KbG9va2luZyBhdCBibGt0ZXN0
cywgd2UgbmVlZCBzb21ldGhpbmcgbGlrZSA6LQ0KDQpkaWZmIC0tZ2l0IGEvY29tbW9uL3JjIGIv
Y29tbW9uL3JjDQppbmRleCA4NmJiOTkxLi41NDVkYTYxIDEwMDY0NA0KLS0tIGEvY29tbW9uL3Jj
DQorKysgYi9jb21tb24vcmMNCkBAIC0yMjYsNiArMjI2LDEyIEBAIF9oYXZlX2tlcm5lbF9vcHRp
b24oKSB7DQogICAgICAgICByZXR1cm4gMA0KICB9DQogIA0KK19oYXZlX2tlcm5lbF9vcHRpb25z
KCkgew0KKyAgICAgIGZvciBvcHQgaW4gIiRAIjsgZG8NCisgICAgICAgICAgX2hhdmVfa2VybmVs
X29wdGlvbiAiJG9wdCIgfHwgcmV0dXJuIDENCisgICAgICBkb25lDQorfQ0KKw0KICAjIENvbXBh
cmUgdGhlIHZlcnNpb24gc3RyaW5nIGluICQxIGluICJhLmIuYyIgZm9ybWF0IHdpdGggIiQyLiQz
LiQ0Ii4NCiAgIyBJZiAiYS5iLmMiIGlzIHNtYWxsZXIgdGhhbiAiJDIuJDMuJDQiLCByZXR1cm4g
dHJ1ZS4gT3RoZXJ3aXNlLCByZXR1cm4NCiAgIyBmYWxzZS4NCg0Kbm90IGFza2luZyB5b3UgdG8g
ZG8gYW55dGhpbmcsIEknbGwgc2VuZCBhIHBhdGNoIGFuZCByZW1vdmUgdGhlc2UNCmR1cGxpY2F0
ZXMuDQoNCg0KPiArfQ0KPiArDQo+ICt0ZXN0X2RldmljZSgpIHsNCj4gKwllY2hvICJSdW5uaW5n
ICR7VEVTVF9OQU1FfSINCj4gKw0KPiArCWlmICEgc3JjL21ldGFkYXRhICR7VEVTVF9ERVZ9OyB0
aGVuDQo+ICsJCWVjaG8gInNyYy9kaW8tb2Zmc2V0cyBmYWlsZWQiDQoNCm5pdDotIGVjaG8gInNy
Yy9tZXRhZGF0YSBmYWlsZWQiID8NCg0KPiArCWZpDQo+ICsNCj4gKwllY2hvICJUZXN0IGNvbXBs
ZXRlIg0KPiArfQ0KPiArDQo+IGRpZmYgLS1naXQgYS90ZXN0cy9ibG9jay8wNDMub3V0IGIvdGVz
dHMvYmxvY2svMDQzLm91dA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAw
Li5mZGE3ZmNhDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvYmxvY2svMDQzLm91dA0K
PiBAQCAtMCwwICsxLDIgQEANCj4gK1J1bm5pbmcgYmxvY2svMDQzDQoNCg0KLWNrDQoNCg0K
