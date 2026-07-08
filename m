Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011005.outbound.protection.outlook.com [40.107.74.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156541C860A
	for <linux-block@vger.kernel.org>; Wed,  8 Jul 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478060; cv=fail; b=vDIOHQ7dwaBKn1Ns1KfMOARRt1NE2D4o5LAvQ8rTaZDtMld7i2eYKml15hOXoXdR7grk3/W2HT4bKDFvUXOeu6DbYWdEOS24q1KAjNpFFpOtUAx1EisA5pHqv4jiJDc+qvbPviPbQKyKtzHaAob9Wvaqb7809ir+GCJtewg43xU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478060; c=relaxed/simple;
	bh=HF9x4jHT2elTMohF8XiqVVKTSWLknsFLHFmsN7v3xec=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YNxa+DpHH0vm6QSeiezxxwiCRZj8tyrf8An4Vh0SQsUbs0LS0rvwa/r5CBYUtoN0Jjgl33VY9qB0yp+uoEWuzHw8X+XKy4/GxXtBGpuSFr6raXLbL7q+wRBKBKWKHiZYb35TRtpOq1RJy2s6Tkh/CIIFS/5a7b3gprDWmPnB2KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XvKorBWA; arc=fail smtp.client-ip=40.107.74.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XvKorBWA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4mmrkJj2F7GzlJ6/i+VCLbx3jmb4hFj403APDY2+aYpeow8R76o00N2xI1jBQztm7rdZqGVs1K+gLeG6sncJn4tgkdnHs1mKUiJIgIbihgOnSn8GUja0qf2g9SKxXJF2rMZsVEDtT5SpCTx8Lm4CRz0CWwfuqryezWT33QOhNSN+ChVVavnP7Tvr31M8+Ta+UM0XaQoZiK917qeDkvHnZm8Gni0LRY+UiqVw9MN26dPkDf3CCHd5VPwc84HsDQIC1MrtnH7L9L1b46TLG6bun6b5X8QJF8cwF79isl9y/B5QGXsKGAUQGmOtYPLQKXAIjAu0aWJEmm8PzD0qv+NQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF9x4jHT2elTMohF8XiqVVKTSWLknsFLHFmsN7v3xec=;
 b=y9qQS3WXfE04Nc+dFYe8/zb+Igj01zP5BEZeQ2lBFILusybpjQ9AFaf0I+TxTAJbTKgDRsZU8awxeOcgKi3DY2xkIsWUhR0wpFgbabk9QR5MyAmvdDK5pCnZSqhamiBNdLB/VxwPs2zisHLv5X+1GPBJlZRgF+1978CUMwtUFG7cEDgH1wYSmSp3b100TJBkm5UzzU9SqXTUz32bjwIwCeu8RmAEb+q8AbmiTcXvV0H/h61Ch6TV88RZS7nsGkYCUttDLZhMIlo13vatYflXZ6n7s1PsD+UEy3w/5e1vqYmLV8REu95Kx0eQ5BbsgigIlL68HZ7NKUF2ZDN6nJqDmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF9x4jHT2elTMohF8XiqVVKTSWLknsFLHFmsN7v3xec=;
 b=XvKorBWAtJyQltUki8MhShqsv8x5I1GYTRR5xJ0D47EuqKHz+AFy8L+cUGsKrsmh0oAjATHJvjMQBwlfs5XevpbMLzHJJ3UmxbkcgGQ1Bs3GnaZVz3v55nfLov0OkXokXJ8WQGOSeAQd/RfhxnGA2VOq4tMTVoW2FKSveEk9EuLazdk2QtxP9aDXvDhvWjv66smrkqYLNntBZvXYqNKea012h4DBIzknrJQVMU+xFWS3enaBc6zKcNVaJxwPqUFuS7I+OxNRl3ZvD/a8grT7hozx35xeVbCsSaHkUjRaOrmotwH5AlabSzin6ogfVBwjdfoMOzePvjPOVWXQzROk7Q==
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com (2603:1096:604:2e6::7)
 by OS9PR01MB14024.jpnprd01.prod.outlook.com (2603:1096:604:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 02:34:14 +0000
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131]) by OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 02:34:13 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>, Ming Lei
	<tom.leiming@gmail.com>, Keith Busch <kbusch@kernel.org>, Yi Zhang
	<yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>, Akinobu Mita
	<akinobu.mita@gmail.com>, John Pittman <jpittman@redhat.com>
