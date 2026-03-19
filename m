Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3729460;
	Thu, 19 Mar 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890307; cv=fail; b=Ci9kL73wvPGpJYl7Q4d3LPvdtSxaVBbtT0kb2y1NSa219n/jkxIRZASADApyHns7Hu3UcGZBWUMvaEs2tiLdwnwoVd/KmQ96gvXD7KIvd1d0e29d58BUt4Nn0EAcFoU6Cxv6YIVSDJFm9BTm0ispOG+Ksh6N+/XpM1dtoIMYGp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890307; c=relaxed/simple;
	bh=1QuH4YCioXcBIxR5t58EsEhhe1SwSEFomZVoTYYOzrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DEpjwSG/OiSWNscBoJK+2o4K4XQZ2+BVdngY7Av59wzgfZGSpFpI4RIuRkKS2WDN8ZhLcQE9BGeNXpkwl17AxLQ9YV8puGdmcHcoP67EARA+QPFQeCYZd4HO3ThVTMimFwQzfuZtsLeBAQo0ACX2v1izttRkzYtAZZMcwjVcZQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jC09P187; arc=fail smtp.client-ip=52.101.52.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jC09P187"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5GKE+uyfKdUJLepK/Gua7mrVUkp4jMhl7iTTm2yI3noqF4wRGk5306CfuDryI/DD0hRUlaxftLe/CwAY9+dPQiXHDgAwW9RVMYDSTXOVLL38dFJNl5X6WoxltkmH0sjeqUumkvUpeoivEB4qFR30ZiNgxOcjBMBQ3GjuhrEqPinM/5jRLcxCIW40BWb+WY+EtUu0XhU5MEJGQ2CAWmTUY5T+QPTd6kXX+03iPdU2CnEUHJx7Qc7TqaV9wOeATAUK/APdXGXrzG/O2Gj4l9RKbrWmugQMz7L/1xqkJCYF9MQra8JmASXDc4zpNzm/Y3pJl08VbszfMa7BEugw3HSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QuH4YCioXcBIxR5t58EsEhhe1SwSEFomZVoTYYOzrQ=;
 b=DTg0KmGYt4KNDgKZE9Z+HzJHeHYCHoZQKJSlrQ1Apb5JlYvFBexoBXlc13aBtmQ/Gg8wwDjox+iFczytBCcPWnXSyWhl/DA9GVGJMOgrkhxCmbR57C4LtMzKA4UQPzntyjCfpRi6Szt4A6oj3U1BLS91b9Ed7UaT2jjnHZb6oFdPENRWuybARZA5u5VqXnsqfON4ANfdcnyQd5rq2Yfpz/oKcKy4EJWR/szh58DooWYBAybenKFPqYAGn54kQQOdt6GQtxxPo1UxLjQ5Pw12cZnHzUp604y2GfNQhK0qv6MRpojaDcjhuqHZMLgr+NAZCNVE8WGbT/JizLVUpzv4rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QuH4YCioXcBIxR5t58EsEhhe1SwSEFomZVoTYYOzrQ=;
 b=jC09P187FzAISWa9Qr1zEjVkYOi3bVQwwXC8Lw60pGR8Kq284VRPHlkJTgmjdfzemKfJfOiHfAvrlyJIC5qvyHIN6/PuLnSHQEDczn9FDDt6NaqRAWXxji+pziQG6L3icvVXbFF4887WxwxA4L33Ri0AQIraUm5VEEOKta0TZhb6WUXuv56dBD09A5WKciPu3a5WsJolO0yXtsM1Nio5GVwyr9DVhJdrHiiMsG0pyZQ1306iiQI8gXIFhZWBua4u3E8hJzG7KE1zfgVhbR9Fe29Xvqb/S1zgcSEMRtp03M4YOoqSX2kdPUPfHE/Yqxmgl1vjsAQF9iTHOp7AUS6UKg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6624.namprd12.prod.outlook.com (2603:10b6:930:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 03:18:22 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9723.016; Thu, 19 Mar 2026
 03:18:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Aaron Tomlin <atomlin@atomlin.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "mhiramat@kernel.org"
	<mhiramat@kernel.org>, "mathieu.desnoyers@efficios.com"
	<mathieu.desnoyers@efficios.com>
CC: "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "bvanassche@acm.org" <bvanassche@acm.org>,
	"dlemoal@kernel.org" <dlemoal@kernel.org>, "ritesh.list@gmail.com"
	<ritesh.list@gmail.com>, "neelx@suse.com" <neelx@suse.com>, "sean@ashe.io"
	<sean@ashe.io>, "mproche@gmail.com" <mproche@gmail.com>, "chjohnst@gmail.com"
	<chjohnst@gmail.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Thread-Topic: [PATCH v2] blk-mq: add tracepoint block_rq_tag_wait
Thread-Index: AQHct0Mk9aGmKDHaX0axWlLBqQf4+rW1L42A
Date: Thu, 19 Mar 2026 03:18:22 +0000
Message-ID: <3a49511e-39f9-4df4-9f70-2d38c7fe2208@nvidia.com>
References: <20260319015300.287653-1-atomlin@atomlin.com>
In-Reply-To: <20260319015300.287653-1-atomlin@atomlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6624:EE_
x-ms-office365-filtering-correlation-id: 8d030a3c-a5ef-45c4-c5fa-08de85662cfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|7053199007|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 Bw5gy/PG286duqtcrDDy85QIMU4eWr4y0H7R+bGdR6POYSBVqY1kz8T2jmlc+4dYezaewayM42BcIOgonFQm1HOxS/jJVma4OokBUvrgKzXJc1caANIYgD0K6JVpACCerNUfg5EDo35EaBIPLuq7dR604KXjbQQZwqNZfq6zRb+FS2bEuqmjvZbfCw86AZapSF+ej/klaDJPp5u1ScGlk+yaxUtmh5Jhcc63qrHoWFx2oAi7h/kaiPpeIEbWcoT6I8rT7HNotxjPxHr2HTCvskm95q8iYnNa1YbIzqzqlWIvtLeUZYnqlZweh/ebrqNAVsv08El6rzr1V5gcOQgcGIcRBKRdJfps1hzQA9jniABFZrMYR3xGVBD3GZ70NDHpb4iE1QCN81k40cN4eoE+W7/lXZu6v6KOhNJYCg/ZVFFnPpPpvoGRP0lQGtDJyRE2jrm25GeuTZ7LfbsV75v7KdtfuyfV6NqAHjq1F5Kjn+ME9Dr59yM2sa+46gFd3K8QSbsTnmBVqASmK8FnjMSVchTjxDkWRlzApKqYhvQveKfrXx6ITtK6loQZZsSf5Olj9AEDBqL1jGkVqkw7KbqHqLRkme0LDqfHSfAVSwFnLtXPGxzN2bXzp0rM8yBi1cA4yQTMH3eGmlxvMNisz/VytARLHrSrD8J8Z+ld8rQ+wCRHkuSpJcXeBFRceJOdL9pGHsDW+dAXLGQaozKf7DwbQ6bSYg+gzEzfvw6iv77kauvdo1KRp+PI++4uxIMtSkdlCIdUJVMYaTeccB2y6Rng2wKJvUflRcNnIoDQDbeMZpM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(7053199007)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWpXY0x0a0FTL3p0K1NoUi9scXB6bW8wMFl6aldYVHptYW5QU0ZYd3JXYkFm?=
 =?utf-8?B?RXQ2NU80dkNscC9xV0xaMlJnSVJOOTFpbHZqWjVTekRQczh2MHdaN0hraU0y?=
 =?utf-8?B?UDI2VUNlY1QyNHJwRk11WUhWdDBBWjMxejVma3NZWU5JMkJHN01PNHRoODho?=
 =?utf-8?B?UFhiSm5oVGtTMHFhTEpXWVNOYTFoUmx5NVBweTJybzNSMllOYm9DMEo0cVdW?=
 =?utf-8?B?NU1nc2w3d1BidURrU0dMUFhZa3J5Y2tDQWxsVUlzc21PS0xVRVorVDduR3k4?=
 =?utf-8?B?OU9Wc1BWcHZHRzVFSy9FN3JBald5S3k0TDhtdE83TmE0Z0ZzZ0dOY1hLdk9v?=
 =?utf-8?B?am1yYmFoNkRpZmhXZzRJdnZYcXF2SDN1M0VQbUhpa2dmcmx4NXlHL1FBdkND?=
 =?utf-8?B?ZEhPUlUwdDhsdkxiQUhLTVRKQW1KTGdCamQvT2tSTUE1MGo3UHRYNzY1aW9m?=
 =?utf-8?B?d0cwWFhwaExJYmJTSWwwai91elRid2s2UlB5M2ZWdWNaZXBpUDEwbm11cG5D?=
 =?utf-8?B?Wnpodk1OTGxZczlUWDFqVWhLQWlia3cwbm1xeUNaWW1ITnRxQ29HQS9qS2VX?=
 =?utf-8?B?ZEloUGJ0WE43WHAvdUZjSW1vUW1LUmZtYS9FNXFXME9hSktqL2dSVmQ2b2xX?=
 =?utf-8?B?dmpCUUJrVjZSdC9pckVCckxGK2RxWWdSeW1ZRW5JcnIwUW44cWg1RmQ0TzF5?=
 =?utf-8?B?UHVFVkhFdkhwZmpmS1VFenVBQ1dGYURFSE1pUzljVE5nTkllMjZVMnhKUUd3?=
 =?utf-8?B?STU3SGZTQ2FHeWVGbUljOStzbFhZR09xbzA0TXc3NjdNKy91a3hmQ3hFSTVt?=
 =?utf-8?B?eWQ5U3VraFc2diticUdHcVF5dXg4SGFIKzBTUTI5N0R3aysrTDFqUzZaTUZS?=
 =?utf-8?B?cGRPNi9RV25UbXFKK0NacktOQU1aMkdqOGpHd1VxQVgvNE9BYWxFMlRCYjRo?=
 =?utf-8?B?VmxsOTNZU0QraGdwVTEzdFdFK2tXTS95M1RLOTRTTGdPUU1kZkt1bzdMRHhp?=
 =?utf-8?B?TnVkanorbE9nU2J4SkFLMjFXaHlZZUkramR6bCtRTGUrQ1JLdFhQL1RxeWh0?=
 =?utf-8?B?SXJzTWRka2p6TTR2elZmWjV3bk1ONzFmVnFPNjZLSVFMNWovRTFsYmtMMVZR?=
 =?utf-8?B?ZlpKem9iYXgvNVNrS2ZtN0wzdkdMZHo4ZnVacmdoNzFHaDQ3dEVTQ2VHZ1Ir?=
 =?utf-8?B?ZTBXODdJY3dwdG1JU01zK2JtVHFLOFN4N0g1NmxNYnhpZzVRWjMvQnZiRGVn?=
 =?utf-8?B?SDV2d2ppeFB2V3o3Tjg5ZEhiMm45RG03eGU3RnF6SWZZand6eE5xN2tmSzRT?=
 =?utf-8?B?WWxxZXhmY0RORWU0TXl5ZmRFQm5ndTMzV28vOWp0Z3NZQ0pHa3Mwa1FzZitp?=
 =?utf-8?B?R3A3N1ZmWmEwTHFQSUF5UGhNREZ6Rkp5Q3lhbldmdXowWFM1cU5kQVZEZ3JS?=
 =?utf-8?B?TWdSdmcwdDc4djV5N3dkTEEvTFExekR5ckpwZDZFa1RtZEFGRkN4S2hpajh3?=
 =?utf-8?B?VVBBT1BqaEp4T2RScldaNGdvSExiamtFQzNJNTlaWStnZ21Dc3hPMVpBT2Vx?=
 =?utf-8?B?WGpaQS9YMGZYWThISCtUc25SeVVWL2N4YmZKOEliMFZWNFRLSFIybVlaaWox?=
 =?utf-8?B?azRyYjlDUi9ic1IwWDMrNmRrQUoxSm11elZFaWc3di9tYWR3RTVrQzBpc3A2?=
 =?utf-8?B?TllxN1Y1YlNaZEVVdFdyMVh5OElBYmdwOEU1VmgrYXR6TTExMytvMW5DUm41?=
 =?utf-8?B?ZWVvYzduMUY4ZW5mN3I4RlFyNHJSd3QzbFdCNVhhcWd3TWFsaWhRNi9TbVEr?=
 =?utf-8?B?dG1kS1NjNk85TmJkSFlYYXlEVllyNTZlRmxmMzArWnlSd2kxd3g1Ny85VzU5?=
 =?utf-8?B?THhUSi84SUVBTkc4TEtwZDRZaU1vWXpXK3R1aFpySkJqUlFuYk5WNFRZUC9p?=
 =?utf-8?B?RHVGd0R0WDRQZC9obHNnR0NWTWpKZDVPUmxXdXBmVHU0QWhpQWgvbVh3VTlY?=
 =?utf-8?B?eGV5UXgzVVlaOXl1S0kxR0NTU3RqWHBkN21qRkF4c0RXemlCNVZUNEJPdnJ5?=
 =?utf-8?B?T2RzSFpFaENubEk1ZHVJVWd1M0FNdlgzdDlHRkkrWWZMRk5IVWpZdjVGd1hG?=
 =?utf-8?B?M09Jb0RBSG9pb3FndWF1NjIwdXdNVjhsd0t3NXEwMWJyZjhNaWdpek1ySE9G?=
 =?utf-8?B?NnhXeFRrOEVrZC9sMHVhcXBjVXJIRkNnSzU4dzVYL3lrUDV2aFMxSEllQzEz?=
 =?utf-8?B?VEdnbTBKWGpoRmFlZFRKYWFrMTVQa3VtVCtiZithQ2JmS2s1cUo0Yk02dzdN?=
 =?utf-8?B?MVU2Wnk0d201VEptZkdTMmw4VENvZlhnNjQvaFA0REpZa3VJVmhHUWxHaFBV?=
 =?utf-8?Q?CA4vYuuO/s29EqFBJQ1fzozvGXLgzlVSsGSxhktPu1SE+?=
x-ms-exchange-antispam-messagedata-1: 0Qrr+LecpvIObw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <844933830B66A048A71B4BE0293F0E77@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d030a3c-a5ef-45c4-c5fa-08de85662cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2026 03:18:22.0779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vz76s0wanyuNXo7814YsXLCPgt9eEag8Mmwnwex6/olPSBrSPhdZ1lEfAouzDPil7tJs34a262fBcIAWeBNL0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6624

T24gMy8xOC8yNiAxODo1MywgQWFyb24gVG9tbGluIHdyb3RlOg0KPiBJbiBoaWdoLXBlcmZvcm1h
bmNlIHN0b3JhZ2UgZW52aXJvbm1lbnRzLCBwYXJ0aWN1bGFybHkgd2hlbiB1dGlsaXNpbmcNCj4g
UkFJRCBjb250cm9sbGVycyB3aXRoIHNoYXJlZCB0YWcgc2V0cyAoQkxLX01RX0ZfVEFHX0hDVFhf
U0hBUkVEKSwgc2V2ZXJlDQo+IGxhdGVuY3kgc3Bpa2VzIGNhbiBvY2N1ciB3aGVuIGZhc3QgZGV2
aWNlcyAoU1NEcykgYXJlIHN0YXJ2ZWQgb2YgaGFyZHdhcmUNCj4gdGFncyB3aGVuIHNoYXJpbmcg
dGhlIHNhbWUgYmxrX21xX3RhZ19zZXQuDQo+DQo+IEN1cnJlbnRseSwgZGlhZ25vc2luZyB0aGlz
IHNwZWNpZmljIGhhcmR3YXJlIHF1ZXVlIGNvbnRlbnRpb24gaXMNCj4gZGlmZmljdWx0LiBXaGVu
IGEgQ1BVIHRocmVhZCBleGhhdXN0cyB0aGUgdGFnIHBvb2wsIGJsa19tcV9nZXRfdGFnKCkNCj4g
Zm9yY2VzIHRoZSBjdXJyZW50IHRocmVhZCB0byBibG9jayB1bmludGVycnVwdGlibGUgdmlhIGlv
X3NjaGVkdWxlKCkuDQo+IFdoaWxlIHRoaXMgY2FuIGJlIGluZmVycmVkIHZpYXNjaGVkOnNjaGVk
X3N3aXRjaCBvciBkeW5hbWljYWxseQ0KPiB0cmFjZWQgYnkgYXR0YWNoaW5nIGEga3Byb2JlIHRv
IGJsa19tcV9tYXJrX3RhZ193YWl0KCksIHRoZXJlIGlzIG5vDQo+IGRlZGljYXRlZCwgb3V0LW9m
LXRoZS1ib3ggb2JzZXJ2YWJpbGl0eSBmb3IgdGhpcyBldmVudC4NCj4NCj4gVGhpcyBwYXRjaCBp
bnRyb2R1Y2VzIHRoZSBibG9ja19ycV90YWdfd2FpdCBzdGF0aWMgdHJhY2UgcG9pbnQgaW4gdGhl
DQo+IHRhZyBhbGxvY2F0aW9uIHNsb3ctcGF0aC4gSXQgdHJpZ2dlcnMgaW1tZWRpYXRlbHkgYmVm
b3JlIHRoZSB0aHJlYWQNCj4geWllbGRzIHRoZSBDUFUsIGV4cG9zaW5nIHRoZSBleGFjdCBoYXJk
d2FyZSBjb250ZXh0IChoY3R4KSB0aGF0IGlzDQo+IHN0YXJ2ZWQsIHRoZSBzcGVjaWZpYyBwb29s
IGV4cGVyaWVuY2luZyBzdGFydmF0aW9uIChoYXJkd2FyZSBvciBzb2Z0d2FyZQ0KPiBzY2hlZHVs
ZXIpLCBhbmQgdGhlIHRvdGFsIHBvb2wgZGVwdGguDQo+DQo+IFRoaXMgcHJvdmlkZXMgc3RvcmFn
ZSBlbmdpbmVlcnMgYW5kIHBlcmZvcm1hbmNlIG1vbml0b3JpbmcgYWdlbnRzDQo+IHdpdGggYSB6
ZXJvLWNvbmZpZ3VyYXRpb24sIGxvdy1vdmVyaGVhZCBtZWNoYW5pc20gdG8gZGVmaW5pdGl2ZWx5
DQo+IGlkZW50aWZ5IHNoYXJlZC10YWcgYm90dGxlbmVja3MgYW5kIHR1bmUgSS9PIHNjaGVkdWxl
cnMgb3IgY2dyb3VwDQo+IHRocm90dGxpbmcgYWNjb3JkaW5nbHkuDQo+DQo+IFNpZ25lZC1vZmYt
Ynk6IEFhcm9uIFRvbWxpbjxhdG9tbGluQGF0b21saW4uY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBp
biB2MSBbMV06DQo+ICAgLSBJbXByb3ZlZCB0aGUgZGVzY3JpcHRpb24gb2YgdGhlIHRyYWNlIHBv
aW50IChEYW1pZW4gTGUgTW9hbCkNCj4gICAtIFJlbW92ZWQgdGhlIHJlZHVuZGFudCAiYWN0aXZl
IHJlcXVlc3RzIiAoTGF1cmVuY2UgT2Jlcm1hbikNCj4gICAtIEludHJvZHVjZWQgcG9vbC1zcGVj
aWZpYyBzdGFydmF0aW9uIHRyYWNraW5nDQo+DQo+IFsxXTpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9sa21sLzIwMjYwMzE3MTgyODM1LjI1ODE4My0xLWF0b21saW5AYXRvbWxpbi5jb20vDQoNCg0K
TEdUTS4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQoNCg==
