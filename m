Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2045.outbound.protection.outlook.com [40.107.100.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408AFA93A
	for <linux-block@vger.kernel.org>; Sun,  3 Mar 2024 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709448238; cv=fail; b=gC5LaU11FuTjhd5Pni30Lg594l2T4YVo4TIOHXwLmziswkmbW433QzDmPEpc6QTaX1WhBqO1v6ASjKnRCPHPORU3GCYdKt/eZEtGUyKRt2Gp4/pkQbdIeh3J1KCSMLx6vyCo5VQekMN0Ddq9DEWwbt2pX+l0eh336L5jkCdZlYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709448238; c=relaxed/simple;
	bh=ZRTcBDPEbx61fxRCCl2E1KZ366TZDh3A70aVBxMmxHY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hSwf530bKVp/AH66tNJ83hQ0YFK8qVrNgKtGkOQwIhPy0y+grYOyelcekTv6xN/HvLmJS2AIKAO1PFAGMpZesIELSkrd2VseuwTrD4h2Y5Fy8qNaID0r+wRocbl9yE5rZ9ganTx7MiBrTnw3sTXlntA2e2vqlqZMaedJ6YgVs0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Dqz18GeP; arc=fail smtp.client-ip=40.107.100.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Dqz18GeP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXpGMQrSIEDl8c7H2xbdWvS5xzH97D1Ttz9gG+4i9K98YxqotNBIEl5VdxNLKgaIZ7YPHXb5fd4PCB0EelK8C2W/eHHbi+SZ3TD/y9j/IeYNBdqoaI2uF/xQhjfNoU0GDNCp+Rquc46Hxmmy3KHWwAXW/FaIZ3ox44cvRUJkTacMs28+s2Os4aD1BNrWPrnDzb6m0qcQtLM3ZanaV3xzcfYotCByFgJWD234iLIJ1/IU0r7007TYD05ptn2KIlvZt5EgsXkGVN9VKiNc8zkC74J9/g+Ym7DNraLOsDafrSIgs34lOMqX3eCS5Tl0ZwHmjHKF+ZsxvbGCuh0m86tbhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRTcBDPEbx61fxRCCl2E1KZ366TZDh3A70aVBxMmxHY=;
 b=CNcFrDPW+AAQL3/qTxTms8KKb++E1TfLer/jhdNj2YKH1Ts6yNlRlpeNfWZ+zTi+ecAr6xvoqFkElwD8AwlwkxPYb7ViNs6wVjrQmfbPYdguaRLpzLSZmkJB5PTJpN4A3axCvHzqUOipI5BWHdRlW5iRptPqDwymApAcXmy14dh9wpd8Ad3NR4dfzTJLH21oEFemJXMbr9EURUsNv2zrJGrA0lZIjEhOrnno731EeTbKeCe0G7TvE2UreFQL4UeHmbtuN5oISkx8sHAq2HpMWXN+vVfDI+BC9idj2xV5PdTFCUi9ViLp9IXeneQvALsUzmtP4Wa+XcSFEZr9/i8psw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRTcBDPEbx61fxRCCl2E1KZ366TZDh3A70aVBxMmxHY=;
 b=Dqz18GePBIOuXPvip9Gw+pP2POtqm+pzgpK3GZfBehU8ywRPhi6i6lAt24dxGjUPIW+HqbAsBcidOCVrLbNf0bmIwwN4IAphy9RGwfOdUat2YqzHDgAIofeSVfcOFy4dlF3vgFeHt07ynPUNyOFzvHGVov4L3U/h366Ca1uAC82X2UjZPOqfHZlIpm2f+1DrvMSTSmmPeahzTZRrN7wRaPNtOfHbjP5MukJJWb8U6vURbVvz2oLNLyZI+HcdXfL3Qj0RbYx8swLfFywXQRfhB7bHLFInbUFlTG5+A0RsJWY+Xr+OpSG6C3ZCbePNpjwS9f6RSXDRnTvkUl4z6DayeQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.37; Sun, 3 Mar
 2024 06:43:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7339.035; Sun, 3 Mar 2024
 06:43:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 2/2] nvme/048: make queue count check retry-able
Thread-Topic: [PATCH blktests 2/2] nvme/048: make queue count check retry-able
Thread-Index: AQHaa72d08S9ZI+j8U2co1NGoY9xybEllNWA
Date: Sun, 3 Mar 2024 06:43:53 +0000
Message-ID: <e55ad703-1b5e-4678-9d3d-7e0a0c01e732@nvidia.com>
References: <20240301094817.29491-1-dwagner@suse.de>
 <20240301094817.29491-3-dwagner@suse.de>
