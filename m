Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01591A23A4
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 00:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775175600; cv=fail; b=qRN+nCyrsnhY7Zw7Cg1eNuePeAO9dphIVJudZ2CSZ3C1DkKA0Tp+FrbIWSkvxVDqTGTYg5EzyBJzAYDju6M+ZSKR65opI0koF/t7MMK+OLWdgq9HAymndxkqGbLDRkcGUjUCejGF5x6HTalfB6ibL45YO6OohdpJknf45UONUmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775175600; c=relaxed/simple;
	bh=377DCrf8b32uWnB++L6T6k0NZdVPpEWBBPZ+XOiuDI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWYu5XmopTtEPAxkbOaSl7vez50cOQfrdf8zr0P1sfegddsxmA+8P2XGSZBRxvNLKYkr5840Tj+2tcPUDq57l7DrWOHrUsYHjBizT/OBdpWMZpd4M3ngoNB4c0oOq+hJt4AukUasHYA3vgrG3osDzSfKvIxoGHyCmS3vHT4K7nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TGrjHPA/; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TGrjHPA/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D0pFSn+GniicfhxeKJwCoM9JXf2svwYVONgKATVD4XKX3WrnoALreLnj6Ku7wnJwXeach1gkiYjzL1797NjMpuMoz8YsIdf1vemjCifDNOGT5nW83S+sNq5WLho2hstYAU95oxyY0YUk0c3KmAXEuTVfpkWC0ng2Cx9Y0mUOpsbpg7H9VGvJN6bsqc/G4DS9QEVL7dAXA0ARecVKvGcVdKSyWW3yWfLsSoxG88tQ+CSSEFk8A3TvVz3aDXkuPTIlKHrbtnk1AYZs9I00ExhJxMW7PPSV688sqbpnoAC22m2TokswD9h1/Rsr4uFpOg6ixowvcMSIV2Sv2cSrxZJsmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=377DCrf8b32uWnB++L6T6k0NZdVPpEWBBPZ+XOiuDI0=;
 b=KXm7TVda49/Z0aMYeuuRGxgADmrX/BJYoy0oA3OSsVtE9l4mH0DRLpxsh08fu202uxwgSiq7waa0dLiI2XlyGlYmUNmwy4qfrBT1zy0RKEl5RpuzG+L4LJvgJk6D3p4E++I+VOKPkEb2zGX9AzYpIfwzMEykfNZBOg9LzyrbKfpAQpL+P5jx5iBOFVISCZtO99LtsvQIZL1HnpPYYV+r1sdRuZC1FhTq0FfzpeSB3Nr+fFFjSSAAH/UEYm81L4Ah48BoGOf2OloxwoyGAoOLQrbx8suRhlkX9A8a9IPzLwcL92qatd2cqkB127IOaX8+5s40IqMl1sgnRdwhuwErzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=377DCrf8b32uWnB++L6T6k0NZdVPpEWBBPZ+XOiuDI0=;
 b=TGrjHPA/ZWsOZpIFNCneAyo4hdxSKlvxMQWIhJa7FQ+74J6E7kw7AAGTxrBDdlHTc4x5g+WcVL7H97E5dAe4r987P6vWNtI8m/oYOYiMXzso2Bw5VcKglIaAto8sNK0l/pe+Sj7+t5ImvcupYJ6XXLxnxuPhy3qDyP8aNqbiNLhR+GjMLkrDQCplvQrZXrtgwhy1JlAEKEdFCth5Vf3rjrQeKS4s472tayqV21rdDb7h3YwnxsvvzjLPQvkNK7OgsFDlls7wrr+XJ3Ms8X+KF/Azl/Emu3Oh0x+7woN/k2R35XDbQJQTa/M03/crmyk3GnC96e0YhjdcZtmaf7lKyg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 00:19:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9769.017; Fri, 3 Apr 2026
 00:19:51 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Marco Elver
	<elver@google.com>