Subject: Re: blktests: call for agreement to relicense GPL-2.0 files
Thread-Topic: blktests: call for agreement to relicense GPL-2.0 files
Thread-Index: AQHdDdtPkaqkcYl0zkyDjqinV7SWsbZi6M2A
Date: Wed, 8 Jul 2026 02:34:13 +0000
Message-ID: <3301a5d5-340c-40f9-9816-0d3ead6ce9fe@fujitsu.com>
References: <akyeX0hlcrnOC0nT@shinmob>
In-Reply-To: <akyeX0hlcrnOC0nT@shinmob>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12148:EE_|OS9PR01MB14024:EE_
x-ms-office365-filtering-correlation-id: f965c5f0-837d-47b6-0fe5-08dedc996600
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|366016|921020|38070700021|11063799006|22082099003|56012099006|1580799027|18002099003;
x-microsoft-antispam-message-info:
 1dTRooqMa2aYbkXrPeuNcQWvpVp73++f4Cy7wDhL6Au/8l3NRA1NVcw/ssTgml7P+AFQ/LbIO7i4dNhs3aGUU4QOMiE9eBrF0/wNfojaYPi7W9+YUC8HXEErcEJH8MkyrmrW5UhTuJlhqYiz1vHpIYuZCsx7MYJkTc5smwmXec41Xd/AP2idMKz6vLvOjEW9eo35bhpmmjMqR6Q+tJ65PjVcBWHX2SuNY5GUQaNN1E2fulPJZPa9/YYl4R0UxlLSzeW/ubNKIFrltZ91rMOB1mMyZpB6fb/r3QyKua+Nlm4tVFu7wFnAiybjFSMTXHsjUpfkA5hoeMsho8aOGxCGn1TD8PyG/P39npuNib894bXqTnvS08+ow4rxivxGpXb3EvV5CypuT46f8TdoFdg4HCjdeB2OTRu6ATf8OD9T9yAnI4Dv9cmiBPexCb3/ySpKQFLnX/2sev78idxlGHUgJwlZOcRX67a1jIdC1PKPSzz3+lWfVbX9/lHt1k9htQiqIva8XYesnEPfQH5bQvHE8NxLkKfUt95wy4By6LGq/3XA6pvblO45m7/0crnPvdwB0cHKlzuUGfcykl+JcFyeyy1IQVKODR/bTd5PVurQd9BqXPJMTdeWvQM8U3KmNRtSLtBlPJaFHyaDWMQzSeKo1VYNsV3r4eeDtxgtn8JiuvaRHdJYRPfdSLt1Hd086933pZMhcaXHg2N/X+VGkAmhNC6VCEl1gsQIlJ5VKZaR7a3Wh9g7ClnC23GnhngDazxs5ufF3UnIkTkbAXJUUUjxGA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12148.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(366016)(921020)(38070700021)(11063799006)(22082099003)(56012099006)(1580799027)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzBMb09UUE5KVmQ5K0htZzZUZEVQS2JheDFZS0RqM1JRZzNsejZ6OFdoM2or?=
 =?utf-8?B?N3JDZU5aeVdRYkZKN0J2Vmtud2Z5dzZaQ29vNHBYemJxUWZDY0t5MERBWUg1?=
 =?utf-8?B?NVVrNkY0TTM5WElha3lQQWlnOHQyeGtZN0Y1UmFiNnVxQjRKV1VOeVUrTzht?=
 =?utf-8?B?cm1va0N4M01wSExzdkNQU0N4dlNnWlUyNVN6MmQwRjlvN1dPd3M5Nnlray9q?=
 =?utf-8?B?YzM4S0FjVWtnOC9ObDdYNHY1alNHbXRrdXRzbE1Ua1RaVnRRZG1mVnFOR1Ix?=
 =?utf-8?B?c3BDcGlVY0RjNVVJT0FLQ2xTbmRwMVJxVGFiclExQVQwd1g0WTFGK2pCS3Ro?=
 =?utf-8?B?MDdjdWlCT1RNWjFQRkJnYUNTckdZWmRKM3ZhK3JiSitWVG1QaFVqWCtLZFQw?=
 =?utf-8?B?eG01M29BTDVNT1cwelA0VzBTVU8rQmpud2lGa2hWaFNKeC9xT2dPV3BFWERE?=
 =?utf-8?B?RzIxeUEyQUJ1aEZZd1dZVExRSWFmWU1NR2gxQllhaDJCb21wVG0zcHN1WUxu?=
 =?utf-8?B?VmtKaDhiY0U4aHltbTVaRitzQzhjSzdZRnBpMnJNcnZMSXpiMTJKTWRCRTVC?=
 =?utf-8?B?S2hsY08vRjZRcHgySHZxQnI2azNMYXE1ZVkzN1FKQ2grc2Zad2VSQ3FMOHU5?=
 =?utf-8?B?aDJMWHd6S3JhL3QvNzNaLzZNdlBUNE1ORTVVRFNnM21aaE1tdVIySjE5bFRz?=
 =?utf-8?B?VThJc3NCcTRTZGtVYVdZd2hYVCtrRUdKOHBpeVI3YmsvSHpWNkNpZnZYNFUy?=
 =?utf-8?B?YytLTEo0LzhGMVpsV1YwTVBjbWxiSzdBR0ZwU2gydFRWelVkTUcxa0NCTWQ5?=
 =?utf-8?B?L01hcVJsZ0NOQ0VJWHhEY2x6bnhsWk1ReERBUnYxL3U2SXF6ZHN1NHMrdlFP?=
 =?utf-8?B?eW1aK292MktKV09mZG1HNkRRMmVVejJ5MTg5R2lCeWNPc3FuOVJMS084V3Ns?=
 =?utf-8?B?N0pKYjNiZSt4TFIrRjM4WS8rdWozSVdIRk1XQjhvVW4vc0QxZGppTG93eDBB?=
 =?utf-8?B?OWU1dUljVUlNQndyU0htQ2hIdk5QQUM2ZjhDWDdXUENIRWdiV0I0Q2svM0R1?=
 =?utf-8?B?VnNWNFMzalBGWEs5bXJUNUFFMjJUazgyOURUQmJ4aHVOUGhTbEl0bG5oaDB5?=
 =?utf-8?B?VDRrMVJYWHpWSTNLQk5vbStDR1hhSVNkN3BTdFlKTndMeUdWVGhWb1laOTNG?=
 =?utf-8?B?T1J4MjZMYS9Sb1N0Sy8xYnh1SjBGdzZKdmFlOW11VlRWTjlNODBVNGtQREJo?=
 =?utf-8?B?bEt4a2FyT25VUGFjb2I2Q2VTQnVJdENsK3V6ZkZhamtWS3hvY0J0SzBHUUp5?=
 =?utf-8?B?NXE3VlhXMEp2ZXdLVkUzSFZhWnFGREFyRFNhbDhqZXNLNHh1VXJ2dVUxTkpQ?=
 =?utf-8?B?cXcrM3JLWFl4Vll5alhnZWdselVSTWx4YUgxbXV4Q1NpdHRHVEN5cjRVeWdY?=
 =?utf-8?B?U1ZIS3Vpekl4NTMxejF6cyttb0I1dmxFdzd6dWYrbU9KMlFaVkJhV1gyUUd4?=
 =?utf-8?B?Nnh4Qm8zOHJqREpqelRiWmlHQW9BT1pUUzRjcjltU01JZFVVWlUvbndUVTVy?=
 =?utf-8?B?Z2pQNXRIclg2ekhLdzIyQ3ZxREgyZkhIRHo0YlFtUHB3MWo4eGpFbGllZVEx?=
 =?utf-8?B?MEV5dTJaMFJQdXVIdmN6V2ZQL3plUGVyUnFpK2ErQkFIMXNsVVplcWUwMUhv?=
 =?utf-8?B?M0k4eW1BSHdRWHR1U3dEYTNJWlZibmZnR3dyVXdIL1J4U2tVZUNjMXZjYWNM?=
 =?utf-8?B?eFRKTWRGdm5KNzJuTEZ0cVE1dzR6VyttbHdwc3A3UFRXU1pYZFB5Sk5VaVdM?=
 =?utf-8?B?U0NkZkg4L041VTZ3NFpOckYvckJVV1gvS0IrUVNDU1E0UzUwYXZENXN6Rytm?=
 =?utf-8?B?ZU5DWnRpb2NmNjVtYlFhODJDaGVidkxqb0pWRWYyVlFNNDBrSmZnWjhLMjNP?=
 =?utf-8?B?K2Qva3U5UUVMeUFvZk53dWxaTVBZWDNvcS9kTE9LeE9OSm9Vamw2MGY5ZUpG?=
 =?utf-8?B?TEt0RG1sZXRnM1pOSFdKSE5xZVpzb0FINzZLNEJ5a1dpTE4yRUlXcTFzVEFn?=
 =?utf-8?B?TlBEWWg5enEyQ1g1bXZMY3RxeE14aEY0ME41bnZXdEs1dWZwZmdVcThXUUha?=
 =?utf-8?B?a0UxRjBEc0lRakRUMkF1ZWVvaWxQQnZaNUUwMi9na1QrQitjdnBER0lEWllX?=
 =?utf-8?B?Sm50MllRMUcvZENoanY1ZWhWbVVjYTVDem82ZW1aR2JtMHRXUDZhZTFnVCsx?=
 =?utf-8?B?bWZDc2ZWVGpoTmhrbzVnV3lxRng3NThSdnBCNURFNmZRUzg5b0VBSUpTOUU2?=
 =?utf-8?B?N2tKSi9yeEdLb2FGVEhVb0NVL2RXaVU3dTQ2VzFJSU5mZnZaNE9Pdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <78E74A3175E36241A1EE0E8FAAF4F6D5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	W9nxdmk0R1u3yUjjAs7brzNKOIMYFEZ5fA4UXe6nTAj3v1iHrynegK/BlPqi+jk8XbehAhxp+l5MIc1gmh4WtmVYIWp8+pb57UhmAwNn/4brXURusYJcrPrfaZJqaAplt59ruLjyXX4ErHPiAF+U9tx+DTYuoQiZlMMqxZzQKUtc8B9gbJPRGebE/zWADug1Zirl7jcfyYebxdVXxOlT6PFQCgdDbV2n2IDVSTApJxCfhP4wN9MMhI0IDhhypxqKC7dMoXbDRjVjUp5Fl/Ww6RAWBLoVgz019aLe7jnrYDMrKZbcnwncBucvi+0OpR3tCJZGGgTExfnKgRcmtaIZpQ==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12148.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f965c5f0-837d-47b6-0fe5-08dedc996600
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 02:34:13.2409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ineT/3icc4U6BuXADn6m1M5bSowVFGpyL+fRJ2aLVi+5NXcw8a5LOyXnMyKvDSD2UwWIEwFf/H0k4ymJljVyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14024

