Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011014.outbound.protection.outlook.com [40.93.194.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFDC38B7A6
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 05:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084367; cv=fail; b=qdtqdEdq1qhFbYo9/CMeMAfPSpWaxMSa0IKmiKqlh/xM2qaPk4mcbumXH5lW1+LuU6fr+VhFMwCiXnVX65Om8NiVmpXrXcBcxJ5RRSZIKL2wjn3WvTTy5g3BMY49x9yEWRUBg46a0eEbOsqeFR565ZcJgvsfHUBdsV5gE4/mqWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084367; c=relaxed/simple;
	bh=VD5SkgOH2Q67iIw8rJyN4544MYsuPm9TGnDnPfHn/og=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AYnv+BPTGm1B8OzC1xGBUU6hDxQy4PnC9IAy53ISuM92DUPyzS15maoCe/MEj5SO+r6D+8+4S293UqUi7pRqcjQYHVVWVbYEin/MoVoHMqO/C4sipYAJMkHt93a8VpCRGavVoASFpGOmV5591Z5MUsovW4Dmol7M3Fc41GFrGjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mYD3AtaV; arc=fail smtp.client-ip=40.93.194.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mYD3AtaV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P+P4DsdaoUOg8QVRovPUKhTyIVqSAPGMMGSrFhp4s9jMJNcmH6bET4EBaGI2n5O78sfNqn1zuSYRUgfpZJlt9q2iQSdzdB3XC0Kqg8Pm1NDUw8PBAVVjCi6eAUpfd/Yh8/Wn05/GdX9oOoSRWoEQTK7KZRF+ymClRhe4oEMKxw+91JfJf3qfqRTAkLJByrlp2uI8Gv9M46lN3QMceeu42/rKfZOMZ9Um572kvc8UYIrzR4j8rj69A6rJxhg9l7nWorfiml6wRQ2PWM05KQc9LBS7yv54PaDTZTsUG7diyir4k7yXQA9hnacrHgMPy7bEmBOno8YxtDScckG/VNNzqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VD5SkgOH2Q67iIw8rJyN4544MYsuPm9TGnDnPfHn/og=;
 b=ZW/a57vu2BGJ/6MGSXZOuRrhh8Z+2b2MmM7YesTHVNjTorYY2HqCGIQOJtgddgJNP3o8aDbGBwZmInvkgfv+UrPG7sppP3y6ilRth1GWN5ulgDt3etziIPEtal5UHWyM2eht4l60D4pGTzzbPZoCZgW26uzrrGo5lRDshx3O6grIB8dkcUegsvU2CUjftkg+hmMjAXQx9POUwm1K2AIfJg6ucMTJ4InoVWzhkgs3eSR4jOxrPp/m94SWgk3riUCRtgWgGlO9sJtrz1mBA3CZLAZHn8CUx3WTGoRWfBx7Q+H+8/WT95ntY0OHwUHM9ElMtYEnM11naWp6d9O71W8+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VD5SkgOH2Q67iIw8rJyN4544MYsuPm9TGnDnPfHn/og=;
 b=mYD3AtaV1crblttfukfWg8Z0rd9PCDAxlPlMd/Xc1HbpJLKdntGu48Z+1lUUQENftlCWi9MxPLcRZBn//9daY3+hX0RCv4W/pLoycws0O14wxHb4sR5GyvifpNyqQHvPGoLkrOnTn/LL5pWDVJ0OodDcJK7M4Zb5cCUaEHUhGcec7bdZAUO9pFse5I0vNsEBjNuMsgDK3SPoicpxfX+EUHLXEfVt//MkXl5aVLIzYoj5Zlt1MuQXcBI3oEyw0Bkv6RycMUv+zAYLbOxPZz5HbR0UzitNnd12QDyz0+BkpHa8gOmAngH+ZGLuLvMHvcZfk4aBNy9nrIh1SbXpWvGfhw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Thu, 26 Feb
 2026 05:39:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 05:39:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 3/3] src: add nvme-passthru-admin-uring to
 .gitignore
Thread-Topic: [PATCH blktests 3/3] src: add nvme-passthru-admin-uring to
 .gitignore
Thread-Index: AQHcpJfTyHPl84HrQkKct81VkyjNj7WUe1UA
Date: Thu, 26 Feb 2026 05:39:22 +0000
Message-ID: <7f2329c1-b3bf-4bf5-bbce-1abe28bc16a5@nvidia.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
 <20260223074110.144758-4-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260223074110.144758-4-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8488:EE_
