Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795647691;
	b=W+jlUOy8UpFAhqxYBz2ruEN5Lc6+5qyMIhzKuHtTHycUc1Pgh/hpDaU/KOWAEkvMiLUC
	 Px8/bMZXuqYPj719EZqN8Rn57Wc5Bu3b1jKPQ029sDavX8yWMmlK16DkxUvjIADohOf+a
	 dHWvwRyUZzwNpfzQvd2eW+K56aeWeNLBk1HKzAJJuFZX3VoEff16PBXQG0x2USNrUTMK6
	 lc9M/RrZnBj9rvfL5q+IBsxg6Z0Pd01hdTvY3fxWxXUO/ngPBkre5dTxw+qGOB1tJ05SN
	 kNg1qCvRuHGNq8PA9YANo2vwVjrhXIY2r023Ti+QjXgNGgBHukjLBVDvAhxCmbunW6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647691;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=jiGDpnoKL2iadwZqDITXmS46FuBJaliTGZBd+b1kmK8=;
	b=vJ9IjxfeDfs0Mmzy44Ai+mBWkxSezQs9/2WaHjXEFVa16HNjdhRePE13EVGb8VIyXKkZ
	 N9Qce6lKDij5bWFcsX8f7V3t7Zxd46zm07oxOuhNtN+qn70O2zePwvgr9rCq6TwhVjogl
	 XpRrF065pxtsnBO24TMYkHu6efu4e7p9hmMsIo9qGsXWK1N0yY0EnOCKtDRnbVtsQJhsr
	 m9oCo7woACpCKEaFgKcS5EOJwcHDW7gZ+MvDLkEv1bLMCHqq+aZMt8nx/MbzM2qdx440H
	 5ED9v53dJK6KLm5cwFtuz40lWqR9cuaHuVjg5EDl7Suze6oi22+Ti+RwCPGW5JTvFfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a6Yc6466;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.59
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013059.outbound.protection.outlook.com [40.93.201.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76E1606A33E
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 23:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C76E1606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=a6Yc6466
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eA6d9iR+yWBomi1URCCNhla4vHF+z3nnJzZm2ZQkZL69991NZjQvXNYS7XjAj/6uSOWuZ+5aMCYWKyNDKb8US4QYAuHAMolg+ENbYzMyoIE1iWB445L+tpIBNf/IbgveVv3qQSdpvA9S2iyOMhzOJ6k3rCS/nt7OMYWrXWzIv0z8wuIxs0l6vcAJRu1jN/jQIHE/WCC1GF/isksId0Bz0wXFE1fEsbUuGJVfgtED2lBNIUGjd/2fFD1xEvhhSNYKVEnarN5M1Y9oXiS+RbcBjFjwN1RHEKwf73WeK2FyafC2bPWPRmpRZU+6HPXySMmoQ/Wf4/vxNMgqpuDBXfZzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiGDpnoKL2iadwZqDITXmS46FuBJaliTGZBd+b1kmK8=;
 b=Nm2SUsoCdgk4vI4R5Y1Oe4n9wvxxhCVZZIxs6GQopqzSMDo18x9NDbXFlkr81DT2W+cuXreMVu1y6w0t3eOpm51VQ3IU9Gq6HkR132IvtSCHGUwckU/Hwgp3lIDthNH/pGnP3KKfmz2BhAUXQ//7lAp5zYoNvEPjxu5IRYEZn7sT39wYx5CyPs0VA2eY2CFAaUD/Qw9Dx/yPnn9IZWIRgv31IZpeyCR3pvTSn3HBhYlopHNXrrZaT3hy542z84U08+zpKAPwLfH9VaxYLZTr7XmDTUPKxJL+x+LURJ0GJzrDTUdyQGbOUHbP/9aH8rppgMyTjyMXtA4Iop5nwaWk7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiGDpnoKL2iadwZqDITXmS46FuBJaliTGZBd+b1kmK8=;
 b=a6Yc6466vgF5d/S78bR2fB2Qex/r5+Cb8ph68RnGIoLF/qo+Pjq6Z7+aV+FXsz/1HMRQgvolFCd/KcQR7x4d2wEI5Y60Vx5wqd6mAsOScVyQPqN+Phn+uBSrwnQe7+7lXxcrRE9TsNZ/H6NsOhJcimewHEYU9GnXBVl1imuqBay3Yb6tZeSLbtkJ2FiASqHSlH1DfQGL3Do2TCJL5QBsHWvC3VmDftv65d4pzm4GYO2NkKWqaT+4KfaTpuEW3V3zQNb5rjWNpgXMd5FZour/RxSRkiAP2DieN2VUX5Q4V3uO1sEEQLR18KLw3JY/wTUI6FQXTa88QpX74SHCMzLWJA==
Received: from MN2PR12MB4159.namprd12.prod.outlook.com (2603:10b6:208:1da::17)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 23:00:29 +0000
Received: from MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee]) by MN2PR12MB4159.namprd12.prod.outlook.com
 ([fe80::5f4c:13a2:f9f8:8aee%6]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 23:00:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: Christoph Hellwig <hch@lst.de>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Hannes
 Reinecke <hare@suse.de>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Niklas Cassel <cassel@kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 5/5] block: add ioprio to the bio based tracepoints
