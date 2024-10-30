Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37581CCEC8
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730313166; cv=fail; b=e3XWaF+F/xWw1M3ACROevJqMqiv/wN08VHxsQhG8LfmzHqgmbGuCHAycsC9ZDI2VvEqFm4qdE1MoPdn3TyRZDOF+dVwiRTD42HRP0Y4VjWprduAysJwjlLPHeapYlyoapSNA+vx2HQFjntAuBtrAw3FVOf31tbw00tNk/BysrEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730313166; c=relaxed/simple;
	bh=fd3UUb53J2FOOhsbnKRHMB9bFpBpU/xEXECFxS0BRTk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YEbFlJmwKL/YFGmIO7EZOl1K6+ILRXZ4x5UzAerYAX2VhLNGI9Wpy0u4MRAj4Fd68j3mbd6s2tt7E8zoXMsGwkNaL7BGi1Q7SF/oDjRhq4AXqaiP/Q8OY5fx5QM9nVpuezLHZExeC1ukii6KE5MHk5f/a9ZgxgrcgE4c9j+XQ7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dtnXluR1; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dtnXluR1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yeZJqhv3eLffLcs9SSKPHdu1zbw+R+TtsvatIO6zPX59TQiL65R7jpSWyXkC87eqTM38p5tlpwT3/YDKZ0WoX47dzs4y/xKf0Hqt9Y1hP0Ito8At9ppVBiyNXTcBK4ftJm3dnPshZTqcazdvNKiaIOr7R0HbqGKullcbYLpIktyjL0SYd4KMYFK+JzwHA4LZRX22iuCHWxV3yXZF7dhbMkomjHV5rm41axEJp7fan4svtrD4upPlAZgjurQiUWrzV1K7R3v6zmcMbvbJIMaU7qxN60tzQI3KjGBUoC/0FRY9ZYQ8TIvp4ugciX9wlTKk9OalzqiqOAjlGI9J0Tfqgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fd3UUb53J2FOOhsbnKRHMB9bFpBpU/xEXECFxS0BRTk=;
 b=jx/cIMi3pJGbRciaopqo+bFltw8tDIo4icrOUUcLJowQgCSm63bhoyl6z/wR/X2zzVEOPEZ+8WF9AIwRr+vR+I1jHoQ35mIOdw9BwvWwZKhwStRGgs+27W+rzopbKq2fo7Pg2/D+XvyZKJsrYKY14gBBDaj4V+bMKoCX1xWisH/IZZJPwNfYUJdYiAMgu9/lYdVavgh3qzgWimTbAk7QNtxfpJbzFONgXVCep6Q7gTrAeV+RhvCG1wEc+mdAOJeBKHKDoe5aFp8RBDos35S5RJLLk9GQUa/Eb45HVVk1XwlVo+QTH8/IG/V5luKPoYfYSy6VwwFIROjgPKhu4ztjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd3UUb53J2FOOhsbnKRHMB9bFpBpU/xEXECFxS0BRTk=;
 b=dtnXluR1TWAnW3LW7k3r0GnupPW4zOL60B4VZ6AflGr9QR/Cptd6/RfeLZNUiJSEgtuPPibybhUcXs6BEk9+d7Sf67rcgPYZS6r4iSX0N0WP9qPEJEOlCnQHuhh28aJeUEUIxulQadhopj5Nx4Ut1hBly0RtIgpB75gMDN8v9lvN+PFaYOf0xsMQebcRMPmGwi2IsP5vRyszjG1DnraHkudY+vNMJeqkiDPf9VKq+JeERs3CyB53Tph8JRVkbSd4rol/cT3LFfRErEk9dW7DNCm9ySaVxD+KYdJGWl4/DT2gtqSViBKE5X5xWrBReP0VI5aGw4Q4Jcmm0I+zy8Z9aw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB7127.namprd12.prod.outlook.com (2603:10b6:806:29e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Wed, 30 Oct
 2024 18:32:40 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:32:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Kundan Kumar
	<kundan.kumar@samsung.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: remove zone append special casing from the
 direct I/O path
Thread-Topic: [PATCH 1/2] block: remove zone append special casing from the
 direct I/O path
Thread-Index: AQHbKos/iH1pcEyMAkK4K1m6kSDQVrKfnx0A
Date: Wed, 30 Oct 2024 18:32:40 +0000
Message-ID: <8ad0f4e6-c232-4d88-adbd-894facd24089@nvidia.com>
References: <20241030051859.280923-1-hch@lst.de>
 <20241030051859.280923-2-hch@lst.de>
In-Reply-To: <20241030051859.280923-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB7127:EE_
x-ms-office365-filtering-correlation-id: a8626e68-8908-4e5a-1e61-08dcf9113ca1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlFKOUhEK3AxS290c2x2NUJSTWl4T1lLRkVWUm1PK0xDR0QwSVFyblN5b1VH?=
 =?utf-8?B?TEJKVlJjempnWkQ5TDVOVlk1cnkzY1ZhRENCT3RDNjB0L2lCY2FWMUdFT3hU?=
 =?utf-8?B?dUkwODhPenhtTHJoT3dVUjduT1ZVdExGUG1yRStVMU56alIvc2tYR0I3WVJa?=
 =?utf-8?B?d0d3S0VwcXBXQytSZ21yT1ZJb2dmZ1ByUnlXcEVVV0NvL05nK0kzVUtJWXV3?=
 =?utf-8?B?eGJobndaSGVzVGFoR3JjSlc2cC9TZjQ3ZmJTSCtVaXJmLzFQaFl3bXRmTTlz?=
 =?utf-8?B?Y1o0VE1mM09YZ1FPQ0ZaYjgrVHhWeGR0Z2JMOHFtT2tzZlo5MVhZcys0SklJ?=
 =?utf-8?B?WTJsNnhYcHFYOVcxdFJJM0VRL1E5RFhFNE14WlI5ZFkvOHRIUWRheW56RktX?=
 =?utf-8?B?SmVuQ09EZUsrcnNlalErdVZIVjFnTEVSMzVRcDdTVXRRTEZHVmZlVk91eGUz?=
 =?utf-8?B?Nm9Zb2JCNFdaRmhiZ2dDdmpGMVM4eW9KUmJTaUk2UlhTMWFySkdUYzB2aDl2?=
 =?utf-8?B?S2dIMXd2UmhYZERLL2I4a1BUZGFWc1ZaWWFmV0JZUUxBa3FGa1pwL0RBQVRY?=
 =?utf-8?B?WWFxSThFTkZ6UC9yWElnOGgzZFNtdTBrVnBHOHBQRytWWUpyby9OZVJ5enAw?=
 =?utf-8?B?VUhmeHM2MTBuVzl4US9LclZzZjBZWHRGaE8wV1AyUWhoREZjWjNiRFMyYjZy?=
 =?utf-8?B?bXBoNm1qaTVMcjJIam9IdU0ybEdIdVRSNStjdWFMZXBrVjlnbk1NR0ZRSDRr?=
 =?utf-8?B?QzhYN0Z6ZFo0YmIyT29WUWo1YzczNUxmVWR1dlhoYkx6NXIyZGFzZVlqQm9S?=
 =?utf-8?B?VFZvNFNKZ2hsaVR6WXpnbzhsTHIwRHFxc25Ud3ZEdDhXSVQxSlQ5TEpteURC?=
 =?utf-8?B?Mm1ZTW1UL1hMUkoxcW1wT1NxNUlnK09IOS9tV29XdFg3RmdTNnYyMEpUdEh2?=
 =?utf-8?B?U1NUZmZCVmFMRGpDdnJrVk1ScXUyNDdxbG1QSlJNdWhLa1hGMnNvTVd4UmFG?=
 =?utf-8?B?NmFsc3Z1cGlLN0Q5SStlemdiZ0Y4dzBxY1dodDk3THVKWWhYeE5DaXg2ZDgr?=
 =?utf-8?B?VlFZUlFnUUswcjBpNjFZQWFNN3pEMk92cTk2dm1LRlluaS8wMXQxRHBIZk93?=
 =?utf-8?B?UHNza0pDNko1N0k5dFZwZkM3cE5ET1VCb2MzellkVndWQk5QbTI0eWFRYWhs?=
 =?utf-8?B?bFlTRjlRZXlVc2taY3h1L0NaQ2VoNGtwSVRzckMyNU9LTTBiYVhBM0FBcUtG?=
 =?utf-8?B?UHZmYSt4ZldlVyt0TDdJQTY3RldicmlSYXdaUUc5eGZVZUlpV1d3MVFERWM1?=
 =?utf-8?B?enkrQ3llc2c1eFpRRlQ4WE02dmsvamd1Rnd6Tlk2WWZoSTFDQXRacTJQdm1m?=
 =?utf-8?B?UGp5TkxqSUFxR3pNUTdPcWRKUE1wVmFXamRRQTlFcURJR2N4aHpieldCS3E2?=
 =?utf-8?B?U2dGUE9zRkNPVlZ6V3RtODRTSTF1bzdNZ2JSRFhuTEh6b0JrQTZaMnVlUDg4?=
 =?utf-8?B?VzVKRnRCbTFCRVdXSU9aa3NEYTJNbnVQa0tDeGgzdHd2VVc1VDJwU3FMQ0pi?=
 =?utf-8?B?VHRtTWg2Rk44QjNnTnV0OWNIYzJMVTJ0Zjc2bUlBcUMrSm1va1NmN3RmQnVP?=
 =?utf-8?B?M1QzdytUNkUzY1c1R0hsMkJDcHVwa0x0a1Z5ZVlxWVoyTm5Xdi9CdXhpTVc2?=
 =?utf-8?B?Yzh4VGYwc2hrMklsblpqY0ZFUTZPYjY3ckplNmdjbTN5eU9iNDhFQzA0NDVO?=
 =?utf-8?B?NXh4eHRweWxrd3dkOHJmYjFWTzZVOEJCOUh3R0UwUE9XSmtqRjhGZHZ4UkhV?=
 =?utf-8?Q?IhDPrwJUm+tUWKGRQyVBJhJecssS/u5OsVUtQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm52aTBtQ280Z25WZGlublluMC9mZ1BRcEo2THloeFpGS1R6U0pYZ2xFY2hV?=
 =?utf-8?B?L05Gb2xmQmZsL0pCT25jNlRyZ3h3KzJEaTBIVFcyVFNhNW1iTGZ5RlpvWGJL?=
 =?utf-8?B?VFhZWFZBR1RQd2dFY2lRQlk5NC9CYVVqS0RrVS9xTk4vZzRwVm5nTFprV2E2?=
 =?utf-8?B?YlM5dlNLeUNwa2RITzRBOUx4T24vR1kzWWVVYkpQU3VFVW1Yblk3TE1DWjRQ?=
 =?utf-8?B?WTd6TnlqM2FVYUtybFhBUVJmRXVXcVFRbXY0N21Od1J3SS9idWthbFR3OWxL?=
 =?utf-8?B?T1BLQ0hMdzNhTU51U3lJSVQ3Rk1CNmx5Q24zcHJwUUNCVEpVTmkrWDRIUzda?=
 =?utf-8?B?REJCR25BTjhJeitHNUpWOEc2WFBuaVptY1FrdUpsSmVGRzZJejRJclhtWmcz?=
 =?utf-8?B?UGFPK2xpYlpVVW9ETDFGNVFWWWp5R0hLZ1pyOWhIOWZKc0dadmw0VXJpUlI1?=
 =?utf-8?B?K0ZMYzZDajZXcm13TjhlaWp3M0l1NVdpS2xwN1BsRStVTW9Fc0p6Y3htZXpW?=
 =?utf-8?B?RlBOQ3o2U2RyUW1Sd1pjdlFUc3FKNVExT2hhVVZsRmJyN1BRZm5icnJqRW4v?=
 =?utf-8?B?cEpqa09EbC9OWldSOThJWllodUhnTnlVWlJadHZ0eEVQSEVCV1dYcTBrVmJE?=
 =?utf-8?B?SFI3WEF2WnA4bnVnOU96TzUrREFPRG04c201eVJXRWVpU2cyRzh4eElqWVgz?=
 =?utf-8?B?KzQ2SEpSTHA2c09GUU16MG5DWDI1ck1FcXFLdTZxTnFteURsbzhza2dGbGNO?=
 =?utf-8?B?WnZPWVpPbzIrYWYxY3l5dklRTzh4Ty9HdmJqaG9ReXhoTy9QZEgzMDJWdkpR?=
 =?utf-8?B?NWt2T0F2WW1OVFdkc2k5WjNkN1BUQ2F5akNTZC9XMXZEVlF6U0J6SmpaeERK?=
 =?utf-8?B?bEkxOFpuemhYQ2FiUmsrM3AvMzhFZnRBcitGYVB0R0RhU25hR3RwejBSUUxY?=
 =?utf-8?B?MWNTQVFId3RIb2xmUW1rL3lrMFVHOHRHV2VxRy9uMWJmelpWODBTNGpaRUo2?=
 =?utf-8?B?MkZGZ2tYQk9MOUtXakdTVTlpMEF6WEhDQk1kaHNtWjduOHJBbG5YMmV4Uy9a?=
 =?utf-8?B?MlJCZjFYQ29JWXluTXRvalhqOXBFSXIwNFozbmdDUmtSRW5lUGdKYTFrczZX?=
 =?utf-8?B?eldRdUtoclJBNUR4cHFENVluaU1iYXlwNE1zM0lRZ1l1Zm1vbHZLR1VVdGhI?=
 =?utf-8?B?b24xMjhtd3RGQmFrV3JtMm1qL2ZXOGVUMjl0bkZJYzRWVnRZVGQ1ZFdxNTl6?=
 =?utf-8?B?ZkYxOEZFeWIwMExvVUt0V3NBaEh0KzhiSC92RUduMy92OTArYUM1OHNqTldz?=
 =?utf-8?B?NE8za2tNTUZCak8rSjVZcFdVOEVEVVpDbG1DMVFsOWxrUEM5bmVrZnY2YkJq?=
 =?utf-8?B?ckx6L1Y0endvUnN1ZFJEOFg4YVhJd1BrdkJqTUJPd0g4VUpIc2o3Z2tvOWs3?=
 =?utf-8?B?ZitKTWxFbUxvRWVDdEJ4TjI0bkg1R214UDh2c3ZPTWEwdW1oSVVHK1lmNndr?=
 =?utf-8?B?Z2hWS2R6bzBZTEFycjVlekM0Y1NuZTZXV1dyNUZYS2FvMklkb1Z1RGZ4NkZJ?=
 =?utf-8?B?OXBjMWg0UHMxYmx6S0JWeHZxQWZXdTEyNFp0bWdLOUIyZVJFbkJWbS8xblZm?=
 =?utf-8?B?QjJTbjZZV29FMFNKaWN3a0s0OTJLWnhzT0xOc0VkSnFXSENpVjJJLzdiUG9O?=
 =?utf-8?B?OEZ0dnExNk84cHRuSHhCSGxsRGJZNi8zL3Q1ZFFRTmV4T2swMEluc1Q5N1Rz?=
 =?utf-8?B?UEg2SWptMk1SRmVvdXZRNVVJYjVXc0xpSHRGamlZMysvUWVEN2FGZGttODAv?=
 =?utf-8?B?ZjRWUXoxQStKb0UzK1JoMWlSdW5SYkx4cXg3SzJUQWZHSlFlRlN2andYSlhB?=
 =?utf-8?B?NXFvdzN0UHIvQ0JTaXhkUnE0a1J2SnI3VHpLWmp1UXNvNkRObG4yekNUdjVI?=
 =?utf-8?B?TDR2Umx1NVRzZlhFeEgydkJuaWxnS1gyUUk5NDQ1U3ZjTTNQUGV2aTFvL0pq?=
 =?utf-8?B?MEtPU2NKWkc2ZmZnQkludmRCcWRVQnhZMkNZOXUzSGpyTlNxMm14aDNnWExM?=
 =?utf-8?B?UGlyclM3NVBNS1FEMW5GM2JUcG1IWTBPQ1BzV1AzR2JYUDBjRlYrRU15RjBD?=
 =?utf-8?Q?WvAKqo8WhToX6TSq/ynuXPZ/3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <128C87FB6BF5344AB52822B614801A11@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a8626e68-8908-4e5a-1e61-08dcf9113ca1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 18:32:40.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +T1ttphY2pwQl4QZkImn+ku5zVMir3hDeDaIvQXmbt5pQlROPFZEaX23NSSHLXsY4c8/ZBXFzRfMXZJnSsFsMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7127

T24gMTAvMjkvMjQgMjI6MTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGlzIGNvZGUg
aXMgdW51c2VkLCBhbmQgYWxsIGZ1dHVyZSB6b25lZCBmaWxlIHN5c3RlbXMgc2hvdWxkIGZvbGxv
dw0KPiB0aGUgYnRyZnMgbGVhZCBvZiBzcGxpdHRpbmcgdGhlIGJpb3MgdGhlbXNlbHZlcyB0byB0
aGUgem9uZWQgbGltaXRzDQo+IGluIHRoZSBJL08gc3VibWlzc2lvbiBoYW5kbGVyLCBiZWNhdXNl
IGlmIHRoZXkgZGlkbid0IHRoZXkgd291bGQgYmUNCj4gaGl0IGJ5IGNvbW1pdCBlZDk4MzJiYzA4
ZGIgKCJibG9jazogaW50cm9kdWNlIGZvbGlvIGF3YXJlbmVzcyBhbmQgYWRkDQo+IGEgYmlnZ2Vy
IHNpemUgZnJvbSBmb2xpbyIpIGJyZWFraW5nIHRoaXMgY29kZSB3aGVuIHRoZSB6b25lIGFwcGVu
ZA0KPiBsaW1pdCAodGhhdCBpcyB1c3VhbGx5IHRoZSBtYXhfaHdfc2VjdG9ycyBsaW1pdCkgaXMg
c21hbGxlciB0aGFuIHRoZQ0KPiBsYXJnZXN0IHBvc3NpYmxlIGZvbGlvIHNpemUuDQo+DQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQoNCkxvb2tzIGdvb2Qu
DQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQot
Y2sNCg0KDQo=
