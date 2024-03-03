Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8971869
	for <linux-block@vger.kernel.org>; Sun,  3 Mar 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709447859; cv=fail; b=MIkUNLtdFtM0NA5xGHjYDKUjruNbFHD4gPEbgTiY2CY6O1iXQarfzsAdSTGmPfM9Tt+wMHctHhkXr9qa+DF7Vgu3BqwaJ++JL0mdqiDwZWJEWs6reaGn5bJiJYiu7vFlpv7sK212Cn+eH9Wi2UhnmXKJjM/bbFTTxB2HK8rg+Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709447859; c=relaxed/simple;
	bh=dzTYDoau+q+y12bK7Qhap2+Y+tI3lhzswDtVEwVdpmM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DtzX36BbSKkMo8pBrVnka4pN+4XO7xIikROfYK8gtNEXprFWFfWQyWYxG5E/JcIt9ZnpAZ1H9TqO2KkF/MT8XEvMZGyLB2SkuzU8OJUh4VMHJ9QMTjXL/JS2YHC/L2nmU84hOuIXkJWhktRaSKK6XK7W1lOccMuuiOwOYYjDVNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IKUsCbhC; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IKUsCbhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvAJC0FTbiHe1+O3ZdGgDGIwmJPZV2E2oQozaGumMApV+W0izr79r5/KxuGJN1UDNfBc4dkP+ydCYG0BugnqWI2QM4RrwX/LO6lZ0ZKsBQfz3ShmXNIxtkwJL/cBCFPlwQQ0O3Ckfj5e1hOSaFEI6nUMYSLkztLZHfj8IZRo5QXVeYYZd3W3drowe1aYVyt2Jp4q/xHlr5jCZ+HKuSrEMmJ1dY3k8Qntc0T2qlybXg66eK8z371S9PzvNz4nSS/ZK9feBiFH+eMDYD+rr0tWQ9gVolD6FJ/nuAiV846Nnxst2xqyoJRgtL++rK3EVjgULJ7QD43J/FrlY/sWeKSDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzTYDoau+q+y12bK7Qhap2+Y+tI3lhzswDtVEwVdpmM=;
 b=AYm1Ajdq9OO+YfW7akn5A1qNDhhzK14WC/eXdXRrNwyJfYn5HMPdG53PU7EO5+VPOz/qlbfGfHv1A7g0Wc3i4Lo7AlfVefPFxeRUQiOxEwllBUwxYScv29RihTXu5gLJIkctZ/1jf6HSzqmHrWWUNkF3veKTIaLtq2GsVLS6T+kZ8+pPuTtlQ+btk64sja70LSgRlJX0wJDv+DPW7WrgBxlkagFhNEP+tkB3IemyMGi9Vja/meXbhzJeltO2gPwAEQtZsNB+0dxVwiGhVR/kgGpI16AZ5uW3i8e6Vbc2FHce3NRIl5ZFqYMucGQTXpVI2UwYYQEPMLkja4enxV7IVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzTYDoau+q+y12bK7Qhap2+Y+tI3lhzswDtVEwVdpmM=;
 b=IKUsCbhC8LxV/6W3Sc203+ATbOYPTDwbaIeSpN28FW22xhiNxz5DMBu6d/qai94OAJrGkXFIFbaMYsH7I9MndG1eaCpine9hwvHDYaUiOhPPztZu63F4hUYmqVY640fe84bSjJtwEGDGEbSbb9ASr/VUXA3UHEpV1P7HrAa6Jb/aDrsiOTNPh14RjT9VjU/HhLcEMRGViiFScb9LVi3nhZIKLVsffHkgxMjyD+VbkKzY6WLG+ZZep1LBPA+Pd8WL8cNgvAAYIFf44jn1uP3Z3cgbgN86c7W1r5UtxSFKc904DW3kdZONUZKBul6o9Hhcj9vQ9p7+HBMT9KcO+YHPcg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sun, 3 Mar
 2024 06:37:32 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Sun, 3 Mar 2024
 06:37:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 1/2] nvme/048: remove unused argument for
 set_qid_max
Thread-Topic: [PATCH blktests 1/2] nvme/048: remove unused argument for
 set_qid_max
Thread-Index: AQHaa72dZ9jM3/92m0+RGRTiy5cJmLElkw2A
Date: Sun, 3 Mar 2024 06:37:32 +0000
Message-ID: <4e10354b-1a41-4626-96df-2bc871b737f1@nvidia.com>
References: <20240301094817.29491-1-dwagner@suse.de>
 <20240301094817.29491-2-dwagner@suse.de>
