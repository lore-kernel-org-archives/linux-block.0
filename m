Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543A03E95A3
	for <linux-block@vger.kernel.org>; Wed, 15 Apr 2026 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275922; cv=fail; b=edHMBcoHrykq5EgbpBtNAlTk21cB9wQCzl6egD/3qLyMqTp7czUwg0bP3bpBcixeMWcGin3Xkl/bc5gYRv+JoJ5HkJTrbWQoIcOLrKKaP/JtOGXWtkq8awhR8oa2fnb2arXdF+rJfC7xscQKxvwERHoFx8O69JOxuuWV0hblY+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275922; c=relaxed/simple;
	bh=ClFpcsC//6EnM/Qre3veUPPsPtWCNAW+F9xjdyi+R3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aX9TTMBHQdX0NaotyMjOfl4+svQNE8Ct1kExIL0K7sXOeySycBNDbZVIGC6oR5AHrZBMxMHiN0mpstNOtUtKrFLVVa0mi3qZNNl4FEavVg6uqPWYZgzmSMWcyXYuflWuxSfep66BE1Lf8sTXU7FTO2B7KaRR1SprUgYjW8ckQY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ir/h/4Z+; arc=fail smtp.client-ip=40.93.196.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ir/h/4Z+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJBPL9jYNoyqoD11+GcmvxJ6jfFQ1WJotEtK4I4mAo80DmyihG43jPUmhDGx7MlOb/X6I3zb7lFLwqR77BUNy87jgpPfteE7hESdIpvr+X0l5ivNVySp7gxoQOuT8PWwI249tZon4SL6aVa/em6OYSCfy7KrUVZ/qv92Xuzq+pGlyeu9B//mavfayLsJX+xxybCTyXev7Fv2HC2lpHdfp3bysn+ohD1uOSU7Zycir7hzL/zIWoiPuJEB/oUuuTZUmiOtORt4eHlMHuEPREfn+8Gyk2SNQwkqg0m52+3UsBEfcmVbmefPbieqr8oEc4yOHd7PQbAvwXiwMdR00k8E1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClFpcsC//6EnM/Qre3veUPPsPtWCNAW+F9xjdyi+R3o=;
 b=g8pjXxki7W64sUvl8jHHojqIaAUl52a6PCXXwVJAb/ycy+TiJ2VIbk1BF1gIlcjV2CM9kObX8nbHxS+hRY8GuW49Bm8utrlJDPMNqCHP1kdFfznpLkbxct0MoxCkywTUFUYXLzh8mEiEtCb/zqIq7A13JI192VPpFGTlydPXdmB54MBbG+IVeZgYR0DmDi9kVE9F++gT9zoFD6Q81QeMHWCwNO+stCVxDjwzN/wHuK5Cr4fUc1EQUHbHabTZ1PkhQlfQIPJ3Ryb1Kn+6CRLjazyN6Efr17q997Bzwp0dKHney1719ud7wKfTrT/sVsWQuYW2eOSZnq2cTqhshFLKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClFpcsC//6EnM/Qre3veUPPsPtWCNAW+F9xjdyi+R3o=;
 b=ir/h/4Z+2V0EIuxRqUnuf1Q9v8aEVvgIdpZrZqs63LVaPjdr3Ak42OLwf0I81csnbFIhFpDsuFNvtjmC5rXSSVAzUq2SgvpPNAaf0lzBXK+BwvZWsMXHrpXp++aUfPwlocd1UoQq4VFiYNeF05SvTxp9us7SdjdJNcxNJz6BjjXJZ0NOEs3v7dfTBf5seHlDzwhLsgFzckWS0M+sXk8CH4lLrmp5/3hnDOHBmDVvby0y1531rLtbKrwwadEyFMulAeLm3pKJeaVmQgIEWiTpm7DYY79ccOasmnoUuqFBtfHv6li8DcTODrmjP3lXrm7BdC767ju4Z0e7qe4a97aESg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA3PR12MB7783.namprd12.prod.outlook.com (2603:10b6:806:314::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Wed, 15 Apr
 2026 17:58:36 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 17:58:36 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: John Garry <john.g.garry@oracle.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"nilay@linux.ibm.com" <nilay@linux.ibm.com>
Subject: Re: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Thread-Topic: [PATCH blktests] nvme/068: add a test for multipath delayed
 removal
Thread-Index: AQHczMR/T8LDRyY5kEerw0gmAkpvNLXgaWyA
Date: Wed, 15 Apr 2026 17:58:36 +0000
Message-ID: <bb9495d8-a65d-4e03-9496-b6013943120f@nvidia.com>
References: <20260415104111.1439459-1-john.g.garry@oracle.com>
In-Reply-To: <20260415104111.1439459-1-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA3PR12MB7783:EE_
x-ms-office365-filtering-correlation-id: 2407c679-921f-4fe1-355f-08de9b189dc1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 YdqfENZXlSoQGDxxoOBogZwfs2q122XLWk01WnNYfILy8DoYpfabgATMVke3OjN7ArhL0dsSPYOgEygHVSE7wLV7R8+GSFFLb6Zf5ZVJCcErLMAncEb4kSjNhdXjt6ks/E7ShuMvDPYdoxq2WRC0Nyhnq9gUFig+ERT0lVPclMK5s44t8qbrLjUlqWUgm9+afzwxQCK6t8gir4Ej8IvjMMvlQjDWSsELEY0JwrEKLF6o0Szews/VyfUxNH5xfDiKq2qcO7C1uK+guf9nbcd7E96F8tG07WH8Efopsx4HQQzg46WOkkHNzWih5f4iosViYQVhT3ufaTOva22RI0Irq40sm6T+HyDWqhDs4Co2Q5CmlZNvCfvQvgYKtAEKM6PyolJH8TeY8QvOt2o8Hlan3SIduCqpqvuhoNTskMFDiH6ysG1wJ/itG7XUKJveJnIw5n9aAi05pIiprsed7ddR6exkYxXoJmKCLEHKRmkfA1932s8nLWtf/7YIi7UtUv1kkycrozoHLp9rkYpapvDpvwj7SKO0HuGZvblRabwIxUU/QXxJBXVw2+NT6HtW9I8uYK3m016chtWTRbNN/ReM4WYq9DW5LF2Wta36SbAWCqVY+ZiEqxlwNWWovy452ZAM1izlBc2f17B1Ss0v8Dbq57phYd8quyKlOqHAYjWX6isGz69L/5S0gVIwRkfPrmmwAJ1zw+deJvBfg0dPsOpJO5e96KzvjPFF4Ya7Wv2GSUPUrInvxeUnwZWIndWg37fQTb8xDX7Yd93NpYxb8408clp+FlKmoM5fZED6evezEYE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjJJcVdSZnJ2aFFuR3kwbkhTMGlvcllwOFBjTCtFM1dNY0Fuam5DZzFSbDEz?=
 =?utf-8?B?Qlk5K2tRRTNrRjlkY1FDTjJ2K01ZVlhtTzM0cnJQdlhHUmJYNkVLSENlZjBL?=
 =?utf-8?B?ZTJzcHBNYlBVdENGNy9weTMzMEJuYThESWdJNzNUV3EwQW5icGZYajllZ2RW?=
 =?utf-8?B?RmpCcDU0bGdTbWoyeGljQms0ekg1R2pqdkFSTU9qU2NLR2JSY3RvcU9ZZ2xt?=
 =?utf-8?B?VUU3clhyS2hiK2hXVlE4dTRObE8rNDVRaWtXekxuWTYyNHVjZHR2NjdHa1dZ?=
 =?utf-8?B?a2syNG1jSEZZNm1TY0Z2R3oxSSs5eWVDRkoxcnU4NDVFQk9DOGpQcFhrcC9h?=
 =?utf-8?B?cVh2ZzZXeUZHb3RaYWkwb3FSRUY4NFRrOHdmcXVVSXBtMEc2MEVHZ1hvcXQv?=
 =?utf-8?B?eWYySGJrangyM0lJb3J0S0xTamRLQ2pXNmJpR2hSRm9jdml2bVN1WjBYQmt1?=
 =?utf-8?B?aVU2RERBY21QbWtMbVBuWkVOekFpa1RhNjhiYmVkc1Z1aTA0b1RUdS9UV1pw?=
 =?utf-8?B?TVJQWVVhaFN5LzdYeFdaR2VFQ09OSno1UEFOMENLZDRTVFB1ME5oUHJRTE9m?=
 =?utf-8?B?b3ZaYTRVUjN4SjhndUovVkZsM1JsSEpMZHpub3JxTFpsd1pWaUsrVGoyVElG?=
 =?utf-8?B?THptRXBxclJqaHk0dU03ZnZ0ejU5T3lRNzdweHdKd3dFWCtyTDZaeWFPdHVO?=
 =?utf-8?B?T1dMTlViWFRnaDdteXhwWGhyTFB4RGNvSjNVdlgxeVZTajVLc1J6TCtJTzB6?=
 =?utf-8?B?ZDJ1US9LTXZpd0ZEdVVBQXBtUzJnb0JRc0FkSnNySUdFL3E0Rm8vYkdOSm8x?=
 =?utf-8?B?bUNjWGNRblFxRlNncmE5Z3pzRk9yQjJiQ0xpL3ZMQ09DWUtYUXhXaVNLcm5u?=
 =?utf-8?B?UTZSMERicUZqZHgxY3B6NXErYW1zVnVBcTNvblNlenNXNFdETzl6TVF3blFq?=
 =?utf-8?B?QUs3b096VzV0eDVReklrWjc0L0RjMGo2UlRZczh0TmJuSWprVnZGQ3ovY2JN?=
 =?utf-8?B?NnJRcTZWOVB3ci94ZU9IY3RQdC9jZlhveitMekFpU081ZkN0WFhRUVBTRFRL?=
 =?utf-8?B?Z2h5N0FoRFNBOUhFY2Z1ckxKNmQwR09zaERBR1dSc25MMTBWQUNVbmt3bjlm?=
 =?utf-8?B?Yi9pc1JkOFlmaTlNeXNaYmRQRHZvZTJQR2l3ZTZLemhMQ0hiZ21QV1M5bU9Z?=
 =?utf-8?B?cENPaUNhbmg5bnovNWdxK1ZFVXZIUTUzVG1ZK0UvOUp6M1IwbmVpVGdQTERN?=
 =?utf-8?B?SjlZVnI5MmdtUit3YVd5anBjUDBoMURIZmhVWWxsdEZWSGV6eGgvUFVyVWls?=
 =?utf-8?B?M29EWnpnV00vUDI5a0N1RHdrOWNMbFFLdXJDZjNMbUJIQmtnWjhkaUo4YjVV?=
 =?utf-8?B?Z1B0M0JpVUJTSUFEUHA0SkR0M29VelZiY0NZSDZFdHFsTFBHUytXSGNqZlRa?=
 =?utf-8?B?VE5wUDVzVE1QUTZVUmhxMWxFQlp0elJIbUJhb1JOOUFDUkpDYkVwZk9LbVRE?=
 =?utf-8?B?TEN1ZWVHdWJVVzVja21rR2ZhbDNidDZ6di9KVjkxaTJWajd5bTlpeFRHS2oz?=
 =?utf-8?B?dTc1N0tIUXhXZlF3eUJHcWlKczNmVHdKblo2OXBlNFdpQWFhdlh4b3dmVG94?=
 =?utf-8?B?WHFSTEgwMFN3Y2NVb1VPSEE5Q0NKQ1VLK2xuNFlSQi8xMUtVZ01sNkpBdldR?=
 =?utf-8?B?M0ZnZXdrMVA1VXo4OUJhSmtYdjZDRSswaTZ4eGRydGduMVh2aXNVVUVOd015?=
 =?utf-8?B?MDNhNGhWSDVmTUFkZ0tQQk9PWjcwZW9mYi9lbXhVWHdBcmpzV1V5UGs5M2Ex?=
 =?utf-8?B?WWtlRFN4QnprWU1rVnY5eUczRkFqaE9mVi8wVDMwbVlidGJrVHpoOUtzSVUr?=
 =?utf-8?B?czBXZU03WFcyWWYwTjF1Qy9EM1F6dmV3STZha3FOQ0lyRGl1RGVKR2syUHNH?=
 =?utf-8?B?NlBCTS9JZ29tbXF1bkZ3Q1ZmSVlDSE1DeXZXNkFUQ0wvU0VtQmZkdktud3Bz?=
 =?utf-8?B?Wmx1WnBlN3Fnd3hnRG5zOCtIS0VLby9hdXVSdzhkMUlJYW9ZSExPbUtiQXE5?=
 =?utf-8?B?ditvTlhESy9NYmNicWZLU2RMbjFtUVAzdXVpNDlxTkNhYmNSMWRUQnBaZFMz?=
 =?utf-8?B?dWtVZzEwVFpHSnpkcWZyMm0rZHpOZVllVU1yWTF2TUNhaG9pUE5PNFo5eGdp?=
 =?utf-8?B?cHZrcncxRkcyWjFONG52YjRDNUFqQXlzdW13WmlPa3ZEM08wTm5JRVZBcUxN?=
 =?utf-8?B?NjNraFF5bFVVVUpNYjNOTCtyMlB0QWs5RWNMN0RaREZpU1d2NTB5TERRb3hI?=
 =?utf-8?B?Y0xlSFhsYzl1dHo0MDgzaUlKeWFBQUcxNG1lOElLVUUyaFZTc1MzSC9uY2Y1?=
 =?utf-8?Q?BHjwPeyRCQ1Z/EPY8RQYPKfWnSn0QHovDHpIHCbb9Zrad?=
x-ms-exchange-antispam-messagedata-1: Xdz5aVIXqd/3kg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <54BC9298E562C54689A2F17C7AE00F6D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2407c679-921f-4fe1-355f-08de9b189dc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 17:58:36.1280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbDe6liV+uWsIjLCWJIlMuoJf1/6LKE+134v7GGn74S8XL5tlo50maIHTfNh+7E8DXBrbbG3x6+Lk/Prb1nqgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7783

Sm9obiwNCg0KT24gNC8xNS8yNiAwMzo0MSwgSm9obiBHYXJyeSB3cm90ZToNCj4gRm9yIE5WTWUg
bXVsdGlwYXRoLCB0aGUgZGVsYXllZCByZW1vdmFsIGZlYXR1cmUgYWxsb3dzIHRoZSBtdWx0aXBh
dGgNCj4gZ2VuZGlzayB0byByZW1haW4gcHJlc2VudCB3aGVuIGFsbCBhdmFpbGFibGUgcGF0aHMg
YXJlIGdvbmUuIFRoZSBwdXJwb3NlIG9mDQo+IHRoaXMgZmVhdHVyZSBpcyB0byBlbnN1cmUgdGhh
dCB3ZSBrZWVwIHRoZSBnZW5kaXNrIGZvciBpbnRlcm1pdHRlbnQgcGF0aA0KPiBmYWlsdXJlcy4N
Cj4NCj4gVGhlIGRlbGF5ZWQgcmVtb3ZhbCB3b3JrcyBvbiBhIHRpbWVyIC0gd2hlbiBhbGwgcGF0
aHMgYXJlIGdvbmUsIGEgdGltZXIgaXMNCj4ga2lja2VkIG9mZjsgb25jZSB0aGUgdGltZXIgZXhw
aXJlcyBhbmQgbm8gcGF0aHMgaGF2ZSByZXR1cm5lZCwgdGhlIGdlbmRpc2sNCj4gaXMgcmVtb3Zl
ZC4NCj4NCj4gV2hlbiBhbGwgcGF0aHMgYXJlIGdvbmUgYW5kIHRoZSBnZW5kaXNrIGlzIHN0aWxs
IHByZXNlbnQsIGFsbCByZWFkcyBhbmQNCj4gd3JpdGVzIHRvIHRoZSBkaXNrIGFyZSBxdWV1ZWQu
IElmIGEgcGF0aCByZXR1cm5zIGJlZm9yZSB0aGUgdGltZXINCj4gZXhwaXJhdGlvbiwgdGhlIHRp
bWVyIGNhbmNlbGVkIGFuZCB0aGUgcXVldWVkIElPIGlzIHN1Ym1pdHRlZDsNCj4gb3RoZXJ3aXNl
IHRoZXkgZmFpbCB3aGVuIHRoZSB0aW1lciBleHBpcmVzLg0KPg0KPiBUaGlzIHRlc3RjYXNlIGNv
dmVycyB0d28gc2NlbmFyaW9zIGluIHNlcGFyYXRlIHBhcnRzOg0KPiBhLiB0ZXN0IHRoYXQgSU9z
IHN1Ym1pdHRlZCBhZnRlciBhbGwgcGF0aHMgYXJlIHJlbW92ZWQgKGFuZCBkbyBub3QgcmV0dXJu
KQ0KPiAgICAgZmFpbA0KPiBiLiB0ZXN0IHRoYXQgSU9zIHN1Ym1pdHRlZCBiZXR3ZWVuIGFsbCBw
YXRocyByZW1vdmVkIGFuZCBhIHBhdGgNCj4gICAgIHJldHVybmluZyBzdWNjZWVkDQo+DQo+IER1
cmluZyB0aGUgcGVyaW9kIG9mIHRoZSB0aW1lciBiZWluZyBhY3RpdmUsIGl0IG11c3QgYmUgZW5z
dXJlZCB0aGF0IHRoZQ0KPiBudm1lLWNvcmUgbW9kdWxlIGlzIG5vdCByZW1vdmVkLiBPdGhlcndp
c2UgdGhlIGRyaXZlciBtYXkgbm90IGJlIHByZXNlbnQNCj4gdG8gaGFuZGxlIHRoZSB0aW1lb3V0
IGV4cGlyeS4gVGhlIGtlcm5lbCBlbnN1cmVzIHRoaXMgYnkgdGFraW5nIGENCj4gcmVmZXJlbmNl
IHRvIHRoZSBtb2R1bGUuIElkZWFsbHksIHdlIHdvdWxkIHRyeSB0byByZW1vdmUgdGhlIG1vZHVs
ZSBkdXJpbmcNCj4gdGhpcyB0ZXN0IHRvIHByb3ZlIHRoYXQgdGhpcyBpcyBub3QgcG9zc2libGUg
KGFuZCB0aGUga2VybmVsIGJlaGF2ZXMgYXMNCj4gZXhwZWN0ZWQpLCBidXQgdGhhdCBtb2R1bGUg
d2lsbCBwcm9iYWJseSBub3QgYmUgcmVtb3ZhYmxlIGFueXdheSBkdWUgdG8NCj4gbWFueSByZWZl
cmVuY2VzLiBUbyB0ZXN0IHRoaXMgZmVhdHVyZSwgY2hlY2sgdGhhdCB0aGUgcmVmY291bnQgb2Yg
dGhlDQo+IG52bWUtY29yZSBtb2R1bGUgaXMgaW5jcmVtZW50ZWQgd2hlbiB0aGUgZGVsYXllZCB0
aW1lciBpcyBhY3RpdmUuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaG4gR2Fycnk8am9obi5nLmdh
cnJ5QG9yYWNsZS5jb20+DQoNClRoYW5rcyB5b3Ugc28gbXVjaCBmb3IgdGhpcyB0ZXN0Y2FzZS4N
CkkndmUgZmFpbGVkIHRvIGFkZCB0ZXN0cyBpbiB0aGlzIGFyZWFzIGJ1dCB0aGlzIHdpbGwgYmUg
YWJzb2x1dGVseQ0KaGVscGZ1bCB0byBoYXZlIGl0IGluIHJlZ3VsYXIgdGVzdGluZy4NCg0KTG9v
a3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQoNCg==
