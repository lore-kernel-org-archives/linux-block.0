Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FD101CA
	for <linux-block@vger.kernel.org>; Fri, 23 Feb 2024 19:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715795; cv=fail; b=OPXgtRJwx0jyK6k/QmPflEJfzmVFHGZzjkIfk4srUttgyzhyJWIi8yZjv4xBRrPSOi1ohrbzh7emM4Om1x3UUf0suzP5AoWCKnI951O/UgQkXvgJWBpaub0m+9hnSP26EAfVT+XTvZr1vIqFqavIMm/73ZLMMy6Dmjfn6Ih42Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715795; c=relaxed/simple;
	bh=D/eEYvdAE5MtPEv9siGdfuaynvKESVXJ2DIgzAVVplY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nvLvo/RtKAcDF76hQsvpMrtretuHLJQ6a5zfzST2+JCUjVfYlEmYzWf8T/sj0ms+47eXJKbcgeDDWR2GZ/7VMi2sFo7Zlxtw6cab2709iEHEXqiNitaWG61t2I0TcZgYxDJN+pW0HhbANMj5+5SwIZknYClTdBSoWB6g6zfhNDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kgnd/Mb3; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kgnd/Mb3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvSK5kScMVRA39lzarEHSzjAbcH7JsVuJ40QfDw36Fxbqj6tPRARHjrP1tbV40sEzgKZZkfH1iSiZl2OPcy7GYulEbpt0N7zEmtubHXZuvXGq7KhMkB7DO+S0a61+ig5tTqFKlnvBDNBoYQR+iGd6Mtai+DtFVixdHvVxtbKWnQEUlPsUfSb+MmFjZ7IvfpEByVIWaYVBBqh7iK47ZDaXbD9wz45lCn69XYad5E33oiSfk+gvc1mH2YHGMaw4x+UR9LQ5wArgeI3y8OTu+Pr+yk0PAyR4txygcTHyQ0Ug6cYo3cx10G92KaxsM8IV3tPtPFfH6qCK4gKsJXRvXx0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/eEYvdAE5MtPEv9siGdfuaynvKESVXJ2DIgzAVVplY=;
 b=bdcVAmqFukN8NFTI141V0Efaj9SQ/RhflbuNLrXERiRrN+NhpfLtOmZLLmqrxpdXtGT9EOhDRVOR20dypynrW52JhkfJKaWv8GBihAn8Utud7Bmuj3/FrrYaVhXItc1HUvvze+Qk1/ff5QLBgkEA6cO4IjkrdM996vpdwMXcqiiOB0EnA0zT9Ii8WlabtBN14ms5IS/i4xNipJSP9luC4zE9MAUw3tmYa8ePpcobMdCrnIjWoYWHJsAOlegoaFvY5NZ96ajXwlTm9zdGhfwzdqqR007Btp8JEtKt4jaXXGYGEeXnZ0J2yLarv3rGAY0qTFT2Y8yNf68fRrDBLifVxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/eEYvdAE5MtPEv9siGdfuaynvKESVXJ2DIgzAVVplY=;
 b=kgnd/Mb3EtnQ093fIV0lxpYvB2x8iyOpO34+U0HgkQiTiikliejq1Hq2yV2c6NP9fw6sRbLiEtGFCo/dxAgfVBX0hPlLT2kQgwGVS6Ke/h5gdI7U+rpEDKxI6TixhADLRI1kOJNSZ7KgrveaibU+2qhs9zAqadWKHvL7FZR8jhHbXQgpsII35Fix24aHNa/R3TPCpGzoR1F+nlLWwd8gQs/pDmvHT3zhgn3fu6PKp8C+o1iBZ1pLkgxpmwHSRCzib8ZHkuEE0rRPqk/J7z59waAXjHR2Oxhao5hx9k8b2GWLroXG/4n+ccpDiRJFEr5J7qucGM7kG31b8OuJ/ZjeYA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB7608.namprd12.prod.outlook.com (2603:10b6:8:13b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.26; Fri, 23 Feb
 2024 19:16:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 19:16:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
CC: "axboe@kernel.org" <axboe@kernel.org>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>, "nilay@linux.ibm.com" <nilay@linux.ibm.com>, Keith
 Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 0/4] block: make long running operations killable