Thread-Topic: [PATCH 5/5] block: add ioprio to the bio based tracepoints
Thread-Index: AQHdfBjUalWHTgZlt0yl2K58mRZ6/bc/aVaA
Date: Wed, 25 Nov 2026 23:00:29 +0000
Message-ID: <09b78263-22cf-41dc-8ee1-cc7ec4069711@nvidia.com>
References: <20261124133553.152463-1-johannes.thumshirn@wdc.com>
 <20261124133553.152463-6-johannes.thumshirn@wdc.com>
In-Reply-To: <20261124133553.152463-6-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB4159:EE_|CH3PR12MB7644:EE_
x-ms-office365-filtering-correlation-id: 08c329c2-2931-49f9-5620-08df4b47e6a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|18002099003|22082099003|10067099003|11063799006|56012099006|261022105027099003|261026140227099003|261028144727099003|38070700021;
x-microsoft-antispam-message-info:
 idxw6+p13Uzxn3cs4v2nXeU1lKlxtjIjakLYM16ktplCnzYpEEhrwjGnO0wWIDx4oKuWRgErrvzrMpjfD1cPgOO9jgOsvrQax6EKvcjwjqLkE2RJEXde6VJgBOhFzqaa02smWCNxISORrqcFIyaW8KmHZ2qjv0SiT3NXziAIhadNC+EjmPlMp+YkgWD0H2o52d6o0Xsg0wJ2XZUhD23ztao9ZP9T6+9eFI/aS5PyiZ+lE+tujqDnD8kLAqzbowtDm3yeDcjq6pu13iJrWWHai5l+rOQbO1MoAHx07jv/lQHQwqeu1r2fhwmAmEeQzk9eOPQsSxCveoDuRGiaCEKurnIAA4SKf9ITRl/301WRFFgaAhlHcoA6o7+V+64Ok/J9Mv2seslcN1M0Olj6vjUlk1bxHCI43PZjC62Kk3rrdpTf2EsAozQdVuVBFC2U7JMzveYqSDvvtl8l4sFXGski/A5Fw2SyFXKWxhTBsxFqLeCi1WBxA6n0szMa8g2ESVom3w+zl3uSgvrbwmETz+vsv0+ulCm8G4cznq4065BEcOhfVCIU5XgvOy3NmpetJBDUIfuq8L7lBhbatqboTYYvxI/BFNAMpFqVSHOrCjNVqpMDnY7v1xqQ2yuJhBPPKZCym865WEicnHdb1z5BSY/NuVdY8iD/pHjMu3y2ORGQrmgS4oO2OdxgGq0EIq+ygpi1WZ2Bzx0U+iv3nGNp+0fqNQ8HwqLKFp6a64HJQ6KtbrQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4159.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2xSc3kvazVzUStTT1BQRElKSnN0QmRmUUwzMUJjU2lSWFg0akFpeFp0cGJE?=
 =?utf-8?B?QlorampHc0ZjU05JUTdvNktWdHNYNVZsTmV3UzhsakIxcyttdDdIUnB2NGNm?=
 =?utf-8?B?L3VJRTRPWGR1b2ZScFJzUkN2TEd5Sm1SaEt4NzY1ZXF0dmMyUVVhOTN6M2Nq?=
 =?utf-8?B?N3RPTWhwc0ZNby9tQVltd0NuTE1Qbi8zb0h3NHhPTVB0bkJva0t5U2oxWkFO?=
 =?utf-8?B?cEZkNDQrMDhrRVdXczNUSHhTNFV1bGtJQ0pXTEZVU2E3RHYrNFArWkNrVHNa?=
 =?utf-8?B?aWl5b1N1UzZCeUdVUHpTVnhqSUtZQTk1QVF5dUF2SFlCTjNqaUpVME9BdlVE?=
 =?utf-8?B?V0ZpU2dxc2p2SEVoeDVzWFR1d3ZtYVoyMXBvZmpOei9aeWI2Zjh5OUlmUmtJ?=
 =?utf-8?B?MWtCVEc0bk1adS80Rjl1RUFiQmxkcTBwc3JNWWN2Q2NUZHk0WVlVWWJFMyt3?=
 =?utf-8?B?V3FlVENpTWs0RTFMa1VvRmZiNW1Idmc3QXNIOXBJUTdocFJuSmh6Um5QaWEy?=
 =?utf-8?B?L1FHalhyRnQrQ0I1VjgvOHRvbFpudWJyNzZsemxOUjNYN2FEK0lzZFlaZ3hT?=
 =?utf-8?B?MmxObzlhTWwwSkRXT0dWTGJEVUE2Mk1HRVVoMmdGeGd4bmRMb0xtdktCYVRt?=
 =?utf-8?B?UlpQVjVZVHVIQUw4Z3NHdXVJbzNJUTNBV1crRzhmWU1YR3YrbGhheWE4Z0Y5?=
 =?utf-8?B?WTNLNllJeVFYQWoyNEwyMER6SHBnWFcwT0lvVDVacHZXdlpjM2hNWmlXTjlX?=
 =?utf-8?B?cEQxcGlaTElnN1lEcEJ0aGgxN24wU2s3ekFNT0ZSQ1VxRGpXYXdaWEVrMkFQ?=
 =?utf-8?B?SWVia3dTenU4NjB2S1NpZHdjWWk0dEgrS2Q1QmN3Q3Jsbys3UDFxbjFraUpE?=
 =?utf-8?B?L2RjeDd0UTJmVjg3b2lmNFRkYkxYd2haTVZ6ajBPYWhTclVzQXN3K0tsZU8r?=
 =?utf-8?B?aExTNUE4aHBZVVpPVXJQMzZneENrdFU5ZGNMbzcwcG05R3NjZE1JVWpsNlZx?=
 =?utf-8?B?NG03Y3VqUjNnTUV3TVd6enZxZlZZN2xPWHhCVit2SDhsVHUvSUllSDhnU1Bu?=
 =?utf-8?B?QzM1MCtNTnRuNzJ3cWlSNkZXUjBoQWp6V25JWGwrNU9Yenh4cjNzaVZHYk5D?=
 =?utf-8?B?RURvNnFidEhGSWVyRmZSSXpnclE5Nkt4QlhNVU1hSndEUkdxWTduOEg5YURu?=
 =?utf-8?B?M2F4ZmVGT3VCNlByMFVDQ0FZZi9WN2FlcG02NmdxSjZhamlndXlvY3RpY3FJ?=
 =?utf-8?B?UDJGT2lKYkVsVythOHNGYTNHMXFtZzQrYVAwRFM0Z1FhOC9Ta0xCTHBvRjdt?=
 =?utf-8?B?K09CM0NIUC9DMHZkbnlzdkl4cW53V08wRkx0T3hKT3Y4K1FPSjFsQ3RmaFB4?=
 =?utf-8?B?SnJpV2NTVzJYaWZ0WUtYSzg4VHptcUZQWCtEVlM5Q3pnYUZ1cE9mV3hZOGR6?=
 =?utf-8?B?YVczY3B1cUxKS1lVVDB6V053V3F1bm03OGREbFlodUNIcGx0OTNVOTFZNWIz?=
 =?utf-8?B?aFZMVHRiUEh2bWRsUkloYXNoR2EwTnNBdmNsWlB3QUVFbFZyalVmL3h0bHIy?=
 =?utf-8?B?blFsMEwrdXFJV1ZOeG15Tm1JTmRLVkIyNjNlZVpUMUx6WGhNWmhpdzZkSHY2?=
 =?utf-8?B?cCtmQXVGd0RrTmhZMFVodEF5K3VPZkdTWlF1MHJKMnkwbjF3TUVDQnZpSHVX?=
 =?utf-8?B?K2dUZVJWN21MUnRwWkV6YmdjZ1pIZXpITkY2Wk9MZW5LWGFoR1BPMU1JejlF?=
 =?utf-8?B?RTJ1N1E5aFd4Wit4RVB0STdIU0xXMUI5YWdpaHJGWjg1YzFZc0dIMFgyejJo?=
 =?utf-8?B?T2NlZjBsZDY3YUtWdDZPdEVQSmtNUlc0SjhWcGNzb3ZMcFlia1N1S0JaemFI?=
 =?utf-8?B?OWxQOGRhNUtqVTcraE56UEJOaUZpZ3plMkdmdjNadzVla0d6ZlgzREFJbWFn?=
 =?utf-8?B?NmJpa1N6VkpZVjNnM3dXTzdNelk2bnM1VVEweTNVTm5yVmttelNINldiUFpt?=
 =?utf-8?B?dG0yY2o5cmNKdjJRbVFKcmVkdGt0eUNTTG5JR0xtSFp3cXV0U2kzMkp6WkpW?=
 =?utf-8?B?Tzg4NnRBdHJLTU1FK0hpTTFlVEpMb3VxbWVpSW5YNG4vNVU1WmpjbENIakZH?=
 =?utf-8?B?bTd5TmZSZTVlMHJwQ3kxOEowZno2Vk9lQVF6VEUxNWZDanJIelBvSWFMUUNj?=
 =?utf-8?B?b0JTeU5lcGRQOHFMS0h5dW1VZ0JvSTlKZ2lhbTZCM1F3NDk0UFZ0eWVZWEtD?=
 =?utf-8?B?SUJKMUJqdjdKL3BWUTZ1QUZXU0E5di9ZSVZBekhvWkd4Wk1SNzBWbEZRL1o5?=
 =?utf-8?B?Y3B5OGlBUU9VZy9jWG5pVUpla292TjhLQ3grcSt1OWduS1lKWEQ0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC3286121FCED246A5606E36B69CCC42@namprd12.prod.outlook.com>
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4159.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c329c2-2931-49f9-5620-08df4b47e6a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 23:00:29.4137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xscYEZekGb/1zrryviDii0v2WridQxF6eKwlGZZBklAWqXGmGrzAGJATdNLYlikJyd46l2bgrO3aaQVgBaxtNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644

