Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18C1CFBC
	for <linux-block@vger.kernel.org>; Fri, 26 Jan 2024 06:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250894; cv=fail; b=lSUziSa6p82GMZSklGspZnmYRj2XWlpuOAFLmlUgXuge6BcE7splrPxR3CrFvya7lX8Yp8syV1QEzsvTDXv72++OUymFCx3bBxFkYlKuCD7qBY8k8kJonHtADK1vVAfmMTaG+z1mYWcYevdrVeN+odWr3D6zmx+bxqVn9oiXazw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250894; c=relaxed/simple;
	bh=7j6CBRRvT0XXITcLIEsZWYzyP69GDRw5xqJevaXtQf8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBGFci0VeAzw8wANFekvvqvJIEZ8tsQeJcY6naLUyIO2ntGWi1Rk+VfVt5seL/hjIHQBWRkDavD3pRrGxK6ai1Zr3n5HWUGiypE3wkATpM1WOQMEfn+1gkpu8OxKK72QZ7xzmymAZJj8URkf6sALuKhlnfoMBVSYOfrCD3FPN1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PnP2J4Jw; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PnP2J4Jw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDftaxHmX6Fbh6rjU5INI0WOKPSHpfs9EhtI3+alqJ9vPtJNsS3D8DtRpkwhwG0ScHVPjaRr5kiBzqSXEKjgWwI6VFhBfX6w14A+YNq4sYEZss5A1U8AEwQoIy7me9NBlCPFt2QygVROKoImMM8GQgXtvG70YV32Ls5Df9ZmszuxyrjO+963H1pE7T+VQEyKYun8lrAv1nMv9Vpp5Cp6LxC/K6CWm4yCImauU6t6q8ho2Z9tNZZdJ43IPhNHebhOPCohtaFTv54AhfjCLAJ9aA62aqQP1dkdDuqNmtspKXZnV/UEugaQ2iDsUUJ0Jk/aDlwbyhRIaZY4gV/tRupi7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j6CBRRvT0XXITcLIEsZWYzyP69GDRw5xqJevaXtQf8=;
 b=mMH+UHX2Bz32v7qFWTzTSC2voc84wIdJPTnBLJv82X2QwN38hPFovAqiPmdXYPi/3uiIxntuqNUoL9Lvg2qTTxRgxnc60RhbptIyItYL8+83Ken0DakVTXg9s0Vv/yl4TweZ11DS8QXslJ6RZJFas4PQ0JqF86CJNVDrfAc5Rt98eMXtHko/gXaZdjXJnjZXYbP5Q638O6aogRalo6+fzSwq2hAHvxgSS8jNHK1N/3tHUN/Ix6Vc1POhPJns9sYxAfmKgn4Y5c7Wl6lB+NxYEuDbf8aNresBrozT8md3j/lUWCfqYE4Pc2/ysJ3/+LHgBzrMTaWXx3jBozaJnI4rfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j6CBRRvT0XXITcLIEsZWYzyP69GDRw5xqJevaXtQf8=;
 b=PnP2J4Jw2DTG6apiyKASpGHUIzX6SjYOTw5zAUsv7nEhyVrvpeMmpUJjuCvpH9Va6oA+yhNCKojAWIoRj3eUh1TV3VOEIL0vQvu43lVpeQSwQVJtyOvKg+uxqVI/TcALyX+4jIMUIPANPdfqt49xQLkb2ZHZIdPbMYKU2NP0FXuth78856sPz7+ut459dGnIjeAK2JexwAdvSYmU31lK+ugbUIRWbYDvQ/e5cNj/lBT7uSYT8CkX/xbpV+A7BehoETMqempENI9wmkdmae5uz9m+yxwIeTP1TyOt/aEI90tv0lzZ6U5Pbc1InorqrdiCqXKat6eei2ph64T//gxTtQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SN7PR12MB6981.namprd12.prod.outlook.com (2603:10b6:806:263::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 06:34:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 06:34:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>
