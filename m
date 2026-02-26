Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6EB2765ED
	for <linux-block@vger.kernel.org>; Thu, 26 Feb 2026 05:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084331; cv=fail; b=r5+hZRvaKI4nU6NyAgJwVpQB4hVIrWDZe5yj4g91v6Ae3X+pwiWpa6gkye1xU0mvoU4iU0+4UGVtq6kH0JpQMkVFL/77vKYfq0luzQVXh/a3+cZM4qd70E2SsmNGupk9sJP+bjb9Juif/KoY7U/0y+UG2hTJp3qlDFnqkOJODVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084331; c=relaxed/simple;
	bh=/3Ua28ZUqsu/uPPU3rvMWFWl7BWzKxdslOqdMsylVc0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EJtdABKK/tXhU0qjFCvcsX9aklGbCAr81WMPQuhEtVb3CNMZfgRFbaxE9talytmqkczmqbXVsTHymyRW7ly1oXbT1yEKEpEjlwELnsdYF0Eo9D1p8YVpkdDHNIkPQu1OVGaO2/fElsXYUF6b/lQ4IJe+EgOjoD0mYaRILyYoUVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D5KeucwR; arc=fail smtp.client-ip=40.107.208.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D5KeucwR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co4qYMjWcdH2y7JKGkidassWMAICp4v0f06l/4oa6DXEpvgHpHB9c7q+/mmwqmcnvfPrAkUH519aMnbznhjnJwSVJVGqa48g/8KeDNva4TmkdRg201dBd8rke4NAUNMkLfoLHFdTBTfguAKkz6Vr3SBSMH6Wo9RUeVeiozij6dnpOuUF/luG3bUuO6KlBtK5rgC84uSVTj7paCEhAlZrGvCvDj275b6zxQVEjbf3lZoMnyo5FqjGv0+UEjsY80HKE/JPV6cZexlkCOwMzE0eBBYgqdPoKrd3ca2IltvqfVNJSUHM+1NoXC+0Oosc661I3+q3JaKT2yvcf1wmoMcIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3Ua28ZUqsu/uPPU3rvMWFWl7BWzKxdslOqdMsylVc0=;
 b=t/6qhpFMC/hDwU176fzTiREwsRMyknSzp+U7uTEYA1Syu4A7H1sP2VUuuCnK+Ww9UIqY9f4DG7oGdRK0N1MYVkwpv3xY+0WWccNL5dYVhkHjcHUx6ea17cVDBqs0R1bVlhyZ0PBtjVcAnT1SDvzl1rdDYpZqFCTk9LOiKBhrTPzbbYaNiC60hf+dv//nRhVIGWazRYIiD29I/x4Cm9aOkwYooQFavVIe/+up+7BfnKnKaVqWj1b6EcUuzEuZONTunsWHJmozc763ERGbhjSLUfF6XpwjrXyfONjZw/DYXTufIDlZ28mfrC8gUQBlB8pmZ/avDVUn5lCDWyLO0vXtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3Ua28ZUqsu/uPPU3rvMWFWl7BWzKxdslOqdMsylVc0=;
 b=D5KeucwRWYSUbJICp/BzMUFD3MCwwCuLgsUVQ0MfiBsLkNEoDxkN4gvzm3lF8eCwZI+HsGJFKdRIfg2aXWhXtbhm9S83wwHW0vdTCp1ZDXDKWhJUUeAZaeHo6Tl8V3aksFad9T7ZRIxkZvbnVM7zyVSFh9mUiF1/7sjWe7cdL88clc9dOIf0owswCmy9q7c6p6t6TYDEFBMTSBkVjphzuWvBDuixFl4uOH2kwVYqe2jzXAlEx++6FJNF0O3wYdOzE5j/bzsXw0EIzPNo1qJh3K3RuGC5v7yfVZ0FvMcP6/+BZBO1PXkHJ5CAUm5TFYJkLqw372k7rcfnl2Xe4dRndg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Thu, 26 Feb
 2026 05:38:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::2109:679c:3b3e:b008%6]) with mapi id 15.20.9654.007; Thu, 26 Feb 2026
 05:38:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 1/3] common/nvme: do not call 'nvme id-ns' to
 non-nvme devices
Thread-Topic: [PATCH blktests 1/3] common/nvme: do not call 'nvme id-ns' to
 non-nvme devices