DQoNCk9uIDA3LzA3LzIwMjYgMTQ6MzgsIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiAx
KSBibG9jay8wMjkNCj4gICAgICBBdXRob3I6IEJhcnQgVmFuIEFzc2NoZTxidmFuYXNzY2hlQGFj
bS5vcmc+DQo+ICAgICAgQ29udHJpYnV0b3JzOiBZaSBaaGFuZzx5aS56aGFuZ0ByZWRoYXQuY29t
Pg0KPiAJCSAgQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gCQkgIExpIFpoaWppYW48
bGl6aGlqaWFuQGZ1aml0c3UuY29tPg0KPiANCj4gMikgYmxvY2svMDMwDQo+ICAgICAgQXV0aG9y
OiBCYXJ0IFZhbiBBc3NjaGU8YnZhbmFzc2NoZUBhY20ub3JnPg0KPiAgICAgIENvbnRyaWJ1dG9y
czogQ2hyaXN0b3BoIEhlbGx3aWc8aGNoQGxzdC5kZT4NCj4gCQkgIExpIFpoaWppYW48bGl6aGlq
aWFuQGZ1aml0c3UuY29tPg0KPiAJCSAgQWtpbm9idSBNaXRhPGFraW5vYnUubWl0YUBnbWFpbC5j
b20+DQoNCg0KQWNrIGZvciBzd2l0Y2hpbmcgdG8gR1BMLTMuMCs=