CC: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH for-next] null_blk: add configfs variable shared_tags
Thread-Topic: [PATCH for-next] null_blk: add configfs variable shared_tags
Thread-Index: AQHaSC2lrv/Oq5AGDkmm0PEnfzxHI7DdZp6AgA1UawCAAPgggA==
Date: Fri, 26 Jan 2024 06:34:49 +0000
Message-ID: <e98bc363-408d-48c2-bf32-22756b1e5550@nvidia.com>
References: <20240116033927.628524-1-shinichiro.kawasaki@wdc.com>
 <481f2f1f-ee5d-4278-a856-1f0d01ef3b4c@nvidia.com>
 <e3c4bafa-e43a-4f98-b848-1c139dc2c900@kernel.dk>
In-Reply-To: <e3c4bafa-e43a-4f98-b848-1c139dc2c900@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SN7PR12MB6981:EE_
x-ms-office365-filtering-correlation-id: 03772554-f4be-447b-79f5-08dc1e38e5b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5gl+d9u0DvyEv97d4OQFD47eJPkVgw7ayjXObnD1vzQsP8M7j9S5UcZGGIie91f8qV1aA6y60bwGfXQkUzTDAkW4nVVAlK6WCG8bmLsJ2n6BJAlXO87+H1N8npizwV7FAdEzNCOr6SyHnQ7eJXioWqz4kUP30o1oueKO7E+ZiFUIY/Il77maTFexgpXGVIkZwW7shkU7Ox3c7J+5pTccIySQ/QQ/0ezCqRctDIhPmNGdUtOWmC/Q1o7ZKfCD44DlKfr9vG9+Amss6nkQu+Po9plth3nwIGx/MQraXhb0mQV5dWbQxNOxAtygavbVyAEyH5+Ci+LppWa8T2QpO4M2Rz6pMxPKgvQNhjMnZ2QaD20WZretkYTUHwDw1locobA5Mk1up4hC1vrIs2dfzxsgleYBOcARXvb9rjnme2l3pQfI9EFVgjsyeQyn7oI8uqS20pyWbMSwjAYn/oyUVNUEronAs7h/4ZM55fHlzg0VINFUx80wej9DQ8GPwPymj2VQ7/3hwcKz3xJEikNVRI6zMN2guVX78v0I+YBNRIM5JZQNQ7zk6ytwaHjFOfaHja11rZYMSlVtGiVFlcZk6aROFSmBevKg33FLRdEdJH6xge6ievJPM6ATziiOOy1VJuKguIAayNMlCXeJ9U9c10NFEw42yf+8Sb2r8KYuwA4UirGhASSSJNmZsW8mjh1mqlh3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(2616005)(26005)(4744005)(6512007)(6506007)(122000001)(38100700002)(8676002)(4326008)(8936002)(5660300002)(6916009)(91956017)(66556008)(54906003)(66476007)(478600001)(6486002)(66446008)(2906002)(66946007)(64756008)(76116006)(316002)(71200400001)(41300700001)(86362001)(38070700009)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2NTbjJVTTdXNzRhaFJYSUVmV0dQcFJaa2FoNUloVEVOdEJJTVYzcWpMQVp1?=
 =?utf-8?B?a1E2TTVoMG1TblBqcytXeGpjUkM1WVZwVmp1N25BYndMZ1NQUEh2enhsWTRi?=
 =?utf-8?B?eWRhODNTdHRlbXZJSzI3WkNuZHUrSGdCRlVJd1M4SHZBQm4vOXYyMHpuaVM5?=
 =?utf-8?B?QzREZWxQdlFWbzVmd3Ztby8wZGkvcTErWU5MOGk0bFZuZVg5eUsvVWZld200?=
 =?utf-8?B?MGZTOUZLT2cyaUZKYjFyLzRIanVJajF1S05IQVNoZ2N5dTBrZWZ3REFSWnMz?=
 =?utf-8?B?cWlNekVaWHl2YWR4N081YzEwTUFTOVFkQk5YWGdjUmxISWZtdUhkdlIzbXJ2?=
 =?utf-8?B?TVlrYlVpRTNFNWlrZ2pKY0YvWkF0d3c4VG80ckQxYVhBRThkWXVOMmgwWm5U?=
 =?utf-8?B?U1YwUTc1Y3VRTElYS3E0ampTSUdxS2d3Q1ZZcUNmZGxWNGJveU1tK3M4Smxi?=
 =?utf-8?B?bHFJeTNQUVlpVjdYYlBQbjVHWlhYMjhzVTl0a3ZoQnFqaGQxOHpFeFBmekdT?=
 =?utf-8?B?S2NDeitNZUZReVVBdlVUZEFPYXdmVkkxYmpPOGZPdXV4MGFYVHNzdEVQSGZu?=
 =?utf-8?B?SGtTbDQ3U2hEaGNBT0U0Q0JmK3pUYVJPYnRrem8wc3FuZFlaRnhrdGl4WUdX?=
 =?utf-8?B?Yit2aEU1MUN0bnZpRTVHVzBUY1kyQWEyd2R3UkN1NlRzbFVPL2NFeEpnSXZM?=
 =?utf-8?B?Y1YwMjF0ZXdMeEZZL09rblJGZElJYjlIMXV4a0p6YlB1ZmJ6ZUFvUVpSVlRs?=
 =?utf-8?B?OEZocjE2RlBZMU02ekxnbFdaUjdrV1Z0SUR1N0FlWjZiSHVqVFpTYndPdkRm?=
 =?utf-8?B?N3ZZS05YVVRQZ1ZuSzZQZUtURjZWWUMwZ3lOZzZJaEhWcENBY0Q2MTFxR0Zo?=
 =?utf-8?B?K0xJcUZMTkhQRzIzcGFJdW10cktuY053dGVNZjF0Q0ViRHlCWU1OWDRrMnFn?=
 =?utf-8?B?T2ZHWEFqKytPRWpBTHo4YWxpdjRYc2h4c1BBQ1gwZU40ckNHQlowTHBITFRq?=
 =?utf-8?B?YVQxM1VxR0NHenFxQ1Q4VmpQMVE3RXl4OWVNdG1RL0JETWE4UEczOWhZNWYy?=
 =?utf-8?B?Zm5SaTdLTHJCRVUxaDR0a2pyd1BpM2Q0MCtvTmRiR3IxU2lLS3c4MnpWVG9U?=
 =?utf-8?B?cFdkNERLK1d0UEEzNTM4RmF0amcweGlTRG8ybkpvQmEyVi84SkhtVm4zSjdy?=
 =?utf-8?B?ZnZ1MkxkZFR5VlhaLzNHYWd6ckluMWNDVG1QMmRJc0RQZEtyY3NXYXhUSUg3?=
 =?utf-8?B?ZHJXL3c2bDN0aSswcE5DNm1TL0owdGhnOFZNZW1SUW9xalVuNFdLNVNvY2VM?=
 =?utf-8?B?SzRObGM5VXc2aXQvRm9LRS9uOXlvVmpwYS9wYzJkSHZlR1pCOXppc21IVnhn?=
 =?utf-8?B?ZElPQkxMSGpnRko2L3lDdHF0dG5ORzFNZTNxcHgwNlVqTVoydk9Rb053Y3dS?=
 =?utf-8?B?QkV5YWhPSkNSWG5XdC9YMkZtai81Z2tDeTZDcHNpOVBHbHJxQm5ySjliaU42?=
 =?utf-8?B?NldYRXJrSnA1SFBKMmdmSHd0ZFNTdFNOQ3N0ckJHQVVRRHBqOE1TaFNpTXNE?=
 =?utf-8?B?SXE0UHd3c3FId2xvWU5sejkyV2s5dWRMUTE5VU1oc0N5dXp2QVJzLzRLVHho?=
 =?utf-8?B?TGJWb213a2grV3lnazBhWlo1T0I4OU5IMC8wTVBLUy9RQzZUc2xCQ1BCS281?=
 =?utf-8?B?aEN6dUc1Q3ZrOFl2Zm5nNUNUcjFnWnZIWStoRm9yejZjeWdkZDVlQTRnZS9U?=
 =?utf-8?B?aHVPL2xXQVpkSGdXeExhS1dHUDF1WUl4ME9QMHBBcjJmeEdvZ2NaTmN4MzQy?=
 =?utf-8?B?UlE5OEZ0dG56M0tGS3ZlQUtRcG9qMC9saUdraGNRb3pqdDZncDloSVhQNlJJ?=
 =?utf-8?B?YXFzWWJ3MkNEbnpqMUFLWG9RMDVPV3F5NnZDT1ZHM0o4UnlxUER4a2F5YnJo?=
 =?utf-8?B?YnlobHVIRGM4dlVTSTBEMEFtc3VnNnhsaHZjNDhLRGw3ZWJINGFKbkxSTDZ0?=
 =?utf-8?B?Ri9zL2NCMEFDNFBONzJpMEZ1M2lEMlJ1a1YzVllwbGpkbTFxWVM3MlBXUTBk?=
 =?utf-8?B?RithUmI3TVl3L09pb1g2eENwMkt6dWduSlYrT2w4cFFZYjVrWmJPbGZDYklw?=
 =?utf-8?Q?9D0GTsJdDnffG1exlN1+VL1wU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A9838DC3486C74B8F66B3F1CE16B6A5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 03772554-f4be-447b-79f5-08dc1e38e5b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 06:34:50.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u9RKMTg1GuaIo69Xnzv0tU/DatZVUepiny2lRTl3XFRGUQdeaE3g04GpmJ06ahLabz6bW1VMrqvCzCnel1UjQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6981

