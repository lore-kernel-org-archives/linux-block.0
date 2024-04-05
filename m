Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C296144D28
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304354; cv=fail; b=fWbJwNaMrzI3Nn4ILCwS3P/V1VevDX8vWMncypAmMxeCrsNpZ0dN/SfhNdw0IugeyCt/vObmx45qry+ZOcUzMr1lBxfFPEP79RUv/PenGKTW3OKOr7bMs5qPbZ23BiwEkHpagYbMKK5MndCI9evaY2AldKF8QFy/fGmG+ooOiJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304354; c=relaxed/simple;
	bh=dnZsZ1ojuIPu/TXddomrdR8Y+ovH/2XSrY0JReQjxDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H/oGDab1YMw5zgDGsFq1VVtN/tZQUmenWOSQRz9kj0vAL72y+7zU59cMxvAZqQ0wbS/D4Xz40IIiezOMymbkV9p2Y4dk6BKbI7OnFJ8/PPEU5DT4bayca1mSgvFCYefTb8HrQ9y5jmINkEZglkTXMYe29AgDceDzP58QzO61Za4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XXTH5j6/; arc=fail smtp.client-ip=40.107.94.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XXTH5j6/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghSaSKe7sxOGR4LuI4x5gZs4JWUNfe5v3LtnneXDdbB80mCN6kWD+YMEHReSKqhh2G8vSaNz6H8GFXmBXuuNLgsCPhOedpRJumYcqIEBUi5RWdJU5/T58pLrvOs3tfgyMV+N8wH+nxywjTiDs28f8WbMqvjEHq/VZYjDdEmky2SAh2gmJ/NNTCC6r/JRrJJgbn8VGo95OH4uJhL8jOPN+CryucqeMjYiZMSW5/dsn7Cd3cmBAQELFSL6yy2l+s1sGaxNQiv0aZ8mRJOPCWwD3EbZSuCNyKPi2B4tuSu9HoHHgeFV7mTFPVipBqepUuX74giM70EWZcQWt66/hWnKfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnZsZ1ojuIPu/TXddomrdR8Y+ovH/2XSrY0JReQjxDs=;
 b=Mubgw/s3gOlCT0yDRPposc90BYoRvPPYqaIjz0lTvZOt664eRZZvtfZqcoIeI3Uh2e+xK9dF9iMs01/GcV5rPDwuf1lvESnX6mM3pdY2wnIEJsg7QhQc3GYZy+osb68nlb5z6FVi0r412TREr40ba4S3UhUO/RzTAO4tynOUTSPqyPZDeEvnX2YxAL331Lxsa4ApGDHz2Z4G5iUDOWKcNRSnon3HfvkO08hRBqqWdObt/J28k4YyNBtuZQ/aNBF1Tb/wO02IN6hiY21c6PNY2yC2NPSlofeRqqtxsvanXx8ZHNHuWdypTOJd0lS25dgHS72Q8KAk974LLPHbk422tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnZsZ1ojuIPu/TXddomrdR8Y+ovH/2XSrY0JReQjxDs=;
 b=XXTH5j6/oUidfPDAsYtLHTADiqGdb+rg3F6q3DIB4oMgRkBaRZG/hvrd+h3UQZRgJl/ZlVzlP84uDnTJIWhYodE7jz8sBqJ3ByEJRrR95ndjaeq3KsojxSsoOb5oJSMUOZhkjI/qA02YR4x2HI94xsyEisTt+0zqAhyEGWcwJxIn3Mw0W3KoyWqzgXwhxKcLhssqiEE2UoANE54vyrvM7TUt+eZd0QKtzIGMmc5m7Qa15cS1Nj5KVZ3PRR5Y9U9EqxxTKAHWQJv75ILsMG9IvDpXU21OnR+x7Tvjet82E4a+rvtRV9lRXtQs25CHT+LXXMfr3Dhhr9iqib3Eq9FlWg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8745.namprd12.prod.outlook.com (2603:10b6:208:48d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Fri, 5 Apr
 2024 08:05:50 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 08:05:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Saranya Muruganandam <saranyamohan@google.com>
CC: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Topic: [PATCH blktests] block/035: test return EIO from BLKRRPART
Thread-Index: AQHahvyWiheVndYbAU2CjNmML0/vjLFZTnqAgAADs4A=
Date: Fri, 5 Apr 2024 08:05:50 +0000
Message-ID: <f6b35f19-5365-45e9-8a89-0081b77fe7ff@nvidia.com>
References: <20240405015657.751659-1-saranyamohan@google.com>
 <2ac46686-5fec-42c7-b267-128cedcc73eb@nvidia.com>
In-Reply-To: <2ac46686-5fec-42c7-b267-128cedcc73eb@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8745:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KGizLxesS/e0NHWps+ZYD8GXxmEtfJDoIiHPbPw5erI5CNNu0z4+hZcV8gfaTR2y4ZeXtIOzfwBAkQf1bT2sXlfxOrdJo1rwUfYCUSlAXVL4FKoxuOUaIFM0Fn6aHbR93yzXw/S2Oqx7zJ43SzjRx42zHRXVpuzJbwGj8Whd6/2ZTlA83JN9ZbtHJOrRFav5eW8zv+skSU/P88bcD5FKjbRZCI6T1KcZ/NkfT2lzvny7I7EjT9x5NwPJHRiNiu6kO1aJhbf4WUvZ5dwUeZHBxs9jbI9DUSe+oVkWfOimTPb0mLfmOVDY5RZUREo7gUVnFy70DEq4k6OUf0Sf3a+T/hywOAB1/tDlHHNhZkYFOX/BktH8aXtksuLJA5uHXB0L7dd7iipfSRD/oGvsg9G6Ys+zfyggQD9eItJy13ih2VJM9coiAIGobPs5Ii8x2pPesoyUfMKwo0eyQ4KyIXklmvomYQlz1FKy+TQHxvk3q5isUMwTr/2okSb8LmsGj/zrPWS5G3W7LQIO1D0PrnUSQN1AtCiO8L1w0AyxqVmkJUlAfMhgI+s5MDv7dwFrLDjLdAB4Z5TPYRGVnuwksuCEl4VOmkCfsJBiRPF4c3XwDtFBBJhMb0qqlE7dKGtMagBI1xWObX2xSiTVjigbc+mGtma/WHcyjr0oRIJxl2uD7LY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEhIb2dhVGZSN2RiMjJCc2M0Y2oxOE5vSUNRbFFSZ2xXcWJKbysybmJ6S2Y1?=
 =?utf-8?B?dE54SG1ZRnpGZSt4ODN2a0FXMVh1NTZlbFlmZmN4cXhxZGMvSTFYZW5sRGly?=
 =?utf-8?B?ODBrU1o4YjFPN2NiOC9tdVl1V3BLbGUzY2Y2Nmo4amxtZGlSd1VYVkM2bWty?=
 =?utf-8?B?WEs1ZDVhOElrcFFUNXpsWStPeDR4Z2xkOXc3M1pKbjZhRWZBVmVlS3Y3akJD?=
 =?utf-8?B?RFBCbkZXU2tCUzZBMVRGS1psUWY3blcvajFnUWExR3lDZTFjRmlaWVA1SnA3?=
 =?utf-8?B?QzQwT2h6cGhSSnExRTdlRmZ6R1VnRlh2dVQ4bWJjcmlvNTJ4bkpxZ3YrS1Bk?=
 =?utf-8?B?OE1VdjRMVHNQT1FHa0JJZ216MlN2ZWwyanAzSTBIMlhGUDFWenpKTGQ0UHI3?=
 =?utf-8?B?VFVXTUZIR0NsS2w5VGIwQlo2cDZBWmdmd2VoaDkwMnVxM2NjdEFhMW9UMXhF?=
 =?utf-8?B?OE9jL3AyLzFoL0dGajExSytCSllsVzFYU1B2dFVRYVdObDRzSVNLdFpCTm5M?=
 =?utf-8?B?OHpzUU1udWxNc0pEaDNkK3c5T0htbktaVXRpNUZZZUcyMi91eXdoQWFSelZp?=
 =?utf-8?B?VzVUdkJGRFpGbWJONTBOenNQZHIwT3lWNUtROHhRNERPcUcvUkJzWDJxTTlL?=
 =?utf-8?B?WkprZmgzdzcrUW9TdE1jMHphek9WeS9rKzNMNUlKaThPanVGQTZrVzBXSzRo?=
 =?utf-8?B?UHZwekQ1azRMVFJhK1plMGtTK1h2OStuU2xXK1RJWVJGdlJsSGZJMUJhM2RR?=
 =?utf-8?B?MUNDR3J1UUs2Uk1IZnlMcGVhZGx5YUFNY2xSRkYrVHBUaC9SSm81aTRjODFn?=
 =?utf-8?B?alFiWk9WVEZUMW0rTEZZTy92Qm5OTWxQczd6MVk0MnM5L3c4dUxCRUI4MXFI?=
 =?utf-8?B?eFk2WW00SnFsckNqOUp2U3BpTjZTdmExRVBrUWdsbnE4cmlaWGxPYUh1VXZx?=
 =?utf-8?B?YVN1VExWZ2xXOXpKREtMVW52dWJ3MnIzcjQxSCs5ZUlCS0lESVNuTjlMUG9J?=
 =?utf-8?B?akw0N1Fxc2JwMDlQUTVzZDgwLzB4Y294U00rZEVQK280WVIwbnM3NWhkTURy?=
 =?utf-8?B?Y282T2hicHpoSURBSWZoV01LckVjNXNhYlZZSEpqODhTQWZISkpzYVZPSzVu?=
 =?utf-8?B?eXJsbmtQN2JZbGx5YVQydnh5T1ZDcG9ON2JndlhWc2FDTU54WUJUY1gvNlpC?=
 =?utf-8?B?cU5MV2VRU2RvenZsWjJFSDkxc1dIZGlNbm1ZR3haZE9oOUFUUjVrY3FBaHlr?=
 =?utf-8?B?eWJsVUVNZ1habEkvejhsWkF3ckhmTmF3ZURBSzFUbWl2bXRrSGg3SWVWVWth?=
 =?utf-8?B?Rlh2emQxZkFyZ2tTMHovUFRNNUdSNG52SXhZRVh1UVB4V1Bxa2FmUDQ2MnFE?=
 =?utf-8?B?L1ZwTkJPM1FxVWRER1hLa2lMSXppZFJ3RVYvajFzQzk4Y3VUaVBGUHNKcDNU?=
 =?utf-8?B?L2pMaURzN3VlTkNZZFRnSVdYTTB3RFIrbnBnT0J3bmRxOVpVdVhzdWlTRDNY?=
 =?utf-8?B?S0tZaVZZMDVUanZZUWlVMWRxWkViOEdnVDlIaFM1UWE5bDFVWldqOU1zUG91?=
 =?utf-8?B?ZHEzY1JPT2dzKzdUQU93aTZYcjJtUW55bHpIenluRVJRY1ZLQzF0N3k5NDkz?=
 =?utf-8?B?WE82RER4eUhsUmdzVDVhdjBRQU9SN0dSNGwra2lKV3FtZWo1Z1hMWm9ueU1D?=
 =?utf-8?B?M1FBcnBBVFNrUmlGRFNpUE9nb3U0V3JjYXRZazhkRFVMbGFUclNHckJMRnNt?=
 =?utf-8?B?a1ZObVhiMURaZ3RjVGlUcURrUUdCUzZTUm43MnpzQTBWYStiT1BXSUNwQXMy?=
 =?utf-8?B?bktQVEs5UEEzVEd4Y0ROZFZUTDkxNzhndG5rT3hzUEM3ckl0WkNaYlNzRThU?=
 =?utf-8?B?anlyQTQ0a29VdFV6Ly9oYU1LWTlkVEtNTzBTUmdyb1BMVE03RVdCbytReXA0?=
 =?utf-8?B?OUs4bnBON0ZvK0FYVlY2N2ZnR1JZdDE4K1hvRnZHczBpOFZualR3Q0lPWlZI?=
 =?utf-8?B?cHNoemgzVHZXOTUwVXdESURHYzIzT0dDQnVCcFdFenpMYlo4US9SSkIxdTdh?=
 =?utf-8?B?QWExVFh5Z1ZkemlFbDNZSzdESSt4RkFKUXd6Z2tCeEJTRmFrVlNUQUY3QmhH?=
 =?utf-8?B?Wkl0NE13ODlOWk41T3FTL0lnd2oyYjI3ekdReXFmbVlxdnhZU2ZnSXF2UE1G?=
 =?utf-8?Q?aME5oPVQtzHogwjOXc9A3u8qK7YE4yK+q+4uGCZJrfMz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EED9F2682F33D74EA36989582EABF562@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e335639-a9cf-4708-c915-08dc55473526
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 08:05:50.2077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFaB4gg+BmdmKOYx796fHbqOOLhSWrZI0TwNWAeBrAN9KuXbptyd/+2sxQ28Sy5Ie53DSXdstM/f80VCpMfwew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8745

T24gNC81LzIwMjQgMTI6NTIgQU0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4gKw0KPiAr
YWxsb3dfZmFpbF9tYWtlX3JlcXVlc3QoKQ0KPiArew0KPiArICAgIFsgLWYgIiRERUJVR0ZTX01O
VC9mYWlsX21ha2VfcmVxdWVzdC9wcm9iYWJpbGl0eSIgXSBcDQo+ICsJfHwgX25vdHJ1biAiJERF
QlVHRlNfTU5UL2ZhaWxfbWFrZV9yZXF1ZXN0IFwNCg0KYWxzbywgSSBkaWRuJ3QgZmluZCBfbm90
cnVuIGZ1bmN0aW9uLCBwZXJoYXBzIEkndmUgYSBicm9rZW4gdHJlZSBvcg0KZGlkbid0IHVuZGVy
c3RhbmQgdGhlIGNvZGUgY29ycmVjdGx5ID8NCg0KPiArIG5vdCBmb3VuZC4gU2VlbXMgdGhhdCBD
T05GSUdfRkFJTF9NQUtFX1JFUVVFU1Qga2VybmVsIGNvbmZpZyBvcHRpb24gbm90IGVuYWJsZWQi
DQo+ICsNCj4gKyAgICBlY2hvICJBbGxvdyBnbG9iYWwgZmFpbF9tYWtlX3JlcXVlc3QgZmVhdHVy
ZSINCg0KLWNrDQoNCg==
