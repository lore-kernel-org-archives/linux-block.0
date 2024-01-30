Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D69355E51
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600993; cv=fail; b=IqrpYEwzrDsl3vX0NNX5H4Dtz2//SBpuS4/IEZL2xRXYgRHsOY80Q2+TTF85N8Zs0RBN83uezheLjP5BrKfS3hUIzX7Ebe4AhP4cvRSTW1n16r8ryRdYjga0t50X8CoQ/jqV+8KaBOtJVehE/sRNR9atYJqdiqb0FtoGWgRdbBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600993; c=relaxed/simple;
	bh=d9gKaaqGP3wSC7PFWNt/R1Yn4EsIZMMDy9jYrbMZZbA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VhWTKYu16PKPIYGx9tXAiy6VV2WAkk4Mi45RKIuJxEDtVNFKZm4Q/W0HzdtCwXjPz4HozWG2+FeoWeVMmFesO7ksG6UhxlgfaUeMIz+4mILAjVLv6jzhuHKQiOr7Oz8dABLTi9qN2h84iYNMRQ7B5AnnNDQjSR2QoQFL0Ryflp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uitODwEq; arc=fail smtp.client-ip=40.107.93.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uitODwEq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dA4SZu67P5w1ZdVCDbnhlIGZgaUBnchDSDYF8brS9Tg7AJmT4wTQA3hKOT+p1k7tMfemRuuidFGTLRxZv9/dp/6XzsdDpyelxVq8lkpmaMR66fVmyL15ATXsLEOqerFPzERkyLVWA48fUsQ8acDKLbvtmfrAcDtYZEJwfGO83HG/wYCqz7WfsOMFCPglHflCfaIw452Nw/fjecRC36C59tK5QcJ7tL8cOua/hU1SAoJCa1mscJEoGdpMV2x1QyyH+dkTqIj/1EwWIAUBDhsVp+3yEF8yUdG3iSjyWXnw8XzLYaKoDmuU7C7m7LST4R05RIlthRQPMtMx5xawaqFddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9gKaaqGP3wSC7PFWNt/R1Yn4EsIZMMDy9jYrbMZZbA=;
 b=e60ecJ6BwSGTltJeatV18an6gNIBO+OyuNW+dl90ufd3VMCfS8Ngq7c0R3lg7mZmUmL84T6Kgps0U5SwJmaRZg64o2d9U1RjF/iaAcvYLz27RII//8cqUAkk1YGnc4nw2L8sL8UQbjIiAxJw8bRoqWfnb2Ac6Bj5DaUh6raKpq5zXTDxD8BWoCblnqPGvNpUDVaEDcxyqUPHzoXBj/eJINVVsInu+44as9FjoTlFJujFu2PxbW4egRtVsldIxACjNEk22yAoWSIRGvV0jg/16LKx7pvvUGXbGJmAc+r5EGGLcJJGQadjaFYdQ9jCDAxb2jwPxPGPbtgC9W/sGC2EZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9gKaaqGP3wSC7PFWNt/R1Yn4EsIZMMDy9jYrbMZZbA=;
 b=uitODwEqh2IHqzjeNN582u9ne3VNEoqbVvi41KFe2n5QWrQ+QL1tdfIW6iuQDZRIwllmLC+T9whypMDkRl2i/qgnK+prdlWzjvhkRjrM8p124cgHEmUxTkVEiAu8+47SkM1QESJwTr7eDjOfhPB7OjSvpOvjh+QSPfUgiMM9iT/ta0ZNB6PbAo8X3XiNcL7mHSGaDzLKcx46toZE8pv+B9k19VHY2Oa02OJ6VD/knxY5o3NA39u8pZ2AwHq1vkQATo/cJzj3po7AVql9+4ykRi60mZLt41m+b1PcklDlHmVDt0z7j0zVul7KRZye1LEzpPG7QL0slFBal28sQFJIzg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4085.namprd12.prod.outlook.com (2603:10b6:610:79::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 07:49:48 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 07:49:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH for-next v3] null_blk: add configfs variable shared_tags
