Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D302FF164
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683399; cv=fail; b=Q0yeDOJ4EcaTGMnhUbif5EsJpbSjR0WCNT+VhMZjVHXfs9r1lHIQglnnWA+SGTr5HabGyXo1Ggtf0bZVFmay7Kl6v7FbWRt7+CYmME7481b+JEWLVtPwO46kYGatG6+0nXV5sv1qKc2Vfap5nL1PCQEoRg1I3kdcexbpd9XS538=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683399; c=relaxed/simple;
	bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FND5fdJ2vujZ1warMXeP3xvKEiYFwWDyPSo1V6PPX/nI/bXaNKvQhnUS636U8MGG+N2bh62Yq+SBS9KFn2k1IYVZZ52ac6xtNGEC0U6jMzj3OWIYsp1OC/Ss+b4i4cSttfOXWUhgU9utf1z6bP4noOrTcqcGHdUxwNDMva2c4Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LodkH2nV; arc=fail smtp.client-ip=52.101.57.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LodkH2nV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgSWQz+EPtq8U6OV/dDrNcvW8ueXuYAyZ+zpU9fcFVHsfi4DHcf1i4YsEyiKl3qAvjhltS88wWAdTnbhcuK20ijN5mrK+ProsB4NhT0slbJiWBlqp+hgbfPGy/oaOZA6zfnd61hmG2ThL1KqsuzdKEJVWtRAs0ziCtM3fzdKRV0nSjComEG/95/Y4U1OZmYUpZ5ApuqfVvNo4pUvStHA/cZNhiskNYJvKNNaBco7xGFFg45oNRnEe1MRiWi4EzPekvrZYvcOf7Gy/jxl1BArDDVxjmnAbXU3PpP6CKhy9tCz2j+LkuHHKYdGxmUkqlJs1ruvfRgDInismRcRAtyTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=UwtDPyn9UF9I/KbtOR5TiJBICOuk6tY35YGQ8eau+6Be9vU2MxJsRzYaszvOjjFTuLhqvA76tBRVrdQVhvL6miC//4NEZhbGuCuU6NYyzBdaRX3R6lIdOuUdnV1S7nTYGSBVY3SmjLJ0RmPCmMr1q8/DblslENrEJ3RoxdJTsN6jWtJHeeoC1P/27yGm5s/m0gcS574pdeqQjqhIthGtkTqxYnvWnwrQ4sP90G1YX4uOM8DsCIF1E+j6/KUb99wkUVPLFUMDY9zb61dGAZI+bXrT4YDfFStAA+6AGFJlxtzmwBy0NvvJVtHDSF5yAijPxpt9aXhU5t9KJO0Z6uIuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+rXzjoLU9S3N6xqyCbfPEidREAaN3K2Och7LAz/IkI=;
 b=LodkH2nVqtfKLCf9QJhZqOTuevDXk6BWbBfKgwLZTSRy0Kq8G5I2i0dDua92/kzQw1kDm5BLEAgeh5N9ko6K7LpgTEdvxHiIyES6CisymsjdqZfAqr0osp82etOlKciGxQA8UNT8B/5PZ9VaEG60G5R53KiFSORlhe/Pbt/3XiIFUSX+E6A478tVOijgpPzcqHztDvDM+e6o2+Vbc9Mv6gsGUdi35zoqoEUWvDoHniHrwORyvWyXxHL5gBkFtld/QSFFS62WVZG1N3kNDIMYx8aB9iV4TKPeGN1IaLymzl/6v4hbiSsmwM+3vOBDvJ6Wxc04kRm4ksKlNc2d0EFW/g==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 18:16:35 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:16:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, Hannes Reinecke <hare@kernel.org>, Damien Le Moal
	<dlemoal@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v7 12/14] block/Kyber: Make the lock context annotations
 compatible with Clang
Thread-Topic: [PATCH v7 12/14] block/Kyber: Make the lock context annotations
 compatible with Clang
Thread-Index: AQHc9RWSQdH1Go7T/kqHIVgXFMYLJrYwRLYA
Date: Fri, 5 Jun 2026 18:16:34 +0000
Message-ID: <148d3a54-1e48-4611-bd24-09f7a5a6bd5a@nvidia.com>
References: <cover.1780682325.git.bvanassche@acm.org>
 <91cb8c790fc8b26b8aa742569fbf8c2c1d099dac.1780682325.git.bvanassche@acm.org>
In-Reply-To:
 <91cb8c790fc8b26b8aa742569fbf8c2c1d099dac.1780682325.git.bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA0PR12MB4415:EE_
