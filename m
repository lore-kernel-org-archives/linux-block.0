Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68907383A9
	for <linux-block@vger.kernel.org>; Sat,  6 Jul 2024 09:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720259876; cv=fail; b=cSTIoaMXB+h9kw28MuJboaRwHQXE7IHaNWY21p4L6KN6zRUSZOhJCN9gdOagvRwlVbZ/YLL+BXso6fZXRAH5BNr3O6IR3nodwt/mEiZxQvyjheLQI89GtIEVXSDMtPKBitvg0ZZ9GUdgVSxXsWm4jUNb1dr1jzvQgtqS5lp2LUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720259876; c=relaxed/simple;
	bh=fZwRJr0+FQSYw/lefm4n8RwB6T/6skY4xpR0nthwiHo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DHUUnaZ2esrnlMUBm7i76TJFrfwsBieXOA3zNbIuRuSJsg21OyYUTAM81jJyZoqfbGQGw140szdskNjuqbDwTSsiDhyWNoxQylGYQ8fvR/EGe8QTWO/ht+RAga0ZjtnMeQRnlzBFiHbyz2q6+UoVbCX7R9MMtiwKcHPfCKoWxzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oT41Abr7; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oT41Abr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibbKVi5Wvq4lK9xEI719wgWkTuRQuO6+053W5fbvYQNd6Mimlyfzu2p4+ETgLMuzwFM5JptJABNdRpyptRVtzK3IpQbTKoT9gYJq26ABUJSWkuHaVulFjjOIWsqHTS663eSqhMi3V7eFb4dOXE2Eqmsg9ZIbXTNgBYWnkuxJS/3QaDfL7hZ08Wm2eqcfEzWhwGSOELjz36F72QLt3vaKbFjUetxgcfEip/ojDJWwWMgpfksNO7NE0Br1uyQBE3Nv41oFF1kN/a/8NIdDh4GFI3Zc+ldTOfYBS3IDrdcW3DbV+q0Z1tL9F48joV/tjS3i5/glUFMthdyyAjZR/Yt9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZwRJr0+FQSYw/lefm4n8RwB6T/6skY4xpR0nthwiHo=;
 b=lWqk2gSAAMxjTY6qt4YE98nO17X/jckGmMbUzPuARoB447MRQTc+sTQSaFadl693NkkP+/oVcoxb9NAexTeOR3XM/pQ+eMtdONeOkBjfUs6444QjKUEkjbmRF92bUUd/ynCcjAG84DnXgdYnCuotGfgVt7DhPMEGC0p8pPlgXUsHDKoFkFfZ6QXXGEyHjKVsS3ZXX/lc9+u3yrzfaBsWwYG0++Ct5rP3SM9oDQS60TYO3H52W6y3E51ziAZE2nNdbbpJuVmE4jil5h56V3f4QlnE6lC5Kh4m0FE1z+I5rmJztpPZIssvNoPDRGNXE8Inx4L9U4TgPRdmEfl6dnabWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZwRJr0+FQSYw/lefm4n8RwB6T/6skY4xpR0nthwiHo=;
 b=oT41Abr7w9ielp6+JxEu2P9NBf53KIxeiOF58ldWR0jKMmVeWCOyCw7NIK98FmdJzgkYrW/RLj77RhdFU5lwNR977RGNtb+MqK4amN5HDtG48utIFkuHWlDUBVQkPjmyKb2lK8QrHeebL/wlCgpXGc8GR+tGlCSqqVScwfpa8ENgZEmPUQ1glEJPWjzC7JZk7ezGo8wie0NwQljpc39MMxqH1rYTghKw2jPiNdWd66qYCbDlguNm4DBQLZFf3isUJJRCyZs7y/u/ooGfteRof/fwePoxdJaioqO/Vhy0VWqxXR7hQFuyxpzWaZoDJpA4y7k28D0ZuX/ISdLkP+M7Gg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Sat, 6 Jul
 2024 09:57:51 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7741.027; Sat, 6 Jul 2024
 09:57:49 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: add a bvec_phys helper
Thread-Topic: [PATCH 1/2] block: add a bvec_phys helper
Thread-Index: AQHaz3l9+G5oXcOu60itFtGPQhyuILHpdvgA
Date: Sat, 6 Jul 2024 09:57:49 +0000
Message-ID: <698840f8-e8f9-4f70-be8b-9af19947a793@nvidia.com>
References: <20240706075228.2350978-1-hch@lst.de>
 <20240706075228.2350978-2-hch@lst.de>