Thread-Topic: [PATCH for-next v3] null_blk: add configfs variable shared_tags
Thread-Index: AQHaUzPUZbOAzRuSeUaYFrCKlgbdl7Dx+2WA
Date: Tue, 30 Jan 2024 07:49:47 +0000
Message-ID: <ea97f700-45b5-446c-b58e-b77c896deb46@nvidia.com>
References: <20240130042134.2463659-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240130042134.2463659-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4085:EE_
x-ms-office365-filtering-correlation-id: b3e54db9-ea7c-4bc7-3be0-08dc2168082c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CP5e+aM3dO0XjYnm9srUOaoNysWaY4Tn2zcGR2/ch72Cvk4WUnmLA4MDTFXDZr1zd1w5wAsSH9PrPon7J4oGm//AhblU5+9/hKS/BCtaI7v4eNUi9RsAD65NspMe4PluSRnLkpBpcfT4b+OahK3BZRN+ytFeawtRnhuHaRAcfbsNckWrA9066vI8ptDy3vR1IAo5hVUjsX89YJdkFXkYUCA6gSjzRN9Mlc0Hm9mGnScMO7q+UMKKAOjqucG8ltX4MRolkJq3Zm9evnQshnG3F8ThU0/z0+NwCQ79hDKD4aT8H2WoHwSd6rflZ+d4EO3srjRdL6nI2NYbvtoWN0AUKuCYM1DpgrvBElP1/nEcB4FVUY6sWXrdo+KlOofnsny27NwoAXRDPBYRF/NFlY2drtR/jOfcghJwGAttECatxY+qA7MStIlkOVtz94kWyOi4zMvDYB1uAzyUXPHiGv3eEz7BjwOpgWY0D+/fuVlLwNl4NMFc3fW7gOyAkYw+0Pg6lntiYVT3WN2LIDelGSHuHKlyfKwiuzqh0rtlvjhXOsfDMlZACm6+DSlphJ1VIHRwyDwnE9N/s7EB3G114Db9zx408SZJHSOXUe0Mipd8sm6YXVUANzigzn/K31URZLfD1ogWZHAJkiNHTpxz30a+PemBdQIZCVNVAO31HiFBUotjPr55rFOHb72a3c9eVSnV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(31686004)(6512007)(53546011)(6506007)(36756003)(31696002)(38070700009)(8676002)(4744005)(8936002)(5660300002)(86362001)(122000001)(41300700001)(4326008)(2616005)(38100700002)(2906002)(6916009)(76116006)(91956017)(66556008)(66946007)(64756008)(54906003)(71200400001)(6486002)(316002)(478600001)(66446008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDh6Y1RRNlRlRW9YZ0FScEc5RVlqZS80S1VaaDdYUGFlRDVJTklDSURRY01n?=
 =?utf-8?B?eUt2Q0wrY2dwOXhqUC92ZHJaYW5WSUd2cU9VaEgxeVpPZjNmL2pKTGhLMTV4?=
 =?utf-8?B?V3BVTDFzVGFENVJINnVXZEM3cWx5dDRxa3pEK28rMWRpTzQzcU1qMWhaQUtY?=
 =?utf-8?B?QjliNnYwK1BzWVFWWThINXlPcmg4SFVmTi9WS0c1M0hSZlE4SnJsQUVDcGJn?=
 =?utf-8?B?VFpIeE5ka3ozaXlrUG43dGR1cWxETkJkbCtEZCsxa2VwZTRtZnorRUdIdndw?=
 =?utf-8?B?YnN4VHBwandvSlNsazc5M3lrNElhVkpCSURGeW5LbFRwQjN6TFNzdFlodTM4?=
 =?utf-8?B?K0dCUFV3SlNNQUNsN0ttUm1IRzlpMXNQS2pBZ3FIZk8xekxmZGRwMk0zNHBC?=
 =?utf-8?B?bHZiMGo4ZXRlWTMvaVZ3WmRWSURuMEdtUmpUSjhPMWFBWS9EWWlRRGQ1bER5?=
 =?utf-8?B?M01kQSsvaUVRVzZtUGJNWDF1cnZRWDRkdVR0Um5Zc0VQbmNmdEUyNmR6eXBU?=
 =?utf-8?B?NWdlcXFPeGZyc2dPWEFwQ1BMK1NhR2kxYllWRG9xd01yTXMvQXB0MUZUOWV6?=
 =?utf-8?B?cSs2TU1lLzRoL3l1RHd5NkRyOW54Y0dtRnNHalBDWGdYYXFXcnkzSXpPWDMy?=
 =?utf-8?B?S0doN1JnQTh0Q0lXV0gzR2NtMGErWGtsb3kzbFNtd0lHSC90Rmp1SmtzMG5N?=
 =?utf-8?B?SEZxVGJ6Qi81aitxdy83N0lGWk4wRy8zOU9DbG5sQ1JGUVBkM00xL2U3Y3Fs?=
 =?utf-8?B?SFN0bjB4dml6L2cwNmp6VW1QOWEzb0JsMWZwYk5lZzdCK3owSkdCL3owK05F?=
 =?utf-8?B?U1JEY09jUUxrQlF5LzkrYjNpcXNPT0ZrYVpWMFNsNEQwZTFRYWsvRkdReTFY?=
 =?utf-8?B?cUlYWS94VnVLRFJwdS9IM3JLeER6TUtwM2xzREYzQzhjcTNBZGtGSGZYYkIx?=
 =?utf-8?B?cjZFQVRVWUJIVGZtQ3ZJaGU1S3Z1Q3B5WXR3L004LzJtbTFSakpTbFlRS0dx?=
 =?utf-8?B?ZGNqdmNRRkhSWDFIQTdBb01lZU4yQ2Znd0FnR0lwTDlYUHBOV0NOOXlneFQy?=
 =?utf-8?B?NW1JWW1tczFRTlI4NDB6cEh5ZTJuWUpXZ1NlNHNWbXRSYVBYbjkrclVpL24x?=
 =?utf-8?B?VFJCUi9lN2w2b3V6cE1NZ0QyU3gwblJmdVpjNTFIMS8yM0hncGUxVEQzSTc5?=
 =?utf-8?B?U3A0bGY5QzZMdEFkTUtLM2FkbnNVclhESHVFNjdaVnQxWU0wYzI3MG81b2dC?=
 =?utf-8?B?ekFPYndNRC9FbTRtNVB6NUNKeWpNNjN0RnNiUmhEU1N5VzFIeCt4MC9xSWN1?=
 =?utf-8?B?OVNHT0VWOFQxYTJhWHdBb2VTajRYaG8vNTYzNk5nZWc5V2xDZXA5cnQ5VlRs?=
 =?utf-8?B?azFLTjBqRFdpYjBtYjRHU0VYTnZNVGNTUlVWTmtOUmxLQW5JL0xqamQ4bVJT?=
 =?utf-8?B?emdUcGwyQVNOYnltQWIyTWg0V3YwY0dOKzNrakpOY3FBY2dOL05QOStDbjhR?=
 =?utf-8?B?Qlo4WkVQd1cyT2w4bUpEemJFZXR6Q2lUUFN4Q1Nhb3MweStWaHUxS2RJRWdC?=
 =?utf-8?B?ZmhyNjkzV0FuSm9aM0U3d0IyM3h3MWE5Uk14WjdIeVRTNWVudjY2ZE5MUWlk?=
 =?utf-8?B?akpMbUhWU2NvQVVwTHE3MVZYRWRMUUQ2VERhVlpTbFdja2JnOVBJZm9OL3VD?=
 =?utf-8?B?YkI3RmhCZURCa1lvSXFhRHVwZXRHR0xGTDB4WUQ5dmZQV1ZWVXdTbHNTRWVi?=
 =?utf-8?B?OFJrMUpFRG9IeXBxbzIzV0RsQzBjS0p2amErdktTM1lXRGV5REh3cHFBMyt5?=
 =?utf-8?B?SmpEMnhaSFg1dUUxczlYY1djdzU2RVAwUU5oR0RDVUFWUk8ybjk0Y1dUL3dM?=
 =?utf-8?B?UW55UnNjQkJqTUFOVzd1WUkyR2dNREwzV3hrY0EzRmdDT0FIODQ2aDU4Zmh5?=
 =?utf-8?B?QUtLMm1vdVNWSkdhWCt6WjRScUNZeFJ2OG5xNDFNV2dXU0lHSGVYMjRvUGlT?=
 =?utf-8?B?bU9kRC93RGVpbld5WFBXTXlibFBtVk5aN3E2cThoUnljUFYrL1BvMmVocTVG?=
 =?utf-8?B?NVVyN25aR3R5YzBEV29HcHloTktWSVU1Qk1JdW5DSW5ScTg1RHEycGxmYVdR?=
 =?utf-8?B?Q2JmVnlNNlgyN0F3N0QyNHZqWVhGODNNZk5IdGd4YWtQaXJYY3JrS2hIUnl4?=
 =?utf-8?Q?uvxj4FAsxQR0L7D316kOKw6QCGWZ3tFogOv3qNR3+XaP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FAFB100AB650C445BC5564A60DC7CF44@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e54db9-ea7c-4bc7-3be0-08dc2168082c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 07:49:47.6685
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B4q55FTzxJDsDs+zzJH/wgCDjHbT9jePkztAEimy2hZ8ptbAMq40EqnX1jQnyiAlfmmWxPzvKo5dufgkIYJFzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4085

