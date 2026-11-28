Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.116
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795879257;
	b=Wm5AxKj/UfJaWmhuihu4VVhRtHIp9YgbgVH5e2IsgJ1DE0AqY+a22YjjdQ6Rn7FQLNqs
	 A3qOl4dUEl0vUr6gePX+O7XGR1tlRKKFCReM4yq4f+/Xmr36a3Uor5buyhWnAn70iBPYi
	 /xbYx+b5pdQI8ZiD9qYcZXWnbNr9yo4uvgoT8t2OYU6HJE/0SXs9GY2cWLBr0Obnfnj2n
	 DAdHthBU77xqm0Huq5Bx7rAyzXCIX3nNxZROEANuVS9tzDkcbKAtFJh3iibc0YvRXsfW5
	 gTE0uuA8msqpBxZBA6v4eF1iYvUycdRlOs4khwhcJVtJPz2appX0XNC3CeUlZtwpVTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879257;
	h=DMARC-Filter:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:x-ms-publictraffictype:
	 x-ms-traffictypediagnostic:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=VGZ/iKQLtzj2EKKRm4frJA9zLTvhD7gb1ma6alf8NnY=;
	b=qMc9ggZOilxn66x9SYfaD9p3uTvDitPZODJU9v2FUM7jzbpagXmClFhld/Zxqy7bRo1S
	 7kV45hrI8+ZnfpeHPkVH1o0Qt1R52yzOa2o4rLwTatKdLGxbzuQGovPNASla199sJY5hZ
	 l/E6zspWZLvHlJcrXPnmWlro8tl8v3j9lBwN1YXSCg2dHrAygPGy6s5RJAqseNrdYLviu
	 HVlC6/6infth5pinIHRFZI5ACn13/Cfd/YVxAmBayzE2VuCFhIu1mIMPxDAzUPCksorU+
	 rJMUQybH7to3XgODK8Mf4VKb7nGSe8c7BlXQqZUVbSD43Pbf7ozBgATTpYXYkuas4zw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=vmb-tech.com;
	spf=pass smtp.mailfrom=vmb-tech.com;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.100.116
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021116.outbound.protection.outlook.com [52.101.100.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4470C606A31F
	for <linux-block@vger.kernel.org>; Sat, 28 Nov 2026 15:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4470C606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vmb-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vmb-tech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wyx4yDMp7rmY2C1+//ZY3Abc15hOXzATmFz8oAHhJalTuRNHL2j0HErysD7qJCYtTYCkeFmRV2WC4fz+0z8YzAozLD7ezjJI+HGkX4RQo7/0IpOGEzTJOk/jIHLgPZkpPBdIa0ZKgfb7u3AiXgsMaacjDnWoz1JBa75P2Ng3jB/WHMcnaQxIg+/8Ic4ySqRgo4cjVUgQhqHyaAxPpRWBDkwnJob/Stisy/5Y45kqF9+XjB1dYXbwsIaIJJI1nGcZzkLy31VHbZdPxrYp7xnhjIe+wETnAEOpf/1DyOqpq4hKIAtXxyXJCR1a83gaF5AYPchjKpmqCB2iCxKxqcYS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=VGZ/iKQLtzj2EKKRm4frJA9zLTvhD7gb1ma6alf8NnY=;
 b=Xg+m18IAzngwbsIN7DIaSALC+/VleNY4idFtwAHow9zXWPXERVuM2H5tBM2vc1in+R2jp2aftwZsCnI+nYF4tdcS/T02H8p5QMRibmxLQBcAJ7qri9rmWa28EPoWc7iLq6+8T13J2I3erF/kw0tAHjCd2Ls66sOEamlYBDDgdgu7Uk1+S4YfDoIBxbvFMrmqQ1tUcGvGisUtfW2/GRb2lm+TGm+WTDAG5JZVJmKpNPpY2o3OrDYi7jnRusry7bFLnPjvRI8zau/p65HxfZZypihOj94MfBO5MYpc+lRL4ZNQjDsVzqDAbknqY+sTN9Vlh5I2MYpYJwyR75A5ArVolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmb-tech.com; dmarc=pass action=none header.from=vmb-tech.com;
 dkim=pass header.d=vmb-tech.com; arc=none
Received: from LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:490::15)
 by LOBP123MB8220.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:440::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Sat, 28 Nov
 2026 15:20:54 +0000