x-ms-office365-filtering-correlation-id: f5456394-d9d5-4d0b-82c4-08de74f96543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 yt3nqXW3qp60Tc1QTpvZ+JKdhO4gbjdigwfOwpt7r6Pyi+vRksSYSTIBxjbw7eSbJ3yPQp66ZytgH3rirk/ELCS9LRwxMJqpUwAJmF/T0lx46Ik923TfyXYCI34MlWL7cIvyvVuEIfg78tEhYsp61f+dVtX194Pc/wzH7g5gNz5WKuV655yAQ27CEe4y7XzczFqaocbts+I7KPBYGuUvXBiYuI79LJO94SlF5Y1/Y2BN7iu9+Yb96Gat+AWYg4RKoBrLu579mVn1YA1MNXbJg6Z7qd63QQauNhxinhTYc71oYUbzhKlYOKnOTrqMJlvYS7DzKprnPeiK9EX4Ta2HLuyKjpbGSyIPPbtXEhT3FrOrsz4ZhqvjwZzgbb4L8yRvR+lFSammTBcFgTXJODBKJgmikqHOX2/XncaNd9y8Pq0B8d4e7Fcgv79KpJvLsJtBl5IeDVOL4Nh7bL5c/DhC6EIWIOcx9JGsh61X7H1VNk+kKjZPckq7t3gt/FR0FlsV2xD2hFaEIsLYC6/SRvwR5cmPOaNxrFNHqTHs6Lhy2EoqF5pl1u/41RJpbWpj/RRBDjGZWL3jwarSfHFd30kopOFepArNq0ywK+cvLR7pyBxS7ZbcfQEzQommdThuW7uUawnTeV6jcj7w4sRErLYHNfNmNiy25XSz6XL1CCjEdhnTHaoEl0XjyqvCglFTXnZQRmmlMntCP69tcb13PF8blgVAdQCcoeCf4ANKYoTY9LU+A/okZNwFxFqB4OenxAvsCBNK+LoyVNokx2zf8QlA/R8K4+8vpRcYdu/VuJubwTo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGVKYVFLN2VPMmpYTGV4N0VkQmZHbHVlQzBNWnNFQUxxTm9mODBoNG1GeWZj?=
 =?utf-8?B?MndJTHRCV041aEVIL1haQWlwSGppNXNrWFZ4RnNWTi84TW5ON3JPc2NPWnJL?=
 =?utf-8?B?bUs3UkdoWTAwazA3M1R0TUw0MEpuUlFHOTdiajRNaU54eTlBbHc3aFZuQWdt?=
 =?utf-8?B?YldmK3JlS1djN05QRFV1eFVHNjYxTGJxQVQ5T3l4YW5QQXlQcUI5ZlZTdGNh?=
 =?utf-8?B?d3hQSXJ0Z2RYT3JUVEhWQ0RuSm1Jb05LSTJpYkVTdkNkc3pxV1p4ZHgxaFRO?=
 =?utf-8?B?SnhrWFN5bTVFVUJIVWYyNkdzWWpla3kxZ1h6cWdkWlFaL0tuWTNLVjFGckIy?=
 =?utf-8?B?Q2g1QUF4OE01TCtyNkpqZm9iTUIvOU1DVGR3bjhYQlUvd0pId01Kc1BkSEM4?=
 =?utf-8?B?MUZuMmw3cFR3Y1pxa2tLZ2hzckExazN1Y2Q3NlBaOTNjaUVkMkoyV1VvNDAr?=
 =?utf-8?B?eTVveFFGc0prNVhlSjFaQXBtb3YzcGN1alExWWEvMnFMbEdaUDBWMFlhMnBt?=
 =?utf-8?B?M3lsV3dZUlAvM0FDdTkzcFVqMHB4MHdoQzZ6ZUtUZU5IOFBJQjlidXgwemVW?=
 =?utf-8?B?TERyYzFKaWFocmhDMHdXbThvaG9nNUpNRDhrb3NoSlBMYUJnS2dSeUFWdnl2?=
 =?utf-8?B?YzhRNS9zbW5FS0NmS3VMdGhwT3hQZk5lZDJiUjhGWG5VaHFsYk9WUkV4RlNZ?=
 =?utf-8?B?dkhnOXRDZ3gvTVlOQ0lSZ2xETVlJUlBaUVJJcVd2TTdOb2RuOXJQRkJ4clZV?=
 =?utf-8?B?ZENvQWk0UTdDTWxyNWRPN2t4ZVhZTUI1RGthOWwwQTc4NjltUWE1N1c5VHdl?=
 =?utf-8?B?MjZZQ2NwdGgxaWhpU0dqcHRiTWwyYW1Yb1hobWtiN2xhSU5zWHdsY2dFMVp3?=
 =?utf-8?B?c2FjVXB2KzZhZzJLeElNRkE0Ly9kWiswRHhNdk9FbThZeUZjWGs3SUh4dWtX?=
 =?utf-8?B?VmRNcHhTdFBob2Q3K1VKOHFlZDVzMnB1aW5WNUxyUUo3VDEycE1JOXhualJH?=
 =?utf-8?B?c3VZUW9BcE9wVWNzQWlxWGQyVElqUVdPeU5GcGlYTE9naWtoV0dVUng2b3ph?=
 =?utf-8?B?WVVrSWJOaVNhUHByelZZVUt0aUY3alpzMnpoRlBiRUhTampqTkZDV0FZbjVV?=
 =?utf-8?B?eGtva1FhL0tLb3lkSlNjcmdaN1hOQnQrbVU2MUR5bERoUWxVWnB1b2FOMTc0?=
 =?utf-8?B?R0p1WDc4ZjJCcTVBd1BTTVpJRUd0ZFU2aXloMEdwcXVIdFFwemlQTVhVRzh4?=
 =?utf-8?B?TDNlQ1k0UDZMRW9VSHN4ZWtsU0hURkcwTHFtMHVhMHhsYlJadkxqWGI4Sk10?=
 =?utf-8?B?K0t2TjNvM09IZXRFME9DQmdCMlM3OGRSUWcvL1Y3K1hMazBvMmJIRVVsOUpl?=
 =?utf-8?B?NnQvdkxyQ2x6OERESGs4YTZnRy92aE9wQ0RMTXlCMWZWT0RDUHMxS21SNzFz?=
 =?utf-8?B?b0h5M3ZtVVBCanpYQUUyQTlrZUxFVldyM3BLSEtZS1BJeE94T01lZ3ZESXVl?=
 =?utf-8?B?dzV4RXFPY01MdUlOekthMUo1SDMwSlhRMFc4VlkyRnNpOWRVNU9DWmVGaDFv?=
 =?utf-8?B?K1ZFc1NuTlRIOHU0UG1sUDYwT3p2VTdsbEtSOVhSMmsvaUJkWElWQnZrUDVv?=
 =?utf-8?B?UDNyM0FGanRnYU1MMXliaTE4MUJpM2F1NHBTWTFHcHJabjRPQjZjOUxMb2tY?=
 =?utf-8?B?TGtnSEtTeGdYekhpaHpMWlBOWExLSkloeUU4QzJacDBiamxuRndFK1d4aGQ1?=
 =?utf-8?B?aTd6WktFK2RlWkFrMk5oMUk2bUlFbUVYY2dNSlJGN0xjM1ZWQVd2WEpyUG8w?=
 =?utf-8?B?THFFaHZmM3FRWGErYUNVdDNpaWF6Q1FBMEI1OFNXRlZxSW8zT2FPVHFhU2V5?=
 =?utf-8?B?blpidVgzOE1DMUx6Zjg4RzRibXF0R2tiTUNnejFuenVReTF6WEw0RlNTUnZz?=
 =?utf-8?B?RDF4bTZRbjk2R2VLZVlqQTc3dDZndlJQbk5GMHF0U2IwdE5aY3c3cTlNN3Yw?=
 =?utf-8?B?aDhPSmVRVHN1MmZPYnVKbXF0bjV4eWdYSlNuR2lzVlFrZW1pUC9tV1MzSi8z?=
 =?utf-8?B?ZzNTMVdweXV3Qkp1WUlMdlFFZXhCTDA1N0h1Wkw3ZlRsWTlTQWpVdlNGRUVW?=
 =?utf-8?B?Q0NRa3FzUmdYYldTd1RQbGtBVjU2N0hoeTFnQ2pFRWZqb3pNbUxPdWJwa1dl?=
 =?utf-8?B?dzhSS0JrNFR0azl1MGpzdlhpOWh3aXFTRUszckM2d2gwbzIvRU9reFczYTQr?=
 =?utf-8?B?d1NtWWNmc0tPNUovWmdvU0p2Z05lTFRHY0N0OTc2Mkh2empBMjUzNXVUWldZ?=
 =?utf-8?B?SGFDMytRN3gvbVVHc2g1cTlCTWNScm5iT3NmQWppZzNHYTBYRVp3cTU4Y0ti?=
 =?utf-8?Q?aE3VdsLru1vF4xmDU0OHZvRJU5yOIFgfx8fiXnBlu2WEr?=