T24gMS8yOS8yMDI0IDg6MjEgUE0sIFNoaW4naWNoaXJvIEthd2FzYWtpIHdyb3RlOg0KPiBBbGxv
dyBzZXR0aW5nIHNoYXJlZF90YWdzIHRocm91Z2ggY29uZmlnZnMsIHdoaWNoIGNvdWxkIG9ubHkg
YmUgc2V0IGFzIGENCj4gbW9kdWxlIHBhcmFtZXRlci4gRm9yIHRoYXQgcHVycG9zZSwgZGVsYXkg
dGFnX3NldCBpbml0aWFsaXphdGlvbiBmcm9tDQo+IG51bGxfaW5pdCgpIHRvIG51bGxfYWRkX2Rl
digpLiBSZWZlciB0YWdfc2V0Lm9wcyBhcyB0aGUgZmxhZyB0byBjaGVjayBpZg0KPiB0YWdfc2V0
IGlzIGluaXRpYWxpemVkIG9yIG5vdC4NCj4gDQo+IFRoZSBmb2xsb3dpbmcgcGFyYW1ldGVycyBj
YW4gbm90IGJlIHNldCB0aHJvdWdoIGNvbmZpZ2ZzIHlldDoNCj4gDQo+ICAgICAgdGltZW91dA0K
PiAgICAgIHJlcXVldWUNCj4gICAgICBpbml0X2hjdHgNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNo
aW4naWNoaXJvIEthd2FzYWtpIDxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQo+IC0tLQ0K
DQpJIGJlbGlldmUgaXQgaXMgcGFzc2luZyBzaGFyZWQgdGFnIGJsa3Rlc3RzLCB3aXRoIHRoYXQg
aXQgbG9va3MgZ29vZCB0bw0KbWUuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