Received: from LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM
 ([fe80::da2d:8a3f:ff90:b208]) by LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM
 ([fe80::da2d:8a3f:ff90:b208%4]) with mapi id 15.21.0662.007; Sat, 28 Nov 2026
 15:20:54 +0000
From: Ville Baillie <ville@vmb-tech.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "ming.lei@redhat.com" <ming.lei@redhat.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Ville Baillie <ville@vmb-tech.com>
Subject: [PATCH 0/1] loop: retry short writes
Thread-Topic: [PATCH 0/1] loop: retry short writes
Thread-Index: AQHdf0wP8Ph+SmlA8UOwEIajvomBOQ==
Date: Sat, 28 Nov 2026 15:20:54 +0000
Message-ID: <20261128152053.1898233-1-ville@vmb-tech.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmb-tech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LOBP123MB8521:EE_|LOBP123MB8220:EE_
x-ms-office365-filtering-correlation-id: a79be1b2-2679-4948-d7cb-08df4d633229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|10067099003|56012099006|261026140227099003|7055299009|261022105027099003|261028144727099003|261102123227099003|261022075727099003|261021121427099003|261009223027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info:
 Xn4VRpbjpR03NhHwpDEj6DjJINdQuTVyaRcJuv+cYJpTmTuDsEbH6oybwt3UoMm8DTQpWfNldrFgfbDWRJugfbobcKFyZdr5r+tUby62HJbTyCW1RVcetGurF87D3pHeuIoJzNSii7msrAlruIwT1nBpjRs9vkOet1XKQ+AWyMfXFFY8lgMAU6omQuQjVOhfOTTQ7lUWVwidgh0mmXha4it5703fSwjW+E6NoIX9FB19Bed0A0e3ku1HXG/zXgARCbbKHwODFX7oG/3rrjkyUipIR2LUVrnew0xaY3j2A8VY5N5BF7bnoLlZmQE7XazXb5Uz6f31M+mIgaEJZyzQgCISaWFlucUPDv70aNPYWPlYZPL2f9gnivSbsEg7xQlu6LUbL0sCwbVXF79qOCkawJM6R4e8arwiXUy0XS2dVi4PvPFHve3U8W0S3f/GmlvXNBnqWq0t2G/Y4zNkjvPghANjPuI/RH7uG+oYg/Duu/LhSFFTUAW2181y3LXAs7XUPniQfrTp4k7Bm4wjL5H6rKQn82TUm1nxGdbgr2d41+/4xOqbmLSQFQWIvpDiJkElloSJ4kmCR0i8qFGMzRXcJDl1g8cfwyZhOdPLmPhmCaSQMA8lJiJY7i+iYy/gB0/VwMsy/QDirayZhFu2/KbbU95b7zh32zfSS7zqaZm8lQeeac7VCTcBBfgh5zKOrA//JQuvbNyT+O7OboW6SQZsjL51GIDyFrSfzNS9BaHFo5GjlxKG53GBswceU4k4fv+3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOBP123MB8521.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(10067099003)(56012099006)(261026140227099003)(7055299009)(261022105027099003)(261028144727099003)(261102123227099003)(261022075727099003)(261021121427099003)(261009223027099003)(261021123027099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2Q1SFF4TUVnVlhFVXc0bjJtaThHQ294dHlZVnNiOUJoaTQyM01ocDV0TTAr?=
 =?utf-8?B?U2ZLS2tYakIrUS8wV2xHUzZZM2NxeE9tQ1ZlQWx3WTI5VDF6SzMwQUNaU1c0?=
 =?utf-8?B?ZGE1MnhiVjRjMUh1Tkgxc1dhbHkvMkw5SDdPekdtSXVVMXhtbzU0ek1KWjM4?=
 =?utf-8?B?eFZZUmRCM2YxQjBsdmdUOGlCc0tTaXJXZWV6L29HZTgzQ1pkVUxhSWtOekxS?=
 =?utf-8?B?dVEyd2lwTG5NUFlGK2xaV0xKRTd4QWo0bzVmVXNsMDBpTitGM05FRnNsZUtJ?=
 =?utf-8?B?RStnS29pc3RreHJiZmFTRE9yL2h5aFF5c0tYcXpwMDN3V1ZITkJnaml3K1VK?=
 =?utf-8?B?eWdRYWJqMVFENWNCLzd4VGxmNnE1Vzd5MFk3U1pXNkgrcDF1UExMV0JKWnli?=
 =?utf-8?B?QXpBQUQwUGhaTUdxdVNRanpzajBxdkF1OE9hdWxkb3pmZ0p6QXY0d1RzU0hN?=
 =?utf-8?B?OFV2QW1YNmxlZ0xoS0FKVlNwNmY1MHNnVVJBM3FrU1gzNTV0OS91QjZ6TTI3?=
 =?utf-8?B?bXltdHFudnN2bkpHMTBuRTZuMUdEWXdkNWVabUpQZjFTaHRXbHI1bTM0dGdy?=
 =?utf-8?B?NGwybnFoSDlaNDgrTzk0WElZNEprNkZJR0NTdHVmUkNaeXlDeWdZMjY2a1d4?=
 =?utf-8?B?QzNlSXJlL1lyZjVVMjNmRkdkZjFOc3hEdElITHpIQmM5eitSSDh4TWhlVlJY?=
 =?utf-8?B?M1BoNFA2bXZTT3hCVVg3TGNCVjJFejBqVEwvMjdrNEFzMGhLRzliUkgyUStO?=
 =?utf-8?B?R05pcnpEVFZtcGVqTUpUT2N1MnllNXZIQ0F2UU1jTFpSMFZIY3ZVR3BtMzcx?=
 =?utf-8?B?eE5rc1FadjkzK21pRnpLVllhajVVZ2lLWEgyUS8xd3VqUnhPRm5ob1M3bEda?=
 =?utf-8?B?eXZxTmRzRHBuY0dCM05zNDZSL0N4UmxQMThrT0orNE5BWjRtamNrUHpCM2ps?=
 =?utf-8?B?NWVGUFd5RC9RT05VNHI1TE10ckZOQWs5M1lObmZpY204Z2ZQQXExc2hjT3pj?=
 =?utf-8?B?R21xajJteTNhM1k2R2I4VWZaaHViTkUyRzFqd3B6SkpmaWMzaXJzMzFmYUtS?=
 =?utf-8?B?RXVOU1doS01XUXRudTJmc1JDUytPRjRpZURGVnVXS1NvZHdJTERTQjhiZTN6?=
 =?utf-8?B?YUE4Q2NVdEN1WkRXVmVzSUtlNGh1MFlsL2hlVWZRYjJVQ2VjWlNHd3hjaEtL?=
 =?utf-8?B?Qjgxak10OTdTd1hQRG9zMTIvUDNkUm1GUjJ6eWFMdzJBM3dySk80aTRmQ1h4?=
 =?utf-8?B?dSs5T25MZXdjaXZHRnJZcU8xejZ3V3hMK0pweHova0M5WHMzVmZ2TDQ2ZEgx?=
 =?utf-8?B?YTBqMjhLVWllSFpoREo4dzlRM0NUNjIwSE4rUERMSGJROUlzdWNHQUJFcDdl?=
 =?utf-8?B?RHhwUEFPU2JNZlJ6STdQMkU0OVV6ZGg3MGEzSlg0YWNVWjhoUG5mWTZtU0ZI?=
 =?utf-8?B?QVB2TG1IaWxSWXZSRlpqa3ZJNHFMNHdLWVFvWThTNEM4WWRoRHBLSGs0QURr?=
 =?utf-8?B?NStnZ2llQ2tZOFZCckhjNzRCaktTNWJhN21UazUxMFgwaXhVRjR1ay85aTBT?=
 =?utf-8?B?SDJXMGpxejJaQ1pvc3FYSW5rVVBZSnpBMUxES1ljNFYyZXNSK1hlTkNpNlFW?=
 =?utf-8?B?OW55TEpNL2h0UnRlODJMN243T1dGVGdQN0RpUG9yaWpYQkYwSVlXeWdwOHJM?=
 =?utf-8?B?QS9vLy9hbjNDMlBpSmRwTkdraUhBQzdWTFRmOENua3ZXZms4K3AzZ2QwQ1hY?=
 =?utf-8?B?VmVsWDNzVnJxdHNpTE5ZRU9FMDl1alZRNGNVTXN3eXhyMTZuWDFXYnJ5WThy?=
 =?utf-8?B?Y2JFY2N6ZXNnMUZqWlZHYWc3ZnpPeUJCeDdtY0dBdjgzdVpPY2xWazRoVlNw?=
 =?utf-8?B?U1VHOEJyLzZDV2ZjaW5sR3hrdTgzQ1AvNVI1c3RnbnJTUDBVcU91SHNzRUho?=
 =?utf-8?B?UWJQYkpGajNhdVNIN1VTOHZBalZhYm9VM2Q3a1JjR1NqK1B5OGRqMmRUOG8v?=
 =?utf-8?B?NXVXaC95L2RDc0FXVE1ZUlQzenFtaDF4MzQrZGRTVzdQMWptU0NhZ0Q3Mis1?=
 =?utf-8?B?eDFzbTh0U2FueHdkREJuelZBRWhnN2dyaHpIYW5aSDYxcVhGa0pzeXBEYlQ5?=
 =?utf-8?B?cmR3UWlPRmovNzU0SW9sWG1RKy92dTB4cXhJL3JpcG0vaDFCOGYrSDBoOURG?=
 =?utf-8?B?eFBUY3dmYzVucGtXeUFDRUt4SklydGdUNG9VNHVRbExQS2kveEdKTmdIeVRY?=
 =?utf-8?B?Rllrbm96WnJLd1N5SlJ1aGIveDFWMThPemtWUUNhby9uOFM5MEYrQktIUVAv?=
 =?utf-8?Q?2DtFhcXStZcK8Ix+hK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a79be1b2-2679-4948-d7cb-08df4d633229
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2026 15:20:54.8319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e8919be-361e-4fdd-b7d0-79a9f2e3ed0d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGfdj31XhHiK38d/0u5KyvJNcHPHR5wl988symAtiHDtkNKoZAP5e5DmAmWLFman6uudl6Y/06Kf2L5VmqhV2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8220

