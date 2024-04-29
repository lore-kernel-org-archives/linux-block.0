Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B968128807
	for <linux-block@vger.kernel.org>; Mon, 29 Apr 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420451; cv=fail; b=sD8If9HRhBzG0GVTucS+lrTs0N9vmdqod7t/NUgmz4eFFxT5FYkHB66MMDqd10/4gWhR8V/DHFlPONe7XpNXyVP3TZP58A2L+fQ2vWf4szSsrZmKdpkUG4zibGNvvu5FH3Sr7SqtaMONMH35uBIJN1lK1asCq8wy4JVPxOVFFK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420451; c=relaxed/simple;
	bh=ycb0AsMUNX0PUodoFUtqdzjZVMvcaLGM4qBcaHH4b0g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTl6XVWKd5Tq40yhIZJ99t3oMKU0cCLfVxOJvVs6vlf27tf57mkoPDKp09PTeDFwtEELAIokrbPo9j4001jaDl9yanl158BR2XcEClap26DaTqWyU2ez1cudpkiO5Q+mGmF2JriRikWQbeW7eBF0MbpJfOmzx2ioXM7LFybQmmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tflLC3lK; arc=fail smtp.client-ip=40.107.220.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tflLC3lK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwz090XHaYNisQEOalUs0kdnTPcPt+JMTZuC35VzC2ncGPfgYfrPCl9nZ9aRtZU66EHn2F5HklLUVMtytszmP8uCpIL8u4XbByL1F6jVeCz7tU3NIwQUO/k6Eib/xaCKjKroU+Lb0rOkJlOQ3t5N61XUomTRNVdN0fYRmddeYQCjZhKu7LLYquGaG+vrviVDMH2jymi5BgQ6aqNDChnJyQrdCxQScaGCftzeLkSKbf7jKFCQRX4/iSTb8pelfjDLueAc5a3sYeHHeICKgOMvR/7AauR8wVXWOMoN1Sym2p3zPxsy7r4E5AAhaZGow+x/D/gzBYc9fEKcpHGwnryErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycb0AsMUNX0PUodoFUtqdzjZVMvcaLGM4qBcaHH4b0g=;
 b=eINu9cB0Q2aW2zbU7PVj6xbpJ4YXkqXUeIuQFZlXdVe7PyP4Pj2zrnnU8Vro9Z8K/UVsLX2MNJ0ym0xze02EuBv9im8/CMrH6MoF8RLU6Bt9s3+WiJFw1bJmN0j2vNMyq0zlYK08ItRzFpVGJc2zplCMKm3Gnjk2KnCN9pDv1sAO0ho2SP8mdsIyp3klmF+8oTEM3cX7JN6RyJ5Af7xLxOc1FDVYNHu/5fCCWbjrgXH8beDxKiJL31YfLgB5/DDuMKjnY6pMXpPs+/XEUzr4rOMQC30j/Pqy3zXC1xBu85L17YQcAvXuS95+FHExF1kl+5hB5xcmkeBe4TY2ARGWYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycb0AsMUNX0PUodoFUtqdzjZVMvcaLGM4qBcaHH4b0g=;
 b=tflLC3lKXo8/EXCHkbfpvxV4+ljgPNLcTo9J7cNo+fYA00ahu8US5tqBMC0y5hD8ulZ166aylf05UcLbdaaV9g1KxARt2i8v7sybpcdqG0q57EYvHVg3/+xxfMEkUJ7V9oDIyOB2UXZntie8YRpFwJ99mJRGGcYUFS/cV6tIkJgXM5zMs6zAi8weagT1eztNoeFoy4h2CBaOTgfbh4lP2df3UOYTt7HZY2wua8y95jHqv475IrDkattnCXPfKrTb5r++uEHVwhSUKR4rti3wdgSIm4YKhsKHTJQ54qzXd1AOtYfKsGVvB/7wsmfNPU8q4lbeLC+Y550Ma2zmNXUxQg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 19:54:05 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 19:54:05 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] brd: implement discard support