Thread-Index: AQHcpJfdf9spAMiUI0yWHzOXc9xQebWUeyoA
Date: Thu, 26 Feb 2026 05:38:47 +0000
Message-ID: <9cfc1d72-a6f3-4d4f-944a-3c40ffa18ef1@nvidia.com>
References: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
 <20260223074110.144758-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20260223074110.144758-2-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH0PR12MB8488:EE_
x-ms-office365-filtering-correlation-id: 29614730-3844-4640-b3af-08de74f94fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 Yyg1dXgaHOEYzVjoK/OgakHJHzQCv+scMwE7/6ttUCH52ai+Sj+wAJ3GIuw/Ezx7IaWRc8icOmKkDycdryib6G/lSCeei3vCRSzDR4iYJhEeStZ/i0A+WLeUzPXi0iVu/4nttjJ2WPU7HIYSUEziidd1ZvNvclaQo2bcorXXV0smDWdl2aKFvruv6nwolwjpuOUKSfzJ1ZvFJxLPYgIhobTTxG1sMzY9M/0DOw/dX+ipi9YMBIITIJHbDErfHWSCNqeSbk55R2NDIrttSdiWDmiugpzHD4Pkqho0gJJiW1uSQDrV2Zv+P733We7n9VHD9jlyzH1TwI3rcVUN9NbxQT2KuTielUODhWmtJLKuheiIwhdIw9KlU03mG7yu8tlFlvCRNrTMaWmdkwyInbpWa2vw11mq7v48kTO5oYveOjj5kN3XTJhEexm8KfydbJYIc0qTodthi/NthUzBKOsZuuioKb5oMs76J9WOnKKOjLjkBRCUqZqkKd5qW+DJb/HYPEam2ZIpuLNghB11FT8UT6uN0C5Upt7RTc834Kj+bpwrh7o7nhk7vCxSX/BO+K+ftD2/D6bvbN40qih4XG/bqfF+9q0IkqjQmql0D3vl4bdlyRzfHZ9oloj7kk+k3deJo6NMZ5zbkQfNLuNaNLmP3W+EAg8YZ9aG8ALy4C23s4oBvmQAC+4dHpU6sPdTR5GxieI650hy2q3klLT1FSQ0E7a0ZB2hF8jHKIlYEv3su8K2gfdz6PR3L2etQW0A+utEb5SZZLeQ606Wjih5LN0anzkbhsMzcHU7ylSkpHBUebY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUJCVkVsVmo4VnlZdG5UbUl4MngvYXpMaWlEVFlNdHorK2ExanE1TTBSRXdz?=
 =?utf-8?B?ZG9nUHcvWllMdDhxd2k0SEhMaCtrdzZRS2FXTkgrL0hDSWhtNWc4c2tuS2lQ?=
 =?utf-8?B?S1RpOHlBM0VsMlZqTERMS1BWZm9CMFRtait2YjREQW5mckFsRDlhdDhUY1V6?=
 =?utf-8?B?WDV1MHpRdTdCRjBXam9UZUJyOTNyek5oOUVYQWM1NEpZMWpyTHNlZTZsR29G?=
 =?utf-8?B?MlRFaWlFTjhOSjB3ZFZqSDBIdXc1eit3YW5pc2JlUFhuRmF5dGlHNjBlQ3BB?=
 =?utf-8?B?MU9NTkhQQlVkMFlxakxyOHE2R1dGaVJRTEdPd205SkVPSDliVDVWVHBKS2Zj?=
 =?utf-8?B?UTNNUjBWV2VIa2tmZmFqOEdhUFJQUzNKSzhnK0VFRWJuVWRqeVZKcE0xblBI?=
 =?utf-8?B?Qm93RGhNS0NiV1hYb0I2N0FqdUZOQTU1M0ZHRUFCOGMwVTdUbk9YbFpwU2Nw?=
 =?utf-8?B?ZjZWOWpCeDcrY3BmakxHbnhWdmZ2a3E5RE1POGhtWEtTdVBGQUFCVjAwdzBj?=
 =?utf-8?B?MFJGcmpWOUNxWTdETk9JSUtoQTA0ZFVCeFJJTmZBdnNvZGtHTTZnai9XdC9w?=
 =?utf-8?B?SDhENXhxdnRCN3Z2UndsMGx4VElSb2IzdDZLWTQzSGRNd0lCQzdjUGUzNWxZ?=
 =?utf-8?B?dSt1Mkh3RG5OYk8rTUZ6cUhvU25oOUF1TzhsQW94YnlyS1kwSFU5dGt5T3M1?=
 =?utf-8?B?dyt2NU44MXFscU4wZzRQNHJTV2RxRDJqNkZhemNUNUV2YkZVZU51Mk03Zi9l?=
 =?utf-8?B?elJURzd0UDFEOHMzVlo3WmgxVUdWSmEwMmNDYUNldGNvaUJNdGtESXBjV0ls?=
 =?utf-8?B?bFlNVGcrSElIaGR5MjFQK0hKcG83YXc2TDEybWxmaTlrRm8rUjRURnhNelFP?=
 =?utf-8?B?b2tuaG9OTTJHUnA2MkxwemhkS0J6V2dDV1FTTXAzU2huSEJhUHF0QWpIcW8x?=
 =?utf-8?B?cUxOMHlnTEtjOWUxNFlyQzV1THUwUGlGd3NnTmlaV0EvWjBFMmt3eGthcWpN?=
 =?utf-8?B?NGJ3L0dtQlptMytId3hMekhOLytJMlJjZjA3MlFsanNkd2FmZm9jU0lQb1RK?=
 =?utf-8?B?WjIwNUd1QVpyVWNFQTB6bXpWYWVKVnRxM0txR0dwNG5vTEVUeG9IK09FeHBh?=
 =?utf-8?B?NGFHU2VtZVRqYkxIV2xsZkRaSUViekFIQVN2RnRMOTlpSldMbWZRbUI5dXlQ?=
 =?utf-8?B?K0puWllYRmpOVkdDUUNJMU1OMzFMVW50RnRmallNSWgzTkIrdEdpUmVqdnd0?=
 =?utf-8?B?eExObk9ZZHoyRWhPU3RzR2N6YTZSdS9KYVExSHdIc3VoNWpteVBpUXFCNTBz?=
 =?utf-8?B?UWdYVXhUd25kczJyK0pUdktTWXVHclN5QWFFWFI2Vk5IZk9pWjBMRWhWU2VU?=
 =?utf-8?B?dkkrbVluNDNYa3dQUkx3S3d4NENVRFFEakR1K00yVUdTeXEzVnpObW5kaWd3?=
 =?utf-8?B?UGtyNWJxNDIzTlpsZC9jckt4YXYwYS9LZDFvYnMwc0k4TzJvUy9zVnJocDl4?=
 =?utf-8?B?OXkvNkJSQzczam12V0kyQ2U4a0NNZzFvcXdNQStNSnBraVZEYWpVZ1FoRXZW?=
 =?utf-8?B?T0NEOFI0UEh5eU04UVBUbE9tbVcxMkZwRnZGa1JrQmpDeFU0WWUzcXVjR2sy?=
 =?utf-8?B?WFlRVmQvZ2MvU1lUL01kMU4rLzN6ZmVoWlVEQkZFSGVuWENwdDRHVXB3MTE0?=
 =?utf-8?B?U0VoWlI1eG9kd2dnZVJveXlJVmZTM3VpdUZKbVdtQWJHM2JuS2cwQ2FTbjVx?=
 =?utf-8?B?cUJVK01kMFNZak9JYzF1dllFNVNhWEFYclNMVUkrMDhZZ1J6TFZtY0U3SGlV?=
 =?utf-8?B?cTI4ajE1elV4ZSsxWDVJcEpaQkhXUUZGTXhOelFHMDlsRUVBeXRiWnRvdTF5?=
 =?utf-8?B?RjB1aGRUQUdTajVzWHdJUHZYMGwzcEt3YXY3dC80KzcwY25wUHNiS0hqVGcy?=
 =?utf-8?B?Qk91THVCaTV2ZlZxYmhUYU9oQ3JycVhSbFA3TkdtZjNBTWpHT3hUY0EwQnh0?=
 =?utf-8?B?OTFsNldlY29hOGFNcnZXOVFObThwSG9RRXdxN1ZPQzQ1bEptUVhsSDRON3Jp?=
 =?utf-8?B?VmxhSWVmOGhGZVR0UHhRZUsxN2dLTnYxeStMMDhnbmd2V0gyK0l4NjBzTjlh?=
 =?utf-8?B?WkJZMjZhU01HNnFwdldlbUcxRWcrN1hXOWpuU0Q5cHRRUTRGa3lDZm1JVHF1?=
 =?utf-8?B?MjVEQlFhTTFCSGxjNVRqVk4yNnhBbnd5cU8rcUFHeU9hQ1hrLzlKWjJ3VTcw?=
 =?utf-8?B?WmpkdnY3ck8raEV1MFdDeHMza0hNd1hsNHVKQXRRRmRsaG9UaGtDR2ZWRlNH?=
 =?utf-8?B?ZTM0eThFc2x2YiszTDZSNzA3cXhOZDJ1Z085bFgxNkt4L1FZYjFBdHhKMmNG?=
 =?utf-8?Q?8zLkUAqVFaXiCDiZGEYJEfdw5bBAE8+Gsjt7f0gbACTuD?=