RnJvbTogVmlsbGUgQmFpbGxpZSA8dmlsbGVAdm1iLXRlY2guY29tPgoKVGhpcyBmaXhlcyBhIHNp
bGVudCBkYXRhLWxvc3MgaXNzdWUgdW5jb3ZlcmVkIHdoZW4gdXNpbmcgYSBzeXNmcwphdHRyaWJ1
dGUgYXMgdGhlIGJhY2tpbmcgZmlsZS4KCkkgd2FzIGFibGUgdG8gcmVwcm9kdWNlIHRoZSBpc3N1
ZSB3aXRoIHdyaXRlcyBsYXJnZXIgdGhhbiA0MDk0IHRocm91Z2gKdGhlIGxvb3AgZGV2aWNlLiBU
aGUgd3JpdGUgd291bGQgcmVwb3J0IHN1Y2Nlc3MgYnV0IGJ5dGVzIGFmdGVyIDQwOTYKd291bGQg
YmUgbG9zdC4KClRoZSBpc3N1ZSB3YXMgbm90aWNlZCB3aGVuIG1vdmluZyBmcm9tIDYuNiB0byA2
LjE4LgoKVGhpcyBwYXRjaCBoYW5kbGVzIHNob3J0IHdyaXRlcyBpbiB0aGUgbG9vcCBkcml2ZXIg
YnkgcmV0cnlpbmcgdGhlCnJlbWFpbmluZyBkYXRhLgoKVGhlIGJ1ZyB3YXMgcmVwcm9kdWNlZCBv
biByZWFsIGhhcmR3YXJlIGFuZCB3aXRoIGFuIGVtdWxhdG9yLiBUaGlzIHBhdGNoCndhcyB0ZXN0
ZWQgb24gYm90aCwgYW5kIHdpdGggdGhlIGVtdWxhdG9yIGl0IHdhcyBwcm92ZW4gdGhhdCB0aGUg
cGFyZW50Cm9mIHRoZSAiZml4ZXMiIGNvbW1pdCBhbHNvIHBhc3NlZC4KClZpbGxlIEJhaWxsaWUg
KDEpOgogIGxvb3A6IHJldHJ5IHNob3J0IHdyaXRlcwoKIGRyaXZlcnMvYmxvY2svbG9vcC5jIHwg
NTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBj
aGFuZ2VkLCAzNSBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKCi0tIAoyLjQzLjAKCg==