Thread-Topic: [PATCH] brd: implement discard support
Thread-Index: AQHamh9EMQHoQBh+E0mIH8L1GXTcEbF/qbyA
Date: Mon, 29 Apr 2024 19:54:05 +0000
Message-ID: <c611759b-7d26-45c2-9655-33eb7bb69024@nvidia.com>
References: <20240429102308.147627-1-kbusch@meta.com>
In-Reply-To: <20240429102308.147627-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB6424:EE_
x-ms-office365-filtering-correlation-id: 8a211ab4-5021-43e3-3682-08dc68862037
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?M1hrMmJZcEQ5UkJFM3dIWnFpdDVtYnRTLzF3eUZpZXlRWTZhMS85RjY1K3Zv?=
 =?utf-8?B?MmRVQmhTWWEwMVVRVlFrM2Jqbk5OTGxyR3ZqQVNoMHFiLzkzdXp5S3JKOTZq?=
 =?utf-8?B?TktvS2lmVFVGVWp3U2F2THcwY2RBUU5Nb2x4U2xjTGJqSEhtcmloajd0cjBy?=
 =?utf-8?B?ZUhjWlFOV2JhQ2hYSHNyNDFLYTFSU0U2cHRGKzlIem9YNmJ5Wk91Q2lta094?=
 =?utf-8?B?VVh2b1E1WmtYcllsU0sxWlR5S0JGY21wWXhqaXdzakJnSGhoZDVqV2hSSzV4?=
 =?utf-8?B?V2FaNFJwaXNPSGxMV3ZYR1lxd0NhN3plTVNKd1pobkFPMlZSNUwxNzBobFVB?=
 =?utf-8?B?LzIvbGNhUC8vNEJXWkYwdkVGTVZiKzZadEIxcjJOMTNIcy9nVG0rc0FlM2tu?=
 =?utf-8?B?WWlRVzNyR2pjRzBkUVUyN2x1R0dxU1V0V0ttY2dMdkhQcXhqdEtWN2lsZXJu?=
 =?utf-8?B?UE5yajZGNlFmNEExTUdINmRPRDhmZm5HYlArUGVIQnJnRjRxcFd3QUFyb2U0?=
 =?utf-8?B?ZTFyU1JsTjZWdXk0cEJVZHBoRjYzWEUxTmpGRWJqdzQ0VDc2bENZT09nYkhI?=
 =?utf-8?B?NjVPTkRCY1lLQ3E3bDdZVEFJSFUrcXZCNlZwQjc3TlhJTnJ6dWdiQjJpN1Ja?=
 =?utf-8?B?TCs5ZVF5WXh1aFR2SUsvL1Vqa2grVnJsU2hLcWgzL0E0Mk4rWkFnc0ZFV2Q0?=
 =?utf-8?B?ZDdFc3I5WUVsLzBFR3BJSlp1R3pYOURRYzNWR2dlS2tpL0xXV04vRHJQS2Z6?=
 =?utf-8?B?blowQ25oeDlZdnlsZ1FXeUNkanhtYjg4T2txQmZaOUVuZlEwT3BzeDJ2ZTRO?=
 =?utf-8?B?ZXoyRFIwNkI5ZnVhdFRROGEvSk1HYWxFZ3hpK3NJaWFlNFNWaDRMWjV2S1Zv?=
 =?utf-8?B?UEdLSWZNU3cyWmVYTkdqSmNyUk5xWGpHOHhueWR1UmJ2UDIyQW5ncGo2ZC93?=
 =?utf-8?B?TUNIVjVrMTljRkZQS1Yram04Q2NRdmRldk43UzMxMm5ZV1hRbnFnOU9idFVW?=
 =?utf-8?B?dERuT0ZvVFREald2VVh4Zk9VZ1VaMlNMbTdvdVJJczN4dnRXRjExTHNCeHF0?=
 =?utf-8?B?Ui9jRnRVTTVKWWxOY0tqS2Z2SittU2pMSHF2TCtBZEo3a1pRREwvTWV4STIz?=
 =?utf-8?B?dUQrdDczaTg5blBYcEpZTVRwYkExZkRicVRTM1pCdEFrU29Tdjg0dFM5SG9D?=
 =?utf-8?B?QklVRzdGVjhQM2laei9KL1hYakxqTzg3RWtGd2RDWWJTbWZzVldMaTJxWG1B?=
 =?utf-8?B?MXhLWHA3WjdlRUdlWkZjNGR6Y3ZZQlhnU1NZN2I4TmZ4ZzIyd0RwakxLbS8v?=
 =?utf-8?B?UVBFL0FyV1pxektmdHRiOFZCd2dGRUV1T0F6SVVWUWN4UkJJOGpqWkFtVGNh?=
 =?utf-8?B?TEc2Z0JwUGgvMUsrV05VUExsa0FpVm5lM1VuUStNUGpkTFNOaTZRenlqNXZB?=
 =?utf-8?B?VkVlYmV6ZWRuS2lETnloemVsN0ZrbFo2QzVpQjBZNXdVWDJvL3FQWFpJdWRI?=
 =?utf-8?B?bThFcUdvU0FQYnBJN3BYSWhjNlY0d2cxV3Vqa20yM1pZRmRvVE41VjE4MmpC?=
 =?utf-8?B?NWlNbzFuUTd3U2Q0RWZhS211N3VjMjc1RUtiUmVyRXBkWWlmY2ZueGpPajAx?=
 =?utf-8?B?ald2NzlsWjJKN1ZRN3N1ZERiVC95WEZuVkhBb3I4NUZnK3c3YWN3ZllLNlhn?=
 =?utf-8?B?aURVR0ViMlVhNFBLY0RCeitqS0JBYzhNRUVLNURwSkJBZzVxOGdVM04vOEl1?=
 =?utf-8?B?TnNQQit2U0UzaEg4L0E1WmFKaVJiOVJlOE80VFN5VDRONjBwZFl1MGl5aFZT?=
 =?utf-8?B?OE4xRTRGNjJhUUpGM1RyQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnEybVBkQkZVelVTN0c1WUJBUnliR1QyYy9STER1UGppQlo2cHdhMFk3QU1G?=
 =?utf-8?B?eldNWGgwdm91Y2NuRktrNFlveWpEdThyOXc0dnA3SUtLV3Y3d0tiYXROaWd1?=
 =?utf-8?B?dWlPSy9XWWhObUVWY3BSem9kSWYvbUhsM0hKWkdibWc2bGlkazU2dldQRE03?=
 =?utf-8?B?SFhSU1BCaXZrQVd4ZDlpVlFTVzhKT05PWTRGc25zSWdmYkttNWFjazNiTmN4?=
 =?utf-8?B?d3NEb3NSK256ZHBOQ1BYWXJGQTNDcFZvOFhETjNEZ3Z2NExGVFB2YnJYS0R2?=
 =?utf-8?B?MGVOM2lhMVc4RUUxTENWMUtzSG9EWVlNQnVGd0d5K2F6bHdITDVDNEVUbzJQ?=
 =?utf-8?B?V3NWTnhMZVM0S01hdXRkNVNzM2FHaU43OTVkTHhnb0o3SmRRUEZWZUdicWRy?=
 =?utf-8?B?aS8xdmU5VzhVT0pXTXp0YmVmNkNUSGRhTVlvUzJWK0ZwTEFCS2RKMURpYTN6?=
 =?utf-8?B?bGdPbTgwWC8xU2h0TDlKVGl5aUd4RUpyNklYVVR4Y1dCcDRCczZRcnljUVh5?=
 =?utf-8?B?N2NoL21lT3NEcFNpWnpaYnlwRnRYOEZVKzAyUnd0dnFNdFJkN0pyZE1pVlZV?=
 =?utf-8?B?Y3lKazBHZk50b2VYTXR2VytqZ3lUb1p1b2Z3bTFGM0dLOWlMRHV1UHQ5WHVC?=
 =?utf-8?B?WVVGcHhhUjdzMlJ1U0NXZHQ1MllOUHBSSm94ZWgyV0lnRTJ3U01aaTU4Y0tM?=
 =?utf-8?B?aVFLbzBGN2pUK1lXcUZZMHNxanpwQUdrQUl3ZFJDcUxUWGt3MVpUZmNIcG8v?=
 =?utf-8?B?STFyUWpTZVRWZFdiaFdVb2dodW9IRmN4cXZJSVpHRVhBRmQwSGxjY1ZhWk5p?=
 =?utf-8?B?Sm50YlVYdmUyUHFNM0t5SkVhajVGYXp2NmtYT2JhN3hHR3NCUDEvcmE3RXdN?=
 =?utf-8?B?Y3JTdjkyNTRGZzRqUnQ0MnhXa1JHamxiNk0rcjkyNnc3SmhmbGcrK0Eyemxo?=
 =?utf-8?B?bEhvYUM2MXRaZUdrUnBlMUc0WTJoSE5nMFNSOVEvTkY4OTM3VGt4WjAzZFV1?=
 =?utf-8?B?a01yTXJFNHBpSEJoT0xRejdweFkrMGRONmh3ejBYOFVTb1VjWndIZElhRHNY?=
 =?utf-8?B?cEVvVjFienBSWjZoUS9sb1lJN3dBTmJqcUVLczMyd2RxcTRWT0pDc1RsSFdy?=
 =?utf-8?B?MVhTREk5TDZLbEVsZnFvNndUTERLbGEzSjZ0V3NCRHFHMUUvSW5KNzQyWjFk?=
 =?utf-8?B?dXFjTFc1bk5sY1ZnTlhFdG1HaTRBSEdpY2R0SE1FU0ViYnF3dmo2Y3lKUHNl?=
 =?utf-8?B?anVObExXRmdMTW0wWS84Nkl4SXVSa1lRaUZoaVI1WTUzWDNuQ0NuTlRrYWJV?=
 =?utf-8?B?WWUyV252K1ora2dYa2V4L2g0UERCM3RZcUJnRkFlTWZUQnBGRWhVNEFUQ3d3?=
 =?utf-8?B?YS85enVCcUZpQmRRVFRXY0l2NzJVZGZQU3hnaWRndXZ6SUFlS1hSV3dWTFNW?=
 =?utf-8?B?SDRCa04razJiZHI4ZWhpQXdOM09VTUxTTXl2VjFBSUlCUDJhdE9PdmJmYlVK?=
 =?utf-8?B?N3lMQWZQZ1c5VGdRU2VFdVVQUzV2WllXM1VsenA5c3o4WUNQYlplMGRETnB1?=
 =?utf-8?B?S1lLcnlUS1NVM1ZHTXBuVTdVUStLLzB2Vm9TVEI0d1MrOEszeWFhZVg5Rzlt?=
 =?utf-8?B?dXlZTGZ5NnYyekoxaTVhcXVOdkxqQi94K2NCQTZCNDhKLzZ1SlFsSzU2RmdY?=
 =?utf-8?B?akt3cVl6OVpMT0tCUDhmOXhuZzQxUXZFK3FLYks3V3ZJc0hiZExzVGN4OWps?=
 =?utf-8?B?QitSOTVZZjA1K3pZdTU3SG1IWDNrRFlVRmI4VE9yZzQ5b1ZUYVVDYjNvclNB?=
 =?utf-8?B?a1RZNk1lN2pwMGNPVGRLR1hVaXhrNmFnZ0k0eWZSczc3R1pSREVWRmRudUpq?=
 =?utf-8?B?WkdEMEU3RkZScDN4TEJIUmg1UXN4QWFvdjl1LzlNMmRXY2c0cEdkT0dXRS8z?=
 =?utf-8?B?bW1YSHp4MDJrakNNZ0Zrc3JvOCt1NWowblB6Zk9MWUhwSEMyTURieVFoOXR0?=
 =?utf-8?B?bm5ZNlg4V1drY2xnS1ZweFJOeTJFN1M4ZXBvVVlQT0lncTM1dHI0cnZicm00?=
 =?utf-8?B?elpMNWQ0Mmh4ekwwNUt4Zlk2dTlyaThEMUIwZzJrVmhBd2tGZFh0bkRVMW1N?=
 =?utf-8?Q?vwEOslnYJfbqIF9pKFY4fo9fY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A8A087B7A7A244DAFF54DBB47C8F8C5@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a211ab4-5021-43e3-3682-08dc68862037
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 19:54:05.5059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w1komipXOa78s+pB+ak7Uut633wgLvjwa5qQQ6EKMzYfsz5suQlTWISuQP5fyx3CL4YxvZUTRPZhS3snLwj0uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

