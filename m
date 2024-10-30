Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92311DE8B9
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275782; cv=fail; b=fwla1R2wys2fGs1pulFeRTOMHPmewHipx5msVybNlSf8nhHCF0H3zbKNQKesABetiGMgLYnV+HfaLeqdyVpVLsDtz8RHfc9rmgD0ObFqcTrPLB8Hc1MNCr+bYhjuIXzKw59SUJ1GoiFa/TopW70SGEISWvAg3lBHYE+RjmRnC3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275782; c=relaxed/simple;
	bh=bICCMnDymADIdGJe5YhxmwhAsCRmdxkwf4AHO3UplN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mN3h4kFGPkkxhM4Y1mvmfBWwQ1IvkuoGpr2IAIc4ESgzAUYHrW/EeqRrDerYEbKnV7etMEu4/Cfa+WbqirwLbE3+UhlmsCcDoK60R628+jOlFKPTSMizoa1mFg61tzv1D0edoSAa5D7oM8VDAKlM4w+Atmt50hCkAMRTwLlTMNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BmdjnF2N; arc=fail smtp.client-ip=40.107.243.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BmdjnF2N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zx5Z9ggp+kyvgQYJIfb4mj51xidu0R1t5YH6lQBztfQZbFkQFotwAEMhwUQXndPTONOr/RywYnGxw+76CI0x42Hi2dXO+IdAu5gA0ikB79JUxY9Cq8Ui0CHW6nZ2UyeTsliE9G/wQjmEb9tvTNCWhewvsy85B/MV/Zb6Nb6iucczCt1BhdBBgo6NBpsFyETfFoBb56WVo33HfSsMe4izP/ek5PKFAo8lZq8nk19VXZvRf02cDEF3tg+3/zAnt5QgMFzP4vN1wXCkQjaeN6mkN5VVjokwfwstbNglbtCqNMDHgJm8qZ2gQ79O8CDiqRSvRbrVQQVQnEoXH3uJh/Yz4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bICCMnDymADIdGJe5YhxmwhAsCRmdxkwf4AHO3UplN8=;
 b=WqMia0EUtvHVG+QfF3OCWv0IH/65KFrv1PhlO1t87M6BAqpso/IZq6DMlQILVQ4Z2XmhQ1jn90CRsZzMB6OrdJgfddWw+ed1VZY3oB3r5JbTQBCc1kFm6dRGxueFJQq24XSr7xkXOp+xxtJx9m3BlcBIAB/LWoL8yISj+gcsitRy/lZ50OKJLFpYM08EzvMqlmG5/YbzWvN28gkqbCbA0Omf87kzmplg6PpYg2hhLjrOj97erluRPv91+Ff4sWI9GsjmIz2Py5jlrjYspstpPPqqjbQlXhS57smR9fU0YfOMPkwUkLLrVj8iap67k2Pf6UW9HH/sWXqz1wfEgIQQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bICCMnDymADIdGJe5YhxmwhAsCRmdxkwf4AHO3UplN8=;
 b=BmdjnF2NhVcvIHlLHP92/iE8n9lCbSzAAklAEZJOIkpuCLm1+j7eW+jBTUgUiar8ZZncOruBwEEmbXo2HlMfE7C2Ii4pM1cOXADWMhbhJhr6viJLAlRXNPtoyLup7JWSfw6V0c8YkLhkmB3iuWi6nLZTkGx3aKIOCjAl/2/X0o+gR8RjT49PzEvtL7nwroNqdKmhr6igq8tYg6bCHBgC0MwPg/oqGOuMLRZILUCer4YpuCOzzubN1eXaUtMam9VSWkJiPsv3TvxxYLV3PuBt4UoJozmASpOO+bL/YlafrIonrq5tEmm6HcK7oB3k8ZFSYGmVdvOoyV3fFqBPKqkQMQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB8328.namprd12.prod.outlook.com (2603:10b6:208:3dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Wed, 30 Oct
 2024 08:09:33 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 08:09:32 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Li Zhijian <lizhijian@fujitsu.com>, Shin'ichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/rc: Uniform the style of skip reasons
Thread-Topic: [PATCH blktests] common/rc: Uniform the style of skip reasons
Thread-Index: AQHbKcGSPOIP97pmAEOYRtBoi3pCE7Ke8pYA
Date: Wed, 30 Oct 2024 08:09:32 +0000
Message-ID: <c82e1527-bff6-4af6-ac64-b46aa17abf5e@nvidia.com>
References: <20241029051551.68260-1-lizhijian@fujitsu.com>
In-Reply-To: <20241029051551.68260-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB8328:EE_
x-ms-office365-filtering-correlation-id: 0b20fe46-cd2d-438b-8fa4-08dcf8ba2fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WlJGbmdGYWpLb2lkL2U5WTkwNFF3NVhrU25tNlFpWnBET2ZUM1hwVllmTFBG?=
 =?utf-8?B?NkZ0bGhIOXZsNzdrRkpBYzBkVk1qOWU1VDQxNnkzNklpRkZGZEFCNmlqcGtU?=
 =?utf-8?B?VzE0TmNka25zUEtwdDVidjZYRFM0dUJ2UEdSckxIeE0zeDlqOGZBZ1dkT3NE?=
 =?utf-8?B?cHhXeHZGcFNZbjJ2ZFg0dE0yOUc5S2ErWityem9rUTBCTjl5N0kzc2FLeml1?=
 =?utf-8?B?SEhJWHl5OFg1UFBpZUtyMWRRNC9KZ20zYTFicDd6dG5nRjV1MTcxd2lpNzhZ?=
 =?utf-8?B?WWdkcDRWejNMUFRGNExIbW0vM3BNak5uQ1Z6djEyeVZWakxwcW9mT3J5Y2dU?=
 =?utf-8?B?Y2xoY2JuVHo3VThucWlBdnFJOWxmcTNmSCtwMWFnMU81Um5Sa0FBeThKK2Nv?=
 =?utf-8?B?TEcyUVRhSjR3eWFHZ3RsbmJBM2IvRmx1V1F0eEtBS3c0ekE3NGxrOStUMlNN?=
 =?utf-8?B?OWRqK2FBb2tTTGNya3FXclc5dHlVajk0U3JmNXE1MW5Xd05HcHgwbkttanpY?=
 =?utf-8?B?ay9kdFRQQzZ6aWZYOEcraitoL3VMVkxZcmhxRjRhdXNma1hGbjZiQWtjYTUz?=
 =?utf-8?B?ZUJwUC9XZGV5a05JREFzQnR5TkhkZUQrY1lXcGJEdWVjalhKVkxoNnFESW41?=
 =?utf-8?B?Ryt4RXh5cnNYei9zTEtkeml4N3l6cEk0N01aNTdmSnZwUk1td0p2R2FjQ3hl?=
 =?utf-8?B?Y3dyNTlWR09LN0p0eWdBY1BycGg3aEtYTmxWTHRhcngwZ3VYYWk3VlArdysx?=
 =?utf-8?B?VklzODg5clBBY0JSclpHZ0xwUVlVZlVzYUx2MEFkSjQrdmVYZm9oNGtnVGFT?=
 =?utf-8?B?bzQvRzFaU1llK1ZDekFhSGR5RUZMV3JySVBqSlZPdE5PM3VHc0lLS29JWW1m?=
 =?utf-8?B?VitqVkhhS2JzclhWMnY0N1RQNmlnVlRWd1ZJaUxOUDlycTFYSFVqY25BcGtv?=
 =?utf-8?B?OGV1SW56bFB4Ly8xOWt6MTF5Rm1KTGFld0grUzVjTlRxcmZPV1ZnUzNzcUto?=
 =?utf-8?B?TDYzMnJNY3h2RHJSRlZmR2tGMHoyWEp2Y2tvcThmYjNWQW5YbkVUR2ZFNkVv?=
 =?utf-8?B?MDNFZFk2Ymw4QkRoRGNjVkg1YVdqdHhKNXh6STUrKzhjNkNKNm5nTC8vbXVp?=
 =?utf-8?B?Y1FFa3BFbFNqU3I5aGNDelVzWXRudWJrUVFBWFNEVXBjcGJZUGE0dGs3UWUv?=
 =?utf-8?B?SzhUeGRwV3VwQ1BPdHZkWGo3dm5Dc0ZIcEoyZUJvZDRFN1NCNTcxU0NKWjYz?=
 =?utf-8?B?QyszVmtMVGdiRHlzQ1F4dG40UTh5bS9nTkJmVldUUzdHOHYrbDdGbUFORmZK?=
 =?utf-8?B?NTY5UXpuUzN1dzEwYUhhYU5TOTRsQ3lZVDFuMXFZRGIxWXVJQ2M4NXl6SEwz?=
 =?utf-8?B?V3V1YjZXQ1VVcFRraTZkdWZRbW1WLzZ6clhIOFd1c2l5NVFyOXZsd2M2UndG?=
 =?utf-8?B?R0RIbEg1N2M5NS9OUVRadlZLVGhMSDJsNTFjcDdwd3V0Vnh0anhlRWNReWgr?=
 =?utf-8?B?QjZIcEVwbExyVHFoZXBEQlNXSFNWdXlabURTRUFvRkdzK3VuZHhDWkZ0L2Jl?=
 =?utf-8?B?NlRZRUhIT3VtMGVVQlBwK3BEclQ4UXkxcHZmK0l2MjR4Qi90SHNkWWc4MXh5?=
 =?utf-8?B?UklNUmFkY2VZdzMyZmpSWXQxaXNwOTZ6N0VXK0FrTVN1NjU0aFMvTUNKUGxH?=
 =?utf-8?B?dFczN0tNSENnV2pDd2lWTTdRUU5sMytKdjk1Um51WlVTb091Uy9pQmxZWlFn?=
 =?utf-8?B?SDQ3S0ROWXhvWmY1YVdLaU5uVFIzRUc4TjZKVUtHeWRaWEQvMXFRVE1ib0Rr?=
 =?utf-8?Q?/E+0xL6ECta+1hDcneNgz1YPnrMVYtA3mdgmw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d3ZYdTZRNFg2czZnWkZ5UEFLTTg5c1FVMVJyWjlTdi8xRVBWWmtQYW51SU4z?=
 =?utf-8?B?ZkMrTWZWdS92T2cwOGVGU0RscGhyTnhDSndneHg2NFpiK2dRclJBekVBTHh4?=
 =?utf-8?B?MnhpalpBMXplNThsaXQ0d1NPS2RjdGxDMnhpV3h4Q3FNVGFPTDE4REtVTjdW?=
 =?utf-8?B?UzJhZ1FNVytMRGFRcTM5eCt6cTluak9BWXNnTVE3TDZ2aTg4TjY4Z2M3Yk5p?=
 =?utf-8?B?WjAwRUQ0eUQvcW02VkdUNlQyR3pMZVZQdWtDZk9PM2J0bEd1bWdvRVI1VUwr?=
 =?utf-8?B?VmE1NmR2ZXRWSWQ4bGRMQzhvMGRjS0hjMHVSQWptVVcxR0NLcG5HSkE0RGVM?=
 =?utf-8?B?Q3FhM3h1YnppOE5kZlBETE9PNXB4NTBwWjNibmtQVXRVNmI2Z0RFdE9hakdh?=
 =?utf-8?B?N2UyN2ZhZmhwNVZTWmFaL1FQTGdBbHQ4SDhnd0I2UEtNOTlFKzRGWlJLMVha?=
 =?utf-8?B?TldyM3JhQzFRaXFXMC9Xa3ZnVFZHdm8xRk8vSnU0a2EySzNjMXJJSktudTNn?=
 =?utf-8?B?S0dHMzJQWjdjRWxaVlNwOWh0MGZxU1V2RldOWW5EWTA2SEFYdXdtVHNCV3NG?=
 =?utf-8?B?SHpScVlScnFnYUJLa24rYVVabUdSNEdiWU9FRXpWcXVsRjE3SkZoZTBkMFp0?=
 =?utf-8?B?cGI5ZFRUMFI3azBpSlVob0JDSnJaZEFwTmZLSzl0dDR2cTlWS2RkYmFKSitP?=
 =?utf-8?B?V2kyRmRxYlgwQ25RYVpFS0N0WFlmemp0c0xSRSs5bEZ3VUtPd1FQa2VvdGRF?=
 =?utf-8?B?ZU1RaTI1OVBEVnBxcHhQQk5Na2JseG1BV04vNHY1MGFYUVU4V09lYm04c0Jl?=
 =?utf-8?B?bHd6S1RGZ09XR3VXZ1hZakRkemU4WEFYenhPL2RlbUp0ZXAvOVNxYW1QQ1pv?=
 =?utf-8?B?RWd3aTJxbkdlRWJKSE5yT0w2enBlNXp5WGhkdjA3TVhpU0IvVnNxZjlUNzkx?=
 =?utf-8?B?aG10dHdCRU5CT3hUOGo5YmVtNmE0WmJMZ3U4MnVaOC93TjVvZXdmWjdHZUt4?=
 =?utf-8?B?SDZKdHpFQmZYMGR3U3ByMmNvQUE2SThaYzcvV2pZbkdGL2xrMnp0V2dxOFZH?=
 =?utf-8?B?MzBWZGxLU09jRUx1YU5zSVB6VkR4UkIwU1F0ZDFDVDVxeUhISVZWN3EvSmF0?=
 =?utf-8?B?d2ZmWEltMThjVnczN29ydTJRRlR0eTI3WTcxWmZ4bGpGZHp2S1hmV3lPSER5?=
 =?utf-8?B?eFZPMVRURWwrZUZJOXN0bXlsSnlSVVZUNFA2VC8yZkM0YVFGOG9wK0l1RFlF?=
 =?utf-8?B?d3dCZGtNd3BGVHByYUZrbU54QW9UMldGZmZVSldnTktuOStldGtGcUllNWJi?=
 =?utf-8?B?NFJqdG5helFER2hydkN2bVZNaUEzTGdtOEF6RWFmTWVJV3VNNTdjdVhSN0dq?=
 =?utf-8?B?bVkrTG1kL1IzVHlFT0FRREdlbVR4WE4yVWxucmhzQmZ1ZURuODZiUzdFVkdr?=
 =?utf-8?B?Ylk3eFFNV2QrNmFJUWg5aXRyVEtmYWVaZjJTcHpOY3pTTStTNWtNc2ZpRUFX?=
 =?utf-8?B?WjNuMVVyWkc1dnRJWmVHYVFGVUxkbDBwVWUxVW04NUovc3BselY2RkdrcFhV?=
 =?utf-8?B?dzN0d1ZhbWpwUWJzWmg0ejY0NzQxeXlGdUlES3k1eWdoYzVhRy9nNm5iNVJ6?=
 =?utf-8?B?azc5QkRhVXljclJwRnhESFBPRlhwNkZtbnk4bUFnWDMxZDlGRGpyYVFBdU9W?=
 =?utf-8?B?NW5ES21LSHZjSFpydjRBMTlKU2k2WEprNzJDaVR2cWl6ZEFoL1pUMm9zVVFR?=
 =?utf-8?B?czk2R0MyU0xhUUFPdWN0WllBcW5uU3JETi94SmltSXJ2d2E5QWxheHlpdm9L?=
 =?utf-8?B?aVdrb1dEYnhJRGxLcGozMnlIK0hwdjQ4VjN1dWMrSTdxcldnL096YmVnUGJE?=
 =?utf-8?B?SmJ0bkorVHdocGo1cldQT0paR0hMVlVxdWt1VHM2MXpuMHZ4MkIyTFl5REtj?=
 =?utf-8?B?Y1gzZGNmNnBFbXNLam5hTHVoN1BBME5BNjByWHd4SG05TEYyY2w2eWkveXhR?=
 =?utf-8?B?VzJ6dFNUK1FMZjJ1YVhtc01QSFVLSjJTL0tqQm5WRnFSRUpWazdZV2ZjNFND?=
 =?utf-8?B?bHE3cDI3bDF0cXErK0FxWnBJeW8xR1M0SU5QVGJ0SGJFWUlsclFjQTd4RTZh?=
 =?utf-8?Q?++bFZoPi8ph0Bl2nhfFv72hKQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <76E2F33938C26D418E713F438390761D@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20fe46-cd2d-438b-8fa4-08dcf8ba2fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 08:09:32.9391
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yD9A+3tQSEl6v06Tlm1fF7Tpj140VX22/CHWHM3O2rZiUyYJIbANm99gz5/hf9tvEOhfLPYkhcmucbQJ2eGeOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8328

T24gMTAvMjgvMjQgMjI6MTUsIExpIFpoaWppYW4gd3JvdGU6DQo+IEJlZm9yZToNCj4gc3JwLyoq
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtu
b3QgcnVuXQ0KPiAgICAgIGRyaXZlciBzY3NpX2RoX2FsdWEgaXMgbm90IGF2YWlsYWJsZQ0KPiAg
ICAgIGRyaXZlciBzY3NpX2RoX2VtYyBpcyBub3QgYXZhaWxhYmxlDQo+ICAgICAgZHJpdmVyIHNj
c2lfZGhfcmRhYyBpcyBub3QgYXZhaWxhYmxlDQo+ICAgICAgZG1fbXVsdGlwYXRoIG1vZHVsZSBp
cyBub3QgYXZhaWxhYmxlDQo+ICAgICAgZG1fcXVldWVfbGVuZ3RoIG1vZHVsZSBpcyBub3QgYXZh
aWxhYmxlDQo+ICAgICAgZG1fc2VydmljZV90aW1lIG1vZHVsZSBpcyBub3QgYXZhaWxhYmxlDQo+
ICAgICAgaWJfc3JwdCBtb2R1bGUgaXMgbm90IGF2YWlsYWJsZQ0KPiAgICAgIGliX3VtYWQgbW9k
dWxlIGlzIG5vdCBhdmFpbGFibGUNCj4gICAgICBudWxsX2JsayBtb2R1bGUgaXMgbm90IGF2YWls
YWJsZQ0KPiAgICAgIHNjc2lfZGVidWcgbW9kdWxlIGlzIG5vdCBhdmFpbGFibGUNCj4gICAgICB0
YXJnZXRfY29yZV9pYmxvY2sgbW9kdWxlIGlzIG5vdCBhdmFpbGFibGUNCj4gICAgICBzZ19yZXNl
dCBpcyBub3QgYXZhaWxhYmxlDQo+DQo+IEFmdGVyOg0KPiBzcnAvKioqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW25vdCBydW5dDQo+ICAgICAg
ZHJpdmVyIHNjc2lfZGhfYWx1YSBpcyBub3QgYXZhaWxhYmxlDQo+ICAgICAgZHJpdmVyIHNjc2lf
ZGhfZW1jIGlzIG5vdCBhdmFpbGFibGUNCj4gICAgICBkcml2ZXIgc2NzaV9kaF9yZGFjIGlzIG5v
dCBhdmFpbGFibGUNCj4gICAgICBtb2R1bGUgZG1fbXVsdGlwYXRoIGlzIG5vdCBhdmFpbGFibGUN
Cj4gICAgICBtb2R1bGUgZG1fcXVldWVfbGVuZ3RoIGlzIG5vdCBhdmFpbGFibGUNCj4gICAgICBt
b2R1bGUgZG1fc2VydmljZV90aW1lIGlzIG5vdCBhdmFpbGFibGUNCj4gICAgICBtb2R1bGUgaWJf
c3JwdCBpcyBub3QgYXZhaWxhYmxlDQo+ICAgICAgbW9kdWxlIGliX3VtYWQgaXMgbm90IGF2YWls
YWJsZQ0KPiAgICAgIG1vZHVsZSBudWxsX2JsayBpcyBub3QgYXZhaWxhYmxlDQo+ICAgICAgbW9k
dWxlIHNjc2lfZGVidWcgaXMgbm90IGF2YWlsYWJsZQ0KPiAgICAgIG1vZHVsZSB0YXJnZXRfY29y
ZV9pYmxvY2sgaXMgbm90IGF2YWlsYWJsZQ0KPiAgICAgIGNvbW1hbmQgc2dfcmVzZXQgaXMgbm90
IGF2YWlsYWJsZQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBMaSBaaGlqaWFuPGxpemhpamlhbkBmdWpp
dHN1LmNvbT4NCg0KDQpNdWNoIGVhc2llciB0byByZWFkIHRoaXMgd2F5LCBsb29rcyBnb29kLg0K
DQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNr
DQoNCg0K
