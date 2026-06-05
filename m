Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEB93A718C
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683363; cv=fail; b=PqZeYd6e2zzw2yBb9au6sgDW+R+aWxNBRlP9AIVr6xgC8tG494L+ytZ+vp0p0to2Ex4uUFV18ZkWFmrYGBQl4m/n+y8RCnQo1Tx9/kt8lQU1QVoiI2cN9i9hggJOiCXbf3rVwGf5SI2i+Jy6zML7GkClmlZsvTT36Vtm66Lr6qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683363; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bX/HnL1alSS11yOabpGagm/lf+qyTJnfrV5rb0XDxrmKI+/QEqsERgU4c4Jm8xq0iUq1dV14cqOT60Nzwvsy6qE/kWTdZ/cnqHOHQyC5EKoA57GCS/VSEFJZoGBaswFH6jIcefEvjjWCEiEfzERMjAqvwEBhwSzThuVsawT8xBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V7WXPV+p; arc=fail smtp.client-ip=52.101.46.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V7WXPV+p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQx+7ak4rqAMqxKwOybnAYpN7mRlLKahlfRDNy0LqO11+O6CQJaZkfA3cLK2JKTQHOWnW3cmkBeeBNU5J1sp1vCZ5/aAxq4mGbYqOeay5z0j1SL81UBpK0Zpw8vQDizBDYprmVGBQwxGhq0eWf8lJKTHqKbuDfTby14UBi6+rWLlncGHz4r8KXeLKEXAxhvKpYbVRPbSzXUSjtMMS9S1QNc9JFSB9U7Fbz1nNuW+rP5ScGCmidDMXf6dKq283s6ZBAz5hn0pukccLL7mVieXq495pCFyGnlYCt/U1xNLLqjK1OsRherdWuAsnVAtoijytyxuA41n+nrZZJo22dpcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=y2ZjxOFnHeI3CpV4hjQc4LfsABBgWnaPNFnF6DHTC6RDYvok/Xx1Y+g5a3xlD1Tyi1DlmmbadMS9HQwfgPaO7oBfw/QpN8WEAlE7bJgImKy++LhiW6IC8fl4CoXsfMUUm8m8cOpEaYhJ0TCKL/atp6Zjhwgxa0362bfnQWDK9TIEwf/xJ/Y/8MEEDZlZLZhaQeROPA9zjN1Aq+fke+3zR3AeuydsvOvOrX+wdAHsA0G1JdP3uOo5pdF6sZqsNo5yZ3dNXuKnruZf6k08nyIkYjsEsjeIu/OP31zcP6cXS2UXNio46DP9K46DA9Z/hMeUh2wrQtU1LkY965A2k/AQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=V7WXPV+pFutWxh/ohdyVQJ9At3MMPsoQRHtprj+gIuRr1M/ELO477cN4VPyKqI4WG0D65Fa24fjBf7lBp1NIjtzL7UeVcYe8F8laDe5yysVIjf+tOGBGHWLK1mcl1SY3jsu5G6S4Uh6pA7hNeGl3kik6qbX5vpWkGfSSQxjusRZsIgR7/a4RoLLYVc1kJVAssMKYkZsdl0AQ+40QPR3bDMvWEVsjPRrCr0ooN3YHcW1/1mg60MO99q1+KbcmjGj0HumEeT/TbxJBELGbdNbsy6f1j4vA2Socjt+lH5He0zKFvCJaRXvTR+BOzICm7X0E2sI5GTHWtL71lS5bwWNrCQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:15:59 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:15:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Josef Bacik
	<josef@toxicpanda.com>