T24gNC8yOS8yNCAwMzoyMywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIHJhbWRpc2sgbWVtb3J5IHV0aWxpemF0aW9u
IGNhbiBvbmx5IGdvIHVwIHdoZW4gZGF0YSBpcyB3cml0dGVuIHRvDQo+IG5ldyBwYWdlcy4gSW1w
bGVtZW50IGRpc2NhcmQgdG8gcHJvdmlkZSB0aGUgcG9zc2liaWxpdHkgdG8gcmVkdWNlIG1lbW9y
eQ0KPiB1c2FnZSBmb3IgcGFnZXMgbm8gbG9uZ2VyIGluIHVzZS4gQWxpZ25lZCBkaXNjYXJkcyB3
aWxsIGZyZWUgdGhlDQo+IGFzc29jaWF0ZWQgcGFnZXMsIGlmIGFueSwgYW5kIGRldGVybWluaXNp
dGljYWxseSByZXR1cm4gemVyb2VkIGRhdGENCj4gdW50aWwgd3JpdHRlbiBhZ2Fpbi4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPg0KPiAtLS0NCj4g
ICBkcml2ZXJzL2Jsb2NrL2JyZC5jIHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ibG9jay9icmQuYyBiL2RyaXZlcnMvYmxvY2svYnJkLmMNCj4gaW5kZXggZTMyMmNlZjY1
OTZiZi4uZTc0MWIwYzNhNGY3OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ibG9jay9icmQuYw0K
PiArKysgYi9kcml2ZXJzL2Jsb2NrL2JyZC5jDQo+IEBAIC0yNDAsNiArMjQwLDIzIEBAIHN0YXRp
YyBpbnQgYnJkX2RvX2J2ZWMoc3RydWN0IGJyZF9kZXZpY2UgKmJyZCwgc3RydWN0IHBhZ2UgKnBh
Z2UsDQo+ICAgCXJldHVybiBlcnI7DQo+ICAgfQ0KPiAgIA0KPiArc3RhdGljIHZvaWQgYnJkX2Rv
X2Rpc2NhcmQoc3RydWN0IGJyZF9kZXZpY2UgKmJyZCwgc2VjdG9yX3Qgc2VjdG9yLCB1MzIgc2l6
ZSkNCj4gK3sNCj4gKwlzZWN0b3JfdCBhbGlnbmVkX3NlY3RvciA9IChzZWN0b3IgKyBQQUdFX1NF
Q1RPUlMpICYgflBBR0VfU0VDVE9SUzsNCj4gKwlzdHJ1Y3QgcGFnZSAqcGFnZTsNCj4gKw0KPiAr
CXNpemUgLT0gKGFsaWduZWRfc2VjdG9yIC0gc2VjdG9yKSAqIFNFQ1RPUl9TSVpFOw0KPiArCXhh
X2xvY2soJmJyZC0+YnJkX3BhZ2VzKTsNCj4gKwl3aGlsZSAoc2l6ZSA+PSBQQUdFX1NJWkUgJiYg
YWxpZ25lZF9zZWN0b3IgPCByZF9zaXplICogMikgew0KPiArCQlwYWdlID0gX194YV9lcmFzZSgm
YnJkLT5icmRfcGFnZXMsIGFsaWduZWRfc2VjdG9yID4+IFBBR0VfU0VDVE9SU19TSElGVCk7DQoN
Cm92ZXJseSBsb25nIGxpbmUgPw0KDQo+ICsJCWlmIChwYWdlKQ0KPiArCQkJX19mcmVlX3BhZ2Uo
cGFnZSk7DQo+ICsJCWFsaWduZWRfc2VjdG9yICs9IFBBR0VfU0VDVE9SUzsNCj4gKwkJc2l6ZSAt
PSBQQUdFX1NJWkU7DQo+ICsJfQ0KPiArCXhhX3VubG9jaygmYnJkLT5icmRfcGFnZXMpOw0KPiAr
fQ0KPiArDQo+ICAgc3RhdGljIHZvaWQgYnJkX3N1Ym1pdF9iaW8oc3RydWN0IGJpbyAqYmlvKQ0K
PiAgIHsNCj4gICAJc3RydWN0IGJyZF9kZXZpY2UgKmJyZCA9IGJpby0+YmlfYmRldi0+YmRfZGlz
ay0+cHJpdmF0ZV9kYXRhOw0KPiBAQCAtMjQ3LDYgKzI2NCwxMiBAQCBzdGF0aWMgdm9pZCBicmRf
c3VibWl0X2JpbyhzdHJ1Y3QgYmlvICpiaW8pDQo+ICAgCXN0cnVjdCBiaW9fdmVjIGJ2ZWM7DQo+
ICAgCXN0cnVjdCBidmVjX2l0ZXIgaXRlcjsNCj4gICANCj4gKwlpZiAodW5saWtlbHkob3BfaXNf
ZGlzY2FyZChiaW8tPmJpX29wZikpKSB7DQoNCkkndmUgYmVlbiB0b2xkIHRoYXQgdW5saWtlbHkg
c2hvdWxkIG5vdCBiZSB1c2VkIHdpdGggZGlzY2FyZCBhcyBpdCBpcw0KYmFkIGZvciBkaXNjYXJk
IHdvcmtsb2FkcywgaWYgdGhhdCBpcyBzdGlsbCB0cnVlLCB0aGVuIGNhbiB5b3UgcGxlYXNlDQpy
ZW1vdmUgdW5saWtlbHkgPw0KDQpBbHNvLCBpZiB5b3UgYXJlIGRvaW5nIHRoaXMgY2FuIHlvdSBw
bGVhc2UgYWxzbyBhZGQgc3VwcG9ydCBmb3INCndyaXRlLXplcm9lcyBmb3IgdGhlIHNha2Ugb2Yg
Y29tcGxldGVuZXNzID8gdW5sZXNzIHRoYXQgc3VwcG9ydCBpcw0Kbm90IGRlc2lyZWQgZm9yIGJy
ZCAuLi4NCg0KLWNrDQoNCg0K