x-ms-office365-filtering-correlation-id: 65e56e48-a26c-49a5-43f0-08dec32e93e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|4143699003|11063799006|56012099006|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info:
 J74Ci/fSVKYc93o1cvsu4XEGp2YbwouqZ8ndX1mMH1z0k/HMUWFh4g0kLr4aFMIHt/38DbgJ1IPEp9za+WIT16mSFga1PkZJ5d7hHxLi2DGJuGHJeGwN3i43iil+taFiIiiK3OrH34g2W4n8aKP3cm3mqCTNWgOGPkvD4jBLIoCg9xYthZSZkRHm1OlEq2AoXFOIaqYC2HVp6MRDVfXzSHbIQwRcnKt8FAu7j85NaZN2ksdPaQONRKhys1DTtsh47tWd2+XTT4ZOWRtVST9BxPC7YYPa0fn2ouAOWbJ3nKsEtkmEpcQn/fNcs2uYMdMEUx9cYeIp7jz2uLsLGMrzqTFPc3H0CQixv2IVd0tUqMtrdlpCGq/c6WtD6EqBixgNyM5q9xb8wfBt7dBftLHRpaXKcvNKd5bFIxyBydiamcGxvu34FDtZpirP29KhJqQxn7Z8RoQymHt0vt+3YFyYGp2TXF2Fs5EROn02W/kvuHFMH35u2g/Xt8Qdtvyxny61L8cER9e5FGygvn/YTPT8k4OE3PbemfGaxGcG4Gz7JZY1qewPwj4FZUTHJkHNUMoftsqaDtxnnox1DbwV97VzbZWlZf2qq26nOH/45IpUHmyd0zRvpbsmAWqw6IpymmlwxGGe9NPenrwEipsxzR45iCIs/fdWH33y9BIdpMCfJeISps2KZItSzR5kRX/1fRj3mWQtLYocISOWeCvWlyTyz61ayFkTAfB9NbYpkBPqN5h5vVI/AhPppjrzhFh+PWs0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UUYxRzlFWCtKZ3Y3bUpGMzlPUDY1U0RxRlcrVmNjL1p2WnhUcFhwUVRyMzR4?=
 =?utf-8?B?OEZlVWk3cUROSHFKMGg4TUtuSk5UTGNUaktZVFpOK2l1WEJvSVBrYlREU3V5?=
 =?utf-8?B?VzFDSVp3YzBQSlJRenUvZ1hpTkdCY3E3dmRpemI1eFg4bXZWVGR5MDRxY1cy?=
 =?utf-8?B?VVJPRXpyeWtmYVROYTJRcXZnRnowbXlFNXhQa0hhTU5aekM1UWFGWE1kY0tz?=
 =?utf-8?B?U3UvYXZPTnE4NDNUV2o2MUFOaDVleWFqRXZ3Mmd5K3BMMWREL1lCdWtTaGJE?=
 =?utf-8?B?eE5UcmxXUGxNaWVUbUxYRWtOZ1dHdWFRSmVlaU1Relk3MS83WVZyU1NtRFA0?=
 =?utf-8?B?cnVjUDFCRWxlblp5VC9UaVFaUDQwRUpmVzNpNWdidE8yNHZ4ZG45VnIwQW9m?=
 =?utf-8?B?eGZ0SVNmbGZuYW44Rmprb1ZNUUttZFhHeFFIQUZOQUpPQ2lXTlNyMnkyeXlW?=
 =?utf-8?B?Z0xqZytrRlJVZytQZmxFYkhQUm53VHVRS3E1enRQMzkzNXU1QVJuV3NlMEVP?=
 =?utf-8?B?YnpwcWtDdUJMQUpFOUFLc0lPQ1ZjSVZoUEVlaWJBV3hDQkRWcmlyV1p4UWhl?=
 =?utf-8?B?eSt2eEZvWFl4N0ZJZzkxQnRYYi9GdGlnZGJVL0dUb0sxd2w5bzNld1FPenRa?=
 =?utf-8?B?RXQrcitGQTBJUlI1V3pjV2VSdDJ1dDVmYWVrdXZiMzZlUldMQk93RUsxR25y?=
 =?utf-8?B?VjB1cktmbGtib25aWjdhN2dyNzNac0U5blZMOEQ4WDdRUXVZYzVhaEpLZ0lz?=
 =?utf-8?B?OURaLzFhTEVwclJtR0Mzc1NCK0F0TEtvanJXNjI0NjFWZzcrbWZIcFg0NVB2?=
 =?utf-8?B?dHVGb2dhQU00QVNLVXBwbEFPRTZiSHF6RzdPb0p5OW52RlA3a1R5Mk5LOGhj?=
 =?utf-8?B?NjltalhUTVNqZkVkcGpPN2VPcXpqbEMwb0lEbzdHeWN4b0NyUlRyVnRubWFX?=
 =?utf-8?B?dDdiZmFVNXZuWTdoU2Y4Um42SWN1dmwvZmJWcGxoWDQ0Zm81a01aS2sxNEJ1?=
 =?utf-8?B?ZGd5cFYxd1EvTHFqU0JkajMwQ2F3OCt0VWJrKzFuNGVhNFFrdG1ISEEwWEVz?=
 =?utf-8?B?SUQ3VUZKTmRxdzQ5TlFLVkE5SndCUS9IaUtnTWI3c1E5SVo4anI4VXB3V25n?=
 =?utf-8?B?K1lNYnBGTDg1RzJXSHRQVElucG5FbndCR0NNL1lrMWNFTFBZMnl1MHdSd1Vr?=
 =?utf-8?B?bDJ5NVhZK2pmWGhVNThaK0FDdjFYdFpFd0tTWDh6K1BEVEZhdEVSaERYcFZJ?=
 =?utf-8?B?Z2xLRy9MT1N1eEkxaDllT1JOS1pQTUUwd0dQTmNBU2xBSEk5bGVWdzFONFpI?=
 =?utf-8?B?UTZPMFJkOXl2SHVZTUEvQXlwMDl6UzJxbFUyV2FqM1lYOFljTFV4STBDVHBS?=
 =?utf-8?B?SXMySk80Wk5SZlFDT1Z2TXRoVms1eWpGOHprTXh6UCsvUWl0M2syQUF2dm1m?=
 =?utf-8?B?UmhwODFKc0srek9FWjRUOSthcVJrSnZQNWNhUVZTbTBDbzZiWDZBeU9RalJw?=
 =?utf-8?B?KzJJbmJYTEJ0Z2oxYWs4YmUreFd0bzVGc0FibXNXSFlCTWthNVFqekI2Rnpy?=
 =?utf-8?B?QW5WNDFnRGdGcFpidUt1c2dFNHBZZ1ZvZUdpZUlSNWhZT2kwWkszbXFIYk13?=
 =?utf-8?B?dGRHdUU1Qy9KbTVNRTRWcjRybDdZRjFBcytXaUt6aHpsNVZ4dUE0dGRlcERD?=
 =?utf-8?B?Tnd0ekxjeklHYVo2ZllNNWxsakFhbVFYamRnalY0dWc0V0dmTm9GRW0xcVF6?=
 =?utf-8?B?ZGtBRkNBZytGT0lZaHMyekd5N1dEZzVvMkwvYjQ4STBrRXVqakRJM0NPc2tF?=
 =?utf-8?B?bEZ5ZkVFUTVQM3JWMjFuY1hCSVB2S0JaaElTYndzZkNaamkyZFJNSkJrVVRl?=
 =?utf-8?B?VnFMVEo3ekhUUlpKam50MnJFMStOaXUwQ0RpQkFtMlArZmxZbld1WEVPMG15?=
 =?utf-8?B?czh2cXFGOERkZHNrVGVaVG5kb25Eb1BuczJPc3hkM2JrOEhpRkZ1UjhySTZE?=
 =?utf-8?B?MXpDSnE1dnhvYmxrRGVTTktndjlEaHMyNXpMTC9oVUJTU3kzMWl1NjcyUXpO?=
 =?utf-8?B?K0k0azNDRzhTdVdMVWNLYWoyUEpvbXk0Q05IN01kcFp5aG8rVldncXdheGVn?=
 =?utf-8?B?VUJQeUtMMU5tdUlFYndKWW40VmFPYk8rT2dnM25pVy9ETWY5TzNpNHBabWhY?=
 =?utf-8?B?TTF4bU9jYVZvYmJSK0IxQW1nRVJwanVNSmRMTVBaWVpRdEVqVElwWDExZ2RS?=
 =?utf-8?B?S1NGamYzdGtqRUFEaTFhcklxQ0Z3eTB2RnMzZTdVb0hsdTM1Zmd3cDE1ZGM0?=
 =?utf-8?B?Wm15L1VXVWpaYngvcjJ6NXpPdWowS0hrRU85eTkyMnV6WkdocjNjaUdZWWZO?=
 =?utf-8?Q?jz2owBgMEJud2bZ3Hj5EIsjdsnHNVJUvjiyr8UDxDERI3?=
x-ms-exchange-antispam-messagedata-1: tbbUwxhWDorn0A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE1FCB291D901F43A7E24768F75618E8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e56e48-a26c-49a5-43f0-08dec32e93e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2026 18:16:34.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLKsrb7joNhEA4H1VxDW+r9GUelnrlg8w436kTRsOyfS6yYMZNoO6QKiwsRuAg5J72S2cxk19DiLE8/HuWEHjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

DQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZp
ZGlhLmNvbT4NCg0KLWNrDQoNCg0K