Subject: Re: [PATCH v7 09/14] block/blk-iocost: Split ioc_rqos_throttle()
Thread-Topic: [PATCH v7 09/14] block/blk-iocost: Split ioc_rqos_throttle()
Thread-Index: AQHc9RXMBSXAVU1N/EyKdhK3O0qAOLYwRIsA
Date: Fri, 5 Jun 2026 18:15:59 +0000
Message-ID: <4f7d3c00-5f1d-49dd-b9d8-2b7327909b8a@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <a6d3ed953cef6669d23a80923bf46600733cbdae.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <a6d3ed953cef6669d23a80923bf46600733cbdae.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: a61dfa68-7c39-41da-297b-08dec32e7e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700021|22082099003|18002099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 arXPh1wFm6fJRUqg/cID2si49Rc2u+E/inAvStay+8WLWwxW5ZP7fsW3BiIs2gavgAq9+N63wDz0FxsH8lo9+z1boq4bJRMppwWpupQfxO89Z6gu4/f/7kDG1wfwlbIsFzFO05ZyxUy9y3qAVCyOiFn0Fw6pZU/UF6zqAwgK+cq7xzwqCj0mwxgTFMU2Vtzv4/+ROtEHpGLQ6rE114Gn4ttnPzJNN7S9SUtsjoew1GCx/8FDNqWVe0ZF+MQz9XewZesFocYnyn9YOaziCBJhmcSbJtpcSZLnmicSq2Wz8KkPZfQPJcOe1k5isSaBP2CeHH6rLOENtCZ0wZuKa5yWRUKUowIoVHl9dKPZFj2/xVRZNpJTyU6U21rY0//iR31RkRB3rHb1Nzm9mJHyGP1ofs269JHxS7ljzlhUKZn92DXlNxz7HI7j86VoSq5A3Irb9pu4uQOowf3sRMd3pUs8s8+BPoUFsDw+JkkTYaiaLt0re+iES7A+Cfc0FIPepu7oG7DmpRgZr0pi+Aqsu2xUoJmvq59c15b6Bk13vTTpma53wnHkz38gejDUMbZYifA2Ax1xp7urmGeG5Sn5vdjOCQbEmXtCd4WnSzCuKFE4pEjqDBVntdCodLS5vqKes1JqBHk7jnkZ/0T8nQN7JdHdkkq5dTHtnQnX3N5Igg0AwtBJAc8JJNa0Knyibh1h9qr6HAQD/clA9zvYSurImUuHLKYR/W24fJOIjXg/h5mRmg9gzGdZGjnhvCWkSPUKchWN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700021)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RnNIODcvR0VRZ20zQnBVclkxeVRHWGUzV2RsWHVZVGJOY05kVk5lQ01UL2xS?=
 =?utf-8?B?WGR1cFp6OEJacjRWOWU0YUJDOFByQkhMSldFVk05OUFEYzVIYkg3RlBLYVJw?=
 =?utf-8?B?QU9RSDl0djJsT3YwRGxHSk5BT1IzNnlTdmtRZjlaRDNiSjNQNXhXeXpIMmZX?=
 =?utf-8?B?YWhJeVY1Ym1UUDh0SWVPSFVHWVZkalBtbkhuaC95YUFrdnprSUxqVElHY21P?=
 =?utf-8?B?TEpXNGIzZkRlMVFuWUFGTUJJQS9SN2lwcGRrUE1UYTVVeEt4QzhIcWM4cjM0?=
 =?utf-8?B?NXdmMWFXK3RKQjNMVmZWV1JvemRpd3VZSkRocmg4MzVlbDVlS0RrR2M0b1lx?=
 =?utf-8?B?c0xqaFhWOGtaMWt1SGdwdFlVNm0rbTQrZVI0ZVp5YU45aXZCdUNDYVo1bFpk?=
 =?utf-8?B?ejJIelV6S0NaUjhQaThXbWNMa25RME5EdUV6Y0pLLzBMNE5henJ4czFyL0dV?=
 =?utf-8?B?dGk3aklUbkEyRG9MZi9uN1JCVHNQamVGcHJ0UzVVd2lZazRwTGNSaTc2ZDlK?=
 =?utf-8?B?RUt2SlYrWVZlR1hyWXJLcUN0aHVtckZjYXY1eEp3STRKTUNWUnF2SXpLKzhF?=
 =?utf-8?B?cWNnOThrMWhNbzI5OFF5UElHYngwdFB1dFBHa2ZRS3paaW1ERmsvbS9ldktW?=
 =?utf-8?B?eUlwNCsvaDVZZmlYdDhGRmxuYVlSUElXSHVOS3RraTR1S0JpZ28vNjRxRzdl?=
 =?utf-8?B?cjVJNkw1WkVNMm9DRXp1TXBIY3g4ZkhWdkE4VFdPMG5SdVZ2d2QrSFZsSStB?=
 =?utf-8?B?blExSU9zRUlwQUhOUjBzYjFpSXpxUWpDM0hLSFNzVE5LL0JiQ3k4UmhpUlVn?=
 =?utf-8?B?NFlDVW5uUE9ES29UUkgzMXd1OUNkMWtFZld5Tm11Y2V1RUFjbVpvbUtmbnhY?=
 =?utf-8?B?WUZNWXo0aHdBQnVVdWx1Ukd6MmRXd2JGUnVyRzVRcTZyRlplTHVRRnZmTExD?=
 =?utf-8?B?RjFQd28yOFJKQXgwRFU2T2ljOVFpNjNNQVRoWkE5WkhJY0ZTdkdwKzZueEVI?=
 =?utf-8?B?MWl4bDBQaFUxaTlPNjk3YTQvbDZ5RjZzOTIzY0Z4WHpENmY5Z2I4d3djUmkr?=
 =?utf-8?B?cThCYjVZaGI1ZXlTUGZBQWExYlY2c2tCeTNoNmhhVVh3QnFPSkNNdWk3eGl5?=
 =?utf-8?B?Zlc2bEg2NWhncmxtTWNTY0hEU2VCbXBxcnVkalovUVdZUXdKRHY4TU1jdzJl?=
 =?utf-8?B?QWFrY1d2YzZUcU5FNUxLRUxWRTVvN0o5Z215V0pzeUhiWk96Y1h2bGhDdG4r?=
 =?utf-8?B?dUV2dWtxYnpsV2FBb2JOZ1JWOU5lNkkrUy8yNEVEQ2RaTmNQQUpsS2MxbnEr?=
 =?utf-8?B?R1Fzcm1pbXd0clhQSmIrdllPSTBBVExKMXc2Y0Z4bnBKSmJ3VythaWtqaEtH?=
 =?utf-8?B?VkxtMHZPcGFOM1dGWVVWbFpSL2RhNkRidEtoSkpnYmsvcjNhSHpEWFdKVkFw?=
 =?utf-8?B?eWg1eGJaV1BmR0s0dUJTRzRWN2Zjc3RURDFzeGE0MW80Sm9xd3JhYk5VRXMv?=
 =?utf-8?B?dGR4Wnk5c3Q4b0tuN0tkOUxtUU5PVm4xcjNDaUdaREVmeTFkYUlEcmlBT25m?=
 =?utf-8?B?V3lrLzZ1bk1nS08xRUxrUmc2dlV5dUFVQzdvNzJJZ2E1NHJ6Wk9qQzI2Tm5w?=
 =?utf-8?B?Q1owY2hidGhHT2VDWkdWSXlWNVBVRzhWdm1IK1lYV3ByTkVNUTZ4R1lXL29s?=
 =?utf-8?B?Sm5ack5CZnkrWG1sSjdQVmZ4TGJSbjNaWms1UXVYWG5Mam5aaGxGWEduTnk3?=
 =?utf-8?B?Nk9lajRIcFpIZmFLMHhTZDVzQVZJMlN2YVRsUUhhWlBUNmlGOE8yTkRGSys2?=
 =?utf-8?B?SThPc01ISnZDSFNnSEJ0V3ZobTRPeWp1UmxQOUFqVS9RamlpdmE2US81WWJQ?=
 =?utf-8?B?VWd4RVk2T0R0VDJ0eE1OYWRnODQ5dlRyTzFsdUMvdkRiY0FPVXI5V2l1SEtH?=
 =?utf-8?B?c0FydlIzRFp1MXl3NmlvSnVNczE0cjZFTWJTTWdOREZtWXQ2ZHdtSXYxQVVp?=
 =?utf-8?B?d2JKUW1EZ3lKYmRRWGRVRzlLMzZ5VFZCY2NFb2poRkU1QVpGYVRwT3puVnFi?=
 =?utf-8?B?WjArOG5NazVlcFBuQnJWL054TngraSt4anUwRUFDbG83RUNNVE85MW5PcEQw?=
 =?utf-8?B?SWtseTVQRUJRelNJWG42QThsVGxrYXBCeDFRRmRaNkdvaFlHdlo2YVZyT0N0?=
 =?utf-8?B?YjBPYXNLUWpoSzI5QVBjem51OHkrL1hXSzlkYzdDcEZ1emtnbnpNQVhlTFh2?=
 =?utf-8?B?ZENGcmtyemlOWnJuNFVKeVBUMzgvek9uTlh1S0s0bWQyNStGaVF3T3BkVTRH?=
 =?utf-8?B?Y2I3ZlRiMTNpVmRWOXROcHpyK0xXK2ZwVjRuMGxnZHFPdWhqeXV4M0hjMDlP?=
 =?utf-8?Q?al57itJs72YjfPHn8GBawd+4dl/8fmzsq+SDdofBHNSqB?=
x-ms-exchange-antispam-messagedata-1: WXDVtZuXv4BfYA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E2E8C1731CD5A4BAF13754FD087044A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a61dfa68-7c39-41da-297b-08dec32e7e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:15:59.1432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +pDJ93fLypoopnw99pACpCmdzt1dtum4Wppv3eENFAJqdOWQ/8SNVCqj3igfkynTlUK2hO0XvY3+UPHPKBv9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
