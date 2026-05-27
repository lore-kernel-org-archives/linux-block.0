Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013009.outbound.protection.outlook.com [40.93.201.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B453FF88C
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900678; cv=fail; b=K0tY1vSywonUgAY0MAXmPHHs/DqFHFSR20wMKRto81mf6xjBezh5QMfAik9W+6Zj8F3vgV8QvfahjI9cAS/6A5YWzY0oiCEE1kVxbK3TfFT17dpas3nuxB68mvN/A9SxLIirK0XnieIo4lwfbbHOULkzfqGSI/LTcwhuARWbNK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900678; c=relaxed/simple;
	bh=55b/ojX7cPAVoZUgxCYb88alUlZFCogPets4A9GDWyE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=krPa6wvmQvA33UqfFnpz+3HG/LJQHPzR6pEYkAGZmhyEWmHKeRBkUnVj/gmlhKJyKukBwq3OkOEfU8DmM7nHBmunrXLdRNp+dcHEDYk/udusi8qLEil6cvIqVqLtaUpSUeHMwHMZql2aEc9hx8CjSX6lz0WY08wns0mUwVdejAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9nfLwYN; arc=fail smtp.client-ip=40.93.201.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9nfLwYN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcBr78rDURJQFSylK5Z5YqbgKkBgIlkE4zF5rAa668amDizkSsin02qFimPz1Fpu4oBxSM+ClQNsgFvq+FWp4m64VFr6wxVFDsd8h4Q1zcZ4B83Mq9V3IA9GShnrXvZorvROyhc5m8fqkSE8v07xpBMrqJsmHMe/GbLpYTQVHOtDq4qm8FdzdxZlbejv52qE+1hwS9m5ti1zVG6X0UGX16A5ET91vU45wraF2Urc4k0F5muGjl39417To9r8AOABdZtlDR/KB/fWCPXAsEqvGxu0u2sKELk6faRAtCUR545EAa/Dl5yOD9GkJ9rTC0xq298LMRaShQyEuQGu2dtQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55b/ojX7cPAVoZUgxCYb88alUlZFCogPets4A9GDWyE=;
 b=OapsJPYMjZcHQO3HbwOLHlnOBW97Em1sco3OZBAMi0DPvi3yb0NYQiqFBFAcIKXj/OSJvaeOyaaK8n2zu0s8Bi9dOvENWQaVkCqiJbY+u9GJqVDEdXlh9ScgIlWoE6dJtxCUkpWtTxkgY2NhFX0RD5on8+5Eb9opK4I6P3aQ6cpgPyPRcpF/paeipDXEqF/BQJYWAh6jQwfIOjqxTRSQLcp4mNO6wm+zhzf8eflPa6NbvCvbQH5adT6EKOY/fJ+ys51lD5gTtJtvyt2o4IhYXxVcxHZZlb9ve+JJ44t8v0n+NAEXwYWOnY2rmX4gtnSliZxIEPdua5j1AsRkaJySdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55b/ojX7cPAVoZUgxCYb88alUlZFCogPets4A9GDWyE=;
 b=e9nfLwYNTq9I3X7nclvd9oO07iV7+D7/V8i2Y6fI8lhZFaffq6f4B76sT78+GQodsvdyjUd3NAjruvbuhuk7SKJ+at9AN+9j+pyVLvvqMYhRIpCGdfMXmyYvUQ4qPt+6eTseLjrWo1HGG522ibaCNjCl76epketYcI2eH9LOxiOvboVEMRAFCFh5vHM3F9dOI4QqPvdBhdOCrs86HtunCERZ/lFF84X5xjVrUp/jtvwZkFUcQhFjkUzmERThKaz0rwpbfCSAvrdlmfHmeGPcSzQp9M7GYia8Yv7soJ2MdrgcmqRSC/mX4ijrlXV9W3nFS6N8XAbvNNyIEbyCCQF/WA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 16:51:10 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 16:51:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Ming
 Lei <tom.leiming@gmail.com>, Bart Van Assche <bvanassche@acm.org>, Caleb
 Sander Mateos <csander@purestorage.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Thread-Topic: [PATCH 2/3] nvme-tcp: cleanup nvme_tcp_init_iter
Thread-Index: AQHc7esVIfDihqBOL0SkX8VK6NKMnbYiFjKA
Date: Wed, 27 May 2026 16:51:10 +0000
Message-ID: <3e954690-a333-465e-9bd1-8f848c8192b4@nvidia.com>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-3-hch@lst.de>
In-Reply-To: <20260527151043.2349900-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8354:EE_
x-ms-office365-filtering-correlation-id: e7df6356-3397-4955-8c4e-08debc102789
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700021|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info:
 HAmuJz8vaLRsLtOj02dcGJNy08Y/CzJl8/fBO649iN1t/pIWYKIuTKryYr7xJ48xXWxout3wwre0hFcnhlOTeUBdg20fgG1JPQGvQMfCHsQ1ffP5+3toNTAKL8EWnj6GPnUpf1epWqGUerbAyiU+teVUiJ23axCP4acrWV8JmhKg+U7E4gMWIVGj6JsItmwzFdwH5KgGnjMZaD/p7ZVXfT/oD5dP3h0QjRjiPFdOuAql3quuCrVcnMPHvK9XmtHD0KV6ShIpmFcbUV8oFkmSwUQrn4omkhbnhx6ysLGNykQuOMvO1ZluLb/qVsX1RUti/gh+BvkMJUJSgXFi9FqTTWJt3lvVTapBisPnu/ABWHwSWtBiXakHkt+OqR4A1O3yPa6DCFsTMxh7RXw/2SL+YgQwDb1EzWZfHK9jU5eZ7tiAFfPrRu2oNwp4A+dTtDbZqukqU55kFnr71pBxqrg+hOaWnEWvjv8JblHw3/zPdTUle+1u9jDEy+SPdnX8Bp1w6XgG4Yed/E3lz1Vp+TcrWxljRiuEpTzaSLm4VGn+E54s1T0og3K7C09Hd3RkvfBRAaPG++X5y/DJL9lRYBE44ny6yQEyLuF8EkBz2PfzNM9dW6QT6OvR7Rk4Y8yTSD0/xAXcDSeg1g7c0cCVzdNZToFctOFOFYWb38SlYelmwo+5SXyg4yw2w0ySxGljc1S2r0zEc2duqeE8bYq48Q4vklVdMCLgDdqhA2jZeqt45hcj8/Vuu6PW35FNIZR8pELA
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0dtMzFzTXBuU0h5Y3hVdE9aSUVzT3FxTm9oaFpEblJ2WDMrSFU4bHF5K3BX?=
 =?utf-8?B?VTRPTGNKWWJZVitaNzJYTUI4QnQxbGZZVlhPMVpNVk1oZmJtSUlqS3pmQUtM?=
 =?utf-8?B?NkJvbWJNZFoyWmJuSnQ2SWgyOFVtN3N4UUFLandNUEYwZXUxM3R0Q2tFN2Q4?=
 =?utf-8?B?UTA3SkdyazFWeFJEQVp4WmxoVTRlbGZtZEY1MmNrZnZac3hKcC9lYWZRb1VT?=
 =?utf-8?B?MUsxY3hlNlNyRDJNUjV5aVNDK0tuWnlwWkN1dHd5RkRJVlVjcUtHTVFMdzE2?=
 =?utf-8?B?bTV3OFMvdncyR09QM0dPK1NpbTRPOUYvdTNYc1I0K1hqSDZ2ek83UnB3ZUZs?=
 =?utf-8?B?NjRCVy8zZEN1WllneFRmU0YrdjN4YnJ4bDY1T2xNK2hma0ZlMGVZa3BjK1lS?=
 =?utf-8?B?TFNoaE9wbXNYRHpsRFhZUUMxWEpFMkRCeEU1cUlRT2phOUs1a3dWUUJYeVBI?=
 =?utf-8?B?RUtFcEJWYXNpQm9XeWNreS9jZDVGeEo2dG1EMUNEMjlMaFlnMWtsZkZic05v?=
 =?utf-8?B?N09IaEl4cEZtVWdTNDFKR2lYZWRjQXRuakJ1TlFZUzlKTkRpNmxRdWVMUC9u?=
 =?utf-8?B?S2ZSdnpzeVpqRkd0dDc1S05zQWIrNVF0aHVndGJvWlVzWnVsb3BEZTdVZXJ3?=
 =?utf-8?B?NjVYR1IwTFhFalFubnRxNklqRG5mQ25NVEErZ1I1a29lVG41c2J1WEV4QjJO?=
 =?utf-8?B?NzQ5QUkyWG5lZ2dPbUhpdmRPMzhlR0Vsd1BYUzZKVmR6UlU4SlI0Mk9DbnBt?=
 =?utf-8?B?SGdzbE8rOEZoVDZlTFl6STY2d3M2bE5VTFlMdUsxaHZ5NDBYemRhODVTdHlJ?=
 =?utf-8?B?ZjBPdkZraVNSR1ZYY3ZqdkRhRnpOL0tYQXp3VGcyWG9Mai93MlFUdlhRV202?=
 =?utf-8?B?aFROZUhLbmg3d1l1L3lsWjRLOWV2VVNkMGdyZEZrellQT1lXQm8wZVRqTG53?=
 =?utf-8?B?ZDVIaHQ0bE9WNWZucUlRVjNIbUpmNExTdVlnbGU0OU1DTWppZTB6Z1NyaEF6?=
 =?utf-8?B?QmZ1NlZURjdocGJueXlnM3d2SktWUWlDb24xWHBiR29uNEUybVZPVUlRcUdX?=
 =?utf-8?B?QmZrREFhbms5ZExmK2xwWHJCUDNHa21zZGphT0RwditOdnZhZ0VqdUo4QzF0?=
 =?utf-8?B?Z3RrMEZRTkZ1YUZtT0ZnMndZcFhiZFVta2hGcHN6WG95dVVhUkNwcFdPcWtI?=
 =?utf-8?B?WU9CbjFXcHhYN1NZeTRDbHc2YjhyNHFJbW5LbGMxMTRTYm0rUmZGOGRhVCtB?=
 =?utf-8?B?Y0RBcmsyU3kvTndHS0hDdWl6YXgyVS9SckIwME5KbjJxbWNtdTlKdzE5QUtU?=
 =?utf-8?B?ZzhiNlIvZDlEdDBSVytBWlByZjR4SDhuaE1jUEFkbzE5UkFxRTg0OXRrMDY3?=
 =?utf-8?B?N2ptWm80Uzd5K0kwUUxJNjZnRGx3UXNDQmV3dWRuN29DdnFiRGIwLzBHdWJT?=
 =?utf-8?B?TS81UWJzR2xWcldTakpHYy8ycGJZdmZOa3J6MXFQTlJoOTRMZVpob3lxRC9E?=
 =?utf-8?B?Y3Qra3VLRkt3NnZ4aEt4bVhPNExvZVVONTlmTGp0ek1MbkhtNUhBb0F4SSt4?=
 =?utf-8?B?dXpWUnJCUHRULzFhbWhXVlBBa1RoQnZnSTVEL1NxWTI5Vjl1TFB5eUJnZ3BV?=
 =?utf-8?B?L1gvcUMrTjY4alFobWZhOXV4QmVGNmlrT0FQWGg5b1NSakFOUTRNZlhrNEtr?=
 =?utf-8?B?dzAxWlBOdzJGVDUxbkdoTUhsRVdidngySUMxaGExSjJ0NTNDL3VmbUxkKzBv?=
 =?utf-8?B?SURjUEtBeVEzai9QYzlHVWhOMXlwa1FkSlVteDl4enlpSGhuRFFvUmxqUkZQ?=
 =?utf-8?B?RlJoZjJ0RmJPWTZWK2xpMk5ZbXZZdWJNYkl2SDZHWU1Sdk5rWWdPck9IeDhJ?=
 =?utf-8?B?amJSUFhKYk5XcXdvYnZwdTBnVkNYcGx5VTFqRXViVU0xd0k0emxyLzRpMFR5?=
 =?utf-8?B?SFB1ak5OaVIwL3pDYkhuVFRVNG5nUFdTalcwUUFXWC80OEFkWTE1S0VKVnds?=
 =?utf-8?B?MXk4QkpqL3ZkdXNGSkFUSDAwSDdmdEJzNlVBS0E2UUx1SU5GRC91SkdPVk5Q?=
 =?utf-8?B?R3Z0YlM3RklyMnBCOVZDUGRvUEhzSjduWnhwandHbit6ZzFBMG1vTVlWYTlj?=
 =?utf-8?B?c2hYRzd5TTQxR0ZVbGpsemZmaW45aTE3QlFON21VMEZ4VHo1ZmYwYkRkVUlQ?=
 =?utf-8?B?TDRTcUVIelRVdHV1aVFuME5mdkhWcUVOVU5VcW9Kb2UwYldSNjljSEtTbTYw?=
 =?utf-8?B?a3Q2UGoremlVN0xDWjZ5dTdlaXhrcGZyWVhFaG9xUWJiUTM5R1NNZDd6aVhs?=
 =?utf-8?B?RG5hTXJVREMwdWVMc1JFeHdlc0Y0QWVQb0gxOFRpM0paaGJvckIvejZmUE1W?=
 =?utf-8?Q?dDBHy4w3MKzgDxS/50HPk6B+5E+xRVaEqx+k4iBvteSyv?=
x-ms-exchange-antispam-messagedata-1: 3AK6LMMWZ24e3A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2389363C5D2CD844B42187DC44FE4A3A@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7df6356-3397-4955-8c4e-08debc102789
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2026 16:51:10.1587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tF+fJXMaS0pl8q02pPgXAb8Q9sw4xIh32euSZNyYtR50yX0EvO7tkG0t2/NA2J00GtMidOk3LuYz4rsnzHqgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

T24gNS8yNy8yNiAwODoxMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFNwbGl0IHRoZSB0
d28gaW5pdCBjYXNlcyBiYXNlZCBvbiBjb2RlIGluIHRoZSB6bG9vcCBkcml2ZXIuICBUaGlzDQo+
IHNpbXBsaWZpZXMgdGhlIGNvZGUgYW5kIG1ha2VzIGl0IGVhc2llciB0byBmb2xsb3cuDQo+DQo+
IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQoNCg0KTG9va3Mg
Z29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