x-ms-exchange-antispam-messagedata-1: v75p4btSSlE5Kg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FDA1EFE150C07419731DFAD3FA9A3D7@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f5456394-d9d5-4d0b-82c4-08de74f96543
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 05:39:22.7575
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VkFU08HJ71dwGZl33dLG8wEaFw4zzwyjRTtcQDojjXOm37sFc/VKuOP/c7ezFNQxjzVL6TnHGYUqHAGSNh1LLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

T24gMi8yMi8yNiAyMzo0MSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IENvbW1pdCBh
OTRiNzcwMTBkNTYgKCJudm1lLzA2NzogdGVzdCBpb191cmluZyBwYXNzIHRocm91Z2ggZm9yIE5W
TWUNCj4gYWRtaW4gcXVldWUiKSBpbnRyb2R1Y2VkIGEgbmV3IHByb2dyYW0gbnZtZS1wYXNzdGhy
dS1hZG1pbi11cmluZyB1bmRlcg0KPiAvc3JjIGRpcmVjdG9yeSwgYnV0IG9taXR0ZWQgaXQgZnJv
bSAuZ2l0aWdub3JlLiBBZGQgaXQgdG8gLmdpdGlnbm9yZS4NCj4NCj4gRml4ZXM6IGE5NGI3NzAx
MGQ1NiAoIm52bWUvMDY3OiB0ZXN0IGlvX3VyaW5nIHBhc3MgdGhyb3VnaCBmb3IgTlZNZSBhZG1p
biBxdWV1ZSIpDQo+IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hp
cm8ua2F3YXNha2lAd2RjLmNvbT4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hh
aXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K
