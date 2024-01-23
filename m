Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4E14F20E
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 22:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706048373; cv=fail; b=Zqs43MA8q+DLENb/9YZ0CvoeXIcNyXBtzj9rPlb0jh71LQhBfhsdMwgegfh5YJwU8xsEPMySU5NAJ9GQAa8irviOQk19sXmDsagnePSZZpZBbmTgUvkHHnivH0u3PchtIRCw3zHXKmHpLy2/sazevm8GP/d+tp1/67p7Sgm3Al4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706048373; c=relaxed/simple;
	bh=tuBfOq9tfUIyYyBTq7kf9Y1FKoHxe5gA3fSQae2hbEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OABpz0oKVjVJJZAqBIkNWGm32lxis1L9VjWgEfDKqhiyyi5qgURcTiSrWLSRAg8hlTzGZ3W+mcNvHt+0zt35Vf7CKKtEPfhKRh+lRC4VuUiSdE/HQ+MCK+cclTDnUZ4cuVV239aYMMMLSvDdsWBTxWWGYO83QTLBanITiZLjk3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WcXTDXuD; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WcXTDXuD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoKHK4WWuKWz551ultGb48FZTcUL0klH3kKt2mDDpayTp6ojJfLszMC3orWsA5/KBnaF8zeT5bQdIqw1n8gQbdLPn/BjgJuPLaVR+KxvGhJt2mVL+oodk3kRF/XRxOf8/FuFpreT5nlx5ZhPVmR0hLYtOBTDRKF7TS0bNj4c6JMLQGVwPoTGoiAiZWWcapcgO1EpwAo8jQXYJ6m9R0gO/ktD5DF8ymJVeRSDo85v4gzktdyVTEh9U0kJGRVNyhM+XFSNv1Rtc6WP2CXtfCIBYuFJdJmBzNKmakJe/WIMDrzjAqoIwNNMEYRQjjwlMZKwoDhbkZubjfGmtrZb1JbZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuBfOq9tfUIyYyBTq7kf9Y1FKoHxe5gA3fSQae2hbEY=;
 b=cYk6ujnfTimjXaF+V8weKzprFxsYjuq10hZEilhipCqFC3hmVzos6Zbk8sciIIR040ZQ+ifiMBrzOQw6SDytoZy8z+BNq8/eU5KM+ZNdFKKFRyseZKfFpeQhDUI9vDLw8hLIsdLz+ZND+cIFlEUGTiGqAIUFqacdrEQVKnx8OF+/KrsKwjQ35moUo9XaC72R7yehz6bjsX+Ivgf5GBaMZ2+V6tBeW0Vy9PbuG2rZEGIzP9nA0bCkr8siMgJDJN+gQzcXQaCyZpot5b0XcXdQIBi8Hw0z3kKiMxFtJdWvDeQ7sd8604hYw8MPKa17urIgNm7AQujUeoTNXbHWiA4h9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuBfOq9tfUIyYyBTq7kf9Y1FKoHxe5gA3fSQae2hbEY=;
 b=WcXTDXuDt+3BMfZUlnibfO81MhFS225gOFTAd2CkdO9u4w6HcJ/kF2IOertMQI4O23bJ52TEJzjXF8sUuvfDO09fMJUrHxKOnnvvpJglSA+s2VOEcFrwZbpMX7RTP8K79Fv2xw1aGu5/dMnaz9oA2ycfEtV/twXUb3wgVUZijx7s4v2aaQQjyEd/Q2zIdlBf7zxE40R4j+nXpeobKpDOIRUDbMXBrCaj5hFC3ND/9zq7Jgbtfv/bB68dR7OCAD7pBigJUA3x+Z9qw3ySV9/5z6lMSwSmc6ecV7991gsuXI/xvfBr2yZWcfOclCqM8HW37sPT8Jnz9dGJSyby7JDzHA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW3PR12MB4522.namprd12.prod.outlook.com (2603:10b6:303:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 22:19:28 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.022; Tue, 23 Jan 2024
 22:19:28 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "kbusch@kernel.org" <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: nvme-pci timeout issue
Thread-Topic: nvme-pci timeout issue
Thread-Index: AQHaREHaRBoa88hWsUeOod3A/KGxjbDoC/EA
Date: Tue, 23 Jan 2024 22:19:28 +0000
Message-ID: <094bf7ce-b5da-4325-93ab-fef6b76671a6@nvidia.com>
References: <287b9ed9-6eb3-46d0-a6f0-a9d283245b90@nvidia.com>
In-Reply-To: <287b9ed9-6eb3-46d0-a6f0-a9d283245b90@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW3PR12MB4522:EE_
x-ms-office365-filtering-correlation-id: 8c0fad29-25cd-4962-0b55-08dc1c615d58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 eNav4wSHqbbehl+md5w4QWI6S4IKRgyl1IQ6YxL2nVZ3+0dyhgaMqb2E2J+Ltl9LjWjZcdgJbrl/ut94EZGBfiMMGInFRx+9BwW4jszuNGB5QI2afI/BDTVU9BF67io60skmQ9fUG80V+nRQblxr7ID95v80jAww7GZL91L9klcKGN2cm8F38YnGCidoOjnuplB8pMJtEdj1G8TrFlfMcvOcUwcggQ3en470EhCChXka+TlXN5+o2UMQY3XVyabeMPRF7ZnNaIxulNIfJMdAJDOiKRlBVpaGduCJSiE6N7e+4/aP+8acTTOSmLxXHwBO5HnjN9+utXXO/KtmQf/W2czIhT5GRXxJ0wbNOs7fO+f/OHec/JbNcXQJQbO1MFqqImH2mTm5M2P3znu7JKldl/c/5BhRTz0FDoRRrYJC8OCeL9hotM5qcFvtDJ2H6DV8BKG2QaM61VjXL5D09SGp7Yn+9gXWxl2fEARgxNIkzS7uaVlTzSRPWgogxidjFJSGGoqRrgNGjLrfaCwJBPMDGZZFMap2TMO9yiMtsXtR700AKuBeMP22uuM3/eWn2cFci+ETbKkqNqoVOmFGwChco8j+ZxBNy+o+3IM6szCL4h48Mx+g6mWdZ4N+4XauH1YPJ9UGnVkhsuYLWQETuzm3aYDh6aoWeIpBNeK1MPQEnrceRLrkb+LGn2HQar9utHAO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(66899024)(83380400001)(36756003)(86362001)(31696002)(38070700009)(41300700001)(122000001)(38100700002)(91956017)(26005)(3480700007)(6512007)(2616005)(6486002)(2906002)(6506007)(66446008)(76116006)(110136005)(66946007)(316002)(66556008)(54906003)(64756008)(478600001)(71200400001)(53546011)(66476007)(8936002)(4326008)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3ZyMjdHdEgvcjd0QXhsRkRaOWZSSTA4Z3p6UElvRmdURmZxRXE3aEd6SE9G?=
 =?utf-8?B?d0dYY2hVajl4MUx5K3VLdENQYzBPUUYxY1VaKzU4bE9QNml6cVFmYVF3UXoy?=
 =?utf-8?B?K242U0hPQUQrbHZiMFZkc2JaNkZJS2hlVzE0SnQ3OVBLaEpzbXdySGNWUHU4?=
 =?utf-8?B?N0ZPWWlYYmk5bzhBTUtMb0VxK0Y5dEtpbFdCYWNxZ0hVa0ZTQVNwUFFkQ3lE?=
 =?utf-8?B?OElXdVZtUFlrb0pFenpGaTdPbDhKYlpDYzFWR0lnWWJaRjhCb3B4Mk13NHRz?=
 =?utf-8?B?bkowbUsweCsvbXBMNm1JQkY2bFA5MzNKcGRzQU1VTDVsN0N6V2QrTFQ4RDRv?=
 =?utf-8?B?ZU5iYTVLWTVpOEtFUmJtL0tYNVZQUVJxTTZianpoV21ZNDdScCtJclFGVjkx?=
 =?utf-8?B?NkV5S2RyZTZacEdiYktGMkdCaDJyZ041R21TRU9JRmlYeWNuQ3Q1d2R4ZnFo?=
 =?utf-8?B?Q2VmaVNvNzFzbFB2N0N5dkxRdVhWZUZJd2Qxb1JvL0xSRWY2dElWbGowVjcx?=
 =?utf-8?B?TTZibFBRSUhTT0cxVzJXR0tuYytaVytRa2VyRlp6UGVoOERWMlFKMlVSVEtT?=
 =?utf-8?B?WmtTUFk2V2U0cllxVlN2M05WSVIxUU1QNkJWK3ErenVNSldya0FxZGFvbm5H?=
 =?utf-8?B?OWlTUWpSRWlXZHhtbGlmSTFCbnhHYVRycmNSd2NYb3hBVmxPcEQ3R1NyQ3dQ?=
 =?utf-8?B?WDFtYlYxZUhyVDJieW5icnZRUURKZ2xxejIzKzI0bGpZTyt6TDMwSkdCd1ZR?=
 =?utf-8?B?VTF5bjB0MHNoOEJROGZUOHJRSU9YTlUrd1V0RGdUZncwQXAyRHBWWm5zaDFy?=
 =?utf-8?B?ams3d0Q2VEdiYTBlOERLZnU1dnpYcXFMZ01rQUpIYTJHVmtaMmowa1ZWaHY4?=
 =?utf-8?B?U2ltSGk3WjJUUFFDa2puaGtSeWMrQXh1Y2FWK0RsM0tZbmV3UFJCbEp4K1Bi?=
 =?utf-8?B?bVZuRFhZWnI2VGhSYkc3R09JSXRROXBWNFJ5U29tTUxtT0pqMXZ6RjRoY3ZM?=
 =?utf-8?B?QjNDUDFWM1R1LzIrTnhkOWlCNW8zdm1IZXY0N1J6QkgxeDdJZVhBTFkveVR5?=
 =?utf-8?B?R2N6cDFMK3hveU9qRDVOZEZjR3dHZWdRc05NcnpyRnhzb3U2VnR0RzFBN2cw?=
 =?utf-8?B?c2dTcWI4LzEwSXR5SnlZQXlqZTJDdjk5eHc0NnM5VmdRQ2VUNGJtYTJtUHNP?=
 =?utf-8?B?cWhvVHIzV1k0RmYzMm9hYXhUdlhhd0xFSVdMZ2taY0krWjM0NWxzV3h6WVRB?=
 =?utf-8?B?V2k4RTUwOTZQeThUOTQrS1FzYkJURkFaQ0hMUG5rd1cyd1RRNGhoL2pmYSt2?=
 =?utf-8?B?UnFPcVhsL2JtcGpkK1RZMmRsaTJEcW9YVnZZcWpILzNmOWJaRVl0K0dEWFN6?=
 =?utf-8?B?WUVWcGo3aU9leExxazZyRmViUkgxRzRVamkwaTRyS1NEZ0dDRWhJUG5IMFFn?=
 =?utf-8?B?RkViNWtyN0F6ZHBMZkVyYXlYZmd3eWhlcEJseFRuVnQ0dldqM3AwTmpUc21O?=
 =?utf-8?B?UEhTa3EzY0tKOVJLSGRCaDV6VHRIWHlVTjJ5UGtWQUFDVEErU2NNYkhXR2lH?=
 =?utf-8?B?Qm9WWXkxeThWWjZPUm56ME8rMFpmZ2RqRXkra0d0QVhlb20rSUlVdjNQMldl?=
 =?utf-8?B?ZGZYRWtiL29wODcxazhtNE9VelNBRXdYbUdrNWxKYzVTVDlnQ2ovUXNzNkVR?=
 =?utf-8?B?OGN0K3Z1SEpzREN4ZnpIVXhzSlJyRmM4MVpXSXFVQ3FvM0FwLzBoNzlBbnl1?=
 =?utf-8?B?NDFHUHpqS3UxZU1FR21Zb3lHMGk5aFRkajNlQzBEVkE1ZzFZQzRaUWhqVGxZ?=
 =?utf-8?B?TlhFUmQ5Y083cmp2N2JxOTFaQWJKTWZmRkFlT3p3VVhpdXM1ZFgyOEd5Q0g3?=
 =?utf-8?B?RnVCRmtPbnZxOHREMW0vN2thMmg0WldidGh1NmlPWlZYUVFKT1l4TU5tN2xj?=
 =?utf-8?B?ZGNZQm9IcEFRVll1RTE0T0gzVnpzeEFhUm1VREZxYUxLcnZzZmJieW5hZGpa?=
 =?utf-8?B?VTZtWE02Z2Yzcis2MzJPL0Niem54Tlo0M0p6MDZSUlVxV29pa3NLMnBaeG5E?=
 =?utf-8?B?Z0ZaejV1QUtrS0Jzc0gxRDArWGw3UjVjSmUyNnBseTB4QVo1aDQ1a05JWGlN?=
 =?utf-8?Q?V01Q3JjJXuAO0fmAm3alAbiRK?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <99FA14CAE2E252458E5067EC93D4BB75@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0fad29-25cd-4962-0b55-08dc1c615d58
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 22:19:28.2973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IoPC92y/xC7btm+YQQtP5UJ8t4S8jMk7E2TfmlXh8frSA4LHv/06O7u+yAaAu8yJOwRLFeoakpIAuPIMiK2qHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4522

U2FnaS9DaHJpc3RvcGgvSmVucy9LZWl0aCwNCg0KT24gMS8xMC8yNCAxOTo1NCwgQ2hhaXRhbnlh
IEt1bGthcm5pIHdyb3RlOg0KPiBIaSBhbGwsDQo+DQo+IEFmdGVyIHJ1bm5pbmcgdGhlIHRlc3Qg
dGhhdCB0cmlnZ2VycyB0aGUgbnZtZSB0aW1lb3V0IGZvciBudm1lLXBjaSwgdGhlDQo+IGRldmlj
ZSB1bmRlciB0ZXN0IGlzIGxpbmdlcmluZyBpbiBhbiBpbmNvbnNpc3RlbnQgc3RhdGUuIEhlcmUg
YXJlIHN0ZXBzIDotDQo+DQo+IDEuIExvYWQgdGhlIGRyaXZlci4NCj4gMi4gVHJpZ2dlciBudm1l
X3RpbWVvdXQuDQo+IDMuIEFmdGVyIHRpbWVvdXQgaGFuZGxlciBnZXRzIHRyaWdnZXJlZCBpdCBm
YWlscyB0aGUgYXBwbGljYXRpb24NCj4gICDCoMKgIHdpdGggSS9PIGVycm9yLg0KPiA0LiBsc2Js
ayBhbmQgbnZtZSBsaXN0ZG9lc24ndCBzaG93IHRoZSBkZXZpY2UgYW55bW9yZS4NCj4gNS4gbHMg
ZG9lcyBzaG93IHRoZSBkZXZpY2UuDQo+IDYuIEFueSB3cml0ZSB0byBpdCBmYWlscyAoZS5nLiBk
ZCkgc2luY2UgZGV2aWNlIGhhcyAwIGNhcGFjaXR5Lg0KPg0KPiBJcyB0aGlzIGFjY2VwdGVkIGJl
aGF2aW9yPyBpZiBpdCBpcyB0aGVuIGEgbWFsZnVuY3Rpb25pbmcgZGV2aWNlIGlzDQo+IGxpbmdl
cmluZyBpbiB0aGUgc3lzdGVtIGFuZCBhcHBsaWNhdGlvbnMgZW5kIHVwIGFjY2Vzc2luZyBpdCBh
cyBpZg0KPiBpdCBpcyBmdW5jdGlvbmluZyBwcm9wZXJseS4gQ2FuIHdlIGF2b2lkIHRoaXMgc2Nl
bmFyaW8/DQo+DQo+IEhvdyBhYm91dCB3ZSByZW1vdmUgdGhlIGRldmljZSBmcm9tIHRoZSBzeXN0
ZW0/IElmIHlvdSdyZSBhbGwgb2theSB3aXRoDQo+IGl0LCBJJ2xsIHNlbmQgYSBwYXRjaCBmb3Ig
dGhlIG52bWUtcGNpIHRpbWVvdXQgdG8gcmVtb3ZlIHRoZSBkZXZpY2UgdGhhdA0KPiBoYXMgemVy
byBjYXBhY2l0eS4gT3RoZXJ3aXNlIHBsZWFzZSBzdWdnZXN0IGhvdyB0byBkZWFsIHdpdGggdGhp
cyBzY2VuYXJpby4NCj4NCj4gV2l0aCB0aGlzIGNvbmZ1c2luZyBiZWhhdmlvciBJJ20gbm90IGVu
dGlyZWx5IHN1cmUgd2hhdCBpcyB0aGUgZXhwZWN0ZWQNCj4gc2NlbmFyaW8gdG8gcGFzcyB0aW1l
b3V0IHRlc3RjYXNlLg0KPg0KPiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgZGV0YWlsZWQgdGVzdCBs
b2cgYmVsb3cuDQo+DQo+IC1jaw0KPg0KDQpDYW4gc29tZW9uZSBwbGVhc2UgcHJvdmlkZSBhbiBp
bnNpZ2h0IG9uIHRoaXMgYmVoYXZpb3Igc28gd2UgY2FuIG1lcmdlIA0KdGVzdGNhc2UgaW50byBi
bGt0ZXN0cz8gUGxlYXNlIG5vdGUgdGhhdCBTaGluaWNoaXJvIGFsc28gb2JzZXJ2ZWQgdGhlIA0K
c2FtZSBiZWhhdmlvci4NCg0KLWNrDQoNCg0K