T24gMTEvMjQvMjYgNTozNSBBTSwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPiBUaGUgcmVx
dWVzdCBiYXNlZCBibG9jayB0cmFjZXBvaW50cyBhbHJlYWR5IHJlcG9ydCB0aGUgSS9PIHByaW9y
aXR5DQo+IHNpbmNlIGNvbW1pdCBhYTZmZjRlYjdjMTAgKCJibG9jazogQWRkIGlvcHJpbyB0byBi
bG9ja19ycSB0cmFjZXBvaW50IikuDQo+IEFkZCBpdCB0byBibG9ja19iaW9fY29tcGxldGUsIHRo
ZSBibG9ja19iaW8gY2xhc3MgKGJsb2NrX2Jpb19iYWNrbWVyZ2UsDQo+IGJsb2NrX2Jpb19mcm9u
dG1lcmdlLCBibG9ja19iaW9fcXVldWUgYW5kIGJsb2NrX2dldHJxKSwgYmxvY2tfc3BsaXQsDQo+
IGJsb2NrX2Jpb19yZW1hcCBhbmQgYmxvY2tfcnFfcmVtYXAgYXMgd2VsbCwgc28gdGhlIEkvTyBw
cmlvcml0eSBhbmQgd2l0aA0KPiBpdCB0aGUgQ0RMIGhpbnQgb2YgYW4gSS9PIGNhbiBiZSBmb2xs
b3dlZCB0aHJvdWdoIHRoZSB3aG9sZSBibG9jayBsYXllci4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
Sm9oYW5uZXMgVGh1bXNoaXJuPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KDQpMb29rcyBn
b29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cg0KDQo=
