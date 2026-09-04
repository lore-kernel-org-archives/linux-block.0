Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011033.outbound.protection.outlook.com [40.107.74.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15802192F9
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788484181; cv=fail; b=Ebvsu9iBQd0e1xIlS4kkF4hlsAco5bjlgFtyxbLhKtpwotkwyqrSYzbosG97+mtljUW1plhjXQhTPtMX+eailXmf3YcgMWeoQw9JVg8bar87iXFJPTk+ew3ZtGO2o/wOXNlXfQrbJSFpqL8lh0M1XtgzWvNgFE0NdjwddEJvQyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788484181; c=relaxed/simple;
	bh=fLPK+P7bURHVEDeAAeQC1tJM+9+7SURfleyIeOhXb5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kkuTKu3gcAxnwybxKg40ZESr9bkPdJqDRlhWGiW8zXnAmuboniyDhOaJMCiDEltGValj6PrZX++rRwFQsMph+wyMKmawp4IPojAD6TnFZLnHcgc9RGwYGvGCQPPcn8BoAgxKvjueSxDO9NEwKJFzK250tN11JnpPAghzq0E9wW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=PUKFW8a5; arc=fail smtp.client-ip=40.107.74.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="PUKFW8a5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WF+x7FhKCORFa3rQNb47TdGuo9wpNl2a5BKvFh7ZfRsHOAfxK7B6Go8VcA6nvvRBFOQ7FVvfUECqG3E9+n5eDp6yCn7pp4OadR9lYIq5Qe0MS7cKmhm31MOtg5c/fM338Ap74rnF7XjYVSBg+atQalX2cooA8gvSrVCuR5RD1ywPBJsiEwzSG9biVQv6tD2hVdH7PT3uE1/wW7v/mWRCK9k2jxpU27nGjAsN3KfjQd/dqO7uw5q8X4JDxvov7Iv1vhjGfgy1mUFTb+gCE2+XqIPfZoZX3A+b3BrWcrgzsomet0acPnFIFf+q1pwlhd31FsNqpIumwqr3AzPVIM6naQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLPK+P7bURHVEDeAAeQC1tJM+9+7SURfleyIeOhXb5g=;
 b=RnGewE7tXofN7D4yLZLAaqMGRweCR03H2w2AfvFYpAG8YOV7++AxgzmZtEahw9kXCEDCfbp3a/K99lEYp3N0320Ove3mVcdMb8YJwh0PcrQJHrCWPsHbGb2g3cLXPTCaKTogJ9WoXbRdS6GASH40hNpjiIoDUgRJdOYFINJVXnQHWmht8RiO79TBf9OaMKQuyHbrx+7OMhS4CdjJwcBJgUW2at8mfkpteyo4mOdhpvidtaBObg6CRfxtErkehF8xSGrypY5Ymp59RUqhBScv/Q2q/ZkCmgnuyLJbDF1HICFlO92ZM2fV6O24Mxi5skZQnpFbV8sSKtEk1Bd1kcD0TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLPK+P7bURHVEDeAAeQC1tJM+9+7SURfleyIeOhXb5g=;
 b=PUKFW8a5MCxLzT0nq3ji89ZDQNhT2wPt6PWHxtVCMhzILnDNmKDSKvSHLG4USmjRBjThpItgqw+p7KwQRg/KdUxKhO6UwYZm+25lW8iyuB2d9WJ59FatchUdZfJcIZL6pRNSxDe8jX6EYvP70GOCQ9YABYo0mwZDuQ32d6Gta0r5O8FMEjm5Fp7918T0NOQfOO2lrb+mhZmQ/DWZS82UbQ0gREmogdv+rRBZsd5W9DIlOa9kMt5/+nTLBtow3cvZPLsmDhxUOHrJiqkSRqTl+1eNweJoppbFDU1aQyF2RsvTxe0llLQI62YRk47XEXvWpmmeJYJGZ8oLsEhRUof6fA==
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com (2603:1096:604:2e6::7)
 by TYCPR01MB11418.jpnprd01.prod.outlook.com (2603:1096:400:3b9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 01:09:35 +0000
Received: from OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131]) by OS9PR01MB12148.jpnprd01.prod.outlook.com
 ([fe80::7a9a:2706:6589:5131%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 01:09:35 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
CC: Christoph Hellwig <hch@lst.de>, Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to
 GPL-3.0+
Thread-Topic: [PATCH blktests] block/{029,030,031}: relicense from GPL-2.0 to
 GPL-3.0+
Thread-Index: AQHdMVtc7cOsrPKSG02F5f3rsz1BW7a9sWEA
Date: Fri, 4 Sep 2026 01:09:35 +0000
Message-ID: <bbc378f3-2f25-4323-acb6-7344da931e6a@fujitsu.com>
References: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260821105335.794406-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12148:EE_|TYCPR01MB11418:EE_
x-ms-office365-filtering-correlation-id: 4d6f087c-be7f-494e-b579-08df0a212f21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|3023799007|1580799027|38070700021|10067099003|11063799006;
x-microsoft-antispam-message-info:
 kIKIEreaaaEpQDedgEMVqT7BHifUDdqyJJ/if+kPNYC5tSFaFwBkuJUFbwadsZCvhdaNglQf6QZcjA7u1mIC2SKhAJFu3w/ufOGgDXSVl8ZvB6At9RvFASby+z5RL/VKqzNmmuf8Fcp6xzjKcS3nq0BkV+6QJZd1ZRNeHtYUE3TQCTzebC6O46iydzEJG/XvsCbZJS7y+Re9vOReUdwYqI4JqzfRAHI0zHdKnIjG3CRTOPCY327cf+IEfPb8kTtUZ9TWQWFU/pzexxKcb3w91xA9FzpVYE3sBE/CY57zzq/29aqnVYsb8XkpPOk/h2xN6VmFQwtviSSAv+XhJPNmkjKqGJz28fGrJhu0K3qazNUMEriz66OEwV5oHzYRLaqjqE8kaPf1FvjvSjaf/LbSDz5DML85ciRfY03ItxFl5F4xk76gsJ/ywHQXAmWhpmSPORvE2yN+Gj+17r7PX5Trv4xGZzOPJ9nYDCup0sSvdnlxbacRkTJ6oAHDVhgKUvMc7zpba3B3flUdBw6KgAemvR/7/5ccdsjttLo3xxqfc2S3mynSu6ergMLswzq575hMMHtNEcZhKeBZq25YNXcC1qB6vzireOVK2SLemY+NHINMWyqwbOpicYCfwoxJSTskR+plSMjn+yUsB2P+4/djE/2ZTY7neja5pi9UetukabmKwapZQLBMpGtmHktbXz4836eSu48tkncgCiA8IVTiEthBpTLEKt6f/y7WWAgqeApeP02yvPrJc6sUEAORK0Qx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12148.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(1580799027)(38070700021)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SE16OCszSFQ3ZklwVEVGU200ZWNUM0k4L2JoK2J0ZGMvR0pqeHF6ZVZBVkJJ?=
 =?utf-8?B?K2UvVHBRR01kMHIwZCtqeS9lN3lxZ1htUXkyTlRHTW5ZTTdOYU1aenV4dytV?=
 =?utf-8?B?RHhGaTlzQkNtczR6WEZDWkVWQVZScTJFYUd0UytNR2VqTVMwYWRQSDk1UWZG?=
 =?utf-8?B?dkhrdXlzZnRCbUxBMGlQU3JkOENYMGN6dmF5MDNkNXIwaEdCRjV2eEVHNDJB?=
 =?utf-8?B?Slo4U3NHSmxobFpkRE05ajdXZ1g1S2NQUlN0QWgvRmJZWlBHUUllTzl0NnR1?=
 =?utf-8?B?S2dCc1hxNGdzOFExY1l2V3U5RW1jNFI3d0poRWVLcll2Nmplb05lNHh2QzBX?=
 =?utf-8?B?Q0xmaEZ4RGZpTCtDV3p5ZWZwM0F2UEpyeTRGKy8vbEhjSFFJRjBsaE9SbkZu?=
 =?utf-8?B?cUNEeDkveDlIcWlLQWxLUzVGV1dJcldXM0dBazNGTmlLQnJNTjNWeEpzd1RZ?=
 =?utf-8?B?amJlRllVMlJDOEl2TDk5NWZ5S2swcDgwKzlodlZ4UGhzeHcrRlVlbVAvYzJT?=
 =?utf-8?B?Z2NPakJWWnR6ZUdLY2xXZTBsNjBqZWtaRGVWTUVRaTRxNUhqaGZ0TGV0R3Ny?=
 =?utf-8?B?U0VxN1ZLQmdoazVNK2VuSjRNSXZjUzN4NzZhNVdncTRvbUo3aXpncHV2MnU5?=
 =?utf-8?B?eU11Ry9nN3l6U3BKOXFVeWcrSzl3YndBVVl3NU1tZHBBMm5RdDh2eU51QlRv?=
 =?utf-8?B?S1ZCbTBENlZBdFZNVmpENVdJUmRxbElQenc4emxZaWowOXR0eXdNVFpBaEw0?=
 =?utf-8?B?OXJBRnFqQldWeWIvcVd4QUJBOHhsK0FuaW9oS2Rad1hqWm1ISnZuOFVSL1dv?=
 =?utf-8?B?ajdMWjRkTHJJdVRtY1M3K1prbW1NQTVmUG8zYUp6SDV5aTF2Z21vSWtYRnly?=
 =?utf-8?B?L1p3elNSSFQwbWtLcFhRZGUvQlZNVGlyMU5RZWZaVmxQYmRlK2MwYUk4Wnp5?=
 =?utf-8?B?S0VNdFQrWjJRdTZTdHU4UE10bnVoYzNET1h1blgwcy9NMlRMK0w5OUxTSmVN?=
 =?utf-8?B?ajIrNWgwTlcwMnZHYjkrRnk2S1VNOURVYXVTUXhkZ0xiMWtOeURxR3hCN2RU?=
 =?utf-8?B?dHdTY0NENW9KcmtzZnV6cnhQMXZEM3BDZnk1cmJxdzVTNlF5SUJkd09lYzgv?=
 =?utf-8?B?eDRPNlhQSGg0VnBMZlIyNEtxZndUZmpwVE13Q3RjNXJjdzVRZS9UeHFFMUxZ?=
 =?utf-8?B?VXJzdHNObDRjZjBRck1vaDFqZXZONzZXN1diRlIvT3JyOEt5OGN6NmxlanJk?=
 =?utf-8?B?d1FRUmhUZUtNNUdkK3FKNDREd29tQmR5dmlOSEdGSkdEU254c3VJQUkzZmU3?=
 =?utf-8?B?RW9BNjJzaDV3UndYOW82V045YXk5ZE9ydFZTamU3OW9sNmZSRmMzQWJZWmtj?=
 =?utf-8?B?TTEwSHJSTlljZDhxS0NVQXBVNHVFRnE0emhpd0VJQUdJdzlRUWJFbldtMmVB?=
 =?utf-8?B?MkFOdE1yK2hhdWNkeko4dU1KN1NiOFpqdXFlTEpiMEZFa0JSSVBPUWk2bFh3?=
 =?utf-8?B?dEJud2VlV3FZNmZ2NDB0QXRZTmp5cXUrUkwvRllIN2FEbjl2YVp3SGx4WTZk?=
 =?utf-8?B?QlVzOFFZV1hrc3NCdU4yRVoyZWpvaVpEcjF5ajdvWXhlaGhUcEZwUnpMU2lj?=
 =?utf-8?B?M2NLaWJjQWk4cXF5b2dLdUJCTWdpZDE2dlRxME1ob1NCVEl5T2FOR0ZaWktF?=
 =?utf-8?B?UzJ1Sm1Wek9aZnhCNktFdHl1bGZEWEl1QWZoVE9MeHVIeitzaG5mS1N5Um5F?=
 =?utf-8?B?K2U1OXBMbjBXNlNZMVpzb3NRamFQVVlYLzcvRmVwUWZxcGwzeTlLRndkbXNt?=
 =?utf-8?B?SUF0RUtmelhCZXpSWlEreEJUdVhyYzhvUkhEQnk0U3ZDWEIzQzZVS2pEYU9L?=
 =?utf-8?B?WEFwZk84UGhFcUFvL1V0Rk9MMWsyWjNuSnhFZmxLNHFVcDVPTExmYmtJdFB2?=
 =?utf-8?B?TlM0dnMybXgrTlNMNkxtUXYxYkpBUXhFL2JvL3lVMmdENFV5bDRrNG5OOHhF?=
 =?utf-8?B?NUhmMEFoU3pycG9UVUF4bldETitGSmtYMEVDbU10c0YzeWJiSHhuWjlJY3pZ?=
 =?utf-8?B?c3h3SVlDYXJVVVEyZ29SWVp2dkxMbEVzRGNlR0t4UDloTnJYdWVlZkJ5WTAv?=
 =?utf-8?B?SWlVZGdiOVYraTkzK1NON0VHdkhWY2htWUtHR1pWdnp2Z0hmWjdrdmpYQnNl?=
 =?utf-8?B?QVBNVzZvSkFOMXk2ckxmY1NIdVhKSnhndzdRc1lMeVIvd3NIeGhPeFFpSUpO?=
 =?utf-8?B?SnVOM0pCVTg1SkptMGlzUVBvR2g2YTRjWW55cnNPbE45VVIxNXo3TXlqM2Jy?=
 =?utf-8?B?aGdVMVBEQmRSbWppcHVHWDhtZzhuOEFCZzhFemlyN2Y3U0lSSmE2dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EE36C63F76EDA4FB2DB881D9F356B5E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	j+QjXKxj+Fb1+7bSe5uDNdtQ7lBhTuMnVVxfpdEKj1hjplVgaUtHOaNkFH9W8D6IS1sl2jlUCCrojw5htXJIc2r/xPDJSLFz0f1cnpli3LEAtibiDAeSlBE/ej9ZjNpyBlTkLLgsSSS+oEcsK/IqugRp948ezPOGux5CsPWerg0uO7BGRxfpU4slbnuqVwv2g5S7bjTCGkaoyw0asS3bl8aYAFB/XD0daPhPRf2MWhVienlPq24Cft1S+yxqcdYNlH4UCOehUicdZanXADebLV0PMoXp+C3QDc6A0G0xTqHhA9bhIOuKphdutNcrc/C0OZG2/mLynjdn77EVDvAcgA==
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12148.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6f087c-be7f-494e-b579-08df0a212f21
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2026 01:09:35.0772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/nqOAPiy8mHRs3GAcRlviJGmlCwpKk8Ewrv7tLT+VlZN96Ko522ZbOGBepFGJSFEVUAm2SHqC5ZFrpzJCDUAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11418

DQpPbiAyMS8wOC8yMDI2IDE4OjUzLCBTaGluJ2ljaGlybyBLYXdhc2FraSB3cm90ZToNCj4gTW9z
dCBibGt0ZXN0cyBjb2RlLCBpbmNsdWRpbmcgY2hlY2sgYW5kIGNvbW1vbi9yYywgaXMgbGljZW5z
ZWQgdW5kZXINCj4gR1BMLTMuMCsuIEhvd2V2ZXIsIHRlc3RzL2Jsb2NrLzAyOSwgMDMwIGFuZCAw
MzEgYXJlIGxpY2Vuc2VkIHVuZGVyDQo+IEdQTC0yLjAgb25seS4gVGhlc2UgdGVzdCBzY3JpcHRz
IHNvdXJjZSBHUEwtMy4wKyBzaGVsbCBjb2RlLCBidXQNCj4gR1BMLTIuMC1vbmx5IGNvZGUgaXMg
aW5jb21wYXRpYmxlIHdpdGggR1BMLTMuMCBjb2RlIFsxXS4NCj4gDQo+IFJlbGljZW5zZSB0aGVz
ZSB0ZXN0IHNjcmlwdHMgdW5kZXIgR1BMLTMuMCBvciBsYXRlciB0byByZXNvbHZlIHRoaXMNCj4g
aW5jb21wYXRpYmlsaXR5Lg0KPiANCj4gVGhlIHNjcmlwdCBmaWxlcyB3ZXJlIGF1dGhvcmVkIGJ5
IEJhcnQgVmFuIEFzc2NoZTxidmFuYXNzY2hlQGFjbS5vcmc+LA0KPiBhbmQgc3Vic2VxdWVudGx5
IG1vZGlmaWVkIGJ5IGZpdmUgY29udHJpYnV0b3JzOg0KPiANCj4gICBZaSBaaGFuZzx5aS56aGFu
Z0ByZWRoYXQuY29tPg0KPiAgIENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+DQo+ICAgTGkg
WmhpamlhbjxsaXpoaWppYW5AZnVqaXRzdS5jb20+DQo+ICAgQWtpbm9idSBNaXRhPGFraW5vYnUu
bWl0YUBnbWFpbC5jb20+DQo+ICAgU2hpbidpY2hpcm8gS2F3YXNha2k8c2hpbmljaGlyby5rYXdh
c2FraUB3ZGMuY29tPg0KPiANCj4gQmFydCBhbmQgYWxsIG9mIHRoZSBsaXN0ZWQgY29udHJpYnV0
b3JzIGV4Y2VwdCBZaSBaaGFuZyBhZ3JlZWQgdG8gdGhlDQo+IHJlbGljZW5zaW5nLiBZaSBaaGFu
ZyBkaWQgbm90IHJlc3BvbmQgdG8gcmVxdWVzdHMgc2VudCB0byBoaXMgUmVkIEhhdA0KPiBlLW1h
aWwgYWRkcmVzcyBhbmQgdGhlIGFkZHJlc3MgYXNzb2NpYXRlZCB3aXRoIGhpcyBHaXRIdWIgYWNj
b3VudC4gSGlzDQo+IGNoYW5nZXMgYXJlIGNvbnNpZGVyZWQgZGUgbWluaW1pcywgc28gaGlzIGNv
bnNlbnQgaXMgbm90IHJlcXVpcmVkIFsyXS4NCj4gDQo+IFsxXWh0dHBzOi8vd3d3LmdudS5vcmcv
bGljZW5zZXMvZ3BsLWZhcS5odG1sI3YydjNDb21wYXRpYmlsaXR5DQo+IFsyXWh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LWJsb2NrL2FtYTFzdkJiZFZmeUVLejFAc2hpbm1vYi8NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFNoaW4naWNoaXJvIEthd2FzYWtpPHNoaW5pY2hpcm8ua2F3YXNha2lA
d2RjLmNvbT4NCg0KDQpBY2tlZC1ieTogTGkgWmhpamlhbiA8bGl6aGlqaWFuQGZ1aml0c3UuY29t
Pg0KDQo=