Subject: Re: [PATCH v3 00/12] Enable lock context analysis
Thread-Topic: [PATCH v3 00/12] Enable lock context analysis
Thread-Index: AQHcwtBtr7b1BI7YnkKWbFZTRZg+dLXMeYoA
Date: Fri, 3 Apr 2026 00:19:50 +0000
Message-ID: <7f3a651b-b279-4768-a9fd-c274168d474d@nvidia.com>
References: <20260402183950.3626956-1-bvanassche@acm.org>
In-Reply-To: <20260402183950.3626956-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH0PR12MB8126:EE_
x-ms-office365-filtering-correlation-id: 5c9c7a5f-07a3-434a-d5cb-08de9116b8db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 a3tBTQVQHnxAvLqlDSTKwLWpNtO8YpVe8f/sdF18d0rBsUw50vm7xDSdB6+LvKAjiINYO/Qjgzo4oQFV77Y81CnnrKpfuFLQ6sT2DNG+TWKDUyueTvpGttoPGk5G1XlQeT9PudPr3FhPPRLag7O2y4SJFIX7drf4AmTr4FQhZ1eEUFxBO8xfVZHkgf61W3/DlJbf+PrXoM1vHBpeNetmwoTtE2YFqLEL3+K7l1JURRYvmCmgsmGAQcv30yyqV4VEgvbwOjoI9MMgbgkgJnvZ8wdeSfaRog/DPTaTmcelx5jX7fZv18UnYeXc7RGYhc6YMh+wJLtJYmsOkOECc8puEnspNOTz5jNIakL7J2yhfWjwwjkjbb4Gkq1omqiMhZupr/v0CWF7UyOl+ayYyrjlqTDljUyuhR1y6eaD6oZ5iuXxAyn4yoE0hbKJz0Bx/gz5YA+1EO4jm3sGr1rRn23OOL30zeXR+EaFOrRrpq+cG+pHO1xKjoH7XioQNs+4GECAaL/Q3Xh79hyPCksHK1SV9zJng5JuaG+X1+ZtoWpmWO7o/AyK9iqyqp0SDri8PG1veNsMPjhfhteE3QjOXGrKVxo9/vMXDfvQ1rapVk0Slvly8nHF11ms5oPHuLKPkMjU6vsKgXzHqFNNdtlkFv2Dp/vF6rpyfBog/ul81NitfZDYGA1q85TChl0PluW+JF9xDWChH4UZajHNKZ5WGrMwYTk5E0Ea8NJil5kd0+oYqZip/Qy4CbW1PvepDTpbxpa/3dctNhFi32g4NJMzO4pfI1F6Vsubp5DqFVdeNjbzunQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Rk9jYzRFQWQySmtTSmdsSk5WTGEyemczVXRvT3BQUUhVWlJqbU9pOVF1Ymx0?=
 =?utf-8?B?eUZjcVhqVGptT3FiUnNFbnk4YWxRbW02c1ZmZlVMVGxMeEoxZDVFVTdkaG82?=
 =?utf-8?B?MU92emtoc29YSkx2TEF5Yi8xM3BjOFVMNTdFRXFTME1PckpLWEgyV3ozUDJP?=
 =?utf-8?B?NVVRRWREY2Jqa1RoNFVWZ3dJMGNDNFB1Uk9IdFFQdUdNSDBxS1I0VCtUUnhL?=
 =?utf-8?B?c0dpRjRzMDFoeGs0aHlMdUZTYTB5NHZuL1kxMDNuMUxnUGF6eUI1dStFbk9D?=
 =?utf-8?B?ZVcxUW5PWHNPV29lWWpTcS9rcHlLSFU0M2hjazJTWEpXNDJyVHpVZ1Y1SmFQ?=
 =?utf-8?B?NS9JamRmWVc0S2hYTDdhc05oNEtlMXhQVHc3V3ZsZGEyWURNSGs5TDl4T3hE?=
 =?utf-8?B?dllyY01yMXdJWnJTWXVWdEI3Vzhma2JtZkZCTyt5VmpwWEZSNjBWUHFzSEVy?=
 =?utf-8?B?dytlTjJ3aTNGRVNVcjVBTFNWMDcyd2ppME0xRXZZSXh1aFIvSDBsd0V2Zjgz?=
 =?utf-8?B?OEpDY1Q2dXd6ZlR2ckZqUnQxdm9YQ0lkQlZLN01TWlIzMTlsTVltY1Y0Rmh2?=
 =?utf-8?B?SXNGd2JCMzV6SjQrYUhRWUNBeVd3N0R0VnpBU20xUk1qWDVYaWRXbldqYzJk?=
 =?utf-8?B?N3g4SjBIQU1BNFZxTGsxS2NQM1h4R0FUeWlUZzRKODcvREZDOXFsaTRLOTJG?=
 =?utf-8?B?RUxXN0Izc3JjeklQK3llaElrUDBqZ2k2Q2xuNDgxNENWREMxb0k2S0JKSnRo?=
 =?utf-8?B?S01wSzVEZUZjQzk0S3g3QU9Jc0tnZzc5eUF6WVpPZStHbHJVV0NnLzNhWmJE?=
 =?utf-8?B?TkZ4bmZ0eE9uK3cvdE1hTlRhWmlSNkdaSTdtcDZGZnROL1EvK2JzYmVRZXpm?=
 =?utf-8?B?cVF1aHNrN0FENW1waWowc0hJRGY3d1JWeWJwTUNWRHYzOWpJMjlydVpoS3pV?=
 =?utf-8?B?REVNSkJQRFRJVmZKazExUXN2bS9oeHhLQ1kvZjBTRENEWE85NzF0dzBDeUVa?=
 =?utf-8?B?d1RHWFo2c2YyR3VvUEFpZElCOXpwTURRaHFSWDRxNG9mZUxjMHN4c1JYcFlW?=
 =?utf-8?B?VFBwa3dWbW4vbVQvV09NN1phVnpUNHRvV3AxUGpOVzNJWjRlRnRDYjAwRkVh?=
 =?utf-8?B?eWJOeE1TL1R5eEZBdFFQWGozWnZDZUZmb3RURGZvc3BXUFJ1ZWZ1MDJNZjVk?=
 =?utf-8?B?dGpVL2xFWjJSSDZOWXR2NTRQcGF0NVBtaXZiQjRFU1MrNlVGRXNwc3VJaThj?=
 =?utf-8?B?QzhLSzBGdEhROXJOR3dzNmpBTSt0RE1IVkk5bVV4THArbklFb0hFT2ZlaThC?=
 =?utf-8?B?OUtCdHhpQnNXSHVhMUgrV3YyRGtac1ZkdzZ1bW9FcXpnVjdUcE5OZ3QrM0ZC?=
 =?utf-8?B?akRVVHZJQkVjZlVZVGMwRVYvN2dCdnNjOThkcEJSc3pvQ1pWZzVlRm8zQUZL?=
 =?utf-8?B?ZTdIeEQzMjh1WGRLTUxxY0RNdjVTVmEvKzZ2amFEZmhtUmNCRk8xR1EvRDIy?=
 =?utf-8?B?L0d5S2xiZ0FxRytHYWNoMTl1ZnFUcVAxa3RVV3hJUVhNRFAwZmJNTnpIcGpZ?=
 =?utf-8?B?dW1HcHlSejJiZU5zNDF1bVJ5U2xQZ1lMVHF0VDgxWkVZQTExa1ZBSXVEdnZS?=
 =?utf-8?B?UnpZd0h3Z1N1dUlJMW9tdlJ1UGtlb2FJVm52cjdia3ZGa0FGeFFXQVdjSVI4?=
 =?utf-8?B?UUpoWk42ZTB0VWZQL0tWV0xHSy83bUh4ZFJxZDlCK0tPUEVuaURWN0JvbFVU?=
 =?utf-8?B?TUhWd1RXRjlsSjd6QUoycVZkT1BQdUJiZmdNR0piQU9BNkxjTHE0cUQyVmsr?=
 =?utf-8?B?QW01N0MzMGw4TVhrUFNvYUhMUi8ya1VaWm01YTJ4VnpXcllTTDdGNkhIT3dT?=
 =?utf-8?B?eGFBWUcrRmlUcXd6NzI3S3JkRjJzekVqaDJQcUxsR0Yrb2kzZlJSeXZ6MHdz?=
 =?utf-8?B?K2s2TmFzMmlhVU02NGdxdkd6VldaL3lmSG1YdjR2Z0VqbWgybnFJaS9ac2lz?=
 =?utf-8?B?RHlmaHlUOWVVZDdPY1FZendUbzU5Q3NHVmdCUVZ4M1JGOGFtMXRwRE9MNllX?=
 =?utf-8?B?cnlmVDdoTXN4aU0xK1ZnUFFlMEI4YXZUOXJjcnVMTTI4OS8rSTV6Mmd5YjQ0?=
 =?utf-8?B?TVgxRFRnVm15R1hTZUZtSkdIWVBLOHRVVEpwQW5pMVlCV1VzeW9rR0hpbkdQ?=
 =?utf-8?B?dHV6Sm9EWW5oejBHOHVzL243SVJPL1AvTk94TEhHeEhHcU01UWVEVEgxYXZ5?=
 =?utf-8?B?QVVuMVJNY080VHFuRzExd0piL1RGR1F4VS8wQVF3UVNXVjk1Q0lsZnllQzk0?=
 =?utf-8?B?TXhtNGZXbE56ejM4MFpDN3kra3Bub0JzRlcrRVpacDNDcmZacERYVzFvYVdq?=
 =?utf-8?Q?zHQh7EYWIpseKA6DgNgd/Bd1U+tNsfIC/E6Lb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF1715B708BD1C46BDB8F9C2982BA48B@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9c7a5f-07a3-434a-d5cb-08de9116b8db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2026 00:19:50.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BT4+bs114gawhcXl3qolUN6Th9tUGo0fcnGrzV1HWX0opkoQny8kqNyp8AXb6/E4YF61uecFta7DheebM/uXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126

