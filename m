Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C5074435
	for <linux-block@vger.kernel.org>; Thu, 18 Apr 2024 07:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425000; cv=fail; b=YtQPzDORnr22qw+wGIQ7ysSZP4sSKi5EgBTfqEuDbG02LQUu7Va4xQdiYcuwuFYTeDXWGgF0RQPeKrzLaKPqAlwzaeDj2SXOHwnIuCvOkBYBLYB2NJ/43qFsFuhX9wa5vzPipbBnalKeJ44VZNLeqBBabYtSR1x0PKLdO9GZ5xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425000; c=relaxed/simple;
	bh=EtnYUR+J3jgj8kG/9gxaXYvyiIzf/uw4n3dOIs4tBmo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PHOFtlkl1idqlGJxumss6Pq451XnMJ6+02+WfLZwOOAi44ZQIqVHHejPLsH57SBsZAoBviRFL8YXMO79bWt+4MCqZjZ6bFORUpj62tBZpdFWntjv/4up4qz41OUAN+WVyktpAk+nybo++9amOtfTQCeP08QH8op+QhRLjOe9QKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RCAffDYV; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RCAffDYV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qgv+OPyNUPmERksY6iyhkoJdsPIGuV52ZM6ms+VaXwiaiefl1QWnw30LLi2uOmVrhfO8ik2jgpiNrAMten8E6Utp9bi4XxPX27r9PzMbJAgCTp1xVcnjGBYQhf6Hj2h8WChJfK3W9nIMX8VLN1oC3EfbOW29+Mc0t76dpCc4nu/vaY5tpSLL1Kr3NDIAIkDdHy1uWc7jZHGGmYDJX4OpH7Cmlp10TFBE8G88p3nosUfNraFIljtPAcB+l01R+8pNyS3AqVxAYlmoq4cs5d8DCIaAuFGPzHH49IK5kFDJdvdcnim6owp6FiGkqgbHNLQTemx5GmWcPSr22fXR44ftyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtnYUR+J3jgj8kG/9gxaXYvyiIzf/uw4n3dOIs4tBmo=;
 b=kXGsNR4oX967duXgn1LlJMwtvRn5bEIajtjBXmpUTEhfQbQj/oNcJXvT+aEVs4WoK5jUgGs218IIi6di+MtSq5o+hKIaK2nN/IVnRq6l8p630cvoGAus8fuFJiCRnLJXhBGjfsR07UKNC5uhfN10h/a2RfQ9EG77TBOBnTA4L2n37KPLRU6KkzxKCnzJwmFjKzL38eBzgEVlMo0rXsJV6SMOvPGV73Qq9mhx2ZhbFnUGgfjy69r61myg0ZkAWBJe9TLgPfSDBEduqSFYxlFWR9dJ4Cwi96SJlUHp1QNF8hHKQKVMQcSo9Ql12wJy0/pnZ8BOV19n+jy5aCbybc6img==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtnYUR+J3jgj8kG/9gxaXYvyiIzf/uw4n3dOIs4tBmo=;
 b=RCAffDYVwpSuczzPJMX2Vjp9vVkj2ciGE1hQb+hnEbO1Z8txMALAfW8EAyAFbA0IN9B365FCtFZpoXblzzadxnxqtzcA6CGBovUU67AxC6WXuQe35vXG3F0D3KBbubnodL5F7s6kcMN22Ar7ruqKkhTRZqjKRuXlCuQpmRa6EszQiIJRfLkWmVawj5LbBL+kkqdnGktmGMNytDf/hDKxQ96We7W7KR4QNDf13BEeljVwxG11AvMKtzLrOlC0U6p5Wd5i+fTp3dTIk5tA5SKd+oEsvt9lU5XR56dCpOHaxmp3X08eYpHz8fYGfAIMCA8g0ZNYtbOpAjL5Dy2VZdIWkA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB5593.namprd12.prod.outlook.com (2603:10b6:510:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 07:23:14 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 07:23:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagern@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 00/11] support test case repeat by different
 conditions