Thread-Topic: [PATCHv4 0/4] block: make long running operations killable
Thread-Index: AQHaZnFKuwnlZYL4+EOJ+sI80l7TmbEYTLkA
Date: Fri, 23 Feb 2024 19:16:30 +0000
Message-ID: <1a81ef8d-023b-4a87-a71d-a31dddf3106c@nvidia.com>
References: <20240223155910.3622666-1-kbusch@meta.com>
In-Reply-To: <20240223155910.3622666-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB7608:EE_
x-ms-office365-filtering-correlation-id: c1d53c15-c97c-4ae4-5a55-08dc34a3f10c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VF/OYZfIdQPuznZX35IyLJlG65wZK4cycTxp5U3w4veN/Y9TCwl1SBp+Aj2r6+SZN4vtuUY1dU7UDFjD+3Y8uWyzL0eVlIa9THP8nsdvdXQkyK7/NIBa4MluIrYImZ0M6y70FAsyCE6ymB2SdpqeFHOXFQDdVb1/EQLINemNeCQ9HQP6RPoCqAEP5GZPOmUfC0YTcF8ICs5/62UxPXgm6qVc5TAZzx9z69BfMrjDh5rPfIDQeIl2fDeU57sSGUlPNQ3CvF8Rj/xpoDiQ8RFE/lhjwDk0+DGErnOMAX5nwhVzb5Gzsx4vuJTB9aqRxcUSnRe0vqlRiNxdUuQy/SGO7vNGz4AYlmDGSm+RMZ8WYUikKn2xj/REBX/QY6sZ4RfYpjLcUEs7iniRKdvliPEWuOfltWWJNSsV9NNmcq8M0nafin4qSgHjzXrIk7vv1Tszj5VtL02VE2BioUInPlYjxqfPbI0tQzLjSk+8DzIr6+MmrvhfYrTFy/7586/WJqkmkZWYOtk27B4Eqdnx26S0jztlHhZr4QkijTj30LQFAfxQKKtvX8MmsUJWcK9ReggU17C+hDKVvNBJkefXaptkWwYo5/rj20LWEpZG7lvUsd2ggQ239gZtxmw3ydMX7u2T
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnhWQ2Q1NXFVN09rb0tKa0hKZTZQQmZVL3R5QlhRMjBCQkNmbGFmTjNiQkUr?=
 =?utf-8?B?RTZySWkzZ3dRNlA5djhlM0lLRnpkb0pwcGNnODZSekxtQXdjWW5kUEpMYnor?=
 =?utf-8?B?eGhCOERZS2Fvbmw3NmJRbm5UWjJXbm1CTm4rakNTSFphaE1hekdPUytTVFpk?=
 =?utf-8?B?UE00ZG5HMXBaeUFEQUFseW94MkRpN1VSMDRoWjN5eUU2TnNIYzlFL21IU1po?=
 =?utf-8?B?UHNwZ2dVRys0aXhGbk54ZWRjLzJNdDNwbU41SjVQWlZQV3ZrSmdqUi9kTnh2?=
 =?utf-8?B?TGNhRmFnZGNCcEM0MFZ6VGRtbEhHeDQ0WEtqSU5xUncrRVJKaXZaMUI3aTY1?=
 =?utf-8?B?Sk5QbjRiUTYvNlZaNUZMU2s4aGRrYk9sUlZKUDhndkNrcndicTcvTkMyRlc4?=
 =?utf-8?B?SUFOaXptYWMzS0NzZllvUWpsTFZDeW03NUJYZ25ZbGJpcGVyOXFkVE5Penhr?=
 =?utf-8?B?TTZPaHNEbGlWWkRkVm0xQXBZRVlXMnBlTlFuMTJDak9EbG5OK0ZqWkZVTW1s?=
 =?utf-8?B?OGx4RnFFZklqRUVNdDZ6aDNVZEV6NXRic09MeUJsK21nTUlmbzNQVmNGbnYr?=
 =?utf-8?B?c2lab0JkRTJtRHlEWXhMdSttVExTUzFncElFd2txbUtQQTlVdU9SL3c0SFVj?=
 =?utf-8?B?OVFzSDhjaHdNM2hLZXNKSEtNalk1Yy8wR25vQVl0bUoxbzkyd3FPYU9jOGpq?=
 =?utf-8?B?THFUM1JYZjJlU29Kc3JRMnNTYkFCMmcyaVBpYXhyTnIvcE5TcWxnUDZZbFhC?=
 =?utf-8?B?Y1pYTklUL0Y4dXc1SlMvcVZjSVpMUG0yR3IvU0pGRjIySkFwZElLNHhQQ3Vs?=
 =?utf-8?B?SWhnSU5WTithOGpwUlk1NldReElQaSs5MFA5M3JhdHNpdlhucWJoVDZUSnJF?=
 =?utf-8?B?bmhGWnUvV2J2SVd4SFJnVmc3NE91NURJUDc3MzEvV1E0cUlYekpkSlFDYk5z?=
 =?utf-8?B?L3Ztb1R1YUVBcE12SVJzVUpyc3VRaEs0d05Na09FSm1aWnJjQi9pVjlDVmRl?=
 =?utf-8?B?VElSYzJ2TEQ2MkNJMlRPK3ZUeVgxcGJtRFFrRnFOa0pjMFExeGNWc1hVT3BV?=
 =?utf-8?B?VW40bW5OdFdCMEJxNURSVTIwZlNXc3JHY2NEUmplcURwNGFnNHdLeXpHWDF1?=
 =?utf-8?B?blArT1VydzY5U1YvV3NWMGVNaUlXL20vYjcwZi82QStKQWQyY09BSkNMNjRD?=
 =?utf-8?B?L3NhbzI3b05ZT3owZGw3UEZBMGd2OXVuakNIbzl3UXN0Vkh5WmtZV1pudnpL?=
 =?utf-8?B?WEY5ZGJGMnFCdkJQRjdmV2xkc1QyZTlOY1h1eUZUK0tjTXhTSDd4UzNBSkgy?=
 =?utf-8?B?QVRjRURoaWxTaUFyOW83QXVoSUs3Ui9NdVZCWXEybFN5b205L29HUGNTQ2U4?=
 =?utf-8?B?OVZkNGlCUC9ldXRBOUF1aVY2RnBiTHBoemZTd1ZqTExLcUdEdS9rbHM4cTJJ?=
 =?utf-8?B?cUJlem1td2V2QlFtc1FNSm5CQURzcEdOc2J5aklrK3pyTmZKQWJ4TjlwYmNr?=
 =?utf-8?B?OHRlUmczS2VSN240K21ZMjYxd3dTNlcvWEhvVWZlU3dMQXhqN1RtVzNJaXly?=
 =?utf-8?B?OUpweWZEL0RpejN5MFpsMWlrYVpVSEFCMU5Vc3NtMDI4UGVrZXNKVzRvQjBq?=
 =?utf-8?B?YVkreFl4S0JqZ281UmdxWXhKWUJxbjNDaS9mUU5MUS9aOE1PLzhqM3FvY3Vu?=
 =?utf-8?B?am9QQkhQTlRSQTZXV1Y5MzdRYXZ3Ylk5SlB6TFdWUmEwVGg2TjRScEw0WDhP?=
 =?utf-8?B?VlUzdnJuR0JyVVdlWFpQeSsyRmtqZkdLWTA4YTJyNFI1UDA0TUdEYVJ5NGJG?=
 =?utf-8?B?eDAxTnJ4clE3eHY3dlhVMUs5ZnUycGc5UFA0NVZDR2J5bktKZzNveVJQakRw?=
 =?utf-8?B?UTJZVmNZcmsvb2FEZDdQSTAwSkgwY2NFOENqRnU2MmFvQnR2UER3UzhUVHlB?=
 =?utf-8?B?NHhxaklZalN3UnhqZkVnQlZ1TXdkREozdGUwQ0ZtSGtyd3l5VG9DRE1ORHpv?=
 =?utf-8?B?ZTVMbW9XVlJFWEhrZGdkeVZWZEVjVGFXanplNlg2eHNqdVQ5U2huajdCUXh5?=
 =?utf-8?B?MXJ6cUw5SXUwUEYrd1ZBeGUvS3ZGdHc0RnJnM2lCQ1hmVFFXV1htTnlicVND?=
 =?utf-8?B?NUFkWDhoVkcwWU5NNTliOWdwcGhzc1lSdmNIaXYrV21uN3V4MlpsOVk0bW10?=
 =?utf-8?Q?WiFZRzt0Z5v9Y1FgX4j99caPJZH8Jx3WroAJoulMJTLh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D141D39E67C1FB4FB03429EAA673FEBE@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d53c15-c97c-4ae4-5a55-08dc34a3f10c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 19:16:30.7901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3C+T9xZx53I9NTKNgH2aZTJMVSc20mkauXIIDCxGEhfysZJOSOu0BpKIhf4uObuf2ys/qzozdhAFEaYMZPeZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7608

T24gMi8yMy8yNCAwNzo1OSwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gQ2hhbmdlcyBmcm9tIHYzOg0KPg0KPiAgIEFkZGVk
IHJldmlld2VkIGFuZCB0ZXN0ZWQgYnkgdGFncw0KPg0KPiAgIE1vcmUgZm9ybWF0dGluZyBjbGVh
bnVwcyBpbiBwYXRjaCAyIChDaHJpc3RvcGgpDQo+DQo+ICAgQSBtb3JlIGRlc2NyaXB0aXZlIG5h
bWUgZm9yIHRoZSBiaW8gY2hhaW4gd2FpdCBoZWxwZXIgKENocmlzdG9waCkNCj4NCj4gICBEb24n
dCBmYWxsYmFjayB0byB0aGUgemVybyBwYWdlIG9uIGZhdGFsIHNpZ25hbCBlcnJvciAoTmlsYXkp
DQo+DQoNCndlIG5lZWQgYSBibGt0ZXN0cyBmb3IgdGhpcywgZm9yIHdob2xlIHNlcmllcyA6LQ0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