T24gNC8yLzI2IDExOjM5LCBCYXJ0IFZhbiBBc3NjaGUgd3JvdGU6DQo+IEhpIEplbnMsDQo+DQo+
IER1cmluZyB0aGUgbW9zdCByZWNlbnQgbWVyZ2Ugd2luZG93IHRoZSBmb2xsb3dpbmcgcGF0Y2gg
c2VyaWVzIGhhcyBiZWVuIG1lcmdlZDoNCj4gW1BBVENIIHY1IDAwLzM2XSBDb21waWxlci1CYXNl
ZCBDb250ZXh0LSBhbmQgTG9ja2luZy1BbmFseXNpcw0KPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDI1MTIxOTE1NDQxOC4zNTkyNjA3LTEtZWx2ZXJAZ29vZ2xlLmNvbS8pLiBUaGF0
DQo+IHBhdGNoIHNlcmllcyBkcm9wcyBzdXBwb3J0IGZvciB2ZXJpZnlpbmcgbG9jayBjb250ZXh0
IGFubm90YXRpb25zIHdpdGggc3BhcnNlDQo+IGFuZCBpbnRyb2R1Y2VzIHN1cHBvcnQgZm9yIHZl
cmlmeWluZyBsb2NrIGNvbnRleHQgYW5ub3RhdGlvbnMgd2l0aCBDbGFuZy4gVGhlDQo+IHN1cHBv
cnQgaW4gQ2xhbmcgZm9yIGxvY2sgY29udGV4dCBhbm5vdGF0aW9uIGFuZCB2ZXJpZmljYXRpb24g
aXMgYmV0dGVyIHRoYW4NCj4gdGhhdCBpbiBzcGFyc2UuIEFzIGFuIGV4YW1wbGUsIF9fY29uZF9h
Y3F1aXJlcygpIGFuZCBfX2d1YXJkZWRfYnkoKSBhcmUNCj4gc3VwcG9ydGVkIGJ5IENsYW5nIGJ1
dCBub3QgYnkgc3BhcnNlLiBIZW5jZSB0aGlzIHBhdGNoIHNlcmllcyB0aGF0IGVuYWJsZXMgbG9j
aw0KPiBjb250ZXh0IGFuYWx5c2lzIGZvciB0aGUgYmxvY2sgbGF5ZXIgY29yZSBhbmQgYWxsIGJs
b2NrIGRyaXZlcnMuDQo+DQo+IFBsZWFzZSBjb25zaWRlciB0aGlzIHBhdGNoIHNlcmllcyBmb3Ig
dGhlIG5leHQgbWVyZ2Ugd2luZG93Lg0KPg0KPiBUaGFua3MsDQoNClRoaXMgd291bGQgYmUgdXNl
ZnVsLCBmb3IgdGhlIHNlcmllczotDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