Thread-Topic: [PATCH blktests v2 00/11] support test case repeat by different
 conditions
Thread-Index: AQHaj+laK8dM/WY30EONf63Jv7FPc7FtoriA
Date: Thu, 18 Apr 2024 07:23:14 +0000
Message-ID: <2108faef-336f-499f-baf1-2eccfd306cff@nvidia.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB5593:EE_
x-ms-office365-filtering-correlation-id: d166e8bb-d8ff-4f68-c26a-08dc5f786900
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uYWZyWqxZPeInmEDQzHrs2p0FTMFFd+qU1Zk3F7xd/K1Y79R4RSiQaSOEadp3Viq0e/hDgOaEku/OWpzTmZ99O70o6XjhAe6UPui/4PJW1evzRcKIPXdxyvUtVe+C5oDg6bwNZV9jW6RZSg0vf4AGJxkhc6TrrI5DL3KjKRa6TsO8WB3PdSDOlYQuspZ7g8avNIbFLp9PQ2OfNpMtx5VMe6Gz2jBtGnX9UrTvWEtZMvbaHhfg9j2gKlAI0jwoVuMrwijhwQTFyW9CWgKslFi1AG4Xu2Mr2ZpAIcXZskZQBk3nw/eQKugCeXF2KifwB2Z65a3v+cgbgn96FCrd2XiiV3+f3xXwCeTHbweY6wHqRTRW1JiwvLD7+cpHbYwvfcTn4oHLgwdY8l9CKQwdPJLn/2hRKDA/1JPgu7QqZzW7wD09lt5Fb7haQNlrfFmaW7x7bl2UNhFo49+cU8nEfcZ3oG5gR+TmcInQOSDUonA7q3KsC0Qbkijozk/c3fFw+08eUS8cE9MNzrc5F4eL14mNsDDpOIaf1q+xSRY3MtPsaJ17jd2TWN+gSGWApGK1K/KKVISN09b14yj+9lq7A/voDL7L2VbB2w8Meu1cvfuRsCaDZSieCfnncKqby1bvHdApBkyU261pvm1SYreYOFheHIlQ3j88peVT3LVIiDJ/yEiVH8TCTJGq+o8/usRwcozMRTAWwcq4syPu6IvoQvjYw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlZnaUVIYW4zOWYwNU1vczkreXd2UWxuUHRSQzlHdm1XWWlNSWtFR2psZEpk?=
 =?utf-8?B?cmRYMW1HNDRoekFtOUE1aEU3ZUViOEJ1VXc4eDVLVWJNd09UVzJXRUo3UkJn?=
 =?utf-8?B?U1ovSy9ySjNFZnVsT1FXaXp2TmNDRXYrQklsNWdmYnJ2d1VFb3FkOFQ4R1RO?=
 =?utf-8?B?WjBHWUlPNUpWcERGYlRScEpjeDhqSXBoR09uREpreFNjTThlY0JmNzFYVlRS?=
 =?utf-8?B?OVpyc1JDL25kRHliL24rZngyWmJKaFlCbWxUcE96MWRiUmkxbjRJVldwWWN0?=
 =?utf-8?B?MTA3TkpBUkFxVW9vZElraStIbGlURGsrZ0hEZEl5TGc3ampVckY4bThFdGJK?=
 =?utf-8?B?Yk9paExBYWU2VWRBN1lJVWpnSjcwb2NuV0c2V2taVUFMTEdtRWQ2WVVxS3lG?=
 =?utf-8?B?YTZkN3Ntd01QVGF3YzZYelkxY3FrWUlGblNuRGVZdEJwQUthSmsxOHp3RkNs?=
 =?utf-8?B?eVI4alpLTFNMZm1UVzBzVUV3eUdqcUk1Zi9pWTdvQzJrdklNRVd0dnV1ekE5?=
 =?utf-8?B?QWhVN1o1WGJxcXlncmN1OWlDaUpQcUVwaVlLanhYcFk0SzFPSkZ3RHVMNVBU?=
 =?utf-8?B?Szg0N3lqUHpvNml0Smo2ZE9oN1ZFaWRyaGhJZCtoVnJjRmpZbnErQmFoTDVP?=
 =?utf-8?B?ajBSRkJMYnM2K05oMkV0bkgyZklDeWlzSUN6QjdLS2ZWZ3MrL24wUm03RGNo?=
 =?utf-8?B?bmkwanR2SFFVdk1XbTJSR0pjaFBEZnhiVEdEWXNnWXlHbFdFem1YTVBWL0Jv?=
 =?utf-8?B?ZnNwajZsTjVidEl6VFJ5SWdGTG1tMVlGWStNbEhWdmlmL05CdStNL2ExOXg3?=
 =?utf-8?B?dUU5SklGcEo0S1o4N2ZHaE1maXRaUDYrSXNiRld2RitYZEJXM0hBRlllWWcy?=
 =?utf-8?B?UEJDOFhOWjJoUWU0VVpGemZMQVJMU2dUTW15UGVPeTBmNy82UC8welpDdTFT?=
 =?utf-8?B?alRaNTJ3S2N4WWsxOUpRQUVFUXJKb0RxVERHNlMzS2JyQVBzOXB4OE9jV05j?=
 =?utf-8?B?dHM0RmZiOWplZ29PTG5xTTZkTU8zM1NvMldnU1BuT0VXdWlkVUtUdDR0aXp6?=
 =?utf-8?B?b3NLc2c0VVM0OHI2OVFqMkFJU1Jvb1hpWHprSDlUdXQ2RTZva1VWZExwY1lt?=
 =?utf-8?B?bEZ6eitudkdaUy9EMGF6V09NaTRWNlJ0NXM5STFicEdXSjh2czdzeWhTTGRU?=
 =?utf-8?B?aXV1UkpMcjM2NjNiSVk3MkRiWFU1UFBWOW5TbDdDbC84NmY5MzNHV0hDTjNI?=
 =?utf-8?B?UnhOMGtVN1Y5Q29YT0NTOEgwUTJiMGJGQkRTdmlNZmRLelFDcDkydTRGL3Fp?=
 =?utf-8?B?b1J6N25aeXlxbVl3ZS9jbVVHdUd1Y0RNTGg2WWsyUm93V2VHckYrYUk5MHp0?=
 =?utf-8?B?Z2t2TXZIQ1JzeVQ0blIxWHZnRzgyYTYvWjV1b1dlS3ozRHRTckZTKzlLeFV6?=
 =?utf-8?B?dzhqclhqOERrWEtQZWM2MGZyNWdwMDhXWndjVWZ2WDB1MEk5YmExZWRKTE1o?=
 =?utf-8?B?T1hiQkx6M0JwRm9tL0lCUnF1LzZlK0JuZHIraGdqRTUvNVdIcXYrcHdMdVlI?=
 =?utf-8?B?SEQzcWM2eFJ0WU5JK2hhQzVQWjRGTVAvdnZLTlBWRXJoME9uSGxBUWxEWk5y?=
 =?utf-8?B?S3ZaTHNIOU45NndMeGF3czlITldrd3NMTVdFdkhobUxZS3hSWkcyUXBQbnRo?=
 =?utf-8?B?NjFMOGQ1c3A2eDB2QXcwa2ZqWFFXc2FFazVpRHpQYkM4Y2d2anR4WlNuREhE?=
 =?utf-8?B?Wkd2eTNHSmt5QTN0ZWJaSnExT2hzcFhCdGVJaVNxdGRKd21ldHhrZnpNM2l3?=
 =?utf-8?B?Ym9tT25KQjQraHFFZ05pUVIxVUQ1NTNEL1FqWm1JRTlMVnQwWU02RVVDd3dI?=
 =?utf-8?B?aTVraXpJTW9ia1hDOUt0bnBGVlBCVHJDUkttdm52REhOVUM4RFpWMWxQR3Qw?=
 =?utf-8?B?bFJQUmEvUC82ajlHMkljK25seURrYlJQdi9keTlwbm83eGpLYU9CV3hYZE54?=
 =?utf-8?B?ZDhtY2E0Z0prM3FmbE1HMFNZdzBHRnJGTlJIOFZDcVllcm9jSndCanBLUHVx?=
 =?utf-8?B?aE1ZbjZOamVmdDRubmZMZTNwVFhybnFZYjNOcGxwQ2xjUFNLZ1EyMzBISUZS?=
 =?utf-8?B?YitSUlFnMUdaMk82dEdaaTVaaFhYS2NWM1g3TWV4S2ZrT25uYWM3QmtCYWZ0?=
 =?utf-8?Q?M75VXZnUnywRWKilyRDnX5wVARGiY62a0FjE1EycrnaT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BDB63990B863C49BF52897141F1633C@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d166e8bb-d8ff-4f68-c26a-08dc5f786900
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 07:23:14.1512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4PrHz+x8LhAv6lX8tdM96R7DTagsHUIm7cUWpGZDN4R0Skr3sbHwViaAoGbTKzRPf8PGKZBdw5m5xPQMKifYaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5593