In-Reply-To: <20240301094817.29491-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB8561:EE_
x-ms-office365-filtering-correlation-id: 3822ba6c-6604-4f3f-b2ae-08dc3b4c67a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pteEeETw/je0M3aLA05L22uSPJf+bzaNcPquvYIY7+51WZnlpDasBFJVGw8qp0qwYhQzXjydYtLYcXFZB99IkhIdxvy70wkDtuBHiTCN0QXDuWruHdWVLBZyvefjd+jH5Uplh4GPR4KZGTzka89WvbC15yBNdF1EgS2O3K7O19VHbMw1+hohYc2ase7jxfxzSBxf/o8wkpHNPXQHUUa75/fCNoZxXNOHFcfoE9EWRCyESkmrBK3POR6mo3/uWKSYaNUp9l1eNba1/1RA/vMDJZ4Qlh/iK9NCej7aqvre1w6mAoZVq454g+Z8GC+UoxuasyGhqc8X7n/KWYMWnjxauMxvy5YxsqIPWsuc141dIudz1LTlBcuZJcQk/KW3YURmGLtKJrX8vgtDAW5NBytXl3QixmfagpsUJ/zOZ0RF4mLqlD8X2OaDlSEQTeOp2sTWJgkN7oNc5qkuVc09esk87Ly7VmLnGanOnSVY4fRBP62raatfqv19et7Me2cDi+EJsrEt/Y1BW2NT6Z6/dQSmcSCEkS5okcX1s8PGHXON2KXkZ+3G5/VJKUxBLyiVwIo76cN81XkAksNV1ubG8kL6LHoawwOaZ8/wS+hKa9gnRllybrhM3icsc8B/0lD+jBw4Fj5xhxlXCeLWixoIJ/uIaAqkJY2yPIpqS4mTIl2S3rpBahowlUkelqHjfIA93KH13BNT4svPl9ea9QWQk5/YnUoCgtaitPQ4c89j1OTdt+o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z096WlQyYXorVUdvK0RmOTZ4VnNoMGRieGdNL2tVYXZLZFVyQlBrVE55Z082?=
 =?utf-8?B?QVVTWHNOSUllZ2FhbzdQczROdzVEcTZNNXRSVUU1UmV1dTBJYk1hOTFKU3Av?=
 =?utf-8?B?OC9wSjErTnduckR4ZExSNXVtMmNJRmpKOGk4L05idEJSUHlVa0F6bkZhRVUx?=
 =?utf-8?B?QUM1WEVxZ1RsOFNKdXl4YVdQZzZ5M2VKR2hHQnk4bDJhdU1RKzlkV1ZyejV5?=
 =?utf-8?B?c1lQMTBQRFh5TVZodXZ1Q01DMTF3bG9iWnpVZm9kMmlndlc5ZFdnZnhqMGhV?=
 =?utf-8?B?L2IvdkRGMXRaY1BBcklLb2NqZEp2YzgyUUlDb1h3RWpJUGlNcVdwY1owdjVY?=
 =?utf-8?B?ckxvaHZBMDhRM3VaT1NSRjN6QzE1Nm1YakZXeHVvRFdnVHBNSnhCQnFnYVI1?=
 =?utf-8?B?Vm9PcHRoK29NOEc0TTluTXVCU3R3RU9IUzFoQWNIM29XQkkzUUxzMUlEbEVJ?=
 =?utf-8?B?UHZHYXowcGNsVjh3TXdjdFA2VDFrWVZxR01UdDZsQm50YXlsQm9RZHUxd3Zi?=
 =?utf-8?B?WEdPc25kcjhvQmZkWG5odGp3c3lYSUhlSmNFMVhsbFAvU3I2VlY2Mk5jZXBH?=
 =?utf-8?B?Rk9ZZE1mUTlBdlZKdkU1QUE2YXNBd05mL2FZWkRCMkhqajJxOVN2TGNXcmJj?=
 =?utf-8?B?c29aY0hsSWJZc0FsQ0R3VU1DQ1dKZTEwdU9zVTYzdStFT2NLUCtTcFRTeUVi?=
 =?utf-8?B?dnVKZkdwMFJMRHIvWVRyV1lOWWRUaWFLZTRvYWl6RW9Jb1Z2bmEzSnUxWWJO?=
 =?utf-8?B?VDFrZ2pRQjR6UkhEZmpVcWhOaSt3NmJwYllYSmNQQjRRUUh6enVzc1NTOXc4?=
 =?utf-8?B?NUtNNEtGV2RuaThmK3FuL1BVZGpxVmJRVXhZc09Fc1V2TzR1c1oxSGFXbnhV?=
 =?utf-8?B?TVRCVnhNaUN2ZjljenVGUHJBQnhlbis2SndLYU8rTEZHUmEzQXF0TFR3VjBH?=
 =?utf-8?B?MFNBd0IvTW9WdzBDT0o2SWhMS1BFREp5WS9CMmR5R0RXUml4MVB5Y29VZnNG?=
 =?utf-8?B?aTl2RzRiUmNod0lEUXhrcHd1cDFubGNTZDJtN1daRXVLai91dXBValpPeEtF?=
 =?utf-8?B?ZHkyeGpialVFTXZQK000RHBGS3RLN0xHcng1Q3cxSWJPTmxTUkk5aHJLSDgr?=
 =?utf-8?B?eUdKZDN1cDlUNTZXY01IY0tEbzVzc3FSbytJemZDVHY1MDN1UGFhL1IxNXdW?=
 =?utf-8?B?MDAyVU9tME1iOUlYTkx0cWlybzhrYXBkY3Q0cFZra1BsYlBDOE14TjlDNFhy?=
 =?utf-8?B?Y3VVdXNYZ09saUVnV2pMaGk1cGYycXpJVWFYODRQcTkwV3F4UHRIbDcrdkF0?=
 =?utf-8?B?aGN4djNlbDNYVDgraERyOEhJTmRYcWN2S0l6TlBHMEVMZU5YQzlwTC9Famw1?=
 =?utf-8?B?am9qQnRBK0c0QmNrMkM5THdadklodFZESEd0azZjcUNXRVhKbC9aR01YVllk?=
 =?utf-8?B?K2pZN3MwY0JMclBnb1JZTHJ4aXE3TTRWdTBSSFdURE9zbk5SVm1JeHA5dDYr?=
 =?utf-8?B?ZEh1THkzc3dtL0hPaGNsVVl6MnNWL0tlOXNvRnp3MmphRW52enVrTGpERmhT?=
 =?utf-8?B?NTFkam5IR0hiWkx6OXFRYVp2SlRPQU1SZCtqTFdmUjY4dzBDMzVpVys3ZGJM?=
 =?utf-8?B?MncyVkIrendxRm9vUkZjcXYvckxyd3pIK3JLTWJQYmRyQmJXSHRLeSthdVBC?=
 =?utf-8?B?a1hNVDZ3RWRUVFlzc2pHZzNqVkdaNXovUm1ld3dua1Ayd3ovOHB0NHpzeVFQ?=
 =?utf-8?B?NFlOaExNT1NZOVMwQWJNMUhxSUVtekVZMGQwRi9JUlp3Tlp6MDN4eHhWUTdx?=
 =?utf-8?B?WGFJZjdhUFRmTHBSVVNWQ2Q3anRQa2MyM2dVTkM1ZWFMQzFNM1h5VGl1NzJZ?=
 =?utf-8?B?dWlYMWt1cElpanlMZ2R1aGRrSmp1TU9oTXc2djZndnloVFk3TmV5T0tsKzdl?=
 =?utf-8?B?L2VpV0owdFJ2MVVwVmM2RGVJVGwxd1FkS2xiR0dxeENoTTNnSEtHZ1U3aE9L?=
 =?utf-8?B?eVVvdWxsNEhyN2p2bkRtSFNKOG5KaVpkUkxSYXNxR0Y1WDVDUjN1dGZLQUxL?=
 =?utf-8?B?cXZqY3lCRzJvdmpKUklXNW1zT3QycE53OEd5dVpZbXlsQ0cyRkpZbHJsazcz?=
 =?utf-8?B?OE1zZFFsbnFMdFFFN0NmQVlnRlp0cHhJUVAyOUxKWllKc2dQV3lEenByWGY0?=
 =?utf-8?Q?O+oUoFjCrVhkDtdY2TCg8oEFH7E5LkAZSC6CmJky/u+x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4901AE8624CFA4DB50E3ADE34146CE8@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3822ba6c-6604-4f3f-b2ae-08dc3b4c67a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 06:37:32.1935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dDAv8xJ4uuHT4hEuNzbz2SJEa0EExlRG4jigp/5B8sXPQoXreqInbjT1iFsy5yEC1LE57ZGJ0xlUIICXayRcmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

T24gMy8xLzI0IDAxOjQ4LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBUaGUgcG9ydCBpcyBhcmd1
bWVudCBpcyB1bnNlZCwgdGh1cyByZW1vdmUgaXQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmll
bCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4NCj4gLS0tDQo+DQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K
DQo=