x-ms-exchange-antispam-messagedata-1: eEO+MhbbuaxdYQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A14276B6AEC33409B7BC55AE17B7B09@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29614730-3844-4640-b3af-08de74f94fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 05:38:47.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AcAisKMRNl4QB3TQAYi1Eu3BRJWBo8FTQfYYB5H6w3kNcqOtm+0XW38J4VImGIkJXZapjVMOguYt4tfqblfA6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488

T24gMi8yMi8yNiAyMzo0MSwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFRoZSB0ZXN0
IGNhc2UgYmxvY2svMDQxIHRlc3RzIFBJIG1ldGFkYXRhIGNhcGFiaWxpdHkgaW4gdGhlIGJsb2Nr
IGxheWVyLg0KPiBBdCB0aGlzIG1vbWVudCwgbnZtZSBpcyB0aGUgb25seSBvbmUgYmxvY2sgZGV2
aWNlIHRoYXQgc3VwcG9ydHMgdGhlDQo+IGNhcGFiaWxpdHkuIFRvIGNoZWNrIHRoYXQgdGhlIHRl
c3QgdGFyZ2V0IG52bWUgZGV2aWNlcyBmdWxmaWxscyB0aGUNCj4gcmVxdWlyZW1lbnQsIHRoZSB0
ZXN0IGNhc2UgY2FsbHMgJ252bWUgbnMtaWQnIGNvbW1hbmQgdmlhDQo+IF90ZXN0X2Rldl9kaXNh
YmxlX2V4dGVuZGVkX2xiYSgpLiBIb3dldmVyLCBzaW5jZSB0aGUgdGVzdCBjYXNlIGlzIGluDQo+
IHRoZSBibG9jayBncm91cCwgVEVTVF9ERVZTIGNhbiBzcGVjaWZ5IG5vbi1udm1lIGRldmljZXMu
IEV2ZW4gdGhvdWdoIHRoZQ0KPiB0ZXN0IGNhc2UgaXMgc2tpcHBlZCBieSBfcmVxdWlyZV90ZXN0
X2Rldl9pc19udm1lKCkgY2hlY2ssIHRoZQ0KPiAnbnZtZSBucy1pZCcgaXMgY2FsbGVkIGZvciB0
aGUgbm9uLW52bWUgZGV2aWNlIGFuZCBmYWlscy4gSXQgc3BpdHMgb3V0DQo+IHVubmVjZXNzYXJ5
IGVycm9yIG1lc3NhZ2VzLg0KPg0KPiBUbyBhdm9pZCB0aGUgZXJyb3IgbWVzc2FnZSwgY2hlY2sg
aWYgdGhlIHRlc3QgZGV2aWNlIGlzIG52bWUgYmVmb3JlDQo+IGNhbGxpbmcgJ252bWUgbnMtaWQn
LiBGb3IgdGhlIGNoZWNrLCBmYWN0b3Igb3V0IGEgaGVscGVyIGZ1bmN0aW9uDQo+IF90ZXN0X2Rl
dl9pc19udm1lKCkuIFdoaWxlIGF0IGl0LCByZXBsYWNlIHNob3J0IGNvbW1hbmQgb3B0aW9ucyAt
cSBhbmQNCj4gLWYgd2l0aCBsb25nIG9wdGlvbnMgLS1xdWlldCBhbmQgLS1jYW5vbmljYWxpemUg
Zm9yIHJlYWRhYmlsaXR5Lg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2Fr
aTxzaGluaWNoaXJvLmthd2FzYWtpQHdkYy5jb20+DQoNCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg0K