T24gNC8xNi8yNCAwMzozMSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEluIHRoZSBy
ZWNlbnQgZGlzY3Vzc2lvbiBmb3IgbnZtZSB0ZXN0IGdyb3VwIFsxXSwgdHdvIHBhaW4gcG9pbnRz
IHdlcmUgbWVudGlvbmVkDQo+IHJlZ2FyZGluZyB0aGUgdGVzdCBjYXNlIHJ1bnMuDQo+DQo+IDEp
IFNldmVyYWwgdGVzdCBjYXNlcyBpbiBudm1lIHRlc3QgZ3JvdXAgZG8gZXhhY3RseSB0aGUgc2Ft
ZSB0ZXN0IGV4Y2VwdCB0aGUNCj4gICAgIE5WTUUgdHJhbnNwb3J0IGJhY2tlbmQgc2V0IHVwIGNv
bmRpdGlvbiBkaWZmZXJlbmNlIChkZXZpY2UgdnMuIGZpbGUpLiBUaGlzDQo+ICAgICByZXN1bHRz
IGluIGR1cGxpY2F0ZSB0ZXN0IHNjcmlwdCBjb2Rlcy4gSXQgaXMgZGVzaXJlZCB0byB1bmlmeSB0
aGUgdGVzdCBjYXNlcw0KPiAgICAgYW5kIHJ1biB0aGVtIHJlcGVhdGVkbHkgd2l0aCB0aGUgZGlm
ZmVyZW50IGNvbmRpdGlvbnMuDQo+DQo+IDIpIE5WTUUgdHJhbnNwb3J0IHR5cGVzIGNhbiBiZSBz
cGVjaWZpZWQgd2l0aCBudm1lX3RydHlwZSBwYXJhbWV0ZXIgc28gdGhhdCB0aGUNCj4gICAgIHNh
bWUgdGVzdHMgY2FuIGJlIHJ1biBmb3IgdmFyaW91cyB0cmFuc3BvcnQgdHlwZXMuIEhvd2V2ZXIs
IHNvbWUgdGVzdCBjYXNlcw0KPiAgICAgZG8gbm90IGRlcGVuZCBvbiB0aGUgdHJhbnNwb3J0IHR5
cGVzLiBUaGV5IGFyZSByZXBlYXRlZCBpbiBtdWx0aXBsZSBydW5zIGZvcg0KPiAgICAgdGhlIHZh
cmlvdXMgdHJhbnNwb3J0IHR5cGVzIHVuZGVyIHRoZSBleGFjdCBzYW1lIGNvbmRpdGlvbnMuIEl0
IGlzIGRlc2lyZWQgdG8NCj4gICAgIHJlcGVhdCB0aGUgdGVzdCBjYXNlcyBvbmx5IHdoZW4gc3Vj
aCByZXBldGl0aW9uIGlzIHJlcXVpcmVkLg0KPg0KPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGludXgtYmxvY2svdzJlYWVnam9wYmFoNXFianN2cG5yd2xuMnQ1ZHI3bXYzdjRuMmU2M201
dGpxaW9jaG1AdW9ucmptMmkyZzcyLw0KPg0KPiBPbmUgaWRlYSB0byBhZGRyZXNzIHRoZXNlIHBh
aW4gcG9pbnRzIGlzIHRvIGFkZCB0aGUgdGVzdCByZXBlYXQgZmVhdHVyZSB0byB0aGUNCj4gbnZt
ZSB0ZXN0IGdyb3VwLiBIb3dldmVyLCBEYW5pZWwgcXVlc3Rpb25lZCBpZiB0aGUgZmVhdHVyZSBj
b3VsZCBiZSBpbXBsZW1lbnRlZA0KPiBpbiB0aGUgYmxrdGVzdHMgZnJhbWV3b3JrLiBBY3R1YWxs
eSwgYSBzaW1pbGFyIGZlYXR1cmUgaGFzIGFscmVhZHkgYmVlbg0KPiBpbXBsZW1lbnRlZCB0byBy
ZXBlYXQgc29tZSB0ZXN0IGNhc2VzIGZvciBub24tem9uZWQgYmxvY2sgZGV2aWNlcyBhbmQgem9u
ZWQNCj4gYmxvY2sgZGV2aWNlcy4gSG93ZXZlciwgdGhpcyBmZWF0dXJlIGlzIGltcGxlbWVudGVk
IG9ubHkgZm9yIHRoZSB6b25lZCBhbmQgbm9uLQ0KPiB6b25lZCBkZXZpY2UgY29uZGl0aW9ucy4g
SXQgY2FuIG5vdCBmdWxmaWxsIHRoZSBkZXNpcmVzIGZvciBudm1lIHRlc3QgZ3JvdXAuDQo+DQo+
IFRoaXMgc2VyaWVzIHByb3Bvc2VzIHRvIGdlbmVyYWxpemUgdGhlIGZlYXR1cmUgaW4gdGhlIGJs
a3Rlc3RzIGZyYW1ld29yayB0bw0KPiByZXBlYXQgdGhlIHRlc3QgY2FzZXMgd2l0aCBkaWZmZXJl
bnQgY29uZGl0aW9ucy4gSW50cm9kdWNlIGEgbmV3IGZ1bmN0aW9uDQo+IHNldF9jb25kaXRpb25z
KCkgdGhhdCBlYWNoIHRlc3QgY2FzZSBjYW4gZGVmaW5lIGFuZCBpbnN0cnVjdCB0aGUgZnJhbWV3
b3JrIHRvDQo+IHJlcGVhdCB0aGUgdGVzdCBjYXNlLiBUaGUgZmlyc3QgZm91ciBwYXRjaGVzIGlu
dHJvZHVjZSB0aGUgZmVhdHVyZSBhbmQgYXBwbHkgaXQNCj4gdG8gdGhlIHJlcGV0aXRpb24gZm9y
IG5vbi16b25lZCBhbmQgem9uZWQgYmxvY2sgZGV2aWNlcy4gVGhlIGZvbGxvd2luZyBzZXZlbg0K
PiBwYXRjaGVzIGFwcGx5IHRoZSBmZWF0dXJlIHRvIG52bWUgdGVzdCBncm91cCBzbyB0aGF0IHRo
ZSB0ZXN0IGNhc2VzIGNhbiBiZQ0KPiByZXBlYXRlZCBmb3IgTlZNRSB0cmFuc3BvcnQgdHlwZXMg
YW5kIGJhY2tlbmQgdHlwZXMgaW4gdGhlIGlkZWFsIHdheS4gVHdvIG9mIHRoZQ0KPiBzZXZlbiBw
YXRjaGVzIGFyZSByZXVzZWQgZnJvbSB0aGUgd29yayBieSBEYW5pZWwuIFRoZSBhbGwgcGF0Y2hl
cyBhcmUgbGlzdGVkIGluDQo+IHRoZSBvcmRlciB0aGF0IGRvZXMgbm90IGxvc2UgdGhlIHRlc3Qg
Y292ZXJhZ2Ugd2l0aCB0aGUgZGVmYXVsdCBzZXQgdXAuDQo+DQo+IFRoaXMgc2VyaWVzIGludHJv
ZHVjZXMgbmV3IGNvbmZpZyBwYXJhbWV0ZXJzIE5WTUVUX1RSVFlQRVMgYW5kDQo+IE5WTUVUX0JM
S0RFVl9UWVBFUywgd2hpY2ggY2FuIHRha2UgbXVsdGlwbGUgdmFsdWVzIHdpdGggc3BhY2Ugc2Vw
YXJhdG9ycy4gV2hlbg0KPiB0aGV5IGFyZSBkZWZpbmVkIGluIHRoZSBjb25maWcgZmlsZSBhcyBm
b2xsb3dzLA0KPg0KPiAgICBOVk1FVF9UUlRZUEVTPSJsb29wIHJkbWEgdGNwIg0KPiAgICBOVk1F
VF9CTEtERVZfVFlQRVM9ImRldmljZSBmaWxlIg0KPg0KPiB0aGUgdGVzdCBjYXNlcyB3aGljaCBk
ZXBlbmQgb24gdGhlc2UgcGFyYW1ldGVycyBhcmUgcmVwZWF0ZWQgMyB4IDIgPSA2IHRpbWVzLg0K
PiBGb3IgZXhhbXBsZSwgbnZtZS8wMDYgaXMgcmVwZWF0ZWQgYXMgZm9sbG93cy4NCj4NCj4gbnZt
ZS8wMDYgKG52bWV0IGJkPWRldmljZSB0cj1sb29wKSAoY3JlYXRlIGFuIE5WTWVPRiB0YXJnZXQp
IFtwYXNzZWRdDQo+ICAgICAgcnVudGltZSAgMC4xNDhzICAuLi4gIDAuMTY1cw0KPiBudm1lLzAw
NiAobnZtZXQgYmQ9ZGV2aWNlIHRyPXJkbWEpIChjcmVhdGUgYW4gTlZNZU9GIHRhcmdldCkgW3Bh
c3NlZF0NCj4gICAgICBydW50aW1lICAwLjI3M3MgIC4uLiAgMC4yMzVzDQo+IG52bWUvMDA2IChu
dm1ldCBiZD1kZXZpY2UgdHI9dGNwKSAoY3JlYXRlIGFuIE5WTWVPRiB0YXJnZXQpICBbcGFzc2Vk
XQ0KPiAgICAgIHJ1bnRpbWUgIDAuMTYycyAgLi4uICAwLjE2NHMNCj4gbnZtZS8wMDYgKG52bWV0
IGJkPWZpbGUgdHI9bG9vcCkgKGNyZWF0ZSBhbiBOVk1lT0YgdGFyZ2V0KSAgIFtwYXNzZWRdDQo+
ICAgICAgcnVudGltZSAgMC4xMzhzICAuLi4gIDAuMTM0cw0KPiBudm1lLzAwNiAobnZtZXQgYmQ9
ZmlsZSB0cj1yZG1hKSAoY3JlYXRlIGFuIE5WTWVPRiB0YXJnZXQpICAgW3Bhc3NlZF0NCj4gICAg
ICBydW50aW1lICAwLjIxNnMgIC4uLiAgMC4yMDFzDQo+IG52bWUvMDA2IChudm1ldCBiZD1maWxl
IHRyPXRjcCkgKGNyZWF0ZSBhbiBOVk1lT0YgdGFyZ2V0KSAgICBbcGFzc2VkXQ0KPiAgICAgIHJ1
bnRpbWUgIDAuMTU0cyAgLi4uICAwLjE0NnMNCj4NCg0KVGhhbmtzIGZvciBkb2luZyB0aGlzLCBs
b29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlh
LmNvbT4NCg0KLWNrDQoNCg0K
