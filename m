Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012071.outbound.protection.outlook.com [52.101.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622BB1A683A
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683263; cv=fail; b=OlVXIiaGWaIqAPFYvPiNR43PEm8xoYB9P1N4yv0V+6qSm74H3xSEFrrrcMX67EvJNaaWhFnnxZ3POVD2uW9Qce9Z89mxWNSApGukB1iM5243ocbEYBEMYTmEBd9euIh3pac+rtokhP6t+bFU3kaa5PB8cBD/U07RnRsYgjPTZdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683263; c=relaxed/simple;
	bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uivv3RD/xO9wwUPb1r2Obe1J99cNFBX1oKhw/8oj6PRcBDgH3Jlua/d+UlSkzNVhpdvMyV9gFcQQQ3sFw7lj7rmk94r49OSOTaKYxjb53tlT0iOqvDjDOm1/K/btKTjX5t8u52hDRFXgPbz6ptokDtDhNNA99xiv9DcZbp2iDUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QIMgYYWb; arc=fail smtp.client-ip=52.101.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QIMgYYWb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUqgunDc7mMltutLIp+kS9xJ3igOdk/JXOoVvzOwHI8UZ5pk8SX19y/dX7YC2WRckbbN3cKp6NWXgETVP0yvPTE0CXeZvyYO+4Lci2p/GrNrbZ90EIMFwub0LJWwAjn/eDbwI4prK/Wgq6LMdoqyAmvibhrrTh+jxS9M9hfg8idZg0zMXqYBLhKN+MNTU5l4UwPgP1Wb2Skr0CbMNSnCbRDVmxhvGHNOansZlk6PL94gT2ckR9UiIy687O+q7dtNfCBX1wfelp9mFNjzsgk14U1asMbkgCfoa6NL9v5SJLzYwxaKRX8QKQ7kjugIGt96m+8Y6muVd/Sh1s+NZ4Ow9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
 b=KeRDT2y1jvWYnoqlXddKyCjMVZVuMrJTv6MLOhiXc8vAf0YFmoj/oraPSM0y05URzIi7TocmZIwN64zEoImwAqGl1tIUFSc0nKa9rgVQ+CcyDzgGgDKbx5/O6t6teniAqsSKrXIXGKQGrWDq3HlVqvHyIRAYnJvFbzG/Op1a6+U7TW9ISbGdYYyGc4FhJKFPadYQk/EKtTRSIwDlgQYLv0ZkUGmqCo1rYtexST+SrVuErBHvGPDbxGk+z8jwt7qbcqupegdKvfZ+Wxuk7b71YJSKIq80TAb+L0EdYM1qQkm9eer+mKdjvPw/YoP049Y+wwVz9VgtXtT364S0FdTJoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODyW3putWk7AtPxENjGHQHLXc7iTGEUQzPA5s2ANr5A=;
 b=QIMgYYWbwUbIcAKqzz4UA45sd70FPqELbhvfGSRBT+PQ4N3HKwOwikieX+wiu8xm+x1KZqHdAuN3BCsguooTnak0U1kRywpBOnvftwSeOdeTxjHABRIcdM2uL683qDTW/rIO2+H6JH0kW09o8IMEZzJHpQmnU8Vp4t+44buyKdYcwz08Em9HCbTErFoxI7qa1l3jq919C6cVA8TRRohkrykdjlYTER5S9DrT1no34RfYwawLhPDC7k0g5JxtSGAdI5XSgnpIcRbASYLhj4JH6fmP056/vEC46XGDufyLI1dJwoHyS2G9kuFX97PJ6hDbgjOpGVebwyaeXMjH30k+pA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB7935.namprd12.prod.outlook.com (2603:10b6:806:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:14:18 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:14:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Tejun Heo <tj@kernel.org>, Yu Kuai <yukuai@fygo.io>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v7 03/14] block/cgroup: Split blkg_conf_prep()
Thread-Topic: [PATCH v7 03/14] block/cgroup: Split blkg_conf_prep()
Thread-Index: AQHc9RVlDNlqVieQoEuDwvS0ln/i/LYwRBIA
Date: Fri, 5 Jun 2026 18:14:16 +0000
Message-ID: <0bf47fca-f592-4c90-ac21-cad3ad2dd75e@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <e6ea0387f413217c8561a0ca54ce7b846aa5c7c5.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <e6ea0387f413217c8561a0ca54ce7b846aa5c7c5.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB7935:EE_
x-ms-office365-filtering-correlation-id: a3bad941-b9dc-4628-d5e4-08dec32e416c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|38070700021|18002099003|22082099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 sFfPGoiQXQtFYoclK4uiMHQ74W91Ex5ZHjf7gq7RI/cgjt0GBk1e5Rp8roy+przNTLTQ6Y5AdVjPp2o7NiGSW1pVqmRldXSsTcZ8QV3dLNrHWkEo7UCQTILrKlHBAtaHuyChUn2MkDoNQGepoIpcElVT7Ztt7Ic48VCwf8DmtxvNMA3tlK8VXpluBDnfsRsusFXXB92bj464VWdNCF3tgUhMwoU/hjDkGVP/6v+mFva2Fioy2U5t8WIIW3aJkykd6sq/BL88J/yUybVDD4zMrwI7l+S5Sz5aAnjZiMHp/UlhO9nq+SanfNbc/YatZD+jUtmJynZO3hmFk8sknBJRddqFw/euiaBfhLHuftvOU6DPH988+aA/yoScJK8Dfh7zFMlMESnJ22pgQqA3JT7s+aT9jmEEx1DJ6s5MFNojy7QRaOdNcdfJLKB6bf4eR4OHdaUDCX35nB1fDoX8HLLjDGGvstyWDhAZPgWU/S1HYSB8i8c2y55Rvrvru2Q8i4JI9V73iHE96zl1w7E2dzOTRxZ8TM0Fj+KADmYTvFQqQR7RnH12t3XOgBFILllV8F7JBGHaW4CeMEavSNtakO9SjVSriy9TxJaGiDCjPt+TV+pZpTfjQxhGhloG2mhwHBQ+j6G/Iqdksn5HsxlQMT+0wTTEXiTpr1JG1Ez3R2R+e6SaiowdXrNnEDfaaudlTjKbbv6mCO/z9gPfiwWcZLMQssnZ9OtixLVh4yiVQqiVL8FpRYAhjawO0ZICAwks/9Mn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(38070700021)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjBUTkNXcGQ3Rk5pRTlvMjRVNVRSb3p1K0RmR2NVNExVbDU1WXJBeXZzZmk4?=
 =?utf-8?B?YndIV3FnM0tCclFuQlZCcXEyU29EUUVQbjZaN212L1JNaVdSR2d2eU1uOG5B?=
 =?utf-8?B?MElWbDNvMGFJbWN4NUttWkpIdnQ0Ukg3My92NjV4eFJXbFFac09xR05nZTAx?=
 =?utf-8?B?SURxL3I2TkFvSFJxWHFDSFhzMy8rRmluMHJadDdPcGZQZ3ZVUGNDUFF0NTN0?=
 =?utf-8?B?RVlSTGhGU0pPZFZTSEI4c1FMWXNqamFtcExYdlA5RTZDSGVBR0xjWjZLWFp3?=
 =?utf-8?B?NjE5QzR0VTlHQjNlRE03T1NOQXJVTFdGblpUVzJBK09KaVJPb1JDaUxpTWFQ?=
 =?utf-8?B?eEJTSzEzeW5XWVhLa3N0WGY4QWNlYXh4UEtRWWRHSm5RV25kYmMzVE5LOEFs?=
 =?utf-8?B?TFJmYlBGZE9vWVZWOUpDamZVVlZCUWk0WUZlcXJmU25jbUJTaXFzTFdmbk9w?=
 =?utf-8?B?UUN3MjJvSU50RkExbmRrSExQZmZmQ1hmK3g5ZmFmWGw4V3Q2OStyRitIYWcz?=
 =?utf-8?B?Y2xJNEoyNlpiakY3VEFpR0phTktjV2gwbnlFNkxQWndTY00yTG1YUUNGa2hj?=
 =?utf-8?B?MTVJMTMzd3Fad1VtV29kMHdLTG9kaVdXenNYSUJuL1FQL1NiMkxVZkhKVmp5?=
 =?utf-8?B?MnhrWTViVHl3SC9hVGUzMGRreGFFeTJlQWtkL0FiWEphaTlWaEhhbDFHU0p4?=
 =?utf-8?B?MmYxZFdVQ2ZpbGNTeWRVYWJWK1FLallBamJRNVFER0Q1V0dJMm5vblFNbGNs?=
 =?utf-8?B?VkJTYXB6TmJBRlE2RTZISE5xTnc0NzZiY09wWnBoaUx1ZURGMzdkN3JaUXQ2?=
 =?utf-8?B?MWF6Z29DSmcvYzVZOG1OcDJvbFplcnR2TklpM2xhem1BYXowUC92b2k4c2Vv?=
 =?utf-8?B?QjZRUFprQkVMMk1nN2k5QXpTaGtyalRHd0NuOUV0Ym5sb2JFYStQS0JCYXZh?=
 =?utf-8?B?UzllbkpJbW4yWERrMkFXZ0Z4WDFWQi92VnNmUE5GMjg2WDlXZkFQSk5uZzJk?=
 =?utf-8?B?b1RuSTl2SFIyc2hpdXU4OUFaT1hUTXRjMitVdlh0U09obUcxRmV3ZDBsOFhU?=
 =?utf-8?B?WU1MNjlqWlNLNDdnejdySTU0Q0hvcnFkYi85S1NiVzZxYXNDTERBZFNJR1Jt?=
 =?utf-8?B?U1NLY1JFcHpseWdraDVma0JIK0I4V0NPV0RSZU1uSnV1c1cyVW84ZVVKV25o?=
 =?utf-8?B?K21WNUlPdVN3azhVbXg4SHJJc2hUMTVHNFU2a1NaYXo0NkFxSnE0MGhZOXpY?=
 =?utf-8?B?UmY1bHh2ZzZQSXlTZHhUV0M1TGFJZkIvVGZzVzlpdWJIRXIzQmFHb2MzcHp0?=
 =?utf-8?B?djFhNjIyRDVsMGxETituWlZyOVN6cVFmU3MvRWJ2REZoQUdEWnlWUDVmSTJu?=
 =?utf-8?B?ckVCYUN5WkdwT3czV09EV2MrOUpRNVBXWkFSYkx6SFZXTjFxdUdCTWF2UFN5?=
 =?utf-8?B?OUgvZVdJMjRaRlVKbjdNUll0SC9UTGExSmZySDhsRGI1bFBMNEdqMElMYnow?=
 =?utf-8?B?cTI5NUZ4aXVEZ0FqRHJnaTlONVo4VVBHdC9hWi9FUXd0bExzTXNqWm56MVN1?=
 =?utf-8?B?dytXV3R0QVRQdkdycGZPN0lPZi94c056S1QwbU4xTk9WMmJMSGtpN1phMWZ6?=
 =?utf-8?B?K1llRTFITFRHUVViS3IycllUVkl3ZjhlN1BNN1ozbkZWZ2Q0SFdRZHJCSUpl?=
 =?utf-8?B?NnlIblA1cWpKU3hNSm5teEJGMjJYTktqV2NVZk8zci90VjVFVHA3cEJsa2RD?=
 =?utf-8?B?SEowcDVuZ1hzekphOHZ1amxtSnNReGJ3UllqRGpXd3kvTlo4ajNYVS9hSmEz?=
 =?utf-8?B?bmM0UElzNmVUZVJFQlVXaUJucHRjZ09za1BnSUF5R2MyTXcyU2JjeURxbzA0?=
 =?utf-8?B?b1BlRGt3ZE5xaFRseFdxcEdQRXc2QUxjQ1VZK1hDVk1vc3lTNnluWnhaVmdu?=
 =?utf-8?B?WVBab1hLcThGbXpkTlpOaG8ra1Z4clRHTXQ1TTZIbEZHc2huR2liZjZyMHgv?=
 =?utf-8?B?TFNHYjVUZndyam5GTy9Fa1IvbUI2cHErb3MycUNmMDZwUGJoQ3FsSnQ0YUZi?=
 =?utf-8?B?dkpRMktMWS8yYVc1YUJwc09jUlJVYWhQMVhxSUJLb29Wa2Fhc1JCOC9LQ1ll?=
 =?utf-8?B?WDUxb2lFUWhZcGozc2VXOExZdW5SVlVLWldHeWFBYk1IdGphSzkxZ1EyUk51?=
 =?utf-8?B?SUhHbUFhOVowOEZzZlJXOWwzdXNhTk11Mnk5ZG9HSTc1ZGE2eHVDZXdjNUdh?=
 =?utf-8?B?UXJIUFVFdlhVN0dkcExTOU5GKzRNTGdzcnZ3N1A4L2JOM1JCWjVDOFM5Zzlx?=
 =?utf-8?B?U2J6U2FFYkVhcHlLc1E0S3dteTlCcXMva2lwNDIzTEowa1JRWTRmR2J5K1Rk?=
 =?utf-8?Q?1LgdRUhyEo19USoxkppcTWOuupW90YkfRTpnj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <286F87DA95B8F24A89F66049D646D013@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a3bad941-b9dc-4628-d5e4-08dec32e416c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:14:16.6104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mm8cINcP63Dprdc/Yy5nxwgtG1PsuHr/s/9ckKSt6wbZ/Zpi1eLOYUqv2VezFLWtHFpX6NthT/p4GEkblb5UmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7935

TG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==