In-Reply-To: <20240301094817.29491-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB8561:EE_
x-ms-office365-filtering-correlation-id: e6c932fa-7be2-46bd-37cf-08dc3b4d4adb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hgoPrGCXj7bbRWAtc+AQshMvRgNO+LvIdrwCJgH0WQkZgnDE++6CKjTlz39ajU8NijJYQwXXOUcpEUygZd68dO/Ez0leK0dNpwi23tUBrYBp7YXqGkUIo0i/zUSCqJROYFVWCjntCWG2/P2rDXJ0GhYp0DFkb2odumf7PBLcCVvpCOnVZUqpANGfAmK8Duv+nmxTmipBCpS9x7d30VZuYMCOR7ULYxgoAXoc9D1/NvHmN6bMOk8gWkSQx83/r1Hw26SRPTNZY5O6KOlnV6mUe2ftNpRF7xApnujynmfQJoFGs/sNupO/g9oLeJ4XiCCdtdmw95dVcPG5HPwnSizll3xv41FXbdzuK3UCD9ddhq0XCtlc6i1Un8/FiHPed+hPJJOA+06VS6mdY9NlBotE60bJCmWWqf0u0WoORwSkRfzWTSngXNxgDIZ29vXMB1g1Ir6NVPcuFzY/vIERSswGJOEG+az3r1+ciIA3x6PAtE2Au18TcN3aAFcn7xQtnA9wuQnAnHh3wX8DcsXw2+PFzSgFbLzadIKIy3ex8+n/gto17+ArWb7ofZoNlZplFCL2CdqaP+AaCPPPJ6Bw9i4Vax7StKoa/imy+Riyu+hy2sWVpLsBUyZr0CX8VS+A/zEdNtdPQsTJ1KRJP5MbrYNB/XRakjIiZ4aQLepTthqiyXEp8xYTiPHCh2M+jm+LQYOBK0ivCcssd2jQlV+BDxZtRzCyqb2QPnIO6DU5ReC7MXo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OCtpWVp0ZVYrVG5rTzZ1aHV0c3RadkdQdk9SZVBxbE9Ja2U0Z3JJdlZRb3Z1?=
 =?utf-8?B?QUxxb24xeGZRWm53eW14bHJ4WHZDQUN5V1VzSGFQRUx4TmF3SXhGbTF1VTF5?=
 =?utf-8?B?ZnJEZndETFZsbUJlaWlvMEZTbWhoR2thekFaWm1tOGIrS0R0dE0vdi9iN1Mw?=
 =?utf-8?B?MVZoSUVHUkRJWlZyYkNoRnF6V01nMElEVE1FUXJGZEdxaG1wdDN0Y0VhdFFC?=
 =?utf-8?B?MDdFSVhaOHExSEVPUGs1aG5HTWZ0OUJodGlOak5BWUNsWVNndEZ0emxZRmlW?=
 =?utf-8?B?czE4dVpDaVc5THFKcUNkNVB3WDZOQVpxbHh1K2xDZ0NwbVBuY2srZzJiam0w?=
 =?utf-8?B?dTdPVHdmS0Q3TmlpZTJGZlRKUjRXR0Y3ajArUlU2TTdiL3ZoMU9yRFhDL05P?=
 =?utf-8?B?aUtzZ3RjeVpKbUJFc0pQdEcvNlhQVURuZk11K1Y3K2x6dXlpeUo1dWptaVcr?=
 =?utf-8?B?Z01wQ0ZXcEJpM01ib1ViRVp2WHlwQVdtUmtzRDdVbHR0QzI2RjgxMTUzVmMx?=
 =?utf-8?B?bGpOVUpTLy90TWpuTjFTMkxCMGxmWTVVWmRzV0lPZnpYMFprc2VEMStpa3B6?=
 =?utf-8?B?V21uU3Nwc2Z5Rlg3ZGZDK2tCUGNheXVqeUxEOXhaSVRvMDdtNzF6YTFzM0hO?=
 =?utf-8?B?VnpEclZTa0pjZkJMb2w5SjREcnY4R1Fjb2JuRnRvWEdVQndwQmljWUw4QlM4?=
 =?utf-8?B?M09UNjdWMlFnaU95WHVvWitTcThLL2Z6aWUxLy9HWTcvVnRPL0VtRVN4UlNW?=
 =?utf-8?B?ZGRwYXFrQ01xV0c0dFhYZURyU1N5M001YjdlYWVuODRZcmNuUXBiTE1EVUpS?=
 =?utf-8?B?by8waHVnSWMyOUlKQmRCblBaNVh4b1lvVW8valp4U3J6Z3pmNFdtSkhMcEpj?=
 =?utf-8?B?U2tDSXBka3l1eWoxWGVSbXVBcS9KMUxhdmpmVXJpVWJMazNSQ2Z1ZkhDamk0?=
 =?utf-8?B?RzlqbjAxaFI1ZmRDT3phTTFzTVBLQ0JTekRVSytPUXJyWUlCWlV3T3hSWkQ2?=
 =?utf-8?B?Lzg0Vm10ejMvbVMwTTM3L0pLdnc0ZG44bFdNc2VQTlpTc1Q5TjdCTFFZRDlD?=
 =?utf-8?B?aFlaSzhlM24zUkVsbkpkbXZtaEV0UDUxb1BzMXFVRFNYb0VnTWpJdkFGckFY?=
 =?utf-8?B?UTR4NFNWNXF1WkdmZDYzb092Nm1ubys3ZDMxbHJwUExaWXJZbkRGZWthWm9a?=
 =?utf-8?B?SXFtSzVrTGg4U09tdytPTkxaeHV0WlRLSmdoZFA3Vk9YNThJeHB6Y0xJd05m?=
 =?utf-8?B?MG9ranJLYTErbUhWcTdtN2ZPNnMzL2VWVE9yRVRtMkhlNHFqak9ENG9MNWhU?=
 =?utf-8?B?SjRWc25ZVEhpSSsxTlJSSUxUaXVNUjk2SVBXWjlwRVdFb2dCajluaExNRXda?=
 =?utf-8?B?NGxyRmxDcGFUVkEwWmtwcmxHTGw4UWl4aFJROFNtUGtuN01zQlJBRUY1Z2pL?=
 =?utf-8?B?T3U2cDZOWnVrR29SK2dEWWdsN01YdHgrcnV3eWl2NWhxTm5oby9WdlJFU2hX?=
 =?utf-8?B?UllVM1JDY3ZBRnhGd3VWaDdUQXBvb0pXNjZETVhUUlV5QUc5ZitoamliZkxm?=
 =?utf-8?B?RlpYUFhvSEVMQnNCQitETldQMjJRT3RSMzlMWnptbWxkUnJaR0hqdDFrTG1v?=
 =?utf-8?B?cjAwTW1sVjVoVHN4N1RjM29HODh2Ukcwa2xOem9JQlpoQ0xLbzk2dVF3aEdX?=
 =?utf-8?B?cHNWUXZiUmxiSFliVG9MU2NYL3BRcDI3blQyUXg3ZUtMOXdidDhESGwzN3hO?=
 =?utf-8?B?VzR1NTZZUFVleWx0eG5hTDRma0lIVmhtVjF0L0tOTDMrRTVKekV6S2xFemtW?=
 =?utf-8?B?QnZHamJQWEREMmwxWG5qdWs1T3phTVMxY1BmRGxucHlwVUUzcWw1c2lNRUxD?=
 =?utf-8?B?NFRLTCtaWktpY2lja0cyaXpiTkNZTThaWmNFZFpTY3VZUkdlcnRlNk56V2da?=
 =?utf-8?B?WVQ0Y3pxeDM4REJNSXcyOUQzVUZPZVFnTmN5Y0hRdGx6V0x2LzJIOE9HLzM4?=
 =?utf-8?B?UnpiTk43aUNKeGVSR2FGKzZNakl6N0VCcWdPeGhLK3ZIaVRNVmV5bVdoQmJs?=
 =?utf-8?B?aVFwK2FIUVUzZ2lRYjZ4VUVuWVpJTFBGR3FTSjNtajlRc2g4Y2NQUXBWMUE0?=
 =?utf-8?B?VC9lc2xaRk9nUmc5ZU5Ec1U1TFlLYWNYMEZUaVZuQ1M1a25TTFlmNXlNbTBi?=
 =?utf-8?Q?DNw0KSh3+9IJsEQGYW6oTfpHZceBS9C6pIt2v2j8q+D3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA6F51C4BB3DF8458000CCD10057DF9E@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c932fa-7be2-46bd-37cf-08dc3b4d4adb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2024 06:43:53.3774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIAFKsammFwyO9GVfyVRrKtaSU8yt20j9uONwv931FKKOXl5BRRaguDSSZiPI5Dp9d7nqTYjCw8BiDcnkp0lOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

T24gMy8xLzI0IDAxOjQ4LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBXZSBhcmUgcmFjaW5nIHdp
dGggdGhlIHJlc2V0IHBhdGggb2YgdGhlIGNvbnRyb2xsZXIuIFRoYXQgbWVhbnMsIHdoZW4gd2UN
Cj4gc2V0IGEgbmV3IHF1ZXVlIGNvdW50LCB3ZSBtaWdodCBub3Qgb2JzZXJ2ZSB0aGUgcmVzZXR0
aW5nIHN0YXRlIGluIHRpbWUuDQo+IFRodXMsIGZpcnN0IGNoZWNrIGlmIHdlIHNlZSB0aGUgY29y
cmVjdCBxdWV1ZSBjb3VudCBhbmQgdGhlbiB0aGUNCj4gY29udHJvbGxlciBzdGF0ZS4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogRGFuaWVsIFdhZ25lciA8ZHdhZ25lckBzdXNlLmRlPg0KPiAtLS0NCj4N
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==
