Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795879260;
	b=5NqvBkXBo8p2QRyCNOlNCqiYPnfeLVhHQ9k6sa7e/+Ne3dAct3hREvt9NQzEho+g2ksD
	 44Ght+FaasCXZUxUDbRIdMnmZXhjMMFWZi3NtxOmP+t8CktzynDSUsLF4SO8M2hCBegSU
	 S1QzEGmD8bLIsCM0pCBab6NUA4/GejKP0yvJxTRYwBNJHahbr3AgM8hMVPd4LMq3pch16
	 grLqRARcYplnw8i3BVafiU2mzSFhq2hmOfHOfelMp8OgYpBothw+rk4eOa2Eu0UarhpE3
	 ciREGwhoThVIPF1I4YMNHgD1uwH62jUdTDjrP3hZh9yLt8WFUhuL79Jlegl1gttCJFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879260;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=mchWj2K2sGcCW30L5i8XA0W2Kgib9IjwRgVmLWzNhH0=;
	b=34fmHaq7o6kSfiqluBZ+KZBiaj9T/wF/NyJ9YhfWw2/fwvUAXBC9bSnFjWvze0Axakr8
	 uKEl1PGj7wJTqNNDf4GLJiezOWJWp67QZksqBRN9fGMPcV780MHdOCGS8NZGnGiYw6T/+
	 2Xjxm/f38BqRdJ65cYnQoMQo3nxL1hLuYxk4f2zHGfQ5pCcrja8LMXX+OQigFyd62p+ef
	 j7j9Xnixmy6d+dLCZRP/0v8aBinrR5N6WrFKkBNhRxfMBiJKGNh7fot1vF+Hr1Tu14pv0
	 lxxqRSmoFv89lL1nwrPFiIjE3BHaCOLJUGMR8/MYhu8slWcKF/8liFhTfEfhFmsUrUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=vmb-tech.com;
	spf=pass smtp.mailfrom=vmb-tech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.129
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020129.outbound.protection.outlook.com [52.101.195.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424BE606A31C
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424BE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vmb-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmb-tech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOqJDn3FsAkY1rnswYyrlPs3WY9oPGdFXddd2BGSlxqNhE25fzNpMuwHhvmiz7kYSSXRo+eUhgo+UPQQcYwJV8tD8On/v5bY8KgbbRerPKd9Xep8otDy9WHrB8nAfZ9xQAamzpchFV7TSIsfigfieThMXQ0aMrKvN+KVcueSt7/knvhBSW4d7ccLGZWINckVhwmBVfl2jHiFoCHS1VH2nL7wsx7tCgAsgzMlzWVw3vMN7UM2MfZyjBs722xtkdpbISMJ+iz0PWy1kPq7JhwwQyg2eydLNYDJIaksnKkdLkVNlTKRpeUkC/fjAN54Z+Ljmzr/uThAOYhF9x6UJY9p/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=mchWj2K2sGcCW30L5i8XA0W2Kgib9IjwRgVmLWzNhH0=;
 b=GudyJ6FPFDOuncmesOd8r+OUumAu6LqJ+zIOEaAhtQu+0AJzWRFR7HzYoBK0AD9KVKbzwRL8jcRhJDVwfBV49jDtKnEj6bIfMTJdcXdsX2AyA9hlC3fuS/hXvjAFIGZgrXIsXKht0l7JPgVcFr1poz54eK/UUlpMPkaRhqybMD0zjXjUWt+2D0LdyUpIQNpXIyc9GzCmEshaVgFXQ9eBnrtyXzMuOgErim4/9FlsvO4zM62XuWaj2vTfXH//E9A5g94hMS8lYZWIz0O4YSzEP8dCLuuwyIH8deSIciLBIh6EU39dxrJ9K9/WPINwOqlqLyenPT7b18mSMh+4Gpb4IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmb-tech.com; dmarc=pass action=none header.from=vmb-tech.com;
 dkim=pass header.d=vmb-tech.com; arc=none
Received: from LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:490::15)
 by LO4P123MB6449.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:29b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 15:20:56 +0000