Pj4gZXhwbGljaXQgaW5pdGlhbGl6aW5nIGdsb2JhbCBib29sIHRvIGZhbHNlIHJlYWxseSBuZWVk
ZWQgPw0KPj4gdW5sZXNzIEkgZGlkIHNvbWV0aGluZyBzZWUgWzFdLg0KPj4NCj4+IC1jaw0KPj4N
Cj4+IG52bWUgKG52bWUtNi44KSAjIGluc21vZCBkcml2ZXJzL2Jsb2NrL251bGxfYmxrL251bGxf
YmxrLmtvDQo+PiBudm1lIChudm1lLTYuOCkgIyBkbWVzZyAgLWMNCj4+IFsyMzIyOC4zNTU0MjNd
IG51bGxfYmxrOiBudWxsX2luaXQgMjI4NSBhYmNkIDAgYWJjZF9pbml0IDANCj4+IFsyMzIyOC4z
NTc1NzFdIG51bGxfYmxrOiBkaXNrIG51bGxiMCBjcmVhdGVkDQo+PiBbMjMyMjguMzU3NTc0XSBu
dWxsX2JsazogbW9kdWxlIGxvYWRlZA0KPiBKdXN0IGFzIGEgaGVhZHMtdXAsIGEgc2luZ2xlIHRl
c3QgaXMgbm90IHByb29mIG9mIGFueXRoaW5nLiBUaGF0IHNhaWQsDQo+IHN0YXRpYyB2YXJpYWJs
ZXMgYXJlIGNsZWFyZWQsIHNvIHRoZXkgbmV2ZXIgbmVlZCB0byBiZSBzZXR1cCB0byBmYWxzZS4N
Cj4NCg0KdGhhbmtzIGZvciB0aGUgc3VnZ2VzdGlvbiwgd2lsbCBwcm92aWRlIGRldGFpbGVkIGV4
cGxhbmF0aW9uIGZvciB0aGUgdGVzdA0KdG8ganVzdGlmeSB0aGUgb3ZlcmFsbCBpbXBhY3QgZnJv
bSBuZXh0IHRpbWUgYXMgSSBkaWQgaXQgbGFzdCB0aW1lIGZvcg0Kc2ltaWxhciBpc3N1ZSAuLi4N
Cg0KLWNrDQoNCg0K