In-Reply-To: <20240706075228.2350978-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW4PR12MB7144:EE_
x-ms-office365-filtering-correlation-id: bb63509c-6807-4a07-b8d3-08dc9da21854
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?am1adEtmRDRQOVlCdVY1UUs4ZmFGd1M1MUE2QU05dGxlQnZWeFp5N1NpV0p3?=
 =?utf-8?B?RC9LTVllaUdHZDhkaGErRGN1ZVBvTm1JeTN6eDBFbnhnTktzT3dyYU1PZVlB?=
 =?utf-8?B?NHNMOTFiS0pLSXRJSlBLdkN4MkNObkoyKzVJM0N2d2hVUnhLZTFVM1g4SS9Z?=
 =?utf-8?B?NEMvYVd4bDBuTjdWdkY5NDFyaGExSXdkcEdQc2c4Zjc0a0VSVDdwb1BuTFdk?=
 =?utf-8?B?YUhKZktJYy9EVVk3bTBzTjQrMDhlUExjRjZSRHNNUXRXcFVtUjlRMlBhUjl0?=
 =?utf-8?B?K3BPUktKY1UvN3Exa3Vva0dSRTg3RTl3ZWxVNlFGRGpMaDRZc2szckw1eHF3?=
 =?utf-8?B?a052QWIvUjQ0SGZlYWN5R0VDQlBETnREM2pFUHR3OHl0YzJzMFJuQUtZRWdr?=
 =?utf-8?B?S0RJeUduZHI5R3lxUElPelJVbFhWMnpQNHRlLzM5TlY3TGpLS0dPTTE4b2cw?=
 =?utf-8?B?ajFHRFZoQ3ZqQyszZENUNjQ5ekpVZVBOZ2dncXhzUUc5RnBWK3dYbGx0LzNW?=
 =?utf-8?B?aXQzT3Y4dTlXZ2t0N3h2cFQzZDRINGlsa3VYV2VYYUI2NnRMSW40aGhBTE5G?=
 =?utf-8?B?K1ZkRFlzM0tmdFRUTWlrZFAwcyt4NE1Zam5iT05lT1c0akFqajh4bDRabkMv?=
 =?utf-8?B?U1dKanl6aFQ3Y1B4Q2JZYnp6TFlVd1NiekNNTG15c2U5UlIvRFIrcDhGZU5x?=
 =?utf-8?B?ZklyMnJYZTJoNFIwVGZ4bFdCb1NiK29PWnpMbkI0NXJrVzVyb0RLQ04rajlY?=
 =?utf-8?B?YVlvclB0cjFqRDJERUtRMUFweEpGK3VKUHh3aldPMW40RnhCakFqVmxCbGVD?=
 =?utf-8?B?OE1rLzlDaDVlVFRERXdlQTA2NDhCK1NpMFVxR2JPeEYyMWMyQW5KY2FYTFAr?=
 =?utf-8?B?R1pjV1NXMWtzUkxub24wRTdBcERqaSttNkl0MkIxQzk3WFNnSTRTeWlONzUr?=
 =?utf-8?B?MHJzL05jclJzbFZSUUhjbVYxNy9WSXI3eU01YitOWTZGdldvZzZiNS9CQWlm?=
 =?utf-8?B?ZVZaZ1dCdlVNU1dtd1BITHdYb24zR2h1eVZsS2Z4WXdJNGpyR0M2Slp4aFky?=
 =?utf-8?B?WURzcmpCa2FmYWVJWHlOUFZRQXdKU3JzZEVld1ZzakQ0ZGQwYldnTUdDUVpD?=
 =?utf-8?B?dENGYmxXYW81SytiNGhsOTRXdHNVSFR0U2pSNytlNU5hTUEzNlVyUFExbUMw?=
 =?utf-8?B?OE5Ra0F1b29VSXlMVHQ2WjQwY1d5czByL3V4UmhITzJXN2NFNXVkTEJRRlNl?=
 =?utf-8?B?L0N0QXNIZ0V0RXorNWU4OUwyZjJ5UitrWnozNzBWN0xYbWFxbzZnQzZ2SmI5?=
 =?utf-8?B?MVQ1VWlrTXRkNkRMa2hpbi91R1d4NFlXcjd5Q1lRVXd3U3NQeVRKeFdUZFdR?=
 =?utf-8?B?SmVwOVo4THBhZEZiNVpnbit2VFFvbFJNR1E4SE03eHNkOTdjVG1CbkIydThG?=
 =?utf-8?B?RS82U3MweVRrbmQ5ck1TcmxISENjTFRYU29hcVpteVhZd1ZYVEZyZjFPSjZs?=
 =?utf-8?B?VDA5UUhFZzhYdVFaOVBPNmtGL1pHQ0JwV3M1Q0JwQ3Jqd0w4dTIwRG9kbGNH?=
 =?utf-8?B?Y1lOcVkyb2RSdWI2NVAzOXJtQkN0emJnT014cWgyNEpBK0lmV01TL2RLVStZ?=
 =?utf-8?B?SC8yaTdjRDZvbmtpZ0xYdXY0UHdpMHFROHl4dmRmSGhvcVBmTmNETGRZemtw?=
 =?utf-8?B?THZaeWZqSlY2VzZINE9MR0Z4Sjl0cVNUVHMxM3dLa3ZMUDBTSFJ2bkkwTi9v?=
 =?utf-8?B?aVJZL2JpSGdZcVF4OVNlU3BOTmhBYmt3NFZXMzNNOWZzd3Zza2RMQjNxU1Rm?=
 =?utf-8?B?S0hwYzBMSXNRZ3dSTGJFZE1iVnNld1p4bGJPMXBFeVF3TGU2OTArcW1FWFpP?=
 =?utf-8?B?NXYvS0NURTJ6SlRVUFpJdWhaa000YTlZZVFyQ0Zac3Nnbmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVR3SmNFai9mWEhIaGhZNnZNT1VqWGZZSzBxdFcxeVFQRWppQS84L0J6aDVt?=
 =?utf-8?B?bTZnOWg0bXBBeTdLaXlubko2enMzZURHUUxML2xtV3kwNlhLeW4rTVBqcmh5?=
 =?utf-8?B?MjNFN1ZWWHB1LzhJZnQ0RDFXVmFJRWEvVkhLTE5vVjByMVQ1RGxIUU9ES1lM?=
 =?utf-8?B?RlZvdytOQ3dON0didTVvUXZLQThCSHJKdnJFU2FXT3kyam8zcmZOalYrbnli?=
 =?utf-8?B?ZW4yVWdxYk9DSjFkdWRnSFZ0TVl1VS9ReVVyUkg1LzVmM1NmNXNlOHBOQi80?=
 =?utf-8?B?NjZKdERiVGI4aS8zelNiVTRrcVBQWGhXRHZwTGJrQVJDTzVQVFZlc0pJQkJ4?=
 =?utf-8?B?NFJ0Qk1JSGZYWXBlV213L3BXR3IwSnZQdTFRSzFxc0pGaW5VMVM1SE5VMmJE?=
 =?utf-8?B?RksyNmdUczhvcW9TL1VlQTZ5Q3lRSmJGb3FNbjBNUkRWeXBmd1VKQzllNU9W?=
 =?utf-8?B?M0h4Qkg0c3hrU0R0WHYrejNCejJLTXBUMVZYV0V5MHRIMlpCOUtXdEhRU3J5?=
 =?utf-8?B?N3l5T0M4MlYzTHpoYmFHeDg4L1lCQWxJd2h0NGJCanBOcVp5RUtJNk9iYjF0?=
 =?utf-8?B?UEZYRkhQdytlV1dUcDc0d2FPNGxqOXltK2I3anRvdUNEdU16dTdJd1ZBR0tv?=
 =?utf-8?B?WW94T2JaYU1PQW96RVplbGU4ZjYyL1F0ZFBCNFlRT1kvekhjYkJDOE5YNHhj?=
 =?utf-8?B?N1djZGtXZDk5THJFem9xVGR0UnNUNjIvS2tnK05yTDdWWEh3VysyaXE4bWlT?=
 =?utf-8?B?dldTZHVFcTV2ajNZSHdXODhNTnhaWUpqSzZTTmxLQU44Z2d0bVZONnJZV1JK?=
 =?utf-8?B?Q3pmMmQxbnFZeGpnVWRBNGVSenAzWWRBVVlTZ1NiLzlUdTJBZGtWSWpFQTVp?=
 =?utf-8?B?dGpJVVdHdW9md28yNTVRYjZRQkpiRXlYeExxUTFRL2NpVTRpeTZjMmlrMm5j?=
 =?utf-8?B?OXYyVUk1VmV5U05tbU41N3hnWjJJdGFHZGdHZ3NscDZWZi9vTFpCMjhxeTNP?=
 =?utf-8?B?aThPU3E5dlB0dTVlcGN0ZFROQ1BmVWlWY1poQm1mdXd5TWFXcjQrZ1l0SjdW?=
 =?utf-8?B?R1BOcWdOdFFpRHQ3YmZyQ291OTVIaGdIVDh2TDJwVmhnTTM2bElVRURYM3F2?=
 =?utf-8?B?ZnBETy93VVh1OU1aR0VhclJOdGV0TzVyMHBlYzZoYWloSEllVXNpdWVieHhs?=
 =?utf-8?B?dC9najc0SWkxOTU4YjcxZTMybDM0QWxLSm93K1lkNk9DeVlMZzhKVk00NUpS?=
 =?utf-8?B?ZE84QlZpNG81dkUxSUxnMktiZGpUTnVDblFRUmJIbGZ4dXBqNkhUaitBbzFL?=
 =?utf-8?B?RkFBelVxLy9JZlZtRTEyUEhEdG1tTkJmemZCSjU0emVWZ0pvTzdlYzZlVDJu?=
 =?utf-8?B?ZmRibk1pMjBkSnlHc3E0RzdRVGUwNFNTR3A2bFlhdnBBclBRTERYbjhXYXlT?=
 =?utf-8?B?ZEdORHV5VksvZ1oyL3hXRlJKMmt6Z1dXcnhBalZjV2JCM3czVGx2U1l0UDJt?=
 =?utf-8?B?cENlWGp4Q3orVG9rZ044akF2T1ZaU2pKeWw1bDVjNFo3OVcxQ2k3MHlKc091?=
 =?utf-8?B?eWJUMlZRVXorNk9sYW5xSHpkN1dZYU92VGZIb3FFcFlJellNMFQ1dzIvWTg1?=
 =?utf-8?B?cGMyMG9QakFXOUNsZldDa2JGa3ZiOTcwK3hGVnFvY3JHQkRCNm4rSHR6ODZm?=
 =?utf-8?B?aWxERTVIVFVUUGdCSllSamJUYlFWUk56dXNPbkZ5OVBybDF2SnNjcytoZHgy?=
 =?utf-8?B?K3RCS3JaVWhoaTFzdEk1cmMyUU1LQlJHVEFaZHRkbjJ2UXVUTmp3UlVSdWJW?=
 =?utf-8?B?bUtBWHg4NGx0bkFyVXJ3akQrcGpOdHZ6V1ZBMDA4aXlJeDRpWmlydHg1d2JU?=
 =?utf-8?B?WWxRR2xCWWlPVW9GdVJzRTBvNHcwZTlGZEJVS054ZUUrS3hkUzJTTFlCUlNC?=
 =?utf-8?B?LzdhWGRhWGZBSEI2Slo4ZEtvYkhMRzZjMlFGL1NDUUtxMUtNRGkveUw3aUQ2?=
 =?utf-8?B?cGVoRG1CN2s3bTZEMGNhd0xZMDNVcktjbDRuRUlITjdTM1F3VytNMWlwbXY2?=
 =?utf-8?B?M1RXQVRTZFBqZ1pqZG1TcDU3VDZBOGhMeEl4OEh5TUhFVmt4WkpDMWdMNzVU?=
 =?utf-8?B?bFg2ZSs2dUVKWjF6WnVFR01reEZSUGVkZUlBNjM2dEk1SENXNkFJc0p1b3RH?=
 =?utf-8?Q?XXF8IC8aMuButipMB3WUydoJ4q+ND1Jh8lLDP4QXUUVm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC28AB9F511C604484122F6BFDC628E9@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bb63509c-6807-4a07-b8d3-08dc9da21854
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2024 09:57:49.8104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u2AmTkorqjMDYdoEs1uq+7aXtpp/5QknV0x5+GLFyEfwywjrxhgdi0Ud4O30CA5XtB/BcPEPXuQozVEjlI1sZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144

T24gNy82LzIwMjQgMTI6NTIgQU0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBHZXQgY2Fs
bGVycyBvdXQgb2YgcG9raW5nIGludG8gYnZlYyBpbnRlcm5hbHMgYSBiaXQgbW9yZS4gIE5vdCBh
IGh1Z2Ugd2luDQo+IHJpZ2h0IG5vdywgYnV0IHdpdGggdGhlIHByb3Bvc2VkIG5ldyBETUEgbWFw
cGluZyBBUEkgd2UgbWlnaHQgZW5kIHVwIHdpdGgNCj4gYSBsb3QgbW9yZSBvZiB0aGlzIG90aGVy
d2lzZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnPGhjaEBsc3QuZGU+
DQoNCnRoYW5rcyBmb3IgdGhlIGFkZGluZyBvcGVuIGNvZGUgY29tbWVudCwgbG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==