Received: from LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM
 ([fe80::da2d:8a3f:ff90:b208]) by LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM
 ([fe80::da2d:8a3f:ff90:b208%4]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 15:20:56 +0000
From: Ville Baillie <ville@vmb-tech.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Ville Baillie <ville@vmb-tech.com>
Subject: [PATCH 1/1] loop: retry short writes
Thread-Topic: [PATCH 1/1] loop: retry short writes
Thread-Index: AQHdf0wQBOHnnre3GEKzasL9qMWyPA==
Date: Sat, 28 Nov 2026 15:20:56 +0000
Message-ID: <20261128152053.1898233-2-ville@vmb-tech.com>
References: <20261128152053.1898233-1-ville@vmb-tech.com>
In-Reply-To: <20261128152053.1898233-1-ville@vmb-tech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmb-tech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOBP123MB8521:EE_|LO4P123MB6449:EE_
x-ms-office365-filtering-correlation-id: daeda4bb-6c9c-4998-4952-08df4d63330f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|38070700021|7055299009|10067099003|56012099006|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|261009223027099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 826/WBLrohPKhrxVvWu7hKqLVfwJE55t/mqVXFpX3/49YzxyqK5P0Y+Xp/cWFGsWZnerOUzptrmLODPjbw9iBUkF2MkNTgaRc9jdjIG+iZpzqEQBdkla5StSdR+h9zFldmvdnVIi7GQ0gGOV/pwjm9QPq64WLRQjfx7o+GgaaXzCz0zfWsgD525xOIn9W6+jE9vJZSC46l5S+6/zotNWS5Ar6FG1iX/kAIZ5Z4VHADDMVI0IrJvSX0z7ZLYGvZtwl7aMYJVAdMGQsq8BIODtrDaGAOytCMVXkJFhrpn0sBAwRyKZGOg12NdQYKl/Rk6QQALD/cDwH9V3mZhuw7aWwcPx6nlhYQWjGeVT8aoyyXSVNJMyY2h8KY9H1W8TIxgOiwTfuz4CHQogq1jmRsmBAv4XdUhz/AP20yDZbSUFewb1Je1CVse6DtjaM0OTsnqG2BTpJqtJYzPte/OvsU2iG86D+AYyxP6M7dOzxYL8LLvhFhZSPLKYzsei3W1jzZuPCx8/b7hXqb0tjlNgF2nyKPvvRBv6ix19HFx0ED7RIcQRGca45fBnD6wZEmxYO+Axc8+l0NAXxx1TQZirmG7854tT+HYeyEugIROngCySgyThV/5y4Pg9rQQA+yFe1j9q//5fDPugh8ZlFhG9ar4InK5ob3yR4nygBbl0imLM9NzGB7cc8s8dgShdbhk12WATbITScDQ9UOlK5pRSbFRZlGF+lZ9TUHJ0uvojaPTMHz1tvdRWuNrtvmYF5RMuL3Ir
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(38070700021)(7055299009)(10067099003)(56012099006)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c040M084WURMVTNJZHNOdkZtb01PMnFNOFA0Q3lGcWo0UXdBUm1PZ0JseGwr?=
 =?utf-8?B?VG9WZCticWRkTzlncEU2d0EzdTN3S1NOV0FJalRtQkM1eWVhVXllaGJaUEdo?=
 =?utf-8?B?ZTlIUko2SldSblVsZ0FYTWFpRUxCVEJVdUJGTjBRaW9zSk1IUnl1RG1XaU5x?=
 =?utf-8?B?TlNQSlYxNEhRZG83bmdMSXcyMUZCTzk2N2hCWkZnalkvdHlTTVpxZEdzdzI2?=
 =?utf-8?B?cUgxbW1oSmczZ1I2L2pvalRVajRLbU5JdXIwUDhaSjY2N0l1YTJlSU9pVUxK?=
 =?utf-8?B?VVhxWkpoRnI3VmZGcDFHV3hRUXJ6VTkwb0c1NFpEa0hhRk1lVi9xeERZckdr?=
 =?utf-8?B?eERFTW5JeHZSaG13TWlWRWxaSnE2amZWZHh2TDlkVFdEbW4ycDNVbC9wOE5z?=
 =?utf-8?B?cGNIbm14SmtlRitnSHROWjcrQVVHM3dwTElMZWpFbS9aWm14d3FqU1FyM1JR?=
 =?utf-8?B?NnFWTVl0WU02Z1RFNVBqWmx2NExFTEEvYnoxMUlLNkw4ZUdvMC9lK2Q3bDRE?=
 =?utf-8?B?RXpxcG5BaFhibklqeWZ3azJReDJadVlpbEp6bVF5NXROYU1HS0xScVlFSUdo?=
 =?utf-8?B?dTJCeXpVclJKSWlsZGp5aWUwV2QxcklWU1ZabUkzaUxnVnVSU0tGNXRIdmsv?=
 =?utf-8?B?YW9HazZwZEhTdlJzVXcrK2pNQ2JRVVQ2aFV6QStzM1J0NW5mcEFtT2FlMTh6?=
 =?utf-8?B?elNWYUlwamdKamlxWWxxLyszcHBSMHN3bmxwbVlTZzZBUlFSMjJTUUlvM1Y4?=
 =?utf-8?B?WEIwVjlDTU1XckJ2Mjh1Vy8wck1ialFKalozUGZUWFBLOVZmejdKbG9SV2ZP?=
 =?utf-8?B?alhyeHlYNzFucS85UmNZbmlzTTNvN25tb0t0QldiUXFSU0l1dHlnQmw0VU5C?=
 =?utf-8?B?VVBzSnhCU3pUT28xYUlnU1cyOU1DWjZ5OE0vbkxaK1dPcjZKcXg3b1paN1RO?=
 =?utf-8?B?aVVDcHlZZFVGb09GVnhqdjI4M3NOSmdlMWZTck5YcHJ5Mld6TkRLZ3BKZDMz?=
 =?utf-8?B?Yk9CUWNzZDRmUVhJNWw0YlVlY2FtenFxdnQxdE5KVXQ2TzRCT0I5RDdaUncx?=
 =?utf-8?B?YUZ6TDVabWpIMEg0TzRKTkkwN2dJNG1kNVNyV1JUdklJRDZoUENhU1Yxblcx?=
 =?utf-8?B?WGNQbUtKeU9kKzVVT0UwemRjWHlody9uM2V6SlVqNjJjblpPVE50VnJ6c1hh?=
 =?utf-8?B?bHBDOXpYekZJcFdVZkdqMm1NTExyNHVDN3dpNE14c2tsQWJtMVJqZGUwQzJi?=
 =?utf-8?B?b01oN292MTRWd2o3Rm41TFIvTEV3Sk9uQy9vakxXR09ib1dHZW12TkVncUd0?=
 =?utf-8?B?cnk4SmpBZWtFSG9RelZ0cmdOZVpHNlhoVThDOFM2WWR1NEZiVDVyc3dZWnNH?=
 =?utf-8?B?U0dFZlZpK0pwVkRPZWh1N1JiYitQaVRVa0t1UEZYUEhNSU9xYUdTTVc0R1hP?=
 =?utf-8?B?aHdDQnlPR0l5SlNDRHBZbHZqYUxYeFdodG40cCtqOHZrdFpacGtnRHpHRFZo?=
 =?utf-8?B?UitWTWFWdTBYeU9XMWVjMWU2Rit0bXdOc1RYM1AxUTR5M3Qza2xralNyYVdk?=
 =?utf-8?B?TnRGMG5xSW95aGFRS2U4QnVneUM3WGZuZWFKTlNPQ1JZc0xkV2ltZUl5anZV?=
 =?utf-8?B?ZG5RSlJ5NFVKUkl2MnRiWmhwVTRScEl4Rk9lOWxqZGtIQzF6NFk2UWovWWxK?=
 =?utf-8?B?T25qRnJnSlJhNEV0T2lVYzQ1Tk1sSXRZbklPc1VjdFVrSE9uSjFQY2VCT2JR?=
 =?utf-8?B?NjlsQUVHNTBwdU11Rm9naEZMZjdHQkZ3cDI3NWZJYmRUc0lMTlVIU09aMHFU?=
 =?utf-8?B?L0NYbmJ5M3lRVVluN3JDd2JqeCtSWnk0QlhMd2tINzFSa3FUSXpERUc2U09p?=
 =?utf-8?B?WnV5YTBVV0hhakN4U1M1SHBFRUxlRUhHbnoxdk40R1hseUljZ21DZzZvbXBC?=
 =?utf-8?B?MGNKNDA3bllEQ3k1ODFCaEw0bVdIOUJnTE9GVVZjalBjbFBGQ0JzdEJ5Mks3?=
 =?utf-8?B?S0t1S21UYklYQ3kyalN2YUlDdGdISHZaUUdvanh5MnIwVzF1ZmlaVHczaEh3?=
 =?utf-8?B?TWpLa2wyeGl5L2xyUFdINGtNNm9NbGNpZHdqc1lJcHRaV255VGtZT1pTbW5E?=
 =?utf-8?B?WW5iYStKOWJENG1ESVZBYXkwd2djTTg3cVZaTkx3bmZtRmhtTjNVb0lYZldh?=
 =?utf-8?B?OHhTY0laeWJDTzRIWW5VQTNIZWRtQVNTTGdFS3BFWFlyU25taWFCYUZhQnNS?=
 =?utf-8?B?MEZVL2kxY2ZUZ2FqODI2MjJSNUsxNXJob2NvYlFPSnlTa3dtdjZtamlnVlFL?=
 =?utf-8?Q?LEQCO2skRZ1ZOTXb6c?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: vmb-tech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: daeda4bb-6c9c-4998-4952-08df4d63330f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 15:20:56.3104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e8919be-361e-4fdd-b7d0-79a9f2e3ed0d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPdMe9YFzcA1NTC8WefAWl0DHlMwCWxIQoWnSHdNuoDj2QwbmVgu9WdT320vqDHKx6KplvjTlh9Puvs9Pz5MdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6449

RnJvbTogVmlsbGUgQmFpbGxpZSA8dmlsbGVAdm1iLXRlY2guY29tPgoKVGhlIGxvb3AgZHJpdmVy
IGNhbiByZWNlaXZlIHNob3J0IHdyaXRlcywgYnV0IHRoZSBjdXJyZW50IGltcGxlbWVudGF0aW9u
CnRyZWF0cyB0aGVzZSBhcyBzdWNjZXNzZnVsLCBwb3RlbnRpYWxseSByZXN1bHRpbmcgaW4gc2ls
ZW50IGRhdGEgbG9zcy4KCkhhbmRsZSBzaG9ydCB3cml0ZXMgaW4gYSBzaW1pbGFyIHdheSB0byBz
aG9ydCByZWFkcywgYWR2YW5jaW5nIHRoZQpyZXF1ZXN0IGFuZCByZXRyeWluZyB0aGUgcmVtYWlu
aW5nIGRhdGEuCgpGaXhlczogZjJmZWQ0NDFjNjliICgibG9vcDogc3RvcCB1c2luZyB2ZnNfaXRl
cl97cmVhZCx3cml0ZX0gZm9yIGJ1ZmZlcmVkIEkvTyIpClNpZ25lZC1vZmYtYnk6IFZpbGxlIEJh
aWxsaWUgPHZpbGxlQHZtYi10ZWNoLmNvbT4KLS0tCiBkcml2ZXJzL2Jsb2NrL2xvb3AuYyB8IDU0
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibG9jay9sb29wLmMgYi9kcml2ZXJzL2Jsb2NrL2xvb3AuYwppbmRleCBhMzMyNWNlYWI0
ODQuLjNkYzY5NjU5MTJlMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ibG9jay9sb29wLmMKKysrIGIv
ZHJpdmVycy9ibG9jay9sb29wLmMKQEAgLTI4NywzMyArMjg3LDQ5IEBAIHN0YXRpYyB2b2lkIGxv
X2NvbXBsZXRlX3JxKHN0cnVjdCByZXF1ZXN0ICpycSkKIAlzdHJ1Y3QgbG9vcF9jbWQgKmNtZCA9
IGJsa19tcV9ycV90b19wZHUocnEpOwogCWJsa19zdGF0dXNfdCByZXQgPSBCTEtfU1RTX09LOwog
Ci0JaWYgKGNtZC0+cmV0IDwgMCB8fCBjbWQtPnJldCA9PSBibGtfcnFfYnl0ZXMocnEpIHx8Ci0J
ICAgIHJlcV9vcChycSkgIT0gUkVRX09QX1JFQUQpIHsKLQkJaWYgKGNtZC0+cmV0IDwgMCkKLQkJ
CXJldCA9IGVycm5vX3RvX2Jsa19zdGF0dXMoY21kLT5yZXQpOworCWlmIChjbWQtPnJldCA9PSBi
bGtfcnFfYnl0ZXMocnEpKQorCQlnb3RvIGVuZF9pbzsKKworCWlmIChjbWQtPnJldCA8IDApIHsK
KwkJcmV0ID0gZXJybm9fdG9fYmxrX3N0YXR1cyhjbWQtPnJldCk7CiAJCWdvdG8gZW5kX2lvOwog
CX0KIAotCS8qCi0JICogU2hvcnQgUkVBRCAtIGlmIHdlIGdvdCBzb21lIGRhdGEsIGFkdmFuY2Ug
b3VyIHJlcXVlc3QgYW5kCi0JICogcmV0cnkgaXQuIElmIHdlIGdvdCBubyBkYXRhLCBlbmQgdGhl
IHJlc3Qgd2l0aCBFSU8uCi0JICovCi0JaWYgKGNtZC0+cmV0KSB7Ci0JCWJsa191cGRhdGVfcmVx
dWVzdChycSwgQkxLX1NUU19PSywgY21kLT5yZXQpOwotCQljbWQtPnJldCA9IDA7Ci0JCWJsa19t
cV9yZXF1ZXVlX3JlcXVlc3QocnEsIHRydWUpOwotCX0gZWxzZSB7Ci0JCXN0cnVjdCBiaW8gKmJp
byA9IHJxLT5iaW87CisJaWYgKHJlcV9vcChycSkgPT0gUkVRX09QX1JFQUQgfHwgcmVxX29wKHJx
KSA9PSBSRVFfT1BfV1JJVEUpIHsKKwkJaWYgKGNtZC0+cmV0KSB7CisJCQkvKgorCQkJICogU2hv
cnQgcmVhZC93cml0ZTogcmVqZWN0IG92ZXJzaXplZCBjb21wbGV0aW9ucywKKwkJCSAqIG90aGVy
d2lzZSBhZHZhbmNlIHRoZSByZXF1ZXN0IGFuZCByZXRyeSBpdC4KKwkJCSAqLworCQkJaWYgKGNt
ZC0+cmV0ID4gYmxrX3JxX2J5dGVzKHJxKSB8fAorCQkJICAgIGNtZC0+cmV0ICUgU0VDVE9SX1NJ
WkUpIHsKKwkJCQlyZXQgPSBCTEtfU1RTX0lPRVJSOworCQkJCWdvdG8gZW5kX2lvOworCQkJfQor
CQkJYmxrX3VwZGF0ZV9yZXF1ZXN0KHJxLCBCTEtfU1RTX09LLCBjbWQtPnJldCk7CisJCQljbWQt
PnJldCA9IDA7CisJCQlibGtfbXFfcmVxdWV1ZV9yZXF1ZXN0KHJxLCB0cnVlKTsKKwkJCXJldHVy
bjsKKwkJfQogCi0JCXdoaWxlIChiaW8pIHsKLQkJCXplcm9fZmlsbF9iaW8oYmlvKTsKLQkJCWJp
byA9IGJpby0+YmlfbmV4dDsKKwkJLyoKKwkJICogWmVybyByZXR1cm4gb24gcmVhZC93cml0ZTog
b24gcmVhZCBmaWxsIHRoZSBidWZmZXIgd2l0aAorCQkgKiB6ZXJvcywgdGhlbiBlbmQgdGhlIHJl
cXVlc3Qgd2l0aCBhbiBlcnJvci4KKwkJICovCisJCWlmIChyZXFfb3AocnEpID09IFJFUV9PUF9S
RUFEKSB7CisJCQlzdHJ1Y3QgYmlvICpiaW8gPSBycS0+YmlvOworCisJCQl3aGlsZSAoYmlvKSB7
CisJCQkJemVyb19maWxsX2JpbyhiaW8pOworCQkJCWJpbyA9IGJpby0+YmlfbmV4dDsKKwkJCX0K
IAkJfQogCiAJCXJldCA9IEJMS19TVFNfSU9FUlI7Ci1lbmRfaW86Ci0JCWJsa19tcV9lbmRfcmVx
dWVzdChycSwgcmV0KTsKIAl9CisKK2VuZF9pbzoKKwlibGtfbXFfZW5kX3JlcXVlc3QocnEsIHJl
dCk7CiB9CiAKIHN0YXRpYyB2b2lkIGxvX3J3X2Fpb19kb19jb21wbGV0aW9uKHN0cnVjdCBsb29w
X2NtZCAqY21kKQotLSAKMi40My4wCgo=
